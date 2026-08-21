using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public static class InputActionRebindingExtensions
{
	internal struct Parameter
	{
		public object instance;

		public FieldInfo field;

		public int bindingIndex;
	}

	private struct ParameterEnumerable(InputActionState state, ParameterOverride parameter, int mapIndex = -1) : IEnumerable<Parameter>, IEnumerable
	{
		private InputActionState m_State = state;

		private ParameterOverride m_Parameter = parameter;

		private int m_MapIndex = mapIndex;

		public ParameterEnumerator GetEnumerator()
		{
			return new ParameterEnumerator(m_State, m_Parameter, m_MapIndex);
		}

		IEnumerator<Parameter> IEnumerable<Parameter>.GetEnumerator()
		{
			return GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	private struct ParameterEnumerator : IEnumerator<Parameter>, IEnumerator, IDisposable
	{
		private InputActionState m_State;

		private int m_MapIndex;

		private int m_BindingCurrentIndex;

		private int m_BindingEndIndex;

		private int m_InteractionCurrentIndex;

		private int m_InteractionEndIndex;

		private int m_ProcessorCurrentIndex;

		private int m_ProcessorEndIndex;

		private InputBinding m_BindingMask;

		private Type m_ObjectType;

		private string m_ParameterName;

		private bool m_MayBeInteraction;

		private bool m_MayBeProcessor;

		private bool m_MayBeComposite;

		private bool m_CurrentBindingIsComposite;

		private object m_CurrentObject;

		private FieldInfo m_CurrentParameter;

		public Parameter Current => new Parameter
		{
			instance = m_CurrentObject,
			field = m_CurrentParameter,
			bindingIndex = m_BindingCurrentIndex
		};

		object IEnumerator.Current => Current;

		public ParameterEnumerator(InputActionState state, ParameterOverride parameter, int mapIndex = -1)
		{
			this = default(ParameterEnumerator);
			m_State = state;
			m_ParameterName = parameter.parameter;
			m_MapIndex = mapIndex;
			m_ObjectType = parameter.objectType;
			m_MayBeComposite = m_ObjectType == null || typeof(InputBindingComposite).IsAssignableFrom(m_ObjectType);
			m_MayBeProcessor = m_ObjectType == null || typeof(InputProcessor).IsAssignableFrom(m_ObjectType);
			m_MayBeInteraction = m_ObjectType == null || typeof(IInputInteraction).IsAssignableFrom(m_ObjectType);
			m_BindingMask = parameter.bindingMask;
			Reset();
		}

		private bool MoveToNextBinding()
		{
			ref InputBinding binding;
			ref InputActionState.BindingState bindingState;
			do
			{
				m_BindingCurrentIndex++;
				if (m_BindingCurrentIndex >= m_BindingEndIndex)
				{
					return false;
				}
				binding = ref m_State.GetBinding(m_BindingCurrentIndex);
				bindingState = ref m_State.GetBindingState(m_BindingCurrentIndex);
			}
			while ((bindingState.processorCount == 0 && bindingState.interactionCount == 0 && !binding.isComposite) || (m_MayBeComposite && !m_MayBeProcessor && !m_MayBeInteraction && !binding.isComposite) || (m_MayBeProcessor && !m_MayBeComposite && !m_MayBeInteraction && bindingState.processorCount == 0) || (m_MayBeInteraction && !m_MayBeComposite && !m_MayBeProcessor && bindingState.interactionCount == 0) || !m_BindingMask.Matches(ref binding));
			if (m_MayBeComposite)
			{
				m_CurrentBindingIsComposite = binding.isComposite;
			}
			m_ProcessorCurrentIndex = bindingState.processorStartIndex - 1;
			m_ProcessorEndIndex = bindingState.processorStartIndex + bindingState.processorCount;
			m_InteractionCurrentIndex = bindingState.interactionStartIndex - 1;
			m_InteractionEndIndex = bindingState.interactionStartIndex + bindingState.interactionCount;
			return true;
		}

		private bool MoveToNextInteraction()
		{
			while (m_InteractionCurrentIndex < m_InteractionEndIndex)
			{
				m_InteractionCurrentIndex++;
				if (m_InteractionCurrentIndex == m_InteractionEndIndex)
				{
					break;
				}
				IInputInteraction instance = m_State.interactions[m_InteractionCurrentIndex];
				if (FindParameter(instance))
				{
					return true;
				}
			}
			return false;
		}

		private bool MoveToNextProcessor()
		{
			while (m_ProcessorCurrentIndex < m_ProcessorEndIndex)
			{
				m_ProcessorCurrentIndex++;
				if (m_ProcessorCurrentIndex == m_ProcessorEndIndex)
				{
					break;
				}
				InputProcessor instance = m_State.processors[m_ProcessorCurrentIndex];
				if (FindParameter(instance))
				{
					return true;
				}
			}
			return false;
		}

		private bool FindParameter(object instance)
		{
			if (m_ObjectType != null && !m_ObjectType.IsInstanceOfType(instance))
			{
				return false;
			}
			FieldInfo field = instance.GetType().GetField(m_ParameterName, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public);
			if (field == null)
			{
				return false;
			}
			m_CurrentParameter = field;
			m_CurrentObject = instance;
			return true;
		}

		public bool MoveNext()
		{
			while (true)
			{
				if (m_MayBeInteraction && MoveToNextInteraction())
				{
					return true;
				}
				if (m_MayBeProcessor && MoveToNextProcessor())
				{
					return true;
				}
				if (!MoveToNextBinding())
				{
					return false;
				}
				if (m_MayBeComposite && m_CurrentBindingIsComposite)
				{
					int compositeOrCompositeBindingIndex = m_State.GetBindingState(m_BindingCurrentIndex).compositeOrCompositeBindingIndex;
					InputBindingComposite instance = m_State.composites[compositeOrCompositeBindingIndex];
					if (FindParameter(instance))
					{
						break;
					}
				}
			}
			return true;
		}

		public unsafe void Reset()
		{
			m_CurrentObject = null;
			m_CurrentParameter = null;
			m_InteractionCurrentIndex = 0;
			m_InteractionEndIndex = 0;
			m_ProcessorCurrentIndex = 0;
			m_ProcessorEndIndex = 0;
			m_CurrentBindingIsComposite = false;
			if (m_MapIndex < 0)
			{
				m_BindingCurrentIndex = -1;
				m_BindingEndIndex = m_State.totalBindingCount;
			}
			else
			{
				m_BindingCurrentIndex = m_State.mapIndices[m_MapIndex].bindingStartIndex - 1;
				m_BindingEndIndex = m_State.mapIndices[m_MapIndex].bindingStartIndex + m_State.mapIndices[m_MapIndex].bindingCount;
			}
		}

		public void Dispose()
		{
		}
	}

	internal struct ParameterOverride
	{
		public string objectRegistrationName;

		public string parameter;

		public InputBinding bindingMask;

		public PrimitiveValue value;

		public Type objectType => InputProcessor.s_Processors.LookupTypeRegistration(objectRegistrationName) ?? InputInteraction.s_Interactions.LookupTypeRegistration(objectRegistrationName) ?? InputBindingComposite.s_Composites.LookupTypeRegistration(objectRegistrationName);

		public ParameterOverride(string parameterName, InputBinding bindingMask, PrimitiveValue value = default(PrimitiveValue))
		{
			int num = parameterName.IndexOf(':');
			if (num < 0)
			{
				objectRegistrationName = null;
				parameter = parameterName;
			}
			else
			{
				objectRegistrationName = parameterName.Substring(0, num);
				parameter = parameterName.Substring(num + 1);
			}
			this.bindingMask = bindingMask;
			this.value = value;
		}

		public ParameterOverride(string objectRegistrationName, string parameterName, InputBinding bindingMask, PrimitiveValue value = default(PrimitiveValue))
		{
			this.objectRegistrationName = objectRegistrationName;
			parameter = parameterName;
			this.bindingMask = bindingMask;
			this.value = value;
		}

		public static ParameterOverride? Find(InputActionMap actionMap, ref InputBinding binding, string parameterName, string objectRegistrationName)
		{
			ParameterOverride? first = Find(actionMap.m_ParameterOverrides, actionMap.m_ParameterOverridesCount, ref binding, parameterName, objectRegistrationName);
			InputActionAsset asset = actionMap.asset;
			ParameterOverride? second = ((asset != null) ? Find(asset.m_ParameterOverrides, asset.m_ParameterOverridesCount, ref binding, parameterName, objectRegistrationName) : ((ParameterOverride?)null));
			return PickMoreSpecificOne(first, second);
		}

		private static ParameterOverride? Find(ParameterOverride[] overrides, int overrideCount, ref InputBinding binding, string parameterName, string objectRegistrationName)
		{
			ParameterOverride? parameterOverride = null;
			for (int i = 0; i < overrideCount; i++)
			{
				ref ParameterOverride reference = ref overrides[i];
				if (string.Equals(parameterName, reference.parameter, StringComparison.OrdinalIgnoreCase) && reference.bindingMask.Matches(binding) && (reference.objectRegistrationName == null || string.Equals(reference.objectRegistrationName, objectRegistrationName, StringComparison.OrdinalIgnoreCase)))
				{
					parameterOverride = (parameterOverride.HasValue ? PickMoreSpecificOne(parameterOverride, reference) : new ParameterOverride?(reference));
				}
			}
			return parameterOverride;
		}

		private static ParameterOverride? PickMoreSpecificOne(ParameterOverride? first, ParameterOverride? second)
		{
			if (!first.HasValue)
			{
				return second;
			}
			if (!second.HasValue)
			{
				return first;
			}
			if (first.Value.objectRegistrationName != null && second.Value.objectRegistrationName == null)
			{
				return first;
			}
			if (second.Value.objectRegistrationName != null && first.Value.objectRegistrationName == null)
			{
				return second;
			}
			if (first.Value.bindingMask.effectivePath != null && second.Value.bindingMask.effectivePath == null)
			{
				return first;
			}
			if (second.Value.bindingMask.effectivePath != null && first.Value.bindingMask.effectivePath == null)
			{
				return second;
			}
			if (first.Value.bindingMask.action != null && second.Value.bindingMask.action == null)
			{
				return first;
			}
			if (second.Value.bindingMask.action != null && first.Value.bindingMask.action == null)
			{
				return second;
			}
			return first;
		}
	}

	public sealed class RebindingOperation : IDisposable
	{
		[Flags]
		private enum Flags
		{
			Started = 1,
			Completed = 2,
			Canceled = 4,
			OnEventHooked = 8,
			OnAfterUpdateHooked = 0x10,
			DontIgnoreNoisyControls = 0x40,
			DontGeneralizePathOfSelectedControl = 0x80,
			AddNewBinding = 0x100,
			SuppressMatchingEvents = 0x200
		}

		public const float kDefaultMagnitudeThreshold = 0.2f;

		private InputAction m_ActionToRebind;

		private InputBinding? m_BindingMask;

		private Type m_ControlType;

		private InternedString m_ExpectedLayout;

		private int m_IncludePathCount;

		private string[] m_IncludePaths;

		private int m_ExcludePathCount;

		private string[] m_ExcludePaths;

		private int m_TargetBindingIndex = -1;

		private string m_BindingGroupForNewBinding;

		private string m_CancelBinding;

		private float m_MagnitudeThreshold = 0.2f;

		private float[] m_Scores;

		private float[] m_Magnitudes;

		private double m_LastMatchTime;

		private double m_StartTime;

		private float m_Timeout;

		private float m_WaitSecondsAfterMatch;

		private InputControlList<InputControl> m_Candidates;

		private Action<RebindingOperation> m_OnComplete;

		private Action<RebindingOperation> m_OnCancel;

		private Action<RebindingOperation> m_OnPotentialMatch;

		private Func<InputControl, string> m_OnGeneratePath;

		private Func<InputControl, InputEventPtr, float> m_OnComputeScore;

		private Action<RebindingOperation, string> m_OnApplyBinding;

		private Action<InputEventPtr, InputDevice> m_OnEventDelegate;

		private Action m_OnAfterUpdateDelegate;

		private InputControlLayout.Cache m_LayoutCache;

		private StringBuilder m_PathBuilder;

		private Flags m_Flags;

		private Dictionary<InputControl, float> m_StartingActuations = new Dictionary<InputControl, float>();

		public InputAction action => m_ActionToRebind;

		public InputBinding? bindingMask => m_BindingMask;

		public InputControlList<InputControl> candidates => m_Candidates;

		public ReadOnlyArray<float> scores => new ReadOnlyArray<float>(m_Scores, 0, m_Candidates.Count);

		public ReadOnlyArray<float> magnitudes => new ReadOnlyArray<float>(m_Magnitudes, 0, m_Candidates.Count);

		public InputControl selectedControl
		{
			get
			{
				if (m_Candidates.Count == 0)
				{
					return null;
				}
				return m_Candidates[0];
			}
		}

		public bool started => (m_Flags & Flags.Started) != 0;

		public bool completed => (m_Flags & Flags.Completed) != 0;

		public bool canceled => (m_Flags & Flags.Canceled) != 0;

		public double startTime => m_StartTime;

		public float timeout => m_Timeout;

		public string expectedControlType => m_ExpectedLayout;

		public RebindingOperation WithAction(InputAction action)
		{
			ThrowIfRebindInProgress();
			if (action == null)
			{
				throw new ArgumentNullException("action");
			}
			if (action.enabled)
			{
				throw new InvalidOperationException($"Cannot rebind action '{action}' while it is enabled");
			}
			m_ActionToRebind = action;
			if (!string.IsNullOrEmpty(action.expectedControlType))
			{
				WithExpectedControlType(action.expectedControlType);
			}
			else if (action.type == InputActionType.Button)
			{
				WithExpectedControlType("Button");
			}
			return this;
		}

		public RebindingOperation WithMatchingEventsBeingSuppressed(bool value = true)
		{
			ThrowIfRebindInProgress();
			if (value)
			{
				m_Flags |= Flags.SuppressMatchingEvents;
			}
			else
			{
				m_Flags &= ~Flags.SuppressMatchingEvents;
			}
			return this;
		}

		public RebindingOperation WithCancelingThrough(string binding)
		{
			ThrowIfRebindInProgress();
			m_CancelBinding = binding;
			return this;
		}

		public RebindingOperation WithCancelingThrough(InputControl control)
		{
			ThrowIfRebindInProgress();
			if (control == null)
			{
				throw new ArgumentNullException("control");
			}
			return WithCancelingThrough(control.path);
		}

		public RebindingOperation WithExpectedControlType(string layoutName)
		{
			ThrowIfRebindInProgress();
			m_ExpectedLayout = new InternedString(layoutName);
			return this;
		}

		public RebindingOperation WithExpectedControlType(Type type)
		{
			ThrowIfRebindInProgress();
			if (type != null && !typeof(InputControl).IsAssignableFrom(type))
			{
				throw new ArgumentException("Type '" + type.Name + "' is not an InputControl", "type");
			}
			m_ControlType = type;
			return this;
		}

		public RebindingOperation WithExpectedControlType<TControl>() where TControl : InputControl
		{
			ThrowIfRebindInProgress();
			return WithExpectedControlType(typeof(TControl));
		}

		public RebindingOperation WithTargetBinding(int bindingIndex)
		{
			if (bindingIndex < 0)
			{
				throw new ArgumentOutOfRangeException("bindingIndex");
			}
			m_TargetBindingIndex = bindingIndex;
			if (m_ActionToRebind != null && bindingIndex < m_ActionToRebind.bindings.Count)
			{
				InputBinding inputBinding = m_ActionToRebind.bindings[bindingIndex];
				if (inputBinding.isPartOfComposite)
				{
					string nameOfComposite = m_ActionToRebind.ChangeBinding(bindingIndex).PreviousCompositeBinding().binding.GetNameOfComposite();
					string name = inputBinding.name;
					string expectedControlLayoutName = InputBindingComposite.GetExpectedControlLayoutName(nameOfComposite, name);
					if (!string.IsNullOrEmpty(expectedControlLayoutName))
					{
						WithExpectedControlType(expectedControlLayoutName);
					}
				}
				InputActionAsset inputActionAsset = action.actionMap?.asset;
				if (inputActionAsset != null && !string.IsNullOrEmpty(inputBinding.groups))
				{
					string[] array = inputBinding.groups.Split(';');
					foreach (string group in array)
					{
						int num = inputActionAsset.controlSchemes.IndexOf((InputControlScheme x) => group.Equals(x.bindingGroup, StringComparison.InvariantCultureIgnoreCase));
						if (num == -1)
						{
							continue;
						}
						foreach (InputControlScheme.DeviceRequirement deviceRequirement in inputActionAsset.controlSchemes[num].deviceRequirements)
						{
							WithControlsHavingToMatchPath(deviceRequirement.controlPath);
						}
					}
				}
			}
			return this;
		}

		public RebindingOperation WithBindingMask(InputBinding? bindingMask)
		{
			m_BindingMask = bindingMask;
			return this;
		}

		public RebindingOperation WithBindingGroup(string group)
		{
			return WithBindingMask(new InputBinding
			{
				groups = group
			});
		}

		public RebindingOperation WithoutGeneralizingPathOfSelectedControl()
		{
			m_Flags |= Flags.DontGeneralizePathOfSelectedControl;
			return this;
		}

		public RebindingOperation WithRebindAddingNewBinding(string group = null)
		{
			m_Flags |= Flags.AddNewBinding;
			m_BindingGroupForNewBinding = group;
			return this;
		}

		public RebindingOperation WithMagnitudeHavingToBeGreaterThan(float magnitude)
		{
			ThrowIfRebindInProgress();
			if (magnitude < 0f)
			{
				throw new ArgumentException($"Magnitude has to be positive but was {magnitude}", "magnitude");
			}
			m_MagnitudeThreshold = magnitude;
			return this;
		}

		public RebindingOperation WithoutIgnoringNoisyControls()
		{
			ThrowIfRebindInProgress();
			m_Flags |= Flags.DontIgnoreNoisyControls;
			return this;
		}

		public RebindingOperation WithControlsHavingToMatchPath(string path)
		{
			ThrowIfRebindInProgress();
			if (string.IsNullOrEmpty(path))
			{
				throw new ArgumentNullException("path");
			}
			for (int i = 0; i < m_IncludePathCount; i++)
			{
				if (string.Compare(m_IncludePaths[i], path, StringComparison.InvariantCultureIgnoreCase) == 0)
				{
					return this;
				}
			}
			ArrayHelpers.AppendWithCapacity(ref m_IncludePaths, ref m_IncludePathCount, path);
			return this;
		}

		public RebindingOperation WithControlsExcluding(string path)
		{
			ThrowIfRebindInProgress();
			if (string.IsNullOrEmpty(path))
			{
				throw new ArgumentNullException("path");
			}
			for (int i = 0; i < m_ExcludePathCount; i++)
			{
				if (string.Compare(m_ExcludePaths[i], path, StringComparison.InvariantCultureIgnoreCase) == 0)
				{
					return this;
				}
			}
			ArrayHelpers.AppendWithCapacity(ref m_ExcludePaths, ref m_ExcludePathCount, path);
			return this;
		}

		public RebindingOperation WithTimeout(float timeInSeconds)
		{
			m_Timeout = timeInSeconds;
			return this;
		}

		public RebindingOperation OnComplete(Action<RebindingOperation> callback)
		{
			m_OnComplete = callback;
			return this;
		}

		public RebindingOperation OnCancel(Action<RebindingOperation> callback)
		{
			m_OnCancel = callback;
			return this;
		}

		public RebindingOperation OnPotentialMatch(Action<RebindingOperation> callback)
		{
			m_OnPotentialMatch = callback;
			return this;
		}

		public RebindingOperation OnGeneratePath(Func<InputControl, string> callback)
		{
			m_OnGeneratePath = callback;
			return this;
		}

		public RebindingOperation OnComputeScore(Func<InputControl, InputEventPtr, float> callback)
		{
			m_OnComputeScore = callback;
			return this;
		}

		public RebindingOperation OnApplyBinding(Action<RebindingOperation, string> callback)
		{
			m_OnApplyBinding = callback;
			return this;
		}

		public RebindingOperation OnMatchWaitForAnother(float seconds)
		{
			m_WaitSecondsAfterMatch = seconds;
			return this;
		}

		public RebindingOperation Start()
		{
			if (started)
			{
				return this;
			}
			if (m_ActionToRebind != null && m_ActionToRebind.bindings.Count == 0 && (m_Flags & Flags.AddNewBinding) == 0)
			{
				throw new InvalidOperationException($"Action '{action}' must have at least one existing binding or must be used with WithRebindingAddNewBinding()");
			}
			if (m_ActionToRebind == null && m_OnApplyBinding == null)
			{
				throw new InvalidOperationException("Must either have an action (call WithAction()) to apply binding to or have a custom callback to apply the binding (call OnApplyBinding())");
			}
			m_StartTime = InputState.currentTime;
			if (m_WaitSecondsAfterMatch > 0f || m_Timeout > 0f)
			{
				HookOnAfterUpdate();
				m_LastMatchTime = -1.0;
			}
			HookOnEvent();
			m_Flags |= Flags.Started;
			m_Flags &= ~Flags.Canceled;
			m_Flags &= ~Flags.Completed;
			return this;
		}

		public void Cancel()
		{
			if (started)
			{
				OnCancel();
			}
		}

		public void Complete()
		{
			if (started)
			{
				OnComplete();
			}
		}

		public void AddCandidate(InputControl control, float score, float magnitude = -1f)
		{
			if (control == null)
			{
				throw new ArgumentNullException("control");
			}
			int num = m_Candidates.IndexOf(control);
			if (num != -1)
			{
				m_Scores[num] = score;
			}
			else
			{
				int count = m_Candidates.Count;
				int count2 = m_Candidates.Count;
				m_Candidates.Add(control);
				ArrayHelpers.AppendWithCapacity(ref m_Scores, ref count, score);
				ArrayHelpers.AppendWithCapacity(ref m_Magnitudes, ref count2, magnitude);
			}
			SortCandidatesByScore();
		}

		public void RemoveCandidate(InputControl control)
		{
			if (control == null)
			{
				throw new ArgumentNullException("control");
			}
			int num = m_Candidates.IndexOf(control);
			if (num != -1)
			{
				int count = m_Candidates.Count;
				m_Candidates.RemoveAt(num);
				m_Scores.EraseAtWithCapacity(ref count, num);
			}
		}

		public void Dispose()
		{
			UnhookOnEvent();
			UnhookOnAfterUpdate();
			m_Candidates.Dispose();
			m_LayoutCache.Clear();
		}

		~RebindingOperation()
		{
			Dispose();
		}

		public RebindingOperation Reset()
		{
			Cancel();
			m_ActionToRebind = null;
			m_BindingMask = null;
			m_ControlType = null;
			m_ExpectedLayout = default(InternedString);
			m_IncludePathCount = 0;
			m_ExcludePathCount = 0;
			m_TargetBindingIndex = -1;
			m_BindingGroupForNewBinding = null;
			m_CancelBinding = null;
			m_MagnitudeThreshold = 0.2f;
			m_Timeout = 0f;
			m_WaitSecondsAfterMatch = 0f;
			m_Flags = (Flags)0;
			m_StartingActuations?.Clear();
			return this;
		}

		private void HookOnEvent()
		{
			if ((m_Flags & Flags.OnEventHooked) == 0)
			{
				if (m_OnEventDelegate == null)
				{
					m_OnEventDelegate = OnEvent;
				}
				InputSystem.onEvent += m_OnEventDelegate;
				m_Flags |= Flags.OnEventHooked;
			}
		}

		private void UnhookOnEvent()
		{
			if ((m_Flags & Flags.OnEventHooked) != 0)
			{
				InputSystem.onEvent -= m_OnEventDelegate;
				m_Flags &= ~Flags.OnEventHooked;
			}
		}

		private unsafe void OnEvent(InputEventPtr eventPtr, InputDevice device)
		{
			FourCC type = eventPtr.type;
			if (type != 1398030676 && type != 1145852993)
			{
				return;
			}
			bool flag = false;
			bool flag2 = false;
			InputControlExtensions.Enumerate enumerate = InputControlExtensions.Enumerate.IncludeSyntheticControls | InputControlExtensions.Enumerate.IncludeNonLeafControls;
			if ((m_Flags & Flags.DontIgnoreNoisyControls) != 0)
			{
				enumerate |= InputControlExtensions.Enumerate.IncludeNoisyControls;
			}
			foreach (InputControl item in eventPtr.EnumerateControls(enumerate, device))
			{
				void* statePtrFromStateEventUnchecked = item.GetStatePtrFromStateEventUnchecked(eventPtr, type);
				if (!string.IsNullOrEmpty(m_CancelBinding) && InputControlPath.Matches(m_CancelBinding, item) && item.HasValueChangeInState(statePtrFromStateEventUnchecked))
				{
					OnCancel();
					break;
				}
				if ((m_ExcludePathCount > 0 && HavePathMatch(item, m_ExcludePaths, m_ExcludePathCount)) || (m_IncludePathCount > 0 && !HavePathMatch(item, m_IncludePaths, m_IncludePathCount)) || (m_ControlType != null && !m_ControlType.IsInstanceOfType(item)) || (!m_ExpectedLayout.IsEmpty() && m_ExpectedLayout != item.m_Layout && !InputControlLayout.s_Layouts.IsBasedOn(m_ExpectedLayout, item.m_Layout)))
				{
					continue;
				}
				if (item.CheckStateIsAtDefault(statePtrFromStateEventUnchecked, null))
				{
					if (!m_StartingActuations.ContainsKey(item))
					{
						m_StartingActuations.Add(item, 0f);
					}
					m_StartingActuations[item] = 0f;
					continue;
				}
				flag2 = true;
				float num = item.EvaluateMagnitude(statePtrFromStateEventUnchecked);
				if (num >= 0f)
				{
					if (!m_StartingActuations.TryGetValue(item, out var value))
					{
						value = item.magnitude;
						m_StartingActuations.Add(item, value);
					}
					if (Mathf.Abs(value - num) < m_MagnitudeThreshold)
					{
						continue;
					}
				}
				float num2;
				if (m_OnComputeScore != null)
				{
					num2 = m_OnComputeScore(item, eventPtr);
				}
				else
				{
					num2 = num;
					if (!item.synthetic)
					{
						num2++;
					}
				}
				int num3 = m_Candidates.IndexOf(item);
				if (num3 != -1)
				{
					if (m_Scores[num3] < num2)
					{
						flag = true;
						m_Scores[num3] = num2;
						if (m_WaitSecondsAfterMatch > 0f)
						{
							m_LastMatchTime = InputState.currentTime;
						}
					}
					continue;
				}
				int count = m_Candidates.Count;
				int count2 = m_Candidates.Count;
				m_Candidates.Add(item);
				ArrayHelpers.AppendWithCapacity(ref m_Scores, ref count, num2);
				ArrayHelpers.AppendWithCapacity(ref m_Magnitudes, ref count2, num);
				flag = true;
				if (m_WaitSecondsAfterMatch > 0f)
				{
					m_LastMatchTime = InputState.currentTime;
				}
			}
			if (flag2 && (m_Flags & Flags.SuppressMatchingEvents) != 0)
			{
				eventPtr.handled = true;
			}
			if (flag && !canceled)
			{
				if (m_OnPotentialMatch != null)
				{
					SortCandidatesByScore();
					m_OnPotentialMatch(this);
				}
				else if (m_WaitSecondsAfterMatch <= 0f)
				{
					OnComplete();
				}
				else
				{
					SortCandidatesByScore();
				}
			}
		}

		private void SortCandidatesByScore()
		{
			int count = m_Candidates.Count;
			if (count <= 1)
			{
				return;
			}
			for (int i = 1; i < count; i++)
			{
				int num = i;
				while (num > 0 && m_Scores[num - 1] < m_Scores[num])
				{
					int index = num - 1;
					m_Scores.SwapElements(num, index);
					m_Candidates.SwapElements(num, index);
					m_Magnitudes.SwapElements(num, index);
					num--;
				}
			}
		}

		private static bool HavePathMatch(InputControl control, string[] paths, int pathCount)
		{
			for (int i = 0; i < pathCount; i++)
			{
				if (InputControlPath.MatchesPrefix(paths[i], control))
				{
					return true;
				}
			}
			return false;
		}

		private void HookOnAfterUpdate()
		{
			if ((m_Flags & Flags.OnAfterUpdateHooked) == 0)
			{
				if (m_OnAfterUpdateDelegate == null)
				{
					m_OnAfterUpdateDelegate = OnAfterUpdate;
				}
				InputSystem.onAfterUpdate += m_OnAfterUpdateDelegate;
				m_Flags |= Flags.OnAfterUpdateHooked;
			}
		}

		private void UnhookOnAfterUpdate()
		{
			if ((m_Flags & Flags.OnAfterUpdateHooked) != 0)
			{
				InputSystem.onAfterUpdate -= m_OnAfterUpdateDelegate;
				m_Flags &= ~Flags.OnAfterUpdateHooked;
			}
		}

		private void OnAfterUpdate()
		{
			if (m_LastMatchTime < 0.0 && m_Timeout > 0f && InputState.currentTime - m_StartTime > (double)m_Timeout)
			{
				Cancel();
			}
			else if (!(m_WaitSecondsAfterMatch <= 0f) && !(m_LastMatchTime < 0.0) && InputState.currentTime >= m_LastMatchTime + (double)m_WaitSecondsAfterMatch)
			{
				Complete();
			}
		}

		private void OnComplete()
		{
			SortCandidatesByScore();
			if (m_Candidates.Count > 0)
			{
				InputControl inputControl = m_Candidates[0];
				string text = inputControl.path;
				if (m_OnGeneratePath != null)
				{
					string text2 = m_OnGeneratePath(inputControl);
					if (!string.IsNullOrEmpty(text2))
					{
						text = text2;
					}
					else if ((m_Flags & Flags.DontGeneralizePathOfSelectedControl) == 0)
					{
						text = GeneratePathForControl(inputControl);
					}
				}
				else if ((m_Flags & Flags.DontGeneralizePathOfSelectedControl) == 0)
				{
					text = GeneratePathForControl(inputControl);
				}
				if (m_OnApplyBinding != null)
				{
					m_OnApplyBinding(this, text);
				}
				else if ((m_Flags & Flags.AddNewBinding) != 0)
				{
					m_ActionToRebind.AddBinding(text, null, null, m_BindingGroupForNewBinding);
				}
				else if (m_TargetBindingIndex >= 0)
				{
					if (m_TargetBindingIndex >= m_ActionToRebind.bindings.Count)
					{
						throw new InvalidOperationException($"Target binding index {m_TargetBindingIndex} out of range for action '{m_ActionToRebind}' with {m_ActionToRebind.bindings.Count} bindings");
					}
					m_ActionToRebind.ApplyBindingOverride(m_TargetBindingIndex, text);
				}
				else if (m_BindingMask.HasValue)
				{
					InputBinding value = m_BindingMask.Value;
					value.overridePath = text;
					m_ActionToRebind.ApplyBindingOverride(value);
				}
				else
				{
					m_ActionToRebind.ApplyBindingOverride(text);
				}
			}
			m_Flags |= Flags.Completed;
			m_OnComplete?.Invoke(this);
			ResetAfterMatchCompleted();
		}

		private void OnCancel()
		{
			m_Flags |= Flags.Canceled;
			m_OnCancel?.Invoke(this);
			ResetAfterMatchCompleted();
		}

		private void ResetAfterMatchCompleted()
		{
			m_Flags &= ~Flags.Started;
			m_Candidates.Clear();
			m_Candidates.Capacity = 0;
			m_StartTime = -1.0;
			m_StartingActuations.Clear();
			UnhookOnEvent();
			UnhookOnAfterUpdate();
		}

		private void ThrowIfRebindInProgress()
		{
			if (started)
			{
				throw new InvalidOperationException("Cannot reconfigure rebinding while operation is in progress");
			}
		}

		private string GeneratePathForControl(InputControl control)
		{
			_ = control.device;
			InternedString internedString = InputControlLayout.s_Layouts.FindLayoutThatIntroducesControl(control, m_LayoutCache);
			if (m_PathBuilder == null)
			{
				m_PathBuilder = new StringBuilder();
			}
			else
			{
				m_PathBuilder.Length = 0;
			}
			control.BuildPath(internedString, m_PathBuilder);
			return m_PathBuilder.ToString();
		}
	}

	internal class DeferBindingResolutionWrapper : IDisposable
	{
		public void Acquire()
		{
			InputActionMap.s_DeferBindingResolution++;
		}

		public void Dispose()
		{
			if (InputActionMap.s_DeferBindingResolution > 0)
			{
				InputActionMap.s_DeferBindingResolution--;
			}
			if (InputActionMap.s_DeferBindingResolution == 0)
			{
				InputActionState.DeferredResolutionOfBindings();
			}
		}
	}

	private static DeferBindingResolutionWrapper s_DeferBindingResolutionWrapper;

	public static PrimitiveValue? GetParameterValue(this InputAction action, string name, InputBinding bindingMask = default(InputBinding))
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		return action.GetParameterValue(new ParameterOverride(name, bindingMask));
	}

	private static PrimitiveValue? GetParameterValue(this InputAction action, ParameterOverride parameterOverride)
	{
		parameterOverride.bindingMask.action = action.name;
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		orCreateActionMap.ResolveBindingsIfNecessary();
		using (ParameterEnumerator parameterEnumerator = new ParameterEnumerable(orCreateActionMap.m_State, parameterOverride, orCreateActionMap.m_MapIndexInState).GetEnumerator())
		{
			if (parameterEnumerator.MoveNext())
			{
				Parameter current = parameterEnumerator.Current;
				return PrimitiveValue.FromObject(current.field.GetValue(current.instance));
			}
		}
		return null;
	}

	public static PrimitiveValue? GetParameterValue(this InputAction action, string name, int bindingIndex)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (bindingIndex < 0)
		{
			throw new ArgumentOutOfRangeException("bindingIndex");
		}
		int index = action.BindingIndexOnActionToBindingIndexOnMap(bindingIndex);
		InputBinding bindingMask = new InputBinding
		{
			id = action.GetOrCreateActionMap().bindings[index].id
		};
		return action.GetParameterValue(name, bindingMask);
	}

	public unsafe static TValue? GetParameterValue<TObject, TValue>(this InputAction action, Expression<Func<TObject, TValue>> expr, InputBinding bindingMask = default(InputBinding)) where TValue : struct
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (expr == null)
		{
			throw new ArgumentNullException("expr");
		}
		ParameterOverride parameterOverride = ExtractParameterOverride(expr, bindingMask);
		PrimitiveValue? parameterValue = action.GetParameterValue(parameterOverride);
		if (!parameterValue.HasValue)
		{
			return null;
		}
		if (Type.GetTypeCode(typeof(TValue)) == parameterValue.Value.type)
		{
			PrimitiveValue value = parameterValue.Value;
			TValue output = default(TValue);
			UnsafeUtility.MemCpy(UnsafeUtility.AddressOf(ref output), value.valuePtr, UnsafeUtility.SizeOf<TValue>());
			return output;
		}
		return (TValue)Convert.ChangeType(parameterValue.Value.ToObject(), typeof(TValue));
	}

	public static void ApplyParameterOverride<TObject, TValue>(this InputAction action, Expression<Func<TObject, TValue>> expr, TValue value, InputBinding bindingMask = default(InputBinding)) where TValue : struct
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (expr == null)
		{
			throw new ArgumentNullException("expr");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		orCreateActionMap.ResolveBindingsIfNecessary();
		bindingMask.action = action.name;
		ParameterOverride parameterOverride = ExtractParameterOverride(expr, bindingMask, PrimitiveValue.From(value));
		ApplyParameterOverride(orCreateActionMap.m_State, orCreateActionMap.m_MapIndexInState, ref orCreateActionMap.m_ParameterOverrides, ref orCreateActionMap.m_ParameterOverridesCount, parameterOverride);
	}

	public static void ApplyParameterOverride<TObject, TValue>(this InputActionMap actionMap, Expression<Func<TObject, TValue>> expr, TValue value, InputBinding bindingMask = default(InputBinding)) where TValue : struct
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (expr == null)
		{
			throw new ArgumentNullException("expr");
		}
		actionMap.ResolveBindingsIfNecessary();
		ParameterOverride parameterOverride = ExtractParameterOverride(expr, bindingMask, PrimitiveValue.From(value));
		ApplyParameterOverride(actionMap.m_State, actionMap.m_MapIndexInState, ref actionMap.m_ParameterOverrides, ref actionMap.m_ParameterOverridesCount, parameterOverride);
	}

	public static void ApplyParameterOverride<TObject, TValue>(this InputActionAsset asset, Expression<Func<TObject, TValue>> expr, TValue value, InputBinding bindingMask = default(InputBinding)) where TValue : struct
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (expr == null)
		{
			throw new ArgumentNullException("expr");
		}
		asset.ResolveBindingsIfNecessary();
		ParameterOverride parameterOverride = ExtractParameterOverride(expr, bindingMask, PrimitiveValue.From(value));
		ApplyParameterOverride(asset.m_SharedStateForAllMaps, -1, ref asset.m_ParameterOverrides, ref asset.m_ParameterOverridesCount, parameterOverride);
	}

	private static ParameterOverride ExtractParameterOverride<TObject, TValue>(Expression<Func<TObject, TValue>> expr, InputBinding bindingMask = default(InputBinding), PrimitiveValue value = default(PrimitiveValue))
	{
		if (expr == null)
		{
			throw new ArgumentException("Expression must be a LambdaExpression but was a " + expr.GetType().Name + " instead", "expr");
		}
		MemberExpression memberExpression = expr.Body as MemberExpression;
		if (memberExpression == null)
		{
			if (!(expr.Body is UnaryExpression { NodeType: ExpressionType.Convert, Operand: MemberExpression operand }))
			{
				throw new ArgumentException("Body in LambdaExpression must be a MemberExpression (x.name) but was a " + expr.GetType().Name + " instead", "expr");
			}
			memberExpression = operand;
		}
		string objectRegistrationName;
		if (typeof(InputProcessor).IsAssignableFrom(typeof(TObject)))
		{
			objectRegistrationName = InputProcessor.s_Processors.FindNameForType(typeof(TObject));
		}
		else if (typeof(IInputInteraction).IsAssignableFrom(typeof(TObject)))
		{
			objectRegistrationName = InputInteraction.s_Interactions.FindNameForType(typeof(TObject));
		}
		else
		{
			if (!typeof(InputBindingComposite).IsAssignableFrom(typeof(TObject)))
			{
				throw new ArgumentException("Given type must be an InputProcessor, IInputInteraction, or InputBindingComposite (was " + typeof(TObject).Name + ")", "TObject");
			}
			objectRegistrationName = InputBindingComposite.s_Composites.FindNameForType(typeof(TObject));
		}
		return new ParameterOverride(objectRegistrationName, memberExpression.Member.Name, bindingMask, value);
	}

	public static void ApplyParameterOverride(this InputActionMap actionMap, string name, PrimitiveValue value, InputBinding bindingMask = default(InputBinding))
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		actionMap.ResolveBindingsIfNecessary();
		ApplyParameterOverride(actionMap.m_State, actionMap.m_MapIndexInState, ref actionMap.m_ParameterOverrides, ref actionMap.m_ParameterOverridesCount, new ParameterOverride(name, bindingMask, value));
	}

	public static void ApplyParameterOverride(this InputActionAsset asset, string name, PrimitiveValue value, InputBinding bindingMask = default(InputBinding))
	{
		if (asset == null)
		{
			throw new ArgumentNullException("asset");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		asset.ResolveBindingsIfNecessary();
		ApplyParameterOverride(asset.m_SharedStateForAllMaps, -1, ref asset.m_ParameterOverrides, ref asset.m_ParameterOverridesCount, new ParameterOverride(name, bindingMask, value));
	}

	public static void ApplyParameterOverride(this InputAction action, string name, PrimitiveValue value, InputBinding bindingMask = default(InputBinding))
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		orCreateActionMap.ResolveBindingsIfNecessary();
		bindingMask.action = action.name;
		ApplyParameterOverride(orCreateActionMap.m_State, orCreateActionMap.m_MapIndexInState, ref orCreateActionMap.m_ParameterOverrides, ref orCreateActionMap.m_ParameterOverridesCount, new ParameterOverride(name, bindingMask, value));
	}

	public static void ApplyParameterOverride(this InputAction action, string name, PrimitiveValue value, int bindingIndex)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentNullException("name");
		}
		if (bindingIndex < 0)
		{
			throw new ArgumentOutOfRangeException("bindingIndex");
		}
		int index = action.BindingIndexOnActionToBindingIndexOnMap(bindingIndex);
		InputBinding bindingMask = new InputBinding
		{
			id = action.GetOrCreateActionMap().bindings[index].id
		};
		action.ApplyParameterOverride(name, value, bindingMask);
	}

	private static void ApplyParameterOverride(InputActionState state, int mapIndex, ref ParameterOverride[] parameterOverrides, ref int parameterOverridesCount, ParameterOverride parameterOverride)
	{
		bool flag = false;
		if (parameterOverrides != null)
		{
			for (int i = 0; i < parameterOverridesCount; i++)
			{
				ref ParameterOverride reference = ref parameterOverrides[i];
				if (string.Equals(reference.objectRegistrationName, parameterOverride.objectRegistrationName, StringComparison.OrdinalIgnoreCase) && string.Equals(reference.parameter, parameterOverride.parameter, StringComparison.OrdinalIgnoreCase) && reference.bindingMask == parameterOverride.bindingMask)
				{
					flag = true;
					reference = parameterOverride;
					break;
				}
			}
		}
		if (!flag)
		{
			ArrayHelpers.AppendWithCapacity(ref parameterOverrides, ref parameterOverridesCount, parameterOverride);
		}
		foreach (Parameter item in new ParameterEnumerable(state, parameterOverride, mapIndex))
		{
			ParameterOverride? parameterOverride2 = ParameterOverride.Find(state.GetActionMap(item.bindingIndex), ref state.GetBinding(item.bindingIndex), parameterOverride.parameter, parameterOverride.objectRegistrationName);
			if (parameterOverride2.HasValue)
			{
				TypeCode typeCode = Type.GetTypeCode(item.field.FieldType);
				item.field.SetValue(item.instance, parameterOverride2.Value.value.ConvertTo(typeCode).ToObject());
			}
		}
	}

	public static int GetBindingIndex(this InputAction action, InputBinding bindingMask)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		ReadOnlyArray<InputBinding> bindings = action.bindings;
		for (int i = 0; i < bindings.Count; i++)
		{
			if (bindingMask.Matches(bindings[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static int GetBindingIndex(this InputActionMap actionMap, InputBinding bindingMask)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		ReadOnlyArray<InputBinding> bindings = actionMap.bindings;
		for (int i = 0; i < bindings.Count; i++)
		{
			if (bindingMask.Matches(bindings[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static int GetBindingIndex(this InputAction action, string group = null, string path = null)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return action.GetBindingIndex(new InputBinding(path, null, group));
	}

	public static InputBinding? GetBindingForControl(this InputAction action, InputControl control)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		int bindingIndexForControl = action.GetBindingIndexForControl(control);
		if (bindingIndexForControl == -1)
		{
			return null;
		}
		return action.bindings[bindingIndexForControl];
	}

	public unsafe static int GetBindingIndexForControl(this InputAction action, InputControl control)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		orCreateActionMap.ResolveBindingsIfNecessary();
		InputActionState state = orCreateActionMap.m_State;
		InputControl[] controls = state.controls;
		int totalControlCount = state.totalControlCount;
		InputActionState.BindingState* bindingStates = state.bindingStates;
		int* controlIndexToBindingIndex = state.controlIndexToBindingIndex;
		int actionIndexInState = action.m_ActionIndexInState;
		for (int i = 0; i < totalControlCount; i++)
		{
			if (controls[i] == control)
			{
				int num = controlIndexToBindingIndex[i];
				if (bindingStates[num].actionIndex == actionIndexInState)
				{
					int bindingIndexInMap = state.GetBindingIndexInMap(num);
					return action.BindingIndexOnMapToBindingIndexOnAction(bindingIndexInMap);
				}
			}
		}
		return -1;
	}

	public static string GetBindingDisplayString(this InputAction action, InputBinding.DisplayStringOptions options = (InputBinding.DisplayStringOptions)0, string group = null)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		InputBinding bindingMask;
		if (!string.IsNullOrEmpty(group))
		{
			bindingMask = InputBinding.MaskByGroup(group);
		}
		else
		{
			InputBinding? inputBinding = action.FindEffectiveBindingMask();
			bindingMask = ((!inputBinding.HasValue) ? default(InputBinding) : inputBinding.Value);
		}
		return action.GetBindingDisplayString(bindingMask, options);
	}

	public static string GetBindingDisplayString(this InputAction action, InputBinding bindingMask, InputBinding.DisplayStringOptions options = (InputBinding.DisplayStringOptions)0)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		string text = string.Empty;
		ReadOnlyArray<InputBinding> bindings = action.bindings;
		for (int i = 0; i < bindings.Count; i++)
		{
			if (!bindings[i].isPartOfComposite && bindingMask.Matches(bindings[i]))
			{
				string bindingDisplayString = action.GetBindingDisplayString(i, options);
				text = ((!(text != "")) ? bindingDisplayString : (text + " | " + bindingDisplayString));
			}
		}
		return text;
	}

	public static string GetBindingDisplayString(this InputAction action, int bindingIndex, InputBinding.DisplayStringOptions options = (InputBinding.DisplayStringOptions)0)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		string deviceLayoutName;
		string controlPath;
		return action.GetBindingDisplayString(bindingIndex, out deviceLayoutName, out controlPath, options);
	}

	public unsafe static string GetBindingDisplayString(this InputAction action, int bindingIndex, out string deviceLayoutName, out string controlPath, InputBinding.DisplayStringOptions options = (InputBinding.DisplayStringOptions)0)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		deviceLayoutName = null;
		controlPath = null;
		ReadOnlyArray<InputBinding> bindings = action.bindings;
		int count = bindings.Count;
		if (bindingIndex < 0 || bindingIndex >= count)
		{
			throw new ArgumentOutOfRangeException($"Binding index {bindingIndex} is out of range on action '{action}' with {bindings.Count} bindings", "bindingIndex");
		}
		if (bindings[bindingIndex].isComposite)
		{
			string name = NameAndParameters.Parse(bindings[bindingIndex].effectivePath).name;
			int firstPartIndex = bindingIndex + 1;
			int i;
			for (i = firstPartIndex; i < count && bindings[i].isPartOfComposite; i++)
			{
			}
			int partCount = i - firstPartIndex;
			string[] partStrings = new string[partCount];
			for (int j = 0; j < partCount; j++)
			{
				string text = action.GetBindingDisplayString(firstPartIndex + j, options);
				if (string.IsNullOrEmpty(text))
				{
					text = " ";
				}
				partStrings[j] = text;
			}
			string displayFormatString = InputBindingComposite.GetDisplayFormatString(name);
			if (string.IsNullOrEmpty(displayFormatString))
			{
				return StringHelpers.Join("/", partStrings);
			}
			return StringHelpers.ExpandTemplateString(displayFormatString, delegate(string fragment)
			{
				string text2 = string.Empty;
				for (int k = 0; k < partCount; k++)
				{
					if (string.Equals(bindings[firstPartIndex + k].name, fragment, StringComparison.InvariantCultureIgnoreCase))
					{
						text2 = (string.IsNullOrEmpty(text2) ? partStrings[k] : (text2 + "|" + partStrings[k]));
					}
				}
				if (string.IsNullOrEmpty(text2))
				{
					text2 = " ";
				}
				return text2;
			});
		}
		InputControl control = null;
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		orCreateActionMap.ResolveBindingsIfNecessary();
		InputActionState state = orCreateActionMap.m_State;
		int bindingIndexInMap = action.BindingIndexOnActionToBindingIndexOnMap(bindingIndex);
		int bindingIndexInState = state.GetBindingIndexInState(orCreateActionMap.m_MapIndexInState, bindingIndexInMap);
		InputActionState.BindingState* ptr = state.bindingStates + bindingIndexInState;
		if (ptr->controlCount > 0)
		{
			control = state.controls[ptr->controlStartIndex];
		}
		InputBinding inputBinding = bindings[bindingIndex];
		if (string.IsNullOrEmpty(inputBinding.effectiveInteractions))
		{
			inputBinding.overrideInteractions = action.interactions;
		}
		else if (!string.IsNullOrEmpty(action.interactions))
		{
			inputBinding.overrideInteractions = inputBinding.effectiveInteractions + ";action.interactions";
		}
		return inputBinding.ToDisplayString(out deviceLayoutName, out controlPath, options, control);
	}

	public static void ApplyBindingOverride(this InputAction action, string newPath, string group = null, string path = null)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		action.ApplyBindingOverride(new InputBinding
		{
			overridePath = newPath,
			groups = group,
			path = path
		});
	}

	public static void ApplyBindingOverride(this InputAction action, InputBinding bindingOverride)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		bool enabled = action.enabled;
		if (enabled)
		{
			action.Disable();
		}
		bindingOverride.action = action.name;
		action.GetOrCreateActionMap().ApplyBindingOverride(bindingOverride);
		if (enabled)
		{
			action.Enable();
			action.RequestInitialStateCheckOnEnabledAction();
		}
	}

	public static void ApplyBindingOverride(this InputAction action, int bindingIndex, InputBinding bindingOverride)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		int bindingIndex2 = action.BindingIndexOnActionToBindingIndexOnMap(bindingIndex);
		bindingOverride.action = action.name;
		action.GetOrCreateActionMap().ApplyBindingOverride(bindingIndex2, bindingOverride);
	}

	public static void ApplyBindingOverride(this InputAction action, int bindingIndex, string path)
	{
		if (path == null)
		{
			throw new ArgumentException("Binding path cannot be null", "path");
		}
		action.ApplyBindingOverride(bindingIndex, new InputBinding
		{
			overridePath = path
		});
	}

	public static int ApplyBindingOverride(this InputActionMap actionMap, InputBinding bindingOverride)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		InputBinding[] bindings = actionMap.m_Bindings;
		if (bindings == null)
		{
			return 0;
		}
		int num = bindings.Length;
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			if (bindingOverride.Matches(ref bindings[i]))
			{
				bindings[i].overridePath = bindingOverride.overridePath;
				bindings[i].overrideInteractions = bindingOverride.overrideInteractions;
				bindings[i].overrideProcessors = bindingOverride.overrideProcessors;
				num2++;
			}
		}
		if (num2 > 0)
		{
			actionMap.OnBindingModified();
		}
		return num2;
	}

	public static void ApplyBindingOverride(this InputActionMap actionMap, int bindingIndex, InputBinding bindingOverride)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		InputBinding[] bindings = actionMap.m_Bindings;
		int num = ((bindings != null) ? bindings.Length : 0);
		if (bindingIndex < 0 || bindingIndex >= num)
		{
			throw new ArgumentOutOfRangeException("bindingIndex", $"Cannot apply override to binding at index {bindingIndex} in map '{actionMap}' with only {num} bindings");
		}
		actionMap.m_Bindings[bindingIndex].overridePath = bindingOverride.overridePath;
		actionMap.m_Bindings[bindingIndex].overrideInteractions = bindingOverride.overrideInteractions;
		actionMap.m_Bindings[bindingIndex].overrideProcessors = bindingOverride.overrideProcessors;
		actionMap.OnBindingModified();
	}

	public static void RemoveBindingOverride(this InputAction action, int bindingIndex)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		action.ApplyBindingOverride(bindingIndex, default(InputBinding));
	}

	public static void RemoveBindingOverride(this InputAction action, InputBinding bindingMask)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		bindingMask.overridePath = null;
		bindingMask.overrideInteractions = null;
		bindingMask.overrideProcessors = null;
		action.ApplyBindingOverride(bindingMask);
	}

	private static void RemoveBindingOverride(this InputActionMap actionMap, InputBinding bindingMask)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		bindingMask.overridePath = null;
		bindingMask.overrideInteractions = null;
		bindingMask.overrideProcessors = null;
		actionMap.ApplyBindingOverride(bindingMask);
	}

	public static void RemoveAllBindingOverrides(this IInputActionCollection2 actions)
	{
		if (actions == null)
		{
			throw new ArgumentNullException("actions");
		}
		using (DeferBindingResolution())
		{
			foreach (InputAction action in actions)
			{
				InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
				InputBinding[] bindings = orCreateActionMap.m_Bindings;
				int num = bindings.LengthSafe();
				for (int i = 0; i < num; i++)
				{
					ref InputBinding reference = ref bindings[i];
					if (reference.TriggersAction(action))
					{
						reference.RemoveOverrides();
					}
				}
				orCreateActionMap.OnBindingModified();
			}
		}
	}

	public static void RemoveAllBindingOverrides(this InputAction action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		string name = action.name;
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		InputBinding[] bindings = orCreateActionMap.m_Bindings;
		if (bindings == null)
		{
			return;
		}
		int num = bindings.Length;
		for (int i = 0; i < num; i++)
		{
			if (string.Compare(bindings[i].action, name, StringComparison.InvariantCultureIgnoreCase) == 0)
			{
				bindings[i].overridePath = null;
				bindings[i].overrideInteractions = null;
				bindings[i].overrideProcessors = null;
			}
		}
		orCreateActionMap.OnBindingModified();
	}

	public static void ApplyBindingOverrides(this InputActionMap actionMap, IEnumerable<InputBinding> overrides)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (overrides == null)
		{
			throw new ArgumentNullException("overrides");
		}
		foreach (InputBinding @override in overrides)
		{
			actionMap.ApplyBindingOverride(@override);
		}
	}

	public static void RemoveBindingOverrides(this InputActionMap actionMap, IEnumerable<InputBinding> overrides)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (overrides == null)
		{
			throw new ArgumentNullException("overrides");
		}
		foreach (InputBinding @override in overrides)
		{
			actionMap.RemoveBindingOverride(@override);
		}
	}

	public static int ApplyBindingOverridesOnMatchingControls(this InputAction action, InputControl control)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		ReadOnlyArray<InputBinding> bindings = action.bindings;
		int count = bindings.Count;
		int num = 0;
		for (int i = 0; i < count; i++)
		{
			InputControl inputControl = InputControlPath.TryFindControl(control, bindings[i].path);
			if (inputControl != null)
			{
				action.ApplyBindingOverride(i, inputControl.path);
				num++;
			}
		}
		return num;
	}

	public static int ApplyBindingOverridesOnMatchingControls(this InputActionMap actionMap, InputControl control)
	{
		if (actionMap == null)
		{
			throw new ArgumentNullException("actionMap");
		}
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		ReadOnlyArray<InputAction> actions = actionMap.actions;
		int count = actions.Count;
		int result = 0;
		for (int i = 0; i < count; i++)
		{
			result = actions[i].ApplyBindingOverridesOnMatchingControls(control);
		}
		return result;
	}

	public static string SaveBindingOverridesAsJson(this IInputActionCollection2 actions)
	{
		if (actions == null)
		{
			throw new ArgumentNullException("actions");
		}
		List<InputActionMap.BindingOverrideJson> list = new List<InputActionMap.BindingOverrideJson>();
		foreach (InputBinding binding in actions.bindings)
		{
			actions.AddBindingOverrideJsonTo(binding, list);
		}
		if (list.Count == 0)
		{
			return string.Empty;
		}
		return JsonUtility.ToJson((object)new InputActionMap.BindingOverrideListJson
		{
			bindings = list
		});
	}

	public static string SaveBindingOverridesAsJson(this InputAction action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		bool isSingletonAction = action.isSingletonAction;
		InputActionMap orCreateActionMap = action.GetOrCreateActionMap();
		List<InputActionMap.BindingOverrideJson> list = new List<InputActionMap.BindingOverrideJson>();
		foreach (InputBinding binding in action.bindings)
		{
			if (isSingletonAction || binding.TriggersAction(action))
			{
				orCreateActionMap.AddBindingOverrideJsonTo(binding, list, isSingletonAction ? action : null);
			}
		}
		if (list.Count == 0)
		{
			return string.Empty;
		}
		return JsonUtility.ToJson((object)new InputActionMap.BindingOverrideListJson
		{
			bindings = list
		});
	}

	private static void AddBindingOverrideJsonTo(this IInputActionCollection2 actions, InputBinding binding, List<InputActionMap.BindingOverrideJson> list, InputAction action = null)
	{
		if (binding.hasOverrides)
		{
			if (action == null)
			{
				action = actions.FindAction(binding.action);
			}
			string actionName = ((action != null && !action.isSingletonAction) ? (action.actionMap.name + "/" + action.name) : "");
			InputActionMap.BindingOverrideJson item = InputActionMap.BindingOverrideJson.FromBinding(binding, actionName);
			list.Add(item);
		}
	}

	public static void LoadBindingOverridesFromJson(this IInputActionCollection2 actions, string json, bool removeExisting = true)
	{
		if (actions == null)
		{
			throw new ArgumentNullException("actions");
		}
		using (DeferBindingResolution())
		{
			if (removeExisting)
			{
				actions.RemoveAllBindingOverrides();
			}
			actions.LoadBindingOverridesFromJsonInternal(json);
		}
	}

	public static void LoadBindingOverridesFromJson(this InputAction action, string json, bool removeExisting = true)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		using (DeferBindingResolution())
		{
			if (removeExisting)
			{
				action.RemoveAllBindingOverrides();
			}
			action.GetOrCreateActionMap().LoadBindingOverridesFromJsonInternal(json);
		}
	}

	private static void LoadBindingOverridesFromJsonInternal(this IInputActionCollection2 actions, string json)
	{
		if (string.IsNullOrEmpty(json))
		{
			return;
		}
		foreach (InputActionMap.BindingOverrideJson binding in JsonUtility.FromJson<InputActionMap.BindingOverrideListJson>(json).bindings)
		{
			if (!string.IsNullOrEmpty(binding.id))
			{
				int num = actions.FindBinding(new InputBinding
				{
					m_Id = binding.id
				}, out var action);
				if (num != -1)
				{
					action.ApplyBindingOverride(num, InputActionMap.BindingOverrideJson.ToBinding(binding));
					continue;
				}
			}
			Debug.LogWarning("Could not override binding as no existing binding was found with the id: " + binding.id);
		}
	}

	public static RebindingOperation PerformInteractiveRebinding(this InputAction action, int bindingIndex = -1)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		RebindingOperation rebindingOperation = new RebindingOperation().WithAction(action).OnMatchWaitForAnother(0.05f).WithControlsExcluding("<Pointer>/delta")
			.WithControlsExcluding("<Pointer>/position")
			.WithControlsExcluding("<Touchscreen>/touch*/position")
			.WithControlsExcluding("<Touchscreen>/touch*/delta")
			.WithControlsExcluding("<Mouse>/clickCount")
			.WithMatchingEventsBeingSuppressed();
		if (rebindingOperation.expectedControlType != "Button")
		{
			rebindingOperation.WithCancelingThrough("<Keyboard>/escape");
		}
		if (bindingIndex >= 0)
		{
			ReadOnlyArray<InputBinding> bindings = action.bindings;
			if (bindingIndex >= bindings.Count)
			{
				throw new ArgumentOutOfRangeException($"Binding index {bindingIndex} is out of range for action '{action}' with {bindings.Count} bindings", "bindings");
			}
			if (bindings[bindingIndex].isComposite)
			{
				throw new InvalidOperationException($"Cannot perform rebinding on composite binding '{bindings[bindingIndex]}' of '{action}'");
			}
			rebindingOperation.WithTargetBinding(bindingIndex);
		}
		return rebindingOperation;
	}

	internal static DeferBindingResolutionWrapper DeferBindingResolution()
	{
		if (s_DeferBindingResolutionWrapper == null)
		{
			s_DeferBindingResolutionWrapper = new DeferBindingResolutionWrapper();
		}
		s_DeferBindingResolutionWrapper.Acquire();
		return s_DeferBindingResolutionWrapper;
	}
}
