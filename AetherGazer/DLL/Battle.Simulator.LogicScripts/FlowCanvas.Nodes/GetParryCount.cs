using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]得到格挡激活计数(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("得到格挡激活计数")]
public class GetParryCount : FlowControlNodeOfLogic
{
	private int _count;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_count = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else
			{
				if (!entityWithEntityID.hasEntityActionParrying)
				{
					_count = 0;
				}
				else
				{
					_count = entityWithEntityID.entityActionParrying.mEnableCount;
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("值", "value", () => _count);
	}
}
