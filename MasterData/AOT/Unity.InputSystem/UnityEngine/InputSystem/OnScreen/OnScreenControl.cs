using System;
using Unity.Collections;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.OnScreen;

public abstract class OnScreenControl : MonoBehaviour
{
	private struct OnScreenDeviceInfo
	{
		public InputEventPtr eventPtr;

		public NativeArray<byte> buffer;

		public InputDevice device;

		public OnScreenControl firstControl;

		public OnScreenDeviceInfo AddControl(OnScreenControl control)
		{
			control.m_NextControlOnDevice = firstControl;
			firstControl = control;
			return this;
		}

		public OnScreenDeviceInfo RemoveControl(OnScreenControl control)
		{
			if (firstControl == control)
			{
				firstControl = control.m_NextControlOnDevice;
			}
			else
			{
				OnScreenControl nextControlOnDevice = firstControl.m_NextControlOnDevice;
				OnScreenControl onScreenControl = firstControl;
				while (nextControlOnDevice != null)
				{
					if (!(nextControlOnDevice != control))
					{
						onScreenControl.m_NextControlOnDevice = nextControlOnDevice.m_NextControlOnDevice;
						break;
					}
					onScreenControl = nextControlOnDevice;
					nextControlOnDevice = nextControlOnDevice.m_NextControlOnDevice;
				}
			}
			control.m_NextControlOnDevice = null;
			return this;
		}

		public void Destroy()
		{
			if (buffer.IsCreated)
			{
				buffer.Dispose();
			}
			if (device != null)
			{
				InputSystem.RemoveDevice(device);
			}
			device = null;
			buffer = default;
		}
	}

	private InputControl m_Control;

	private OnScreenControl m_NextControlOnDevice;

	private InputEventPtr m_InputEventPtr;

	private static int s_nbActiveInstances;

	private static InlinedArray<OnScreenDeviceInfo> s_OnScreenDevices;

	public string controlPath
	{
		get
		{
			return controlPathInternal;
		}
		set
		{
			controlPathInternal = value;
			if (isActiveAndEnabled)
			{
				SetupInputControl();
			}
		}
	}

	public InputControl control => m_Control;

	protected abstract string controlPathInternal { get; set; }

	internal static bool HasAnyActive => s_nbActiveInstances != 0;

	private void SetupInputControl()
	{
		string text = controlPathInternal;
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		string text2 = InputControlPath.TryGetDeviceLayout(text);
		if (text2 == null)
		{
			Debug.LogError("Cannot determine device layout to use based on control path '" + text + "' used in " + GetType().Name + " component", this);
			return;
		}
		InternedString internedString = new InternedString(text2);
		int num = -1;
		for (int i = 0; i < s_OnScreenDevices.length; i++)
		{
			if (s_OnScreenDevices[i].device.m_Layout == internedString)
			{
				num = i;
				break;
			}
		}
		InputDevice device;
		if (num == -1)
		{
			try
			{
				device = InputSystem.AddDevice(text2);
			}
			catch (Exception exception)
			{
				Debug.LogError("Could not create device with layout '" + text2 + "' used in '" + GetType().Name + "' component");
				Debug.LogException(exception);
				return;
			}
			InputSystem.AddDeviceUsage(device, "OnScreen");
			NativeArray<byte> buffer = StateEvent.From(device, out var eventPtr, Allocator.Persistent);
			num = s_OnScreenDevices.Append(new OnScreenDeviceInfo
			{
				eventPtr = eventPtr,
				buffer = buffer,
				device = device
			});
		}
		else
		{
			device = s_OnScreenDevices[num].device;
		}
		m_Control = InputControlPath.TryFindControl(device, text);
		if (m_Control == null)
		{
			Debug.LogError("Cannot find control with path '" + text + "' on device of type '" + text2 + "' referenced by component '" + GetType().Name + "'", this);
			if (s_OnScreenDevices[num].firstControl == null)
			{
				s_OnScreenDevices[num].Destroy();
				s_OnScreenDevices.RemoveAt(num);
			}
		}
		else
		{
			m_InputEventPtr = s_OnScreenDevices[num].eventPtr;
			s_OnScreenDevices[num] = s_OnScreenDevices[num].AddControl(this);
		}
	}

	protected void SendValueToControl<TValue>(TValue value) where TValue : struct
	{
		if (m_Control != null)
		{
			if (!(m_Control is InputControl<TValue> inputControl))
			{
				throw new ArgumentException("The control path " + controlPath + " yields a control of type " + m_Control.GetType().Name + " which is not an InputControl with value type " + typeof(TValue).Name, "value");
			}
			m_InputEventPtr.internalTime = InputRuntime.s_Instance.currentTime;
			inputControl.WriteValueIntoEvent(value, m_InputEventPtr);
			InputSystem.QueueEvent(m_InputEventPtr);
		}
	}

	protected void SentDefaultValueToControl()
	{
		if (m_Control != null)
		{
			m_InputEventPtr.internalTime = InputRuntime.s_Instance.currentTime;
			m_Control.ResetToDefaultStateInEvent(m_InputEventPtr);
			InputSystem.QueueEvent(m_InputEventPtr);
		}
	}

	protected virtual void OnEnable()
	{
		s_nbActiveInstances++;
		SetupInputControl();
		if (m_Control == null || s_nbActiveInstances != 1 || !PlayerInput.isSinglePlayer)
		{
			return;
		}
		PlayerInput playerByIndex = PlayerInput.GetPlayerByIndex(0);
		if ((object)playerByIndex == null || playerByIndex.neverAutoSwitchControlSchemes)
		{
			return;
		}
		ReadOnlyArray<InputDevice> devices = playerByIndex.devices;
		bool flag = false;
		foreach (InputDevice item in devices)
		{
			if (m_Control.device.deviceId == item.deviceId)
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			playerByIndex.SwitchCurrentControlScheme(m_Control.device);
		}
	}

	protected virtual void OnDisable()
	{
		s_nbActiveInstances--;
		if (m_Control == null)
		{
			return;
		}
		InputDevice device = m_Control.device;
		for (int i = 0; i < s_OnScreenDevices.length; i++)
		{
			if (s_OnScreenDevices[i].device != device)
			{
				continue;
			}
			OnScreenDeviceInfo value = s_OnScreenDevices[i].RemoveControl(this);
			if (value.firstControl == null)
			{
				s_OnScreenDevices[i].Destroy();
				s_OnScreenDevices.RemoveAt(i);
			}
			else
			{
				s_OnScreenDevices[i] = value;
				if (!m_Control.CheckStateIsAtDefault())
				{
					SentDefaultValueToControl();
				}
			}
			m_Control = null;
			m_InputEventPtr = default;
			break;
		}
	}

	internal string GetWarningMessage()
	{
		return $"{GetType()} needs to be attached as a child to a UI Canvas and have a RectTransform component to function properly.";
	}
}
