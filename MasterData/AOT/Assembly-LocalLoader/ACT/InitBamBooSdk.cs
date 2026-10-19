using System;
using ACT.LocalLoader;
using UnityEngine;
using bamboosdk;

namespace ACT;

internal class InitBamBooSdk : GameLoadingFlowBase
{
	private const string PushModName = "push";

	private const string PushInitData = "{\"action\":\"init\",\"data\":{}}";

	private LuminBambooBridgeListener _listener;

	private GameLoadingData _data;

	internal override int TotalRetryCount { get; }

	internal override EGameLoadingStage Stage => EGameLoadingStage.BambooSdk;

	internal InitBamBooSdk(LuminBambooBridgeListener listener)
	{
		_listener = listener;
		LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Combine(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
	}

	internal override void Init(GameLoadingData data)
	{
		_data = data;
		_loadState = EGameLoadingState.Loading;
		LuminBambooBridgeListener.Default.EnsureInitBambooSDK();
	}

	internal override void Update()
	{
		if (_data.AcceptAgreement && (!NeedSdkAutoLogin() || _data.BamBooLogin))
		{
			_loadState = EGameLoadingState.Succeed;
			LuminApplication.DeviceId = BamBooSdk.getInstance().getBBPresetProperties().device_id;
			BamBooSdk.getInstance().getExtend("cps", "");
			BamBooSdk.getInstance().getExtend("remainingStorageSpace", "");
			BamBooSdk.getInstance().getExtend("push", "{\"action\":\"init\",\"data\":{}}");
		}
	}

	private bool NeedSdkAutoLogin()
	{
		return true;
	}

	private void TryOpenSdkLoginPage()
	{
		if (NeedSdkAutoLogin())
		{
			LuminBambooBridgeListener.Default.OpenLoginPage();
		}
	}

	private void OnSDKStateChanged(string name, bool value)
	{
		if (string.Equals("IsSDKInitialized", name))
		{
			if (!value)
			{
				return;
			}
			if (!LuminBambooBridgeListener.Default.IsAcceptAgreement)
			{
				_listener.OpenAgreementPage();
			}
			else
			{
				TryOpenSdkLoginPage();
			}
			_listener.SetBBSuperProperties(AotConstValues.TaPublicProperties);
		}
		if (string.Equals("IsAcceptAgreement", name))
		{
			_data.AcceptAgreement = value;
			if (value)
			{
				TryOpenSdkLoginPage();
			}
			else
			{
				Application.Quit();
			}
		}
		if (string.Equals("IsLogin", name))
		{
			_data.BamBooLogin = value;
			if (value)
			{
				LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Remove(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
			}
		}
	}
}
