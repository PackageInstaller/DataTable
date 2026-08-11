#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class HeroInfoView : UGuiView
{
	[SerializeField]
	private Transform heroImage;

	[SerializeField]
	private TextMeshProUGUI painterName;

	[SerializeField]
	private CustomScrollRect scrollRect;

	private bool changeHeroEnable;

	public float changeHeroRange;

	private HeroInfoViewModel _viewModel;

	public GameObject _heroImgObj;

	private string originalAssetPath;

	private string assetTag = "HeroInfoView";

	public void Init(HeroInfoViewModel viewModel, bool changeHeroEnable = true)
	{
		_viewModel = viewModel;
		this.changeHeroEnable = changeHeroEnable;
		BindingSet<HeroInfoView, HeroInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(base.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroInfoViewModel vm) => !vm.HeroModel.IsNullOrEmpty());
		if ((UnityEngine.Object)(object)painterName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(painterName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HeroInfoViewModel vm) => vm.HeroModel.IsNullOrEmpty() ? "" : $"画师：{vm.HeroModel.PainterName}");
		}
		bindingSet.Bind().For((HeroInfoView v) => v.UpdateHeroInfo).To((HeroInfoViewModel vm) => vm.OnRefreshQuest);
		bindingSet.Build();
		scrollRect.enabled = changeHeroEnable;
		scrollRect.onValueChanged.AddListener(delegate
		{
			if (scrollRect.content.anchoredPosition.x > changeHeroRange)
			{
				scrollRect.content.SetLocalPositionX(changeHeroRange);
				ChangeHero(-1);
			}
			else if (scrollRect.content.anchoredPosition.x < 0f - changeHeroRange)
			{
				scrollRect.content.SetLocalPositionX(0f - changeHeroRange);
				ChangeHero(1);
			}
		});
		scrollRect.OnBeginDragEvent.AddListener(delegate
		{
			_viewModel.BeginDrag();
		});
		scrollRect.OnEndDragEvent.AddListener(delegate
		{
			_viewModel.EndDrag();
		});
		UpdateHeroInfo(null, null);
		GetComponent<HeroSkinChangeControl>()?.AddHeroSkinChangeAction(delegate(int heroId)
		{
			if (!_viewModel.HeroModel.IsNullOrEmpty() && heroId == _viewModel.HeroModel.Id)
			{
				UpdateHeroOriginal(_viewModel.HeroModel);
			}
		});
	}

	private void ChangeHero(int index)
	{
		_viewModel.ChangeHero(index);
		scrollRect.enabled = false;
	}

	public void ViewSetting(float viewAlpha, bool showInfo = true)
	{
		CanvasGroup.alpha = viewAlpha;
	}

	private void UpdateHeroInfo(object sender, InteractionEventArgs e)
	{
		HeroModel heroModel = _viewModel.HeroModel;
		if (!heroModel.IsNullOrEmpty())
		{
			UpdateHeroOriginal(heroModel);
		}
	}

	private async void UpdateHeroOriginal(HeroModel heroModel)
	{
		try
		{
			Clear();
			originalAssetPath = heroModel.Original;
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(originalAssetPath), heroImage);
			if (gameObject == null)
			{
				Toast.ShowInfo("找不到" + heroModel.Original + "文件");
			}
			else
			{
				_heroImgObj = gameObject;
				UIUtilly.SpineMatchRectHelper(_heroImgObj, heroImage, overwrite: false);
				StreamerMode.ApplySpineSkin(gameObject);
			}
		}
		catch (Exception ex)
		{
			Log.Error("加载资源发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
		scrollRect.enabled = changeHeroEnable;
	}

	public void Clear()
	{
		if (_heroImgObj != null)
		{
			UnityEngine.Object.Destroy(_heroImgObj);
			_heroImgObj = null;
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
