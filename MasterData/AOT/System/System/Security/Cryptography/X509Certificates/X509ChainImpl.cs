namespace System.Security.Cryptography.X509Certificates;

internal abstract class X509ChainImpl : IDisposable
{
	public abstract bool IsValid { get; }

	public abstract X509ChainElementCollection ChainElements { get; }

	public abstract X509ChainPolicy ChainPolicy { get; }

	protected void ThrowIfContextInvalid()
	{
		if (!IsValid)
		{
			throw X509Helper2.GetInvalidChainContextException();
		}
	}

	public abstract bool Build(X509Certificate2 certificate);

	public abstract void AddStatus(X509ChainStatusFlags errorCode);

	public abstract void Reset();

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	~X509ChainImpl()
	{
		Dispose(disposing: false);
	}
}
