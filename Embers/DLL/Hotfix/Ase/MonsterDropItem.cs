using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class MonsterDropItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private TextMeshProUGUI limitText;

	private MonsterDropItemData _viewModel;

	public void Init(MonsterDropItemData data)
	{
		_viewModel = data;
		BindingSet<MonsterDropItem, MonsterDropItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MonsterDropItemData vm) => vm.NameText);
		bindingSet.Build();
	}

	public void RefreshData(MonsterDropItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
