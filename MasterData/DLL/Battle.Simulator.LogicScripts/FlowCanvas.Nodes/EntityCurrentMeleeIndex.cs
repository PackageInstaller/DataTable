using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("当前普攻段数", 0)]
[Category("Logic/Abilities")]
[Description("返回当前普攻段数")]
public class EntityCurrentMeleeIndex : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("普攻段数", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			return entityWithEntityID.hasEntityBlackboard ? entityWithEntityID.entityBlackboard.var.meleeIndex : 0;
		});
	}
}
