using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("血色落雷", "Mixin", new string[] { "blood", "thunder", "trap" })]
public class ConfigMixinBloodThunder : ConfigMixin
{
	[SerializeField]
	public YooAssetReference[] bloodThunderEffectsID;

	public AllianceCondition allianceCondition;

	public WhereTargets whereTargets;

	public ConfigAction[] configActions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinBloodThunder(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		if (configActions != null)
		{
			ConfigAbility.CacheActionList(list, configActions, configAbility);
		}
	}

	public override void Precache(List<YooAssetReference> addlist)
	{
		if (bloodThunderEffectsID == null)
		{
			return;
		}
		for (int i = 0; i < bloodThunderEffectsID.Length; i++)
		{
			YooAssetReference yooAssetReference = bloodThunderEffectsID[i];
			if (yooAssetReference.RuntimeKeyIsValid())
			{
				addlist.Add(yooAssetReference);
			}
		}
	}
}
