using System;
using ACT.LocalLoader;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Networking;
using bamboosdk;

namespace ACT;

internal class ReadGameVersionInfo : GameLoadingFlowBase
{
	private LuminBambooBridgeListener _listener;

	private string _clientCommitId;

	private string _tableCommitId;

	private string _dllCommitId;

	private string _rawFileCommitId;

	internal override EGameLoadingStage Stage => EGameLoadingStage.ReadGameVersionInfo;

	internal ReadGameVersionInfo(LuminBambooBridgeListener listener)
	{
		_listener = listener;
	}

	internal override void Init(GameLoadingData data)
	{
		if (LuminApplication.IsLocalVersion)
		{
			_loadState = EGameLoadingState.Succeed;
			return;
		}
		_loadState = EGameLoadingState.Loading;
		ReadCommitIdFiles().Forget();
	}

	internal override void Update()
	{
	}

	private async UniTaskVoid ReadCommitIdFiles()
	{
		_ = 3;
		try
		{
			_clientCommitId = await ReadCommitIdFromRemote(AssetType.Assets, "Assets");
			_tableCommitId = await ReadCommitIdFromRemote(AssetType.ClientStatic, "ClientStatic");
			_dllCommitId = await ReadCommitIdFromRemote(AssetType.Dll, "Dll");
			string dllCommitId = _dllCommitId;
			_rawFileCommitId = await ReadCommitIdFromRemote(AssetType.RawFile, "RawFile");
			if (!string.IsNullOrEmpty(_clientCommitId) && !string.IsNullOrEmpty(_tableCommitId) && !string.IsNullOrEmpty(dllCommitId) && !string.IsNullOrEmpty(_rawFileCommitId))
			{
				LuminApplication.UpdateResourceVersion(_clientCommitId, _tableCommitId, dllCommitId, _rawFileCommitId);
				LuminApplication.SaveCommitIds(_clientCommitId, _tableCommitId, dllCommitId, _rawFileCommitId);
				AotConstValues.ClearProperties();
				_listener.SetBBSuperProperties(AotConstValues.TaPublicProperties);
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			Debug.LogError("[ReadGameVersionInfo] 读取CommitId失败: ClientCommitId=" + _clientCommitId + ", TableCommitId=" + _tableCommitId + ", DllCommitId=" + dllCommitId + ", RawFileCommitId=" + _rawFileCommitId);
			_loadState = EGameLoadingState.Failed;
		}
		catch (Exception arg)
		{
			Debug.LogError($"[ReadGameVersionInfo] 读取CommitId异常: {arg}");
			_loadState = EGameLoadingState.Failed;
		}
	}

	private async UniTask<string> ReadCommitIdFromRemote(AssetType assetType, string packageName)
	{
		string manifestPrefix = LuminApplication.GetManifestPath(assetType);
		string version = GetPackageVersion(packageName);
		if (LuminApplication.RemoteConfig == null)
		{
			Debug.LogError("[ReadGameVersionInfo] RemoteConfig 为空，无法读取 CommitId");
			return string.Empty;
		}
		string primaryUrl = BuildCommitIdUrl(LuminApplication.GetCDNPath(assetType), manifestPrefix, packageName, version);
		string text = await FetchCommitIdOnce(primaryUrl, packageName, "主CDN");
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		string backUpCDNPath = LuminApplication.GetBackUpCDNPath(assetType);
		if (string.IsNullOrWhiteSpace(backUpCDNPath))
		{
			Debug.LogError("[ReadGameVersionInfo] 主CDN失败且无备用CDN，读取" + packageName + "的CommitId失败");
			return string.Empty;
		}
		if (UrlsSameHostAndPath(primaryUrl, BuildCommitIdUrl(backUpCDNPath, manifestPrefix, packageName, version)))
		{
			Debug.LogError("[ReadGameVersionInfo] 主CDN与备用CDN地址相同，读取" + packageName + "的CommitId失败");
			return string.Empty;
		}
		string commitIdUrl = BuildCommitIdUrl(backUpCDNPath, manifestPrefix, packageName, version);
		text = await FetchCommitIdOnce(commitIdUrl, packageName, "备用CDN");
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		Debug.LogError("[ReadGameVersionInfo] 主CDN与备用CDN均失败，读取" + packageName + "的CommitId失败");
		return string.Empty;
	}

	private static string BuildCommitIdUrl(string cdnBase, string manifestPrefix, string packageName, string version)
	{
		if (string.IsNullOrWhiteSpace(cdnBase))
		{
			return null;
		}
		string text = cdnBase.TrimEnd('/');
		return text + manifestPrefix + "/" + packageName + "/" + version + "/CommitId";
	}

	private static bool UrlsSameHostAndPath(string a, string b)
	{
		if (string.IsNullOrEmpty(a) || string.IsNullOrEmpty(b))
		{
			return false;
		}
		try
		{
			Uri uri = new Uri(a);
			return string.Equals(b: new Uri(b).GetLeftPart(UriPartial.Path), a: uri.GetLeftPart(UriPartial.Path), comparisonType: StringComparison.OrdinalIgnoreCase);
		}
		catch
		{
			return string.Equals(a.TrimEnd('/'), b.TrimEnd('/'), StringComparison.OrdinalIgnoreCase);
		}
	}

	private async UniTask<string> FetchCommitIdOnce(string commitIdUrl, string packageName, string cdnLabel)
	{
		if (string.IsNullOrEmpty(commitIdUrl))
		{
			Debug.LogWarning("[ReadGameVersionInfo] " + cdnLabel + " CommitId URL 为空，跳过 (" + packageName + ")");
			return string.Empty;
		}
		using UnityWebRequest request = UnityWebRequest.Get(commitIdUrl);
		await request.SendWebRequest();
		if (request.result == UnityWebRequest.Result.Success)
		{
			string text = request.downloadHandler.text;
			Debug.Log("[ReadGameVersionInfo] [" + cdnLabel + "] 读取" + packageName + "的CommitId: " + text);
			return text;
		}
		Debug.LogWarning("[ReadGameVersionInfo] [" + cdnLabel + "] 读取" + packageName + "的CommitId失败: " + commitIdUrl + ", " + request.error);
		return string.Empty;
	}

	private string GetPackageVersion(string packageName)
	{
		return packageName switch
		{
			"Assets" => LuminApplication.RemoteConfig.AssetsVersion.ToString(), 
			"ClientStatic" => LuminApplication.RemoteConfig.ClientStaticVersion.ToString(), 
			"Dll" => LuminApplication.RemoteConfig.DllVersion.ToString(), 
			"RawFile" => LuminApplication.RemoteConfig.RawFileVersion.ToString(), 
			_ => string.Empty, 
		};
	}
}
