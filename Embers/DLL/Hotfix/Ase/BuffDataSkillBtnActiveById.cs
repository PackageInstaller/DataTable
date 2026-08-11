using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataSkillBtnActiveById : BuffDataBase
{
	public int[] skillIds;

	public bool[] actives;

	public override BuffOperationType EffectType => BuffOperationType.SkillBtnActiveById;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count % 2 != 0)
		{
			LogWarning("参数数量错误");
			return;
		}
		int num = paramList.Count / 2;
		skillIds = new int[num];
		actives = new bool[num];
		for (int i = 0; i < num; i++)
		{
			skillIds[i] = Utility.Convert.StringToInt(paramList[i * 2]);
			actives[i] = Utility.Convert.StringToBool(paramList[i * 2 + 1]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		if (skillIds.IsNullOrEmpty() || actives.IsNullOrEmpty())
		{
			return string.Empty;
		}
		if (skillIds.Length != actives.Length)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{skillIds[0]},{actives[0]}");
		for (int i = 1; i < skillIds.Length; i++)
		{
			stringBuilder.Append($",{skillIds[i]},{actives[i]}");
		}
		return stringBuilder.ToString();
	}
}
