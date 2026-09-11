using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI目标是否在范围内(精简版)", 0)]
[Category("Logic/AI")]
[Description("AI目标是否在range范围内,如果没有目标也返回false, 范围要小于40000")]
public class AITargetDistance : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID = AddValueInput<int>("entityID");
		ValueInput<int> range = AddValueInput<int>("range");
		AddValueOutput("entityID", () => entityID.value);
		ValueInput<HitHeight> heightInput = AddValueInput<HitHeight>("覆盖的高度标签").SetDefaultAndSerializedValue((HitHeight)(-1));
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID.value);
			_ = range.value;
			_ = 40000;
			if (AIProcessor.IsTargetInRange(entityWithEntityID, range.value))
			{
				HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(CommonProcessor.GetSimEntityByMultiColliders(base.mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget)));
				if (curHitHeight != HitHeight.None && !heightInput.value.HasFlag(curHitHeight))
				{
					falseOut.Call(f);
				}
				else
				{
					trueOut.Call(f);
				}
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
