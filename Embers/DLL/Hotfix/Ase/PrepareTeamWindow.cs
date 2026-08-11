using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PrepareTeamWindow : UGuiView
{
	public Transform teamContent;

	public Button cancelBtn;

	public Button confirmBtn;

	public Button backBgBtn;

	private List<SingleTeamView> _teamList;

	private PrepareTeamViewModel _viewModel;

	public void Init(PrepareTeamViewModel prepareTeamViewModel)
	{
		_viewModel = prepareTeamViewModel;
		_teamList = new List<SingleTeamView>();
		BindingSet<PrepareTeamWindow, PrepareTeamViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((PrepareTeamViewModel vm) => vm.OnConfirmBtnClick);
		bindingSet.Build();
		InitTeams();
		cancelBtn.onClick.AddListener(delegate
		{
			Hide();
		});
		backBgBtn.onClick.AddListener(delegate
		{
			Hide();
		});
		confirmBtn.onClick.AddListener(delegate
		{
			Hide();
		});
	}

	private void InitTeams()
	{
		GameObject original = teamContent.GetChild(0).gameObject;
		for (int i = 1; i < 7; i++)
		{
			GameObject obj = Object.Instantiate(original, teamContent);
			SingleTeamView component = obj.transform.GetComponent<SingleTeamView>();
			component.Init(new TeamViewModel(_viewModel, i));
			_teamList.Add(component);
			obj.SetActive(value: true);
		}
	}

	private void UpdateTeams()
	{
		Dictionary<int, TeamModel> allTeamData = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetAllTeamData();
		for (int i = 1; i < 7; i++)
		{
			_teamList[i - 1].ViewModel.UpdateTeamData(allTeamData[i]);
		}
	}

	public void Show()
	{
		UpdateTeams();
		base.gameObject.SetActive(value: true);
		_teamList[Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId() - 1].Toggle.isOn = true;
	}

	public void Hide()
	{
		base.gameObject.SetActive(value: false);
	}

	protected override void OnDestroy()
	{
		foreach (SingleTeamView team in _teamList)
		{
			Object.DestroyImmediate(team.gameObject);
		}
		_teamList.Clear();
		base.OnDestroy();
	}
}
