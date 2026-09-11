using System.IO;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class WebConnectionTunnel
{
	private enum NtlmAuthState
	{
		None,
		Challenge,
		Response
	}

	private HttpWebRequest connectRequest;

	private NtlmAuthState ntlmAuthState;

	[CompilerGenerated]
	private string _003CStatusDescription_003Ek__BackingField;

	public HttpWebRequest Request { get; }

	public Uri ConnectUri { get; }

	public bool Success { get; private set; }

	public bool CloseConnection { get; private set; }

	public int StatusCode { get; private set; }

	private string StatusDescription
	{
		[CompilerGenerated]
		set
		{
			_003CStatusDescription_003Ek__BackingField = value;
		}
	}

	public string[] Challenge { get; private set; }

	public WebHeaderCollection Headers { get; private set; }

	public Version ProxyVersion { get; private set; }

	public byte[] Data { get; private set; }

	public WebConnectionTunnel(HttpWebRequest request, Uri connectUri)
	{
		Request = request;
		ConnectUri = connectUri;
	}

	internal async Task Initialize(Stream stream, CancellationToken cancellationToken)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("CONNECT ");
		stringBuilder.Append(Request.Address.Host);
		stringBuilder.Append(':');
		stringBuilder.Append(Request.Address.Port);
		stringBuilder.Append(" HTTP/");
		if (Request.ProtocolVersion == HttpVersion.Version11)
		{
			stringBuilder.Append("1.1");
		}
		else
		{
			stringBuilder.Append("1.0");
		}
		stringBuilder.Append("\r\nHost: ");
		stringBuilder.Append(Request.Address.Authority);
		bool flag = false;
		string[] challenge = Challenge;
		Challenge = null;
		string text = Request.Headers["Proxy-Authorization"];
		bool have_auth = text != null;
		if (have_auth)
		{
			stringBuilder.Append("\r\nProxy-Authorization: ");
			stringBuilder.Append(text);
			flag = text.ToUpper().Contains("NTLM");
		}
		else if (challenge != null && StatusCode == 407)
		{
			ICredentials credentials = Request.Proxy.Credentials;
			have_auth = true;
			if (connectRequest == null)
			{
				connectRequest = (HttpWebRequest)WebRequest.Create(ConnectUri.Scheme + "://" + ConnectUri.Host + ":" + ConnectUri.Port + "/");
				connectRequest.Method = "CONNECT";
				connectRequest.Credentials = credentials;
			}
			if (credentials != null)
			{
				for (int i = 0; i < challenge.Length; i++)
				{
					Authorization authorization = AuthenticationManager.Authenticate(challenge[i], connectRequest, credentials);
					if (authorization != null)
					{
						flag = authorization.ModuleAuthenticationType == "NTLM";
						stringBuilder.Append("\r\nProxy-Authorization: ");
						stringBuilder.Append(authorization.Message);
						break;
					}
				}
			}
		}
		if (flag)
		{
			stringBuilder.Append("\r\nProxy-Connection: keep-alive");
			ntlmAuthState++;
		}
		stringBuilder.Append("\r\n\r\n");
		StatusCode = 0;
		byte[] bytes = Encoding.Default.GetBytes(stringBuilder.ToString());
		await stream.WriteAsync(bytes, 0, bytes.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		(Headers, Data, StatusCode) = await ReadHeaders(stream, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		if ((!have_auth || ntlmAuthState == NtlmAuthState.Challenge) && Headers != null && StatusCode == 407)
		{
			string text2 = Headers["Connection"];
			if (!string.IsNullOrEmpty(text2) && text2.ToLower() == "close")
			{
				CloseConnection = true;
			}
			Challenge = Headers.GetValues("Proxy-Authenticate");
			Success = false;
		}
		else
		{
			Success = StatusCode == 200 && Headers != null;
		}
		if (Challenge == null && (StatusCode == 401 || StatusCode == 407))
		{
			HttpWebResponse response = new HttpWebResponse(ConnectUri, "CONNECT", (HttpStatusCode)StatusCode, Headers);
			throw new WebException((StatusCode == 407) ? "(407) Proxy Authentication Required" : "(401) Unauthorized", null, WebExceptionStatus.ProtocolError, response);
		}
	}

	private async Task<(WebHeaderCollection, byte[], int)> ReadHeaders(Stream stream, CancellationToken cancellationToken)
	{
		byte[] retBuffer = null;
		int status = 200;
		byte[] buffer = new byte[1024];
		MemoryStream ms = new MemoryStream();
		while (true)
		{
			cancellationToken.ThrowIfCancellationRequested();
			int num = await stream.ReadAsync(buffer, 0, 1024, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num == 0)
			{
				break;
			}
			ms.Write(buffer, 0, num);
			int start = 0;
			string output = null;
			bool flag = false;
			WebHeaderCollection webHeaderCollection = new WebHeaderCollection();
			while (WebConnection.ReadLine(ms.GetBuffer(), ref start, (int)ms.Length, ref output))
			{
				if (output == null)
				{
					string text = webHeaderCollection["Content-Length"];
					if (string.IsNullOrEmpty(text) || !int.TryParse(text, out var result))
					{
						result = 0;
					}
					if (ms.Length - start - result > 0)
					{
						retBuffer = new byte[ms.Length - start - result];
						Buffer.BlockCopy(ms.GetBuffer(), start + result, retBuffer, 0, retBuffer.Length);
					}
					else
					{
						FlushContents(stream, result - (int)(ms.Length - start));
					}
					return (webHeaderCollection, retBuffer, status);
				}
				if (flag)
				{
					webHeaderCollection.Add(output);
					continue;
				}
				string[] array = output.Split(' ');
				if (array.Length < 2)
				{
					throw WebConnection.GetException(WebExceptionStatus.ServerProtocolViolation, null);
				}
				if (string.Compare(array[0], "HTTP/1.1", ignoreCase: true) == 0)
				{
					ProxyVersion = HttpVersion.Version11;
				}
				else
				{
					if (string.Compare(array[0], "HTTP/1.0", ignoreCase: true) != 0)
					{
						throw WebConnection.GetException(WebExceptionStatus.ServerProtocolViolation, null);
					}
					ProxyVersion = HttpVersion.Version10;
				}
				status = (int)uint.Parse(array[1]);
				if (array.Length >= 3)
				{
					StatusDescription = string.Join(" ", array, 2, array.Length - 2);
				}
				flag = true;
			}
		}
		throw WebConnection.GetException(WebExceptionStatus.ServerProtocolViolation, null);
	}

	private void FlushContents(Stream stream, int contentLength)
	{
		while (contentLength > 0)
		{
			byte[] buffer = new byte[contentLength];
			int num = stream.Read(buffer, 0, contentLength);
			if (num > 0)
			{
				contentLength -= num;
				continue;
			}
			break;
		}
	}
}
