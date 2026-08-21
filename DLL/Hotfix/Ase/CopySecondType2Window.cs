using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType2Window : CopyPlayUnlockEffectWindow
{
	public MoneyView MoneyView;

	public List<GameObject> detailReplayAnimations;

	public Animator animator;

	public string detailOpen;

	public string detailClose;

	public GameObject dragMask;

	public Button btnUp;

	public Button btnDown;

	public Button btnBack;

	public Button btnCloseDetail;

	public RectTransform miniItemRoot;

	public RectTransform miniItemTempl;

	private List<CopyItem2View> miniItemList;

	public CopyItemDetail2View detailView;

	public GameObject leftRoot;

	public VerticalLayoutGroup leftItemRoot;

	public LoopListView2 leftList;

	public CopyType2ItemView type2ItemTempl;

	private List<CopyType2ItemView> leftItems;

	public int leftMaxShowCount = 5;

	public GameObject arrowItem;

	public RectTransform middleRoot;

	public RectTransform middlePos1;

	public RectTransform middlePos2;

	public CopySecondTouch secondTouch;

	public RectTransform miniPos1;

	public RectTransform miniPos2;

	public CopyPermitView permitView;

	private CopySecondType2ViewModel viewModel;

	private bool isInit = true;

	private bool isPlayAni;

	private bool isUpper;

	private float dura;

	private bool showDetailAfterAni;

	private bool isMiddle = true;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySecondType2ViewModel>();
		BindingSet<CopySecondType2Window, CopySecondType2ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType2Window v) => v.OnDismissRequest).To((CopySecondType2ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySecondType2Window v) => v.OpenUguiWindow).To((CopySecondType2ViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopySecondType2Window v) => v.OnOpt).To((CopySecondType2ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnCloseDetail).For((Button v) => v.onClick).To((CopySecondType2ViewModel vm) => vm.OptCommand)
			.CommandParameter("CloseDetail");
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopySecondType2ViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Build();
		MoneyView.Init(new MoneyViewModel(viewModel));
		permitView.Init(viewModel.PermitVm);
		btnCloseDetail.gameObject.SetActive(value: false);
		dragMask.SetActive(value: false);
		InitLeft();
		RefreshMiniItems();
		secondTouch.AddAction(UpdateItem);
		if (viewModel.CopyDetailVm == null)
		{
			detailView.gameObject.SetActive(value: false);
			SetMiniPos(miniPos1);
		}
		else
		{
			detailView.gameObject.SetActive(value: true);
			btnCloseDetail.gameObject.SetActive(value: true);
			detailView.Init(viewModel.CopyDetailVm);
			SetMiniPos(miniPos2);
			SetMiddlePos(middle: false, isBack: true);
		}
		btnUp.onClick.AddListener(delegate
		{
		});
		btnDown.onClick.AddListener(delegate
		{
		});
		secondTouch.Init(viewModel);
	}

	private void InitLeft()
	{
		int openCount = viewModel.GetTypeOpenCount();
		leftList.InitListView(openCount, OnGetTypeItemByIndex);
		LoopListView2 loopListView = leftList;
		loopListView.onChangeContentSize = (Action)Delegate.Combine(loopListView.onChangeContentSize, (Action)delegate
		{
			if (openCount <= leftMaxShowCount)
			{
				leftItemRoot.enabled = true;
				leftList.ScrollRect.enabled = false;
				Vector2 sizeDelta = leftList.GetComponent<RectTransform>().sizeDelta;
				Vector2 sizeDelta2 = leftItemRoot.GetComponent<RectTransform>().sizeDelta;
				leftItemRoot.GetComponent<RectTransform>().sizeDelta = new Vector2(sizeDelta2.x, sizeDelta.y);
				arrowItem.SetActive(value: false);
			}
			else
			{
				leftItemRoot.enabled = false;
				leftList.ScrollRect.enabled = true;
				leftList.ScrollRect.onValueChanged.AddListener(ShowArrowItem);
			}
		});
		if (openCount > leftMaxShowCount)
		{
			int selectTypeIndex = viewModel.GetSelectTypeIndex();
			arrowItem.SetActive(selectTypeIndex + 1 != openCount);
			leftList.MovePanelToItemIndex(openCount - 1 - selectTypeIndex, 0f);
		}
		type2ItemTempl.gameObject.SetActive(value: false);
	}

	private void ShowArrowItem(Vector2 v)
	{
		arrowItem.SetActive(v.y < 0.9f);
	}

	private LoopListViewItem2 OnGetTypeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TypeVms.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyTypeItemView");
		if (loopListViewItem != null)
		{
			CopyType2ItemView component = loopListViewItem.GetComponent<CopyType2ItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.GetCopyTypeByIndex(index));
			}
			else
			{
				component.RefreshData(viewModel.GetCopyTypeByIndex(index));
			}
		}
		return loopListViewItem;
	}

	private void UpdateItem(CopyItem2View copyItem2View)
	{
		int index = copyItem2View.Index;
		viewModel.SetSelectIndex(index);
	}

	private void SetMiniPos(RectTransform pos)
	{
		miniItemRoot.anchoredPosition = new Vector2(pos.anchoredPosition.x, miniItemRoot.anchoredPosition.y);
	}

	private void SetMiddlePos(bool middle, bool isBack = false)
	{
		if (isBack && !middle)
		{
			isMiddle = middle;
			((Behaviour)(object)animator).enabled = false;
			RectTransform rectTransform = (middle ? middlePos1 : middlePos2);
			middleRoot.anchoredPosition = new Vector2(rectTransform.anchoredPosition.x, middleRoot.anchoredPosition.y);
			leftRoot.gameObject.SetActive(middle);
		}
		else if (isMiddle != middle)
		{
			isMiddle = middle;
			if (!leftRoot.gameObject.activeSelf)
			{
				leftRoot.gameObject.SetActive(value: true);
				btnBack.gameObject.SetActive(value: true);
			}
			if (!((Behaviour)(object)animator).enabled)
			{
				((Behaviour)(object)animator).enabled = true;
			}
			animator.Play(middle ? detailClose : detailOpen);
		}
	}

	private void RefreshMiniItems()
	{
		if (miniItemList == null)
		{
			miniItemList = new List<CopyItem2View>();
		}
		for (int i = 0; i < viewModel.CopyItemVms.Count; i++)
		{
			if (i >= miniItemList.Count)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(miniItemTempl.gameObject, miniItemRoot);
				if (gameObject != null)
				{
					CopyItem2View component = gameObject.GetComponent<CopyItem2View>();
					miniItemList.Add(component);
					component.Init(viewModel.CopyItemVms[i]);
					gameObject.gameObject.SetActive(value: true);
				}
			}
			else
			{
				miniItemList[i].RefreshData(viewModel.CopyItemVms[i]);
				miniItemList[i].gameObject.SetActive(value: true);
			}
		}
		for (int j = viewModel.CopyItemVms.Count; j < miniItemList.Count; j++)
		{
			miniItemList[j].gameObject.SetActive(value: false);
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenDetail".Equals(optName))
		{
			if (detailView.gameObject.activeSelf)
			{
				PlayDetailViewAni();
			}
			detailView.gameObject.SetActive(value: true);
			btnCloseDetail.gameObject.SetActive(value: true);
			detailView.Init(viewModel.CopyDetailVm);
			SetMiniPos(miniPos2);
			SetMiddlePos(middle: false);
		}
		else if ("CloseDetail".Equals(optName))
		{
			detailView.gameObject.SetActive(value: false);
			btnCloseDetail.gameObject.SetActive(value: false);
			SetMiddlePos(middle: true);
			SetMiniPos(miniPos1);
		}
		else if ("RefreshCopyItems".Equals(optName))
		{
			RefreshMiniItems();
			secondTouch.RefreshList();
			OnOpenPlayAniMask();
		}
		else if ("AutoPlay2Click".Equals(optName))
		{
			secondTouch.AutoPlay2Index(viewModel.NextSelIndex);
		}
		else if ("CheckLeftTabPlayUnlockEffect".Equals(optName))
		{
			OnOpenPlayAniMask();
			if (viewModel.CheckNeedPlayLeftTabEffect())
			{
				int curTypeMaxIndex = viewModel.GetCurTypeMaxIndex();
				int typeOpenCount = viewModel.GetTypeOpenCount();
				leftList.MovePanelToItemIndex(typeOpenCount - 1 - curTypeMaxIndex, 0f);
				arrowItem.SetActive(curTypeMaxIndex + 1 != typeOpenCount);
			}
		}
		else if ("RefreshCopyList".Equals(optName))
		{
			secondTouch.RefreshList();
		}
	}

	private void PlayDetailViewAni()
	{
		if (detailReplayAnimations == null || detailReplayAnimations.Count == 0)
		{
			return;
		}
		for (int i = 0; i < detailReplayAnimations.Count; i++)
		{
			if (detailReplayAnimations[i] == null || !detailReplayAnimations[i].activeSelf)
			{
				continue;
			}
			Animation[] componentsInChildren = detailReplayAnimations[i].GetComponentsInChildren<Animation>();
			if (componentsInChildren != null)
			{
				for (int j = 0; j < componentsInChildren.Length; j++)
				{
					componentsInChildren[j].Play();
				}
			}
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		if (viewModel != null)
		{
			viewModel.SaveSelectItem();
		}
	}

	public override bool CheckNeedPlayEffect()
	{
		if (!viewModel.CheckNeedPlayMiddleEffect())
		{
			return viewModel.CheckNeedPlayLeftTabEffect();
		}
		return true;
	}

	public override void PlayUnlockEffect()
	{
		viewModel.PlayLeftUnlockEffect();
		viewModel.PlayMiddleUnlockEffect();
	}
}
