using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropTaskInfoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI textTitle;

	[SerializeField]
	private Image taskIcon;

	[SerializeField]
	private TextMeshProUGUI textContent;

	private PropTaskInfoViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropTaskInfoViewModel>();
		BindingSet<PropTaskInfoWindow, PropTaskInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((PropTaskInfoWindow v) => v.OnDismissRequest).To((PropTaskInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PropTaskInfoViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(textTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropTaskInfoViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(textContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropTaskInfoViewModel vm) => vm.Content.Replace("\\n", "\n"));
		bindingSet.Bind(((Component)(object)textContent).gameObject).For((GameObject v) => v.activeSelf).To((PropTaskInfoViewModel vm) => vm.ShowContent);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		Refresh();
	}

	private async void Refresh()
	{
		if (!_viewModel.ShowIcon)
		{
			taskIcon.gameObject.SetActive(value: false);
			return;
		}
		Image image = taskIcon;
		image.sprite = await LoadSpriteAsync(AssetUtility.GetTextureAsset(_viewModel.Icon));
		taskIcon.SetNativeSize();
		taskIcon.gameObject.SetActive(value: true);
	}
}
