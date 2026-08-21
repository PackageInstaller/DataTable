using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailHeroItem : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject emptyObj;

	[SerializeField]
	private GameObject heroObj;

	[SerializeField]
	private Image heroImg;

	private SailHeroItemData viewModel;

	public void Init(SailHeroItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SailHeroItem, SailHeroItemData> bindingSet = this.CreateBindingSet(viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((SailHeroItemData vm) => vm.OnClick);
		}
		if (emptyObj != null)
		{
			bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((SailHeroItemData vm) => vm.IsEmpty);
		}
		if (heroObj != null)
		{
			bindingSet.Bind(heroObj).For((GameObject v) => v.activeSelf).ToExpression((SailHeroItemData vm) => !vm.IsEmpty);
		}
		if (heroImg != null)
		{
			bindingSet.Bind(heroImg).For((Image v) => v.sprite).ToExpression((SailHeroItemData vm) => vm.HeroIcon)
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
	}

	public void RefreshHeroData(SailHeroItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
