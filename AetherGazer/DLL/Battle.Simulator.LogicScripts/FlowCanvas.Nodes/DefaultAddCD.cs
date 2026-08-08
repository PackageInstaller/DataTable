using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]默认的添加CD", 0)]
[Category("Logic/Attribute")]
[Description("默认的添加CD, 只需要给被标记为源技能的Ability添加CD,\n如果是技能的最后一段，则给原技能加上CD, \n如果有奖励，先把奖励用掉,使源技能不会进入CD也不会减少使用次数")]
public class DefaultAddCD : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID后3位");
		FlowOutput trueOutput = AddFlowOutput("成功");
		FlowOutput falseOutput = AddFlowOutput("失败");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (!entityWithEntityID.hasEntityCD || !entityWithEntityID.hasEntityRemotePlayer)
			{
				falseOutput.Call(f);
			}
			else
			{
				int abilityID = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
				abilityID = CDProcessor.CheckAbilityIsAvoid(abilityID);
				AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(abilityID);
				if (config != null && (config.OriginAbility == 0 || abilityID == config.OriginAbility))
				{
					abilityID = ((config.OriginAbility == 0 || abilityID == config.OriginAbility) ? abilityID : config.OriginAbility);
					if (entityWithEntityID.hasEntityCD)
					{
						CDProcessor.AddCD(entityWithEntityID, abilityID);
					}
				}
				trueOutput.Call(f);
			}
		});
	}
}
