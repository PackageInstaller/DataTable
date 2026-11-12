using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Warrior_Support : ActionScript_Summoned_Support
{
	private CoroutineNode _perkLogic_P23;

	public override void OnStart()
	{
		base.OnStart();
		if (HavePersonalPerk(515823, out var perkLevel))
		{
			bool flag = true;
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.FE)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				_perkLogic_P23 = _actor.StartLogicCoroutine(PerkLogic_P23());
			}
		}
		if (HavePersonalPerk(515828, out perkLevel))
		{
			_areaEffectId_P28 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_15801_Support_Skill_P28_Summon_BuffEachOther_P23", _actor.tsTransform.Position);
			_perkLogic_P28 = _actor.StartLogicCoroutine(PerkLogic_P28(158528002, Config_Support.hitRadius_Warrior_P28, Config_Support.hitInnerRadius_Warrior_P28, Config_Support.hitInterval_Warrior_P28), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P23()
	{
		FP interval = Config_Support.interval_AddBuff_P23;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent.AddBuff(15823011, _actor);
				interval += Config_Support.interval_AddBuff_P23;
			}
			yield return null;
		}
	}

	protected override FP GetAttackRange()
	{
		return Config_Support.attackRange_Warrior;
	}

	protected override int GetNormalAttackSkillId()
	{
		return 15896003;
	}

	protected override FP GetNormalAttackInterval()
	{
		return Config_Support.useInterval_NormalAttack_Warrior;
	}

	protected override FP GetUseSkillInterval()
	{
		return Config_Support.useInterval_Skill_Warrior;
	}

	protected override int GetSkillId()
	{
		return 15896004;
	}

	public override void OnStop()
	{
		base.OnStop();
		if (_perkLogic_P23 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P23);
		}
		_perkLogic_P23 = null;
	}
}
