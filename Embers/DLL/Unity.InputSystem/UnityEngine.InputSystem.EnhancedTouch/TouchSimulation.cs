using System;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.EnhancedTouch;

[AddComponentMenu("Input/Debug/Touch Simulation")]
[ExecuteInEditMode]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/Touch.html#touch-simulation")]
public class TouchSimulation : MonoBehaviour, IInputStateChangeMonitor
{
	[NonSerialized]
	private int m_NumPointers;

	[NonSerialized]
	private Pointer[] m_Pointers;

	[NonSerialized]
	private Vector2[] m_CurrentPositions;

	[NonSerialized]
	private int[] m_CurrentDisplayIndices;

	[NonSerialized]
	private ButtonControl[] m_Touches;

	[NonSerialized]
	private int m_LastTouchId;

	[NonSerialized]
	private int m_PrimaryTouchIndex = -1;

	[NonSerialized]
	private Action<InputDevice, InputDeviceChange> m_OnDeviceChange;

	[NonSerialized]
	private Action<InputEventPtr, InputDevice> m_OnEvent;

	internal static TouchSimulation s_Instance;

	public Touchscreen simulatedTouchscreen { get; private set; }

	public static TouchSimulation instance => s_Instance;

	public static void Enable()
	{
		if (instance == null)
		{
			GameObject obj = new GameObject();
			obj.SetActive(value: false);
			obj.hideFlags = HideFlags.HideAndDontSave;
			s_Instance = obj.AddComponent<TouchSimulation>();
			instance.gameObject.SetActive(value: true);
		}
		instance.enabled = true;
	}

	public static void Disable()
	{
		if (instance != null)
		{
			instance.enabled = false;
		}
	}

	public static void Destroy()
	{
		Disable();
		if (s_Instance != null)
		{
			Object.Destroy(s_Instance.gameObject);
			s_Instance = null;
		}
	}

	protected void AddPointer(Pointer pointer)
	{
		if (pointer == null)
		{
			throw new ArgumentNullException("pointer");
		}
		if (!m_Pointers.ContainsReference(m_NumPointers, pointer))
		{
			ArrayHelpers.AppendWithCapacity(ref m_Pointers, ref m_NumPointers, pointer);
			ArrayHelpers.Append(ref m_CurrentPositions, default(Vector2));
			ArrayHelpers.Append(ref m_CurrentDisplayIndices, 0);
			InputSystem.DisableDevice(pointer, keepSendingEvents: true);
		}
	}

	protected void RemovePointer(Pointer pointer)
	{
		if (pointer == null)
		{
			throw new ArgumentNullException("pointer");
		}
		int num = m_Pointers.IndexOfReference(pointer, m_NumPointers);
		if (num == -1)
		{
			return;
		}
		for (int i = 0; i < m_Touches.Length; i++)
		{
			ButtonControl buttonControl = m_Touches[i];
			if (buttonControl == null || buttonControl.device == pointer)
			{
				UpdateTouch(i, num, TouchPhase.Canceled);
			}
		}
		m_Pointers.EraseAtWithCapacity(ref m_NumPointers, num);
		ArrayHelpers.EraseAt(ref m_CurrentPositions, num);
		ArrayHelpers.EraseAt(ref m_CurrentDisplayIndices, num);
		if (pointer.added)
		{
			InputSystem.EnableDevice(pointer);
		}
	}

	private unsafe void OnEvent(InputEventPtr eventPtr, InputDevice device)
	{
		int num = m_Pointers.IndexOfReference(device, m_NumPointers);
		if (num < 0)
		{
			return;
		}
		FourCC type = eventPtr.type;
		if (type != 1398030676 && type != 1145852993)
		{
			return;
		}
		Pointer obj = m_Pointers[num];
		Vector2Control position = obj.position;
		void* statePtrFromStateEventUnchecked = position.GetStatePtrFromStateEventUnchecked(eventPtr, type);
		if (statePtrFromStateEventUnchecked != null)
		{
			m_CurrentPositions[num] = position.ReadValueFromState(statePtrFromStateEventUnchecked);
		}
		IntegerControl displayIndex = obj.displayIndex;
		void* statePtrFromStateEventUnchecked2 = displayIndex.GetStatePtrFromStateEventUnchecked(eventPtr, type);
		if (statePtrFromStateEventUnchecked2 != null)
		{
			m_CurrentDisplayIndices[num] = displayIndex.ReadValueFromState(statePtrFromStateEventUnchecked2);
		}
		for (int i = 0; i < m_Touches.Length; i++)
		{
			ButtonControl buttonControl = m_Touches[i];
			if (buttonControl == null || buttonControl.device != device)
			{
				continue;
			}
			void* statePtrFromStateEventUnchecked3 = buttonControl.GetStatePtrFromStateEventUnchecked(eventPtr, type);
			if (statePtrFromStateEventUnchecked3 == null)
			{
				if (statePtrFromStateEventUnchecked != null)
				{
					UpdateTouch(i, num, TouchPhase.Moved, eventPtr);
				}
			}
			else if (buttonControl.ReadValueFromState(statePtrFromStateEventUnchecked3) < ButtonControl.s_GlobalDefaultButtonPressPoint * ButtonControl.s_GlobalDefaultButtonReleaseThreshold)
			{
				UpdateTouch(i, num, TouchPhase.Ended, eventPtr);
			}
		}
		foreach (InputControl item in eventPtr.EnumerateControls(InputControlExtensions.Enumerate.IgnoreControlsInDefaultState, device))
		{
			if (!item.isButton)
			{
				continue;
			}
			void* statePtrFromStateEventUnchecked4 = item.GetStatePtrFromStateEventUnchecked(eventPtr, type);
			float output = 0f;
			item.ReadValueFromStateIntoBuffer(statePtrFromStateEventUnchecked4, UnsafeUtility.AddressOf(ref output), 4);
			if (output <= ButtonControl.s_GlobalDefaultButtonPressPoint)
			{
				continue;
			}
			int num2 = m_Touches.IndexOfReference(item);
			if (num2 < 0)
			{
				num2 = m_Touches.IndexOfReference<ButtonControl, ButtonControl>(null);
				if (num2 >= 0)
				{
					m_Touches[num2] = (ButtonControl)item;
					UpdateTouch(num2, num, TouchPhase.Began, eventPtr);
				}
			}
			else
			{
				UpdateTouch(num2, num, TouchPhase.Moved, eventPtr);
			}
		}
		eventPtr.handled = true;
	}

	private void OnDeviceChange(InputDevice device, InputDeviceChange change)
	{
		if (device == simulatedTouchscreen && change == InputDeviceChange.Removed)
		{
			Disable();
			return;
		}
		switch (change)
		{
		case InputDeviceChange.Added:
			if (device is Pointer pointer2 && !(device is Touchscreen))
			{
				AddPointer(pointer2);
			}
			break;
		case InputDeviceChange.Removed:
			if (device is Pointer pointer)
			{
				RemovePointer(pointer);
			}
			break;
		}
	}

	protected void OnEnable()
	{
		if (simulatedTouchscreen != null)
		{
			if (!simulatedTouchscreen.added)
			{
				InputSystem.AddDevice(simulatedTouchscreen);
			}
		}
		else
		{
			simulatedTouchscreen = InputSystem.GetDevice("Simulated Touchscreen") as Touchscreen;
			if (simulatedTouchscreen == null)
			{
				simulatedTouchscreen = InputSystem.AddDevice<Touchscreen>("Simulated Touchscreen");
			}
		}
		if (m_Touches == null)
		{
			m_Touches = new ButtonControl[simulatedTouchscreen.touches.Count];
		}
		foreach (InputDevice device in InputSystem.devices)
		{
			OnDeviceChange(device, InputDeviceChange.Added);
		}
		if (m_OnDeviceChange == null)
		{
			m_OnDeviceChange = OnDeviceChange;
		}
		if (m_OnEvent == null)
		{
			m_OnEvent = OnEvent;
		}
		InputSystem.onDeviceChange += m_OnDeviceChange;
		InputSystem.onEvent += m_OnEvent;
	}

	protected void OnDisable()
	{
		if (simulatedTouchscreen != null && simulatedTouchscreen.added)
		{
			InputSystem.RemoveDevice(simulatedTouchscreen);
		}
		for (int i = 0; i < m_NumPointers; i++)
		{
			InputSystem.EnableDevice(m_Pointers[i]);
		}
		m_Pointers.Clear(m_NumPointers);
		m_Touches.Clear();
		m_NumPointers = 0;
		m_LastTouchId = 0;
		m_PrimaryTouchIndex = -1;
		InputSystem.onDeviceChange -= m_OnDeviceChange;
		InputSystem.onEvent -= m_OnEvent;
	}

	private unsafe void UpdateTouch(int touchIndex, int pointerIndex, TouchPhase phase, InputEventPtr eventPtr = default(InputEventPtr))
	{
		Vector2 vector = m_CurrentPositions[pointerIndex];
		byte displayIndex = (byte)m_CurrentDisplayIndices[pointerIndex];
		TouchState state = new TouchState
		{
			phase = phase,
			position = vector,
			displayIndex = displayIndex
		};
		double num = (eventPtr.valid ? eventPtr.time : InputState.currentTime);
		TouchState* ptr = (TouchState*)((byte*)simulatedTouchscreen.currentStatePtr + simulatedTouchscreen.touches[touchIndex].stateBlock.byteOffset);
		if (phase == TouchPhase.Began)
		{
			state.isPrimaryTouch = m_PrimaryTouchIndex < 0;
			state.startTime = num;
			state.startPosition = vector;
			state.touchId = ++m_LastTouchId;
			state.tapCount = ptr->tapCount;
			if (state.isPrimaryTouch)
			{
				m_PrimaryTouchIndex = touchIndex;
			}
		}
		else
		{
			state.touchId = ptr->touchId;
			state.isPrimaryTouch = m_PrimaryTouchIndex == touchIndex;
			state.delta = vector - ptr->position;
			state.startPosition = ptr->startPosition;
			state.startTime = ptr->startTime;
			state.tapCount = ptr->tapCount;
			if (phase == TouchPhase.Ended)
			{
				state.isTap = num - ptr->startTime <= (double)Touchscreen.s_TapTime && (vector - ptr->startPosition).sqrMagnitude <= Touchscreen.s_TapRadiusSquared;
				if (state.isTap)
				{
					state.tapCount++;
				}
			}
		}
		if (state.isPrimaryTouch)
		{
			InputState.Change(simulatedTouchscreen.primaryTouch, state, InputUpdateType.None, eventPtr);
		}
		InputState.Change(simulatedTouchscreen.touches[touchIndex], state, InputUpdateType.None, eventPtr);
		if (phase.IsEndedOrCanceled())
		{
			m_Touches[touchIndex] = null;
			if (m_PrimaryTouchIndex == touchIndex)
			{
				m_PrimaryTouchIndex = -1;
			}
		}
	}

	void IInputStateChangeMonitor.NotifyControlStateChanged(InputControl control, double time, InputEventPtr eventPtr, long monitorIndex)
	{
	}

	void IInputStateChangeMonitor.NotifyTimerExpired(InputControl control, double time, long monitorIndex, int timerIndex)
	{
	}

	protected void InstallStateChangeMonitors(int startIndex = 0)
	{
	}

	protected void OnSourceControlChangedValue(InputControl control, double time, InputEventPtr eventPtr, long sourceDeviceAndButtonIndex)
	{
	}

	protected void UninstallStateChangeMonitors(int startIndex = 0)
	{
	}
}
