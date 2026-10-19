using System;
using System.Collections.Generic;
using ACT;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace bamboosdk;

public abstract class LuminBambooBridgeListener : BamBooSdkListener
{
	protected static bool m_IsSDKInitialized;

	protected static bool m_IsAcceptAgreement;

	protected static bool m_IsLogin;

	protected static bool m_IsInAgreementPage;

	protected static bool m_IsInLoginPage;

	protected static bool m_IsInLogoutPage;

	public static long LeftDiskSpace = -1L;

	private static bool s_QuitGameAfterSdkLogout;

	public static LuminBambooBridgeListener Default { get; protected set; }

	public bool IsSDKInitialized
	{
		get
		{
			return m_IsSDKInitialized;
		}
		set
		{
			m_IsSDKInitialized = value;
			OnSDKStateChanged?.Invoke("IsSDKInitialized", value);
		}
	}

	public bool IsAcceptAgreement
	{
		get
		{
			return m_IsAcceptAgreement;
		}
		set
		{
			m_IsAcceptAgreement = value;
			OnSDKStateChanged?.Invoke("IsAcceptAgreement", value);
		}
	}

	public bool IsLogin
	{
		get
		{
			return m_IsLogin;
		}
		set
		{
			m_IsLogin = value;
			OnSDKStateChanged?.Invoke("IsLogin", value);
		}
	}

	public bool IsInAgreementPage
	{
		get
		{
			return m_IsInAgreementPage;
		}
		set
		{
			m_IsInAgreementPage = value;
			OnSDKStateChanged?.Invoke("IsInAgreementPage", value);
		}
	}

	public bool IsInLoginPage
	{
		get
		{
			return m_IsInLoginPage;
		}
		set
		{
			m_IsInLoginPage = value;
			OnSDKStateChanged?.Invoke("IsInLoginPage", value);
		}
	}

	public bool IsInLogoutPage
	{
		get
		{
			return m_IsInLogoutPage;
		}
		set
		{
			m_IsInLogoutPage = value;
			OnSDKStateChanged?.Invoke("IsInLogoutPage", value);
		}
	}

	public static UserInfo UserInfo { get; private set; }

	public static Action<string, bool> OnSDKStateChanged { get; set; }

	public static event Action<string, string> ExtendSucceeded;

	public static event Action<string, ErrorMsg> ExtendFailed;

	protected static void RaiseExtendSucceeded(string modName, string jsonResult)
	{
		Action<string, string> extendSucceeded = ExtendSucceeded;
		if (extendSucceeded == null)
		{
			return;
		}
		Delegate[] invocationList = extendSucceeded.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			Action<string, string> action = (Action<string, string>)invocationList[i];
			try
			{
				action(modName, jsonResult);
			}
			catch (Exception)
			{
			}
		}
	}

	protected static void RaiseExtendFailed(string modName, ErrorMsg error)
	{
		Action<string, ErrorMsg> extendFailed = ExtendFailed;
		if (extendFailed == null)
		{
			return;
		}
		Delegate[] invocationList = extendFailed.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			Action<string, ErrorMsg> action = (Action<string, ErrorMsg>)invocationList[i];
			try
			{
				action(modName, error);
			}
			catch (Exception)
			{
			}
		}
	}

	public static bool TryLogoutAndQuitGameForWeGameAccountSwitch()
	{
		if (!LuminApplication.IsWeGameChannel)
		{
			return false;
		}
		if (s_QuitGameAfterSdkLogout)
		{
			return true;
		}
		if (!m_IsLogin)
		{
			Application.Quit(0);
			return true;
		}
		LuminBambooBridgeListener luminBambooBridgeListener = Default;
		if (luminBambooBridgeListener == null)
		{
			return true;
		}
		s_QuitGameAfterSdkLogout = true;
		try
		{
			luminBambooBridgeListener.EnsureInitBambooSDK().logout(isShowWindow: false);
		}
		catch (Exception)
		{
			s_QuitGameAfterSdkLogout = false;
		}
		return true;
	}

	public BamBooSdk EnsureInitBambooSDK()
	{
		BamBooSdk instance = BamBooSdk.getInstance();
		if (instance == null)
		{
			throw new Exception("BambooSdk instance为空");
		}
		instance.setListener(Default);
		if (!IsSDKInitialized)
		{
			instance.init();
		}
		return instance;
	}

	public void OpenAgreementPage()
	{
		if (!IsInAgreementPage)
		{
			BamBooSdk bamBooSdk = EnsureInitBambooSDK();
			IsInAgreementPage = true;
			bamBooSdk.acceptAgreement(isShow: true);
		}
	}

	public override void onAcceptAgreement(bool isAgree)
	{
		IsAcceptAgreement = isAgree;
		IsInAgreementPage = false;
	}

	public override void onAcceptAgreement(string isAgree)
	{
		onAcceptAgreement(bool.Parse(isAgree));
	}

	public void OpenLoginPage()
	{
		if (!IsInLoginPage && IsAcceptAgreement)
		{
			BamBooSdk bamBooSdk = EnsureInitBambooSDK();
			IsInLoginPage = true;
			bamBooSdk.login();
		}
	}

	public void OpenQRPage()
	{
		if (!TryLogoutAndQuitGameForWeGameAccountSwitch() && IsAcceptAgreement)
		{
			EnsureInitBambooSDK().getExtend("scanQRCodeLogin");
		}
	}

	public void OpenUserCenter(string url)
	{
		if (!string.IsNullOrEmpty(url))
		{
			JObject jObject = new JObject { ["url"] = url };
			EnsureInitBambooSDK().getExtend("user_center", jObject.ToString(Formatting.None));
		}
	}

	public override void onLoginSuccess(UserInfo userInfo)
	{
		UserInfo = userInfo;
		IsInLoginPage = false;
		IsLogin = true;
		LuminApplication.RuntimeInfo.SetRecordingEnabled(enabled: true);
	}

	public override void onLoginCancel(ErrorMsg errMsg)
	{
		IsLogin = false;
		IsInLoginPage = false;
	}

	public override void onLoginFailed(ErrorMsg errMsg)
	{
		IsInLoginPage = false;
	}

	public void OpenLogoutPage()
	{
		if (!TryLogoutAndQuitGameForWeGameAccountSwitch())
		{
			EnsureInitBambooSDK().logout(isShowWindow: true);
			IsInLogoutPage = true;
		}
	}

	public override void onLogoutSuccess()
	{
		UserInfo = null;
		IsLogin = false;
		IsInLogoutPage = false;
		LuminApplication.RuntimeInfo.SetRecordingEnabled(enabled: false);
		try
		{
			OnLogoutSuccessAfterStateChanged();
		}
		finally
		{
			if (s_QuitGameAfterSdkLogout)
			{
				Application.Quit(0);
			}
		}
	}

	protected virtual void OnLogoutSuccessAfterStateChanged()
	{
	}

	public override void onLogoutFailed()
	{
		IsInLogoutPage = false;
		if (s_QuitGameAfterSdkLogout)
		{
			s_QuitGameAfterSdkLogout = false;
		}
	}

	public override void onInitSuccess()
	{
		IsSDKInitialized = true;
	}

	public override void onInitFailed(ErrorMsg message)
	{
		IsSDKInitialized = false;
	}

	public void SetBBSuperProperties(List<JObject> properties)
	{
		BamBooSdk bamBooSdk = EnsureInitBambooSDK();
		foreach (JObject property in properties)
		{
			string bBSuperProperties = property.ToString();
			bamBooSdk.setBBSuperProperties(bBSuperProperties);
		}
	}

	public override void onExitSuccess()
	{
		Application.Quit();
	}

	public override void onExitFailed()
	{
	}

	private void OnApplicationQuit()
	{
		EnsureInitBambooSDK().exitWithOutShowDialog();
	}
}
