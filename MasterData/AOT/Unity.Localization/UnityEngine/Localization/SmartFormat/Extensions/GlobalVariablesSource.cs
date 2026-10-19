using System;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
[Obsolete("Please use PersistentVariablesSource instead (UnityUpgradable) -> PersistentVariablesSource")]
public class GlobalVariablesSource : PersistentVariablesSource
{
	public GlobalVariablesSource(SmartFormatter formatter)
		: base(formatter)
	{
	}
}
