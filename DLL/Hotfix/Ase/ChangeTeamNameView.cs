using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChangeTeamNameView : UGuiView
{
	[SerializeField]
	private Button maskBtn;

	[SerializeField]
	private InputField teamName;

	[SerializeField]
	private Text curName;

	[SerializeField]
	private Button sureBtn;

	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Button cancelBtn;

	[SerializeField]
	private TextMeshProUGUI errorText;

	private ChangeTeamNameViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ChangeTeamNameViewModel>(userData);
		BindingSet<ChangeTeamNameView, ChangeTeamNameViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(teamName).For((InputField v) => v.text, (InputField v) => v.onEndEdit).To((ChangeTeamNameViewModel vm) => vm.TeamName)
			.TwoWay();
		bindingSet.Bind<TextMeshProUGUI>(errorText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChangeTeamNameViewModel vm) => vm.ErrorText);
		bindingSet.Bind(sureBtn).For((Button v) => v.onClick).To((ChangeTeamNameViewModel vm) => vm.OnSureBtnClick);
		bindingSet.Build();
		maskBtn.onClick.AddListener(Hide);
		closeBtn.onClick.AddListener(Hide);
		cancelBtn.onClick.AddListener(Hide);
	}

	public void Show(int teamId, string curName)
	{
		_viewModel.TeamId = teamId;
		this.curName.text = "当前队伍名称：" + curName;
		base.gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		teamName.text = string.Empty;
		_viewModel.TeamName = string.Empty;
		base.gameObject.SetActive(value: false);
	}
}
