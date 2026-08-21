using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignMatItem : UGuiView
{
	[SerializeField]
	private Button button;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI count;

	private CampaignMatItemData _viewModel;

	public CampaignMatItemData ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignMatItemData>(userData);
		BindingSet<CampaignMatItem, CampaignMatItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CampaignMatItemData vm) => vm.PropDataBase.Amount);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((CampaignMatItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
		button.onClick.AddListener(OnIconBtnClick);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is CampaignMatItemData campaignMatItemData)
		{
			_viewModel = campaignMatItemData;
			this.SetDataContext(campaignMatItemData);
		}
	}

	private void OnIconBtnClick()
	{
		_viewModel.OnIconBtnClick(button.transform.position);
	}
}
