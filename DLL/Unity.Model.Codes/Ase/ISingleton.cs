using System;

namespace Ase;

public interface ISingleton : IDisposable
{
	void Register();

	void Destroy();

	bool IsDisposed();
}
