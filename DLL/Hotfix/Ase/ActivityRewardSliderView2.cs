using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityRewardSliderView2 : UGuiView
{
	[SerializeField]
	private RectTransform ParentRectTransform;

	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private Image rewardIcon;

	[SerializeField]
	private TextMeshProUGUI pointText;

	[SerializeField]
	private Image activityFill;

	[SerializeField]
	private GameObject rewardItem;

	[SerializeField]
	private GameObject fillObj;

	[SerializeField]
	private GameObject rewardDetailView;

	[SerializeField]
	private Button closeRewardDetailView;

	[SerializeField]
	private Transform rewardDetailViewRect;

	[SerializeField]
	private GameObject rewardDetailItem;

	[SerializeField]
	private RectTransform expEffectFillRect;

	[SerializeField]
	private UIParticlePlayer expAddPlayer;

	[SerializeField]
	private UIParticlePlayer expFillHeadPlayer;

	[SerializeField]
	private UIParticlePlayer expFillPlayer;

	[SerializeField]
	private int fixDuration;

	[SerializeField]
	private float rewardViewOffset;

	[SerializeField]
	private RectTransform posItem;

	private ActivityRewardSlider2ViewModel viewModel;

	private int duration;

	private Timer addExpTimer;

	private float curExpWidth;

	private float perExpAdd;

	public void Init(ActivityRewardSlider2ViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ActivityRewardSliderView2, ActivityRewardSlider2ViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(rewardIcon).For((Image v) => v.sprite).ToExpression((ActivityRewardSlider2ViewModel vm) => vm.IconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(pointText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityRewardSlider2ViewModel vm) => vm.GameActivityPointText);
		bindingSet.Bind(this).For((ActivityRewardSliderView2 v) => v.PlayEffectList).To((ActivityRewardSlider2ViewModel vm) => vm.PlayEffectRequest);
		bindingSet.Bind(this).For((ActivityRewardSliderView2 v) => v.OpenRewardDetailView).To((ActivityRewardSlider2ViewModel vm) => vm.OpenRewardDetailViewRequest);
		bindingSet.Build();
		if (fixDuration <= 0)
		{
			fixDuration = 1;
		}
		SetRewardListItemPadding();
		rewardItemList.InitListView(viewModel.RewardItemList.Count, OnGetRewardItemByIndex);
		rewardItemList.ScrollRect.horizontal = false;
		rewardItemList.ScrollRect.vertical = false;
		SetFillStartPos();
		closeRewardDetailView.onClick.AddListener(delegate
		{
			rewardDetailView.gameObject.SetActive(value: false);
		});
	}

	private void SetFillStartPos()
	{
		float width = fillObj.GetComponent<RectTransform>().rect.width;
		if (expEffectFillRect != null)
		{
			expEffectFillRect.sizeDelta = new Vector2(width * viewModel.GameActivityFill, 30f);
		}
		activityFill.fillAmount = viewModel.GameActivityFill;
	}

	private void PlayEffectList(object sender, InteractionEventArgs e)
	{
		float width = fillObj.GetComponent<RectTransform>().rect.width;
		if (expEffectFillRect != null)
		{
			expEffectFillRect.sizeDelta = new Vector2(width * viewModel.GameOldActivityFill, 30f);
		}
		activityFill.fillAmount = viewModel.GameOldActivityFill;
		duration = fixDuration;
		if (expFillHeadPlayer != null)
		{
			expFillHeadPlayer.Play();
		}
		if (expAddPlayer != null)
		{
			expAddPlayer.Hide();
			expAddPlayer.Play();
		}
		if (expEffectFillRect != null)
		{
			curExpWidth = expEffectFillRect.rect.width;
		}
		float num = width * viewModel.GameActivityFill;
		perExpAdd = (num - curExpWidth) / (float)duration;
		if (expFillPlayer != null)
		{
			expFillPlayer.Play();
			CloseAddExpTimer();
			addExpTimer = Timer.Register(0.01f, AddExp, null, isLooped: true, useRealTime: true);
		}
		else
		{
			activityFill.fillAmount = viewModel.GameActivityFill;
		}
	}

	private void AddExp()
	{
		duration--;
		if (duration < 0)
		{
			activityFill.fillAmount = viewModel.GameActivityFill;
			expFillPlayer.Hide();
			CloseAddExpTimer();
			return;
		}
		curExpWidth += perExpAdd;
		if (expEffectFillRect != null)
		{
			expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 30f);
		}
	}

	private void CloseAddExpTimer()
	{
		if (addExpTimer != null)
		{
			addExpTimer.Cancel();
			addExpTimer = null;
		}
	}

	private void OpenRewardDetailView(object sender, InteractionEventArgs e)
	{
		ClearObj();
		foreach (KnapsackItemViewModel showRewardItemData in viewModel.ShowRewardItemDataList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(rewardDetailItem, rewardDetailViewRect);
			obj.transform.GetComponent<KnapsackItemNew>().Init(showRewardItemData);
			obj.gameObject.SetActive(value: true);
		}
		if (posItem != null)
		{
			GameActivityRewardItem[] componentsInChildren = rewardItemList.ScrollRect.content.GetComponentsInChildren<GameActivityRewardItem>();
			RectTransform parent = null;
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				if (componentsInChildren[i].GetVm == viewModel.CurSelItem)
				{
					parent = componentsInChildren[i].RectTransform;
				}
			}
			posItem.SetParent(parent);
			posItem.anchoredPosition = Vector2.zero;
			posItem.SetParent(rewardDetailView.GetComponent<RectTransform>());
			Vector2 anchoredPosition = rewardDetailViewRect.GetComponent<RectTransform>().anchoredPosition;
			rewardDetailViewRect.GetComponent<RectTransform>().anchoredPosition = new Vector2(posItem.anchoredPosition.x, anchoredPosition.y);
		}
		else
		{
			float num = ParentRectTransform.rect.width - RectTransform.rect.width - rewardViewOffset;
			float newValue = ((float)e.Context + num) * RectTransform.lossyScale.x;
			rewardDetailViewRect.GetComponent<RectTransform>().SetPositionX(newValue);
		}
		rewardDetailView.gameObject.SetActive(value: true);
	}

	private void SetRewardListItemPadding()
	{
		float width = rewardItem.GetComponent<RectTransform>().rect.width;
		float width2 = fillObj.GetComponent<RectTransform>().rect.width;
		int count = viewModel.RewardItemList.Count;
		float itemPadding = (width2 - width * (float)count) / (float)count;
		rewardItemList.SetItemPadding(itemPadding);
		for (int i = 0; i < rewardItemList.ItemList.Count; i++)
		{
			rewardItemList.OnItemSizeChanged(i);
		}
	}

	private void ClearObj()
	{
		for (int i = 0; i < rewardDetailViewRect.childCount; i++)
		{
			UnityEngine.Object.Destroy(rewardDetailViewRect.GetChild(i).gameObject);
		}
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ActivityRewardItem");
		if (loopListViewItem != null)
		{
			GameActivityRewardItem component = loopListViewItem.GetComponent<GameActivityRewardItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemList[index]);
			}
			else
			{
				component.RefreshGameActivityRewardItem(viewModel.RewardItemList[index]);
			}
		}
		return loopListViewItem;
	}
}
