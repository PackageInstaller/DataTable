using System.Collections.Generic;
using UnityEngine;

namespace ZumaGame;

public class ZumaEndlessManager
{
	public bool isEndless;

	public float duration = 300f;

	public float remainDuration;

	private List<string> endlessRandomList = new List<string>();

	private bool isChangeMapEffect;

	private float timeCountdownAniPlayTime = 10f;

	private float changeMapAllTimes = 2.2f;

	private float changeMapTims;

	public void InitEndless(bool isEndless)
	{
		isChangeMapEffect = false;
		changeMapTims = 0f;
		this.isEndless = isEndless;
		if (isEndless)
		{
			InitEndlessData();
		}
	}

	private void InitEndlessData()
	{
		int effectValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessTimes);
		if (effectValue != 0)
		{
			duration = effectValue;
		}
		remainDuration = duration;
		ZumaEffectData effectData = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectData(ZumaEffectType.EndlessMap);
		if (effectData != null)
		{
			for (int i = 0; i < effectData.effectValueStrList.Length; i++)
			{
				endlessRandomList.Add(effectData.effectValueStrList[i]);
			}
		}
	}

	public void UpdateEndlessTimes(float times)
	{
		if (!isEndless)
		{
			return;
		}
		if (isChangeMapEffect)
		{
			UpdateChangeMapShow(times);
			return;
		}
		if (remainDuration > timeCountdownAniPlayTime && remainDuration - times < timeCountdownAniPlayTime)
		{
			ZumaGameManager.GetInstance().zumaGamePlay.PlayEndlessTimeAni(isPlay: true);
		}
		remainDuration -= times;
		if (remainDuration <= 0f)
		{
			LuaHelper.CallFunction("ZumaToLuaBridge.OnZumaOver", true);
			ZumaGameManager.GetInstance().zumaGamePlay.gameOver = true;
		}
	}

	public float GetEndlessTimes()
	{
		return remainDuration;
	}

	public string RandomEndlessMap()
	{
		int index = Random.Range(0, endlessRandomList.Count);
		string text = endlessRandomList[index];
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaEndlessSetMapName", text);
		return text;
	}

	public void UpdateChangeMapShow(float times)
	{
		changeMapTims -= times;
		if (changeMapTims <= 0f)
		{
			EndChangeMap();
		}
	}

	public void BeginChangeMap()
	{
		if (!isChangeMapEffect)
		{
			changeMapTims = changeMapAllTimes;
			isChangeMapEffect = true;
			AudioManager.Instance.Play("effect", "minigame_activity_3_11", "minigame_activity_3_11_zuma_mapchange", useStream: false);
			LuaHelper.CallFunction("ZumaToLuaBridge.ZumaEndlessChangeMap", true);
		}
	}

	private void EndChangeMap()
	{
		isChangeMapEffect = false;
		string newMapName = RandomEndlessMap();
		ZumaGameManager.GetInstance().zumaGamePlay.EndlessEnterNextMap(newMapName);
		LuaHelper.CallFunction("ZumaToLuaBridge.ZumaEndlessChangeMap", false);
	}
}
