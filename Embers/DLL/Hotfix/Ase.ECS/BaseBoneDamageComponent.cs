using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class BaseBoneDamageComponent : BaseComponent
{
	private List<DRBoneDamageCalcData> baseBoneDamageDic = new List<DRBoneDamageCalcData>();

	private bool _isRun = true;

	public override void OnStart(object data)
	{
		base.OnStart(data);
		DRMonster data2 = GetData<DRMonster>("MonsterConfig");
		if (data2 == null)
		{
			return;
		}
		if (data2.BoundID.Count <= 0)
		{
			_isRun = false;
		}
		foreach (int item in data2.BoundID)
		{
			DRBoneDamageCalcData dataRow = GameEntry.DataTable.GetDataRow<DRBoneDamageCalcData>(item);
			if (dataRow != null)
			{
				baseBoneDamageDic.Add(dataRow);
			}
		}
	}

	public DRBoneDamageCalcData GetBoneDamageConfig(BaseEntity attackerEntity, Vector3 bulletPos, bool isMelee)
	{
		if (!IsCanRun())
		{
			return null;
		}
		float num = 0f;
		WeaponEnum item = (attackerEntity as HeroEntity)?.BattleHeroData.WeaponEnum ?? WeaponEnum.Gun;
		if (isMelee)
		{
			num = TSUtil.TargetFwdAngleToSelf(mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles.y, attackerEntity.transform.position);
			num = TSUtil.Harf2Full(num);
			num = ((Mathf.Abs(num - 360f) <= 1f) ? 359f : num);
		}
		else
		{
			num = TSUtil.TargetFwdAngleToSelf(mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles.y, bulletPos);
			num = TSUtil.Harf2Full(num);
			num = ((Mathf.Abs(num - 360f) <= 1f) ? 359f : num);
		}
		foreach (DRBoneDamageCalcData item2 in baseBoneDamageDic)
		{
			if ((float)item2.MinValue < num && (float)item2.MaxValue >= num && item2.WeaponEnum.Contains(item))
			{
				if ((double)Math.Abs(item2.DamageTextScale - 0f) < 0.0010000000474974513)
				{
					return null;
				}
				return item2;
			}
		}
		return null;
	}

	private bool IsCanRun()
	{
		return _isRun;
	}

	public override void OnDispose()
	{
		baseBoneDamageDic.Clear();
		_isRun = true;
	}
}
