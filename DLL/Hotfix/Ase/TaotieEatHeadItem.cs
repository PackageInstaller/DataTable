using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaotieEatHeadItem : UGuiView
{
	[SerializeField]
	private RectTransform headRoot;

	[SerializeField]
	private Image icon;

	private bool isInit;

	public bool IsInit => isInit;

	public void Init(TaotieEatHeadItemData viewModel, float yFitter)
	{
		headRoot.sizeDelta = new Vector2(headRoot.sizeDelta.x * yFitter, headRoot.sizeDelta.y * yFitter);
		headRoot.localRotation = Quaternion.Euler(0f, 0f, viewModel.ZRootRotateAngle);
		BindingSet<TaotieEatHeadItem, TaotieEatHeadItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TaotieEatHeadItem v) => v.OnVisibleChanged).To((TaotieEatHeadItemData vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((TaotieEatHeadItem v) => v.Visibility).To((TaotieEatHeadItemData vm) => vm.HasHero);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((TaotieEatHeadItemData vm) => vm.IconName)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		isInit = true;
	}

	public void RefreshData(TaotieEatHeadItemData viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
