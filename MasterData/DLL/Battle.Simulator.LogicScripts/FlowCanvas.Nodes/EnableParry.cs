using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]激活格挡(位)(慎用)(逻辑)", 0)]
[Category("Logic/格挡")]
[Description("激活格挡;\n使用位作为标志位,其中已占用0(None)1(Ability)2(NodeControl)")]
public class EnableParry : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> indexInput = AddValueInput<int>("标志位(0-31)", "index");
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
			else if (indexInput.value < 0 || indexInput.value > 31)
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
				entityWithEntityID.entityActionParrying.SetEnableFlag(indexInput.value, enableInput.value);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
