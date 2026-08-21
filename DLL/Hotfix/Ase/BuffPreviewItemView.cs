using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffPreviewItemView : UGuiView
{
	[SerializeField]
	private Image buffIcon;

	private BuffItemViewModel buffViewModel;

	public void Init(BuffItemViewModel buffViewModel)
	{
		this.buffViewModel = buffViewModel;
		BindingSet<BuffPreviewItemView, BuffItemViewModel> bindingSet = this.CreateBindingSet(buffViewModel);
		bindingSet.Bind(buffIcon).For((Image v) => v.sprite).ToExpression((BuffItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public void RefreshData(BuffItemViewModel buffViewModel)
	{
		this.SetDataContext(buffViewModel);
	}
}
