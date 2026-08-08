using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前ability时间", 0)]
[Category("Logic/Abilities")]
[Description("获取当前ability时间")]
public class GetAbilityCurrent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		AddValueOutput("时间", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			return entityWithEntityID.hasEntityActionAbility ? entityWithEntityID.entityActionAbility.mLogicTime : 0;
		});
	}
}
