using System;

namespace Ase.ECS;

[Serializable]
public class BuffInfo
{
	public int id;

	public string duration;

	public string cooling;

	public string desc;

	private float limitTime;

	private float maxLimitTime;

	private float coolingTime;

	private float maxCoolingTime;

	private string LimitTime
	{
		get
		{
			if (maxLimitTime != -1f)
			{
				return $"{limitTime:F2}/{maxLimitTime:F2}";
			}
			return "Loop";
		}
	}

	private string CoolingTime
	{
		get
		{
			if (maxCoolingTime != 0f)
			{
				return $"{coolingTime:F2}/{maxCoolingTime:F2}";
			}
			return "None";
		}
	}

	public BuffInfo(Buff buff)
	{
		id = buff.BuffId;
		limitTime = buff.CurLifeTime;
		maxLimitTime = buff.MaxLifeTime;
		maxCoolingTime = buff.RepeatTime;
		desc = buff.Desc;
		duration = LimitTime;
		cooling = CoolingTime;
	}
}
