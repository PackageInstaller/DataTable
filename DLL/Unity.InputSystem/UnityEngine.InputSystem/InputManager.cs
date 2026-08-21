using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Composites;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Interactions;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Processors;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal class InputManager
{
	internal enum DeviceDisableScope
	{
		Everywhere,
		InFrontendOnly,
		TemporaryWhilePlayerIsInBackground
	}

	[Serializable]
	internal struct AvailableDevice
	{
		public InputDeviceDescription description;

		public int deviceId;

		public bool isNative;

		public bool isRemoved;
	}

	private struct StateChangeMonitorTimeout
	{
		public InputControl control;

		public double time;

		public IInputStateChangeMonitor monitor;

		public long monitorIndex;

		public int timerIndex;
	}

	internal struct StateChangeMonitorListener
	{
		public InputControl control;

		public IInputStateChangeMonitor monitor;

		public long monitorIndex;

		public uint groupIndex;
	}

	internal struct StateChangeMonitorsForDevice
	{
		public MemoryHelpers.BitRegion[] memoryRegions;

		public StateChangeMonitorListener[] listeners;

		public DynamicBitfield signalled;

		public bool needToUpdateOrderingOfMonitors;

		public bool needToCompactArrays;

		public int count => signalled.length;

		public void Add(InputControl control, IInputStateChangeMonitor monitor, long monitorIndex, uint groupIndex)
		{
			int length = signalled.length;
			ArrayHelpers.AppendWithCapacity(ref listeners, ref length, new StateChangeMonitorListener
			{
				monitor = monitor,
				monitorIndex = monitorIndex,
				groupIndex = groupIndex,
				control = control
			});
			ref InputStateBlock stateBlock = ref control.m_StateBlock;
			int length2 = signalled.length;
			ArrayHelpers.AppendWithCapacity(ref memoryRegions, ref length2, new MemoryHelpers.BitRegion(stateBlock.byteOffset - control.device.stateBlock.byteOffset, stateBlock.bitOffset, stateBlock.sizeInBits));
			signalled.SetLength(signalled.length + 1);
			needToUpdateOrderingOfMonitors = true;
		}

		public void Remove(IInputStateChangeMonitor monitor, long monitorIndex, bool deferRemoval)
		{
			if (listeners == null)
			{
				return;
			}
			for (int i = 0; i < signalled.length; i++)
			{
				if (listeners[i].monitor == monitor && listeners[i].monitorIndex == monitorIndex)
				{
					if (deferRemoval)
					{
						listeners[i] = default(StateChangeMonitorListener);
						memoryRegions[i] = default(MemoryHelpers.BitRegion);
						signalled.ClearBit(i);
						needToCompactArrays = true;
					}
					else
					{
						RemoveAt(i);
					}
					break;
				}
			}
		}

		public void Clear()
		{
			listeners.Clear(count);
			signalled.SetLength(0);
			needToCompactArrays = false;
		}

		public void CompactArrays()
		{
			for (int num = count - 1; num >= 0; num--)
			{
				if (memoryRegions[num].sizeInBits == 0)
				{
					RemoveAt(num);
				}
			}
			needToCompactArrays = false;
		}

		private void RemoveAt(int i)
		{
			int num = count;
			int num2 = count;
			listeners.EraseAtWithCapacity(ref num, i);
			memoryRegions.EraseAtWithCapacity(ref num2, i);
			signalled.SetLength(count - 1);
		}

		public void SortMonitorsByIndex()
		{
			for (int i = 1; i < signalled.length; i++)
			{
				for (int num = i; num > 0; num--)
				{
					int complexityFromMonitorIndex = InputActionState.GetComplexityFromMonitorIndex(listeners[num - 1].monitorIndex);
					int complexityFromMonitorIndex2 = InputActionState.GetComplexityFromMonitorIndex(listeners[num].monitorIndex);
					if (complexityFromMonitorIndex >= complexityFromMonitorIndex2)
					{
						break;
					}
					listeners.SwapElements(num, num - 1);
					memoryRegions.SwapElements(num, num - 1);
				}
			}
			needToUpdateOrderingOfMonitors = false;
		}
	}

	internal int m_LayoutRegistrationVersion;

	private float m_PollingFrequency;

	internal InputControlLayout.Collection m_Layouts;

	private TypeTable m_Processors;

	private TypeTable m_Interactions;

	private TypeTable m_Composites;

	private int m_DevicesCount;

	private InputDevice[] m_Devices;

	private Dictionary<int, InputDevice> m_DevicesById;

	internal int m_AvailableDeviceCount;

	internal AvailableDevice[] m_AvailableDevices;

	internal int m_DisconnectedDevicesCount;

	internal InputDevice[] m_DisconnectedDevices;

	internal InputUpdateType m_UpdateMask;

	private InputUpdateType m_CurrentUpdate;

	internal InputStateBuffers m_StateBuffers;

	private CallbackArray<Action<InputDevice, InputDeviceChange>> m_DeviceChangeListeners;

	private CallbackArray<Action<InputDevice, InputEventPtr>> m_DeviceStateChangeListeners;

	private CallbackArray<InputDeviceFindControlLayoutDelegate> m_DeviceFindLayoutCallbacks;

	internal CallbackArray<InputDeviceCommandDelegate> m_DeviceCommandCallbacks;

	private CallbackArray<Action<string, InputControlLayoutChange>> m_LayoutChangeListeners;

	private CallbackArray<Action<InputEventPtr, InputDevice>> m_EventListeners;

	private CallbackArray<Action> m_BeforeUpdateListeners;

	private CallbackArray<Action> m_AfterUpdateListeners;

	private CallbackArray<Action> m_SettingsChangedListeners;

	private bool m_NativeBeforeUpdateHooked;

	private bool m_HaveDevicesWithStateCallbackReceivers;

	private bool m_HasFocus;

	private InputEventStream m_InputEventStream;

	private InputDeviceExecuteCommandDelegate m_DeviceFindExecuteCommandDelegate;

	private int m_DeviceFindExecuteCommandDeviceId;

	internal IInputRuntime m_Runtime;

	internal InputMetrics m_Metrics;

	internal InputSettings m_Settings;

	private bool m_ShouldMakeCurrentlyUpdatingDeviceCurrent;

	internal StateChangeMonitorsForDevice[] m_StateChangeMonitors;

	private InlinedArray<StateChangeMonitorTimeout> m_StateChangeMonitorTimeouts;

	public ReadOnlyArray<InputDevice> devices => new ReadOnlyArray<InputDevice>(m_Devices, 0, m_DevicesCount);

	public TypeTable processors => m_Processors;

	public TypeTable interactions => m_Interactions;

	public TypeTable composites => m_Composites;

	public InputMetrics metrics
	{
		get
		{
			InputMetrics result = m_Metrics;
			result.currentNumDevices = m_DevicesCount;
			result.currentStateSizeInBytes = (int)m_StateBuffers.totalSize;
			result.currentControlCount = m_DevicesCount;
			for (int i = 0; i < m_DevicesCount; i++)
			{
				result.currentControlCount += m_Devices[i].allControls.Count;
			}
			result.currentLayoutCount = m_Layouts.layoutTypes.Count;
			result.currentLayoutCount += m_Layouts.layoutStrings.Count;
			result.currentLayoutCount += m_Layouts.layoutBuilders.Count;
			result.currentLayoutCount += m_Layouts.layoutOverrides.Count;
			return result;
		}
	}

	public InputSettings settings
	{
		get
		{
			return m_Settings;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (!(m_Settings == value))
			{
				m_Settings = value;
				ApplySettings();
			}
		}
	}

	public InputUpdateType updateMask
	{
		get
		{
			return m_UpdateMask;
		}
		set
		{
			if (m_UpdateMask != value)
			{
				m_UpdateMask = value;
				if (m_DevicesCount > 0)
				{
					ReallocateStateBuffers();
				}
			}
		}
	}

	public InputUpdateType defaultUpdateType
	{
		get
		{
			if (m_CurrentUpdate != InputUpdateType.None)
			{
				return m_CurrentUpdate;
			}
			return m_UpdateMask.GetUpdateTypeForPlayer();
		}
	}

	public float pollingFrequency
	{
		get
		{
			return m_PollingFrequency;
		}
		set
		{
			if (value <= 0f)
			{
				throw new ArgumentException("Polling frequency must be greater than zero", "value");
			}
			m_PollingFrequency = value;
			if (m_Runtime != null)
			{
				m_Runtime.pollingFrequency = value;
			}
		}
	}

	public bool isProcessingEvents => m_InputEventStream.isOpen;

	private bool gameIsPlaying => true;

	private bool gameHasFocus
	{
		get
		{
			if (!m_HasFocus)
			{
				return gameShouldGetInputRegardlessOfFocus;
			}
			return true;
		}
	}

	private bool gameShouldGetInputRegardlessOfFocus => m_Settings.backgroundBehavior == InputSettings.BackgroundBehavior.IgnoreFocus;

	public event Action<InputDevice, InputDeviceChange> onDeviceChange
	{
		add
		{
			m_DeviceChangeListeners.AddCallback(value);
		}
		remove
		{
			m_DeviceChangeListeners.RemoveCallback(value);
		}
	}

	public event Action<InputDevice, InputEventPtr> onDeviceStateChange
	{
		add
		{
			m_DeviceStateChangeListeners.AddCallback(value);
		}
		remove
		{
			m_DeviceStateChangeListeners.RemoveCallback(value);
		}
	}

	public event InputDeviceCommandDelegate onDeviceCommand
	{
		add
		{
			m_DeviceCommandCallbacks.AddCallback(value);
		}
		remove
		{
			m_DeviceCommandCallbacks.RemoveCallback(value);
		}
	}

	public event InputDeviceFindControlLayoutDelegate onFindControlLayoutForDevice
	{
		add
		{
			m_DeviceFindLayoutCallbacks.AddCallback(value);
			AddAvailableDevicesThatAreNowRecognized();
		}
		remove
		{
			m_DeviceFindLayoutCallbacks.RemoveCallback(value);
		}
	}

	public event Action<string, InputControlLayoutChange> onLayoutChange
	{
		add
		{
			m_LayoutChangeListeners.AddCallback(value);
		}
		remove
		{
			m_LayoutChangeListeners.RemoveCallback(value);
		}
	}

	public event Action<InputEventPtr, InputDevice> onEvent
	{
		add
		{
			m_EventListeners.AddCallback(value);
		}
		remove
		{
			m_EventListeners.RemoveCallback(value);
		}
	}

	public event Action onBeforeUpdate
	{
		add
		{
			InstallBeforeUpdateHookIfNecessary();
			m_BeforeUpdateListeners.AddCallback(value);
		}
		remove
		{
			m_BeforeUpdateListeners.RemoveCallback(value);
		}
	}

	public event Action onAfterUpdate
	{
		add
		{
			m_AfterUpdateListeners.AddCallback(value);
		}
		remove
		{
			m_AfterUpdateListeners.RemoveCallback(value);
		}
	}

	public event Action onSettingsChange
	{
		add
		{
			m_SettingsChangedListeners.AddCallback(value);
		}
		remove
		{
			m_SettingsChangedListeners.RemoveCallback(value);
		}
	}

	public void RegisterControlLayout(string name, Type type)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		bool flag = typeof(InputDevice).IsAssignableFrom(type);
		bool flag2 = typeof(InputControl).IsAssignableFrom(type);
		if (!flag && !flag2)
		{
			throw new ArgumentException("Types used as layouts have to be InputControls or InputDevices; '" + type.Name + "' is a '" + type.BaseType.Name + "'", "type");
		}
		InternedString internedString = new InternedString(name);
		bool isReplacement = m_Layouts.HasLayout(internedString);
		m_Layouts.layoutTypes[internedString] = type;
		string text = null;
		Type baseType = type.BaseType;
		while (text == null && baseType != typeof(InputControl))
		{
			foreach (KeyValuePair<InternedString, Type> layoutType in m_Layouts.layoutTypes)
			{
				if (layoutType.Value == baseType)
				{
					text = layoutType.Key;
					break;
				}
			}
			baseType = baseType.BaseType;
		}
		PerformLayoutPostRegistration(internedString, new InlinedArray<InternedString>(new InternedString(text)), isReplacement, flag);
	}

	public void RegisterControlLayout(string json, string name = null, bool isOverride = false)
	{
		if (string.IsNullOrEmpty(json))
		{
			throw new ArgumentNullException("json");
		}
		InputControlLayout.ParseHeaderFieldsFromJson(json, out var name2, out var baseLayouts, out var deviceMatcher);
		InternedString internedString = new InternedString(name);
		if (internedString.IsEmpty())
		{
			internedString = name2;
			if (internedString.IsEmpty())
			{
				throw new ArgumentException("Layout name has not been given and is not set in JSON layout", "name");
			}
		}
		if (isOverride && baseLayouts.length == 0)
		{
			throw new ArgumentException($"Layout override '{internedString}' must have 'extend' property mentioning layout to which to apply the overrides", "json");
		}
		bool flag = m_Layouts.HasLayout(internedString);
		if ((flag & isOverride) && !m_Layouts.layoutOverrideNames.Contains(internedString))
		{
			throw new ArgumentException($"Failed to register layout override '{internedString}'" + $"since a layout named '{internedString}' already exist. Layout overrides must " + "have unique names with respect to existing layouts.");
		}
		m_Layouts.layoutStrings[internedString] = json;
		if (isOverride)
		{
			m_Layouts.layoutOverrideNames.Add(internedString);
			for (int i = 0; i < baseLayouts.length; i++)
			{
				InternedString key = baseLayouts[i];
				m_Layouts.layoutOverrides.TryGetValue(key, out var value);
				if (!flag)
				{
					ArrayHelpers.Append(ref value, internedString);
				}
				m_Layouts.layoutOverrides[key] = value;
			}
		}
		PerformLayoutPostRegistration(internedString, baseLayouts, flag, isKnownToBeDeviceLayout: false, isOverride);
		if (!deviceMatcher.empty)
		{
			RegisterControlLayoutMatcher(internedString, deviceMatcher);
		}
	}

	public void RegisterControlLayoutBuilder(Func<InputControlLayout> method, string name, string baseLayout = null)
	{
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		InternedString internedString = new InternedString(name);
		InternedString value = new InternedString(baseLayout);
		bool isReplacement = m_Layouts.HasLayout(internedString);
		m_Layouts.layoutBuilders[internedString] = method;
		PerformLayoutPostRegistration(internedString, new InlinedArray<InternedString>(value), isReplacement);
	}

	private void PerformLayoutPostRegistration(InternedString layoutName, InlinedArray<InternedString> baseLayouts, bool isReplacement, bool isKnownToBeDeviceLayout = false, bool isOverride = false)
	{
		m_LayoutRegistrationVersion++;
		InputControlLayout.s_CacheInstance.Clear();
		if (!isOverride && baseLayouts.length > 0)
		{
			if (baseLayouts.length > 1)
			{
				throw new NotSupportedException($"Layout '{layoutName}' has multiple base layouts; this is only supported on layout overrides");
			}
			InternedString value = baseLayouts[0];
			if (!value.IsEmpty())
			{
				m_Layouts.baseLayoutTable[layoutName] = value;
			}
		}
		m_Layouts.precompiledLayouts.Remove(layoutName);
		if (m_Layouts.precompiledLayouts.Count > 0)
		{
			InternedString[] array = m_Layouts.precompiledLayouts.Keys.ToArray();
			foreach (InternedString internedString in array)
			{
				string metadata = m_Layouts.precompiledLayouts[internedString].metadata;
				if (isOverride)
				{
					for (int j = 0; j < baseLayouts.length; j++)
					{
						if (internedString == baseLayouts[j] || StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(metadata, baseLayouts[j], ';'))
						{
							m_Layouts.precompiledLayouts.Remove(internedString);
						}
					}
				}
				else if (StringHelpers.CharacterSeparatedListsHaveAtLeastOneCommonElement(metadata, layoutName, ';'))
				{
					m_Layouts.precompiledLayouts.Remove(internedString);
				}
			}
		}
		if (isOverride)
		{
			for (int k = 0; k < baseLayouts.length; k++)
			{
				RecreateDevicesUsingLayout(baseLayouts[k], isKnownToBeDeviceLayout);
			}
		}
		else
		{
			RecreateDevicesUsingLayout(layoutName, isKnownToBeDeviceLayout);
		}
		InputControlLayoutChange argument = (isReplacement ? InputControlLayoutChange.Replaced : InputControlLayoutChange.Added);
		DelegateHelpers.InvokeCallbacksSafe(ref m_LayoutChangeListeners, layoutName.ToString(), argument, "InputSystem.onLayoutChange");
	}

	public void RegisterPrecompiledLayout<TDevice>(string metadata) where TDevice : InputDevice, new()
	{
		if (metadata == null)
		{
			throw new ArgumentNullException("metadata");
		}
		Type baseType = typeof(TDevice).BaseType;
		InternedString key = FindOrRegisterDeviceLayoutForType(baseType);
		m_Layouts.precompiledLayouts[key] = new InputControlLayout.Collection.PrecompiledLayout
		{
			factoryMethod = () => new TDevice(),
			metadata = metadata
		};
	}

	private void RecreateDevicesUsingLayout(InternedString layout, bool isKnownToBeDeviceLayout = false)
	{
		if (m_DevicesCount == 0)
		{
			return;
		}
		List<InputDevice> list = null;
		for (int i = 0; i < m_DevicesCount; i++)
		{
			InputDevice inputDevice = m_Devices[i];
			if ((!isKnownToBeDeviceLayout) ? IsControlOrChildUsingLayoutRecursive(inputDevice, layout) : IsControlUsingLayout(inputDevice, layout))
			{
				if (list == null)
				{
					list = new List<InputDevice>();
				}
				list.Add(inputDevice);
			}
		}
		if (list == null)
		{
			return;
		}
		using (InputDeviceBuilder.Ref())
		{
			for (int j = 0; j < list.Count; j++)
			{
				InputDevice inputDevice2 = list[j];
				RecreateDevice(inputDevice2, inputDevice2.m_Layout);
			}
		}
	}

	private bool IsControlOrChildUsingLayoutRecursive(InputControl control, InternedString layout)
	{
		if (IsControlUsingLayout(control, layout))
		{
			return true;
		}
		ReadOnlyArray<InputControl> children = control.children;
		for (int i = 0; i < children.Count; i++)
		{
			if (IsControlOrChildUsingLayoutRecursive(children[i], layout))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsControlUsingLayout(InputControl control, InternedString layout)
	{
		if (control.layout == layout)
		{
			return true;
		}
		InternedString value = control.m_Layout;
		while (m_Layouts.baseLayoutTable.TryGetValue(value, out value))
		{
			if (value == layout)
			{
				return true;
			}
		}
		return false;
	}

	public void RegisterControlLayoutMatcher(string layoutName, InputDeviceMatcher matcher)
	{
		if (string.IsNullOrEmpty(layoutName))
		{
			throw new ArgumentNullException("layoutName");
		}
		if (matcher.empty)
		{
			throw new ArgumentException("Matcher cannot be empty", "matcher");
		}
		InternedString layout = new InternedString(layoutName);
		m_Layouts.AddMatcher(layout, matcher);
		RecreateDevicesUsingLayoutWithInferiorMatch(matcher);
		AddAvailableDevicesMatchingDescription(matcher, layout);
	}

	public void RegisterControlLayoutMatcher(Type type, InputDeviceMatcher matcher)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (matcher.empty)
		{
			throw new ArgumentException("Matcher cannot be empty", "matcher");
		}
		InternedString internedString = m_Layouts.TryFindLayoutForType(type);
		if (internedString.IsEmpty())
		{
			throw new ArgumentException("Type '" + type.Name + "' has not been registered as a control layout", "type");
		}
		RegisterControlLayoutMatcher(internedString, matcher);
	}

	private void RecreateDevicesUsingLayoutWithInferiorMatch(InputDeviceMatcher deviceMatcher)
	{
		if (m_DevicesCount == 0)
		{
			return;
		}
		using (InputDeviceBuilder.Ref())
		{
			int num = m_DevicesCount;
			for (int i = 0; i < num; i++)
			{
				InputDevice inputDevice = m_Devices[i];
				InputDeviceDescription deviceDescription = inputDevice.description;
				if (!deviceDescription.empty && deviceMatcher.MatchPercentage(deviceDescription) > 0f)
				{
					InternedString internedString = TryFindMatchingControlLayout(ref deviceDescription, inputDevice.deviceId);
					if (internedString != inputDevice.m_Layout)
					{
						inputDevice.m_Description = deviceDescription;
						RecreateDevice(inputDevice, internedString);
						i--;
						num--;
					}
				}
			}
		}
	}

	private void RecreateDevice(InputDevice oldDevice, InternedString newLayout)
	{
		RemoveDevice(oldDevice, keepOnListOfAvailableDevices: true);
		InputDevice inputDevice = InputDevice.Build<InputDevice>(newLayout, oldDevice.m_Variants, oldDevice.m_Description);
		inputDevice.m_DeviceId = oldDevice.m_DeviceId;
		inputDevice.m_Description = oldDevice.m_Description;
		if (oldDevice.native)
		{
			inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.Native;
		}
		if (oldDevice.remote)
		{
			inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.Remote;
		}
		if (!oldDevice.enabled)
		{
			inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.DisabledStateHasBeenQueriedFromRuntime;
			inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.DisabledInFrontend;
		}
		AddDevice(inputDevice);
	}

	private void AddAvailableDevicesMatchingDescription(InputDeviceMatcher matcher, InternedString layout)
	{
		for (int i = 0; i < m_AvailableDeviceCount; i++)
		{
			if (m_AvailableDevices[i].isRemoved)
			{
				continue;
			}
			int deviceId = m_AvailableDevices[i].deviceId;
			if (TryGetDeviceById(deviceId) == null && matcher.MatchPercentage(m_AvailableDevices[i].description) > 0f)
			{
				try
				{
					AddDevice(layout, deviceId, null, m_AvailableDevices[i].description, m_AvailableDevices[i].isNative ? InputDevice.DeviceFlags.Native : ((InputDevice.DeviceFlags)0));
				}
				catch (Exception ex)
				{
					Debug.LogError($"Layout '{layout}' matches existing device '{m_AvailableDevices[i].description}' but failed to instantiate: {ex}");
					Debug.LogException(ex);
					continue;
				}
				EnableDeviceCommand command = EnableDeviceCommand.Create();
				m_Runtime.DeviceCommand(deviceId, ref command);
			}
		}
	}

	public void RemoveControlLayout(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		InternedString internedString = new InternedString(name);
		int num = 0;
		while (num < m_DevicesCount)
		{
			InputDevice inputDevice = m_Devices[num];
			if (IsControlOrChildUsingLayoutRecursive(inputDevice, internedString))
			{
				RemoveDevice(inputDevice, keepOnListOfAvailableDevices: true);
			}
			else
			{
				num++;
			}
		}
		m_Layouts.layoutTypes.Remove(internedString);
		m_Layouts.layoutStrings.Remove(internedString);
		m_Layouts.layoutBuilders.Remove(internedString);
		m_Layouts.baseLayoutTable.Remove(internedString);
		m_LayoutRegistrationVersion++;
		DelegateHelpers.InvokeCallbacksSafe(ref m_LayoutChangeListeners, name, InputControlLayoutChange.Removed, "InputSystem.onLayoutChange");
	}

	public InputControlLayout TryLoadControlLayout(Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!typeof(InputControl).IsAssignableFrom(type))
		{
			throw new ArgumentException("Type '" + type.Name + "' is not an InputControl", "type");
		}
		InternedString name = m_Layouts.TryFindLayoutForType(type);
		if (name.IsEmpty())
		{
			throw new ArgumentException("Type '" + type.Name + "' has not been registered as a control layout", "type");
		}
		return m_Layouts.TryLoadLayout(name);
	}

	public InputControlLayout TryLoadControlLayout(InternedString name)
	{
		return m_Layouts.TryLoadLayout(name);
	}

	public InternedString TryFindMatchingControlLayout(ref InputDeviceDescription deviceDescription, int deviceId = 0)
	{
		InternedString internedString = m_Layouts.TryFindMatchingLayout(deviceDescription);
		if (internedString.IsEmpty() && !string.IsNullOrEmpty(deviceDescription.deviceClass))
		{
			InternedString layoutName = new InternedString(deviceDescription.deviceClass);
			Type controlTypeForLayout = m_Layouts.GetControlTypeForLayout(layoutName);
			if (controlTypeForLayout != null && typeof(InputDevice).IsAssignableFrom(controlTypeForLayout))
			{
				internedString = new InternedString(deviceDescription.deviceClass);
			}
		}
		if (m_DeviceFindLayoutCallbacks.length > 0)
		{
			if (m_DeviceFindExecuteCommandDelegate == null)
			{
				m_DeviceFindExecuteCommandDelegate = delegate(ref InputDeviceCommand commandRef)
				{
					return (m_DeviceFindExecuteCommandDeviceId == 0) ? (-1) : m_Runtime.DeviceCommand(m_DeviceFindExecuteCommandDeviceId, ref commandRef);
				};
			}
			m_DeviceFindExecuteCommandDeviceId = deviceId;
			bool flag = false;
			m_DeviceFindLayoutCallbacks.LockForChanges();
			for (int num = 0; num < m_DeviceFindLayoutCallbacks.length; num++)
			{
				try
				{
					string text = m_DeviceFindLayoutCallbacks[num](ref deviceDescription, internedString, m_DeviceFindExecuteCommandDelegate);
					if (!string.IsNullOrEmpty(text) && !flag)
					{
						internedString = new InternedString(text);
						flag = true;
					}
				}
				catch (Exception ex)
				{
					Debug.LogError(ex.GetType().Name + " while executing 'InputSystem.onFindLayoutForDevice' callbacks");
					Debug.LogException(ex);
				}
			}
			m_DeviceFindLayoutCallbacks.UnlockForChanges();
		}
		return internedString;
	}

	private InternedString FindOrRegisterDeviceLayoutForType(Type type)
	{
		InternedString result = m_Layouts.TryFindLayoutForType(type);
		if (result.IsEmpty() && result.IsEmpty())
		{
			result = new InternedString(type.Name);
			RegisterControlLayout(type.Name, type);
		}
		return result;
	}

	private bool IsDeviceLayoutMarkedAsSupportedInSettings(InternedString layoutName)
	{
		ReadOnlyArray<string> supportedDevices = m_Settings.supportedDevices;
		if (supportedDevices.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < supportedDevices.Count; i++)
		{
			InternedString internedString = new InternedString(supportedDevices[i]);
			if (layoutName == internedString || m_Layouts.IsBasedOn(internedString, layoutName))
			{
				return true;
			}
		}
		return false;
	}

	public IEnumerable<string> ListControlLayouts(string basedOn = null)
	{
		if (!string.IsNullOrEmpty(basedOn))
		{
			InternedString internedBasedOn = new InternedString(basedOn);
			foreach (KeyValuePair<InternedString, Type> layoutType in m_Layouts.layoutTypes)
			{
				if (m_Layouts.IsBasedOn(internedBasedOn, layoutType.Key))
				{
					yield return layoutType.Key;
				}
			}
			foreach (KeyValuePair<InternedString, string> layoutString in m_Layouts.layoutStrings)
			{
				if (m_Layouts.IsBasedOn(internedBasedOn, layoutString.Key))
				{
					yield return layoutString.Key;
				}
			}
			foreach (KeyValuePair<InternedString, Func<InputControlLayout>> layoutBuilder in m_Layouts.layoutBuilders)
			{
				if (m_Layouts.IsBasedOn(internedBasedOn, layoutBuilder.Key))
				{
					yield return layoutBuilder.Key;
				}
			}
			yield break;
		}
		foreach (KeyValuePair<InternedString, Type> layoutType2 in m_Layouts.layoutTypes)
		{
			yield return layoutType2.Key;
		}
		foreach (KeyValuePair<InternedString, string> layoutString2 in m_Layouts.layoutStrings)
		{
			yield return layoutString2.Key;
		}
		foreach (KeyValuePair<InternedString, Func<InputControlLayout>> layoutBuilder2 in m_Layouts.layoutBuilders)
		{
			yield return layoutBuilder2.Key;
		}
	}

	public int GetControls<TControl>(string path, ref InputControlList<TControl> controls) where TControl : InputControl
	{
		if (string.IsNullOrEmpty(path))
		{
			return 0;
		}
		if (m_DevicesCount == 0)
		{
			return 0;
		}
		int devicesCount = m_DevicesCount;
		int num = 0;
		for (int i = 0; i < devicesCount; i++)
		{
			InputDevice control = m_Devices[i];
			num += InputControlPath.TryFindControls(control, path, 0, ref controls);
		}
		return num;
	}

	public void SetDeviceUsage(InputDevice device, InternedString usage)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if ((device.usages.Count != 1 || !(device.usages[0] == usage)) && (device.usages.Count != 0 || !usage.IsEmpty()))
		{
			device.ClearDeviceUsages();
			if (!usage.IsEmpty())
			{
				device.AddDeviceUsage(usage);
			}
			NotifyUsageChanged(device);
		}
	}

	public void AddDeviceUsage(InputDevice device, InternedString usage)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (usage.IsEmpty())
		{
			throw new ArgumentException("Usage string cannot be empty", "usage");
		}
		if (!device.usages.Contains(usage))
		{
			device.AddDeviceUsage(usage);
			NotifyUsageChanged(device);
		}
	}

	public void RemoveDeviceUsage(InputDevice device, InternedString usage)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (usage.IsEmpty())
		{
			throw new ArgumentException("Usage string cannot be empty", "usage");
		}
		if (device.usages.Contains(usage))
		{
			device.RemoveDeviceUsage(usage);
			NotifyUsageChanged(device);
		}
	}

	private void NotifyUsageChanged(InputDevice device)
	{
		InputActionState.OnDeviceChange(device, InputDeviceChange.UsageChanged);
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, device, InputDeviceChange.UsageChanged, "InputSystem.onDeviceChange");
		device.MakeCurrent();
	}

	public InputDevice AddDevice(Type type, string name = null)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		InternedString internedString = FindOrRegisterDeviceLayoutForType(type);
		return AddDevice(internedString, name);
	}

	public InputDevice AddDevice(string layout, string name = null, InternedString variants = default(InternedString))
	{
		if (string.IsNullOrEmpty(layout))
		{
			throw new ArgumentNullException("layout");
		}
		InputDevice inputDevice = InputDevice.Build<InputDevice>(layout, variants);
		if (!string.IsNullOrEmpty(name))
		{
			inputDevice.m_Name = new InternedString(name);
		}
		AddDevice(inputDevice);
		return inputDevice;
	}

	private InputDevice AddDevice(InternedString layout, int deviceId, string deviceName = null, InputDeviceDescription deviceDescription = default(InputDeviceDescription), InputDevice.DeviceFlags deviceFlags = (InputDevice.DeviceFlags)0, InternedString variants = default(InternedString))
	{
		InputDevice inputDevice = InputDevice.Build<InputDevice>(new InternedString(layout), deviceDescription: deviceDescription, layoutVariants: variants);
		inputDevice.m_DeviceId = deviceId;
		inputDevice.m_Description = deviceDescription;
		inputDevice.m_DeviceFlags |= deviceFlags;
		if (!string.IsNullOrEmpty(deviceName))
		{
			inputDevice.m_Name = new InternedString(deviceName);
		}
		if (!string.IsNullOrEmpty(deviceDescription.product))
		{
			inputDevice.m_DisplayName = deviceDescription.product;
		}
		AddDevice(inputDevice);
		return inputDevice;
	}

	public void AddDevice(InputDevice device)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (string.IsNullOrEmpty(device.layout))
		{
			throw new InvalidOperationException("Device has no associated layout");
		}
		if (ArrayHelpers.Contains(m_Devices, device))
		{
			return;
		}
		MakeDeviceNameUnique(device);
		AssignUniqueDeviceId(device);
		device.m_DeviceIndex = ArrayHelpers.AppendWithCapacity(ref m_Devices, ref m_DevicesCount, device);
		m_DevicesById[device.deviceId] = device;
		device.m_StateBlock.byteOffset = uint.MaxValue;
		ReallocateStateBuffers();
		InitializeDeviceState(device);
		m_Metrics.maxNumDevices = Mathf.Max(m_DevicesCount, m_Metrics.maxNumDevices);
		m_Metrics.maxStateSizeInBytes = Mathf.Max((int)m_StateBuffers.totalSize, m_Metrics.maxStateSizeInBytes);
		for (int i = 0; i < m_AvailableDeviceCount; i++)
		{
			if (m_AvailableDevices[i].deviceId == device.deviceId)
			{
				m_AvailableDevices[i].isRemoved = false;
			}
		}
		if (true && !gameHasFocus && m_Settings.backgroundBehavior != InputSettings.BackgroundBehavior.IgnoreFocus && m_Runtime.runInBackground && device.QueryEnabledStateFromRuntime() && !ShouldRunDeviceInBackground(device))
		{
			EnableOrDisableDevice(device, enable: false, DeviceDisableScope.TemporaryWhilePlayerIsInBackground);
		}
		InputActionState.OnDeviceChange(device, InputDeviceChange.Added);
		if (device is IInputUpdateCallbackReceiver inputUpdateCallbackReceiver)
		{
			onBeforeUpdate += inputUpdateCallbackReceiver.OnUpdate;
		}
		if (device is IInputStateCallbackReceiver)
		{
			InstallBeforeUpdateHookIfNecessary();
			device.m_DeviceFlags |= InputDevice.DeviceFlags.HasStateCallbacks;
			m_HaveDevicesWithStateCallbackReceivers = true;
		}
		if (device is IEventMerger)
		{
			device.hasEventMerger = true;
		}
		if (device is IEventPreProcessor)
		{
			device.hasEventPreProcessor = true;
		}
		if (device.updateBeforeRender)
		{
			updateMask |= InputUpdateType.BeforeRender;
		}
		device.NotifyAdded();
		device.MakeCurrent();
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, device, InputDeviceChange.Added, "InputSystem.onDeviceChange");
		if (device.enabled)
		{
			device.RequestSync();
		}
		device.SetOptimizedControlDataTypeRecursively();
	}

	public InputDevice AddDevice(InputDeviceDescription description)
	{
		return AddDevice(description, throwIfNoLayoutFound: true);
	}

	public InputDevice AddDevice(InputDeviceDescription description, bool throwIfNoLayoutFound, string deviceName = null, int deviceId = 0, InputDevice.DeviceFlags deviceFlags = (InputDevice.DeviceFlags)0)
	{
		InternedString layout = TryFindMatchingControlLayout(ref description, deviceId);
		if (layout.IsEmpty())
		{
			if (throwIfNoLayoutFound)
			{
				throw new ArgumentException($"Cannot find layout matching device description '{description}'", "description");
			}
			if (deviceId != 0)
			{
				DisableDeviceCommand command = DisableDeviceCommand.Create();
				m_Runtime.DeviceCommand(deviceId, ref command);
			}
			return null;
		}
		InputDevice inputDevice = AddDevice(layout, deviceId, deviceName, description, deviceFlags);
		inputDevice.m_Description = description;
		return inputDevice;
	}

	public InputDevice AddDevice(InputDeviceDescription description, InternedString layout, string deviceName = null, int deviceId = 0, InputDevice.DeviceFlags deviceFlags = (InputDevice.DeviceFlags)0)
	{
		try
		{
			InputDevice inputDevice = AddDevice(layout, deviceId, deviceName, description, deviceFlags);
			inputDevice.m_Description = description;
			return inputDevice;
		}
		finally
		{
		}
	}

	public void RemoveDevice(InputDevice device, bool keepOnListOfAvailableDevices = false)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (device.m_DeviceIndex == -1)
		{
			return;
		}
		RemoveStateChangeMonitors(device);
		int deviceIndex = device.m_DeviceIndex;
		int deviceId = device.deviceId;
		if (deviceIndex < m_StateChangeMonitors.LengthSafe())
		{
			int count = m_StateChangeMonitors.Length;
			m_StateChangeMonitors.EraseAtWithCapacity(ref count, deviceIndex);
		}
		m_Devices.EraseAtWithCapacity(ref m_DevicesCount, deviceIndex);
		m_DevicesById.Remove(deviceId);
		if (m_Devices != null)
		{
			ReallocateStateBuffers();
		}
		else
		{
			m_StateBuffers.FreeAll();
		}
		for (int i = deviceIndex; i < m_DevicesCount; i++)
		{
			m_Devices[i].m_DeviceIndex--;
		}
		device.m_DeviceIndex = -1;
		for (int j = 0; j < m_AvailableDeviceCount; j++)
		{
			if (m_AvailableDevices[j].deviceId == deviceId)
			{
				if (keepOnListOfAvailableDevices)
				{
					m_AvailableDevices[j].isRemoved = true;
				}
				else
				{
					m_AvailableDevices.EraseAtWithCapacity(ref m_AvailableDeviceCount, j);
				}
				break;
			}
		}
		device.BakeOffsetIntoStateBlockRecursive((uint)(0uL - (ulong)device.m_StateBlock.byteOffset));
		InputActionState.OnDeviceChange(device, InputDeviceChange.Removed);
		if (device is IInputUpdateCallbackReceiver inputUpdateCallbackReceiver)
		{
			onBeforeUpdate -= inputUpdateCallbackReceiver.OnUpdate;
		}
		if (device.updateBeforeRender)
		{
			bool flag = false;
			for (int k = 0; k < m_DevicesCount; k++)
			{
				if (m_Devices[k].updateBeforeRender)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				updateMask &= ~InputUpdateType.BeforeRender;
			}
		}
		device.NotifyRemoved();
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, device, InputDeviceChange.Removed, "InputSystem.onDeviceChange");
		InputSystem.GetDevice(device.GetType())?.MakeCurrent();
	}

	public void FlushDisconnectedDevices()
	{
		m_DisconnectedDevices.Clear(m_DisconnectedDevicesCount);
		m_DisconnectedDevicesCount = 0;
	}

	public unsafe void ResetDevice(InputDevice device, bool alsoResetDontResetControls = false, bool? issueResetCommand = null)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (!device.added)
		{
			throw new InvalidOperationException($"Device '{device}' has not been added to the system");
		}
		bool flag = alsoResetDontResetControls || !device.hasDontResetControls;
		InputDeviceChange inputDeviceChange = (flag ? InputDeviceChange.HardReset : InputDeviceChange.SoftReset);
		InputActionState.OnDeviceChange(device, inputDeviceChange);
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, device, inputDeviceChange, "onDeviceChange");
		if (!alsoResetDontResetControls && device is ICustomDeviceReset customDeviceReset)
		{
			customDeviceReset.Reset();
		}
		else
		{
			void* defaultStatePtr = device.defaultStatePtr;
			uint alignedSizeInBytes = device.stateBlock.alignedSizeInBytes;
			using NativeArray<byte> nativeArray = new NativeArray<byte>((int)(24 + alignedSizeInBytes), Allocator.Temp);
			StateEvent* unsafePtr = (StateEvent*)nativeArray.GetUnsafePtr();
			void* state = unsafePtr->state;
			double currentTime = m_Runtime.currentTime;
			ref InputStateBlock stateBlock = ref device.m_StateBlock;
			unsafePtr->baseEvent.type = 1398030676;
			unsafePtr->baseEvent.sizeInBytes = 24 + alignedSizeInBytes;
			unsafePtr->baseEvent.time = currentTime;
			unsafePtr->baseEvent.deviceId = device.deviceId;
			unsafePtr->baseEvent.eventId = -1;
			unsafePtr->stateFormat = device.m_StateBlock.format;
			if (flag)
			{
				UnsafeUtility.MemCpy(state, (byte*)defaultStatePtr + stateBlock.byteOffset, alignedSizeInBytes);
			}
			else
			{
				void* currentStatePtr = device.currentStatePtr;
				void* resetMaskBuffer = m_StateBuffers.resetMaskBuffer;
				UnsafeUtility.MemCpy(state, (byte*)currentStatePtr + stateBlock.byteOffset, alignedSizeInBytes);
				MemoryHelpers.MemCpyMasked(state, (byte*)defaultStatePtr + stateBlock.byteOffset, (int)alignedSizeInBytes, (byte*)resetMaskBuffer + stateBlock.byteOffset);
			}
			UpdateState(device, defaultUpdateType, state, 0u, alignedSizeInBytes, currentTime, new InputEventPtr((InputEvent*)unsafePtr));
		}
		bool flag2 = flag;
		if (issueResetCommand.HasValue)
		{
			flag2 = issueResetCommand.Value;
		}
		if (flag2)
		{
			device.RequestReset();
		}
	}

	public InputDevice TryGetDevice(string nameOrLayout)
	{
		if (string.IsNullOrEmpty(nameOrLayout))
		{
			throw new ArgumentException("Name is null or empty.", "nameOrLayout");
		}
		if (m_DevicesCount == 0)
		{
			return null;
		}
		string text = nameOrLayout.ToLower();
		for (int i = 0; i < m_DevicesCount; i++)
		{
			InputDevice inputDevice = m_Devices[i];
			if (inputDevice.m_Name.ToLower() == text || inputDevice.m_Layout.ToLower() == text)
			{
				return inputDevice;
			}
		}
		return null;
	}

	public InputDevice GetDevice(string nameOrLayout)
	{
		return TryGetDevice(nameOrLayout) ?? throw new ArgumentException("Cannot find device with name or layout '" + nameOrLayout + "'", "nameOrLayout");
	}

	public InputDevice TryGetDevice(Type layoutType)
	{
		InternedString internedString = m_Layouts.TryFindLayoutForType(layoutType);
		if (internedString.IsEmpty())
		{
			return null;
		}
		return TryGetDevice(internedString);
	}

	public InputDevice TryGetDeviceById(int id)
	{
		if (m_DevicesById.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public int GetUnsupportedDevices(List<InputDeviceDescription> descriptions)
	{
		if (descriptions == null)
		{
			throw new ArgumentNullException("descriptions");
		}
		int num = 0;
		for (int i = 0; i < m_AvailableDeviceCount; i++)
		{
			if (TryGetDeviceById(m_AvailableDevices[i].deviceId) == null)
			{
				descriptions.Add(m_AvailableDevices[i].description);
				num++;
			}
		}
		return num;
	}

	public void EnableOrDisableDevice(InputDevice device, bool enable, DeviceDisableScope scope = DeviceDisableScope.Everywhere)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (enable)
		{
			switch (scope)
			{
			case DeviceDisableScope.Everywhere:
				device.disabledWhileInBackground = false;
				if (!device.disabledInFrontend && !device.disabledInRuntime)
				{
					return;
				}
				if (device.disabledInRuntime)
				{
					device.ExecuteEnableCommand();
					device.disabledInRuntime = false;
				}
				if (device.disabledInFrontend)
				{
					if (!device.RequestSync())
					{
						ResetDevice(device);
					}
					device.disabledInFrontend = false;
				}
				break;
			case DeviceDisableScope.InFrontendOnly:
				device.disabledWhileInBackground = false;
				if (!device.disabledInFrontend && device.disabledInRuntime)
				{
					return;
				}
				if (!device.disabledInRuntime)
				{
					device.ExecuteDisableCommand();
					device.disabledInRuntime = true;
				}
				if (device.disabledInFrontend)
				{
					if (!device.RequestSync())
					{
						ResetDevice(device);
					}
					device.disabledInFrontend = false;
				}
				break;
			case DeviceDisableScope.TemporaryWhilePlayerIsInBackground:
				if (device.disabledWhileInBackground)
				{
					if (device.disabledInRuntime)
					{
						device.ExecuteEnableCommand();
						device.disabledInRuntime = false;
					}
					if (!device.RequestSync())
					{
						ResetDevice(device);
					}
					device.disabledWhileInBackground = false;
				}
				break;
			}
		}
		else
		{
			switch (scope)
			{
			case DeviceDisableScope.Everywhere:
				device.disabledWhileInBackground = false;
				if (device.disabledInFrontend && device.disabledInRuntime)
				{
					return;
				}
				if (!device.disabledInRuntime)
				{
					device.ExecuteDisableCommand();
					device.disabledInRuntime = true;
				}
				if (!device.disabledInFrontend)
				{
					ResetDevice(device, alsoResetDontResetControls: false, false);
					device.disabledInFrontend = true;
				}
				break;
			case DeviceDisableScope.InFrontendOnly:
				device.disabledWhileInBackground = false;
				if (!device.disabledInRuntime && device.disabledInFrontend)
				{
					return;
				}
				if (device.disabledInRuntime)
				{
					device.ExecuteEnableCommand();
					device.disabledInRuntime = false;
				}
				if (!device.disabledInFrontend)
				{
					ResetDevice(device, alsoResetDontResetControls: false, false);
					device.disabledInFrontend = true;
				}
				break;
			case DeviceDisableScope.TemporaryWhilePlayerIsInBackground:
				if (device.disabledInFrontend || device.disabledWhileInBackground)
				{
					return;
				}
				device.disabledWhileInBackground = true;
				ResetDevice(device, alsoResetDontResetControls: false, false);
				device.ExecuteDisableCommand();
				device.disabledInRuntime = true;
				break;
			}
		}
		InputDeviceChange argument = (enable ? InputDeviceChange.Enabled : InputDeviceChange.Disabled);
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, device, argument, "InputSystem.onDeviceChange");
	}

	private unsafe void QueueEvent(InputEvent* eventPtr)
	{
		if (m_InputEventStream.isOpen)
		{
			m_InputEventStream.Write(eventPtr);
		}
		else
		{
			m_Runtime.QueueEvent(eventPtr);
		}
	}

	public unsafe void QueueEvent(InputEventPtr ptr)
	{
		QueueEvent(ptr.data);
	}

	public unsafe void QueueEvent<TEvent>(ref TEvent inputEvent) where TEvent : struct, IInputEventTypeInfo
	{
		QueueEvent((InputEvent*)UnsafeUtility.AddressOf(ref inputEvent));
	}

	public void Update()
	{
		Update(defaultUpdateType);
	}

	public void Update(InputUpdateType updateType)
	{
		m_Runtime.Update(updateType);
	}

	internal void Initialize(IInputRuntime runtime, InputSettings settings)
	{
		m_Settings = settings;
		InitializeData();
		InstallRuntime(runtime);
		InstallGlobals();
		ApplySettings();
	}

	internal void Destroy()
	{
		for (int i = 0; i < m_DevicesCount; i++)
		{
			m_Devices[i].NotifyRemoved();
		}
		m_StateBuffers.FreeAll();
		UninstallGlobals();
		if (m_Settings != null && m_Settings.hideFlags == HideFlags.HideAndDontSave)
		{
			Object.DestroyImmediate(m_Settings);
		}
	}

	internal void InitializeData()
	{
		m_Layouts.Allocate();
		m_Processors.Initialize();
		m_Interactions.Initialize();
		m_Composites.Initialize();
		m_DevicesById = new Dictionary<int, InputDevice>();
		m_UpdateMask = InputUpdateType.Dynamic | InputUpdateType.Fixed;
		m_HasFocus = Application.isFocused;
		m_PollingFrequency = 60f;
		RegisterControlLayout("Axis", typeof(AxisControl));
		RegisterControlLayout("Button", typeof(ButtonControl));
		RegisterControlLayout("DiscreteButton", typeof(DiscreteButtonControl));
		RegisterControlLayout("Key", typeof(KeyControl));
		RegisterControlLayout("Analog", typeof(AxisControl));
		RegisterControlLayout("Integer", typeof(IntegerControl));
		RegisterControlLayout("Digital", typeof(IntegerControl));
		RegisterControlLayout("Double", typeof(DoubleControl));
		RegisterControlLayout("Vector2", typeof(Vector2Control));
		RegisterControlLayout("Vector3", typeof(Vector3Control));
		RegisterControlLayout("Delta", typeof(DeltaControl));
		RegisterControlLayout("Quaternion", typeof(QuaternionControl));
		RegisterControlLayout("Stick", typeof(StickControl));
		RegisterControlLayout("Dpad", typeof(DpadControl));
		RegisterControlLayout("DpadAxis", typeof(DpadControl.DpadAxisControl));
		RegisterControlLayout("AnyKey", typeof(AnyKeyControl));
		RegisterControlLayout("Touch", typeof(TouchControl));
		RegisterControlLayout("TouchPhase", typeof(TouchPhaseControl));
		RegisterControlLayout("TouchPress", typeof(TouchPressControl));
		RegisterControlLayout("Gamepad", typeof(Gamepad));
		RegisterControlLayout("Joystick", typeof(Joystick));
		RegisterControlLayout("Keyboard", typeof(Keyboard));
		RegisterControlLayout("Pointer", typeof(Pointer));
		RegisterControlLayout("Mouse", typeof(Mouse));
		RegisterControlLayout("Pen", typeof(Pen));
		RegisterControlLayout("Touchscreen", typeof(Touchscreen));
		RegisterControlLayout("Sensor", typeof(Sensor));
		RegisterControlLayout("Accelerometer", typeof(Accelerometer));
		RegisterControlLayout("Gyroscope", typeof(Gyroscope));
		RegisterControlLayout("GravitySensor", typeof(GravitySensor));
		RegisterControlLayout("AttitudeSensor", typeof(AttitudeSensor));
		RegisterControlLayout("LinearAccelerationSensor", typeof(LinearAccelerationSensor));
		RegisterControlLayout("MagneticFieldSensor", typeof(MagneticFieldSensor));
		RegisterControlLayout("LightSensor", typeof(LightSensor));
		RegisterControlLayout("PressureSensor", typeof(PressureSensor));
		RegisterControlLayout("HumiditySensor", typeof(HumiditySensor));
		RegisterControlLayout("AmbientTemperatureSensor", typeof(AmbientTemperatureSensor));
		RegisterControlLayout("StepCounter", typeof(StepCounter));
		RegisterControlLayout("TrackedDevice", typeof(TrackedDevice));
		RegisterPrecompiledLayout<FastKeyboard>(";AnyKey;Button;Axis;Key;DiscreteButton;Keyboard");
		RegisterPrecompiledLayout<FastTouchscreen>("AutoWindowSpace;Touch;Vector2;Delta;Analog;TouchPress;Button;Axis;Integer;TouchPhase;Double;Touchscreen;Pointer");
		RegisterPrecompiledLayout<FastMouse>("AutoWindowSpace;Vector2;Delta;Button;Axis;Digital;Integer;Mouse;Pointer");
		processors.AddTypeRegistration("Invert", typeof(InvertProcessor));
		processors.AddTypeRegistration("InvertVector2", typeof(InvertVector2Processor));
		processors.AddTypeRegistration("InvertVector3", typeof(InvertVector3Processor));
		processors.AddTypeRegistration("Clamp", typeof(ClampProcessor));
		processors.AddTypeRegistration("Normalize", typeof(NormalizeProcessor));
		processors.AddTypeRegistration("NormalizeVector2", typeof(NormalizeVector2Processor));
		processors.AddTypeRegistration("NormalizeVector3", typeof(NormalizeVector3Processor));
		processors.AddTypeRegistration("Scale", typeof(ScaleProcessor));
		processors.AddTypeRegistration("ScaleVector2", typeof(ScaleVector2Processor));
		processors.AddTypeRegistration("ScaleVector3", typeof(ScaleVector3Processor));
		processors.AddTypeRegistration("StickDeadzone", typeof(StickDeadzoneProcessor));
		processors.AddTypeRegistration("AxisDeadzone", typeof(AxisDeadzoneProcessor));
		processors.AddTypeRegistration("CompensateDirection", typeof(CompensateDirectionProcessor));
		processors.AddTypeRegistration("CompensateRotation", typeof(CompensateRotationProcessor));
		interactions.AddTypeRegistration("Hold", typeof(HoldInteraction));
		interactions.AddTypeRegistration("Tap", typeof(TapInteraction));
		interactions.AddTypeRegistration("SlowTap", typeof(SlowTapInteraction));
		interactions.AddTypeRegistration("MultiTap", typeof(MultiTapInteraction));
		interactions.AddTypeRegistration("Press", typeof(PressInteraction));
		composites.AddTypeRegistration("1DAxis", typeof(AxisComposite));
		composites.AddTypeRegistration("2DVector", typeof(Vector2Composite));
		composites.AddTypeRegistration("3DVector", typeof(Vector3Composite));
		composites.AddTypeRegistration("Axis", typeof(AxisComposite));
		composites.AddTypeRegistration("Dpad", typeof(Vector2Composite));
		composites.AddTypeRegistration("ButtonWithOneModifier", typeof(ButtonWithOneModifier));
		composites.AddTypeRegistration("ButtonWithTwoModifiers", typeof(ButtonWithTwoModifiers));
		composites.AddTypeRegistration("OneModifier", typeof(OneModifierComposite));
		composites.AddTypeRegistration("TwoModifiers", typeof(TwoModifiersComposite));
	}

	internal void InstallRuntime(IInputRuntime runtime)
	{
		if (m_Runtime != null)
		{
			m_Runtime.onUpdate = null;
			m_Runtime.onBeforeUpdate = null;
			m_Runtime.onDeviceDiscovered = null;
			m_Runtime.onPlayerFocusChanged = null;
			m_Runtime.onShouldRunUpdate = null;
		}
		m_Runtime = runtime;
		m_Runtime.onUpdate = OnUpdate;
		m_Runtime.onDeviceDiscovered = OnNativeDeviceDiscovered;
		m_Runtime.onPlayerFocusChanged = OnFocusChanged;
		m_Runtime.onShouldRunUpdate = ShouldRunUpdate;
		m_Runtime.pollingFrequency = pollingFrequency;
		m_HasFocus = m_Runtime.isPlayerFocused;
		if (m_BeforeUpdateListeners.length > 0 || m_HaveDevicesWithStateCallbackReceivers)
		{
			m_Runtime.onBeforeUpdate = OnBeforeUpdate;
			m_NativeBeforeUpdateHooked = true;
		}
	}

	internal unsafe void InstallGlobals()
	{
		InputControlLayout.s_Layouts = m_Layouts;
		InputProcessor.s_Processors = m_Processors;
		InputInteraction.s_Interactions = m_Interactions;
		InputBindingComposite.s_Composites = m_Composites;
		InputRuntime.s_Instance = m_Runtime;
		InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup = m_Runtime.currentTimeOffsetToRealtimeSinceStartup;
		InputUpdate.Restore(default(InputUpdate.SerializedState));
		InputStateBuffers.SwitchTo(m_StateBuffers, InputUpdateType.Dynamic);
		InputStateBuffers.s_DefaultStateBuffer = m_StateBuffers.defaultStateBuffer;
		InputStateBuffers.s_NoiseMaskBuffer = m_StateBuffers.noiseMaskBuffer;
		InputStateBuffers.s_ResetMaskBuffer = m_StateBuffers.resetMaskBuffer;
	}

	internal void UninstallGlobals()
	{
		if (InputControlLayout.s_Layouts.baseLayoutTable == m_Layouts.baseLayoutTable)
		{
			InputControlLayout.s_Layouts = default(InputControlLayout.Collection);
		}
		if (InputProcessor.s_Processors.table == m_Processors.table)
		{
			InputProcessor.s_Processors = default(TypeTable);
		}
		if (InputInteraction.s_Interactions.table == m_Interactions.table)
		{
			InputInteraction.s_Interactions = default(TypeTable);
		}
		if (InputBindingComposite.s_Composites.table == m_Composites.table)
		{
			InputBindingComposite.s_Composites = default(TypeTable);
		}
		InputControlLayout.s_CacheInstance = default(InputControlLayout.Cache);
		InputControlLayout.s_CacheInstanceRef = 0;
		if (m_Runtime != null)
		{
			m_Runtime.onUpdate = null;
			m_Runtime.onDeviceDiscovered = null;
			m_Runtime.onBeforeUpdate = null;
			m_Runtime.onPlayerFocusChanged = null;
			m_Runtime.onShouldRunUpdate = null;
			if (InputRuntime.s_Instance == m_Runtime)
			{
				InputRuntime.s_Instance = null;
			}
		}
	}

	private void MakeDeviceNameUnique(InputDevice device)
	{
		if (m_DevicesCount != 0)
		{
			string text = StringHelpers.MakeUniqueName(device.name, m_Devices, (InputDevice x) => (x == null) ? string.Empty : x.name);
			if (text != device.name)
			{
				ResetControlPathsRecursive(device);
				device.m_Name = new InternedString(text);
			}
		}
	}

	private static void ResetControlPathsRecursive(InputControl control)
	{
		control.m_Path = null;
		ReadOnlyArray<InputControl> children = control.children;
		int count = children.Count;
		for (int i = 0; i < count; i++)
		{
			ResetControlPathsRecursive(children[i]);
		}
	}

	private void AssignUniqueDeviceId(InputDevice device)
	{
		if (device.deviceId != 0)
		{
			InputDevice inputDevice = TryGetDeviceById(device.deviceId);
			if (inputDevice != null)
			{
				throw new InvalidOperationException($"Duplicate device ID {device.deviceId} detected for devices '{device.name}' and '{inputDevice.name}'");
			}
		}
		else
		{
			device.m_DeviceId = m_Runtime.AllocateDeviceId();
		}
	}

	private unsafe void ReallocateStateBuffers()
	{
		InputStateBuffers stateBuffers = m_StateBuffers;
		InputStateBuffers stateBuffers2 = default(InputStateBuffers);
		stateBuffers2.AllocateAll(m_Devices, m_DevicesCount);
		stateBuffers2.MigrateAll(m_Devices, m_DevicesCount, stateBuffers);
		stateBuffers.FreeAll();
		m_StateBuffers = stateBuffers2;
		InputStateBuffers.s_DefaultStateBuffer = stateBuffers2.defaultStateBuffer;
		InputStateBuffers.s_NoiseMaskBuffer = stateBuffers2.noiseMaskBuffer;
		InputStateBuffers.s_ResetMaskBuffer = stateBuffers2.resetMaskBuffer;
		InputStateBuffers.SwitchTo(m_StateBuffers, (InputUpdate.s_LatestUpdateType != InputUpdateType.None) ? InputUpdate.s_LatestUpdateType : defaultUpdateType);
	}

	private unsafe void InitializeDefaultState(InputDevice device)
	{
		if (!device.hasControlsWithDefaultState)
		{
			return;
		}
		ReadOnlyArray<InputControl> allControls = device.allControls;
		int count = allControls.Count;
		void* defaultStateBuffer = m_StateBuffers.defaultStateBuffer;
		for (int i = 0; i < count; i++)
		{
			InputControl inputControl = allControls[i];
			if (inputControl.hasDefaultState)
			{
				inputControl.m_StateBlock.Write(defaultStateBuffer, inputControl.m_DefaultState);
			}
		}
		InputStateBlock stateBlock = device.m_StateBlock;
		int deviceIndex = device.m_DeviceIndex;
		if (m_StateBuffers.m_PlayerStateBuffers.valid)
		{
			stateBlock.CopyToFrom(m_StateBuffers.m_PlayerStateBuffers.GetFrontBuffer(deviceIndex), defaultStateBuffer);
			stateBlock.CopyToFrom(m_StateBuffers.m_PlayerStateBuffers.GetBackBuffer(deviceIndex), defaultStateBuffer);
		}
	}

	private unsafe void InitializeDeviceState(InputDevice device)
	{
		ReadOnlyArray<InputControl> allControls = device.allControls;
		int count = allControls.Count;
		void* resetMaskBuffer = m_StateBuffers.resetMaskBuffer;
		bool hasControlsWithDefaultState = device.hasControlsWithDefaultState;
		void* noiseMaskBuffer = m_StateBuffers.noiseMaskBuffer;
		MemoryHelpers.SetBitsInBuffer(noiseMaskBuffer, (int)device.stateBlock.byteOffset, 0, (int)device.stateBlock.sizeInBits, value: false);
		MemoryHelpers.SetBitsInBuffer(resetMaskBuffer, (int)device.stateBlock.byteOffset, 0, (int)device.stateBlock.sizeInBits, value: true);
		void* defaultStateBuffer = m_StateBuffers.defaultStateBuffer;
		for (int i = 0; i < count; i++)
		{
			InputControl inputControl = allControls[i];
			if (inputControl.usesStateFromOtherControl)
			{
				continue;
			}
			if (!inputControl.noisy || inputControl.dontReset)
			{
				ref InputStateBlock stateBlock = ref inputControl.m_StateBlock;
				if (!inputControl.noisy)
				{
					MemoryHelpers.SetBitsInBuffer(noiseMaskBuffer, (int)stateBlock.byteOffset, (int)stateBlock.bitOffset, (int)stateBlock.sizeInBits, value: true);
				}
				if (inputControl.dontReset)
				{
					MemoryHelpers.SetBitsInBuffer(resetMaskBuffer, (int)stateBlock.byteOffset, (int)stateBlock.bitOffset, (int)stateBlock.sizeInBits, value: false);
				}
			}
			if (hasControlsWithDefaultState && inputControl.hasDefaultState)
			{
				inputControl.m_StateBlock.Write(defaultStateBuffer, inputControl.m_DefaultState);
			}
		}
		if (hasControlsWithDefaultState)
		{
			ref InputStateBlock stateBlock2 = ref device.m_StateBlock;
			int deviceIndex = device.m_DeviceIndex;
			if (m_StateBuffers.m_PlayerStateBuffers.valid)
			{
				stateBlock2.CopyToFrom(m_StateBuffers.m_PlayerStateBuffers.GetFrontBuffer(deviceIndex), defaultStateBuffer);
				stateBlock2.CopyToFrom(m_StateBuffers.m_PlayerStateBuffers.GetBackBuffer(deviceIndex), defaultStateBuffer);
			}
		}
	}

	private void OnNativeDeviceDiscovered(int deviceId, string deviceDescriptor)
	{
		RestoreDevicesAfterDomainReloadIfNecessary();
		InputDevice inputDevice = TryMatchDisconnectedDevice(deviceDescriptor);
		InputDeviceDescription deviceDescription = inputDevice?.description ?? InputDeviceDescription.FromJson(deviceDescriptor);
		bool isRemoved = false;
		try
		{
			if (m_Settings.supportedDevices.Count > 0)
			{
				InternedString layoutName = inputDevice?.m_Layout ?? TryFindMatchingControlLayout(ref deviceDescription, deviceId);
				if (!IsDeviceLayoutMarkedAsSupportedInSettings(layoutName))
				{
					isRemoved = true;
					return;
				}
			}
			if (inputDevice != null)
			{
				inputDevice.m_DeviceId = deviceId;
				inputDevice.m_DeviceFlags |= InputDevice.DeviceFlags.Native;
				inputDevice.m_DeviceFlags &= ~InputDevice.DeviceFlags.DisabledInFrontend;
				inputDevice.m_DeviceFlags &= ~InputDevice.DeviceFlags.DisabledWhileInBackground;
				inputDevice.m_DeviceFlags &= ~InputDevice.DeviceFlags.DisabledStateHasBeenQueriedFromRuntime;
				AddDevice(inputDevice);
				DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, inputDevice, InputDeviceChange.Reconnected, "InputSystem.onDeviceChange");
			}
			else
			{
				AddDevice(deviceDescription, throwIfNoLayoutFound: false, null, deviceId, InputDevice.DeviceFlags.Native);
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"Could not create a device for '{deviceDescription}' (exception: {arg})");
		}
		finally
		{
			ArrayHelpers.AppendWithCapacity(ref m_AvailableDevices, ref m_AvailableDeviceCount, new AvailableDevice
			{
				description = deviceDescription,
				deviceId = deviceId,
				isNative = true,
				isRemoved = isRemoved
			});
		}
	}

	private InputDevice TryMatchDisconnectedDevice(string deviceDescriptor)
	{
		for (int i = 0; i < m_DisconnectedDevicesCount; i++)
		{
			InputDevice inputDevice = m_DisconnectedDevices[i];
			InputDeviceDescription description = inputDevice.description;
			if (InputDeviceDescription.ComparePropertyToDeviceDescriptor("interface", description.interfaceName, deviceDescriptor) && InputDeviceDescription.ComparePropertyToDeviceDescriptor("product", description.product, deviceDescriptor) && InputDeviceDescription.ComparePropertyToDeviceDescriptor("manufacturer", description.manufacturer, deviceDescriptor) && InputDeviceDescription.ComparePropertyToDeviceDescriptor("type", description.deviceClass, deviceDescriptor) && InputDeviceDescription.ComparePropertyToDeviceDescriptor("capabilities", description.capabilities, deviceDescriptor) && InputDeviceDescription.ComparePropertyToDeviceDescriptor("serial", description.serial, deviceDescriptor))
			{
				m_DisconnectedDevices.EraseAtWithCapacity(ref m_DisconnectedDevicesCount, i);
				return inputDevice;
			}
		}
		return null;
	}

	private void InstallBeforeUpdateHookIfNecessary()
	{
		if (!m_NativeBeforeUpdateHooked && m_Runtime != null)
		{
			m_Runtime.onBeforeUpdate = OnBeforeUpdate;
			m_NativeBeforeUpdateHooked = true;
		}
	}

	private void RestoreDevicesAfterDomainReloadIfNecessary()
	{
	}

	private void WarnAboutDevicesFailingToRecreateAfterDomainReload()
	{
	}

	private void OnBeforeUpdate(InputUpdateType updateType)
	{
		RestoreDevicesAfterDomainReloadIfNecessary();
		if ((updateType & m_UpdateMask) == 0)
		{
			return;
		}
		InputStateBuffers.SwitchTo(m_StateBuffers, updateType);
		InputUpdate.OnBeforeUpdate(updateType);
		if (m_HaveDevicesWithStateCallbackReceivers && updateType != InputUpdateType.BeforeRender)
		{
			for (int i = 0; i < m_DevicesCount; i++)
			{
				InputDevice inputDevice = m_Devices[i];
				if (inputDevice.hasStateCallbacks)
				{
					((IInputStateCallbackReceiver)inputDevice).OnNextUpdate();
				}
			}
		}
		DelegateHelpers.InvokeCallbacksSafe(ref m_BeforeUpdateListeners, "onBeforeUpdate");
	}

	internal void ApplySettings()
	{
		InputUpdateType inputUpdateType = InputUpdateType.Editor;
		if ((m_UpdateMask & InputUpdateType.BeforeRender) != InputUpdateType.None)
		{
			inputUpdateType |= InputUpdateType.BeforeRender;
		}
		if (m_Settings.updateMode == (InputSettings.UpdateMode)0)
		{
			m_Settings.updateMode = InputSettings.UpdateMode.ProcessEventsInDynamicUpdate;
		}
		updateMask = m_Settings.updateMode switch
		{
			InputSettings.UpdateMode.ProcessEventsInDynamicUpdate => inputUpdateType | InputUpdateType.Dynamic, 
			InputSettings.UpdateMode.ProcessEventsInFixedUpdate => inputUpdateType | InputUpdateType.Fixed, 
			InputSettings.UpdateMode.ProcessEventsManually => inputUpdateType | InputUpdateType.Manual, 
			_ => throw new NotSupportedException("Invalid input update mode: " + m_Settings.updateMode), 
		};
		AddAvailableDevicesThatAreNowRecognized();
		if (settings.supportedDevices.Count > 0)
		{
			for (int i = 0; i < m_DevicesCount; i++)
			{
				InputDevice inputDevice = m_Devices[i];
				InternedString layout = inputDevice.m_Layout;
				bool flag = false;
				for (int j = 0; j < m_AvailableDeviceCount; j++)
				{
					if (m_AvailableDevices[j].deviceId == inputDevice.deviceId)
					{
						flag = true;
						break;
					}
				}
				if (flag && !IsDeviceLayoutMarkedAsSupportedInSettings(layout))
				{
					RemoveDevice(inputDevice, keepOnListOfAvailableDevices: true);
					i--;
				}
			}
		}
		if (m_Settings.m_FeatureFlags != null && m_Settings.IsFeatureEnabled("USE_WINDOWS_GAMING_INPUT_BACKEND"))
		{
			UseWindowsGamingInputCommand command = UseWindowsGamingInputCommand.Create(enable: true);
			if (ExecuteGlobalCommand(ref command) < 0)
			{
				Debug.LogError("Could not enable Windows.Gaming.Input");
			}
		}
		Touchscreen.s_TapTime = settings.defaultTapTime;
		Touchscreen.s_TapDelayTime = settings.multiTapDelayTime;
		Touchscreen.s_TapRadiusSquared = settings.tapRadius * settings.tapRadius;
		ButtonControl.s_GlobalDefaultButtonPressPoint = Mathf.Clamp(settings.defaultButtonPressPoint, 0.0001f, float.MaxValue);
		ButtonControl.s_GlobalDefaultButtonReleaseThreshold = settings.buttonReleaseThreshold;
		foreach (InputDevice device in devices)
		{
			device.SetOptimizedControlDataTypeRecursively();
		}
		foreach (InputDevice device2 in devices)
		{
			device2.MarkAsStaleRecursively();
		}
		DelegateHelpers.InvokeCallbacksSafe(ref m_SettingsChangedListeners, "InputSystem.onSettingsChange");
	}

	internal unsafe long ExecuteGlobalCommand<TCommand>(ref TCommand command) where TCommand : struct, IInputDeviceCommandInfo
	{
		InputDeviceCommand* commandPtr = (InputDeviceCommand*)UnsafeUtility.AddressOf(ref command);
		return InputRuntime.s_Instance.DeviceCommand(0, commandPtr);
	}

	internal void AddAvailableDevicesThatAreNowRecognized()
	{
		for (int i = 0; i < m_AvailableDeviceCount; i++)
		{
			int deviceId = m_AvailableDevices[i].deviceId;
			if (TryGetDeviceById(deviceId) != null)
			{
				continue;
			}
			InternedString internedString = TryFindMatchingControlLayout(ref m_AvailableDevices[i].description, deviceId);
			if (!IsDeviceLayoutMarkedAsSupportedInSettings(internedString))
			{
				continue;
			}
			if (internedString.IsEmpty())
			{
				if (deviceId != 0)
				{
					DisableDeviceCommand command = DisableDeviceCommand.Create();
					m_Runtime.DeviceCommand(deviceId, ref command);
				}
			}
			else
			{
				try
				{
					AddDevice(m_AvailableDevices[i].description, internedString, null, deviceId, m_AvailableDevices[i].isNative ? InputDevice.DeviceFlags.Native : ((InputDevice.DeviceFlags)0));
				}
				catch (Exception)
				{
				}
			}
		}
	}

	private bool ShouldRunDeviceInBackground(InputDevice device)
	{
		if (m_Settings.backgroundBehavior != InputSettings.BackgroundBehavior.ResetAndDisableAllDevices)
		{
			return device.canRunInBackground;
		}
		return false;
	}

	internal void OnFocusChanged(bool focus)
	{
		bool runInBackground = m_Runtime.runInBackground;
		if ((m_Settings.backgroundBehavior == InputSettings.BackgroundBehavior.IgnoreFocus) & runInBackground)
		{
			m_HasFocus = focus;
			return;
		}
		if (!focus)
		{
			if (runInBackground)
			{
				for (int i = 0; i < m_DevicesCount; i++)
				{
					InputDevice inputDevice = m_Devices[i];
					if (inputDevice.enabled && !ShouldRunDeviceInBackground(inputDevice))
					{
						EnableOrDisableDevice(inputDevice, enable: false, DeviceDisableScope.TemporaryWhilePlayerIsInBackground);
						int num = m_Devices.IndexOfReference(inputDevice, m_DevicesCount);
						i = ((num != -1) ? num : (i - 1));
					}
				}
			}
		}
		else
		{
			for (int j = 0; j < m_DevicesCount; j++)
			{
				InputDevice inputDevice2 = m_Devices[j];
				if (inputDevice2.disabledWhileInBackground)
				{
					EnableOrDisableDevice(inputDevice2, enable: true, DeviceDisableScope.TemporaryWhilePlayerIsInBackground);
				}
				else if (inputDevice2.enabled && !runInBackground && !inputDevice2.RequestSync())
				{
					ResetDevice(inputDevice2);
				}
			}
		}
		m_HasFocus = focus;
	}

	internal bool ShouldRunUpdate(InputUpdateType updateType)
	{
		if (updateType == InputUpdateType.None)
		{
			return true;
		}
		InputUpdateType inputUpdateType = m_UpdateMask;
		return (updateType & inputUpdateType) != 0;
	}

	private unsafe void OnUpdate(InputUpdateType updateType, ref InputEventBuffer eventBuffer)
	{
		if (m_InputEventStream.isOpen)
		{
			throw new InvalidOperationException("Already have an event buffer set! Was OnUpdate() called recursively?");
		}
		RestoreDevicesAfterDomainReloadIfNecessary();
		if ((updateType & m_UpdateMask) == 0)
		{
			return;
		}
		WarnAboutDevicesFailingToRecreateAfterDomainReload();
		ref InputMetrics reference = ref m_Metrics;
		int totalUpdateCount = reference.totalUpdateCount + 1;
		reference.totalUpdateCount = totalUpdateCount;
		InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup = m_Runtime.currentTimeOffsetToRealtimeSinceStartup;
		InputStateBuffers.SwitchTo(m_StateBuffers, updateType);
		m_CurrentUpdate = updateType;
		InputUpdate.OnUpdate(updateType);
		foreach (InputDevice device in devices)
		{
			_ = device;
		}
		bool flag = updateType.IsPlayerUpdate() && gameIsPlaying;
		double num = ((updateType == InputUpdateType.Fixed) ? m_Runtime.currentTimeForFixedUpdate : m_Runtime.currentTime);
		bool flag2 = (updateType == InputUpdateType.Fixed || updateType == InputUpdateType.BeforeRender) && InputSystem.settings.updateMode == InputSettings.UpdateMode.ProcessEventsInFixedUpdate;
		bool flag3 = !gameHasFocus && !m_Runtime.runInBackground;
		if (((eventBuffer.eventCount == 0) | flag3) || ((!gameHasFocus || gameShouldGetInputRegardlessOfFocus) && m_Settings.backgroundBehavior == InputSettings.BackgroundBehavior.ResetAndDisableAllDevices && updateType != InputUpdateType.Editor))
		{
			if (flag)
			{
				ProcessStateChangeMonitorTimeouts();
			}
			InvokeAfterUpdateCallback(updateType);
			if (flag3)
			{
				eventBuffer.Reset();
			}
			m_CurrentUpdate = InputUpdateType.None;
			return;
		}
		long timestamp = Stopwatch.GetTimestamp();
		double num2 = 0.0;
		try
		{
			m_InputEventStream = new InputEventStream(ref eventBuffer, m_Settings.maxQueuedEventsPerUpdate);
			uint num3 = 0u;
			InputEvent* ptr = null;
			while (m_InputEventStream.remainingEventCount > 0)
			{
				if (m_Settings.maxEventBytesPerUpdate > 0 && num3 >= m_Settings.maxEventBytesPerUpdate)
				{
					Debug.LogError("Exceeded budget for maximum input event throughput per InputSystem.Update(). Discarding remaining events. Increase InputSystem.settings.maxEventBytesPerUpdate or set it to 0 to remove the limit.");
					break;
				}
				InputDevice inputDevice = null;
				InputEvent* ptr2 = m_InputEventStream.currentEventPtr;
				if (updateType == InputUpdateType.BeforeRender)
				{
					while (m_InputEventStream.remainingEventCount > 0)
					{
						inputDevice = TryGetDeviceById(ptr2->deviceId);
						if (inputDevice != null && inputDevice.updateBeforeRender && (ptr2->type == 1398030676 || ptr2->type == 1145852993))
						{
							break;
						}
						ptr2 = m_InputEventStream.Advance(leaveEventInBuffer: true);
					}
				}
				if (m_InputEventStream.remainingEventCount == 0)
				{
					break;
				}
				double internalTime = ptr2->internalTime;
				FourCC type = ptr2->type;
				if (flag2 && internalTime >= num)
				{
					m_InputEventStream.Advance(leaveEventInBuffer: true);
					continue;
				}
				if (inputDevice == null)
				{
					inputDevice = TryGetDeviceById(ptr2->deviceId);
				}
				if (inputDevice == null)
				{
					m_InputEventStream.Advance(leaveEventInBuffer: false);
					continue;
				}
				if (!inputDevice.enabled && type != 1146242381 && type != 1145259591 && (inputDevice.m_DeviceFlags & (InputDevice.DeviceFlags.DisabledInRuntime | InputDevice.DeviceFlags.DisabledWhileInBackground)) != 0)
				{
					m_InputEventStream.Advance(leaveEventInBuffer: false);
					continue;
				}
				if (!settings.disableRedundantEventsMerging && inputDevice.hasEventMerger && ptr2 != ptr)
				{
					InputEvent* ptr3 = m_InputEventStream.Peek();
					if (ptr3 != null && ptr2->deviceId == ptr3->deviceId && (!flag2 || ptr3->internalTime < num))
					{
						if (((IEventMerger)inputDevice).MergeForward(ptr2, ptr3))
						{
							m_InputEventStream.Advance(leaveEventInBuffer: false);
							continue;
						}
						ptr = ptr3;
					}
				}
				if (inputDevice.hasEventPreProcessor && !((IEventPreProcessor)inputDevice).PreProcessEvent(ptr2))
				{
					m_InputEventStream.Advance(leaveEventInBuffer: false);
					continue;
				}
				if (m_EventListeners.length > 0)
				{
					DelegateHelpers.InvokeCallbacksSafe(ref m_EventListeners, new InputEventPtr(ptr2), inputDevice, "InputSystem.onEvent");
					if (ptr2->handled)
					{
						m_InputEventStream.Advance(leaveEventInBuffer: false);
						continue;
					}
				}
				if (internalTime <= num)
				{
					num2 += num - internalTime;
				}
				ref InputMetrics reference2 = ref m_Metrics;
				totalUpdateCount = reference2.totalEventCount + 1;
				reference2.totalEventCount = totalUpdateCount;
				m_Metrics.totalEventBytes += (int)ptr2->sizeInBytes;
				switch (type)
				{
				case 1145852993:
				case 1398030676:
				{
					InputEventPtr inputEventPtr = new InputEventPtr(ptr2);
					bool hasStateCallbacks = inputDevice.hasStateCallbacks;
					if (internalTime < inputDevice.m_LastUpdateTimeInternal && (!hasStateCallbacks || !(inputDevice.stateBlock.format != inputEventPtr.stateFormat)))
					{
						break;
					}
					bool flag4 = true;
					if (hasStateCallbacks)
					{
						m_ShouldMakeCurrentlyUpdatingDeviceCurrent = true;
						((IInputStateCallbackReceiver)inputDevice).OnStateEvent(inputEventPtr);
						flag4 = m_ShouldMakeCurrentlyUpdatingDeviceCurrent;
					}
					else
					{
						if (inputDevice.stateBlock.format != inputEventPtr.stateFormat)
						{
							break;
						}
						flag4 = UpdateState(inputDevice, inputEventPtr, updateType);
					}
					num3 += inputEventPtr.sizeInBytes;
					if (inputDevice.m_LastUpdateTimeInternal <= inputEventPtr.internalTime)
					{
						inputDevice.m_LastUpdateTimeInternal = inputEventPtr.internalTime;
					}
					if (flag4)
					{
						inputDevice.MakeCurrent();
					}
					break;
				}
				case 1413830740:
				{
					TextEvent* ptr4 = (TextEvent*)ptr2;
					if (inputDevice is ITextInputReceiver textInputReceiver)
					{
						int character = ptr4->character;
						if (character >= 65536)
						{
							character -= 65536;
							int num4 = 55296 + ((character >> 10) & 0x3FF);
							int num5 = 56320 + (character & 0x3FF);
							textInputReceiver.OnTextInput((char)num4);
							textInputReceiver.OnTextInput((char)num5);
						}
						else
						{
							textInputReceiver.OnTextInput((char)character);
						}
					}
					break;
				}
				case 1229800787:
				{
					IMECompositionEvent* ptr5 = (IMECompositionEvent*)ptr2;
					(inputDevice as ITextInputReceiver)?.OnIMECompositionChanged(ptr5->compositionString);
					break;
				}
				case 1146242381:
					RemoveDevice(inputDevice);
					if (inputDevice.native && !inputDevice.description.empty)
					{
						ArrayHelpers.AppendWithCapacity(ref m_DisconnectedDevices, ref m_DisconnectedDevicesCount, inputDevice);
						DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, inputDevice, InputDeviceChange.Disconnected, "InputSystem.onDeviceChange");
					}
					break;
				case 1145259591:
					inputDevice.NotifyConfigurationChanged();
					InputActionState.OnDeviceChange(inputDevice, InputDeviceChange.ConfigurationChanged);
					DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceChangeListeners, inputDevice, InputDeviceChange.ConfigurationChanged, "InputSystem.onDeviceChange");
					break;
				case 1146245972:
					ResetDevice(inputDevice, ((DeviceResetEvent*)ptr2)->hardReset);
					break;
				}
				m_InputEventStream.Advance(leaveEventInBuffer: false);
			}
			m_Metrics.totalEventProcessingTime += (double)(Stopwatch.GetTimestamp() - timestamp) / (double)Stopwatch.Frequency;
			m_Metrics.totalEventLagTime += num2;
			m_InputEventStream.Close(ref eventBuffer);
		}
		catch (Exception)
		{
			m_InputEventStream.CleanUpAfterException();
			throw;
		}
		if (flag)
		{
			ProcessStateChangeMonitorTimeouts();
		}
		InvokeAfterUpdateCallback(updateType);
		m_CurrentUpdate = InputUpdateType.None;
	}

	private void InvokeAfterUpdateCallback(InputUpdateType updateType)
	{
		if (updateType != InputUpdateType.Editor || !gameIsPlaying)
		{
			DelegateHelpers.InvokeCallbacksSafe(ref m_AfterUpdateListeners, "InputSystem.onAfterUpdate");
		}
	}

	internal void DontMakeCurrentlyUpdatingDeviceCurrent()
	{
		m_ShouldMakeCurrentlyUpdatingDeviceCurrent = false;
	}

	internal unsafe bool UpdateState(InputDevice device, InputEvent* eventPtr, InputUpdateType updateType)
	{
		InputStateBlock stateBlock = device.m_StateBlock;
		uint num = stateBlock.sizeInBits / 8;
		uint num2 = 0u;
		byte* statePtr;
		uint num3;
		if (eventPtr->type == 1398030676)
		{
			System.Runtime.CompilerServices.Unsafe.Read<StateEvent>(eventPtr);
			uint stateSizeInBytes = ((StateEvent*)eventPtr)->stateSizeInBytes;
			statePtr = (byte*)((StateEvent*)eventPtr)->state;
			num3 = stateSizeInBytes;
			if (num3 > num)
			{
				num3 = num;
			}
		}
		else
		{
			System.Runtime.CompilerServices.Unsafe.Read<DeltaStateEvent>(eventPtr);
			uint deltaStateSizeInBytes = ((DeltaStateEvent*)eventPtr)->deltaStateSizeInBytes;
			statePtr = (byte*)((DeltaStateEvent*)eventPtr)->deltaState;
			num2 = ((DeltaStateEvent*)eventPtr)->stateOffset;
			num3 = deltaStateSizeInBytes;
			if (num2 + num3 > num)
			{
				if (num2 >= num)
				{
					return false;
				}
				num3 = num - num2;
			}
		}
		return UpdateState(device, updateType, statePtr, num2, num3, eventPtr->internalTime, eventPtr);
	}

	internal unsafe bool UpdateState(InputDevice device, InputUpdateType updateType, void* statePtr, uint stateOffsetInDevice, uint stateSize, double internalTime, InputEventPtr eventPtr = default(InputEventPtr))
	{
		int deviceIndex = device.m_DeviceIndex;
		ref InputStateBlock stateBlock = ref device.m_StateBlock;
		byte* frontBufferForDevice = (byte*)InputStateBuffers.GetFrontBufferForDevice(deviceIndex);
		SortStateChangeMonitorsIfNecessary(deviceIndex);
		bool flag = ProcessStateChangeMonitors(deviceIndex, statePtr, frontBufferForDevice + stateBlock.byteOffset, stateSize, stateOffsetInDevice);
		uint num = device.m_StateBlock.byteOffset + stateOffsetInDevice;
		byte* ptr = frontBufferForDevice + num;
		byte* mask = (device.noisy ? ((byte*)InputStateBuffers.s_NoiseMaskBuffer + num) : null);
		bool result = !MemoryHelpers.MemCmpBitRegion(ptr, statePtr, 0u, stateSize * 8, mask);
		WriteStateChange(flippedBuffers: FlipBuffersForDeviceIfNecessary(device, updateType), buffers: m_StateBuffers.m_PlayerStateBuffers, deviceIndex: deviceIndex, deviceStateBlock: ref stateBlock, stateOffsetInDevice: stateOffsetInDevice, statePtr: statePtr, stateSizeInBytes: stateSize);
		DelegateHelpers.InvokeCallbacksSafe(ref m_DeviceStateChangeListeners, device, eventPtr, "InputSystem.onDeviceStateChange");
		if (flag)
		{
			FireStateChangeNotifications(deviceIndex, internalTime, eventPtr);
		}
		return result;
	}

	private unsafe void WriteStateChange(InputStateBuffers.DoubleBuffers buffers, int deviceIndex, ref InputStateBlock deviceStateBlock, uint stateOffsetInDevice, void* statePtr, uint stateSizeInBytes, bool flippedBuffers)
	{
		void* frontBuffer = buffers.GetFrontBuffer(deviceIndex);
		uint num = deviceStateBlock.sizeInBits / 8;
		if (flippedBuffers && num != stateSizeInBytes)
		{
			void* backBuffer = buffers.GetBackBuffer(deviceIndex);
			UnsafeUtility.MemCpy((byte*)frontBuffer + deviceStateBlock.byteOffset, (byte*)backBuffer + deviceStateBlock.byteOffset, num);
		}
		if (InputSettings.readValueCachingFeatureEnabled)
		{
			byte* ptr = (byte*)frontBuffer;
			if (flippedBuffers && num == stateSizeInBytes)
			{
				ptr = (byte*)buffers.GetBackBuffer(deviceIndex);
			}
			m_Devices[deviceIndex].WriteChangedControlStates(ptr + deviceStateBlock.byteOffset, statePtr, stateSizeInBytes, stateOffsetInDevice);
		}
		UnsafeUtility.MemCpy((byte*)frontBuffer + deviceStateBlock.byteOffset + stateOffsetInDevice, statePtr, stateSizeInBytes);
	}

	private bool FlipBuffersForDeviceIfNecessary(InputDevice device, InputUpdateType updateType)
	{
		if (updateType == InputUpdateType.BeforeRender)
		{
			return false;
		}
		if (device.m_CurrentUpdateStepCount != InputUpdate.s_UpdateStepCount)
		{
			m_StateBuffers.m_PlayerStateBuffers.SwapBuffers(device.m_DeviceIndex);
			device.m_CurrentUpdateStepCount = InputUpdate.s_UpdateStepCount;
			return true;
		}
		return false;
	}

	public void AddStateChangeMonitor(InputControl control, IInputStateChangeMonitor monitor, long monitorIndex, uint groupIndex)
	{
		int deviceIndex = control.device.m_DeviceIndex;
		if (m_StateChangeMonitors == null)
		{
			m_StateChangeMonitors = new StateChangeMonitorsForDevice[m_DevicesCount];
		}
		else if (m_StateChangeMonitors.Length <= deviceIndex)
		{
			Array.Resize(ref m_StateChangeMonitors, m_DevicesCount);
		}
		if (!isProcessingEvents && m_StateChangeMonitors[deviceIndex].needToCompactArrays)
		{
			m_StateChangeMonitors[deviceIndex].CompactArrays();
		}
		m_StateChangeMonitors[deviceIndex].Add(control, monitor, monitorIndex, groupIndex);
	}

	private void RemoveStateChangeMonitors(InputDevice device)
	{
		if (m_StateChangeMonitors == null)
		{
			return;
		}
		int deviceIndex = device.m_DeviceIndex;
		if (deviceIndex >= m_StateChangeMonitors.Length)
		{
			return;
		}
		m_StateChangeMonitors[deviceIndex].Clear();
		for (int i = 0; i < m_StateChangeMonitorTimeouts.length; i++)
		{
			if (m_StateChangeMonitorTimeouts[i].control?.device == device)
			{
				m_StateChangeMonitorTimeouts[i] = default(StateChangeMonitorTimeout);
			}
		}
	}

	public void RemoveStateChangeMonitor(InputControl control, IInputStateChangeMonitor monitor, long monitorIndex)
	{
		if (m_StateChangeMonitors == null)
		{
			return;
		}
		int deviceIndex = control.device.m_DeviceIndex;
		if (deviceIndex == -1 || deviceIndex >= m_StateChangeMonitors.Length)
		{
			return;
		}
		m_StateChangeMonitors[deviceIndex].Remove(monitor, monitorIndex, isProcessingEvents);
		for (int i = 0; i < m_StateChangeMonitorTimeouts.length; i++)
		{
			if (m_StateChangeMonitorTimeouts[i].monitor == monitor && m_StateChangeMonitorTimeouts[i].monitorIndex == monitorIndex)
			{
				m_StateChangeMonitorTimeouts[i] = default(StateChangeMonitorTimeout);
			}
		}
	}

	public void AddStateChangeMonitorTimeout(InputControl control, IInputStateChangeMonitor monitor, double time, long monitorIndex, int timerIndex)
	{
		m_StateChangeMonitorTimeouts.Append(new StateChangeMonitorTimeout
		{
			control = control,
			time = time,
			monitor = monitor,
			monitorIndex = monitorIndex,
			timerIndex = timerIndex
		});
	}

	public void RemoveStateChangeMonitorTimeout(IInputStateChangeMonitor monitor, long monitorIndex, int timerIndex)
	{
		int length = m_StateChangeMonitorTimeouts.length;
		for (int i = 0; i < length; i++)
		{
			if (m_StateChangeMonitorTimeouts[i].monitor == monitor && m_StateChangeMonitorTimeouts[i].monitorIndex == monitorIndex && m_StateChangeMonitorTimeouts[i].timerIndex == timerIndex)
			{
				m_StateChangeMonitorTimeouts[i] = default(StateChangeMonitorTimeout);
				break;
			}
		}
	}

	private void SortStateChangeMonitorsIfNecessary(int deviceIndex)
	{
		if (m_StateChangeMonitors != null && deviceIndex < m_StateChangeMonitors.Length && m_StateChangeMonitors[deviceIndex].needToUpdateOrderingOfMonitors)
		{
			m_StateChangeMonitors[deviceIndex].SortMonitorsByIndex();
		}
	}

	public void SignalStateChangeMonitor(InputControl control, IInputStateChangeMonitor monitor)
	{
		int deviceIndex = control.device.m_DeviceIndex;
		ref StateChangeMonitorsForDevice reference = ref m_StateChangeMonitors[deviceIndex];
		for (int i = 0; i < reference.signalled.length; i++)
		{
			SortStateChangeMonitorsIfNecessary(i);
			ref StateChangeMonitorListener reference2 = ref reference.listeners[i];
			if (reference2.control == control && reference2.monitor == monitor)
			{
				reference.signalled.SetBit(i);
			}
		}
	}

	public unsafe void FireStateChangeNotifications()
	{
		double currentTime = m_Runtime.currentTime;
		int num = Math.Min(m_StateChangeMonitors.LengthSafe(), m_DevicesCount);
		for (int i = 0; i < num; i++)
		{
			FireStateChangeNotifications(i, currentTime, null);
		}
	}

	private unsafe bool ProcessStateChangeMonitors(int deviceIndex, void* newStateFromEvent, void* oldStateOfDevice, uint newStateSizeInBytes, uint newStateOffsetInBytes)
	{
		if (m_StateChangeMonitors == null)
		{
			return false;
		}
		if (deviceIndex >= m_StateChangeMonitors.Length)
		{
			return false;
		}
		MemoryHelpers.BitRegion[] memoryRegions = m_StateChangeMonitors[deviceIndex].memoryRegions;
		if (memoryRegions == null)
		{
			return false;
		}
		int num = m_StateChangeMonitors[deviceIndex].count;
		bool result = false;
		DynamicBitfield signalled = m_StateChangeMonitors[deviceIndex].signalled;
		bool flag = false;
		MemoryHelpers.BitRegion bitRegion = new MemoryHelpers.BitRegion(newStateOffsetInBytes, 0u, newStateSizeInBytes * 8);
		for (int i = 0; i < num; i++)
		{
			MemoryHelpers.BitRegion other = memoryRegions[i];
			if (other.sizeInBits == 0)
			{
				int count = num;
				int count2 = num;
				m_StateChangeMonitors[deviceIndex].listeners.EraseAtWithCapacity(ref count, i);
				memoryRegions.EraseAtWithCapacity(ref count2, i);
				signalled.SetLength(num - 1);
				flag = true;
				num--;
				i--;
			}
			else
			{
				MemoryHelpers.BitRegion region = bitRegion.Overlap(other);
				if (!region.isEmpty && !MemoryHelpers.Compare(oldStateOfDevice, (byte*)newStateFromEvent - newStateOffsetInBytes, region))
				{
					signalled.SetBit(i);
					flag = true;
					result = true;
				}
			}
		}
		if (flag)
		{
			m_StateChangeMonitors[deviceIndex].signalled = signalled;
		}
		m_StateChangeMonitors[deviceIndex].needToCompactArrays = false;
		return result;
	}

	internal unsafe void FireStateChangeNotifications(int deviceIndex, double internalTime, InputEvent* eventPtr)
	{
		ref DynamicBitfield signalled = ref m_StateChangeMonitors[deviceIndex].signalled;
		ref StateChangeMonitorListener[] listeners = ref m_StateChangeMonitors[deviceIndex].listeners;
		double time = internalTime - InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup;
		InputEvent output = new InputEvent(new FourCC('F', 'A', 'K', 'E'), 20, -1, internalTime);
		if (eventPtr == null)
		{
			eventPtr = (InputEvent*)UnsafeUtility.AddressOf(ref output);
		}
		eventPtr->handled = false;
		for (int i = 0; i < signalled.length; i++)
		{
			if (!signalled.TestBit(i))
			{
				continue;
			}
			StateChangeMonitorListener stateChangeMonitorListener = listeners[i];
			try
			{
				stateChangeMonitorListener.monitor.NotifyControlStateChanged(stateChangeMonitorListener.control, time, eventPtr, stateChangeMonitorListener.monitorIndex);
			}
			catch (Exception ex)
			{
				Debug.LogError($"Exception '{ex.GetType().Name}' thrown from state change monitor '{stateChangeMonitorListener.monitor.GetType().Name}' on '{stateChangeMonitorListener.control}'");
				Debug.LogException(ex);
			}
			if (eventPtr->handled)
			{
				uint groupIndex = listeners[i].groupIndex;
				for (int j = i + 1; j < signalled.length; j++)
				{
					if (listeners[j].groupIndex == groupIndex && listeners[j].monitor == stateChangeMonitorListener.monitor)
					{
						signalled.ClearBit(j);
					}
				}
				eventPtr->handled = false;
			}
			signalled.ClearBit(i);
		}
	}

	private void ProcessStateChangeMonitorTimeouts()
	{
		if (m_StateChangeMonitorTimeouts.length == 0)
		{
			return;
		}
		double num = m_Runtime.currentTime - InputRuntime.s_CurrentTimeOffsetToRealtimeSinceStartup;
		int num2 = 0;
		for (int i = 0; i < m_StateChangeMonitorTimeouts.length; i++)
		{
			if (m_StateChangeMonitorTimeouts[i].control == null)
			{
				continue;
			}
			if (m_StateChangeMonitorTimeouts[i].time <= num)
			{
				StateChangeMonitorTimeout stateChangeMonitorTimeout = m_StateChangeMonitorTimeouts[i];
				stateChangeMonitorTimeout.monitor.NotifyTimerExpired(stateChangeMonitorTimeout.control, num, stateChangeMonitorTimeout.monitorIndex, stateChangeMonitorTimeout.timerIndex);
				continue;
			}
			if (i != num2)
			{
				m_StateChangeMonitorTimeouts[num2] = m_StateChangeMonitorTimeouts[i];
			}
			num2++;
		}
		m_StateChangeMonitorTimeouts.SetLength(num2);
	}
}
