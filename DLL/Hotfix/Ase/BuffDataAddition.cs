using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataAddition : BuffDataBase
{
	public bool isGlobalAddition;

	public AdditionType additionType;

	public AdditionKind additionKind;

	public InputOptionEnum skillTypeEnum;

	public float addition;

	public override BuffOperationType EffectType => BuffOperationType.Addition;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		isGlobalAddition = Utility.Convert.StringToBool(paramList[0]);
		additionType = Utility.Convert.StringToEnum<AdditionType>(paramList[1]);
		additionKind = Utility.Convert.StringToEnum<AdditionKind>(paramList[2]);
		skillTypeEnum = Utility.Convert.StringToEnum<InputOptionEnum>(paramList[3]);
		addition = Utility.Convert.StringToFloat(paramList[4]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{isGlobalAddition},{additionType},{additionKind},{skillTypeEnum},{addition}";
	}
}
