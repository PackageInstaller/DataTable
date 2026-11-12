using System;
using TrueSync;

namespace AIScript.Utils;

public class SkillVariable
{
	public readonly int id;

	public FP cdMax;

	public FP cdInit;

	public FP releaseDistance;

	public FP trackTime;

	public readonly bool immBondage;

	public FP cdExpireTime;

	private Func<bool> _conditionFunc;

	public Func<bool> ConditionFunc => _conditionFunc;

	public SkillVariable(int id, FP cdMax, FP cdInit, FP releaseDistance, FP trackTime, bool immBondage, FP currentTime, Func<bool> conditionFunc = null)
	{
		this.id = id;
		this.cdMax = cdMax;
		this.cdInit = cdInit;
		this.releaseDistance = releaseDistance;
		this.trackTime = trackTime;
		this.immBondage = immBondage;
		cdExpireTime = currentTime + cdInit;
		if (conditionFunc != null)
		{
			_conditionFunc = conditionFunc;
		}
	}

	public void SetCondition(Func<bool> conditionFunc)
	{
		_conditionFunc = conditionFunc;
	}

	public void ResetExpireTime(FP currentTime)
	{
		cdExpireTime = currentTime + cdMax;
	}

	public void ClearExpireTime()
	{
		cdExpireTime = 0;
	}
}
