using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BTEntityView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI entityId;

	[SerializeField]
	private TextMeshProUGUI configId;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private LoopListView2 buffList;

	[SerializeField]
	private Button btn;

	private BTEntityViewModel viewModel;

	public void Init(BTEntityViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<BTEntityView, BTEntityViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(entityId).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTEntityViewModel vm) => $"实体Id：{vm.EntityId}");
		bindingSet.Bind<TextMeshProUGUI>(configId).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTEntityViewModel vm) => $"配置Id：{vm.ConfigId}");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BTEntityViewModel vm) => $"实体名称：{vm.Name}");
		bindingSet.Bind(this).For((BTEntityView v) => v.UpdateBuffList).To((BTEntityViewModel vm) => vm.UpdateBuffListRequest);
		bindingSet.Build();
		buffList.InitListView(viewModel.Count, OnGetEntityItemByIndex);
		btn.onClick.AddListener(this.viewModel.UpdateEntityBuffs);
	}

	public void RefreshData(BTEntityViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private void UpdateBuffList(object sender, InteractionEventArgs e)
	{
		buffList.SetListItemCount(viewModel.Count);
		buffList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetEntityItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BuffItem");
		if (loopListViewItem != null)
		{
			BTBuffView component = loopListViewItem.GetComponent<BTBuffView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BtbVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BtbVMs[index]);
			}
		}
		return loopListViewItem;
	}
}
