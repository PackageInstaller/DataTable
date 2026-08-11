#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class GuildViewModel : OptionBase
{
	private int curTabIndex = 1;

	private TabItemData curSelectTab;

	private List<TabItemData> _tabItemDatas = new List<TabItemData>();

	private InteractionRequest onTabClickRst = new InteractionRequest();

	private ISubscription<GuildMessage> onGuildMessage;

	private GuildInfoViewModel infoViewModel;

	private GuildMemberViewModel memberViewModel;

	private GuildTaskViewModel taskViewModel;

	private GuildShopViewModel shopViewModel;

	private GuildActivityViewModel activityViewModel;

	private PropExchangeViewModel exchangeViewModel;

	private SimpleCommand<string> optCommand;

	public OptionArg initParam;

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

	public GuildInfoViewModel InfoViewModel => infoViewModel;

	public GuildMemberViewModel MemberViewModel => memberViewModel;

	public GuildTaskViewModel TaskViewModel => taskViewModel;

	public GuildShopViewModel ShopViewModel => shopViewModel;

	public GuildActivityViewModel ActivityViewModel => activityViewModel;

	public InteractionRequest OnTabClickRst => onTabClickRst;

	public GuildViewModel()
	{
	}

	public GuildViewModel(OptionBase parent, int tabIndex = 1)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>().OnGuildActivityChange(isActive: true);
		optCommand = new SimpleCommand<string>(delegate
		{
		});
		infoViewModel = new GuildInfoViewModel(this);
		memberViewModel = new GuildMemberViewModel(this);
		taskViewModel = new GuildTaskViewModel(this);
		shopViewModel = new GuildShopViewModel(this)
		{
			CurTabIndex = GuildDefinition.GetGuildMainShopId()
		};
		activityViewModel = new GuildActivityViewModel(this);
		AddChild(infoViewModel);
		AddChild(memberViewModel);
		AddChild(taskViewModel);
		AddChild(shopViewModel);
		AddChild(activityViewModel);
		exchangeViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeViewModel);
		CurTabIndex = tabIndex;
	}

	public async Task RequestData()
	{
		await shopViewModel.RequestData();
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is string text)
		{
			if (text == "CloseWindow")
			{
				Close();
			}
		}
		else if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is ShopGoodItemData shopGoodItemData)
		{
			ShopDefinition.OnShopGoodItemClick(shopGoodItemData.ExcData, exchangeViewModel, this, "GuildWindow");
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				await OnExchangeConfirmExc();
			}
			else if ("OpenActivityExpedition".Equals(optionArg.OptionName))
			{
				OnOpenActivityExpedition((GuildActivityItemViewModel)optionArg.Obj);
			}
			else if ("OpenActivityExpeditionWithCopy".Equals(optionArg.OptionName))
			{
				OnOpenActivityExpedition((CopyData)optionArg.Obj);
			}
		}
	}

	public TabItemData CreateTabItemData(int tabIndex)
	{
		TabItemData tabItemData = new TabItemData(this, tabIndex);
		_tabItemDatas.Add(tabItemData);
		return tabItemData;
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
		onTabClickRst.Raise();
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.Kicked || message.Type == GuildMessageEnum.ExitGuild || message.Type == GuildMessageEnum.GuildDismissed)
		{
			Close();
		}
		else if (message.Type == GuildMessageEnum.GuildLevelChange)
		{
			infoViewModel?.RefreshData();
		}
		else if (message.Type == GuildMessageEnum.GuildAssetChange)
		{
			infoViewModel?.RefreshData();
		}
		else if (message.Type == GuildMessageEnum.MemberChange)
		{
			infoViewModel?.RefreshData();
		}
		else if (message.Type == GuildMessageEnum.GuildPermissionChange && _tabItemDatas != null && _tabItemDatas.Count > 0)
		{
			SetTabSelected(_tabItemDatas[0]);
		}
	}

	private async Task OnExchangeConfirmExc()
	{
		object exchangeData = exchangeViewModel.ExchangeData;
		if (exchangeData is ShopExcData shopExcData)
		{
			Loading loading = await Loading.Show();
			int consumeSchemeIndex = ((exchangeViewModel.ConsumeSchemeType == ExchangeConsumeScheme.Multiple) ? exchangeViewModel.CurSchemeTabIndex : 0);
			RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopExchange(shopExcData.MainShopId, shopExcData.ShopId, shopExcData.ExcId, exchangeViewModel.UseCount, consumeSchemeIndex);
			loading.Dispose();
			if (rewardGetData != null)
			{
				if (rewardGetData.PropList.Count > 0)
				{
					PropGetViewModel userData = new PropGetViewModel(this, rewardGetData.PropList);
					openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				}
				shopViewModel?.OnExchangeSucceed(shopExcData.MainShopId, shopExcData.ShopId, shopExcData.ExcId, exchangeViewModel.UseCount);
				exchangeViewModel.SetData(shopExcData);
				showViewRequest.Raise(new ShowViewArg(exchangeViewModel, isShow: false));
			}
		}
		exchangeViewModel.OnEnable();
	}

	private void OnOpenActivityExpedition(GuildActivityItemViewModel item)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		try
		{
			optCommand.Enabled = false;
			GuildActivityExpeditionViewModel userData = new GuildActivityExpeditionViewModel(this, item);
			openWindowRequest.Raise(new OpenViewArg(typeof(GuildActivityExpeditionWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开界面发生异常 " + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void OnOpenActivityExpedition(CopyData copyData)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		try
		{
			optCommand.Enabled = false;
			GuildActivityItemViewModel validExpetionItem = activityViewModel.GetValidExpetionItem(copyData);
			GuildActivityExpeditionViewModel userData = new GuildActivityExpeditionViewModel(this, validExpetionItem, copyData);
			openWindowRequest.Raise(new OpenViewArg(typeof(GuildActivityExpeditionWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开界面发生异常 " + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public bool SetOpenActivityExpedition(CopyData copyData)
	{
		try
		{
			if (activityViewModel != null)
			{
				GuildActivityItemViewModel validExpetionItem = activityViewModel.GetValidExpetionItem(copyData);
				if (validExpetionItem == null)
				{
					return false;
				}
				if (validExpetionItem.Data.IsEveryTimeLock)
				{
					Toast.ShowInfo("副本未开放");
					return false;
				}
				initParam = new OptionArg(copyData, "OpenActivityExpeditionWithCopy");
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开界面发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	public void SettleInitParam()
	{
		if (initParam != null)
		{
			ItemOnClick(initParam);
		}
		initParam = null;
	}

	protected override void Dispose(bool disposing)
	{
		Singleton<ServiceSystem>.Instance?.GetService<IGuildService>()?.OnGuildActivityChange(isActive: true);
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
