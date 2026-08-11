using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class HCTalentPreviewView : HCTalentView
{
	private HCTalentPreviewViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HCTalentPreviewViewModel>(userData);
		BindingSet<HCTalentPreviewView, HCTalentPreviewViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HCTalentPreviewView v) => v.OnOpt).To((HCTalentPreviewViewModel vm) => vm.OptRequest);
		bindingSet.Build();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	protected virtual void SettleOpt(string optName)
	{
		if ("RefreshBind".Equals(optName))
		{
			viewModel.RefreshSkillItems();
			BindPoints();
		}
	}

	public override void OnInitAfter()
	{
		hctDescView.Init(viewModel.DescVm);
		hctDescView.gameObject.SetActive(value: false);
		skillDescView.gameObject.SetActive(value: false);
		BindPoints();
		hctDescView.transform.SetParent(base.transform.parent.transform.parent);
		skillDescView.SetParent(base.transform.parent.transform.parent);
		descPos1.SetParent(base.transform.parent.transform.parent);
		descPos1.anchoredPosition = new Vector2(0f, descPos1.anchoredPosition.y);
		descPos2.SetParent(base.transform.parent.transform.parent);
		descPos2.anchoredPosition = new Vector2(hctDescView.RectTransform.rect.width, descPos2.anchoredPosition.y);
		descWidth = hctDescView.RectTransform.sizeDelta.x / 2f;
		p1 = pos.anchoredPosition;
	}
}
