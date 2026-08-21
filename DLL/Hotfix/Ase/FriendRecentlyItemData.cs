using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class FriendRecentlyItemData : ItemOptionBase
{
	private PlayerData playerData;

	private bool isFriend;

	private string funcText;

	private SimpleCommand addBlackListCmd;

	private SimpleCommand onFuncBtnClickCmd;

	private InteractionRequest chatRst = new InteractionRequest();

	public PlayerData PlayerData
	{
		get
		{
			return playerData;
		}
		set
		{
			Set(ref playerData, value, "PlayerData");
			IsFriend = playerData.RelationShip == PlayerData.RelationState.Friend;
			FuncText = (IsFriend ? "聊天" : "加为好友");
		}
	}

	public bool IsFriend
	{
		get
		{
			return isFriend;
		}
		set
		{
			Set(ref isFriend, value, "IsFriend");
		}
	}

	public string FuncText
	{
		get
		{
			return funcText;
		}
		set
		{
			Set(ref funcText, value, "FuncText");
		}
	}

	public SimpleCommand AddBlackListCmd => addBlackListCmd;

	public SimpleCommand OnFuncBtnClickCmd => onFuncBtnClickCmd;

	public InteractionRequest ChatRst => chatRst;

	public FriendRecentlyItemData()
	{
	}

	public FriendRecentlyItemData(OptionBase parent, PlayerData playerData)
	{
		addBlackListCmd = new SimpleCommand(AddBlackList);
		onFuncBtnClickCmd = new SimpleCommand(OnFuncBtnClick);
		base.parent = parent;
		PlayerData = playerData;
	}

	public void OnLookInfoBtnClick()
	{
		if (parent is FriendViewModel friendViewModel)
		{
			friendViewModel.OpenPlayerInfoRequest.Raise(new PlayerInfoViewModel(friendViewModel, playerData, isSelf: false));
		}
	}

	public async void AddBlackList()
	{
		if (PlayerData == null)
		{
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否将该玩家加入黑名单", "确定", "取消", autoPause: false);
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				AddToBlackList();
			}
		});
	}

	public void OnFuncBtnClick()
	{
		if (PlayerData == null)
		{
			return;
		}
		onFuncBtnClickCmd.Enabled = false;
		if (FuncText.Equals("聊天"))
		{
			ChatRst.Raise();
			onFuncBtnClickCmd.Enabled = true;
		}
		else
		{
			if (!FuncText.Equals("加为好友"))
			{
				return;
			}
			IAsyncResult<KeyValuePair<int, string>> result = VerifyDialog.Show("添加好友", "申请后需等待对方通过", "请输入验证信息（最多15字）", "确定");
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result.Key == -1)
				{
					if (result.Result.Value.Length > 15)
					{
						Toast.ShowInfo("验证信息不可超过15字");
					}
					else
					{
						AddFriend(result.Result.Value);
					}
				}
				onFuncBtnClickCmd.Enabled = true;
			});
		}
	}

	private async void AddToBlackList()
	{
		addBlackListCmd.Enabled = false;
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().HandleFriendBlackList(PlayerData, ope: true);
		loading.Dispose();
		addBlackListCmd.Enabled = true;
	}

	private async void AddFriend(string verifyMsg)
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().AddFriend(PlayerData, verifyMsg);
		loading.Dispose();
		onFuncBtnClickCmd.Enabled = true;
	}
}
