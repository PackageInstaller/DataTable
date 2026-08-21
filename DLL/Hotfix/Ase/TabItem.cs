using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TabItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	protected GameObject selected;

	[SerializeField]
	private TextMeshProUGUI textSelected;

	[SerializeField]
	private Image iconSelected;

	[SerializeField]
	private TextMeshProUGUI englishSelected;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private TextMeshProUGUI textNormal;

	[SerializeField]
	private Image iconNormal;

	[SerializeField]
	private TextMeshProUGUI englishNormal;

	[SerializeField]
	private List<GameObject> reds;

	private TabItemData viewModel;

	public TabItemData ViewModel => viewModel;

	public void Init(TabItemData viewModel)
	{
		if (viewModel == null)
		{
			return;
		}
		this.viewModel = viewModel;
		BindingSet<TabItem, TabItemData> bindingSet = this.CreateBindingSet(viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((TabItemData vm) => vm.TabOnClick);
		}
		if (selected != null)
		{
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).ToExpression((TabItemData vm) => vm.IsSelected);
		}
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((TabItemData vm) => !vm.IsSelected);
		}
		if ((UnityEngine.Object)(object)textSelected != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(textSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemData vm) => vm.TextSelected);
		}
		if ((UnityEngine.Object)(object)englishSelected != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(englishSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemData vm) => vm.EnglishSelected);
		}
		if (iconSelected != null)
		{
			bindingSet.Bind(iconSelected).For((Image v) => v.sprite).To((TabItemData vm) => vm.IconSelected)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)textNormal != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(textNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemData vm) => vm.TextNormal);
		}
		if ((UnityEngine.Object)(object)englishNormal != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(englishNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TabItemData vm) => vm.EnglishNormal);
		}
		if (iconNormal != null)
		{
			bindingSet.Bind(iconNormal).For((Image v) => v.sprite).To((TabItemData vm) => vm.IconNormal)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind().For((TabItem v) => v.OnSelectChanged).To((TabItemData vm) => vm.OnSelectChangedRst);
		if (reds != null && reds.Count > 0)
		{
			foreach (GameObject red in reds)
			{
				bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((TabItemData vm) => vm.Red);
			}
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is TabItemData dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
		base.RefreshData(userData);
	}

	protected virtual void OnSelectChanged(object sender, InteractionEventArgs e)
	{
	}
}
