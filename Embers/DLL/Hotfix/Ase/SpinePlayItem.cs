using System;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SpinePlayItem : UGuiView
{
	[SerializeField]
	private Image spineIcon;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private Button button;

	private SpinePlayItemData _viewModel;

	public SpinePlayItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<SpinePlayItemData>(userData);
		BindingSet<SpinePlayItem, SpinePlayItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(spineIcon).For((Image v) => v.sprite).To((SpinePlayItemData vm) => vm.SpineIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((SpinePlayItemData vm) => vm.Selected);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is SpinePlayItemData spinePlayItemData)
		{
			_viewModel = spinePlayItemData;
			this.SetDataContext(spinePlayItemData);
		}
	}

	public void SetButtonClick(Action<int> func)
	{
		button.onClick.RemoveAllListeners();
		button.onClick.AddListener(delegate
		{
			func?.Invoke(_viewModel.ItemIndex);
		});
	}
}
