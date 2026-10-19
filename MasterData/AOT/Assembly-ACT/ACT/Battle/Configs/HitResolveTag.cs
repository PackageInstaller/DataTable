using System;

namespace ACT.Battle.Configs;

[Flags]
public enum HitResolveTag
{
	None = 0,
	IgnoreInvincibility = 1
}
