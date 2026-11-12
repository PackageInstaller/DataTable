using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ActionScript_Summoned : AIBase
{
	protected enum SummonedType
	{
		None,
		Dragon,
		Tiger
	}

	protected PlayerAdventureActor _summoner;

	protected SummonedType _summonedType;

	private CoroutineNode _perkLogicCor_P22;

	private PlayFX _playFX_P22;

	private long _areaEffectId_P24;

	private long _areaEffectId_P27;

	public virtual void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		_areaEffectId_P24 = 0L;
		_areaEffectId_P27 = 0L;
	}

	protected bool HavePersonalPerk(int perkId)
	{
		if (_summoner == null)
		{
			return false;
		}
		int perkLevel;
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
	}

	public virtual void OnStart()
	{
		_actor.monsterTarget = null;
		if (HavePersonalPerk(514122))
		{
			if (_perkLogicCor_P22 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P22);
			}
			_perkLogicCor_P22 = _actor.StartLogicCoroutine(PerkLogic_P22());
		}
		if (HavePersonalPerk(514124) && _actor.logicVariable.GetLogicTagToggle("IsFirstSummoned"))
		{
			_areaEffectId_P24 = _summonedType switch
			{
				SummonedType.Dragon => ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Summon_Snake_P24_FireCoat", _actor.tsTransform.Position), 
				SummonedType.Tiger => ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Summon_Tiger_P24_FireCoat", _actor.tsTransform.Position), 
				_ => 0L, 
			};
		}
		if (HavePersonalPerk(514127))
		{
			_areaEffectId_P27 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Summon_P27_Defense", _actor.tsTransform.Position);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
	}

	private IEnumerator PerkLogic_P22()
	{
		if (_playFX_P22 == null)
		{
			_playFX_P22 = new PlayFX();
		}
		else
		{
			_playFX_P22.Clear();
		}
		while (_summoner.logicVariable.GetLogicTagValue("SummonedCount").AsInt() < 2)
		{
			yield return null;
		}
		_actor.buffComponent.AddBuff(14122011, _summoner);
		switch (_summonedType)
		{
		case SummonedType.Dragon:
			_playFX_P22.Play(_actor, null, "fx_14101_Buff_Support_Skill_P22_Summon_1_Exciting", default, _actor.tsTransform.Position, default);
			break;
		case SummonedType.Tiger:
			_playFX_P22.Play(_actor, null, "fx_14101_Buff_Support_Skill_P22_Summon_1_Exciting", default, _actor.tsTransform.Position, default);
			break;
		}
		FP time = Config_Support.scaleChangeTime_P22;
		FP scaleChangeMutli = Config_Support.scaleMutli_P22 - _actor.actorScaleInfo.modelScale;
		while (time > 0)
		{
			_actor.actorScaleInfo.modelScale += scaleChangeMutli * _actor.LogicDeltaTime;
			time -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	public virtual void OnUpdate()
	{
	}

	private void OnActorCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (adventureActorCastSkillEvent.sender as AdventureActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			OnMainPlayerActorCastSkill();
		}
	}

	protected virtual void OnMainPlayerActorCastSkill()
	{
	}

	public virtual void OnStop()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnActorCastSkill);
		if (_perkLogicCor_P22 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P22);
		}
		_perkLogicCor_P22 = null;
		if (_areaEffectId_P24 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P24);
		}
		_areaEffectId_P24 = 0L;
		if (_areaEffectId_P27 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P27);
		}
		_areaEffectId_P27 = 0L;
	}

	public virtual void OnDisable()
	{
		_summoner = null;
	}
}
