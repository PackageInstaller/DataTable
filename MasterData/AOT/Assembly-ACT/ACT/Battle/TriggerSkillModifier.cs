using System;
using ACT.Core;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class TriggerSkillModifier : ISkillModifier
{
	[SerializeField]
	protected string key;

	protected int skillId;

	public IDynamicFloat DynamicFloat;

	public int TriggerId { get; set; }

	public int SkillId
	{
		get
		{
			if (RuntimeConfigs.data.rogueTriggerCards.TryGetValue(TriggerId, out var value))
			{
				return value.skillid;
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("错误的使用了TriggerSkillModifier");
			}
			return -1;
		}
	}

	public string Key => key;

	public float GetValue()
	{
		return DynamicFloat.GetFloat(SkillId);
	}

	public void Init(Ability ability)
	{
		TriggerId = ability.rogueTrigger;
	}
}
