using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(TouchscreenState), isGenericTypeOfDevice = true)]
public class Touchscreen : Pointer, IInputStateCallbackReceiver, IEventMerger, ICustomDeviceReset
{
	internal static float s_TapTime;

	internal static float s_TapDelayTime;

	internal static float s_TapRadiusSquared;

	public TouchControl primaryTouch { get; protected set; }

	public ReadOnlyArray<TouchControl> touches { get; protected set; }

	protected TouchControl[] touchControlArray
	{
		get
		{
			return touches.m_Array;
		}
		set
		{
			touches = new ReadOnlyArray<TouchControl>(value);
		}
	}

	public new static Touchscreen current { get; internal set; }

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
	}

	protected override void FinishSetup()
	{
		base.FinishSetup();
		primaryTouch = GetChildControl<TouchControl>("primaryTouch");
		base.displayIndex = primaryTouch.displayIndex;
		int num = 0;
		foreach (InputControl child in base.children)
		{
			if (child is TouchControl)
			{
				num++;
			}
		}
		if (num >= 1)
		{
			num--;
		}
		TouchControl[] array = new TouchControl[num];
		int num2 = 0;
		foreach (InputControl child2 in base.children)
		{
			if (child2 != primaryTouch && child2 is TouchControl touchControl)
			{
				array[num2++] = touchControl;
			}
		}
		touches = new ReadOnlyArray<TouchControl>(array);
	}

	protected new unsafe void OnNextUpdate()
	{
		void* ptr = base.currentStatePtr;
		TouchState* ptr2 = (TouchState*)((byte*)ptr + base.stateBlock.byteOffset + 56);
		int num = 0;
		while (num < touches.Count)
		{
			if (ptr2->delta != default(Vector2))
			{
				InputState.Change(touches[num].delta, Vector2.zero);
			}
			if (ptr2->tapCount > 0 && InputState.currentTime >= ptr2->startTime + (double)s_TapTime + (double)s_TapDelayTime)
			{
				InputState.Change((InputControl)touches[num].tapCount, (byte)0, InputUpdateType.None, default(InputEventPtr));
			}
			num++;
			ptr2++;
		}
		TouchState* ptr3 = (TouchState*)((byte*)ptr + base.stateBlock.byteOffset);
		if (ptr3->delta != default(Vector2))
		{
			InputState.Change(primaryTouch.delta, Vector2.zero);
		}
		if (ptr3->tapCount > 0 && InputState.currentTime >= ptr3->startTime + (double)s_TapTime + (double)s_TapDelayTime)
		{
			InputState.Change((InputControl)primaryTouch.tapCount, (byte)0, InputUpdateType.None, default(InputEventPtr));
		}
	}

	protected new unsafe void OnStateEvent(InputEventPtr eventPtr)
	{
		if (eventPtr.type == 1145852993)
		{
			return;
		}
		StateEvent* ptr = StateEvent.FromUnchecked(eventPtr);
		if (ptr->stateFormat != TouchState.Format)
		{
			InputState.Change(this, eventPtr);
			return;
		}
		void* num = base.currentStatePtr;
		TouchState* ptr2 = (TouchState*)((byte*)num + touches[0].stateBlock.byteOffset);
		TouchState* ptr3 = (TouchState*)((byte*)num + primaryTouch.stateBlock.byteOffset);
		int count = touches.Count;
		TouchState output;
		if (ptr->stateSizeInBytes == 56)
		{
			output = *(TouchState*)ptr->state;
		}
		else
		{
			output = default(TouchState);
			UnsafeUtility.MemCpy(UnsafeUtility.AddressOf(ref output), ptr->state, ptr->stateSizeInBytes);
		}
		output.tapCount = 0;
		output.isTapPress = false;
		output.isTapRelease = false;
		output.updateStepCount = InputUpdate.s_UpdateStepCount;
		if (output.phase != TouchPhase.Began)
		{
			int touchId = output.touchId;
			for (int i = 0; i < count; i++)
			{
				if (ptr2[i].touchId != touchId)
				{
					continue;
				}
				bool flag = (output.isPrimaryTouch = ptr2[i].isPrimaryTouch);
				if (output.delta == default(Vector2))
				{
					output.delta = output.position - ptr2[i].position;
				}
				output.delta += ptr2[i].delta;
				output.startTime = ptr2[i].startTime;
				output.startPosition = ptr2[i].startPosition;
				bool flag2 = output.isNoneEndedOrCanceled && eventPtr.time - output.startTime <= (double)s_TapTime && (output.position - output.startPosition).sqrMagnitude <= s_TapRadiusSquared;
				if (flag2)
				{
					output.tapCount = (byte)(ptr2[i].tapCount + 1);
				}
				else
				{
					output.tapCount = ptr2[i].tapCount;
				}
				if (flag)
				{
					if (output.isNoneEndedOrCanceled)
					{
						output.isPrimaryTouch = false;
						bool flag3 = false;
						for (int j = 0; j < count; j++)
						{
							if (j != i && ptr2[j].isInProgress)
							{
								flag3 = true;
								break;
							}
						}
						if (!flag3)
						{
							if (flag2)
							{
								TriggerTap(primaryTouch, ref output, eventPtr);
							}
							else
							{
								InputState.Change(primaryTouch, ref output, InputUpdateType.None, eventPtr);
							}
						}
						else
						{
							TouchState state = output;
							state.phase = TouchPhase.Moved;
							state.isOrphanedPrimaryTouch = true;
							InputState.Change(primaryTouch, ref state, InputUpdateType.None, eventPtr);
						}
					}
					else
					{
						InputState.Change(primaryTouch, ref output, InputUpdateType.None, eventPtr);
					}
				}
				else if (output.isNoneEndedOrCanceled && ptr3->isOrphanedPrimaryTouch)
				{
					bool flag4 = false;
					for (int k = 0; k < count; k++)
					{
						if (k != i && ptr2[k].isInProgress)
						{
							flag4 = true;
							break;
						}
					}
					if (!flag4)
					{
						ptr3->isOrphanedPrimaryTouch = false;
						InputState.Change((InputControl)primaryTouch.phase, (byte)3, InputUpdateType.None, default(InputEventPtr));
					}
				}
				if (flag2)
				{
					TriggerTap(touches[i], ref output, eventPtr);
				}
				else
				{
					InputState.Change(touches[i], ref output, InputUpdateType.None, eventPtr);
				}
				break;
			}
			return;
		}
		int num2 = 0;
		while (num2 < count)
		{
			if (ptr2->isNoneEndedOrCanceled)
			{
				output.delta = Vector2.zero;
				output.startTime = eventPtr.time;
				output.startPosition = output.position;
				output.isPrimaryTouch = false;
				output.isOrphanedPrimaryTouch = false;
				output.isTap = false;
				output.tapCount = ptr2->tapCount;
				if (ptr3->isNoneEndedOrCanceled)
				{
					output.isPrimaryTouch = true;
					InputState.Change(primaryTouch, ref output, InputUpdateType.None, eventPtr);
				}
				InputState.Change(touches[num2], ref output, InputUpdateType.None, eventPtr);
				break;
			}
			num2++;
			ptr2++;
		}
	}

	void IInputStateCallbackReceiver.OnNextUpdate()
	{
		OnNextUpdate();
	}

	void IInputStateCallbackReceiver.OnStateEvent(InputEventPtr eventPtr)
	{
		OnStateEvent(eventPtr);
	}

	unsafe bool IInputStateCallbackReceiver.GetStateOffsetForEvent(InputControl control, InputEventPtr eventPtr, ref uint offset)
	{
		if (!eventPtr.IsA<StateEvent>())
		{
			return false;
		}
		StateEvent* ptr = StateEvent.FromUnchecked(eventPtr);
		if (ptr->stateFormat != TouchState.Format)
		{
			return false;
		}
		if (control == null)
		{
			TouchState* ptr2 = (TouchState*)((byte*)base.currentStatePtr + touches[0].stateBlock.byteOffset);
			TouchState* state = (TouchState*)ptr->state;
			int touchId = state->touchId;
			TouchPhase phase = state->phase;
			int count = touches.Count;
			for (int i = 0; i < count; i++)
			{
				TouchState* ptr3 = ptr2 + i;
				if (ptr3->touchId == touchId || (!ptr3->isInProgress && phase.IsActive()))
				{
					offset = primaryTouch.m_StateBlock.byteOffset + primaryTouch.m_StateBlock.alignedSizeInBytes - m_StateBlock.byteOffset + (uint)(i * UnsafeUtility.SizeOf<TouchState>());
					return true;
				}
			}
			return false;
		}
		TouchControl touchControl = control.FindInParentChain<TouchControl>();
		if (touchControl == null || touchControl.parent != this)
		{
			return false;
		}
		if (touchControl != primaryTouch)
		{
			return false;
		}
		offset = touchControl.stateBlock.byteOffset - m_StateBlock.byteOffset;
		return true;
	}

	unsafe void ICustomDeviceReset.Reset()
	{
		void* ptr = base.currentStatePtr;
		using NativeArray<byte> nativeArray = new NativeArray<byte>(StateEvent.GetEventSizeWithPayload<TouchState>(), Allocator.Temp);
		StateEvent* unsafePtr = (StateEvent*)nativeArray.GetUnsafePtr();
		System.Runtime.CompilerServices.Unsafe.Write(&unsafePtr->baseEvent, new InputEvent(1398030676, nativeArray.Length, base.deviceId));
		TouchState* ptr2 = (TouchState*)((byte*)ptr + primaryTouch.stateBlock.byteOffset);
		if (ptr2->phase.IsActive())
		{
			UnsafeUtility.MemCpy(unsafePtr->state, ptr2, UnsafeUtility.SizeOf<TouchState>());
			((TouchState*)unsafePtr->state)->phase = TouchPhase.Canceled;
			InputState.Change(primaryTouch.phase, TouchPhase.Canceled, InputUpdateType.None, new InputEventPtr((InputEvent*)unsafePtr));
		}
		TouchState* ptr3 = (TouchState*)((byte*)ptr + touches[0].stateBlock.byteOffset);
		int count = touches.Count;
		for (int i = 0; i < count; i++)
		{
			if (ptr3[i].phase.IsActive())
			{
				UnsafeUtility.MemCpy(unsafePtr->state, ptr3 + i, UnsafeUtility.SizeOf<TouchState>());
				((TouchState*)unsafePtr->state)->phase = TouchPhase.Canceled;
				InputState.Change(touches[i].phase, TouchPhase.Canceled, InputUpdateType.None, new InputEventPtr((InputEvent*)unsafePtr));
			}
		}
	}

	internal unsafe static bool MergeForward(InputEventPtr currentEventPtr, InputEventPtr nextEventPtr)
	{
		if (currentEventPtr.type != 1398030676 || nextEventPtr.type != 1398030676)
		{
			return false;
		}
		StateEvent* ptr = StateEvent.FromUnchecked(currentEventPtr);
		StateEvent* ptr2 = StateEvent.FromUnchecked(nextEventPtr);
		if (ptr->stateFormat != TouchState.Format || ptr2->stateFormat != TouchState.Format)
		{
			return false;
		}
		TouchState* state = (TouchState*)ptr->state;
		TouchState* state2 = (TouchState*)ptr2->state;
		if (state->touchId != state2->touchId || state->phaseId != state2->phaseId || state->flags != state2->flags)
		{
			return false;
		}
		state2->delta += state->delta;
		return true;
	}

	bool IEventMerger.MergeForward(InputEventPtr currentEventPtr, InputEventPtr nextEventPtr)
	{
		return MergeForward(currentEventPtr, nextEventPtr);
	}

	private static void TriggerTap(TouchControl control, ref TouchState state, InputEventPtr eventPtr)
	{
		state.isTapPress = true;
		state.isTapRelease = false;
		InputState.Change(control, ref state, InputUpdateType.None, eventPtr);
		state.isTapPress = false;
		state.isTapRelease = true;
		InputState.Change(control, ref state, InputUpdateType.None, eventPtr);
		state.isTapRelease = false;
	}
}
