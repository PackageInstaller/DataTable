using System;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class BulletDisplayComponent : BaseComponent
{
	private BulletData _bulletData;

	public const string CREATE = "Create";

	public const string HITCAMERA = "HitCamera";

	public const string HIT = "Hit";

	public const string ENDTIME = "EndTime";

	public const string ZEROTRIGGERCOUNT = "ZeroTriggerCount";

	public override void OnAwake(object data = null)
	{
		_bulletData = GetData<BulletData>("bulletData");
		OnDisplay("Create");
	}

	public void OnDisplay(string state, BaseEntity entity = null, HitVolume hitVolume = null)
	{
		switch (state)
		{
		case "Create":
			CreateDisplay(entity, hitVolume);
			break;
		case "HitCamera":
			HitCameraDisplay(entity, hitVolume);
			break;
		case "Hit":
			HitDisplay(entity, hitVolume);
			break;
		case "EndTime":
			EndLifeDisplay(entity, hitVolume);
			break;
		case "ZeroTriggerCount":
			ZeroTriggerCountDisplay(entity, hitVolume);
			break;
		}
	}

	private void CreateDisplay(BaseEntity entity = null, HitVolume hitVolume = null)
	{
		if (mBaseEntity.IsCanExecuteDisPlay)
		{
			CreateCameraShake();
			MakeImpulse(_bulletData.cfg, 1);
			SoundAttaching();
		}
	}

	private void CreateCameraShake()
	{
		if ((mBaseEntity.GetSystem<VirtualCameraSystem>().GetSummonedCanShake(mBaseEntity.Parent) || mBaseEntity.Parent.Id == mBaseEntity.GetWorld().ActorId || mBaseEntity.Parent.GetEntityType() == EntityType.MONSTER || _bulletData.cfg.IsGlobal) && _bulletData.cfg.ShakeCameraDuration != null && _bulletData.cfg.ShakeCameraStrength != null && _bulletData.cfg.ShakeCameraFrequency != null && _bulletData.cfg.ShakeNoiseName != null && _bulletData.cfg.ShakeCameraDuration.Count >= 2 && _bulletData.cfg.ShakeCameraStrength.Count >= 2 && _bulletData.cfg.ShakeNoiseName.Count >= 2 && _bulletData.cfg.ShakeCameraFrequency.Count >= 2)
		{
			SetCameraShakeParam(1);
		}
	}

	private void MakeImpulse(DRBullet bulletConfig, int makeImpluseTime)
	{
		if (bulletConfig != null && makeImpluseTime == bulletConfig.PulseStartTime && bulletConfig.PulseParameter.Count >= 7 && bulletConfig.PulseCurve.Count >= 5)
		{
			VirtualCameraSystem system = mBaseEntity.GetSystem<VirtualCameraSystem>();
			MakeImpulseSourceData makeImpulseSourceData = ReferencePool.Acquire<MakeImpulseSourceData>();
			makeImpulseSourceData.ImpulseInterval = 0f;
			makeImpulseSourceData.ImpulseNums = 1f;
			makeImpulseSourceData._impulseForce = bulletConfig.PulseParameter[0];
			CurveData impulseRangeCurveData = system.GetImpulseRangeCurveData(bulletConfig.PulseCurve[0]);
			if (impulseRangeCurveData != null)
			{
				makeImpulseSourceData.ImpulseForceCurve = impulseRangeCurveData.CurveValue;
			}
			CurveData intensityCurveData = system.GetIntensityCurveData(bulletConfig.PulseCurve[1]);
			if (intensityCurveData != null)
			{
				makeImpulseSourceData.StrengCurve = intensityCurveData.CurveValue;
			}
			CurveData impulseRangeCurveData2 = system.GetImpulseRangeCurveData(bulletConfig.PulseCurve[2]);
			if (impulseRangeCurveData2 != null)
			{
				makeImpulseSourceData.DistanceStrengCurve = impulseRangeCurveData2.CurveValue;
			}
			CurveData frequencyCurveData = system.GetFrequencyCurveData(bulletConfig.PulseCurve[3]);
			if (frequencyCurveData != null)
			{
				makeImpulseSourceData.FrequencyCurve = frequencyCurveData.CurveValue;
			}
			makeImpulseSourceData.ImpulseDir = Vector3.one;
			makeImpulseSourceData.ImpulseSpeed = bulletConfig.PulseParameter[2];
			makeImpulseSourceData.ImpulseDistance = bulletConfig.PulseParameter[1];
			makeImpulseSourceData.ImpulsePosition = mBaseEntity.transform.position;
			makeImpulseSourceData.ImpulsePosEntityId = 0;
			makeImpulseSourceData.ImpulsePosPoint = "";
			makeImpulseSourceData.ImpulsePositionOffset = Vector3.zero;
			makeImpulseSourceData.BlendTime = 0.2f;
			makeImpulseSourceData.IntensityInit = bulletConfig.PulseParameter[4];
			makeImpulseSourceData.frequency = bulletConfig.PulseParameter[5];
			makeImpulseSourceData.duration = bulletConfig.PulseParameter[6];
			makeImpulseSourceData.NoiseName = bulletConfig.PulseCurve[4];
			makeImpulseSourceData.ImpulsePriorityInit = bulletConfig.PulseParameter[3];
			makeImpulseSourceData.ImpulsePriorityCurve = null;
			makeImpulseSourceData.ImpulsePriorityDisCurve = null;
			makeImpulseSourceData.UseRandomNoise = false;
			makeImpulseSourceData.ImpulseUniqueIndex = system.ImpulseUniqueIndex;
			system.MakeImpulse(makeImpulseSourceData);
		}
	}

	private void SoundAttaching()
	{
		int selfSfx = _bulletData.cfg.SelfSfx;
		if (selfSfx != 0)
		{
			DREffect dREffect = mBaseEntity.Parent?.GetEffectSkinIdByParentSkinConfig(selfSfx);
			if (dREffect != null)
			{
				mBaseEntity.GetComponent<SoundComponent>()?.RegistSound(dREffect, delayStartBaseFrozen: false, mBaseEntity, mBaseEntity);
				mBaseEntity.GetComponent<SoundComponent>()?.TryPlaySound();
			}
		}
	}

	private void HitCameraDisplay(BaseEntity entity = null, HitVolume hitVolume = null)
	{
		if (mBaseEntity.IsCanExecuteDisPlay)
		{
			HitCameraShake();
			MakeImpulse(_bulletData.cfg, 2);
		}
	}

	private void HitDisplay(BaseEntity entity = null, HitVolume hitVolume = null)
	{
		if (mBaseEntity.IsCanExecuteDisPlay)
		{
			PlayHitEffect(entity, hitVolume);
		}
	}

	[Obsolete("走伤害流程")]
	private void PlayHitEffect(BaseEntity entity, HitVolume hitVolume = null)
	{
	}

	private void CalculateEffectPosition(MonsterEntity entity, Vector3 hitVolumeCenter, ref Vector3 exactPosition, ref Vector3 exactEuler)
	{
		bool isMelee = _bulletData.cfg.IsMelee;
		float num = (isMelee ? entity.GetData<DRMonster>("MonsterConfig").NearPlayEffectRadius : entity.GetData<DRMonster>("MonsterConfig").FarPlayEffectRadius);
		Vector3 zero = Vector3.zero;
		Vector3 selfPos = new Vector3(entity.transform.position.x, 0f, entity.transform.position.z);
		Vector3 targetPos = new Vector3(mBaseEntity.transform.position.x, 0f, mBaseEntity.transform.position.z);
		float y = entity.transform.eulerAngles.y + TSUtil.TargetFwdAngleToSelf(selfPos, entity.transform.eulerAngles.y, targetPos);
		exactEuler = new Vector3(0f, y, 0f);
		if (num == 0f)
		{
			exactPosition = hitVolumeCenter;
		}
		else if (isMelee)
		{
			if (mBaseEntity.Parent != null && mBaseEntity.Parent.IsSurvival)
			{
				zero = (new Vector3(mBaseEntity.Parent.transform.position.x, entity.transform.position.y, mBaseEntity.Parent.transform.position.z) - entity.transform.position).normalized * num;
				exactPosition += zero;
			}
		}
		else
		{
			zero = (new Vector3(mBaseEntity.transform.position.x, entity.transform.position.y, mBaseEntity.transform.position.z) - entity.transform.position).normalized * num;
			exactPosition += zero;
		}
	}

	private void HitCameraShake()
	{
		if ((mBaseEntity.GetSystem<VirtualCameraSystem>().GetSummonedCanShake(mBaseEntity.Parent) || mBaseEntity.Parent.Id == mBaseEntity.GetWorld().ActorId || mBaseEntity.GetEntityType() == EntityType.MONSTER || _bulletData.cfg.IsGlobal) && _bulletData.cfg.ShakeCameraDuration != null && _bulletData.cfg.ShakeCameraStrength != null && _bulletData.cfg.ShakeCameraFrequency != null && _bulletData.cfg.ShakeNoiseName != null && _bulletData.cfg.ShakeCameraDuration.Count >= 1 && _bulletData.cfg.ShakeCameraStrength.Count >= 1 && _bulletData.cfg.ShakeNoiseName.Count >= 1 && _bulletData.cfg.ShakeCameraFrequency.Count >= 1)
		{
			SetCameraShakeParam(0);
		}
	}

	private void SetCameraShakeParam(int paramIndex)
	{
		VirtualCameraSystem system = mBaseEntity.GetSystem<VirtualCameraSystem>();
		DRBullet cfg = _bulletData.cfg;
		if (system != null && cfg != null)
		{
			AnimationCurve intensityCurveData = null;
			if (cfg.AmplitudeAttenuationCurve.Count > paramIndex)
			{
				intensityCurveData = system.GetIntensityCurveData(cfg.AmplitudeAttenuationCurve[paramIndex])?.CurveValue;
			}
			AnimationCurve frequencyCurveData = null;
			if (cfg.FrequencyAttenuationCurve.Count > paramIndex)
			{
				frequencyCurveData = system.GetFrequencyCurveData(cfg.FrequencyAttenuationCurve[paramIndex])?.CurveValue;
			}
			float intensityBlendTime = 0f;
			if (cfg.BlendTime.Count > paramIndex)
			{
				intensityBlendTime = cfg.BlendTime[paramIndex];
			}
			bool useRandomNoise = false;
			if (cfg.EnableRandomStart.Count > paramIndex)
			{
				useRandomNoise = cfg.EnableRandomStart[paramIndex];
			}
			int cameraShakeIndex = system.GetCameraShakeIndex();
			system.SetCameraShakeParam(cfg.ShakeCameraWeight, cfg.ShakeCameraDuration[paramIndex], cfg.ShakeCameraStrength[paramIndex], cfg.ShakeCameraFrequency[paramIndex], cfg.ShakeNoiseName[paramIndex], intensityCurveData, frequencyCurveData, intensityBlendTime, useRandomNoise, cameraShakeIndex);
		}
	}

	private void ZeroTriggerCountDisplay(BaseEntity entity = null, HitVolume hitVolume = null)
	{
		if (mBaseEntity.IsCanExecuteDisPlay && _bulletData.cfg.HitDestroySfx != 0)
		{
			mBaseEntity.GetSystem<EffectSystem>()?.PlayEffect(mBaseEntity.Parent, mBaseEntity.Parent, _bulletData.cfg.HitDestroySfx, base.transform.position, base.transform.eulerAngles);
		}
	}

	private void EndLifeDisplay(BaseEntity entity = null, HitVolume hitVolume = null)
	{
		if (mBaseEntity.IsCanExecuteDisPlay && _bulletData.cfg.TimeDestroySfx != 0)
		{
			mBaseEntity.GetSystem<EffectSystem>()?.PlayEffect(mBaseEntity.Parent, mBaseEntity.Parent, _bulletData.cfg.TimeDestroySfx, base.transform.position, base.transform.eulerAngles);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_bulletData = null;
	}
}
