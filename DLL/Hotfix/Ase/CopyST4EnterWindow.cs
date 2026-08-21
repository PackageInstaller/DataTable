using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyST4EnterWindow : UGuiWindow
{
	public Transform highlightRoot;

	public Button btnBack;

	public Button btnHero;

	public Button btnEnter;

	public Button btnReset;

	public Button btnHide;

	public Button btnChangeTeam;

	public Button btnClearTeam;

	public GameObject multiCopyRoot;

	public TextMeshProUGUI buffDesc;

	public TextMeshProUGUI buffName;

	public List<CopyST4EnterItemView> copyItems;

	public CopyHeroSelectView selectView;

	private CopyST4EnterViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopyST4EnterViewModel>();
		BindingSet<CopyST4EnterWindow, CopyST4EnterViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopyST4EnterWindow v) => v.OnDismissRequest).To((CopyST4EnterViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopyST4EnterWindow v) => v.OpenUguiWindow).To((CopyST4EnterViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopyST4EnterWindow v) => v.SetChildViewVisibility).To((CopyST4EnterViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((CopyST4EnterWindow v) => v.OnOpt).To((CopyST4EnterViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.Close);
		bindingSet.Bind(btnHide).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("HideTeamView");
		bindingSet.Bind(btnHero).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenHero");
		bindingSet.Bind(btnEnter).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("SaveTeam");
		bindingSet.Bind(btnReset).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("ResetTeam");
		bindingSet.Bind(btnChangeTeam).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeTeam");
		bindingSet.Bind(btnClearTeam).For((Button v) => v.onClick).To((CopyST4EnterViewModel vm) => vm.OptCommand)
			.CommandParameter("ClearTeam");
		bindingSet.Bind(multiCopyRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterViewModel vm) => vm.MultiCopy);
		bindingSet.Bind(btnReset.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterViewModel vm) => (int)vm.CopyStage == 3);
		bindingSet.Bind(btnHero.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterViewModel vm) => (int)vm.CopyStage != 3);
		bindingSet.Bind(btnEnter.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterViewModel vm) => (int)vm.CopyStage != 3);
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyST4EnterViewModel vm) => vm.BuffDesc);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyST4EnterViewModel vm) => vm.BuffName);
		bindingSet.Build();
		for (int num = 0; num < copyItems.Count; num++)
		{
			if (viewModel.CopyItemVms.Count > num)
			{
				copyItems[num].Init(viewModel.CopyItemVms[num]);
				copyItems[num].gameObject.SetActive(value: true);
			}
			else
			{
				copyItems[num].gameObject.SetActive(value: false);
			}
			copyItems[num].SetTeamListHighlightRoot(highlightRoot);
		}
		selectView.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenTeamView".Equals(optName))
		{
			selectView.Init(viewModel.HeroSelectVm);
			selectView.gameObject.SetActive(value: true);
			btnHide.gameObject.SetActive(value: true);
		}
		else if ("HideTeamView".Equals(optName))
		{
			selectView.gameObject.SetActive(value: false);
			btnHide.gameObject.SetActive(value: false);
		}
	}
}
