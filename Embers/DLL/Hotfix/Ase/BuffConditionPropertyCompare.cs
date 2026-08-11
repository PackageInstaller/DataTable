using System.Collections.Generic;

namespace Ase;

public class BuffConditionPropertyCompare : BuffConditionBase
{
	private string propertyKey1;

	private string propertyKey2;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyCompare;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey1 = paramList[0];
		propertyKey2 = paramList[1];
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey1},{propertyKey2},{methodType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return ComparePropertyValue();
	}

	private bool ComparePropertyValue()
	{
		return ConditionExtensions.CompareValueMethod(methodType, entityTarget.GetProperty(propertyKey1), entityTarget.GetProperty(propertyKey2));
	}
}
