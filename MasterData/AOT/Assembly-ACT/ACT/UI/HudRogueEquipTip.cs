using System.Collections.Generic;
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
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class HudRogueEquipTip : RogueSubComponent<HudRogueEquipTipSubController>
{
	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextDes;

	public Image ImageQua;

	public BImage ItemIcon;

	public Transform TfRogueInfoInScriptionIconItem;

	public GameObject RogueInfoInScriptionIconPrefab;

	public GameObject BtnBuyObject;

	public ActButton BtnBuy;

	public TextMeshProUGUI TextPrice;

	public ActButton BtnGet;

	public ActButton BtnReplace;

	public ActButton BtnShowInScriptionDetails;

	public HudRogueSingleInscriptionInfo SingleInscriptionInfo;

	public HudRogueTwoInscriptionInfo SecondInscriptionInfo;

	public BetterAnimation betterAnimation;

	private RogueElement _rogueElement;

	private RogueItem _rogueItem;

	private ImageAssetStation roguestation;

	private bool showDetails;

	private int stateWorldAssetUid;

	public List<Sprite> Qualitys = new List<Sprite>();

	private bool _isbuy;

	private bool _isreplace;

	private Color _priceNormalColor;

	private VertexGradient _priceNormalGradient;

	private bool _priceNormalGradientEnabled;

	private ActBtnTextColorComp _priceTextColorComp;

	private bool _priceColorCached;

	private void Start()
	{
		Reset();
		BtnBuy.SetBtnClick(OnBuy);
		BtnGet.SetBtnClick(OnGet);
		BtnReplace.SetBtnClick(OnReplace);
		BtnShowInScriptionDetails.SetBtnClick(OnShowBtnShowInScriptionDetails);
	}

	private void Reset()
	{
		showDetails = false;
		SingleInscriptionInfo.gameObject.SetActive(value: false);
		SecondInscriptionInfo.gameObject.SetActive(value: false);
	}

	public void Init(RogueElement element, bool isreplace, int _stateWorldAssetUid)
	{
		_rogueElement = element;
		_isreplace = isreplace;
		stateWorldAssetUid = _stateWorldAssetUid;
		_isbuy = Model<RogueNewModel>.Interface.GetIsBuyByRogueItemId(element.id);
		_rogueItem = CoreUtils.GetData(element.id, RuntimeConfigs.data.rogueItems);
		roguestation = Model<RoGueModel>.Interface.rogueStation;
		if (_isbuy)
		{
			TextPrice.text = _rogueElement.shopPrice.FastToString();
			RefreshPriceColor();
		}
		BtnBuyObject.gameObject.SetActive(_isbuy);
		BtnReplace.gameObject.SetActive(!_isbuy & isreplace);
		BtnGet.gameObject.SetActive(!_isbuy && !isreplace);
		ImageQua.sprite = Qualitys[_rogueItem.rarity - 1];
		SetInfo();
		SetInscriptionInfo();
		SetInscriptionInfoDetails();
		Reset();
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

	private void SetInfo()
	{
		TextName.StringReference.TableEntryReference = _rogueElement.name;
		TextDes.StringReference.TableEntryReference = _rogueElement.description;
		roguestation.LoadImage(188, _rogueElement.iconAddress, ItemIcon);
	}

	private void SetInscriptionInfo()
	{
		if (TfRogueInfoInScriptionIconItem.childCount > 0)
		{
			TfRogueInfoInScriptionIconItem.DestroyChildren();
		}
		for (int i = 0; i < _rogueItem.inscriptionIds.Length; i++)
		{
			UIUtility.AddWidget<RogueInfoInScriptionIconItem>(TfRogueInfoInScriptionIconItem, RogueInfoInScriptionIconPrefab).Init(_rogueItem.inscriptionIds[i], roguestation, needLevel: true);
		}
	}

	private void SetInscriptionInfoDetails()
	{
		if (_rogueItem.inscriptionIds.Length > 1)
		{
			SecondInscriptionInfo.Init(_rogueItem.inscriptionIds);
		}
		else
		{
			SingleInscriptionInfo.Init(_rogueItem.inscriptionIds[0]);
		}
	}

	private void Update()
	{
	}

	public void OnBuy()
	{
		if (_rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin())
		{
			GameUtility.OpenToolTip(2736);
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

	public void OnGet()
	{
		if (Model<RogueNewModel>.Interface.IsInDiscards(_rogueItem.id))
		{
			Model<RogueNewModel>.Interface.SendRoguePickUpItem(_rogueItem.id, isReplace: false, 0, (RoguePickUpItemAck ack) =>
			{
				RogueBuyItem rogueBuyItem = new RogueBuyItem
				{
					id = _rogueItem.id,
					swuid = stateWorldAssetUid
				};
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueBuyItem, rogueBuyItem);
				Singleton<EventManager>.instance.ReleaseEvt(rogueBuyItem);
			});
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueBuyItem(_rogueItem.id, (RogueBuyItemAck ack) =>
			{
				RogueBuyItem rogueBuyItem = new RogueBuyItem
				{
					id = _rogueItem.id,
					swuid = stateWorldAssetUid
				};
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueBuyItem, rogueBuyItem);
				Singleton<EventManager>.instance.ReleaseEvt(rogueBuyItem);
			});
		}
	}

	public void OnReplace()
	{
		RogueReplacementItemViewData rogueReplacementItemViewData = new RogueReplacementItemViewData();
		rogueReplacementItemViewData.swuid = stateWorldAssetUid;
		rogueReplacementItemViewData.newItemId = _rogueItem.id;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUEREPLACEMENTITEM, rogueReplacementItemViewData);
	}

	private void OnShowBtnShowInScriptionDetails()
	{
		if (!showDetails)
		{
			SecondInscriptionInfo.gameObject.SetActive(_rogueItem.inscriptionIds.Length > 1);
			SingleInscriptionInfo.gameObject.SetActive(_rogueItem.inscriptionIds.Length == 1);
		}
		else
		{
			SecondInscriptionInfo.gameObject.SetActive(value: false);
			SingleInscriptionInfo.gameObject.SetActive(value: false);
		}
		showDetails = !showDetails;
	}
}
