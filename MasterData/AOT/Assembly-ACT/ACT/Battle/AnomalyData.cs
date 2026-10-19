using System;
using Bamboo.ECS;

namespace ACT.Battle;

public class AnomalyData
{
	public bool isAnomaly;

	public AnomalyType currAnomaly = AnomalyType.count;

	public Action<AnomalyType> isFull;

	public Action<AnomalyType, Entity> isOver;

	public bool[] isShowUI = new bool[2];

	public int[] anomalyValue = new int[2];

	public string[] anomalyAbilities = new string[2];

	public Action[] onValueChange = new Action[2];

	internal void Reset()
	{
		isAnomaly = false;
		currAnomaly = AnomalyType.count;
		for (int i = 0; i < 2; i++)
		{
			isShowUI[i] = false;
			anomalyValue[i] = 0;
			anomalyAbilities[i] = null;
			isFull = null;
			isOver = null;
			onValueChange[i] = null;
		}
	}
}
