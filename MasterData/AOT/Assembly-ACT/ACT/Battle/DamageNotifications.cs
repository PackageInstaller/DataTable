using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public static class DamageNotifications
{
	public static CmdDamageNumber BuildDamageNumberCmd(AttackData attackData, Ability ability)
	{
		CompTransform compTransform = attackData.attackee.GetCompTransform();
		CompTransform compTransform2 = attackData.attacker.GetCompTransform();
		DamageFeature damageFeature = PickDamageFeature(attackData);
		Vector3 entityPos = compTransform.physicsPosition;
		Vector3 pos = attackData.attackee.GetNetColliderPosition();
		if ((damageFeature == DamageFeature.Damage || damageFeature == DamageFeature.Manner) && attackData.attackee.IsMonster() && attackData.attackee.GetConfig().damageNumberUseHitBodyPartPosition && TryGetHitBodyPartPosition(attackData.attackee, attackData.bodyPart, out var position))
		{
			entityPos = position;
			pos = position;
		}
		CmdDamageNumber result = new CmdDamageNumber
		{
			damageFeature = damageFeature,
			serverTime = 0.0,
			pos = pos,
			damage = Mathf.RoundToInt(attackData.damage),
			critical = attackData.critical,
			element = attackData.element,
			isWeakElement = (attackData.isWeakElement || attackData.partWeakPhaseAdd > 0f),
			entityType = attackData.attackee.GetEntityType(),
			mannerType = attackData.mannerType,
			dotIconId = ((ability != null && ability.config != null && ability.config.showIcon) ? ability.config.damageDotIconId : (-1)),
			useMonsterType = attackData.attackee.IsMonster(),
			entitySize = compTransform.size,
			entityPos = entityPos
		};
		if (attackData.attacker != null)
		{
			result.faceLeft = compTransform.physicsPosition.x < compTransform2.physicsPosition.x;
		}
		if (result.useMonsterType)
		{
			result.monsterWeigtType = attackData.attackee.GetConfig().monsterWeigtType;
		}
		return result;
	}

	private static bool TryGetHitBodyPartPosition(Entity attackee, int bodyPart, out Vector3 position)
	{
		position = default;
		if (bodyPart <= 0)
		{
			return false;
		}
		MonoEntity mono = attackee.GetMono();
		int num = bodyPart - 1;
		if (mono == null || mono.bodyParts == null || num >= mono.bodyParts.Length)
		{
			return false;
		}
		MonoBodyPart monoBodyPart = mono.bodyParts[num];
		if (monoBodyPart == null)
		{
			return false;
		}
		position = monoBodyPart.transform.position;
		return true;
	}

	public static void FireDamageNumberSpawn(in CmdDamageNumber cmd)
	{
		DamageNumberSpawnEvt evt = Singleton<EventManager>.instance.GetEvt<DamageNumberSpawnEvt>();
		evt.cmdDamageNumber = cmd;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.DamageNumberSpawn, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public static void NotifyCharacterDamageHit(AttackData attackData)
	{
		CompCharacter compCharacter = attackData.attacker.GetCompCharacter();
		if (compCharacter != null)
		{
			CmdCharacterDamageHit hit = new CmdCharacterDamageHit
			{
				characterDamageType = RuntimeConfigs.data.entityCharacterDatas[compCharacter.characterSource.Id()].characterDamageType
			};
			attackData.attackee.CharacterDamageHit(hit);
		}
	}

	private static DamageFeature PickDamageFeature(AttackData attackData)
	{
		if (attackData.mannerType != MannerType.None)
		{
			return DamageFeature.Manner;
		}
		if (attackData.adjust2AttackType.HasFlag(Adjust2AttackTypeTag.DotAttack))
		{
			return DamageFeature.Dot;
		}
		return DamageFeature.Damage;
	}
}
