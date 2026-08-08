using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取抓取对象", 0)]
[Category("Logic/Config")]
[Description("获取抓取对象")]
public class GetGrabTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("目标ID", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			return (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard) ? entityWithEntityID.entityBlackboard.var.mGrabTarget : 0;
		});
	}
}
