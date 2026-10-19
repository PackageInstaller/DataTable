using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT;
using ACT.Core;
using ACT.Game.Data;
using ACT.Sound;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;

public class CardDrawSettleComponent : MonoBehaviour
{
	public ActButton BtnClose;

	public GameObject GoSingleResult;

	public CardDrawResultCell GoSingleItem;

	public GameObject GoMultipleResult;

	public List<CardDrawResultCell> ListMultipleItem;

	public ViewControlLayer ResultSingleViewControlLayer;

	public ViewControlLayer ResultMultipleViewControlLayer;

	public GameObject GoExtraitem;

	public List<LiteItemUIComponent> _LiteItems;

	private bool IsSingle;

	public List<GachaCardDrawItem> lististResult;

	public BetterAnimation betterAnimation;

	public ActButton ShareButton;

	public List<GameObject> ShareHide = new List<GameObject>();

	public GamePadTipsComp gamePadTipsComp;

	private ImageAssetStation Station;

	private int _gachaId;

	private int _gachaType;

	private Action OnCloseCallBack;

	private bool _isSharing;

	private const int ViewDetailLocalizeKey = 1642;

	public bool CanFocusResult
	{
		get
		{
			if (gameObject.activeInHierarchy && BtnClose != null)
			{
				return BtnClose.IsActive();
			}
			return false;
		}
	}

	public ViewControlLayer ActiveResultViewControlLayer => GetActiveResultLayer();

	public bool IsResultFocused => ActiveResultViewControlLayer?.IsFocused ?? false;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void PreInit(ImageAssetStation station, List<GachaCardDrawItem> _lististResult, Action onClose, int gachaId, int gachaType)
	{
		ClearResultFocus();
		lististResult = _lististResult;
		Station = station;
		_gachaId = gachaId;
		_gachaType = gachaType;
		BtnClose.SetBtnClick(Close);
		ShareButton?.SetBtnClick(() =>
		{
			Share().Forget();
		});
		PreInitPanel();
		BtnClose.gameObject.SetActive(value: false);
		OnCloseCallBack = onClose;
		RefreshGamepadTips(isItemSelectMode: false);
	}

	private void PreInitPanel()
	{
		IsSingle = lististResult.Count == 1;
		Init();
	}

	protected void Init()
	{
		InitPanel();
	}

	private void Close()
	{
		ClearResultFocus();
		OnCloseCallBack?.Invoke();
	}

	public bool TryFocusResult()
	{
		if (!CanFocusResult)
		{
			return false;
		}
		ViewControlLayer activeResultLayer = GetActiveResultLayer();
		if (activeResultLayer == null)
		{
			return false;
		}
		if (activeResultLayer.IsFocused)
		{
			RefreshGamepadTips(isItemSelectMode: true);
			return true;
		}
		if (!RefreshResultDefaultSelect(activeResultLayer))
		{
			return false;
		}
		activeResultLayer.Focus();
		bool isFocused = activeResultLayer.IsFocused;
		if (isFocused)
		{
			RefreshGamepadTips(isItemSelectMode: true);
		}
		return isFocused;
	}

	public bool TryUnFocusResult()
	{
		ViewControlLayer activeResultLayer = GetActiveResultLayer();
		if (activeResultLayer == null || !activeResultLayer.IsFocused)
		{
			return false;
		}
		activeResultLayer.UnFocus();
		RefreshGamepadTips(isItemSelectMode: false);
		return true;
	}

	public void ReFocusResult()
	{
		ViewControlLayer activeResultLayer = GetActiveResultLayer();
		if (CanFocusResult && !(activeResultLayer == null) && activeResultLayer.IsFocused)
		{
			activeResultLayer.ReFocus();
			RefreshGamepadTips(isItemSelectMode: true);
		}
	}

	public bool TrySubmitResult()
	{
		ViewControlLayer activeResultLayer = GetActiveResultLayer();
		if (activeResultLayer == null || !activeResultLayer.IsFocused)
		{
			return false;
		}
		if (!EventSystemHelper.Available)
		{
			return true;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		ACT.ViewControl.SelectableEx selectableEx = ((currentSelected != null) ? currentSelected.GetComponent<ACT.ViewControl.SelectableEx>() : null);
		if (selectableEx == null || selectableEx.Layer != activeResultLayer)
		{
			activeResultLayer.ReFocus();
			currentSelected = EventSystemHelper.CurrentSelected;
		}
		if (currentSelected != null)
		{
			EventSystemHelper.Click(currentSelected);
		}
		return true;
	}

	public void ClearResultFocus()
	{
		bool isResultFocused = IsResultFocused;
		ResultSingleViewControlLayer?.UnFocus();
		ResultMultipleViewControlLayer?.UnFocus();
		ResultSingleViewControlLayer?.SetDefaultSelect(null);
		ResultMultipleViewControlLayer?.SetDefaultSelect(null);
		if (isResultFocused)
		{
			RefreshGamepadTips(isItemSelectMode: false);
		}
	}

	private void RefreshGamepadTips(bool isItemSelectMode)
	{
		if (!(gamePadTipsComp == null))
		{
			gamePadTipsComp.ClearAllPrompts();
			if (isItemSelectMode)
			{
				GamePadTipsAction gamePadTipsAction = new GamePadTipsAction
				{
					inputAction = "UI/Confirm",
					localizeTable = "Common",
					localizeKey = 774
				};
				gamePadTipsComp.RegisterInputActions(gamePadTipsAction, GamePadTipHelper.BackAction);
			}
			else
			{
				GamePadTipsAction gamePadTipsAction2 = new GamePadTipsAction
				{
					inputAction = "UI/Confirm",
					localizeTable = "Common",
					localizeKey = 13
				};
				GamePadTipsAction gamePadTipsAction3 = new GamePadTipsAction
				{
					inputAction = "UI/SelectItemCell",
					localizeTable = "Common",
					localizeKey = 1642
				};
				gamePadTipsComp.RegisterInputActions(gamePadTipsAction2, gamePadTipsAction3);
			}
		}
	}

	private ViewControlLayer GetActiveResultLayer()
	{
		if (!IsSingle)
		{
			return ResultMultipleViewControlLayer;
		}
		return ResultSingleViewControlLayer;
	}

	private bool RefreshResultDefaultSelect(ViewControlLayer resultLayer)
	{
		ACT.ViewControl.SelectableEx selectableEx = null;
		if (IsSingle)
		{
			selectableEx = GetValidSelectable(GoSingleItem);
		}
		else
		{
			foreach (CardDrawResultCell item in ListMultipleItem)
			{
				selectableEx = GetValidSelectable(item);
				if (selectableEx != null)
				{
					break;
				}
			}
		}
		resultLayer.SetDefaultSelect(selectableEx);
		return selectableEx != null;
	}

	private static ACT.ViewControl.SelectableEx GetValidSelectable(CardDrawResultCell resultCell)
	{
		if (resultCell == null || !resultCell.gameObject.activeInHierarchy || resultCell.BtnClick == null)
		{
			return null;
		}
		ACT.ViewControl.SelectableEx component = resultCell.BtnClick.GetComponent<ACT.ViewControl.SelectableEx>();
		if (!(component != null) || !component.IsValid())
		{
			return null;
		}
		return component;
	}

	private void ShowCardSettle()
	{
		FinallyResultShow();
		PlayRewardAnimation();
	}

	private void SetResultClickEnabled(bool enabled)
	{
		if (IsSingle)
		{
			GoSingleItem?.SetClickEnabled(enabled);
			return;
		}
		foreach (CardDrawResultCell item in ListMultipleItem)
		{
			item?.SetClickEnabled(enabled);
		}
	}

	public void InitPanel()
	{
		ShowCardSettle();
	}

	private void FinallyResultShow()
	{
		GoSingleResult.SetActive(IsSingle);
		GoMultipleResult.SetActive(!IsSingle);
		for (int i = 0; i < _LiteItems.Count; i++)
		{
			_LiteItems[i].gameObject.SetActive(value: false);
		}
		if (IsSingle)
		{
			ShowSingleItem();
		}
		else
		{
			ShowMultipleItem();
		}
		ShowExtraitem();
	}

	private void PlayRewardAnimation()
	{
		SetResultClickEnabled(enabled: false);
		if (IsSingle)
		{
			CoreUtils.GetData(lististResult[0].PoolItem.Id, RuntimeConfigs.data.itemDatas);
			betterAnimation.GetSequence("ItemShowSingle").OnComplete((AnimationBuilder builder) =>
			{
				SetResultClickEnabled(enabled: true);
				BtnClose.gameObject.SetActive(value: true);
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Reward10_Role", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
		else
		{
			betterAnimation.GetSequence("Ten").Play().OnComplete((AnimationBuilder builder) =>
			{
				SetResultClickEnabled(enabled: true);
				BtnClose.gameObject.SetActive(value: true);
			});
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/DrawCard/Machine/Settlement_Gold", new AudioPlayOptions
			{
				attachTarget = transform
			});
		}
	}

	private bool CheckHaveGoldReward()
	{
		for (int i = 0; i < lististResult.Count; i++)
		{
			if (CoreUtils.GetData(lististResult[i].PoolItem.Id, RuntimeConfigs.data.itemDatas).quality >= 5)
			{
				return true;
			}
		}
		return false;
	}

	private void ItemPlayAnimation()
	{
		for (int i = 0; i < ListMultipleItem.Count; i++)
		{
			ListMultipleItem[i].CheckNeedPlayAni();
		}
	}

	private void ShowSingleItem()
	{
		GoSingleItem.Init(lististResult[0], Station, lististResult[0].CharacterMaxConstellation, isSingle: true, _gachaId, _gachaType);
		GoSingleItem.SetCanvaGroupAlpha(0f);
	}

	private void ShowExtraitem()
	{
		Dictionary<int, Item> dictionary = new Dictionary<int, Item>();
		for (int i = 0; i < lististResult.Count; i++)
		{
			for (int j = 0; j < lististResult[i].ExtraItem.Count; j++)
			{
				if (!lististResult[i].CharacterMaxConstellation)
				{
					if (dictionary.TryGetValue(lististResult[i].ExtraItem[j].Id, out var value))
					{
						value.Count += lististResult[i].ExtraItem[j].Count;
						continue;
					}
					Item item = new Item();
					item.Id = lististResult[i].ExtraItem[j].Id;
					item.Count = lististResult[i].ExtraItem[j].Count;
					dictionary.Add(item.Id, item);
				}
			}
		}
		List<Item> list = dictionary.Values.ToList();
		for (int k = 0; k < list.Count; k++)
		{
			if (k < _LiteItems.Count)
			{
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(list[k].Id, list[k].Count);
				_LiteItems[k].SetData(item2, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				_LiteItems[k].UpdatePerformance();
				_LiteItems[k].gameObject.SetActive(value: true);
			}
		}
		GoExtraitem.SetActive(list.Count > 0);
	}

	private void ShowMultipleItem()
	{
		for (int i = 0; i < lististResult.Count; i++)
		{
			ListMultipleItem[i].Init(lististResult[i], Station, lististResult[i].CharacterMaxConstellation, isSingle: false, _gachaId, _gachaType);
		}
	}

	protected void PlayOpenAnimation()
	{
	}

	public async UniTask Share()
	{
		if (_isSharing)
		{
			return;
		}
		_isSharing = true;
		Dictionary<GameObject, bool> hiddenStates = new Dictionary<GameObject, bool>();
		ShareScreenshotResult screenshot = null;
		CancellationToken cancellationToken = this.GetCancellationTokenOnDestroy();
		try
		{
			List<ShareViewViewData.LootItemData> lootItems = (from item in lististResult
				where item?.PoolItem != null
				select new ShareViewViewData.LootItemData
				{
					Id = item.PoolItem.Id,
					Num = item.PoolItem.Count
				}).ToList();
			try
			{
				HideForScreenshot(ShareButton ? ShareButton.gameObject : null, hiddenStates);
				foreach (GameObject item in ShareHide)
				{
					HideForScreenshot(item, hiddenStates);
				}
				screenshot = await ShareScreenshotUtilities.CaptureFullScreenAsync(this);
			}
			finally
			{
				foreach (KeyValuePair<GameObject, bool> item2 in hiddenStates)
				{
					if ((bool)item2.Key)
					{
						item2.Key.SetActive(item2.Value);
					}
				}
			}
			cancellationToken.ThrowIfCancellationRequested();
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SHARE, new ShareViewViewData
			{
				Screenshot = screenshot,
				LootItems = lootItems
			});
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			Debug.LogError($"CardDrawSettleComponent: failed to prepare share screenshot.\n{arg}");
		}
		finally
		{
			if (screenshot != null && !screenshot.IsOwnedByView)
			{
				screenshot.Dispose();
			}
			_isSharing = false;
		}
	}

	private static void HideForScreenshot(GameObject target, Dictionary<GameObject, bool> hiddenStates)
	{
		if (!(target == null) && !hiddenStates.ContainsKey(target))
		{
			hiddenStates.Add(target, target.activeSelf);
			target.SetActive(value: false);
		}
	}
}
