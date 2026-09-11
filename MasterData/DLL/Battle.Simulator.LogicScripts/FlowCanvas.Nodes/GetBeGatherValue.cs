using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[聚怪]得到被聚值", 0)]
[Category("Logic/聚怪")]
[Description("得到被聚值")]
public class GetBeGatherValue : FlowControlNodeOfLogic
{
	private int _beGatherValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput noneOut = AddFlowOutput("无被聚值", "none");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_beGatherValue = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			int pValue;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (!GatherHelper.TryGetBeGatherValue(entityWithEntityID, out pValue))
			{
				noneOut.Call(f);
			}
			else
			{
				_beGatherValue = pValue;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("被聚值", "beGatherValue", () => _beGatherValue);
	}
}
