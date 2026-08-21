using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaotieEatView : UGuiView
{
	[SerializeField]
	private RectTransform root;

	[SerializeField]
	private RectTransform help;

	[SerializeField]
	private List<float> rorateAnglesConfig;

	[SerializeField]
	private List<TaotieEatHeadItem> headItems;

	private TaotieEatViewModel viewModel;

	public List<float> RorateAnglesConfig => rorateAnglesConfig;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<TaotieEatViewModel>(userData);
		help.sizeDelta = new Vector2(help.sizeDelta.x, help.sizeDelta.y);
		BindingSet<TaotieEatView, TaotieEatViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TaotieEatView v) => v.OnVisibleChanged).To((TaotieEatViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(root).For((RectTransform v) => v.localPosition).To((TaotieEatViewModel vm) => vm.BossPos);
		bindingSet.Bind(this).For((TaotieEatView v) => v.UpdateHeroHead).To((TaotieEatViewModel vm) => vm.UpdateHeroRequest);
		bindingSet.Build();
		if (viewModel.HeadItemDatas != null && viewModel.HeadItemDatas.Count > 0)
		{
			UpdateHeroHead(null, null);
		}
	}

	private void UpdateHeroHead(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < headItems.Count; i++)
		{
			if (i < viewModel.HeadItemDatas.Count)
			{
				if (headItems[i].IsInit)
				{
					headItems[i].RefreshData(viewModel.HeadItemDatas[i]);
				}
				else
				{
					headItems[i].Init(viewModel.HeadItemDatas[i], 1f);
				}
			}
		}
	}
}
