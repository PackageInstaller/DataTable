using System;
using System.Collections.Generic;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class ConfigMixin
{
	public abstract BaseAbilityMixin CreateInst(Ability ab, byte index);

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
	}

	public virtual void Precache(List<YooAssetReference> addlist)
	{
	}
}
