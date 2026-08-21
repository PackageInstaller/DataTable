using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Layouts;

internal struct InputDeviceBuilder : IDisposable
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	internal struct RefInstance : IDisposable
	{
		public void Dispose()
		{
			s_InstanceRef--;
			if (s_InstanceRef <= 0)
			{
				s_Instance.Dispose();
				s_Instance = default(InputDeviceBuilder);
				s_InstanceRef = 0;
			}
			else
			{
				s_Instance.Reset();
			}
		}
	}

	private InputDevice m_Device;

	private InputControlLayout.CacheRefInstance m_LayoutCacheRef;

	private Dictionary<string, InputControlLayout.ControlItem> m_ChildControlOverrides;

	private List<uint> m_StateOffsetToControlMap;

	private StringBuilder m_StringBuilder;

	private const uint kSizeForControlUsingStateFromOtherControl = uint.MaxValue;

	private static InputDeviceBuilder s_Instance;

	private static int s_InstanceRef;

	internal static ref InputDeviceBuilder instance => ref s_Instance;

	public void Setup(InternedString layout, InternedString variants, InputDeviceDescription deviceDescription = default(InputDeviceDescription))
	{
		m_LayoutCacheRef = InputControlLayout.CacheRef();
		InstantiateLayout(layout, variants, default(InternedString), null);
		FinalizeControlHierarchy();
		m_StateOffsetToControlMap.Sort();
		m_Device.m_Description = deviceDescription;
		m_Device.m_StateOffsetToControlMap = m_StateOffsetToControlMap.ToArray();
		m_Device.CallFinishSetupRecursive();
	}

	public InputDevice Finish()
	{
		InputDevice device = m_Device;
		Reset();
		return device;
	}

	public void Dispose()
	{
		m_LayoutCacheRef.Dispose();
	}

	private void Reset()
	{
		m_Device = null;
		m_ChildControlOverrides?.Clear();
		m_StateOffsetToControlMap?.Clear();
	}

	private InputControl InstantiateLayout(InternedString layout, InternedString variants, InternedString name, InputControl parent)
	{
		InputControlLayout layout2 = FindOrLoadLayout(layout);
		return InstantiateLayout(layout2, variants, name, parent);
	}

	private InputControl InstantiateLayout(InputControlLayout layout, InternedString variants, InternedString name, InputControl parent)
	{
		if (!(Activator.CreateInstance(layout.type) is InputControl inputControl))
		{
			throw new InvalidOperationException($"Type '{layout.type.Name}' referenced by layout '{layout.name}' is not an InputControl");
		}
		if (inputControl is InputDevice device)
		{
			if (parent != null)
			{
				throw new InvalidOperationException($"Cannot instantiate device layout '{layout.name}' as child of '{parent.path}'; devices must be added at root");
			}
			m_Device = device;
			m_Device.m_StateBlock.byteOffset = 0u;
			m_Device.m_StateBlock.bitOffset = 0u;
			m_Device.m_StateBlock.format = layout.stateFormat;
			m_Device.m_AliasesForEachControl = null;
			m_Device.m_ChildrenForEachControl = null;
			m_Device.m_UsagesForEachControl = null;
			m_Device.m_UsageToControl = null;
			if (layout.m_UpdateBeforeRender == true)
			{
				m_Device.m_DeviceFlags |= InputDevice.DeviceFlags.UpdateBeforeRender;
			}
			if (layout.canRunInBackground.HasValue)
			{
				m_Device.m_DeviceFlags |= InputDevice.DeviceFlags.CanRunInBackgroundHasBeenQueried;
				if (layout.canRunInBackground == true)
				{
					m_Device.m_DeviceFlags |= InputDevice.DeviceFlags.CanRunInBackground;
				}
			}
		}
		else if (parent == null)
		{
			throw new InvalidOperationException($"Toplevel layout used with InputDeviceBuilder must be a device layout; '{layout.name}' is a control layout");
		}
		if (name.IsEmpty())
		{
			name = layout.name;
			int num = name.ToString().LastIndexOf(':');
			if (num != -1)
			{
				name = new InternedString(name.ToString().Substring(num + 1));
			}
		}
		if (name.ToString().IndexOf('/') != -1)
		{
			name = new InternedString(name.ToString().CleanSlashes());
		}
		if (variants.IsEmpty())
		{
			variants = layout.variants;
			if (variants.IsEmpty())
			{
				variants = InputControlLayout.DefaultVariant;
			}
		}
		inputControl.m_Name = name;
		inputControl.m_DisplayNameFromLayout = layout.m_DisplayName;
		inputControl.m_Layout = layout.name;
		inputControl.m_Variants = variants;
		inputControl.m_Parent = parent;
		inputControl.m_Device = m_Device;
		if (inputControl is InputDevice)
		{
			inputControl.noisy = layout.isNoisy;
		}
		bool haveChildrenUsingStateFromOtherControls = false;
		try
		{
			AddChildControls(layout, variants, inputControl, ref haveChildrenUsingStateFromOtherControls);
		}
		catch
		{
			throw;
		}
		ComputeStateLayout(inputControl);
		if (haveChildrenUsingStateFromOtherControls)
		{
			InputControlLayout.ControlItem[] controls = layout.m_Controls;
			for (int i = 0; i < controls.Length; i++)
			{
				ref InputControlLayout.ControlItem reference = ref controls[i];
				if (!string.IsNullOrEmpty(reference.useStateFrom))
				{
					ApplyUseStateFrom(inputControl, ref reference, layout);
				}
			}
		}
		return inputControl;
	}

	private void AddChildControls(InputControlLayout layout, InternedString variants, InputControl parent, ref bool haveChildrenUsingStateFromOtherControls)
	{
		InputControlLayout.ControlItem[] controls = layout.m_Controls;
		if (controls == null)
		{
			return;
		}
		int num = 0;
		bool flag = false;
		for (int i = 0; i < controls.Length; i++)
		{
			if (!controls[i].variants.IsEmpty() && !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(controls[i].variants, variants, ";"[0]))
			{
				continue;
			}
			if (controls[i].isModifyingExistingControl)
			{
				if (controls[i].isArray)
				{
					throw new NotSupportedException($"Control '{controls[i].name}' in layout '{layout.name}' is modifying the child of another control but is marked as an array");
				}
				flag = true;
				InsertChildControlOverride(parent, ref controls[i]);
			}
			else
			{
				num = ((!controls[i].isArray) ? (num + 1) : (num + controls[i].arraySize));
			}
		}
		if (num == 0)
		{
			parent.m_ChildCount = 0;
			parent.m_ChildStartIndex = 0;
			haveChildrenUsingStateFromOtherControls = false;
			return;
		}
		int num2 = ArrayHelpers.GrowBy(ref m_Device.m_ChildrenForEachControl, num);
		int num3 = num2;
		for (int j = 0; j < controls.Length; j++)
		{
			InputControlLayout.ControlItem controlItem = controls[j];
			if (controlItem.isModifyingExistingControl || (!controlItem.variants.IsEmpty() && !StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(controlItem.variants, variants, ";"[0])))
			{
				continue;
			}
			if (controlItem.isArray)
			{
				for (int k = 0; k < controlItem.arraySize; k++)
				{
					string nameOverride = string.Concat(controlItem.name, k.ToString());
					InputControl inputControl = AddChildControl(layout, variants, parent, ref haveChildrenUsingStateFromOtherControls, controlItem, num3, nameOverride);
					num3++;
					if (inputControl.m_StateBlock.byteOffset != uint.MaxValue)
					{
						inputControl.m_StateBlock.byteOffset += (uint)(k * (int)inputControl.m_StateBlock.alignedSizeInBytes);
					}
				}
			}
			else
			{
				AddChildControl(layout, variants, parent, ref haveChildrenUsingStateFromOtherControls, controlItem, num3);
				num3++;
			}
		}
		parent.m_ChildCount = num;
		parent.m_ChildStartIndex = num2;
		if (!flag)
		{
			return;
		}
		for (int l = 0; l < controls.Length; l++)
		{
			InputControlLayout.ControlItem controlItem2 = controls[l];
			if (controlItem2.isModifyingExistingControl && (controlItem2.variants.IsEmpty() || StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(controls[l].variants, variants, ";"[0])))
			{
				AddChildControlIfMissing(layout, variants, parent, ref haveChildrenUsingStateFromOtherControls, ref controlItem2);
			}
		}
	}

	private InputControl AddChildControl(InputControlLayout layout, InternedString variants, InputControl parent, ref bool haveChildrenUsingStateFromOtherControls, InputControlLayout.ControlItem controlItem, int childIndex, string nameOverride = null)
	{
		InternedString internedString = ((nameOverride != null) ? new InternedString(nameOverride) : controlItem.name);
		if (string.IsNullOrEmpty(controlItem.layout))
		{
			throw new InvalidOperationException($"Layout has not been set on control '{controlItem.name}' in '{layout.name}'");
		}
		if (m_ChildControlOverrides != null)
		{
			string key = ChildControlOverridePath(parent, internedString);
			if (m_ChildControlOverrides.TryGetValue(key, out var value))
			{
				controlItem = value.Merge(controlItem);
			}
		}
		InternedString layout2 = controlItem.layout;
		InputControl inputControl;
		try
		{
			inputControl = InstantiateLayout(layout2, variants, internedString, parent);
		}
		catch (InputControlLayout.LayoutNotFoundException ex)
		{
			throw new InputControlLayout.LayoutNotFoundException($"Cannot find layout '{ex.layout}' used in control '{internedString}' of layout '{layout.name}'", ex);
		}
		m_Device.m_ChildrenForEachControl[childIndex] = inputControl;
		inputControl.noisy = controlItem.isNoisy;
		inputControl.synthetic = controlItem.isSynthetic;
		inputControl.usesStateFromOtherControl = !string.IsNullOrEmpty(controlItem.useStateFrom);
		inputControl.dontReset = (inputControl.noisy || controlItem.dontReset) && !inputControl.usesStateFromOtherControl;
		if (inputControl.noisy)
		{
			m_Device.noisy = true;
		}
		inputControl.isButton = inputControl is ButtonControl;
		if (inputControl.dontReset)
		{
			m_Device.hasDontResetControls = true;
		}
		inputControl.m_DisplayNameFromLayout = controlItem.displayName;
		inputControl.m_ShortDisplayNameFromLayout = controlItem.shortDisplayName;
		inputControl.m_DefaultState = controlItem.defaultState;
		if (!inputControl.m_DefaultState.isEmpty)
		{
			m_Device.hasControlsWithDefaultState = true;
		}
		if (!controlItem.minValue.isEmpty)
		{
			inputControl.m_MinValue = controlItem.minValue;
		}
		if (!controlItem.maxValue.isEmpty)
		{
			inputControl.m_MaxValue = controlItem.maxValue;
		}
		if (!inputControl.usesStateFromOtherControl)
		{
			inputControl.m_StateBlock.byteOffset = controlItem.offset;
			inputControl.m_StateBlock.bitOffset = controlItem.bit;
			if (controlItem.sizeInBits != 0)
			{
				inputControl.m_StateBlock.sizeInBits = controlItem.sizeInBits;
			}
			if (controlItem.format != 0)
			{
				SetFormat(inputControl, controlItem);
			}
		}
		else
		{
			inputControl.m_StateBlock.sizeInBits = uint.MaxValue;
			haveChildrenUsingStateFromOtherControls = true;
		}
		ReadOnlyArray<InternedString> usages = controlItem.usages;
		if (usages.Count > 0)
		{
			int count = usages.Count;
			int num = (inputControl.m_UsageStartIndex = ArrayHelpers.AppendToImmutable(ref m_Device.m_UsagesForEachControl, usages.m_Array));
			inputControl.m_UsageCount = count;
			ArrayHelpers.GrowBy(ref m_Device.m_UsageToControl, count);
			for (int i = 0; i < count; i++)
			{
				m_Device.m_UsageToControl[num + i] = inputControl;
			}
		}
		if (controlItem.aliases.Count > 0)
		{
			int count2 = controlItem.aliases.Count;
			int aliasStartIndex = ArrayHelpers.AppendToImmutable(ref m_Device.m_AliasesForEachControl, controlItem.aliases.m_Array);
			inputControl.m_AliasStartIndex = aliasStartIndex;
			inputControl.m_AliasCount = count2;
		}
		if (controlItem.parameters.Count > 0)
		{
			NamedValue.ApplyAllToObject(inputControl, controlItem.parameters);
		}
		if (controlItem.processors.Count > 0)
		{
			AddProcessors(inputControl, ref controlItem, layout.name);
		}
		return inputControl;
	}

	private void InsertChildControlOverride(InputControl parent, ref InputControlLayout.ControlItem controlItem)
	{
		if (m_ChildControlOverrides == null)
		{
			m_ChildControlOverrides = new Dictionary<string, InputControlLayout.ControlItem>();
		}
		string key = ChildControlOverridePath(parent, controlItem.name);
		if (!m_ChildControlOverrides.TryGetValue(key, out var value))
		{
			m_ChildControlOverrides[key] = controlItem;
			return;
		}
		value = value.Merge(controlItem);
		m_ChildControlOverrides[key] = value;
	}

	private string ChildControlOverridePath(InputControl parent, InternedString controlName)
	{
		string text = controlName.ToLower();
		for (InputControl inputControl = parent; inputControl != m_Device; inputControl = inputControl.m_Parent)
		{
			text = inputControl.m_Name.ToLower() + "/" + text;
		}
		return text;
	}

	private void AddChildControlIfMissing(InputControlLayout layout, InternedString variants, InputControl parent, ref bool haveChildrenUsingStateFromOtherControls, ref InputControlLayout.ControlItem controlItem)
	{
		InputControl inputControl = InputControlPath.TryFindChild(parent, controlItem.name);
		if (inputControl == null)
		{
			inputControl = InsertChildControl(layout, variants, parent, ref haveChildrenUsingStateFromOtherControls, ref controlItem);
			if (inputControl.parent != parent)
			{
				ComputeStateLayout(inputControl.parent);
			}
		}
	}

	private InputControl InsertChildControl(InputControlLayout layout, InternedString variant, InputControl parent, ref bool haveChildrenUsingStateFromOtherControls, ref InputControlLayout.ControlItem controlItem)
	{
		string text = controlItem.name.ToString();
		int num = text.LastIndexOf('/');
		if (num == -1)
		{
			throw new InvalidOperationException("InsertChildControl has to be called with a slash-separated path");
		}
		string text2 = text.Substring(0, num);
		InputControl inputControl = InputControlPath.TryFindChild(parent, text2);
		if (inputControl == null)
		{
			throw new InvalidOperationException($"Cannot find parent '{text2}' of control '{controlItem.name}' in layout '{layout.name}'");
		}
		string text3 = text.Substring(num + 1);
		if (text3.Length == 0)
		{
			throw new InvalidOperationException($"Path cannot end in '/' (control '{controlItem.name}' in layout '{layout.name}')");
		}
		int num2 = inputControl.m_ChildStartIndex;
		if (num2 == 0)
		{
			num2 = (inputControl.m_ChildStartIndex = m_Device.m_ChildrenForEachControl.LengthSafe());
		}
		int num3 = num2 + inputControl.m_ChildCount;
		ShiftChildIndicesInHierarchyOneUp(m_Device, num3, inputControl);
		ArrayHelpers.InsertAt(ref m_Device.m_ChildrenForEachControl, num3, null);
		inputControl.m_ChildCount++;
		return AddChildControl(layout, variant, inputControl, ref haveChildrenUsingStateFromOtherControls, controlItem, num3, text3);
	}

	private static void ApplyUseStateFrom(InputControl parent, ref InputControlLayout.ControlItem controlItem, InputControlLayout layout)
	{
		InputControl inputControl = InputControlPath.TryFindChild(parent, controlItem.name);
		InputControl inputControl2 = InputControlPath.TryFindChild(parent, controlItem.useStateFrom);
		if (inputControl2 == null)
		{
			throw new InvalidOperationException($"Cannot find control '{controlItem.useStateFrom}' referenced in 'useStateFrom' of control '{controlItem.name}' in layout '{layout.name}'");
		}
		inputControl.m_StateBlock = inputControl2.m_StateBlock;
		inputControl.usesStateFromOtherControl = true;
		inputControl.dontReset = inputControl2.dontReset;
		if (inputControl.parent != inputControl2.parent)
		{
			for (InputControl parent2 = inputControl2.parent; parent2 != parent; parent2 = parent2.parent)
			{
				inputControl.m_StateBlock.byteOffset += parent2.m_StateBlock.byteOffset;
			}
		}
	}

	private static void ShiftChildIndicesInHierarchyOneUp(InputDevice device, int startIndex, InputControl exceptControl)
	{
		InputControl[] childrenForEachControl = device.m_ChildrenForEachControl;
		int num = childrenForEachControl.Length;
		for (int i = 0; i < num; i++)
		{
			InputControl inputControl = childrenForEachControl[i];
			if (inputControl != null && inputControl != exceptControl && inputControl.m_ChildStartIndex >= startIndex)
			{
				inputControl.m_ChildStartIndex++;
			}
		}
	}

	private void SetDisplayName(InputControl control, string longDisplayNameFromLayout, string shortDisplayNameFromLayout, bool shortName)
	{
		string text = (shortName ? shortDisplayNameFromLayout : longDisplayNameFromLayout);
		if (string.IsNullOrEmpty(text))
		{
			if (shortName)
			{
				if (control.parent != null && control.parent != control.device)
				{
					if (m_StringBuilder == null)
					{
						m_StringBuilder = new StringBuilder();
					}
					m_StringBuilder.Length = 0;
					AddParentDisplayNameRecursive(control.parent, m_StringBuilder, shortName: true);
					if (m_StringBuilder.Length == 0)
					{
						control.m_ShortDisplayNameFromLayout = null;
						return;
					}
					if (!string.IsNullOrEmpty(longDisplayNameFromLayout))
					{
						m_StringBuilder.Append(longDisplayNameFromLayout);
					}
					else
					{
						m_StringBuilder.Append(control.name);
					}
					control.m_ShortDisplayNameFromLayout = m_StringBuilder.ToString();
				}
				else
				{
					control.m_ShortDisplayNameFromLayout = null;
				}
				return;
			}
			text = control.name;
		}
		if (control.parent != null && control.parent != control.device)
		{
			if (m_StringBuilder == null)
			{
				m_StringBuilder = new StringBuilder();
			}
			m_StringBuilder.Length = 0;
			AddParentDisplayNameRecursive(control.parent, m_StringBuilder, shortName);
			m_StringBuilder.Append(text);
			text = m_StringBuilder.ToString();
		}
		if (shortName)
		{
			control.m_ShortDisplayNameFromLayout = text;
		}
		else
		{
			control.m_DisplayNameFromLayout = text;
		}
	}

	private static void AddParentDisplayNameRecursive(InputControl control, StringBuilder stringBuilder, bool shortName)
	{
		if (control.parent != null && control.parent != control.device)
		{
			AddParentDisplayNameRecursive(control.parent, stringBuilder, shortName);
		}
		if (shortName)
		{
			string value = control.shortDisplayName;
			if (string.IsNullOrEmpty(value))
			{
				value = control.displayName;
			}
			stringBuilder.Append(value);
		}
		else
		{
			stringBuilder.Append(control.displayName);
		}
		stringBuilder.Append(' ');
	}

	private static void AddProcessors(InputControl control, ref InputControlLayout.ControlItem controlItem, string layoutName)
	{
		int count = controlItem.processors.Count;
		for (int i = 0; i < count; i++)
		{
			string name = controlItem.processors[i].name;
			Type type = InputProcessor.s_Processors.LookupTypeRegistration(name);
			if (type == null)
			{
				throw new InvalidOperationException($"Cannot find processor '{name}' referenced by control '{controlItem.name}' in layout '{layoutName}'");
			}
			object first = Activator.CreateInstance(type);
			ReadOnlyArray<NamedValue> parameters = controlItem.processors[i].parameters;
			if (parameters.Count > 0)
			{
				NamedValue.ApplyAllToObject(first, parameters);
			}
			control.AddProcessor(first);
		}
	}

	private static void SetFormat(InputControl control, InputControlLayout.ControlItem controlItem)
	{
		control.m_StateBlock.format = controlItem.format;
		if (controlItem.sizeInBits == 0)
		{
			int sizeOfPrimitiveFormatInBits = InputStateBlock.GetSizeOfPrimitiveFormatInBits(controlItem.format);
			if (sizeOfPrimitiveFormatInBits != -1)
			{
				control.m_StateBlock.sizeInBits = (uint)sizeOfPrimitiveFormatInBits;
			}
		}
	}

	private static InputControlLayout FindOrLoadLayout(string name)
	{
		return InputControlLayout.cache.FindOrLoadLayout(name);
	}

	private static void ComputeStateLayout(InputControl control)
	{
		ReadOnlyArray<InputControl> children = control.children;
		if (control.m_StateBlock.sizeInBits == 0 && control.m_StateBlock.format != 0)
		{
			int sizeOfPrimitiveFormatInBits = InputStateBlock.GetSizeOfPrimitiveFormatInBits(control.m_StateBlock.format);
			if (sizeOfPrimitiveFormatInBits != -1)
			{
				control.m_StateBlock.sizeInBits = (uint)sizeOfPrimitiveFormatInBits;
			}
		}
		if (control.m_StateBlock.sizeInBits == 0 && children.Count == 0)
		{
			throw new InvalidOperationException("Control '" + control.path + "' with layout '" + control.layout + "' has no size set and has no children to compute size from");
		}
		if (children.Count == 0)
		{
			return;
		}
		uint num = 0u;
		foreach (InputControl item in children)
		{
			if (item.m_StateBlock.sizeInBits == uint.MaxValue)
			{
				continue;
			}
			uint sizeInBits = item.m_StateBlock.sizeInBits;
			if (sizeInBits == 0 || sizeInBits == uint.MaxValue)
			{
				throw new InvalidOperationException("Child '" + item.name + "' of '" + control.name + "' has no size set!");
			}
			if (item.m_StateBlock.byteOffset != uint.MaxValue && item.m_StateBlock.byteOffset != 4294967294u)
			{
				if (item.m_StateBlock.bitOffset == uint.MaxValue)
				{
					item.m_StateBlock.bitOffset = 0u;
				}
				uint num2 = MemoryHelpers.ComputeFollowingByteOffset(item.m_StateBlock.byteOffset, item.m_StateBlock.bitOffset + sizeInBits);
				if (num2 > num)
				{
					num = num2;
				}
			}
		}
		uint num3 = num;
		InputControl inputControl = null;
		uint num4 = 0u;
		foreach (InputControl item2 in children)
		{
			if ((item2.m_StateBlock.byteOffset != uint.MaxValue && item2.m_StateBlock.byteOffset != 4294967294u) || item2.m_StateBlock.sizeInBits == uint.MaxValue)
			{
				continue;
			}
			bool num5 = item2.m_StateBlock.sizeInBits % 8 != 0;
			if (num5)
			{
				if (inputControl == null)
				{
					inputControl = item2;
				}
				if (item2.m_StateBlock.bitOffset == uint.MaxValue || item2.m_StateBlock.bitOffset == 4294967294u)
				{
					item2.m_StateBlock.bitOffset = num4;
					num4 += item2.m_StateBlock.sizeInBits;
				}
				else
				{
					uint num6 = item2.m_StateBlock.bitOffset + item2.m_StateBlock.sizeInBits;
					if (num6 > num4)
					{
						num4 = num6;
					}
				}
			}
			else
			{
				if (inputControl != null)
				{
					num3 = MemoryHelpers.ComputeFollowingByteOffset(num3, num4);
					inputControl = null;
				}
				if (item2.m_StateBlock.bitOffset == uint.MaxValue)
				{
					item2.m_StateBlock.bitOffset = 0u;
				}
				num3 = MemoryHelpers.AlignNatural(num3, item2.m_StateBlock.alignedSizeInBytes);
			}
			item2.m_StateBlock.byteOffset = num3;
			if (!num5)
			{
				num3 = MemoryHelpers.ComputeFollowingByteOffset(num3, item2.m_StateBlock.sizeInBits);
			}
		}
		if (inputControl != null)
		{
			num3 = MemoryHelpers.ComputeFollowingByteOffset(num3, num4);
		}
		uint num7 = num3;
		control.m_StateBlock.sizeInBits = num7 * 8;
	}

	private void FinalizeControlHierarchy()
	{
		if (m_StateOffsetToControlMap == null)
		{
			m_StateOffsetToControlMap = new List<uint>();
		}
		if ((long)m_Device.allControls.Count > 1024L)
		{
			throw new NotSupportedException($"Device '{m_Device}' exceeds maximum supported control count of {1024u} (has {m_Device.allControls.Count} controls)");
		}
		InputDevice.ControlBitRangeNode controlBitRangeNode = new InputDevice.ControlBitRangeNode((ushort)(m_Device.m_StateBlock.sizeInBits - 1));
		m_Device.m_ControlTreeNodes = new InputDevice.ControlBitRangeNode[1];
		m_Device.m_ControlTreeNodes[0] = controlBitRangeNode;
		int controlIndiciesNextFreeIndex = 0;
		FinalizeControlHierarchyRecursive(m_Device, -1, m_Device.m_ChildrenForEachControl, noisy: false, dontReset: false, ref controlIndiciesNextFreeIndex);
	}

	private void FinalizeControlHierarchyRecursive(InputControl control, int controlIndex, InputControl[] allControls, bool noisy, bool dontReset, ref int controlIndiciesNextFreeIndex)
	{
		if (control.m_ChildCount == 0)
		{
			if (control.m_StateBlock.effectiveBitOffset >= 8192)
			{
				throw new NotSupportedException($"Control '{control}' exceeds maximum supported state bit offset of {8191u} (bit offset {control.stateBlock.effectiveBitOffset})");
			}
			if (control.m_StateBlock.sizeInBits >= 512)
			{
				throw new NotSupportedException($"Control '{control}' exceeds maximum supported state bit size of {511u} (bit offset {control.stateBlock.sizeInBits})");
			}
		}
		if (control != m_Device)
		{
			InsertControlBitRangeNode(ref m_Device.m_ControlTreeNodes[0], control, ref controlIndiciesNextFreeIndex, 0);
		}
		if (control.m_ChildCount == 0)
		{
			m_StateOffsetToControlMap.Add(InputDevice.EncodeStateOffsetToControlMapEntry((uint)controlIndex, control.m_StateBlock.effectiveBitOffset, control.m_StateBlock.sizeInBits));
		}
		string displayNameFromLayout = control.m_DisplayNameFromLayout;
		string shortDisplayNameFromLayout = control.m_ShortDisplayNameFromLayout;
		SetDisplayName(control, displayNameFromLayout, shortDisplayNameFromLayout, shortName: false);
		SetDisplayName(control, displayNameFromLayout, shortDisplayNameFromLayout, shortName: true);
		if (control != control.device)
		{
			if (noisy)
			{
				control.noisy = true;
			}
			else
			{
				noisy = control.noisy;
			}
			if (dontReset)
			{
				control.dontReset = true;
			}
			else
			{
				dontReset = control.dontReset;
			}
		}
		uint byteOffset = control.m_StateBlock.byteOffset;
		int childCount = control.m_ChildCount;
		int childStartIndex = control.m_ChildStartIndex;
		for (int i = 0; i < childCount; i++)
		{
			int num = childStartIndex + i;
			InputControl inputControl = allControls[num];
			inputControl.m_StateBlock.byteOffset += byteOffset;
			FinalizeControlHierarchyRecursive(inputControl, num, allControls, noisy, dontReset, ref controlIndiciesNextFreeIndex);
		}
		control.isSetupFinished = true;
	}

	private void InsertControlBitRangeNode(ref InputDevice.ControlBitRangeNode parent, InputControl control, ref int controlIndiciesNextFreeIndex, ushort startOffset)
	{
		InputDevice.ControlBitRangeNode left;
		InputDevice.ControlBitRangeNode right;
		if (parent.leftChildIndex == -1)
		{
			ushort bestMidPoint = GetBestMidPoint(parent, startOffset);
			left = new InputDevice.ControlBitRangeNode(bestMidPoint);
			right = new InputDevice.ControlBitRangeNode(parent.endBitOffset);
			AddChildren(ref parent, left, right);
		}
		else
		{
			left = m_Device.m_ControlTreeNodes[parent.leftChildIndex];
			right = m_Device.m_ControlTreeNodes[parent.leftChildIndex + 1];
		}
		if (control.m_StateBlock.effectiveBitOffset < left.endBitOffset && control.m_StateBlock.effectiveBitOffset + control.m_StateBlock.sizeInBits > left.endBitOffset)
		{
			AddControlToNode(control, ref controlIndiciesNextFreeIndex, parent.leftChildIndex);
			AddControlToNode(control, ref controlIndiciesNextFreeIndex, parent.leftChildIndex + 1);
		}
		else if (control.m_StateBlock.effectiveBitOffset == startOffset && control.m_StateBlock.effectiveBitOffset + control.m_StateBlock.sizeInBits == left.endBitOffset)
		{
			AddControlToNode(control, ref controlIndiciesNextFreeIndex, parent.leftChildIndex);
		}
		else if (control.m_StateBlock.effectiveBitOffset == left.endBitOffset && control.m_StateBlock.effectiveBitOffset + control.m_StateBlock.sizeInBits == right.endBitOffset)
		{
			AddControlToNode(control, ref controlIndiciesNextFreeIndex, parent.leftChildIndex + 1);
		}
		else if (control.m_StateBlock.effectiveBitOffset < left.endBitOffset)
		{
			InsertControlBitRangeNode(ref m_Device.m_ControlTreeNodes[parent.leftChildIndex], control, ref controlIndiciesNextFreeIndex, startOffset);
		}
		else
		{
			InsertControlBitRangeNode(ref m_Device.m_ControlTreeNodes[parent.leftChildIndex + 1], control, ref controlIndiciesNextFreeIndex, left.endBitOffset);
		}
	}

	private ushort GetBestMidPoint(InputDevice.ControlBitRangeNode parent, ushort startOffset)
	{
		ushort num = (ushort)(startOffset + ((parent.endBitOffset - startOffset - 1) / 2 + 1));
		ushort num2 = ushort.MaxValue;
		ushort num3 = ushort.MaxValue;
		InputControl[] childrenForEachControl = m_Device.m_ChildrenForEachControl;
		for (int i = 0; i < childrenForEachControl.Length; i++)
		{
			InputStateBlock stateBlock = childrenForEachControl[i].m_StateBlock;
			if (stateBlock.effectiveBitOffset + stateBlock.sizeInBits - 1 >= startOffset && stateBlock.effectiveBitOffset < parent.endBitOffset && stateBlock.sizeInBits <= parent.endBitOffset - startOffset && stateBlock.effectiveBitOffset != startOffset && stateBlock.effectiveBitOffset + stateBlock.sizeInBits != parent.endBitOffset)
			{
				if (Math.Abs(stateBlock.effectiveBitOffset + stateBlock.sizeInBits - (int)num) < Math.Abs(num2 - num) && stateBlock.effectiveBitOffset + stateBlock.sizeInBits < parent.endBitOffset)
				{
					num2 = (ushort)(stateBlock.effectiveBitOffset + stateBlock.sizeInBits);
				}
				if (Math.Abs(stateBlock.effectiveBitOffset - (int)num) < Math.Abs(num3 - num) && stateBlock.effectiveBitOffset >= startOffset)
				{
					num3 = (ushort)stateBlock.effectiveBitOffset;
				}
			}
		}
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		childrenForEachControl = m_Device.m_ChildrenForEachControl;
		foreach (InputControl inputControl in childrenForEachControl)
		{
			if (num3 != ushort.MaxValue && num3 > inputControl.m_StateBlock.effectiveBitOffset && num3 < inputControl.m_StateBlock.effectiveBitOffset + inputControl.m_StateBlock.sizeInBits)
			{
				num5++;
			}
			if (num2 != ushort.MaxValue && num2 > inputControl.m_StateBlock.effectiveBitOffset && num2 < inputControl.m_StateBlock.effectiveBitOffset + inputControl.m_StateBlock.sizeInBits)
			{
				num6++;
			}
			if (num > inputControl.m_StateBlock.effectiveBitOffset && num < inputControl.m_StateBlock.effectiveBitOffset + inputControl.m_StateBlock.sizeInBits)
			{
				num4++;
			}
		}
		if (num2 != ushort.MaxValue && num6 <= num5 && num6 <= num4)
		{
			return num2;
		}
		if (num3 != ushort.MaxValue && num5 <= num6 && num5 <= num4)
		{
			return num3;
		}
		return num;
	}

	private void AddControlToNode(InputControl control, ref int controlIndiciesNextFreeIndex, int nodeIndex)
	{
		ref InputDevice.ControlBitRangeNode reference = ref m_Device.m_ControlTreeNodes[nodeIndex];
		ushort controlStartIndex = reference.controlStartIndex;
		if (reference.controlCount == 0)
		{
			reference.controlStartIndex = (ushort)controlIndiciesNextFreeIndex;
			controlStartIndex = reference.controlStartIndex;
		}
		ArrayHelpers.InsertAt(ref m_Device.m_ControlTreeIndices, reference.controlStartIndex + reference.controlCount, GetControlIndex(control));
		reference.controlCount++;
		controlIndiciesNextFreeIndex++;
		for (int i = 0; i < m_Device.m_ControlTreeNodes.Length; i++)
		{
			if (m_Device.m_ControlTreeNodes[i].controlCount != 0 && m_Device.m_ControlTreeNodes[i].controlStartIndex > controlStartIndex)
			{
				m_Device.m_ControlTreeNodes[i].controlStartIndex++;
			}
		}
	}

	private void AddChildren(ref InputDevice.ControlBitRangeNode parent, InputDevice.ControlBitRangeNode left, InputDevice.ControlBitRangeNode right)
	{
		if (parent.leftChildIndex == -1)
		{
			int num = m_Device.m_ControlTreeNodes.Length;
			parent.leftChildIndex = (short)num;
			Array.Resize(ref m_Device.m_ControlTreeNodes, num + 2);
			m_Device.m_ControlTreeNodes[num] = left;
			m_Device.m_ControlTreeNodes[num + 1] = right;
		}
	}

	private ushort GetControlIndex(InputControl control)
	{
		for (int i = 0; i < m_Device.m_ChildrenForEachControl.Length; i++)
		{
			if (control == m_Device.m_ChildrenForEachControl[i])
			{
				return (ushort)i;
			}
		}
		throw new InvalidOperationException($"InputDeviceBuilder error. Couldn't find control {control}.");
	}

	internal static RefInstance Ref()
	{
		s_InstanceRef++;
		return default(RefInstance);
	}
}
