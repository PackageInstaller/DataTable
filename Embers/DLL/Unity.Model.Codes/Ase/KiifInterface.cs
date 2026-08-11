using System;

namespace Ase;

public abstract class KiifInterface
{
	public delegate void LoginSucHandler(LoginInfo data);

	public delegate void LoginServerSuc(LoginInfo data);

	public delegate void LoginHandler(LoginInfo data);

	public delegate void LogoutHandler();

	public LoginSucHandler OnAndroidLoginSuc;

	public LoginSucHandler OnIOSSZXKLoginSuc;

	public LoginServerSuc OnLoginServerSuc;

	public LogoutHandler OnLogout;

	private static KiifInterface _instance;

	protected int _PlatorID;

	protected string _DomainName;

	public string _MODEL;

	public static string _IsAgreePermission;

	protected bool _HaveBindPhone;

	protected bool _HaveBindIDCard;

	protected string _ServerList;

	protected int _VipOpenLevel;

	protected string _VipService;

	protected string _AuditionIP;

	protected bool _needVerification;

	protected bool _openVoice;

	protected bool _haveFeedbackFun;

	protected bool _haveSlientLogin;

	protected int _ISFormal = 1;

	protected string _ChannelID = "";

	public static KiifInterface Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new KiifInterfaceAndroid();
			}
			return _instance;
		}
	}

	public int PlatorID => _PlatorID;

	public string DomainName => _DomainName;

	public string MODEL => _MODEL;

	public static string IsAgreePermission => _IsAgreePermission;

	public bool HaveBindPhone => _HaveBindPhone;

	public bool HaveBindIDCard => _HaveBindIDCard;

	public string ServerList => _ServerList;

	public int VIPOpenLevel => _VipOpenLevel;

	public string VipService => _VipService;

	public string AuditionIP => _AuditionIP;

	public bool NeedVerification => _needVerification;

	public bool OpenVoice => _openVoice;

	public bool HaveFeedbackFun => _haveFeedbackFun;

	public bool HaveSlientLogin => _haveSlientLogin;

	public int IsFormal => _ISFormal;

	public string ChannelID => _ChannelID;

	public void BindLoginSucListener(LoginSucHandler a)
	{
		if (OnAndroidLoginSuc == null)
		{
			OnAndroidLoginSuc = a;
		}
		else
		{
			OnAndroidLoginSuc = (LoginSucHandler)Delegate.Combine(OnAndroidLoginSuc, a);
		}
	}

	public void RemoveLoginSucListener()
	{
		if (OnAndroidLoginSuc != null)
		{
			OnAndroidLoginSuc = null;
		}
	}

	public abstract void GetAppConfig();

	public abstract void Login();

	public abstract void SlientLogin();

	public abstract void Login(string info);

	public abstract void LoginServer(string url);

	public abstract void ChangeAccount();

	public abstract void LogoutAccount();

	public abstract void DeleteAccount();

	public abstract void WriteOff();

	public abstract void OnSetDistinctId(string distinctId);

	public abstract void OnSetAccountId(string accountId);

	public abstract void Logout();

	public abstract void CustomerService();

	public abstract void OpenReview();

	public abstract void InstallApk(string apkPath);

	public abstract void SubmitGameData(ExtraGameData data);

	public abstract void SubmitBuyData(BuyItemInfo data);

	public abstract T GetVersion<T>();

	public abstract string GetVersion();

	public abstract void Py(PyParams data);

	public abstract void EnterGame(string roleName, int server);

	public abstract void CreateRole(string roleName, int server);

	public abstract void ExitGame();

	public abstract void JumpAppStore(string url);

	public abstract string GetAPPName();

	public abstract int GetIsSpecialLoad();
}
