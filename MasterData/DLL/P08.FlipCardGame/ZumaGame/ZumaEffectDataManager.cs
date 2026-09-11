using System.Collections.Generic;

namespace ZumaGame;

public class ZumaEffectDataManager
{
	private Dictionary<ZumaEffectType, float> effectFloatDic = new Dictionary<ZumaEffectType, float>();

	private Dictionary<SkillType, Dictionary<ZumaEffectType, ZumaEffectData>> skillEffectDic = new Dictionary<SkillType, Dictionary<ZumaEffectType, ZumaEffectData>>();

	private Dictionary<ZumaEffectType, ZumaEffectData> effectDataDic = new Dictionary<ZumaEffectType, ZumaEffectData>();

	public void TalentInit(ZumaEffectData[] list)
	{
		effectFloatDic.Clear();
		skillEffectDic.Clear();
		effectDataDic.Clear();
		foreach (ZumaEffectData effectData in list)
		{
			EffectDataInit(effectData);
		}
	}

	public void EffectDataInit(ZumaEffectData effectData)
	{
		ZumaEffectType effectType = (ZumaEffectType)effectData.effectType;
		if (effectType >= ZumaEffectType.BallSpeedSlow && effectType <= ZumaEffectType.WinScoreUp)
		{
			effectFloatDic[effectType] = (float)effectData.effectValueList[0] / 100f;
		}
		else if (effectType >= ZumaEffectType.SkillUseTimes && effectType <= ZumaEffectType.SkillBaseDuration)
		{
			SkillType key = (SkillType)effectData.effectValueList[1];
			if (!skillEffectDic.ContainsKey(key))
			{
				skillEffectDic.Add(key, new Dictionary<ZumaEffectType, ZumaEffectData>());
			}
			if (skillEffectDic[key].ContainsKey(effectType) && effectType == ZumaEffectType.SkillTimesAdd)
			{
				skillEffectDic[key][effectType].effectValueList[0] += effectData.effectValueList[0];
			}
			else
			{
				skillEffectDic[key][effectType] = effectData;
			}
		}
		else
		{
			effectDataDic[effectType] = effectData;
		}
	}

	public float GetEffectFloatValue(ZumaEffectType type)
	{
		if (effectFloatDic.ContainsKey(type))
		{
			return effectFloatDic[type];
		}
		return 0f;
	}

	public int GetSkillEffectValue(SkillType skillType, ZumaEffectType effectType)
	{
		if (skillEffectDic.ContainsKey(skillType) && skillEffectDic[skillType].ContainsKey(effectType))
		{
			return skillEffectDic[skillType][effectType].effectValueList[0];
		}
		return 0;
	}

	public int GetEffectValue(ZumaEffectType effectType)
	{
		if (effectDataDic.ContainsKey(effectType))
		{
			return effectDataDic[effectType].effectValueList[0];
		}
		return 0;
	}

	public ZumaEffectData GetEffectData(ZumaEffectType effectType)
	{
		if (effectDataDic.ContainsKey(effectType))
		{
			return effectDataDic[effectType];
		}
		return null;
	}

	public bool GetEffectIsExist(ZumaEffectType effectType)
	{
		if (effectDataDic.ContainsKey(effectType))
		{
			return true;
		}
		return false;
	}
}
