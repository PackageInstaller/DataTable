using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AnnouncementPopupWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI date;

	[SerializeField]
	private TextMeshProUGUI version;

	[SerializeField]
	private TextMeshProUGUI content;

	[SerializeField]
	private Button sureBtn;

	private AnnouncementPopupViewModel popupViewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		popupViewModel = GetData<AnnouncementPopupViewModel>();
		BindingSet<AnnouncementPopupWindow, AnnouncementPopupViewModel> bindingSet = this.CreateBindingSet(popupViewModel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementPopupViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(date).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementPopupViewModel vm) => vm.Date);
		bindingSet.Bind<TextMeshProUGUI>(version).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementPopupViewModel vm) => vm.Version);
		bindingSet.Bind<TextMeshProUGUI>(content).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((AnnouncementPopupViewModel vm) => vm.Content);
		bindingSet.Build();
		sureBtn.onClick.AddListener(Close);
	}

	private new void Close()
	{
		Dismiss();
	}
}
