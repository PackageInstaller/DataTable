using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionPropertyChangedFactor : BuffConditionBase, IPropertyChanged
{
	private string propertyKey;

	private ChangeType methodType;

	private float changedValue;

	private Ase.ECS.PropertyData property;

	private bool isCondition;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyChangedFactor;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		methodType = Utility.Convert.StringToEnum<ChangeType>(paramList[1]);
		changedValue = Utility.Convert.StringToFloat(paramList[2]);
		if (entityTarget == null)
		{
			LogWarning("当前目标不存在");
			return;
		}
		property = entityTarget.EntityViewModel.GetPropertyData(propertyKey);
		if (property == null)
		{
			LogWarning("当前属性不存在:" + propertyKey);
		}
		else
		{
			property.RegisterOnChangedCallback(this);
		}
	}

	protected override string OnGetDataString()
	{
		return $"{property},{methodType},{changedValue}";
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (changedEnum == PropertyChangedEnum.CurValue && delta != 0f && property.MaxValue != 0f && propertyName == property.PropertyName && !isCondition)
		{
			isCondition = ComparePropertyValue(delta / property.MaxValue);
		}
	}

	private PropertyChangedEnum GetPropertyChangedEnum(PropertyType propertyType)
	{
		return propertyType switch
		{
			PropertyType.Min => PropertyChangedEnum.MinValue, 
			PropertyType.Max => PropertyChangedEnum.MaxValue, 
			_ => PropertyChangedEnum.CurValue, 
		};
	}

	public override bool OnCheck(Buff buff = null)
	{
		return isCondition;
	}

	private bool ComparePropertyValue(float changed)
	{
		return ConditionExtensions.CompareValueMethod(methodType, changedValue, changed);
	}

	protected override void OnReset()
	{
		isCondition = false;
	}

	protected override void OnDispose()
	{
		property.RemoveOnChangedCallback(this);
		property = null;
		isCondition = false;
	}
}
