using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("清除移动", 0)]
[Category("Logic/Buff/效果/移动")]
[Description("用于停止移动,针对移动组件进行停止操作,如果需要持续停止,则需要每帧调用,例如buff中停止移动")]
public class StopMovableOnTick : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID != null)
			{
				MovementProcessor.Stop(entityWithEntityID);
				MovementProcessor.EnableMovement(entityWithEntityID, isActive: false);
			}
			output.Call(f);
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
