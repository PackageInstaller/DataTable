using System;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngineInternal.Input;

namespace UnityEngine.InputSystem.LowLevel;

internal class NativeInputRuntime : IInputRuntime
{
	public static readonly NativeInputRuntime instance = new NativeInputRuntime();

	private bool m_RunInBackground;

	private Action m_ShutdownMethod;

	private InputUpdateDelegate m_OnUpdate;

	private Action<InputUpdateType> m_OnBeforeUpdate;

	private Func<InputUpdateType, bool> m_OnShouldRunUpdate;

	private float m_PollingFrequency = 60f;

	private bool m_DidCallOnShutdown;

	private Action<bool> m_FocusChangedMethod;

	public unsafe InputUpdateDelegate onUpdate
	{
		get
		{
			return m_OnUpdate;
		}
		set
		{
			if (value != null)
			{
				NativeInputSystem.onUpdate = (NativeInputUpdateType updateType, NativeInputEventBuffer* eventBufferPtr) =>
				{
					InputEventBuffer eventBuffer = new InputEventBuffer((InputEvent*)eventBufferPtr->eventBuffer, eventBufferPtr->eventCount, eventBufferPtr->sizeInBytes, eventBufferPtr->capacityInBytes);
					try
					{
						value((InputUpdateType)updateType, ref eventBuffer);
					}
					catch (Exception ex)
					{
						Debug.LogException(ex);
						Debug.LogError($"{ex.GetType().Name} during event processing of {updateType} update; resetting event buffer");
						eventBuffer.Reset();
					}
					if (eventBuffer.eventCount > 0)
					{
						eventBufferPtr->eventCount = eventBuffer.eventCount;
						eventBufferPtr->sizeInBytes = (int)eventBuffer.sizeInBytes;
						eventBufferPtr->capacityInBytes = (int)eventBuffer.capacityInBytes;
						eventBufferPtr->eventBuffer = NativeArrayUnsafeUtility.GetUnsafeBufferPointerWithoutChecks(eventBuffer.data);
					}
					else
					{
						eventBufferPtr->eventCount = 0;
						eventBufferPtr->sizeInBytes = 0;
					}
				};
			}
			else
			{
				NativeInputSystem.onUpdate = null;
			}
			m_OnUpdate = value;
		}
	}

	public Action<InputUpdateType> onBeforeUpdate
	{
		get
		{
			return m_OnBeforeUpdate;
		}
		set
		{
			if (value != null)
			{
				NativeInputSystem.onBeforeUpdate = (NativeInputUpdateType updateType) =>
				{
					value((InputUpdateType)updateType);
				};
			}
			else
			{
				NativeInputSystem.onBeforeUpdate = null;
			}
			m_OnBeforeUpdate = value;
		}
	}

	public Func<InputUpdateType, bool> onShouldRunUpdate
	{
		get
		{
			return m_OnShouldRunUpdate;
		}
		set
		{
			if (value != null)
			{
				NativeInputSystem.onShouldRunUpdate = (NativeInputUpdateType updateType) => value((InputUpdateType)updateType);
			}
			else
			{
				NativeInputSystem.onShouldRunUpdate = null;
			}
			m_OnShouldRunUpdate = value;
		}
	}

	public Action<int, string> onDeviceDiscovered
	{
		get
		{
			return NativeInputSystem.onDeviceDiscovered;
		}
		set
		{
			NativeInputSystem.onDeviceDiscovered = value;
		}
	}

	public Action onShutdown
	{
		get
		{
			return m_ShutdownMethod;
		}
		set
		{
			if (value == null)
			{
				Application.quitting -= OnShutdown;
			}
			else if (m_ShutdownMethod == null)
			{
				Application.quitting += OnShutdown;
			}
			m_ShutdownMethod = value;
		}
	}

	public Action<bool> onPlayerFocusChanged
	{
		get
		{
			return m_FocusChangedMethod;
		}
		set
		{
			if (value == null)
			{
				Application.focusChanged -= OnFocusChanged;
			}
			else if (m_FocusChangedMethod == null)
			{
				Application.focusChanged += OnFocusChanged;
			}
			m_FocusChangedMethod = value;
		}
	}

	public bool isPlayerFocused => Application.isFocused;

	public float pollingFrequency
	{
		get
		{
			return m_PollingFrequency;
		}
		set
		{
			m_PollingFrequency = value;
			NativeInputSystem.SetPollingFrequency(value);
		}
	}

	public double currentTime => NativeInputSystem.currentTime;

	public double currentTimeForFixedUpdate => (double)Time.fixedUnscaledTime + currentTimeOffsetToRealtimeSinceStartup;

	public double currentTimeOffsetToRealtimeSinceStartup => NativeInputSystem.currentTimeOffsetToRealtimeSinceStartup;

	public float unscaledGameTime => Time.unscaledTime;

	public bool runInBackground
	{
		get
		{
			if (!Application.runInBackground)
			{
				return m_RunInBackground;
			}
			return true;
		}
		set
		{
			m_RunInBackground = value;
		}
	}

	public Vector2 screenSize => new Vector2(Screen.width, Screen.height);

	public ScreenOrientation screenOrientation => Screen.orientation;

	public int AllocateDeviceId()
	{
		return NativeInputSystem.AllocateDeviceId();
	}

	public void Update(InputUpdateType updateType)
	{
		NativeInputSystem.Update((NativeInputUpdateType)updateType);
	}

	public unsafe void QueueEvent(InputEvent* ptr)
	{
		NativeInputSystem.QueueInputEvent((IntPtr)ptr);
	}

	public unsafe long DeviceCommand(int deviceId, InputDeviceCommand* commandPtr)
	{
		if (commandPtr == null)
		{
			throw new ArgumentNullException("commandPtr");
		}
		return NativeInputSystem.IOCTL(deviceId, commandPtr->type, new IntPtr(commandPtr->payloadPtr), commandPtr->payloadSizeInBytes);
	}

	private void OnShutdown()
	{
		m_ShutdownMethod();
	}

	private bool OnWantsToShutdown()
	{
		if (!m_DidCallOnShutdown)
		{
			OnShutdown();
			m_DidCallOnShutdown = true;
		}
		return true;
	}

	private void OnFocusChanged(bool focus)
	{
		m_FocusChangedMethod(focus);
	}
}
