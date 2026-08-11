using System.Globalization;
using System.IO;
using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public class FileWebResponse : WebResponse, ISerializable, ICloseEx
{
	private bool m_closed;

	private long m_contentLength;

	private FileAccess m_fileAccess;

	private WebHeaderCollection m_headers;

	private Stream m_stream;

	private Uri m_uri;

	public override WebHeaderCollection Headers
	{
		get
		{
			CheckDisposed();
			return m_headers;
		}
	}

	public override Uri ResponseUri
	{
		get
		{
			CheckDisposed();
			return m_uri;
		}
	}

	internal FileWebResponse(FileWebRequest request, Uri uri, FileAccess access, bool asyncHint)
	{
		try
		{
			m_fileAccess = access;
			if (access == FileAccess.Write)
			{
				m_stream = Stream.Null;
			}
			else
			{
				m_stream = new FileWebStream(request, uri.LocalPath, FileMode.Open, FileAccess.Read, FileShare.Read, 8192, asyncHint);
				m_contentLength = m_stream.Length;
			}
			m_headers = new WebHeaderCollection(WebHeaderCollectionType.FileWebResponse);
			m_headers.AddInternal("Content-Length", m_contentLength.ToString(NumberFormatInfo.InvariantInfo));
			m_headers.AddInternal("Content-Type", "application/octet-stream");
			m_uri = uri;
		}
		catch (Exception ex)
		{
			throw new WebException(ex.Message, ex, WebExceptionStatus.ConnectFailure, null);
		}
	}

	[Obsolete("Serialization is obsoleted for this type. http://go.microsoft.com/fwlink/?linkid=14202")]
	protected FileWebResponse(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
		m_headers = (WebHeaderCollection)serializationInfo.GetValue("headers", typeof(WebHeaderCollection));
		m_uri = (Uri)serializationInfo.GetValue("uri", typeof(Uri));
		m_contentLength = serializationInfo.GetInt64("contentLength");
		m_fileAccess = (FileAccess)serializationInfo.GetInt32("fileAccess");
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		serializationInfo.AddValue("headers", m_headers, typeof(WebHeaderCollection));
		serializationInfo.AddValue("uri", m_uri, typeof(Uri));
		serializationInfo.AddValue("contentLength", m_contentLength);
		serializationInfo.AddValue("fileAccess", m_fileAccess);
		base.GetObjectData(serializationInfo, streamingContext);
	}

	private void CheckDisposed()
	{
		if (m_closed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
	}

	public override void Close()
	{
		((ICloseEx)this).CloseEx(CloseExState.Normal);
	}

	void ICloseEx.CloseEx(CloseExState closeState)
	{
		try
		{
			if (m_closed)
			{
				return;
			}
			m_closed = true;
			Stream stream = m_stream;
			if (stream != null)
			{
				if (stream is ICloseEx)
				{
					((ICloseEx)stream).CloseEx(closeState);
				}
				else
				{
					stream.Close();
				}
				m_stream = null;
			}
		}
		finally
		{
		}
	}

	public override Stream GetResponseStream()
	{
		try
		{
			CheckDisposed();
		}
		finally
		{
		}
		return m_stream;
	}
}
