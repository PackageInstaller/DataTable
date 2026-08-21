using System.IO;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Net;

[Serializable]
public class FileWebRequest : WebRequest, ISerializable
{
	private static WaitCallback s_GetRequestStreamCallback = GetRequestStreamCallback;

	private static WaitCallback s_GetResponseCallback = GetResponseCallback;

	private string m_connectionGroupName;

	private long m_contentLength;

	private ICredentials m_credentials;

	private FileAccess m_fileAccess;

	private WebHeaderCollection m_headers;

	private string m_method = "GET";

	private bool m_preauthenticate;

	private IWebProxy m_proxy;

	private ManualResetEvent m_readerEvent;

	private bool m_readPending;

	private WebResponse m_response;

	private Stream m_stream;

	private bool m_syncHint;

	private int m_timeout = 100000;

	private Uri m_uri;

	private bool m_writePending;

	private bool m_writing;

	private LazyAsyncResult m_WriteAResult;

	private LazyAsyncResult m_ReadAResult;

	private int m_Aborted;

	internal bool Aborted => m_Aborted != 0;

	public override string ConnectionGroupName
	{
		set
		{
			m_connectionGroupName = value;
		}
	}

	public override long ContentLength
	{
		get
		{
			return m_contentLength;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentException(global::SR.GetString("The Content-Length value must be greater than or equal to zero."), "value");
			}
			m_contentLength = value;
		}
	}

	public override string ContentType
	{
		set
		{
			m_headers["Content-Type"] = value;
		}
	}

	public override ICredentials Credentials
	{
		get
		{
			return m_credentials;
		}
		set
		{
			m_credentials = value;
		}
	}

	public override WebHeaderCollection Headers => m_headers;

	public override string Method
	{
		get
		{
			return m_method;
		}
		set
		{
			if (ValidationHelper.IsBlankString(value))
			{
				throw new ArgumentException(global::SR.GetString("Cannot set null or blank methods on request."), "value");
			}
			m_method = value;
		}
	}

	public override bool PreAuthenticate
	{
		set
		{
			m_preauthenticate = true;
		}
	}

	public override IWebProxy Proxy
	{
		get
		{
			return m_proxy;
		}
		set
		{
			m_proxy = value;
		}
	}

	public override int Timeout
	{
		get
		{
			return m_timeout;
		}
		set
		{
			if (value < 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", global::SR.GetString("Timeout can be only be set to 'System.Threading.Timeout.Infinite' or a value >= 0."));
			}
			m_timeout = value;
		}
	}

	public override Uri RequestUri => m_uri;

	public override bool UseDefaultCredentials
	{
		get
		{
			throw ExceptionHelper.PropertyNotSupportedException;
		}
	}

	internal FileWebRequest(Uri uri)
	{
		if ((object)uri.Scheme != Uri.UriSchemeFile)
		{
			throw new ArgumentOutOfRangeException("uri");
		}
		m_uri = uri;
		m_fileAccess = FileAccess.Read;
		m_headers = new WebHeaderCollection(WebHeaderCollectionType.FileWebRequest);
	}

	[Obsolete("Serialization is obsoleted for this type. http://go.microsoft.com/fwlink/?linkid=14202")]
	protected FileWebRequest(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
		m_headers = (WebHeaderCollection)serializationInfo.GetValue("headers", typeof(WebHeaderCollection));
		m_proxy = (IWebProxy)serializationInfo.GetValue("proxy", typeof(IWebProxy));
		m_uri = (Uri)serializationInfo.GetValue("uri", typeof(Uri));
		m_connectionGroupName = serializationInfo.GetString("connectionGroupName");
		m_method = serializationInfo.GetString("method");
		m_contentLength = serializationInfo.GetInt64("contentLength");
		m_timeout = serializationInfo.GetInt32("timeout");
		m_fileAccess = (FileAccess)serializationInfo.GetInt32("fileAccess");
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		serializationInfo.AddValue("headers", m_headers, typeof(WebHeaderCollection));
		serializationInfo.AddValue("proxy", m_proxy, typeof(IWebProxy));
		serializationInfo.AddValue("uri", m_uri, typeof(Uri));
		serializationInfo.AddValue("connectionGroupName", m_connectionGroupName);
		serializationInfo.AddValue("method", m_method);
		serializationInfo.AddValue("contentLength", m_contentLength);
		serializationInfo.AddValue("timeout", m_timeout);
		serializationInfo.AddValue("fileAccess", m_fileAccess);
		serializationInfo.AddValue("preauthenticate", value: false);
		base.GetObjectData(serializationInfo, streamingContext);
	}

	public override IAsyncResult BeginGetRequestStream(AsyncCallback callback, object state)
	{
		try
		{
			if (Aborted)
			{
				throw ExceptionHelper.RequestAbortedException;
			}
			if (!CanGetRequestStream())
			{
				throw new ProtocolViolationException(global::SR.GetString("Cannot send a content-body with this verb-type."));
			}
			if (m_response != null)
			{
				throw new InvalidOperationException(global::SR.GetString("This operation cannot be performed after the request has been submitted."));
			}
			lock (this)
			{
				if (m_writePending)
				{
					throw new InvalidOperationException(global::SR.GetString("Cannot re-call BeginGetRequestStream/BeginGetResponse while a previous call is still in progress."));
				}
				m_writePending = true;
			}
			m_ReadAResult = new LazyAsyncResult(this, state, callback);
			ThreadPool.QueueUserWorkItem(s_GetRequestStreamCallback, m_ReadAResult);
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
		return m_ReadAResult;
	}

	public override IAsyncResult BeginGetResponse(AsyncCallback callback, object state)
	{
		try
		{
			if (Aborted)
			{
				throw ExceptionHelper.RequestAbortedException;
			}
			lock (this)
			{
				if (m_readPending)
				{
					throw new InvalidOperationException(global::SR.GetString("Cannot re-call BeginGetRequestStream/BeginGetResponse while a previous call is still in progress."));
				}
				m_readPending = true;
			}
			m_WriteAResult = new LazyAsyncResult(this, state, callback);
			ThreadPool.QueueUserWorkItem(s_GetResponseCallback, m_WriteAResult);
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
		return m_WriteAResult;
	}

	private bool CanGetRequestStream()
	{
		return !KnownHttpVerb.Parse(m_method).ContentBodyNotAllowed;
	}

	public override Stream EndGetRequestStream(IAsyncResult asyncResult)
	{
		try
		{
			LazyAsyncResult lazyAsyncResult = asyncResult as LazyAsyncResult;
			if (asyncResult == null || lazyAsyncResult == null)
			{
				throw (asyncResult == null) ? new ArgumentNullException("asyncResult") : new ArgumentException(global::SR.GetString("The AsyncResult is not valid."), "asyncResult");
			}
			object obj = lazyAsyncResult.InternalWaitForCompletion();
			if (obj is Exception)
			{
				throw (Exception)obj;
			}
			Stream result = (Stream)obj;
			m_writePending = false;
			return result;
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
	}

	public override WebResponse EndGetResponse(IAsyncResult asyncResult)
	{
		try
		{
			LazyAsyncResult lazyAsyncResult = asyncResult as LazyAsyncResult;
			if (asyncResult == null || lazyAsyncResult == null)
			{
				throw (asyncResult == null) ? new ArgumentNullException("asyncResult") : new ArgumentException(global::SR.GetString("The AsyncResult is not valid."), "asyncResult");
			}
			object obj = lazyAsyncResult.InternalWaitForCompletion();
			if (obj is Exception)
			{
				throw (Exception)obj;
			}
			WebResponse result = (WebResponse)obj;
			m_readPending = false;
			return result;
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
	}

	public override Stream GetRequestStream()
	{
		IAsyncResult asyncResult;
		try
		{
			asyncResult = BeginGetRequestStream(null, null);
			if (Timeout != -1 && !asyncResult.IsCompleted && (!asyncResult.AsyncWaitHandle.WaitOne(Timeout, exitContext: false) || !asyncResult.IsCompleted))
			{
				if (m_stream != null)
				{
					m_stream.Close();
				}
				throw new WebException(NetRes.GetWebStatusString(WebExceptionStatus.Timeout), WebExceptionStatus.Timeout);
			}
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
		return EndGetRequestStream(asyncResult);
	}

	public override WebResponse GetResponse()
	{
		m_syncHint = true;
		IAsyncResult asyncResult;
		try
		{
			asyncResult = BeginGetResponse(null, null);
			if (Timeout != -1 && !asyncResult.IsCompleted && (!asyncResult.AsyncWaitHandle.WaitOne(Timeout, exitContext: false) || !asyncResult.IsCompleted))
			{
				if (m_response != null)
				{
					m_response.Close();
				}
				throw new WebException(NetRes.GetWebStatusString(WebExceptionStatus.Timeout), WebExceptionStatus.Timeout);
			}
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
		return EndGetResponse(asyncResult);
	}

	private static void GetRequestStreamCallback(object state)
	{
		LazyAsyncResult lazyAsyncResult = (LazyAsyncResult)state;
		FileWebRequest fileWebRequest = (FileWebRequest)lazyAsyncResult.AsyncObject;
		try
		{
			if (fileWebRequest.m_stream == null)
			{
				fileWebRequest.m_stream = new FileWebStream(fileWebRequest, fileWebRequest.m_uri.LocalPath, FileMode.Create, FileAccess.Write, FileShare.Read);
				fileWebRequest.m_fileAccess = FileAccess.Write;
				fileWebRequest.m_writing = true;
			}
		}
		catch (Exception ex)
		{
			Exception result = new WebException(ex.Message, ex);
			lazyAsyncResult.InvokeCallback(result);
			return;
		}
		lazyAsyncResult.InvokeCallback(fileWebRequest.m_stream);
	}

	private static void GetResponseCallback(object state)
	{
		LazyAsyncResult lazyAsyncResult = (LazyAsyncResult)state;
		FileWebRequest fileWebRequest = (FileWebRequest)lazyAsyncResult.AsyncObject;
		if (fileWebRequest.m_writePending || fileWebRequest.m_writing)
		{
			lock (fileWebRequest)
			{
				if (fileWebRequest.m_writePending || fileWebRequest.m_writing)
				{
					fileWebRequest.m_readerEvent = new ManualResetEvent(initialState: false);
				}
			}
		}
		if (fileWebRequest.m_readerEvent != null)
		{
			fileWebRequest.m_readerEvent.WaitOne();
		}
		try
		{
			if (fileWebRequest.m_response == null)
			{
				fileWebRequest.m_response = new FileWebResponse(fileWebRequest, fileWebRequest.m_uri, fileWebRequest.m_fileAccess, !fileWebRequest.m_syncHint);
			}
		}
		catch (Exception ex)
		{
			Exception result = new WebException(ex.Message, ex);
			lazyAsyncResult.InvokeCallback(result);
			return;
		}
		lazyAsyncResult.InvokeCallback(fileWebRequest.m_response);
	}

	internal void UnblockReader()
	{
		lock (this)
		{
			if (m_readerEvent != null)
			{
				m_readerEvent.Set();
			}
		}
		m_writing = false;
	}

	public override void Abort()
	{
		_ = Logging.On;
		try
		{
			if (Interlocked.Increment(ref m_Aborted) != 1)
			{
				return;
			}
			LazyAsyncResult readAResult = m_ReadAResult;
			LazyAsyncResult writeAResult = m_WriteAResult;
			WebException result = new WebException(NetRes.GetWebStatusString("net_requestaborted", WebExceptionStatus.RequestCanceled), WebExceptionStatus.RequestCanceled);
			Stream stream = m_stream;
			if (readAResult != null && !readAResult.IsCompleted)
			{
				readAResult.InvokeCallback(result);
			}
			if (writeAResult != null && !writeAResult.IsCompleted)
			{
				writeAResult.InvokeCallback(result);
			}
			if (stream != null)
			{
				if (stream is ICloseEx)
				{
					((ICloseEx)stream).CloseEx(CloseExState.Abort);
				}
				else
				{
					stream.Close();
				}
			}
			if (m_response != null)
			{
				((ICloseEx)m_response).CloseEx(CloseExState.Abort);
			}
		}
		catch (Exception)
		{
			_ = Logging.On;
			throw;
		}
		finally
		{
		}
	}
}
