using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupCharacterSkinBuyView : BaseUIView<PopupCharacterSkinBuyViewInputController>
{
	public ActButton BtnClose;

	public GameObject GoTag;

	public BImage SkinIcon;

	public LocalizeStringEvent TextTime;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDescription;

	public ActButton BtnBuy;

	public ActButton BtnCanel;

	public CommonPriceComponent PriceComponent;

	public SkinQualityComponent SkinQualityComponent;

	[Header("按键提示相关")]
	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	private PopupCharacterSkinBuyViewData m_data;

	private Skin _skinData;

	private SkinShop _skinShopData;

	public override UniTask PreInit()
	{
		BtnClose.SetBtnClick(OnCancel);
		BtnCanel.SetBtnClick(OnCancel);
		BtnBuy.SetBtnClick(OnBuy);
		m_data = uiViewData as PopupCharacterSkinBuyViewData;
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AddSkin, OnAddSkin);
		base.AddEventListener();
	}

	private void OnAddSkin(BaseEventContent obj)
	{
		Close();
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHARACTERSKINACQUIRE, new PopupCharacterSkinAcquireViewData
		{
			SkinId = _skinData.id
		});
	}

	private void UpdatePrice(SkinShop _skinShop)
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

	private void InitPanel()
	{
		_skinData = CoreUtils.GetData(m_data.SkinId, RuntimeConfigs.data.Skins);
		if (_skinData != null)
		{
			TextName.StringReference.TableEntryReference = _skinData.skinname;
			TextDescription.StringReference.TableEntryReference = _skinData.skindetail;
			_skinShopData = CoreUtils.GetData(_skinData.id, RuntimeConfigs.data.skinShops);
			Station.LoadImage(149, _skinData.id, SkinIcon);
			SkinQualityComponent.SetSkinQuality(_skinData.skinQuality);
			if (_skinShopData != null)
			{
				UpdatePrice(_skinShopData);
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void OnBuy()
	{
		ShopEventTrackHelper.Dispatch(m_data.SubShopId, 4, _skinShopData.id, 1);
		if (_skinShopData.paytype == 1)
		{
			if (G.localPlayer.GetCountById(_skinShopData.itemNeed[0].id) >= _skinShopData.itemNeed[0].count)
			{
				Model<PayModel>.Interface.ExchangeCommodity(m_data.SubShopId, _skinShopData.id, (bool ok, List<Item> items) =>
				{
					ShopEventTrackHelper.Dispatch(m_data.SubShopId, ok ? 6 : 5, _skinShopData.id, 1);
				});
			}
			else
			{
				ShopEventTrackHelper.Dispatch(m_data.SubShopId, 5, _skinShopData.id, 1);
			}
		}
		else
		{
			if (_skinShopData.paytype != 2)
			{
				return;
			}
			Model<PayModel>.Interface.SendOrder(_skinShopData.id, m_data.SubShopId, (bool ok, CreatOrderAck ack) =>
			{
				if (!ok)
				{
					ShopEventTrackHelper.Dispatch(m_data.SubShopId, 5, _skinShopData.id, 1);
				}
				else
				{
					PayModel payModel = Model<PayModel>.Interface;
					payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnOrderPaySuccess));
				}
				void OnOrderPaySuccess(string orderId)
				{
					if (ack == null || !(orderId != ack.OrderId))
					{
						PayModel payModel2 = Model<PayModel>.Interface;
						payModel2.OnPaySuccess = (Action<string>)Delegate.Remove(payModel2.OnPaySuccess, new Action<string>(OnOrderPaySuccess));
						ShopEventTrackHelper.Dispatch(m_data.SubShopId, 6, _skinShopData.id, 1);
					}
				}
			});
		}
	}

	private void OnCancel()
	{
		if (_skinShopData != null)
		{
			ShopEventTrackHelper.Dispatch(m_data.SubShopId, 5, _skinShopData.id, 1);
		}
		Close();
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AddSkin, OnAddSkin);
		base.RemoveEventListener();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}
}
