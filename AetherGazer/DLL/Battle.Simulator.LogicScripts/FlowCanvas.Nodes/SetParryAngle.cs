using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]设置格挡角度(逻辑)(过时)", 0)]
[Category("Logic/格挡")]
[Description("以角色正方向为中心,例如60度,则左30右30")]
public class SetParryAngle : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> angleInput = AddValueInput<int>("角度", "angle").SetDefaultAndSerializedValue(360);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput unparryOut = AddFlowOutput("无格挡", "unparry");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionParrying)
			{
				unparryOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityActionParrying.mAngle = angleInput.value;
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
