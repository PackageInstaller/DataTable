using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataPropertyConvert : BuffDataBase
{
	public string mainPropertyKey;

	public PropertyType mainPropertyType;

	public string deputyPropertyKey;

	public PropertyType deputyPropertyType;

	public ChangeType changeType;

	public float value;

	public float min;

	public float max;

	public override BuffOperationType EffectType => BuffOperationType.PropertyConvert;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		mainPropertyKey = paramList[0];
		mainPropertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[1]);
		deputyPropertyKey = paramList[2];
		deputyPropertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[3]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[4]);
		value = Utility.Convert.StringToFloat(paramList[5]);
		min = Utility.Convert.StringToFloat(paramList[6]);
		max = Utility.Convert.StringToFloat(paramList[7]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{mainPropertyKey},{mainPropertyType},{deputyPropertyKey},{deputyPropertyType},{changeType},{value},{min},{max}";
	}
}
