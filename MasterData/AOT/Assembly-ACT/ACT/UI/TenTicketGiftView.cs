using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using bamboosdk;

namespace ACT.UI;

public class TenTicketGiftView : BaseUIView<TenTicketGiftInputController>, IFacePushReusableView
{
	public ActButton BtnClose;

	public ActButton BtnBuy;

	public CommonPriceComponent PriceComponent;

	public TextMeshProUGUI giftName;

	public TextMeshProUGUI description;

	public ViewControlLayer ViewControlLayer;

	public GameObject GamepadTipsRoot;

	private TenTicketGiftViewData m_data;

	private Bundle _bundleData;

	private bool _purchaseRequesting;

	private string _pendingOrderId;

	private bool _payEventListening;

	private bool _acceptRetriedPayEvent;

	private bool _facePushShown;

	private readonly FacePushViewLifecycle _facePushLifecycle = new FacePushViewLifecycle();

	public override UniTask PreInit()
	{
		m_data = (uiViewData as TenTicketGiftViewData) ?? new TenTicketGiftViewData();
		_facePushLifecycle.Bind(m_data);
		_purchaseRequesting = false;
		_pendingOrderId = null;
		_acceptRetriedPayEvent = false;
		_facePushShown = false;
		BtnClose?.SetBtnClick(CloseFacePush);
		BtnBuy?.SetBtnClick(OnMainButtonClick);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/FirstPurchase");
		if (!RefreshView())
		{
			_facePushLifecycle.NotifyOpenFailed("十连券礼包界面数据无效");
			Close();
		}
		else
		{
			_facePushLifecycle.NotifyShown();
			_facePushShown = _facePushLifecycle.HasSession;
			ReportFacePushEvent(0, 1);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_facePushLifecycle.NotifyCloseTransitionStarted();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	protected override void UnInit()
	{
		StopListenPayEvent();
		_pendingOrderId = null;
		_acceptRetriedPayEvent = false;
		_purchaseRequesting = false;
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
		base.UnInit();
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		_facePushLifecycle.NotifyOnCloseComplete();
	}

	public bool TryRefreshFacePush(object viewData)
	{
		if (!(viewData is TenTicketGiftViewData tenTicketGiftViewData))
		{
			return false;
		}
		TenTicketGiftViewData data = m_data;
		m_data = tenTicketGiftViewData;
		SetUIViewData(tenTicketGiftViewData);
		if (!RefreshView())
		{
			m_data = data;
			SetUIViewData(data);
			RefreshView();
			return false;
		}
		_facePushLifecycle.Bind(m_data);
		_purchaseRequesting = false;
		_pendingOrderId = null;
		_acceptRetriedPayEvent = false;
		_facePushShown = _facePushLifecycle.HasSession;
		_facePushLifecycle.NotifyShown();
		ReportFacePushEvent(0, 1);
		ViewControlLayer?.Focus();
		return true;
	}

	public void CloseFacePush()
	{
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
		if (!_facePushLifecycle.HasSession || !Model<FacePushModel>.HasInstance() || Model<FacePushModel>.Interface.Scheduler == null || !Model<FacePushModel>.Interface.Scheduler.TryRefreshCurrentFacePushWithSameUI(UI_TYPE.UI_TENTICKETGIFT))
		{
			Close();
		}
	}

	public void OnActivate()
	{
		if (MonoECS.instance != null)
		{
			OnInputDeviceChange(MonoECS.instance.InputMode);
		}
		ViewControlLayer?.Focus();
	}

	public void OnConfirm()
	{
		if (!EventSystemHelper.Available || EventSystemHelper.CurrentSelected == null)
		{
			OnMainButtonClick();
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData eventData) =>
		{
			handler.OnSubmit(eventData);
		});
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		ViewControlRoot viewControlRoot = ((ViewControlLayer != null) ? ViewControlLayer.GetComponentInParent<ViewControlRoot>() : GetComponentInParent<ViewControlRoot>());
		switch (direction)
		{
		case MoveDirection.Up:
			viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			viewControlRoot?.SelectRight();
			break;
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		ViewControlLayer?.ReFocus();
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		}
	}

	private bool RefreshView()
	{
		_bundleData = CoreUtils.GetData(m_data.bundleId, RuntimeConfigs.data.bundles);
		if (_bundleData == null || !IsBundleAvailable())
		{
			return false;
		}
		UpdateDescription();
		UpdatePrice();
		UpdateButton();
		UpdateGiftName();
		return true;
	}

	private void UpdateGiftName()
	{
		giftName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, _bundleData.bundlename);
	}

	private bool IsBundleAvailable()
	{
		if (_bundleData == null || m_data.subShopId <= 0 || !Model<ShopModel>.HasInstance())
		{
			return false;
		}
		if (_bundleData.type == 4 || _bundleData.paytype < 1 || _bundleData.paytype > 3)
		{
			return false;
		}
		if (Model<ShopModel>.Interface.BundleLeftCount(_bundleData.id) == 0)
		{
			return false;
		}
		if (!IsCommodityInSaleTime(_bundleData.id))
		{
			return false;
		}
		if (_bundleData.missionGroupId != 0)
		{
			return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(_bundleData.missionGroupId);
		}
		return true;
	}

	private bool IsCommodityInSaleTime(int commodityId)
	{
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(commodityId, out var value))
		{
			return true;
		}
		if (value.EndTime > 0)
		{
			return value.EndTime >= TimeManager.ServerTime.NowTimestampSecond;
		}
		return true;
	}

	private void UpdateDescription()
	{
		if (!(description == null))
		{
			description.text = LocalizationUtility.GetLocalizeString("longcommon", _bundleData.bundledetail);
		}
	}

	private void UpdatePrice()
	{
		if (PriceComponent == null)
		{
			return;
		}
		int preprice = _bundleData.preprice;
		switch (_bundleData.paytype)
		{
		case 1:
		{
			ItemKv itemKv = _bundleData.itemNeed?.FirstOrDefault();
			if (itemKv != null)
			{
				PriceComponent.Init(itemKv.id, itemKv.count, (preprice > 0) ? preprice : (-1));
			}
			break;
		}
		case 2:
			PriceComponent.Init(Model<PayModel>.Interface.GetPrice(_bundleData.id), (preprice > 0) ? preprice.FastToString() : null);
			break;
		case 3:
			PriceComponent.Init();
			break;
		}
	}

	private void UpdateButton()
	{
		BtnBuy?.Interactable(!_purchaseRequesting && IsBundleAvailable());
	}

	private void OnBuy()
	{
		if (!_purchaseRequesting && _bundleData != null && IsBundleAvailable())
		{
			switch (_bundleData.paytype)
			{
			case 1:
			case 3:
				BuyByExchange();
				break;
			case 2:
				BuyByCash();
				break;
			}
			ReportFacePushEvent(0, 5);
		}
	}

	private void OnMainButtonClick()
	{
		if (!_facePushLifecycle.TryExecuteButtonAction(null, OnJump, OnBuy))
		{
			OnBuy();
		}
	}

	private void OnJump()
	{
		ReportFacePushEvent(0, 4);
		Close();
	}

	private void BuyByExchange()
	{
		_purchaseRequesting = true;
		UpdateButton();
		Model<PayModel>.Interface.ExchangeCommodity(m_data.subShopId, _bundleData.id, (bool ok, List<Item> items) =>
		{
			_purchaseRequesting = false;
			if (!ok)
			{
				UpdateButton();
			}
			else
			{
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items));
				Close();
			}
		});
	}

	private void BuyByCash()
	{
		if (!LuminBambooBridgeListener.Default.IsLogin)
		{
			GameUtility.OpenToolTip("未登录SDK无法拉起支付");
			return;
		}
		_purchaseRequesting = true;
		UpdateButton();
		Model<PayModel>.Interface.SendOrder(_bundleData.id, m_data.subShopId, (bool ok, CreatOrderAck ack) =>
		{
			if (!ok || ack == null || string.IsNullOrEmpty(ack.OrderId))
			{
				_purchaseRequesting = false;
				UpdateButton();
			}
			else
			{
				_pendingOrderId = ack.OrderId;
				_acceptRetriedPayEvent = false;
				StartListenPayEvent();
			}
		});
	}

	private void StartListenPayEvent()
	{
		if (!_payEventListening)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Pay, OnPayEvent);
			_payEventListening = true;
		}
	}

	private void StopListenPayEvent()
	{
		if (_payEventListening)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Pay, OnPayEvent);
			_payEventListening = false;
		}
	}

	private void OnPayEvent(BaseEventContent content)
	{
		if (!(content is PayEvent payEvent) || string.IsNullOrEmpty(_pendingOrderId))
		{
			return;
		}
		bool flag = payEvent.orderID == _pendingOrderId;
		if (!flag && !_acceptRetriedPayEvent)
		{
			return;
		}
		if (payEvent.isRetry & flag)
		{
			_acceptRetriedPayEvent = true;
			return;
		}
		StopListenPayEvent();
		_pendingOrderId = null;
		_acceptRetriedPayEvent = false;
		_purchaseRequesting = false;
		if (payEvent.isSuccess)
		{
			Close();
		}
		else
		{
			UpdateButton();
		}
	}

	private void ReportFacePushEvent(int durationTime, int status)
	{
		if (m_data?.FacePushSession != null)
		{
			PopupEvent evt = EventTrackSolver.Instance.GetEvt<PopupEvent>();
			evt.adId = m_data.FacePushSession.Config.id;
			evt.eventDuration = durationTime;
			evt.type = 1;
			evt.status = status;
			evt.subShopId = m_data.subShopId;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}
}
