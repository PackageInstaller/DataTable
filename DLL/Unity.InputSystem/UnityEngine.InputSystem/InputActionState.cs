using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal class InputActionState : IInputStateChangeMonitor, ICloneable, IDisposable
{
	[StructLayout(LayoutKind.Explicit, Size = 48)]
	internal struct InteractionState
	{
		[Flags]
		private enum Flags
		{
			TimerRunning = 1
		}

		[FieldOffset(0)]
		private ushort m_TriggerControlIndex;

		[FieldOffset(2)]
		private byte m_Phase;

		[FieldOffset(3)]
		private byte m_Flags;

		[FieldOffset(4)]
		private float m_TimerDuration;

		[FieldOffset(8)]
		private double m_StartTime;

		[FieldOffset(16)]
		private double m_TimerStartTime;

		[FieldOffset(24)]
		private double m_PerformedTime;

		[FieldOffset(32)]
		private float m_TotalTimeoutCompletionTimeDone;

		[FieldOffset(36)]
		private float m_TotalTimeoutCompletionTimeRemaining;

		[FieldOffset(40)]
		private long m_TimerMonitorIndex;

		public int triggerControlIndex
		{
			get
			{
				if (m_TriggerControlIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_TriggerControlIndex;
			}
			set
			{
				if (value == -1)
				{
					m_TriggerControlIndex = ushort.MaxValue;
					return;
				}
				if (value < 0 || value >= 65535)
				{
					throw new NotSupportedException("More than ushort.MaxValue-1 controls in a single InputActionState");
				}
				m_TriggerControlIndex = (ushort)value;
			}
		}

		public double startTime
		{
			get
			{
				return m_StartTime;
			}
			set
			{
				m_StartTime = value;
			}
		}

		public double performedTime
		{
			get
			{
				return m_PerformedTime;
			}
			set
			{
				m_PerformedTime = value;
			}
		}

		public double timerStartTime
		{
			get
			{
				return m_TimerStartTime;
			}
			set
			{
				m_TimerStartTime = value;
			}
		}

		public float timerDuration
		{
			get
			{
				return m_TimerDuration;
			}
			set
			{
				m_TimerDuration = value;
			}
		}

		public float totalTimeoutCompletionDone
		{
			get
			{
				return m_TotalTimeoutCompletionTimeDone;
			}
			set
			{
				m_TotalTimeoutCompletionTimeDone = value;
			}
		}

		public float totalTimeoutCompletionTimeRemaining
		{
			get
			{
				return m_TotalTimeoutCompletionTimeRemaining;
			}
			set
			{
				m_TotalTimeoutCompletionTimeRemaining = value;
			}
		}

		public long timerMonitorIndex
		{
			get
			{
				return m_TimerMonitorIndex;
			}
			set
			{
				m_TimerMonitorIndex = value;
			}
		}

		public bool isTimerRunning
		{
			get
			{
				return (m_Flags & 1) == 1;
			}
			set
			{
				if (value)
				{
					m_Flags |= 1;
					return;
				}
				Flags flags = ~Flags.TimerRunning;
				m_Flags &= (byte)flags;
			}
		}

		public InputActionPhase phase
		{
			get
			{
				return (InputActionPhase)m_Phase;
			}
			set
			{
				m_Phase = (byte)value;
			}
		}
	}

	[StructLayout(LayoutKind.Explicit, Size = 32)]
	internal struct BindingState
	{
		[Flags]
		public enum Flags
		{
			ChainsWithNext = 1,
			EndOfChain = 2,
			Composite = 4,
			PartOfComposite = 8,
			InitialStateCheckPending = 0x10,
			WantsInitialStateCheck = 0x20
		}

		[FieldOffset(0)]
		private byte m_ControlCount;

		[FieldOffset(1)]
		private byte m_InteractionCount;

		[FieldOffset(2)]
		private byte m_ProcessorCount;

		[FieldOffset(3)]
		private byte m_MapIndex;

		[FieldOffset(4)]
		private byte m_Flags;

		[FieldOffset(5)]
		private byte m_PartIndex;

		[FieldOffset(6)]
		private ushort m_ActionIndex;

		[FieldOffset(8)]
		private ushort m_CompositeOrCompositeBindingIndex;

		[FieldOffset(10)]
		private ushort m_ProcessorStartIndex;

		[FieldOffset(12)]
		private ushort m_InteractionStartIndex;

		[FieldOffset(14)]
		private ushort m_ControlStartIndex;

		[FieldOffset(16)]
		private double m_PressTime;

		[FieldOffset(24)]
		private int m_TriggerEventIdForComposite;

		[FieldOffset(28)]
		private int __padding;

		public int controlStartIndex
		{
			get
			{
				return m_ControlStartIndex;
			}
			set
			{
				if (value >= 65535)
				{
					throw new NotSupportedException("Total control count in state cannot exceed byte.MaxValue=" + ushort.MaxValue);
				}
				m_ControlStartIndex = (ushort)value;
			}
		}

		public int controlCount
		{
			get
			{
				return m_ControlCount;
			}
			set
			{
				if (value >= 255)
				{
					throw new NotSupportedException("Control count per binding cannot exceed byte.MaxValue=" + byte.MaxValue);
				}
				m_ControlCount = (byte)value;
			}
		}

		public int interactionStartIndex
		{
			get
			{
				if (m_InteractionStartIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_InteractionStartIndex;
			}
			set
			{
				if (value == -1)
				{
					m_InteractionStartIndex = ushort.MaxValue;
					return;
				}
				if (value >= 65535)
				{
					throw new NotSupportedException("Interaction count cannot exceed ushort.MaxValue=" + ushort.MaxValue);
				}
				m_InteractionStartIndex = (ushort)value;
			}
		}

		public int interactionCount
		{
			get
			{
				return m_InteractionCount;
			}
			set
			{
				if (value >= 255)
				{
					throw new NotSupportedException("Interaction count per binding cannot exceed byte.MaxValue=" + byte.MaxValue);
				}
				m_InteractionCount = (byte)value;
			}
		}

		public int processorStartIndex
		{
			get
			{
				if (m_ProcessorStartIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_ProcessorStartIndex;
			}
			set
			{
				if (value == -1)
				{
					m_ProcessorStartIndex = ushort.MaxValue;
					return;
				}
				if (value >= 65535)
				{
					throw new NotSupportedException("Processor count cannot exceed ushort.MaxValue=" + ushort.MaxValue);
				}
				m_ProcessorStartIndex = (ushort)value;
			}
		}

		public int processorCount
		{
			get
			{
				return m_ProcessorCount;
			}
			set
			{
				if (value >= 255)
				{
					throw new NotSupportedException("Processor count per binding cannot exceed byte.MaxValue=" + byte.MaxValue);
				}
				m_ProcessorCount = (byte)value;
			}
		}

		public int actionIndex
		{
			get
			{
				if (m_ActionIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_ActionIndex;
			}
			set
			{
				if (value == -1)
				{
					m_ActionIndex = ushort.MaxValue;
					return;
				}
				if (value >= 65535)
				{
					throw new NotSupportedException("Action count cannot exceed ushort.MaxValue=" + ushort.MaxValue);
				}
				m_ActionIndex = (ushort)value;
			}
		}

		public int mapIndex
		{
			get
			{
				return m_MapIndex;
			}
			set
			{
				if (value >= 255)
				{
					throw new NotSupportedException("Map count cannot exceed byte.MaxValue=" + byte.MaxValue);
				}
				m_MapIndex = (byte)value;
			}
		}

		public int compositeOrCompositeBindingIndex
		{
			get
			{
				if (m_CompositeOrCompositeBindingIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_CompositeOrCompositeBindingIndex;
			}
			set
			{
				if (value == -1)
				{
					m_CompositeOrCompositeBindingIndex = ushort.MaxValue;
					return;
				}
				if (value >= 65535)
				{
					throw new NotSupportedException("Composite count cannot exceed ushort.MaxValue=" + ushort.MaxValue);
				}
				m_CompositeOrCompositeBindingIndex = (ushort)value;
			}
		}

		public int triggerEventIdForComposite
		{
			get
			{
				return m_TriggerEventIdForComposite;
			}
			set
			{
				m_TriggerEventIdForComposite = value;
			}
		}

		public double pressTime
		{
			get
			{
				return m_PressTime;
			}
			set
			{
				m_PressTime = value;
			}
		}

		public Flags flags
		{
			get
			{
				return (Flags)m_Flags;
			}
			set
			{
				m_Flags = (byte)value;
			}
		}

		public bool chainsWithNext
		{
			get
			{
				return (flags & Flags.ChainsWithNext) == Flags.ChainsWithNext;
			}
			set
			{
				if (value)
				{
					flags |= Flags.ChainsWithNext;
				}
				else
				{
					flags &= ~Flags.ChainsWithNext;
				}
			}
		}

		public bool isEndOfChain
		{
			get
			{
				return (flags & Flags.EndOfChain) == Flags.EndOfChain;
			}
			set
			{
				if (value)
				{
					flags |= Flags.EndOfChain;
				}
				else
				{
					flags &= ~Flags.EndOfChain;
				}
			}
		}

		public bool isPartOfChain
		{
			get
			{
				if (!chainsWithNext)
				{
					return isEndOfChain;
				}
				return true;
			}
		}

		public bool isComposite
		{
			get
			{
				return (flags & Flags.Composite) == Flags.Composite;
			}
			set
			{
				if (value)
				{
					flags |= Flags.Composite;
				}
				else
				{
					flags &= ~Flags.Composite;
				}
			}
		}

		public bool isPartOfComposite
		{
			get
			{
				return (flags & Flags.PartOfComposite) == Flags.PartOfComposite;
			}
			set
			{
				if (value)
				{
					flags |= Flags.PartOfComposite;
				}
				else
				{
					flags &= ~Flags.PartOfComposite;
				}
			}
		}

		public bool initialStateCheckPending
		{
			get
			{
				return (flags & Flags.InitialStateCheckPending) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.InitialStateCheckPending;
				}
				else
				{
					flags &= ~Flags.InitialStateCheckPending;
				}
			}
		}

		public bool wantsInitialStateCheck
		{
			get
			{
				return (flags & Flags.WantsInitialStateCheck) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.WantsInitialStateCheck;
				}
				else
				{
					flags &= ~Flags.WantsInitialStateCheck;
				}
			}
		}

		public int partIndex
		{
			get
			{
				return m_PartIndex;
			}
			set
			{
				if (partIndex < 0)
				{
					throw new ArgumentOutOfRangeException("value", "Part index must not be negative");
				}
				if (partIndex > 255)
				{
					throw new InvalidOperationException("Part count must not exceed byte.MaxValue=" + byte.MaxValue);
				}
				m_PartIndex = (byte)value;
			}
		}
	}

	[StructLayout(LayoutKind.Explicit, Size = 48)]
	public struct TriggerState
	{
		[Flags]
		public enum Flags
		{
			HaveMagnitude = 1,
			PassThrough = 2,
			MayNeedConflictResolution = 4,
			HasMultipleConcurrentActuations = 8,
			InProcessing = 0x10,
			Button = 0x20,
			Pressed = 0x40
		}

		public const int kMaxNumMaps = 255;

		public const int kMaxNumControls = 65535;

		public const int kMaxNumBindings = 65535;

		[FieldOffset(0)]
		private byte m_Phase;

		[FieldOffset(1)]
		private byte m_Flags;

		[FieldOffset(2)]
		private byte m_MapIndex;

		[FieldOffset(4)]
		private ushort m_ControlIndex;

		[FieldOffset(8)]
		private double m_Time;

		[FieldOffset(16)]
		private double m_StartTime;

		[FieldOffset(24)]
		private ushort m_BindingIndex;

		[FieldOffset(26)]
		private ushort m_InteractionIndex;

		[FieldOffset(28)]
		private float m_Magnitude;

		[FieldOffset(32)]
		private uint m_LastPerformedInUpdate;

		[FieldOffset(36)]
		private uint m_LastCanceledInUpdate;

		[FieldOffset(40)]
		private uint m_PressedInUpdate;

		[FieldOffset(44)]
		private uint m_ReleasedInUpdate;

		public InputActionPhase phase
		{
			get
			{
				return (InputActionPhase)m_Phase;
			}
			set
			{
				m_Phase = (byte)value;
			}
		}

		public bool isDisabled => phase == InputActionPhase.Disabled;

		public bool isWaiting => phase == InputActionPhase.Waiting;

		public bool isStarted => phase == InputActionPhase.Started;

		public bool isPerformed => phase == InputActionPhase.Performed;

		public bool isCanceled => phase == InputActionPhase.Canceled;

		public double time
		{
			get
			{
				return m_Time;
			}
			set
			{
				m_Time = value;
			}
		}

		public double startTime
		{
			get
			{
				return m_StartTime;
			}
			set
			{
				m_StartTime = value;
			}
		}

		public float magnitude
		{
			get
			{
				return m_Magnitude;
			}
			set
			{
				flags |= Flags.HaveMagnitude;
				m_Magnitude = value;
			}
		}

		public bool haveMagnitude => (flags & Flags.HaveMagnitude) != 0;

		public int mapIndex
		{
			get
			{
				return m_MapIndex;
			}
			set
			{
				if (value < 0 || value > 255)
				{
					throw new NotSupportedException("More than byte.MaxValue InputActionMaps in a single InputActionState");
				}
				m_MapIndex = (byte)value;
			}
		}

		public int controlIndex
		{
			get
			{
				if (m_ControlIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_ControlIndex;
			}
			set
			{
				if (value == -1)
				{
					m_ControlIndex = ushort.MaxValue;
					return;
				}
				if (value < 0 || value >= 65535)
				{
					throw new NotSupportedException("More than ushort.MaxValue-1 controls in a single InputActionState");
				}
				m_ControlIndex = (ushort)value;
			}
		}

		public int bindingIndex
		{
			get
			{
				return m_BindingIndex;
			}
			set
			{
				if (value < 0 || value > 65535)
				{
					throw new NotSupportedException("More than ushort.MaxValue bindings in a single InputActionState");
				}
				m_BindingIndex = (ushort)value;
			}
		}

		public int interactionIndex
		{
			get
			{
				if (m_InteractionIndex == ushort.MaxValue)
				{
					return -1;
				}
				return m_InteractionIndex;
			}
			set
			{
				if (value == -1)
				{
					m_InteractionIndex = ushort.MaxValue;
					return;
				}
				if (value < 0 || value >= 65535)
				{
					throw new NotSupportedException("More than ushort.MaxValue-1 interactions in a single InputActionState");
				}
				m_InteractionIndex = (ushort)value;
			}
		}

		public uint lastPerformedInUpdate
		{
			get
			{
				return m_LastPerformedInUpdate;
			}
			set
			{
				m_LastPerformedInUpdate = value;
			}
		}

		public uint lastCanceledInUpdate
		{
			get
			{
				return m_LastCanceledInUpdate;
			}
			set
			{
				m_LastCanceledInUpdate = value;
			}
		}

		public uint pressedInUpdate
		{
			get
			{
				return m_PressedInUpdate;
			}
			set
			{
				m_PressedInUpdate = value;
			}
		}

		public uint releasedInUpdate
		{
			get
			{
				return m_ReleasedInUpdate;
			}
			set
			{
				m_ReleasedInUpdate = value;
			}
		}

		public bool isPassThrough
		{
			get
			{
				return (flags & Flags.PassThrough) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.PassThrough;
				}
				else
				{
					flags &= ~Flags.PassThrough;
				}
			}
		}

		public bool isButton
		{
			get
			{
				return (flags & Flags.Button) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.Button;
				}
				else
				{
					flags &= ~Flags.Button;
				}
			}
		}

		public bool isPressed
		{
			get
			{
				return (flags & Flags.Pressed) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.Pressed;
				}
				else
				{
					flags &= ~Flags.Pressed;
				}
			}
		}

		public bool mayNeedConflictResolution
		{
			get
			{
				return (flags & Flags.MayNeedConflictResolution) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.MayNeedConflictResolution;
				}
				else
				{
					flags &= ~Flags.MayNeedConflictResolution;
				}
			}
		}

		public bool hasMultipleConcurrentActuations
		{
			get
			{
				return (flags & Flags.HasMultipleConcurrentActuations) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.HasMultipleConcurrentActuations;
				}
				else
				{
					flags &= ~Flags.HasMultipleConcurrentActuations;
				}
			}
		}

		public bool inProcessing
		{
			get
			{
				return (flags & Flags.InProcessing) != 0;
			}
			set
			{
				if (value)
				{
					flags |= Flags.InProcessing;
				}
				else
				{
					flags &= ~Flags.InProcessing;
				}
			}
		}

		public Flags flags
		{
			get
			{
				return (Flags)m_Flags;
			}
			set
			{
				m_Flags = (byte)value;
			}
		}
	}

	public struct ActionMapIndices
	{
		public int actionStartIndex;

		public int actionCount;

		public int controlStartIndex;

		public int controlCount;

		public int bindingStartIndex;

		public int bindingCount;

		public int interactionStartIndex;

		public int interactionCount;

		public int processorStartIndex;

		public int processorCount;

		public int compositeStartIndex;

		public int compositeCount;
	}

	public struct UnmanagedMemory : IDisposable
	{
		public unsafe void* basePtr;

		public int mapCount;

		public int actionCount;

		public int interactionCount;

		public int bindingCount;

		public int controlCount;

		public int compositeCount;

		public unsafe TriggerState* actionStates;

		public unsafe BindingState* bindingStates;

		public unsafe InteractionState* interactionStates;

		public unsafe float* controlMagnitudes;

		public unsafe float* compositeMagnitudes;

		public unsafe int* enabledControls;

		public unsafe ushort* actionBindingIndicesAndCounts;

		public unsafe ushort* actionBindingIndices;

		public unsafe int* controlIndexToBindingIndex;

		public unsafe ushort* controlGroupingAndComplexity;

		public bool controlGroupingInitialized;

		public unsafe ActionMapIndices* mapIndices;

		public unsafe bool isAllocated => basePtr != null;

		public unsafe int sizeInBytes => mapCount * sizeof(ActionMapIndices) + actionCount * sizeof(TriggerState) + bindingCount * sizeof(BindingState) + interactionCount * sizeof(InteractionState) + controlCount * 4 + compositeCount * 4 + controlCount * 4 + controlCount * 2 * 2 + actionCount * 2 * 2 + bindingCount * 2 + (controlCount + 31) / 32 * 4;

		public unsafe void Allocate(int mapCount, int actionCount, int bindingCount, int controlCount, int interactionCount, int compositeCount)
		{
			this.mapCount = mapCount;
			this.actionCount = actionCount;
			this.interactionCount = interactionCount;
			this.bindingCount = bindingCount;
			this.controlCount = controlCount;
			this.compositeCount = compositeCount;
			int num = sizeInBytes;
			byte* ptr = (byte*)UnsafeUtility.Malloc(num, 8, Allocator.Persistent);
			UnsafeUtility.MemClear(ptr, num);
			basePtr = ptr;
			actionStates = (TriggerState*)ptr;
			ptr = (byte*)(enabledControls = (int*)((byte*)(actionBindingIndices = (ushort*)((byte*)(actionBindingIndicesAndCounts = (ushort*)((byte*)(controlGroupingAndComplexity = (ushort*)((byte*)(controlIndexToBindingIndex = (int*)((byte*)(compositeMagnitudes = (float*)((byte*)(controlMagnitudes = (float*)((byte*)(mapIndices = (ActionMapIndices*)((byte*)(bindingStates = (BindingState*)((byte*)(interactionStates = (InteractionState*)(ptr + actionCount * sizeof(TriggerState))) + interactionCount * sizeof(InteractionState))) + bindingCount * sizeof(BindingState))) + mapCount * sizeof(ActionMapIndices))) + controlCount * 4)) + compositeCount * 4)) + controlCount * 4)) + controlCount * 2 * 2)) + actionCount * 2 * 2)) + bindingCount * 2)) + (controlCount + 31) / 32 * 4;
		}

		public unsafe void Dispose()
		{
			if (basePtr != null)
			{
				UnsafeUtility.Free(basePtr, Allocator.Persistent);
				basePtr = null;
				actionStates = null;
				interactionStates = null;
				bindingStates = null;
				mapIndices = null;
				controlMagnitudes = null;
				compositeMagnitudes = null;
				controlIndexToBindingIndex = null;
				controlGroupingAndComplexity = null;
				actionBindingIndices = null;
				actionBindingIndicesAndCounts = null;
				mapCount = 0;
				actionCount = 0;
				bindingCount = 0;
				controlCount = 0;
				interactionCount = 0;
				compositeCount = 0;
			}
		}

		public unsafe void CopyDataFrom(UnmanagedMemory memory)
		{
			UnsafeUtility.MemCpy(mapIndices, memory.mapIndices, memory.mapCount * sizeof(ActionMapIndices));
			UnsafeUtility.MemCpy(actionStates, memory.actionStates, memory.actionCount * sizeof(TriggerState));
			UnsafeUtility.MemCpy(bindingStates, memory.bindingStates, memory.bindingCount * sizeof(BindingState));
			UnsafeUtility.MemCpy(interactionStates, memory.interactionStates, memory.interactionCount * sizeof(InteractionState));
			UnsafeUtility.MemCpy(controlMagnitudes, memory.controlMagnitudes, memory.controlCount * 4);
			UnsafeUtility.MemCpy(compositeMagnitudes, memory.compositeMagnitudes, memory.compositeCount * 4);
			UnsafeUtility.MemCpy(controlIndexToBindingIndex, memory.controlIndexToBindingIndex, memory.controlCount * 4);
			UnsafeUtility.MemCpy(controlGroupingAndComplexity, memory.controlGroupingAndComplexity, memory.controlCount * 2 * 2);
			UnsafeUtility.MemCpy(actionBindingIndicesAndCounts, memory.actionBindingIndicesAndCounts, memory.actionCount * 2 * 2);
			UnsafeUtility.MemCpy(actionBindingIndices, memory.actionBindingIndices, memory.bindingCount * 2);
			UnsafeUtility.MemCpy(enabledControls, memory.enabledControls, (memory.controlCount + 31) / 32 * 4);
		}

		public UnmanagedMemory Clone()
		{
			if (!isAllocated)
			{
				return default(UnmanagedMemory);
			}
			UnmanagedMemory result = default(UnmanagedMemory);
			result.Allocate(mapCount, actionCount, controlCount: controlCount, bindingCount: bindingCount, interactionCount: interactionCount, compositeCount: compositeCount);
			result.CopyDataFrom(this);
			return result;
		}
	}

	internal struct GlobalState
	{
		internal InlinedArray<GCHandle> globalList;

		internal CallbackArray<Action<object, InputActionChange>> onActionChange;

		internal CallbackArray<Action<object>> onActionControlsChanged;
	}

	public const int kInvalidIndex = -1;

	public InputActionMap[] maps;

	public InputControl[] controls;

	public IInputInteraction[] interactions;

	public InputProcessor[] processors;

	public InputBindingComposite[] composites;

	public int totalProcessorCount;

	public UnmanagedMemory memory;

	private bool m_OnBeforeUpdateHooked;

	private bool m_OnAfterUpdateHooked;

	private bool m_InProcessControlStateChange;

	private InputEventPtr m_CurrentlyProcessingThisEvent;

	private Action m_OnBeforeUpdateDelegate;

	private Action m_OnAfterUpdateDelegate;

	internal static GlobalState s_GlobalState;

	public int totalCompositeCount => memory.compositeCount;

	public int totalMapCount => memory.mapCount;

	public int totalActionCount => memory.actionCount;

	public int totalBindingCount => memory.bindingCount;

	public int totalInteractionCount => memory.interactionCount;

	public int totalControlCount => memory.controlCount;

	public unsafe ActionMapIndices* mapIndices => memory.mapIndices;

	public unsafe TriggerState* actionStates => memory.actionStates;

	public unsafe BindingState* bindingStates => memory.bindingStates;

	public unsafe InteractionState* interactionStates => memory.interactionStates;

	public unsafe int* controlIndexToBindingIndex => memory.controlIndexToBindingIndex;

	public unsafe ushort* controlGroupingAndComplexity => memory.controlGroupingAndComplexity;

	public unsafe float* controlMagnitudes => memory.controlMagnitudes;

	public unsafe uint* enabledControls => (uint*)memory.enabledControls;

	public bool isProcessingControlStateChange => m_InProcessControlStateChange;

	public void Initialize(InputBindingResolver resolver)
	{
		ClaimDataFrom(resolver);
		AddToGlobalList();
	}

	private unsafe void ComputeControlGroupingIfNecessary()
	{
		if (memory.controlGroupingInitialized)
		{
			return;
		}
		bool flag = !InputSystem.settings.shortcutKeysConsumeInput;
		uint num = 1u;
		for (int i = 0; i < totalControlCount; i++)
		{
			InputControl inputControl = controls[i];
			int num2 = controlIndexToBindingIndex[i];
			ref BindingState reference = ref bindingStates[num2];
			int num3 = 1;
			if (reference.isPartOfComposite && !flag)
			{
				int compositeOrCompositeBindingIndex = reference.compositeOrCompositeBindingIndex;
				for (int j = compositeOrCompositeBindingIndex + 1; j < totalBindingCount; j++)
				{
					ref BindingState reference2 = ref bindingStates[j];
					if (!reference2.isPartOfComposite || reference2.compositeOrCompositeBindingIndex != compositeOrCompositeBindingIndex)
					{
						break;
					}
					num3++;
				}
			}
			controlGroupingAndComplexity[i * 2 + 1] = (ushort)num3;
			if (controlGroupingAndComplexity[i * 2] != 0)
			{
				continue;
			}
			if (!flag)
			{
				for (int k = 0; k < totalControlCount; k++)
				{
					InputControl inputControl2 = controls[k];
					if (inputControl == inputControl2)
					{
						controlGroupingAndComplexity[k * 2] = (ushort)num;
					}
				}
			}
			controlGroupingAndComplexity[i * 2] = (ushort)num;
			num++;
		}
		memory.controlGroupingInitialized = true;
	}

	public void ClaimDataFrom(InputBindingResolver resolver)
	{
		totalProcessorCount = resolver.totalProcessorCount;
		maps = resolver.maps;
		interactions = resolver.interactions;
		processors = resolver.processors;
		composites = resolver.composites;
		controls = resolver.controls;
		memory = resolver.memory;
		resolver.memory = default(UnmanagedMemory);
		ComputeControlGroupingIfNecessary();
	}

	~InputActionState()
	{
		Destroy(isFinalizing: true);
	}

	public void Dispose()
	{
		Destroy();
	}

	private unsafe void Destroy(bool isFinalizing = false)
	{
		if (!isFinalizing)
		{
			for (int i = 0; i < totalMapCount; i++)
			{
				InputActionMap inputActionMap = maps[i];
				if (inputActionMap.enabled)
				{
					DisableControls(i, mapIndices[i].controlStartIndex, mapIndices[i].controlCount);
				}
				if (inputActionMap.m_Asset != null)
				{
					inputActionMap.m_Asset.m_SharedStateForAllMaps = null;
				}
				inputActionMap.m_State = null;
				inputActionMap.m_MapIndexInState = -1;
				inputActionMap.m_EnabledActionsCount = 0;
				InputAction[] actions = inputActionMap.m_Actions;
				if (actions != null)
				{
					for (int j = 0; j < actions.Length; j++)
					{
						actions[j].m_ActionIndexInState = -1;
					}
				}
			}
			RemoveMapFromGlobalList();
		}
		memory.Dispose();
	}

	public InputActionState Clone()
	{
		return new InputActionState
		{
			maps = ArrayHelpers.Copy(maps),
			controls = ArrayHelpers.Copy(controls),
			interactions = ArrayHelpers.Copy(interactions),
			processors = ArrayHelpers.Copy(processors),
			composites = ArrayHelpers.Copy(composites),
			totalProcessorCount = totalProcessorCount,
			memory = memory.Clone()
		};
	}

	object ICloneable.Clone()
	{
		return Clone();
	}

	private bool IsUsingDevice(InputDevice device)
	{
		bool flag = false;
		for (int i = 0; i < totalMapCount; i++)
		{
			ReadOnlyArray<InputDevice>? devices = maps[i].devices;
			if (!devices.HasValue)
			{
				flag = true;
			}
			else if (Enumerable.Contains(devices.Value, device))
			{
				return true;
			}
		}
		if (!flag)
		{
			return false;
		}
		for (int j = 0; j < totalControlCount; j++)
		{
			if (controls[j].device == device)
			{
				return true;
			}
		}
		return false;
	}

	private bool CanUseDevice(InputDevice device)
	{
		bool flag = false;
		for (int i = 0; i < totalMapCount; i++)
		{
			ReadOnlyArray<InputDevice>? devices = maps[i].devices;
			if (!devices.HasValue)
			{
				flag = true;
			}
			else if (Enumerable.Contains(devices.Value, device))
			{
				return true;
			}
		}
		if (!flag)
		{
			return false;
		}
		for (int j = 0; j < totalMapCount; j++)
		{
			InputBinding[] bindings = maps[j].m_Bindings;
			if (bindings == null)
			{
				continue;
			}
			int num = bindings.Length;
			for (int k = 0; k < num; k++)
			{
				if (InputControlPath.TryFindControl(device, bindings[k].effectivePath) != null)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool HasEnabledActions()
	{
		for (int i = 0; i < totalMapCount; i++)
		{
			if (maps[i].enabled)
			{
				return true;
			}
		}
		return false;
	}

	private unsafe void FinishBindingCompositeSetups()
	{
		for (int i = 0; i < totalBindingCount; i++)
		{
			ref BindingState reference = ref bindingStates[i];
			if (reference.isComposite && reference.compositeOrCompositeBindingIndex != -1)
			{
				InputBindingComposite obj = composites[reference.compositeOrCompositeBindingIndex];
				InputBindingCompositeContext context = new InputBindingCompositeContext
				{
					m_State = this,
					m_BindingIndex = i
				};
				obj.CallFinishSetup(ref context);
			}
		}
	}

	internal unsafe void PrepareForBindingReResolution(bool needFullResolve, ref InputControlList<InputControl> activeControls, ref bool hasEnabledActions)
	{
		bool flag = false;
		for (int i = 0; i < totalMapCount; i++)
		{
			InputActionMap inputActionMap = maps[i];
			if (inputActionMap.enabled)
			{
				hasEnabledActions = true;
				if (needFullResolve)
				{
					DisableAllActions(inputActionMap);
				}
				else
				{
					foreach (InputAction action in inputActionMap.actions)
					{
						if (!action.phase.IsInProgress())
						{
							continue;
						}
						if (action.ActiveControlIsValid(action.activeControl))
						{
							if (!flag)
							{
								activeControls = new InputControlList<InputControl>(Allocator.Temp);
								activeControls.Resize(totalControlCount);
								flag = true;
							}
							ref TriggerState reference = ref actionStates[action.m_ActionIndexInState];
							int controlIndex = reference.controlIndex;
							activeControls[controlIndex] = controls[controlIndex];
							BindingState bindingState = bindingStates[reference.bindingIndex];
							for (int j = 0; j < bindingState.interactionCount; j++)
							{
								int num = bindingState.interactionStartIndex + j;
								if (interactionStates[num].phase.IsInProgress())
								{
									controlIndex = interactionStates[num].triggerControlIndex;
									if (action.ActiveControlIsValid(controls[controlIndex]))
									{
										activeControls[controlIndex] = controls[controlIndex];
									}
									else
									{
										ResetInteractionState(num);
									}
								}
							}
						}
						else
						{
							ResetActionState(action.m_ActionIndexInState);
						}
					}
					DisableControls(inputActionMap);
				}
			}
			inputActionMap.ClearCachedActionData(!needFullResolve);
		}
		NotifyListenersOfActionChange(InputActionChange.BoundControlsAboutToChange);
	}

	public void FinishBindingResolution(bool hasEnabledActions, UnmanagedMemory oldMemory, InputControlList<InputControl> activeControls, bool isFullResolve)
	{
		FinishBindingCompositeSetups();
		if (hasEnabledActions)
		{
			RestoreActionStatesAfterReResolvingBindings(oldMemory, activeControls, isFullResolve);
		}
		else
		{
			NotifyListenersOfActionChange(InputActionChange.BoundControlsChanged);
		}
	}

	private unsafe void RestoreActionStatesAfterReResolvingBindings(UnmanagedMemory oldState, InputControlList<InputControl> activeControls, bool isFullResolve)
	{
		for (int i = 0; i < totalActionCount; i++)
		{
			ref TriggerState reference = ref oldState.actionStates[i];
			ref TriggerState reference2 = ref actionStates[i];
			reference2.lastCanceledInUpdate = reference.lastCanceledInUpdate;
			reference2.lastPerformedInUpdate = reference.lastPerformedInUpdate;
			reference2.pressedInUpdate = reference.pressedInUpdate;
			reference2.releasedInUpdate = reference.releasedInUpdate;
			reference2.startTime = reference.startTime;
			if (reference.phase != InputActionPhase.Disabled)
			{
				reference2.phase = InputActionPhase.Waiting;
				if (isFullResolve)
				{
					maps[reference2.mapIndex].m_EnabledActionsCount++;
				}
			}
		}
		for (int j = 0; j < totalBindingCount; j++)
		{
			ref BindingState reference3 = ref memory.bindingStates[j];
			if (reference3.isPartOfComposite)
			{
				continue;
			}
			if (reference3.isComposite)
			{
				int compositeOrCompositeBindingIndex = reference3.compositeOrCompositeBindingIndex;
				memory.compositeMagnitudes[compositeOrCompositeBindingIndex] = oldState.compositeMagnitudes[compositeOrCompositeBindingIndex];
			}
			int actionIndex = reference3.actionIndex;
			if (actionIndex == -1)
			{
				continue;
			}
			ref TriggerState reference4 = ref actionStates[actionIndex];
			if (reference4.isDisabled)
			{
				continue;
			}
			reference3.initialStateCheckPending = reference3.wantsInitialStateCheck;
			EnableControls(reference3.mapIndex, reference3.controlStartIndex, reference3.controlCount);
			if (isFullResolve)
			{
				continue;
			}
			ref BindingState reference5 = ref memory.bindingStates[j];
			reference3.triggerEventIdForComposite = reference5.triggerEventIdForComposite;
			ref TriggerState reference6 = ref oldState.actionStates[actionIndex];
			if (j != reference6.bindingIndex || !reference6.phase.IsInProgress() || activeControls.Count <= 0 || activeControls[reference6.controlIndex] == null)
			{
				continue;
			}
			InputControl control = activeControls[reference6.controlIndex];
			int num = FindControlIndexOnBinding(j, control);
			if (num != -1)
			{
				reference4.phase = reference6.phase;
				reference4.controlIndex = num;
				reference4.magnitude = reference6.magnitude;
				reference4.interactionIndex = reference6.interactionIndex;
				memory.controlMagnitudes[num] = reference6.magnitude;
			}
			for (int k = 0; k < reference3.interactionCount; k++)
			{
				ref InteractionState reference7 = ref oldState.interactionStates[reference5.interactionStartIndex + k];
				if (!reference7.phase.IsInProgress())
				{
					continue;
				}
				control = activeControls[reference7.triggerControlIndex];
				if (control != null)
				{
					num = FindControlIndexOnBinding(j, control);
					ref InteractionState reference8 = ref interactionStates[reference3.interactionStartIndex + k];
					reference8.phase = reference7.phase;
					reference8.performedTime = reference7.performedTime;
					reference8.startTime = reference7.startTime;
					reference8.triggerControlIndex = num;
					if (reference7.isTimerRunning)
					{
						TriggerState trigger = new TriggerState
						{
							mapIndex = reference3.mapIndex,
							controlIndex = num,
							bindingIndex = j,
							time = reference7.timerStartTime,
							interactionIndex = reference3.interactionStartIndex + k
						};
						StartTimeout(reference7.timerDuration, ref trigger);
						reference8.totalTimeoutCompletionDone = reference7.totalTimeoutCompletionDone;
						reference8.totalTimeoutCompletionTimeRemaining = reference7.totalTimeoutCompletionTimeRemaining;
					}
				}
			}
		}
		HookOnBeforeUpdate();
		NotifyListenersOfActionChange(InputActionChange.BoundControlsChanged);
		if (!isFullResolve || s_GlobalState.onActionChange.length <= 0)
		{
			return;
		}
		for (int l = 0; l < totalMapCount; l++)
		{
			InputActionMap inputActionMap = maps[l];
			if (inputActionMap.m_SingletonAction == null && inputActionMap.m_EnabledActionsCount == inputActionMap.m_Actions.LengthSafe())
			{
				NotifyListenersOfActionChange(InputActionChange.ActionMapEnabled, inputActionMap);
				continue;
			}
			foreach (InputAction action in inputActionMap.actions)
			{
				if (action.enabled)
				{
					NotifyListenersOfActionChange(InputActionChange.ActionEnabled, action);
				}
			}
		}
	}

	private unsafe bool IsActiveControl(int bindingIndex, int controlIndex)
	{
		ref BindingState reference = ref bindingStates[bindingIndex];
		int actionIndex = reference.actionIndex;
		if (actionIndex == -1)
		{
			return false;
		}
		if (actionStates[actionIndex].controlIndex == controlIndex)
		{
			return true;
		}
		for (int i = 0; i < reference.interactionCount; i++)
		{
			if (interactionStates[bindingStates->interactionStartIndex + i].triggerControlIndex == controlIndex)
			{
				return true;
			}
		}
		return false;
	}

	private unsafe int FindControlIndexOnBinding(int bindingIndex, InputControl control)
	{
		int controlStartIndex = bindingStates[bindingIndex].controlStartIndex;
		int controlCount = bindingStates[bindingIndex].controlCount;
		for (int i = 0; i < controlCount; i++)
		{
			if (control == controls[controlStartIndex + i])
			{
				return controlStartIndex + i;
			}
		}
		return -1;
	}

	private unsafe void ResetActionStatesDrivenBy(InputDevice device)
	{
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			for (int i = 0; i < totalActionCount; i++)
			{
				TriggerState* ptr = actionStates + i;
				if (ptr->phase == InputActionPhase.Waiting || ptr->phase == InputActionPhase.Disabled)
				{
					continue;
				}
				if (ptr->isPassThrough)
				{
					if (!IsActionBoundToControlFromDevice(device, i))
					{
						continue;
					}
				}
				else
				{
					int controlIndex = ptr->controlIndex;
					if (controlIndex == -1 || controls[controlIndex].device != device)
					{
						continue;
					}
				}
				ResetActionState(i);
			}
		}
	}

	private unsafe bool IsActionBoundToControlFromDevice(InputDevice device, int actionIndex)
	{
		bool result = false;
		ushort actionBindingStartIndexAndCount = GetActionBindingStartIndexAndCount(actionIndex, out var bindingCount);
		for (int i = 0; i < bindingCount; i++)
		{
			ushort num = memory.actionBindingIndices[actionBindingStartIndexAndCount + i];
			int controlCount = bindingStates[(int)num].controlCount;
			int controlStartIndex = bindingStates[(int)num].controlStartIndex;
			for (int j = 0; j < controlCount; j++)
			{
				if (controls[controlStartIndex + j].device == device)
				{
					result = true;
					break;
				}
			}
		}
		return result;
	}

	public unsafe void ResetActionState(int actionIndex, InputActionPhase toPhase = InputActionPhase.Waiting, bool hardReset = false)
	{
		TriggerState* ptr = actionStates + actionIndex;
		if (ptr->phase != InputActionPhase.Waiting && ptr->phase != InputActionPhase.Disabled)
		{
			ptr->time = InputState.currentTime;
			if (ptr->interactionIndex != -1)
			{
				int bindingIndex = ptr->bindingIndex;
				if (bindingIndex != -1)
				{
					int mapIndex = ptr->mapIndex;
					int interactionCount = bindingStates[bindingIndex].interactionCount;
					int interactionStartIndex = bindingStates[bindingIndex].interactionStartIndex;
					for (int i = 0; i < interactionCount; i++)
					{
						int interactionIndex = interactionStartIndex + i;
						ResetInteractionStateAndCancelIfNecessary(mapIndex, bindingIndex, interactionIndex);
					}
				}
			}
			else if (ptr->phase != InputActionPhase.Canceled)
			{
				ChangePhaseOfAction(InputActionPhase.Canceled, ref actionStates[actionIndex]);
			}
		}
		ptr->phase = toPhase;
		ptr->controlIndex = -1;
		ptr->bindingIndex = memory.actionBindingIndices[(int)memory.actionBindingIndicesAndCounts[actionIndex]];
		ptr->interactionIndex = -1;
		ptr->startTime = 0.0;
		ptr->time = 0.0;
		ptr->hasMultipleConcurrentActuations = false;
		ptr->inProcessing = false;
		ptr->isPressed = false;
		if (hardReset)
		{
			ptr->lastCanceledInUpdate = 0u;
			ptr->lastPerformedInUpdate = 0u;
			ptr->pressedInUpdate = 0u;
			ptr->releasedInUpdate = 0u;
		}
	}

	public unsafe ref TriggerState FetchActionState(InputAction action)
	{
		return ref actionStates[action.m_ActionIndexInState];
	}

	public unsafe ActionMapIndices FetchMapIndices(InputActionMap map)
	{
		return mapIndices[map.m_MapIndexInState];
	}

	public unsafe void EnableAllActions(InputActionMap map)
	{
		EnableControls(map);
		int mapIndexInState = map.m_MapIndexInState;
		int actionCount = mapIndices[mapIndexInState].actionCount;
		int actionStartIndex = mapIndices[mapIndexInState].actionStartIndex;
		for (int i = 0; i < actionCount; i++)
		{
			int num = actionStartIndex + i;
			TriggerState* ptr = actionStates + num;
			if (ptr->isDisabled)
			{
				ptr->phase = InputActionPhase.Waiting;
			}
			ptr->inProcessing = false;
		}
		map.m_EnabledActionsCount = actionCount;
		HookOnBeforeUpdate();
		if (map.m_SingletonAction != null)
		{
			NotifyListenersOfActionChange(InputActionChange.ActionEnabled, map.m_SingletonAction);
		}
		else
		{
			NotifyListenersOfActionChange(InputActionChange.ActionMapEnabled, map);
		}
	}

	private unsafe void EnableControls(InputActionMap map)
	{
		int mapIndexInState = map.m_MapIndexInState;
		int controlCount = mapIndices[mapIndexInState].controlCount;
		int controlStartIndex = mapIndices[mapIndexInState].controlStartIndex;
		if (controlCount > 0)
		{
			EnableControls(mapIndexInState, controlStartIndex, controlCount);
		}
	}

	public unsafe void EnableSingleAction(InputAction action)
	{
		EnableControls(action);
		int actionIndexInState = action.m_ActionIndexInState;
		actionStates[actionIndexInState].phase = InputActionPhase.Waiting;
		action.m_ActionMap.m_EnabledActionsCount++;
		HookOnBeforeUpdate();
		NotifyListenersOfActionChange(InputActionChange.ActionEnabled, action);
	}

	private unsafe void EnableControls(InputAction action)
	{
		int actionIndexInState = action.m_ActionIndexInState;
		int mapIndexInState = action.m_ActionMap.m_MapIndexInState;
		int bindingStartIndex = mapIndices[mapIndexInState].bindingStartIndex;
		int bindingCount = mapIndices[mapIndexInState].bindingCount;
		BindingState* ptr = memory.bindingStates;
		for (int i = 0; i < bindingCount; i++)
		{
			int num = bindingStartIndex + i;
			BindingState* ptr2 = ptr + num;
			if (ptr2->actionIndex == actionIndexInState && !ptr2->isPartOfComposite)
			{
				int controlCount = ptr2->controlCount;
				if (controlCount != 0)
				{
					EnableControls(mapIndexInState, ptr2->controlStartIndex, controlCount);
				}
			}
		}
	}

	public unsafe void DisableAllActions(InputActionMap map)
	{
		DisableControls(map);
		int mapIndexInState = map.m_MapIndexInState;
		int actionStartIndex = mapIndices[mapIndexInState].actionStartIndex;
		int actionCount = mapIndices[mapIndexInState].actionCount;
		bool flag = map.m_EnabledActionsCount == actionCount;
		for (int i = 0; i < actionCount; i++)
		{
			int num = actionStartIndex + i;
			if (actionStates[num].phase != InputActionPhase.Disabled)
			{
				ResetActionState(num, InputActionPhase.Disabled);
				if (!flag)
				{
					NotifyListenersOfActionChange(InputActionChange.ActionDisabled, map.m_Actions[i]);
				}
			}
		}
		map.m_EnabledActionsCount = 0;
		if (map.m_SingletonAction != null)
		{
			NotifyListenersOfActionChange(InputActionChange.ActionDisabled, map.m_SingletonAction);
		}
		else if (flag)
		{
			NotifyListenersOfActionChange(InputActionChange.ActionMapDisabled, map);
		}
	}

	public unsafe void DisableControls(InputActionMap map)
	{
		int mapIndexInState = map.m_MapIndexInState;
		int controlCount = mapIndices[mapIndexInState].controlCount;
		int controlStartIndex = mapIndices[mapIndexInState].controlStartIndex;
		if (controlCount > 0)
		{
			DisableControls(mapIndexInState, controlStartIndex, controlCount);
		}
	}

	public void DisableSingleAction(InputAction action)
	{
		DisableControls(action);
		ResetActionState(action.m_ActionIndexInState, InputActionPhase.Disabled);
		action.m_ActionMap.m_EnabledActionsCount--;
		NotifyListenersOfActionChange(InputActionChange.ActionDisabled, action);
	}

	private unsafe void DisableControls(InputAction action)
	{
		int actionIndexInState = action.m_ActionIndexInState;
		int mapIndexInState = action.m_ActionMap.m_MapIndexInState;
		int bindingStartIndex = mapIndices[mapIndexInState].bindingStartIndex;
		int bindingCount = mapIndices[mapIndexInState].bindingCount;
		BindingState* ptr = memory.bindingStates;
		for (int i = 0; i < bindingCount; i++)
		{
			int num = bindingStartIndex + i;
			BindingState* ptr2 = ptr + num;
			if (ptr2->actionIndex == actionIndexInState && !ptr2->isPartOfComposite)
			{
				int controlCount = ptr2->controlCount;
				if (controlCount != 0)
				{
					DisableControls(mapIndexInState, ptr2->controlStartIndex, controlCount);
				}
			}
		}
	}

	private unsafe void EnableControls(int mapIndex, int controlStartIndex, int numControls)
	{
		InputManager s_Manager = InputSystem.s_Manager;
		for (int i = 0; i < numControls; i++)
		{
			int num = controlStartIndex + i;
			if (!IsControlEnabled(num))
			{
				int num2 = controlIndexToBindingIndex[num];
				long monitorIndex = ToCombinedMapAndControlAndBindingIndex(mapIndex, num, num2);
				BindingState* ptr = bindingStates + num2;
				if (ptr->wantsInitialStateCheck)
				{
					SetInitialStateCheckPending(ptr, value: true);
				}
				s_Manager.AddStateChangeMonitor(controls[num], this, monitorIndex, controlGroupingAndComplexity[num * 2]);
				SetControlEnabled(num, state: true);
			}
		}
	}

	private unsafe void DisableControls(int mapIndex, int controlStartIndex, int numControls)
	{
		InputManager s_Manager = InputSystem.s_Manager;
		for (int i = 0; i < numControls; i++)
		{
			int num = controlStartIndex + i;
			if (IsControlEnabled(num))
			{
				int num2 = controlIndexToBindingIndex[num];
				long monitorIndex = ToCombinedMapAndControlAndBindingIndex(mapIndex, num, num2);
				BindingState* ptr = bindingStates + num2;
				if (ptr->wantsInitialStateCheck)
				{
					SetInitialStateCheckPending(ptr, value: false);
				}
				s_Manager.RemoveStateChangeMonitor(controls[num], this, monitorIndex);
				SetControlEnabled(num, state: false);
			}
		}
	}

	public unsafe void SetInitialStateCheckPending(int actionIndex, bool value = true)
	{
		int mapIndex = actionStates[actionIndex].mapIndex;
		int bindingStartIndex = mapIndices[mapIndex].bindingStartIndex;
		int bindingCount = mapIndices[mapIndex].bindingCount;
		for (int i = 0; i < bindingCount; i++)
		{
			ref BindingState reference = ref bindingStates[bindingStartIndex + i];
			if (reference.actionIndex == actionIndex && !reference.isPartOfComposite)
			{
				reference.initialStateCheckPending = value;
			}
		}
	}

	private unsafe void SetInitialStateCheckPending(BindingState* bindingStatePtr, bool value)
	{
		if (bindingStatePtr->isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStatePtr->compositeOrCompositeBindingIndex;
			bindingStates[compositeOrCompositeBindingIndex].initialStateCheckPending = value;
		}
		else
		{
			bindingStatePtr->initialStateCheckPending = value;
		}
	}

	private unsafe bool IsControlEnabled(int controlIndex)
	{
		int num = controlIndex / 32;
		uint num2 = (uint)(1 << controlIndex % 32);
		return (enabledControls[num] & num2) != 0;
	}

	private unsafe void SetControlEnabled(int controlIndex, bool state)
	{
		int num = controlIndex / 32;
		uint num2 = (uint)(1 << controlIndex % 32);
		if (state)
		{
			enabledControls[num] |= num2;
		}
		else
		{
			enabledControls[num] &= ~num2;
		}
	}

	private void HookOnBeforeUpdate()
	{
		if (!m_OnBeforeUpdateHooked)
		{
			if (m_OnBeforeUpdateDelegate == null)
			{
				m_OnBeforeUpdateDelegate = OnBeforeInitialUpdate;
			}
			InputSystem.s_Manager.onBeforeUpdate += m_OnBeforeUpdateDelegate;
			m_OnBeforeUpdateHooked = true;
		}
	}

	private void UnhookOnBeforeUpdate()
	{
		if (m_OnBeforeUpdateHooked)
		{
			InputSystem.s_Manager.onBeforeUpdate -= m_OnBeforeUpdateDelegate;
			m_OnBeforeUpdateHooked = false;
		}
	}

	private unsafe void OnBeforeInitialUpdate()
	{
		if (InputState.currentUpdateType == InputUpdateType.BeforeRender)
		{
			return;
		}
		UnhookOnBeforeUpdate();
		double currentTime = InputState.currentTime;
		InputManager s_Manager = InputSystem.s_Manager;
		for (int i = 0; i < totalBindingCount; i++)
		{
			ref BindingState reference = ref bindingStates[i];
			if (!reference.initialStateCheckPending)
			{
				continue;
			}
			reference.initialStateCheckPending = false;
			int controlStartIndex = reference.controlStartIndex;
			int controlCount = reference.controlCount;
			bool isComposite = reference.isComposite;
			bool flag = false;
			for (int j = 0; j < controlCount; j++)
			{
				int num = controlStartIndex + j;
				InputControl inputControl = controls[num];
				if (!IsActiveControl(i, num) && !inputControl.CheckStateIsAtDefault())
				{
					if (inputControl.IsValueConsideredPressed(inputControl.magnitude) && (reference.pressTime == 0.0 || reference.pressTime > currentTime))
					{
						reference.pressTime = currentTime;
					}
					if (!(isComposite & flag))
					{
						s_Manager.SignalStateChangeMonitor(inputControl, this);
						flag = true;
					}
				}
			}
		}
		s_Manager.FireStateChangeNotifications();
	}

	void IInputStateChangeMonitor.NotifyControlStateChanged(InputControl control, double time, InputEventPtr eventPtr, long mapControlAndBindingIndex)
	{
		SplitUpMapAndControlAndBindingIndex(mapControlAndBindingIndex, out var mapIndex, out var controlIndex, out var bindingIndex);
		ProcessControlStateChange(mapIndex, controlIndex, bindingIndex, time, eventPtr);
	}

	void IInputStateChangeMonitor.NotifyTimerExpired(InputControl control, double time, long mapControlAndBindingIndex, int interactionIndex)
	{
		SplitUpMapAndControlAndBindingIndex(mapControlAndBindingIndex, out var mapIndex, out var controlIndex, out var bindingIndex);
		ProcessTimeout(time, mapIndex, controlIndex, bindingIndex, interactionIndex);
	}

	private unsafe long ToCombinedMapAndControlAndBindingIndex(int mapIndex, int controlIndex, int bindingIndex)
	{
		ushort num = controlGroupingAndComplexity[controlIndex * 2 + 1];
		return controlIndex | ((long)bindingIndex << 24) | ((long)mapIndex << 40) | (long)((ulong)num << 48);
	}

	private void SplitUpMapAndControlAndBindingIndex(long mapControlAndBindingIndex, out int mapIndex, out int controlIndex, out int bindingIndex)
	{
		controlIndex = (int)(mapControlAndBindingIndex & 0xFFFFFF);
		bindingIndex = (int)((mapControlAndBindingIndex >> 24) & 0xFFFF);
		mapIndex = (int)((mapControlAndBindingIndex >> 40) & 0xFF);
	}

	internal static int GetComplexityFromMonitorIndex(long mapControlAndBindingIndex)
	{
		return (int)((mapControlAndBindingIndex >> 48) & 0xFF);
	}

	private unsafe void ProcessControlStateChange(int mapIndex, int controlIndex, int bindingIndex, double time, InputEventPtr eventPtr)
	{
		using (InputActionRebindingExtensions.DeferBindingResolution())
		{
			m_InProcessControlStateChange = true;
			m_CurrentlyProcessingThisEvent = eventPtr;
			try
			{
				BindingState* ptr = bindingStates + bindingIndex;
				int actionIndex = ptr->actionIndex;
				TriggerState trigger = new TriggerState
				{
					mapIndex = mapIndex,
					controlIndex = controlIndex,
					bindingIndex = bindingIndex,
					interactionIndex = -1,
					time = time,
					startTime = time,
					isPassThrough = (actionIndex != -1 && actionStates[actionIndex].isPassThrough),
					isButton = (actionIndex != -1 && actionStates[actionIndex].isButton)
				};
				if (m_OnBeforeUpdateHooked)
				{
					ptr->initialStateCheckPending = false;
				}
				InputControl inputControl = controls[controlIndex];
				trigger.magnitude = (inputControl.CheckStateIsAtDefault() ? 0f : inputControl.magnitude);
				controlMagnitudes[controlIndex] = trigger.magnitude;
				if (inputControl.IsValueConsideredPressed(trigger.magnitude) && (ptr->pressTime == 0.0 || ptr->pressTime > trigger.time))
				{
					ptr->pressTime = trigger.time;
				}
				bool flag = false;
				if (ptr->isPartOfComposite)
				{
					int compositeOrCompositeBindingIndex = ptr->compositeOrCompositeBindingIndex;
					BindingState* ptr2 = bindingStates + compositeOrCompositeBindingIndex;
					if (ShouldIgnoreInputOnCompositeBinding(ptr2, eventPtr))
					{
						return;
					}
					int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
					InputBindingCompositeContext context = new InputBindingCompositeContext
					{
						m_State = this,
						m_BindingIndex = compositeOrCompositeBindingIndex
					};
					trigger.magnitude = composites[compositeOrCompositeBindingIndex2].EvaluateMagnitude(ref context);
					memory.compositeMagnitudes[compositeOrCompositeBindingIndex2] = trigger.magnitude;
					int interactionCount = ptr2->interactionCount;
					if (interactionCount > 0)
					{
						flag = true;
						ProcessInteractions(ref trigger, ptr2->interactionStartIndex, interactionCount);
					}
				}
				bool flag2 = IsConflictingInput(ref trigger, actionIndex);
				ptr = bindingStates + trigger.bindingIndex;
				if (!flag2)
				{
					ProcessButtonState(ref trigger, actionIndex, ptr);
				}
				int interactionCount2 = ptr->interactionCount;
				if (interactionCount2 > 0 && !ptr->isPartOfComposite)
				{
					ProcessInteractions(ref trigger, ptr->interactionStartIndex, interactionCount2);
				}
				else if (!flag && !flag2)
				{
					ProcessDefaultInteraction(ref trigger, actionIndex);
				}
			}
			finally
			{
				m_InProcessControlStateChange = false;
				m_CurrentlyProcessingThisEvent = default(InputEventPtr);
			}
		}
	}

	private unsafe void ProcessButtonState(ref TriggerState trigger, int actionIndex, BindingState* bindingStatePtr)
	{
		InputControl inputControl = controls[trigger.controlIndex];
		float num = (inputControl.isButton ? ((ButtonControl)inputControl).pressPointOrDefault : ButtonControl.s_GlobalDefaultButtonPressPoint);
		if (controlMagnitudes[trigger.controlIndex] <= num * ButtonControl.s_GlobalDefaultButtonReleaseThreshold)
		{
			bindingStatePtr->pressTime = 0.0;
		}
		float magnitude = trigger.magnitude;
		TriggerState* ptr = actionStates + actionIndex;
		if (!ptr->isPressed && magnitude >= num)
		{
			ptr->pressedInUpdate = InputUpdate.s_UpdateStepCount;
			ptr->isPressed = true;
		}
		else if (ptr->isPressed)
		{
			float num2 = num * ButtonControl.s_GlobalDefaultButtonReleaseThreshold;
			if (magnitude <= num2)
			{
				ptr->releasedInUpdate = InputUpdate.s_UpdateStepCount;
				ptr->isPressed = false;
			}
		}
	}

	private unsafe static bool ShouldIgnoreInputOnCompositeBinding(BindingState* binding, InputEvent* eventPtr)
	{
		if (eventPtr == null)
		{
			return false;
		}
		int eventId = eventPtr->eventId;
		if (eventId != 0 && binding->triggerEventIdForComposite == eventId)
		{
			return true;
		}
		binding->triggerEventIdForComposite = eventId;
		return false;
	}

	private unsafe bool IsConflictingInput(ref TriggerState trigger, int actionIndex)
	{
		TriggerState* ptr = actionStates + actionIndex;
		if (!ptr->mayNeedConflictResolution)
		{
			return false;
		}
		int num = trigger.controlIndex;
		if (bindingStates[trigger.bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[trigger.bindingIndex].compositeOrCompositeBindingIndex;
			num = bindingStates[compositeOrCompositeBindingIndex].controlStartIndex;
		}
		int num2 = ptr->controlIndex;
		if (bindingStates[ptr->bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex2 = bindingStates[ptr->bindingIndex].compositeOrCompositeBindingIndex;
			num2 = bindingStates[compositeOrCompositeBindingIndex2].controlStartIndex;
		}
		if (num2 == -1)
		{
			ptr->magnitude = trigger.magnitude;
			return false;
		}
		bool flag = num == num2 || controls[num] == controls[num2];
		if (trigger.magnitude > ptr->magnitude)
		{
			if (trigger.magnitude > 0f && !flag && ptr->magnitude > 0f)
			{
				ptr->hasMultipleConcurrentActuations = true;
			}
			ptr->magnitude = trigger.magnitude;
			return false;
		}
		if (trigger.magnitude < ptr->magnitude)
		{
			if (!flag)
			{
				if (trigger.magnitude > 0f)
				{
					ptr->hasMultipleConcurrentActuations = true;
				}
				return true;
			}
			if (!ptr->hasMultipleConcurrentActuations)
			{
				ptr->magnitude = trigger.magnitude;
				return false;
			}
			ushort actionBindingStartIndexAndCount = GetActionBindingStartIndexAndCount(actionIndex, out var bindingCount);
			float num3 = trigger.magnitude;
			int num4 = -1;
			int num5 = -1;
			int num6 = 0;
			for (int i = 0; i < bindingCount; i++)
			{
				ushort num7 = memory.actionBindingIndices[actionBindingStartIndexAndCount + i];
				BindingState* ptr2 = memory.bindingStates + (int)num7;
				if (ptr2->isComposite)
				{
					int controlStartIndex = ptr2->controlStartIndex;
					int compositeOrCompositeBindingIndex3 = ptr2->compositeOrCompositeBindingIndex;
					float num8 = memory.compositeMagnitudes[compositeOrCompositeBindingIndex3];
					if (num8 > 0f)
					{
						num6++;
					}
					if (num8 > num3)
					{
						num4 = controlStartIndex;
						num5 = controlIndexToBindingIndex[controlStartIndex];
						num3 = num8;
					}
				}
				else
				{
					if (ptr2->isPartOfComposite)
					{
						continue;
					}
					for (int j = 0; j < ptr2->controlCount; j++)
					{
						int num9 = ptr2->controlStartIndex + j;
						float num10 = memory.controlMagnitudes[num9];
						if (num10 > 0f)
						{
							num6++;
						}
						if (num10 > num3)
						{
							num4 = num9;
							num5 = num7;
							num3 = num10;
						}
					}
				}
			}
			if (num6 <= 1)
			{
				ptr->hasMultipleConcurrentActuations = false;
			}
			if (num4 != -1)
			{
				trigger.controlIndex = num4;
				trigger.bindingIndex = num5;
				trigger.magnitude = num3;
				if (ptr->bindingIndex != num5)
				{
					if (ptr->interactionIndex != -1)
					{
						ResetInteractionState(ptr->interactionIndex);
					}
					BindingState* num11 = bindingStates + num5;
					int interactionCount = num11->interactionCount;
					int interactionStartIndex = num11->interactionStartIndex;
					for (int k = 0; k < interactionCount; k++)
					{
						if (interactionStates[interactionStartIndex + k].phase.IsInProgress())
						{
							ptr->interactionIndex = interactionStartIndex + k;
							trigger.interactionIndex = interactionStartIndex + k;
							break;
						}
					}
				}
				ptr->controlIndex = num4;
				ptr->bindingIndex = num5;
				ptr->magnitude = num3;
				return false;
			}
		}
		if (!flag && Mathf.Approximately(trigger.magnitude, ptr->magnitude))
		{
			if (trigger.magnitude > 0f)
			{
				ptr->hasMultipleConcurrentActuations = true;
			}
			return true;
		}
		return false;
	}

	private unsafe ushort GetActionBindingStartIndexAndCount(int actionIndex, out ushort bindingCount)
	{
		bindingCount = memory.actionBindingIndicesAndCounts[actionIndex * 2 + 1];
		return memory.actionBindingIndicesAndCounts[actionIndex * 2];
	}

	private unsafe void ProcessDefaultInteraction(ref TriggerState trigger, int actionIndex)
	{
		TriggerState* ptr = actionStates + actionIndex;
		switch (ptr->phase)
		{
		case InputActionPhase.Waiting:
			if (trigger.isPassThrough)
			{
				ChangePhaseOfAction(InputActionPhase.Performed, ref trigger);
			}
			else if (trigger.isButton)
			{
				float magnitude3 = trigger.magnitude;
				if (magnitude3 > 0f)
				{
					ChangePhaseOfAction(InputActionPhase.Started, ref trigger);
				}
				float num4 = ((controls[trigger.controlIndex] is ButtonControl buttonControl3) ? buttonControl3.pressPointOrDefault : ButtonControl.s_GlobalDefaultButtonPressPoint);
				if (magnitude3 >= num4)
				{
					ChangePhaseOfAction(InputActionPhase.Performed, ref trigger, InputActionPhase.Performed);
				}
			}
			else if (IsActuated(ref trigger))
			{
				ChangePhaseOfAction(InputActionPhase.Started, ref trigger);
				ChangePhaseOfAction(InputActionPhase.Performed, ref trigger, InputActionPhase.Started);
			}
			break;
		case InputActionPhase.Started:
			if (ptr->isButton)
			{
				float magnitude2 = trigger.magnitude;
				float num3 = ((controls[trigger.controlIndex] is ButtonControl buttonControl2) ? buttonControl2.pressPointOrDefault : ButtonControl.s_GlobalDefaultButtonPressPoint);
				if (magnitude2 >= num3)
				{
					ChangePhaseOfAction(InputActionPhase.Performed, ref trigger, InputActionPhase.Performed);
				}
				else if (Mathf.Approximately(magnitude2, 0f))
				{
					ChangePhaseOfAction(InputActionPhase.Canceled, ref trigger);
				}
			}
			else if (!IsActuated(ref trigger))
			{
				ChangePhaseOfAction(InputActionPhase.Canceled, ref trigger);
			}
			else
			{
				ChangePhaseOfAction(InputActionPhase.Performed, ref trigger, InputActionPhase.Started);
			}
			break;
		case InputActionPhase.Performed:
			if (ptr->isButton)
			{
				float magnitude = trigger.magnitude;
				float num = ((controls[trigger.controlIndex] is ButtonControl buttonControl) ? buttonControl.pressPointOrDefault : ButtonControl.s_GlobalDefaultButtonPressPoint);
				if (Mathf.Approximately(0f, magnitude))
				{
					ChangePhaseOfAction(InputActionPhase.Canceled, ref trigger);
					break;
				}
				float num2 = num * ButtonControl.s_GlobalDefaultButtonReleaseThreshold;
				if (magnitude <= num2)
				{
					ChangePhaseOfAction(InputActionPhase.Started, ref trigger);
				}
			}
			else if (ptr->isPassThrough)
			{
				ChangePhaseOfAction(InputActionPhase.Performed, ref trigger, InputActionPhase.Performed);
			}
			break;
		}
	}

	private unsafe void ProcessInteractions(ref TriggerState trigger, int interactionStartIndex, int interactionCount)
	{
		InputInteractionContext context = new InputInteractionContext
		{
			m_State = this,
			m_TriggerState = trigger
		};
		for (int i = 0; i < interactionCount; i++)
		{
			int num = interactionStartIndex + i;
			InteractionState interactionState = interactionStates[num];
			IInputInteraction obj = interactions[num];
			context.m_TriggerState.phase = interactionState.phase;
			context.m_TriggerState.startTime = interactionState.startTime;
			context.m_TriggerState.interactionIndex = num;
			obj.Process(ref context);
		}
	}

	private unsafe void ProcessTimeout(double time, int mapIndex, int controlIndex, int bindingIndex, int interactionIndex)
	{
		ref InteractionState reference = ref interactionStates[interactionIndex];
		InputInteractionContext context = new InputInteractionContext
		{
			m_State = this,
			m_TriggerState = new TriggerState
			{
				phase = reference.phase,
				time = time,
				mapIndex = mapIndex,
				controlIndex = controlIndex,
				bindingIndex = bindingIndex,
				interactionIndex = interactionIndex,
				startTime = reference.startTime
			},
			timerHasExpired = true
		};
		reference.isTimerRunning = false;
		reference.totalTimeoutCompletionTimeRemaining = Mathf.Max(reference.totalTimeoutCompletionTimeRemaining - reference.timerDuration, 0f);
		reference.timerDuration = 0f;
		interactions[interactionIndex].Process(ref context);
	}

	internal unsafe void SetTotalTimeoutCompletionTime(float seconds, ref TriggerState trigger)
	{
		InteractionState* num = interactionStates + trigger.interactionIndex;
		num->totalTimeoutCompletionDone = 0f;
		num->totalTimeoutCompletionTimeRemaining = seconds;
	}

	internal unsafe void StartTimeout(float seconds, ref TriggerState trigger)
	{
		InputManager s_Manager = InputSystem.s_Manager;
		double time = trigger.time;
		InputControl control = controls[trigger.controlIndex];
		int interactionIndex = trigger.interactionIndex;
		long num = ToCombinedMapAndControlAndBindingIndex(trigger.mapIndex, trigger.controlIndex, trigger.bindingIndex);
		InteractionState* num2 = interactionStates + interactionIndex;
		if (num2->isTimerRunning)
		{
			StopTimeout(interactionIndex);
		}
		s_Manager.AddStateChangeMonitorTimeout(control, this, time + (double)seconds, num, interactionIndex);
		num2->isTimerRunning = true;
		num2->timerStartTime = time;
		num2->timerDuration = seconds;
		num2->timerMonitorIndex = num;
	}

	private unsafe void StopTimeout(int interactionIndex)
	{
		ref InteractionState reference = ref interactionStates[interactionIndex];
		InputSystem.s_Manager.RemoveStateChangeMonitorTimeout(this, reference.timerMonitorIndex, interactionIndex);
		reference.isTimerRunning = false;
		reference.totalTimeoutCompletionDone += reference.timerDuration;
		reference.totalTimeoutCompletionTimeRemaining = Mathf.Max(reference.totalTimeoutCompletionTimeRemaining - reference.timerDuration, 0f);
		reference.timerDuration = 0f;
		reference.timerStartTime = 0.0;
		reference.timerMonitorIndex = 0L;
	}

	internal unsafe void ChangePhaseOfInteraction(InputActionPhase newPhase, ref TriggerState trigger, InputActionPhase phaseAfterPerformed = InputActionPhase.Waiting, bool processNextInteractionOnCancel = true)
	{
		int interactionIndex = trigger.interactionIndex;
		int bindingIndex = trigger.bindingIndex;
		InputActionPhase phaseAfterPerformedOrCanceled = InputActionPhase.Waiting;
		if (newPhase == InputActionPhase.Performed)
		{
			phaseAfterPerformedOrCanceled = phaseAfterPerformed;
		}
		ref InteractionState reference = ref interactionStates[interactionIndex];
		if (reference.isTimerRunning)
		{
			StopTimeout(trigger.interactionIndex);
		}
		reference.phase = newPhase;
		reference.triggerControlIndex = trigger.controlIndex;
		reference.startTime = trigger.startTime;
		if (newPhase == InputActionPhase.Performed)
		{
			reference.performedTime = trigger.time;
		}
		int actionIndex = bindingStates[bindingIndex].actionIndex;
		if (actionIndex != -1)
		{
			if (actionStates[actionIndex].phase == InputActionPhase.Waiting)
			{
				if (!ChangePhaseOfAction(newPhase, ref trigger, phaseAfterPerformedOrCanceled))
				{
					return;
				}
			}
			else if (newPhase == InputActionPhase.Canceled && actionStates[actionIndex].interactionIndex == trigger.interactionIndex)
			{
				if (!ChangePhaseOfAction(newPhase, ref trigger) || !processNextInteractionOnCancel)
				{
					return;
				}
				int interactionStartIndex = bindingStates[bindingIndex].interactionStartIndex;
				int interactionCount = bindingStates[bindingIndex].interactionCount;
				for (int i = 0; i < interactionCount; i++)
				{
					int num = interactionStartIndex + i;
					if (num == trigger.interactionIndex || (interactionStates[num].phase != InputActionPhase.Started && interactionStates[num].phase != InputActionPhase.Performed))
					{
						continue;
					}
					double startTime = interactionStates[num].startTime;
					TriggerState trigger2 = new TriggerState
					{
						phase = InputActionPhase.Started,
						controlIndex = interactionStates[num].triggerControlIndex,
						bindingIndex = trigger.bindingIndex,
						interactionIndex = num,
						mapIndex = trigger.mapIndex,
						time = startTime,
						startTime = startTime
					};
					if (ChangePhaseOfAction(InputActionPhase.Started, ref trigger2))
					{
						if (interactionStates[num].phase != InputActionPhase.Performed)
						{
							break;
						}
						trigger2 = new TriggerState
						{
							phase = InputActionPhase.Performed,
							controlIndex = interactionStates[num].triggerControlIndex,
							bindingIndex = trigger.bindingIndex,
							interactionIndex = num,
							mapIndex = trigger.mapIndex,
							time = interactionStates[num].performedTime,
							startTime = startTime
						};
						if (ChangePhaseOfAction(InputActionPhase.Performed, ref trigger2))
						{
							break;
						}
					}
					return;
				}
			}
			else if (actionStates[actionIndex].interactionIndex == trigger.interactionIndex)
			{
				if (!ChangePhaseOfAction(newPhase, ref trigger, phaseAfterPerformedOrCanceled))
				{
					return;
				}
				if (newPhase == InputActionPhase.Performed)
				{
					int interactionStartIndex2 = bindingStates[bindingIndex].interactionStartIndex;
					int interactionCount2 = bindingStates[bindingIndex].interactionCount;
					for (int j = 0; j < interactionCount2; j++)
					{
						int num2 = interactionStartIndex2 + j;
						if (num2 != trigger.interactionIndex)
						{
							ResetInteractionState(num2);
						}
					}
				}
			}
		}
		if (newPhase != InputActionPhase.Performed || actionStates[actionIndex].interactionIndex == trigger.interactionIndex)
		{
			if (newPhase == InputActionPhase.Performed && phaseAfterPerformed != InputActionPhase.Waiting)
			{
				reference.phase = phaseAfterPerformed;
			}
			else if (newPhase == InputActionPhase.Performed || newPhase == InputActionPhase.Canceled)
			{
				ResetInteractionState(trigger.interactionIndex);
			}
		}
	}

	private unsafe bool ChangePhaseOfAction(InputActionPhase newPhase, ref TriggerState trigger, InputActionPhase phaseAfterPerformedOrCanceled = InputActionPhase.Waiting)
	{
		int actionIndex = bindingStates[trigger.bindingIndex].actionIndex;
		if (actionIndex == -1)
		{
			return true;
		}
		TriggerState* ptr = actionStates + actionIndex;
		if (ptr->isDisabled)
		{
			return true;
		}
		ptr->inProcessing = true;
		try
		{
			if (ptr->isPassThrough && trigger.interactionIndex == -1)
			{
				ChangePhaseOfActionInternal(actionIndex, ptr, newPhase, ref trigger);
				if (!ptr->inProcessing)
				{
					return false;
				}
			}
			else if (newPhase == InputActionPhase.Performed && ptr->phase == InputActionPhase.Waiting)
			{
				ChangePhaseOfActionInternal(actionIndex, ptr, InputActionPhase.Started, ref trigger);
				if (!ptr->inProcessing)
				{
					return false;
				}
				ChangePhaseOfActionInternal(actionIndex, ptr, newPhase, ref trigger);
				if (!ptr->inProcessing)
				{
					return false;
				}
				if (phaseAfterPerformedOrCanceled == InputActionPhase.Waiting)
				{
					ChangePhaseOfActionInternal(actionIndex, ptr, InputActionPhase.Canceled, ref trigger);
				}
				if (!ptr->inProcessing)
				{
					return false;
				}
				ptr->phase = phaseAfterPerformedOrCanceled;
			}
			else if (ptr->phase != newPhase || newPhase == InputActionPhase.Performed)
			{
				ChangePhaseOfActionInternal(actionIndex, ptr, newPhase, ref trigger);
				if (!ptr->inProcessing)
				{
					return false;
				}
				if (newPhase == InputActionPhase.Performed || newPhase == InputActionPhase.Canceled)
				{
					ptr->phase = phaseAfterPerformedOrCanceled;
				}
			}
		}
		finally
		{
			ptr->inProcessing = false;
		}
		if (ptr->phase == InputActionPhase.Waiting)
		{
			ptr->controlIndex = -1;
			ptr->flags &= ~TriggerState.Flags.HaveMagnitude;
		}
		return true;
	}

	private unsafe void ChangePhaseOfActionInternal(int actionIndex, TriggerState* actionState, InputActionPhase newPhase, ref TriggerState trigger)
	{
		TriggerState triggerState = trigger;
		triggerState.flags = actionState->flags;
		if (newPhase != InputActionPhase.Canceled)
		{
			triggerState.magnitude = trigger.magnitude;
		}
		else
		{
			triggerState.magnitude = 0f;
		}
		triggerState.phase = newPhase;
		switch (newPhase)
		{
		case InputActionPhase.Performed:
			triggerState.lastPerformedInUpdate = InputUpdate.s_UpdateStepCount;
			triggerState.lastCanceledInUpdate = actionState->lastCanceledInUpdate;
			if (controlGroupingAndComplexity[trigger.controlIndex * 2 + 1] > 1 && m_CurrentlyProcessingThisEvent.valid)
			{
				m_CurrentlyProcessingThisEvent.handled = true;
			}
			break;
		case InputActionPhase.Canceled:
			triggerState.lastCanceledInUpdate = InputUpdate.s_UpdateStepCount;
			triggerState.lastPerformedInUpdate = actionState->lastPerformedInUpdate;
			break;
		default:
			triggerState.lastPerformedInUpdate = actionState->lastPerformedInUpdate;
			triggerState.lastCanceledInUpdate = actionState->lastCanceledInUpdate;
			break;
		}
		triggerState.pressedInUpdate = actionState->pressedInUpdate;
		triggerState.releasedInUpdate = actionState->releasedInUpdate;
		if (newPhase == InputActionPhase.Started)
		{
			triggerState.startTime = triggerState.time;
		}
		*actionState = triggerState;
		InputActionMap inputActionMap = maps[trigger.mapIndex];
		InputAction inputAction = inputActionMap.m_Actions[actionIndex - mapIndices[trigger.mapIndex].actionStartIndex];
		trigger.phase = newPhase;
		switch (newPhase)
		{
		case InputActionPhase.Started:
			CallActionListeners(actionIndex, inputActionMap, newPhase, ref inputAction.m_OnStarted, "started");
			break;
		case InputActionPhase.Performed:
			CallActionListeners(actionIndex, inputActionMap, newPhase, ref inputAction.m_OnPerformed, "performed");
			break;
		case InputActionPhase.Canceled:
			CallActionListeners(actionIndex, inputActionMap, newPhase, ref inputAction.m_OnCanceled, "canceled");
			break;
		}
	}

	private void CallActionListeners(int actionIndex, InputActionMap actionMap, InputActionPhase phase, ref CallbackArray<Action<InputAction.CallbackContext>> listeners, string callbackName)
	{
		CallbackArray<Action<InputAction.CallbackContext>> callbacks = actionMap.m_ActionCallbacks;
		if (listeners.length == 0 && callbacks.length == 0 && s_GlobalState.onActionChange.length == 0)
		{
			return;
		}
		InputAction.CallbackContext argument = new InputAction.CallbackContext
		{
			m_State = this,
			m_ActionIndex = actionIndex
		};
		InputAction action = argument.action;
		if (s_GlobalState.onActionChange.length > 0)
		{
			InputActionChange argument2;
			switch (phase)
			{
			default:
				return;
			case InputActionPhase.Started:
				argument2 = InputActionChange.ActionStarted;
				break;
			case InputActionPhase.Performed:
				argument2 = InputActionChange.ActionPerformed;
				break;
			case InputActionPhase.Canceled:
				argument2 = InputActionChange.ActionCanceled;
				break;
			}
			DelegateHelpers.InvokeCallbacksSafe(ref s_GlobalState.onActionChange, action, argument2, "InputSystem.onActionChange");
		}
		DelegateHelpers.InvokeCallbacksSafe(ref listeners, argument, callbackName, action);
		DelegateHelpers.InvokeCallbacksSafe(ref callbacks, argument, callbackName, actionMap);
	}

	private object GetActionOrNoneString(ref TriggerState trigger)
	{
		InputAction actionOrNull = GetActionOrNull(ref trigger);
		if (actionOrNull == null)
		{
			return "<none>";
		}
		return actionOrNull;
	}

	internal unsafe InputAction GetActionOrNull(int bindingIndex)
	{
		int actionIndex = bindingStates[bindingIndex].actionIndex;
		if (actionIndex == -1)
		{
			return null;
		}
		int mapIndex = bindingStates[bindingIndex].mapIndex;
		int actionStartIndex = mapIndices[mapIndex].actionStartIndex;
		return maps[mapIndex].m_Actions[actionIndex - actionStartIndex];
	}

	internal unsafe InputAction GetActionOrNull(ref TriggerState trigger)
	{
		int actionIndex = bindingStates[trigger.bindingIndex].actionIndex;
		if (actionIndex == -1)
		{
			return null;
		}
		int actionStartIndex = mapIndices[trigger.mapIndex].actionStartIndex;
		return maps[trigger.mapIndex].m_Actions[actionIndex - actionStartIndex];
	}

	internal InputControl GetControl(ref TriggerState trigger)
	{
		return controls[trigger.controlIndex];
	}

	private IInputInteraction GetInteractionOrNull(ref TriggerState trigger)
	{
		if (trigger.interactionIndex == -1)
		{
			return null;
		}
		return interactions[trigger.interactionIndex];
	}

	internal unsafe int GetBindingIndexInMap(int bindingIndex)
	{
		int mapIndex = bindingStates[bindingIndex].mapIndex;
		int bindingStartIndex = mapIndices[mapIndex].bindingStartIndex;
		return bindingIndex - bindingStartIndex;
	}

	internal unsafe int GetBindingIndexInState(int mapIndex, int bindingIndexInMap)
	{
		return mapIndices[mapIndex].bindingStartIndex + bindingIndexInMap;
	}

	internal unsafe ref BindingState GetBindingState(int bindingIndex)
	{
		return ref bindingStates[bindingIndex];
	}

	internal unsafe ref InputBinding GetBinding(int bindingIndex)
	{
		int mapIndex = bindingStates[bindingIndex].mapIndex;
		int bindingStartIndex = mapIndices[mapIndex].bindingStartIndex;
		return ref maps[mapIndex].m_Bindings[bindingIndex - bindingStartIndex];
	}

	internal unsafe InputActionMap GetActionMap(int bindingIndex)
	{
		int mapIndex = bindingStates[bindingIndex].mapIndex;
		return maps[mapIndex];
	}

	private unsafe void ResetInteractionStateAndCancelIfNecessary(int mapIndex, int bindingIndex, int interactionIndex)
	{
		int actionIndex = bindingStates[bindingIndex].actionIndex;
		if (actionStates[actionIndex].interactionIndex == interactionIndex)
		{
			InputActionPhase phase = interactionStates[interactionIndex].phase;
			if ((uint)(phase - 2) <= 1u)
			{
				ChangePhaseOfInteraction(InputActionPhase.Canceled, ref actionStates[actionIndex], InputActionPhase.Waiting, processNextInteractionOnCancel: false);
			}
			actionStates[actionIndex].interactionIndex = -1;
		}
		ResetInteractionState(interactionIndex);
	}

	private unsafe void ResetInteractionState(int interactionIndex)
	{
		interactions[interactionIndex].Reset();
		if (interactionStates[interactionIndex].isTimerRunning)
		{
			StopTimeout(interactionIndex);
		}
		interactionStates[interactionIndex] = new InteractionState
		{
			phase = InputActionPhase.Waiting,
			triggerControlIndex = -1
		};
	}

	internal unsafe int GetValueSizeInBytes(int bindingIndex, int controlIndex)
	{
		if (bindingStates[bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[bindingIndex].compositeOrCompositeBindingIndex;
			int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
			return composites[compositeOrCompositeBindingIndex2].valueSizeInBytes;
		}
		return controls[controlIndex].valueSizeInBytes;
	}

	internal unsafe Type GetValueType(int bindingIndex, int controlIndex)
	{
		if (bindingStates[bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[bindingIndex].compositeOrCompositeBindingIndex;
			int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
			return composites[compositeOrCompositeBindingIndex2].valueType;
		}
		return controls[controlIndex].valueType;
	}

	internal static bool IsActuated(ref TriggerState trigger, float threshold = 0f)
	{
		float magnitude = trigger.magnitude;
		if (magnitude < 0f)
		{
			return true;
		}
		if (Mathf.Approximately(threshold, 0f))
		{
			return magnitude > 0f;
		}
		return magnitude >= threshold;
	}

	internal unsafe void ReadValue(int bindingIndex, int controlIndex, void* buffer, int bufferSize, bool ignoreComposites = false)
	{
		InputControl control = null;
		if (!ignoreComposites && bindingStates[bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[bindingIndex].compositeOrCompositeBindingIndex;
			int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
			InputBindingComposite obj = composites[compositeOrCompositeBindingIndex2];
			InputBindingCompositeContext context = new InputBindingCompositeContext
			{
				m_State = this,
				m_BindingIndex = compositeOrCompositeBindingIndex
			};
			obj.ReadValue(ref context, buffer, bufferSize);
			bindingIndex = compositeOrCompositeBindingIndex;
		}
		else
		{
			control = controls[controlIndex];
			control.ReadValueIntoBuffer(buffer, bufferSize);
		}
		int processorCount = bindingStates[bindingIndex].processorCount;
		if (processorCount > 0)
		{
			int processorStartIndex = bindingStates[bindingIndex].processorStartIndex;
			for (int i = 0; i < processorCount; i++)
			{
				processors[processorStartIndex + i].Process(buffer, bufferSize, control);
			}
		}
	}

	internal unsafe TValue ReadValue<TValue>(int bindingIndex, int controlIndex, bool ignoreComposites = false) where TValue : struct
	{
		TValue output = default(TValue);
		InputControl<TValue> inputControl = null;
		if (!ignoreComposites && bindingStates[bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[bindingIndex].compositeOrCompositeBindingIndex;
			int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
			InputBindingComposite inputBindingComposite = composites[compositeOrCompositeBindingIndex2];
			InputBindingCompositeContext context = new InputBindingCompositeContext
			{
				m_State = this,
				m_BindingIndex = compositeOrCompositeBindingIndex
			};
			if (!(inputBindingComposite is InputBindingComposite<TValue> inputBindingComposite2))
			{
				Type valueType = inputBindingComposite.valueType;
				if (!valueType.IsAssignableFrom(typeof(TValue)))
				{
					throw new InvalidOperationException($"Cannot read value of type '{typeof(TValue).Name}' from composite '{inputBindingComposite}' bound to action '{GetActionOrNull(bindingIndex)}' (composite is a '{compositeOrCompositeBindingIndex2.GetType().Name}' with value type '{valueType.GetNiceTypeName()}')");
				}
				inputBindingComposite.ReadValue(ref context, UnsafeUtility.AddressOf(ref output), UnsafeUtility.SizeOf<TValue>());
			}
			else
			{
				output = inputBindingComposite2.ReadValue(ref context);
			}
			bindingIndex = compositeOrCompositeBindingIndex;
		}
		else if (controlIndex != -1)
		{
			InputControl inputControl2 = controls[controlIndex];
			inputControl = inputControl2 as InputControl<TValue>;
			if (inputControl == null)
			{
				throw new InvalidOperationException($"Cannot read value of type '{typeof(TValue).GetNiceTypeName()}' from control '{inputControl2.path}' bound to action '{GetActionOrNull(bindingIndex)}' (control is a '{inputControl2.GetType().Name}' with value type '{inputControl2.valueType.GetNiceTypeName()}')");
			}
			output = inputControl.value;
		}
		return ApplyProcessors(bindingIndex, output, inputControl);
	}

	internal unsafe TValue ApplyProcessors<TValue>(int bindingIndex, TValue value, InputControl<TValue> controlOfType = null) where TValue : struct
	{
		int processorCount = bindingStates[bindingIndex].processorCount;
		if (processorCount > 0)
		{
			int processorStartIndex = bindingStates[bindingIndex].processorStartIndex;
			for (int i = 0; i < processorCount; i++)
			{
				if (processors[processorStartIndex + i] is InputProcessor<TValue> inputProcessor)
				{
					value = inputProcessor.Process(value, controlOfType);
				}
			}
		}
		return value;
	}

	public unsafe float EvaluateCompositePartMagnitude(int bindingIndex, int partNumber)
	{
		int num = bindingIndex + 1;
		float num2 = float.MinValue;
		for (int i = num; i < totalBindingCount && bindingStates[i].isPartOfComposite; i++)
		{
			if (bindingStates[i].partIndex == partNumber)
			{
				int controlCount = bindingStates[i].controlCount;
				int controlStartIndex = bindingStates[i].controlStartIndex;
				for (int j = 0; j < controlCount; j++)
				{
					num2 = Mathf.Max(controls[controlStartIndex + j].magnitude, num2);
				}
			}
		}
		return num2;
	}

	internal unsafe double GetCompositePartPressTime(int bindingIndex, int partNumber)
	{
		int num = bindingIndex + 1;
		double num2 = double.MaxValue;
		for (int i = num; i < totalBindingCount && bindingStates[i].isPartOfComposite; i++)
		{
			ref BindingState reference = ref bindingStates[i];
			if (reference.partIndex == partNumber && reference.pressTime != 0.0 && reference.pressTime < num2)
			{
				num2 = reference.pressTime;
			}
		}
		if (num2 == double.MaxValue)
		{
			return -1.0;
		}
		return num2;
	}

	internal unsafe TValue ReadCompositePartValue<TValue, TComparer>(int bindingIndex, int partNumber, bool* buttonValuePtr, out int controlIndex, TComparer comparer = default(TComparer)) where TValue : struct where TComparer : IComparer<TValue>
	{
		TValue val = default(TValue);
		int num = bindingIndex + 1;
		bool flag = true;
		controlIndex = -1;
		for (int i = num; i < totalBindingCount && bindingStates[i].isPartOfComposite; i++)
		{
			if (bindingStates[i].partIndex != partNumber)
			{
				continue;
			}
			int controlCount = bindingStates[i].controlCount;
			int controlStartIndex = bindingStates[i].controlStartIndex;
			for (int j = 0; j < controlCount; j++)
			{
				int num2 = controlStartIndex + j;
				TValue output = ReadValue<TValue>(i, num2, ignoreComposites: true);
				if (flag)
				{
					val = output;
					controlIndex = num2;
					flag = false;
				}
				else if (comparer.Compare(output, val) > 0)
				{
					val = output;
					controlIndex = num2;
				}
				if (buttonValuePtr != null && controlIndex == num2)
				{
					InputControl inputControl = controls[num2];
					if (inputControl is ButtonControl buttonControl)
					{
						*buttonValuePtr = buttonControl.isPressed;
					}
					else if (inputControl is InputControl<float>)
					{
						void* ptr = UnsafeUtility.AddressOf(ref output);
						*buttonValuePtr = *(float*)ptr >= ButtonControl.s_GlobalDefaultButtonPressPoint;
					}
				}
			}
		}
		return val;
	}

	internal unsafe bool ReadCompositePartValue(int bindingIndex, int partNumber, void* buffer, int bufferSize)
	{
		int num = bindingIndex + 1;
		float num2 = float.MinValue;
		for (int i = num; i < totalBindingCount && bindingStates[i].isPartOfComposite; i++)
		{
			if (bindingStates[i].partIndex != partNumber)
			{
				continue;
			}
			int controlCount = bindingStates[i].controlCount;
			int controlStartIndex = bindingStates[i].controlStartIndex;
			for (int j = 0; j < controlCount; j++)
			{
				int num3 = controlStartIndex + j;
				float magnitude = controls[num3].magnitude;
				if (!(magnitude < num2))
				{
					ReadValue(i, num3, buffer, bufferSize, ignoreComposites: true);
					num2 = magnitude;
				}
			}
		}
		return num2 > float.MinValue;
	}

	internal unsafe object ReadCompositePartValueAsObject(int bindingIndex, int partNumber)
	{
		int num = bindingIndex + 1;
		float num2 = float.MinValue;
		object result = null;
		for (int i = num; i < totalBindingCount && bindingStates[i].isPartOfComposite; i++)
		{
			if (bindingStates[i].partIndex != partNumber)
			{
				continue;
			}
			int controlCount = bindingStates[i].controlCount;
			int controlStartIndex = bindingStates[i].controlStartIndex;
			for (int j = 0; j < controlCount; j++)
			{
				int num3 = controlStartIndex + j;
				float magnitude = controls[num3].magnitude;
				if (!(magnitude < num2))
				{
					result = ReadValueAsObject(i, num3, ignoreComposites: true);
					num2 = magnitude;
				}
			}
		}
		return result;
	}

	internal unsafe object ReadValueAsObject(int bindingIndex, int controlIndex, bool ignoreComposites = false)
	{
		InputControl control = null;
		object obj = null;
		if (!ignoreComposites && bindingStates[bindingIndex].isPartOfComposite)
		{
			int compositeOrCompositeBindingIndex = bindingStates[bindingIndex].compositeOrCompositeBindingIndex;
			int compositeOrCompositeBindingIndex2 = bindingStates[compositeOrCompositeBindingIndex].compositeOrCompositeBindingIndex;
			InputBindingComposite obj2 = composites[compositeOrCompositeBindingIndex2];
			InputBindingCompositeContext context = new InputBindingCompositeContext
			{
				m_State = this,
				m_BindingIndex = compositeOrCompositeBindingIndex
			};
			obj = obj2.ReadValueAsObject(ref context);
			bindingIndex = compositeOrCompositeBindingIndex;
		}
		else if (controlIndex != -1)
		{
			control = controls[controlIndex];
			obj = control.ReadValueAsObject();
		}
		if (obj != null)
		{
			int processorCount = bindingStates[bindingIndex].processorCount;
			if (processorCount > 0)
			{
				int processorStartIndex = bindingStates[bindingIndex].processorStartIndex;
				for (int i = 0; i < processorCount; i++)
				{
					obj = processors[processorStartIndex + i].ProcessAsObject(obj, control);
				}
			}
		}
		return obj;
	}

	internal unsafe bool ReadValueAsButton(int bindingIndex, int controlIndex)
	{
		ButtonControl buttonControl = null;
		if (!bindingStates[bindingIndex].isPartOfComposite)
		{
			buttonControl = controls[controlIndex] as ButtonControl;
		}
		float num = ReadValue<float>(bindingIndex, controlIndex);
		if (buttonControl != null)
		{
			return num >= buttonControl.pressPointOrDefault;
		}
		return num >= ButtonControl.s_GlobalDefaultButtonPressPoint;
	}

	internal static ISavedState SaveAndResetState()
	{
		SavedStructState<GlobalState> result = new SavedStructState<GlobalState>(ref s_GlobalState, delegate(ref GlobalState state)
		{
			s_GlobalState = state;
		}, delegate
		{
			ResetGlobals();
		});
		s_GlobalState = default(GlobalState);
		return result;
	}

	private void AddToGlobalList()
	{
		CompactGlobalList();
		GCHandle value = GCHandle.Alloc(this, GCHandleType.Weak);
		s_GlobalState.globalList.AppendWithCapacity(value);
	}

	private void RemoveMapFromGlobalList()
	{
		int length = s_GlobalState.globalList.length;
		for (int i = 0; i < length; i++)
		{
			if (s_GlobalState.globalList[i].Target == this)
			{
				s_GlobalState.globalList[i].Free();
				s_GlobalState.globalList.RemoveAtByMovingTailWithCapacity(i);
				break;
			}
		}
	}

	private static void CompactGlobalList()
	{
		int length = s_GlobalState.globalList.length;
		int num = 0;
		for (int i = 0; i < length; i++)
		{
			GCHandle value = s_GlobalState.globalList[i];
			if (value.IsAllocated && value.Target != null)
			{
				if (num != i)
				{
					s_GlobalState.globalList[num] = value;
				}
				num++;
			}
			else
			{
				if (value.IsAllocated)
				{
					s_GlobalState.globalList[i].Free();
				}
				s_GlobalState.globalList[i] = default(GCHandle);
			}
		}
		s_GlobalState.globalList.length = num;
	}

	internal void NotifyListenersOfActionChange(InputActionChange change)
	{
		for (int i = 0; i < totalMapCount; i++)
		{
			InputActionMap inputActionMap = maps[i];
			if (inputActionMap.m_SingletonAction != null)
			{
				NotifyListenersOfActionChange(change, inputActionMap.m_SingletonAction);
				continue;
			}
			if (inputActionMap.m_Asset == null)
			{
				NotifyListenersOfActionChange(change, inputActionMap);
				continue;
			}
			NotifyListenersOfActionChange(change, inputActionMap.m_Asset);
			break;
		}
	}

	internal static void NotifyListenersOfActionChange(InputActionChange change, object actionOrMapOrAsset)
	{
		DelegateHelpers.InvokeCallbacksSafe(ref s_GlobalState.onActionChange, actionOrMapOrAsset, change, "onActionChange");
		if (change == InputActionChange.BoundControlsChanged)
		{
			DelegateHelpers.InvokeCallbacksSafe(ref s_GlobalState.onActionControlsChanged, actionOrMapOrAsset, "onActionControlsChange");
		}
	}

	private static void ResetGlobals()
	{
		DestroyAllActionMapStates();
		for (int i = 0; i < s_GlobalState.globalList.length; i++)
		{
			if (s_GlobalState.globalList[i].IsAllocated)
			{
				s_GlobalState.globalList[i].Free();
			}
		}
		s_GlobalState.globalList.length = 0;
		s_GlobalState.onActionChange.Clear();
		s_GlobalState.onActionControlsChanged.Clear();
	}

	internal unsafe static int FindAllEnabledActions(List<InputAction> result)
	{
		int num = 0;
		int length = s_GlobalState.globalList.length;
		for (int i = 0; i < length; i++)
		{
			GCHandle gCHandle = s_GlobalState.globalList[i];
			if (!gCHandle.IsAllocated)
			{
				continue;
			}
			InputActionState inputActionState = (InputActionState)gCHandle.Target;
			if (inputActionState == null)
			{
				continue;
			}
			int num2 = inputActionState.totalMapCount;
			InputActionMap[] array = inputActionState.maps;
			for (int j = 0; j < num2; j++)
			{
				InputActionMap inputActionMap = array[j];
				if (!inputActionMap.enabled)
				{
					continue;
				}
				InputAction[] actions = inputActionMap.m_Actions;
				int num3 = actions.Length;
				if (inputActionMap.m_EnabledActionsCount == num3)
				{
					result.AddRange(actions);
					num += num3;
					continue;
				}
				int actionStartIndex = inputActionState.mapIndices[inputActionMap.m_MapIndexInState].actionStartIndex;
				for (int k = 0; k < num3; k++)
				{
					if (inputActionState.actionStates[actionStartIndex + k].phase != InputActionPhase.Disabled)
					{
						result.Add(actions[k]);
						num++;
					}
				}
			}
		}
		return num;
	}

	internal static void OnDeviceChange(InputDevice device, InputDeviceChange change)
	{
		for (int i = 0; i < s_GlobalState.globalList.length; i++)
		{
			GCHandle gCHandle = s_GlobalState.globalList[i];
			if (!gCHandle.IsAllocated || gCHandle.Target == null)
			{
				if (gCHandle.IsAllocated)
				{
					s_GlobalState.globalList[i].Free();
				}
				s_GlobalState.globalList.RemoveAtWithCapacity(i);
				i--;
				continue;
			}
			InputActionState inputActionState = (InputActionState)gCHandle.Target;
			bool fullResolve = true;
			switch (change)
			{
			case InputDeviceChange.Added:
				if (!inputActionState.CanUseDevice(device))
				{
					continue;
				}
				fullResolve = false;
				break;
			case InputDeviceChange.Removed:
			{
				if (!inputActionState.IsUsingDevice(device))
				{
					continue;
				}
				for (int j = 0; j < inputActionState.totalMapCount; j++)
				{
					InputActionMap obj = inputActionState.maps[j];
					obj.m_Devices.Remove(device);
					obj.asset?.m_Devices.Remove(device);
				}
				fullResolve = false;
				break;
			}
			case InputDeviceChange.UsageChanged:
			case InputDeviceChange.ConfigurationChanged:
				if (!inputActionState.IsUsingDevice(device) && !inputActionState.CanUseDevice(device))
				{
					continue;
				}
				break;
			case InputDeviceChange.SoftReset:
			case InputDeviceChange.HardReset:
				if (inputActionState.IsUsingDevice(device))
				{
					inputActionState.ResetActionStatesDrivenBy(device);
				}
				continue;
			}
			for (int k = 0; k < inputActionState.totalMapCount && !inputActionState.maps[k].LazyResolveBindings(fullResolve); k++)
			{
			}
		}
	}

	internal static void DeferredResolutionOfBindings()
	{
		InputActionMap.s_DeferBindingResolution++;
		try
		{
			for (int i = 0; i < s_GlobalState.globalList.length; i++)
			{
				GCHandle gCHandle = s_GlobalState.globalList[i];
				if (!gCHandle.IsAllocated || gCHandle.Target == null)
				{
					if (gCHandle.IsAllocated)
					{
						s_GlobalState.globalList[i].Free();
					}
					s_GlobalState.globalList.RemoveAtWithCapacity(i);
					i--;
				}
				else
				{
					InputActionState inputActionState = (InputActionState)gCHandle.Target;
					for (int j = 0; j < inputActionState.totalMapCount; j++)
					{
						inputActionState.maps[j].ResolveBindingsIfNecessary();
					}
				}
			}
		}
		finally
		{
			InputActionMap.s_DeferBindingResolution--;
		}
	}

	internal static void DisableAllActions()
	{
		for (int i = 0; i < s_GlobalState.globalList.length; i++)
		{
			GCHandle gCHandle = s_GlobalState.globalList[i];
			if (gCHandle.IsAllocated && gCHandle.Target != null)
			{
				InputActionState obj = (InputActionState)gCHandle.Target;
				int num = obj.totalMapCount;
				InputActionMap[] array = obj.maps;
				for (int j = 0; j < num; j++)
				{
					array[j].Disable();
				}
			}
		}
	}

	internal static void DestroyAllActionMapStates()
	{
		while (s_GlobalState.globalList.length > 0)
		{
			int index = s_GlobalState.globalList.length - 1;
			GCHandle gCHandle = s_GlobalState.globalList[index];
			if (!gCHandle.IsAllocated || gCHandle.Target == null)
			{
				if (gCHandle.IsAllocated)
				{
					s_GlobalState.globalList[index].Free();
				}
				s_GlobalState.globalList.RemoveAtWithCapacity(index);
			}
			else
			{
				((InputActionState)gCHandle.Target).Destroy();
			}
		}
	}
}
