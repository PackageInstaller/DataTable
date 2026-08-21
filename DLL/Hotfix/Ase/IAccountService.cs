using System;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IAccountService
{
	public class ChangeRoleResult
	{
		private int code;

		private string message;

		public int Code => code;

		public string Message => message;

		public ChangeRoleResult(int code, string message)
		{
			this.code = code;
			this.message = message;
		}
	}

	public class LoginParam
	{
		public bool IsSDKLogin { get; set; }

		public string Account { get; set; }

		public string UserName { get; set; }

		public string Password { get; set; }

		public string Token { get; set; }

		public long ChannelID { get; set; }

		public string DeviceId { get; set; }
	}

	string Account { get; set; }

	long ReloginKey { get; set; }

	bool IsLogin { get; set; }

	bool WaittingForLoginOut { get; set; }

	IMessenger GetMessager();

	UniTask<bool> LoginBySDK();

	UniTask Logout();

	UniTask<bool> Relogin();

	void OnAccountDisconnect(int reason);

	IAsyncResult<int> OnAccountDisconnect(string tipsContent, bool isDoubleButton);

	UniTask<ChangeRoleResult> CreateUser(string name, int gender = 1);

	UniTask<ChangeRoleResult> ChangeName(string newName);

	UniTask<bool> RequestAccountData(Action<int> onProcessUpdate = null);

	long GetLoginSeconds();

	void SubscribeNetworkNotify();

	void UnSubscribeNetworkNotify();

	void Dispose();
}
