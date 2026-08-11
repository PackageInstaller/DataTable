using System.Collections.Generic;
using Ase;
using GameFramework;

public class NormalWeaknessData : BaseWeaknessData
{
	public List<MomentWeaknessData> weaknessConfig;

	public override void Init(DRWeaknessUIData config)
	{
		base.Init(config);
		float num = 0f;
		for (int i = 0; i < weaknessConfig.Count; i++)
		{
			num += weaknessConfig[i].TimeLength;
		}
		float num2 = 0f;
		for (int j = 0; j < weaknessConfig.Count; j++)
		{
			DRWeaknessData dataRow = GameEntry.DataTable.GetDataRow<DRWeaknessData>(weaknessConfig[j].ConfigId);
			WeaknessStateInfo weaknessStateInfo = ReferencePool.Acquire<WeaknessStateInfo>();
			weaknessStateInfo.ConfigId = dataRow.Id;
			weaknessStateInfo.LV = dataRow.Level;
			weaknessStateInfo.ToughDamagePercent = dataRow.ToughnessDamage;
			weaknessStateInfo.DamagePercent = dataRow.Damage;
			weaknessStateInfo.StateScale = weaknessConfig[j].TimeLength / num;
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"NormalWeaknessData weaknessConfig[i].TimeLength = {weaknessConfig[j].TimeLength} scaleSum = {num} ", monsterEntity);
			}
			weaknessStateInfo.WeaknessDamageTextType = dataRow.WeaknessWorldKey;
			weaknessStateInfo.WeaknessCriticalDamageTextType = dataRow.WeaknessCriticalWorldKey;
			weaknessStateInfo.StartTimer = num2;
			weaknessStateInfo.Timer = weaknessStateInfo.StateScale * base.Lifetime;
			num2 = (weaknessStateInfo.EndTimer = num2 + weaknessStateInfo.Timer);
			weaknessStateInfo.XpIncrease = dataRow.XPIncrease;
			weaknessStateInfo.WeaknessLevel = dataRow.Level;
			weaknessStateInfo.IsWarnWeakness = dataRow.IsWarnWeakness;
			weaknessStateInfo.EffectList = dataRow.WeaknessHitSfx;
			weaknessStateInfo.EffectCoolingList = dataRow.WeaknessHitSfxCooling;
			weaknessState.Add(weaknessStateInfo);
		}
		Runtime = 0f - config.WeaknessDelayTime;
	}
}
