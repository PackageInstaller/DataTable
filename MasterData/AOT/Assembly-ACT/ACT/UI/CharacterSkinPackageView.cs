using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterSkinPackageView : BaseUIView<CharacterSkinPackageViewInputController>
{
	public ActButton BtnClose;

	public ActButton BtnBuy;

	public LocalizeStringEvent TitleName;

	public LocalizeStringEvent DesText;

	public CommonPriceComponent PriceComponent;

	private CommonTimerComponent TimerComponent;

	public ViewControlLayer ViewControlLayer;

	public GameObject GamepadTipsRoot;

	private CharacterSkinPackageViewData m_data;

	private SkinShop _skinShop;

	private Skin _skinData;

	private bool _facePushShown;

	private readonly FacePushViewLifecycle _facePushLifecycle = new FacePushViewLifecycle();

	public override UniTask PreInit()
	{
		m_data = (uiViewData as CharacterSkinPackageViewData) ?? new CharacterSkinPackageViewData();
		_facePushLifecycle.Bind(m_data);
		_facePushShown = false;
		BtnClose?.SetBtnClick(Close);
		BtnBuy?.SetBtnClick(OnMainButtonClick);
		if (TimerComponent != null)
		{
			TimerComponent.OnTimeOut = OnTimeOut;
		}
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/TalkingHead/Skin_2601_1");
		if (!RefreshView())
		{
			_facePushLifecycle.NotifyOpenFailed("皮肤礼包界面数据无效");
			Close();
			return;
		}
		_facePushShown = _facePushLifecycle.NotifyShown();
		if (_facePushShown)
		{
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
		if (TimerComponent != null)
		{
			TimerComponent.OnTimeOut = null;
		}
		base.UnInit();
		if (_facePushShown)
		{
			ReportFacePushEvent(TimeManager.ServerTime.NowTimestampSecond - m_data.FacePushSession.OpenTime, 2);
			_facePushShown = false;
		}
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		_facePushLifecycle.NotifyOnCloseComplete();
	}

	public void OnActivate()
	{
		if (MonoECS.instance != null)
		{
			OnInputDeviceChange(MonoECS.instance.InputMode);
		}
		ViewControlLayer?.Focus();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (GamepadTipsRoot != null)
		{
			GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		}
	}

	public void OnConfirm()
	{
		if (!EventSystemHelper.Available || EventSystemHelper.CurrentSelected == null)
		{
			OnMainButtonClick();
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		ViewControlRoot componentInParent = GetComponentInParent<ViewControlRoot>();
		switch (direction)
		{
		case MoveDirection.Up:
			componentInParent?.SelectUp();
			break;
		case MoveDirection.Down:
			componentInParent?.SelectDown();
			break;
		case MoveDirection.Left:
			componentInParent?.SelectLeft();
			break;
		case MoveDirection.Right:
			componentInParent?.SelectRight();
			break;
		}
	}

	private bool RefreshView()
	{
		if (RuntimeConfigs.data?.skinShops == null || RuntimeConfigs.data.Skins == null || RuntimeConfigs.data.subshopDatas == null)
		{
			return false;
		}
		_skinShop = CoreUtils.GetData(m_data.skinShopId, RuntimeConfigs.data.skinShops);
		if (_skinShop == null)
		{
			return false;
		}
		_skinData = CoreUtils.GetData(_skinShop.skinid, RuntimeConfigs.data.Skins);
		if (_skinData == null || !IsSkinPackageAvailable())
		{
			return false;
		}
		UpdateText();
		UpdateTimer();
		UpdatePrice();
		UpdateButton();
		return true;
	}

	private bool IsSkinPackageAvailable()
	{
		if (_skinShop == null || _skinData == null || m_data.subShopId <= 0 || !Model<ShopModel>.HasInstance())
		{
			return false;
		}
		if (_skinShop.paytype < 1 || _skinShop.paytype > 3)
		{
			return false;
		}
		if (!IsCommodityInSaleTime(_skinShop.id))
		{
			return false;
		}
		if (Model<ShopModel>.Interface.SkinItemLeftCount(_skinShop.id) == 0)
		{
			return false;
		}
		return !HasOwnedSkin(_skinShop.skinid);
	}

	private static bool HasOwnedSkin(int skinId)
	{
		List<SkinInfo> skinData = Model<ShopModel>.Interface.SkinData;
		if (skinData == null)
		{
			return false;
		}
		for (int i = 0; i < skinData.Count; i++)
		{
			if (skinData[i].SkinId == skinId)
			{
				return true;
			}
		}
		return false;
	}

	private bool IsCommodityInSaleTime(int commodityId)
	{
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(commodityId, out var value))
		{
			SubshopData data = CoreUtils.GetData(m_data.subShopId, RuntimeConfigs.data.subshopDatas);
			if (data == null)
			{
				return false;
			}
			return data.gmType == 1;
		}
		if (value.EndTime > 0)
		{
			return value.EndTime >= TimeManager.ServerTime.NowTimestampSecond;
		}
		return true;
	}

	private void UpdateText()
	{
		if (TitleName != null)
		{
			TitleName.SetTable("shortcommon");
			TitleName.StringReference.TableEntryReference = _skinShop.bundlename;
		}
		if (DesText != null)
		{
			DesText.SetTable("longcommon");
			DesText.StringReference.TableEntryReference = _skinShop.bundledetail;
		}
	}

	private void UpdateTimer()
	{
		if (!(TimerComponent == null))
		{
			long num = Model<ShopModel>.Interface.CommodityLeftTime(_skinShop.id);
			if (num < 0 || TimeSpan.FromSeconds(num).Ticks >= 3153600000000000L)
			{
				CommonTimerComponent timerComponent = TimerComponent;
				System.DateTime minValue = System.DateTime.MinValue;
				timerComponent.Time = minValue.Add(TimeSpan.FromTicks(3153600000000000L));
			}
			else
			{
				TimerComponent.IsCountDown = true;
				CommonTimerComponent timerComponent2 = TimerComponent;
				System.DateTime minValue = System.DateTime.MinValue;
				timerComponent2.Time = minValue.Add(TimeSpan.FromSeconds(num));
			}
		}
	}

	private void UpdatePrice()
	{
		if (PriceComponent == null)
		{
			return;
		}
		switch (_skinShop.paytype)
		{
		case 1:
		{
			ItemKv itemKv = _skinShop.itemNeed?.FirstOrDefault();
			if (itemKv != null)
			{
				PriceComponent.Init(itemKv.id, itemKv.count);
			}
			break;
		}
		case 2:
			PriceComponent.Init(Model<PayModel>.Interface.GetPrice(_skinShop.id));
			break;
		case 3:
			PriceComponent.Init();
			break;
		}
	}

	private void UpdateButton()
	{
		BtnBuy?.Interactable(IsSkinPackageAvailable());
	}

	private void OnMainButtonClick()
	{
		if (!_facePushLifecycle.TryExecuteButtonAction(CanJump, OnJump))
		{
			OnJump();
		}
	}

	private void OnJump()
	{
		ReportFacePushEvent(0, 4);
		Close();
	}

	private bool CanJump()
	{
		if (_skinShop != null && _skinData != null)
		{
			return IsSkinPackageAvailable();
		}
		return false;
	}

	private void OnTimeOut()
	{
		if (!RefreshView())
		{
			Close();
		}
	}

	private ActButton FindActButton(string nodeName)
	{
		Transform transform = FindChildByName(base.transform, nodeName);
		if (!(transform != null))
		{
			return null;
		}
		return transform.GetComponentInChildren<ActButton>(includeInactive: true);
	}

	private LocalizeStringEvent FindLocalizeString(string nodeName)
	{
		Transform transform = FindChildByName(base.transform, nodeName);
		if (!(transform != null))
		{
			return null;
		}
		return transform.GetComponentInChildren<LocalizeStringEvent>(includeInactive: true);
	}

	private Transform FindChildByName(Transform root, string nodeName)
	{
		if (root == null)
		{
			return null;
		}
		if (root.name == nodeName)
		{
			return root;
		}
		for (int i = 0; i < root.childCount; i++)
		{
			Transform transform = FindChildByName(root.GetChild(i), nodeName);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	private void ReportFacePushEvent(int durationTime, int status)
	{
		PopupEvent evt = EventTrackSolver.Instance.GetEvt<PopupEvent>();
		evt.adId = m_data.FacePushSession.Config.id;
		evt.eventDuration = durationTime;
		evt.type = 1;
		evt.status = status;
		evt.subShopId = ((status == 3) ? m_data.subShopId : 0);
		EventTrackSolver.Instance.Dispatch(evt);
	}
}
