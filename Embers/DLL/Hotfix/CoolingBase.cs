using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

public class CoolingBase : ViewModelBase
{
	protected BaseEntity entity;

	protected float currentParamValue;

	protected float releaseParamValue;

	protected bool isConsumeCondition;

	protected int Option;

	protected bool enoughCondition = true;

	public float CurrentParamValue
	{
		get
		{
			return currentParamValue;
		}
		protected set
		{
			Set(ref currentParamValue, value, "CurrentParamValue");
		}
	}

	public float ReleaseParamValue
	{
		get
		{
			return releaseParamValue;
		}
		protected set
		{
			Set(ref releaseParamValue, value, "ReleaseParamValue");
		}
	}

	public BaseEntity Entity => entity;

	public bool IsConsumeCondition => isConsumeCondition;

	public CoolingBase(string[] param, bool isConsumeCondition, BaseEntity baseEntity)
	{
		entity = baseEntity;
		if (param != null && param.Length != 0)
		{
			this.isConsumeCondition = isConsumeCondition;
			if (!isConsumeCondition)
			{
				Option = int.Parse(param[2]);
			}
		}
	}

	public virtual bool Check()
	{
		return false;
	}

	public virtual void Release()
	{
	}

	public virtual void Update()
	{
	}

	public virtual void Cultivate(CoolingBase coolingBase)
	{
	}

	protected bool ReleaseOption(float value)
	{
		return Option switch
		{
			1 => Math.Abs(value - ReleaseParamValue) < 0.001f, 
			2 => value > ReleaseParamValue, 
			3 => value < ReleaseParamValue, 
			4 => value >= ReleaseParamValue, 
			5 => value <= ReleaseParamValue, 
			6 => Math.Abs(value - ReleaseParamValue) > 0.001f, 
			_ => false, 
		};
	}

	public virtual string NotEnoughConditionText(List<string> tipTexts)
	{
		return string.Empty;
	}
}
