using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class TowerTalentLevelItemView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI desText;

	[SerializeField]
	private TextMeshProUGUI LevelText;

	[SerializeField]
	private GameObject curLevel;

	public ChatMsgFitter chatMsgFitter;

	private TowerTalentLevelDesViewModel viewModel;

	public void Init(TowerTalentLevelDesViewModel towerTalentLevelDes)
	{
		viewModel = towerTalentLevelDes;
		BindingSet<TowerTalentLevelItemView, TowerTalentLevelDesViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(LevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TowerTalentLevelDesViewModel vm) => $"Lv.{vm.TalentLevel}");
		bindingSet.Bind(curLevel).For((GameObject v) => v.activeSelf).To((TowerTalentLevelDesViewModel vm) => vm.CurLevel);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = (TowerTalentLevelDesViewModel)userData;
		this.SetDataContext(viewModel);
	}

	public void SetFitter()
	{
		if (viewModel != null && !(chatMsgFitter == null))
		{
			chatMsgFitter.SetBGSize(viewModel.TalentDes, send: false);
			chatMsgFitter.SetCurItemHeight(RectTransform);
		}
	}
}
