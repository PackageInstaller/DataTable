using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class EntityUIInfo
{
	public int Id { get; }

	public EntityType entityType { get; }

	public EntityId entityId { get; }

	public int Level { get; private set; }

	public int BasicMaxHp { get; private set; }

	public int CurMaxHp { get; private set; }

	public int OldHp { get; private set; }

	public int CurHp { get; private set; }

	public float CurHpPercentage { get; private set; }

	public bool InPosture { get; private set; }

	public int MaxPosture { get; private set; }

	public int CurPosture { get; private set; }

	public int OldPosture { get; private set; }

	public float CurPosturePercentage { get; private set; }

	public float OldPosturePercentage { get; private set; }

	public PostureType PostureType { get; private set; }

	public float[] PosturePartsVal { get; private set; }

	public int CurPartsIndex { get; set; }

	public int OldPartsIndex { get; set; }

	public bool InWeak { get; private set; }

	public float CurWeakPercentage { get; private set; }

	public bool InBurst { get; private set; }

	public int MaxBurst { get; private set; }

	public int CurBurst { get; private set; }

	public float CurBurstPercentage { get; private set; }

	public int DamageType { get; private set; }

	public EntityUIInfo(AddBossHatredEvt addBossHatredEvt, ConfigCharacter configCharacter)
	{
		Id = addBossHatredEvt.id;
		entityId = addBossHatredEvt.entityId;
		entityType = EntityType.Boss;
		Level = addBossHatredEvt.level;
		BasicMaxHp = addBossHatredEvt.basicMaxHp;
		CurMaxHp = addBossHatredEvt.curMaxHp;
		CurHp = addBossHatredEvt.curHp;
		CurHpPercentage = addBossHatredEvt.curHpPercentage;
		InPosture = addBossHatredEvt.inPosture;
		MaxPosture = addBossHatredEvt.maxPosture;
		CurPosture = addBossHatredEvt.curPosture;
		OldPosture = addBossHatredEvt.curPosture;
		CurPosturePercentage = addBossHatredEvt.curPosturePercentage;
		OldPosturePercentage = addBossHatredEvt.curPosturePercentage;
		InWeak = addBossHatredEvt.inWeak;
		CurWeakPercentage = addBossHatredEvt.curWeakPercentage;
		InBurst = addBossHatredEvt.inBurst;
		MaxBurst = addBossHatredEvt.maxBurst;
		CurBurst = addBossHatredEvt.curBurst;
		CurBurstPercentage = addBossHatredEvt.curBurstPercentage;
		DamageType = addBossHatredEvt.damageType;
		PostureType = configCharacter.postureType;
		PosturePartsVal = configCharacter.posturePercent;
		if (PostureType == PostureType.Multi)
		{
			CurPartsIndex = GetPosturePartIndex(CurPosturePercentage);
		}
		if (PostureType == PostureType.Multi)
		{
			OldPartsIndex = GetPosturePartIndex(OldPosturePercentage);
		}
	}

	public EntityUIInfo(Entity entity)
	{
		if (entity.TryGetCompAbility(out CompAbility component))
		{
			Id = entity.GetTableId();
			entityId = entity.Id;
			entityType = entity.GetEntityType();
			Level = (entity.TryGetCompMonster(out CompMonster component2) ? component2.level : 0);
			BasicMaxHp = component.maxHP;
			CurMaxHp = component.maxHP;
			CurHp = component.hp;
			CurHpPercentage = component.HpPercent;
			InPosture = component.IsHavePosture;
			MaxPosture = component.maxPosture;
			CurPosture = component.posture;
			OldPosture = component.posture;
			CurPosturePercentage = (float)CurPosture / (float)MaxPosture;
			OldPosturePercentage = (float)OldPosture / (float)MaxPosture;
			InWeak = component.IsWeak;
			CurWeakPercentage = component.revivePostureProgress;
			InBurst = false;
			MaxBurst = 0;
			CurBurst = 0;
			CurBurstPercentage = 0f;
			DamageType = 0;
			ConfigCharacter config = entity.GetConfig();
			PostureType = config.postureType;
			PosturePartsVal = config.posturePercent;
			if (PostureType == PostureType.Multi)
			{
				CurPartsIndex = GetPosturePartIndex(CurPosturePercentage);
			}
			if (PostureType == PostureType.Multi)
			{
				OldPartsIndex = GetPosturePartIndex(OldPosturePercentage);
			}
		}
	}

	public void UpdateHpVal(EntityHpChangeEvt entityHpChangeEvt)
	{
		if (!(entityHpChangeEvt.entityId != entityId))
		{
			BasicMaxHp = entityHpChangeEvt.basicMaxHp;
			CurMaxHp = entityHpChangeEvt.curMaxHp;
			OldHp = entityHpChangeEvt.oldHp;
			CurHp = entityHpChangeEvt.curHp;
			CurHpPercentage = entityHpChangeEvt.curHpPercentage;
		}
	}

	public void SetInPosture(bool inPosture)
	{
		InPosture = inPosture;
	}

	public void UpdatePostureVal(EntityPostureChangeEvt postureChangeEvt)
	{
		if (!(postureChangeEvt.entityId != entityId))
		{
			MaxPosture = postureChangeEvt.maxPosture;
			CurPosture = postureChangeEvt.curPosture;
			CurPosturePercentage = postureChangeEvt.curPosturePercentage;
			OldPosture = postureChangeEvt.oldPosture;
			OldPosturePercentage = (float)OldPosture / (float)MaxPosture;
			if (PostureType == PostureType.Multi)
			{
				CurPartsIndex = GetPosturePartIndex(CurPosturePercentage);
			}
			if (PostureType == PostureType.Multi)
			{
				OldPartsIndex = GetPosturePartIndex(OldPosturePercentage);
			}
		}
	}

	private int GetPosturePartIndex(float percent)
	{
		if (Mathf.Approximately(percent, 1f))
		{
			return PosturePartsVal.Length - 1;
		}
		if (Mathf.Approximately(percent, 0f))
		{
			return 0;
		}
		for (int i = 0; i < PosturePartsVal.Length; i++)
		{
			if (percent > ((i == 0) ? 0f : PosturePartsVal[i - 1]) && percent <= PosturePartsVal[i])
			{
				return i;
			}
		}
		return 0;
	}

	public void UpdateWeakVal(EntityEnterWeakEvt enterWeakEvt)
	{
		if (!(enterWeakEvt.entityId != entityId))
		{
			InWeak = true;
			CurWeakPercentage = enterWeakEvt.curWeakPercentage;
		}
	}

	public void UpdateWeakVal(EntityExitWeakEvt exitWeakEvt)
	{
		if (!(exitWeakEvt.entityId != entityId))
		{
			InWeak = false;
		}
	}

	public void UpdateWeakVal(EntityWeakChangeEvt weakChangeEvt)
	{
		if (!(weakChangeEvt.entityId != entityId))
		{
			CurWeakPercentage = weakChangeEvt.weakPercentage;
		}
	}

	public void SetInBurst(bool inBurst)
	{
		InBurst = inBurst;
	}

	public void UpdateBurstVal(EntityBurstChangeEvt burstChangeEvt)
	{
		if (!(burstChangeEvt.entityId != entityId))
		{
			MaxBurst = burstChangeEvt.maxBurst;
			CurBurst = burstChangeEvt.curBurst;
			CurBurstPercentage = burstChangeEvt.curBurstPercentage;
		}
	}

	public void SetDamageType(int damageType)
	{
		DamageType = damageType;
	}
}
