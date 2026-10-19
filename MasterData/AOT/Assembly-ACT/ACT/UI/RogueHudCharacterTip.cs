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

namespace ACT.UI;

public class RogueHudCharacterTip : RogueSubComponent<RogueHudCharacterTipSubController>
{
	public BetterAnimation betterAnimation;

	public BetterAnimation GoskillInfobetterAnimation;

	public BImage ImageIcon;

	public LocalizeStringEvent TextName;

	public ActButton BtnDetails;

	public ActButton BtnBuy;

	public GameObject BtnBuyObject;

	public TextMeshProUGUI TextPrice;

	public ActButton BtnGet;

	public TextMeshProUGUI CharacterLevel;

	public LocalizeStringEvent SkillGroupTextName;

	public RogueCharacterSkillInfo GoskillInfo;

	public TextMeshProUGUI TextCd;

	public Transform TfDesc;

	public GameObject SkillDesc;

	private RogueElement _rogueElement;

	private ImageAssetStation roguestation;

	private bool _isbuy;

	private Color _priceNormalColor;

	private VertexGradient _priceNormalGradient;

	private bool _priceNormalGradientEnabled;

	private ActBtnTextColorComp _priceTextColorComp;

	private bool _priceColorCached;

	private int stateWorldAssetUid;

	private void Start()
	{
		Reset();
		BtnBuy.SetBtnClick(OnBuy);
		BtnGet.SetBtnClick(OnGet);
		BtnDetails.SetBtnClick(OnDetails);
	}

	private void Reset()
	{
	}

	public void OnBuy()
	{
		if (_rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin())
		{
			GameUtility.OpenToolTip(81);
		}
		else
		{
			OnGet();
		}
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

	public void OnDetails()
	{
		SetGoskillInfoActive(!GoskillInfo.gameObject.activeSelf);
	}

	private void SetGoskillInfoActive(bool active)
	{
		GoskillInfo.gameObject.SetActive(active);
		if (!active)
		{
			return;
		}
		if (GoskillInfobetterAnimation == null)
		{
			Debug.LogWarning("RogueHudCharacterTip 技能详情动画组件未配置", this);
			return;
		}
		AnimationBuilder sequence = GoskillInfobetterAnimation.GetSequence("Show");
		if (sequence == null)
		{
			Debug.LogWarning("RogueHudCharacterTip 技能详情 Show 动画不可用，请检查 Legacy 配置", this);
		}
		else
		{
			sequence.Play();
		}
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

	public void Init(RogueElement element, int _stateWorldAssetUid)
	{
		_rogueElement = element;
		SetGoskillInfoActive(active: false);
		_isbuy = Model<RogueNewModel>.Interface.GetIsBuyByRogueItemId(element.id);
		stateWorldAssetUid = _stateWorldAssetUid;
		roguestation = Model<RoGueModel>.Interface.rogueStation;
		roguestation.LoadImage(188, element.iconAddress, ImageIcon);
		TextName.StringReference.TableEntryReference = element.name;
		RogueAssistCharacter data = CoreUtils.GetData(element.id, RuntimeConfigs.data.rogueAssistCharacters);
		TextMeshProUGUI characterLevel = CharacterLevel;
		string localizeString = LocalizationUtility.GetLocalizeString("Common", 2492);
		int tier = data.tier;
		characterLevel.SetText(localizeString + tier);
		if (_isbuy)
		{
			TextPrice.SetText(_rogueElement.shopPrice.FastToString());
			RefreshPriceColor();
		}
		SkillGroupData data2 = CoreUtils.GetData(data.skID, RuntimeConfigs.data.skillGroupDatas);
		if (data2 != null)
		{
			SkillGroupTextName.SetTable(LocalizeTable.ShortCommon);
			SkillGroupTextName.StringReference.TableEntryReference = data2.skillSetLocal;
		}
		BtnGet.gameObject.SetActive(!_isbuy);
		BtnBuyObject.SetActive(_isbuy);
		GoskillInfo.SetDescription(data2.id, data);
	}
}
