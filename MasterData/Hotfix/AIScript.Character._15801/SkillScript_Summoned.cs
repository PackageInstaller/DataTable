using AIScript.Utils;

namespace AIScript.Character._15801;

public class SkillScript_Summoned : SkillAdvancedBase
{
	protected PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	protected bool HavePersonalPerk(int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_summoner == null)
		{
			return false;
		}
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
	}
}
