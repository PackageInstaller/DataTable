using System;
using System.Collections.Generic;
using Sirenix.Serialization;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class ConfigAction
{
	[NonSerialized]
	public int cacheIndex;

	[OdinSerialize]
	private AbilityAuth cAuth;

	public virtual FindTargetResult.TargetSourceType VaildTagetSourceTypeMask => ~FindTargetResult.TargetSourceType.Damageable;

	protected virtual AbilityAuth defaultAuth => AbilityAuth.Server;

	public AbilityAuth auth
	{
		get
		{
			if (cAuth != AbilityAuth.Inherit)
			{
				return cAuth;
			}
			return defaultAuth;
		}
	}

	public abstract void Do(ActionMemory memory);

	public void CheckDo(ActionMemory memory)
	{
		if ((memory.target.targetSourceType & VaildTagetSourceTypeMask) != 0)
		{
			Do(memory);
		}
	}

	public virtual void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}

	public virtual void Precache(List<YooAssetReference> addlist)
	{
	}

	public virtual void CollectEffectPrewarm(EffectPrewarmCollector collector, ConfigSkinBattleMapping mapping = null)
	{
	}
}
