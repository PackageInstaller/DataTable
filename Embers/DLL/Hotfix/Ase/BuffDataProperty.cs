using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataProperty : BuffDataBase
{
	public string propertyKey;

	public float propertyValue;

	public ChangeType changeType;

	public PropertyType propertyType;

	public override BuffOperationType EffectType => BuffOperationType.Property;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		propertyValue = Utility.Convert.StringToFloat(paramList[1]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[2]);
		propertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[3]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{propertyValue},{changeType},{propertyType}";
	}
}
