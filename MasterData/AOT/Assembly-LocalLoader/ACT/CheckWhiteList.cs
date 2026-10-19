using System;
using AOT.WhiteListCheck;
using bamboosdk;

namespace ACT;

internal class CheckWhiteList : GameLoadingFlowBase
{
	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckWhiteList;

	public CheckWhiteList()
	{
		LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Remove(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
		LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Combine(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
	}

	private async void OnSDKStateChanged(string arg1, bool arg2)
	{
		if (arg1.Equals("IsLogin") && arg2)
		{
			_loadState = ((await WhiteListCheckUtil.CheckWhiteListFunc()) ? EGameLoadingState.Succeed : EGameLoadingState.Failed);
		}
	}

	internal override void Init(GameLoadingData data)
	{
		base.Init(data);
		_loadState = EGameLoadingState.Waiting;
	}
}
