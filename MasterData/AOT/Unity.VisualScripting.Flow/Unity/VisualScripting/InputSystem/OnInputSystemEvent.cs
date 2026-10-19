using System;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Unity.VisualScripting.InputSystem;

[UnitCategory("Events/Input")]
public abstract class OnInputSystemEvent : MachineEventUnit<EmptyEventArgs>
{
	[UnitHeaderInspectable]
	[Inspectable]
	[Serialize]
	public InputActionChangeOption InputActionChangeType;

	private InputAction m_Action;

	private Vector2 m_Value;

	protected override string hookName
	{
		get
		{
			if (UnityEngine.InputSystem.InputSystem.settings.updateMode != InputSettings.UpdateMode.ProcessEventsInDynamicUpdate)
			{
				return "FixedUpdate";
			}
			return "Update";
		}
	}

	protected abstract OutputType OutputType { get; }

	[DoNotSerialize]
	public ValueInput InputAction { get; private set; }

	[DoNotSerialize]
	[NullMeansSelf]
	[PortLabelHidden]
	public ValueInput Target { get; private set; }

	[PortLabelHidden]
	public ValueOutput FloatValue { get; private set; }

	[PortLabelHidden]
	public ValueOutput Vector2Value { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		Target = ValueInput(typeof(PlayerInput), "Target");
		Target.SetDefaultValue(null);
		Target.NullMeansSelf();
		InputAction = ValueInput(typeof(InputAction), "InputAction");
		InputAction.SetDefaultValue(null);
		switch (OutputType)
		{
		case OutputType.Float:
			FloatValue = ValueOutput("FloatValue", (Flow _) => m_Value.x);
			break;
		case OutputType.Vector2:
			Vector2Value = ValueOutput("Vector2Value", (Flow _) => m_Value);
			break;
		default:
			throw new ArgumentOutOfRangeException();
		case OutputType.Button:
			break;
		}
	}

	public override void StartListening(GraphStack stack)
	{
		base.StartListening(stack);
		GraphReference reference = stack.ToReference();
		PlayerInput playerInput = Flow.FetchValue<PlayerInput>(Target, reference);
		InputAction inputAction = Flow.FetchValue<InputAction>(InputAction, reference);
		if (inputAction != null)
		{
			ref InputAction action = ref m_Action;
			InputAction inputAction2;
			if ((bool)playerInput)
			{
				inputAction2 = playerInput.actions.FindAction(inputAction.id);
			}
			else
			{
				inputAction2 = ((inputAction.actionMap != null) ? inputAction : null);
			}
			action = inputAction2;
		}
	}

	public override void StopListening(GraphStack stack)
	{
		base.StopListening(stack);
		m_Action = null;
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		if (m_Action == null)
		{
			return false;
		}
		bool result = InputActionChangeType switch
		{
			InputActionChangeOption.OnPressed => m_Action.WasPressedThisFrame(), 
			InputActionChangeOption.OnHold => (OutputType == OutputType.Vector2) ? m_Action.triggered : m_Action.IsPressed(), 
			InputActionChangeOption.OnReleased => m_Action.WasReleasedThisFrame(), 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		DoAssignArguments(flow);
		return result;
	}

	private void DoAssignArguments(Flow flow)
	{
		switch (OutputType)
		{
		case OutputType.Float:
		{
			float num = m_Action.ReadValue<float>();
			m_Value.Set(num, 0f);
			flow.SetValue(FloatValue, num);
			break;
		}
		case OutputType.Vector2:
			flow.SetValue(value: m_Value = m_Action.ReadValue<Vector2>(), port: Vector2Value);
			break;
		default:
			throw new ArgumentOutOfRangeException();
		case OutputType.Button:
			break;
		}
	}
}
