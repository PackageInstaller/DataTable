#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class TeachGuideImageVideoView : UGuiView
{
	public int GuideType = 1;

	private TeachGuideViewModel _viewModel;

	[SerializeField]
	private Transform videoParent;

	[SerializeField]
	private RawImage videoTexture;

	[SerializeField]
	private TextMeshProUGUI ImageText;

	[SerializeField]
	private TextMeshProUGUI TitleText;

	[SerializeField]
	private TextMeshProUGUI PageContent;

	[SerializeField]
	private Image ShowImage;

	[SerializeField]
	private Image VideoBlackScreen;

	[SerializeField]
	private Button CloseBtn;

	[SerializeField]
	private GameObject Bg;

	[SerializeField]
	private Button NextBtn;

	[SerializeField]
	private GameObject nextBtnEffect;

	[SerializeField]
	private Button PreBtn;

	[SerializeField]
	private GameObject preBtnEffect;

	private int currentPage;

	private int pageTotal;

	[SerializeField]
	private float videoPLayerBlackTime = 0.2f;

	[SerializeField]
	private float videoLoopBlend = 0.2f;

	private GameObject videoPrefab;

	private string videoName;

	private VideoPlayer prefabVideoPlayer;

	private Tween videoPlayerTween;

	private Tween titleTween;

	private Tween desTween;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = userData as TeachGuideViewModel;
		if (_viewModel != null && _viewModel.TeachConfig.TeachingType == GuideType)
		{
			base.gameObject.SetActive(value: true);
			BindingSet<TeachGuideImageVideoView, TeachGuideViewModel> bindingSet = this.CreateBindingSet(_viewModel);
			bindingSet.Bind<TextMeshProUGUI>(ImageText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachGuideViewModel vm) => vm.ShowDesContent);
			bindingSet.Bind(ShowImage).For((Image v) => v.enabled).ToExpression((TeachGuideViewModel vm) => vm.ShowImageName != string.Empty);
			bindingSet.Bind(this).For((TeachGuideImageVideoView v) => v.DesAlaphaChange).To((TeachGuideViewModel vm) => vm.DesPlayAnRequest);
			bindingSet.Bind(this).For((TeachGuideImageVideoView v) => v.TitleAlphaChange).To((TeachGuideViewModel vm) => vm.TitlePlayAnRequest);
			bindingSet.Build();
			CloseBtn.onClick.AddListener(CloseWindow);
			NextBtn.onClick.AddListener(ClickNextPage);
			PreBtn.onClick.AddListener(ClickPrePage);
		}
	}

	public void ShowContent()
	{
		if (_viewModel.TeachConfig.TeachingType == GuideType)
		{
			Bg.SetActive(_viewModel.TeachConfig.BlackShade);
			pageTotal = _viewModel.TeachConfig.PopupConfigure.Count;
			ClickNextPage();
		}
	}

	private void OnVideoPlayError(VideoPlayer source, string message)
	{
		Log.Error("播放视频出错. 错误信息 ： " + message);
	}

	private void EndReached(VideoPlayer source)
	{
		VideoBlackScreen.color = Color.black;
		videoPlayerTween = DOTweenModuleUI.DOFade(VideoBlackScreen, 0f, videoLoopBlend);
	}

	private void OnPrepareCompled(VideoPlayer videoPlayer)
	{
		if (_viewModel.PlayBlackScreenBlend)
		{
			videoPlayerTween = DOTweenModuleUI.DOFade(VideoBlackScreen, 0f, videoPLayerBlackTime);
		}
	}

	private void VideoPlayerAddEvent(VideoPlayer videoPlayer)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Expected O, but got Unknown
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Expected O, but got Unknown
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Expected O, but got Unknown
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Expected O, but got Unknown
		videoPlayer.isLooping = true;
		videoPlayer.loopPointReached += new EventHandler(EndReached);
		videoPlayer.errorReceived += new ErrorEventHandler(OnVideoPlayError);
		videoPlayer.prepareCompleted += new EventHandler(OnPrepareCompled);
		videoPlayer.errorReceived += new ErrorEventHandler(OnVideoPlayError);
		((Behaviour)(object)videoPlayer).enabled = false;
		((Behaviour)(object)videoPlayer).enabled = true;
	}

	private void VideoPlayRemoveEvent(VideoPlayer videoPlayer)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Expected O, but got Unknown
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Expected O, but got Unknown
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Expected O, but got Unknown
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Expected O, but got Unknown
		videoPlayer.loopPointReached -= new EventHandler(EndReached);
		videoPlayer.errorReceived -= new ErrorEventHandler(OnVideoPlayError);
		videoPlayer.prepareCompleted -= new EventHandler(OnPrepareCompled);
		videoPlayer.errorReceived -= new ErrorEventHandler(OnVideoPlayError);
	}

	private async void ChangePage()
	{
		if (_viewModel == null)
		{
			return;
		}
		if (_viewModel.PlayBlackScreenBlend)
		{
			if (videoPlayerTween != null && videoPlayerTween.IsPlaying())
			{
				videoPlayerTween.Kill();
				videoPlayerTween = null;
			}
			VideoBlackScreen.color = Color.black;
		}
		if (_viewModel.VideoName == string.Empty)
		{
			videoTexture.enabled = false;
			UnVideoPlayer();
		}
		else if (videoName != _viewModel.VideoName)
		{
			videoTexture.enabled = true;
			LoadVideoPrefab();
		}
		((TMP_Text)PageContent).text = $"{currentPage}/{pageTotal}";
		NextBtn.interactable = currentPage != pageTotal;
		PreBtn.interactable = currentPage != 1;
		nextBtnEffect.SetActive(currentPage != pageTotal);
		preBtnEffect.SetActive(currentPage != 1);
		if (_viewModel.ShowImageName != string.Empty)
		{
			Sprite sprite = await LoadSpriteAsync(AssetUtility.GetTeachGuideAsset(_viewModel.ShowImageName));
			if (this == null)
			{
				return;
			}
			ShowImage.sprite = sprite;
			if (_viewModel.PlayBlackScreenBlend)
			{
				videoPlayerTween = DOTweenModuleUI.DOFade(VideoBlackScreen, 0f, videoPLayerBlackTime);
			}
		}
		CloseBtn.gameObject.SetActive(currentPage == _viewModel.TeachConfig.PopupConfigure.Count);
	}

	private async void LoadVideoPrefab()
	{
		UnVideoPlayer();
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetGuideVideoPrefab(_viewModel.VideoName), videoParent);
		if (!(gameObject == null))
		{
			videoPrefab = gameObject;
			prefabVideoPlayer = videoPrefab.GetComponentInChildren<VideoPlayer>();
			VideoPlayerAddEvent(prefabVideoPlayer);
			videoPrefab.SetActive(value: true);
			videoName = _viewModel.VideoName;
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		UnVideoPlayer();
	}

	private void UnVideoPlayer()
	{
		if (videoPrefab != null)
		{
			if ((UnityEngine.Object)(object)prefabVideoPlayer != null)
			{
				VideoPlayRemoveEvent(prefabVideoPlayer);
			}
			videoPrefab.SetActive(value: false);
			UnityEngine.Object.Destroy(videoPrefab);
			GameEntry.Resource.UnloadAsset(AssetUtility.GetGuideVideoPrefab(videoName));
			prefabVideoPlayer = null;
		}
		videoName = string.Empty;
	}

	private void ClickNextPage()
	{
		if (currentPage != pageTotal)
		{
			currentPage++;
			_viewModel.ChangePage(currentPage, _viewModel.VideoURL, _viewModel.ShowImageName);
			ChangePage();
		}
	}

	private void ClickPrePage()
	{
		if (currentPage != 1)
		{
			currentPage--;
			_viewModel.ChangePage(currentPage, _viewModel.VideoURL, _viewModel.ShowImageName);
			ChangePage();
		}
	}

	private void CloseWindow()
	{
		if (_viewModel.TeachConfig.FinishCondition == 2 || _viewModel.TeachConfig.FinishCondition == 3)
		{
			_viewModel.CloseUI();
		}
	}

	private void TitleAlphaChange(object o, InteractionEventArgs args)
	{
		if (titleTween != null && titleTween.IsPlaying())
		{
			titleTween.Kill();
		}
		((TMP_Text)TitleText).alpha = 1f;
		titleTween = DOTweenModuleUI.DOFade((Graphic)(object)TitleText, 0f, 0.1f).OnComplete(delegate
		{
			((TMP_Text)TitleText).text = _viewModel.ShowTitleContent;
			DOTweenModuleUI.DOFade((Graphic)(object)TitleText, 1f, 0.1f);
		});
	}

	private void DesAlaphaChange(object o, InteractionEventArgs args)
	{
		if (desTween != null && desTween.IsPlaying())
		{
			desTween.Kill();
		}
		((TMP_Text)ImageText).alpha = 1f;
		desTween = DOTweenModuleUI.DOFade((Graphic)(object)ImageText, 0f, 0.1f).OnComplete(delegate
		{
			((TMP_Text)ImageText).text = _viewModel.ShowDesContent;
			DOTweenModuleUI.DOFade((Graphic)(object)ImageText, 1f, 0.1f);
		});
	}
}
