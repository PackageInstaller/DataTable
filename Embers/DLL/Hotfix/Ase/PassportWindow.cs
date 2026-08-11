using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnGameTip;

	[SerializeField]
	private GameObject levelObj;

	[SerializeField]
	private TextMeshProUGUI leftTimeText;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private Image sliderFill;

	[SerializeField]
	private TextMeshProUGUI curExpText;

	[SerializeField]
	private TextMeshProUGUI weekExpText;

	[SerializeField]
	private Button btnUpLevel;

	[SerializeField]
	private UIParticlePlayer levelUpEffect;

	[SerializeField]
	private PassportRewardView passportRewardView;

	[SerializeField]
	private PassportTaskView passportTaskView;

	[SerializeField]
	private PassportShowView passportShowView;

	[SerializeField]
	private List<TabItemNormal> tabList;

	[SerializeField]
	private GameObject fillObj;

	[SerializeField]
	private RectTransform expEffectFillRect;

	[SerializeField]
	private UIParticlePlayer expAddPlayer;

	[SerializeField]
	private UIParticlePlayer expFillHeadPlayer;

	[SerializeField]
	private UIParticlePlayer expFillPlayer;

	[SerializeField]
	private int fixDuration;

	private PassportViewModel viewModel;

	private int duration;

	private Timer addExpTimer;

	private float curExpWidth;

	private float perExpAdd;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PassportViewModel>();
		BindingSet<PassportWindow, PassportViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((PassportViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((PassportWindow v) => v.OpenUguiWindow).To((PassportViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PassportWindow v) => v.CloseWindow).To((PassportViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnGameTip).For((Button v) => v.onClick).To((PassportViewModel vm) => vm.OpenGameTipCmd);
		bindingSet.Bind(levelObj).For((GameObject v) => v.activeSelf).To((PassportViewModel vm) => vm.ShowLevel);
		bindingSet.Bind<TextMeshProUGUI>(leftTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportViewModel vm) => vm.LeftTimeText);
		bindingSet.Bind<TextMeshProUGUI>(levelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportViewModel vm) => vm.Level);
		bindingSet.Bind<TextMeshProUGUI>(curExpText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportViewModel vm) => vm.ExpText);
		bindingSet.Bind<TextMeshProUGUI>(weekExpText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportViewModel vm) => vm.ExpWeekText);
		bindingSet.Bind(btnUpLevel).For((Button v) => v.onClick).To((PassportViewModel vm) => vm.BuyLevelOnclick);
		bindingSet.Bind(this).For((PassportWindow v) => v.PlayExpAddEffect).To((PassportViewModel vm) => vm.PlayExpAddRequest);
		bindingSet.Bind(this).For((PassportWindow v) => v.PlayLevelUpEffect).To((PassportViewModel vm) => vm.PlayLevelUpRequest);
		bindingSet.Build();
		passportRewardView.Init(viewModel.PassportRewardViewModel);
		passportTaskView.Init(viewModel.PassportTaskViewModel);
		passportShowView.Init(viewModel.PassportShowViewModel);
		for (int num = 0; num < tabList.Count; num++)
		{
			tabList[num].Init(viewModel.TabList[num]);
		}
		SetFillStartPos();
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.ReSetTab();
	}

	private void SetFillStartPos()
	{
		float width = fillObj.GetComponent<RectTransform>().rect.width;
		expEffectFillRect.sizeDelta = new Vector2(width * viewModel.SliderFillAmount, 6f);
		sliderFill.fillAmount = viewModel.SliderFillAmount;
	}

	public void PlayExpAddEffect(object sender, InteractionEventArgs e)
	{
		if (viewModel.LevelUp || viewModel.OldSliderFillAmount != viewModel.SliderFillAmount)
		{
			float width = fillObj.GetComponent<RectTransform>().rect.width;
			expEffectFillRect.sizeDelta = new Vector2(width * viewModel.OldSliderFillAmount, 6f);
			sliderFill.fillAmount = viewModel.OldSliderFillAmount;
			duration = fixDuration;
			if (expFillHeadPlayer != null)
			{
				expFillHeadPlayer.Play();
			}
			if (expAddPlayer != null)
			{
				expAddPlayer.Hide();
				expAddPlayer.Play();
			}
			curExpWidth = width * viewModel.OldSliderFillAmount;
			float num = width * viewModel.SliderFillAmount;
			num = ((!viewModel.LevelUp) ? (num - curExpWidth) : (num + (width - curExpWidth)));
			perExpAdd = num / (float)duration;
			if (expFillPlayer != null)
			{
				expFillPlayer.Play();
				CloseAddExpTimer();
				addExpTimer = Timer.Register(0.01f, AddExp, null, isLooped: true, useRealTime: true);
			}
			PlayLevelUpEffect();
		}
	}

	public void PlayLevelUpEffect(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel.LevelUp && levelUpEffect != null)
		{
			levelUpEffect.Play();
		}
	}

	private void AddExp()
	{
		try
		{
			if (sliderFill == null || viewModel == null || expFillPlayer == null || expEffectFillRect == null || viewModel.PassportRewardViewModel == null || fillObj == null)
			{
				return;
			}
			duration--;
			if (duration < 0)
			{
				sliderFill.fillAmount = viewModel.SliderFillAmount;
				expFillPlayer.Hide();
				CloseAddExpTimer();
				return;
			}
			curExpWidth += perExpAdd;
			if (curExpWidth >= fillObj.GetComponent<RectTransform>()?.rect.width)
			{
				if (viewModel.Level == viewModel.PassportRewardViewModel.PassportLevelItemDataList.Count)
				{
					sliderFill.fillAmount = viewModel.SliderFillAmount;
					expFillPlayer.Hide();
					CloseAddExpTimer();
					return;
				}
				curExpWidth = 0f;
				sliderFill.fillAmount = 0f;
			}
			expEffectFillRect.sizeDelta = new Vector2(curExpWidth, 6f);
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
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
		Dismiss();
	}
}
