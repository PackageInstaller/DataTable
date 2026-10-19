using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.Model.PowerModel;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CharacterLevelUpPanel : LevelUpPanel<CharacterLevelUpPanelData>
{
	public CommonCoinComponent costRoleExp;

	public CommonCoinComponent costCoin;

	public LocalizeStringEvent characterNameLocalize;

	public GameObject GoCostRoot;

	public GameObject GoUpgradeRoot;

	public LocalizeStringEvent needLevelUpText;

	public GameObject GoMaxText;

	[SerializeField]
	private LocalizeStringEvent upgradeBtnText;

	private ImageAssetStation _station;

	private int _characterId;

	private bool _canUpgrade;

	private bool _canExchangeMaterial;

	private List<Item> exps = new List<Item>
	{
		new Item()
	};

	public PlayerAttribute RoleExpItemId => costRoleExp.itemId;

	public PlayerAttribute CoinItemId => costCoin.itemId;

	public override void Init(LevelUpPanelData data)
	{
		_station = data._station;
		base.Init(data);
		EntityData data2 = CoreUtils.GetData(_panelData.CharacterId, RuntimeConfigs.data.entityDatas);
		characterNameLocalize.StringReference.TableEntryReference = data2.nameLocal;
		SetPanel();
		OnAddLevelChange(_selectLevel - _panelData.CurLevel);
	}

	private void SetPanel()
	{
		GoMaxText.SetActive(_panelData.CurLevel == _panelData.FinallyMaxLevel);
		GoUpgradeRoot.SetActive(_panelData.CurLevel < _panelData.MaxLevel);
		GoCostRoot.SetActive(_panelData.CurLevel < _panelData.MaxLevel);
		bool flag = _panelData.CurLevel == _panelData.MaxLevel && !GoMaxText.gameObject.activeSelf;
		if (flag)
		{
			needLevelUpText.StringReference.TableEntryReference = 41000011L;
			needLevelUpText.StringReference.GetVariable<string>("0").Value = (SystemUnlockManager.playerLevel + 1).ToString();
		}
		needLevelUpText.gameObject.SetActive(flag);
	}

	protected override void InitPanelData(LevelUpPanelData data)
	{
		base.InitPanelData(data);
		_characterId = _panelData.CharacterId;
	}

	protected override float GetCurPropertyVal(Properties properties)
	{
		G.localPlayer.GetBagCharacter(_panelData.CharacterId);
		float porpertyBaseValue = GetPorpertyBaseValue(_panelData.CharacterId, properties.property, 1);
		float porpertyBaseValue2 = GetPorpertyBaseValue(_panelData.CharacterId, properties.property, 2);
		return porpertyBaseValue + (float)(_panelData.CurLevel - 1) * porpertyBaseValue2;
	}

	private float GetPorpertyBaseValue(int characterid, int propertyid, int type)
	{
		EntityCharacterData data = CoreUtils.GetData(_panelData.CharacterId, RuntimeConfigs.data.entityCharacterDatas);
		float result = 0f;
		if (data == null)
		{
			return result;
		}
		List<Properties> list = ((type == 1) ? data.characterPorpertyBase : data.characterPorpertyAdd);
		for (int i = 0; i < list.Count; i++)
		{
			if (propertyid == list[i].property)
			{
				result = list[i].value;
			}
		}
		return result;
	}

	protected override float GetAddPropertyVal(Properties properties, int addLevel)
	{
		return (float)addLevel * properties.value;
	}

	private static int GetCoinCount(int expCount)
	{
		return Mathf.FloorToInt((float)expCount / RuntimeConfigs.data.game.expToCoinData / 10f + 0.5f) * 10;
	}

	protected override void OnAddLevelChange(int addVal)
	{
		base.OnAddLevelChange(addVal);
		TryGetUpgradeCost(out var expCount, out var coinCount);
		costRoleExp.Station = _station;
		costCoin.Station = _station;
		costRoleExp?.Init(expCount);
		costCoin?.Init(coinCount);
		RefreshUpgradeButtonState(expCount, coinCount);
	}

	private bool TryGetUpgradeCost(out int expCount, out int coinCount)
	{
		expCount = 0;
		coinCount = 0;
		if (_panelData == null || _panelData.ReachMax)
		{
			return false;
		}
		Character bagCharacter = G.localPlayer.GetBagCharacter(_characterId);
		if (bagCharacter == null || _selectLevel <= bagCharacter.Level || _selectLevel > _panelData.MaxLevel)
		{
			return false;
		}
		int xpTotal = RuntimeConfigs.data.entityCharacterXPDatas[bagCharacter.GetCharacterXpId()].xpTotal;
		int xpTotal2 = RuntimeConfigs.data.entityCharacterXPDatas[bagCharacter.GetCharacterXpId(_selectLevel)].xpTotal;
		expCount = xpTotal2 - xpTotal - bagCharacter.Exp;
		coinCount = GetCoinCount(expCount);
		return true;
	}

	private void RefreshUpgradeButtonState(int expCount, int coinCount)
	{
		bool flag = G.TryGetAttribute((int)costRoleExp.itemId) >= expCount;
		bool flag2 = G.TryGetAttribute((int)costCoin.itemId) >= coinCount;
		_canUpgrade = flag & flag2;
		_canExchangeMaterial = !_canUpgrade && TryGetQuickPowerExchangeItemViewData(out var _, out var _);
		bool flag3 = !_canUpgrade && _canExchangeMaterial;
		upgradeBtn.Interactable(_canUpgrade | flag3);
		if ((object)upgradeBtnText == null)
		{
			upgradeBtnText = upgradeBtn.GetComponentInChildren<LocalizeStringEvent>(includeInactive: true);
		}
		if (upgradeBtnText != null)
		{
			upgradeBtnText.SetTable(LocalizeTable.Common);
			upgradeBtnText.StringReference.TableEntryReference = (flag3 ? LocalizationCommonData.CommonString.ExchangeMaterial : LocalizationCommonData.CommonString.LevelUp);
		}
	}

	private bool TryGetQuickPowerExchangeItemViewData(out QuickPowerExchangeItemViewData viewData, out long totalPowerCost)
	{
		viewData = new QuickPowerExchangeItemViewData();
		totalPowerCost = 0L;
		if (!TryGetUpgradeCost(out var expCount, out var coinCount))
		{
			return false;
		}
		int itemId = (int)costCoin.itemId;
		int itemId2 = (int)costRoleExp.itemId;
		int num = (int)Math.Max(0L, coinCount - G.TryGetAttribute(itemId));
		if (num > 0)
		{
			if (!Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemId))
			{
				return false;
			}
			long requirePowerCount = Model<PowerModel>.Interface.GetRequirePowerCount(itemId, num);
			if (requirePowerCount <= 0)
			{
				return false;
			}
			viewData.NeedItemId = itemId;
			viewData.NeedItemCount = num;
			totalPowerCost = requirePowerCount;
			return true;
		}
		int num2 = (int)Math.Max(0L, expCount - G.TryGetAttribute(itemId2));
		if (num2 > 0)
		{
			if (!Model<PowerModel>.Interface.IsItemPowerExchangeUnlocked(itemId2))
			{
				return false;
			}
			long requirePowerCount2 = Model<PowerModel>.Interface.GetRequirePowerCount(itemId2, num2);
			if (requirePowerCount2 <= 0)
			{
				return false;
			}
			viewData.NeedItemId = itemId2;
			viewData.NeedItemCount = num2;
			totalPowerCost = requirePowerCount2;
		}
		return totalPowerCost > 0;
	}

	private void OpenQuickPowerExchangeItemView()
	{
		if (_canExchangeMaterial && TryGetQuickPowerExchangeItemViewData(out var viewData, out var _))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_QUICKPOWEREXCHANGEITEM, viewData);
		}
	}

	public void TriggerUpgrade()
	{
		Upgrade();
	}

	protected override void Upgrade()
	{
		if (!TryGetUpgradeCost(out var expCount, out var coinCount))
		{
			return;
		}
		if (G.TryGetAttribute((int)costRoleExp.itemId) < expCount || G.TryGetAttribute((int)costCoin.itemId) < coinCount)
		{
			OpenQuickPowerExchangeItemView();
			return;
		}
		int capturedCharacterId = _characterId;
		Character bagCharacter = G.localPlayer.GetBagCharacter(capturedCharacterId);
		int preLevel = bagCharacter.Level;
		if (bagCharacter.Level == _panelData.MaxLevel || bagCharacter.Level == _selectLevel)
		{
			return;
		}
		exps[0].Id = 1;
		exps[0].Count = expCount;
		G.service.CharacterLevelUp(capturedCharacterId, exps, (bool success) =>
		{
			if (success && _characterId == capturedCharacterId)
			{
				Character bagCharacter2 = G.localPlayer.GetBagCharacter(capturedCharacterId);
				OnUpgradeSuccess(preLevel, bagCharacter2.Level);
				SetPanel();
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Skill_Refresh, null);
			}
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.CharacterLevelUpClick);
	}
}
