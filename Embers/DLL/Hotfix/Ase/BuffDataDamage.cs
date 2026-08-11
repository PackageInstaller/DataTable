using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BuffDataDamage : BuffDataBase
{
	public BulletAttackData bulletAttackData;

	public float DamageScale;

	public HeroAttributeEnum DamageTypeEnum;

	public float fixedValue;

	public Vector3 hitDirect;

	public bool IsMelee;

	public int BelongToSkillId;

	public int damageTextId;

	public bool IsIgnoreHit = true;

	public float virtualHpScale;

	public int attackPower;

	public float shakeTime;

	public bool isExcuteFormula;

	public float TenacityScale;

	public int effectId;

	public string pointKey;

	public override BuffOperationType EffectType => BuffOperationType.Damage;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
	}

	protected override void OnResetParams(params object[] args)
	{
		BulletAttackData bulletAttackData = (BulletAttackData)args[0];
		if (bulletAttackData != null)
		{
			this.bulletAttackData = bulletAttackData;
			hitDirect = bulletAttackData.attackDirect;
			DamageScale = bulletAttackData.HitColliderVariableData?.DamageMagnification ?? 0f;
			TenacityScale = bulletAttackData.HitColliderVariableData?.TenacityMagnification ?? 0f;
			BelongToSkillId = bulletAttackData.bulletData.BelongToSkillId;
			DRBullet dRBullet = bulletAttackData.bulletData.cfg ?? null;
			if (dRBullet != null)
			{
				IsMelee = dRBullet.IsMelee;
				DamageTypeEnum = dRBullet.HeroAttributeEnum;
				attackPower = dRBullet.AttackPower;
				shakeTime = dRBullet.ShakeTime;
				virtualHpScale = dRBullet.VirtualHpConvertHpScale;
				IsIgnoreHit = dRBullet.IsIgnoreHit;
			}
		}
		isExcuteFormula = true;
	}

	protected override string OnGetDataString()
	{
		return "这是伤害Buff，别瞎改";
	}

	protected override void OnClear()
	{
		if (bulletAttackData != null)
		{
			ReferencePool.Release(bulletAttackData);
			bulletAttackData = null;
		}
		DamageScale = 0f;
		DamageTypeEnum = HeroAttributeEnum.Normal;
		fixedValue = 0f;
		hitDirect = Vector3.zero;
		IsMelee = false;
		BelongToSkillId = 0;
		damageTextId = 0;
		IsIgnoreHit = true;
		virtualHpScale = 0f;
		attackPower = 0;
		shakeTime = 0f;
		isExcuteFormula = false;
		effectId = 0;
		pointKey = string.Empty;
	}
}
