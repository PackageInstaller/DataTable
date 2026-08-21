using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能上个Hit高度配置", 0)]
[Category("Logic/Config")]
[Description("获取技能上一个Hit配置, 如果没有放技能等, 返回-1")]
public class GetAbilityHitConfig : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> creationIndexVar = AddValueInput<int>("实体ID或抛掷物ID", "creationIndex");
		AddValueOutput("", delegate
		{
			if (creationIndexVar.GetValue() < 0)
			{
				if (ThrownProcessor.TryGetThrown(base.mSimContext, creationIndexVar.GetValue(), out var thrownState))
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
					if (config != null)
					{
						int mLogicTime = thrownState.mLogicTime;
						for (int i = 0; i < config.HitTimeList.Count; i++)
						{
							HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(i);
							if (mLogicTime >= hitCheckInfo.Start && mLogicTime < hitCheckInfo.Start + hitCheckInfo.Duration)
							{
								return hitCheckInfo.HitHeight;
							}
						}
					}
				}
				return -1;
			}
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(creationIndexVar.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
			{
				Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (entityWithEntityID.entityActionAbility.mHitIndex - 1 < config2.HitTimeList.Count && entityWithEntityID.entityActionAbility.mHitIndex - 1 >= 0)
				{
					return config2.HitTimeList.get_Item(entityWithEntityID.entityActionAbility.mHitIndex - 1).HitHeight;
				}
				return -1;
			}
			return -1;
		});
	}
}
