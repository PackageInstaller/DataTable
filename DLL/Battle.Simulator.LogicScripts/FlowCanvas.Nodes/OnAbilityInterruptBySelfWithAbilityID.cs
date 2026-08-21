using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD返还事件(技能ID)", 0)]
[Category("Logic/事件")]
[Description("技能被自我打断时的事件(本事件会在CD返还后触发)")]
public class OnAbilityInterruptBySelfWithAbilityID : OnAbilityInterruptBySelf
{
	private ValueInput<int> _targetAbilityIDInput;

	protected override void OnTriggerAbilityInterruptBySelf(int simEntityID, int abilityID)
	{
		if (abilityID == _targetAbilityIDInput.value)
		{
			base.OnTriggerAbilityInterruptBySelf(simEntityID, abilityID);
		}
	}

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_targetAbilityIDInput = AddValueInput<int>("技能ID");
	}
}
