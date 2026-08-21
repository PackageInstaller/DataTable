using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置被嘲讽", 0)]
[Category("Logic/AI")]
[Description("设置被嘲讽, 传0就是取消, 一般是buff调用")]
public class SetTauntTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> tauntIDInput = AddValueInput<int>("谁放的嘲讽");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && entityWithEntityID.hasEntityBlackboard)
			{
				int value = tauntIDInput.value;
				AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2213, value, 0L, 0L);
				AIProcessor.ChangeTarget(entityWithEntityID, value);
				entityWithEntityID.entityBlackboard.var.hasManualLock = true;
			}
			output.Call(f);
		});
	}
}
