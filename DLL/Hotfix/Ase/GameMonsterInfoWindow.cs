using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameMonsterInfoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoadUISprite img;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private LoopListView2 skillList;

	private GameMonsterInfoViewModel viewModel;

	private string imgPath = "";

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameMonsterInfoViewModel>();
		BindingSet<GameMonsterInfoWindow, GameMonsterInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameMonsterInfoViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((GameMonsterInfoWindow v) => v.OpenUguiWindow).To((GameMonsterInfoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameMonsterInfoWindow v) => v.CloseWindow).To((GameMonsterInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMonsterInfoViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameMonsterInfoViewModel vm) => vm.Desc);
		bindingSet.Build();
		skillList.InitListView(viewModel.SkillDataList.Count, OnGetSkillItemByIndex);
		img.Path = "CopySceneImg/" + viewModel.ImgPath;
	}

	private LoopListViewItem2 OnGetSkillItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SkillDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("SkillItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SkillDataList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SkillDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
