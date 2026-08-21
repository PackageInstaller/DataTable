using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaCreate : MonoBehaviour
{
	public static List<int> createColorList = new List<int>();

	private static BallEffctType lastShootBallType = BallEffctType.Empty;

	public static int createSpecialScore = 0;

	private static int createShootSpecialDisCount = 0;

	public static bool isInit = false;

	public static int createScore;

	private static List<BallEffctType> specialBallCreateList = new List<BallEffctType>
	{
		BallEffctType.CHANGECOLOR,
		BallEffctType.BOOM,
		BallEffctType.ALMIGHTY
	};

	public static void InitRandData()
	{
		List<bool> useColorList = ZumaGameManager.GetInstance().GetZumaMapData().useColorList;
		createColorList.Clear();
		for (int i = 0; i < 8; i++)
		{
			if (useColorList[i])
			{
				createColorList.Add(i);
			}
		}
		isInit = true;
		float effectFloatValue = ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.ShooterSpeicalUp1);
		effectFloatValue += ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.ShooterSpeicalUp2);
		effectFloatValue += ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectFloatValue(ZumaEffectType.ShooterSpeicalUp3);
		createScore = (int)(500f * (1f - effectFloatValue) + 0.1f);
		createShootSpecialDisCount = 0;
		createSpecialScore = 0;
		SpawnSpeicalEffect();
	}

	public static void ClearData()
	{
		createSpecialScore = 0;
	}

	public static BallEffctType SpawnSpeicalEffect()
	{
		if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.EndlessMapEffectA))
		{
			return BallEffctType.BOOM;
		}
		if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.EndlessMapEffectB))
		{
			return BallEffctType.CHANGECOLOR;
		}
		int index = Random.Range(1, 3);
		BallEffctType value = specialBallCreateList[index];
		specialBallCreateList[index] = specialBallCreateList[0];
		specialBallCreateList[0] = value;
		return specialBallCreateList[0];
	}

	public static void SpawnShootBallStrategy(out BallEffctType effectType, out BallColorType colorType)
	{
		effectType = BallEffctType.NORMAL;
		colorType = BallColorType.EmptyColor;
		if (createSpecialScore >= createScore && (createShootSpecialDisCount >= 3 || lastShootBallType == BallEffctType.Empty))
		{
			effectType = SpawnSpeicalEffect();
			lastShootBallType = effectType;
			createSpecialScore -= createScore;
			createShootSpecialDisCount = 0;
		}
		else
		{
			createShootSpecialDisCount++;
		}
		if (effectType == BallEffctType.CHANGECOLOR || effectType == BallEffctType.NORMAL)
		{
			int index = Random.Range(0, createColorList.Count);
			colorType = (BallColorType)createColorList[index];
		}
	}

	public static BallColorType RangeShootBallColor()
	{
		int index = Random.Range(0, createColorList.Count);
		return (BallColorType)createColorList[index];
	}
}
