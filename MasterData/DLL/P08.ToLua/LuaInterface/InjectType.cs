using System;

namespace LuaInterface;

[Flags]
public enum InjectType
{
	None = 0,
	After = 1,
	Before = 2,
	Replace = 4,
	ReplaceWithPreInvokeBase = 8,
	ReplaceWithPostInvokeBase = 0x10
}
