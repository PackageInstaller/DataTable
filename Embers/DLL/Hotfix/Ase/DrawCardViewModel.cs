#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.DataTable;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardViewModel : OptionBase
{
	private SimpleCommand oneTimeCommand;

	private SimpleCommand tenTimeCommand;

	private bool canLottery;

	private int tenTimePrice;

	private bool isSale;

	private int saleCount;

	private SimpleCommand openExchangeCommand;

	private SimpleCommand openDetailCommand;

	private SimpleCommand openPreviewCommand;

	private bool isShowPreview;

	private MoneyData moneyData;

	private List<DrawCardTabData> poolTabsData;

	private DrawCardTabData curPoolInfo;

	private InteractionRequest switchImgRequest;

	private InteractionRequest refreshPoolRequest;

	private DrawCardTenViewModel drawCardTenViewModel;

	private int dropType;

	private bool showOption;

	private Dictionary<int, List<DrawCardItemInfo>> chooseWindowDic;

	private int chooseIndex;

	private List<int> chooseIndexList;

	private List<DrawCardItemInfo> newCardShowList;

	private int newCardIndex;

	private DrawCardMode drawCardMode;

	private bool isInTenWindo;

	private List<DrawCardItemInfo> resultList;

	public bool IsSkip;

	private bool isMask;

	private string leftTimes;

	private string leftRefreshTimeText;

	private int remainPurpleCardCount;

	private int remainGoldenCardCount;

	private string remainPurpleCardCountTxt;

	private string remainGoldenCardCountTxt;

	private string purpleCardTxt;

	private string goldenCardTxt;

	private bool isShowDrawCardTxt;

	private int isCardTimesOrCardCount;

	private Timer timer;

	private DrawCardManager drawCardManager;

	private DrawCardInfoItemData drawCardInfoItemData;

	private DrawCardOptionalViewModel drawCardOptionalViewModel;

	private IMessenger messenger;

	private ISubscription<DrawCardMessage> subscription_DrawCard;

	private InteractionRequest setWindowAlphaToOneRequest;

	private bool needRefreshPool;

	private List<int> ssrIdList = new List<int>();

	private List<int> srIdList = new List<int>();

	private int upType;

	private Dictionary<int, List<DrawCardRecordInfo>> cardRecordInfoDic;

	public MoneyData MoneyData => moneyData;

	public SimpleCommand OneTimeCommand => oneTimeCommand;

	public SimpleCommand TenTimeCommand => tenTimeCommand;

	public SimpleCommand OpenExchangeCommand => openExchangeCommand;

	public SimpleCommand OpenDetailCommand => openDetailCommand;

	public SimpleCommand OpenPreviewCommand => openPreviewCommand;

	public InteractionRequest SwitchImgRequest => switchImgRequest;

	public InteractionRequest RefreshPoolRequest => refreshPoolRequest;

	public DrawCardMode DrawCardMode => drawCardMode;

	public InteractionRequest SetWindowAlphaToOneRequest => setWindowAlphaToOneRequest;

	public List<DrawCardTabData> PoolTabsData
	{
		get
		{
			return poolTabsData;
		}
		private set
		{
			Set(ref poolTabsData, value, "PoolTabsData");
		}
	}

	public DrawCardTabData CurPoolInfo
	{
		get
		{
			return curPoolInfo;
		}
		private set
		{
			Set(ref curPoolInfo, value, "CurPoolInfo");
		}
	}

	public int TenTimePrice
	{
		get
		{
			return tenTimePrice;
		}
		private set
		{
			Set(ref tenTimePrice, value, "TenTimePrice");
		}
	}

	public bool IsSale
	{
		get
		{
			return isSale;
		}
		private set
		{
			Set(ref isSale, value, "IsSale");
		}
	}

	public int SaleCount
	{
		get
		{
			return saleCount;
		}
		private set
		{
			Set(ref saleCount, value, "SaleCount");
		}
	}

	public bool IsMask
	{
		get
		{
			return isMask;
		}
		private set
		{
			Set(ref isMask, value, "IsMask");
		}
	}

	public bool IsShowPreview
	{
		get
		{
			return isShowPreview;
		}
		private set
		{
			Set(ref isShowPreview, value, "IsShowPreview");
		}
	}

	public string LeftTimes
	{
		get
		{
			return leftTimes;
		}
		private set
		{
			Set(ref leftTimes, value, "LeftTimes");
		}
	}

	public int DropType
	{
		get
		{
			return dropType;
		}
		private set
		{
			Set(ref dropType, value, "DropType");
		}
	}

	public bool ShowOption
	{
		get
		{
			return showOption;
		}
		private set
		{
			Set(ref showOption, value, "ShowOption");
		}
	}

	public int IsCardTimesOrCardCount
	{
		get
		{
			return isCardTimesOrCardCount;
		}
		set
		{
			Set(ref isCardTimesOrCardCount, value, "IsCardTimesOrCardCount");
		}
	}

	public string LeftRefreshTimeText
	{
		get
		{
			return leftRefreshTimeText;
		}
		private set
		{
			Set(ref leftRefreshTimeText, value, "LeftRefreshTimeText");
		}
	}

	public DrawCardInfoItemData DrawCardInfoItemData
	{
		get
		{
			return drawCardInfoItemData;
		}
		set
		{
			Set(ref drawCardInfoItemData, value, "DrawCardInfoItemData");
		}
	}

	public string RemainPurpleCardCountTxt
	{
		get
		{
			return remainPurpleCardCountTxt;
		}
		set
		{
			Set(ref remainPurpleCardCountTxt, value, "RemainPurpleCardCountTxt");
		}
	}

	public string RemainGoldenCardCountTxt
	{
		get
		{
			return remainGoldenCardCountTxt;
		}
		set
		{
			Set(ref remainGoldenCardCountTxt, value, "RemainGoldenCardCountTxt");
		}
	}

	public string PurpleCardTxt
	{
		get
		{
			return purpleCardTxt;
		}
		set
		{
			Set(ref purpleCardTxt, value, "PurpleCardTxt");
		}
	}

	public string GoldenCardTxt
	{
		get
		{
			return goldenCardTxt;
		}
		set
		{
			Set(ref goldenCardTxt, value, "GoldenCardTxt");
		}
	}

	public bool IsShowDrawCardTxt
	{
		get
		{
			return isShowDrawCardTxt;
		}
		set
		{
			Set(ref isShowDrawCardTxt, value, "IsShowDrawCardTxt");
		}
	}

	public int RemainGoldenCardCount
	{
		get
		{
			return remainGoldenCardCount;
		}
		set
		{
			Set(ref remainGoldenCardCount, value, "RemainGoldenCardCount");
		}
	}

	public int RemainPurpleCardCount
	{
		get
		{
			return remainPurpleCardCount;
		}
		set
		{
			Set(ref remainPurpleCardCount, value, "RemainPurpleCardCount");
		}
	}

	public DrawCardViewModel(OptionBase parent, MoneyData moneyData, List<DrawCardTabData> drawCardTabInfos, List<DrawCardItemInfo> drawCardItemInfos, int defaultPoolId = 0)
	{
		base.parent = parent;
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_DrawCard = messenger.Subscribe<DrawCardMessage>(GetTaskNotify);
		this.moneyData = moneyData;
		oneTimeCommand = new SimpleCommand(DrawCardOneTime);
		tenTimeCommand = new SimpleCommand(DrawCardTenTime);
		openExchangeCommand = new SimpleCommand(OpenExchangeView);
		openDetailCommand = new SimpleCommand(OpenDetailView);
		openPreviewCommand = new SimpleCommand(OpenPreviewWindow);
		canLottery = true;
		switchImgRequest = new InteractionRequest();
		refreshPoolRequest = new InteractionRequest();
		setWindowAlphaToOneRequest = new InteractionRequest();
		isInTenWindo = false;
		IsSkip = false;
		chooseWindowDic = new Dictionary<int, List<DrawCardItemInfo>>();
		chooseIndexList = new List<int>();
		newCardShowList = new List<DrawCardItemInfo>();
		drawCardInfoItemData = new DrawCardInfoItemData(this);
		cardRecordInfoDic = new Dictionary<int, List<DrawCardRecordInfo>>();
		poolTabsData = drawCardTabInfos;
		SetParent();
		SetDefaultCardPool((defaultPoolId == 0) ? PoolTabsData[0].DrawCardPoolInfo.Id : defaultPoolId);
		LoadLastDrawCardResult(drawCardItemInfos);
		Dictionary<int, List<DrawCardItemInfo>> dictionary = chooseWindowDic;
		int num;
		if (dictionary != null)
		{
			Dictionary<int, List<DrawCardItemInfo>>.ValueCollection values = dictionary.Values;
			if (values != null)
			{
				num = ((values.Count > 0) ? 1 : 0);
				goto IL_0197;
			}
		}
		num = 0;
		goto IL_0197;
		IL_0197:
		IsMask = (byte)num != 0;
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	private void SetDefaultCardPool(int poolId)
	{
		foreach (DrawCardTabData poolTabsDatum in PoolTabsData)
		{
			if (poolTabsDatum.DrawCardPoolInfo.Id == poolId)
			{
				poolTabsDatum.RedPointOnClick();
				TabItemOnclick(poolTabsDatum);
				return;
			}
		}
		PoolTabsData[0].RedPointOnClick();
		TabItemOnclick(PoolTabsData[0]);
	}

	private void GetTaskNotify(DrawCardMessage message)
	{
		if (message.MsgEnum == DrawCardMsgEnum.Close)
		{
			needRefreshPool = true;
		}
		else if (message.MsgEnum == DrawCardMsgEnum.ClosePoolImmediately)
		{
			RefreshPoolInfo();
		}
	}

	private void RefreshPoolInfo()
	{
		poolTabsData = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetDrawCardTabInfos();
		SetParent();
		TabItemOnclick(PoolTabsData[0]);
		PoolTabsData[0].RedPointOnClick();
		refreshPoolRequest.Raise();
		needRefreshPool = false;
	}

	private void SetParent()
	{
		foreach (DrawCardTabData poolTabsDatum in poolTabsData)
		{
			poolTabsDatum.SetParent(this);
		}
		poolTabsData.Sort((DrawCardTabData x, DrawCardTabData y) => x.DrawCardPoolInfo.Id.CompareTo(y.DrawCardPoolInfo.Id));
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ViewBackArg viewBackArg)
		{
			if (!(viewBackArg.Obj is DrawCardTenViewModel) && !(viewBackArg.Obj is DrawCardSingleViewModel))
			{
				return;
			}
			if (drawCardMode == DrawCardMode.One)
			{
				WillResultJionAllCardsDic();
				InitCurCardPoolRemainCountInfo();
			}
			else if (drawCardMode == DrawCardMode.Ten && viewBackArg.Obj is DrawCardTenViewModel)
			{
				WillResultJionAllCardsDic();
				InitCurCardPoolRemainCountInfo();
			}
		}
		base.ItemOnClick(obj);
		if (obj is DrawCardTabData drawCardTabData)
		{
			if (!drawCardTabData.IsSelected)
			{
				TabItemOnclick(drawCardTabData);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (!(optionArg.Obj is DrawCardSingleViewModel drawCardSingleViewModel) || optionArg.OptionName.Equals("BackString"))
			{
				return;
			}
			drawCardSingleViewModel.Close();
			if (optionArg.OptionName.Equals("SingleShowSkip"))
			{
				if (DrawCardMode == DrawCardMode.One)
				{
					LoadProduct();
				}
				else if (DrawCardMode == DrawCardMode.Ten)
				{
					IsSkip = true;
					newCardIndex = newCardShowList.Count;
					FirstOpenNewSingleWindow();
				}
			}
			else if (optionArg.OptionName.Equals("Next"))
			{
				if (DrawCardMode == DrawCardMode.One)
				{
					LoadProduct();
				}
				else if (DrawCardMode == DrawCardMode.Ten)
				{
					LoadNewCardWindow();
				}
			}
		}
		else if (obj is string text)
		{
			canLottery = true;
			oneTimeCommand.Enabled = true;
			tenTimeCommand.Enabled = true;
			if (text.Equals("OpenResult"))
			{
				if (drawCardMode == DrawCardMode.Ten)
				{
					OpenDrawTenWindow();
				}
				else if (drawCardMode == DrawCardMode.One)
				{
					Dictionary<int, List<DrawCardItemInfo>> dictionary = chooseWindowDic;
					if (dictionary != null && dictionary.Count > 0)
					{
						chooseIndex++;
						OpenChooseWindow(chooseWindowDic.Values.ToList()[0]);
						return;
					}
					OpenSingleViewModel(GetSingleViewModel(resultList[0], resultList[0].IsNew), needDelay: true);
				}
				CloseDrawCardScene();
				SetWindowAlphaToOneRequest.Raise();
			}
			else if (text.Equals("BeatStoneSkip"))
			{
				BeatStoneSkip();
				CloseDrawCardScene();
				SetWindowAlphaToOneRequest.Raise();
			}
			else if (text.Equals("Next"))
			{
				Choose();
			}
			else if (text.Equals("TenWindowShow"))
			{
				drawCardTenViewModel.PlayEnterAnimation();
			}
			else if (text.Equals("PlayLight"))
			{
				drawCardTenViewModel.PlayAllLightAnimation();
				FirstOpenNewSingleWindow();
			}
		}
		else if (obj is DrawCardTenViewModel)
		{
			isInTenWindo = false;
			LoadProduct();
		}
		else if (obj is DrawCardChooseViewModel drawCardChooseViewModel)
		{
			chooseIndexList.Add(drawCardChooseViewModel.SelectedViewModel.Index);
			List<int> list = chooseWindowDic.Keys.ToList();
			bool isNew = false;
			if (drawCardTenViewModel != null)
			{
				isNew = drawCardTenViewModel.SetConvertImg(list[chooseIndex - 1], drawCardChooseViewModel.SelectedViewModel.Index);
			}
			if (chooseIndex == chooseWindowDic.Values.Count)
			{
				SendChooseIndexResult();
			}
			DrawCardSingleViewModel singleViewModel = GetSingleViewModel(drawCardChooseViewModel.SelectedViewModel.DrawCardItemInfo, isNew);
			OpenSingleViewModel(singleViewModel, needDelay: false, drawCardChooseViewModel);
		}
		else if (obj is DrawCardInfoItemData drawCardInfoItemData)
		{
			OpenOptionalWindow(drawCardInfoItemData.Id);
		}
		else if (obj is DrawCardOptionalItemData upInfoItem)
		{
			SetUpInfoItem(upInfoItem);
		}
	}

	private async void Choose()
	{
		List<int> drawCardIndexList = chooseWindowDic.Keys.ToList();
		drawCardTenViewModel?.PlayAnimation(drawCardIndexList[chooseIndex - 1], "Load");
		if (isInTenWindo && chooseIndex < chooseWindowDic.Values.Count)
		{
			await UniTask.Delay(2000);
		}
		if (chooseIndex < drawCardIndexList.Count)
		{
			drawCardTenViewModel?.PlayAnimation(drawCardIndexList[chooseIndex], "Light");
		}
		if (isInTenWindo && chooseIndex < chooseWindowDic.Values.Count)
		{
			await UniTask.Delay(1500);
		}
		if (chooseIndex < chooseWindowDic.Values.Count)
		{
			OpenChooseWindow(chooseWindowDic.Values.ToList()[chooseIndex]);
		}
		if (chooseIndex >= chooseWindowDic.Values.Count)
		{
			if (drawCardTenViewModel != null)
			{
				StartChoose();
			}
		}
		else
		{
			chooseIndex++;
		}
	}

	private async void SendChooseIndexResult()
	{
		Loading loading = await Loading.Show();
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ChooseLotteryResult(chooseIndexList)))
		{
			Toast.ShowInfo("多选失败!");
		}
		loading.Dispose();
	}

	private async void CloseDrawCardScene()
	{
		await UniTask.Delay(1500);
		drawCardManager.DestroyStone();
		drawCardManager = null;
	}

	private void BeatStoneSkip()
	{
		IsSkip = true;
		if (DrawCardMode == DrawCardMode.One)
		{
			if (chooseWindowDic != null && chooseWindowDic.Count > 0)
			{
				chooseIndex++;
				OpenChooseWindow(chooseWindowDic.Values.ToList()[0]);
			}
			else
			{
				OpenSingleViewModel(GetSingleViewModel(resultList[0], resultList[0].IsNew), needDelay: true);
			}
		}
		else if (DrawCardMode == DrawCardMode.Ten)
		{
			OpenDrawTenWindow();
		}
	}

	private async void OpenSingleViewModel(DrawCardSingleViewModel drawCardSingleViewModel, bool needDelay = false, DrawCardChooseViewModel drawCardChooseViewModel = null)
	{
		if (needDelay)
		{
			await UniTask.Delay(300);
		}
		if (drawCardSingleViewModel.IsSsr)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardSSRWindow), drawCardSingleViewModel), delegate
			{
				drawCardChooseViewModel?.Close();
			});
		}
		else
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardSRWindow), drawCardSingleViewModel), delegate
			{
				drawCardChooseViewModel?.Close();
			});
		}
	}

	private void LoadLastDrawCardResult(List<DrawCardItemInfo> drawCardItemInfos)
	{
		if (drawCardItemInfos.Count == 0)
		{
			return;
		}
		for (int i = 0; i < drawCardItemInfos.Count; i++)
		{
			if (drawCardItemInfos[i].ChooseIds != null)
			{
				List<DrawCardItemInfo> list = new List<DrawCardItemInfo>();
				for (int j = 0; j < drawCardItemInfos[i].ChooseIds.Count; j++)
				{
					DrawCardItemInfo item = DrawCardItemInfoConvert.Convert(drawCardItemInfos[i].ChooseIds[j], drawCardItemInfos[i].ChooseTypes[j]);
					list.Add(item);
				}
				chooseWindowDic.Add(i, list);
			}
		}
	}

	public void OnShow()
	{
		if (IsMask)
		{
			chooseIndex++;
			if (chooseWindowDic.Values.Count > 0)
			{
				OpenChooseWindow(chooseWindowDic.Values.ToList()[0]);
			}
		}
	}

	public void TabItemOnclick(DrawCardTabData data)
	{
		if (curPoolInfo != null)
		{
			curPoolInfo.ChangeSelected(value: false);
		}
		CurPoolInfo = data;
		CurPoolInfo.ChangeSelected(value: true);
		LeftTimes = ((CurPoolInfo.DrawCardPoolInfo.LotteryMax == 0) ? "" : $"剩余抽卡次数{CurPoolInfo.DrawCardPoolInfo.LotteryLeft}/{CurPoolInfo.DrawCardPoolInfo.LotteryMax}");
		RefreshTime();
		SetTimeSale();
		DropType = CurPoolInfo.DrawCardPoolInfo.DropType;
		if (DropType == 1)
		{
			ShowOption = CurPoolInfo.DrawCardPoolInfo.Trigger < CurPoolInfo.DrawCardPoolInfo.MaxTrigger;
		}
		else
		{
			ShowOption = false;
		}
		SetUpInfoItem();
		InitCurCardPoolRemainCountInfo();
		switchImgRequest.Raise();
		CheckPreviewWindow();
	}

	private void SetTimeSale()
	{
		int num = CurPoolInfo.DrawCardPoolInfo.LotteryMax - CurPoolInfo.DrawCardPoolInfo.LotteryLeft;
		TenTimePrice = 10;
		IsSale = false;
		if (CurPoolInfo.DrawCardPoolInfo.SaleNum > 0 && num < CurPoolInfo.DrawCardPoolInfo.SaleTime)
		{
			IsSale = true;
			TenTimePrice = 10 * (100 - CurPoolInfo.DrawCardPoolInfo.SaleNum) / 100;
			SaleCount = CurPoolInfo.DrawCardPoolInfo.SaleNum;
		}
	}

	private void SetUpInfoItem(DrawCardOptionalItemData drawCardOptionalItemData = null)
	{
		drawCardOptionalViewModel?.Close();
		if (DropType != 1)
		{
			return;
		}
		string icon = "empty";
		int num = 0;
		if (drawCardOptionalItemData != null)
		{
			if (drawCardOptionalItemData.ItemType == 4)
			{
				icon = $"UserHead{drawCardOptionalItemData.ItemId}_0";
			}
			else if (drawCardOptionalItemData.ItemType == 5)
			{
				icon = drawCardOptionalItemData.ItemIcon;
			}
			num = drawCardOptionalItemData.ItemId;
		}
		else
		{
			num = CurPoolInfo.DrawCardPoolInfo.SelectUpId;
			if (CurPoolInfo.DrawCardPoolInfo.SelectUpId == 0)
			{
				DRChoose dataRow = GameEntry.DataTable.GetDataRow((DRChoose p) => p.CardId == CurPoolInfo.DrawCardPoolInfo.Id);
				if (dataRow != null)
				{
					num = dataRow.Option[0];
				}
				Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ChooseOptionalHero(CurPoolInfo.DrawCardPoolInfo.Id, num);
				if (dataRow != null && dataRow.IsPopUp)
				{
					OpenOptionalWindow(0);
				}
			}
			if (GameEntry.DataTable.GetDataRow<DRHeroInfo>(num) != null)
			{
				icon = $"UserHead{num}_0";
			}
			else
			{
				DRWeapon dataRow2 = GameEntry.DataTable.GetDataRow<DRWeapon>(num);
				if (dataRow2 == null)
				{
					Toast.ShowError($"武器:{num}的数据错误!");
					return;
				}
				icon = dataRow2.Icon;
			}
		}
		drawCardInfoItemData?.SetNewInfo(icon, num);
	}

	private void DrawCardOneTime()
	{
		if (!canLottery)
		{
			return;
		}
		drawCardMode = DrawCardMode.One;
		if (oneTimeCommand.Enabled)
		{
			canLottery = false;
			oneTimeCommand.Enabled = false;
			if (MoneyDefinition.GetMoneyCount(CurPoolInfo.DrawCardPoolInfo.CostPropType) < 1)
			{
				AddTicket(1);
			}
			else
			{
				Lottery(DrawCardMode.One);
			}
		}
	}

	private void DrawCardTenTime()
	{
		if (!canLottery)
		{
			return;
		}
		drawCardMode = DrawCardMode.Ten;
		if (tenTimeCommand.Enabled)
		{
			canLottery = false;
			tenTimeCommand.Enabled = false;
			if (MoneyDefinition.GetMoneyCount(CurPoolInfo.DrawCardPoolInfo.CostPropType) < tenTimePrice)
			{
				AddTicket(tenTimePrice - (int)MoneyDefinition.GetMoneyCount(CurPoolInfo.DrawCardPoolInfo.CostPropType));
			}
			else
			{
				Lottery(DrawCardMode.Ten);
			}
		}
	}

	private async void Lottery(DrawCardMode drawCardMode)
	{
		Loading loading = await Loading.Show();
		if (await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().Lottery(drawCardMode, CurPoolInfo.DrawCardPoolInfo) == 0)
		{
			IsMask = true;
			this.drawCardMode = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetDrawCardMode();
			if (this.drawCardMode == DrawCardMode.Null)
			{
				Toast.ShowInfo("抽卡结果出错!");
				IsMask = false;
				canLottery = true;
				oneTimeCommand.Enabled = true;
				tenTimeCommand.Enabled = true;
				loading.Dispose();
				return;
			}
			LeftTimes = ((CurPoolInfo.DrawCardPoolInfo.LotteryMax <= 0) ? "" : $"剩余抽卡次数{CurPoolInfo.DrawCardPoolInfo.LotteryLeft}/{CurPoolInfo.DrawCardPoolInfo.LotteryMax}");
			ShowOption = CurPoolInfo.DrawCardPoolInfo.Trigger < CurPoolInfo.DrawCardPoolInfo.MaxTrigger;
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: false);
			chooseIndexList = new List<int>();
			newCardShowList = new List<DrawCardItemInfo>();
			resultList = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryResultInfos();
			CountUp(resultList);
			drawCardManager = UnityEngine.Object.FindObjectOfType<DrawCardManager>();
			drawCardManager.Init(resultList);
			if (await drawCardManager.LoadStone() && await drawCardManager.LoadGems())
			{
				drawCardManager.UpdateSceneState(active: true);
				if (this.drawCardMode == DrawCardMode.One)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardSingleTouchWindow), new DrawCardTouchViewModel(this)), delegate
					{
						canLottery = true;
						oneTimeCommand.Enabled = true;
						tenTimeCommand.Enabled = true;
					});
				}
				else if (this.drawCardMode == DrawCardMode.Ten)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardTenTouchWindow), new DrawCardTouchViewModel(this)), delegate
					{
						canLottery = true;
						oneTimeCommand.Enabled = true;
						tenTimeCommand.Enabled = true;
					});
				}
			}
			loading.Dispose();
		}
		else
		{
			loading.Dispose();
			canLottery = true;
			IsMask = false;
			oneTimeCommand.Enabled = true;
			tenTimeCommand.Enabled = true;
			await UIHelper.RequestData();
			if (await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetLotteryPool())
			{
				RefreshPoolInfo();
			}
		}
	}

	private void ClearCount()
	{
		chooseWindowDic.Clear();
		chooseIndex = 0;
		chooseIndexList.Clear();
		newCardShowList.Clear();
		newCardIndex = 0;
	}

	private void CountUp(List<DrawCardItemInfo> drawCardItemInfos)
	{
		ClearCount();
		for (int i = 0; i < drawCardItemInfos.Count; i++)
		{
			if (drawCardItemInfos[i].IsNew || drawCardItemInfos[i].Rarity == 4)
			{
				newCardShowList.Add(drawCardItemInfos[i]);
			}
			if (drawCardItemInfos[i].IsChoose)
			{
				List<DrawCardItemInfo> list = new List<DrawCardItemInfo>();
				for (int j = 0; j < drawCardItemInfos[i].ChooseIds.Count; j++)
				{
					DrawCardItemInfo item = DrawCardItemInfoConvert.Convert(drawCardItemInfos[i].ChooseIds[j], drawCardItemInfos[i].ChooseTypes[j]);
					list.Add(item);
				}
				chooseWindowDic.Add(i, list);
			}
		}
	}

	private void OpenChooseWindow(List<DrawCardItemInfo> drawCardItemInfos)
	{
		openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardChooseWindow), new DrawCardChooseViewModel(this, drawCardItemInfos)), delegate
		{
			IsMask = false;
		});
	}

	private void OpenGameScoreWindow()
	{
		if (drawCardMode != DrawCardMode.Ten)
		{
			return;
		}
		int num = 0;
		foreach (DrawCardItemInfo result in resultList)
		{
			if (result.Rarity == 4)
			{
				num++;
			}
		}
		if (num >= 2 && !GameEntry.BuiltinData.OpenTestFlight)
		{
			int id = 1;
			string exText = "";
			if (Singleton<ServiceSystem>.Instance.GetService<IGameNewsTipService>().CheckOpenScoreWindow(id))
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(GameScoreWindow), new GameScoreViewModel(this, id, exText)));
			}
		}
	}

	private void LoadProduct()
	{
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.DrawCard, stopVoice: true);
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		foreach (KeyValuePair<int, int> item in Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetPropIdCountDic())
		{
			list.Add(KnapsackPropData.Create(item.Key, item.Value));
		}
		if (list.Count != 0)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(this, list)), delegate
			{
				IsMask = false;
				OpenGameScoreWindow();
				CheckDrawCardPool();
			});
		}
		else
		{
			IsMask = false;
			OpenGameScoreWindow();
			CheckDrawCardPool();
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveCanAcceptInvite(value: true);
	}

	private void CheckDrawCardPool()
	{
		if (needRefreshPool)
		{
			RefreshPoolInfo();
			return;
		}
		List<DrawCardTabData> drawCardTabInfos = Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().GetDrawCardTabInfos();
		if (drawCardTabInfos.Union(PoolTabsData).ToList().Count != drawCardTabInfos.Count || drawCardTabInfos.Count != PoolTabsData.Count)
		{
			RefreshPoolInfo();
		}
	}

	private void OpenDrawTenWindow()
	{
		List<DrawCardItemViewModel> list = new List<DrawCardItemViewModel>();
		for (int i = 0; i < resultList.Count; i++)
		{
			list.Add(new DrawCardItemViewModel(this, resultList[i]));
		}
		drawCardTenViewModel = new DrawCardTenViewModel(this, list, IsSkip);
		openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardTenWindow), drawCardTenViewModel));
		isInTenWindo = true;
	}

	private async void FirstOpenNewSingleWindow()
	{
		await UniTask.Delay(500);
		LoadNewCardWindow();
	}

	private void LoadNewCardWindow()
	{
		if (newCardIndex < newCardShowList.Count)
		{
			OpenSingleViewModel(GetSingleViewModel(newCardShowList[newCardIndex], newCardShowList[newCardIndex].IsNew));
			newCardIndex++;
		}
		else
		{
			drawCardTenViewModel?.PlayAllLoadAnimation();
			StartChoose();
		}
	}

	private async void StartChoose()
	{
		if (chooseIndex < chooseWindowDic.Count)
		{
			await UniTask.Delay(1500);
			List<int> list = chooseWindowDic.Keys.ToList();
			List<List<DrawCardItemInfo>> drawCardWindowList = chooseWindowDic.Values.ToList();
			drawCardTenViewModel?.PlayAnimation(list[chooseIndex], "Light");
			await UniTask.Delay(1000);
			OpenChooseWindow(drawCardWindowList[chooseIndex]);
			chooseIndex++;
		}
		else
		{
			await UniTask.Delay(800);
			drawCardTenViewModel.PlayAllConvertAnimation();
		}
	}

	private DrawCardSingleViewModel GetSingleViewModel(DrawCardItemInfo drawCardItemInfo, bool isNew = false)
	{
		if (drawCardItemInfo.Type == 4)
		{
			HeroModel heroModel = new HeroModel(drawCardItemInfo.Id, 0, 0, 1, 0L, 1, 0L);
			List<KnapsackPropData> knapsackPropDataList = LoadRealResult(drawCardItemInfo);
			bool isShowFinal = DrawCardMode == DrawCardMode.Ten;
			return new DrawCardSingleViewModel(this, heroModel, knapsackPropDataList, isShowFinal, isNew);
		}
		if (drawCardItemInfo.Type == 5)
		{
			WeaponData weaponData = WeaponData.CreateWeaponData(drawCardItemInfo.Id);
			if (weaponData == null)
			{
				return null;
			}
			List<KnapsackPropData> knapsackPropDataList2 = LoadRealResult(drawCardItemInfo);
			bool isShowFinal2 = DrawCardMode == DrawCardMode.Ten;
			return new DrawCardSingleViewModel(this, weaponData, knapsackPropDataList2, isShowFinal2, isNew);
		}
		return null;
	}

	private List<KnapsackPropData> LoadRealResult(DrawCardItemInfo drawCardItemInfo)
	{
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		if (drawCardItemInfo.DrawCardRealResults != null)
		{
			foreach (DrawCardRealResult drawCardRealResult in drawCardItemInfo.DrawCardRealResults)
			{
				if (drawCardRealResult.RealResultType == 1)
				{
					list.Add(KnapsackPropData.Create(drawCardRealResult.RealResultId, drawCardRealResult.RealResultCount));
				}
			}
		}
		if (drawCardItemInfo.DrawCardProducts != null)
		{
			foreach (DrawCardProduct drawCardProduct in drawCardItemInfo.DrawCardProducts)
			{
				if (drawCardProduct.ProductType == 1)
				{
					list.Add(KnapsackPropData.Create(drawCardProduct.ProductId, drawCardProduct.ProductCount));
				}
			}
		}
		return list;
	}

	private void AddTicket(int num)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>((int)CurPoolInfo.DrawCardPoolInfo.CostPropType);
		if (!UiConvert.TextConvert.DebugDataTable(dataRow, "抽奖券", (int)CurPoolInfo.DrawCardPoolInfo.CostPropType))
		{
			return;
		}
		float num2 = 0f;
		if (dataRow.Id == 9410400)
		{
			num2 = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioDiamond2NormalDraw, 160);
		}
		else if (dataRow.Id == 9410401)
		{
			num2 = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioDiamond2LimitDraw, 160);
		}
		DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(9002);
		string gemName = "熔镀晶";
		if (dataRow2 != null)
		{
			gemName = dataRow2.Name;
		}
		float diamondCost = (float)num * num2;
		float num3 = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioMoney2Diamond, 1);
		float voucherCost = (diamondCost - (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond)) * num3;
		string message = $"{dataRow.Name}不足,是否消耗<color=#cc5545>{diamondCost}</color>个{gemName}购买<color=#cc5545>{num}</color>个{dataRow.Name}?";
		IAsyncResult<int> result = AlertDialog.Show(dataRow.Name + "兑换", message, "同意", "拒绝");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				if ((float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond) >= diamondCost)
				{
					ExChangeTick(num);
				}
				else
				{
					ExChangeGem(voucherCost, diamondCost - (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond), gemName, num);
				}
			}
			canLottery = true;
			oneTimeCommand.Enabled = true;
			tenTimeCommand.Enabled = true;
		});
	}

	private void ExChangeGem(float voucherCost, float gemCost, string gemName, int tickNum)
	{
		string message = $"{gemName}不足，是否使用<color=#cc5545>{voucherCost}</color>个宏光贝购买<color=#cc5545>{gemCost}</color>个{gemName}?";
		IAsyncResult<int> result = AlertDialog.Show(gemName + "兑换", message, "同意", "拒绝");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				if (voucherCost <= (float)MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher) && MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher) > 0)
				{
					ExChangeGem((int)voucherCost, tickNum);
				}
				else
				{
					OpenShop();
				}
			}
			canLottery = true;
			oneTimeCommand.Enabled = true;
			tenTimeCommand.Enabled = true;
		});
	}

	private void OpenShop()
	{
		string message = "宏光贝不足，是否前往镀金商店购买?";
		IAsyncResult<int> result = AlertDialog.Show("提示", message, "同意", "拒绝");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				OpenShopWindow();
			}
		});
	}

	private async void OpenShopWindow()
	{
		ShopWindowViewModel userData = new ShopWindowViewModel(this, 998);
		openWindowRequest.Raise(new OpenViewArg(typeof(ShopWindow), userData), delegate
		{
		});
	}

	private async void ExChangeGem(int exchangeNum, int tickNum)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().SendCurrencyExchange(9006, 9002, exchangeNum) != null)
		{
			ExChangeTick(tickNum);
		}
		else
		{
			Toast.ShowInfo("兑换失败");
		}
	}

	private async void ExChangeTick(float num)
	{
		Loading loading = await Loading.Show();
		bool num2 = await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ExchangeTickets((int)CurPoolInfo.DrawCardPoolInfo.CostPropType, (int)num);
		loading.Dispose();
		if (num2)
		{
			IsMask = true;
			if (DrawCardMode == DrawCardMode.One)
			{
				DrawCardOneTime();
			}
			else if (DrawCardMode == DrawCardMode.Ten)
			{
				DrawCardTenTime();
			}
		}
	}

	private async void OpenExchangeView()
	{
		openExchangeCommand.Enabled = false;
		try
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(ShopWindow), new ShopWindowViewModel(this, 1)), delegate
			{
				openExchangeCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开抽卡商店发生异常！" + ex.Message + " / " + ex.StackTrace);
			Toast.ShowInfo("打开兑换商店失败，请重试！");
			openExchangeCommand.Enabled = true;
			openExchangeCommand.Enabled = true;
		}
	}

	private async void OpenDetailView()
	{
		openDetailCommand.Enabled = false;
		List<DrawCardRecordInfo> list = await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().RequestServerDrawCardResult();
		List<DrawCardRecordInfo> list2 = new List<DrawCardRecordInfo>();
		DRDrawCardInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRDrawCardInfo p) => p.CardType == CurPoolInfo.DrawCardPoolInfo.Type);
		List<int> list3 = new List<int>();
		DRDrawCardInfo[] array = dataRows;
		foreach (DRDrawCardInfo dRDrawCardInfo in array)
		{
			list3.Add(dRDrawCardInfo.Id);
		}
		foreach (DrawCardRecordInfo info in list)
		{
			if (list3.Exists((int p) => p.Equals(info.poolId)))
			{
				list2.Add(info);
			}
		}
		DrawCardPoolDetailViewModel drawCardPoolDetailViewModel = new DrawCardPoolDetailViewModel(this, CurPoolInfo);
		drawCardPoolDetailViewModel.SetDrawCardRecordInfos(list2);
		drawCardPoolDetailViewModel.TabOnClick(0);
		drawCardPoolDetailViewModel.SetPoolInfo(curPoolInfo);
		drawCardPoolDetailViewModel.ReSetScroll();
		openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardPoolDetailWindow), drawCardPoolDetailViewModel), delegate
		{
			openDetailCommand.Enabled = true;
		});
	}

	private void OpenOptionalWindow(int id)
	{
		if (DropType == 1)
		{
			drawCardOptionalViewModel = new DrawCardOptionalViewModel(this, CurPoolInfo.DrawCardPoolInfo.Id, id);
			openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardOptionalWindow), drawCardOptionalViewModel), delegate
			{
				drawCardInfoItemData.OpenWindowCmd.Enabled = true;
			});
		}
	}

	private void CheckPreviewWindow()
	{
		ssrIdList.Clear();
		srIdList.Clear();
		DRDrawCardDrop dataRow = GameEntry.DataTable.GetDataRow<DRDrawCardDrop>(curPoolInfo.DrawCardPoolInfo.Id);
		if (curPoolInfo.DrawCardPoolInfo.DropType == 1)
		{
			DRChoose dataRow2 = GameEntry.DataTable.GetDataRow((DRChoose p) => p.CardId == curPoolInfo.DrawCardPoolInfo.Id);
			if (dataRow2 != null && dataRow2.Option.Count > 0)
			{
				foreach (int item in dataRow2.Option)
				{
					ssrIdList.Add(item);
				}
				if (dataRow2.Type.Count > 0)
				{
					upType = dataRow2.Type[0];
				}
			}
			if (dataRow != null && dataRow.UpPurpleId.Count != 0 && dataRow.UpPurpleType.Count != 0)
			{
				upType = dataRow.UpPurpleType[0];
				foreach (int item2 in dataRow.UpPurpleId)
				{
					srIdList.Add(item2);
				}
			}
		}
		else if (dataRow != null && dataRow.UpGoldId.Count != 0 && dataRow.UpGoldType.Count != 0)
		{
			upType = dataRow.UpGoldType[0];
			foreach (int item3 in dataRow.UpGoldId)
			{
				ssrIdList.Add(item3);
			}
			if (dataRow.UpPurpleId.Count != 0 && dataRow.UpPurpleType.Count != 0)
			{
				foreach (int item4 in dataRow.UpPurpleId)
				{
					srIdList.Add(item4);
				}
			}
		}
		IsShowPreview = ssrIdList.Count > 0 || srIdList.Count > 0;
	}

	private void OpenPreviewWindow()
	{
		DrawCardUpPreviewViewModel userData = new DrawCardUpPreviewViewModel(this, upType, ssrIdList, srIdList);
		openWindowRequest.Raise(new OpenViewArg(typeof(DrawCardUpPreviewWindow), userData));
	}

	private void RefreshTime()
	{
		isCardTimesOrCardCount = 0;
		if (CurPoolInfo.DrawCardPoolInfo.DeadLineTime > 0)
		{
			isCardTimesOrCardCount = 1;
		}
		else if (CurPoolInfo.DrawCardPoolInfo.DeadLineTime <= 0 && CurPoolInfo.DrawCardPoolInfo.Id == 1)
		{
			isCardTimesOrCardCount = 2;
		}
		if (CurPoolInfo.DrawCardPoolInfo.DeadLineTime > 0)
		{
			LeftRefreshTimeText = Utility.DateTime.GetLeftDateHourExact(CurPoolInfo.DrawCardPoolInfo.DeadLineTime, "dd\\天hh\\时mm\\分") + "  " + LeftTimes;
		}
		else
		{
			LeftRefreshTimeText = string.Empty + LeftTimes;
		}
	}

	public override void Close()
	{
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.DrawCard, stopVoice: true);
		if (timer != null)
		{
			Timer.Cancel(timer);
			timer = null;
		}
		base.Close();
	}

	private int GetPoolTypeByPoolId(int poolId)
	{
		return GameEntry.DataTable.GetDataRow<DRDrawCardInfo>(poolId)?.CardType ?? 0;
	}

	private async void WillResultJionAllCardsDic()
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		int type = curPoolInfo.DrawCardPoolInfo.Type;
		if (!cardRecordInfoDic.TryGetValue(type, out var value))
		{
			value = new List<DrawCardRecordInfo>();
			cardRecordInfoDic[type] = value;
		}
		List<DrawCardRecordInfo> list = new List<DrawCardRecordInfo>(resultList.Count);
		for (int num = resultList.Count - 1; num >= 0; num--)
		{
			DrawCardRecordInfo drawCardRecordInfo = new DrawCardRecordInfo();
			drawCardRecordInfo.poolId = curPoolInfo.DrawCardPoolInfo.Id;
			drawCardRecordInfo.itemId = resultList[num].Id;
			drawCardRecordInfo.itemType = resultList[num].Type;
			drawCardRecordInfo.callTime = curServerTime;
			list.Add(drawCardRecordInfo);
		}
		value.InsertRange(0, list);
	}

	public async UniTask InitAllCardsInfo()
	{
		foreach (DrawCardRecordInfo item in await Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().RequestServerDrawCardResult())
		{
			int poolTypeByPoolId = GetPoolTypeByPoolId(item.poolId);
			if (poolTypeByPoolId > 0)
			{
				if (cardRecordInfoDic.TryGetValue(poolTypeByPoolId, out var value))
				{
					value.Add(item);
					continue;
				}
				cardRecordInfoDic[poolTypeByPoolId] = new List<DrawCardRecordInfo> { item };
			}
		}
		foreach (KeyValuePair<int, List<DrawCardRecordInfo>> item2 in cardRecordInfoDic)
		{
			StableSortByCallTimeDesc(item2.Value);
		}
	}

	private async void InitCurCardPoolRemainCountInfo()
	{
		List<DrawCardRecordInfo> list = new List<DrawCardRecordInfo>();
		int type = CurPoolInfo.DrawCardPoolInfo.Type;
		if (cardRecordInfoDic.TryGetValue(type, out var value))
		{
			list.AddRange(value);
		}
		if (curPoolInfo.DrawCardPoolInfo.Type == 2)
		{
			List<DrawCardRecordInfo> list2 = new List<DrawCardRecordInfo>();
			foreach (DrawCardRecordInfo item in list)
			{
				if (item.poolId == 1)
				{
					list2.Add(item);
				}
			}
			list2.Reverse();
			list.RemoveAll((DrawCardRecordInfo info) => info.poolId == 1);
			list.AddRange(list2);
		}
		int c = CalculatePurpleRemainCount(list, 3, 4);
		int c2 = CalculateRemainCount(list, 4);
		SetRemainCardCount(c, c2);
	}

	private int CompareListFirst(List<DrawCardRecordInfo> x, List<DrawCardRecordInfo> y)
	{
		long callTime = x[0].callTime;
		long callTime2 = y[0].callTime;
		return callTime2.CompareTo(callTime);
	}

	private static void StableSortByCallTimeDesc(List<DrawCardRecordInfo> list)
	{
		if (list != null && list.Count > 1)
		{
			(DrawCardRecordInfo, int)[] array = new(DrawCardRecordInfo, int)[list.Count];
			for (int i = 0; i < list.Count; i++)
			{
				array[i] = (list[i], i);
			}
			Array.Sort(array, delegate((DrawCardRecordInfo item, int index) a, (DrawCardRecordInfo item, int index) b)
			{
				int num2 = b.item.callTime.CompareTo(a.item.callTime);
				return (num2 == 0) ? a.index.CompareTo(b.index) : num2;
			});
			for (int num = 0; num < list.Count; num++)
			{
				list[num] = array[num].Item1;
			}
		}
	}

	private void SetRemainCardCount(int c1, int c2)
	{
		DRDrawCardDrop dataRow = GameEntry.DataTable.GetDataRow((DRDrawCardDrop p) => p.Id == CurPoolInfo.DrawCardPoolInfo.Id);
		RemainPurpleCardCount = dataRow.Guarantee - c1;
		RemainGoldenCardCount = dataRow.BigGuarantee - c2;
		IsShowDrawCardTxt = false;
		string text = "以上烬天使/武魂";
		string text2 = "";
		if (curPoolInfo.DrawCardPoolInfo.Type == 4 || curPoolInfo.DrawCardPoolInfo.Type == 6)
		{
			text2 = "武魂";
			IsShowDrawCardTxt = true;
		}
		else if (curPoolInfo.DrawCardPoolInfo.Type == 1 || curPoolInfo.DrawCardPoolInfo.Type == 2 || curPoolInfo.DrawCardPoolInfo.Type == 3)
		{
			text2 = "烬天使";
			IsShowDrawCardTxt = true;
		}
		if (remainPurpleCardCount == 1)
		{
			RemainPurpleCardCountTxt = "<color=#e9b3ff>下次</color>誓约内必得";
			PurpleCardTxt = "<color=#e9b3ff>" + text + "</color>";
		}
		else
		{
			RemainPurpleCardCountTxt = $"<color=#e9b3ff>{RemainPurpleCardCount}次</color>誓约内必得";
			PurpleCardTxt = "<color=#e9b3ff>" + text + "</color>";
		}
		if (remainGoldenCardCount == 1)
		{
			RemainGoldenCardCountTxt = "<color=#ffd270>下次</color>誓约内必得";
			GoldenCardTxt = "<color=#ffd270>" + text2 + "</color>";
		}
		else
		{
			RemainGoldenCardCountTxt = $"<color=#ffd270>{RemainGoldenCardCount}次</color>誓约内必得";
			GoldenCardTxt = "<color=#ffd270>" + text2 + "</color>";
		}
	}

	private int CalculateRemainCount(List<DrawCardRecordInfo> records, int targetRarity)
	{
		IDataTable<DRHeroInfo> dataTable = GameEntry.DataTable.GetDataTable<DRHeroInfo>();
		IDataTable<DRWeapon> dataTable2 = GameEntry.DataTable.GetDataTable<DRWeapon>();
		int num = 0;
		foreach (DrawCardRecordInfo record in records)
		{
			if (record.itemType == 4)
			{
				DRHeroInfo dataRow = dataTable.GetDataRow(record.itemId);
				if (dataRow != null && dataRow.Rarity == targetRarity)
				{
					return num;
				}
			}
			else if (record.itemType == 5)
			{
				DRWeapon dataRow2 = dataTable2.GetDataRow(record.itemId);
				if (dataRow2 != null && dataRow2.Rarity == targetRarity)
				{
					return num;
				}
			}
			num++;
		}
		return num;
	}

	private int CalculatePurpleRemainCount(List<DrawCardRecordInfo> records, int targetRarity1, int targetRarity2)
	{
		IDataTable<DRHeroInfo> dataTable = GameEntry.DataTable.GetDataTable<DRHeroInfo>();
		IDataTable<DRWeapon> dataTable2 = GameEntry.DataTable.GetDataTable<DRWeapon>();
		int num = 0;
		foreach (DrawCardRecordInfo record in records)
		{
			if (record.itemType == 4)
			{
				DRHeroInfo dataRow = dataTable.GetDataRow(record.itemId);
				if (dataRow != null && (dataRow.Rarity == targetRarity1 || dataRow.Rarity == targetRarity2))
				{
					return num;
				}
			}
			else if (record.itemType == 5)
			{
				DRWeapon dataRow2 = dataTable2.GetDataRow(record.itemId);
				if (dataRow2 != null && (dataRow2.Rarity == targetRarity1 || dataRow2.Rarity == targetRarity2))
				{
					return num;
				}
			}
			num++;
		}
		return num;
	}
}
