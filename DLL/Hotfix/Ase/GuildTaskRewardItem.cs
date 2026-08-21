using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildTaskRewardItem : UGuiView
{
	[SerializeField]
	private RectTransform rect;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI needPoint;

	[SerializeField]
	private Button btnReward;

	[SerializeField]
	private GameObject canGet;

	[SerializeField]
	private GameObject alreadyGet;

	[SerializeField]
	private GameObject rewardGetEffect;

	private GuildTaskRewardItemData _viewModel;

	public GuildTaskRewardItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildTaskRewardItemData>(userData);
		BindingSet<GuildTaskRewardItem, GuildTaskRewardItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((GuildTaskRewardItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rect).For((RectTransform v) => v.anchoredPosition).To((GuildTaskRewardItemData vm) => vm.Pos);
		bindingSet.Bind<TextMeshProUGUI>(needPoint).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildTaskRewardItemData vm) => vm.NeedPoint);
		bindingSet.Bind(canGet).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskRewardItemData vm) => vm.State == 2);
		bindingSet.Bind(alreadyGet).For((GameObject v) => v.activeSelf).ToExpression((GuildTaskRewardItemData vm) => vm.State == 3);
		bindingSet.Bind(rewardGetEffect).For((GameObject v) => v.activeSelf).To((GuildTaskRewardItemData vm) => vm.ShowGetEffect);
		bindingSet.Build();
		btnReward.onClick.AddListener(delegate
		{
			_viewModel.OnItemClick(this);
		});
	}
}
