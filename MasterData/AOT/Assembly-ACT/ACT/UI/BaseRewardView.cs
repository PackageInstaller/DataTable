using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.UI.InputController.RewardView;
using ACT.Utility;
using Bamboo.Collections;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Rendering;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class BaseRewardView : BaseUIView<RewardViewInputController>
{
	private sealed class DestinyOverflowMarker
	{
		public int CharacterId;

		public int Count;
	}

	[Header("UI组件")]
	public CommonScrollBagComponent scrollBag;

	public SortingGroup VFXSortingGroup;

	[Header("角色展示组件")]
	public AcquireCharacterShowComponent acquireCharacterShowComponent;

	[Header("点击空白处关闭文本提示")]
	public GameObject closeTipText;

	public GamePadTipsComp gamePadTipsComp;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private bool _isGamepadItemSelectMode;

	private bool _blockNextConfirmClose;

	[Header("滚动区域")]
	[FormerlySerializedAs("_viewPort")]
	[SerializeField]
	protected RectTransform _scrollView;

	[SerializeField]
	protected RectTransform _content;

	[SerializeField]
	protected RectTransform _template;

	protected List<AcquireCharacterShowData> _characterShowList;

	protected bool _hasCharacterToShow;

	protected Action _onCharacterShowComplete;

	private readonly Dictionary<ItemUnifierProxy, DestinyOverflowMarker> _destinyOverflowMarkers = new Dictionary<ItemUnifierProxy, DestinyOverflowMarker>();

	protected override void Init()
	{
		base.Init();
		_isGamepadItemSelectMode = false;
		_blockNextConfirmClose = false;
		ProcessRewardData();
		CheckAndShowCharacterRewards();
		InitGameTipsDic();
		OnInputModeChanged(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected virtual void ProcessRewardData()
	{
		_characterShowList = null;
		_hasCharacterToShow = false;
		ProcessRewardItems();
		if (_hasCharacterToShow)
		{
			_onCharacterShowComplete = () =>
			{
				_hasCharacterToShow = false;
				ShowItemRewards();
			};
		}
	}

	protected abstract void ProcessRewardItems();

	protected virtual void CheckAndShowCharacterRewards()
	{
		if (_hasCharacterToShow && _characterShowList != null)
		{
			AcquireCharacterShowConfig acquireCharacterShowConfig = new AcquireCharacterShowConfig
			{
				_listsNeedShow = _characterShowList,
				isNeedSettle = false,
				isNeedShowOpenAni = false,
				onAllShowComplete = () =>
				{
					_onCharacterShowComplete?.Invoke();
				}
			};
			acquireCharacterShowComponent.InitPanel(acquireCharacterShowConfig, Station);
		}
		else
		{
			ShowItemRewards();
		}
	}

	protected virtual void ShowItemRewards()
	{
		ConfigureScrollBag();
		RegisterItemShowHandler();
		scrollBag.ForceUpdatePerformance();
		Resize();
		SetVFXSortingLayer();
		PlayOpenAnimation();
		gameObject.SetActive(value: true);
	}

	protected virtual void ConfigureScrollBag()
	{
		if (scrollBag != null)
		{
			scrollBag.Station = Station;
			scrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		}
	}

	protected virtual void RegisterItemShowHandler()
	{
		if (scrollBag != null)
		{
			scrollBag.OnItemShow = null;
			CommonScrollBagComponent commonScrollBagComponent = scrollBag;
			commonScrollBagComponent.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemShow, new Action<ItemUIComponentBase>(HandleItemShow));
		}
	}

	protected virtual void HandleItemShow(ItemUIComponentBase component)
	{
		if (component?.ItemUnifier != null && _destinyOverflowMarkers.TryGetValue(component.ItemUnifier, out var value))
		{
			SetCharacterOverflowTransition(component, value.CharacterId, value.Count);
		}
	}

	protected List<ItemUnifierProxy> BuildRewardItemProxies(IList<UniversalItem> sourceItems)
	{
		_destinyOverflowMarkers.Clear();
		List<UniversalItem> sourceItems2 = RemoveSkinRewardItems(sourceItems);
		List<UniversalItem> sourceItems3 = NormalizeCharacterRewardCounts(sourceItems2);
		List<UniversalItem> sourceItems4 = BuildRewardDisplayItems(sourceItems3);
		List<UniversalItem> sourceItems5 = MergeRewardItems(sourceItems4);
		return CreateSortedRewardProxies(sourceItems5);
	}

	protected virtual List<UniversalItem> RemoveSkinRewardItems(IList<UniversalItem> sourceItems)
	{
		return sourceItems?.Where((UniversalItem item) => item == null || item.Type != UniversalItemType.UniversalItemSkin).ToList() ?? new List<UniversalItem>();
	}

	protected virtual List<UniversalItem> NormalizeCharacterRewardCounts(IList<UniversalItem> sourceItems)
	{
		List<UniversalItem> list = new List<UniversalItem>();
		if (sourceItems == null)
		{
			return list;
		}
		foreach (UniversalItem sourceItem in sourceItems)
		{
			if (sourceItem != null)
			{
				UniversalItem universalItem = sourceItem.Clone();
				if (universalItem.Type == UniversalItemType.UniversalItemCharacter && universalItem.Count <= 0)
				{
					universalItem.Count = 1;
				}
				list.Add(universalItem);
			}
		}
		return list;
	}

	protected virtual List<UniversalItem> BuildRewardDisplayItems(IList<UniversalItem> sourceItems)
	{
		List<UniversalItem> list = new List<UniversalItem>();
		foreach (UniversalItem sourceItem in sourceItems)
		{
			if (sourceItem == null)
			{
				continue;
			}
			if (sourceItem.Type != UniversalItemType.UniversalItemCharacter)
			{
				AddDisplayItem(list, sourceItem);
				foreach (UniversalItem extraItem in sourceItem.ExtraItems)
				{
					AddDisplayItem(list, extraItem);
				}
				continue;
			}
			if (sourceItem.IsNew)
			{
				AddDisplayItem(list, sourceItem);
				foreach (UniversalItem extraItem2 in sourceItem.ExtraItems)
				{
					AddDisplayItem(list, extraItem2);
				}
				continue;
			}
			if (!TryGetCharacterIdByItemId(sourceItem.Index, out var characterId) || Model<DestinyModel>.Interface?.characterDestinyCost == null || !Model<DestinyModel>.Interface.characterDestinyCost.TryGetValue(characterId, out var value))
			{
				Debug.LogError($"角色道具 {sourceItem.Index} 未找到对应的角色或命座配置，跳过该奖励。");
				continue;
			}
			foreach (UniversalItem extraItem3 in sourceItem.ExtraItems)
			{
				if (extraItem3 != null && extraItem3.Count > 0)
				{
					if (IsDestinyItem(extraItem3.Index))
					{
						AddDisplayItem(list, extraItem3);
					}
					else if (IsOverflowConversionItem(extraItem3.Index))
					{
						list.Add(new UniversalItem
						{
							Type = UniversalItemType.UniversalItemNormal,
							Index = value,
							Count = sourceItem.Count,
							Uid = -characterId,
							Tag = extraItem3.Tag
						});
					}
					else
					{
						AddDisplayItem(list, extraItem3);
					}
				}
			}
			if (sourceItem.ExtraItems.Count == 0)
			{
				list.Add(new UniversalItem
				{
					Type = UniversalItemType.UniversalItemNormal,
					Index = value,
					Count = sourceItem.Count,
					Tag = sourceItem.Tag
				});
			}
		}
		return list;
	}

	private static void AddDisplayItem(List<UniversalItem> displayItems, UniversalItem item)
	{
		if (item != null)
		{
			UniversalItem universalItem = item.Clone();
			if (universalItem.Type == UniversalItemType.UniversalItemCharacter && universalItem.Count <= 0)
			{
				universalItem.Count = 1;
			}
			displayItems.Add(universalItem);
		}
	}

	private static bool IsDestinyItem(int itemId)
	{
		ItemData data = ACT.Core.CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		return data.type == 21;
	}

	private static bool IsOverflowConversionItem(int itemId)
	{
		return itemId == RuntimeConfigs.data.game.gachaDrawRoleToken;
	}

	protected virtual List<UniversalItem> MergeRewardItems(IList<UniversalItem> sourceItems)
	{
		List<UniversalItem> list = new List<UniversalItem>();
		if (sourceItems == null)
		{
			return list;
		}
		foreach (UniversalItem item in sourceItems)
		{
			if (item != null)
			{
				UniversalItem universalItem = list.FirstOrDefault((UniversalItem current) => current.Index == item.Index && current.Tag == item.Tag && current.Uid < 0 == item.Uid < 0);
				if (universalItem == null)
				{
					list.Add(item.Clone());
				}
				else
				{
					universalItem.Count += item.Count;
				}
			}
		}
		return list;
	}

	protected virtual List<ItemUnifierProxy> CreateSortedRewardProxies(IList<UniversalItem> sourceItems)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (UniversalItem sourceItem in sourceItems)
		{
			if (sourceItem == null)
			{
				continue;
			}
			if (sourceItem.Count != 0)
			{
				AddRewardProxy(list, sourceItem);
			}
			else
			{
				if (sourceItem.ExtraItems == null)
				{
					continue;
				}
				foreach (UniversalItem extraItem in sourceItem.ExtraItems)
				{
					AddRewardProxy(list, extraItem);
				}
			}
		}
		list.Sort(SortUtility.SortItemUnifierProxy2);
		return list;
	}

	private void AddRewardProxy(List<ItemUnifierProxy> proxies, UniversalItem item)
	{
		if (item != null && item.Count > 0)
		{
			ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.Index, item.Count);
			itemUnifierProxy.RewardTag = item.Tag;
			if (item.Uid < 0)
			{
				int characterId = -item.Uid;
				_destinyOverflowMarkers[itemUnifierProxy] = new DestinyOverflowMarker
				{
					CharacterId = characterId,
					Count = item.Count
				};
			}
			proxies.Add(itemUnifierProxy);
		}
	}

	private static bool TryGetCharacterId(int destinyId, out int characterId)
	{
		BMap<int, int> bMap = Model<DestinyModel>.Interface?.characterDestinyCost;
		if (bMap == null)
		{
			characterId = 0;
			return false;
		}
		foreach (KeyValuePair<int, int> item in bMap)
		{
			if (item.Value == destinyId)
			{
				characterId = item.Key;
				return true;
			}
		}
		characterId = 0;
		return false;
	}

	private static bool TryGetCharacterIdByItemId(int characterItemId, out int characterId)
	{
		ItemData data = ACT.Core.CoreUtils.GetData(characterItemId, RuntimeConfigs.data.itemDatas);
		List<ItemKv> list = data?.canBeTransited;
		if (list == null || list.Count <= 0)
		{
			characterId = 0;
			return false;
		}
		characterId = data.canBeTransited[0].id;
		return characterId > 0;
	}

	private void SetCharacterOverflowTransition(ItemUIComponentBase component, int characterId, int overflowCount)
	{
		EntityCharacterData data = ACT.Core.CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		if (data != null)
		{
			int gachaDrawRoleToken = RuntimeConfigs.data.game.gachaDrawRoleToken;
			int num = 0;
			if (data.stars == 4)
			{
				num = RuntimeConfigs.data.game.gachaDraw4StarDestinedNum;
			}
			else if (data.stars >= 5)
			{
				num = RuntimeConfigs.data.game.gachaDraw5StarDestinedNum;
			}
			ItemUnifierProxy transiteItemUnifier = ItemUnifierProxy.ItemUnifierPool.Get<Item>(gachaDrawRoleToken, num * Math.Max(1, overflowCount));
			component.TransiteItemUnifier = transiteItemUnifier;
			component.PlayAnimation(1f, "Overflow");
		}
	}

	protected virtual void SetVFXSortingLayer()
	{
		if ((bool)VFXSortingGroup)
		{
			VFXSortingGroup.sortingLayerName = ContentCanvas.sortingLayerName;
		}
	}

	protected virtual void Resize()
	{
	}

	protected override void PlayOpenAnimation()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Reward");
		if (!_hasCharacterToShow && betterAnimation != null)
		{
			betterAnimation.GetSequence("RewardShow").Play().OnComplete((AnimationBuilder _) =>
			{
				SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
				OpenEffectFinishNew();
			});
		}
	}

	protected override void PlayCloseAnimation()
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("RewardHide").Play().OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			});
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	protected override void UnInit()
	{
		_destinyOverflowMarkers.Clear();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		base.UnInit();
	}

	private void SetGamePadTipsActive(bool active)
	{
		if (!(gamePadTipsComp == null))
		{
			if (active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				RefreshGamepadComp();
			}
			closeTipText.SetActive(!active);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	private void RefreshGamepadComp()
	{
		if (!(gamePadTipsComp == null))
		{
			if (actionDic.Count == 0)
			{
				InitGameTipsDic();
			}
			_tipsActions.Clear();
			gamePadTipsComp.ClearAllPrompts();
			if (_isGamepadItemSelectMode)
			{
				_tipsActions.Add(actionDic["LargeMapView/Select"]);
				_tipsActions.Add(actionDic["LargeMapView/Return"]);
			}
			else
			{
				_tipsActions.Add(actionDic["UI/Confirm"]);
				_tipsActions.Add(actionDic["UI/SelectItemCell"]);
			}
			gamePadTipsComp.RegisterInputActions(_tipsActions);
		}
	}

	private void InitGameTipsDic()
	{
		actionDic.Clear();
		actionDic.Add("UI/Confirm", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 13,
			localizeTable = "Common"
		});
		actionDic.Add("UI/SelectItemCell", new GamePadTipsAction
		{
			inputAction = "UI/SelectItemCell",
			localizeKey = 1642,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Select",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/Return", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Return",
			localizeKey = 606,
			localizeTable = "Common"
		});
	}

	public bool CanCloseByConfirm()
	{
		if (_isGamepadItemSelectMode)
		{
			return false;
		}
		if (_blockNextConfirmClose)
		{
			_blockNextConfirmClose = false;
			return false;
		}
		return true;
	}

	public bool IsGamepadItemSelectMode()
	{
		return _isGamepadItemSelectMode;
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (_isGamepadItemSelectMode)
		{
			switch (dir)
			{
			case MoveDirection.Up:
				MoveRewardSelectionVertical(-1);
				break;
			case MoveDirection.Down:
				MoveRewardSelectionVertical(1);
				break;
			case MoveDirection.Left:
				MoveRewardSelectionHorizontal(-1);
				break;
			case MoveDirection.Right:
				MoveRewardSelectionHorizontal(1);
				break;
			}
		}
	}

	public void OnClickStartBtn()
	{
		if (!_isGamepadItemSelectMode)
		{
			_isGamepadItemSelectMode = true;
			_blockNextConfirmClose = false;
			ClearRewardItemHighlightStates();
			scrollBag?.SelectedModels.Clear();
			RewardViewInputController controller = GetController();
			if (controller != null)
			{
				controller.ControllerType = RewardSubController.SelectItem;
			}
			RefreshGamepadComp();
		}
	}

	public void OnClickSelectABtn()
	{
		if (!_isGamepadItemSelectMode)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ItemUIComponentBase component = currentSelected.GetComponent<ItemUIComponentBase>();
			if (component?.ItemUnifier?.Source != null && !ItemUnifierProxy.Empty.Equals(component.ItemUnifier))
			{
				ItemUnifierProxy uiData = ItemUnifierProxy.ItemUnifierPool.Get<Item>(component.ItemUnifier.Id, G.localPlayer.Inventory.GetItemCount(component.ItemUnifier.Id));
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, uiData);
			}
		}
	}

	public void OnClickSelectBBtn()
	{
		if (_isGamepadItemSelectMode)
		{
			_isGamepadItemSelectMode = false;
			_blockNextConfirmClose = true;
			ClearRewardItemHighlightStates();
			scrollBag?.SelectedModels.Clear();
			EventSystemHelper.SetSelectedGameObject(null);
			RewardViewInputController controller = GetController();
			if (controller != null)
			{
				controller.ControllerType = RewardSubController.Main;
			}
			RefreshGamepadComp();
		}
	}

	private void MoveRewardSelectionHorizontal(int direction)
	{
		if (!TryGetCurrentRewardIndex(out var currentIndex, out var itemList))
		{
			return;
		}
		int num = currentIndex + direction;
		if (num >= 0 && num < itemList.Count)
		{
			int rewardColumnCount = GetRewardColumnCount();
			if (rewardColumnCount <= 0 || currentIndex / rewardColumnCount == num / rewardColumnCount)
			{
				SelectRewardAtIndex(num, itemList);
			}
		}
	}

	private void MoveRewardSelectionVertical(int direction)
	{
		if (!TryGetCurrentRewardIndex(out var currentIndex, out var itemList))
		{
			return;
		}
		int rewardColumnCount = GetRewardColumnCount();
		if (rewardColumnCount <= 0)
		{
			return;
		}
		int count = itemList.Count;
		int num = currentIndex / rewardColumnCount;
		int num2 = currentIndex % rewardColumnCount;
		if (direction > 0)
		{
			int num3 = (num + 1) * rewardColumnCount;
			if (num3 < count)
			{
				int b = Mathf.Min(num3 + rewardColumnCount - 1, count - 1);
				int num4 = Mathf.Min(num3 + num2, b);
				if (num4 != currentIndex)
				{
					SelectRewardAtIndex(num4, itemList);
				}
			}
			return;
		}
		int num5 = num - 1;
		if (num5 >= 0)
		{
			int num6 = num5 * rewardColumnCount;
			int num7 = Mathf.Min(num6 + rewardColumnCount - 1, count - 1) - num6 + 1;
			int num8 = Mathf.Min(num2, num7 - 1);
			int num9 = num6 + num8;
			if (num9 >= 0 && num9 < count && num9 != currentIndex)
			{
				SelectRewardAtIndex(num9, itemList);
			}
		}
	}

	private bool TryGetCurrentRewardIndex(out int currentIndex, out List<ItemUnifierProxy> itemList)
	{
		currentIndex = -1;
		itemList = null;
		if (scrollBag == null || scrollBag.ItemSource == null)
		{
			return false;
		}
		itemList = new List<ItemUnifierProxy>();
		foreach (ItemUnifierProxy item in scrollBag.ItemSource)
		{
			itemList.Add(item);
		}
		if (itemList.Count == 0)
		{
			return false;
		}
		ItemUnifierProxy itemUnifierProxy = null;
		ObservableCollection<ItemUnifierProxy> selectedModels = scrollBag.SelectedModels;
		if (selectedModels != null && selectedModels.Count > 0)
		{
			itemUnifierProxy = scrollBag.SelectedModels[0];
		}
		if (itemUnifierProxy == null)
		{
			itemUnifierProxy = (EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>())?.ItemUnifier;
		}
		if (itemUnifierProxy != null)
		{
			currentIndex = itemList.IndexOf(itemUnifierProxy);
		}
		if (currentIndex < 0)
		{
			ItemUIComponentBase itemUIComponentBase = EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>();
			if (itemUIComponentBase != null && itemUIComponentBase.Index >= 0 && itemUIComponentBase.Index < itemList.Count)
			{
				currentIndex = itemUIComponentBase.Index;
			}
			else
			{
				currentIndex = 0;
			}
		}
		if (currentIndex >= 0)
		{
			return currentIndex < itemList.Count;
		}
		return false;
	}

	private int GetRewardColumnCount()
	{
		if (scrollBag != null)
		{
			LoopScrollRect componentInChildren = scrollBag.GetComponentInChildren<LoopScrollRect>();
			if (componentInChildren != null && componentInChildren.contentConstraintCount > 0)
			{
				return Mathf.Max(1, componentInChildren.contentConstraintCount);
			}
		}
		if (_content == null)
		{
			return 0;
		}
		GridLayoutGroup component = _content.GetComponent<GridLayoutGroup>();
		if (component == null)
		{
			return 0;
		}
		if (component.constraint == GridLayoutGroup.Constraint.FixedColumnCount)
		{
			return Mathf.Max(1, component.constraintCount);
		}
		if (component.constraint == GridLayoutGroup.Constraint.FixedRowCount)
		{
			int num = 0;
			if (scrollBag?.ItemSource != null)
			{
				foreach (ItemUnifierProxy item in scrollBag.ItemSource)
				{
					_ = item;
					num++;
				}
			}
			return Mathf.Max(1, Mathf.CeilToInt((float)num / (float)Mathf.Max(1, component.constraintCount)));
		}
		return 0;
	}

	private bool IsRewardIndexInCurrentVisibleWindow(int index)
	{
		if (scrollBag == null)
		{
			return true;
		}
		LoopScrollRect componentInChildren = scrollBag.GetComponentInChildren<LoopScrollRect>();
		if (componentInChildren == null)
		{
			return true;
		}
		if (index >= componentInChildren.ItemIndexStart)
		{
			return index < componentInChildren.ItemIndexEnd;
		}
		return false;
	}

	private void StopRewardListScrollMotion()
	{
		if (!(scrollBag == null))
		{
			scrollBag.GetComponentInChildren<LoopScrollRect>()?.StopMovement();
		}
	}

	private void SelectRewardAtIndex(int index, List<ItemUnifierProxy> itemList)
	{
		if (scrollBag == null || itemList == null || index < 0 || index >= itemList.Count)
		{
			return;
		}
		ClearRewardItemHighlightStates();
		ItemUIComponentBase item = scrollBag.GetItem(index);
		scrollBag.SelectedModels.Clear();
		scrollBag.SelectedModels.Add(itemList[index]);
		if (!IsRewardIndexInCurrentVisibleWindow(index))
		{
			scrollBag.ScrollToIndex(index);
			EventSystemHelper.SetSelectedGameObject(null);
			return;
		}
		StopRewardListScrollMotion();
		if (item != null)
		{
			EventSystemHelper.SetSelectedGameObject(item.gameObject);
		}
	}

	private void ClearRewardItemHighlightStates()
	{
		if (scrollBag?.ItemSource == null)
		{
			return;
		}
		int num = 0;
		foreach (ItemUnifierProxy item2 in scrollBag.ItemSource)
		{
			_ = item2;
			ItemUIComponentBase item = scrollBag.GetItem(num);
			if ((object)item != null)
			{
				item.IsHighLight = false;
			}
			num++;
		}
	}

	public void HandleGamePadReturnButtonInput(RewardSubController controllerType)
	{
		if (controllerType == RewardSubController.SelectItem || _isGamepadItemSelectMode)
		{
			OnClickSelectBBtn();
		}
		else if (CanCloseByConfirm())
		{
			Close();
		}
	}
}
