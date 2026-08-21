using System;

namespace Cysharp.Threading.Tasks.Internal;

internal sealed class SingleAssignmentDisposable : IDisposable
{
	private readonly object gate = new object();

	private IDisposable current;

	private bool disposed;

	public bool IsDisposed
	{
		get
		{
			lock (gate)
			{
				return disposed;
			}
		}
	}

	public IDisposable Disposable
	{
		get
		{
			return current;
		}
		set
		{
			IDisposable disposable = null;
			bool flag;
			lock (gate)
			{
				flag = disposed;
				disposable = current;
				if (!flag)
				{
					if (value == null)
					{
						return;
					}
					current = value;
				}
			}
			if (flag && value != null)
			{
				value.Dispose();
			}
			else if (disposable != null)
			{
				throw new InvalidOperationException("Disposable is already set");
			}
		}
	}

	public void Dispose()
	{
		IDisposable disposable = null;
		lock (gate)
		{
			if (!disposed)
			{
				disposed = true;
				disposable = current;
				current = null;
			}
		}
		disposable?.Dispose();
	}
}
