using System.Collections;
using System.IO;
using System.Net.Cache;
using System.Net.Configuration;
using System.Net.Security;
using System.Runtime.Serialization;
using System.Security.Principal;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

[Serializable]
public abstract class WebRequest : MarshalByRefObject, ISerializable
{
	internal class DesignerWebRequestCreate : IWebRequestCreate
	{
		public WebRequest Create(Uri uri)
		{
			return WebRequest.Create(uri);
		}
	}

	private static volatile ArrayList s_PrefixList;

	private static object s_InternalSyncObject;

	private static TimerThread.Queue s_DefaultTimerQueue = TimerThread.CreateQueue(100000);

	private AuthenticationLevel m_AuthenticationLevel;

	private TokenImpersonationLevel m_ImpersonationLevel;

	private RequestCachePolicy m_CachePolicy;

	private RequestCacheProtocol m_CacheProtocol;

	private RequestCacheBinding m_CacheBinding;

	private static DesignerWebRequestCreate webRequestCreate = new DesignerWebRequestCreate();

	private static volatile IWebProxy s_DefaultWebProxy;

	private static volatile bool s_DefaultWebProxyInitialized;

	private static object InternalSyncObject
	{
		get
		{
			if (s_InternalSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange(ref s_InternalSyncObject, value, null);
			}
			return s_InternalSyncObject;
		}
	}

	internal static ArrayList PrefixList
	{
		get
		{
			if (s_PrefixList == null)
			{
				lock (InternalSyncObject)
				{
					if (s_PrefixList == null)
					{
						s_PrefixList = PopulatePrefixList();
					}
				}
			}
			return s_PrefixList;
		}
	}

	public static RequestCachePolicy DefaultCachePolicy => RequestCacheManager.GetBinding(string.Empty).Policy;

	public virtual RequestCachePolicy CachePolicy
	{
		set
		{
			InternalSetCachePolicy(value);
		}
	}

	public virtual string Method
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

	public virtual Uri RequestUri
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual string ConnectionGroupName
	{
		set
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
		set
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual ICredentials Credentials
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

	public virtual bool UseDefaultCredentials
	{
		get
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual IWebProxy Proxy
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

	public virtual bool PreAuthenticate
	{
		set
		{
			throw ExceptionHelper.PropertyNotImplementedException;
		}
	}

	public virtual int Timeout
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

	internal RequestCacheProtocol CacheProtocol
	{
		get
		{
			return m_CacheProtocol;
		}
		set
		{
			m_CacheProtocol = value;
		}
	}

	internal static IWebProxy InternalDefaultWebProxy
	{
		get
		{
			if (!s_DefaultWebProxyInitialized)
			{
				lock (InternalSyncObject)
				{
					if (!s_DefaultWebProxyInitialized)
					{
						DefaultProxySectionInternal section = DefaultProxySectionInternal.GetSection();
						if (section != null)
						{
							s_DefaultWebProxy = section.WebProxy;
						}
						s_DefaultWebProxyInitialized = true;
					}
				}
			}
			return s_DefaultWebProxy;
		}
	}

	private static WebRequest Create(Uri requestUri, bool useUriBase)
	{
		_ = Logging.On;
		WebRequestPrefixElement webRequestPrefixElement = null;
		bool flag = false;
		string text = (useUriBase ? (requestUri.Scheme + ":") : requestUri.AbsoluteUri);
		int length = text.Length;
		ArrayList prefixList = PrefixList;
		for (int i = 0; i < prefixList.Count; i++)
		{
			webRequestPrefixElement = (WebRequestPrefixElement)prefixList[i];
			if (length >= webRequestPrefixElement.Prefix.Length && string.Compare(webRequestPrefixElement.Prefix, 0, text, 0, webRequestPrefixElement.Prefix.Length, StringComparison.OrdinalIgnoreCase) == 0)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			WebRequest result = webRequestPrefixElement.Creator.Create(requestUri);
			_ = Logging.On;
			return result;
		}
		_ = Logging.On;
		throw new NotSupportedException(global::SR.GetString("The URI prefix is not recognized."));
	}

	public static WebRequest Create(string requestUriString)
	{
		if (requestUriString == null)
		{
			throw new ArgumentNullException("requestUriString");
		}
		return Create(new Uri(requestUriString), useUriBase: false);
	}

	public static WebRequest Create(Uri requestUri)
	{
		if (requestUri == null)
		{
			throw new ArgumentNullException("requestUri");
		}
		return Create(requestUri, useUriBase: false);
	}

	private static ArrayList PopulatePrefixList()
	{
		ArrayList arrayList = new ArrayList();
		IWebRequestCreate c = new HttpRequestCreator();
		arrayList.Add(new WebRequestPrefixElement("http", c));
		arrayList.Add(new WebRequestPrefixElement("https", c));
		arrayList.Add(new WebRequestPrefixElement("file", new FileWebRequestCreator()));
		arrayList.Add(new WebRequestPrefixElement("ftp", new FtpWebRequestCreator()));
		return arrayList;
	}

	protected WebRequest()
	{
		m_ImpersonationLevel = TokenImpersonationLevel.Delegation;
		m_AuthenticationLevel = AuthenticationLevel.MutualAuthRequested;
	}

	protected WebRequest(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	protected virtual void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
	}

	private void InternalSetCachePolicy(RequestCachePolicy policy)
	{
		if (m_CacheBinding != null && m_CacheBinding.Cache != null && m_CacheBinding.Validator != null && CacheProtocol == null && policy != null && policy.Level != RequestCacheLevel.BypassCache)
		{
			CacheProtocol = new RequestCacheProtocol(m_CacheBinding.Cache, m_CacheBinding.Validator.CreateValidator());
		}
		m_CachePolicy = policy;
	}

	public virtual Stream GetRequestStream()
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual WebResponse GetResponse()
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual IAsyncResult BeginGetResponse(AsyncCallback callback, object state)
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual WebResponse EndGetResponse(IAsyncResult asyncResult)
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual IAsyncResult BeginGetRequestStream(AsyncCallback callback, object state)
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual Stream EndGetRequestStream(IAsyncResult asyncResult)
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}

	public virtual Task<Stream> GetRequestStreamAsync()
	{
		IWebProxy webProxy = null;
		try
		{
			webProxy = Proxy;
		}
		catch (NotImplementedException)
		{
		}
		if (ExecutionContext.IsFlowSuppressed() && (UseDefaultCredentials || Credentials != null || (webProxy != null && webProxy.Credentials != null)))
		{
			WindowsIdentity currentUser = SafeCaptureIdenity();
			return Task.Run(delegate
			{
				using (currentUser)
				{
					using (currentUser.Impersonate())
					{
						return Task<Stream>.Factory.FromAsync(BeginGetRequestStream, EndGetRequestStream, null);
					}
				}
			});
		}
		return Task.Run(() => Task<Stream>.Factory.FromAsync(BeginGetRequestStream, EndGetRequestStream, null));
	}

	public virtual Task<WebResponse> GetResponseAsync()
	{
		IWebProxy webProxy = null;
		try
		{
			webProxy = Proxy;
		}
		catch (NotImplementedException)
		{
		}
		if (ExecutionContext.IsFlowSuppressed() && (UseDefaultCredentials || Credentials != null || (webProxy != null && webProxy.Credentials != null)))
		{
			WindowsIdentity currentUser = SafeCaptureIdenity();
			return Task.Run(delegate
			{
				using (currentUser)
				{
					using (currentUser.Impersonate())
					{
						return Task<WebResponse>.Factory.FromAsync(BeginGetResponse, EndGetResponse, null);
					}
				}
			});
		}
		return Task.Run(() => Task<WebResponse>.Factory.FromAsync(BeginGetResponse, EndGetResponse, null));
	}

	private WindowsIdentity SafeCaptureIdenity()
	{
		return WindowsIdentity.GetCurrent();
	}

	public virtual void Abort()
	{
		throw ExceptionHelper.MethodNotImplementedException;
	}
}
