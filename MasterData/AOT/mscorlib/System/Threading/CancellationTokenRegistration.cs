using System.Threading.Tasks;

namespace System.Threading;

public readonly struct CancellationTokenRegistration : IEquatable<CancellationTokenRegistration>, IDisposable, IAsyncDisposable
{
	private readonly CancellationCallbackInfo m_callbackInfo;

	private readonly SparselyPopulatedArrayAddInfo<CancellationCallbackInfo> m_registrationInfo;

	public CancellationToken Token => m_callbackInfo?.CancellationTokenSource.Token ?? default(CancellationToken);

	internal CancellationTokenRegistration(CancellationCallbackInfo callbackInfo, SparselyPopulatedArrayAddInfo<CancellationCallbackInfo> registrationInfo)
	{
		m_callbackInfo = callbackInfo;
		m_registrationInfo = registrationInfo;
	}

	public bool Unregister()
	{
		if (m_registrationInfo.Source == null)
		{
			return false;
		}
		if (m_registrationInfo.Source.SafeAtomicRemove(m_registrationInfo.Index, m_callbackInfo) != m_callbackInfo)
		{
			return false;
		}
		return true;
	}

	public void Dispose()
	{
		bool flag = Unregister();
		CancellationCallbackInfo callbackInfo = m_callbackInfo;
		if (callbackInfo != null)
		{
			CancellationTokenSource cancellationTokenSource = callbackInfo.CancellationTokenSource;
			if (cancellationTokenSource.IsCancellationRequested && !cancellationTokenSource.IsCancellationCompleted && !flag && cancellationTokenSource.ThreadIDExecutingCallbacks != Environment.CurrentManagedThreadId)
			{
				cancellationTokenSource.WaitForCallbackToComplete(m_callbackInfo);
			}
		}
	}

	public static bool operator ==(CancellationTokenRegistration left, CancellationTokenRegistration right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CancellationTokenRegistration left, CancellationTokenRegistration right)
	{
		return !left.Equals(right);
	}

	public override bool Equals(object obj)
	{
		if (obj is CancellationTokenRegistration)
		{
			return Equals((CancellationTokenRegistration)obj);
		}
		return false;
	}

	public bool Equals(CancellationTokenRegistration other)
	{
		if (m_callbackInfo == other.m_callbackInfo && m_registrationInfo.Source == other.m_registrationInfo.Source)
		{
			return m_registrationInfo.Index == other.m_registrationInfo.Index;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (m_registrationInfo.Source != null)
		{
			return m_registrationInfo.Source.GetHashCode() ^ m_registrationInfo.Index.GetHashCode();
		}
		return m_registrationInfo.Index.GetHashCode();
	}

	public ValueTask DisposeAsync()
	{
		Dispose();
		return new ValueTask(Task.FromResult<object>(null));
	}
}
