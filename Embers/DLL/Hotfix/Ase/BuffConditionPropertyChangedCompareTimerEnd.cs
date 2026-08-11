using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionPropertyChangedCompareTimerEnd : BuffConditionBase, IPropertyChangedBefore
{
	private string propertyKey;

	private CompareMethodType methodType;

	private float changedValue;

	private float timer;

	private Ase.ECS.PropertyData property;

	private bool isTimer;

	private float temp_time;

	private float initValue;

	private bool conditionVal;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyChangedCompareTimerEnd;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
		changedValue = Utility.Convert.StringToFloat(paramList[2]);
		timer = Utility.Convert.StringToFloat(paramList[3]);
		if (entityTarget == null)
		{
			LogWarning("当前目标不存在");
			return;
		}
		property = entityTarget.EntityViewModel.GetPropertyData(propertyKey);
		if (property == null)
		{
			LogWarning("当前属性不存在:" + propertyKey);
			return;
		}
		property.RegisterOnChangedBeforeCallback(this);
		initValue = property.CurValue;
		temp_time = 0f;
		isTimer = false;
		conditionVal = false;
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{methodType},{changedValue},{timer}";
	}

	public void OnPropertyChangedBefore(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (changedEnum == PropertyChangedEnum.CurValue && delta != 0f && !isTimer)
		{
			conditionVal = false;
			initValue = property.CurValue;
			temp_time = 0f;
			isTimer = true;
		}
	}

	public override void Update(float deltaTime)
	{
		base.Update(deltaTime);
		if (isTimer)
		{
			temp_time += deltaTime;
			if (temp_time >= timer)
			{
				isTimer = false;
				conditionVal = ComparePropertyValue();
			}
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return conditionVal;
	}

	private bool ComparePropertyValue()
	{
		return ConditionExtensions.CompareValueMethod(methodType, property.CurValue - initValue, changedValue);
	}

	protected override void OnReset()
	{
		if (conditionVal)
		{
			isTimer = false;
			conditionVal = false;
		}
	}

	protected override void OnDispose()
	{
		property.RemoveOnChangedBeforeCallback(this);
		property = null;
		isTimer = false;
	}
}
