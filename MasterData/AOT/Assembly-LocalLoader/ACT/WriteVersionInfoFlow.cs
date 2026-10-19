using System;
using System.IO;
using ACT.Error;

namespace ACT;

internal class WriteVersionInfoFlow : DownloadAssetSubFlowBase
{
	internal override EGameLoadingStage Stage => EGameLoadingStage.WriteVersionInfo;

	internal WriteVersionInfoFlow(DownloadAssetContext context)
		: base(context)
	{
	}

	internal override void Init(GameLoadingData data)
	{
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		try
		{
			WriteVersionInfoToFile();
			DownloadData.DownloadComplete = true;
			_loadState = EGameLoadingState.Succeed;
		}
		catch (Exception ex)
		{
			Exception(ex);
			DownloadData.ErrorCode = "C03-0504";
			DownloadData.SystemModule = "03";
			DownloadData.Message = ex.Message;
			DownloadData.DownloadFail = true;
			DownloadData.CanRetry = true;
			DownloadData.AcceptUpdate = false;
			_loadState = EGameLoadingState.Failed;
		}
	}

	private void WriteVersionInfoToFile()
	{
		try
		{
			if (LuminApplication.RemoteConfig == null)
			{
				Warning("RemoteConfig为空，跳过写入版本信息");
				return;
			}
			int assetsVersion = LuminApplication.RemoteConfig.AssetsVersion;
			int clientStaticVersion = LuminApplication.RemoteConfig.ClientStaticVersion;
			int dllVersion = LuminApplication.RemoteConfig.DllVersion;
			int rawFileVersion = LuminApplication.RemoteConfig.RawFileVersion;
			string text = WriteVersionInfoFile(assetsVersion, clientStaticVersion, dllVersion, rawFileVersion);
			Log("版本信息已写入: " + text);
			Log($"AssetVersion={assetsVersion}, ClientStaticVersion={clientStaticVersion}, DllVersion={dllVersion}, RawFileVersion={rawFileVersion}");
		}
		catch (Exception ex)
		{
			Error("写入版本信息失败: " + ex.Message + "\n" + ex.StackTrace);
			LuminErrorAOT.ReportGameLoadingError("C03-0504", "01", 1, ex.Message);
		}
	}

	internal static string WriteVersionInfoFile(int assetVersion, int clientStaticVersion, int dllVersion, int rawFileVersion)
	{
		string text = Path.Combine(LuminApplication.GetResPath(), "version");
		if (!Directory.Exists(text))
		{
			Directory.CreateDirectory(text);
		}
		string text2 = Path.Combine(text, "version.txt");
		string[] lines = new string[5]
		{
			"AppEnv=" + LuminApplication.AppEnv,
			$"AssetsVersion={assetVersion}",
			$"ClientStaticVersion={clientStaticVersion}",
			$"DllVersion={dllVersion}",
			$"RawFileVersion={rawFileVersion}"
		};
		AotCrypto.WriteEncryptedLines(text2, lines);
		return text2;
	}
}
