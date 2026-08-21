using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class CutFlavourWeaknessData : BaseWeaknessData
{
	private WeaknessComparer _comparer;

	private int _recursionValue;

	public float otherWeaknessTimer;

	public List<FoundWeaknessData> weaknessConfig;

	public override void Init(DRWeaknessUIData config)
	{
		base.Init(config);
		_recursionValue = 0;
		KeennessInfluenceWeakness(weaknessConfig, monsterEntity, otherWeaknessTimer);
		_comparer = new WeaknessComparer();
		Runtime = 0f - config.WeaknessDelayTime;
		SingleWeakLiftTime = base.Lifetime;
		if (weaknessConfig.Count == 0)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"CutFlavourWeaknessData weaknessConfig.Count = {weaknessConfig.Count} ", monsterEntity);
			}
			WeakConfigCount = 1;
			WeaknessStateInfo weaknessStateInfo = CreateWeaknessBaseData(1);
			CreateWeaknessTimerData(weaknessStateInfo, 0f, base.Lifetime, "weaknessConfig.Count == 0");
			weaknessState.Add(weaknessStateInfo);
		}
		else if (weaknessConfig.Count == 1)
		{
			WeakConfigCount = 1;
			WeaknessStateInfo weaknessStateInfo2 = CreateWeaknessBaseData(weaknessConfig[0].Level);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId("CutFlavourWeaknessData weaknessConfig.Count = 0 ", monsterEntity);
			}
			CreateWeaknessTimerData(weaknessStateInfo2, weaknessConfig[0].CentralMoment - weaknessConfig[0].Timer / 2f, weaknessConfig[0].CentralMoment + weaknessConfig[0].Timer / 2f, "weaknessConfig.Count == 1");
			weaknessState.Add(weaknessStateInfo2);
			RecursionLeftWeaknessData(weaknessStateInfo2);
			RecursionRightWeaknessData(weaknessStateInfo2);
		}
		else
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"CutFlavourWeaknessData weaknessConfig.Count = {weaknessConfig.Count} ", monsterEntity);
			}
			WeakConfigCount = 2;
			SingleWeakLiftTime = base.Lifetime / 2f;
			List<WeaknessStateInfo> list = new List<WeaknessStateInfo>();
			WeaknessStateInfo weaknessStateInfo3 = CreateWeaknessBaseData(weaknessConfig[0].Level);
			CreateWeaknessTimerData(weaknessStateInfo3, weaknessConfig[0].CentralMoment - weaknessConfig[0].Timer / 2f, weaknessConfig[0].CentralMoment + weaknessConfig[0].Timer / 2f, " 首先递归左侧 weaknessConfig.Count == else");
			weaknessState.Add(weaknessStateInfo3);
			list.Add(weaknessStateInfo3);
			RecursionLeftWeaknessData(weaknessStateInfo3);
			FoundWeaknessData foundWeaknessData = weaknessConfig[weaknessConfig.Count - 1];
			WeaknessStateInfo weaknessStateInfo4 = CreateWeaknessBaseData(foundWeaknessData.Level);
			CreateWeaknessTimerData(weaknessStateInfo4, foundWeaknessData.CentralMoment - foundWeaknessData.Timer / 2f, foundWeaknessData.CentralMoment + foundWeaknessData.Timer / 2f, " 首先递归右侧 weaknessConfig.Count == else");
			weaknessState.Add(weaknessStateInfo4);
			list.Add(weaknessStateInfo4);
			RecursionRightWeaknessData(weaknessStateInfo4);
			for (int i = 0; i < weaknessConfig.Count; i++)
			{
				if (i != 0 && i != weaknessConfig.Count - 1)
				{
					WeaknessStateInfo weaknessStateInfo5 = CreateWeaknessBaseData(weaknessConfig[i].Level);
					CreateWeaknessTimerData(weaknessStateInfo5, weaknessConfig[i].CentralMoment - weaknessConfig[i].Timer / 2f, weaknessConfig[i].CentralMoment + weaknessConfig[i].Timer / 2f, " 递归中间空隙 weaknessConfig.Count == else");
					list.Add(weaknessStateInfo5);
					weaknessState.Add(weaknessStateInfo5);
				}
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (j != list.Count - 1)
				{
					float length = list[j + 1].StartTimer - list[j].EndTimer;
					RecursionCenterWeaknessData(length, list[j], list[j + 1]);
				}
			}
		}
		weaknessState.Sort(_comparer);
	}

	private void RecursionCenterWeaknessData(float length, WeaknessStateInfo infoLeft, WeaknessStateInfo infoRight)
	{
		if (length <= 0f)
		{
			return;
		}
		WeaknessStateInfo weaknessStateInfo = null;
		float num = 0f;
		num = ((length > otherWeaknessTimer) ? otherWeaknessTimer : length);
		if (infoLeft.TempValue == 2 && infoRight.TempValue == 2)
		{
			weaknessStateInfo = CreateWeaknessBaseData(infoLeft.TempValue - 1);
			CreateWeaknessTimerData(weaknessStateInfo, infoLeft.EndTimer, infoRight.StartTimer, "RecursionCenterWeaknessData 俩边都是2 中间1级填满");
			weaknessState.Add(weaknessStateInfo);
			return;
		}
		length -= otherWeaknessTimer;
		if (infoLeft.TempValue >= infoRight.TempValue)
		{
			infoLeft.TempValue--;
			weaknessStateInfo = CreateWeaknessBaseData(infoLeft.TempValue);
			CreateWeaknessTimerData(weaknessStateInfo, infoLeft.EndTimer, infoLeft.EndTimer + num, "infoLeft.TempValue >= infoRight.TempValue");
			weaknessState.Add(weaknessStateInfo);
			RecursionCenterWeaknessData(length, weaknessStateInfo, infoRight);
		}
		else
		{
			infoRight.TempValue--;
			weaknessStateInfo = CreateWeaknessBaseData(infoRight.TempValue);
			CreateWeaknessTimerData(weaknessStateInfo, infoRight.StartTimer - num, infoRight.StartTimer, "infoLeft.TempValue >= infoRight.TempValue  else");
			weaknessState.Add(weaknessStateInfo);
			RecursionCenterWeaknessData(length, infoLeft, weaknessStateInfo);
		}
	}

	private void RecursionLeftWeaknessData(WeaknessStateInfo info)
	{
		_recursionValue++;
		if (_recursionValue <= 999)
		{
			WeaknessStateInfo weaknessStateInfo = CreateWeaknessBaseData(info.TempValue - 1);
			if (weaknessStateInfo.TempValue == 1)
			{
				CreateWeaknessTimerData(weaknessStateInfo, 0f, info.StartTimer, "RecursionLeftWeaknessData lowInfo.TempValue == 1");
				weaknessState.Add(weaknessStateInfo);
			}
			else if (info.StartTimer - otherWeaknessTimer <= 0f)
			{
				CreateWeaknessTimerData(weaknessStateInfo, 0f, info.StartTimer, "RecursionLeftWeaknessData info.StartTimer - otherWeaknessTimer <= 0");
				weaknessState.Add(weaknessStateInfo);
			}
			else
			{
				CreateWeaknessTimerData(weaknessStateInfo, info.StartTimer - otherWeaknessTimer, info.StartTimer, "RecursionLeftWeaknessData else");
				weaknessState.Add(weaknessStateInfo);
				RecursionLeftWeaknessData(weaknessStateInfo);
			}
		}
	}

	private void RecursionRightWeaknessData(WeaknessStateInfo info)
	{
		_recursionValue++;
		if (_recursionValue <= 999)
		{
			WeaknessStateInfo weaknessStateInfo = CreateWeaknessBaseData(info.TempValue - 1);
			if (weaknessStateInfo.TempValue == 1)
			{
				CreateWeaknessTimerData(weaknessStateInfo, info.EndTimer, base.Lifetime, "RecursionRightWeaknessData lowInfo.TempValue == 1");
				weaknessState.Add(weaknessStateInfo);
			}
			else if (info.EndTimer + otherWeaknessTimer >= base.Lifetime)
			{
				CreateWeaknessTimerData(weaknessStateInfo, info.EndTimer, base.Lifetime, "RecursionRightWeaknessData info.EndTimer + otherWeaknessTimer >= Lifetime");
				weaknessState.Add(weaknessStateInfo);
			}
			else
			{
				CreateWeaknessTimerData(weaknessStateInfo, info.EndTimer, info.EndTimer + otherWeaknessTimer, "RecursionRightWeaknessData else");
				weaknessState.Add(weaknessStateInfo);
				RecursionRightWeaknessData(weaknessStateInfo);
			}
		}
	}

	private WeaknessStateInfo CreateWeaknessBaseData(int weaknessLevel)
	{
		DRWeaknessData dataRow = GameEntry.DataTable.GetDataRow<DRWeaknessData>(weaknessLevel);
		WeaknessStateInfo weaknessStateInfo = ReferencePool.Acquire<WeaknessStateInfo>();
		weaknessStateInfo.ConfigId = dataRow.Id;
		weaknessStateInfo.LV = dataRow.Level;
		weaknessStateInfo.ToughDamagePercent = dataRow.ToughnessDamage;
		weaknessStateInfo.DamagePercent = dataRow.Damage;
		weaknessStateInfo.ViewColor = new Color(dataRow.WeaknessViewColor[0], dataRow.WeaknessViewColor[1], dataRow.WeaknessViewColor[2], dataRow.WeaknessViewColor[3]);
		weaknessStateInfo.WeaknessDamageTextType = dataRow.WeaknessWorldKey;
		weaknessStateInfo.XpIncrease = dataRow.XPIncrease;
		weaknessStateInfo.TempValue = weaknessLevel;
		weaknessStateInfo.WeaknessLevel = dataRow.Level;
		weaknessStateInfo.WeaknessCriticalDamageTextType = dataRow.WeaknessCriticalWorldKey;
		weaknessStateInfo.IsWarnWeakness = dataRow.IsWarnWeakness;
		weaknessStateInfo.EffectList = dataRow.WeaknessHitSfx;
		weaknessStateInfo.EffectCoolingList = dataRow.WeaknessHitSfxCooling;
		return weaknessStateInfo;
	}

	private void CreateWeaknessTimerData(WeaknessStateInfo info, float startTimer, float endTimer, string content)
	{
		info.StateScale = (endTimer - startTimer) / base.Lifetime;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"CreateWeaknessTimerData endTimer = {endTimer} startTimer = {startTimer} Lifetime = {base.Lifetime}  content = {content}", monsterEntity);
		}
		info.StartTimer = startTimer;
		info.Timer = endTimer - startTimer;
		info.EndTimer = endTimer;
	}

	private void KeennessInfluenceWeakness(List<FoundWeaknessData> configData, BaseEntity entity, float otherWeaknessTimer)
	{
		if (configData.Count == 0)
		{
			return;
		}
		float num = (entity as MonsterEntity)?.GetMeatQuality() ?? 1f;
		float num2 = 5f;
		int keennessMaxInfluence = entity.GetWorld().BattleConfig.keennessMaxInfluence;
		keennessMaxInfluence = ((!(Mathf.Abs(num2 - num) > (float)keennessMaxInfluence)) ? ((int)(num2 - num)) : ((num2 > num) ? keennessMaxInfluence : (-keennessMaxInfluence)));
		float influenceValue = (float)keennessMaxInfluence * entity.GetWorld().BattleConfig.oneKeennessInfluence;
		List<int> list = CollectionPool<List<int>, int>.Get();
		for (int i = 0; i < configData.Count; i++)
		{
			RecursionWeaknessData(configData[i], influenceValue, otherWeaknessTimer * 2f);
			if (configData[i].Level == 1)
			{
				list.Add(i);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			configData.RemoveAt(j);
		}
		CollectionPool<List<int>, int>.Release(list);
	}

	private void VerifyWeaknessData(List<FoundWeaknessData> configData, float maxWeaknessTimer)
	{
		for (int i = 0; i < configData.Count; i++)
		{
			if (configData[i].Level != monsterEntity.GetWorld().BattleConfig.weaknessMaxLevel && configData[i].Timer > maxWeaknessTimer)
			{
				configData[i].Timer = maxWeaknessTimer;
			}
		}
	}

	private void RecursionWeaknessData(FoundWeaknessData data, float influenceValue, float maxWeaknessTimer)
	{
		_recursionValue++;
		if (_recursionValue > 999 || data.Level == 1 || influenceValue == 0f)
		{
			return;
		}
		if (influenceValue > 0f)
		{
			if (data.Level == monsterEntity.GetWorld().BattleConfig.weaknessMaxLevel)
			{
				data.Timer += influenceValue;
				influenceValue = 0f;
			}
			else
			{
				data.Timer += influenceValue;
				if (data.Timer > maxWeaknessTimer)
				{
					influenceValue = data.Timer - maxWeaknessTimer;
					data.Timer = 0f;
					data.Level++;
				}
				else
				{
					influenceValue = 0f;
				}
			}
		}
		else if (data.Timer <= Mathf.Abs(influenceValue))
		{
			influenceValue += data.Timer;
			data.Level--;
			data.Timer = maxWeaknessTimer;
		}
		else
		{
			data.Timer += influenceValue;
			influenceValue = 0f;
		}
		RecursionWeaknessData(data, influenceValue, maxWeaknessTimer);
	}

	public override void Clear()
	{
		base.Clear();
		for (int i = 0; i < weaknessConfig.Count; i++)
		{
			ReferencePool.Release(weaknessConfig[i]);
		}
		weaknessConfig.Clear();
		weaknessConfig = null;
		otherWeaknessTimer = 0f;
		_comparer = null;
		_recursionValue = 0;
	}
}
