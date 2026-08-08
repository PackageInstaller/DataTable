using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]得到格挡角度(逻辑)(过时)", 0)]
[Category("Logic/格挡")]
[Description("得到格挡角度")]
public class GetParryAngle : FlowControlNodeOfLogic
{
	private int _angle;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput unparryOut = AddFlowOutput("无格挡", "unparry");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_angle = 0;
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityActionAbility && (!entityWithEntityID.hasEntityActionParrying || !entityWithEntityID.entityActionParrying.IsEnable()))
			{
				unparryOut.Call(f);
			}
			else if (entityWithEntityID.hasEntityActionParrying)
			{
				_angle = 360;
				output.Call(f);
			}
			else
			{
				if (ConfigProcessor.TryGetParryingInfo(entityWithEntityID.entityActionAbility.mAbilityID, entityWithEntityID.entityActionAbility.mLogicTime, out var pParryActionInfo, out var _))
				{
					_angle = pParryActionInfo.Angle;
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("角度(度)", "angle", () => _angle);
	}
}
