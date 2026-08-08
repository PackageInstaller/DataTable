using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD结束事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("每次CD结束的时候会触发一次该事件")]
public class CDEndCommonEvent : CDEndEventBase
{
	protected override void AddCustionValueOutput()
	{
	}

	protected override void AddCustomValueInput()
	{
	}

	protected override bool ConditionFunc(SimEntity simEntity, AbilityCD abilityCD)
	{
		return true;
	}
}
