using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionPropertyChanged : BuffConditionBase, IPropertyChanged
{
	private string propertyKey;

	private ChangeType methodType;

	private float changedValue;

	private PropertyType changedEnum;

	private Ase.ECS.PropertyData property;

	private bool isCondition;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyChanged;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		methodType = Utility.Convert.StringToEnum<ChangeType>(paramList[1]);
		changedValue = Utility.Convert.StringToFloat(paramList[2]);
		changedEnum = ((paramList.Count > 3) ? Utility.Convert.StringToEnum<PropertyType>(paramList[3]) : PropertyType.Cur);
		if (entityTarget != null)
		{
			property = entityTarget.EntityViewModel.GetPropertyData(propertyKey);
			if (property != null)
			{
				property.RegisterOnChangedCallback(this);
			}
		}
	}

	protected override string OnGetDataString()
	{
		return $"{property},{methodType},{changedValue},{changedEnum}";
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == property.PropertyName && GetPropertyChangedEnum(this.changedEnum) == changedEnum && !isCondition)
		{
			isCondition = ComparePropertyValue(delta);
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
