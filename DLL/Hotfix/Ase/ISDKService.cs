using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface ISDKService
{
	UniTask<SDKLoginResult> Login();

	void Pay(PyParams payInfos);

	void Logout();

	void WriteOff();

	void OnSetDistinctId(string distinctId);

	void OnSetAccountId(string account_id);

	void CustomerSer();

	void OpenTapReview();

	void ReportPlayerData(ExtraGameData data);

	UniTask<SDKPayResult> Pay(string uid, string name, int goodId);

	void OnLoginSuccess(LoginInfo loginInfo);

	void OnLoginFaile(LoginInfo loginInfo);

	void OnLogoutSuccess();

	void OnPaySuccess();

	void OnPayFail(Dictionary<string, object> eventPropertys);

	UniTask OnPayCancel(Dictionary<string, object> eventPropertys);

	UniTask PayCancel(string productId);

	void Dispose();

	bool IfShowCustomerServiceBtn();

	bool IfShowWriteOffBtn();

	SDKLoginResult GetSDKLoginResult();
}
