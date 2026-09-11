using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置抓取对象", 0)]
[Category("Logic/Config")]
[Description("设置抓取对象")]
public class SetGrabTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> valueInput = AddValueInput<int>("目标ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				output.Call(f);
			}
			else
			{
				if (valueInput.value == 0)
				{
					int mGrabTarget = entityWithEntityID.entityBlackboard.var.mGrabTarget;
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mGrabTarget);
					if (entityWithEntityID2 != null)
					{
						entityWithEntityID2.entityBlackboard.var.mIsCaught = false;
					}
				}
				entityWithEntityID.entityBlackboard.var.mGrabTarget = valueInput.value;
				output.Call(f);
			}
		});
	}
}
