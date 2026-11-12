using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ActionScript_Summoned_Support : ActionScript_Summoned
{
	private bool _canUseSkill;

	private FP _useSkillInterval;

	protected long _areaEffectId_P28;

	protected CoroutineNode _perkLogic_P28;

	private CommomAreaHitConfig _hitConfig_P28;

	private CoroutineNode _perkLogic_P29;

	public override void OnStart()
	{
		base.OnStart();
		EnableTrace();
		if (HavePersonalPerk(515824, out var perkLevel))
		{
			_canUseSkill = true;
		}
		if (HavePersonalPerk(515829, out perkLevel))
		{
			_perkLogic_P29 = _actor.StartLogicCoroutine(PerkLogic_P29());
		}
		_useSkillInterval = 0;
	}

	protected IEnumerator PerkLogic_P28(int hitDamageId, FP hitRadius, FP hitInnerRadius, FP hitInterval)
	{
		FP interval = hitInterval;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				if (_hitConfig_P28 == null)
				{
					_hitConfig_P28 = new CommomAreaHitConfig
					{
						hittedEffectAlias = "fx_15801_hit_Lash"
					};
				}
				_hitConfig_P28.hitDamageId = hitDamageId;
				_hitConfig_P28.position = _actor.tsTransform.Position;
				ILRuntimeAPI.CircleAreaHit(_actor, _hitConfig_P28, hitRadius, hitInnerRadius);
				interval += hitInterval;
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P29()
	{
		FP interval = 0;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				_actor.buffComponent.AddBuff(15829011, _actor);
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(15829011);
				if (Config_Support.modelScaleDic_P29.TryGetValue(buffNumByID, out var value))
				{
					FP fP = 1 + value * 0.01f;
					FP originModelScale = _actor.actorScaleInfo.originModelScale;
					_actor.actorScaleInfo.modelScale = originModelScale * fP;
				}
				interval += Config_Support.interval_AddBuff_P29;
			}
			yield return null;
		}
	}

	protected virtual FP GetUseSkillInterval()
	{
		return 0;
	}

	public override void OnUpdate()
	{
		if (_canUseSkill)
		{
			if (_useSkillInterval > 0)
			{
				_useSkillInterval -= _actor.LogicDeltaTime;
			}
			else if (CastSkill())
			{
				_useSkillInterval += GetUseSkillInterval();
			}
		}
		base.OnUpdate();
	}

	private bool CastSkill()
	{
		if (_actor.attackTarget == null)
		{
			return false;
		}
		if (_actor.movementState != ActorState.StandBy)
		{
			return false;
		}
		if (_actor.DistanceWithRadius(_actor.attackTarget) > GetAttackRange())
		{
			return false;
		}
		if (ILRuntimeAPI.CreateSkill(GetSkillId(), _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false))
		{
			return true;
		}
		return false;
	}

	protected virtual int GetSkillId()
	{
		return 0;
	}

	public override void OnStop()
	{
		base.OnStop();
		DisableTrace();
		_canUseSkill = false;
		if (_areaEffectId_P28 > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectId_P28);
		}
		_areaEffectId_P28 = 0L;
		if (_perkLogic_P28 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P28);
		}
		_perkLogic_P28 = null;
		if (_perkLogic_P29 != null)
		{
			_actor.StopLogicCoroutine(_perkLogic_P29);
		}
		_perkLogic_P29 = null;
	}
}
