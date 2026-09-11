using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("保持受击状态", 0)]
[Category("Logic/Buff")]
[Description("保持受击状态,设置当前状态为受击动作第一帧,可能需要一直调用")]
public class KeepHitRecover : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID.hasEntityHitRecover && entityWithEntityID.entityHitRecover.mHitRecoverTime >= CommonProcessor.GetConfigInterval())
			{
				entityWithEntityID.entityHitRecover.mTimeScale = 0;
				entityWithEntityID.entityHitRecover.mEnableMovement = false;
			}
			else if (!entityWithEntityID.hasEntityHitRecover && !entityWithEntityID.hasEntityActionAbility)
			{
				BuffProcessor.AddHitRecoverComponent(entityWithEntityID, E_HitRecoverStatus.HitReocver);
			}
			BuffProcessor.RemoveInputMovementAndAbility(entityWithEntityID);
			output.Call(f);
		});
	}
}
