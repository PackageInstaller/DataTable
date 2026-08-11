using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class BaseDamageFormulaZone : DamageFormulaZoneBase<BaseDamageFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcFixedValue();
		CalcPropertyAddition();
		CalcTalentDamageAddition();
		CalcDamageAdditionRatio();
	}

	protected override void OnNoExcuteFormulaZone()
	{
		CalcFixedValue();
	}

	protected void CalcFixedValue()
	{
		dataBase.fixedValue = dataDamage.fixedValue;
	}

	protected void CalcPropertyAddition()
	{
		if (dataDamage.bulletAttackData == null)
		{
			return;
		}
		BulletData bulletData = dataDamage.bulletAttackData.bulletData;
		if (bulletData == null)
		{
			return;
		}
		DRBullet cfg = bulletData.cfg;
		BulletRuntimeConfigData runtimeConfigData = bulletData.extraData.runtimeConfigData;
		if (bulletData.cfg == null || bulletData.extraData.runtimeConfigData == null)
		{
			return;
		}
		List<float> list = DealDamageRatio(runtimeConfigData.DamageRatio, cfg.DamageRatioModification, dataDamage.bulletAttackData.lifeTime);
		List<string> damageAdd = cfg.DamageAdd;
		if (list.Count == damageAdd.Count)
		{
			float num = 0f;
			for (int i = 0; i < list.Count; i++)
			{
				float damageBouns = BattleFormulaUtility.GetDamageBouns(cfg.DamageBonusTypeEnum, damageAdd[i], dataDamage, defender);
				num += damageBouns * list[i];
				dataBase.propertyAdditionList.Add(new BaseDamageFormulaData.PropertyDamageAddition
				{
					propertyKey = damageAdd[i],
					value = damageBouns,
					addition = list[i]
				});
			}
			dataBase.propertyAddition = num;
			dataBase.fixAddition = runtimeConfigData.FixAddition;
		}
	}

	protected void CalcTalentDamageAddition()
	{
		BaseEntity baseEntity = ((attacker.GetEntityType() == EntityType.SummonedEntity) ? attacker.Parent : attacker);
		if (baseEntity != null)
		{
			SkillAdditionData skillAdditionData = baseEntity.GetComponent<SkillComponent>()?.GetSkillAddition(dataDamage.BelongToSkillId);
			if (skillAdditionData != null)
			{
				dataBase.talentDamageRaito = skillAdditionData.TalentDamageRatio;
				dataBase.talentFixDamageRatio = skillAdditionData.TalentFixDamageRatio;
			}
			if (dataBase.talentDamageRaito == 0f)
			{
				dataBase.talentDamageRaito = 1f;
			}
			if (dataBase.talentFixDamageRatio == 0f)
			{
				dataBase.talentFixDamageRatio = 1f;
			}
		}
	}

	private List<float> DealDamageRatio(List<float> damageRatio, List<List<float>> ratioChange, float lifeTime)
	{
		float num = DamageRatioAdd(ratioChange, lifeTime);
		List<float> list = new List<float>();
		for (int i = 0; i < damageRatio.Count; i++)
		{
			list.Add(damageRatio[i] + damageRatio[i] * num);
		}
		return list;
	}

	private float DamageRatioAdd(List<List<float>> ratioChange, float lifeTime)
	{
		if (ratioChange.IsNullOrEmpty())
		{
			return 0f;
		}
		if (dataDamage.bulletAttackData == null)
		{
			return 0f;
		}
		if (ratioChange.Count < 2)
		{
			return 0f;
		}
		if (ratioChange[0] == null || ratioChange[0].Count != 1)
		{
			return 0f;
		}
		switch ((int)ratioChange[0][0])
		{
		case 1:
		{
			List<float> list3 = ratioChange[1];
			if (list3 == null || list3.Count != 4)
			{
				return 0f;
			}
			if (list3[3] < 0f)
			{
				return 0f;
			}
			list3[2] = ((list3[2] < 0f) ? 0f : list3[2]);
			if (lifeTime < list3[2])
			{
				return 0f;
			}
			if (lifeTime > list3[3])
			{
				return Mathf.Floor((list3[3] - list3[2]) / list3[0]) * list3[1];
			}
			return Mathf.Floor((lifeTime - list3[2]) / list3[0]) * list3[1];
		}
		case 2:
		{
			List<float> list4 = ratioChange[1];
			if (list4 == null || list4.Count != 3)
			{
				return 0f;
			}
			BaseEntity entity = attacker.GetSystem<EntitySystem>().GetEntity(dataDamage.bulletAttackData.bulletId);
			if (entity == null)
			{
				return 0f;
			}
			float num3 = Vector3.Distance(entity.initTransform.position, dataDamage.bulletAttackData.BulletPos);
			if (num3 < list4[0])
			{
				return 0f;
			}
			num3 = Mathf.Min(num3, list4[1]);
			return Mathf.Floor(num3 / list4[1] * list4[2]);
		}
		case 3:
		{
			List<float> list5 = ratioChange[1];
			List<float> list6 = ratioChange[2];
			if (list5 == null || list6 == null || list5.Count != list6.Count)
			{
				return 0f;
			}
			BaseEntity entity2 = attacker.GetSystem<EntitySystem>().GetEntity(dataDamage.bulletAttackData.bulletId);
			if (entity2 == null)
			{
				return 0f;
			}
			float num4 = Vector3.Distance(entity2.initTransform.position, defender.transform.position);
			int index = list5.Count - 1;
			if (num4 >= list5[index])
			{
				index = list6.Count - 1;
				return list6[index];
			}
			int num5 = -1;
			for (int j = 0; j < list5.Count; j++)
			{
				if (num4 < list5[j])
				{
					num5 = j - 1;
					break;
				}
			}
			if (num5 < 0)
			{
				return 0f;
			}
			return list6[num5];
		}
		case 4:
		{
			List<float> list = ratioChange[1];
			List<float> list2 = ratioChange[2];
			if (list == null || list2 == null || list.Count != list2.Count)
			{
				return 0f;
			}
			float num = Vector3.Distance(dataDamage.bulletAttackData.bulletData.parentPosition, defender.transform.position);
			int index = list.Count - 1;
			if (num >= list[index])
			{
				index = list2.Count - 1;
				return list2[index];
			}
			int num2 = -1;
			for (int i = 0; i < list.Count; i++)
			{
				if (num < list[i])
				{
					num2 = i - 1;
					break;
				}
			}
			if (num2 < 0)
			{
				return 0f;
			}
			return list2[num2];
		}
		default:
			return 0f;
		}
	}

	private void CalcDamageAdditionRatio()
	{
		dataBase.damageAdditionRatio = dataDamage.GetAttackerProperty("DamageRatioAddition");
	}
}
