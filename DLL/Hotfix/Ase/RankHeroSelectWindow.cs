using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RankHeroSelectWindow : UGuiWindow
{
	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private LoopGridView loopGridView;

	private RankHeroSelectViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<RankHeroSelectViewModel>();
		BindingSet<RankHeroSelectWindow, RankHeroSelectViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((RankHeroSelectWindow v) => v.OnDismissRequest).To((RankHeroSelectViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((RankHeroSelectViewModel vm) => vm.Close);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((RankHeroSelectViewModel vm) => vm.Close);
		bindingSet.Build();
		loopGridView.InitGridView(_viewModel.Datas.Count, OnGetItemByIndex);
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		RankDefinition.HeroChallengeData data = _viewModel.Datas[dataIndex];
		LoopGridViewItem loopGridViewItem = null;
		loopGridViewItem = loopGridView.NewListViewItem("RankHeroSelectItem");
		RankHeroSelectItem component = loopGridViewItem.GetComponent<RankHeroSelectItem>();
		RankHeroSelectItemData rankHeroSelectItemData = new RankHeroSelectItemData(_viewModel, data);
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(rankHeroSelectItemData);
		}
		else
		{
			component.SetDataContext(rankHeroSelectItemData);
		}
		if (data.HeroId == _viewModel.SelectHeroId)
		{
			_viewModel.SetItemSelected(rankHeroSelectItemData);
		}
		return loopGridViewItem;
	}
}
