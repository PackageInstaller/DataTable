using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("中止拼刀", 0)]
[Category("Logic/QTE")]
[Description("中止拼刀, 只能单机使用")]
public class StopQTE : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<QTEStatusType> valueInput = AddValueInput<QTEStatusType>("结果").SetDefaultAndSerializedValue(QTEStatusType.Stop);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityQTE)
			{
				falseOut.Call(f);
			}
			else
			{
				QTEStatusType value = valueInput.value;
				if (value == QTEStatusType.Start || value == QTEStatusType.Running)
				{
					falseOut.Call(f);
				}
				else
				{
					entityWithEntityID.entityQTE.mStatus = value;
					trueOut.Call(f);
				}
			}
		});
	}
}
