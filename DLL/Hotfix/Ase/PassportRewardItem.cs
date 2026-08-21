using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportRewardItem : UGuiView
{
	[SerializeField]
	private GameObject self;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarity;

	[SerializeField]
	private TextMeshProUGUI count;

	[SerializeField]
	private GameObject RedPoint;

	[SerializeField]
	private GameObject lockMask;

	[SerializeField]
	private GameObject received;

	[SerializeField]
	private GameObject emptyObj;

	private PassportRewardItemData viewModel;

	public void Init(PassportRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportRewardItem, PassportRewardItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(self).For((GameObject v) => v.activeSelf).ToExpression((PassportRewardItemData vm) => !vm.IsEmpty);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((PassportRewardItemData vm) => vm.OnClick);
		}
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((PassportRewardItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rarity).For((Image v) => v.sprite).ToExpression((PassportRewardItemData vm) => $"Rarity_Middle_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportRewardItemData vm) => vm.Count);
		bindingSet.Bind(RedPoint).For((GameObject v) => v.activeSelf).To((PassportRewardItemData vm) => vm.RedPoint);
		if (lockMask != null)
		{
			bindingSet.Bind(lockMask).For((GameObject v) => v.activeSelf).To((PassportRewardItemData vm) => vm.IsLock);
		}
		bindingSet.Bind(received).For((GameObject v) => v.activeSelf).To((PassportRewardItemData vm) => vm.IsReceived);
		if (emptyObj != null)
		{
			bindingSet.Bind(emptyObj).For((GameObject v) => v.activeSelf).To((PassportRewardItemData vm) => vm.IsEmpty);
		}
		bindingSet.Build();
	}

	public void RefreshPassRewardItemData(PassportRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
