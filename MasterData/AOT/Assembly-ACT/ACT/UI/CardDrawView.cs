using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.SmartFormat.PersistentVariables;
using UnityEngine.UI;

namespace ACT.UI;

public class CardDrawView : BaseUIView<CardDrawViewController>
{
	private CardDrawViewData m_data;

	public GameObject GachaViewRoot;

	public GameObject BlackRoot;

	public Transform TfCardBg;

	public Transform TfCardDrawCell;

	public ActButton BtnClose;

	public GameObject CardDrawCellPrefab;

	public GameObject GoLimitUpPool;

	public GameObject GoGuaranteeDes;

	public LocalizeStringEvent TextGuaranteeS;

	public LocalizeStringEvent TextGuaranteeA;

	public CommonTimerComponent TextLimitupTimerComponent;

	public GameObject GoLimitGuaranteedPool;

	public CommonTimerComponent TextLimitGuaranteedTimerComponent;

	public TextMeshProUGUI TextLimitGuaranteedCurrentNum;

	public TextMeshProUGUI TextLimitGuaranteedTargetNum;

	public GameObject GoResidentPool;

	public GameObject GoResident;

	public TextMeshProUGUI TextResidentMinGuaranteeNum;

	public TextMeshProUGUI TextResidentExtractionNum;

	public GameObject GoFirstGuranteed;

	public LocalizeStringEvent TextFirstGuranteed;

	public GameObject GoMilestoneReward;

	public BImage ImageMilestoneRewardIcon;

	public LocalizeStringEvent TextImageMilestoneReward;

	public ActButton BtnMilestoneReward;

	public GameObject GoMilestoneRewarded;

	public GameObject GoMilestoneRewardedGou;

	public GameObject GoMilestoneCanReward;

	public RedDotItem GoMilestoneCanRewardRed;

	public GameObject GoAccumulated;

	public TextMeshProUGUI TextResidentoptionalCurrentNum;

	public TextMeshProUGUI TextResidentoptionalTargetNum;

	public Image ImageResidentoptionalProgress;

	public GameObject GoGaChaGiftHightLight;

	public TextMeshProUGUI TextGaChaGiftHightLight;

	public ActButton BtnResidentoptionalGift;

	public ActButton BtnTargetGacha;

	public LocalizeStringEvent ChargeValueText;

	public GameObject NoTargetGacha;

	public GameObject HaveTargetGacha;

	public BImage TargetIcon;

	public GameObject GoDiscountPool;

	public TextMeshProUGUI TextDiscountMinGuaranteeNum;

	public TextMeshProUGUI TextDiscountExtractionNum;

	public CommonCoinComponent GaChaItemComponent;

	public GameObject GaChaItemComponentPlus;

	public CommonCoinGroup CoinGroup;

	public ActButton BtnOnce;

	public BImage OnceNeedItemIcon;

	public ActButton BtnTen;

	public GameObject GoNewbiePoolRed;

	public RedDotItem GoNewbiePoolRedItem;

	public GameObject GoTagDiscountTen;

	public TextMeshProUGUI TextTagDiscountTen;

	public BImage TenNeedItemIcon;

	public TextMeshProUGUI TextTenNum;

	public ActButton BtnShop;

	public ActButton BtnProbabilityDetail;

	public ActButton BtnJump;

	public Transform GachaUpCharacterIconRoot;

	public GameObject UpCharacterIconItemPrefab;

	public List<GameObject> gamepadTips;

	public GamePadTipsComp gamePadTipsComp;

	public GameObject CharacterShowRoot;

	public AcquireCharacterShowNewComponent AcquireCharacterShowNewComponent;

	public GameObject CardDrawSettleRoot;

	public CardDrawSettleComponent CardDrawSettleComponent;

	public ActButton BtnSkip;

	public ActButton BtnNext;

	public GameObject GachaMachineRoot;

	public GameObject GachaMachineEffect;

	public RectTransform TfRight;

	public RectTransform TfLeft;

	public RectTransform TfMid;

	public ActButton BtnStart;

	private List<Gacha> _gachasPoolDatas = new List<Gacha>();

	private List<CarddrawCell> _carddrawCells = new List<CarddrawCell>();

	private readonly Dictionary<int, CardDrawBgComponent> _bgPrefabCache = new Dictionary<int, CardDrawBgComponent>();

	private readonly Dictionary<int, AssetLoadHandle> _bgPrefabHandleCache = new Dictionary<int, AssetLoadHandle>();

	private Gacha CurrentCardPool;

	private int CurrentNeedItemId;

	private NewbieConfig NewbieConfig;

	private GachaResidentPool ResidentPoolData;

	private GachaTestRoundTwoPool TestRoundTwoPoolData;

	private GachaLimitedUpPool LimitedUpPoolData;

	private GachaLimitedGuaranteedPool LimitedGuaranteedPoolData;

	private GachaNewbiePool NewbiePoolPoolData;

	private int CurrentSelectPoolId;

	private int PreSelectPoolId;

	private int SelectPoolId;

	private List<AcquireCharacterShowData> _listNeedShow = new List<AcquireCharacterShowData>();

	private List<CardDrawCharacterShowData> _cardlistNeedShow = new List<CardDrawCharacterShowData>();

	private bool IsPlayAnimation;

	private bool canreward;

	private bool rewarded;

	private readonly Queue<AcquireCharacterShowData> _characterShowQueue = new Queue<AcquireCharacterShowData>();

	private List<GachaCardDrawItem> _cachedGachaResults = new List<GachaCardDrawItem>();

	private ActButton _curSelectButton;

	private GachaPoolUniqueData _milestoneRewardData;

	private int _OncePrice = 160;

	private bool inStart;

	private Gacha newpooldata;

	private uint IdleSoundId;

	private uint GachaSettleSoundId;

	private uint GachaStartSoundId;

	private uint characterSoundId;

	private const uint NewbiePoolItemId = 200133u;

	private const int ShopJumpId = 2502;

	private OperateState m_operateState;

	private Dictionary<string, GamePadTipsAction> _inputActionDic;

	private List<GamePadTipsAction> _tipsActions;

	public uint CharacterSoundId => characterSoundId;

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GaChaPoolDataUpdate, OnGaChaPoolDataUpdate);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GachaTargetStateChanged, OnGachaTargetStateChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GachaAcquireCharacterShow, OnGachaAcquireCharacterShow);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GachaStartShow, OnGachaStartShow);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
		CoinGroup.GetComponent<ViewControlLayer>().OnFocusChanged.AddListener(OnCoinFocusChanged);
		base.AddEventListener();
	}

	private void Update()
	{
		if (GachaMachineRoot.activeSelf)
		{
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().UpdateUIFollowWorldPosition(Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().LeftHandle, TfLeft);
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().UpdateUIFollowWorldPosition(Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().StartHandle, TfRight);
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().UpdateUIFollowWorldPosition(Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().MidHandle, TfMid);
		}
	}

	private void OnGachaAcquireCharacterShow(BaseEventContent obj)
	{
		AcquireCharacterShowNewComponent.ShowPanel();
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GaChaPoolDataUpdate, OnGaChaPoolDataUpdate);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GachaTargetStateChanged, OnGachaTargetStateChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GachaAcquireCharacterShow, OnGachaAcquireCharacterShow);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GachaStartShow, OnGachaStartShow);
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
		CoinGroup.GetComponent<ViewControlLayer>().OnFocusChanged.RemoveListener(OnCoinFocusChanged);
		base.RemoveEventListener();
	}

	private void OnCoinFocusChanged(bool arg0)
	{
		if (arg0)
		{
			OnChooseResource();
		}
		else
		{
			SetOperateState(OperateState.Normal);
		}
	}

	private void OnGachaStartShow(BaseEventContent obj)
	{
		BtnNext.gameObject.SetActive(value: true);
		Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().AfterStartShow();
	}

	private void OnGaChaPoolDataUpdate(BaseEventContent obj)
	{
		if (!(obj is GachaUpdateEvent gachaUpdateEvent))
		{
			return;
		}
		switch (gachaUpdateEvent.GaChaPoolType)
		{
		case GaChaPoolType.Resident:
			ResidentPoolData = Model<CardDrawModel>.Interface.GetGachaResidentPool();
			break;
		case GaChaPoolType.Test:
			TestRoundTwoPoolData = Model<CardDrawModel>.Interface.GetGachaTestRoundTwoPool();
			break;
		case GaChaPoolType.Limitup:
			LimitedUpPoolData = Model<CardDrawModel>.Interface.GetLimitedUpPool();
			break;
		case GaChaPoolType.LimitGuranteed:
			LimitedGuaranteedPoolData = Model<CardDrawModel>.Interface.GetLimitedGuaranteedPool();
			break;
		case GaChaPoolType.Beginner:
			NewbiePoolPoolData = Model<CardDrawModel>.Interface.GetNewbiePool();
			break;
		}
		if (IsCardDrawDataReady())
		{
			if (CurrentNeedItemId == 0)
			{
				RefreshRightPanel(CurrentCardPool.id);
				return;
			}
			GaChaPoolType poolType = getPoolType((int)gachaUpdateEvent.GaChaPoolType);
			SetRightPanel(poolType);
			SetMilestoneReward();
			RefreshTargetGachaState();
		}
	}

	private void OnGachaTargetStateChanged(BaseEventContent obj)
	{
		if (obj is GachaTargetStateChangedEvent gachaTargetStateChangedEvent && CurrentCardPool != null && gachaTargetStateChangedEvent.GachaId == CurrentCardPool.id)
		{
			RefreshTargetGachaState();
		}
	}

	public override async UniTask PreInit()
	{
		Stopwatch totalStopwatch = Stopwatch.StartNew();
		Stopwatch segmentStopwatch = Stopwatch.StartNew();
		await base.PreInit();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] PreInit/base.PreInit 耗时 {segmentStopwatch.ElapsedMilliseconds} 毫秒");
		}
		segmentStopwatch.Restart();
		await Singleton<UISceneManager>.instance.LoadScene<CardDrawViewScene>(GameLoader.meta.carddrawSceneReferenceAssetID.GUID);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] PreInit/LoadScene 耗时 {segmentStopwatch.ElapsedMilliseconds} 毫秒");
		}
		segmentStopwatch.Restart();
		PreInitPanel();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] PreInit/PreInitPanel 耗时 {segmentStopwatch.ElapsedMilliseconds} 毫秒");
			Debug.Log($"[CardDrawView] PreInit 总耗时 {totalStopwatch.ElapsedMilliseconds} 毫秒");
		}
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<CardDrawViewScene>();
	}

	protected override void OnMoveToHide()
	{
		Singleton<UISceneManager>.instance.CloseScene<CardDrawViewScene>();
	}

	protected override void CloseComplete()
	{
		UnloadAllBgPrefab();
		Singleton<UISceneManager>.instance.ReleaseScene<CardDrawViewScene>();
	}

	private void PreInitPanel()
	{
		PreInitData();
		m_data = uiViewData as CardDrawViewData;
		BtnResidentoptionalGift.SetBtnClick(OnOpenResidentoptionalReward, "event:/UI/Interface/DrawCard/Tab");
		BtnTargetGacha.SetBtnClick(OpenTargetGacha, "event:/UI/Interface/DrawCard/Tab");
		BtnProbabilityDetail.SetBtnClick(OpenHistoryTips, "event:/UI/Interface/DrawCard/Tab");
		BtnClose.SetBtnClick(Close);
		BtnShop.SetBtnClick(OpenShop, "event:/UI/Interface/DrawCard/Tab");
		BtnOnce.SetBtnClick(OnDrawOnce, "event:/UI/Interface/DrawCard/Extract10");
		BtnTen.SetBtnClick(OnDrawTen, "event:/UI/Interface/DrawCard/Extract1");
		BtnMilestoneReward.SetBtnClick(GetReward);
		BtnJump.SetBtnClick(OnJump, "event:/UI/Interface/DrawCard/Tab");
		BtnSkip.SetBtnClick(SkipSceneTimeline);
		BtnNext.SetBtnClick(OnNext);
		BtnStart.SetBtnClick(OnStart, "event:/UI/Interface/DrawCard/Machine/Play");
		IsPlayAnimation = false;
		OnGamePadInit();
		InitPanel();
	}

	private void OnJump()
	{
		if (CurrentCardPool.uptestJump != 0)
		{
			RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(CurrentCardPool.uptestJump);
			JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
			if (result.ShowType != JumpResult.JumpShowType.CanJump)
			{
				GameUtility.OpenJumpResultTips(result);
				result.Release();
			}
			else
			{
				Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
				result.Release();
			}
		}
	}

	private void OnNext()
	{
		BtnNext.gameObject.SetActive(value: false);
		Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().GoToCharacterShow();
	}

	private void PreInitData()
	{
		Dictionary<int, Gacha> gachas = RuntimeConfigs.data.gachas;
		if (_gachasPoolDatas.Count > 0)
		{
			_gachasPoolDatas.Clear();
		}
		ResidentPoolData = Model<CardDrawModel>.Interface.GetGachaResidentPool();
		LimitedUpPoolData = Model<CardDrawModel>.Interface.GetLimitedUpPool();
		LimitedGuaranteedPoolData = Model<CardDrawModel>.Interface.GetLimitedGuaranteedPool();
		TestRoundTwoPoolData = Model<CardDrawModel>.Interface.GetGachaTestRoundTwoPool();
		NewbiePoolPoolData = Model<CardDrawModel>.Interface.GetNewbiePool();
		foreach (KeyValuePair<int, Gacha> item in gachas)
		{
			if (Model<CardDrawModel>.Interface.CheckGachaPoolInTimeRange(item.Value.id))
			{
				_gachasPoolDatas.Add(item.Value);
			}
			if (item.Value.gachaType == 1)
			{
				InitNewbieConfig(item.Value.typeProperty);
			}
			if (item.Value.gachaType == 5)
			{
				newpooldata = item.Value;
			}
		}
		_gachasPoolDatas.Sort((Gacha a, Gacha b) =>
		{
			int displayPriority = a.displayPriority;
			return displayPriority.CompareTo(b.displayPriority);
		});
	}

	protected override void Init()
	{
		Stopwatch stopwatch = Stopwatch.StartNew();
		Stopwatch stopwatch2 = Stopwatch.StartNew();
		base.Init();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] Init/base.Init 耗时 {stopwatch2.ElapsedMilliseconds} 毫秒");
		}
		stopwatch2.Restart();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] Init/PlaySound 耗时 {stopwatch2.ElapsedMilliseconds} 毫秒");
		}
		stopwatch2.Restart();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] Init/InitPanel 耗时 {stopwatch2.ElapsedMilliseconds} 毫秒");
		}
		stopwatch2.Restart();
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(1007);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			m_operateState = OperateState.Normal;
			SetScatteredGamepadTipsVisible(visible: true);
			ReBindBtnPrompt();
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[CardDrawView] Init/RedDot+Gamepad 耗时 {stopwatch2.ElapsedMilliseconds} 毫秒");
			Debug.Log($"[CardDrawView] Init 总耗时 {stopwatch.ElapsedMilliseconds} 毫秒");
		}
		if (newpooldata != null)
		{
			string fullPath = RedDotPathDefine.GaCha + $"|{newpooldata.id}" + "|" + RedDotPathDefine.GaChaNewbiePool;
			GoNewbiePoolRedItem.InitRedDot(fullPath);
		}
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	private void InitPanel()
	{
		_cachedGachaResults.Clear();
		ChangeGaChaViewRoot(isshow: true);
		BtnSkip.gameObject.SetActive(value: false);
		CharacterShowRoot.SetActive(value: false);
		CardDrawSettleRoot.SetActive(value: false);
		CurrentSelectPoolId = 0;
		CurrentCardPool = null;
		CurrentNeedItemId = 0;
		PreSelectPoolId = m_data?.PoolId ?? 0;
		BtnOnce.Interactable(active: false);
		BtnTen.Interactable(active: false);
		CreateLeftCardDrawCell();
	}

	public void ChangeGaChaViewRoot(bool isshow)
	{
		GachaViewRoot.SetActive(isshow);
		BlackRoot.SetActive(isshow);
		if (isshow)
		{
			CoinGroup.FocusIn();
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.EnableUISceneCameraSkipBase();
		}
		else
		{
			CoinGroup.FocusOut();
		}
		GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
		evt.IsInState = !isshow;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnGachaChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void CreateLeftCardDrawCell()
	{
		_carddrawCells.Clear();
		if (TfCardDrawCell.childCount > 0)
		{
			TfCardDrawCell.DestroyChildren();
		}
		int nextOpenViewTabPoolSelectId = Model<CardDrawModel>.Interface.GetNextOpenViewTabPoolSelectId();
		int requestedPoolId;
		if (nextOpenViewTabPoolSelectId != 0)
		{
			requestedPoolId = nextOpenViewTabPoolSelectId;
		}
		else
		{
			requestedPoolId = ((CurrentSelectPoolId != 0) ? CurrentSelectPoolId : PreSelectPoolId);
		}
		int num = _gachasPoolDatas.FindIndex((Gacha pool) => pool.id == requestedPoolId);
		if (num < 0 && _gachasPoolDatas.Count > 0)
		{
			num = 0;
			if (requestedPoolId != 0)
			{
				Debug.LogWarning($"[CardDrawView] 预选卡池 {requestedPoolId} 不可用，回退至卡池 {_gachasPoolDatas[0].id}。");
			}
		}
		SelectPoolId = 0;
		for (int num2 = 0; num2 < _gachasPoolDatas.Count; num2++)
		{
			CarddrawCell item = UIUtility.AddWidget<CarddrawCell>(TfCardDrawCell, CardDrawCellPrefab);
			CarddrawCell carddrawCell = item;
			int id = _gachasPoolDatas[num2].id;
			carddrawCell.name = id.ToString();
			item.Init(_gachasPoolDatas[num2], getPoolType(_gachasPoolDatas[num2].gachaType), Station);
			item.BtnClick.SetBtnClick(() =>
			{
				if (item.GaChaId != SelectPoolId)
				{
					for (int i = 0; i < _carddrawCells.Count; i++)
					{
						CarddrawCell carddrawCell2 = _carddrawCells[i];
						bool isSelected = carddrawCell2.GaChaId == item.GaChaId;
						carddrawCell2.SetSelected(isSelected, playInstantly: true);
					}
					if (item.type == GaChaPoolType.Beginner)
					{
						GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.GachaTabBeginner);
					}
					RefreshRightPanel(item.GaChaId);
				}
			}, "event:/UI/Interface/DrawCard/Left_Tab");
			_carddrawCells.Add(item);
			if (num2 == num)
			{
				item.SetSelected(isSelected: true);
				RefreshRightPanel(item.GaChaId);
			}
			else
			{
				item.SetSelected(isSelected: false);
			}
		}
	}

	private void SetBgPrefab(int GachaId)
	{
		foreach (KeyValuePair<int, CardDrawBgComponent> item in _bgPrefabCache)
		{
			if (item.Value != null)
			{
				item.Value.gameObject.SetActive(item.Key == GachaId);
			}
		}
		CardDrawBgComponent cardDrawBgComponent = LoadBgPrefab(GachaId);
		if (!(cardDrawBgComponent == null))
		{
			cardDrawBgComponent.gameObject.SetActive(value: true);
			cardDrawBgComponent.betterAnimation.GetSequence("Show")?.Play();
			if (!string.IsNullOrEmpty(cardDrawBgComponent.SoundResourceName))
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(cardDrawBgComponent.SoundResourceName);
			}
		}
	}

	private CardDrawBgComponent LoadBgPrefab(int bgId)
	{
		if (_bgPrefabCache.TryGetValue(bgId, out var value) && value != null)
		{
			return value;
		}
		string assetID = "UI/Gacha" + bgId;
		AssetLoadHandle assetLoadHandle = Station.Load<GameObject>(assetID);
		if (assetLoadHandle.Result == null)
		{
			Station.Release(assetLoadHandle);
			return null;
		}
		CardDrawBgComponent component = UnityEngine.Object.Instantiate((GameObject)assetLoadHandle.Result, TfCardBg).GetComponent<CardDrawBgComponent>();
		component.Init();
		_bgPrefabCache[bgId] = component;
		_bgPrefabHandleCache[bgId] = assetLoadHandle;
		return component;
	}

	private void UnloadAllBgPrefab()
	{
		foreach (KeyValuePair<int, CardDrawBgComponent> item in _bgPrefabCache)
		{
			if (item.Value != null)
			{
				UnityEngine.Object.Destroy(item.Value.gameObject);
			}
		}
		_bgPrefabCache.Clear();
		foreach (AssetLoadHandle value in _bgPrefabHandleCache.Values)
		{
			Station.Release(value);
		}
		_bgPrefabHandleCache.Clear();
	}

	private void RefreshRightPanel(int GachaId)
	{
		BtnOnce.Interactable(active: false);
		BtnTen.Interactable(active: false);
		CurrentNeedItemId = 0;
		_milestoneRewardData = null;
		CurrentSelectPoolId = GachaId;
		SelectPoolId = GachaId;
		CurrentCardPool = CoreUtils.GetData(GachaId, RuntimeConfigs.data.gachas);
		if (CurrentCardPool == null)
		{
			BtnTargetGacha?.gameObject.SetActive(value: false);
			return;
		}
		BindMilestoneRewardRedDot(CurrentCardPool.id);
		BtnTargetGacha?.gameObject.SetActive(CurrentCardPool.targetCharacterPool != 0);
		RefreshTargetGachaState();
		if (!IsCardDrawDataReady())
		{
			return;
		}
		SetBgPrefab(CurrentCardPool.bgPerfeb);
		CurrentNeedItemId = CurrentCardPool.token[0].id;
		GachaDisplay data = CoreUtils.GetData(GachaId, RuntimeConfigs.data.gachaDisplays);
		GaChaPoolType poolType = getPoolType(CurrentCardPool.gachaType);
		SetRightPanel(poolType);
		SetRightPanelActive(poolType);
		BtnJump.gameObject.SetActive(CurrentCardPool.uptestJump != 0);
		GaChaItemComponent.InitData(CurrentCardPool.token[0].id, isBagItem: true);
		GaChaItemComponentPlus.SetActive(CurrentCardPool.gachaType != 5);
		GaChaItemComponent.Initialize();
		int iconAddress = CoreUtils.GetData(CurrentCardPool.token[0].id, RuntimeConfigs.data.itemDatas).iconAddress;
		Station.LoadItemIcon(iconAddress, OnceNeedItemIcon);
		Station.LoadItemIcon(iconAddress, TenNeedItemIcon);
		if (poolType == GaChaPoolType.Beginner)
		{
			TextTenNum.text = "x1";
		}
		else
		{
			TextTenNum.text = "x10";
		}
		BtnOnce.Interactable(poolType != GaChaPoolType.Beginner);
		BtnTen.Interactable(poolType != GaChaPoolType.Beginner || NewbiePoolPoolData.TotalCount < CurrentCardPool.discountEligiblePulls);
		GoAccumulated.SetActive(CurrentCardPool.isFinalGuarantSelectable);
		if (data != null)
		{
			GachaUpCharacterIconRoot.gameObject.SetActive(data.up4StarCharacterIds.Length != 0);
			if (data.up4StarCharacterIds.Length != 0)
			{
				CreateUpCharacterIcon(data);
			}
		}
		else
		{
			GachaUpCharacterIconRoot.gameObject.SetActive(value: false);
		}
		SetMilestoneReward();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			ReBindBtnPrompt();
		}
		GoNewbiePoolRed.SetActive(CurrentCardPool.gachaType == 5);
		betterAnimation.GetSequence("TabShow").Play();
	}

	private void BindMilestoneRewardRedDot(int poolId)
	{
		if (!(GoMilestoneCanRewardRed == null))
		{
			RedDotTrieNode redDotTrieNode = GoMilestoneCanRewardRed.redDotTrieNode;
			if (redDotTrieNode != null)
			{
				redDotTrieNode.itemList?.Remove(GoMilestoneCanRewardRed);
				GoMilestoneCanRewardRed.redDotTrieNode = null;
			}
			string text = RedDotPathDefine.GaCha + $"|{poolId}|{RedDotPathDefine.GoMilestoneCanReward}";
			GoMilestoneCanRewardRed.fullPath = text.Split("|").ToList();
			GoMilestoneCanRewardRed.BindTrieNode();
			GoMilestoneCanRewardRed.UpdateDisplay();
		}
	}

	private void GetReward()
	{
		if (!canreward || rewarded)
		{
			ItemUnifierProxy uiData = ItemUnifierProxy.ItemUnifierPool.Get<Item>(CurrentCardPool.milestoneReward[0].id, G.localPlayer.Inventory.GetItemCount(CurrentCardPool.milestoneReward[0].id));
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, uiData);
		}
		else
		{
			if (_milestoneRewardData == null)
			{
				return;
			}
			ReportGachaClick(2);
			Model<CardDrawModel>.Interface.SendGaChaExchangeMilestoneReward(CurrentCardPool.id, (GachaExchangeMilestoneRewardAck GachaExchangeMilestoneRewardAck) =>
			{
				List<Item> newItems = ListPool<Item>.Get();
				foreach (UniversalItem item2 in GachaExchangeMilestoneRewardAck.Items)
				{
					Item item = new Item
					{
						Id = item2.Index,
						Count = item2.Count
					};
					newItems.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(newItems), notSort: false, () =>
				{
					ListPool<Item>.Release(newItems);
				});
				SetMilestoneReward();
			});
		}
	}

	private void SetFirstGuranteed()
	{
		bool flag = CurrentCardPool.gachaType == 3;
		GachaPoolUniqueData gachaPoolUniqueData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(CurrentCardPool.id);
		TextFirstGuranteed.StringReference.TableEntryReference = LocalizationCommonData.CommonString.GaChaFirstGuranteed;
		GoFirstGuranteed.SetActive(flag);
		if (!flag)
		{
			return;
		}
		string value = "<color=#fdff70>1</color>";
		string value2 = "<color=#ff7272>0</color>";
		if (gachaPoolUniqueData == null)
		{
			TextFirstGuranteed.GetVariable<string>("0").Value = value;
		}
		else if (gachaPoolUniqueData != null)
		{
			if (gachaPoolUniqueData.TiggeredFirstGuaranteed)
			{
				TextFirstGuranteed.GetVariable<string>("0").Value = value2;
			}
			else
			{
				TextFirstGuranteed.GetVariable<string>("0").Value = value;
			}
		}
	}

	private void Jump()
	{
	}

	private void SetMilestoneReward()
	{
		bool flag = CurrentCardPool.milestonePull != 0;
		_milestoneRewardData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(CurrentCardPool.id);
		TextImageMilestoneReward.StringReference.TableEntryReference = LocalizationCommonData.CommonString.GaChaMilestoneReward;
		GoMilestoneReward.SetActive(flag);
		canreward = _milestoneRewardData != null && _milestoneRewardData.TotalCount >= CurrentCardPool.milestonePull;
		rewarded = _milestoneRewardData != null && _milestoneRewardData.HasTakenMilestoneReward;
		if (flag)
		{
			ItemData data = CoreUtils.GetData(CurrentCardPool.milestoneReward[0].id, RuntimeConfigs.data.itemDatas);
			if (data != null)
			{
				Station.LoadItemIcon(data.iconAddress, ImageMilestoneRewardIcon);
			}
			if (_milestoneRewardData == null)
			{
				Variable<string> variable = TextImageMilestoneReward.GetVariable<string>("0");
				int milestonePull = CurrentCardPool.milestonePull;
				variable.Value = milestonePull.ToString();
			}
			else
			{
				TextImageMilestoneReward.GetVariable<string>("0").Value = Math.Max(0, CurrentCardPool.milestonePull - _milestoneRewardData.TotalCount).ToString();
			}
		}
		GoMilestoneCanReward.SetActive(canreward && !rewarded);
		GoMilestoneRewarded.SetActive(rewarded);
		GoMilestoneRewardedGou.SetActive(rewarded);
		TextImageMilestoneReward.gameObject.SetActive(_milestoneRewardData == null || (!rewarded && !canreward));
		SetMilestoneRewardedAni(canreward && !rewarded);
	}

	private void SetMilestoneRewardedAni(bool canreward)
	{
		if (canreward)
		{
			GoMilestoneReward.GetComponent<BetterAnimation>().GetSequence("CanReward").SetLoops(-1)
				.Play();
			return;
		}
		GoMilestoneReward.GetComponent<BetterAnimation>().StopAnimation();
		GoMilestoneReward.GetComponent<BetterAnimation>().GetSequence("Normal").Play();
	}

	private void CreateUpCharacterIcon(GachaDisplay gachaDisplay)
	{
		List<Character> Characters = CharacterDataHelper.CreateTrialCharacterTeamByProbationIds(CurrentCardPool.targetCharacterShows);
		if (GachaUpCharacterIconRoot.childCount > 0)
		{
			GachaUpCharacterIconRoot.DestroyChildren();
		}
		for (int i = 0; i < gachaDisplay.up4StarCharacterIds.Length; i++)
		{
			int characterId = gachaDisplay.up4StarCharacterIds[i];
			UpCharacteritem upCharacteritem = UIUtility.AddWidget<UpCharacteritem>(GachaUpCharacterIconRoot, UpCharacterIconItemPrefab);
			upCharacteritem.Init(characterId, Station);
			upCharacteritem.BtnJump.SetBtnClick(() =>
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
				{
					DisplayCharacters = Characters,
					defaultCharacterId = characterId
				});
			});
		}
	}

	private GaChaPoolType getPoolType(int type)
	{
		return type switch
		{
			1 => IsResident(), 
			3 => GaChaPoolType.Limitup, 
			2 => GaChaPoolType.LimitGuranteed, 
			4 => GaChaPoolType.Test, 
			5 => GaChaPoolType.Beginner, 
			_ => GaChaPoolType.None, 
		};
	}

	private GaChaPoolType IsResident()
	{
		if (ResidentPoolData != null)
		{
			if (ResidentPoolData.CountForTenConsecutiveDiscount >= NewbieConfig.MultiNumber)
			{
				return GaChaPoolType.Resident;
			}
			return GaChaPoolType.Beginner;
		}
		return GaChaPoolType.None;
	}

	private void SetRightPanelActive(GaChaPoolType type)
	{
		GoLimitUpPool.SetActive(type == GaChaPoolType.Limitup);
		GoLimitGuaranteedPool.SetActive(type == GaChaPoolType.LimitGuranteed);
		GoResidentPool.SetActive(type == GaChaPoolType.Resident || type == GaChaPoolType.Test);
		GoDiscountPool.SetActive(type == GaChaPoolType.Beginner);
	}

	private void SetRightPanel(GaChaPoolType type)
	{
		BtnTen.gameObject.SetActive(value: true);
		switch (type)
		{
		case GaChaPoolType.Resident:
			SetResidentPool();
			break;
		case GaChaPoolType.Limitup:
			SetLimitupPool();
			break;
		case GaChaPoolType.LimitGuranteed:
			SetLimitGuranteedPool();
			break;
		case GaChaPoolType.Beginner:
			SetDiscounttPool();
			break;
		case GaChaPoolType.Test:
			SetTestRoundTwoPool();
			break;
		}
		GoGuaranteeDes.SetActive(type == GaChaPoolType.Limitup || type == GaChaPoolType.Resident);
		BtnOnce.gameObject.SetActive(type != GaChaPoolType.Beginner);
	}

	private void SetLimitupPool()
	{
		GachaPoolEffectiveInfo gachaEffectiveInfo = Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(CurrentCardPool.id);
		TextLimitupTimerComponent.IsCountDown = true;
		CommonTimerComponent textLimitupTimerComponent = TextLimitupTimerComponent;
		System.DateTime minValue = System.DateTime.MinValue;
		textLimitupTimerComponent.Time = minValue.AddSeconds(Math.Max(0L, gachaEffectiveInfo.EndTimestamp - TimeManager.ServerTime.NowTimestampSecond));
		SetGuarantee(CurrentCardPool.bigGuarantNum - LimitedUpPoolData.CountForNotHighestQuality, 10 - LimitedUpPoolData.CountForNotHighQuality);
	}

	private void SetLimitGuranteedPool()
	{
		GachaPoolEffectiveInfo gachaEffectiveInfo = Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(CurrentCardPool.id);
		TextLimitGuaranteedTimerComponent.IsCountDown = true;
		CommonTimerComponent textLimitGuaranteedTimerComponent = TextLimitGuaranteedTimerComponent;
		System.DateTime minValue = System.DateTime.MinValue;
		textLimitGuaranteedTimerComponent.Time = minValue.AddSeconds(Math.Max(0L, gachaEffectiveInfo.EndTimestamp - TimeManager.ServerTime.NowTimestampSecond));
	}

	private void SetResidentPool()
	{
		SetResidentActive(isdiscount: false);
		int currentPoolCountForNotExchangeFinalGuaranteed = Model<CardDrawModel>.Interface.GetCurrentPoolCountForNotExchangeFinalGuaranteed(CurrentCardPool.gachaType);
		TextResidentoptionalCurrentNum.text = currentPoolCountForNotExchangeFinalGuaranteed.ToString();
		TextMeshProUGUI textResidentoptionalTargetNum = TextResidentoptionalTargetNum;
		int finalGuarantNum = CurrentCardPool.finalGuarantNum;
		textResidentoptionalTargetNum.text = finalGuarantNum.ToString();
		ImageResidentoptionalProgress.fillAmount = (float)currentPoolCountForNotExchangeFinalGuaranteed * 1f / (float)CurrentCardPool.finalGuarantNum;
		GoGaChaGiftHightLight.SetActive(currentPoolCountForNotExchangeFinalGuaranteed >= CurrentCardPool.finalGuarantNum);
		TextGaChaGiftHightLight.text = (currentPoolCountForNotExchangeFinalGuaranteed / CurrentCardPool.finalGuarantNum).ToString();
		SetGuarantee(CurrentCardPool.bigGuarantNum - ResidentPoolData.CountForNotHighestQuality, 10 - ResidentPoolData.CountForNotHighQuality);
	}

	private void SetGuarantee(int numS, int numA)
	{
		TextGuaranteeS.SetTable(LocalizeTable.Common);
		TextGuaranteeS.StringReference.TableEntryReference = LocalizationCommonData.CommonString.GuaranteeS;
		TextGuaranteeS.GetVariable<string>("0").Value = numS.ToString();
		TextGuaranteeA.SetTable(LocalizeTable.Common);
		TextGuaranteeA.StringReference.TableEntryReference = LocalizationCommonData.CommonString.GuaranteeA;
		TextGuaranteeA.GetVariable<string>("0").Value = numA.ToString();
	}

	private void SetTestRoundTwoPool()
	{
		SetResidentActive(isdiscount: false);
		int currentPoolCountForNotExchangeFinalGuaranteed = Model<CardDrawModel>.Interface.GetCurrentPoolCountForNotExchangeFinalGuaranteed(CurrentCardPool.gachaType);
		TextResidentoptionalCurrentNum.text = currentPoolCountForNotExchangeFinalGuaranteed.ToString();
		TextMeshProUGUI textResidentoptionalTargetNum = TextResidentoptionalTargetNum;
		int finalGuarantNum = CurrentCardPool.finalGuarantNum;
		textResidentoptionalTargetNum.text = finalGuarantNum.ToString();
		ImageResidentoptionalProgress.fillAmount = (float)currentPoolCountForNotExchangeFinalGuaranteed * 1f / (float)CurrentCardPool.finalGuarantNum;
		GoGaChaGiftHightLight.SetActive(currentPoolCountForNotExchangeFinalGuaranteed >= CurrentCardPool.finalGuarantNum);
		TextGaChaGiftHightLight.text = (currentPoolCountForNotExchangeFinalGuaranteed / CurrentCardPool.finalGuarantNum).ToString();
	}

	private void SetDiscounttPool()
	{
		SetResidentActive(isdiscount: true);
		TextMeshProUGUI textDiscountMinGuaranteeNum = TextDiscountMinGuaranteeNum;
		string text = (CurrentCardPool.discountEligiblePulls - NewbiePoolPoolData.TotalCount).ToString();
		int discountEligiblePulls = CurrentCardPool.discountEligiblePulls;
		textDiscountMinGuaranteeNum.text = text + "/" + discountEligiblePulls;
		BtnTen.Interactable(NewbiePoolPoolData.TotalCount < CurrentCardPool.discountEligiblePulls);
	}

	private void SetResidentActive(bool isdiscount)
	{
		GoResident.SetActive(!isdiscount);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		PreSelectPoolId = 0;
		m_data = null;
		uiViewData = null;
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		if (!Model<CardDrawModel>.Interface.InCommunication)
		{
			base.Close();
		}
	}

	private bool IsCardDrawDataReady()
	{
		if (Model<CardDrawModel>.HasInstance() && G.localPlayer != null && CurrentCardPool?.token != null && CurrentCardPool.token.Count > 0)
		{
			if (CurrentCardPool.gachaType == 5)
			{
				return NewbiePoolPoolData != null;
			}
			return true;
		}
		return false;
	}

	public void OnDrawOnce()
	{
		if (IsCardDrawDataReady() && !TryOpenTargetGachaReminder(DrawOnce))
		{
			DrawOnce();
		}
	}

	private void DrawOnce()
	{
		if (IsCardDrawDataReady() && CurrentCardPool.gachaType != 5)
		{
			NarmalDrawCard(1);
			ReportGachaClick(1, 1);
		}
	}

	public void OnDrawTen()
	{
		if (IsCardDrawDataReady() && !TryOpenTargetGachaReminder(DrawTen))
		{
			DrawTen();
		}
	}

	private void DrawTen()
	{
		if (IsCardDrawDataReady())
		{
			NarmalDrawCard(10);
			int gachaType = (((long)CurrentCardPool.token[0].id == 200133) ? 4 : 2);
			ReportGachaClick(1, gachaType);
		}
	}

	private bool TryOpenTargetGachaReminder(Action continueDraw)
	{
		if (CurrentCardPool == null || CurrentCardPool.targetCharacterPool == 0)
		{
			return false;
		}
		if (Singleton<GameState>.instance.InGuiding)
		{
			return false;
		}
		if (Model<CardDrawModel>.Interface.IsTargetGachaReminderDisabled())
		{
			return false;
		}
		GachaPoolUniqueData gachaPoolUniqueData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(CurrentCardPool.id);
		if (gachaPoolUniqueData != null && gachaPoolUniqueData.TargetGachaItemId > 0)
		{
			return false;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTARGETGACHAREMINDER, new PopupTargetGachaReminderViewData
		{
			GachaId = CurrentCardPool.id,
			OnContinue = continueDraw,
			SilenceEnabled = Model<CardDrawModel>.Interface.IsTargetGachaReminderDisabled(),
			OnClickSilence = Model<CardDrawModel>.Interface.SetTargetGachaReminderDisabled
		});
		return true;
	}

	private void NarmalDrawCard(int times)
	{
		if (!IsCardDrawDataReady())
		{
			return;
		}
		GachaPoolEffectiveInfo gachaEffectiveInfo = Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(CurrentCardPool.id);
		if (gachaEffectiveInfo == null)
		{
			return;
		}
		int num = ((CurrentCardPool.gachaType == 5) ? 1 : times);
		if ((CurrentCardPool.gachaType == 5 && NewbiePoolPoolData.TotalCount >= CurrentCardPool.discountEligiblePulls) || IsPlayAnimation || Model<CardDrawModel>.Interface.InCommunication)
		{
			return;
		}
		if (TimeManager.IsInTimeRange(gachaEffectiveInfo.BeginTimestamp, gachaEffectiveInfo.EndTimestamp, isMilliseconds: false))
		{
			if (CheckItemEnough(num))
			{
				Model<CardDrawModel>.Interface.InCommunication = true;
				Model<CardDrawModel>.Interface.SendGachaCardDraw(CurrentSelectPoolId, times, (GachaCardDrawAck ack) =>
				{
					OnCardDrawBack(ack);
					Model<CardDrawModel>.Interface.InCommunication = false;
				});
			}
			else if (CurrentCardPool.gachaType == 5)
			{
				GameUtility.OpenToolTip(41000125);
			}
			else
			{
				int neednum = num - GetCurrentItemNum();
				BuyNeedItem(neednum, () =>
				{
					NarmalDrawCard(times);
				});
			}
		}
		else
		{
			GameUtility.OpenToolTip(1767);
		}
	}

	private void BuyNeedItem(int neednum, Action callback)
	{
		int num = neednum * _OncePrice;
		(neednum * _OncePrice).ToString();
		int countById = G.localPlayer.GetCountById(97);
		int countById2 = G.localPlayer.GetCountById(98);
		ItemData data = CoreUtils.GetData(CurrentCardPool.token[0].id, RuntimeConfigs.data.itemDatas);
		LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal);
		GachaInsufficientPropsViewData gachaInsufficientPropsViewData = new GachaInsufficientPropsViewData();
		if (countById >= num)
		{
			IList<object> list = new List<object>();
			list.Add(num);
			list.Add(neednum);
			gachaInsufficientPropsViewData.StringDes = LocalizationUtility.GetLocalizeString("Common", 2717, list);
			gachaInsufficientPropsViewData.StringTips = LocalizationUtility.GetLocalizeString("Common", 2718);
			gachaInsufficientPropsViewData.OnConfirm = () =>
			{
				Model<CardDrawModel>.Interface.InCommunication = true;
				Model<CardDrawModel>.Interface.SendGachaExchangeTicket(CurrentCardPool.id, neednum, (GachaExchangeTicketAck ack) =>
				{
					Model<CardDrawModel>.Interface.InCommunication = false;
					if (ack.Code == 0)
					{
						callback();
					}
					else
					{
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
					}
				});
			};
		}
		else
		{
			int needcostNum = num - countById;
			if (countById2 >= needcostNum)
			{
				IList<object> list2 = new List<object>();
				list2.Add(countById);
				list2.Add(needcostNum);
				list2.Add(neednum);
				gachaInsufficientPropsViewData.StringDes = LocalizationUtility.GetLocalizeString("Common", 2719, list2);
				gachaInsufficientPropsViewData.StringTips = LocalizationUtility.GetLocalizeString("Common", 2718);
				gachaInsufficientPropsViewData.OnConfirm = () =>
				{
					G.service.ExchangeFreeDiamond(needcostNum, (bool success) =>
					{
						if (success)
						{
							Model<CardDrawModel>.Interface.InCommunication = true;
							Model<CardDrawModel>.Interface.SendGachaExchangeTicket(CurrentCardPool.id, neednum, (GachaExchangeTicketAck ack) =>
							{
								Model<CardDrawModel>.Interface.InCommunication = false;
								if (ack.Code == 0)
								{
									callback();
								}
								else
								{
									Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
								}
							});
						}
					});
				};
			}
			else
			{
				IList<object> list3 = new List<object>();
				list3.Add(num.FastToString());
				list3.Add(neednum.FastToString());
				gachaInsufficientPropsViewData.isbuy = true;
				gachaInsufficientPropsViewData.StringDes = LocalizationUtility.GetLocalizeString("Common", 2720, list3);
				IList<object> list4 = new List<object>();
				if (countById2 == 0)
				{
					list4.Add(needcostNum);
					gachaInsufficientPropsViewData.StringTips = LocalizationUtility.GetLocalizeString("Common", 2887, list4);
				}
				else
				{
					list4.Add(countById2.FastToString());
					int value = num - countById - countById2;
					list4.Add(value.FastToString());
					gachaInsufficientPropsViewData.StringTips = LocalizationUtility.GetLocalizeString("Common", 2721, list4);
				}
				gachaInsufficientPropsViewData.OnConfirm = () =>
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, new ShopViewData
					{
						FirstTabID = 5
					});
				};
			}
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GACHAINSUFFICIENTPROPS, gachaInsufficientPropsViewData);
	}

	public void OnDiscountTen()
	{
		if (!IsCardDrawDataReady())
		{
			return;
		}
		GachaPoolEffectiveInfo gachaEffectiveInfo = Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(CurrentCardPool.id);
		if (gachaEffectiveInfo == null)
		{
			return;
		}
		if (TimeManager.IsInTimeRange(gachaEffectiveInfo.BeginTimestamp, gachaEffectiveInfo.EndTimestamp, isMilliseconds: false))
		{
			if (CheckItemEnough(8))
			{
				Model<CardDrawModel>.Interface.SendGachaCardDraw(CurrentSelectPoolId, 10, (GachaCardDrawAck ack) =>
				{
					OnCardDrawBack(ack);
				});
				return;
			}
			int neednum = 8 - GetCurrentItemNum();
			BuyNeedItem(neednum, () =>
			{
				OnDiscountTen();
			});
		}
		else
		{
			GameUtility.OpenToolTip(1767);
		}
	}

	private void OnCardDrawBack(GachaCardDrawAck ack)
	{
		if (ack.Code == 0)
		{
			IsPlayAnimation = true;
			Debug.Log(":OnCardDrawBack UI_CARDDRAWSETTLE" + Time.frameCount);
			CheckNeedShow(ack.GotItems);
			CheckCardDrawNeedShow(ack.GotItems);
			_cachedGachaResults = ack.GotItems.ToList();
			PlaySceneTimeline();
			if (ack.GotItems.Count == 1)
			{
				GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.DrawCardOnce);
			}
			else
			{
				GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.DrawCardTen);
			}
		}
	}

	private bool CheckNeedShow(RepeatedField<GachaCardDrawItem> Items)
	{
		bool result = false;
		_listNeedShow.Clear();
		foreach (GachaCardDrawItem Item in Items)
		{
			AcquireCharacterShowData acquireCharacterShowData = new AcquireCharacterShowData();
			acquireCharacterShowData.IsNew = Item.PoolItem.IsNew;
			acquireCharacterShowData.Id = Item.PoolItem.Id;
			acquireCharacterShowData.CharacterMaxConstellation = Item.CharacterMaxConstellation;
			List<AcquireCharacterShowExtraData> list = new List<AcquireCharacterShowExtraData>();
			for (int i = 0; i < Item.ExtraItem.Count; i++)
			{
				list.Add(new AcquireCharacterShowExtraData
				{
					Id = Item.ExtraItem[i].Id,
					Count = Item.ExtraItem[i].Count
				});
			}
			acquireCharacterShowData.ExtraItem = list;
			_listNeedShow.Add(acquireCharacterShowData);
			result = true;
		}
		return result;
	}

	private bool CheckCardDrawNeedShow(RepeatedField<GachaCardDrawItem> Items)
	{
		bool result = false;
		_cardlistNeedShow.Clear();
		foreach (GachaCardDrawItem Item in Items)
		{
			CardDrawCharacterShowData cardDrawCharacterShowData = new CardDrawCharacterShowData();
			cardDrawCharacterShowData.IsNew = Item.PoolItem.IsNew;
			cardDrawCharacterShowData.Id = Item.PoolItem.Id;
			cardDrawCharacterShowData.Count = Item.PoolItem.Count;
			cardDrawCharacterShowData.CharacterMaxConstellation = Item.CharacterMaxConstellation;
			cardDrawCharacterShowData.isCharacter = Item.PoolItem.itemType == 5;
			List<CardDrawCharacterShowExtraData> list = new List<CardDrawCharacterShowExtraData>();
			for (int i = 0; i < Item.ExtraItem.Count; i++)
			{
				list.Add(new CardDrawCharacterShowExtraData
				{
					Id = Item.ExtraItem[i].Id,
					Count = Item.ExtraItem[i].Count
				});
			}
			cardDrawCharacterShowData.ExtraItem = list;
			_cardlistNeedShow.Add(cardDrawCharacterShowData);
			result = true;
		}
		return result;
	}

	private bool CheckItemEnough(int neednum)
	{
		return G.localPlayer.GetCountById(CurrentNeedItemId) >= neednum;
	}

	private int GetCurrentItemNum()
	{
		return G.localPlayer.GetCountById(CurrentNeedItemId);
	}

	public void OnOpenResidentoptionalReward()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CARDDRAWSELFSELECTEDREWARD, new CardDrawSelfSelectedRewardViewData
		{
			GaChaId = CurrentCardPool.id
		});
	}

	private void RefreshTargetGachaState()
	{
		if (CurrentCardPool == null)
		{
			return;
		}
		GachaPoolUniqueData gachaPoolUniqueData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(CurrentCardPool.id);
		GachaItem gachaItem = ((gachaPoolUniqueData != null && gachaPoolUniqueData.TargetGachaItemId > 0) ? CoreUtils.GetData(gachaPoolUniqueData.TargetGachaItemId, RuntimeConfigs.data.gachaItems) : null);
		ItemData itemData = ((gachaItem == null) ? null : CoreUtils.GetData(gachaItem.itemId, RuntimeConfigs.data.itemDatas));
		bool flag = itemData != null;
		NoTargetGacha.SetActive(!flag);
		HaveTargetGacha.SetActive(flag);
		if (flag)
		{
			if (ChargeValueText != null)
			{
				ChargeValueText.SetTable("Common");
				ChargeValueText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.ChargeValueText;
				ChargeValueText.GetVariable<int>("0").Value = gachaPoolUniqueData.TargetPoint;
				ChargeValueText.GetVariable<int>("1").Value = CurrentCardPool.maxTargetPoint;
			}
			if (TargetIcon != null)
			{
				Station.LoadImage(148, itemData.iconAddress, TargetIcon);
			}
		}
	}

	private void OpenTargetGacha()
	{
		if (CurrentCardPool != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTARGETGACHA, new PopupTargetGachaViewData
			{
				GachaId = CurrentCardPool.id
			});
		}
	}

	public void OpenHistoryTips()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCARDDRAWRECORD, new PopupCardDrawRecordViewData
		{
			CurrentCardPool = CurrentCardPool
		});
		int gachaType = (((long)CurrentCardPool.token[0].id == 200133) ? 4 : 2);
		ReportGachaClick(3, gachaType);
	}

	private void ReportGachaClick(int type, int gachaType = 0)
	{
		GachaClickEvent evt = EventTrackSolver.Instance.GetEvt<GachaClickEvent>();
		evt.gachaId = CurrentCardPool.id;
		evt.gachaType = gachaType;
		evt.type = type;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public async UniTask PlaySceneTimeline()
	{
		if (GachaViewRoot.activeSelf)
		{
			ChangeGaChaViewRoot(isshow: false);
			BtnSkip.gameObject.SetActive(value: true);
			GachaMachineRoot.SetActive(value: true);
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.DisableUISceneCameraSkipBase();
			GachaMachineEffect.SetActive(value: false);
			IdleSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Mus/UI/DrawCard_1");
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Open");
			GachaMachineRoot.GetComponent<BetterAnimation>().GetSequence("tips_Loop").SetLoops(-1)
				.Play();
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().GetResult();
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().ResetIdleSound();
			GachaSettleSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Mus/UI/DrawCard_4");
		}
	}

	public void SetIdleSound(string name, float vaule)
	{
		Singleton<GameManager>.instance.audioManager.SetParameter(IdleSoundId, name, vaule);
	}

	public void PlayGachaStartSound(int maxQuality)
	{
		GachaStartSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Mus/UI/DrawCard_2");
		int value = ((maxQuality >= 5) ? 3 : ((maxQuality != 4) ? 1 : 2));
		Singleton<GameManager>.instance.audioManager.SetParameter(GachaStartSoundId, "Music_DrawCard_Bridge", value);
	}

	public void PlayGachaCharacterSound(int quality)
	{
		characterSoundId = Singleton<GameManager>.instance.audioManager.PlaySound("event:/Mus/UI/DrawCard_3");
		int value = ((quality < 5) ? 1 : 2);
		Singleton<GameManager>.instance.audioManager.SetParameter(characterSoundId, "Music_DrawCard_Stinger", value);
	}

	private void OnStart()
	{
		if (inStart)
		{
			return;
		}
		inStart = true;
		GachaMachineEffect.SetActive(value: true);
		GachaMachineRoot.GetComponent<BetterAnimation>().GetSequence("trigger").Play()
			.OnComplete((AnimationBuilder a) =>
			{
				GachaMachineRoot.SetActive(value: false);
				if (IdleSoundId != 0)
				{
					Singleton<GameManager>.instance.audioManager.Stop(IdleSoundId);
					IdleSoundId = 0u;
					GachaMachineEffect.SetActive(value: false);
				}
				Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>().StartCardDraw();
			});
	}

	public void SkipSceneTimeline()
	{
		if (BtnSkip.IsActive())
		{
			BtnSkip.gameObject.SetActive(value: false);
		}
		if (BtnNext.IsActive())
		{
			BtnNext.gameObject.SetActive(value: false);
		}
		if (GachaMachineRoot.activeSelf)
		{
			GachaMachineRoot.SetActive(value: false);
		}
		if (IdleSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(IdleSoundId);
			IdleSoundId = 0u;
		}
		if (GachaStartSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(GachaStartSoundId);
			GachaStartSoundId = 0u;
		}
		CheckCharacterSound();
		Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.SkipCardDrawTimeline();
	}

	public void CheckCharacterSound()
	{
		if (characterSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(characterSoundId);
			characterSoundId = 0u;
		}
	}

	private void InitNewbieConfig(string typeProperty)
	{
		if (!string.IsNullOrEmpty(typeProperty))
		{
			NewbieConfig = JsonParser.ParseNewbieConfig(typeProperty);
		}
	}

	private void OpenShop()
	{
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(2502);
		if (Model<JumpModel>.Interface.CanJump(runTimeJumpData).ShowType == JumpResult.JumpShowType.CanJump)
		{
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		}
	}

	private void OnGamePadInit()
	{
		_inputActionDic = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			},
			["UI/UISpecial9"] = new GamePadTipsAction
			{
				inputAction = "UI/UISpecial9",
				localizeKey = 41000208,
				localizeTable = "Common"
			}
		};
	}

	private void SetScatteredGamepadTipsVisible(bool visible)
	{
		foreach (GameObject gamepadTip in gamepadTips)
		{
			gamepadTip.SetActive(visible);
		}
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadTipsComp == null) && _inputActionDic != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadTipsComp.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_inputActionDic["UI/Back"]);
			if (m_operateState == OperateState.Resource || m_operateState == OperateState.Function)
			{
				_tipsActions.Add(_inputActionDic["UI/Confirm"]);
			}
			if (CheckPoolIsJumpToCharacter())
			{
				_tipsActions.Add(_inputActionDic["UI/UISpecial9"]);
			}
			gamePadTipsComp.RegisterInputActions(_tipsActions);
		}
	}

	private bool CheckPoolIsJumpToCharacter()
	{
		Gacha currentCardPool = CurrentCardPool;
		if (currentCardPool == null)
		{
			return false;
		}
		return currentCardPool.targetCharacterShows.Length != 0;
	}

	private void SetOperateState(OperateState state)
	{
		m_operateState = state;
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetScatteredGamepadTipsVisible(state != OperateState.Resource && state != OperateState.Function);
			ReBindBtnPrompt();
		}
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			CardDrawSettleComponent?.ClearResultFocus();
		}
		EventSystemHelper.SetSelectedGameObject(null);
		_curSelectButton = null;
		if (deviceInputMode != DeviceInputMode.Gamepad)
		{
			SetScatteredGamepadTipsVisible(visible: false);
			gamePadTipsComp?.ClearAllPrompts();
			m_operateState = OperateState.None;
		}
		else
		{
			m_operateState = OperateState.Normal;
			SetScatteredGamepadTipsVisible(visible: true);
			ReBindBtnPrompt();
		}
	}

	public void OnTenConfirm()
	{
		if (m_operateState == OperateState.Normal)
		{
			BtnTen.OnSubmit(null);
		}
	}

	public void OnOneConfirm()
	{
		if (m_operateState == OperateState.Normal)
		{
			BtnOnce.OnSubmit(null);
		}
	}

	public bool TryExitSubState()
	{
		if (m_operateState == OperateState.Resource || m_operateState == OperateState.Function)
		{
			SetOperateState(OperateState.Normal);
			EventSystemHelper.SetSelectedGameObject(null);
			return true;
		}
		return false;
	}

	public void OnConfirm()
	{
		if (!GachaViewRoot.activeSelf && GachaMachineRoot.activeSelf)
		{
			BtnStart.OnSubmit(null);
		}
		else if (BtnNext.IsActive())
		{
			BtnNext.OnSubmit(null);
		}
		else if (CharacterShowRoot.activeSelf && AcquireCharacterShowNewComponent.BtnNext.IsActive())
		{
			AcquireCharacterShowNewComponent.BtnNext.OnSubmit(null);
		}
		else if (CardDrawSettleRoot.activeSelf && CardDrawSettleComponent.BtnClose.IsActive())
		{
			CardDrawSettleComponent.BtnClose.OnSubmit(null);
		}
		else if (m_operateState != OperateState.None)
		{
			if (m_operateState == OperateState.Function)
			{
				_curSelectButton.OnSubmit(null);
				return;
			}
			_ = m_operateState;
			_ = 2;
		}
	}

	public void OnSpecial4()
	{
		if (BtnSkip.IsActive())
		{
			BtnSkip.OnSubmit(null);
		}
		else if (GachaViewRoot.activeSelf && !CardDrawSettleRoot.activeSelf && !CharacterShowRoot.activeSelf)
		{
			BtnShop.OnSubmit(null);
		}
	}

	public void OnSelfChoose()
	{
		if (m_operateState == OperateState.Normal && CurrentCardPool.isFinalGuarantSelectable && GachaViewRoot.activeSelf)
		{
			BtnResidentoptionalGift.OnClick.Invoke();
		}
	}

	public void CloseFromGamepad()
	{
		BtnClose.OnSubmit(null);
	}

	public void OnChooseResource()
	{
		if (m_operateState == OperateState.Normal)
		{
			m_operateState = OperateState.Resource;
			SetOperateState(OperateState.Resource);
		}
	}

	public void OnChooseFunction()
	{
		if (m_operateState == OperateState.Normal)
		{
			m_operateState = OperateState.Function;
			BtnProbabilityDetail.Select();
			_curSelectButton = BtnProbabilityDetail;
			SetOperateState(OperateState.Function);
		}
	}

	public void OnNavigate(Vector2 value)
	{
		if (m_operateState != OperateState.Function)
		{
			return;
		}
		if (value != Vector2.zero && Mathf.Abs(value.x) > Mathf.Abs(value.y))
		{
			if (BtnJump.IsActive())
			{
				if (value.x > 0f)
				{
					_curSelectButton = BtnJump;
				}
				else
				{
					_curSelectButton = BtnProbabilityDetail;
				}
			}
			else
			{
				_curSelectButton = BtnProbabilityDetail;
			}
		}
		EventSystemHelper.SetSelectedGameObject(_curSelectButton.gameObject);
	}

	public void OnGamepadSlide(float value)
	{
		if (GachaMachineRoot.activeSelf && m_operateState != OperateState.Resource && m_operateState != OperateState.Function)
		{
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.OnGamepadSlide(value);
		}
	}

	public void OnGamepadRotate(float deltaAngle)
	{
		if (GachaMachineRoot.activeSelf && m_operateState != OperateState.Resource && m_operateState != OperateState.Function)
		{
			Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.OnGamepadRotate(deltaAngle);
		}
	}

	public void SwitchTab(bool next)
	{
		if (_carddrawCells.Count > 1)
		{
			int num = _carddrawCells.FindIndex((CarddrawCell c) => c.GaChaId == SelectPoolId);
			if (num < 0)
			{
				num = 0;
			}
			int index = (next ? ((num + 1) % _carddrawCells.Count) : ((num - 1 + _carddrawCells.Count) % _carddrawCells.Count));
			CarddrawCell carddrawCell = _carddrawCells[index];
			if (carddrawCell.GaChaId != SelectPoolId)
			{
				carddrawCell.BtnClick.OnSubmit(null);
			}
		}
	}

	public List<GachaCardDrawItem> GetGachaResults()
	{
		return _cachedGachaResults;
	}

	public void ToCharacterShow(List<CardDrawCharacterShowData> showList = null, bool isSkip = false)
	{
		List<CardDrawCharacterShowData> showItems = showList ?? BuildCardDrawCharacterShowList();
		if (AcquireCharacterShowNewComponent == null && CharacterShowRoot != null)
		{
			AcquireCharacterShowNewComponent = CharacterShowRoot.GetComponentInChildren<AcquireCharacterShowNewComponent>(includeInactive: true);
		}
		if (AcquireCharacterShowNewComponent == null)
		{
			return;
		}
		CardDrawCharacterShowConfig cardDrawCharacterShowConfig = new CardDrawCharacterShowConfig
		{
			showItems = showItems,
			isNeedShowOpenAni = true,
			gachaId = CurrentCardPool.id,
			gachaType = ((_cachedGachaResults.Count == 1) ? 1 : (((long)CurrentCardPool.token[0].id == 200133) ? 4 : 2)),
			onBeforeShowItemAsync = async (CardDrawCharacterShowData item) =>
			{
				CardDrawViewScene scene = Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>();
				if (scene != null)
				{
					bool active = !item.isCharacter || !item.IsNew;
					BtnSkip.gameObject.SetActive(active);
					await scene.PlayCharacterTimelineBeforeShow(item);
				}
			},
			shouldAbortCurrentShow = () =>
			{
				CardDrawViewScene scene = Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>();
				return scene != null && scene.Phase == CardDrawPhase.ShowingSettle;
			},
			onAllShowComplete = ToCardDrawSettle,
			settleItems = _cachedGachaResults
		};
		CharacterShowRoot.SetActive(value: true);
		AcquireCharacterShowNewComponent.InitPanel(cardDrawCharacterShowConfig, Station, this);
	}

	public void PlayCharacterAcquireTimelineForTest(int characterItemId)
	{
		ItemData data = CoreUtils.GetData(characterItemId, RuntimeConfigs.data.itemDatas);
		if (data == null || data.type != 5)
		{
			Debug.LogError($"角色演出测试失败：角色道具 {characterItemId} 不存在或不是角色道具。");
			return;
		}
		if (CurrentCardPool == null && _gachasPoolDatas.Count > 0)
		{
			RefreshRightPanel(_gachasPoolDatas[0].id);
		}
		if (CurrentCardPool == null && RuntimeConfigs.data?.gachas != null)
		{
			foreach (Gacha value in RuntimeConfigs.data.gachas.Values)
			{
				if (value != null)
				{
					RefreshRightPanel(value.id);
					if (CurrentCardPool != null)
					{
						break;
					}
				}
			}
		}
		CardDrawCharacterShowData item = new CardDrawCharacterShowData
		{
			Id = characterItemId,
			Count = 1,
			IsNew = true,
			isCharacter = true,
			ExtraItem = new List<CardDrawCharacterShowExtraData>()
		};
		_cardlistNeedShow.Clear();
		_cardlistNeedShow.Add(item);
		_cachedGachaResults.Clear();
		_cachedGachaResults.Add(new GachaCardDrawItem
		{
			PoolItem = new Item
			{
				Id = characterItemId,
				Count = 1,
				IsNew = true
			}
		});
		CardDrawViewScene scene = Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>();
		if (scene == null || CurrentCardPool == null)
		{
			Debug.LogError("角色演出测试失败：抽卡场景或卡池未初始化。");
			return;
		}
		ChangeGaChaViewRoot(isshow: false);
		scene.GetResult();
		ToCharacterShow(new List<CardDrawCharacterShowData> { item });
	}

	private List<CardDrawCharacterShowData> BuildCardDrawCharacterShowList()
	{
		List<CardDrawCharacterShowData> list = new List<CardDrawCharacterShowData>(_cardlistNeedShow.Count);
		for (int i = 0; i < _cardlistNeedShow.Count; i++)
		{
			CardDrawCharacterShowData cardDrawCharacterShowData = _cardlistNeedShow[i];
			if (cardDrawCharacterShowData == null)
			{
				continue;
			}
			CardDrawCharacterShowData cardDrawCharacterShowData2 = new CardDrawCharacterShowData
			{
				IsNew = cardDrawCharacterShowData.IsNew,
				Id = cardDrawCharacterShowData.Id,
				Count = cardDrawCharacterShowData.Count,
				CharacterMaxConstellation = cardDrawCharacterShowData.CharacterMaxConstellation,
				isCharacter = cardDrawCharacterShowData.isCharacter,
				ExtraItem = new List<CardDrawCharacterShowExtraData>()
			};
			if (cardDrawCharacterShowData.ExtraItem != null)
			{
				for (int j = 0; j < cardDrawCharacterShowData.ExtraItem.Count; j++)
				{
					cardDrawCharacterShowData2.ExtraItem.Add(new CardDrawCharacterShowExtraData
					{
						Id = cardDrawCharacterShowData.ExtraItem[j].Id,
						Count = cardDrawCharacterShowData.ExtraItem[j].Count
					});
				}
			}
			list.Add(cardDrawCharacterShowData2);
		}
		return list;
	}

	public void ToCardDrawSettle()
	{
		BtnSkip.gameObject.SetActive(value: false);
		CharacterShowRoot.SetActive(value: false);
		CardDrawSettleRoot.SetActive(value: true);
		Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.EnableUISceneCameraSkipBase();
		int gachaType = ((_cachedGachaResults.Count == 1) ? 1 : (((long)CurrentCardPool.token[0].id == 200133) ? 4 : 2));
		CardDrawSettleComponent.PreInit(Station, _cachedGachaResults, OnSettleComplete, CurrentCardPool.id, gachaType);
	}

	private void OnSettleComplete()
	{
		if (GachaSettleSoundId != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(GachaSettleSoundId);
			GachaSettleSoundId = 0u;
		}
		CardDrawSettleComponent.ClearResultFocus();
		CardDrawSettleRoot.SetActive(value: false);
		inStart = false;
		Singleton<UISceneManager>.instance.GetScene<CardDrawViewScene>()?.NotifySettleClosed();
		IsPlayAnimation = false;
	}

	public void NormalJumpToCharacter()
	{
		if (GachaViewRoot.activeSelf && CheckPoolIsJumpToCharacter())
		{
			List<Character> displayCharacters = CharacterDataHelper.CreateTrialCharacterTeamByProbationIds(CurrentCardPool.targetCharacterShows);
			EntityCharacterProbation data = CoreUtils.GetData(CurrentCardPool.targetCharacterShows[0], RuntimeConfigs.data.entityCharacterProbations);
			if (data != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
				{
					DisplayCharacters = displayCharacters,
					defaultCharacterId = data.characterId
				});
			}
		}
	}
}
