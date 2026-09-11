using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace ZumaGame;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct ZumaGameConst
{
	public const int colorNums = 8;

	public const int trackBallChance = 50;

	public const float oneStopDuration = 5f;

	public const float oneAimDuration = 5f;

	public const float oneBackProgress = 10f;

	public const float aimAddShootSpeed = 5f;

	public const float backBallSpeed = 10f;

	public const float fallbackSpeed = 15f;

	public const int minCreateSpeicalCount = 30;

	public const int speicalCreateCDCount = 10;

	public const int createScore = 500;

	public const int shootBallCreateCDCount = 3;

	public const int goldMinCreateTimes = 20;

	public const int goldMaxCreateTimes = 30;

	public const int goldfadeTimes = 10;

	public const float baseEffectRange = 0.11f;

	public const float speicalEffectRangeBase = 0.55f;

	public static float speicalEffectRange;

	public const int scoreBase = 10;

	public const int routeScoreBase = 10;

	public const int goldScoreBase = 100;

	public static int hitScore;

	public static int routeScore;

	public static int goldScore;

	public const int moveToBeginScoreBase = 100;

	public const float updateTimeValue = 0.02f;

	public const float warningHoleValue = 7f;

	public static float GetTimeValue()
	{
		return Math.Min(Time.deltaTime, 0.02f);
	}

	public static void InitTalentValue()
	{
		hitScore = (int)(10f * (1f + ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.HitScoreUp)));
		routeScore = (int)(10f * (1f + ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.WinScoreUp)));
		goldScore = (int)(100f * (1f + ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.GoldScoreUp)));
		float num = (float)(ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessMapEffectA) + ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectValue(ZumaEffectType.EndlessMapEffectB)) / 100f;
		speicalEffectRange = 0.55f * (1f + num);
	}

	public static int CountComboScorePower(int commboLv)
	{
		int result = 1;
		if (commboLv == 1)
		{
			result = 1;
		}
		else if (commboLv == 2)
		{
			result = 2;
		}
		else if (commboLv == 3)
		{
			result = 3;
		}
		else if (commboLv == 4)
		{
			result = 4;
		}
		else if (commboLv >= 5)
		{
			result = 5;
		}
		return result;
	}

	public static float CountComboBackPower(int commboLv)
	{
		float result = 1f;
		if (commboLv == 1)
		{
			result = 1f;
		}
		else if (commboLv == 2)
		{
			result = 1.5f;
		}
		else if (commboLv == 3)
		{
			result = 2f;
		}
		else if (commboLv == 4)
		{
			result = 3f;
		}
		else if (commboLv >= 5)
		{
			result = 5f;
		}
		return result;
	}
}
