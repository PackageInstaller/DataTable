using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatChannelItemView : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject redRoot;

	[SerializeField]
	private GameObject selectedRoot;

	[SerializeField]
	private GameObject unSelectedRoot;

	[SerializeField]
	private TextMeshProUGUI name1;

	[SerializeField]
	private TextMeshProUGUI name2;

	private ChatChannelItemViewModel viewModel;

	public void Init(ChatChannelItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ChatChannelItemView, ChatChannelItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((ChatChannelItemViewModel vm) => vm.OnClick);
		bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).To((ChatChannelItemViewModel vm) => vm.HasNew);
		bindingSet.Bind(selectedRoot).For((GameObject v) => v.activeSelf).To((ChatChannelItemViewModel vm) => vm.IsSelected);
		bindingSet.Bind(unSelectedRoot).For((GameObject v) => v.activeSelf).ToExpression((ChatChannelItemViewModel vm) => !vm.IsSelected);
		bindingSet.Bind<TextMeshProUGUI>(name1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatChannelItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatChannelItemViewModel vm) => vm.Name);
		bindingSet.Build();
	}

	public void RefreshData(ChatChannelItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
