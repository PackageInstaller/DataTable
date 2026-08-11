using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkillSkinItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI skinName;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private GameObject useObj;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private LoadUISprite skinImg;

	[SerializeField]
	private GameObject unLockEffectObj;

	[SerializeField]
	private GameObject useEffectObj;

	private HeroSkillSkinItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HeroSkillSkinItemData>(userData);
		BindingSet<HeroSkillSkinItem, HeroSkillSkinItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroSkillSkinItemData vm) => vm.OnClick);
		bindingSet.Bind<TextMeshProUGUI>(skinName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillSkinItemData vm) => vm.SkinName);
		bindingSet.Bind(selectObj).For((GameObject v) => v.activeSelf).To((HeroSkillSkinItemData vm) => vm.IsSelected);
		bindingSet.Bind(useObj).For((GameObject v) => v.activeSelf).To((HeroSkillSkinItemData vm) => vm.IsUse);
		bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinItemData vm) => !vm.IsLocked);
		bindingSet.Bind(skinImg).For((LoadUISprite v) => v.Path).ToExpression((HeroSkillSkinItemData vm) => vm.SkinImgPath);
		bindingSet.Bind(unLockEffectObj).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinItemData vm) => vm.IsLocked);
		bindingSet.Bind(useEffectObj).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillSkinItemData vm) => vm.IsUse);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is HeroSkillSkinItemData dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
	}
}
