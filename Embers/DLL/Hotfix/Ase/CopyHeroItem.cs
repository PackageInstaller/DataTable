using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class CopyHeroItem : HeroItem
{
	public GameObject teamTagNormalRoot;

	public GameObject teamTagBlockRoot;

	public TextMeshProUGUI teamName;

	public GameObject seatTag1;

	public GameObject seatTag2;

	public GameObject seatTag3;

	private int seatTag;

	private CopyHeroItemViewModel viewModel;

	public int SeatTag
	{
		get
		{
			return seatTag;
		}
		set
		{
			seatTag = value;
			if (!(seatTag1 == null))
			{
				seatTag1.gameObject.SetActive(!viewModel.IsBlock && seatTag == 1);
				seatTag2.gameObject.SetActive(!viewModel.IsBlock && seatTag == 2);
				seatTag3.gameObject.SetActive(!viewModel.IsBlock && seatTag == 3);
			}
		}
	}

	public void Init(CopyHeroItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		Init((HeroItemViewModel)viewModel);
		BindingSet<CopyHeroItem, CopyHeroItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(teamTagNormalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroItemViewModel vm) => vm.HaveTag && !vm.IsBlock);
		if (teamTagBlockRoot != null)
		{
			bindingSet.Bind(teamTagBlockRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroItemViewModel vm) => vm.HaveTag && vm.IsBlock);
		}
		bindingSet.Bind(((Component)(object)teamName).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroItemViewModel vm) => vm.HaveTag);
		bindingSet.Bind(this).For((CopyHeroItem v) => v.SeatTag).ToExpression((CopyHeroItemViewModel vm) => vm.IsBlock ? 0 : vm.SeatTag);
		bindingSet.Bind<TextMeshProUGUI>(teamName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyHeroItemViewModel vm) => $"队伍{vm.TagIndex}");
		bindingSet.Build();
	}

	public void RefreshData(CopyHeroItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		RefreshData((HeroItemViewModel)viewModel);
		this.SetDataContext(viewModel);
	}
}
