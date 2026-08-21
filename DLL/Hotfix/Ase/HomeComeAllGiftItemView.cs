using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeAllGiftItemView : UGuiView
{
	[SerializeField]
	private Image img;

	[SerializeField]
	private Button button;

	private HomeComeAllGiftItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HomeComeAllGiftItemViewModel>(userData);
		BindingSet<HomeComeAllGiftItemView, HomeComeAllGiftItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (img != null)
		{
			bindingSet.Bind(img).For((Image v) => v.sprite).ToExpression((HomeComeAllGiftItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((HomeComeAllGiftItemViewModel vm) => vm.ClickCommand);
		}
		bindingSet.Build();
	}

	public void RefreshData(HomeComeAllGiftItemViewModel data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
