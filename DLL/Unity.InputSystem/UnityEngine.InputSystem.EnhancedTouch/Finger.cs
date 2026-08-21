using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.EnhancedTouch;

public class Finger
{
	internal readonly InputStateHistory<TouchState> m_StateHistory;

	public Touchscreen screen { get; }

	public int index { get; }

	public bool isActive => currentTouch.valid;

	public Vector2 screenPosition
	{
		get
		{
			Touch touch = lastTouch;
			if (!touch.valid)
			{
				return default(Vector2);
			}
			return touch.screenPosition;
		}
	}

	public Touch lastTouch
	{
		get
		{
			int count = m_StateHistory.Count;
			if (count == 0)
			{
				return default(Touch);
			}
			return new Touch(this, m_StateHistory[count - 1]);
		}
	}

	public Touch currentTouch
	{
		get
		{
			Touch result = lastTouch;
			if (!result.valid)
			{
				return default(Touch);
			}
			if (result.isInProgress)
			{
				return result;
			}
			if (result.updateStepCount == InputUpdate.s_UpdateStepCount)
			{
				return result;
			}
			return default(Touch);
		}
	}

	public TouchHistory touchHistory => new TouchHistory(this, m_StateHistory);

	internal Finger(Touchscreen screen, int index, InputUpdateType updateMask)
	{
		this.screen = screen;
		this.index = index;
		m_StateHistory = new InputStateHistory<TouchState>(screen.touches[index])
		{
			historyDepth = Touch.maxHistoryLengthPerFinger,
			extraMemoryPerRecord = UnsafeUtility.SizeOf<Touch.ExtraDataPerTouchState>(),
			onRecordAdded = OnTouchRecorded,
			onShouldRecordStateChange = ShouldRecordTouch,
			updateMask = updateMask
		};
		m_StateHistory.StartRecording();
		if (screen.touches[index].isInProgress)
		{
			m_StateHistory.RecordStateChange(screen.touches[index], screen.touches[index].value);
		}
	}

	private unsafe static bool ShouldRecordTouch(InputControl control, double time, InputEventPtr eventPtr)
	{
		if (!eventPtr.valid)
		{
			return false;
		}
		FourCC type = eventPtr.type;
		if (type != 1398030676 && type != 1145852993)
		{
			return false;
		}
		TouchState* ptr = (TouchState*)((byte*)control.currentStatePtr + control.stateBlock.byteOffset);
		if (ptr->isTapRelease)
		{
			return false;
		}
		return true;
	}

	private unsafe void OnTouchRecorded(InputStateHistory.Record record)
	{
		int recordIndex = record.recordIndex;
		InputStateHistory.RecordHeader* recordUnchecked = m_StateHistory.GetRecordUnchecked(recordIndex);
		TouchState* statePtrWithoutControlIndex = (TouchState*)recordUnchecked->statePtrWithoutControlIndex;
		statePtrWithoutControlIndex->updateStepCount = InputUpdate.s_UpdateStepCount;
		Touch.s_GlobalState.playerState.haveBuiltActiveTouches = false;
		Touch.ExtraDataPerTouchState* ptr = (Touch.ExtraDataPerTouchState*)((byte*)recordUnchecked + m_StateHistory.bytesPerRecord - UnsafeUtility.SizeOf<Touch.ExtraDataPerTouchState>());
		ptr->uniqueId = ++Touch.s_GlobalState.playerState.lastId;
		ptr->accumulatedDelta = statePtrWithoutControlIndex->delta;
		if (statePtrWithoutControlIndex->phase != TouchPhase.Began)
		{
			if (recordIndex != m_StateHistory.m_HeadIndex)
			{
				int num = ((recordIndex == 0) ? (m_StateHistory.historyDepth - 1) : (recordIndex - 1));
				TouchState* statePtrWithoutControlIndex2 = (TouchState*)m_StateHistory.GetRecordUnchecked(num)->statePtrWithoutControlIndex;
				statePtrWithoutControlIndex->delta -= statePtrWithoutControlIndex2->delta;
				statePtrWithoutControlIndex->beganInSameFrame = statePtrWithoutControlIndex2->beganInSameFrame && statePtrWithoutControlIndex2->updateStepCount == statePtrWithoutControlIndex->updateStepCount;
			}
		}
		else
		{
			statePtrWithoutControlIndex->beganInSameFrame = true;
		}
		switch (statePtrWithoutControlIndex->phase)
		{
		case TouchPhase.Began:
			DelegateHelpers.InvokeCallbacksSafe(ref Touch.s_GlobalState.onFingerDown, this, "Touch.onFingerDown");
			break;
		case TouchPhase.Moved:
			DelegateHelpers.InvokeCallbacksSafe(ref Touch.s_GlobalState.onFingerMove, this, "Touch.onFingerMove");
			break;
		case TouchPhase.Ended:
		case TouchPhase.Canceled:
			DelegateHelpers.InvokeCallbacksSafe(ref Touch.s_GlobalState.onFingerUp, this, "Touch.onFingerUp");
			break;
		}
	}

	private unsafe Touch FindTouch(uint uniqueId)
	{
		foreach (InputStateHistory<TouchState>.Record item in m_StateHistory)
		{
			if (((Touch.ExtraDataPerTouchState*)item.GetUnsafeExtraMemoryPtrUnchecked())->uniqueId == uniqueId)
			{
				return new Touch(this, item);
			}
		}
		return default(Touch);
	}

	internal unsafe TouchHistory GetTouchHistory(Touch touch)
	{
		InputStateHistory<TouchState>.Record touchRecord = touch.m_TouchRecord;
		if (touchRecord.owner != m_StateHistory)
		{
			touch = FindTouch(touch.uniqueId);
			if (!touch.valid)
			{
				return default(TouchHistory);
			}
		}
		int touchId = touch.touchId;
		int num = touch.m_TouchRecord.index;
		int num2 = 0;
		if (touch.phase != TouchPhase.Began)
		{
			InputStateHistory<TouchState>.Record previous = touch.m_TouchRecord.previous;
			while (previous.valid)
			{
				TouchState* unsafeMemoryPtr = (TouchState*)previous.GetUnsafeMemoryPtr();
				if (unsafeMemoryPtr->touchId != touchId)
				{
					break;
				}
				num2++;
				if (unsafeMemoryPtr->phase == TouchPhase.Began)
				{
					break;
				}
				previous = previous.previous;
			}
		}
		if (num2 == 0)
		{
			return default(TouchHistory);
		}
		num--;
		return new TouchHistory(this, m_StateHistory, num, num2);
	}
}
