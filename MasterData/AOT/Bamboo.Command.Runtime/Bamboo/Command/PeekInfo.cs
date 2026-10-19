using System;

namespace Bamboo.Command;

internal class PeekInfo : BasePeekInfo
{
	public Func<bool> Action;
}
internal class PeekInfo<T> : BasePeekInfo
{
	public Func<T, bool> Action;
}
internal class PeekInfo<T1, T2> : BasePeekInfo
{
	public Func<T1, T2, bool> Action;
}
internal class PeekInfo<T1, T2, T3> : BasePeekInfo
{
	public Func<T1, T2, T3, bool> Action;
}
