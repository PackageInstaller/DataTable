using System;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Serialization;

namespace UnityEngine.InputSystem;

[Serializable]
public sealed class InputAction : ICloneable, IDisposable
{
	[Flags]
	internal enum ActionFlags
	{
		WantsInitialStateCheck = 1
	}

	public struct CallbackContext
	{
		internal InputActionState m_State;

		internal int m_ActionIndex;

		private int actionIndex => m_ActionIndex;

		private unsafe int bindingIndex => m_State.actionStates[actionIndex].bindingIndex;

		private unsafe int controlIndex => m_State.actionStates[actionIndex].controlIndex;

		private unsafe int interactionIndex => m_State.actionStates[actionIndex].interactionIndex;

		public unsafe InputActionPhase phase
		{
			get
			{
				if (m_State == null)
				{
					return InputActionPhase.Disabled;
				}
				return m_State.actionStates[actionIndex].phase;
			}
		}

		public bool started => phase == InputActionPhase.Started;

		public bool performed => phase == InputActionPhase.Performed;

		public bool canceled => phase == InputActionPhase.Canceled;

		public InputAction action => m_State?.GetActionOrNull(bindingIndex);

		public InputControl control
		{
			get
			{
				InputActionState state = m_State;
				if (state == null)
				{
					return null;
				}
				return state.controls[controlIndex];
			}
		}

		public IInputInteraction interaction
		{
			get
			{
				if (m_State == null)
				{
					return null;
				}
				int num = interactionIndex;
				if (num == -1)
				{
					return null;
				}
				return m_State.interactions[num];
			}
		}

		public unsafe double time
		{
			get
			{
				if (m_State == null)
				{
					return 0.0;
				}
				return m_State.actionStates[actionIndex].time;
			}
		}

		public unsafe double startTime
		{
			get
			{
				if (m_State == null)
				{
					return 0.0;
				}
				return m_State.actionStates[actionIndex].startTime;
			}
		}

		public double duration => time - startTime;

		public Type valueType => m_State?.GetValueType(bindingIndex, controlIndex);

		public int valueSizeInBytes
		{
			get
			{
				if (m_State == null)
				{
					return 0;
				}
				return m_State.GetValueSizeInBytes(bindingIndex, controlIndex);
			}
		}

		public unsafe void ReadValue(void* buffer, int bufferSize)
		{
			if (buffer == null)
			{
				throw new ArgumentNullException("buffer");
			}
			if (m_State != null && phase.IsInProgress())
			{
				m_State.ReadValue(bindingIndex, controlIndex, buffer, bufferSize);
				return;
			}
			int num = valueSizeInBytes;
			if (bufferSize < num)
			{
				throw new ArgumentException($"Expected buffer of at least {num} bytes but got buffer of only {bufferSize} bytes", "bufferSize");
			}
			UnsafeUtility.MemClear(buffer, valueSizeInBytes);
		}

		public TValue ReadValue<TValue>() where TValue : struct
		{
			TValue val = default(TValue);
			if (m_State != null)
			{
				return phase.IsInProgress() ? m_State.ReadValue<TValue>(bindingIndex, controlIndex) : m_State.ApplyProcessors(bindingIndex, val);
			}
			return val;
		}

		public bool ReadValueAsButton()
		{
			bool result = false;
			if (m_State != null && phase.IsInProgress())
			{
				result = m_State.ReadValueAsButton(bindingIndex, controlIndex);
			}
			return result;
		}

		public object ReadValueAsObject()
		{
			if (m_State != null && phase.IsInProgress())
			{
				return m_State.ReadValueAsObject(bindingIndex, controlIndex);
			}
			return null;
		}

		public override string ToString()
		{
			return $"{{ action={action} phase={phase} time={time} control={control} value={ReadValueAsObject()} interaction={interaction} }}";
		}
	}

	[Tooltip("Human readable name of the action. Must be unique within its action map (case is ignored). Can be changed without breaking references to the action.")]
	[SerializeField]
	internal string m_Name;

	[SerializeField]
	[Tooltip("Determines how the action triggers.\n\nA Value action will start and perform when a control moves from its default value and then perform on every value change. It will cancel when controls go back to default value. Also, when enabled, a Value action will respond right away to a control's current value.\n\nA Button action will start when a button is pressed and perform when the press threshold (see 'Default Button Press Point' in settings) is reached. It will cancel when the button is going below the release threshold (see 'Button Release Threshold' in settings). Also, if a button is already pressed when the action is enabled, the button has to be released first.\n\nA Pass-Through action will not explicitly start and will never cancel. Instead, for every value change on any bound control, the action will perform.")]
	internal InputActionType m_Type;

	[FormerlySerializedAs("m_ExpectedControlLayout")]
	[SerializeField]
	[Tooltip("The type of control expected by the action (e.g. \"Button\" or \"Stick\"). This will limit the controls shown when setting up bindings in the UI and will also limit which controls can be bound interactively to the action.")]
	internal string m_ExpectedControlType;

	[SerializeField]
	[Tooltip("Unique ID of the action (GUID). Used to reference the action from bindings such that actions can be renamed without breaking references.")]
	internal string m_Id;

	[SerializeField]
	internal string m_Processors;

	[SerializeField]
	internal string m_Interactions;

	[SerializeField]
	internal InputBinding[] m_SingletonActionBindings;

	[SerializeField]
	internal ActionFlags m_Flags;

	[NonSerialized]
	internal InputBinding? m_BindingMask;

	[NonSerialized]
	internal int m_BindingsStartIndex;

	[NonSerialized]
	internal int m_BindingsCount;

	[NonSerialized]
	internal int m_ControlStartIndex;

	[NonSerialized]
	internal int m_ControlCount;

	[NonSerialized]
	internal int m_ActionIndexInState = -1;

	[NonSerialized]
	internal InputActionMap m_ActionMap;

	[NonSerialized]
	internal CallbackArray<Action<CallbackContext>> m_OnStarted;

	[NonSerialized]
	internal CallbackArray<Action<CallbackContext>> m_OnCanceled;

	[NonSerialized]
	internal CallbackArray<Action<CallbackContext>> m_OnPerformed;

	public string name => m_Name;

	public InputActionType type => m_Type;

	public Guid id
	{
		get
		{
			MakeSureIdIsInPlace();
			return new Guid(m_Id);
		}
	}

	internal Guid idDontGenerate
	{
		get
		{
			if (string.IsNullOrEmpty(m_Id))
			{
				return default(Guid);
			}
			return new Guid(m_Id);
		}
	}

	public string expectedControlType
	{
		get
		{
			return m_ExpectedControlType;
		}
		set
		{
			m_ExpectedControlType = value;
		}
	}

	public string processors => m_Processors;

	public string interactions => m_Interactions;

	public InputActionMap actionMap
	{
		get
		{
			if (!isSingletonAction)
			{
				return m_ActionMap;
			}
			return null;
		}
	}

	public InputBinding? bindingMask
	{
		get
		{
			return m_BindingMask;
		}
		set
		{
			if (!(value == m_BindingMask))
			{
				if (value.HasValue)
				{
					InputBinding value2 = value.Value;
					value2.action = name;
					value = value2;
				}
				m_BindingMask = value;
				InputActionMap orCreateActionMap = GetOrCreateActionMap();
				if (orCreateActionMap.m_State != null)
				{
					orCreateActionMap.LazyResolveBindings(fullResolve: true);
				}
			}
		}
	}

	public ReadOnlyArray<InputBinding> bindings => GetOrCreateActionMap().GetBindingsForSingleAction(this);

	public ReadOnlyArray<InputControl> controls
	{
		get
		{
			InputActionMap orCreateActionMap = GetOrCreateActionMap();
			orCreateActionMap.ResolveBindingsIfNecessary();
			return orCreateActionMap.GetControlsForSingleAction(this);
		}
	}

	public InputActionPhase phase => currentState.phase;

	public bool inProgress => phase.IsInProgress();

	public bool enabled => phase != InputActionPhase.Disabled;

	public bool triggered => WasPerformedThisFrame();

	public unsafe InputControl activeControl
	{
		get
		{
			InputActionState state = GetOrCreateActionMap().m_State;
			if (state != null)
			{
				int controlIndex = state.actionStates[m_ActionIndexInState].controlIndex;
				if (controlIndex != -1)
				{
					return state.controls[controlIndex];
				}
			}
			return null;
		}
	}

	public bool wantsInitialStateCheck
	{
		get
		{
			if (type != InputActionType.Value)
			{
				return (m_Flags & ActionFlags.WantsInitialStateCheck) != 0;
			}
			return true;
		}
		set
		{
			if (value)
			{
				m_Flags |= ActionFlags.WantsInitialStateCheck;
			}
			else
			{
				m_Flags &= ~ActionFlags.WantsInitialStateCheck;
			}
		}
	}

	internal bool isSingletonAction
	{
		get
		{
			if (m_ActionMap != null)
			{
				return m_ActionMap.m_SingletonAction == this;
			}
			return true;
		}
	}

	private InputActionState.TriggerState currentState
	{
		get
		{
			if (m_ActionIndexInState == -1)
			{
				return default(InputActionState.TriggerState);
			}
			return m_ActionMap.m_State.FetchActionState(this);
		}
	}

	public event Action<CallbackContext> started
	{
		add
		{
			m_OnStarted.AddCallback(value);
		}
		remove
		{
			m_OnStarted.RemoveCallback(value);
		}
	}

	public event Action<CallbackContext> canceled
	{
		add
		{
			m_OnCanceled.AddCallback(value);
		}
		remove
		{
			m_OnCanceled.RemoveCallback(value);
		}
	}

	public event Action<CallbackContext> performed
	{
		add
		{
			m_OnPerformed.AddCallback(value);
		}
		remove
		{
			m_OnPerformed.RemoveCallback(value);
		}
	}

	public InputAction()
	{
		m_Id = Guid.NewGuid().ToString();
	}

	public InputAction(string name = null, InputActionType type = InputActionType.Value, string binding = null, string interactions = null, string processors = null, string expectedControlType = null)
	{
		m_Name = name;
		m_Type = type;
		if (!string.IsNullOrEmpty(binding))
		{
			m_SingletonActionBindings = new InputBinding[1]
			{
				new InputBinding
				{
					path = binding,
					interactions = interactions,
					processors = processors,
					action = m_Name,
					id = Guid.NewGuid()
				}
			};
			m_BindingsStartIndex = 0;
			m_BindingsCount = 1;
		}
		else
		{
			m_Interactions = interactions;
			m_Processors = processors;
		}
		m_ExpectedControlType = expectedControlType;
		m_Id = Guid.NewGuid().ToString();
	}

	public void Dispose()
	{
		m_ActionMap?.m_State?.Dispose();
	}

	public override string ToString()
	{
		string text = ((m_Name == null) ? "<Unnamed>" : ((m_ActionMap == null || isSingletonAction || string.IsNullOrEmpty(m_ActionMap.name)) ? m_Name : (m_ActionMap.name + "/" + m_Name)));
		ReadOnlyArray<InputControl> readOnlyArray = controls;
		if (readOnlyArray.Count > 0)
		{
			text += "[";
			bool flag = true;
			foreach (InputControl item in readOnlyArray)
			{
				if (!flag)
				{
					text += ",";
				}
				text += item.path;
				flag = false;
			}
			text += "]";
		}
		return text;
	}

	public void Enable()
	{
		if (!enabled)
		{
			InputActionMap orCreateActionMap = GetOrCreateActionMap();
			orCreateActionMap.ResolveBindingsIfNecessary();
			orCreateActionMap.m_State.EnableSingleAction(this);
		}
	}

	public void Disable()
	{
		if (enabled)
		{
			m_ActionMap.m_State.DisableSingleAction(this);
		}
	}

	public InputAction Clone()
	{
		return new InputAction(m_Name, m_Type)
		{
			m_SingletonActionBindings = bindings.ToArray(),
			m_BindingsCount = m_BindingsCount,
			m_ExpectedControlType = m_ExpectedControlType,
			m_Interactions = m_Interactions,
			m_Processors = m_Processors,
			m_Flags = m_Flags
		};
	}

	object ICloneable.Clone()
	{
		return Clone();
	}

	public unsafe TValue ReadValue<TValue>() where TValue : struct
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state == null)
		{
			return default(TValue);
		}
		InputActionState.TriggerState* ptr = state.actionStates + m_ActionIndexInState;
		if (!ptr->phase.IsInProgress())
		{
			return state.ApplyProcessors(ptr->bindingIndex, default(TValue));
		}
		return state.ReadValue<TValue>(ptr->bindingIndex, ptr->controlIndex);
	}

	public unsafe object ReadValueAsObject()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state == null)
		{
			return null;
		}
		InputActionState.TriggerState* ptr = state.actionStates + m_ActionIndexInState;
		if (ptr->phase.IsInProgress())
		{
			int controlIndex = ptr->controlIndex;
			if (controlIndex != -1)
			{
				return state.ReadValueAsObject(ptr->bindingIndex, controlIndex);
			}
		}
		return null;
	}

	public void Reset()
	{
		GetOrCreateActionMap().m_State?.ResetActionState(m_ActionIndexInState, enabled ? InputActionPhase.Waiting : InputActionPhase.Disabled, hardReset: true);
	}

	public unsafe bool IsPressed()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state != null)
		{
			return state.actionStates[m_ActionIndexInState].isPressed;
		}
		return false;
	}

	public unsafe bool IsInProgress()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state != null)
		{
			return state.actionStates[m_ActionIndexInState].phase.IsInProgress();
		}
		return false;
	}

	public unsafe bool WasPressedThisFrame()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state != null)
		{
			InputActionState.TriggerState* num = state.actionStates + m_ActionIndexInState;
			uint s_UpdateStepCount = InputUpdate.s_UpdateStepCount;
			if (num->pressedInUpdate == s_UpdateStepCount)
			{
				return s_UpdateStepCount != 0;
			}
			return false;
		}
		return false;
	}

	public unsafe bool WasReleasedThisFrame()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state != null)
		{
			InputActionState.TriggerState* num = state.actionStates + m_ActionIndexInState;
			uint s_UpdateStepCount = InputUpdate.s_UpdateStepCount;
			if (num->releasedInUpdate == s_UpdateStepCount)
			{
				return s_UpdateStepCount != 0;
			}
			return false;
		}
		return false;
	}

	public unsafe bool WasPerformedThisFrame()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state != null)
		{
			InputActionState.TriggerState* num = state.actionStates + m_ActionIndexInState;
			uint s_UpdateStepCount = InputUpdate.s_UpdateStepCount;
			if (num->lastPerformedInUpdate == s_UpdateStepCount)
			{
				return s_UpdateStepCount != 0;
			}
			return false;
		}
		return false;
	}

	public unsafe float GetTimeoutCompletionPercentage()
	{
		InputActionState state = GetOrCreateActionMap().m_State;
		if (state == null)
		{
			return 0f;
		}
		ref InputActionState.TriggerState reference = ref state.actionStates[m_ActionIndexInState];
		int interactionIndex = reference.interactionIndex;
		if (interactionIndex == -1)
		{
			return (reference.phase == InputActionPhase.Performed) ? 1 : 0;
		}
		ref InputActionState.InteractionState reference2 = ref state.interactionStates[interactionIndex];
		switch (reference2.phase)
		{
		case InputActionPhase.Started:
		{
			float num = 0f;
			if (reference2.isTimerRunning)
			{
				float timerDuration = reference2.timerDuration;
				double num2 = reference2.timerStartTime + (double)timerDuration - InputState.currentTime;
				num = ((!(num2 <= 0.0)) ? ((float)(((double)timerDuration - num2) / (double)timerDuration)) : 1f);
			}
			if (reference2.totalTimeoutCompletionTimeRemaining > 0f)
			{
				return (reference2.totalTimeoutCompletionDone + num * reference2.timerDuration) / (reference2.totalTimeoutCompletionDone + reference2.totalTimeoutCompletionTimeRemaining);
			}
			return num;
		}
		case InputActionPhase.Performed:
			return 1f;
		default:
			return 0f;
		}
	}

	internal string MakeSureIdIsInPlace()
	{
		if (string.IsNullOrEmpty(m_Id))
		{
			GenerateId();
		}
		return m_Id;
	}

	internal void GenerateId()
	{
		m_Id = Guid.NewGuid().ToString();
	}

	internal InputActionMap GetOrCreateActionMap()
	{
		if (m_ActionMap == null)
		{
			CreateInternalActionMapForSingletonAction();
		}
		return m_ActionMap;
	}

	private void CreateInternalActionMapForSingletonAction()
	{
		m_ActionMap = new InputActionMap
		{
			m_Actions = new InputAction[1] { this },
			m_SingletonAction = this,
			m_Bindings = m_SingletonActionBindings
		};
	}

	internal void RequestInitialStateCheckOnEnabledAction()
	{
		GetOrCreateActionMap().m_State.SetInitialStateCheckPending(m_ActionIndexInState);
	}

	internal bool ActiveControlIsValid(InputControl control)
	{
		if (control == null)
		{
			return false;
		}
		InputDevice device = control.device;
		if (!device.added)
		{
			return false;
		}
		ReadOnlyArray<InputDevice>? devices = GetOrCreateActionMap().devices;
		if (devices.HasValue && !devices.Value.ContainsReference(device))
		{
			return false;
		}
		return true;
	}

	internal InputBinding? FindEffectiveBindingMask()
	{
		if (m_BindingMask.HasValue)
		{
			return m_BindingMask;
		}
		InputActionMap inputActionMap = m_ActionMap;
		if (inputActionMap != null && inputActionMap.m_BindingMask.HasValue)
		{
			return m_ActionMap.m_BindingMask;
		}
		return m_ActionMap?.m_Asset?.m_BindingMask;
	}

	internal int BindingIndexOnActionToBindingIndexOnMap(int indexOfBindingOnAction)
	{
		InputBinding[] array = GetOrCreateActionMap().m_Bindings;
		int num = array.LengthSafe();
		_ = name;
		int num2 = -1;
		for (int i = 0; i < num; i++)
		{
			if (array[i].TriggersAction(this))
			{
				num2++;
				if (num2 == indexOfBindingOnAction)
				{
					return i;
				}
			}
		}
		throw new ArgumentOutOfRangeException("indexOfBindingOnAction", $"Binding index {indexOfBindingOnAction} is out of range for action '{this}' with {num2 + 1} bindings");
	}

	internal int BindingIndexOnMapToBindingIndexOnAction(int indexOfBindingOnMap)
	{
		InputBinding[] array = GetOrCreateActionMap().m_Bindings;
		string strB = name;
		int num = 0;
		for (int num2 = indexOfBindingOnMap - 1; num2 >= 0; num2--)
		{
			ref InputBinding reference = ref array[num2];
			if (string.Compare(reference.action, strB, StringComparison.InvariantCultureIgnoreCase) == 0 || reference.action == m_Id)
			{
				num++;
			}
		}
		return num;
	}
}
