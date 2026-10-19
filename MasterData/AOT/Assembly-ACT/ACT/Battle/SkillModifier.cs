using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class SkillModifier : ISkillModifier
{
	[SerializeField]
	protected int skillId;

	[SerializeField]
	protected string key;

	public IDynamicFloat DynamicFloat;

	public int SkillId => skillId;

	public string Key => key;

	public float GetValue()
	{
		return DynamicFloat.GetFloat(skillId);
	}

	public void Init(Ability ability)
	{
	}
}
