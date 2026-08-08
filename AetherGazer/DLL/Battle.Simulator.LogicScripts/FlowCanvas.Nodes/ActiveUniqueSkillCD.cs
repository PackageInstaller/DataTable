using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("激活奥义CD(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("如题")]
public class ActiveUniqueSkillCD : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "EntityID");
		_out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			UniqueSkill config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
			{
				_Error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.ENTITY_CONFIG_ID, out config) || config.AbilityId.Count <= 0)
			{
				_Error.Call(f);
			}
			else
			{
				int num = config.AbilityId.get_Item(0);
				AbilityConfig config2 = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(num);
				if (config2 != null && (config2.OriginAbility == 0 || num == config2.OriginAbility))
				{
					num = ((config2.OriginAbility == 0 || num == config2.OriginAbility) ? num : config2.OriginAbility);
					if (entityWithEntityID.hasEntityCD && !CDProcessor.HasAward(entityWithEntityID, num))
					{
						CDProcessor.AddCD(entityWithEntityID, num);
					}
				}
				_out.Call(f);
			}
		});
		AddValueOutput("EntityID", "EntityID", () => _EntityIDInput.GetValue());
	}
}
