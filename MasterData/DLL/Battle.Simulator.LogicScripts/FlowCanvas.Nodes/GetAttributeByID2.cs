using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[逻辑黑板]得到属性值", 0)]
[Category("Logic/Attribute")]
[Description("得到实体黑板属性对应的值")]
public class GetAttributeByID2 : FlowControlNodeOfLogic
{
	private long _v;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> wantedVarIntNameInput = AddValueInput<int>("变量名字", "wantedVarIntName");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput nullOut = AddFlowOutput("无变量", "null");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				_v = 0L;
				if (!AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, wantedVarIntNameInput.value, out _v, out var _, out var _))
				{
					nullOut.Call(f);
				}
				else
				{
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => _v);
	}
}
