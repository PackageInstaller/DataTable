using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class SkillDetailData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly int commandListDescLocal;

	public readonly int briefDescLocal;

	public readonly int detailDescLocal;

	public readonly int descTypeLocal;

	public readonly string skillGIFLocal = "";

	public readonly int skillPropertyDescLocal;

	public readonly int skillPropertyParamLocal;

	public readonly int skillLevelupPropertyDescLocal;

	public readonly int skillLevelupPropertyParamLocal;

	public readonly string abilityName = "";

	public readonly List<DetailFormat> detailDesc;

	public readonly string[] validParam = new string[0];

	public readonly string[] validParam1 = new string[0];

	public SkillDetailData(int id, int nameLocal, int commandListDescLocal, int briefDescLocal, int detailDescLocal, int descTypeLocal, string skillGIFLocal, int skillPropertyDescLocal, int skillPropertyParamLocal, int skillLevelupPropertyDescLocal, int skillLevelupPropertyParamLocal, string abilityName, List<DetailFormat> detailDesc, string[] validParam, string[] validParam1)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.commandListDescLocal = commandListDescLocal;
		this.briefDescLocal = briefDescLocal;
		this.detailDescLocal = detailDescLocal;
		this.descTypeLocal = descTypeLocal;
		this.skillGIFLocal = skillGIFLocal;
		this.skillPropertyDescLocal = skillPropertyDescLocal;
		this.skillPropertyParamLocal = skillPropertyParamLocal;
		this.skillLevelupPropertyDescLocal = skillLevelupPropertyDescLocal;
		this.skillLevelupPropertyParamLocal = skillLevelupPropertyParamLocal;
		this.abilityName = abilityName;
		this.detailDesc = detailDesc;
		this.validParam = validParam;
		this.validParam1 = validParam1;
	}
}
