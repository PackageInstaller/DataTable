using ACT.Event;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using Google.Protobuf;
using Pb;
using Runtime.WaitSort;
using UnityEngine;
using bamboosdk;

namespace ACT.Battle;

public class ReviewPromptManager
{
	private const string KEY = "LUMIN.REVIEWFLAG";

	private int Status;

	private const string ShareModName = "share_platform";

	private bool _hasEnteredMainWorld;

	private float startTime;

	private bool noWait;

	public ReviewPromptManager()
	{
		BamBooSdk.getInstance().getExtend("init_share", "");
		startTime = Time.time;
		Status = PlayerPrefs.GetInt("LUMIN.REVIEWFLAG", 0);
		LuminBambooBridgeListener.ExtendSucceeded += OnExtendSucceeded;
		LuminBambooBridgeListener.ExtendFailed += OnExtendFailed;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeLeaveWorld, OnBeforeLeaveWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
	}

	~ReviewPromptManager()
	{
		LuminBambooBridgeListener.ExtendSucceeded -= OnExtendSucceeded;
		LuminBambooBridgeListener.ExtendFailed -= OnExtendFailed;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeLeaveWorld, OnBeforeLeaveWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
	}

	private void OnBeforeLeaveWorld(BaseEventContent content)
	{
		_hasEnteredMainWorld = false;
	}

	private void OnAfterEnterWorld(BaseEventContent content)
	{
		_hasEnteredMainWorld = !MonoECS.instance.IsNotInMain;
	}

	private void OnExtendSucceeded(string modName, string jsonResult)
	{
	}

	private void OnExtendFailed(string modName, ErrorMsg error)
	{
		if (modName == "share_platform")
		{
			Debug.LogError("Share SDK: " + error.errMsg);
		}
	}

	public void Send()
	{
		BamBooSdk.getInstance().getExtend("app_write_review", "");
	}

	public void Mark()
	{
		PlayerPrefs.SetInt("LUMIN.REVIEWFLAG", 1);
		Status = 1;
		Debug.LogError("Share SDK: Receive queue request");
	}

	public void Tick()
	{
		if (Status == 1 && _hasEnteredMainWorld && (bool)MonoECS.instance && Model<BattleMainModel>.Interface != null && (noWait || !(Time.time - startTime < 300f)) && (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui) || ui.State == UIState.Opened) && (MonoECS.instance.playState == PlayState.UnBattle || Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType))
		{
			Status = 0;
			PlayerPrefs.SetInt("LUMIN.REVIEWFLAG", 0);
			ReviewPromptDisplayedReq data = new ReviewPromptDisplayedReq();
			Singleton<NetManager>.instance.Request(data, (IMessage _) =>
			{
			});
			if (!Singleton<SystemBlockManager>.instance.IsBlocked(SystemType.ReviewPrompt))
			{
				Send();
			}
		}
	}

	public void NoWait()
	{
		noWait = true;
	}
}
