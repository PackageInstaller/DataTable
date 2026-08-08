using System.IO;
using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public abstract class WebResponse : MarshalByRefObject, ISerializable, IDisposable
{
	private bool m_IsCacheFresh;

	private bool m_IsFromCache;

	public virtual bool IsFromCache => m_IsFromCache;

	internal bool InternalSetFromCache
	{
		set
		{
			m_IsFromCache = value;
		}
	}

	internal virtual bool IsCacheFresh => m_IsCacheFresh;

	internal bool InternalSetIsCacheFresh
	{
		set
		{
			m_IsCacheFresh = value;
		}
	}

	public virtual bool IsMutuallyAuthenticated => false;

	public virtual long ContentLength
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
		set
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual string ContentType
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
		set
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual Uri ResponseUri
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual WebHeaderCollection Headers
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual bool SupportsHeaders => false;

	protected WebResponse()
	{
	}

	protected WebResponse(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected virtual void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
	}

	public virtual void Close()
	{
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposing)
		{
			return;
		}
		try
		{
			Close();
		}
		catch
		{
		}
	}

	public virtual Stream GetResponseStream()
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}
}
