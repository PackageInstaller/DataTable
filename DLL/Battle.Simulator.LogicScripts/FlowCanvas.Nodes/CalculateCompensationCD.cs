using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]计算CD的补尝值(过时)", 0)]
[Category("Logic/Attribute")]
[Description("计算CD的补尝值")]
[ExposeAsDefinition]
public class CalculateCompensationCD : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int entityID, int abilityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		int mLogicTime = entityWithEntityID.entityActionAbility.mLogicTime;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
		int maxUseCount;
		if (!ConfigProcessor.IsMoveRecover(entityWithEntityID) && !ConfigProcessor.IsRecover(entityWithEntityID) && config.CDCompensationList.Count > 0)
		{
			int num = 0;
			for (int i = 0; i < config.CDCompensationList.Count; i++)
			{
				CDCompensationInfo cDCompensationInfo = config.CDCompensationList.get_Item(i);
				if (mLogicTime >= cDCompensationInfo.Start && mLogicTime <= cDCompensationInfo.Start + cDCompensationInfo.Duration)
				{
					num = config.CDCompensationList.get_Item(i).CDCompensation;
					break;
				}
			}
			ConfigHelper.GetInstance().GetConfig<public_skill>(config.ID);
			ConfigProcessor.TryGetCDConfig(entityWithEntityID, config.ID, out var cd, out maxUseCount);
			int num2 = cd;
			return new VFactor((100 - num) * num2, 100L).integer;
		}
		ConfigProcessor.TryGetCDConfig(entityWithEntityID, config.ID, out var cd2, out maxUseCount);
		return cd2;
	}
}
