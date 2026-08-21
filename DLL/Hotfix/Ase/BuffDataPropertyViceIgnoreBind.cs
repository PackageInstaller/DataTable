using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataPropertyViceIgnoreBind : BuffDataBase
{
	public string propertyKey;

	public string vicePropertyKey;

	public float ratio;

	public ChangeType changeType;

	public PropertyType propertyType;

	public PropertyType vicePropertyType;

	public bool clearVice;

	public override BuffOperationType EffectType => BuffOperationType.PropertyIgnoreBind;

	protected override int paramsMinCount => 7;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		vicePropertyKey = paramList[1];
		ratio = Utility.Convert.StringToFloat(paramList[2]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[3]);
		propertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[4]);
		vicePropertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[5]);
		clearVice = Utility.Convert.StringToBool(paramList[6]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{vicePropertyKey},{ratio},{changeType},{propertyType},{vicePropertyType},{clearVice}";
	}
}
