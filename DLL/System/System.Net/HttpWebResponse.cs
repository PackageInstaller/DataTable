using System.IO;
using System.IO.Compression;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Net;

[Serializable]
public class HttpWebResponse : WebResponse, ISerializable, IDisposable
{
	private Uri uri;

	private WebHeaderCollection webHeaders;

	private CookieCollection cookieCollection;

	private string method;

	private Version version;

	private HttpStatusCode statusCode;

	private string statusDescription;

	private long contentLength;

	private string contentType;

	private CookieContainer cookie_container;

	private bool disposed;

	private Stream stream;

	public override WebHeaderCollection Headers => webHeaders;

	public override Uri ResponseUri
	{
		get
		{
			CheckDisposed();
			return uri;
		}
	}

	public virtual HttpStatusCode StatusCode => statusCode;

	public virtual string StatusDescription
	{
		get
		{
			CheckDisposed();
			return statusDescription;
		}
	}

	public HttpWebResponse()
	{
	}

	internal HttpWebResponse(Uri uri, string method, HttpStatusCode status, WebHeaderCollection headers)
	{
		this.uri = uri;
		this.method = method;
		statusCode = status;
		statusDescription = HttpStatusDescription.Get(status);
		webHeaders = headers;
		version = HttpVersion.Version10;
		contentLength = -1L;
	}

	internal HttpWebResponse(Uri uri, string method, WebResponseStream stream, CookieContainer container)
	{
		this.uri = uri;
		this.method = method;
		this.stream = stream;
		webHeaders = stream.Headers ?? new WebHeaderCollection();
		version = stream.Version;
		statusCode = stream.StatusCode;
		statusDescription = stream.StatusDescription ?? HttpStatusDescription.Get(statusCode);
		contentLength = -1L;
		try
		{
			string text = webHeaders["Content-Length"];
			if (string.IsNullOrEmpty(text) || !long.TryParse(text, out contentLength))
			{
				contentLength = -1L;
			}
		}
		catch (Exception)
		{
			contentLength = -1L;
		}
		if (container != null)
		{
			cookie_container = container;
			FillCookies();
		}
		string text2 = webHeaders["Content-Encoding"];
		if (text2 == "gzip" && (stream.Request.AutomaticDecompression & DecompressionMethods.GZip) != DecompressionMethods.None)
		{
			this.stream = new GZipStream(stream, CompressionMode.Decompress);
			webHeaders.Remove(HttpRequestHeader.ContentEncoding);
		}
		else if (text2 == "deflate" && (stream.Request.AutomaticDecompression & DecompressionMethods.Deflate) != DecompressionMethods.None)
		{
			this.stream = new DeflateStream(stream, CompressionMode.Decompress);
			webHeaders.Remove(HttpRequestHeader.ContentEncoding);
		}
	}

	[Obsolete("Serialization is obsoleted for this type", false)]
	protected HttpWebResponse(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		uri = (Uri)serializationInfo.GetValue("uri", typeof(Uri));
		contentLength = serializationInfo.GetInt64("contentLength");
		contentType = serializationInfo.GetString("contentType");
		method = serializationInfo.GetString("method");
		statusDescription = serializationInfo.GetString("statusDescription");
		cookieCollection = (CookieCollection)serializationInfo.GetValue("cookieCollection", typeof(CookieCollection));
		version = (Version)serializationInfo.GetValue("version", typeof(Version));
		statusCode = (HttpStatusCode)serializationInfo.GetValue("statusCode", typeof(HttpStatusCode));
	}

	public override Stream GetResponseStream()
	{
		CheckDisposed();
		if (stream == null)
		{
			return Stream.Null;
		}
		if (string.Equals(method, "HEAD", StringComparison.OrdinalIgnoreCase))
		{
			return Stream.Null;
		}
		return stream;
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		serializationInfo.AddValue("uri", uri);
		serializationInfo.AddValue("contentLength", contentLength);
		serializationInfo.AddValue("contentType", contentType);
		serializationInfo.AddValue("method", method);
		serializationInfo.AddValue("statusDescription", statusDescription);
		serializationInfo.AddValue("cookieCollection", cookieCollection);
		serializationInfo.AddValue("version", version);
		serializationInfo.AddValue("statusCode", statusCode);
	}

	public override void Close()
	{
		Interlocked.Exchange(ref stream, null)?.Close();
	}

	void IDisposable.Dispose()
	{
		Dispose(disposing: true);
	}

	protected override void Dispose(bool disposing)
	{
		disposed = true;
		base.Dispose(disposing: true);
	}

	private void CheckDisposed()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().FullName);
		}
	}

	private void FillCookies()
	{
		if (webHeaders == null)
		{
			return;
		}
		CookieCollection cookieCollection = null;
		try
		{
			string text = webHeaders.Get("Set-Cookie");
			if (text != null)
			{
				cookieCollection = cookie_container.CookieCutter(uri, "Set-Cookie", text, isThrow: false);
			}
		}
		catch
		{
		}
		try
		{
			string text = webHeaders.Get("Set-Cookie2");
			if (text != null)
			{
				CookieCollection cookieCollection2 = cookie_container.CookieCutter(uri, "Set-Cookie2", text, isThrow: false);
				if (cookieCollection != null && cookieCollection.Count != 0)
				{
					cookieCollection.Add(cookieCollection2);
				}
				else
				{
					cookieCollection = cookieCollection2;
				}
			}
		}
		catch
		{
		}
		this.cookieCollection = cookieCollection;
	}
}
