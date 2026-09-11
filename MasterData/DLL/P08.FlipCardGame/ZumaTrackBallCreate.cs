using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaTrackBallCreate
{
	public BallColorType colorType;

	public BallEffctType effectType;

	public int colorSpawnNum;

	public List<BallGroupItem> useGroup = new List<BallGroupItem>();

	public int useGroupIndex;

	public bool isUseGroup;

	private int createColorNums = 1;

	private List<int> colorTypeList = new List<int>();

	private List<BallGroup> randomValueList = new List<BallGroup>();

	private int createSpecialDisCount;

	private BallEffctType lastTrackBallType = BallEffctType.Empty;

	private List<BallEffctType> specialBallCreateList = new List<BallEffctType>
	{
		BallEffctType.BACK,
		BallEffctType.AIM,
		BallEffctType.STOP
	};

	public void InitRandData()
	{
		createColorNums = ZumaGameManager.GetInstance().GetZumaMapData().createColorNums;
		randomValueList.Clear();
		int num = 0;
		foreach (BallGroup group in ZumaGameManager.GetInstance().GetZumaMapData().groupList)
		{
			num += group.weight;
			BallGroup ballGroup = new BallGroup();
			ballGroup.weight = num;
			ballGroup.list = group.list;
			randomValueList.Add(ballGroup);
		}
		List<bool> useColorList = ZumaGameManager.GetInstance().GetZumaMapData().useColorList;
		colorTypeList.Clear();
		for (int i = 0; i < 8; i++)
		{
			if (useColorList[i])
			{
				colorTypeList.Add(i);
			}
		}
		SpawnSpeicalEffect();
	}

	public BallColorType SpawnBallStrategyColor()
	{
		if (!isUseGroup)
		{
			useGroupIndex = 0;
			int num = Random.Range(0, 1000);
			foreach (BallGroup randomValue in randomValueList)
			{
				if (num > randomValue.weight)
				{
					continue;
				}
				isUseGroup = true;
				useGroup = randomValue.list;
				for (int i = 0; i < useGroup.Count; i++)
				{
					useGroup[i].colorType = BallColorType.EmptyColor;
				}
				for (int j = 0; j < useGroup.Count; j++)
				{
					BallGroupItem ballGroupItem = useGroup[j];
					int colorIndex = ballGroupItem.colorIndex;
					if (useGroup[colorIndex] == null)
					{
						continue;
					}
					if (useGroup[colorIndex].colorType == BallColorType.EmptyColor)
					{
						useGroup[colorIndex].colorType = RandomColorType();
					}
					else if (j == useGroup.Count - 1)
					{
						int num2 = colorTypeList.IndexOf((int)useGroup[colorIndex].colorType);
						if (num2 != 0)
						{
							colorTypeList[0] = colorTypeList[0] ^ colorTypeList[num2];
							colorTypeList[num2] = colorTypeList[0] ^ colorTypeList[num2];
							colorTypeList[0] = colorTypeList[0] ^ colorTypeList[num2];
						}
					}
					ballGroupItem.colorType = useGroup[colorIndex].colorType;
				}
				break;
			}
		}
		colorType = SpawnBallByGroup();
		return colorType;
	}

	public BallColorType SpawnBallByGroup()
	{
		if (!isUseGroup)
		{
			return RandomColorType();
		}
		if (colorSpawnNum <= 0)
		{
			BallGroupItem ballGroupItem = useGroup[useGroupIndex];
			colorSpawnNum = ballGroupItem.nums;
			colorType = ballGroupItem.colorType;
			useGroupIndex++;
			if (useGroupIndex >= useGroup.Count)
			{
				isUseGroup = false;
			}
		}
		colorSpawnNum--;
		return colorType;
	}

	public BallColorType RandomColorType()
	{
		int index = Random.Range(1, createColorNums);
		colorTypeList[0] = colorTypeList[0] ^ colorTypeList[index];
		colorTypeList[index] = colorTypeList[0] ^ colorTypeList[index];
		colorTypeList[0] = colorTypeList[0] ^ colorTypeList[index];
		return (BallColorType)colorTypeList[0];
	}

	public BallEffctType SpawnSpeicalEffect()
	{
		if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.EndlessMapEffectC))
		{
			return BallEffctType.STOP;
		}
		if (ZumaGameManager.GetInstance().zumaEffectDataManager.GetEffectIsExist(ZumaEffectType.EndlessMapEffectD))
		{
			return BallEffctType.BACK;
		}
		int index = Random.Range(1, 3);
		BallEffctType value = specialBallCreateList[index];
		specialBallCreateList[index] = specialBallCreateList[0];
		specialBallCreateList[0] = value;
		return specialBallCreateList[0];
	}

	public BallEffctType SpawnBallStrategyEffect()
	{
		BallEffctType ballEffctType = BallEffctType.NORMAL;
		if (lastTrackBallType != BallEffctType.NORMAL && createSpecialDisCount >= 10 && createSpecialDisCount < 30)
		{
			if (Random.Range(0, 1000) <= 50)
			{
				ballEffctType = SpawnSpeicalEffect();
			}
		}
		else if (createSpecialDisCount >= 30)
		{
			ballEffctType = SpawnSpeicalEffect();
		}
		createSpecialDisCount++;
		if (ballEffctType != BallEffctType.NORMAL)
		{
			createSpecialDisCount = 0;
			lastTrackBallType = ballEffctType;
		}
		return ballEffctType;
	}
}
