using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能是否开启(奥义)(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("判断奥义技能是否开启状态")]
public class IsEnableOfUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOut = AddFlowOutput("开启", "true");
		FlowOutput falseOut = AddFlowOutput("禁用", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			UniqueSkill config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out config))
			{
				errorOut.Call(f);
			}
			else
			{
				bool flag = true;
				_ = entityWithEntityID.entityBlackboard;
				for (int i = 0; i < config.AbilityId.Count; i++)
				{
					if (!AttributeProcessor.IsEnableAbility(entityWithEntityID, config.AbilityId.get_Item(i)))
					{
						flag = false;
						break;
					}
				}
				if (flag)
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
	}
}
