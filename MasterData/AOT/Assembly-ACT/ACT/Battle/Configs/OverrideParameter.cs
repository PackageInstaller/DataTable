using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct OverrideParameter<T>(T t)
{
	public T value = t;

	public bool isOverride = true;
}
