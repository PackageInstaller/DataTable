using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyTeamItemView : UGuiView
{
	public Button btnOpen;

	public Image heroIcon;

	public Image heroIcon2;

	public TextMeshProUGUI pos;

	public GameObject AddRoot;

	public GameObject heroRoot;

	public GameObject firstRoot;

	public GameObject selectRoot;

	public GameObject noSelectRoot;

	private int curIndex;

	private CopyTeamItemViewModel viewModel;

	public int CurIndex
	{
		get
		{
			return curIndex;
		}
		set
		{
			curIndex = value;
			if (!(firstRoot == null))
			{
				firstRoot.SetActive(curIndex == 0);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyTeamItemViewModel>(userData);
		BindingSet<CopyTeamItemView, CopyTeamItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btnOpen != null)
		{
			bindingSet.Bind(btnOpen).For((Button v) => v.onClick).To((CopyTeamItemViewModel vm) => vm.OptCommand);
		}
		if (heroIcon2 != null)
		{
			bindingSet.Bind(heroIcon2).For((Image v) => v.sprite).ToExpression((CopyTeamItemViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, vm.HeroId, vm.HeroSkinSuffix, vm.SkinConfigId))
				.WithConversion("ItemIcon");
		}
		if (heroIcon != null)
		{
			bindingSet.Bind(heroIcon).For((Image v) => v.sprite).ToExpression((CopyTeamItemViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, vm.HeroId, vm.HeroSkinSuffix, vm.SkinConfigId))
				.WithConversion("ItemIcon");
		}
		if (AddRoot != null)
		{
			bindingSet.Bind(AddRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTeamItemViewModel vm) => vm.HeroId == 0);
		}
		if (selectRoot != null)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTeamItemViewModel vm) => vm.IsSelect);
		}
		if (noSelectRoot != null)
		{
			bindingSet.Bind(noSelectRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTeamItemViewModel vm) => !vm.IsSelect);
		}
		bindingSet.Bind(heroRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyTeamItemViewModel vm) => vm.HeroId != 0);
		if ((UnityEngine.Object)(object)pos != null)
		{
			if (viewModel.ShowPos)
			{
				bindingSet.Bind<TextMeshProUGUI>(pos).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyTeamItemViewModel vm) => $"{vm.Pos}P");
			}
			else
			{
				((TMP_Text)pos).transform.parent.gameObject.SetActive(value: false);
			}
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTeamItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
