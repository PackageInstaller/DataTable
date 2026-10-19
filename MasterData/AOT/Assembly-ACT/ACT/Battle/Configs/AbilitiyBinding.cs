using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct AbilitiyBinding
{
	public int skillId;

	public bool ingoreWhenNoSkill;

	public string[] abilitiyNames;
}
