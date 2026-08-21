using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameHeroGuideWindow : UGuiWindow
{
	[SerializeField]
	private RectTransform pointRect;

	[SerializeField]
	private GameObject pointItem;

	[SerializeField]
	private Button btnBack;

	private GameHeroGuideViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameHeroGuideViewModel>();
		BindingSet<GameHeroGuideWindow, GameHeroGuideViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameHeroGuideViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameHeroGuideWindow v) => v.OpenUguiWindow).To((GameHeroGuideViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameHeroGuideWindow v) => v.CloseWindow).To((GameHeroGuideViewModel vm) => vm.DismissRequest);
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
