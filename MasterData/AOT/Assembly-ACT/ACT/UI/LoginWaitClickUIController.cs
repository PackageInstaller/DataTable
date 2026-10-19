using System;
using bamboosdk;

namespace ACT.UI;

public class LoginWaitClickUIController : BaseUIController
{
	private bool m_SdkListenersBound;

	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequirePauseGame => false;

	public override bool RequireCatchScreen => false;

	protected override void OnOpen()
	{
		base.OnOpen();
		BindSdkListeners();
	}

	protected override void OnClosed()
	{
		UnbindSdkListeners();
		base.OnClosed();
	}

	protected override void OnUnInit()
	{
		UnbindSdkListeners();
		base.OnUnInit();
	}

	private void BindSdkListeners()
	{
		if (!m_SdkListenersBound)
		{
			m_SdkListenersBound = true;
			LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Combine(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSdkStateChanged));
			LuminBambooBridgeListener.ExtendSucceeded += OnExtendSucceeded;
		}
	}

	private void UnbindSdkListeners()
	{
		if (m_SdkListenersBound)
		{
			m_SdkListenersBound = false;
			LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Remove(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSdkStateChanged));
			LuminBambooBridgeListener.ExtendSucceeded -= OnExtendSucceeded;
		}
	}

	private void OnSdkStateChanged(string propertyName, bool value)
	{
		if (_uiView is MonoLoginWaitClickView monoLoginWaitClickView)
		{
			monoLoginWaitClickView.OnLoginStateChanged(propertyName, value);
			monoLoginWaitClickView.HandlePageStateChanged(propertyName, value);
		}
	}

	private void OnExtendSucceeded(string modName, string jsonRes)
	{
		if (_uiView is MonoLoginWaitClickView monoLoginWaitClickView)
		{
			monoLoginWaitClickView.OnNotificationExtendSucceeded(modName, jsonRes);
		}
	}
}
