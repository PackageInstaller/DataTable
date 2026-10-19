using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using Pb;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class RogueHudCharacterReplaceTip : RogueSubComponent<RogueHudCharacterReplaceTipSubController>
{
	public GameObject GoDetails;

	public ViewControlLayer DetailLayer;

	public ActButton BtnDetails;

	public RogueHudCharacterReplaceItem FirstCharacter;

	public ActButton BtnReplaceFirst;

	public ActButton BtnFirstReplaceAndBuy;

	public GameObject BtnFirstReplaceAndBuyGroup;

	public TextMeshProUGUI TxtFirstPrice;

	public RogueCharacterSkillInfo FirstCharacterSkillInfo;

	public RogueHudCharacterReplaceItem SecondCharacter;

	public ActButton BtnReplaceSecond;

	public ActButton BtnSecondReplaceAndBuy;

	public GameObject BtnSecondReplaceAndBuyGroup;

	public TextMeshProUGUI TxtSecondPrice;

	public RogueCharacterSkillInfo SecondCharacterSkillInfo;

	public BetterAnimation betterAnimation;

	public BImage NewImageIcon;

	public RogueCharacterSkillInfo NewCharacterSkillInfo;

	public LocalizeStringEvent TextNewName;

	public TextMeshProUGUI TextNewCharacterLevel;

	public LocalizeStringEvent TextSkilGroupName;

	private bool _isBuy;

	private int stateWorldAssetUid;

	private RogueElement _rogueElement;

	private ImageAssetStation roguestation;

	private List<RogueBagItemData> characterlist;

	private RogueBagItemData _characterFirstData;

	private RogueBagItemData _characterSecondData;

	private Color _firstPriceNormalColor;

	private Color _secondPriceNormalColor;

	private VertexGradient _firstPriceNormalGradient;

	private VertexGradient _secondPriceNormalGradient;

	private bool _firstPriceNormalGradientEnabled;

	private bool _secondPriceNormalGradientEnabled;

	private ActBtnTextColorComp _firstPriceTextColorComp;

	private ActBtnTextColorComp _secondPriceTextColorComp;

	private bool _priceColorCached;

	private void Start()
	{
		Reset();
		BtnFirstReplaceAndBuy.SetBtnClick(() =>
		{
			OnBuy(0);
		});
		BtnSecondReplaceAndBuy.SetBtnClick(() =>
		{
			OnBuy(1);
		});
		BtnReplaceFirst.SetBtnClick(() =>
		{
			OnReplace(0);
		});
		BtnReplaceSecond.SetBtnClick(() =>
		{
			OnReplace(1);
		});
		BtnDetails.SetBtnClick(OnDetails);
	}

	private void Reset()
	{
		GoDetails.SetActive(value: false);
	}

	public void OnDetails()
	{
		SetGoskillInfoActive(!GoDetails.gameObject.activeSelf);
	}

	private void SetGoskillInfoActive(bool active)
	{
		if (active)
		{
			betterAnimation.GetSequence("DetailsShow").Play();
		}
		else
		{
			betterAnimation.GetSequence("DetailsHide").Play();
		}
		GoDetails.gameObject.SetActive(active);
	}

	public void Init(RogueElement element, int _stateWorldAssetUid)
	{
		_rogueElement = element;
		SetGoskillInfoActive(active: false);
		_isBuy = Model<RogueNewModel>.Interface.GetIsBuyByRogueItemId(element.id);
		stateWorldAssetUid = _stateWorldAssetUid;
		roguestation = Model<RoGueModel>.Interface.rogueStation;
		roguestation.LoadImage(188, element.iconAddress, NewImageIcon);
		TextNewName.StringReference.TableEntryReference = element.name;
		RogueAssistCharacter data = CoreUtils.GetData(element.id, RuntimeConfigs.data.rogueAssistCharacters);
		TextMeshProUGUI textNewCharacterLevel = TextNewCharacterLevel;
		string localizeString = LocalizationUtility.GetLocalizeString("Common", 2492);
		int tier = data.tier;
		textNewCharacterLevel.SetText(localizeString + tier);
		SkillGroupData data2 = CoreUtils.GetData(data.skID, RuntimeConfigs.data.skillGroupDatas);
		if (data2 != null)
		{
			TextSkilGroupName.SetTable(LocalizeTable.ShortCommon);
			TextSkilGroupName.StringReference.TableEntryReference = data2.skillSetLocal;
		}
		characterlist = Model<RogueNewModel>.Interface.GetRogueBagByType(2);
		_characterFirstData = GetRogueCharacterDataByPosIndex(0);
		_characterSecondData = GetRogueCharacterDataByPosIndex(1);
		FirstCharacter.Init(_characterFirstData);
		SecondCharacter.Init(_characterSecondData);
		RefreshBtnState();
		SetSetDescription();
	}

	private void SetSetDescription()
	{
		RogueAssistCharacter data = CoreUtils.GetData(_characterFirstData.RogueItem.ItemId, RuntimeConfigs.data.rogueAssistCharacters);
		SkillGroupData data2 = CoreUtils.GetData(data.skID, RuntimeConfigs.data.skillGroupDatas);
		if (data2 != null)
		{
			FirstCharacterSkillInfo.SetDescription(data2.id, data);
		}
		RogueAssistCharacter data3 = CoreUtils.GetData(_characterSecondData.RogueItem.ItemId, RuntimeConfigs.data.rogueAssistCharacters);
		SkillGroupData data4 = CoreUtils.GetData(data3.skID, RuntimeConfigs.data.skillGroupDatas);
		if (data4 != null)
		{
			SecondCharacterSkillInfo.SetDescription(data4.id, data3);
		}
		RogueAssistCharacter data5 = CoreUtils.GetData(_rogueElement.id, RuntimeConfigs.data.rogueAssistCharacters);
		SkillGroupData data6 = CoreUtils.GetData(data5.skID, RuntimeConfigs.data.skillGroupDatas);
		if (data6 != null)
		{
			NewCharacterSkillInfo.SetDescription(data6.id, data5);
		}
	}

	private void RefreshBtnState()
	{
		if (_isBuy)
		{
			TextMeshProUGUI txtFirstPrice = TxtFirstPrice;
			int shopPrice = _rogueElement.shopPrice;
			txtFirstPrice.SetText(shopPrice.ToString());
			TextMeshProUGUI txtSecondPrice = TxtSecondPrice;
			shopPrice = _rogueElement.shopPrice;
			txtSecondPrice.SetText(shopPrice.ToString());
			RefreshPriceColor();
		}
		BtnReplaceFirst.gameObject.SetActive(!_isBuy);
		BtnFirstReplaceAndBuyGroup.SetActive(_isBuy);
		BtnReplaceSecond.gameObject.SetActive(!_isBuy);
		BtnSecondReplaceAndBuyGroup.SetActive(_isBuy);
	}

	private void RefreshPriceColor()
	{
		if (!_priceColorCached)
		{
			_firstPriceNormalColor = TxtFirstPrice.color;
			_secondPriceNormalColor = TxtSecondPrice.color;
			_firstPriceNormalGradient = TxtFirstPrice.colorGradient;
			_secondPriceNormalGradient = TxtSecondPrice.colorGradient;
			_firstPriceNormalGradientEnabled = TxtFirstPrice.enableVertexGradient;
			_secondPriceNormalGradientEnabled = TxtSecondPrice.enableVertexGradient;
			_firstPriceTextColorComp = TxtFirstPrice.GetComponent<ActBtnTextColorComp>();
			_secondPriceTextColorComp = TxtSecondPrice.GetComponent<ActBtnTextColorComp>();
			_priceColorCached = true;
		}
		bool flag = _rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin();
		TxtFirstPrice.color = (flag ? RoguePriceColor.LackPriceColor : _firstPriceNormalColor);
		TxtSecondPrice.color = (flag ? RoguePriceColor.LackPriceColor : _secondPriceNormalColor);
		TxtFirstPrice.enableVertexGradient = !flag && _firstPriceNormalGradientEnabled;
		TxtSecondPrice.enableVertexGradient = !flag && _secondPriceNormalGradientEnabled;
		if (!flag)
		{
			TxtFirstPrice.colorGradient = _firstPriceNormalGradient;
			TxtSecondPrice.colorGradient = _secondPriceNormalGradient;
		}
		if (_firstPriceTextColorComp != null)
		{
			_firstPriceTextColorComp.enabled = !flag;
		}
		if (_secondPriceTextColorComp != null)
		{
			_secondPriceTextColorComp.enabled = !flag;
		}
	}

	private RogueBagItemData GetRogueCharacterDataByPosIndex(int PosIndex)
	{
		RogueBagItemData result = null;
		for (int i = 0; i < characterlist.Count; i++)
		{
			if (characterlist[i].RogueItem.Position == PosIndex)
			{
				result = characterlist[i];
			}
		}
		return result;
	}

	private void OnBuy(int posindex)
	{
		RogueBagItemData rogueBagItemData = ((posindex == 0) ? _characterFirstData : _characterSecondData);
		if (Model<RogueNewModel>.Interface.GetIsBuyByRogueItemId(rogueBagItemData.RogueItem.ItemId) && _rogueElement.shopPrice > Model<RogueNewModel>.Interface.GetRogueCoin())
		{
			GameUtility.OpenToolTip(81);
		}
		else
		{
			OnReplace(posindex);
		}
	}

	private void OnReplace(int posindex)
	{
		RogueBagItemData currentdata = ((posindex == 0) ? _characterFirstData : _characterSecondData);
		if (Model<RogueNewModel>.Interface.IsInDiscards(_rogueElement.id))
		{
			Model<RogueNewModel>.Interface.ReplaceRogueItem(currentdata.RogueItem.ItemId, _rogueElement.id);
			SendRoguePropReplace(currentdata.RogueItem.Position, stateWorldAssetUid, currentdata.RogueItem.ItemId);
		}
		else
		{
			Model<RogueNewModel>.Interface.SendRogueBuyItem(_rogueElement.id, (RogueBuyItemAck ack) =>
			{
				SendRoguePropReplace(currentdata.RogueItem.Position, stateWorldAssetUid, currentdata.RogueItem.ItemId);
			}, currentdata.RogueItem.ItemId, isReplace: true, currentdata.RogueItem.Position);
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
}
