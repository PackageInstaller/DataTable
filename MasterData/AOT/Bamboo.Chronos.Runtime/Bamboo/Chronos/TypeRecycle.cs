using System;
using Bamboo.Pool;

namespace Bamboo.Chronos;

internal abstract class TypeRecycle : IRecycle
{
	public abstract Type Type { get; }

	public bool IsRecycled { get; set; }

	public abstract void Recycle();
}
