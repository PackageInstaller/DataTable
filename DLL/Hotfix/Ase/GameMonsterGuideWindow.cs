using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameMonsterGuideWindow : UGuiWindow
{
	[SerializeField]
	private RectTransform pointRect;

	[SerializeField]
	private GameObject pointItem;

	[SerializeField]
	private Button btnBack;

	private GameMonsterGuideViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameMonsterGuideViewModel>();
		BindingSet<GameMonsterGuideWindow, GameMonsterGuideViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameMonsterGuideViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameMonsterGuideWindow v) => v.OpenUguiWindow).To((GameMonsterGuideViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameMonsterGuideWindow v) => v.CloseWindow).To((GameMonsterGuideViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		LoadPoint();
	}

	private void LoadPoint()
	{
		for (int i = 0; i < viewModel.PointItemDataList.Count; i++)
		{
			GameObject obj = Object.Instantiate(pointItem, pointRect);
			obj.GetComponent<MapPointItem>().Init(viewModel.PointItemDataList[i]);
			obj.gameObject.SetActive(value: true);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
