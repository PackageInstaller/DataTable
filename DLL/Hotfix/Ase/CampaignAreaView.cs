using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignAreaView : UGuiView
{
	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected RectTransform iconSize;

	[SerializeField]
	protected Button button;

	[SerializeField]
	protected RectTransform buttonArea;

	private CampaignAreaData _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignAreaData>(userData);
		BindingSet<CampaignAreaView, CampaignAreaData> bindingSet = this.CreateBindingSet(_viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((CampaignAreaData vm) => vm.Icon)
				.WithConversion("ItemIcon");
		}
		if (iconSize != null)
		{
			bindingSet.Bind(iconSize).For((RectTransform v) => v.sizeDelta).ToExpression((CampaignAreaData vm) => vm.IconSize * Vector2.one);
		}
		if (button != null)
		{
			bindingSet.Bind(button).For((Button v) => v.onClick).To((CampaignAreaData vm) => vm.OnAreaClick);
		}
		if (buttonArea != null)
		{
			bindingSet.Bind(buttonArea).For((RectTransform v) => v.localScale).ToExpression((CampaignAreaData vm) => Vector3.one * vm.ClickRange);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		if (userData is CampaignAreaData campaignAreaData)
		{
			_viewModel = campaignAreaData;
			this.SetDataContext(campaignAreaData);
		}
	}

	public void SetParent(CampaignPosition area)
	{
		base.transform.SetParent(area.transform);
	}
}
