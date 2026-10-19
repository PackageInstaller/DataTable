using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using Runtime.Model;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RogueHudBloodbottleTip : RogueSubComponent<RogueHudBloodbottleTipSubController>
{
	public RogueHudBloodbootleItem CurrentHudBloodbootleItem;

	public ActButton BtnPickup;

	public RogueHudBloodbootleItem ReplaceHudBloodbootleItem;

	public ActButton BtnReplace;

	public ActButton BtnBuy;

	public GameObject BtnBuyObject;

	public TextMeshProUGUI TextPrice;

	public ActButton BtnGet;

	public BetterAnimation betterAnimation;

	private ImageAssetStation roguestation;

	private bool _isbuy;

	private bool _isreplace;

	private int stateWorldAssetUid;

	private RogueElement _rogueElement;

	private Color _priceNormalColor;

	private VertexGradient _priceNormalGradient;

	private bool _priceNormalGradientEnabled;

	private ActBtnTextColorComp _priceTextColorComp;

	private bool _priceColorCached;

	private void Start()
	{
		BtnBuy.SetBtnClick(OnBuy);
		BtnGet.SetBtnClick(OnGet);
		BtnReplace.SetBtnClick(OnReplace);
	}

	public void OnReplace()
	{
		int oldItmeId = Model<RogueNewModel>.Interface.GetRogueBagByType(1)[0].RogueItem.ItemId;
		if (Model<RogueNewModel>.Interface.IsInDiscards(_rogueElement.id))
		{
			Model<RogueNewModel>.Interface.ReplaceRogueItem(oldItmeId, _rogueElement.id);
			SendRoguePropReplace(0, stateWorldAssetUid, oldItmeId);
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueBuyItem(_rogueElement.id, (RogueBuyItemAck ack) =>
			{
				SendRoguePropReplace(0, stateWorldAssetUid, oldItmeId);
			}, oldItmeId, isReplace: true);
		}
	}

	private void SendRoguePropReplace(int index = 0, int swuid = 0, int newItemId = 0)
	{
		RoguePropReplace roguePropReplace = new RoguePropReplace();
		roguePropReplace.isCompleted = true;
		roguePropReplace.index = index;
		roguePropReplace.swuid = swuid;
		roguePropReplace.newItemId = newItemId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueReplace, roguePropReplace);
		Singleton<EventManager>.instance.ReleaseEvt(roguePropReplace);
	}

	private void RefreshPriceColor()
	{
		if (!_priceColorCached)
		{
			_priceNormalColor = TextPrice.color;
			_priceNormalGradient = TextPrice.colorGradient;
			_priceNormalGradientEnabled = TextPrice.enableVertexGradient;
			_priceTextColorComp = TextPrice.GetComponent<ActBtnTextColorComp>();
			_priceColorCached = true;
		}
		bool flag = _rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin();
		TextPrice.color = (flag ? RoguePriceColor.LackPriceColor : _priceNormalColor);
		TextPrice.enableVertexGradient = !flag && _priceNormalGradientEnabled;
		if (!flag)
		{
			TextPrice.colorGradient = _priceNormalGradient;
		}
		if (_priceTextColorComp != null)
		{
			_priceTextColorComp.enabled = !flag;
		}
	}

	private void Reset()
	{
	}

	public void OnGet()
	{
		if (Model<RogueNewModel>.Interface.IsInDiscards(_rogueElement.id))
		{
			Model<RogueNewModel>.Interface.SendRoguePickUpItem(_rogueElement.id, isReplace: false, 0, (RoguePickUpItemAck ack) =>
			{
				RogueBuyItem rogueBuyItem = new RogueBuyItem
				{
					id = _rogueElement.id,
					swuid = stateWorldAssetUid
				};
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueBuyItem, rogueBuyItem);
				Singleton<EventManager>.instance.ReleaseEvt(rogueBuyItem);
			});
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueBuyItem(_rogueElement.id, (RogueBuyItemAck ack) =>
			{
				RogueBuyItem rogueBuyItem = new RogueBuyItem
				{
					id = _rogueElement.id,
					swuid = stateWorldAssetUid
				};
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueBuyItem, rogueBuyItem);
				Singleton<EventManager>.instance.ReleaseEvt(rogueBuyItem);
			});
		}
	}

	public void OnBuy()
	{
		if (_rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin())
		{
			GameUtility.OpenToolTip(81);
		}
		else if (_isreplace)
		{
			OnReplace();
		}
		else
		{
			OnGet();
		}
	}

	public void Init(RogueElement element, bool isReplace, int _stateWorldAssetUid)
	{
		_rogueElement = element;
		_isreplace = isReplace;
		stateWorldAssetUid = _stateWorldAssetUid;
		_isbuy = Model<RogueNewModel>.Interface.GetIsBuyByRogueItemId(element.id);
		if (isReplace)
		{
			RogueElement data = CoreUtils.GetData(Model<RogueNewModel>.Interface.GetRogueBagByType(1)[0].RogueItem.ItemId, RuntimeConfigs.data.rogueElements);
			ReplaceHudBloodbootleItem.Init(element, isNow: false);
			CurrentHudBloodbootleItem.Init(data, isReplace);
		}
		else
		{
			CurrentHudBloodbootleItem.Init(element, isReplace);
		}
		if (_isbuy)
		{
			TextPrice.text = _rogueElement.shopPrice.FastToString();
			RefreshPriceColor();
		}
		CurrentHudBloodbootleItem.gameObject.SetActive(value: true);
		ReplaceHudBloodbootleItem.gameObject.SetActive(isReplace);
		BtnBuyObject.gameObject.SetActive(_isbuy);
		BtnReplace.gameObject.SetActive(!_isbuy & isReplace);
		BtnGet.gameObject.SetActive(!_isbuy && !isReplace);
	}

	private void Update()
	{
	}
}
