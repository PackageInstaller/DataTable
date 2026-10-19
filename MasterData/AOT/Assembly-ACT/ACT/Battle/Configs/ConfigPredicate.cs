using System;

namespace ACT.Battle.Configs;

[Serializable]
public abstract class ConfigPredicate
{
	public bool Inverse;

	public abstract bool Check(ActionMemory memory);
}
