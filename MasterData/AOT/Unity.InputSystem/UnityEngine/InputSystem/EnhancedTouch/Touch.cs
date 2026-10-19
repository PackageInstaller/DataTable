using System;
using System.Collections.Generic;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.EnhancedTouch;

public struct Touch : IEquatable<Touch>
{
	internal struct GlobalState
	{
		internal InlinedArray<Touchscreen> touchscreens;

		internal int historyLengthPerFinger;

		internal CallbackArray<Action<Finger>> onFingerDown;

		internal CallbackArray<Action<Finger>> onFingerMove;

		internal CallbackArray<Action<Finger>> onFingerUp;

		internal FingerAndTouchState playerState;
	}

	internal struct FingerAndTouchState
	{
		public InputUpdateType updateMask;

		public Finger[] fingers;

		public Finger[] activeFingers;

		public Touch[] activeTouches;

		public int activeFingerCount;

		public int activeTouchCount;

		public int totalFingerCount;

		public uint lastId;

		public bool haveBuiltActiveTouches;

		public bool haveActiveTouchesNeedingRefreshNextUpdate;

		public InputStateHistory<TouchState> activeTouchState;

		public void AddFingers(Touchscreen screen)
		{
			int count = screen.touches.Count;
			ArrayHelpers.EnsureCapacity(ref fingers, totalFingerCount, count);
			for (int i = 0; i < count; i++)
			{
				Finger value = new Finger(screen, i, updateMask);
				ArrayHelpers.AppendWithCapacity(ref fingers, ref totalFingerCount, value);
			}
		}

		public void RemoveFingers(Touchscreen screen)
		{
			int count = screen.touches.Count;
			for (int i = 0; i < fingers.Length; i++)
			{
				if (fingers[i].screen == screen)
				{
					for (int j = 0; j < count; j++)
					{
						fingers[i + j].m_StateHistory.Dispose();
					}
					ArrayHelpers.EraseSliceWithCapacity(ref fingers, ref totalFingerCount, i, count);
					break;
				}
			}
			haveBuiltActiveTouches = false;
		}

		public void Destroy()
		{
			for (int i = 0; i < totalFingerCount; i++)
			{
				fingers[i].m_StateHistory.Dispose();
			}
			activeTouchState?.Dispose();
			activeTouchState = null;
		}

		public void UpdateActiveFingers()
		{
			activeFingerCount = 0;
			for (int i = 0; i < totalFingerCount; i++)
			{
				Finger finger = fingers[i];
				if (finger.currentTouch.valid)
				{
					ArrayHelpers.AppendWithCapacity(ref activeFingers, ref activeFingerCount, finger);
				}
			}
		}

		public unsafe void UpdateActiveTouches()
		{
			if (haveBuiltActiveTouches)
			{
				return;
			}
			if (activeTouchState == null)
			{
				activeTouchState = new InputStateHistory<TouchState>
				{
					extraMemoryPerRecord = UnsafeUtility.SizeOf<ExtraDataPerTouchState>()
				};
			}
			else
			{
				activeTouchState.Clear();
				activeTouchState.m_ControlCount = 0;
				activeTouchState.m_Controls.Clear();
			}
			activeTouchCount = 0;
			haveActiveTouchesNeedingRefreshNextUpdate = false;
			uint s_UpdateStepCount = InputUpdate.s_UpdateStepCount;
			for (int i = 0; i < totalFingerCount; i++)
			{
				ref Finger reference = ref fingers[i];
				InputStateHistory<TouchState> stateHistory = reference.m_StateHistory;
				int count = stateHistory.Count;
				if (count == 0)
				{
					continue;
				}
				int index = activeTouchCount;
				int num = 0;
				TouchState* ptr = default;
				int num2 = stateHistory.UserIndexToRecordIndex(count - 1);
				InputStateHistory.RecordHeader* ptr2 = stateHistory.GetRecordUnchecked(num2);
				int bytesPerRecord = stateHistory.bytesPerRecord;
				int num3 = bytesPerRecord - stateHistory.extraMemoryPerRecord;
				for (int j = 0; j < count; j++)
				{
					if (j != 0)
					{
						num2--;
						if (num2 < 0)
						{
							num2 = stateHistory.historyDepth - 1;
							ptr2 = stateHistory.GetRecordUnchecked(num2);
						}
						else
						{
							ptr2 = (InputStateHistory.RecordHeader*)((byte*)ptr2 - bytesPerRecord);
						}
					}
					TouchState* statePtrWithoutControlIndex = (TouchState*)ptr2->statePtrWithoutControlIndex;
					bool flag = statePtrWithoutControlIndex->updateStepCount == s_UpdateStepCount;
					if (statePtrWithoutControlIndex->touchId == num && !statePtrWithoutControlIndex->phase.IsEndedOrCanceled())
					{
						if (flag && statePtrWithoutControlIndex->phase == TouchPhase.Began)
						{
							ptr->phase = TouchPhase.Began;
							ptr->position = statePtrWithoutControlIndex->position;
							ptr->delta = default;
							haveActiveTouchesNeedingRefreshNextUpdate = true;
						}
						continue;
					}
					if (statePtrWithoutControlIndex->phase.IsEndedOrCanceled() && (!statePtrWithoutControlIndex->beganInSameFrame || statePtrWithoutControlIndex->updateStepCount != s_UpdateStepCount - 1) && !flag)
					{
						break;
					}
					ExtraDataPerTouchState* source = (ExtraDataPerTouchState*)((byte*)ptr2 + num3);
					InputStateHistory.RecordHeader* ptr3 = activeTouchState.AllocateRecord(out var index2);
					TouchState* statePtrWithControlIndex = (TouchState*)ptr3->statePtrWithControlIndex;
					ExtraDataPerTouchState* ptr4 = (ExtraDataPerTouchState*)((byte*)ptr3 + activeTouchState.bytesPerRecord - UnsafeUtility.SizeOf<ExtraDataPerTouchState>());
					ptr3->time = ptr2->time;
					ptr3->controlIndex = ArrayHelpers.AppendWithCapacity(ref activeTouchState.m_Controls, ref activeTouchState.m_ControlCount, reference.m_StateHistory.controls[0]);
					UnsafeUtility.MemCpy(statePtrWithControlIndex, statePtrWithoutControlIndex, UnsafeUtility.SizeOf<TouchState>());
					UnsafeUtility.MemCpy(ptr4, source, UnsafeUtility.SizeOf<ExtraDataPerTouchState>());
					TouchPhase phase = statePtrWithoutControlIndex->phase;
					if ((phase == TouchPhase.Moved || phase == TouchPhase.Began) && !flag && (phase != TouchPhase.Moved || !statePtrWithoutControlIndex->beganInSameFrame || statePtrWithoutControlIndex->updateStepCount != s_UpdateStepCount - 1))
					{
						statePtrWithControlIndex->phase = TouchPhase.Stationary;
						statePtrWithControlIndex->delta = default;
					}
					else if (!flag && !statePtrWithoutControlIndex->beganInSameFrame)
					{
						statePtrWithControlIndex->delta = default;
					}
					else
					{
						statePtrWithControlIndex->delta = ptr4->accumulatedDelta;
					}
					Touch value = new Touch(touchRecord: new InputStateHistory<TouchState>.Record(activeTouchState, index2, ptr3), finger: reference);
					ArrayHelpers.InsertAtWithCapacity(ref activeTouches, ref activeTouchCount, index, value);
					num = statePtrWithoutControlIndex->touchId;
					ptr = statePtrWithControlIndex;
					if (value.phase != TouchPhase.Stationary)
					{
						haveActiveTouchesNeedingRefreshNextUpdate = true;
					}
				}
			}
			haveBuiltActiveTouches = true;
		}
	}

	internal struct ExtraDataPerTouchState
	{
		public Vector2 accumulatedDelta;

		public uint uniqueId;
	}

	private readonly Finger m_Finger;

	internal InputStateHistory<TouchState>.Record m_TouchRecord;

	internal static GlobalState s_GlobalState = CreateGlobalState();

	public bool valid => m_TouchRecord.valid;

	public Finger finger => m_Finger;

	public TouchPhase phase => state.phase;

	public bool began => phase == TouchPhase.Began;

	public bool inProgress
	{
		get
		{
			if (phase != TouchPhase.Moved && phase != TouchPhase.Stationary)
			{
				return phase == TouchPhase.Began;
			}
			return true;
		}
	}

	public bool ended
	{
		get
		{
			if (phase != TouchPhase.Ended)
			{
				return phase == TouchPhase.Canceled;
			}
			return true;
		}
	}

	public int touchId => state.touchId;

	public float pressure => state.pressure;

	public Vector2 radius => state.radius;

	public double startTime => state.startTime;

	public double time => m_TouchRecord.time;

	public Touchscreen screen => finger.screen;

	public Vector2 screenPosition => state.position;

	public Vector2 startScreenPosition => state.startPosition;

	public Vector2 delta => state.delta;

	public int tapCount => state.tapCount;

	public bool isTap => state.isTap;

	public int displayIndex => state.displayIndex;

	public bool isInProgress
	{
		get
		{
			TouchPhase touchPhase = phase;
			if ((uint)(touchPhase - 1) <= 1u || touchPhase == TouchPhase.Stationary)
			{
				return true;
			}
			return false;
		}
	}

	internal uint updateStepCount => state.updateStepCount;

	internal uint uniqueId => extraData.uniqueId;

	private unsafe ref TouchState state => ref *(TouchState*)m_TouchRecord.GetUnsafeMemoryPtr();

	private unsafe ref ExtraDataPerTouchState extraData => ref *(ExtraDataPerTouchState*)m_TouchRecord.GetUnsafeExtraMemoryPtr();

	public TouchHistory history
	{
		get
		{
			if (!valid)
			{
				throw new InvalidOperationException("Touch is invalid");
			}
			return finger.GetTouchHistory(this);
		}
	}

	public static ReadOnlyArray<Touch> activeTouches
	{
		get
		{
			s_GlobalState.playerState.UpdateActiveTouches();
			return new ReadOnlyArray<Touch>(s_GlobalState.playerState.activeTouches, 0, s_GlobalState.playerState.activeTouchCount);
		}
	}

	public static ReadOnlyArray<Finger> fingers => new ReadOnlyArray<Finger>(s_GlobalState.playerState.fingers, 0, s_GlobalState.playerState.totalFingerCount);

	public static ReadOnlyArray<Finger> activeFingers
	{
		get
		{
			s_GlobalState.playerState.UpdateActiveFingers();
			return new ReadOnlyArray<Finger>(s_GlobalState.playerState.activeFingers, 0, s_GlobalState.playerState.activeFingerCount);
		}
	}

	public static IEnumerable<Touchscreen> screens => s_GlobalState.touchscreens;

	public static int maxHistoryLengthPerFinger => s_GlobalState.historyLengthPerFinger;

	public static event Action<Finger> onFingerDown
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerDown.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerDown.RemoveCallback(value);
		}
	}

	public static event Action<Finger> onFingerUp
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerUp.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerUp.RemoveCallback(value);
		}
	}

	public static event Action<Finger> onFingerMove
	{
		add
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerMove.AddCallback(value);
		}
		remove
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			s_GlobalState.onFingerMove.RemoveCallback(value);
		}
	}

	internal Touch(Finger finger, InputStateHistory<TouchState>.Record touchRecord)
	{
		m_Finger = finger;
		m_TouchRecord = touchRecord;
	}

	public override string ToString()
	{
		if (!valid)
		{
			return "<None>";
		}
		return $"{{id={touchId} finger={finger.index} phase={phase} position={screenPosition} delta={delta} time={time}}}";
	}

	public bool Equals(Touch other)
	{
		if (object.Equals(m_Finger, other.m_Finger))
		{
			return m_TouchRecord.Equals(other.m_TouchRecord);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (obj is Touch other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((m_Finger != null) ? m_Finger.GetHashCode() : 0) * 397) ^ m_TouchRecord.GetHashCode();
	}

	internal static void AddTouchscreen(Touchscreen screen)
	{
		s_GlobalState.touchscreens.AppendWithCapacity(screen, 5);
		s_GlobalState.playerState.AddFingers(screen);
	}

	internal static void RemoveTouchscreen(Touchscreen screen)
	{
		int index = s_GlobalState.touchscreens.IndexOfReference(screen);
		s_GlobalState.touchscreens.RemoveAtWithCapacity(index);
		s_GlobalState.playerState.RemoveFingers(screen);
	}

	internal static void BeginUpdate()
	{
		if (s_GlobalState.playerState.haveActiveTouchesNeedingRefreshNextUpdate)
		{
			s_GlobalState.playerState.haveBuiltActiveTouches = false;
		}
	}

	private static GlobalState CreateGlobalState()
	{
		return new GlobalState
		{
			historyLengthPerFinger = 64
		};
	}

	internal static ISavedState SaveAndResetState()
	{
		SavedStructState<GlobalState> result = new SavedStructState<GlobalState>(ref s_GlobalState, delegate(ref GlobalState state)
		{
			s_GlobalState = state;
		}, () =>
		{
		});
		s_GlobalState = CreateGlobalState();
		return result;
	}
}
