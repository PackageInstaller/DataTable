using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GuildMemberViewModel : OptionBase
{
	private int tabIndex;

	private TabItemData curSelectTab;

	private GuildMemberItemData curSelectMember;

	private long curOpePlayerUid;

	private string listTips;

	private string memberCountText;

	private string applicationCountText;

	private List<GuildMemberData> guildMembers;

	private List<PlayerDataBase> guildApplications;

	private List<PlayerDataBase> recommendPlayers;

	private InteractionRequest onTabClickRst = new InteractionRequest();

	private InteractionRequest refreshListRst = new InteractionRequest();

	private InteractionRequest<GuildMemberItem> openOptionPanelRst = new InteractionRequest<GuildMemberItem>();

	private InteractionRequest closeOptionPanelRst = new InteractionRequest();

	private InteractionRequest onNewApplicationRst = new InteractionRequest();

	private SimpleCommand<string> requestCmd;

	private ISubscription<GuildMessage> onGuildMessage;

	public int TabIndex
	{
		get
		{
			return tabIndex;
		}
		set
		{
			Set(ref tabIndex, value, "TabIndex");
			RefreshListTips();
		}
	}

	public string ListTips
	{
		get
		{
			return listTips;
		}
		set
		{
			Set(ref listTips, value, "ListTips");
		}
	}

	public string MemberCountText
	{
		get
		{
			return memberCountText;
		}
		set
		{
			Set(ref memberCountText, value, "MemberCountText");
		}
	}

	public string ApplicationCountText
	{
		get
		{
			return applicationCountText;
		}
		set
		{
			Set(ref applicationCountText, value, "ApplicationCountText");
		}
	}

	public List<GuildMemberData> GuildMembers => guildMembers;

	public List<PlayerDataBase> GuildApplications => guildApplications;

	public List<PlayerDataBase> RecommendPlayers => recommendPlayers;

	public InteractionRequest OnTabClickRst => onTabClickRst;

	public InteractionRequest RefreshListRst => refreshListRst;

	public InteractionRequest<GuildMemberItem> OpenOptionPanelRst => openOptionPanelRst;

	public InteractionRequest CloseOptionPanelRst => closeOptionPanelRst;

	public InteractionRequest OnNewApplicationRst => onNewApplicationRst;

	public SimpleCommand<string> RequestCmd => requestCmd;

	public GuildMemberViewModel()
	{
	}

	public GuildMemberViewModel(OptionBase parent, int tabIndex = 1)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		requestCmd = new SimpleCommand<string>(Request);
		RefreshServiceDatas();
		TabIndex = tabIndex;
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.MemberChange)
		{
			RefreshServiceDatas();
			if (TabIndex == 1)
			{
				refreshListRst.Raise();
			}
		}
		else if (message.Type == GuildMessageEnum.NewApplication)
		{
			RefreshServiceDatas();
			onNewApplicationRst.Raise();
		}
		else if (message.Type == GuildMessageEnum.GuildPermissionChange)
		{
			closeOptionPanelRst.Raise();
		}
	}

	private void RefreshServiceDatas()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
		if (myGuildData != null)
		{
			guildMembers = myGuildData.Members;
			guildApplications = myGuildData.ApplyDatas;
			recommendPlayers = myGuildData.RecommendDatas;
			int valueOrDefault = (guildMembers?.FindAll((GuildMemberData p) => p.State != 4)?.Count).GetValueOrDefault();
			MemberCountText = $"{valueOrDefault}/{guildMembers?.Count ?? 0}";
			ApplicationCountText = $"{guildApplications?.Count ?? 0}/{GuildDefinition.GetMaxApplicationCount()}";
			RefreshListTips();
		}
	}

	private void Request(string arg)
	{
		requestCmd.Enabled = false;
		if (arg.Equals("OpenMemberInfo"))
		{
			TryOpenMemberInfo();
		}
		else if (arg.Equals("SetViceMaster"))
		{
			TrySetMemberPosition(GuildDefinition.GuildPositions.ViceMaster);
		}
		else if (arg.Equals("SetExcellentMember"))
		{
			TrySetMemberPosition(GuildDefinition.GuildPositions.ExcellentMember);
		}
		else if (arg.Equals("SetNormalMember"))
		{
			TrySetMemberPosition(GuildDefinition.GuildPositions.NormalMember);
		}
		else if (arg.Equals("KickMember"))
		{
			TryKickMember();
		}
		else if (arg.Equals("TransMaster"))
		{
			TryTransMaster();
		}
		else if (arg.Equals("ExitGuild"))
		{
			int.TryParse(GameEntry.DataTable.GetDataRow<DRGuildConfig>(12).Value, out var result);
			IAsyncResult<int> result2 = AlertDialog.Show("提示", $"是否确认退出公会，退出后会有{result}小时的冷静期无法加入/创建公会", "确定", "取消");
			result2.Callbackable().OnCallback(delegate
			{
				if (result2.Result == -1)
				{
					TryExitGuild();
				}
				else
				{
					requestCmd.Enabled = true;
				}
			});
		}
		else if (arg.Equals("RefuseApplication"))
		{
			TryOperateApplication(curOpePlayerUid, ope: false);
		}
		else if (arg.Equals("PassApplication"))
		{
			TryOperateApplication(curOpePlayerUid, ope: true);
		}
		else if (arg.Equals("OpenGuildPosition"))
		{
			OpenViewArg obj = new OpenViewArg(typeof(GuildPositionWindow), new GuildPositionViewModel(parent), "GuildMember", isOpenWindow: true, "DEFAULT", delegate
			{
				requestCmd.Enabled = true;
			});
			parent?.ItemOnClick(obj);
		}
		else if (arg.Equals("OpenAuditSetting"))
		{
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			OpenViewArg obj2 = new OpenViewArg(typeof(GuildAuditSettingWindow), new GuildAuditSettingViewModel(parent, myGuildData.AuditType, myGuildData.ApplyLevelThreshold), "GuildMember", isOpenWindow: true, "DEFAULT", delegate
			{
				requestCmd.Enabled = true;
			});
			parent?.ItemOnClick(obj2);
		}
		else if (arg.Equals("RefuseAllApplication"))
		{
			TryRefuseAllApplication();
		}
		else if (arg.Equals("PassAllApplication"))
		{
			TryPassAllApplication();
		}
		else if (arg.Equals("Invite"))
		{
			TryInvitePlayer(curOpePlayerUid);
		}
		else if (arg.Equals("InviteAll"))
		{
			TryInviteAllPlayer();
		}
		else if (arg.Equals("RefreshRecommend"))
		{
			RefreshRecommendPlayers();
		}
		else if (arg.Equals("SendRecruit"))
		{
			TrySendRecruitMsg();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GuildPlayerItemData guildPlayerItemData)
			{
				curOpePlayerUid = guildPlayerItemData.Uid;
				requestCmd.Execute(optionArg.OptionName);
			}
		}
		else if (obj is GuildMemberItem memberSelected)
		{
			SetMemberSelected(memberSelected);
		}
	}

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (curSelectTab != null)
		{
			curSelectTab.IsSelected = false;
		}
		curSelectTab = tabItemData;
		curSelectTab.IsSelected = true;
		TabIndex = tabItemData.TabIndex;
		OnTabSelected(tabItemData);
		onTabClickRst.Raise();
	}

	private void OnTabSelected(TabItemData tabItemData)
	{
		if (TabIndex == 2)
		{
			IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
			List<RedPointSave> redPoint = service.GetRedPoint(RedPointLocalSaveKeys.NewGuildApplication);
			if (guildApplications == null)
			{
				return;
			}
			foreach (PlayerDataBase application in guildApplications)
			{
				if (!redPoint.Exists((RedPointSave p) => p.keyId == application.Uid))
				{
					redPoint.Add(new RedPointSave
					{
						keyId = application.Uid,
						param1 = 0,
						isNew = false
					});
				}
				else
				{
					redPoint.FindAll((RedPointSave p) => p.keyId == application.Uid)?.ForEach(delegate(RedPointSave p)
					{
						p.isNew = false;
					});
				}
			}
			service.SaveRedPoint(redPoint, RedPointLocalSaveKeys.NewGuildApplication);
			IGuildService service2 = Singleton<ServiceSystem>.Instance.GetService<IGuildService>();
			service2?.PublishMessage(GuildMessageEnum.ApplicationRead, service2.GetMyGuildData());
		}
		else if (TabIndex == 3)
		{
			List<PlayerDataBase> recommendDatas = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().RecommendDatas;
			if (recommendDatas == null || recommendDatas.Count <= 0)
			{
				RefreshRecommendPlayers();
			}
		}
	}

	private void SetMemberSelected(GuildMemberItem memberItem)
	{
		curSelectMember = memberItem.ViewModel;
		openOptionPanelRst.Raise(memberItem);
	}

	private void RefreshListTips()
	{
		if (TabIndex == 1)
		{
			ListTips = ((guildMembers.Count > 0) ? string.Empty : "暂无成员信息");
		}
		else if (TabIndex == 2)
		{
			ListTips = ((guildApplications.Count > 0) ? string.Empty : "暂无申请信息");
		}
		else if (TabIndex == 3)
		{
			ListTips = ((recommendPlayers.Count > 0) ? string.Empty : "暂无可寻访人");
		}
		else
		{
			ListTips = string.Empty;
		}
	}

	public void RefreshList(bool refreshData)
	{
		if (refreshData)
		{
			RefreshServiceDatas();
		}
		refreshListRst.Raise();
	}

	private async void TryOpenMemberInfo()
	{
		if (curSelectMember == null)
		{
			requestCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		PlayerData playerData = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSearchPlayer(curSelectMember.MemberData.Uid);
		loading.Dispose();
		if (playerData == null)
		{
			Toast.ShowInfo("查找玩家信息异常，请重试");
			requestCmd.Enabled = true;
			return;
		}
		PlayerInfoViewModel userData = new PlayerInfoViewModel(parent, playerData, isSelf: false);
		parent?.ItemOnClick(new OpenViewArg(typeof(PlayerInfoWindow), userData, "GuildMember", isOpenWindow: true, "DEFAULT", delegate
		{
			requestCmd.Enabled = true;
		}));
		closeOptionPanelRst.Raise();
	}

	private void TrySetMemberPosition(GuildDefinition.GuildPositions newPosition)
	{
		if (curSelectMember == null)
		{
			requestCmd.Enabled = true;
			return;
		}
		IAsyncResult<int> asyncResult = AlertDialog.Show("提示", "是否确认将 " + curSelectMember.Name + " 设为 " + newPosition.GetDescription(), "确定", "取消");
		asyncResult.Callbackable().OnCallback(delegate
		{
			if (asyncResult.Result == -1)
			{
				SetMemberPosition(newPosition);
			}
			else
			{
				requestCmd.Enabled = true;
			}
		});
	}

	private async void SetMemberPosition(GuildDefinition.GuildPositions newPosition)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestChangeMemberPosition(curSelectMember.Uid, (int)newPosition);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("调整职位成功");
			RefreshList(refreshData: true);
		}
		closeOptionPanelRst.Raise();
		requestCmd.Enabled = true;
	}

	private void TryKickMember()
	{
		if (curSelectMember == null)
		{
			requestCmd.Enabled = true;
			return;
		}
		IAsyncResult<int> asyncResult = AlertDialog.Show("提示", "是否确认将 " + curSelectMember.Name + " 请出公会", "确定", "取消");
		asyncResult.Callbackable().OnCallback(delegate
		{
			if (asyncResult.Result == -1)
			{
				KickMember();
			}
			else
			{
				requestCmd.Enabled = true;
			}
		});
	}

	private async void KickMember()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestKickMember(curSelectMember.Uid);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("成功请出");
			RefreshList(refreshData: true);
		}
		closeOptionPanelRst.Raise();
		requestCmd.Enabled = true;
	}

	private void TryTransMaster()
	{
		if (curSelectMember == null)
		{
			requestCmd.Enabled = true;
			return;
		}
		IAsyncResult<int> asyncResult = AlertDialog.Show("提示", "是否确认将会长转让给 " + curSelectMember.Name, "确定", "取消");
		asyncResult.Callbackable().OnCallback(delegate
		{
			if (asyncResult.Result == -1)
			{
				TranMaster();
			}
			else
			{
				requestCmd.Enabled = true;
			}
		});
	}

	private async void TranMaster()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestTransMaster(curSelectMember.Uid);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("转让成功");
			RefreshList(refreshData: true);
		}
		closeOptionPanelRst.Raise();
		requestCmd.Enabled = true;
	}

	private async void TryExitGuild()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestExitGuild();
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("退出公会成功");
			parent?.ItemOnClick("CloseWindow");
		}
		else
		{
			requestCmd.Enabled = true;
		}
	}

	private async void TryOperateApplication(long uid, bool ope)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestReplyToApplication(uid, ope);
		loading?.Dispose();
		if (num)
		{
			RefreshList(refreshData: true);
		}
		requestCmd.Enabled = true;
	}

	private async void TryRefuseAllApplication()
	{
		if (guildApplications.Count <= 0)
		{
			Toast.ShowInfo("暂无申请");
			requestCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestCleanApplication();
		loading?.Dispose();
		if (num)
		{
			RefreshList(refreshData: true);
		}
		requestCmd.Enabled = true;
	}

	private async void TryPassAllApplication()
	{
		if (guildApplications.Count <= 0)
		{
			Toast.ShowInfo("暂无申请");
			requestCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestPassAllApplication();
		loading?.Dispose();
		if (num)
		{
			RefreshList(refreshData: true);
		}
		requestCmd.Enabled = true;
	}

	private async void RefreshRecommendPlayers()
	{
		Loading loading = await Loading.Show();
		List<PlayerDataBase> obj = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestRecommendPlayers();
		loading?.Dispose();
		if (obj != null)
		{
			Toast.ShowInfo("刷新成功");
			RefreshList(refreshData: true);
		}
		requestCmd.Enabled = true;
	}

	private async void TrySendRecruitMsg()
	{
		IGuildService service = Singleton<ServiceSystem>.Instance.GetService<IGuildService>();
		MyGuildData myGuildData = service?.GetMyGuildData();
		if (myGuildData == null)
		{
			return;
		}
		if (myGuildData.LeftRecruitTime > 0f)
		{
			Toast.ShowInfo($"{myGuildData.LeftRecruitTime}秒后可发送招募信息");
			requestCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		bool num = await service.RequestSendRecruitInfo();
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("招募信息发送成功");
			await (myGuildData?.StartRecruitTimer());
		}
		requestCmd.Enabled = true;
	}

	private async void TryInvitePlayer(long uid)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestInviteToGuild(uid, haveCooling: false);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("邀请成功");
		}
		RefreshList(refreshData: true);
		requestCmd.Enabled = true;
	}

	private async void TryInviteAllPlayer()
	{
		List<long> uids = new List<long>();
		recommendPlayers?.ForEach(delegate(PlayerDataBase p)
		{
			uids.Add(p.Uid);
		});
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestInviteAll(uids);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("全部邀请发送成功");
			RefreshList(refreshData: true);
		}
		requestCmd.Enabled = true;
	}
}
