using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否处于闪避行为(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("是否处于闪避行为")]
public class IsInAvoidAbility : FlowControlNodeOfLogic
{
	private int _timelineID;

	private int _actionID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_timelineID = 0;
			_actionID = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			RoleConfig config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(entityWithEntityID.entityConfig.mId, out config))
			{
				errorOut.Call(f);
			}
			else
			{
				_timelineID = entityWithEntityID.entityActionAbility.mAbilityID;
				_actionID = _timelineID % 1000;
				if (entityWithEntityID.hasEntityActionAbility && config.AvoidAbility.Contains(entityWithEntityID.entityActionAbility.mAbilityID))
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("TimelineID", "timelineID", () => _timelineID);
		AddValueOutput("后三位", "actionID", () => _actionID);
	}
}
