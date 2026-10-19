using System;
using ACT.Error;
using ACT.Local;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using bamboosdk;

namespace ACT.Battle;

public sealed class ServerNetworkController : IDisposable
{
	private bool _isListenerReady;

	private bool _isNetworkFluctuation;

	public void AddNetworkListener()
	{
		if (!_isListenerReady)
		{
			_isListenerReady = true;
			Singleton<NetManager>.instance.NetworkFluctuation += SetNetworkFluctuation;
			Singleton<NetManager>.instance.NetworkDisconnected += OnNetworkDisconnected;
			Singleton<NetManager>.instance.ConnectionStateChanged += OnConnectionStateChanged;
			Singleton<NetManager>.instance.ReconnectFailed += OnReconnectFailed;
		}
	}

	public void RemoveNetworkListener()
	{
		if (_isListenerReady)
		{
			_isListenerReady = false;
			Singleton<NetManager>.instance.NetworkFluctuation -= SetNetworkFluctuation;
			Singleton<NetManager>.instance.NetworkDisconnected -= OnNetworkDisconnected;
			Singleton<NetManager>.instance.ConnectionStateChanged -= OnConnectionStateChanged;
			Singleton<NetManager>.instance.ReconnectFailed -= OnReconnectFailed;
		}
	}

	public void Dispose()
	{
		RemoveNetworkListener();
	}

	public void SetNetworkFluctuation(bool isNetworkFluctuation)
	{
		if (isNetworkFluctuation != _isNetworkFluctuation)
		{
			_isNetworkFluctuation = isNetworkFluctuation;
			if (_isNetworkFluctuation)
			{
				MonoECS.instance.PushPause();
				Singleton<NewUIManager>.instance.NetworkFluctuationView.Init();
			}
			else
			{
				MonoECS.instance.PopPause();
				Singleton<NewUIManager>.instance.NetworkFluctuationView.UnInit();
			}
		}
	}

	private void OnConnectionStateChanged(NetConnectionState previous, NetConnectionState current)
	{
		switch (current)
		{
		case NetConnectionState.Reconnecting:
			SetNetworkFluctuation(isNetworkFluctuation: true);
			break;
		case NetConnectionState.Online:
			SetNetworkFluctuation(isNetworkFluctuation: false);
			break;
		case NetConnectionState.Idle:
		case NetConnectionState.Disconnected:
			SetNetworkFluctuation(isNetworkFluctuation: false);
			break;
		}
	}

	private void OnReconnectFailed(Exception exception)
	{
		Singleton<GameState>.instance.SetGameServerState(GameServerState.Disconnected);
		SetNetworkFluctuation(isNetworkFluctuation: false);
		HandleReconnectException(exception);
	}

	private void OnNetworkDisconnected()
	{
		if (Singleton<GameState>.instance.RunningState == GameRunningState.Login)
		{
			LoginUtility.ConnectFailAction?.Invoke();
		}
		else
		{
			LuminError.Handle(CodeType.CLIENT, CodeModule.NETWORK, 4, new ErrorHandleOptions(ErrorPresentation.Dialog, null, null, LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 691), DisconnectServer, null, null, hideErrorCode: true));
		}
		RemoveNetworkListener();
		SetNetworkFluctuation(isNetworkFluctuation: false);
	}

	public async void DisconnectServer()
	{
		Singleton<GameState>.instance.SetGameServerState(GameServerState.Disconnected);
		await MonoECS.instance.DestroyWorld();
	}

	private void HandleReconnectException(Exception exception)
	{
		LuminErrorException errorException = exception as LuminErrorException;
		if (errorException == null)
		{
			Debug.LogError($"[NetFailure] [NetReconnect] unhandled exception; show disconnect prompt\n{exception}");
			OnNetworkDisconnected();
			return;
		}
		if (LoginUtility.IsLastSessionExpiredError(errorException))
		{
			LuminError.Handle(errorException, new ErrorHandleOptions(ErrorPresentation.None));
			MonoECS.instance.DestroyWorld();
			return;
		}
		LuminError.Handle(options: new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, (!RuntimeVersionCheck.IsVersionError(errorException)) ? ((Action)(() =>
		{
			if (errorException.Is(CodeType.SERVER, CodeModule.LOGIN, 1))
			{
				if (LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
				{
					return;
				}
				BamBooSdk.getInstance().getExtend("logoutAndCleanData");
			}
			MonoECS.instance.DestroyWorld();
		})) : new Action(RuntimeVersionCheck.RestartGame)), exception: errorException);
	}
}
