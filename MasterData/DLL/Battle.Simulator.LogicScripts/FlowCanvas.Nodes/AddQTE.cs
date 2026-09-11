using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("激活拼刀", 0)]
[Category("Logic/QTE")]
[Description("激活拼刀, 只能单机使用")]
public class AddQTE : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> maxTimeInput = AddValueInput<int>("最大持续时间");
		ValueInput<int> IDInput = AddValueInput<int>("拼刀ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || entityWithEntityID.hasEntityQTE)
			{
				falseOut.Call(f);
			}
			else
			{
				entityWithEntityID.AddEntityQTE(QTEStatusType.Start, IDInput.value, 0, maxTimeInput.value);
				trueOut.Call(f);
			}
		});
	}
}
