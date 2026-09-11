using System;

namespace LuaInterface;

[AttributeUsage(AttributeTargets.Method)]
public sealed class LuaRenameAttribute : Attribute
{
	public string Name;
}
