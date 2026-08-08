using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取拼刀状态", 0)]
[Category("Logic/QTE")]
[Description("获取拼刀状态, 只能单机使用")]
public class GetQTEStatus : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		QTEStatusType res = QTEStatusType.Running;
		AddValueOutput("当前状态", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityQTE)
			{
				falseOut.Call(f);
			}
			else
			{
				res = entityWithEntityID.entityQTE.mStatus;
				trueOut.Call(f);
			}
		});
	}
}
