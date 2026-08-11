using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleDSView : UGuiView
{
	[SerializeField]
	private LoopListView2 dsListList;

	[SerializeField]
	private RectTransform BgImage;

	[SerializeField]
	private CanvasGroup ContentCanvasGroup;

	[SerializeField]
	private Button ContentBtn;

	[SerializeField]
	private Transform arrow;

	[SerializeField]
	private Animation downStateAni;

	private BattleDSViewModel viewModel;

	private bool isShow = true;

	public List<float> bgLength;

	[SerializeField]
	private Transform downDamageTrans;

	[SerializeField]
	private DownDamageInfoView downDamageInfoView;

	[SerializeField]
	private TextMeshProUGUI totalDownDamage;

	private List<DownDamageInfoView> showDownDamageInfoViews;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleDSViewModel>(userData);
		BindingSet<BattleDSView, BattleDSViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleDSView v) => v.OnChangeDSShowRequest).To((BattleDSViewModel vm) => vm.ChangeDSShowRequest);
		bindingSet.Bind(this).For((BattleDSView v) => v.OnBossDownStateRequest).To((BattleDSViewModel vm) => vm.BossDownStateRequest);
		bindingSet.Bind<TextMeshProUGUI>(totalDownDamage).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleDSViewModel vm) => vm.TotalDownDamageText);
		bindingSet.Build();
		base.transform.parent = viewModel.Root;
		dsListList.InitListView(viewModel.ItemVMs.Count, OnGetDsListItemByIndex);
		SetBgSize();
		ContentBtn.onClick.AddListener(OnClickBtn);
		RefreshDownDamageView();
	}

	public override void OnShow()
	{
		if (viewModel != null)
		{
			SetBgSize();
			if (!dsListList.IsInited)
			{
				dsListList.InitListView(viewModel.ItemVMs.Count, OnGetDsListItemByIndex);
			}
			else
			{
				dsListList.SetListItemCount(viewModel.ItemVMs.Count);
				dsListList.RefreshAllShownItem();
			}
			RefreshDownDamageView();
		}
	}

	private void OnClickBtn()
	{
		if (isShow)
		{
			DOTweenModuleUI.DOFade(ContentCanvasGroup, 0f, 0.1f);
			isShow = false;
		}
		else
		{
			DOTweenModuleUI.DOFade(ContentCanvasGroup, 1f, 0.1f);
			isShow = true;
		}
		arrow.localEulerAngles = -arrow.localEulerAngles;
	}

	private void SetBgSize()
	{
		float num = bgLength[viewModel.ItemVMs.Count - 1];
		BgImage.sizeDelta = new Vector2(0f, 0f - num);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleDSViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetDsListItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ItemVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("DamageInfo");
		if (loopListViewItem != null)
		{
			DamageInfoView component = loopListViewItem.GetComponent<DamageInfoView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemVMs.Values.ToList()[index]);
			}
			else
			{
				component.UpdateData(viewModel.ItemVMs.Values.ToList()[index]);
			}
		}
		return loopListViewItem;
	}

	private void OnChangeDSShowRequest(object sender, InteractionEventArgs args)
	{
		dsListList.SetListItemCount(viewModel.ItemVMs.Count);
		dsListList.RefreshAllShownItem();
		RefreshDownDamageView();
	}

	private void OnBossDownStateRequest(object sender, InteractionEventArgs args)
	{
		if (viewModel.DownState)
		{
			((Component)(object)downStateAni).gameObject.SetActive(value: true);
			downStateAni.Play("Downed_enter");
		}
		else
		{
			downStateAni.Play("Downed_out");
		}
	}

	private void RefreshDownDamageView()
	{
		int count = viewModel.ItemVMs.Count;
		if (showDownDamageInfoViews == null)
		{
			showDownDamageInfoViews = new List<DownDamageInfoView>(3);
		}
		if (count > showDownDamageInfoViews.Count)
		{
			int num = count - showDownDamageInfoViews.Count;
			for (int i = 0; i < num; i++)
			{
				DownDamageInfoView component = UnityEngine.Object.Instantiate(this.downDamageInfoView.gameObject, downDamageTrans).GetComponent<DownDamageInfoView>();
				showDownDamageInfoViews.Add(component);
			}
		}
		for (int j = 0; j < showDownDamageInfoViews.Count; j++)
		{
			showDownDamageInfoViews[j].gameObject.SetActive(j < count);
		}
		int num2 = 0;
		foreach (DamageInfoViewModel value in viewModel.ItemVMs.Values)
		{
			DownDamageInfoView downDamageInfoView = showDownDamageInfoViews[num2];
			if (!downDamageInfoView.IsInitHandlerCalled)
			{
				downDamageInfoView.Init(value);
			}
			else
			{
				downDamageInfoView.RefreshData(value);
			}
			num2++;
		}
	}
}
