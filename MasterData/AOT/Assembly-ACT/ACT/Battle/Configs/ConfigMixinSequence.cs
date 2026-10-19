using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("序列效果", "Mixin", new string[] { "sequence" })]
public class ConfigMixinSequence : ConfigMixin
{
	[Serializable]
	public class MixinSequenceElement
	{
		public ConfigFunction<float> delay = new ConstFloat();

		public ConfigAction[] actions;
	}

	public bool loop;

	public bool randomOrder;

	public int randomExecuteCount;

	[SerializeReference]
	public MixinSequenceElement[] elements;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSequence(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		if (elements != null)
		{
			MixinSequenceElement[] array = elements;
			foreach (MixinSequenceElement mixinSequenceElement in array)
			{
				ConfigAbility.CacheActionList(list, mixinSequenceElement.actions, configAbility);
			}
		}
	}
}
