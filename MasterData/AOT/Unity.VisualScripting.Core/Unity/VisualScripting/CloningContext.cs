using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public sealed class CloningContext : IPoolable, IDisposable
{
	private bool disposed;

	public Dictionary<object, object> clonings { get; } = new Dictionary<object, object>(ReferenceEqualityComparer.Instance);

	public ICloner fallbackCloner { get; private set; }

	public bool tryPreserveInstances { get; private set; }

	void IPoolable.New()
	{
		disposed = false;
	}

	void IPoolable.Free()
	{
		disposed = true;
		clonings.Clear();
	}

	public void Dispose()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(ToString());
		}
		GenericPool<CloningContext>.Free(this);
	}

	public static CloningContext New(ICloner fallbackCloner, bool tryPreserveInstances)
	{
		CloningContext cloningContext = GenericPool<CloningContext>.New(() => new CloningContext());
		cloningContext.fallbackCloner = fallbackCloner;
		cloningContext.tryPreserveInstances = tryPreserveInstances;
		return cloningContext;
	}
}
