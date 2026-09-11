using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Net.Cache;
using System.Net.Security;
using System.Runtime.Serialization;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Mono.Net.Security;
using Mono.Security.Interface;
using Unity;

namespace System.Net;

[Serializable]
public class HttpWebRequest : WebRequest, ISerializable
{
	private enum NtlmAuthState
	{
		None,
		Challenge,
		Response
	}

	private struct AuthorizationState
	{
		private readonly HttpWebRequest request;

		private readonly bool isProxy;

		private bool isCompleted;

		private NtlmAuthState ntlm_auth_state;

		public bool IsCompleted => isCompleted;

		public NtlmAuthState NtlmAuthState => ntlm_auth_state;

		public bool IsNtlmAuthenticated
		{
			get
			{
				if (isCompleted)
				{
					return ntlm_auth_state != NtlmAuthState.None;
				}
				return false;
			}
		}

		public AuthorizationState(HttpWebRequest request, bool isProxy)
		{
			this.request = request;
			this.isProxy = isProxy;
			isCompleted = false;
			ntlm_auth_state = NtlmAuthState.None;
		}

		public bool CheckAuthorization(WebResponse response, HttpStatusCode code)
		{
			isCompleted = false;
			if (code == HttpStatusCode.Unauthorized && request.credentials == null)
			{
				return false;
			}
			if (isProxy != (code == HttpStatusCode.ProxyAuthenticationRequired))
			{
				return false;
			}
			if (isProxy && (request.proxy == null || request.proxy.Credentials == null))
			{
				return false;
			}
			string[] values = response.Headers.GetValues(isProxy ? "Proxy-Authenticate" : "WWW-Authenticate");
			if (values == null || values.Length == 0)
			{
				return false;
			}
			ICredentials credentials = ((!isProxy) ? request.credentials : request.proxy.Credentials);
			Authorization authorization = null;
			string[] array = values;
			for (int i = 0; i < array.Length; i++)
			{
				authorization = AuthenticationManager.Authenticate(array[i], request, credentials);
				if (authorization != null)
				{
					break;
				}
			}
			if (authorization == null)
			{
				return false;
			}
			request.webHeaders[isProxy ? "Proxy-Authorization" : "Authorization"] = authorization.Message;
			isCompleted = authorization.Complete;
			if (authorization.ModuleAuthenticationType == "NTLM")
			{
				ntlm_auth_state++;
			}
			return true;
		}

		public void Reset()
		{
			isCompleted = false;
			ntlm_auth_state = NtlmAuthState.None;
			request.webHeaders.RemoveInternal(isProxy ? "Proxy-Authorization" : "Authorization");
		}

		public override string ToString()
		{
			return string.Format("{0}AuthState [{1}:{2}]", isProxy ? "Proxy" : "", isCompleted, ntlm_auth_state);
		}
	}

	private Uri requestUri;

	private Uri actualUri;

	private bool hostChanged;

	private bool allowAutoRedirect;

	private bool allowBuffering;

	private bool allowReadStreamBuffering;

	private X509CertificateCollection certificates;

	private string connectionGroup;

	private bool haveContentLength;

	private long contentLength;

	private HttpContinueDelegate continueDelegate;

	private CookieContainer cookieContainer;

	private ICredentials credentials;

	private bool haveResponse;

	private bool requestSent;

	private WebHeaderCollection webHeaders;

	private bool keepAlive;

	private int maxAutoRedirect;

	private string mediaType;

	private string method;

	private string initialMethod;

	private bool pipelined;

	private bool preAuthenticate;

	private bool usedPreAuth;

	private Version version;

	private bool force_version;

	private Version actualVersion;

	private IWebProxy proxy;

	private bool sendChunked;

	private ServicePoint servicePoint;

	private int timeout;

	private int continueTimeout;

	private WebRequestStream writeStream;

	private HttpWebResponse webResponse;

	private WebCompletionSource responseTask;

	private WebOperation currentOperation;

	private int aborted;

	private bool gotRequestStream;

	private int redirects;

	private bool expectContinue;

	private bool getResponseCalled;

	private object locker;

	private bool finished_reading;

	private DecompressionMethods auto_decomp;

	private int maxResponseHeadersLength;

	private static int defaultMaxResponseHeadersLength;

	private static int defaultMaximumErrorResponseLength;

	private static RequestCachePolicy defaultCachePolicy;

	private int readWriteTimeout;

	private MobileTlsProvider tlsProvider;

	private MonoTlsSettings tlsSettings;

	private ServerCertValidationCallback certValidationCallback;

	private bool hostHasPort;

	private Uri hostUri;

	private AuthorizationState auth_state;

	private AuthorizationState proxy_auth_state;

	[NonSerialized]
	internal Func<Stream, Task> ResendContentFactory;

	internal readonly int ID;

	private bool unsafe_auth_blah;

	public string Accept
	{
		get
		{
			return webHeaders["Accept"];
		}
		set
		{
			CheckRequestStarted();
			SetSpecialHeaders("Accept", value);
		}
	}

	public Uri Address
	{
		get
		{
			return actualUri;
		}
		internal set
		{
			actualUri = value;
		}
	}

	public virtual bool AllowAutoRedirect
	{
		get
		{
			return allowAutoRedirect;
		}
		set
		{
			allowAutoRedirect = value;
		}
	}

	public virtual bool AllowWriteStreamBuffering
	{
		get
		{
			return allowBuffering;
		}
		set
		{
			allowBuffering = value;
		}
	}

	public virtual bool AllowReadStreamBuffering
	{
		get
		{
			return allowReadStreamBuffering;
		}
		set
		{
			allowReadStreamBuffering = value;
		}
	}

	public DecompressionMethods AutomaticDecompression
	{
		get
		{
			return auto_decomp;
		}
		set
		{
			CheckRequestStarted();
			auto_decomp = value;
		}
	}

	internal bool InternalAllowBuffering
	{
		get
		{
			if (allowBuffering)
			{
				return MethodWithBuffer;
			}
			return false;
		}
	}

	private bool MethodWithBuffer
	{
		get
		{
			if (method != "HEAD" && method != "GET" && method != "MKCOL" && method != "CONNECT")
			{
				return method != "TRACE";
			}
			return false;
		}
	}

	internal MobileTlsProvider TlsProvider => tlsProvider;

	internal MonoTlsSettings TlsSettings => tlsSettings;

	public X509CertificateCollection ClientCertificates
	{
		get
		{
			if (certificates == null)
			{
				certificates = new X509CertificateCollection();
			}
			return certificates;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			certificates = value;
		}
	}

	public string Connection
	{
		get
		{
			return webHeaders["Connection"];
		}
		set
		{
			CheckRequestStarted();
			if (string.IsNullOrWhiteSpace(value))
			{
				webHeaders.RemoveInternal("Connection");
				return;
			}
			string text = value.ToLowerInvariant();
			if (text.Contains("keep-alive") || text.Contains("close"))
			{
				throw new ArgumentException("Keep-Alive and Close may not be set using this property.", "value");
			}
			string value2 = HttpValidationHelpers.CheckBadHeaderValueChars(value);
			webHeaders.CheckUpdate("Connection", value2);
		}
	}

	public override string ConnectionGroupName
	{
		get
		{
			return connectionGroup;
		}
		set
		{
			connectionGroup = value;
		}
	}

	public override long ContentLength
	{
		get
		{
			return contentLength;
		}
		set
		{
			CheckRequestStarted();
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value", "Content-Length must be >= 0");
			}
			contentLength = value;
			haveContentLength = true;
		}
	}

	internal long InternalContentLength
	{
		set
		{
			contentLength = value;
		}
	}

	internal bool ThrowOnError { get; set; }

	public override string ContentType
	{
		get
		{
			return webHeaders["Content-Type"];
		}
		set
		{
			SetSpecialHeaders("Content-Type", value);
		}
	}

	public HttpContinueDelegate ContinueDelegate
	{
		get
		{
			return continueDelegate;
		}
		set
		{
			continueDelegate = value;
		}
	}

	public virtual CookieContainer CookieContainer
	{
		get
		{
			return cookieContainer;
		}
		set
		{
			cookieContainer = value;
		}
	}

	public override ICredentials Credentials
	{
		get
		{
			return credentials;
		}
		set
		{
			credentials = value;
		}
	}

	public DateTime Date
	{
		get
		{
			string text = webHeaders["Date"];
			if (text == null)
			{
				return DateTime.MinValue;
			}
			return DateTime.ParseExact(text, "r", CultureInfo.InvariantCulture).ToLocalTime();
		}
		set
		{
			SetDateHeaderHelper("Date", value);
		}
	}

	[System.MonoTODO]
	public static int DefaultMaximumErrorResponseLength
	{
		get
		{
			return defaultMaximumErrorResponseLength;
		}
		set
		{
			defaultMaximumErrorResponseLength = value;
		}
	}

	public string Expect
	{
		get
		{
			return webHeaders["Expect"];
		}
		set
		{
			CheckRequestStarted();
			string text = value;
			if (text != null)
			{
				text = text.Trim().ToLower();
			}
			if (text == null || text.Length == 0)
			{
				webHeaders.RemoveInternal("Expect");
				return;
			}
			if (text == "100-continue")
			{
				throw new ArgumentException("100-Continue cannot be set with this property.", "value");
			}
			webHeaders.CheckUpdate("Expect", value);
		}
	}

	public virtual bool HaveResponse => haveResponse;

	public override WebHeaderCollection Headers
	{
		get
		{
			return webHeaders;
		}
		set
		{
			CheckRequestStarted();
			WebHeaderCollection webHeaderCollection = new WebHeaderCollection(WebHeaderCollectionType.HttpWebRequest);
			string[] allKeys = value.AllKeys;
			foreach (string name in allKeys)
			{
				webHeaderCollection.Add(name, value[name]);
			}
			webHeaders = webHeaderCollection;
		}
	}

	public string Host
	{
		get
		{
			Uri uri = hostUri ?? Address;
			if ((!(hostUri == null) && hostHasPort) || !Address.IsDefaultPort)
			{
				return uri.Host + ":" + uri.Port;
			}
			return uri.Host;
		}
		set
		{
			CheckRequestStarted();
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (value.IndexOf('/') != -1 || !TryGetHostUri(value, out var uri))
			{
				throw new ArgumentException("The specified value is not a valid Host header string.", "value");
			}
			hostUri = uri;
			if (!hostUri.IsDefaultPort)
			{
				hostHasPort = true;
				return;
			}
			if (value.IndexOf(':') == -1)
			{
				hostHasPort = false;
				return;
			}
			int num = value.IndexOf(']');
			hostHasPort = num == -1 || value.LastIndexOf(':') > num;
		}
	}

	public DateTime IfModifiedSince
	{
		get
		{
			string text = webHeaders["If-Modified-Since"];
			if (text == null)
			{
				return DateTime.Now;
			}
			try
			{
				return MonoHttpDate.Parse(text);
			}
			catch (Exception)
			{
				return DateTime.Now;
			}
		}
		set
		{
			CheckRequestStarted();
			webHeaders.SetInternal("If-Modified-Since", value.ToUniversalTime().ToString("r", null));
		}
	}

	public bool KeepAlive
	{
		get
		{
			return keepAlive;
		}
		set
		{
			keepAlive = value;
		}
	}

	public int MaximumAutomaticRedirections
	{
		get
		{
			return maxAutoRedirect;
		}
		set
		{
			if (value <= 0)
			{
				throw new ArgumentException("Must be > 0", "value");
			}
			maxAutoRedirect = value;
		}
	}

	[System.MonoTODO("Use this")]
	public int MaximumResponseHeadersLength
	{
		get
		{
			return maxResponseHeadersLength;
		}
		set
		{
			CheckRequestStarted();
			if (value < 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", "The specified value must be greater than 0.");
			}
			maxResponseHeadersLength = value;
		}
	}

	[System.MonoTODO("Use this")]
	public static int DefaultMaximumResponseHeadersLength
	{
		get
		{
			return defaultMaxResponseHeadersLength;
		}
		set
		{
			defaultMaxResponseHeadersLength = value;
		}
	}

	public int ReadWriteTimeout
	{
		get
		{
			return readWriteTimeout;
		}
		set
		{
			CheckRequestStarted();
			if (value <= 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", "Timeout can be only be set to 'System.Threading.Timeout.Infinite' or a value > 0.");
			}
			readWriteTimeout = value;
		}
	}

	[System.MonoTODO]
	public int ContinueTimeout
	{
		get
		{
			return continueTimeout;
		}
		set
		{
			CheckRequestStarted();
			if (value < 0 && value != -1)
			{
				throw new ArgumentOutOfRangeException("value", "Timeout can be only be set to 'System.Threading.Timeout.Infinite' or a value >= 0.");
			}
			continueTimeout = value;
		}
	}

	public string MediaType
	{
		get
		{
			return mediaType;
		}
		set
		{
			mediaType = value;
		}
	}

	public override string Method
	{
		get
		{
			return method;
		}
		set
		{
			if (string.IsNullOrEmpty(value))
			{
				throw new ArgumentException("Cannot set null or blank methods on request.", "value");
			}
			if (HttpValidationHelpers.IsInvalidMethodOrHeaderString(value))
			{
				throw new ArgumentException("Cannot set null or blank methods on request.", "value");
			}
			method = value.ToUpperInvariant();
			if (method != "HEAD" && method != "GET" && method != "POST" && method != "PUT" && method != "DELETE" && method != "CONNECT" && method != "TRACE" && method != "MKCOL")
			{
				method = value;
			}
		}
	}

	public bool Pipelined
	{
		get
		{
			return pipelined;
		}
		set
		{
			pipelined = value;
		}
	}

	public override bool PreAuthenticate
	{
		get
		{
			return preAuthenticate;
		}
		set
		{
			preAuthenticate = value;
		}
	}

	public Version ProtocolVersion
	{
		get
		{
			return version;
		}
		set
		{
			if (value != HttpVersion.Version10 && value != HttpVersion.Version11)
			{
				throw new ArgumentException("Only HTTP/1.0 and HTTP/1.1 version requests are currently supported.", "value");
			}
			force_version = true;
			version = value;
		}
	}

	public override IWebProxy Proxy
	{
		get
		{
			return proxy;
		}
		set
		{
			CheckRequestStarted();
			proxy = value;
			servicePoint = null;
			GetServicePoint();
		}
	}

	public string Referer
	{
		get
		{
			return webHeaders["Referer"];
		}
		set
		{
			CheckRequestStarted();
			if (value == null || value.Trim().Length == 0)
			{
				webHeaders.RemoveInternal("Referer");
			}
			else
			{
				webHeaders.SetInternal("Referer", value);
			}
		}
	}

	public override Uri RequestUri => requestUri;

	public bool SendChunked
	{
		get
		{
			return sendChunked;
		}
		set
		{
			CheckRequestStarted();
			sendChunked = value;
		}
	}

	public ServicePoint ServicePoint => GetServicePoint();

	internal ServicePoint ServicePointNoLock => servicePoint;

	public virtual bool SupportsCookieContainer => true;

	public override int Timeout
	{
		get
		{
			return timeout;
		}
		set
		{
			if (value < -1)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			timeout = value;
		}
	}

	public string TransferEncoding
	{
		get
		{
			return webHeaders["Transfer-Encoding"];
		}
		set
		{
			CheckRequestStarted();
			if (string.IsNullOrWhiteSpace(value))
			{
				webHeaders.RemoveInternal("Transfer-Encoding");
				return;
			}
			if (value.ToLower().Contains("chunked"))
			{
				throw new ArgumentException("Chunked encoding must be set via the SendChunked property.", "value");
			}
			if (!SendChunked)
			{
				throw new InvalidOperationException("TransferEncoding requires the SendChunked property to be set to true.");
			}
			string value2 = HttpValidationHelpers.CheckBadHeaderValueChars(value);
			webHeaders.CheckUpdate("Transfer-Encoding", value2);
		}
	}

	public override bool UseDefaultCredentials
	{
		get
		{
			return CredentialCache.DefaultCredentials == Credentials;
		}
		set
		{
			Credentials = (value ? CredentialCache.DefaultCredentials : null);
		}
	}

	public string UserAgent
	{
		get
		{
			return webHeaders["User-Agent"];
		}
		set
		{
			webHeaders.SetInternal("User-Agent", value);
		}
	}

	public bool UnsafeAuthenticatedConnectionSharing
	{
		get
		{
			return unsafe_auth_blah;
		}
		set
		{
			unsafe_auth_blah = value;
		}
	}

	internal bool GotRequestStream => gotRequestStream;

	internal bool ExpectContinue
	{
		get
		{
			return expectContinue;
		}
		set
		{
			expectContinue = value;
		}
	}

	internal Uri AuthUri => actualUri;

	internal bool ProxyQuery
	{
		get
		{
			if (servicePoint.UsesProxy)
			{
				return !servicePoint.UseConnect;
			}
			return false;
		}
	}

	internal ServerCertValidationCallback ServerCertValidationCallback => certValidationCallback;

	public RemoteCertificateValidationCallback ServerCertificateValidationCallback
	{
		get
		{
			if (certValidationCallback == null)
			{
				return null;
			}
			return certValidationCallback.ValidationCallback;
		}
		set
		{
			if (value == null)
			{
				certValidationCallback = null;
			}
			else
			{
				certValidationCallback = new ServerCertValidationCallback(value);
			}
		}
	}

	internal bool FinishedReading
	{
		get
		{
			return finished_reading;
		}
		set
		{
			finished_reading = value;
		}
	}

	internal bool Aborted => Interlocked.CompareExchange(ref aborted, 0, 0) == 1;

	internal bool ReuseConnection { get; set; }

	static HttpWebRequest()
	{
		defaultMaxResponseHeadersLength = 64;
		defaultMaximumErrorResponseLength = 64;
		defaultCachePolicy = new RequestCachePolicy(RequestCacheLevel.BypassCache);
	}

	public HttpWebRequest(Uri uri)
	{
		allowAutoRedirect = true;
		allowBuffering = true;
		contentLength = -1L;
		keepAlive = true;
		maxAutoRedirect = 50;
		mediaType = string.Empty;
		method = "GET";
		initialMethod = "GET";
		pipelined = true;
		version = HttpVersion.Version11;
		timeout = 100000;
		continueTimeout = 350;
		locker = new object();
		readWriteTimeout = 300000;
		base._002Ector();
		requestUri = uri;
		actualUri = uri;
		proxy = WebRequest.InternalDefaultWebProxy;
		webHeaders = new WebHeaderCollection(WebHeaderCollectionType.HttpWebRequest);
		ThrowOnError = true;
		ResetAuthorization();
	}

	internal HttpWebRequest(Uri uri, MobileTlsProvider tlsProvider, MonoTlsSettings settings = null)
		: this(uri)
	{
		this.tlsProvider = tlsProvider;
		tlsSettings = settings;
	}

	[Obsolete("Serialization is obsoleted for this type.  http://go.microsoft.com/fwlink/?linkid=14202")]
	protected HttpWebRequest(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		allowAutoRedirect = true;
		allowBuffering = true;
		contentLength = -1L;
		keepAlive = true;
		maxAutoRedirect = 50;
		mediaType = string.Empty;
		method = "GET";
		initialMethod = "GET";
		pipelined = true;
		version = HttpVersion.Version11;
		timeout = 100000;
		continueTimeout = 350;
		locker = new object();
		readWriteTimeout = 300000;
		base._002Ector();
		throw new SerializationException();
	}

	private void ResetAuthorization()
	{
		auth_state = new AuthorizationState(this, isProxy: false);
		proxy_auth_state = new AuthorizationState(this, isProxy: true);
	}

	private void SetSpecialHeaders(string HeaderName, string value)
	{
		value = WebHeaderCollection.CheckBadChars(value, isHeaderValue: true);
		webHeaders.RemoveInternal(HeaderName);
		if (value.Length != 0)
		{
			webHeaders.AddInternal(HeaderName, value);
		}
	}

	private static Exception GetMustImplement()
	{
		return new NotImplementedException();
	}

	private void SetDateHeaderHelper(string headerName, DateTime dateTime)
	{
		if (dateTime == DateTime.MinValue)
		{
			SetSpecialHeaders(headerName, null);
		}
		else
		{
			SetSpecialHeaders(headerName, HttpProtocolUtils.date2string(dateTime));
		}
	}

	private bool TryGetHostUri(string hostName, out Uri hostUri)
	{
		return Uri.TryCreate(Address.Scheme + "://" + hostName + Address.PathAndQuery, UriKind.Absolute, out hostUri);
	}

	internal ServicePoint GetServicePoint()
	{
		lock (locker)
		{
			if (hostChanged || servicePoint == null)
			{
				servicePoint = ServicePointManager.FindServicePoint(actualUri, proxy);
				hostChanged = false;
			}
		}
		return servicePoint;
	}

	public void AddRange(int range)
	{
		AddRange("bytes", (long)range);
	}

	public void AddRange(int from, int to)
	{
		AddRange("bytes", (long)from, (long)to);
	}

	public void AddRange(string rangeSpecifier, int range)
	{
		AddRange(rangeSpecifier, (long)range);
	}

	public void AddRange(string rangeSpecifier, int from, int to)
	{
		AddRange(rangeSpecifier, (long)from, (long)to);
	}

	public void AddRange(long range)
	{
		AddRange("bytes", range);
	}

	public void AddRange(long from, long to)
	{
		AddRange("bytes", from, to);
	}

	public void AddRange(string rangeSpecifier, long range)
	{
		if (rangeSpecifier == null)
		{
			throw new ArgumentNullException("rangeSpecifier");
		}
		if (!WebHeaderCollection.IsValidToken(rangeSpecifier))
		{
			throw new ArgumentException("Invalid range specifier", "rangeSpecifier");
		}
		string text = webHeaders["Range"];
		if (text == null)
		{
			text = rangeSpecifier + "=";
		}
		else
		{
			if (string.Compare(text.Substring(0, text.IndexOf('=')), rangeSpecifier, StringComparison.OrdinalIgnoreCase) != 0)
			{
				throw new InvalidOperationException("A different range specifier is already in use");
			}
			text += ",";
		}
		string text2 = range.ToString(CultureInfo.InvariantCulture);
		text = ((range >= 0) ? (text + text2 + "-") : (text + "0" + text2));
		webHeaders.ChangeInternal("Range", text);
	}

	public void AddRange(string rangeSpecifier, long from, long to)
	{
		if (rangeSpecifier == null)
		{
			throw new ArgumentNullException("rangeSpecifier");
		}
		if (!WebHeaderCollection.IsValidToken(rangeSpecifier))
		{
			throw new ArgumentException("Invalid range specifier", "rangeSpecifier");
		}
		if (from > to || from < 0)
		{
			throw new ArgumentOutOfRangeException("from");
		}
		if (to < 0)
		{
			throw new ArgumentOutOfRangeException("to");
		}
		string text = webHeaders["Range"];
		text = ((text != null) ? (text + ",") : (rangeSpecifier + "="));
		text = $"{text}{from}-{to}";
		webHeaders.ChangeInternal("Range", text);
	}

	private WebOperation SendRequest(bool redirecting, BufferOffsetSize writeBuffer, CancellationToken cancellationToken)
	{
		lock (locker)
		{
			WebOperation webOperation;
			if (!redirecting && requestSent)
			{
				webOperation = currentOperation;
				if (webOperation == null)
				{
					throw new InvalidOperationException("Should never happen!");
				}
				return webOperation;
			}
			webOperation = new WebOperation(this, writeBuffer, isNtlmChallenge: false, cancellationToken);
			if (Interlocked.CompareExchange(ref currentOperation, webOperation, null) != null)
			{
				throw new InvalidOperationException("Invalid nested call.");
			}
			requestSent = true;
			if (!redirecting)
			{
				redirects = 0;
			}
			servicePoint = GetServicePoint();
			servicePoint.SendRequest(webOperation, connectionGroup);
			return webOperation;
		}
	}

	private Task<Stream> MyGetRequestStreamAsync(CancellationToken cancellationToken)
	{
		if (Aborted)
		{
			throw CreateRequestAbortedException();
		}
		bool flag = !(method == "GET") && !(method == "CONNECT") && !(method == "HEAD") && !(method == "TRACE");
		if (method == null || !flag)
		{
			throw new ProtocolViolationException("Cannot send a content-body with this verb-type.");
		}
		if (contentLength == -1 && !sendChunked && !allowBuffering && KeepAlive)
		{
			throw new ProtocolViolationException("Content-Length not set");
		}
		string transferEncoding = TransferEncoding;
		if (!sendChunked && transferEncoding != null && transferEncoding.Trim() != "")
		{
			throw new InvalidOperationException("TransferEncoding requires the SendChunked property to be set to true.");
		}
		WebOperation webOperation;
		lock (locker)
		{
			if (getResponseCalled)
			{
				throw new InvalidOperationException("This operation cannot be performed after the request has been submitted.");
			}
			webOperation = currentOperation;
			if (webOperation == null)
			{
				initialMethod = method;
				gotRequestStream = true;
				webOperation = SendRequest(redirecting: false, null, cancellationToken);
			}
		}
		return webOperation.GetRequestStream();
	}

	public override IAsyncResult BeginGetRequestStream(AsyncCallback callback, object state)
	{
		return TaskToApm.Begin(RunWithTimeout(MyGetRequestStreamAsync), callback, state);
	}

	public override Stream EndGetRequestStream(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		try
		{
			return TaskToApm.End<Stream>(asyncResult);
		}
		catch (Exception e)
		{
			throw GetWebException(e);
		}
	}

	public override Stream GetRequestStream()
	{
		try
		{
			return GetRequestStreamAsync().Result;
		}
		catch (Exception e)
		{
			throw GetWebException(e);
		}
	}

	[System.MonoTODO]
	public Stream GetRequestStream(out TransportContext context)
	{
		throw new NotImplementedException();
	}

	public override Task<Stream> GetRequestStreamAsync()
	{
		return RunWithTimeout(MyGetRequestStreamAsync);
	}

	internal static Task<T> RunWithTimeout<T>(Func<CancellationToken, Task<T>> func, int timeout, Action abort, Func<bool> aborted, CancellationToken cancellationToken)
	{
		CancellationTokenSource cancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
		return RunWithTimeoutWorker(func(cancellationTokenSource.Token), timeout, abort, aborted, cancellationTokenSource);
	}

	private static async Task<T> RunWithTimeoutWorker<T>(Task<T> workerTask, int timeout, Action abort, Func<bool> aborted, CancellationTokenSource cts)
	{
		try
		{
			if (await ServicePointScheduler.WaitAsync(workerTask, timeout).ConfigureAwait(continueOnCapturedContext: false))
			{
				return workerTask.Result;
			}
			try
			{
				cts.Cancel();
				abort();
			}
			catch
			{
			}
			workerTask.ContinueWith((Task<T> t) => t.Exception?.GetHashCode(), TaskContinuationOptions.OnlyOnFaulted);
			throw new WebException("The operation has timed out.", WebExceptionStatus.Timeout);
		}
		catch (Exception e)
		{
			throw GetWebException(e, aborted());
		}
		finally
		{
			cts.Dispose();
		}
	}

	private Task<T> RunWithTimeout<T>(Func<CancellationToken, Task<T>> func)
	{
		CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
		return RunWithTimeoutWorker(func(cancellationTokenSource.Token), timeout, Abort, () => Aborted, cancellationTokenSource);
	}

	private async Task<HttpWebResponse> MyGetResponseAsync(CancellationToken cancellationToken)
	{
		if (Aborted)
		{
			throw CreateRequestAbortedException();
		}
		WebCompletionSource completion = new WebCompletionSource();
		WebOperation operation;
		lock (locker)
		{
			getResponseCalled = true;
			WebCompletionSource webCompletionSource = Interlocked.CompareExchange(ref responseTask, completion, null);
			if (webCompletionSource != null)
			{
				webCompletionSource.ThrowOnError();
				if (haveResponse && webCompletionSource.Task.IsCompleted)
				{
					return webResponse;
				}
				throw new InvalidOperationException("Cannot re-call start of asynchronous method while a previous call is still in progress.");
			}
			operation = currentOperation;
			if (currentOperation != null)
			{
				writeStream = currentOperation.WriteStream;
			}
			initialMethod = method;
			operation = SendRequest(redirecting: false, null, cancellationToken);
		}
		while (true)
		{
			WebException throwMe = null;
			HttpWebResponse response = null;
			WebResponseStream stream = null;
			bool redirect = false;
			bool mustReadAll = false;
			WebOperation ntlm = null;
			BufferOffsetSize writeBuffer = null;
			try
			{
				cancellationToken.ThrowIfCancellationRequested();
				writeStream = await operation.GetRequestStreamInternal().ConfigureAwait(continueOnCapturedContext: false);
				await writeStream.WriteRequestAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				stream = await operation.GetResponseStream();
				(response, redirect, mustReadAll, writeBuffer, ntlm) = await GetResponseFromData(stream, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
			catch (Exception e)
			{
				throwMe = GetWebException(e);
			}
			lock (locker)
			{
				if (throwMe != null)
				{
					haveResponse = true;
					completion.TrySetException(throwMe);
					throw throwMe;
				}
				if (!redirect)
				{
					haveResponse = true;
					webResponse = response;
					completion.TrySetCompleted();
					return response;
				}
				finished_reading = false;
				haveResponse = false;
				webResponse = null;
				currentOperation = ntlm;
			}
			try
			{
				if (mustReadAll)
				{
					await stream.ReadAllAsync(redirect || ntlm != null, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				operation.Finish(ok: true);
				response.Close();
			}
			catch (Exception e2)
			{
				throwMe = GetWebException(e2);
			}
			lock (locker)
			{
				if (throwMe != null)
				{
					haveResponse = true;
					stream?.Close();
					completion.TrySetException(throwMe);
					throw throwMe;
				}
				operation = ((ntlm != null) ? ntlm : SendRequest(redirecting: true, writeBuffer, cancellationToken));
			}
		}
	}

	private async Task<(HttpWebResponse response, bool redirect, bool mustReadAll, BufferOffsetSize writeBuffer, WebOperation ntlm)> GetResponseFromData(WebResponseStream stream, CancellationToken cancellationToken)
	{
		HttpWebResponse response = new HttpWebResponse(actualUri, method, stream, cookieContainer);
		WebException throwMe = null;
		bool redirect = false;
		bool mustReadAll = false;
		WebOperation item = null;
		Task<BufferOffsetSize> task = null;
		BufferOffsetSize bufferOffsetSize = null;
		lock (locker)
		{
			(redirect, mustReadAll, task, throwMe) = CheckFinalStatus(response);
		}
		if (throwMe != null)
		{
			if (mustReadAll)
			{
				await stream.ReadAllAsync(resending: false, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
			throw throwMe;
		}
		if (task != null)
		{
			bufferOffsetSize = await task.ConfigureAwait(continueOnCapturedContext: false);
		}
		lock (locker)
		{
			bool flag = ProxyQuery && proxy != null && !proxy.IsBypassed(actualUri);
			if (!redirect)
			{
				if ((flag ? proxy_auth_state : auth_state).IsNtlmAuthenticated && response.StatusCode < HttpStatusCode.BadRequest)
				{
					stream.Connection.NtlmAuthenticated = true;
				}
				if (writeStream != null)
				{
					writeStream.KillBuffer();
				}
				return (response: response, redirect: false, mustReadAll: false, writeBuffer: bufferOffsetSize, ntlm: null);
			}
			if (sendChunked)
			{
				sendChunked = false;
				webHeaders.RemoveInternal("Transfer-Encoding");
			}
			item = HandleNtlmAuth(stream, response, bufferOffsetSize, cancellationToken).Item1;
		}
		return (response: response, redirect: true, mustReadAll: mustReadAll, writeBuffer: bufferOffsetSize, ntlm: item);
	}

	internal static Exception FlattenException(Exception e)
	{
		if (e is AggregateException ex)
		{
			AggregateException ex2 = ex.Flatten();
			if (ex2.InnerExceptions.Count == 1)
			{
				return ex2.InnerException;
			}
		}
		return e;
	}

	private WebException GetWebException(Exception e)
	{
		return GetWebException(e, Aborted);
	}

	private static WebException GetWebException(Exception e, bool aborted)
	{
		e = FlattenException(e);
		if (e is WebException ex && (!aborted || ex.Status == WebExceptionStatus.RequestCanceled || ex.Status == WebExceptionStatus.Timeout))
		{
			return ex;
		}
		if (aborted || e is OperationCanceledException || e is ObjectDisposedException)
		{
			return CreateRequestAbortedException();
		}
		return new WebException(e.Message, e, WebExceptionStatus.UnknownError, null);
	}

	internal static WebException CreateRequestAbortedException()
	{
		return new WebException(global::SR.Format("The request was aborted: The request was canceled.", WebExceptionStatus.RequestCanceled), WebExceptionStatus.RequestCanceled);
	}

	public override IAsyncResult BeginGetResponse(AsyncCallback callback, object state)
	{
		if (Aborted)
		{
			throw CreateRequestAbortedException();
		}
		string transferEncoding = TransferEncoding;
		if (!sendChunked && transferEncoding != null && transferEncoding.Trim() != "")
		{
			throw new InvalidOperationException("TransferEncoding requires the SendChunked property to be set to true.");
		}
		return TaskToApm.Begin(RunWithTimeout(MyGetResponseAsync), callback, state);
	}

	public override WebResponse EndGetResponse(IAsyncResult asyncResult)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		try
		{
			return TaskToApm.End<HttpWebResponse>(asyncResult);
		}
		catch (Exception e)
		{
			throw GetWebException(e);
		}
	}

	public Stream EndGetRequestStream(IAsyncResult asyncResult, out TransportContext context)
	{
		if (asyncResult == null)
		{
			throw new ArgumentNullException("asyncResult");
		}
		context = null;
		return EndGetRequestStream(asyncResult);
	}

	public override WebResponse GetResponse()
	{
		try
		{
			return GetResponseAsync().Result;
		}
		catch (Exception e)
		{
			throw GetWebException(e);
		}
	}

	public override void Abort()
	{
		if (Interlocked.CompareExchange(ref aborted, 1, 0) == 1)
		{
			return;
		}
		haveResponse = true;
		currentOperation?.Abort();
		responseTask?.TrySetCanceled();
		if (webResponse == null)
		{
			return;
		}
		try
		{
			webResponse.Close();
			webResponse = null;
		}
		catch
		{
		}
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		throw new SerializationException();
	}

	protected override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		throw new SerializationException();
	}

	private void CheckRequestStarted()
	{
		if (requestSent)
		{
			throw new InvalidOperationException("request started");
		}
	}

	internal void DoContinueDelegate(int statusCode, WebHeaderCollection headers)
	{
		if (continueDelegate != null)
		{
			continueDelegate(statusCode, headers);
		}
	}

	private void RewriteRedirectToGet()
	{
		method = "GET";
		webHeaders.RemoveInternal("Transfer-Encoding");
		sendChunked = false;
	}

	private bool Redirect(HttpStatusCode code, WebResponse response)
	{
		redirects++;
		Exception ex = null;
		string text = null;
		switch (code)
		{
		case HttpStatusCode.MultipleChoices:
			ex = new WebException("Ambiguous redirect.");
			break;
		case HttpStatusCode.MovedPermanently:
		case HttpStatusCode.Found:
			if (method == "POST")
			{
				RewriteRedirectToGet();
			}
			break;
		case HttpStatusCode.SeeOther:
			RewriteRedirectToGet();
			break;
		case HttpStatusCode.NotModified:
			return false;
		case HttpStatusCode.UseProxy:
			ex = new NotImplementedException("Proxy support not available.");
			break;
		default:
		{
			int num = (int)code;
			ex = new ProtocolViolationException("Invalid status code: " + num);
			break;
		}
		case HttpStatusCode.TemporaryRedirect:
			break;
		}
		if (method != "GET" && !InternalAllowBuffering && ResendContentFactory == null && (writeStream.WriteBufferLength > 0 || contentLength > 0))
		{
			ex = new WebException("The request requires buffering data to succeed.", null, WebExceptionStatus.ProtocolError, response);
		}
		if (ex != null)
		{
			throw ex;
		}
		if (AllowWriteStreamBuffering || method == "GET")
		{
			contentLength = -1L;
		}
		text = response.Headers["Location"];
		if (text == null)
		{
			throw new WebException($"No Location header found for {(int)code}", null, WebExceptionStatus.ProtocolError, response);
		}
		Uri uri = actualUri;
		try
		{
			actualUri = new Uri(actualUri, text);
		}
		catch (Exception)
		{
			throw new WebException($"Invalid URL ({text}) for {(int)code}", null, WebExceptionStatus.ProtocolError, response);
		}
		hostChanged = actualUri.Scheme != uri.Scheme || Host != uri.Authority;
		return true;
	}

	private string GetHeaders()
	{
		bool flag = false;
		if (sendChunked)
		{
			flag = true;
			webHeaders.ChangeInternal("Transfer-Encoding", "chunked");
			webHeaders.RemoveInternal("Content-Length");
		}
		else if (contentLength != -1)
		{
			if (auth_state.NtlmAuthState == NtlmAuthState.Challenge || proxy_auth_state.NtlmAuthState == NtlmAuthState.Challenge)
			{
				if (haveContentLength || gotRequestStream || contentLength > 0)
				{
					webHeaders.SetInternal("Content-Length", "0");
				}
				else
				{
					webHeaders.RemoveInternal("Content-Length");
				}
			}
			else
			{
				if (contentLength > 0)
				{
					flag = true;
				}
				if (haveContentLength || gotRequestStream || contentLength > 0)
				{
					webHeaders.SetInternal("Content-Length", contentLength.ToString());
				}
			}
			webHeaders.RemoveInternal("Transfer-Encoding");
		}
		else
		{
			webHeaders.RemoveInternal("Content-Length");
		}
		if (((actualVersion == HttpVersion.Version11) & flag) && servicePoint.SendContinue)
		{
			webHeaders.ChangeInternal("Expect", "100-continue");
			expectContinue = true;
		}
		else
		{
			webHeaders.RemoveInternal("Expect");
			expectContinue = false;
		}
		bool proxyQuery = ProxyQuery;
		string name = (proxyQuery ? "Proxy-Connection" : "Connection");
		webHeaders.RemoveInternal((!proxyQuery) ? "Proxy-Connection" : "Connection");
		Version protocolVersion = servicePoint.ProtocolVersion;
		bool flag2 = protocolVersion == null || protocolVersion == HttpVersion.Version10;
		if (keepAlive && ((version == HttpVersion.Version10) | flag2))
		{
			if (webHeaders[name] == null || webHeaders[name].IndexOf("keep-alive", StringComparison.OrdinalIgnoreCase) == -1)
			{
				webHeaders.ChangeInternal(name, "keep-alive");
			}
		}
		else if (!keepAlive && version == HttpVersion.Version11)
		{
			webHeaders.ChangeInternal(name, "close");
		}
		string value = ((hostUri != null) ? ((!hostHasPort) ? hostUri.GetComponents(UriComponents.Host, UriFormat.Unescaped) : hostUri.GetComponents(UriComponents.HostAndPort, UriFormat.Unescaped)) : ((!Address.IsDefaultPort) ? Address.GetComponents(UriComponents.HostAndPort, UriFormat.Unescaped) : Address.GetComponents(UriComponents.Host, UriFormat.Unescaped)));
		webHeaders.SetInternal("Host", value);
		if (cookieContainer != null)
		{
			string cookieHeader = cookieContainer.GetCookieHeader(actualUri);
			if (cookieHeader != "")
			{
				webHeaders.ChangeInternal("Cookie", cookieHeader);
			}
			else
			{
				webHeaders.RemoveInternal("Cookie");
			}
		}
		string text = null;
		if ((auto_decomp & DecompressionMethods.GZip) != DecompressionMethods.None)
		{
			text = "gzip";
		}
		if ((auto_decomp & DecompressionMethods.Deflate) != DecompressionMethods.None)
		{
			text = ((text != null) ? "gzip, deflate" : "deflate");
		}
		if (text != null)
		{
			webHeaders.ChangeInternal("Accept-Encoding", text);
		}
		if (!usedPreAuth && preAuthenticate)
		{
			DoPreAuthenticate();
		}
		return webHeaders.ToString();
	}

	private void DoPreAuthenticate()
	{
		bool flag = proxy != null && !proxy.IsBypassed(actualUri);
		ICredentials credentials = ((!flag || this.credentials != null) ? this.credentials : proxy.Credentials);
		Authorization authorization = AuthenticationManager.PreAuthenticate(this, credentials);
		if (authorization != null)
		{
			webHeaders.RemoveInternal("Proxy-Authorization");
			webHeaders.RemoveInternal("Authorization");
			string name = ((flag && this.credentials == null) ? "Proxy-Authorization" : "Authorization");
			webHeaders[name] = authorization.Message;
			usedPreAuth = true;
		}
	}

	internal byte[] GetRequestHeaders()
	{
		StringBuilder stringBuilder = new StringBuilder();
		string text = (ProxyQuery ? $"{actualUri.Scheme}://{Host}{actualUri.PathAndQuery}" : actualUri.PathAndQuery);
		if (!force_version && servicePoint.ProtocolVersion != null && servicePoint.ProtocolVersion < version)
		{
			actualVersion = servicePoint.ProtocolVersion;
		}
		else
		{
			actualVersion = version;
		}
		stringBuilder.AppendFormat("{0} {1} HTTP/{2}.{3}\r\n", method, text, actualVersion.Major, actualVersion.Minor);
		stringBuilder.Append(GetHeaders());
		string s = stringBuilder.ToString();
		return Encoding.UTF8.GetBytes(s);
	}

	private (WebOperation, bool) HandleNtlmAuth(WebResponseStream stream, HttpWebResponse response, BufferOffsetSize writeBuffer, CancellationToken cancellationToken)
	{
		bool flag = response.StatusCode == HttpStatusCode.ProxyAuthenticationRequired;
		if ((flag ? proxy_auth_state : auth_state).NtlmAuthState == NtlmAuthState.None)
		{
			return (null, false);
		}
		bool flag2 = auth_state.NtlmAuthState == NtlmAuthState.Challenge || proxy_auth_state.NtlmAuthState == NtlmAuthState.Challenge;
		WebOperation webOperation = new WebOperation(this, writeBuffer, flag2, cancellationToken);
		stream.Operation.SetPriorityRequest(webOperation);
		ICredentials credentials = ((!flag || proxy == null) ? this.credentials : proxy.Credentials);
		if (credentials != null)
		{
			stream.Connection.NtlmCredential = credentials.GetCredential(requestUri, "NTLM");
			stream.Connection.UnsafeAuthenticatedConnectionSharing = unsafe_auth_blah;
		}
		return (webOperation, flag2);
	}

	private bool CheckAuthorization(WebResponse response, HttpStatusCode code)
	{
		if (code != HttpStatusCode.ProxyAuthenticationRequired)
		{
			return auth_state.CheckAuthorization(response, code);
		}
		return proxy_auth_state.CheckAuthorization(response, code);
	}

	private (Task<BufferOffsetSize> task, WebException throwMe) GetRewriteHandler(HttpWebResponse response, bool redirect)
	{
		if (redirect)
		{
			if (!MethodWithBuffer)
			{
				return (task: null, throwMe: null);
			}
			if (writeStream.WriteBufferLength == 0 || contentLength == 0L)
			{
				return (task: null, throwMe: null);
			}
		}
		if (AllowWriteStreamBuffering)
		{
			return (task: Task.FromResult(writeStream.GetWriteBuffer()), throwMe: null);
		}
		if (ResendContentFactory == null)
		{
			return (task: null, throwMe: new WebException("The request requires buffering data to succeed.", null, WebExceptionStatus.ProtocolError, response));
		}
		return (task: ((Func<Task<BufferOffsetSize>>)async delegate
		{
			using MemoryStream ms = new MemoryStream();
			await ResendContentFactory(ms).ConfigureAwait(continueOnCapturedContext: false);
			byte[] array = ms.ToArray();
			return new BufferOffsetSize(array, 0, array.Length, copyBuffer: false);
		})(), throwMe: null);
	}

	private (bool redirect, bool mustReadAll, Task<BufferOffsetSize> writeBuffer, WebException throwMe) CheckFinalStatus(HttpWebResponse response)
	{
		WebException ex = null;
		bool item = false;
		HttpStatusCode httpStatusCode = (HttpStatusCode)0;
		Task<BufferOffsetSize> item2 = null;
		httpStatusCode = response.StatusCode;
		if (((!auth_state.IsCompleted && httpStatusCode == HttpStatusCode.Unauthorized && credentials != null) || (ProxyQuery && !proxy_auth_state.IsCompleted && httpStatusCode == HttpStatusCode.ProxyAuthenticationRequired)) && !usedPreAuth && CheckAuthorization(response, httpStatusCode))
		{
			item = true;
			if (!MethodWithBuffer)
			{
				return (redirect: true, mustReadAll: item, writeBuffer: null, throwMe: null);
			}
			(item2, ex) = GetRewriteHandler(response, redirect: false);
			if (ex == null)
			{
				return (redirect: true, mustReadAll: item, writeBuffer: item2, throwMe: null);
			}
			if (!ThrowOnError)
			{
				return (redirect: false, mustReadAll: item, writeBuffer: null, throwMe: null);
			}
			writeStream.InternalClose();
			writeStream = null;
			response.Close();
			return (redirect: false, mustReadAll: item, writeBuffer: null, throwMe: ex);
		}
		if (httpStatusCode >= HttpStatusCode.BadRequest)
		{
			ex = new WebException($"The remote server returned an error: ({(int)httpStatusCode}) {response.StatusDescription}.", null, WebExceptionStatus.ProtocolError, response);
			item = true;
		}
		else if (httpStatusCode == HttpStatusCode.NotModified && allowAutoRedirect)
		{
			ex = new WebException($"The remote server returned an error: ({(int)httpStatusCode}) {response.StatusDescription}.", null, WebExceptionStatus.ProtocolError, response);
		}
		else if (httpStatusCode >= HttpStatusCode.MultipleChoices && allowAutoRedirect && redirects >= maxAutoRedirect)
		{
			ex = new WebException("Max. redirections exceeded.", null, WebExceptionStatus.ProtocolError, response);
			item = true;
		}
		if (ex == null)
		{
			int num = (int)httpStatusCode;
			bool flag = false;
			if (allowAutoRedirect && num >= 300)
			{
				flag = Redirect(httpStatusCode, response);
				(item2, ex) = GetRewriteHandler(response, redirect: true);
				if (flag && !unsafe_auth_blah)
				{
					auth_state.Reset();
					proxy_auth_state.Reset();
				}
			}
			if (num >= 300 && num != 304)
			{
				item = true;
			}
			if (ex == null)
			{
				return (redirect: flag, mustReadAll: item, writeBuffer: item2, throwMe: null);
			}
		}
		if (!ThrowOnError)
		{
			return (redirect: false, mustReadAll: item, writeBuffer: null, throwMe: null);
		}
		if (writeStream != null)
		{
			writeStream.InternalClose();
			writeStream = null;
		}
		return (redirect: false, mustReadAll: item, writeBuffer: null, throwMe: ex);
	}

	internal static StringBuilder GenerateConnectionGroup(string connectionGroupName, bool unsafeConnectionGroup, bool isInternalGroup)
	{
		StringBuilder stringBuilder = new StringBuilder(connectionGroupName);
		stringBuilder.Append(unsafeConnectionGroup ? "U>" : "S>");
		if (isInternalGroup)
		{
			stringBuilder.Append("I>");
		}
		return stringBuilder;
	}

	[Obsolete("This API supports the .NET Framework infrastructure and is not intended to be used directly from your code.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public HttpWebRequest()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
