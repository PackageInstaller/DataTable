using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameActivityRewardItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI activeLevelText;

	[SerializeField]
	private GameObject normalState;

	[SerializeField]
	private GameObject redPointState;

	[SerializeField]
	private GameObject receiveState;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private Button btn;

	private GameActivityRewardItemData viewModel;

	public GameActivityRewardItemData GetVm => (GameActivityRewardItemData)this.GetDataContext();

	public void Init(GameActivityRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<GameActivityRewardItem, GameActivityRewardItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind<TextMeshProUGUI>(activeLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameActivityRewardItemData vm) => vm.ActiveLevel);
		bindingSet.Bind(normalState).For((GameObject v) => v.activeSelf).ToExpression((GameActivityRewardItemData vm) => vm.State == 1);
		bindingSet.Bind(redPointState).For((GameObject v) => v.activeSelf).ToExpression((GameActivityRewardItemData vm) => vm.State == 2);
		bindingSet.Bind(receiveState).For((GameObject v) => v.activeSelf).ToExpression((GameActivityRewardItemData vm) => vm.State == 3);
		if (select != null)
		{
			bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((GameActivityRewardItemData vm) => vm.IsSelect);
		}
		bindingSet.Build();
		btn.onClick.AddListener(OnClick);
	}

	private void OnClick()
	{
		float x = base.transform.localPosition.x;
		viewModel.OnClick(x);
	}

	public void RefreshGameActivityRewardItem(GameActivityRewardItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
