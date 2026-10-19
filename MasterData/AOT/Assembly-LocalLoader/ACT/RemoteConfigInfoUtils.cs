using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using ACT.Error;
using AOT.CryptographyCode;
using UnityEngine;
using UnityEngine.Networking;

namespace ACT;

internal static class RemoteConfigInfoUtils
{
	[Serializable]
	private class RemoteConfigInfo
	{
		public int code;

		public string message;

		public RemoteConfigData data;
	}

	private const string InternalVersionPattern = "(.+)\\.([aiw])(\\d+)$";

	private static string _editorRemoteConfigRequestInternalVersion;

	private static readonly Dictionary<string, string> PlatformMap = new Dictionary<string, string>
	{
		{ "a", "Android" },
		{ "i", "iOS" },
		{ "w", "Win64" }
	};

	private const string RequestRemoteConfigParamPlatform = "target_platform";

	private const string RequestRemoteConfigParamBuild = "build_id";

	private const string RequestRemoteConfigParamRegion = "region";

	private const string RequestRemoteConfigParamEnv = "env";

	private const string RequestRemoteConfigParamChannel = "channel";

	private const string RequestRemoteConfigParamVersion = "client_version";

	private const string RequestRemoteConfigParamDevice = "device_id";

	private const string RequestRemoteConfigParamAssetsVersion = "assets_version";

	private const string RequestRemoteConfigParamRawfileVersion = "raw_file_version";

	private const string RequestRemoteConfigParamClientStaticVersion = "client_static_version";

	private const string RequestRemoteConfigParamDllVersion = "dll_version";

	private const string RequestRemoteConfigParamAid = "aid";

	private const string RequestRemoteConfigParamCpsGroup = "cps_group";

	private static string _requestRemoteConfigUrl = "https://lmapi-dev.zhuziplay.com/remote/config";

	private const string DefaultRequestRemoteConfigUrl = "https://lmapi-dev.zhuziplay.com/remote/config";

	public static IEnumerator LoadRemoteConfig(string region, string env, string channel, string clientVersion, string deviceId, int defaultPackageVersion, int rawfileVersion, int clientStaticVersion, int dllVersion, string aid, Action<bool, RemoteConfig> callback)
	{
		bool flag = !string.IsNullOrWhiteSpace(_editorRemoteConfigRequestInternalVersion);
		string text = (flag ? _editorRemoteConfigRequestInternalVersion : "dev.local");
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(string.Format("当前包内版本为: {0}， 是否本地包: {1}", "dev.local", LuminApplication.IsLocalVersion));
		}
		if (LuminApplication.IsLocalVersion && !flag)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("当前为本地包, 不请求远程配置");
			}
			callback?.Invoke(arg1: true, RemoteConfig.Empty);
			yield break;
		}
		string text2 = text;
		Match match = Regex.Match(text2, "(.+)\\.([aiw])(\\d+)$");
		if (match.Success && PlatformMap.TryGetValue(match.Groups[2].Value, out var value))
		{
			string value2 = match.Groups[1].Value;
			string value3 = match.Groups[3].Value;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"Send Request To Get Remote Config: [ branch:{value2}, build_Id:{value3}, target_platform:{value}, region:{region}, env:{env}, channel:{channel}, client_version:{clientVersion}, default_package_version:{defaultPackageVersion}, client_static_version:{clientStaticVersion}, dll_version:{dllVersion}@ {text2} ] => {_requestRemoteConfigUrl}");
			}
			yield return RequestRemoteConfig(value3, value, region, env, channel, clientVersion, deviceId, defaultPackageVersion, rawfileVersion, clientStaticVersion, dllVersion, aid, callback);
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("不匹配的版本信息！！");
			}
			callback?.Invoke(arg1: false, RemoteConfig.Empty);
		}
	}

	internal static void SetEditorRemoteConfigRequestInternalVersion(string internalVersion)
	{
	}

	internal static void SetOverrideRequestRemoteConfigUrl(string url)
	{
		_requestRemoteConfigUrl = (string.IsNullOrEmpty(url) ? "https://lmapi-dev.zhuziplay.com/remote/config" : (url + "/remote/config"));
	}

	private static void AppendFormParam(WWWForm form, string key, string value, ref string logStr, bool checkEmpty = false)
	{
		if (checkEmpty && string.IsNullOrEmpty(value))
		{
			return;
		}
		if (logStr != null)
		{
			if (logStr.Length > 0)
			{
				logStr += "&";
			}
			logStr = logStr + key + "=" + value;
		}
		form.AddField(key, value);
	}

	private static IEnumerator RequestRemoteConfig(string buildId, string platform, string region, string env, string channel, string clientVersion, string deviceId, int assetsVersion, int rawfileVersion, int clientStaticVersion, int dllVersion, string aid, Action<bool, RemoteConfig> callback)
	{
		WWWForm wWWForm = new WWWForm();
		string logStr = null;
		if (LuminApplication.LogEnabled)
		{
			logStr = string.Empty;
		}
		AppendFormParam(wWWForm, "build_id", buildId, ref logStr);
		AppendFormParam(wWWForm, "target_platform", platform, ref logStr);
		AppendFormParam(wWWForm, "region", region, ref logStr);
		AppendFormParam(wWWForm, "env", env, ref logStr);
		AppendFormParam(wWWForm, "channel", channel, ref logStr);
		AppendFormParam(wWWForm, "client_version", clientVersion, ref logStr);
		AppendFormParam(wWWForm, "device_id", deviceId, ref logStr, checkEmpty: true);
		AppendFormParam(wWWForm, "assets_version", assetsVersion.ToString(), ref logStr);
		AppendFormParam(wWWForm, "raw_file_version", rawfileVersion.ToString(), ref logStr);
		AppendFormParam(wWWForm, "client_static_version", clientStaticVersion.ToString(), ref logStr);
		AppendFormParam(wWWForm, "dll_version", dllVersion.ToString(), ref logStr);
		AppendFormParam(wWWForm, "aid", aid, ref logStr);
		AppendFormParam(wWWForm, "cps_group", LuminApplication.AppCpsGroup, ref logStr);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("Send URL Request: " + _requestRemoteConfigUrl + "?" + logStr);
		}
		using UnityWebRequest request = BambooSafeHttpRequest.Post(_requestRemoteConfigUrl, wWWForm);
		yield return request.SendWebRequest();
		if (request.result != UnityWebRequest.Result.Success)
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0007", "01", 0, request.responseCode.ToString());
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[C01-0007] Request Remote Config Network Error: " + request.error);
			}
			callback?.Invoke(arg1: false, null);
			yield break;
		}
		string text = Encoding.UTF8.GetString(request.downloadHandler.data);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[Request Remote Config] Response: " + text);
		}
		RemoteConfigInfo remoteConfigInfo = JsonUtility.FromJson<RemoteConfigInfo>(text);
		RemoteConfig remoteConfig = null;
		if (remoteConfigInfo.code == 0)
		{
			remoteConfig = RemoteConfig.Restore(remoteConfigInfo.data);
		}
		else
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0008", "01", 0, $"[{remoteConfigInfo.code}]:{remoteConfigInfo.message}");
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[C01-0008] Parse Remote Config Failed[{remoteConfigInfo.code}]: {remoteConfigInfo.message}!!");
			}
		}
		callback(remoteConfig != null, remoteConfig);
	}
}
