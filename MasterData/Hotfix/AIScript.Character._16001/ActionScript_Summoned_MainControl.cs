using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class ActionScript_Summoned_MainControl : AIBase
{
	private PlayerAdventureActor _summoner;

	private FP _durationTime;

	private readonly TraceTarget _traceTarget = new TraceTarget();

	private FP _checkTraceInterval;

	private PlayFX _playFX_P2;

	private long _areaEffectId_P2;

	private CoroutineNode _perkLogic_P2;

	public void OnStart()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		if (CommonUtils.HavePersonalPerk(_summoner.dataID, 516002, out var perkLevel))
		{
			if (_perkLogic_P2 != null)
			{
				_actor.StopLogicCoroutine(_perkLogic_P2);
			}
			_perkLogic_P2 = _actor.StartLogicCoroutine(PerkLogic_P2(), runImmediately: true);
		}
		_durationTime = Config_MainControl.durationTime_Summoned;
		if (CommonUtils.HavePersonalPerk(_summoner.dataID, 516013, out perkLevel))
		{
			_durationTime += CommonUtils.GetScriptValue(_summoner, 16013011);
		}
		_checkTraceInterval = Config_MainControl.interval_CheckTrace_Summoned;
		ILRuntimeAPI.CreateSkill(16010010, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
	}

	private void OnSkillFinish(bool success)
	{
		if (success)
		{
			if (_durationTime > 0)
			{
				ILRuntimeAPI.CreateSkill(16010010, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
			}
			else
			{
				_actor.DestroySelf();
			}
		}
	}

	private IEnumerator PerkLogic_P2()
	{
		while (true)
		{
			if (_summoner.status == ActorStatus.Default)
			{
				if (_areaEffectId_P2 <= 0)
				{
					if (_playFX_P2 == null)
					{
						_playFX_P2 = new PlayFX();
					}
					_playFX_P2.Play(_actor, null, "fx_16001_loop_Skill_Main_Perk02", default, _actor.tsTransform.Position, default, null, 1f, 1f, actorScale: true);
					_areaEffectId_P2 = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16001_Main_P02", _actor.tsTransform.Position);
				}
			}
			else
			{
				if (_areaEffectId_P2 > 0)
				{
					ILRuntimeAPI.StopAreaEffect(_areaEffectId_P2);
					_playFX_P2?.Stop();
					_playFX_P2?.Clear();
				}
				_areaEffectId_P2 = 0L;
			}
			yield return null;
		}
	}

	public void OnUpdate()
	{
		if (_checkTraceInterval > 0)
		{
			_checkTraceInterval -= _actor.LogicDeltaTime;
		}
		else
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
			LogicEntity attackTarget = playerAdventureActor.attackTarget;
			attackTarget = ((attackTarget == null) ? _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false) : attackTarget);
			attackTarget = ((attackTarget == null) ? playerAdventureActor : attackTarget);
			_traceTarget.BeginTrace(_actor, attackTarget, attackTarget.GetRadius() + _actor.GetRadius() + 1f, -1, -1, null, null);
			_checkTraceInterval = Config_MainControl.interval_CheckTrace_Summoned;
		}
		if (_durationTime > 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
	}

	public void OnStop()
	{
		_durationTime = 0;
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
		_checkTraceInterval = 0;
		if (_perkLogic_P2 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P2);
		}
		_perkLogic_P2 = null;
		if (_areaEffectId_P2 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P2);
		}
		_areaEffectId_P2 = 0L;
		_playFX_P2?.Stop();
		_playFX_P2?.Clear();
	}
}
