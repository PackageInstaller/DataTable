using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PropPickComponent : BaseUIComponent, IBattleMainComponent
{
	[Header("配置")]
	public CanvasGroup canvasGroup;

	public int maxShowNum;

	[Header(" 普通掉落道具 cell 的预制体")]
	public GameObject cellPrefab;

	[Header("ScrollView")]
	public ScrollRect propScrollRect;

	[Header("普通道具 cell 在可见区域内的停留时间")]
	public float normalRemainTime = 1f;

	[Header("新道具 cell 在可见区域内的停留时间")]
	public float newItemRemainTime = 2f;

	[Header("金币组件")]
	public PickUpCoinItem pickUpCoinItem;

	[Header("经验组件")]
	public PickUpCoinItem pickUpExpItem;

	[Header("新物品提示")]
	public NewItemTip newItemTip;

	[Header("特殊物品提示")]
	public SpecialItemTip specialItemTip;

	private DisplayStage _displayStage;

	private List<MonoItem> _curItemCellList;

	private List<ItemAchieveinfo> _commonItemListOnCombine;

	private List<ItemAchieveinfo> _newItemList;

	private List<ItemAchieveinfo> _specialItemList;

	private const int CoinId = 2;

	private const int ExpId = 6;

	private ItemAchieveinfo _coinData;

	private ItemAchieveinfo _expData;

	private float _cellHeight;

	private float _verticalSpacing;

	private int _contentHeightByCellNum;

	private float _cellHideTime;

	private PropPickingData m_Data;

	private PropPickingManager _manager;

	private CancellationTokenSource _cts;

	private CancellationToken _ct;

	private int _alreadyCreatedItemCount;

	private bool _isShowingCells;

	private int _topToHideIndex;

	private int _nextToShowIndex;

	private readonly Queue<MonoItem> _normalCellPool = new Queue<MonoItem>();

	private readonly List<List<ItemAchieveinfo>> _boundaryPackageBuffer = new List<List<ItemAchieveinfo>>();

	private void Awake()
	{
		_cellHeight = cellPrefab.GetComponent<RectTransform>().sizeDelta.y;
		_verticalSpacing = propScrollRect.content.GetComponent<VerticalLayoutGroup>().spacing;
		RectTransform component = propScrollRect.GetComponent<RectTransform>();
		component.sizeDelta = new Vector2(component.sizeDelta.x, GetContentHeight(maxShowNum));
		AnimationClip[] animationClips = cellPrefab.GetComponent<Animator>().runtimeAnimatorController.animationClips;
		foreach (AnimationClip animationClip in animationClips)
		{
			if (animationClip.name == "Hide")
			{
				_cellHideTime = animationClip.length;
				break;
			}
		}
	}

	protected override void OnUnityDestroy()
	{
		if (_manager != null)
		{
			_manager.AppendPackageQueued -= OnAppendPackageQueued;
		}
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		ClearCellPool();
	}

	public void Show(PropPickingData data, Action openFail)
	{
		onClose = () =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.LeftBottom);
		};
		try
		{
			m_Data = data;
			if (canvasGroup != null)
			{
				canvasGroup.alpha = 1f;
			}
			_coinData = null;
			_expData = null;
			_alreadyCreatedItemCount = 0;
			_isShowingCells = false;
			_topToHideIndex = 0;
			_nextToShowIndex = 0;
			_cts = new CancellationTokenSource();
			_ct = _cts.Token;
			if (!Mathf.Approximately(propScrollRect.verticalNormalizedPosition, 1f))
			{
				propScrollRect.verticalNormalizedPosition = 1f;
			}
			_contentHeightByCellNum = maxShowNum;
			UpdateContentHeight(_contentHeightByCellNum);
			newItemTip.gameObject.SetActive(value: false);
			specialItemTip.gameObject.SetActive(value: false);
			CombineNewPackageItems(data.info);
			_displayStage = DisplayStage.Displaying;
			_manager.UpdateComponentOpenState(isOpen: true);
			DisplayLoop().Forget();
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"物品掉落打开失败：{arg}");
			}
			openFail?.Invoke();
			Hide();
		}
	}

	public void Hide()
	{
		if (_displayStage != DisplayStage.Idle)
		{
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = null;
			ReturnAllCellsToPool();
			_curItemCellList?.Clear();
			_commonItemListOnCombine?.Clear();
			_newItemList?.Clear();
			_specialItemList?.Clear();
			pickUpCoinItem?.ClearData();
			pickUpExpItem?.ClearData();
			_displayStage = DisplayStage.Idle;
			_manager.UpdateComponentOpenState(isOpen: false);
			_alreadyCreatedItemCount = 0;
			_isShowingCells = false;
			_topToHideIndex = 0;
			_nextToShowIndex = 0;
			onClose?.Invoke();
			onClose = null;
			if (canvasGroup != null)
			{
				canvasGroup.alpha = 0f;
			}
		}
	}

	private void ReleaseList<T>(ref List<T> list)
	{
		if (list != null)
		{
			ListPool<T>.Release(list);
			list = null;
		}
	}

	private async UniTaskVoid DisplayLoop()
	{
		_ = 3;
		try
		{
			bool flag = true;
			while (flag)
			{
				await ShowSpecial();
				await ShowIsNew();
				await ShowCell();
				if (_displayStage != DisplayStage.Displaying)
				{
					break;
				}
				ReturnAllCellsToPool();
				ResetScrollState();
				flag = ConsumeNextWaitingPackage();
				if (!flag)
				{
					flag = await WaitForCoinExpFinishOrPendingDisplay();
					if (!flag)
					{
						flag = ConsumeNextWaitingPackage();
					}
				}
			}
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"PropPickComponent DisplayLoop 异常：{arg}");
			}
		}
		Hide();
	}

	private async UniTask ShowCell()
	{
		BuildCellsForPendingItems();
		List<MonoItem> curItemCellList = _curItemCellList;
		if (curItemCellList == null || curItemCellList.Count <= 0)
		{
			return;
		}
		_isShowingCells = true;
		try
		{
			int num = Mathf.Min(maxShowNum, _curItemCellList.Count);
			_topToHideIndex = 0;
			_nextToShowIndex = num;
			for (int i = 0; i < num; i++)
			{
				_curItemCellList[i].PlayShowAnimationByQuality();
			}
			int lastShownIdx = num - 1;
			await UniTask.WaitUntil(() => _curItemCellList[lastShownIdx].stage == MonoItem.PropPickingCellStage.Remain, PlayerLoopTiming.Update, _ct);
			while (_topToHideIndex < _curItemCellList.Count)
			{
				int lastVisible = Mathf.Min(_topToHideIndex + maxShowNum - 1, _commonItemListOnCombine.Count - 1);
				await UniTask.Delay(TimeSpan.FromSeconds(GetRemainTimeForRange(_topToHideIndex, lastVisible)), ignoreTimeScale: false, PlayerLoopTiming.Update, _ct);
				if (_displayStage != DisplayStage.Displaying || _curItemCellList == null || _topToHideIndex >= _curItemCellList.Count)
				{
					break;
				}
				_contentHeightByCellNum++;
				UpdateContentHeight(_contentHeightByCellNum);
				_curItemCellList[_topToHideIndex].PlayHideAnimation();
				MonoItem showingCell = null;
				if (_nextToShowIndex < _curItemCellList.Count)
				{
					showingCell = _curItemCellList[_nextToShowIndex];
					showingCell.PlayShowAnimationByQuality();
					_nextToShowIndex++;
				}
				await propScrollRect.DOVerticalNormalizedPos(0f, _cellHideTime).ToUniTask(TweenCancelBehaviour.KillAndCancelAwait, _ct);
				if (showingCell != null)
				{
					await UniTask.WaitUntil(() => showingCell.stage == MonoItem.PropPickingCellStage.Remain, PlayerLoopTiming.Update, _ct);
				}
				_topToHideIndex++;
			}
		}
		finally
		{
			_isShowingCells = false;
		}
	}

	private async UniTask ShowSpecial()
	{
		if (_specialItemList == null || _specialItemList.Count == 0)
		{
			return;
		}
		while (true)
		{
			ItemAchieveinfo info = null;
			for (int i = 0; i < _specialItemList.Count; i++)
			{
				ItemAchieveinfo itemAchieveinfo = _specialItemList[i];
				if (itemAchieveinfo != null && itemAchieveinfo.IsSpecial)
				{
					info = itemAchieveinfo;
					break;
				}
			}
			if (info != null)
			{
				try
				{
					await specialItemTip.Show(info, _ct);
				}
				catch (OperationCanceledException)
				{
					specialItemTip.Uninit();
					break;
				}
				_specialItemList.Remove(info);
				continue;
			}
			break;
		}
	}

	private async UniTask ShowIsNew()
	{
		if (_newItemList == null || _newItemList.Count == 0)
		{
			return;
		}
		while (newItemTip.curItemFinish)
		{
			ItemAchieveinfo nextNewInfo = null;
			for (int i = 0; i < _newItemList.Count; i++)
			{
				ItemAchieveinfo itemAchieveinfo = _newItemList[i];
				if (itemAchieveinfo != null && itemAchieveinfo.isNew)
				{
					nextNewInfo = itemAchieveinfo;
					break;
				}
			}
			if (nextNewInfo != null)
			{
				try
				{
					await newItemTip.Show(nextNewInfo, _ct);
					await newItemTip.Hide(_ct);
				}
				catch (OperationCanceledException)
				{
					newItemTip.ForceFinish();
					break;
				}
				_newItemList.Remove(nextNewInfo);
				continue;
			}
			break;
		}
	}

	private MonoItem GetCellFromPool(Transform parent)
	{
		MonoItem monoItem;
		if (_normalCellPool.Count > 0)
		{
			monoItem = _normalCellPool.Dequeue();
			monoItem.transform.SetParent(parent, worldPositionStays: false);
			monoItem.transform.SetAsLastSibling();
		}
		else
		{
			monoItem = UnityEngine.Object.Instantiate(cellPrefab, parent).GetComponent<MonoItem>();
		}
		return monoItem;
	}

	private void ReturnCellToPool(MonoItem cell, Transform hideRoot)
	{
		if (!(cell == null))
		{
			cell.gameObject.SetActive(value: false);
			cell.transform.SetParent(hideRoot, worldPositionStays: false);
			_normalCellPool.Enqueue(cell);
		}
	}

	private void ClearCellPool()
	{
		while (_normalCellPool.Count > 0)
		{
			MonoItem monoItem = _normalCellPool.Dequeue();
			if (monoItem != null && monoItem.gameObject != null)
			{
				UnityEngine.Object.Destroy(monoItem.gameObject);
			}
		}
	}

	private void OnAppendPackageQueued()
	{
		if (_displayStage != DisplayStage.Displaying || _commonItemListOnCombine == null || _curItemCellList == null)
		{
			return;
		}
		List<List<ItemAchieveinfo>> list = ListPool<List<ItemAchieveinfo>>.Get();
		if (_manager.TryTakeAppendCommonPackages(list))
		{
			for (int i = 0; i < list.Count; i++)
			{
				AppendCommonPackageItems(list[i]);
			}
		}
		ListPool<List<ItemAchieveinfo>>.Release(list);
		if (_isShowingCells)
		{
			BuildCellsForPendingItems();
			ShowPendingCellsInVisibleRange();
		}
	}

	private void ShowPendingCellsInVisibleRange()
	{
		int num = Mathf.Min(_topToHideIndex + maxShowNum, _curItemCellList.Count);
		while (_nextToShowIndex < num)
		{
			MonoItem monoItem = _curItemCellList[_nextToShowIndex];
			if (monoItem != null)
			{
				monoItem.PlayShowAnimationByQuality();
			}
			_nextToShowIndex++;
		}
	}

	private void BuildCellsForPendingItems()
	{
		List<ItemAchieveinfo> commonItemListOnCombine = _commonItemListOnCombine;
		if (commonItemListOnCombine != null && commonItemListOnCombine.Count > 0 && _curItemCellList != null)
		{
			for (int i = _alreadyCreatedItemCount; i < _commonItemListOnCombine.Count; i++)
			{
				ItemAchieveinfo info = _commonItemListOnCombine[i];
				MonoItem cellFromPool = GetCellFromPool(propScrollRect.content);
				cellFromPool.Init(info);
				_curItemCellList.Add(cellFromPool);
			}
			_alreadyCreatedItemCount = _commonItemListOnCombine.Count;
		}
	}

	private void AppendCommonPackageItems(List<ItemAchieveinfo> packageItems)
	{
		if (packageItems == null)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		foreach (ItemAchieveinfo packageItem in packageItems)
		{
			if (packageItem != null)
			{
				if (packageItem.itemId == 2)
				{
					num += packageItem.itemNum;
					AddCoinData(packageItem.itemNum);
				}
				else if (packageItem.itemId == 6)
				{
					num2 += packageItem.itemNum;
					AddExpData(packageItem.itemNum);
				}
				else
				{
					_commonItemListOnCombine.Add(packageItem);
				}
			}
		}
		RefreshCoinExpDisplay(num, num2);
	}

	private void CombineNewPackageItems(List<ItemAchieveinfo> newPackageItems)
	{
		if (newPackageItems != null && newPackageItems.Count > 0)
		{
			_commonItemListOnCombine.Clear();
			int coinAddNum = 0;
			int expAddNum = 0;
			CombinePackageItemsIntoCurrentDisplay(newPackageItems, ref coinAddNum, ref expAddNum);
			RefreshCoinExpDisplay(coinAddNum, expAddNum);
		}
	}

	private void CombinePackageItemsIntoCurrentDisplay(List<ItemAchieveinfo> packageItems, ref int coinAddNum, ref int expAddNum)
	{
		for (int i = 0; i < packageItems.Count; i++)
		{
			ItemAchieveinfo itemAchieveinfo = packageItems[i];
			if (itemAchieveinfo.itemId == 2)
			{
				coinAddNum += itemAchieveinfo.itemNum;
				AddCoinData(itemAchieveinfo.itemNum);
				continue;
			}
			if (itemAchieveinfo.itemId == 6)
			{
				expAddNum += itemAchieveinfo.itemNum;
				AddExpData(itemAchieveinfo.itemNum);
				continue;
			}
			_commonItemListOnCombine.Add(itemAchieveinfo);
			if (!ItemIsTreasure(itemAchieveinfo))
			{
				if (itemAchieveinfo.IsSpecial)
				{
					_specialItemList.Add(itemAchieveinfo);
				}
				else if (itemAchieveinfo.isNew && RuntimeConfigs.data.itemDatas[itemAchieveinfo.itemId].isNeedNewTip)
				{
					_newItemList.Add(itemAchieveinfo);
				}
			}
		}
	}

	private bool ConsumeNextWaitingPackage()
	{
		_boundaryPackageBuffer.Clear();
		if (!_manager.TryTakeBoundaryPackages(_boundaryPackageBuffer))
		{
			return false;
		}
		_commonItemListOnCombine.Clear();
		int coinAddNum = 0;
		int expAddNum = 0;
		for (int i = 0; i < _boundaryPackageBuffer.Count; i++)
		{
			List<ItemAchieveinfo> list = _boundaryPackageBuffer[i];
			if (list != null)
			{
				CombinePackageItemsIntoCurrentDisplay(list, ref coinAddNum, ref expAddNum);
			}
		}
		RefreshCoinExpDisplay(coinAddNum, expAddNum);
		_boundaryPackageBuffer.Clear();
		List<ItemAchieveinfo> commonItemListOnCombine = _commonItemListOnCombine;
		if (commonItemListOnCombine == null || commonItemListOnCombine.Count <= 0)
		{
			commonItemListOnCombine = _specialItemList;
			if (commonItemListOnCombine == null || commonItemListOnCombine.Count <= 0)
			{
				commonItemListOnCombine = _newItemList;
				if (commonItemListOnCombine != null)
				{
					return commonItemListOnCombine.Count > 0;
				}
				return false;
			}
		}
		return true;
	}

	private void ReturnAllCellsToPool()
	{
		if (_curItemCellList == null)
		{
			return;
		}
		foreach (MonoItem curItemCell in _curItemCellList)
		{
			if (curItemCell != null)
			{
				ReturnCellToPool(curItemCell, propScrollRect.viewport);
			}
		}
		_curItemCellList.Clear();
	}

	private void ResetScrollState()
	{
		_contentHeightByCellNum = maxShowNum;
		UpdateContentHeight(_contentHeightByCellNum);
		if (!Mathf.Approximately(propScrollRect.verticalNormalizedPosition, 1f))
		{
			propScrollRect.verticalNormalizedPosition = 1f;
		}
		_commonItemListOnCombine?.Clear();
		_alreadyCreatedItemCount = 0;
		_topToHideIndex = 0;
		_nextToShowIndex = 0;
	}

	private async UniTask<bool> WaitForCoinExpFinishOrPendingDisplay()
	{
		while (true)
		{
			if (HasPendingImmediateDisplay())
			{
				return true;
			}
			if (CoinExpRemainFinished())
			{
				break;
			}
			await UniTask.Yield(PlayerLoopTiming.Update, _ct);
		}
		return false;
	}

	private bool HasPendingImmediateDisplay()
	{
		if (_commonItemListOnCombine != null)
		{
			return _commonItemListOnCombine.Count > _alreadyCreatedItemCount;
		}
		return false;
	}

	private bool CoinExpRemainFinished()
	{
		bool num = pickUpCoinItem == null || pickUpCoinItem.remainFinish;
		bool flag = pickUpExpItem == null || pickUpExpItem.remainFinish;
		return num & flag;
	}

	private float GetContentHeight(int cellNum)
	{
		return (float)cellNum * _cellHeight + (float)(cellNum - 1) * _verticalSpacing;
	}

	private void UpdateContentHeight(int cellNum)
	{
		propScrollRect.content.sizeDelta = new Vector2(propScrollRect.content.sizeDelta.x, GetContentHeight(cellNum));
	}

	private float GetRemainTimeForRange(int firstVisible, int lastVisible)
	{
		if (_commonItemListOnCombine == null)
		{
			return normalRemainTime;
		}
		for (int i = firstVisible; i <= lastVisible && i < _commonItemListOnCombine.Count; i++)
		{
			if (_commonItemListOnCombine[i].isNew)
			{
				return newItemRemainTime;
			}
		}
		return normalRemainTime;
	}

	private void PickOutCoinAndExp(List<ItemAchieveinfo> packageItems)
	{
		int num = 0;
		int num2 = 0;
		for (int num3 = packageItems.Count - 1; num3 >= 0; num3--)
		{
			ItemAchieveinfo itemAchieveinfo = packageItems[num3];
			if (itemAchieveinfo.itemId == 2)
			{
				packageItems.RemoveAt(num3);
				num += itemAchieveinfo.itemNum;
				AddCoinData(itemAchieveinfo.itemNum);
			}
			else if (itemAchieveinfo.itemId == 6)
			{
				packageItems.RemoveAt(num3);
				num2 += itemAchieveinfo.itemNum;
				AddExpData(itemAchieveinfo.itemNum);
			}
		}
		RefreshCoinExpDisplay(num, num2);
	}

	private void AddCoinData(int itemNum)
	{
		if (_coinData == null)
		{
			_coinData = new ItemAchieveinfo
			{
				itemId = 2,
				itemNum = itemNum
			};
		}
		else
		{
			_coinData.itemNum += itemNum;
		}
	}

	private void AddExpData(int itemNum)
	{
		if (_expData == null)
		{
			_expData = new ItemAchieveinfo
			{
				itemId = 6,
				itemNum = itemNum
			};
		}
		else
		{
			_expData.itemNum += itemNum;
		}
	}

	private void RefreshCoinExpDisplay(int coinAddNum, int expAddNum)
	{
		if (coinAddNum > 0 && _coinData != null && (bool)pickUpCoinItem)
		{
			pickUpCoinItem.RefreshData(coinAddNum);
			pickUpCoinItem.RefreshDisplay(_coinData, Station);
		}
		if (expAddNum > 0 && _expData != null && (bool)pickUpExpItem)
		{
			pickUpExpItem.RefreshData(expAddNum);
			pickUpExpItem.RefreshDisplay(_expData, Station);
		}
	}

	private void CollectSpecialItem(List<ItemAchieveinfo> packageItems)
	{
		for (int num = packageItems.Count - 1; num >= 0; num--)
		{
			if (packageItems[num].IsSpecial && !ItemIsTreasure(packageItems[num]))
			{
				_specialItemList.Add(packageItems[num]);
			}
		}
	}

	private void CollectFirstGetItem(List<ItemAchieveinfo> packageItems)
	{
		for (int i = 0; i < packageItems.Count; i++)
		{
			ItemAchieveinfo itemAchieveinfo = packageItems[i];
			if (itemAchieveinfo.isNew && RuntimeConfigs.data.itemDatas[itemAchieveinfo.itemId].isNeedNewTip && !itemAchieveinfo.IsSpecial && !ItemIsTreasure(itemAchieveinfo))
			{
				_newItemList.Add(itemAchieveinfo);
			}
		}
	}

	private bool ItemIsTreasure(ItemAchieveinfo item)
	{
		if (item == null || !Model<TreasureModel>.HasInstance())
		{
			return false;
		}
		List<Treasure> allTreasures = Model<TreasureModel>.Interface.allTreasures;
		if (allTreasures == null || allTreasures.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < allTreasures.Count; i++)
		{
			Treasure treasure = allTreasures[i];
			if (treasure != null && treasure.GetItemId() == item.itemId)
			{
				return true;
			}
		}
		return false;
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_manager = Singleton<PropPickingManager>.instance;
		_curItemCellList = ListPool<MonoItem>.Get();
		_commonItemListOnCombine = ListPool<ItemAchieveinfo>.Get();
		_newItemList = ListPool<ItemAchieveinfo>.Get();
		_specialItemList = ListPool<ItemAchieveinfo>.Get();
		_manager.AppendPackageQueued -= OnAppendPackageQueued;
		_manager.AppendPackageQueued += OnAppendPackageQueued;
		gameObject.SetActive(value: true);
		if (canvasGroup != null)
		{
			canvasGroup.alpha = 0f;
		}
	}

	public void UnInitialize()
	{
		Hide();
		ReleaseList(ref _curItemCellList);
		ReleaseList(ref _commonItemListOnCombine);
		ReleaseList(ref _newItemList);
		ReleaseList(ref _specialItemList);
		_manager.AppendPackageQueued -= OnAppendPackageQueued;
		gameObject.SetActive(value: false);
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
