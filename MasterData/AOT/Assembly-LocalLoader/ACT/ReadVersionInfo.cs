using System;
using System.IO;
using ACT.Error;
using UnityEngine;

namespace ACT;

internal class ReadVersionInfo : GameLoadingFlowBase
{
	private DownloadData _downloadData;

	internal override EGameLoadingStage Stage => EGameLoadingStage.ReadVersionInfo;

	internal ReadVersionInfo(DownloadData downloadData)
	{
		_downloadData = downloadData;
	}

	internal override void Init(GameLoadingData data)
	{
		if (_downloadData == null)
		{
			Error("ReadVersionInfo DownloadData为空");
			return;
		}
		try
		{
			string versionFilePath = GetVersionFilePath();
			if (!File.Exists(versionFilePath))
			{
				Debug.Log("版本文件不存在: " + versionFilePath);
				_downloadData.HasVersionInfo = false;
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			string text = AotCrypto.ReadDecrypted(versionFilePath);
			if (string.IsNullOrWhiteSpace(text))
			{
				Debug.LogWarning("版本文件内容为空: " + versionFilePath);
				_downloadData.HasVersionInfo = false;
				_loadState = EGameLoadingState.Succeed;
				return;
			}
			string[] array = text.Split('\n');
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			string[] array2 = array;
			foreach (string text2 in array2)
			{
				if (string.IsNullOrWhiteSpace(text2))
				{
					continue;
				}
				string[] array3 = text2.Trim().Split('=');
				if (array3.Length != 2)
				{
					continue;
				}
				string text3 = array3[0].Trim();
				string text4 = array3[1].Trim();
				switch (text3)
				{
				case "AppEnv":
					if (LuminApplication.AppEnv != text4)
					{
						Debug.Log("环境信息 - Now:" + LuminApplication.AppEnv + ", Old:" + text4);
						_downloadData.HasVersionInfo = false;
						_loadState = EGameLoadingState.Succeed;
						return;
					}
					break;
				case "AssetsVersion":
				{
					if (int.TryParse(text4, out var result3))
					{
						_downloadData.AssetVersion = result3;
						flag = true;
					}
					break;
				}
				case "ClientStaticVersion":
				{
					if (int.TryParse(text4, out var result4))
					{
						_downloadData.ClientStaticVersion = result4;
						flag3 = true;
					}
					break;
				}
				case "DllVersion":
				{
					if (int.TryParse(text4, out var result2))
					{
						_downloadData.DllVersion = result2;
						flag4 = true;
					}
					break;
				}
				case "RawFileVersion":
				{
					if (int.TryParse(text4, out var result))
					{
						_downloadData.RawFileVersion = result;
						flag2 = true;
					}
					break;
				}
				}
			}
			if (flag & flag3 & flag4 & flag2)
			{
				_downloadData.HasVersionInfo = true;
				Debug.Log($"成功读取版本信息 - Asset:{_downloadData.AssetVersion}, ClientStatic:{_downloadData.ClientStaticVersion}, Dll:{_downloadData.DllVersion}");
			}
			else
			{
				_downloadData.HasVersionInfo = false;
				Debug.LogWarning($"版本文件解析不完整: Asset={flag}, ClientStatic={flag3}, Dll={flag4}, RawFile={flag2}");
				LuminErrorAOT.ReportGameLoadingError("C01-0302", "03", 1, "", retry: false, null, showDialog: false);
			}
			_loadState = EGameLoadingState.Succeed;
		}
		catch (Exception ex)
		{
			Debug.LogError("读取版本文件失败: " + ex.Message);
			LuminErrorAOT.ReportGameLoadingError("C01-0301", "03", 1, "", retry: false, null, showDialog: false);
			_downloadData.HasVersionInfo = false;
			_loadState = EGameLoadingState.Succeed;
		}
	}

	private string GetVersionFilePath()
	{
		return Path.Combine(GetDataDirectory(), "version", "version.txt");
	}

	private string GetDataDirectory()
	{
		return LuminApplication.GetResPath();
	}
}
