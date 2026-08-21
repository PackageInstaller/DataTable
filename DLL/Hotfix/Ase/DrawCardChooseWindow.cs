using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;

namespace Ase;

public class DrawCardChooseWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 chooseItemList;

	[SerializeField]
	private List<GameObject> heroItemObjList;

	[SerializeField]
	private List<GameObject> weaponItemObjList;

	private DrawCardChooseViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardChooseViewModel>();
		BindingSet<DrawCardChooseWindow, DrawCardChooseViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DrawCardChooseWindow v) => v.CloseWindow).To((DrawCardChooseViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		InitDrawCardChooseItem();
	}

	private void InitDrawCardChooseItem()
	{
		for (int i = 0; i < viewModel.ChooseItemViewModels.Count; i++)
		{
			DrawCardChooseItemViewModel drawCardChooseItemViewModel = viewModel.ChooseItemViewModels[i];
			if (drawCardChooseItemViewModel.Type == 5)
			{
				weaponItemObjList[i].gameObject.SetActive(value: true);
				weaponItemObjList[i].GetComponent<DrawCardChooseItem>()?.Init(drawCardChooseItemViewModel);
			}
			else
			{
				heroItemObjList[i].gameObject.SetActive(value: true);
				heroItemObjList[i].GetComponent<DrawCardChooseItem>()?.Init(drawCardChooseItemViewModel);
			}
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
