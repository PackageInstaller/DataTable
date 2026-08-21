using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using Unity;

namespace System;

[Serializable]
[ComVisible(false)]
public sealed class ActivationContext : IDisposable, ISerializable
{
	private ApplicationIdentity _appid;

	private bool _disposed;

	public ApplicationIdentity Identity => _appid;

	~ActivationContext()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		if (_disposed)
		{
			_disposed = true;
		}
	}

	[MonoTODO("Missing serialization support")]
	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
	}

	internal ActivationContext()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
