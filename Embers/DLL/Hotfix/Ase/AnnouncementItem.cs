using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AnnouncementItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject isNew;

	[SerializeField]
	private GameObject isSelected;

	[SerializeField]
	private TextMeshProUGUI dateNormal;

	[SerializeField]
	private TextMeshProUGUI dateSelected;

	[SerializeField]
	private TextMeshProUGUI title;

	private AnnouncementItemData viewModel;

	public void Init(AnnouncementItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AnnouncementItem, AnnouncementItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(isNew).For((GameObject v) => v.activeSelf).ToExpression((AnnouncementItemData vm) => !vm.Data.IsRead);
		bindingSet.Bind(isSelected).For((GameObject v) => v.activeSelf).To((AnnouncementItemData vm) => vm.IsSelected);
		bindingSet.Bind<TextMeshProUGUI>(dateNormal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementItemData vm) => vm.StartTime);
		bindingSet.Bind<TextMeshProUGUI>(dateSelected).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementItemData vm) => vm.StartTime);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementItemData vm) => vm.Data.Title);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((AnnouncementItemData vm) => vm.OnClick);
		bindingSet.Build();
	}

	public void RefreshData(AnnouncementItemData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
