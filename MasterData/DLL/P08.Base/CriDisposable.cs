using System;

public abstract class CriDisposable : IDisposable
{
	public Guid guid;

	public CriDisposable()
	{
		guid = Guid.NewGuid();
	}

	public abstract void Dispose();
}
