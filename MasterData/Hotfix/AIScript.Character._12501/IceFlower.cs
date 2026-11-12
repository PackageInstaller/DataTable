using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class IceFlower
{
	private AdventureActor _actor;

	private CommomAreaHitConfig _areaHitConfig;

	private Action<IceFlower> _finishCallBack;

	private PlayFX _playFX;

	private CoroutineNode _explosionCor;

	private string _fxKey;

	private int _hitDamageId_Blossom;

	private int _hitDamageId_Explosion;

	private FP _hitRadius_Blossom;

	private FP _hitRadius_Explosion;

	public void Steup(AdventureActor actor, Action<IceFlower> finishCallback)
	{
		_actor = actor;
		_finishCallBack = finishCallback;
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig
			{
				damageImmuneDuration = -1,
				hitFlags = (HitBox.FeatureFlag.Stiff | HitBox.FeatureFlag.AddBuffForTarget),
				hitFeatureData = Config_Support.hitBoxFeatureData_IceFlower,
				hittedEffectAlias = "fx_12501_hit_Ice"
			};
		}
	}

	public void Blossom(TSVector2 position, int blossomHitDamageId, int explosionHitDamageId, int delayExplosionFrame = 0, int blossomUniqueAttackId = 0, int explosionUniqueAttackId = 0)
	{
		_fxKey = "fx_12501_loop_B1_Skill_IceFlower";
		_hitDamageId_Blossom = blossomHitDamageId;
		_hitDamageId_Explosion = explosionHitDamageId;
		_hitRadius_Blossom = Config_Support.hitRaidus_IceFlower_Blossom;
		_hitRadius_Explosion = Config_Support.hitRaidus_IceFlower_Explosion;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512521, out var _))
		{
			_fxKey = "fx_12501_loop_B1_Skill_IceFlower_Rage";
			_hitRadius_Blossom = Config_Support.hitRaidus_IceFlower_Blossom_P21;
			_hitRadius_Explosion = Config_Support.hitRaidus_IceFlower_Explosion_P21;
		}
		_areaHitConfig.position = position;
		blossomUniqueAttackId = ((blossomUniqueAttackId > 0) ? blossomUniqueAttackId : SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId());
		explosionUniqueAttackId = ((explosionUniqueAttackId > 0) ? explosionUniqueAttackId : SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId());
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		else
		{
			_playFX.Clear();
		}
		_playFX.Play(_actor, null, _fxKey, default, position, default);
		CircleAreaHit(_hitDamageId_Blossom, blossomUniqueAttackId, _hitRadius_Blossom);
		if (_explosionCor != null)
		{
			_actor.StopLogicCoroutine(_explosionCor);
		}
		_explosionCor = _actor.StartLogicCoroutine(ExplosionLogic(delayExplosionFrame, explosionUniqueAttackId));
	}

	private IEnumerator ExplosionLogic(int delayExplosionFrame, int uniqueAttackId)
	{
		if (delayExplosionFrame > 0)
		{
			yield return delayExplosionFrame;
		}
		int leftFrame = 30;
		int delayHitFrame = 4;
		_playFX?.Stop();
		bool hitted = false;
		while (leftFrame > 0)
		{
			if (delayHitFrame > 0)
			{
				delayHitFrame--;
			}
			else if (!hitted)
			{
				CircleAreaHit(_hitDamageId_Explosion, uniqueAttackId, _hitRadius_Explosion);
				hitted = true;
			}
			leftFrame--;
			yield return null;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512527, out var perkLevel))
		{
			string fxAlias = "AreaEffect_125_Main_P27_IceFlower";
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512521, out perkLevel))
			{
				fxAlias = "AreaEffect_125_Main_P27P21_IceFlower_Large";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _areaHitConfig.position);
		}
		_finishCallBack?.Invoke(this);
	}

	public void Clear()
	{
		_playFX?.Stop(dontPlaySubFX: true);
		_playFX?.Clear();
		if (_explosionCor != null)
		{
			_actor.StopLogicCoroutine(_explosionCor);
		}
		_explosionCor = null;
		_finishCallBack = null;
		_actor = null;
	}

	private void CircleAreaHit(int hitDamageId, int uniqueAttackId, FP radius)
	{
		if (!(_actor == null) && _areaHitConfig != null)
		{
			_areaHitConfig.hitDamageId = hitDamageId;
			_areaHitConfig.uniqueAttackId = ((uniqueAttackId > 0) ? uniqueAttackId : (-1));
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, radius, 0);
		}
	}
}
