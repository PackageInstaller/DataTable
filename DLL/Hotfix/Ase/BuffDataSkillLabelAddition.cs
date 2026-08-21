using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataSkillLabelAddition : BuffDataBase
{
	public ObserverConditionParams[] skillLabelParams;

	public AdditionKind additionKind;

	public float addition;

	public override BuffOperationType EffectType => BuffOperationType.SkillLabelAddition;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		skillLabelParams = new ObserverConditionParams[paramList.Count - 2];
		for (int i = 0; i < paramList.Count - 2; i++)
		{
			skillLabelParams[i] = new ObserverConditionParams(paramList[i]);
		}
		int index = paramList.Count - 2;
		additionKind = Utility.Convert.StringToEnum<AdditionKind>(paramList[index]);
		index = paramList.Count - 1;
		addition = Utility.Convert.StringToFloat(paramList[index]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		if (skillLabelParams.IsNullOrEmpty())
		{
			return "Null";
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(skillLabelParams[0].OriginString);
		for (int i = 1; i < skillLabelParams.Length; i++)
		{
			stringBuilder.Append("," + skillLabelParams[i].OriginString);
		}
		return $"{stringBuilder.ToString()},{additionKind},{addition}";
	}
}
