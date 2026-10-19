using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BloodIBottleLevelUp : SubUIView<BottleLevelUpSubController>, IBottleSubPanelBase, ISubUIView, IBaseUIComponent
{
	protected int pageIndex = -1;

	protected BloodBottleView _parentView;

	protected ImageAssetStation _station;

	public LocalizeStringEvent bottleName;

	public BImage bottleIcon;

	public GameObject costRoot;

	public CommonCoinComponent haveCoin;

	public ItemUIComponentBase costItem;

	public CommonCoinComponent costCoin;

	public TextMeshProUGUI bottleSkillDes;

	public CommonNumberComponent levelComponent;

	public TextMeshProUGUI levelAddNum;

	public TextMeshProUGUI maxBtnLevelText;

	public GameObject maxLevelIocn;

	public GameObject alreadyMaxLevel;

	public ActButton levelUpBtn;

	public OperateBtnPrompt levelUpBtnPrompt;

	public ActButton osaMaxLevelBtn;

	public GameObject maxLeftArrow;

	public GameObject maxRightArrow;

	public ActButton openBottleDetail;

	public Image qualitityBoard;

	public Color[] qualitityBoardColors;

	public BottleProperty healProperty;

	public BottleProperty useCountProperty;

	public BottleProperty slotProperty;

	private StringBuilder _sb;

	private bool canUpgrade;

	private int _preLevel;

	private int costEnoughLevel;

	protected BloodBottleHandler _handler => Singleton<BloodBottleHandler>.instance;

	protected BloodBottleModel _model => Model<BloodBottleModel>.Interface;

	protected BloodBottleBuffHandler _buffHandler => Singleton<BloodBottleBuffHandler>.instance;

	public void Init()
	{
		pageIndex = 2;
		_parentView = GetComponentInParent<BloodBottleView>();
		if (_parentView != null)
		{
			_station = _parentView.Station;
		}
		_sb = new StringBuilder();
		haveCoin.Station = _station;
	}

	public void Refresh()
	{
		gameObject.SetActive(value: true);
		FocusIn();
		if (_parentView != null && _parentView.animFinish)
		{
			_parentView.animFinish = false;
			try
			{
				_parentView.betterAnimation?.GetSequence("LevelUpShow").OnComplete((AnimationBuilder _) =>
				{
					_parentView.animFinish = true;
				}).Play();
			}
			catch (Exception value)
			{
				_parentView.animFinish = true;
				Console.WriteLine(value);
				throw;
			}
		}
		_preLevel = ((_model.curOperationBottle.curLevel + 1 >= _model.curOperationBottle.maxLevel) ? _model.curOperationBottle.maxLevel : (_model.curOperationBottle.curLevel + 1));
		ItemData data = CoreUtils.GetData(_model.curOperationBottle.id, RuntimeConfigs.data.itemDatas);
		bottleName.StringReference.TableEntryReference = data.nameLocal;
		_station.LoadItemIconAsync(data.iconAddress, bottleIcon).Forget();
		RefreshCurLevelDisPlay(_preLevel);
		qualitityBoard.color = qualitityBoardColors[data.quality - 1];
		levelUpBtn.SetBtnClick(() =>
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleClickLevelUp);
			OnLevelUp();
		});
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleViewSelectOneAndGoToLevelUp);
	}

	private void RefreshCurLevelDisPlay(int preLevel)
	{
		levelAddNum.gameObject.SetActive(_model.curOperationBottle.curLevel < _model.curOperationBottle.maxLevel);
		if (_model.curOperationBottle.curLevel < _model.curOperationBottle.maxLevel)
		{
			_sb.Clear();
			_sb.Append("+").Append(preLevel - _model.curOperationBottle.curLevel);
			levelAddNum.SetText(_sb);
		}
		maxLevelIocn.SetActive(_model.curOperationBottle.curLevel >= _model.curOperationBottle.maxLevel);
		levelComponent.UpdateNumber(_model.curOperationBottle.curLevel, _model.curOperationBottle.maxLevel);
		bottleSkillDes.SetText(_buffHandler.GetSpecifyLevelBottleSkillDes(_model.curOperationBottle, _sb, preLevel, detailDesc: true));
		RefreshProperty(_model.curOperationBottle, preLevel);
		canUpgrade = UpdateLevelUpSpendItem(_model.curOperationBottle, preLevel);
		levelUpBtn.Interactable(canUpgrade);
		levelUpBtnPrompt?.SetVisible(canUpgrade);
	}

	private void UpdateMaxLevelArrow(int selectedLevel)
	{
		if (osaMaxLevelBtn.gameObject.activeInHierarchy)
		{
			if ((selectedLevel == _model.curOperationBottle.maxLevel || selectedLevel == costEnoughLevel) && costEnoughLevel != 0 && costEnoughLevel >= _model.curOperationBottle.maxLevel)
			{
				maxLeftArrow.SetActive(value: false);
				maxRightArrow.SetActive(value: false);
			}
			else if (selectedLevel < costEnoughLevel)
			{
				maxLeftArrow.SetActive(value: false);
				maxRightArrow.SetActive(value: true);
			}
			else
			{
				maxLeftArrow.SetActive(value: true);
				maxRightArrow.SetActive(value: false);
			}
		}
	}

	private void InitLevelMaxBtnState()
	{
		if (costEnoughLevel <= _model.curOperationBottle.maxLevel && costEnoughLevel != 0)
		{
			osaMaxLevelBtn.gameObject.SetActive(value: true);
			maxBtnLevelText.SetText(costEnoughLevel.FastToString());
		}
		else
		{
			osaMaxLevelBtn.gameObject.SetActive(value: false);
		}
	}

	private int GetCurrentCostCanUpgradeLevel()
	{
		int[][] levelUpItem = CoreUtils.GetData(_model.curOperationBottle.uid, RuntimeConfigs.data.potionDatas).levelUpItem;
		int[][] levelUpCost = CoreUtils.GetData(_model.curOperationBottle.uid, RuntimeConfigs.data.potionDatas).levelUpCost;
		Dictionary<int, int> dictionary = DictionaryPool<int, int>.Get();
		Array values = Enum.GetValues(typeof(PlayerAttribute));
		for (int i = _model.curOperationBottle.curLevel; i < _model.curOperationBottle.maxLevel; i++)
		{
			int num = i - 1;
			for (int j = 0; j < levelUpItem[num].Length; j++)
			{
				int key = levelUpItem[num][j];
				int num2 = levelUpCost[num][j];
				dictionary[key] = dictionary.GetValueOrDefault(key) + num2;
			}
			foreach (KeyValuePair<int, int> item in dictionary)
			{
				bool flag = false;
				foreach (object item2 in values)
				{
					if (item.Key == (int)item2)
					{
						flag = true;
						break;
					}
				}
				if ((flag ? G.TryGetAttribute(item.Key) : G.localPlayer.Inventory.GetItemCount(item.Key)) < item.Value)
				{
					DictionaryPool<int, int>.Release(dictionary);
					return i;
				}
			}
		}
		DictionaryPool<int, int>.Release(dictionary);
		return _model.curOperationBottle.maxLevel;
	}

	private void RefreshProperty(BloodBottleData bottle, int preLevel)
	{
		(float, float) bottleHealSkillLevelData = _model.GetBottleHealSkillLevelData(bottle, bottle.curLevel);
		(float, float) bottleHealSkillLevelData2 = _model.GetBottleHealSkillLevelData(bottle, preLevel);
		int bootleUseCount = _model.GetBootleUseCount(bottle, bottle.curLevel);
		int bootleUseCount2 = _model.GetBootleUseCount(bottle, preLevel);
		int bottleSlotCount = _model.GetBottleSlotCount(bottle, bottle.curLevel);
		int bottleSlotCount2 = _model.GetBottleSlotCount(bottle, preLevel);
		if (bottle.curLevel < bottle.maxLevel)
		{
			healProperty.UpdateHealProperty(bottleHealSkillLevelData, bottleHealSkillLevelData2, _sb);
			useCountProperty.UpdateUseCountProperty(bootleUseCount, bootleUseCount2);
			slotProperty.UpdateSlotProperty(bottleSlotCount, bottleSlotCount2);
		}
		else
		{
			healProperty.UpdateMaxLevelHealProperty(bottleHealSkillLevelData2, _sb);
			useCountProperty.UpdateMaxLevelUseCountProperty(bootleUseCount2);
			slotProperty.UpdateMaxLevelSlotProperty(bottleSlotCount2);
		}
	}

	private bool UpdateLevelUpSpendItem(BloodBottleData bottle, int targetLevel)
	{
		alreadyMaxLevel.SetActive(bottle.curLevel == bottle.maxLevel);
		Dictionary<int, int> dictionary = DictionaryPool<int, int>.Get();
		List<ItemKv> list = ListPool<ItemKv>.Get();
		UpdateCostAndSpend(bottle, targetLevel, dictionary, list);
		if (bottle.curLevel == bottle.maxLevel)
		{
			costRoot.SetActive(value: false);
			return false;
		}
		costRoot.SetActive(value: true);
		bool result = GameUtility.ItemsIsEnough(list);
		ListPool<ItemKv>.Release(list);
		DictionaryPool<int, int>.Release(dictionary);
		return result;
	}

	private void UpdateCostAndSpend(BloodBottleData bottle, int targetLevel, Dictionary<int, int> costs, List<ItemKv> itemKvs)
	{
		int[][] levelUpItem = CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas).levelUpItem;
		int[][] levelUpCost = CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas).levelUpCost;
		for (int i = ((bottle.curLevel == bottle.maxLevel) ? (bottle.curLevel - 2) : (bottle.curLevel - 1)); i <= targetLevel - 2; i++)
		{
			for (int j = 0; j < levelUpItem[i].Length; j++)
			{
				int key = levelUpItem[i][j];
				int num = levelUpCost[i][j];
				if (!costs.ContainsKey(key))
				{
					costs.Add(key, num);
				}
				else
				{
					costs[key] += num;
				}
			}
		}
		itemKvs.Clear();
		foreach (KeyValuePair<int, int> cost in costs)
		{
			itemKvs.Add(new ItemKv(cost.Key, cost.Value));
		}
		if (itemKvs.Count != 0)
		{
			costItem.gameObject.SetActive(itemKvs.Count >= 1);
			haveCoin.InitData(itemKvs[0].id, isBagItem: false);
			costCoin.Init(itemKvs[0].count);
			if (itemKvs.Count >= 1)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKvs[1].id, itemKvs[1].count);
				int itemCount = G.localPlayer.Inventory.GetItemCount(itemKvs[1].id);
				costItem.SetData(item, itemCount, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.Both);
				costItem.UpdatePerformance();
			}
		}
	}

	private void OnLevelUp()
	{
		_handler.BottleLevelUp(_model.curOperationBottle.uid, _preLevel, () =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Upgrade");
			_model.curOperationBottle.SetCurLevel(_preLevel);
			_model.curOperationBottle.RefreshWineMatListByCurLevel();
			_preLevel = ((_model.curOperationBottle.curLevel >= _model.curOperationBottle.maxLevel) ? _model.curOperationBottle.maxLevel : (_model.curOperationBottle.curLevel + 1));
			RefreshCurLevelDisPlay(_preLevel);
		});
	}

	public void UnInit()
	{
		levelUpBtn.OnLongPressUpdate.RemoveListener(OnLevelUp);
		costItem.Release();
		if (_parentView != null)
		{
			_parentView.lastPageIndex = pageIndex;
			if (_parentView.animFinish)
			{
				_parentView.animFinish = false;
				_parentView.betterAnimation?.GetSequence("LevelUpHide").OnComplete((AnimationBuilder _) =>
				{
					_parentView.animFinish = true;
					FocusOut();
					gameObject.SetActive(value: false);
				}).Play();
				return;
			}
		}
		FocusOut();
		gameObject.SetActive(value: false);
	}

	public void OnParentViewClose()
	{
		Station.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
	}
}
