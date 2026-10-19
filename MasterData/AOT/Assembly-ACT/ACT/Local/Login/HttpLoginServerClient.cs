using System;
using System.Text;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;
using Google.Protobuf;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Pb;
using UnityEngine;
using UnityEngine.Networking;

namespace ACT.Local.Login;

public sealed class HttpLoginServerClient
{
	private const string LoginPath = "/api/login";

	private const string QueryServerVersionPath = "/api/queryServerVersion";

	private const int ServerVersionRequestTimeoutSeconds = 10;

	private static readonly HttpLoginServerClient ServerVersionClient = new HttpLoginServerClient();

	private static int _serverVersionRequestSequence;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void RegisterServerVersionUpdater()
	{
		LuminApplication.OnResourceVersionUpdated -= RequestServerVersion;
		LuminApplication.OnResourceVersionUpdated += RequestServerVersion;
	}

	private static void RequestServerVersion()
	{
		string text = LuminApplication.RemoteConfig?.ServerUrl;
		if (!string.IsNullOrWhiteSpace(text))
		{
			QueryServerVersionAndUpdateAsync(text, ++_serverVersionRequestSequence).Forget();
		}
	}

	private static async UniTaskVoid QueryServerVersionAndUpdateAsync(string serverUrl, int requestSequence)
	{
		try
		{
			string serverVersion = await ServerVersionClient.QueryServerVersionAsync(serverUrl, LuminApplication.SDKAccountId, LuminApplication.AppClientVersion, 10);
			if (requestSequence == _serverVersionRequestSequence)
			{
				LuminApplication.UpdateServerVersion(serverVersion);
			}
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[LoginHttp] Query server version failed: " + ex.Message);
			}
		}
	}

	public async UniTask<IMessage> LoginAsync(string loginUrl, LoginReq request, int timeoutSeconds)
	{
		if (request == null)
		{
			throw new ArgumentNullException("request");
		}
		if (!Uri.TryCreate(loginUrl, UriKind.Absolute, out var result) || (result.Scheme != Uri.UriSchemeHttp && result.Scheme != Uri.UriSchemeHttps))
		{
			throw new ArgumentException("Login URL must be an absolute HTTP or HTTPS URL.", "loginUrl");
		}
		Uri uri = BuildLoginEndpoint(result);
		string text = SerializeLoginRequest(request);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[LoginHttp] POST " + uri.AbsoluteUri + "\nRequest: " + SanitizeJson(text, "loginTicket"));
		}
		using UnityWebRequest webRequest = new UnityWebRequest(uri.AbsoluteUri, "POST");
		webRequest.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(text));
		webRequest.downloadHandler = new DownloadHandlerBuffer();
		webRequest.SetRequestHeader("Content-Type", "application/json; charset=utf-8");
		webRequest.timeout = Math.Max(1, timeoutSeconds);
		UnityWebRequestAsyncOperation operation = webRequest.SendWebRequest();
		await UniTask.WaitUntil(() => operation.isDone);
		if (webRequest.result == UnityWebRequest.Result.ConnectionError || webRequest.result == UnityWebRequest.Result.DataProcessingError)
		{
			throw new InvalidOperationException("Login HTTP request failed: " + webRequest.error);
		}
		string text2 = webRequest.downloadHandler?.text;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(string.Format("[LoginHttp] HTTP {0} {1}\nResponse: {2}", webRequest.responseCode, webRequest.result, SanitizeJson(text2, "loginKey", "aesKey")));
		}
		if (string.IsNullOrWhiteSpace(text2))
		{
			throw new InvalidOperationException($"Login server returned an empty response. HTTP {webRequest.responseCode}");
		}
		try
		{
			return ParseResponse(text2, webRequest.responseCode);
		}
		catch (Exception innerException) when (webRequest.result == UnityWebRequest.Result.ProtocolError)
		{
			throw new InvalidOperationException($"Login gateway returned HTTP {webRequest.responseCode} with a non-protocol response: {webRequest.error}", innerException);
		}
	}

	public async UniTask<string> QueryServerVersionAsync(string loginUrl, string sdkAid, string clientVersion, int timeoutSeconds)
	{
		if (!Uri.TryCreate(loginUrl, UriKind.Absolute, out var result) || (result.Scheme != Uri.UriSchemeHttp && result.Scheme != Uri.UriSchemeHttps))
		{
			throw new ArgumentException("Login URL must be an absolute HTTP or HTTPS URL.", "loginUrl");
		}
		Uri uri = BuildQueryServerVersionEndpoint(result);
		string text = new JObject
		{
			["sdkAid"] = sdkAid ?? string.Empty,
			["clientVersion"] = clientVersion ?? string.Empty
		}.ToString(Formatting.None);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[LoginHttp] POST " + uri.AbsoluteUri + "\nRequest: " + text);
		}
		using UnityWebRequest webRequest = new UnityWebRequest(uri.AbsoluteUri, "POST");
		webRequest.uploadHandler = new UploadHandlerRaw(Encoding.UTF8.GetBytes(text));
		webRequest.downloadHandler = new DownloadHandlerBuffer();
		webRequest.SetRequestHeader("Content-Type", "application/json; charset=utf-8");
		webRequest.timeout = Math.Max(1, timeoutSeconds);
		UnityWebRequestAsyncOperation operation = webRequest.SendWebRequest();
		await UniTask.WaitUntil(() => operation.isDone);
		if (webRequest.result == UnityWebRequest.Result.ConnectionError || webRequest.result == UnityWebRequest.Result.DataProcessingError)
		{
			throw new InvalidOperationException("Query server version HTTP request failed: " + webRequest.error);
		}
		string text2 = webRequest.downloadHandler?.text;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[LoginHttp] HTTP {webRequest.responseCode} {webRequest.result}\nResponse: {text2}");
		}
		if (string.IsNullOrWhiteSpace(text2))
		{
			throw new InvalidOperationException($"Login server returned an empty server-version response. HTTP {webRequest.responseCode}");
		}
		try
		{
			return ParseServerVersionResponse(text2, webRequest.responseCode);
		}
		catch (Exception innerException) when (webRequest.result == UnityWebRequest.Result.ProtocolError)
		{
			throw new InvalidOperationException($"Login gateway returned HTTP {webRequest.responseCode} while querying server version: {webRequest.error}", innerException);
		}
	}

	private static IMessage ParseResponse(string json, long statusCode)
	{
		JObject jObject = JObject.Parse(json);
		if (statusCode >= 200 && statusCode < 300 && jObject["errCode"] == null && jObject["codeType"] == null && jObject["codeModule"] == null && jObject["subCode"] == null)
		{
			return ParseLoginAck(jObject);
		}
		return ParseErrorAck(jObject);
	}

	private static string ParseServerVersionResponse(string json, long statusCode)
	{
		JObject jObject = JObject.Parse(json);
		if (statusCode < 200 || statusCode >= 300 || jObject["errCode"] != null || jObject["codeType"] != null || jObject["codeModule"] != null || jObject["subCode"] != null)
		{
			throw new InvalidOperationException("Query server version failed: " + ReadString(jObject, "message"));
		}
		string text = ReadString(jObject, "serverVersion");
		if (string.IsNullOrEmpty(text))
		{
			text = ReadString(jObject, "version");
		}
		if (string.IsNullOrEmpty(text) && jObject["data"] is JObject json2)
		{
			text = ReadString(json2, "serverVersion");
			if (string.IsNullOrEmpty(text))
			{
				text = ReadString(json2, "version");
			}
		}
		if (string.IsNullOrEmpty(text))
		{
			JToken? jToken = jObject["data"];
			if (jToken != null && jToken.Type == JTokenType.String)
			{
				text = jObject["data"].Value<string>();
			}
		}
		if (string.IsNullOrEmpty(text))
		{
			throw new InvalidOperationException("Login server response does not contain a server version.");
		}
		return text;
	}

	private static string SerializeLoginRequest(LoginReq request)
	{
		JObject jObject = new JObject();
		AddString(jObject, "loginTicket", request.LoginTicket);
		AddString(jObject, "openId", request.OpenId);
		AddString(jObject, "appVersion", request.AppVersion);
		if (request.AccountId != 0L)
		{
			jObject["accountId"] = request.AccountId.ToString();
		}
		AddString(jObject, "distinctID", request.DistinctID);
		if (request.IsEditor)
		{
			jObject["isEditor"] = true;
		}
		AddString(jObject, "env", request.Env);
		if (request.OperationalInfo != null)
		{
			OperationalInfo operationalInfo = request.OperationalInfo;
			JObject jObject2 = new JObject();
			AddString(jObject2, "platform", operationalInfo.Platform);
			AddString(jObject2, "device", operationalInfo.Device);
			AddString(jObject2, "operatingSystem", operationalInfo.OperatingSystem);
			AddString(jObject2, "clientVersion", operationalInfo.ClientVersion);
			AddString(jObject2, "deviceId", operationalInfo.DeviceId);
			if (operationalInfo.ViolationRecords.Count > 0)
			{
				JArray jArray = new JArray();
				foreach (ViolationRecord violationRecord in operationalInfo.ViolationRecords)
				{
					jArray.Add(new JObject
					{
						["id"] = violationRecord.Id,
						["num"] = violationRecord.Num
					});
				}
				jObject2["violationRecords"] = jArray;
			}
			if (operationalInfo.CountedBlackAccountIds.Count > 0)
			{
				JArray jArray2 = new JArray();
				foreach (long countedBlackAccountId in operationalInfo.CountedBlackAccountIds)
				{
					jArray2.Add(countedBlackAccountId.ToString());
				}
				jObject2["countedBlackAccountIds"] = jArray2;
			}
			jObject["operationalInfo"] = jObject2;
		}
		if (request.TdData != null)
		{
			TDClientData tdData = request.TdData;
			JObject jObject3 = new JObject();
			AddString(jObject3, "os", tdData.Os);
			AddString(jObject3, "osVersion", tdData.OsVersion);
			AddString(jObject3, "bundleId", tdData.BundleId);
			AddString(jObject3, "deviceId", tdData.DeviceId);
			AddString(jObject3, "deviceModel", tdData.DeviceModel);
			if (tdData.ScreenHeight != 0)
			{
				jObject3["screenHeight"] = tdData.ScreenHeight;
			}
			if (tdData.ScreenWidth != 0)
			{
				jObject3["screenWidth"] = tdData.ScreenWidth;
			}
			AddString(jObject3, "systemLan", tdData.SystemLan);
			AddString(jObject3, "cpu", tdData.Cpu);
			AddString(jObject3, "gpu", tdData.Gpu);
			AddString(jObject3, "channelId", tdData.ChannelId);
			AddString(jObject3, "cps", tdData.Cps);
			AddString(jObject3, "platform", tdData.Platform);
			jObject["tdData"] = jObject3;
		}
		return jObject.ToString(Formatting.None);
	}

	private static LoginAck ParseLoginAck(JObject json)
	{
		return new LoginAck
		{
			OpenId = ReadString(json, "openId"),
			LoginKey = ReadString(json, "loginKey"),
			AccountId = ReadInt64(json, "accountId"),
			GateAddr = ReadString(json, "gateAddr"),
			Code = ReadInt32(json, "code"),
			ServerGroup = ReadString(json, "serverGroup"),
			SdkAid = ReadInt64(json, "sdkAid"),
			AesKey = ReadBytes(json, "aesKey"),
			IsEncry = ReadBool(json, "isEncry"),
			FairTag = ReadInt32(json, "fairTag"),
			GateAddrBackup = ReadString(json, "gateAddrBackup")
		};
	}

	private static ErrorAck ParseErrorAck(JObject json)
	{
		ErrorAck errorAck = new ErrorAck
		{
			Code = ReadInt32(json, "code"),
			Message = ReadString(json, "message"),
			ErrCode = ReadString(json, "errCode"),
			CodeType = ReadInt32(json, "codeType"),
			CodeModule = ReadInt32(json, "codeModule"),
			SubCode = ReadInt32(json, "subCode")
		};
		if (json["param"] is JObject json2)
		{
			errorAck.Param = new ErrorParam
			{
				Uid = ReadInt64(json2, "uid"),
				BanEndTimestamp = ReadInt64(json2, "banEndTimestamp"),
				FairTag = ReadInt32(json2, "fairTag")
			};
		}
		return errorAck;
	}

	private static void AddString(JObject json, string name, string value)
	{
		if (!string.IsNullOrEmpty(value))
		{
			json[name] = value;
		}
	}

	private static string ReadString(JObject json, string name)
	{
		JToken? jToken = json[name];
		return ((jToken != null) ? jToken.Value<string>() : null) ?? string.Empty;
	}

	private static int ReadInt32(JObject json, string name)
	{
		if (json[name] != null)
		{
			return json[name].Value<int>();
		}
		return 0;
	}

	private static long ReadInt64(JObject json, string name)
	{
		if (json[name] != null)
		{
			return Convert.ToInt64(json[name].ToString());
		}
		return 0L;
	}

	private static bool ReadBool(JObject json, string name)
	{
		if (json[name] != null)
		{
			return json[name].Value<bool>();
		}
		return false;
	}

	private static ByteString ReadBytes(JObject json, string name)
	{
		string text = ReadString(json, name);
		if (!string.IsNullOrEmpty(text))
		{
			return ByteString.CopyFrom(Convert.FromBase64String(text));
		}
		return ByteString.Empty;
	}

	private static Uri BuildLoginEndpoint(Uri baseUri)
	{
		UriBuilder uriBuilder = new UriBuilder(baseUri);
		string text = uriBuilder.Path.TrimEnd('/');
		uriBuilder.Path = (text.EndsWith("/api/login", StringComparison.OrdinalIgnoreCase) ? text : (text + "/api/login"));
		return uriBuilder.Uri;
	}

	private static Uri BuildQueryServerVersionEndpoint(Uri baseUri)
	{
		UriBuilder uriBuilder = new UriBuilder(baseUri);
		string text = uriBuilder.Path.TrimEnd('/');
		if (text.EndsWith("/api/login", StringComparison.OrdinalIgnoreCase))
		{
			string text2 = text;
			int length = "/api/login".Length;
			text = text2.Substring(0, text2.Length - length);
		}
		uriBuilder.Path = (text.EndsWith("/api/queryServerVersion", StringComparison.OrdinalIgnoreCase) ? text : (text + "/api/queryServerVersion"));
		return uriBuilder.Uri;
	}

	private static string SanitizeJson(string json, params string[] sensitiveFields)
	{
		if (string.IsNullOrWhiteSpace(json))
		{
			return "<empty>";
		}
		try
		{
			JToken jToken = JToken.Parse(json);
			foreach (string text in sensitiveFields)
			{
				foreach (JToken item in jToken.SelectTokens("$.." + text))
				{
					item.Replace("<redacted>");
				}
			}
			return jToken.ToString(Formatting.None);
		}
		catch
		{
			return $"<non-json response, length={json.Length}>";
		}
	}
}
