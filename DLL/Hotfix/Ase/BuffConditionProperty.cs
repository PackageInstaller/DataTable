using System.Collections.Generic;

namespace Ase;

public class BuffConditionProperty : BuffConditionBase
{
	private string propertyKey;

	private CompareMethodType methodType;

	private float compareValue;

	public override BuffConditionType BuffConditionType => BuffConditionType.Property;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
		compareValue = Utility.Convert.StringToFloat(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{methodType},{compareValue}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return ComparePropertyValue();
	}

	private bool ComparePropertyValue()
	{
		return ConditionExtensions.CompareValueMethod(methodType, entityTarget.GetProperty(propertyKey), compareValue);
	}
}
