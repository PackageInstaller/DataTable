using System.Collections.Generic;
using ACT.Event;
using ACT.UI.DataProxy;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoPopUpRewardOneRowView : BaseRewardView
{
	private PopUpRewardOneRowData m_data;

	private List<ItemUnifierProxy> _mergedItemList;

	private MonoEmptyForRaycast _scrollAreaRaycastBlock;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as PopUpRewardOneRowData;
	}

	protected override void ProcessRewardItems()
	{
	}

	protected override void ConfigureScrollBag()
	{
		base.ConfigureScrollBag();
		PopUpRewardOneRowData popUpRewardOneRowData = uiViewData as PopUpRewardOneRowData;
		if (popUpRewardOneRowData?.itemSource != null)
		{
			_mergedItemList = BuildRewardItemProxies(popUpRewardOneRowData.itemSource);
			scrollBag.ItemSource = _mergedItemList;
		}
		else
		{
			scrollBag.ItemSource = null;
			_mergedItemList = null;
		}
	}

	protected override void PlayOpenAnimation()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Reward");
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PopRewardOpened, null);
		betterAnimation.GetSequence("RewardShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (_mergedItemList != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_mergedItemList);
			_mergedItemList = null;
		}
		(uiViewData as PopUpRewardOneRowData)?.callBack?.Invoke();
	}

	protected override void Resize()
	{
		GridLayoutGroup component = _content.GetComponent<GridLayoutGroup>();
		RectTransform viewport = _scrollView.GetComponent<LoopVerticalScrollRect>().viewport;
		if (!(component == null) && !(viewport == null))
		{
			int childCount = ((_mergedItemList != null) ? _mergedItemList.Count : 0);
			bool flag = IsGridOverflow(component, childCount, viewport);
			if (_scrollAreaRaycastBlock == null)
			{
				_scrollAreaRaycastBlock = _scrollView.GetComponentInChildren<MonoEmptyForRaycast>(includeInactive: true);
			}
			if (_scrollAreaRaycastBlock != null)
			{
				_scrollAreaRaycastBlock.raycastTarget = flag;
			}
			if (flag)
			{
				_content.anchorMax = new Vector2(0.5f, 1f);
				_content.anchorMin = new Vector2(0.5f, 1f);
				_content.pivot = new Vector2(0.5f, 1f);
				_content.anchoredPosition = new Vector2(_content.anchoredPosition.x, 0f);
				component.childAlignment = TextAnchor.UpperLeft;
			}
			else
			{
				_content.anchorMax = new Vector2(0.5f, 0.5f);
				_content.anchorMin = new Vector2(0.5f, 0.5f);
				_content.pivot = new Vector2(0.5f, 0.5f);
				_content.anchoredPosition = new Vector2(_content.anchoredPosition.x, 0f);
				component.childAlignment = TextAnchor.MiddleCenter;
			}
		}
	}

	private bool IsGridOverflow(GridLayoutGroup grid, int childCount, RectTransform viewport)
	{
		if (childCount <= 0)
		{
			return false;
		}
		int num;
		int num2;
		if (grid.constraint == GridLayoutGroup.Constraint.FixedColumnCount)
		{
			num = grid.constraintCount;
			num2 = Mathf.CeilToInt((float)childCount / (float)num);
		}
		else if (grid.constraint == GridLayoutGroup.Constraint.FixedRowCount)
		{
			num2 = grid.constraintCount;
			num = Mathf.CeilToInt((float)childCount / (float)num2);
		}
		else
		{
			int b = Mathf.FloorToInt((viewport.rect.width - (float)grid.padding.left - (float)grid.padding.right + grid.spacing.x) / (grid.cellSize.x + grid.spacing.x));
			b = Mathf.Max(1, b);
			num = b;
			num2 = Mathf.CeilToInt((float)childCount / (float)num);
		}
		float num3 = (float)(grid.padding.left + grid.padding.right) + (float)num * grid.cellSize.x + (float)(num - 1) * grid.spacing.x;
		if (!((float)(grid.padding.top + grid.padding.bottom) + (float)num2 * grid.cellSize.y + (float)(num2 - 1) * grid.spacing.y > viewport.rect.height))
		{
			return num3 > viewport.rect.width;
		}
		return true;
	}
}
