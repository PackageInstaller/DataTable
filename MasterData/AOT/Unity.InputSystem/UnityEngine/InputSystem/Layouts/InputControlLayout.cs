using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Layouts;

public class InputControlLayout
{
	public struct ControlItem
	{
		[Flags]
		private enum Flags
		{
			isModifyingExistingControl = 1,
			IsNoisy = 2,
			IsSynthetic = 4,
			IsFirstDefinedInThisLayout = 8,
			DontReset = 0x10
		}

		public InternedString name { get; internal set; }

		public InternedString layout { get; internal set; }

		public InternedString variants { get; internal set; }

		public string useStateFrom { get; internal set; }

		public string displayName { get; internal set; }

		public string shortDisplayName { get; internal set; }

		public ReadOnlyArray<InternedString> usages { get; internal set; }

		public ReadOnlyArray<InternedString> aliases { get; internal set; }

		public ReadOnlyArray<NamedValue> parameters { get; internal set; }

		public ReadOnlyArray<NameAndParameters> processors { get; internal set; }

		public uint offset { get; internal set; }

		public uint bit { get; internal set; }

		public uint sizeInBits { get; internal set; }

		public FourCC format { get; internal set; }

		private Flags flags { get; set; }

		public int arraySize { get; internal set; }

		public PrimitiveValue defaultState { get; internal set; }

		public PrimitiveValue minValue { get; internal set; }

		public PrimitiveValue maxValue { get; internal set; }

		public bool isModifyingExistingControl
		{
			get
			{
				return (flags & Flags.isModifyingExistingControl) == Flags.isModifyingExistingControl;
			}
			internal set
			{
				if (value)
				{
					flags |= Flags.isModifyingExistingControl;
				}
				else
				{
					flags &= ~Flags.isModifyingExistingControl;
				}
			}
		}

		public bool isNoisy
		{
			get
			{
				return (flags & Flags.IsNoisy) == Flags.IsNoisy;
			}
			internal set
			{
				if (value)
				{
					flags |= Flags.IsNoisy;
				}
				else
				{
					flags &= ~Flags.IsNoisy;
				}
			}
		}

		public bool isSynthetic
		{
			get
			{
				return (flags & Flags.IsSynthetic) == Flags.IsSynthetic;
			}
			internal set
			{
				if (value)
				{
					flags |= Flags.IsSynthetic;
				}
				else
				{
					flags &= ~Flags.IsSynthetic;
				}
			}
		}

		public bool dontReset
		{
			get
			{
				return (flags & Flags.DontReset) == Flags.DontReset;
			}
			internal set
			{
				if (value)
				{
					flags |= Flags.DontReset;
				}
				else
				{
					flags &= ~Flags.DontReset;
				}
			}
		}

		public bool isFirstDefinedInThisLayout
		{
			get
			{
				return (flags & Flags.IsFirstDefinedInThisLayout) != 0;
			}
			internal set
			{
				if (value)
				{
					flags |= Flags.IsFirstDefinedInThisLayout;
				}
				else
				{
					flags &= ~Flags.IsFirstDefinedInThisLayout;
				}
			}
		}

		public bool isArray => arraySize != 0;

		public ControlItem Merge(ControlItem other)
		{
			ControlItem result = new ControlItem
			{
				name = name,
				isModifyingExistingControl = isModifyingExistingControl,
				displayName = (string.IsNullOrEmpty(displayName) ? other.displayName : displayName),
				shortDisplayName = (string.IsNullOrEmpty(shortDisplayName) ? other.shortDisplayName : shortDisplayName),
				layout = (layout.IsEmpty() ? other.layout : layout),
				variants = (variants.IsEmpty() ? other.variants : variants),
				useStateFrom = (useStateFrom ?? other.useStateFrom),
				arraySize = ((!isArray) ? other.arraySize : arraySize),
				isNoisy = (isNoisy || other.isNoisy),
				dontReset = (dontReset || other.dontReset),
				isSynthetic = (isSynthetic || other.isSynthetic),
				isFirstDefinedInThisLayout = false
			};
			if (offset != uint.MaxValue)
			{
				result.offset = offset;
			}
			else
			{
				result.offset = other.offset;
			}
			if (bit != uint.MaxValue)
			{
				result.bit = bit;
			}
			else
			{
				result.bit = other.bit;
			}
			if (format != 0)
			{
				result.format = format;
			}
			else
			{
				result.format = other.format;
			}
			if (sizeInBits != 0)
			{
				result.sizeInBits = sizeInBits;
			}
			else
			{
				result.sizeInBits = other.sizeInBits;
			}
			if (aliases.Count > 0)
			{
				result.aliases = aliases;
			}
			else
			{
				result.aliases = other.aliases;
			}
			if (usages.Count > 0)
			{
				result.usages = usages;
			}
			else
			{
				result.usages = other.usages;
			}
			if (parameters.Count == 0)
			{
				result.parameters = other.parameters;
			}
			else
			{
				result.parameters = parameters;
			}
			if (processors.Count == 0)
			{
				result.processors = other.processors;
			}
			else
			{
				result.processors = processors;
			}
			if (!string.IsNullOrEmpty(displayName))
			{
				result.displayName = displayName;
			}
			else
			{
				result.displayName = other.displayName;
			}
			if (!defaultState.isEmpty)
			{
				result.defaultState = defaultState;
			}
			else
			{
				result.defaultState = other.defaultState;
			}
			if (!minValue.isEmpty)
			{
				result.minValue = minValue;
			}
			else
			{
				result.minValue = other.minValue;
			}
			if (!maxValue.isEmpty)
			{
				result.maxValue = maxValue;
			}
			else
			{
				result.maxValue = other.maxValue;
			}
			return result;
		}
	}

	public class Builder
	{
		public struct ControlBuilder
		{
			internal Builder builder;

			internal int index;

			public ControlBuilder WithDisplayName(string displayName)
			{
				builder.m_Controls[index].displayName = displayName;
				return this;
			}

			public ControlBuilder WithLayout(string layout)
			{
				if (string.IsNullOrEmpty(layout))
				{
					throw new ArgumentException("Layout name cannot be null or empty", "layout");
				}
				builder.m_Controls[index].layout = new InternedString(layout);
				return this;
			}

			public ControlBuilder WithFormat(FourCC format)
			{
				builder.m_Controls[index].format = format;
				return this;
			}

			public ControlBuilder WithFormat(string format)
			{
				return WithFormat(new FourCC(format));
			}

			public ControlBuilder WithByteOffset(uint offset)
			{
				builder.m_Controls[index].offset = offset;
				return this;
			}

			public ControlBuilder WithBitOffset(uint bit)
			{
				builder.m_Controls[index].bit = bit;
				return this;
			}

			public ControlBuilder IsSynthetic(bool value)
			{
				builder.m_Controls[index].isSynthetic = value;
				return this;
			}

			public ControlBuilder IsNoisy(bool value)
			{
				builder.m_Controls[index].isNoisy = value;
				return this;
			}

			public ControlBuilder DontReset(bool value)
			{
				builder.m_Controls[index].dontReset = value;
				return this;
			}

			public ControlBuilder WithSizeInBits(uint sizeInBits)
			{
				builder.m_Controls[index].sizeInBits = sizeInBits;
				return this;
			}

			public ControlBuilder WithRange(float minValue, float maxValue)
			{
				builder.m_Controls[index].minValue = minValue;
				builder.m_Controls[index].maxValue = maxValue;
				return this;
			}

			public ControlBuilder WithUsages(params InternedString[] usages)
			{
				if (usages == null || usages.Length == 0)
				{
					return this;
				}
				for (int i = 0; i < usages.Length; i++)
				{
					if (usages[i].IsEmpty())
					{
						throw new ArgumentException($"Empty usage entry at index {i} for control '{builder.m_Controls[index].name}' in layout '{builder.name}'", "usages");
					}
				}
				builder.m_Controls[index].usages = new ReadOnlyArray<InternedString>(usages);
				return this;
			}

			public ControlBuilder WithUsages(IEnumerable<string> usages)
			{
				InternedString[] usages2 = usages.Select((string x) => new InternedString(x)).ToArray();
				return WithUsages(usages2);
			}

			public ControlBuilder WithUsages(params string[] usages)
			{
				return WithUsages((IEnumerable<string>)usages);
			}

			public ControlBuilder WithParameters(string parameters)
			{
				if (string.IsNullOrEmpty(parameters))
				{
					return this;
				}
				NamedValue[] array = NamedValue.ParseMultiple(parameters);
				builder.m_Controls[index].parameters = new ReadOnlyArray<NamedValue>(array);
				return this;
			}

			public ControlBuilder WithProcessors(string processors)
			{
				if (string.IsNullOrEmpty(processors))
				{
					return this;
				}
				NameAndParameters[] array = NameAndParameters.ParseMultiple(processors).ToArray();
				builder.m_Controls[index].processors = new ReadOnlyArray<NameAndParameters>(array);
				return this;
			}

			public ControlBuilder WithDefaultState(PrimitiveValue value)
			{
				builder.m_Controls[index].defaultState = value;
				return this;
			}

			public ControlBuilder UsingStateFrom(string path)
			{
				if (string.IsNullOrEmpty(path))
				{
					return this;
				}
				builder.m_Controls[index].useStateFrom = path;
				return this;
			}

			public ControlBuilder AsArrayOfControlsWithSize(int arraySize)
			{
				builder.m_Controls[index].arraySize = arraySize;
				return this;
			}
		}

		private string m_ExtendsLayout;

		private int m_ControlCount;

		private ControlItem[] m_Controls;

		public string name { get; set; }

		public string displayName { get; set; }

		public Type type { get; set; }

		public FourCC stateFormat { get; set; }

		public int stateSizeInBytes { get; set; }

		public string extendsLayout
		{
			get
			{
				return m_ExtendsLayout;
			}
			set
			{
				if (!string.IsNullOrEmpty(value))
				{
					m_ExtendsLayout = value;
				}
				else
				{
					m_ExtendsLayout = null;
				}
			}
		}

		public bool? updateBeforeRender { get; set; }

		public ReadOnlyArray<ControlItem> controls => new ReadOnlyArray<ControlItem>(m_Controls, 0, m_ControlCount);

		public ControlBuilder AddControl(string name)
		{
			if (string.IsNullOrEmpty(name))
			{
				throw new ArgumentException(name);
			}
			int index = ArrayHelpers.AppendWithCapacity(ref m_Controls, ref m_ControlCount, new ControlItem
			{
				name = new InternedString(name),
				isModifyingExistingControl = (name.IndexOf('/') != -1),
				offset = uint.MaxValue,
				bit = uint.MaxValue
			});
			return new ControlBuilder
			{
				builder = this,
				index = index
			};
		}

		public Builder WithName(string name)
		{
			this.name = name;
			return this;
		}

		public Builder WithDisplayName(string displayName)
		{
			this.displayName = displayName;
			return this;
		}

		public Builder WithType<T>() where T : InputControl
		{
			type = typeof(T);
			return this;
		}

		public Builder WithFormat(FourCC format)
		{
			stateFormat = format;
			return this;
		}

		public Builder WithFormat(string format)
		{
			return WithFormat(new FourCC(format));
		}

		public Builder WithSizeInBytes(int sizeInBytes)
		{
			stateSizeInBytes = sizeInBytes;
			return this;
		}

		public Builder Extend(string baseLayoutName)
		{
			extendsLayout = baseLayoutName;
			return this;
		}

		public InputControlLayout Build()
		{
			ControlItem[] destinationArray = null;
			if (m_ControlCount > 0)
			{
				destinationArray = new ControlItem[m_ControlCount];
				Array.Copy(m_Controls, destinationArray, m_ControlCount);
			}
			return new InputControlLayout(new InternedString(name), (type == null && string.IsNullOrEmpty(extendsLayout)) ? typeof(InputDevice) : type)
			{
				m_DisplayName = displayName,
				m_StateFormat = stateFormat,
				m_StateSizeInBytes = stateSizeInBytes,
				m_BaseLayouts = ((!string.IsNullOrEmpty(extendsLayout)) ? new InlinedArray<InternedString>(new InternedString(extendsLayout)) : default(InlinedArray<InternedString>)),
				m_Controls = destinationArray,
				m_UpdateBeforeRender = updateBeforeRender
			};
		}
	}

	[Flags]
	private enum Flags
	{
		IsGenericTypeOfDevice = 1,
		HideInUI = 2,
		IsOverride = 4,
		CanRunInBackground = 8,
		CanRunInBackgroundIsSet = 0x10,
		IsNoisy = 0x20
	}

	[Serializable]
	internal struct LayoutJsonNameAndDescriptorOnly
	{
		public string name;

		public string extend;

		public string[] extendMultiple;

		public InputDeviceMatcher.MatcherJson device;
	}

	[Serializable]
	private struct LayoutJson
	{
		public string name;

		public string extend;

		public string[] extendMultiple;

		public string format;

		public string beforeRender;

		public string runInBackground;

		public string[] commonUsages;

		public string displayName;

		public string description;

		public string type;

		public string variant;

		public bool isGenericTypeOfDevice;

		public bool hideInUI;

		public ControlItemJson[] controls;

		public InputControlLayout ToLayout()
		{
			Type type = null;
			if (!string.IsNullOrEmpty(this.type))
			{
				type = Type.GetType(this.type, throwOnError: false);
				if (type == null)
				{
					Debug.Log("Cannot find type '" + this.type + "' used by layout '" + name + "'; falling back to using InputDevice");
					type = typeof(InputDevice);
				}
				else if (!typeof(InputControl).IsAssignableFrom(type))
				{
					throw new InvalidOperationException("'" + this.type + "' used by layout '" + name + "' is not an InputControl");
				}
			}
			else if (string.IsNullOrEmpty(extend))
			{
				type = typeof(InputDevice);
			}
			InputControlLayout inputControlLayout = new InputControlLayout(name, type)
			{
				m_DisplayName = displayName,
				m_Description = description,
				isGenericTypeOfDevice = isGenericTypeOfDevice,
				hideInUI = hideInUI,
				m_Variants = new InternedString(variant),
				m_CommonUsages = ArrayHelpers.Select(commonUsages, (string x) => new InternedString(x))
			};
			if (!string.IsNullOrEmpty(format))
			{
				inputControlLayout.m_StateFormat = new FourCC(format);
			}
			if (!string.IsNullOrEmpty(extend))
			{
				inputControlLayout.m_BaseLayouts.Append(new InternedString(extend));
			}
			if (extendMultiple != null)
			{
				string[] array = extendMultiple;
				foreach (string text in array)
				{
					inputControlLayout.m_BaseLayouts.Append(new InternedString(text));
				}
			}
			if (!string.IsNullOrEmpty(beforeRender))
			{
				string text2 = beforeRender.ToLowerInvariant();
				if (text2 == "ignore")
				{
					inputControlLayout.m_UpdateBeforeRender = false;
				}
				else
				{
					if (!(text2 == "update"))
					{
						throw new InvalidOperationException("Invalid beforeRender setting '" + beforeRender + "' (should be 'ignore' or 'update')");
					}
					inputControlLayout.m_UpdateBeforeRender = true;
				}
			}
			if (!string.IsNullOrEmpty(runInBackground))
			{
				string text3 = runInBackground.ToLowerInvariant();
				if (text3 == "enabled")
				{
					inputControlLayout.canRunInBackground = true;
				}
				else
				{
					if (!(text3 == "disabled"))
					{
						throw new InvalidOperationException("Invalid runInBackground setting '" + beforeRender + "' (should be 'enabled' or 'disabled')");
					}
					inputControlLayout.canRunInBackground = false;
				}
			}
			if (controls != null)
			{
				List<ControlItem> list = new List<ControlItem>();
				ControlItemJson[] array2 = controls;
				foreach (ControlItemJson obj in array2)
				{
					if (string.IsNullOrEmpty(obj.name))
					{
						throw new InvalidOperationException("Control with no name in layout '" + name);
					}
					ControlItem item = obj.ToLayout();
					list.Add(item);
				}
				inputControlLayout.m_Controls = list.ToArray();
			}
			return inputControlLayout;
		}

		public static LayoutJson FromLayout(InputControlLayout layout)
		{
			return new LayoutJson
			{
				name = layout.m_Name,
				type = layout.type?.AssemblyQualifiedName,
				variant = layout.m_Variants,
				displayName = layout.m_DisplayName,
				description = layout.m_Description,
				isGenericTypeOfDevice = layout.isGenericTypeOfDevice,
				hideInUI = layout.hideInUI,
				extend = ((layout.m_BaseLayouts.length == 1) ? layout.m_BaseLayouts[0].ToString() : null),
				extendMultiple = ((layout.m_BaseLayouts.length > 1) ? layout.m_BaseLayouts.ToArray((InternedString x) => x.ToString()) : null),
				format = layout.stateFormat.ToString(),
				commonUsages = ArrayHelpers.Select(layout.m_CommonUsages, (InternedString x) => x.ToString()),
				controls = ControlItemJson.FromControlItems(layout.m_Controls),
				beforeRender = ((!layout.m_UpdateBeforeRender.HasValue) ? null : (layout.m_UpdateBeforeRender.Value ? "Update" : "Ignore"))
			};
		}
	}

	[Serializable]
	private class ControlItemJson
	{
		public string name;

		public string layout;

		public string variants;

		public string usage;

		public string alias;

		public string useStateFrom;

		public uint offset;

		public uint bit;

		public uint sizeInBits;

		public string format;

		public int arraySize;

		public string[] usages;

		public string[] aliases;

		public string parameters;

		public string processors;

		public string displayName;

		public string shortDisplayName;

		public bool noisy;

		public bool dontReset;

		public bool synthetic;

		public string defaultState;

		public string minValue;

		public string maxValue;

		public ControlItemJson()
		{
			offset = uint.MaxValue;
			bit = uint.MaxValue;
		}

		public ControlItem ToLayout()
		{
			ControlItem result = new ControlItem
			{
				name = new InternedString(name),
				layout = new InternedString(layout),
				variants = new InternedString(variants),
				displayName = displayName,
				shortDisplayName = shortDisplayName,
				offset = offset,
				useStateFrom = useStateFrom,
				bit = bit,
				sizeInBits = sizeInBits,
				isModifyingExistingControl = (name.IndexOf('/') != -1),
				isNoisy = noisy,
				dontReset = dontReset,
				isSynthetic = synthetic,
				isFirstDefinedInThisLayout = true,
				arraySize = arraySize
			};
			if (!string.IsNullOrEmpty(format))
			{
				result.format = new FourCC(format);
			}
			if (!string.IsNullOrEmpty(usage) || usages != null)
			{
				List<string> list = new List<string>();
				if (!string.IsNullOrEmpty(usage))
				{
					list.Add(usage);
				}
				if (usages != null)
				{
					list.AddRange(usages);
				}
				result.usages = new ReadOnlyArray<InternedString>(list.Select((string x) => new InternedString(x)).ToArray());
			}
			if (!string.IsNullOrEmpty(alias) || aliases != null)
			{
				List<string> list2 = new List<string>();
				if (!string.IsNullOrEmpty(alias))
				{
					list2.Add(alias);
				}
				if (aliases != null)
				{
					list2.AddRange(aliases);
				}
				result.aliases = new ReadOnlyArray<InternedString>(list2.Select((string x) => new InternedString(x)).ToArray());
			}
			if (!string.IsNullOrEmpty(parameters))
			{
				result.parameters = new ReadOnlyArray<NamedValue>(NamedValue.ParseMultiple(parameters));
			}
			if (!string.IsNullOrEmpty(processors))
			{
				result.processors = new ReadOnlyArray<NameAndParameters>(NameAndParameters.ParseMultiple(processors).ToArray());
			}
			if (defaultState != null)
			{
				result.defaultState = PrimitiveValue.FromObject(defaultState);
			}
			if (minValue != null)
			{
				result.minValue = PrimitiveValue.FromObject(minValue);
			}
			if (maxValue != null)
			{
				result.maxValue = PrimitiveValue.FromObject(maxValue);
			}
			return result;
		}

		public static ControlItemJson[] FromControlItems(ControlItem[] items)
		{
			if (items == null)
			{
				return null;
			}
			int num = items.Length;
			ControlItemJson[] array = new ControlItemJson[num];
			for (int i = 0; i < num; i++)
			{
				ControlItem controlItem = items[i];
				array[i] = new ControlItemJson
				{
					name = controlItem.name,
					layout = controlItem.layout,
					variants = controlItem.variants,
					displayName = controlItem.displayName,
					shortDisplayName = controlItem.shortDisplayName,
					bit = controlItem.bit,
					offset = controlItem.offset,
					sizeInBits = controlItem.sizeInBits,
					format = controlItem.format.ToString(),
					parameters = string.Join(",", controlItem.parameters.Select((NamedValue x) => x.ToString()).ToArray()),
					processors = string.Join(",", controlItem.processors.Select((NameAndParameters x) => x.ToString()).ToArray()),
					usages = controlItem.usages.Select((InternedString x) => x.ToString()).ToArray(),
					aliases = controlItem.aliases.Select((InternedString x) => x.ToString()).ToArray(),
					noisy = controlItem.isNoisy,
					dontReset = controlItem.dontReset,
					synthetic = controlItem.isSynthetic,
					arraySize = controlItem.arraySize,
					defaultState = controlItem.defaultState.ToString(),
					minValue = controlItem.minValue.ToString(),
					maxValue = controlItem.maxValue.ToString()
				};
			}
			return array;
		}
	}

	internal struct Collection
	{
		public struct LayoutMatcher
		{
			public InternedString layoutName;

			public InputDeviceMatcher deviceMatcher;
		}

		public struct PrecompiledLayout
		{
			public Func<InputDevice> factoryMethod;

			public string metadata;
		}

		public const float kBaseScoreForNonGeneratedLayouts = 1f;

		public Dictionary<InternedString, Type> layoutTypes;

		public Dictionary<InternedString, string> layoutStrings;

		public Dictionary<InternedString, Func<InputControlLayout>> layoutBuilders;

		public Dictionary<InternedString, InternedString> baseLayoutTable;

		public Dictionary<InternedString, InternedString[]> layoutOverrides;

		public HashSet<InternedString> layoutOverrideNames;

		public Dictionary<InternedString, PrecompiledLayout> precompiledLayouts;

		public List<LayoutMatcher> layoutMatchers;

		public void Allocate()
		{
			layoutTypes = new Dictionary<InternedString, Type>();
			layoutStrings = new Dictionary<InternedString, string>();
			layoutBuilders = new Dictionary<InternedString, Func<InputControlLayout>>();
			baseLayoutTable = new Dictionary<InternedString, InternedString>();
			layoutOverrides = new Dictionary<InternedString, InternedString[]>();
			layoutOverrideNames = new HashSet<InternedString>();
			layoutMatchers = new List<LayoutMatcher>();
			precompiledLayouts = new Dictionary<InternedString, PrecompiledLayout>();
		}

		public InternedString TryFindLayoutForType(Type layoutType)
		{
			foreach (KeyValuePair<InternedString, Type> layoutType2 in layoutTypes)
			{
				if (layoutType2.Value == layoutType)
				{
					return layoutType2.Key;
				}
			}
			return default;
		}

		public InternedString TryFindMatchingLayout(InputDeviceDescription deviceDescription)
		{
			float num = 0f;
			InternedString result = default;
			int count = layoutMatchers.Count;
			for (int i = 0; i < count; i++)
			{
				float num2 = layoutMatchers[i].deviceMatcher.MatchPercentage(deviceDescription);
				if (num2 > 0f && !layoutBuilders.ContainsKey(layoutMatchers[i].layoutName))
				{
					num2++;
				}
				if (num2 > num)
				{
					num = num2;
					result = layoutMatchers[i].layoutName;
				}
			}
			return result;
		}

		public bool HasLayout(InternedString name)
		{
			if (!layoutTypes.ContainsKey(name) && !layoutStrings.ContainsKey(name))
			{
				return layoutBuilders.ContainsKey(name);
			}
			return true;
		}

		private InputControlLayout TryLoadLayoutInternal(InternedString name)
		{
			if (layoutStrings.TryGetValue(name, out var value))
			{
				return FromJson(value);
			}
			if (layoutTypes.TryGetValue(name, out var value2))
			{
				return FromType(name, value2);
			}
			if (layoutBuilders.TryGetValue(name, out var value3))
			{
				return value3() ?? throw new InvalidOperationException($"Layout builder '{name}' returned null when invoked");
			}
			return null;
		}

		public InputControlLayout TryLoadLayout(InternedString name, Dictionary<InternedString, InputControlLayout> table = null)
		{
			if (table != null && table.TryGetValue(name, out var value))
			{
				return value;
			}
			value = TryLoadLayoutInternal(name);
			if (value != null)
			{
				value.m_Name = name;
				if (layoutOverrideNames.Contains(name))
				{
					value.isOverride = true;
				}
				InternedString value2 = default;
				if (!value.isOverride && baseLayoutTable.TryGetValue(name, out value2))
				{
					InputControlLayout inputControlLayout = TryLoadLayout(value2, table);
					if (inputControlLayout == null)
					{
						throw new LayoutNotFoundException($"Cannot find base layout '{value2}' of layout '{name}'");
					}
					value.MergeLayout(inputControlLayout);
					if (value.m_BaseLayouts.length == 0)
					{
						value.m_BaseLayouts.Append(value2);
					}
				}
				if (layoutOverrides.TryGetValue(name, out var value3))
				{
					foreach (InternedString internedString in value3)
					{
						InputControlLayout inputControlLayout2 = TryLoadLayout(internedString);
						inputControlLayout2.MergeLayout(value);
						inputControlLayout2.m_BaseLayouts.Clear();
						inputControlLayout2.isOverride = false;
						inputControlLayout2.isGenericTypeOfDevice = value.isGenericTypeOfDevice;
						inputControlLayout2.m_Name = value.name;
						inputControlLayout2.m_BaseLayouts = value.m_BaseLayouts;
						value = inputControlLayout2;
						value.m_AppliedOverrides.Append(internedString);
					}
				}
				if (table != null)
				{
					table[name] = value;
				}
			}
			return value;
		}

		public InternedString GetBaseLayoutName(InternedString layoutName)
		{
			if (baseLayoutTable.TryGetValue(layoutName, out var value))
			{
				return value;
			}
			return default;
		}

		public InternedString GetRootLayoutName(InternedString layoutName)
		{
			InternedString value;
			while (baseLayoutTable.TryGetValue(layoutName, out value))
			{
				layoutName = value;
			}
			return layoutName;
		}

		public bool ComputeDistanceInInheritanceHierarchy(InternedString firstLayout, InternedString secondLayout, out int distance)
		{
			distance = 0;
			int num = 0;
			InternedString internedString = secondLayout;
			while (!internedString.IsEmpty() && internedString != firstLayout)
			{
				internedString = GetBaseLayoutName(internedString);
				num++;
			}
			if (internedString == firstLayout)
			{
				distance = num;
				return true;
			}
			int num2 = 0;
			internedString = firstLayout;
			while (!internedString.IsEmpty() && internedString != secondLayout)
			{
				internedString = GetBaseLayoutName(internedString);
				num2++;
			}
			if (internedString == secondLayout)
			{
				distance = num2;
				return true;
			}
			return false;
		}

		public InternedString FindLayoutThatIntroducesControl(InputControl control, Cache cache)
		{
			InputControl inputControl = control;
			while (inputControl.parent != control.device)
			{
				inputControl = inputControl.parent;
			}
			InternedString internedString = control.device.m_Layout;
			InternedString value = internedString;
			while (baseLayoutTable.TryGetValue(value, out value))
			{
				if (cache.FindOrLoadLayout(value).FindControl(inputControl.m_Name).HasValue)
				{
					internedString = value;
				}
			}
			return internedString;
		}

		public Type GetControlTypeForLayout(InternedString layoutName)
		{
			while (layoutStrings.ContainsKey(layoutName))
			{
				if (baseLayoutTable.TryGetValue(layoutName, out var value))
				{
					layoutName = value;
					continue;
				}
				return typeof(InputDevice);
			}
			layoutTypes.TryGetValue(layoutName, out var value2);
			return value2;
		}

		public bool ValueTypeIsAssignableFrom(InternedString layoutName, Type valueType)
		{
			Type controlTypeForLayout = GetControlTypeForLayout(layoutName);
			if (controlTypeForLayout == null)
			{
				return false;
			}
			Type genericTypeArgumentFromHierarchy = TypeHelpers.GetGenericTypeArgumentFromHierarchy(controlTypeForLayout, typeof(InputControl<>), 0);
			if (genericTypeArgumentFromHierarchy == null)
			{
				return false;
			}
			return valueType.IsAssignableFrom(genericTypeArgumentFromHierarchy);
		}

		public bool IsGeneratedLayout(InternedString layout)
		{
			return layoutBuilders.ContainsKey(layout);
		}

		public IEnumerable<InternedString> GetBaseLayouts(InternedString layout, bool includeSelf = true)
		{
			if (includeSelf)
			{
				yield return layout;
			}
			while (baseLayoutTable.TryGetValue(layout, out layout))
			{
				yield return layout;
			}
		}

		public bool IsBasedOn(InternedString parentLayout, InternedString childLayout)
		{
			InternedString value = childLayout;
			while (baseLayoutTable.TryGetValue(value, out value))
			{
				if (value == parentLayout)
				{
					return true;
				}
			}
			return false;
		}

		public void AddMatcher(InternedString layout, InputDeviceMatcher matcher)
		{
			int count = layoutMatchers.Count;
			for (int i = 0; i < count; i++)
			{
				if (layoutMatchers[i].deviceMatcher == matcher)
				{
					return;
				}
			}
			layoutMatchers.Add(new LayoutMatcher
			{
				layoutName = layout,
				deviceMatcher = matcher
			});
		}
	}

	public class LayoutNotFoundException : Exception
	{
		public string layout { get; }

		public LayoutNotFoundException()
		{
		}

		public LayoutNotFoundException(string name, string message)
			: base(message)
		{
			layout = name;
		}

		public LayoutNotFoundException(string name)
			: base("Cannot find control layout '" + name + "'")
		{
			layout = name;
		}

		public LayoutNotFoundException(string message, Exception innerException)
			: base(message, innerException)
		{
		}

		protected LayoutNotFoundException(SerializationInfo info, StreamingContext context)
			: base(info, context)
		{
		}
	}

	internal struct Cache
	{
		public Dictionary<InternedString, InputControlLayout> table;

		public void Clear()
		{
			table = null;
		}

		public InputControlLayout FindOrLoadLayout(string name, bool throwIfNotFound = true)
		{
			InternedString name2 = new InternedString(name);
			if (table == null)
			{
				table = new Dictionary<InternedString, InputControlLayout>();
			}
			InputControlLayout inputControlLayout = s_Layouts.TryLoadLayout(name2, table);
			if (inputControlLayout != null)
			{
				return inputControlLayout;
			}
			if (throwIfNotFound)
			{
				throw new LayoutNotFoundException(name);
			}
			return null;
		}
	}

	internal struct CacheRefInstance : IDisposable
	{
		public bool valid;

		public void Dispose()
		{
			if (valid)
			{
				s_CacheInstanceRef--;
				if (s_CacheInstanceRef <= 0)
				{
					s_CacheInstance = default;
					s_CacheInstanceRef = 0;
				}
				valid = false;
			}
		}
	}

	private static InternedString s_DefaultVariant = new InternedString("Default");

	public const string VariantSeparator = ";";

	private InternedString m_Name;

	private Type m_Type;

	private InternedString m_Variants;

	private FourCC m_StateFormat;

	internal int m_StateSizeInBytes;

	internal bool? m_UpdateBeforeRender;

	internal InlinedArray<InternedString> m_BaseLayouts;

	private InlinedArray<InternedString> m_AppliedOverrides;

	private InternedString[] m_CommonUsages;

	internal ControlItem[] m_Controls;

	internal string m_DisplayName;

	private string m_Description;

	private Flags m_Flags;

	internal static Collection s_Layouts;

	internal static Cache s_CacheInstance;

	internal static int s_CacheInstanceRef;

	public static InternedString DefaultVariant => s_DefaultVariant;

	public InternedString name => m_Name;

	public string displayName => m_DisplayName ?? ((string)m_Name);

	public Type type => m_Type;

	public InternedString variants => m_Variants;

	public FourCC stateFormat => m_StateFormat;

	public int stateSizeInBytes => m_StateSizeInBytes;

	public IEnumerable<InternedString> baseLayouts => m_BaseLayouts;

	public IEnumerable<InternedString> appliedOverrides => m_AppliedOverrides;

	public ReadOnlyArray<InternedString> commonUsages => new ReadOnlyArray<InternedString>(m_CommonUsages);

	public ReadOnlyArray<ControlItem> controls => new ReadOnlyArray<ControlItem>(m_Controls);

	public bool updateBeforeRender => m_UpdateBeforeRender == true;

	public bool isDeviceLayout => typeof(InputDevice).IsAssignableFrom(m_Type);

	public bool isControlLayout => !isDeviceLayout;

	public bool isOverride
	{
		get
		{
			return (m_Flags & Flags.IsOverride) != 0;
		}
		internal set
		{
			if (value)
			{
				m_Flags |= Flags.IsOverride;
			}
			else
			{
				m_Flags &= ~Flags.IsOverride;
			}
		}
	}

	public bool isGenericTypeOfDevice
	{
		get
		{
			return (m_Flags & Flags.IsGenericTypeOfDevice) != 0;
		}
		internal set
		{
			if (value)
			{
				m_Flags |= Flags.IsGenericTypeOfDevice;
			}
			else
			{
				m_Flags &= ~Flags.IsGenericTypeOfDevice;
			}
		}
	}

	public bool hideInUI
	{
		get
		{
			return (m_Flags & Flags.HideInUI) != 0;
		}
		internal set
		{
			if (value)
			{
				m_Flags |= Flags.HideInUI;
			}
			else
			{
				m_Flags &= ~Flags.HideInUI;
			}
		}
	}

	public bool isNoisy
	{
		get
		{
			return (m_Flags & Flags.IsNoisy) != 0;
		}
		internal set
		{
			if (value)
			{
				m_Flags |= Flags.IsNoisy;
			}
			else
			{
				m_Flags &= ~Flags.IsNoisy;
			}
		}
	}

	public bool? canRunInBackground
	{
		get
		{
			if ((m_Flags & Flags.CanRunInBackgroundIsSet) == 0)
			{
				return null;
			}
			return (m_Flags & Flags.CanRunInBackground) != 0;
		}
		internal set
		{
			if (!value.HasValue)
			{
				m_Flags &= ~Flags.CanRunInBackgroundIsSet;
				return;
			}
			m_Flags |= Flags.CanRunInBackgroundIsSet;
			if (value.Value)
			{
				m_Flags |= Flags.CanRunInBackground;
			}
			else
			{
				m_Flags &= ~Flags.CanRunInBackground;
			}
		}
	}

	public ControlItem this[string path]
	{
		get
		{
			if (string.IsNullOrEmpty(path))
			{
				throw new ArgumentNullException("path");
			}
			if (m_Controls != null)
			{
				for (int i = 0; i < m_Controls.Length; i++)
				{
					if (m_Controls[i].name == path)
					{
						return m_Controls[i];
					}
				}
			}
			throw new KeyNotFoundException($"Cannot find control '{path}' in layout '{name}'");
		}
	}

	internal static ref Cache cache => ref s_CacheInstance;

	public ControlItem? FindControl(InternedString path)
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new ArgumentNullException("path");
		}
		if (m_Controls == null)
		{
			return null;
		}
		for (int i = 0; i < m_Controls.Length; i++)
		{
			if (m_Controls[i].name == path)
			{
				return m_Controls[i];
			}
		}
		return null;
	}

	public ControlItem? FindControlIncludingArrayElements(string path, out int arrayIndex)
	{
		if (string.IsNullOrEmpty(path))
		{
			throw new ArgumentNullException("path");
		}
		arrayIndex = -1;
		if (m_Controls == null)
		{
			return null;
		}
		int num = 0;
		int num2 = path.Length;
		while (num2 > 0 && char.IsDigit(path[num2 - 1]))
		{
			num2--;
			num *= 10;
			num += path[num2] - 48;
		}
		int num3 = 0;
		if (num2 < path.Length && num2 > 0)
		{
			num3 = num2;
		}
		for (int i = 0; i < m_Controls.Length; i++)
		{
			ref ControlItem reference = ref m_Controls[i];
			if (string.Compare(reference.name, path, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				return reference;
			}
			if (reference.isArray && num3 > 0 && num3 == reference.name.length && string.Compare(reference.name.ToString(), 0, path, 0, num3, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				arrayIndex = num;
				return reference;
			}
		}
		return null;
	}

	public Type GetValueType()
	{
		return TypeHelpers.GetGenericTypeArgumentFromHierarchy(type, typeof(InputControl<>), 0);
	}

	public static InputControlLayout FromType(string name, Type type)
	{
		List<ControlItem> list = new List<ControlItem>();
		InputControlLayoutAttribute customAttribute = type.GetCustomAttribute<InputControlLayoutAttribute>(inherit: true);
		FourCC fourCC = default;
		if (customAttribute != null && customAttribute.stateType != null)
		{
			AddControlItems(customAttribute.stateType, list, name);
			if (typeof(IInputStateTypeInfo).IsAssignableFrom(customAttribute.stateType))
			{
				fourCC = ((IInputStateTypeInfo)Activator.CreateInstance(customAttribute.stateType)).format;
			}
		}
		else
		{
			AddControlItems(type, list, name);
		}
		if (customAttribute != null && !string.IsNullOrEmpty(customAttribute.stateFormat))
		{
			fourCC = new FourCC(customAttribute.stateFormat);
		}
		InternedString internedString = default;
		if (customAttribute != null)
		{
			internedString = new InternedString(customAttribute.variants);
		}
		InputControlLayout inputControlLayout = new InputControlLayout(name, type)
		{
			m_Controls = list.ToArray(),
			m_StateFormat = fourCC,
			m_Variants = internedString,
			m_UpdateBeforeRender = customAttribute?.updateBeforeRenderInternal,
			isGenericTypeOfDevice = (customAttribute?.isGenericTypeOfDevice ?? false),
			hideInUI = (customAttribute?.hideInUI ?? false),
			m_Description = customAttribute?.description,
			m_DisplayName = customAttribute?.displayName,
			canRunInBackground = customAttribute?.canRunInBackgroundInternal,
			isNoisy = (customAttribute?.isNoisy ?? false)
		};
		if (customAttribute?.commonUsages != null)
		{
			inputControlLayout.m_CommonUsages = ArrayHelpers.Select(customAttribute.commonUsages, (string x) => new InternedString(x));
		}
		return inputControlLayout;
	}

	public string ToJson()
	{
		return JsonUtility.ToJson(LayoutJson.FromLayout(this), prettyPrint: true);
	}

	public static InputControlLayout FromJson(string json)
	{
		return JsonUtility.FromJson<LayoutJson>(json).ToLayout();
	}

	private InputControlLayout(string name, Type type)
	{
		m_Name = new InternedString(name);
		m_Type = type;
	}

	private static void AddControlItems(Type type, List<ControlItem> controlLayouts, string layoutName)
	{
		AddControlItemsFromFields(type, controlLayouts, layoutName);
		AddControlItemsFromProperties(type, controlLayouts, layoutName);
	}

	private static void AddControlItemsFromFields(Type type, List<ControlItem> controlLayouts, string layoutName)
	{
		MemberInfo[] fields = type.GetFields(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		AddControlItemsFromMembers(fields, controlLayouts, layoutName);
	}

	private static void AddControlItemsFromProperties(Type type, List<ControlItem> controlLayouts, string layoutName)
	{
		MemberInfo[] properties = type.GetProperties(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
		AddControlItemsFromMembers(properties, controlLayouts, layoutName);
	}

	private static void AddControlItemsFromMembers(MemberInfo[] members, List<ControlItem> controlItems, string layoutName)
	{
		foreach (MemberInfo memberInfo in members)
		{
			if (memberInfo.DeclaringType == typeof(InputControl))
			{
				continue;
			}
			Type valueType = TypeHelpers.GetValueType(memberInfo);
			if (valueType != null && valueType.IsValueType && typeof(IInputStateTypeInfo).IsAssignableFrom(valueType))
			{
				int count = controlItems.Count;
				AddControlItems(valueType, controlItems, layoutName);
				if (memberInfo as FieldInfo != null)
				{
					int num = Marshal.OffsetOf(memberInfo.DeclaringType, memberInfo.Name).ToInt32();
					int count2 = controlItems.Count;
					for (int j = count; j < count2; j++)
					{
						ControlItem value = controlItems[j];
						if (controlItems[j].offset != uint.MaxValue)
						{
							value.offset += (uint)num;
							controlItems[j] = value;
						}
					}
				}
			}
			InputControlAttribute[] array = memberInfo.GetCustomAttributes<InputControlAttribute>(inherit: false).ToArray();
			if (array.Length != 0 || (!(valueType == null) && typeof(InputControl).IsAssignableFrom(valueType) && !(memberInfo is PropertyInfo)))
			{
				AddControlItemsFromMember(memberInfo, array, controlItems);
			}
		}
	}

	private static void AddControlItemsFromMember(MemberInfo member, InputControlAttribute[] attributes, List<ControlItem> controlItems)
	{
		if (attributes.Length == 0)
		{
			ControlItem item = CreateControlItemFromMember(member, null);
			controlItems.Add(item);
			return;
		}
		foreach (InputControlAttribute attribute in attributes)
		{
			ControlItem item2 = CreateControlItemFromMember(member, attribute);
			controlItems.Add(item2);
		}
	}

	private static ControlItem CreateControlItemFromMember(MemberInfo member, InputControlAttribute attribute)
	{
		string text = attribute?.name;
		if (string.IsNullOrEmpty(text))
		{
			text = member.Name;
		}
		bool flag = text.IndexOf('/') != -1;
		string text2 = attribute?.displayName;
		string shortDisplayName = attribute?.shortDisplayName;
		string text3 = attribute?.layout;
		if (string.IsNullOrEmpty(text3) && !flag && (!(member is FieldInfo) || member.GetCustomAttribute<FixedBufferAttribute>(inherit: false) == null))
		{
			text3 = InferLayoutFromValueType(TypeHelpers.GetValueType(member));
		}
		string text4 = null;
		if (attribute != null && !string.IsNullOrEmpty(attribute.variants))
		{
			text4 = attribute.variants;
		}
		uint offset = uint.MaxValue;
		if (attribute != null && attribute.offset != uint.MaxValue)
		{
			offset = attribute.offset;
		}
		else if (member is FieldInfo && !flag)
		{
			offset = (uint)Marshal.OffsetOf(member.DeclaringType, member.Name).ToInt32();
		}
		uint num = uint.MaxValue;
		if (attribute != null)
		{
			num = attribute.bit;
		}
		uint sizeInBits = 0u;
		if (attribute != null)
		{
			sizeInBits = attribute.sizeInBits;
		}
		FourCC format = default;
		if (attribute != null && !string.IsNullOrEmpty(attribute.format))
		{
			format = new FourCC(attribute.format);
		}
		else if (!flag && num == uint.MaxValue)
		{
			format = InputStateBlock.GetPrimitiveFormatFromType(TypeHelpers.GetValueType(member));
		}
		InternedString[] array = null;
		if (attribute != null)
		{
			string[] array2 = ArrayHelpers.Join(attribute.alias, attribute.aliases);
			if (array2 != null)
			{
				array = array2.Select((string x) => new InternedString(x)).ToArray();
			}
		}
		InternedString[] array3 = null;
		if (attribute != null)
		{
			string[] array4 = ArrayHelpers.Join(attribute.usage, attribute.usages);
			if (array4 != null)
			{
				array3 = array4.Select((string x) => new InternedString(x)).ToArray();
			}
		}
		NamedValue[] array5 = null;
		if (attribute != null && !string.IsNullOrEmpty(attribute.parameters))
		{
			array5 = NamedValue.ParseMultiple(attribute.parameters);
		}
		NameAndParameters[] array6 = null;
		if (attribute != null && !string.IsNullOrEmpty(attribute.processors))
		{
			array6 = NameAndParameters.ParseMultiple(attribute.processors).ToArray();
		}
		string useStateFrom = null;
		if (attribute != null && !string.IsNullOrEmpty(attribute.useStateFrom))
		{
			useStateFrom = attribute.useStateFrom;
		}
		bool flag2 = false;
		if (attribute != null)
		{
			flag2 = attribute.noisy;
		}
		bool dontReset = false;
		if (attribute != null)
		{
			dontReset = attribute.dontReset;
		}
		bool isSynthetic = false;
		if (attribute != null)
		{
			isSynthetic = attribute.synthetic;
		}
		int arraySize = 0;
		if (attribute != null)
		{
			arraySize = attribute.arraySize;
		}
		PrimitiveValue defaultState = default;
		if (attribute != null)
		{
			defaultState = PrimitiveValue.FromObject(attribute.defaultState);
		}
		PrimitiveValue minValue = default;
		PrimitiveValue maxValue = default;
		if (attribute != null)
		{
			minValue = PrimitiveValue.FromObject(attribute.minValue);
			maxValue = PrimitiveValue.FromObject(attribute.maxValue);
		}
		return new ControlItem
		{
			name = new InternedString(text),
			displayName = text2,
			shortDisplayName = shortDisplayName,
			layout = new InternedString(text3),
			variants = new InternedString(text4),
			useStateFrom = useStateFrom,
			format = format,
			offset = offset,
			bit = num,
			sizeInBits = sizeInBits,
			parameters = new ReadOnlyArray<NamedValue>(array5),
			processors = new ReadOnlyArray<NameAndParameters>(array6),
			usages = new ReadOnlyArray<InternedString>(array3),
			aliases = new ReadOnlyArray<InternedString>(array),
			isModifyingExistingControl = flag,
			isFirstDefinedInThisLayout = true,
			isNoisy = flag2,
			dontReset = dontReset,
			isSynthetic = isSynthetic,
			arraySize = arraySize,
			defaultState = defaultState,
			minValue = minValue,
			maxValue = maxValue
		};
	}

	private static string InferLayoutFromValueType(Type type)
	{
		InternedString internedString = s_Layouts.TryFindLayoutForType(type);
		if (internedString.IsEmpty())
		{
			InternedString internedString2 = new InternedString(type.Name);
			if (s_Layouts.HasLayout(internedString2))
			{
				internedString = internedString2;
			}
			else if (type.Name.EndsWith("Control"))
			{
				internedString2 = new InternedString(type.Name.Substring(0, type.Name.Length - "Control".Length));
				if (s_Layouts.HasLayout(internedString2))
				{
					internedString = internedString2;
				}
			}
		}
		return internedString;
	}

	public void MergeLayout(InputControlLayout other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		m_UpdateBeforeRender = m_UpdateBeforeRender ?? other.m_UpdateBeforeRender;
		if (m_Variants.IsEmpty())
		{
			m_Variants = other.m_Variants;
		}
		if (m_Type == null)
		{
			m_Type = other.m_Type;
		}
		else if (m_Type.IsAssignableFrom(other.m_Type))
		{
			m_Type = other.m_Type;
		}
		bool flag = !m_Variants.IsEmpty();
		if (m_StateFormat == default(FourCC))
		{
			m_StateFormat = other.m_StateFormat;
		}
		m_CommonUsages = ArrayHelpers.Merge(other.m_CommonUsages, m_CommonUsages);
		m_AppliedOverrides.Merge(other.m_AppliedOverrides);
		if (string.IsNullOrEmpty(m_DisplayName))
		{
			m_DisplayName = other.m_DisplayName;
		}
		if (m_Controls == null)
		{
			m_Controls = other.m_Controls;
		}
		else
		{
			if (other.m_Controls == null)
			{
				return;
			}
			ControlItem[] controlItems = other.m_Controls;
			List<ControlItem> list = new List<ControlItem>();
			List<string> list2 = new List<string>();
			Dictionary<string, ControlItem> dictionary = CreateLookupTableForControls(controlItems, list2);
			foreach (KeyValuePair<string, ControlItem> item5 in CreateLookupTableForControls(m_Controls))
			{
				if (dictionary.TryGetValue(item5.Key, out var value))
				{
					ControlItem item = item5.Value.Merge(value);
					list.Add(item);
					dictionary.Remove(item5.Key);
				}
				else if (item5.Value.variants.IsEmpty() || item5.Value.variants == DefaultVariant)
				{
					bool flag2 = false;
					if (flag)
					{
						for (int i = 0; i < list2.Count; i++)
						{
							if (VariantsMatch(m_Variants.ToLower(), list2[i]))
							{
								string key = item5.Key + "@" + list2[i];
								if (dictionary.TryGetValue(key, out value))
								{
									ControlItem item2 = item5.Value.Merge(value);
									list.Add(item2);
									dictionary.Remove(key);
									flag2 = true;
								}
							}
						}
					}
					else
					{
						foreach (string item6 in list2)
						{
							string key2 = item5.Key + "@" + item6;
							if (dictionary.TryGetValue(key2, out value))
							{
								ControlItem item3 = item5.Value.Merge(value);
								list.Add(item3);
								dictionary.Remove(key2);
								flag2 = true;
							}
						}
					}
					if (!flag2)
					{
						list.Add(item5.Value);
					}
				}
				else if (dictionary.TryGetValue(item5.Value.name.ToLower(), out value))
				{
					ControlItem item4 = item5.Value.Merge(value);
					list.Add(item4);
					dictionary.Remove(item5.Value.name.ToLower());
				}
				else if (VariantsMatch(m_Variants, item5.Value.variants))
				{
					list.Add(item5.Value);
				}
			}
			if (!flag)
			{
				int count = list.Count;
				list.AddRange(dictionary.Values);
				for (int j = count; j < list.Count; j++)
				{
					ControlItem value2 = list[j];
					value2.isFirstDefinedInThisLayout = false;
					list[j] = value2;
				}
			}
			else
			{
				int count2 = list.Count;
				list.AddRange(dictionary.Values.Where((ControlItem x) => VariantsMatch(m_Variants, x.variants)));
				for (int num = count2; num < list.Count; num++)
				{
					ControlItem value3 = list[num];
					value3.isFirstDefinedInThisLayout = false;
					list[num] = value3;
				}
			}
			m_Controls = list.ToArray();
		}
	}

	private static Dictionary<string, ControlItem> CreateLookupTableForControls(ControlItem[] controlItems, List<string> variants = null)
	{
		Dictionary<string, ControlItem> dictionary = new Dictionary<string, ControlItem>();
		for (int i = 0; i < controlItems.Length; i++)
		{
			string text = controlItems[i].name.ToLower();
			InternedString internedString = controlItems[i].variants;
			if (!internedString.IsEmpty() && internedString != DefaultVariant)
			{
				if (internedString.ToString().IndexOf(";"[0]) != -1)
				{
					string[] array = internedString.ToLower().Split(";"[0]);
					foreach (string text2 in array)
					{
						variants?.Add(text2);
						text = text + "@" + text2;
						dictionary[text] = controlItems[i];
					}
					continue;
				}
				text = text + "@" + internedString.ToLower();
				variants?.Add(internedString.ToLower());
			}
			dictionary[text] = controlItems[i];
		}
		return dictionary;
	}

	internal static bool VariantsMatch(InternedString expected, InternedString actual)
	{
		return VariantsMatch(expected.ToLower(), actual.ToLower());
	}

	internal static bool VariantsMatch(string expected, string actual)
	{
		if (actual != null && StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(DefaultVariant, actual, ";"[0]))
		{
			return true;
		}
		if (expected == null)
		{
			return true;
		}
		if (actual == null)
		{
			return true;
		}
		return StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(expected, actual, ";"[0]);
	}

	internal static void ParseHeaderFieldsFromJson(string json, out InternedString name, out InlinedArray<InternedString> baseLayouts, out InputDeviceMatcher deviceMatcher)
	{
		LayoutJsonNameAndDescriptorOnly layoutJsonNameAndDescriptorOnly = JsonUtility.FromJson<LayoutJsonNameAndDescriptorOnly>(json);
		name = new InternedString(layoutJsonNameAndDescriptorOnly.name);
		baseLayouts = default;
		if (!string.IsNullOrEmpty(layoutJsonNameAndDescriptorOnly.extend))
		{
			baseLayouts.Append(new InternedString(layoutJsonNameAndDescriptorOnly.extend));
		}
		if (layoutJsonNameAndDescriptorOnly.extendMultiple != null)
		{
			string[] extendMultiple = layoutJsonNameAndDescriptorOnly.extendMultiple;
			foreach (string text in extendMultiple)
			{
				baseLayouts.Append(new InternedString(text));
			}
		}
		deviceMatcher = layoutJsonNameAndDescriptorOnly.device.ToMatcher();
	}

	internal static CacheRefInstance CacheRef()
	{
		s_CacheInstanceRef++;
		return new CacheRefInstance
		{
			valid = true
		};
	}
}
