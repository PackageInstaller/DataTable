using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BoardChangeItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image image;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject greyMask;

	[SerializeField]
	private GameObject itemTag;

	private BoardChangeItemData _viewModel;

	public void Init(BoardChangeItemData data)
	{
		_viewModel = data;
		BindingSet<BoardChangeItem, BoardChangeItemData> bindingSet = this.CreateBindingSet(_viewModel);
		if (greyMask != null)
		{
			bindingSet.Bind(greyMask).For((GameObject v) => v.activeSelf).ToExpression((BoardChangeItemData vm) => !vm.Unlock);
		}
		if (image != null)
		{
			bindingSet.Bind(image).For((Image v) => v.sprite).To((BoardChangeItemData vm) => vm.ImagePath)
				.WithConversion("ItemIcon");
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((BoardChangeItemData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((BoardChangeItemData vm) => vm.Selected);
		bindingSet.Bind(itemTag).For((GameObject v) => v.activeSelf).To((BoardChangeItemData vm) => vm.ShowTag);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((BoardChangeItemData vm) => vm.OnItemClick);
		bindingSet.Build();
	}

	public void RefreshData(BoardChangeItemData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}
}
