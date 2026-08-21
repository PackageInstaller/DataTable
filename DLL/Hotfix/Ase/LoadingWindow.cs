#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using FMOD.Studio;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LoadingWindow : UGuiWindow
{
	public Image bg;

	public TextMeshProUGUI progressBarText;

	public Image progressBarRight;

	public TextMeshProUGUI tipText;

	public TextMeshProUGUI titleText;

	public float interval = 20f;

	private LoadingViewModel viewModel;

	private float cur;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<LoadingViewModel>();
		BindingSet<LoadingWindow, LoadingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((LoadingWindow v) => v.OnDismissRequest).To((LoadingViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((LoadingWindow v) => v.OpenUguiWindow).To((LoadingViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(progressBarRight).For((Image v) => v.fillAmount).To((LoadingViewModel vm) => vm.ProgressBar.Progress);
		bindingSet.Bind(progressBarRight.gameObject).For((GameObject v) => v.activeSelf).To((LoadingViewModel vm) => vm.ProgressBar.Enable)
			.OneWay();
		bindingSet.Bind<TextMeshProUGUI>(progressBarText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((LoadingViewModel vm) => $"{Mathf.FloorToInt(vm.ProgressBar.Progress * 100f)}%")
			.OneWay();
		bindingSet.Bind<TextMeshProUGUI>(tipText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LoadingViewModel vm) => vm.ProgressBar.Tip)
			.OneWay();
		bindingSet.Bind<TextMeshProUGUI>(titleText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LoadingViewModel vm) => vm.ProgressBar.Title)
			.OneWay();
		bindingSet.Bind().For((LoadingWindow v) => v.Alpha).To((LoadingViewModel vm) => vm.Alpha)
			.OneWay();
		bindingSet.Bind<CanvasGroup>(CanvasGroup).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((LoadingViewModel vm) => vm.BlocksRaycasts)
			.OneWay();
		bindingSet.Build();
		LoadImg();
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.StartLoading();
	}

	private async void LoadImg()
	{
		try
		{
			Sprite bgSprite = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetBgSprite();
			if (bgSprite == null)
			{
				Log.Error("loading 背景图未缓存！");
				return;
			}
			bg.sprite = bgSprite;
			bg.color = Color.white;
		}
		catch (Exception)
		{
			Log.Error("加载Loading图片异常！");
		}
	}

	private void FixedUpdate()
	{
		if (cur < interval)
		{
			cur += Time.deltaTime;
		}
		else
		{
			cur = 0f;
		}
	}

	private new void OnDismissRequest(object sender, InteractionEventArgs args)
	{
		Singleton<AudioSystem>.Instance.StopGlobalSnapshot(100052, (STOP_MODE)0);
		base.OnDismissRequest(sender, args);
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		bg.sprite = null;
	}
}
