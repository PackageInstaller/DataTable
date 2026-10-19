using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("播放Die特效", "Action", new string[] { "fire", "die", "effect", "fx", "particle" })]
public class ActionFireDieEffect : ConfigAction
{
	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		ConfigCharacter config = memory.target.entity.GetConfig();
		EnemyRace enemyRace = config.enemyRace;
		MonsterWeigtType monsterWeigtType = config.monsterWeigtType;
		if (!GameLoader.meta.configGroundLightDiePara.enemyDieEffectDic.TryGetValue(enemyRace, out var value))
		{
			return;
		}
		YooAssetReference effectReferenceAssetID;
		YooAssetReference effectReferenceAssetID2;
		YooAssetReference effectReferenceAssetID3;
		YooAssetReference effectReferenceAssetID4;
		if (memory.target.entity.IsMonster() && memory.target.entity.GetEntityType() == EntityType.Elite)
		{
			effectReferenceAssetID = value[MonsterWeigtType.Big].effectReferenceAssetID;
			effectReferenceAssetID2 = value[MonsterWeigtType.Big].effectReferenceAssetID1;
			effectReferenceAssetID3 = value[MonsterWeigtType.Big].effectReferenceAssetID2;
			effectReferenceAssetID4 = value[MonsterWeigtType.Big].effectReferenceAssetID3;
		}
		else
		{
			effectReferenceAssetID = value[monsterWeigtType].effectReferenceAssetID;
			effectReferenceAssetID2 = value[monsterWeigtType].effectReferenceAssetID1;
			effectReferenceAssetID3 = value[monsterWeigtType].effectReferenceAssetID2;
			effectReferenceAssetID4 = value[monsterWeigtType].effectReferenceAssetID3;
		}
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = memory.target,
			patternAssetID = effectReferenceAssetID,
			removeWhenMotionExit = true,
			timescale = TimeScale.NoScale,
			type = EffectDataType.Point,
			point1 = new EffectPoint
			{
				type = EffectPoint.EffectPointType.Character,
				offset = Vector3.zero
			},
			removeWhenStop = true,
			changeScale = false,
			isAttach = false
		};
		if (effectReferenceAssetID != null && effectReferenceAssetID.RuntimeKeyIsValid())
		{
			effectParams.point1 = new EffectPoint
			{
				type = EffectPoint.EffectPointType.AttachPoint,
				attachPoint = BattleConsts.AIM_ATTACH_POINT
			};
			GameManager.effectSystem.FireEffect(effectParams);
		}
		if (effectReferenceAssetID2 != null && effectReferenceAssetID2.RuntimeKeyIsValid())
		{
			effectParams.point1 = new EffectPoint
			{
				type = EffectPoint.EffectPointType.AttachPoint,
				attachPoint = BattleConsts.AIM_ATTACH_POINT
			};
			effectParams.patternAssetID = effectReferenceAssetID2;
			GameManager.effectSystem.FireEffect(effectParams);
		}
		if (effectReferenceAssetID3 != null && effectReferenceAssetID3.RuntimeKeyIsValid())
		{
			effectParams.point1 = new EffectPoint
			{
				type = EffectPoint.EffectPointType.TargetGroundPos
			};
			effectParams.patternAssetID = effectReferenceAssetID3;
			GameManager.effectSystem.FireEffect(effectParams);
		}
		if (effectReferenceAssetID4 != null && effectReferenceAssetID4.RuntimeKeyIsValid())
		{
			Quaternion rotate = memory.owner.GetCompPhysics().faceDirRot * Quaternion.Euler(0f, -90f, 0f);
			Vector3 physicsPosition = memory.target.entity.GetCompTransform().physicsPosition;
			AttachPoint attachPointAll = memory.target.entity.GetMono().GetAttachPointAll(BattleConsts.AIM_ATTACH_POINT);
			if (attachPointAll.forward != null)
			{
				attachPointAll.forward.position = attachPointAll.GetPos();
			}
			physicsPosition = ((attachPointAll.forward != null) ? attachPointAll.forward.position : attachPointAll.transform.position);
			GameManager.effectSystem.FireEffect(effectReferenceAssetID4, physicsPosition, rotate);
		}
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
	}
}
