using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataSkillBtnActive : BuffDataBase
{
	public HeroSkillTypeEnum[] heroSkillTypeEnums;

	public bool[] actives;

	public override BuffOperationType EffectType => BuffOperationType.SkillBtnActive;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count % 2 != 0)
		{
			LogWarning("参数数量错误");
			return;
		}
		int num = paramList.Count / 2;
		heroSkillTypeEnums = new HeroSkillTypeEnum[num];
		actives = new bool[num];
		for (int i = 0; i < num; i++)
		{
			heroSkillTypeEnums[i] = Utility.Convert.StringToEnum<HeroSkillTypeEnum>(paramList[i * 2]);
			actives[i] = Utility.Convert.StringToBool(paramList[i * 2 + 1]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		if (heroSkillTypeEnums.IsNullOrEmpty() || actives.IsNullOrEmpty())
		{
			return string.Empty;
		}
		if (heroSkillTypeEnums.Length != actives.Length)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{heroSkillTypeEnums[0]},{actives[0]}");
		for (int i = 1; i < heroSkillTypeEnums.Length; i++)
		{
			stringBuilder.Append($",{heroSkillTypeEnums[i]},{actives[i]}");
		}
		return stringBuilder.ToString();
	}
}
