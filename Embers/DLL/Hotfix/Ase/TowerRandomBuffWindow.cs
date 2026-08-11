using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerRandomBuffWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI refreshCount1;

	[SerializeField]
	private TextMeshProUGUI refreshCount2;

	[SerializeField]
	private TextMeshProUGUI getCount;

	[SerializeField]
	private Button refreshBtn;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private GameObject confirmActive;

	[SerializeField]
	private GameObject confirmDisactive;

	[SerializeField]
	private GameObject refreshActive;

	[SerializeField]
	private GameObject refreshDisactive;

	[SerializeField]
	private RandomBuffItemView buffItem;

	[SerializeField]
	private Transform buffItemParent;

	private TowerRandomBuffViewModel viewModel;

	private List<RandomBuffItemView> randomBuffItemViews;

	protected override void OnInit()
	{
		base.OnInit();
		viewModel = GetData<TowerRandomBuffViewModel>();
		BindingSet<TowerRandomBuffWindow, TowerRandomBuffViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(refreshCount1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TowerRandomBuffViewModel vm) => $"x{vm.RefreshCount}");
		bindingSet.Bind<TextMeshProUGUI>(refreshCount2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TowerRandomBuffViewModel vm) => $"x{vm.RefreshCount}");
		bindingSet.Bind<TextMeshProUGUI>(getCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerRandomBuffViewModel vm) => vm.SelectCountText);
		bindingSet.Bind(confirmActive).For((GameObject v) => v.activeSelf).To((TowerRandomBuffViewModel vm) => vm.CanConfirm);
		bindingSet.Bind(confirmDisactive).For((GameObject v) => v.activeSelf).ToExpression((TowerRandomBuffViewModel vm) => !vm.CanConfirm);
		bindingSet.Bind(refreshActive).For((GameObject v) => v.activeSelf).To((TowerRandomBuffViewModel vm) => vm.CanRefresh);
		bindingSet.Bind(refreshDisactive).For((GameObject v) => v.activeSelf).ToExpression((TowerRandomBuffViewModel vm) => !vm.CanRefresh);
		bindingSet.Bind(this).For((TowerRandomBuffWindow v) => v.OnDismissRequest).To((TowerRandomBuffViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		refreshBtn.onClick.AddListener(ClickRefreshBtn);
		confirmBtn.onClick.AddListener(ClickConfirmBtn);
		RefreshRandomBuffItem();
	}

	private void ClickRefreshBtn()
	{
		viewModel.ClickRefresh();
		RefreshRandomBuffItem();
	}

	private void ClickConfirmBtn()
	{
		viewModel.ClickConfirm();
	}

	private void RefreshRandomBuffItem()
	{
		if (randomBuffItemViews == null)
		{
			randomBuffItemViews = new List<RandomBuffItemView>(viewModel.RandomBuffCount);
			for (int i = 0; i < viewModel.RandomBuffCount; i++)
			{
				GameObject obj = UnityEngine.Object.Instantiate(buffItem.gameObject, buffItemParent);
				obj.SetActive(value: true);
				obj.transform.localPosition = Vector3.zero;
				RandomBuffItemView component = obj.GetComponent<RandomBuffItemView>();
				randomBuffItemViews.Add(component);
				component.Init(viewModel.RandomBuffVM[i]);
			}
		}
		else
		{
			for (int j = 0; j < viewModel.RandomBuffCount; j++)
			{
				randomBuffItemViews[j].RefreshData(viewModel.RandomBuffVM[j]);
			}
		}
	}
}
