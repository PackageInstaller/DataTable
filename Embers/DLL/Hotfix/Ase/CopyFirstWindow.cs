using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyFirstWindow : CopyPlayUnlockEffectWindow
{
	public float ani1Dura;

	public float ani2Dura;

	public MoneyView MoneyView;

	public List<GameObject> groupList;

	public LoopListView2 groupItemList;

	public LoopListView2 type1ItemList;

	public List<CopyType2ItemView> type2ItemList;

	public ScrollRect scrollRect;

	public float t2ItemHeight;

	public Button btnArrow;

	public Button btnBack;

	public Button btnTrain;

	public CopyPermitView permitView;

	public ViewSOControl soControl;

	private CopyFirstViewModel viewModel;

	private float srH;

	private float bottom;

	private float goPos;

	private bool isAddTimeUpdater;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopyFirstViewModel>();
		BindingSet<CopyFirstWindow, CopyFirstViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopyFirstWindow v) => v.OnDismissRequest).To((CopyFirstViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopyFirstWindow v) => v.OpenUguiWindow).To((CopyFirstViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopyFirstWindow v) => v.OnOpenGroup).To((CopyFirstViewModel vm) => vm.OpenGroupRequest);
		bindingSet.Bind(this).For((CopyFirstWindow v) => v.OnOpt).To((CopyFirstViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopyFirstViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnTrain).For((Button v) => v.onClick).To((CopyFirstViewModel vm) => vm.OpenType99);
		bindingSet.Build();
		groupItemList.InitListView(viewModel.GroupList.Count, OnGetGroupItemItemByIndex);
		ShowGroup(viewModel.CopyMainId);
		MoneyView.Init(new MoneyViewModel(viewModel));
		InitRoot2Scroll();
		SetAniMaskDuration((viewModel.CopyMainId == 1) ? ani1Dura : (ani2Dura * viewModel.GetUnlockRatio()));
	}

	private void InitRoot2Scroll()
	{
		scrollRect.content.anchoredPosition = new Vector2(0f, scrollRect.content.sizeDelta.y);
		scrollRect.onValueChanged.AddListener(OnScrollRectBarChange);
		srH = scrollRect.GetComponent<RectTransform>().rect.height;
		btnArrow.onClick.AddListener(delegate
		{
			scrollRect.normalizedPosition = new Vector2(1f, goPos);
		});
		scrollRect.normalizedPosition = new Vector2(0f, goPos);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			SettleOpt("RefreshGroup");
			SetTypeArrow();
		}
	}

	private void SetTypeArrow()
	{
		scrollRect.content.anchoredPosition = new Vector2(0f, scrollRect.content.sizeDelta.y);
		OnScrollRectBarChange(new Vector2(0f, -0.1f));
		scrollRect.normalizedPosition = new Vector2(1f, goPos);
		btnArrow.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshGroup".Equals(optName))
		{
			groupItemList.SetListItemCount(viewModel.GroupList.Count);
		}
	}

	private void OnOpenGroup(object sender, InteractionEventArgs e)
	{
		int num = (int)e.Context;
		ShowGroup(num);
		if (num == 2)
		{
			SetTypeArrow();
		}
		CheckPlayUnlockEffect(num);
	}

	private void ShowGroup(int index)
	{
		for (int i = 0; i < groupList.Count; i++)
		{
			groupList[i].SetActive(i + 1 == index);
		}
		switch (index)
		{
		case 1:
			if (!type1ItemList.IsInited)
			{
				type1ItemList.InitListView(viewModel.TypeVms.Count, OnGetTypeItemItemByIndex);
				break;
			}
			type1ItemList.SetListItemCount(viewModel.TypeVms.Count);
			type1ItemList.RefreshAllShownItem();
			break;
		case 2:
		{
			for (int j = 0; j < type2ItemList.Count; j++)
			{
				if (j >= viewModel.TypeVms.Count)
				{
					type2ItemList[j].gameObject.SetActive(value: false);
					continue;
				}
				type2ItemList[j].Init(viewModel.TypeVms[j]);
				type2ItemList[j].gameObject.SetActive(value: true);
			}
			permitView.Init(viewModel.PermitVm);
			UpdateType2ItemServerTime();
			break;
		}
		}
	}

	private void OnScrollRectBarChange(Vector2 v2)
	{
		bottom = scrollRect.content.anchoredPosition.y - scrollRect.content.rect.height;
		for (int num = type2ItemList.Count - 1; num >= 0; num--)
		{
			if (type2ItemList[num].CheckOpen())
			{
				float num2 = type2ItemList[num].GetComponent<RectTransform>().anchoredPosition.y + t2ItemHeight;
				bool flag = bottom + num2 <= srH;
				if (!flag)
				{
					float value = (num2 - srH) / (scrollRect.content.rect.height - srH);
					goPos = Mathf.Clamp01(value);
				}
				else
				{
					goPos = 0f;
				}
				btnArrow.gameObject.SetActive(!flag);
				break;
			}
		}
	}

	private LoopListViewItem2 OnGetTypeItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TypeVms.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyType1ItemView");
		if (loopListViewItem != null)
		{
			CopyType1ItemView component = loopListViewItem.GetComponent<CopyType1ItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TypeVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.TypeVms[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetGroupItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.GroupList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyGroupItemView");
		if (loopListViewItem != null)
		{
			CopyGroupItemView component = loopListViewItem.GetComponent<CopyGroupItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.GroupList[index]);
				component.AddSOControl(soControl);
			}
			else
			{
				component.RefreshData(viewModel.GroupList[index]);
			}
		}
		return loopListViewItem;
	}

	private void UpdateType2ItemServerTime()
	{
		if (!isAddTimeUpdater)
		{
			CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
			copyVM.typeRefreshAction = (Action<long>)Delegate.Combine(copyVM.typeRefreshAction, new Action<long>(UpdateType2ItemServerTime));
			isAddTimeUpdater = true;
		}
	}

	private void UpdateType2ItemServerTime(long t)
	{
		if (type2ItemList != null)
		{
			for (int i = 0; i < type2ItemList.Count; i++)
			{
				type2ItemList[i].lockText.UpdateServerTime(t);
			}
		}
	}

	protected override void OnDestroy()
	{
		CopyViewModel copyViewModel = Singleton<ServiceSystem>.Instance?.GetService<ICopyService>()?.GetCopyVM();
		if (copyViewModel != null)
		{
			copyViewModel.typeRefreshAction = (Action<long>)Delegate.Remove(copyViewModel.typeRefreshAction, new Action<long>(UpdateType2ItemServerTime));
		}
		base.OnDestroy();
	}

	public override bool CheckNeedPlayEffect()
	{
		return viewModel.CheckNeedPlayEffect();
	}

	public override void PlayUnlockEffect()
	{
		if (viewModel.CopyMainId == 1)
		{
			int newUnlockIndex = viewModel.GetNewUnlockIndex();
			type1ItemList.MovePanelToItemIndex(newUnlockIndex, 0f);
		}
		viewModel.PlayUnlockEffect();
	}

	private void CheckPlayUnlockEffect(int index)
	{
		if (index == 1 || index == 2)
		{
			SetAniMaskDuration((viewModel.CopyMainId == 1) ? ani1Dura : (ani2Dura * viewModel.GetUnlockRatio()));
			OnOpenPlayAniMask();
		}
	}
}
