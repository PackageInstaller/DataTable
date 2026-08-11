using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleResultBaseWindow : UGuiWindow
{
	[SerializeField]
	private BattleResultTeamView battleResultTeamView;

	[SerializeField]
	private Button btnFirstEnter;

	[SerializeField]
	private Button btnToTeamWindow;

	[SerializeField]
	private Button btnToRewardWindow;

	[SerializeField]
	private Transform heroImgPos;

	[SerializeField]
	private GameObject normalCopyObj;

	[SerializeField]
	private Button btnOpenCopy;

	[SerializeField]
	private Button btnAgain;

	[SerializeField]
	private GameObject Type4CopyObj;

	[SerializeField]
	private TextMeshProUGUI openCopy4Text;

	[SerializeField]
	private Button btnOpenCopy4;

	[SerializeField]
	private Button btnAgain4;

	[SerializeField]
	private TextMeshProUGUI roleLevel;

	[SerializeField]
	private TextMeshProUGUI roleExpAdd;

	[SerializeField]
	private TextMeshProUGUI rewardTitle;

	[SerializeField]
	private InputCheck inputCheck;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private Button btnStatistic;

	[SerializeField]
	private Button btnStatistic2;

	[SerializeField]
	private Type4ProgressView type4ProgressView;

	[SerializeField]
	private RectTransform barRoot;

	[SerializeField]
	private GameObject emptyReward;

	[SerializeField]
	private Material battleMaterial;

	[SerializeField]
	private GameObject fillObj;

	[SerializeField]
	private RectTransform expEffectFillRect;

	[SerializeField]
	private GameObject expFillHeadObj;

	private BattleResultViewModel viewModel;

	private string heroImgPath = "";

	private bool isTeamView = true;

	private bool canSlider = true;

	private bool isFirstOnClick = true;

	private Timer addExpTimer;

	private int duration;

	private float perExpAdd;

	private float curExpWidth;

	private float totalWidth;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleResultViewModel>();
		BindingSet<BattleResultBaseWindow, BattleResultViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleResultBaseWindow v) => v.CloseWindow).To((BattleResultViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TextMeshProUGUI>(roleLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleResultViewModel vm) => vm.RoleViewModel.PlayerInfo.Level);
		bindingSet.Bind<TextMeshProUGUI>(roleExpAdd).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleResultViewModel vm) => vm.RoleExpAdd);
		bindingSet.Bind(normalCopyObj).For((GameObject v) => v.activeSelf).ToExpression((BattleResultViewModel vm) => (int)vm.ResultShowType != 3 || !vm.IsWin);
		bindingSet.Bind(btnOpenCopy).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenCopyCmd);
		bindingSet.Bind(btnAgain).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenTeamWindowCmd);
		bindingSet.Bind(Type4CopyObj).For((GameObject v) => v.activeSelf).ToExpression((BattleResultViewModel vm) => (int)vm.ResultShowType == 3 && vm.IsWin);
		bindingSet.Bind(btnOpenCopy4).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenCopyCmd);
		bindingSet.Bind(btnAgain4).For((Button v) => v.onClick).To((BattleResultViewModel vm) => vm.OpenCopyType4Cmd);
		bindingSet.Bind<TextMeshProUGUI>(rewardTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleResultViewModel vm) => vm.RewardTitle);
		bindingSet.Bind(this).For((BattleResultBaseWindow v) => v.OpenUguiWindow).To((BattleResultViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		LoadHero();
		battleResultTeamView.Init(viewModel);
		btnStatistic.onClick.AddListener(viewModel.OpenStatistic);
		btnStatistic2.onClick.AddListener(viewModel.OpenStatistic);
		inputCheck.AddAction(SliderAction);
		Type4Config();
		btnFirstEnter.onClick.AddListener(Left);
		emptyReward.SetActive(viewModel.RewardList.Count == 0 && viewModel.Type4ProgressVm == null);
		btnToTeamWindow.onClick.AddListener(Right);
		btnToRewardWindow.onClick.AddListener(Left);
		if (expFillHeadObj != null)
		{
			expFillHeadObj.gameObject.SetActive(value: false);
		}
		if (viewModel.IsCampaignMultiBattle)
		{
			btnAgain.gameObject.SetActive(value: false);
		}
	}

	private async void LoadHero()
	{
		heroImgPath = AssetUtility.GetUIItemAsset(viewModel.TeamList[0].HeroModel.Original);
		GameObject gameObject = await InstantiateAsync(heroImgPath, heroImgPos);
		UIUtilly.SpineMatchRectHelper(gameObject, heroImgPos, overwrite: false);
		SetHeroMaterialColor(gameObject);
		StreamerMode.ApplySpineSkin(gameObject);
	}

	private void SetHeroMaterialColor(GameObject go)
	{
		SkeletonGraphic[] componentsInChildren = go.GetComponentsInChildren<SkeletonGraphic>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			((Graphic)(object)componentsInChildren[i]).material = battleMaterial;
		}
	}

	private void Type4Config()
	{
		if (viewModel.Type4ProgressVm != null)
		{
			type4ProgressView.AddDragAction(delegate(bool b)
			{
				canSlider = b;
			});
			type4ProgressView.Init(viewModel.Type4ProgressVm);
			type4ProgressView.gameObject.SetActive(value: true);
			type4ProgressView.SetCopyItemRoot(barRoot);
			btnAgain4.gameObject.SetActive(!viewModel.Type4ProgressVm.IsAllComplete);
			((TMP_Text)openCopy4Text).text = (viewModel.Type4ProgressVm.NextChallenge ? "下个挑战" : "下个裂隙");
		}
	}

	protected override void OnShow()
	{
		base.OnShow();
		PlayBattleResultAudio();
	}

	public void PlayBattleResultAudio()
	{
		UniTask.Delay(1000);
		viewModel.PlayBattleResultAudio();
	}

	private void SliderAction(string action)
	{
		if (viewModel.Canslider && canSlider)
		{
			if (action.Equals("Left") && isTeamView)
			{
				Left();
			}
			if (action.Equals("Right") && !isTeamView)
			{
				Right();
			}
		}
	}

	private void Left()
	{
		btnFirstEnter.gameObject.SetActive(value: false);
		isTeamView = false;
		string text = (viewModel.IsWin ? "WinBackReward" : "FailBackReward");
		animator.SetTrigger(Animator.StringToHash(text));
		if (isFirstOnClick)
		{
			PlayLevelUpEffect();
			viewModel.OpenLevelUpTip();
			isFirstOnClick = false;
		}
	}

	private void Right()
	{
		btnFirstEnter.gameObject.SetActive(value: false);
		isTeamView = true;
		string text = (viewModel.IsWin ? "WinBackTeam" : "FailBackTeam");
		animator.SetTrigger(Animator.StringToHash(text));
		isFirstOnClick = false;
	}

	private void PlayLevelUpEffect()
	{
		if (viewModel.BattleReward.AccountExpDelta == 0L)
		{
			return;
		}
		totalWidth = fillObj.GetComponent<RectTransform>().rect.width;
		expEffectFillRect.sizeDelta = new Vector2(totalWidth * viewModel.RoleOldExpFill, 6f);
		curExpWidth = expEffectFillRect.rect.width;
		float num = (viewModel.BattleReward.IsUpgrade ? (totalWidth * (viewModel.RoleCurExpFill + 1f - viewModel.RoleOldExpFill)) : (totalWidth * viewModel.RoleCurExpFill));
		duration = 100;
		if (viewModel.BattleReward.AccountExpDelta == 0L)
		{
			curExpWidth = totalWidth * viewModel.RoleCurExpFill;
			expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 6f);
			return;
		}
		if (expFillHeadObj != null)
		{
			expFillHeadObj.gameObject.SetActive(value: true);
		}
		perExpAdd = (num - curExpWidth) / (float)duration;
		addExpTimer = Timer.Register(0.01f, AddExp, null, isLooped: true, useRealTime: true);
	}

	private void AddExp()
	{
		duration--;
		if (duration < 0)
		{
			if (expFillHeadObj != null)
			{
				expFillHeadObj.gameObject.SetActive(value: false);
			}
			curExpWidth = totalWidth * viewModel.RoleCurExpFill;
			expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 6f);
			CloseAddExpTimer();
		}
		else
		{
			curExpWidth += perExpAdd;
			if (curExpWidth >= totalWidth && viewModel.BattleReward.IsUpgrade)
			{
				curExpWidth = 0f;
			}
			expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 6f);
		}
	}

	private void CloseAddExpTimer()
	{
		if (addExpTimer != null)
		{
			addExpTimer.Cancel();
			addExpTimer = null;
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		viewModel.StopBattleResultAudio();
		CloseAddExpTimer();
		Dismiss();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
