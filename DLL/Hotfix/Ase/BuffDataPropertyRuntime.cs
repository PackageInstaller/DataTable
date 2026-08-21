using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataPropertyRuntime : BuffDataBase
{
	public BuffRuntimeEnum modifyToRuntimeEnum;

	public string modifyToPropertykey;

	public PropertyType modifyToPropertyType;

	public BuffRuntimeEnum modifyFromRuntimeEnum;

	public string modifyFromPropertykey;

	public PropertyType modifyFromPropertyType;

	public ChangeType changeType;

	public NumberType numberType;

	public float value;

	public float product;

	public float limitMax;

	public override BuffOperationType EffectType => BuffOperationType.PropertyRuntime;

	protected override int paramsMinCount => 11;

	protected override void OnInit(List<string> paramList)
	{
		modifyToRuntimeEnum = Utility.Convert.StringToEnum<BuffRuntimeEnum>(paramList[0]);
		modifyToPropertykey = paramList[1];
		modifyToPropertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[2]);
		modifyFromRuntimeEnum = Utility.Convert.StringToEnum<BuffRuntimeEnum>(paramList[3]);
		modifyFromPropertykey = paramList[4];
		modifyFromPropertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[5]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[6]);
		numberType = Utility.Convert.StringToEnum<NumberType>(paramList[7]);
		value = Utility.Convert.StringToFloat(paramList[8]);
		product = Utility.Convert.StringToFloat(paramList[9]);
		limitMax = Utility.Convert.StringToFloat(paramList[10]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{modifyToRuntimeEnum},{modifyToPropertykey},{modifyToPropertyType},{modifyFromRuntimeEnum},{modifyFromPropertykey},{modifyFromPropertyType},{changeType},{numberType},{value},{product},{limitMax}";
	}
}
