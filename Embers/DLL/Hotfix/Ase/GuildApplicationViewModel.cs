using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class GuildApplicationViewModel : OptionBase
{
	private int curTabIndex = 1;

	private TabItemData curSelectTab;

	private ISubscription<GuildMessage> onGuildMessage;

	private InteractionRequest onTabClickRst = new InteractionRequest();

	private bool openReportEnable = true;

	public int CurTabIndex
	{
		get
		{
			return curTabIndex;
		}
		set
		{
			Set(ref curTabIndex, value, "CurTabIndex");
		}
	}

	public InteractionRequest OnTabClickRst => onTabClickRst;

	public GuildApplicationViewModel()
	{
	}

	public GuildApplicationViewModel(OptionBase parent, int tabIndex = 1)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		CurTabIndex = tabIndex;
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		switch (obj as string)
		{
		case "CloseWindow":
			Close();
			break;
		case "CloseAndOpenGuildWindow":
			if (parent != null)
			{
				OptionBase parentVm = parent;
				Close();
				Loading loading = await Loading.Show();
				GuildViewModel guildViewModel = new GuildViewModel(parentVm);
				await guildViewModel.RequestData();
				loading?.Dispose();
				parentVm.ItemOnClick(new OpenViewArg(typeof(GuildWindow), guildViewModel));
			}
			break;
		case null:
			if (obj is TabItemData tabSelected)
			{
				SetTabSelected(tabSelected);
				onTabClickRst.Raise();
			}
			else if (obj is OptionArg { OptionName: "OpenReport", Obj: GuildItemData obj2 })
			{
				OpenReportPopupWindow(obj2.WorldPosition, obj2.GuildData.Name, obj2.GuildData.Uid);
			}
			break;
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
		CurTabIndex = tabItemData.TabIndex;
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.JoinInGuild && message.Arg is MyGuildData)
		{
			Close();
		}
	}

	private void OpenReportPopupWindow(Vector3 worldPosition, string name, long uid)
	{
		if (openReportEnable)
		{
			openReportEnable = false;
			base.ItemOnClick((object)new OpenViewArg(typeof(ReportPopupWindow), new ReportPopupViewModel(parent, worldPosition, ReportTypeEnum.Guild, name, uid), "GuildRank", isOpenWindow: true, "DEFAULT", delegate
			{
				openReportEnable = true;
			}));
		}
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
