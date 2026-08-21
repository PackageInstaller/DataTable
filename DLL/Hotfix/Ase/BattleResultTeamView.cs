using System.Collections.Generic;
using GameFramework.Runtime;
using Spine.Unity;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleResultTeamView : UGuiView
{
	[SerializeField]
	private GameObject team1;

	[SerializeField]
	private Transform team1HeroPos1;

	[SerializeField]
	private GameObject team2;

	[SerializeField]
	private Transform team2HeroPos1;

	[SerializeField]
	private Transform team2HeroPos2;

	[SerializeField]
	private GamerHeadInfoView team2RoleInfo2;

	[SerializeField]
	private GameObject team3;

	[SerializeField]
	private Transform team3HeroPos1;

	[SerializeField]
	private Transform team3HeroPos2;

	[SerializeField]
	private Transform team3HeroPos3;

	[SerializeField]
	private GamerHeadInfoView team3RoleInfo2;

	[SerializeField]
	private GamerHeadInfoView team3RoleInfo3;

	[SerializeField]
	private Material battleMaterial;

	private BattleResultViewModel viewModel;

	private List<string> pathList;

	public void Init(BattleResultViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.CreateBindingSet(viewModel).Build();
		LoadTeamView();
	}

	private void LoadTeamView()
	{
		pathList = new List<string>();
		if (viewModel.IsMulti)
		{
			LoadMulti();
		}
		else
		{
			LoadSingle();
		}
	}

	private void LoadSingle()
	{
		if (viewModel.TeamList.Count == 1)
		{
			team1.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team1HeroPos1);
		}
		else if (viewModel.TeamList.Count == 2)
		{
			team2.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team2HeroPos1);
			LoadHeroObj(viewModel.TeamList[1].HeroModel.Original, team2HeroPos2);
		}
		else if (viewModel.TeamList.Count == 3)
		{
			team3.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team3HeroPos1);
			LoadHeroObj(viewModel.TeamList[1].HeroModel.Original, team3HeroPos2);
			LoadHeroObj(viewModel.TeamList[2].HeroModel.Original, team3HeroPos3);
		}
	}

	private void LoadMulti()
	{
		if (viewModel.GamersInfo.Count == 0)
		{
			team1.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team1HeroPos1);
		}
		else if (viewModel.GamersInfo.Count == 1)
		{
			team2.SetActive(value: true);
			team1.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team2HeroPos1);
			LoadHeroObj(viewModel.GamersInfo[0].heroOriginal, team2HeroPos2);
			team2RoleInfo2.gameObject.SetActive(value: true);
			team2RoleInfo2.Init(viewModel.GamersInfo[0]);
		}
		else if (viewModel.GamersInfo.Count == 2)
		{
			team3.SetActive(value: true);
			team1.SetActive(value: true);
			LoadHeroObj(viewModel.TeamList[0].HeroModel.Original, team3HeroPos1);
			LoadHeroObj(viewModel.GamersInfo[0].heroOriginal, team3HeroPos2);
			LoadHeroObj(viewModel.GamersInfo[1].heroOriginal, team3HeroPos3);
			team3RoleInfo2.gameObject.SetActive(value: true);
			team3RoleInfo2.Init(viewModel.GamersInfo[0]);
			team3RoleInfo3.gameObject.SetActive(value: true);
			team3RoleInfo3.Init(viewModel.GamersInfo[1]);
		}
	}

	private async void LoadHeroObj(string path, Transform position)
	{
		string uIItemAsset = AssetUtility.GetUIItemAsset(path);
		GameObject gameObject = await InstantiateAsync(uIItemAsset, position);
		if (!(gameObject == null))
		{
			UIUtilly.SpineMatchRectHelper(gameObject, position, overwrite: false);
			SetFailMaterial(gameObject);
			StreamerMode.ApplySpineSkin(gameObject);
			pathList.Add(path);
		}
	}

	private void SetFailMaterial(GameObject gameObject)
	{
		SkeletonGraphic[] componentsInChildren = gameObject.GetComponentsInChildren<SkeletonGraphic>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			((Graphic)(object)componentsInChildren[i]).material = battleMaterial;
		}
	}
}
