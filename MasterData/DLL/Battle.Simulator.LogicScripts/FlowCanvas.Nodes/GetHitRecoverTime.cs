using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前受击时间", 0)]
[Category("Logic/Abilities")]
[Description("获取当前受击时间")]
public class GetHitRecoverTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int currentTime = 0;
		int maxTime = 0;
		AddValueOutput("当前时间", () => currentTime);
		AddValueOutput("总时间", () => maxTime);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityHitRecover)
			{
				f.Call(falseOut);
			}
			else
			{
				maxTime = AbilitiesProcessor.GetTimelineDuration(entityWithEntityID, entityWithEntityID.entityHitRecover.mHitRecoverActionID, entityWithEntityID.entityHitRecover.mHitRecoverStatus);
				currentTime = entityWithEntityID.entityHitRecover.mHitRecoverTime;
				f.Call(trueOut);
			}
		});
	}
}
