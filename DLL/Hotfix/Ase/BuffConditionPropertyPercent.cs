using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionPropertyPercent : BuffConditionBase
{
	protected Ase.ECS.PropertyData propertyData;

	private string propertyKey;

	private float compareValue;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyPercent;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		compareValue = Utility.Convert.StringToFloat(paramList[1]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
		propertyData = entityTarget.GetPropertyDataOrCreate(propertyKey);
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{compareValue},{methodType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return ComparePropertyValue();
	}

	private bool ComparePropertyValue()
	{
		return ConditionExtensions.CompareValueMethod(methodType, propertyData.ScaleValue, compareValue);
	}
}
