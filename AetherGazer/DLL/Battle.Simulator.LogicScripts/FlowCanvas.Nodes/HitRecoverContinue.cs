using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("恢复受击执行", 0)]
[Category("Logic/Buff")]
[Description("恢复受击执行")]
public class HitRecoverContinue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityHitRecover)
			{
				entityWithEntityID.entityHitRecover.mTimeScale = 100;
			}
			output.Call(f);
		});
	}
}
