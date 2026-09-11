using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取向前闪避槽", 0)]
[Category("Logic/Abilities")]
[Description("获取向前闪避槽")]
public class GetForwardAvoidSlot : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("技能ID", () => base.mSimContext.GetEntityWithEntityID(entityIDInput.value)?.entityBlackboard.var.mAvoidForwardSlots ?? 0);
	}
}
