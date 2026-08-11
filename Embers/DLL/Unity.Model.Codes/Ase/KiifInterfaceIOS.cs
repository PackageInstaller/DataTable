using System;
using System.Collections.Generic;
using MiniJSON;

namespace Ase;

public class KiifInterfaceIOS : KiifInterface
{
	public override T GetVersion<T>()
	{
		throw new NotImplementedException();
	}

	public override void GetAppConfig()
	{
	}

	public override void Login()
	{
	}

	public override void SlientLogin()
	{
	}

	public override void Login(string info)
	{
	}

	public override void ChangeAccount()
	{
	}

	public override void Logout()
	{
	}

	public override void WriteOff()
	{
	}

	public override void OnSetDistinctId(string distinctId)
	{
	}

	public override void OnSetAccountId(string AccountId)
	{
	}

	public override void CustomerService()
	{
	}

	public override void OpenReview()
	{
	}

	public override void SubmitGameData(ExtraGameData data)
	{
	}

	public override void InstallApk(string apkPath)
	{
	}

	public override string GetVersion()
	{
		return string.Empty;
	}

	public override void Py(PyParams data)
	{
	}

	public override void EnterGame(string roleName, int server)
	{
	}

	public override void JumpAppStore(string url)
	{
	}

	public override void CreateRole(string roleName, int server)
	{
	}

	public override void ExitGame()
	{
	}

	public override void LogoutAccount()
	{
	}

	public override void DeleteAccount()
	{
	}

	public override void SubmitBuyData(BuyItemInfo data)
	{
	}

	public override void LoginServer(string url)
	{
	}

	private string encodePyParams(PyParams data)
	{
		return Json.Serialize(new Dictionary<string, object>
		{
			{ "app_User_Id", data.app_User_Id },
			{ "game_Role_Id", data.game_Role_Id },
			{ "app_user_Name", data.app_user_Name },
			{ "notify_Uri", data.notify_Uri },
			{ "amount", data.amount },
			{ "app_Ext1", data.app_Ext1 },
			{ "app_Ext2", data.app_Ext2 },
			{ "role_name", data.role_name },
			{ "app_order_Id", data.app_order_Id },
			{ "product_Id", data.product_Id },
			{ "sid", data.sid },
			{ "serverName", data.serverName },
			{ "product_name", data.product_name },
			{ "product_desc", data.product_desc },
			{ "vipLevel", data.vipLevel },
			{ "roleLevel", data.roleLevel },
			{ "gangName", data.UnionName },
			{ "createTime", data.CreateTime },
			{ "balance", data.balance },
			{ "sign", data.sign },
			{ "extToken", data.extToken }
		});
	}

	private string encodeGameData(ExtraGameData data)
	{
		return Json.Serialize(new Dictionary<string, object>
		{
			{ "dataType", data.dataType },
			{ "userID", data.userID },
			{ "roleID", data.roleID },
			{ "roleName", data.roleName },
			{ "roleLevel", data.roleLevel },
			{ "serverID", data.serverID },
			{ "serverName", data.serverName },
			{ "monyNum_1", data.monyNum_1 },
			{ "monyNum_2", data.monyNum_2 },
			{ "accumulateNum", data.accumulateNum },
			{ "vipLevel", data.vipLevel },
			{ "vipExp", data.vipExp },
			{ "createRoleTime", data.createRoleTime },
			{ "updateRoleTime", data.updateLevelTime },
			{ "gangLevel", data.gangLevel },
			{ "gangID", data.gangID },
			{ "gangName", data.gangName },
			{ "gangLeaderName", data.gangLeaderName },
			{ "rolePower", data.rolePower },
			{ "professionID", data.professionID },
			{ "profession", data.profession },
			{ "professionRoleName", data.professionRoleName },
			{ "gender", data.gender },
			{ "friendList", data.friendList },
			{ "loginTime", data.loginTime }
		});
	}

	private string EncodeItemInfo(BuyItemInfo info)
	{
		return Json.Serialize(new Dictionary<string, object>
		{
			{ "roleName", info.roleName },
			{ "roleID", info.roleID },
			{ "serverID", info.serverID },
			{ "coinCount", info.coinCount },
			{ "bindCoinCount", info.bindCoinCount },
			{ "reminCoinCount", info.reminCoinCount },
			{ "reminBindCounCount", info.reminBindCounCount },
			{ "buyItemCount", info.buyItemCount },
			{ "itemName", info.itemName },
			{ "itemDesc", info.itemDesc }
		});
	}

	public override string GetAPPName()
	{
		return string.Empty;
	}

	public override int GetIsSpecialLoad()
	{
		return 0;
	}

	private EVerifiedStatus ParseVerifyStatus(int val)
	{
		return val switch
		{
			1 => EVerifiedStatus.UnVerified, 
			2 => EVerifiedStatus.Nonage, 
			3 => EVerifiedStatus.Adult, 
			_ => EVerifiedStatus.FuncNotOpen, 
		};
	}
}
