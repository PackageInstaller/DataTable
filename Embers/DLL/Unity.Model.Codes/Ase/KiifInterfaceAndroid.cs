using System;
using System.Collections.Generic;
using MiniJSON;
using UnityEngine;

namespace Ase;

public class KiifInterfaceAndroid : KiifInterface
{
	private AndroidJavaObject jo;

	public KiifInterfaceAndroid()
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Expected O, but got Unknown
		base._002Ector();
		AndroidJavaClass val = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		try
		{
			jo = ((AndroidJavaObject)val).GetStatic<AndroidJavaObject>("currentActivity");
		}
		finally
		{
			((IDisposable)val)?.Dispose();
		}
	}

	private T MuCall<T>(string method, params object[] param)
	{
		try
		{
			return jo.Call<T>(method, param);
		}
		catch (Exception message)
		{
			if (Debug.developerConsoleVisible)
			{
				Debug.LogError(message);
			}
		}
		return default(T);
	}

	private void MuCall(string method, params object[] param)
	{
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Expected O, but got Unknown
		try
		{
			if (jo != null)
			{
				jo.Call(method, param);
			}
		}
		catch (Exception ex)
		{
			if (Debug.developerConsoleVisible)
			{
				Debug.LogError("=============================" + ex);
			}
			try
			{
				if (jo == null)
				{
					return;
				}
				jo.Call("runOnUiThread", new object[1] { (object)(AndroidJavaRunnable)delegate
				{
					if (jo != null)
					{
						jo.Call(method, param);
					}
				} });
			}
			catch (Exception ex2)
			{
				if (Debug.developerConsoleVisible)
				{
					Debug.LogError("=============================" + ex2);
				}
			}
		}
	}

	public override void Login()
	{
		MuCall("login");
	}

	public override void Login(string info)
	{
		MuCall("login", info);
	}

	public override void LoginServer(string url)
	{
		Debug.LogError("Android没有对应方法！！ LoginServer(string url)");
	}

	public override void Py(PyParams data)
	{
		string text = encodePyParams(data);
		MuCall("pay", text);
	}

	public override void ChangeAccount()
	{
		MuCall("changeAccount");
	}

	public override void LogoutAccount()
	{
		MuCall("logoutAccount");
	}

	public override void DeleteAccount()
	{
		MuCall("deleteAccount");
	}

	public override void Logout()
	{
		MuCall("logoutGame");
	}

	public override void CustomerService()
	{
		MuCall("CustomerService");
	}

	public override void OpenReview()
	{
		MuCall("OpenReview");
	}

	public override void WriteOff()
	{
		MuCall("CancelAccountBiLi");
	}

	public override void OnSetDistinctId(string distinctId)
	{
		MuCall("OnSetDistinctId", distinctId);
	}

	public override void OnSetAccountId(string AccountId)
	{
		MuCall("OnSetAccountId", AccountId);
	}

	public override void SubmitGameData(ExtraGameData data)
	{
		try
		{
			string text = encodeGameData(data);
			MuCall("submitExtendData", text);
		}
		catch
		{
		}
	}

	private string GetFriendInfo()
	{
		return string.Empty;
	}

	public override void SubmitBuyData(BuyItemInfo data)
	{
		Debug.LogError("Android没有对应方法！！ SubmitBuyData(BuyItemInfo data)");
	}

	public override void CreateRole(string roleName, int server)
	{
		Debug.LogError("Android没有对应方法！！ CreateRole(string roleName, int server)");
	}

	public override void ExitGame()
	{
		MuCall("ExitGame");
	}

	public override void InstallApk(string apkPath)
	{
		MuCall("InstallApk", apkPath);
	}

	public override T GetVersion<T>()
	{
		return jo.Call<T>("getVersionCode", Array.Empty<object>());
	}

	public override void EnterGame(string roleName, int server)
	{
		Debug.LogError("Android没有对应方法！！ EnterGame(string roleName, int server)");
	}

	public override void JumpAppStore(string url)
	{
		Debug.LogError("Android没有对应方法！！ JumpAppStore(string url)");
	}

	private RoleData roleParams(string roleName, int server)
	{
		return new RoleData
		{
			district = 0,
			roleName = roleName,
			server = server
		};
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
			{ "extToken", data.extToken },
			{ "UnionName", data.UnionName }
		});
	}

	private string encodeRoleData(RoleData roleData)
	{
		new Dictionary<string, object>
		{
			{ "roleName", roleData.roleName },
			{ "district", roleData.district },
			{ "server", roleData.server }
		};
		return string.Empty;
	}

	private string EncodeFilePath(string srcPath, string targetPath)
	{
		new Dictionary<string, object>
		{
			{ "SourcePath", srcPath },
			{ "TargetPath", targetPath }
		};
		return string.Empty;
	}

	private string EncodeItemInfo(BuyItemInfo info)
	{
		new Dictionary<string, object>
		{
			{ "coinCount", info.coinCount },
			{ "bindCoinCount", info.bindCoinCount },
			{ "reminCoinCount", info.reminCoinCount },
			{ "reminBindCounCount", info.reminBindCounCount },
			{ "buyItemCount", info.buyItemCount },
			{ "itemName", info.itemName },
			{ "itemDesc", info.itemDesc }
		};
		return string.Empty;
	}

	public override void GetAppConfig()
	{
		Debug.LogError("ios 实现方法，Android 未定义！");
	}

	public override void SlientLogin()
	{
		Debug.LogError("ios 实现方法，Android 未定义！");
	}

	public override string GetVersion()
	{
		Debug.LogError("ios 实现方法，Android 未定义！");
		return "";
	}

	public override string GetAPPName()
	{
		return MuCall<string>("getAPKName", Array.Empty<object>());
	}

	public override int GetIsSpecialLoad()
	{
		return MuCall<int>("isSpecialLoadSkin", Array.Empty<object>());
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
