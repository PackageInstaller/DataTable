using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionCheckSkillLayer : BuffConditionBase
{
	protected int skillId;

	protected CompareMethodType methodType;

	protected int checkLayer;

	public override BuffConditionType BuffConditionType => BuffConditionType.CheckSkillLayer;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
		checkLayer = Utility.Convert.StringToInt(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{methodType},{checkLayer}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		HeroSkillData heroSkillData = entityTarget.GetComponent<SkillComponent>()?.GetSkillData(skillId);
		int num = heroSkillData?.CacheLayer ?? 0;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"SkillId :{skillId}  检查技能层数  {num}  checkLayer  {checkLayer}", entityTarget);
		}
		return ConditionExtensions.CompareValueMethod(methodType, heroSkillData.CacheLayer, checkLayer);
	}
}
