using System;
using System.Collections.Generic;

namespace ACT;

internal class InitAssetTag : GameLoadingFlowBase
{
	private static readonly string[] BaseDownloadTags = new string[1] { "Preload" };

	private static readonly string[] NormalOnlyDownloadTags = new string[3] { "Default", "Video", "CN" };

	private static readonly string[] OptionalVoiceTags = new string[2] { "EN", "JP" };

	private readonly ZipDownloadParam _zipDownloadParam;

	internal override EGameLoadingStage Stage => EGameLoadingStage.InitAssetTag;

	internal InitAssetTag(ZipDownloadParam zipDownloadParam)
	{
		_zipDownloadParam = zipDownloadParam;
	}

	internal override void Init(GameLoadingData data)
	{
		try
		{
			if (_zipDownloadParam == null)
			{
				Error("InitAssetTag ZipDownloadParam为空");
				return;
			}
			string[] array = BuildDownloadTags();
			_zipDownloadParam.DownloadTags = array;
			_zipDownloadParam.IntegrityDownloadTags = array;
			DownloadAssetManager.Instance.SetPlayerTags(_zipDownloadParam.DownloadTags ?? Array.Empty<string>());
			_loadState = EGameLoadingState.Succeed;
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	internal static string[] BuildDownloadTags()
	{
		List<string> list = new List<string>(BaseDownloadTags);
		if (!string.Equals(LuminApplication.RemoteConfig?.ServerName, "review", StringComparison.OrdinalIgnoreCase))
		{
			list.InsertRange(0, NormalOnlyDownloadTags);
		}
		DownloadAssetManager instance = DownloadAssetManager.Instance;
		string[] optionalVoiceTags = OptionalVoiceTags;
		foreach (string text in optionalVoiceTags)
		{
			if (instance.HasLocalDownloadedTag(text))
			{
				list.Add(text);
			}
		}
		return list.ToArray();
	}
}
