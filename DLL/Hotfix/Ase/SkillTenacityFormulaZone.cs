using Ase.ECS;

namespace Ase;

public class SkillTenacityFormulaZone : TenacityFormulaZoneBase<SkillTenacityFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcSkillTenacity();
		CalcTechTenacity();
	}

	protected void CalcSkillTenacity()
	{
		BulletRuntimeConfigData bulletRuntimeConfigData = dataDamage.bulletAttackData?.bulletData?.extraData?.runtimeConfigData ?? null;
		if (bulletRuntimeConfigData != null)
		{
			dataBase.bulletTenacity = bulletRuntimeConfigData.AffectTenacity;
			dataBase.fixedTenacity = bulletRuntimeConfigData.FixedAffectTenacity;
		}
		SkillAdditionData skillAdditionData = attacker.GetComponent<SkillComponent>()?.GetSkillAddition(dataDamage.BelongToSkillId);
		if (skillAdditionData != null)
		{
			dataBase.talentTenacity = skillAdditionData.TalentTenacityRatio;
			dataBase.talentFixedTenacity = skillAdditionData.TalentFixTenacityRatio;
		}
		if (dataBase.talentTenacity == 0f)
		{
			dataBase.talentTenacity = 1f;
		}
		if (dataBase.talentFixedTenacity == 0f)
		{
			dataBase.talentFixedTenacity = 1f;
		}
	}

	protected void CalcTechTenacity()
	{
		dataBase.isHitWeak = weaknessData != null && weaknessData.Level > 1;
		if (dataBase.isHitWeak)
		{
			dataBase.weaknessTenacityAddition = dataDamage.GetAttackerProperty("HighWeaknessTenacityAddition");
			dataBase.weakTenacity = weaknessData.TenacityDamagePercent * (1f + dataBase.weaknessTenacityAddition) + dataDamage.TenacityScale;
			switch ((dataDamage.bulletAttackData?.HitColliderVariableData?.SiteLevel).GetValueOrDefault())
			{
			case 0:
				dataBase.siteAddition = dataDamage.GetAttackerProperty("NBTenacityAddition");
				break;
			case 1:
				dataBase.siteAddition = dataDamage.GetAttackerProperty("BTenacityAddition");
				break;
			case 2:
				dataBase.siteAddition = dataDamage.GetAttackerProperty("HBTenacityAddition");
				break;
			}
			dataBase.techTenacity = dataBase.weakTenacity + dataBase.siteAddition;
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"weaknessTenacityAddition:{dataBase.weaknessTenacityAddition}", attacker);
				LockstepData.Instance.WriteAuthorityEntityId($"TenacityDamagePercent:{weaknessData.TenacityDamagePercent}", attacker);
				LockstepData.Instance.WriteAuthorityEntityId($"TenacityScale:{dataDamage.TenacityScale}", attacker);
			}
			return;
		}
		HitColliderVariableData hitColliderVariableData = dataDamage.bulletAttackData?.HitColliderVariableData ?? null;
		if (hitColliderVariableData != null)
		{
			float num = 0f;
			if (attacker is HeroEntity)
			{
				num = dataDamage.GetAttackerProperty("NormalTenacityAmend");
			}
			dataBase.techTenacity = hitColliderVariableData.NormalTouch * (1f + num);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"constant:{num}", attacker);
				LockstepData.Instance.WriteAuthorityEntityId($"NormalTouch:{hitColliderVariableData.NormalTouch}", attacker);
				LockstepData.Instance.WriteAuthorityEntityId($"techTenacity:{dataBase.techTenacity}", attacker);
			}
		}
	}
}
