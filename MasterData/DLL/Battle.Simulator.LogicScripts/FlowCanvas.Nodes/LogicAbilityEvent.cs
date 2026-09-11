using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件", 0)]
[Category("Logic/事件")]
[Description("技能Update时调用的事件")]
public class LogicAbilityEvent : LogicAbilityEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustionValueOutput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, int abilityID, int logicTime, int actionID)
	{
		return true;
	}
}
