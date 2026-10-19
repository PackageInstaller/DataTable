using ACT.Battle.Configs;
using ACT.MultiPlayer;
using ACT.Sound;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public static class PostureHitEffectPlayer
{
	private const float OffsetBaseScale = 0.25f;

	private const float OffsetBackZ = -1.2f;

	private const float HighLowYRatio = 2925f / 4095f;

	private const float HighLowRotX = 45f;

	public static void Play(Entity attackee, in CmdHit hit)
	{
		if (!attackee.IsBattleBehaveNotCharacter() || hit.bodyIndex <= 0 || !hit.lastHavePosture)
		{
			return;
		}
		CompAbility compAbility = attackee.GetCompAbility();
		bool flag = !compAbility.IsWeak;
		bool flag2 = !hit.lastIsWeak && compAbility.IsWeak;
		if (!flag && !flag2)
		{
			return;
		}
		EffectPoint point = BuildAttachPoint(attackee, in hit);
		SystemEffect.EffectParams effectParams = BuildEffectParams(attackee, in hit, point);
		AudioEventReference audioEventReference = default;
		CompBehave compBehave = attackee.GetCompBehave();
		if (flag)
		{
			effectParams.patternAssetID = GameLoader.meta.breakPostureActions.PostureHitEffectAndVoiceDict[compBehave.Config.enemyRace][compBehave.Config.monsterWeigtType].monsterPostureHitEffectAssetID;
			audioEventReference = PickSound(attackee, postureBreak: false);
		}
		else
		{
			effectParams.patternAssetID = GameLoader.meta.breakPostureActions.PostureHitEffectAndVoiceDict[compBehave.Config.enemyRace][compBehave.Config.monsterWeigtType].monsterPostureBreakEffectAssetID;
			audioEventReference = PickSound(attackee, postureBreak: true);
			if (compBehave.EntityType == EntityType.Boss)
			{
				PlayBossExtraEffect(attackee, in hit);
			}
		}
		if (effectParams.patternAssetID.IsValid())
		{
			GameManager.effectSystem.FireEffect(effectParams);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound(audioEventReference, new AudioPlayOptions
		{
			attachTarget = attackee.GetRootTransform()
		});
	}

	private static EffectPoint BuildAttachPoint(Entity attackee, in CmdHit hit)
	{
		Vector3 size = attackee.GetMono().bodyParts[hit.bodyIndex - 1].myCollider.bounds.size;
		Vector3 physicsPosition = attackee.GetCompTransform().physicsPosition;
		float num = hit.touchPos.x - physicsPosition.x;
		float num2 = hit.touchPos.y - physicsPosition.y;
		float num3 = 0.25f * attackee.GetConfig().enemyPostureEffectScale;
		float num4 = (hit.attackeeAtLeft ? 1f : (-1f));
		EffectPoint result = new EffectPoint
		{
			continueouslyFollow = true,
			rotateFollowLogicDir = true,
			useOwnerRot = true,
			oriRotY = (hit.attackeeAtLeft ? (-30) : 30),
			aimTarget = false,
			useInitRotation = true,
			type = EffectPoint.EffectPointType.Character,
			offset = new Vector3(num + num4 * size.x * 0.5f + num4 * num3, num2, -1.2f)
		};
		float num5 = attackee.GetCompTransform().size.y * (2925f / 4095f);
		if (num2 > num5)
		{
			result.oriRotX = 45f;
		}
		else if (num2 < 0f - num5)
		{
			result.oriRotX = -45f;
		}
		return result;
	}

	private static SystemEffect.EffectParams BuildEffectParams(Entity attackee, in CmdHit hit, EffectPoint point1)
	{
		return new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(attackee),
			removeWhenMotionExit = false,
			timescale = TimeScale.NoScale,
			type = EffectDataType.Point,
			point1 = point1,
			point2 = default,
			removeWhenStop = false,
			changeScale = false,
			effectRangeEnum = EffectRangeEnum.none,
			transformScaleMulBase = Vector3.zero,
			isChangeWithEntity = false,
			initRotation = default,
			isAttach = false,
			xMirror = !hit.attackeeAtLeft
		};
	}

	private static AudioEventReference PickSound(Entity attackee, bool postureBreak)
	{
		ConfigBreakPostureActions breakPostureActions = GameLoader.meta.breakPostureActions;
		CompBehave compBehave = attackee.GetCompBehave();
		if (compBehave.EntityType == EntityType.Boss)
		{
			EnemyPostureHitEffectAndVoice enemyPostureHitEffectAndVoice = breakPostureActions.BossPostureHitEffectAndVoiceDict[compBehave.Config.enemyRace];
			if (!postureBreak)
			{
				return enemyPostureHitEffectAndVoice.audioPostureHitVoice;
			}
			return enemyPostureHitEffectAndVoice.audioPostureBreakVoice;
		}
		EnemyPostureHitEffectAndVoice enemyPostureHitEffectAndVoice2 = breakPostureActions.PostureHitEffectAndVoiceDict[compBehave.Config.enemyRace][compBehave.Config.monsterWeigtType];
		if (!postureBreak)
		{
			return enemyPostureHitEffectAndVoice2.audioPostureHitVoice;
		}
		return enemyPostureHitEffectAndVoice2.audioPostureBreakVoice;
	}

	private static void PlayBossExtraEffect(Entity attackee, in CmdHit hit)
	{
		YooAssetReference postureBreakBossExtraEffect = GameLoader.meta.breakPostureActions.PostureBreakBossExtraEffect;
		if (postureBreakBossExtraEffect.IsValid())
		{
			EffectPoint point = new EffectPoint
			{
				continueouslyFollow = true,
				rotateFollowLogicDir = true,
				aimTarget = false,
				useInitRotation = true,
				useOwnerRot = true,
				type = EffectPoint.EffectPointType.Character,
				attachPoint = "waist",
				offset = new Vector3(1f, 0f, 0f)
			};
			SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
			{
				target = FindTargetResult.EntityOnly(attackee),
				removeWhenMotionExit = false,
				timescale = TimeScale.NoScale,
				type = EffectDataType.Point,
				point1 = point,
				point2 = default,
				removeWhenStop = false,
				changeScale = false,
				effectRangeEnum = EffectRangeEnum.none,
				transformScaleMulBase = Vector3.zero,
				isChangeWithEntity = false,
				initRotation = default,
				isAttach = false,
				xMirror = !hit.attackeeAtLeft,
				patternAssetID = postureBreakBossExtraEffect
			};
			GameManager.effectSystem.FireEffect(effectParams);
		}
	}
}
