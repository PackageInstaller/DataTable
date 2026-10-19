using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using ProximaWebSocketSharp;
using ProximaWebSocketSharp.Net;
using ProximaWebSocketSharp.Server;
using UnityEngine;

namespace Proxima;

internal class ProximaEmbeddedServer : ProximaServer
{
	private ConcurrentQueue<(ProximaConnection, string)> _receiveQueue;

	private HttpServer _server;

	private ProximaDispatcher _dispatcher;

	private int _port;

	private bool _useHttps;

	private PfxAsset _cert;

	private string _certPass;

	private Dictionary<string, ProximaStatic.StaticFile> _pathToFile;

	private ProximaStatus _status;

	private byte[] _luminPerformanceBenchmarkPanelBytes;

	private const string LuminPerformanceBenchmarkPanelPath = "lumin-performance-benchmark.js";

	public ProximaEmbeddedServer(ProximaDispatcher dispatcher, ProximaStatus status, int port, bool useHttps, PfxAsset cert, string certPass)
	{
		_dispatcher = dispatcher;
		_port = port;
		_useHttps = useHttps;
		_cert = cert;
		_certPass = certPass;
		_status = status;
		if (_useHttps && _cert == null)
		{
			_cert = Resources.Load<PfxAsset>("Proxima/ProximaEmbeddedCert");
			_certPass = "proximapass";
		}
		ProximaStatic proximaStatic = Resources.Load<ProximaStatic>("Proxima/web");
		_pathToFile = new Dictionary<string, ProximaStatic.StaticFile>();
		foreach (ProximaStatic.StaticFile file in proximaStatic.Files)
		{
			_pathToFile.Add(file.Path, file);
		}
		TextAsset textAsset = Resources.Load<TextAsset>("Proxima/LuminPerformanceBenchmarkPanel.js");
		if (textAsset != null)
		{
			_luminPerformanceBenchmarkPanelBytes = Encoding.UTF8.GetBytes(textAsset.text);
		}
	}

	public void Start(string displayName, string password)
	{
		_server = new HttpServer(IPAddress.Any, _port, _useHttps);
		_server.Log.Level = LogLevel.Trace;
		if (_useHttps)
		{
			_server.SslConfiguration.ServerCertificate = new X509Certificate2(_cert.Bytes, _certPass);
			_server.SslConfiguration.EnabledSslProtocols = SslProtocols.Tls12;
		}
		DateTime epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
		_server.OnGet += (object sender, HttpRequestEventArgs e) =>
		{
			HttpListenerRequest request = e.Request;
			HttpListenerResponse response = e.Response;
			string text = request.RawUrl.Split('?')[0];
			text = ((text == "/") ? "index.html" : text.Substring(1));
			ProximaStatic.StaticFile value;
			if (text == "lumin-performance-benchmark.js" && _luminPerformanceBenchmarkPanelBytes != null)
			{
				response.AppendHeader("Cache-Control", "no-store");
				response.ContentEncoding = Encoding.UTF8;
				response.ContentType = "application/javascript; charset=utf-8";
				response.ContentLength64 = _luminPerformanceBenchmarkPanelBytes.Length;
				response.OutputStream.Write(_luminPerformanceBenchmarkPanelBytes, 0, _luminPerformanceBenchmarkPanelBytes.Length);
				response.Close();
			}
			else if (_pathToFile.TryGetValue(text, out value) || _pathToFile.TryGetValue(text + ".html", out value))
			{
				byte[] bytes = value.Bytes;
				int num;
				if (value.Path == "index.html")
				{
					num = ((_luminPerformanceBenchmarkPanelBytes != null) ? 1 : 0);
					if (num != 0)
					{
						response.AppendHeader("Cache-Control", "no-store");
						string text2 = Encoding.UTF8.GetString(value.Bytes);
						text2 = text2.Replace("</head>", "<script src=\"./lumin-performance-benchmark.js\"></script></head>");
						bytes = Encoding.UTF8.GetBytes(text2);
					}
				}
				else
				{
					num = 0;
				}
				DateTime dateTime = epoch.AddMilliseconds(value.LastModified);
				if (num == 0 && request.Headers.AllKeys.Contains("If-Modified-Since"))
				{
					string dateString = request.Headers["If-Modified-Since"];
					try
					{
						if (HttpDateParse.ParseHttpDate(dateString, out var dtOut))
						{
							dtOut = dtOut.ToUniversalTime();
							if (dateTime <= dtOut)
							{
								response.StatusCode = 304;
								response.Close();
								return;
							}
						}
					}
					catch (Exception)
					{
					}
				}
				string value2 = $"{dateTime:ddd, dd MMM yyyy HH:mm:ss} GMT";
				response.AppendHeader("Last-Modified", value2);
				response.ContentEncoding = Encoding.UTF8;
				response.ContentType = ProximaMimeTypes.Get(Path.GetExtension(value.Path));
				response.ContentLength64 = bytes.Length;
				response.OutputStream.Write(bytes, 0, bytes.Length);
				response.Close();
			}
			else
			{
				response.StatusCode = 404;
				response.Close();
			}
		};
		_receiveQueue = new ConcurrentQueue<(ProximaConnection, string)>();
		_server.AddWebSocketService("/api", (ProximaEmbeddedConnection api) =>
		{
			api.Initialize(displayName, password, _dispatcher, _status, _receiveQueue);
		});
		_server.Start();
		UpdateConnectionInfo();
	}

	public async void UpdateConnectionInfo()
	{
		string text = await GetIpAddress();
		string text2 = (_useHttps ? "https" : "http") + "://" + text + ":" + _port;
		Log.Info("Proxima Inspector started on " + text2);
		_status.SetConnectInfo(text2);
	}

	private async Task<string> GetIpAddress()
	{
		try
		{
			using Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
			Task task = socket.ConnectAsync("8.8.8.8", 53);
			await Task.WhenAny(task, Task.Delay(100));
			if (task.Status == TaskStatus.RanToCompletion)
			{
				return socket.LocalEndPoint.ToString().Split(':')[0];
			}
		}
		catch (Exception e)
		{
			Log.Exception(e);
		}
		return Dns.GetHostEntry(Dns.GetHostName()).AddressList.First((IPAddress f) => f.AddressFamily == AddressFamily.InterNetwork).ToString();
	}

	public void Stop()
	{
		_server?.Stop();
		_server = null;
		_receiveQueue = null;
	}

	public bool TryGetMessage(out (ProximaConnection, string) message)
	{
		if (_receiveQueue != null)
		{
			return _receiveQueue.TryDequeue(out message);
		}
		message = (null, "");
		return false;
	}
}
