using System.IO;
using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public abstract class WebResponse : MarshalByRefObject, ISerializable, IDisposable
{
	private bool m_IsFromCache;

	public virtual bool IsFromCache => m_IsFromCache;

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
