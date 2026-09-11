using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

namespace RogueCard;

public static class RogueCardTimeSystem
{
	private static float _curTick = 0f;

	private static List<int> speedUpList;

	private static Dictionary<string, float> timeDic_ = new Dictionary<string, float>
	{
		["Score_CardPlayNum"] = 0.8f,
		["Score_CardScoreShow"] = 0.1f,
		["Score_JokerPlayNum"] = 0.8f,
		["Score_FlyText"] = 0.3f,
		["WuChang_Effect"] = 1.6f,
		["WuChang_FlipChangeDelay"] = 0.2f,
		["cardDrawAnimationDuration"] = 0.3f,
		["cardDrawInterval"] = 0.1f,
		["story_item"] = 0.8f,
		["story_change"] = 0.6f,
		["story_end"] = 0.8f,
		["fanzhuan"] = 0.14f
	};

	public static float GetSpeed
	{
		get
		{
			int num = 1;
			if (RogueCardGameMain.Instance.isAniSpeedUp)
			{
				num *= 2;
			}
			for (int i = 0; i < speedUpList.Count; i++)
			{
				if (_curTick > (float)speedUpList[i])
				{
					num *= 2;
				}
			}
			return num;
		}
	}

	public static bool isPlayingAni { get; private set; }

	public static void Init()
	{
		Reset();
		if (speedUpList == null)
		{
			speedUpList = new List<int>();
		}
		speedUpList.Clear();
		object[] array = LuaHelper.CallFunction("RogueCardGameBridge.GetSpeedUpData");
		for (int i = 0; i < array.Length; i++)
		{
			LuaTable luaTable = array[i] as LuaTable;
			for (int j = 1; j <= luaTable.Length; j++)
			{
				speedUpList.Add((int)(double)luaTable[j]);
			}
		}
	}

	public static void Reset()
	{
		_curTick = 0f;
		isPlayingAni = false;
	}

	public static void Update()
	{
		_curTick += Time.deltaTime;
	}

	public static void StartTick()
	{
		_curTick = 0f;
		isPlayingAni = true;
	}

	public static void EndTick()
	{
		isPlayingAni = false;
	}

	public static float GetTime(string key, bool useSpeed = false)
	{
		if (!timeDic_.ContainsKey(key))
		{
			return 1f;
		}
		float num = timeDic_[key];
		if (useSpeed)
		{
			num /= GetSpeed;
		}
		return num;
	}
}
