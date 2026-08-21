#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using GameFramework.WebRequest;
using Spine.Unity;
using UnityEngine;

namespace Ase;

public static class StreamerMode
{
	private class StreamerModeControlData
	{
		public int status;
	}

	private const string StreamerModeSuffixHeroIcon = "_hx";

	private const string _default = "default";

	private const string _streamerModeOn = "hexie";

	private const string _streamerModeOff = "weihexie";

	public static bool StreamerModeSet;

	private static int StreamerModeControl;

	private const string LocalSaveKey = "StreamerModeSetting";

	public static bool GetStreamerMode()
	{
		if (GameEntry.BuiltinData.OpenTestFlight)
		{
			return true;
		}
		if (StreamerModeControl == 0)
		{
			return StreamerModeSet;
		}
		if (StreamerModeControl == 2)
		{
			return false;
		}
		if (StreamerModeControl == 1)
		{
			return true;
		}
		return StreamerModeSet;
	}

	public static bool ShowStreamerModeUi()
	{
		if (!GameEntry.BuiltinData.OpenTestFlight)
		{
			return StreamerModeControl == 0;
		}
		return false;
	}

	private static string GetStreamerIcon(string rawPath, bool haveSexConfig)
	{
		bool streamerMode = GetStreamerMode();
		if (!haveSexConfig)
		{
			return rawPath;
		}
		if (!streamerMode)
		{
			return rawPath;
		}
		return rawPath + "_hx";
	}

	public static string GetHeroSkinIcon(DRUIHeroSkin druiHeroSkin)
	{
		if (druiHeroSkin == null)
		{
			return "";
		}
		if (!GetSexConfig(druiHeroSkin))
		{
			return druiHeroSkin.SkinIcon;
		}
		if (!GetStreamerMode())
		{
			return druiHeroSkin.SkinSexIcon;
		}
		return druiHeroSkin.SkinIcon;
	}

	public static string GetHeroItemIcon(HeroModel heroModel, HeroIconTypeEnum iconType)
	{
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(heroModel.SkinConfigId);
		return GetStreamerIcon($"{heroModel.Id}_{iconType.ToString()}{heroModel.SkinSuffix}", GetSexConfig(dataRow));
	}

	public static string GetHeroHeadIcon(string rawPath, int skinConfigId)
	{
		DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(skinConfigId);
		if (dataRow == null)
		{
			return "";
		}
		return GetStreamerIcon(rawPath, GetSexConfig(dataRow));
	}

	private static bool GetSexConfig(DRUIHeroSkin config)
	{
		if (config != null)
		{
			return !string.IsNullOrEmpty(config.SkinSexIcon);
		}
		return false;
	}

	public static void ApplySpineSkin(GameObject gameObject, bool initialize = true)
	{
		bool streamerMode = GetStreamerMode();
		try
		{
			SkeletonGraphic[] componentsInChildren = gameObject.GetComponentsInChildren<SkeletonGraphic>();
			if (componentsInChildren != null)
			{
				SkeletonGraphic[] array = componentsInChildren;
				foreach (SkeletonGraphic val in array)
				{
					if (val.SkeletonData != null)
					{
						string text = (streamerMode ? "hexie" : "weihexie");
						if (val.SkeletonData.FindSkin(text) == null)
						{
							text = "default";
						}
						val.initialSkinName = text;
						if (initialize)
						{
							val.Initialize(true);
						}
						val.MatchRectTransformWithBounds();
						val.UpdateMesh();
					}
				}
			}
		}
		catch (Exception)
		{
		}
		string text2 = "_hx";
		BoardPartItem[] componentsInChildren2 = gameObject.GetComponentsInChildren<BoardPartItem>(includeInactive: true);
		if (componentsInChildren2 == null)
		{
			return;
		}
		Dictionary<string, BoardPartItem> dictionary = new Dictionary<string, BoardPartItem>();
		BoardPartItem[] array2 = componentsInChildren2;
		foreach (BoardPartItem boardPartItem in array2)
		{
			if (!dictionary.ContainsKey(boardPartItem.gameObject.name))
			{
				dictionary.Add(boardPartItem.gameObject.name, boardPartItem);
			}
		}
		foreach (KeyValuePair<string, BoardPartItem> item in dictionary)
		{
			if (item.Key.EndsWith(text2))
			{
				item.Value.gameObject.SetActive(streamerMode);
			}
			else if (dictionary.ContainsKey(item.Key + text2))
			{
				item.Value.gameObject.SetActive(!streamerMode);
			}
		}
	}

	public static void ApplySpineSkin(GameObject spineGo, Transform parentRoot)
	{
		ApplySpineSkin(spineGo, initialize: false);
		UIUtilly.SpineMatchRectHelper(spineGo, parentRoot, overwrite: true);
	}

	public static void LoadLocalSetting()
	{
		if (PlayerPrefs.HasKey("StreamerModeSetting"))
		{
			StreamerModeSet = PlayerPrefs.GetInt("StreamerModeSetting", 0) == 1;
		}
		else
		{
			StreamerModeSet = false;
		}
	}

	public static void SaveLocalSetting(bool setOn)
	{
		if (StreamerModeSet != setOn)
		{
			StreamerModeSet = setOn;
			PlayerPrefs.SetInt("StreamerModeSetting", StreamerModeSet ? 1 : 0);
			Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new StreamerModeMsg(null));
		}
	}

	public static async UniTask Initialized()
	{
		LoadLocalSetting();
		await RequestStreamerModeControl();
	}

	private static async UniTask<bool> RequestStreamerModeControl()
	{
		string webRequestUri = "https://gmapi.kiifstudio.com/game_api/streamer_mode/status";
		try
		{
			WWWForm wwwForm = new WWWForm();
			WebRequestResponse webRequestResponse = await GameEntry.WebRequest.AddWebRequest(webRequestUri, wwwForm);
			if (webRequestResponse == null)
			{
				return false;
			}
			StreamerModeControl = (webRequestResponse.GetResponseData<StreamerModeControlData>().Item1 ?? new StreamerModeControlData()).status;
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
			return false;
		}
		return true;
	}
}
