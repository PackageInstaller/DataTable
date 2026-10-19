using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using UnityEngine;

namespace Proxima;

[HelpURL("https://www.unityproxima.com/docs")]
public class ProximaInspector : MonoBehaviour
{
	public enum ServerTypes
	{
		Remote,
		Embedded
	}

	private struct OpenStream
	{
		public ProximaConnection Connection;

		public string Id;

		public string Guid;

		public StreamInfo Info;
	}

	private class StreamInfo
	{
		public MethodInfo StartMethod;

		public MethodInfo StopMethod;

		public MethodInfo UpdateMethod;
	}

	[SerializeField]
	private string _displayName;

	[SerializeField]
	private int _port = 7759;

	[SerializeField]
	private string _password = "";

	[SerializeField]
	private bool _useHttps;

	[SerializeField]
	private PfxAsset _certificate;

	[SerializeField]
	private string _certificatePassword;

	[SerializeField]
	private bool _runOnEnable;

	[SerializeField]
	private int _logBufferSize = 1000;

	[SerializeField]
	private bool _instantiateStatusUI;

	[SerializeField]
	private bool _instantiateConnectUI;

	[SerializeField]
	private bool _dontDestroyOnLoad = true;

	[SerializeField]
	private bool _setRunInBackground = true;

	public ProximaStatus Status = new ProximaStatus();

	[HideInInspector]
	[SerializeField]
	private ServerTypes _serverType = ServerTypes.Embedded;

	[HideInInspector]
	[SerializeField]
	private string _serverUrl = "";

	public static int MaxGameObjectUpdatesPerFrame = 10;

	public static int MaxComponentUpdateFrequency = 10;

	private ProximaServer _server;

	private static List<MethodInfo> _inits = new List<MethodInfo>();

	private static List<MethodInfo> _teardowns = new List<MethodInfo>();

	private static Dictionary<string, MethodInfo> _commands = new Dictionary<string, MethodInfo>(StringComparer.OrdinalIgnoreCase);

	private static bool _staticInitialized;

	private static Dictionary<string, StreamInfo> _streams = new Dictionary<string, StreamInfo>(StringComparer.OrdinalIgnoreCase);

	private Dictionary<string, List<OpenStream>> _openStreams;

	private ProximaDispatcher _dispatcher;

	private ProximaStatusUI _statusUI;

	private ProximaConnectUI _connectUI;

	private bool _wasRunInBackgroundSet;

	public string DisplayName
	{
		get
		{
			return _displayName;
		}
		set
		{
			_displayName = value;
		}
	}

	public int Port
	{
		get
		{
			return _port;
		}
		set
		{
			_port = value;
		}
	}

	public string Password
	{
		get
		{
			return _password;
		}
		set
		{
			_password = value;
		}
	}

	public bool UseHttps
	{
		get
		{
			return _useHttps;
		}
		set
		{
			_useHttps = value;
		}
	}

	public PfxAsset Certificate
	{
		get
		{
			return _certificate;
		}
		set
		{
			_certificate = value;
		}
	}

	public string CertificatePassword
	{
		get
		{
			return _certificatePassword;
		}
		set
		{
			_certificatePassword = value;
		}
	}

	public bool StartOnEnable
	{
		get
		{
			return _runOnEnable;
		}
		set
		{
			_runOnEnable = value;
		}
	}

	public int LogBufferSize
	{
		get
		{
			return _logBufferSize;
		}
		set
		{
			ProximaLogCommands.SetLogCapacity(value);
		}
	}

	public bool InstantiateStatusUI
	{
		get
		{
			return _instantiateStatusUI;
		}
		set
		{
			_instantiateStatusUI = value;
		}
	}

	public bool InstantiateConnectUI
	{
		get
		{
			return _instantiateConnectUI;
		}
		set
		{
			_instantiateConnectUI = value;
		}
	}

	public ServerTypes ServerType
	{
		get
		{
			return _serverType;
		}
		set
		{
			_serverType = value;
		}
	}

	public string ServerUrl
	{
		get
		{
			return _serverUrl;
		}
		set
		{
			_serverUrl = value;
		}
	}

	public static Dictionary<string, MethodInfo> Commands => _commands;

	private void Awake()
	{
		if (!_staticInitialized)
		{
			RegisterBuiltInCommands();
			ProximaLogCommands.SetLogCapacity(_logBufferSize);
			_staticInitialized = true;
		}
		_dispatcher = new ProximaDispatcher(this);
		if (string.IsNullOrEmpty(_displayName))
		{
			_displayName = Application.companyName + "." + Application.productName + "." + Application.version;
		}
	}

	private void OnEnable()
	{
		if (_dontDestroyOnLoad)
		{
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}
		if (_runOnEnable)
		{
			Run();
		}
		if (_instantiateStatusUI)
		{
			_statusUI = UnityEngine.Object.Instantiate(Resources.Load<ProximaStatusUI>("Proxima/ProximaStatusUI"));
			_statusUI.ProximaInspector = this;
			_statusUI.transform.SetParent(transform);
		}
		if (_instantiateConnectUI)
		{
			_connectUI = UnityEngine.Object.Instantiate(Resources.Load<ProximaConnectUI>("Proxima/ProximaConnectUI"));
			_connectUI.ProximaInspector = this;
			_connectUI.GetComponent<ProximaStatusUI>().ProximaInspector = this;
			_connectUI.transform.SetParent(transform);
		}
	}

	private void OnApplicationQuit()
	{
		Stop();
	}

	private void OnDestroy()
	{
		Stop();
	}

	private void OnDisable()
	{
		Stop();
		if ((bool)_statusUI)
		{
			UnityEngine.Object.Destroy(_statusUI.gameObject);
			_statusUI = null;
		}
		if ((bool)_connectUI)
		{
			UnityEngine.Object.Destroy(_connectUI.gameObject);
			_connectUI = null;
		}
	}

	public void Run()
	{
		if (_server != null)
		{
			Log.Warning("Run was called, but Proxima is already running.");
			return;
		}
		if (string.IsNullOrWhiteSpace(_displayName))
		{
			Status.SetError("Display name is required to start Proxima.");
			Log.Error("Display name is required to start Proxima.");
			return;
		}
		if (string.IsNullOrWhiteSpace(_password))
		{
			Status.SetError("Password is required to start Proxima.");
			Log.Error("Password is required to start Proxima.");
			return;
		}
		foreach (MethodInfo init in _inits)
		{
			init.Invoke(null, null);
		}
		if (_setRunInBackground)
		{
			_wasRunInBackgroundSet = Application.runInBackground;
			Application.runInBackground = true;
		}
		Status.Reset();
		Status.SetRunning(running: true);
		Type type = Type.GetType("Proxima.ProximaRemoteServer");
		Type.GetType("Proxima.ProximaDemoServer");
		if (type != null && _serverType == ServerTypes.Remote)
		{
			_server = (ProximaServer)Activator.CreateInstance(type, _dispatcher, Status, _serverUrl);
		}
		else
		{
			_server = new ProximaEmbeddedServer(_dispatcher, Status, _port, _useHttps, _certificate, _certificatePassword);
		}
		try
		{
			_server.Start(_displayName, _password);
		}
		catch (Exception innerException)
		{
			if (innerException.InnerException != null)
			{
				innerException = innerException.InnerException;
			}
			Log.Exception(innerException);
			Status.SetError(innerException.Message);
			Status.SetRunning(running: false);
			Cleanup();
		}
	}

	public void Stop()
	{
		if (_server != null)
		{
			Log.Info("Proxima shutting down.");
			foreach (MethodInfo teardown in _teardowns)
			{
				teardown.Invoke(null, null);
			}
		}
		_server?.Stop();
		Status.Reset();
		Cleanup();
	}

	private void Cleanup()
	{
		if (_server != null && _setRunInBackground)
		{
			Application.runInBackground = _wasRunInBackgroundSet;
		}
		_server = null;
		_openStreams = null;
	}

	private void Update()
	{
		_dispatcher?.InvokeAll();
		if (_server == null)
		{
			return;
		}
		if (_server.TryGetMessage(out var message))
		{
			(ProximaConnection, string) tuple = message;
			ProximaConnection item = tuple.Item1;
			string item2 = tuple.Item2;
			MemoryStream memoryStream = HandleMessage(item, item2);
			if (memoryStream != null)
			{
				item.SendMessage(memoryStream);
			}
		}
		UpdateStreams();
	}

	private MemoryStream HandleMessage(ProximaConnection connection, string message)
	{
		ProximaRequest proximaRequest;
		try
		{
			proximaRequest = JsonUtility.FromJson<ProximaRequest>(message);
		}
		catch (Exception ex)
		{
			Log.Error("Failed to parse request: " + ex.Message);
			return ProximaSerialization.ErrorResponse(message, "Invalid request.");
		}
		if (proximaRequest.Type == ProximaRequestType.StartStream)
		{
			return HandleStreamStartRequest(connection, proximaRequest);
		}
		if (proximaRequest.Type == ProximaRequestType.StopStream)
		{
			return HandleStreamStopRequest(connection, proximaRequest);
		}
		if (proximaRequest.Type == ProximaRequestType.Command)
		{
			return HandleCommand(proximaRequest);
		}
		if (proximaRequest.Type == ProximaRequestType.List)
		{
			return ProximaSerialization.DataResponse(proximaRequest, "");
		}
		if (proximaRequest.Type == ProximaRequestType.Select)
		{
			return ProximaSerialization.ErrorResponse(proximaRequest, "Already selected.");
		}
		return ProximaSerialization.ErrorResponse(proximaRequest, "Invalid request type.");
	}

	private MemoryStream HandleStreamStartRequest(ProximaConnection connection, ProximaRequest request)
	{
		string cmd = request.Cmd;
		if (!_streams.TryGetValue(cmd, out var value))
		{
			return ProximaSerialization.ErrorResponse(request, "Invalid stream.");
		}
		if (_openStreams == null)
		{
			_openStreams = new Dictionary<string, List<OpenStream>>(StringComparer.OrdinalIgnoreCase);
		}
		if (!_openStreams.ContainsKey(cmd))
		{
			_openStreams.Add(cmd, new List<OpenStream>());
		}
		string text = Guid.NewGuid().ToString();
		if (value.StartMethod != null)
		{
			string[] array = new string[request.Args.Length + 1];
			array[0] = text;
			Array.Copy(request.Args, 0, array, 1, request.Args.Length);
			if (!TryInvoke(value.StartMethod, array, out var _, out var error))
			{
				return ProximaSerialization.ErrorResponse(request, error);
			}
		}
		OpenStream item = new OpenStream
		{
			Connection = connection,
			Id = request.Id,
			Guid = text,
			Info = value
		};
		_openStreams[cmd].Add(item);
		return null;
	}

	private MemoryStream HandleStreamStopRequest(ProximaConnection connection, ProximaRequest request)
	{
		string cmd = request.Cmd;
		if (!_streams.TryGetValue(cmd, out var value))
		{
			return ProximaSerialization.ErrorResponse(request, "Invalid stream name.");
		}
		if (_openStreams == null)
		{
			return ProximaSerialization.ErrorResponse(request, "Stream not open. (A)");
		}
		if (!_openStreams.TryGetValue(cmd, out var value2))
		{
			return ProximaSerialization.ErrorResponse(request, "Stream not open. (B)");
		}
		int num = value2.FindIndex((OpenStream os) => os.Connection == connection && os.Id == request.Id);
		if (num < 0)
		{
			return ProximaSerialization.ErrorResponse(request, "Stream not open. (C)");
		}
		string guid = value2[num].Guid;
		value2.RemoveAt(num);
		if (!TryInvoke(value.StopMethod, new string[1] { guid }, out var _, out var error))
		{
			return ProximaSerialization.ErrorResponse(request, error);
		}
		return ProximaSerialization.DataResponse(request, "<STREAM-END>");
	}

	private MemoryStream HandleCommand(ProximaRequest request)
	{
		if (!_commands.TryGetValue(request.Cmd, out var value))
		{
			return ProximaSerialization.ErrorResponse(request, "Method " + request.Cmd + " not found.");
		}
		if (!TryInvoke(value, request.Args, out var result, out var error))
		{
			return ProximaSerialization.ErrorResponse(request, error);
		}
		return ProximaSerialization.DataResponse(request, result);
	}

	private static StreamInfo GetOrCreateStreamInfo(string name)
	{
		if (!_streams.TryGetValue(name, out var value))
		{
			value = new StreamInfo();
			_streams.Add(name, value);
		}
		return value;
	}

	private void RegisterBuiltInCommands()
	{
		RegisterCommands<ProximaInternalCommands>();
		RegisterCommands<ProximaGameObjectCommands>();
		RegisterCommands<ProximaComponentCommands>();
		RegisterCommands<ProximaLogCommands>();
		RegisterCommands(typeof(ProximaPerformanceBenchmark));
		ProximaFeatures.RegisterProFeatures();
	}

	public static void RegisterCommands<T>()
	{
		RegisterCommands(typeof(T));
	}

	public static void RegisterCommands(Type type)
	{
		foreach (MethodInfo runtimeMethod in type.GetRuntimeMethods())
		{
			if (!runtimeMethod.IsStatic)
			{
				continue;
			}
			if (runtimeMethod.GetCustomAttribute<ProximaInitializeAttribute>() != null)
			{
				_inits.Add(runtimeMethod);
			}
			if (runtimeMethod.GetCustomAttribute<ProximaTeardownAttribute>() != null)
			{
				_teardowns.Add(runtimeMethod);
			}
			ProximaCommandAttribute customAttribute = runtimeMethod.GetCustomAttribute<ProximaCommandAttribute>();
			if (customAttribute != null)
			{
				if (_commands.ContainsKey(runtimeMethod.Name))
				{
					continue;
				}
				_commands.Add(runtimeMethod.Name, runtimeMethod);
				if (!string.IsNullOrWhiteSpace(customAttribute.Alias))
				{
					_commands.Add(customAttribute.Alias, runtimeMethod);
				}
			}
			ProximaStreamStartAttribute customAttribute2 = runtimeMethod.GetCustomAttribute<ProximaStreamStartAttribute>();
			if (customAttribute2 != null)
			{
				StreamInfo orCreateStreamInfo = GetOrCreateStreamInfo(customAttribute2.Name);
				if (orCreateStreamInfo.StartMethod != null)
				{
					throw new Exception("Multiple Proxima stream start methods found for stream " + type.Name + "." + customAttribute2.Name + ".");
				}
				orCreateStreamInfo.StartMethod = runtimeMethod;
			}
			ProximaStreamStopAttribute customAttribute3 = runtimeMethod.GetCustomAttribute<ProximaStreamStopAttribute>();
			if (customAttribute3 != null)
			{
				StreamInfo orCreateStreamInfo2 = GetOrCreateStreamInfo(customAttribute3.Name);
				if (orCreateStreamInfo2.StopMethod != null)
				{
					throw new Exception("Multiple Proxima stream stop methods found for stream " + type.Name + "." + customAttribute3.Name + ".");
				}
				orCreateStreamInfo2.StopMethod = runtimeMethod;
			}
			ProximaStreamUpdateAttribute customAttribute4 = runtimeMethod.GetCustomAttribute<ProximaStreamUpdateAttribute>();
			if (customAttribute4 != null)
			{
				StreamInfo orCreateStreamInfo3 = GetOrCreateStreamInfo(customAttribute4.Name);
				if (orCreateStreamInfo3.UpdateMethod != null)
				{
					throw new Exception("Multiple Proxima stream update methods found for stream " + type.Name + "." + customAttribute4.Name + ".");
				}
				orCreateStreamInfo3.UpdateMethod = runtimeMethod;
			}
		}
	}

	private void UpdateStreams()
	{
		if (_openStreams == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<OpenStream>> openStream in _openStreams)
		{
			List<OpenStream> value = openStream.Value;
			foreach (OpenStream item in value)
			{
				if (!item.Connection.Open)
				{
					TryInvoke(item.Info.StopMethod, new string[1] { item.Guid });
				}
			}
			value.RemoveAll((OpenStream os) => !os.Connection.Open);
			foreach (OpenStream item2 in value)
			{
				object obj = null;
				string text = null;
				try
				{
					obj = item2.Info.UpdateMethod?.Invoke(null, new object[1] { item2.Guid });
				}
				catch (Exception ex)
				{
					Debug.LogException(ex);
					text = ex.Message;
				}
				if (!string.IsNullOrEmpty(text))
				{
					item2.Connection.SendMessage(ProximaSerialization.ErrorResponse(item2.Id, text));
				}
				else if (obj != null)
				{
					item2.Connection.SendMessage(ProximaSerialization.DataResponse(item2.Id, obj));
				}
			}
		}
	}

	public static bool TryInvoke(MethodInfo method, string[] args)
	{
		object result;
		string error;
		return TryInvoke(method, args, out result, out error);
	}

	public static bool TryInvoke(MethodInfo method, string[] args, out object result, out string error)
	{
		result = null;
		error = string.Empty;
		if (method == null)
		{
			return true;
		}
		ParameterInfo[] parameters = method.GetParameters();
		object[] array = new object[parameters.Length];
		for (int i = 0; i < parameters.Length; i++)
		{
			ParameterInfo parameterInfo = parameters[i];
			if (args == null || args.Length <= i)
			{
				if (parameters[i].HasDefaultValue)
				{
					array[i] = parameters[i].DefaultValue;
					continue;
				}
				error = "Required argument " + parameterInfo.Name + " not found.";
				return false;
			}
			if (typeof(IPropertyOrValue).IsAssignableFrom(parameterInfo.ParameterType))
			{
				array[i] = Activator.CreateInstance(parameterInfo.ParameterType, args[i]);
				continue;
			}
			if (ProximaSerialization.TryDeserialize(parameterInfo.ParameterType, args[i], out var result2))
			{
				array[i] = result2;
				continue;
			}
			error = "Unable to deserialize argument " + parameterInfo.Name + " as " + parameterInfo.ParameterType.Name + ".";
			return false;
		}
		try
		{
			if (method.ReturnType == typeof(void))
			{
				method.Invoke(null, array);
			}
			else
			{
				result = method.Invoke(null, array);
			}
		}
		catch (Exception ex)
		{
			Log.Exception(ex);
			error = ex.InnerException.Message;
			return false;
		}
		return true;
	}
}
