using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleResultWindow : UGuiWindow
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
	private GameObject winnerObj;

	[SerializeField]
	private UIStarGroup2 _uiStarGroup2;

	[SerializeField]
	private TextMeshProUGUI teamViewTime;

	[SerializeField]
	private GameObject failObj;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private Material _battleFailMaterial;

	[SerializeField]
	private Material _bgColorMaterial;

	[SerializeField]
	private GameObject rewardView;

	[SerializeField]
	private Transform heroPos;

	[SerializeField]
	private LoopGridView rewardItemList;

	[SerializeField]
	private Button btnOpenCopy;

	[SerializeField]
	private Button btnAgain;

	[SerializeField]
	private Image roleIcon;

	[SerializeField]
	private Image roleFrame;

	[SerializeField]
	private Text roleName;

	[SerializeField]
	private TextMeshProUGUI roleLevel;

	[SerializeField]
	private TextMeshProUGUI roleExpAdd;

	[SerializeField]
	private Image roleExpFill;

	[SerializeField]
	private GameObject winnerObj2;

	[SerializeField]
	private TextMeshProUGUI rewardViewTime;

	[SerializeField]
	private LoopListView2 starDetailList;

	[SerializeField]
	private GameObject failObj2;

	[SerializeField]
	private Button btnOpenHeroUpgrade;

	[SerializeField]
	private Button btnOpenWeaponUpgrade;

	[SerializeField]
	private Button btnOpenArmourUpgrade;

	[SerializeField]
	private Button btnOpenHeroTalent;

	[SerializeField]
	private InputCheck inputCheck1;

	[SerializeField]
	private InputCheck inputCheck2;

	[SerializeField]
	private Animator _animator;

	[SerializeField]
	private Button mask;

	[SerializeField]
	private bool isTeamView;

	[SerializeField]
	private Button btnStatistic;

	[SerializeField]
	private Button btnStatistic2;

	[SerializeField]
	private Type4ProgressView type4ProgressView;

	[SerializeField]
	private RectTransform barRoot;

	private BattleResultViewModel _viewModel;

	private List<GameObject> createObjList = new List<GameObject>();

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BattleResultViewModel>();
		BindingSet<BattleResultWindow, BattleResultViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BattleResultWindow v) => v.CloseWindow).To((BattleResultViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnOpenHeroUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenHeroCultivateCmd);
		bindingSet.Bind(btnOpenWeaponUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenWeaponCmd);
		bindingSet.Bind(btnOpenArmourUpgrade).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenArmourCmd);
		bindingSet.Bind(btnOpenHeroTalent).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenHeroTalendCmd);
		bindingSet.Bind(btnOpenCopy).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenCopyCmd);
		bindingSet.Bind(btnAgain).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenTeamWindowCmd);
		bindingSet.Bind(this).For((BattleResultWindow v) => v.OpenUguiWindow).To((BattleResultViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		isTeamView = true;
		inputCheck1.AddAction(SliderAction);
		inputCheck2.AddAction(SliderAction);
		LoadTeamView();
		rewardItemList.InitGridView(_viewModel.RewardList.Count, OnGetRewardItemByIndex);
		if (_viewModel.IsWin)
		{
			LoadWinGameObj();
		}
		else
		{
			LoadFailGameObj();
		}
		if (_viewModel.IsMulti)
		{
			LoadMultiGameObj();
		}
		btnStatistic.onClick.AddListener(_viewModel.OpenStatistic);
		btnStatistic2.onClick.AddListener(_viewModel.OpenStatistic);
		CanOnClickMask();
		mask.onClick.AddListener(MaskAction);
		Type4Config();
		if (_viewModel.IsCampaignMultiBattle)
		{
			btnAgain.gameObject.SetActive(value: false);
		}
	}

	private void Type4Config()
	{
		if (_viewModel.Type4ProgressVm != null)
		{
			type4ProgressView.Init(_viewModel.Type4ProgressVm);
			type4ProgressView.gameObject.SetActive(value: true);
			type4ProgressView.SetCopyItemRoot(barRoot);
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		PlayAnimation();
	}

	public async void PlayAnimation()
	{
		await UniTask.Delay(100);
		string text = (_viewModel.IsWin ? "WinEnter" : "FailEnter");
		_animator.SetTrigger(Animator.StringToHash(text));
		PlayBattleResultAudio();
	}

	public void PlayBattleResultAudio()
	{
		UniTask.Delay(1000);
		_viewModel.PlayBattleResultAudio();
	}

	private void LoadWinGameObj()
	{
		_bgColorMaterial.SetFloat("_Decolorization", 1f);
		winnerObj.SetActive(value: true);
		_uiStarGroup2.SetStarCount(_viewModel.CopyMaxStar, _viewModel.CopyGetStar, 0);
		((TMP_Text)teamViewTime).text = GetTime();
		winnerObj2.SetActive(value: true);
		((TMP_Text)rewardViewTime).text = GetTime();
	}

	private string GetTime()
	{
		int num = (int)(_viewModel.Time / 60f) % 60;
		int num2 = (int)_viewModel.Time % 60;
		return $"{num:00}:{num2:00}";
	}

	private void LoadFailGameObj()
	{
		_bgColorMaterial.SetFloat("_Decolorization", 0f);
		failObj.SetActive(value: true);
		failObj2.SetActive(value: true);
	}

	private void LoadMultiGameObj()
	{
		if (_viewModel.GamersInfo.Count == 1)
		{
			team2RoleInfo2.gameObject.SetActive(value: true);
			team2RoleInfo2.Init(_viewModel.GamersInfo[0]);
		}
		else if (_viewModel.GamersInfo.Count == 2)
		{
			team3RoleInfo2.gameObject.SetActive(value: true);
			team3RoleInfo2.Init(_viewModel.GamersInfo[0]);
			team3RoleInfo3.gameObject.SetActive(value: true);
			team3RoleInfo3.Init(_viewModel.GamersInfo[1]);
		}
	}

	private void SetFailMaterial(GameObject gameObject)
	{
		SkeletonGraphic componentInChildren = gameObject.GetComponentInChildren<SkeletonGraphic>();
		if ((Object)(object)componentInChildren != null)
		{
			((Graphic)(object)componentInChildren).material = _battleFailMaterial;
		}
	}

	private async void LoadTeamView()
	{
		if (_viewModel.IsMulti)
		{
			LoadMulti();
		}
		else
		{
			LoadSingle();
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(_viewModel.TeamList[0].HeroModel.Original), heroPos);
		if (!(gameObject == null))
		{
			UIUtilly.SpineMatchRectHelper(gameObject, heroPos, overwrite: false);
			StreamerMode.ApplySpineSkin(gameObject);
			createObjList.Add(gameObject);
		}
	}

	private void LoadSingle()
	{
		if (_viewModel.TeamList.Count == 1)
		{
			team1.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team1HeroPos1);
		}
		else if (_viewModel.TeamList.Count == 2)
		{
			team2.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team2HeroPos1);
			LoadHeroObj(_viewModel.TeamList[1].HeroModel.Original, team2HeroPos2);
		}
		else if (_viewModel.TeamList.Count == 3)
		{
			team3.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team3HeroPos1);
			LoadHeroObj(_viewModel.TeamList[1].HeroModel.Original, team3HeroPos2);
			LoadHeroObj(_viewModel.TeamList[2].HeroModel.Original, team3HeroPos3);
		}
	}

	private void LoadMulti()
	{
		if (_viewModel.GamersInfo.Count == 0)
		{
			team1.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team1HeroPos1);
		}
		else if (_viewModel.GamersInfo.Count == 1)
		{
			team2.SetActive(value: true);
			team1.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team2HeroPos1);
			LoadHeroObj(_viewModel.GamersInfo[0].heroOriginal, team2HeroPos2);
		}
		else if (_viewModel.GamersInfo.Count == 2)
		{
			team3.SetActive(value: true);
			team1.SetActive(value: true);
			LoadHeroObj(_viewModel.TeamList[0].HeroModel.Original, team3HeroPos1);
			LoadHeroObj(_viewModel.GamersInfo[0].heroOriginal, team3HeroPos2);
			LoadHeroObj(_viewModel.GamersInfo[1].heroOriginal, team3HeroPos3);
		}
	}

	private async void LoadHeroObj(string path, Transform position)
	{
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(path), position);
		if (!(gameObject == null))
		{
			UIUtilly.SpineMatchRectHelper(gameObject, position, overwrite: false);
			StreamerMode.ApplySpineSkin(gameObject);
			if (!_viewModel.IsWin)
			{
				SetFailMaterial(gameObject);
			}
			createObjList.Add(gameObject);
		}
	}

	private void SliderAction(string action)
	{
		if (_viewModel.Canslider)
		{
			if (action.Equals("Left") && isTeamView)
			{
				bg.GetComponent<Image>().material.SetFloat("_Decolorization", 1f);
				isTeamView = false;
				rewardView.SetActive(value: true);
				inputCheck1.enabled = false;
				inputCheck2.enabled = true;
				string text = (_viewModel.IsWin ? "WinBackReward" : "FailBackReward");
				_animator.SetTrigger(Animator.StringToHash(text));
			}
			if (action.Equals("Right") && !isTeamView)
			{
				int num = (_viewModel.IsWin ? 1 : 0);
				bg.GetComponent<Image>().material.SetFloat("_Decolorization", num);
				isTeamView = true;
				rewardView.SetActive(value: false);
				inputCheck1.enabled = true;
				inputCheck2.enabled = false;
				string text2 = (_viewModel.IsWin ? "WinBackTeam" : "FailBackTeam");
				_animator.SetTrigger(Animator.StringToHash(text2));
			}
		}
	}

	private async void CanOnClickMask()
	{
		await Task.Delay(5000);
		if (mask != null)
		{
			mask.gameObject.SetActive(value: true);
		}
	}

	private void MaskAction()
	{
		mask.gameObject.SetActive(value: false);
		SliderAction("Left");
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= _viewModel.RewardList.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = (_viewModel.RewardList[index].IsActive ? gridView.NewListViewItem("PropItem_Star") : gridView.NewListViewItem("PropItem_Normal"));
		if (loopGridViewItem != null)
		{
			KnapsackItemNew component = loopGridViewItem.GetComponent<KnapsackItemNew>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(_viewModel.RewardList[index]);
			}
			else
			{
				component.RefreshData(_viewModel.RewardList[index]);
			}
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < createObjList.Count; i++)
		{
			Object.Destroy(createObjList[i]);
		}
		Dismiss();
	}
}
