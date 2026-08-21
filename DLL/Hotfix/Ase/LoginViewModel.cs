using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class LoginViewModel : OptionBase
{
	private string username;

	private string password;

	private string passcode;

	private bool rememberMe;

	private bool agree;

	private bool kfinner;

	private SimpleCommand loginCommand;

	private SimpleCommand closeCommand;

	private InteractionRequest<bool> innerModeChangeRst;

	private bool skip;

	public string Username
	{
		get
		{
			return username;
		}
		set
		{
			if (Set(ref username, value, "Username") && !string.IsNullOrEmpty(username) && PlayerPrefs.GetString("_login_username", null) == username)
			{
				Password = PlayerPrefs.GetString("_login_password");
			}
		}
	}

	public string Password
	{
		get
		{
			return password;
		}
		set
		{
			Set(ref password, value, "Password");
		}
	}

	public bool RememberMe
	{
		get
		{
			return rememberMe;
		}
		set
		{
			Set(ref rememberMe, value, "RememberMe");
		}
	}

	public bool Skip
	{
		get
		{
			return skip;
		}
		set
		{
			Set(ref skip, value, "Skip");
			GuidanceManager.skip = skip;
		}
	}

	public bool Agree
	{
		get
		{
			return agree;
		}
		set
		{
			Set(ref agree, value, "Agree");
		}
	}

	public bool KFInner
	{
		get
		{
			return kfinner;
		}
		set
		{
			Set(ref kfinner, value, "KFInner");
		}
	}

	public ICommand LoginCommand => loginCommand;

	public ICommand CloseCommand => closeCommand;

	public InteractionRequest<bool> InnerModeChangeRst => innerModeChangeRst;

	public LoginViewModel()
	{
		rememberMe = PlayerPrefs.GetInt("_login_remember", 1) != 0;
		agree = PlayerPrefs.GetInt("_login_agree", 0) != 0;
		Skip = false;
		KFInner = PlayerPrefs.GetInt("_login_innermode", 0) != 0;
		if (rememberMe)
		{
			username = PlayerPrefs.GetString("_login_username", null);
			password = PlayerPrefs.GetString("_login_password", null);
		}
		innerModeChangeRst = new InteractionRequest<bool>(this);
		loginCommand = new SimpleCommand(Login);
		closeCommand = new SimpleCommand(delegate
		{
			Close();
		});
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabItemData)
		{
			KFInner = tabItemData.TabIndex == 2;
			InnerModeChangeRst.Raise(KFInner);
		}
	}

	private async void Login()
	{
	}

	private async UniTask<bool> SignUp()
	{
		return false;
	}

	private string GetUsername()
	{
		if (KFInner)
		{
			return "kfinner" + username;
		}
		return username;
	}

	private bool CheckValidBeforeLogin()
	{
		if (!ValidateUsername().Result || !ValidatePassword().Result)
		{
			return false;
		}
		if (!agree)
		{
			Toast.ShowInfo("请勾选同意下方的服务协议，即可进入游戏");
			return false;
		}
		return true;
	}

	public void SetRememberMe()
	{
		if (RememberMe)
		{
			PlayerPrefs.SetString("_login_username", username);
			PlayerPrefs.SetString("_login_password", password);
			PlayerPrefs.SetInt("_login_remember", 1);
		}
		else
		{
			PlayerPrefs.SetString("_login_username", null);
			PlayerPrefs.SetString("_login_password", null);
			PlayerPrefs.SetInt("_login_remember", 0);
		}
		PlayerPrefs.SetInt("_login_skip", skip ? 1 : 0);
		PlayerPrefs.SetInt("_login_agree", 1);
		PlayerPrefs.SetInt("_login_innermode", KFInner ? 1 : 0);
	}

	private async Task<bool> ValidateUsername()
	{
		if (string.IsNullOrEmpty(username))
		{
			Toast.ShowError("请输入用户名！");
			return false;
		}
		if (!Regex.IsMatch(username, "^[a-zA-Z0-9_-]{1,50}$"))
		{
			Toast.ShowError("用户名不存在！");
			return false;
		}
		return true;
	}

	private async Task<bool> ValidatePassword()
	{
		if (string.IsNullOrEmpty(password))
		{
			Toast.ShowError("请输入密码！");
			return false;
		}
		if (!Regex.IsMatch(password, "^[a-zA-Z0-9_-]{1,50}$"))
		{
			Toast.ShowError("用户名或密码错误！");
			return false;
		}
		return true;
	}
}
