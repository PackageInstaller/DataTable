using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]激活格挡(布尔)(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("激活格挡;\n布尔类型直接作为开关,与计数是独立的")]
public class EnableParryOfBool : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<bool> enableInput = AddValueInput<bool>("激活", "enable").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else
			{
				if (!entityWithEntityID.hasEntityActionParrying)
				{
					if (!enableInput.value)
					{
						output.Call(f);
						return;
					}
					entityWithEntityID.AddEntityActionParrying(360, 0u, 0);
				}
				entityWithEntityID.entityActionParrying.SetEnableFlag(En_ParryingEnableType.NodeControl, enableInput.value);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
