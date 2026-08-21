#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class UIGuidanceWindow : UGuiWindow
{
	public UITipGuidanceView uiTipGuidanceView;

	public CustomUIMask customUiMask;

	public UIGuidanceViewModel viewModel;

	public GameObject videoRoot;

	public CanvasGroup videoRootCanvasGroup;

	[SerializeField]
	private Transform videoParent;

	public TextMeshProUGUI videoText;

	public RawImage videoTexture;

	public TextMeshProUGUI videoName;

	public GameObject root;

	public Image clickMask;

	private Animator animator;

	private GameObject videoPrefab;

	private string videoConfigName;

	private VideoPlayer prefabVideoPlayer;

	private RenderTexture rt;

	protected override async void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		animator = GetComponent<Animator>();
	}

	public async void BindGuidance(UIGuidanceViewModel viewModel)
	{
		if (viewModel == null || !viewModel.IsVaild)
		{
			Close();
			return;
		}
		if (this.viewModel == null)
		{
			this.viewModel = viewModel;
			InitBinding();
		}
		else
		{
			this.viewModel = viewModel;
			this.SetDataContext(viewModel);
		}
		uiTipGuidanceView.Init(this.viewModel);
		videoRootCanvasGroup.alpha = 0f;
		customUiMask.OnClickCallback = delegate
		{
			customUiMask.LockHollowOut = true;
			customUiMask.arrowDirect = 0;
			this.viewModel.IsFinish = true;
			uiTipGuidanceView.gameObject.SetActive(value: false);
		};
		if (!Visibility)
		{
			await DoShow(ignoreAnimation: true);
		}
		if ((bool)(UnityEngine.Object)(object)animator && !((Behaviour)(object)animator).enabled)
		{
			((Behaviour)(object)animator).enabled = true;
		}
		this.viewModel.OnShowTip();
		await new WaitUntil(() => customUiMask.size == viewModel.Size);
		customUiMask.Refresh();
		customUiMask.LockHollowOut = false;
		this.viewModel.OpenTeachingPageWindow();
		if (Singleton<GameSystem>.Instance != null)
		{
			Singleton<GameSystem>.Instance.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, pause: true, allPause: true, transition: true));
		}
	}

	private void InitBinding()
	{
		BindingSet<UIGuidanceWindow, UIGuidanceViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((UIGuidanceWindow v) => v.OpenUguiWindow).To((UIGuidanceViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.offset).To((UIGuidanceViewModel vm) => vm.Offset);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.size).To((UIGuidanceViewModel vm) => vm.Size);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.ShowHollowOut).ToExpression((UIGuidanceViewModel vm) => vm.GuidanceTarget != null && !vm.VideoClipOpen);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.target).ToExpression((UIGuidanceViewModel vm) => vm.GuidanceTarget);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.cliclAnyWhere).ToExpression((UIGuidanceViewModel vm) => vm.GuidanceType == 2 && vm.WaitTime <= 0f);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.color).ToExpression((UIGuidanceViewModel vm) => vm.Alpha);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.eventClickLockCenter).ToExpression((UIGuidanceViewModel vm) => vm.GuidanceType == 3);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.arrowDirect).ToExpression((UIGuidanceViewModel vm) => vm.FingerDirection);
		bindingSet.Bind(customUiMask).For((CustomUIMask v) => v.arrowOffset).ToExpression((UIGuidanceViewModel vm) => vm.FingerShifting);
		bindingSet.Bind(videoRoot).For((GameObject v) => v.activeSelf).To((UIGuidanceViewModel vm) => vm.VideoClipOpen);
		bindingSet.Bind<TextMeshProUGUI>(videoText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UIGuidanceViewModel vm) => vm.TipText);
		bindingSet.Bind<TextMeshProUGUI>(videoName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((UIGuidanceViewModel vm) => vm.VideoName);
		bindingSet.Bind().For((UIGuidanceWindow v) => v.OnVideoPlayRequest).To((UIGuidanceViewModel vm) => vm.OnVideoPlayRequest);
		bindingSet.Bind(clickMask).For((Image v) => v.raycastTarget).ToExpression((UIGuidanceViewModel vm) => vm.DelayTime != 0f);
		bindingSet.Bind(clickMask.gameObject).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => vm.DelayTime != 0f);
		bindingSet.Bind(root).For((GameObject v) => v.activeSelf).ToExpression((UIGuidanceViewModel vm) => vm.DelayTime == 0f);
		bindingSet.Bind().For((UIGuidanceWindow v) => v.onCloseRequest).To((UIGuidanceViewModel vm) => vm.OnCloseRequest);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
	}

	public async void CloseGuidanceWindow()
	{
		customUiMask.ShowHollowOut = false;
		customUiMask.LockHollowOut = true;
		customUiMask.arrowDirect = 0;
		customUiMask.Refresh();
		await new WaitForFixedUpdate();
		if (Visibility)
		{
			this.SetVisibility(visibility: false);
		}
		Singleton<GameSystem>.Instance?.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, pause: false, allPause: true));
	}

	private void onCloseRequest(object sender, InteractionEventArgs e)
	{
		CloseGuidanceWindow();
	}

	private void OnVideoPlayError(VideoPlayer source, string message)
	{
		Log.Error("播放视频出错. 错误信息 ： " + message);
		if (viewModel != null)
		{
			viewModel.IsFinish = true;
		}
	}

	private void EndReached(VideoPlayer source)
	{
	}

	private async void OnVideoPlayRequest(object sender, InteractionEventArgs e)
	{
		await LoadVideoPrefab();
		if ((UnityEngine.Object)(object)prefabVideoPlayer != null)
		{
			prefabVideoPlayer.loopPointReached += new EventHandler(EndReached);
			prefabVideoPlayer.errorReceived += new ErrorEventHandler(OnVideoPlayError);
			CreateRendererTexture();
			await new WaitUntil(() => prefabVideoPlayer.isPlaying);
		}
		videoRootCanvasGroup.alpha = 1f;
	}

	private async UniTask LoadVideoPrefab()
	{
		UnVideoPlayer();
		if (!string.IsNullOrEmpty(viewModel.VideoClipName))
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetGuideVideoPrefab(viewModel.VideoClipName), videoParent);
			if (!(gameObject == null))
			{
				videoPrefab = gameObject;
				prefabVideoPlayer = videoPrefab.GetComponentInChildren<VideoPlayer>();
				VideoPlayerAddEvent(prefabVideoPlayer);
				videoPrefab.SetActive(value: true);
				videoConfigName = viewModel.VideoClipName;
			}
		}
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
			GameEntry.Resource.UnloadAsset(AssetUtility.GetGuideVideoPrefab(videoConfigName));
			prefabVideoPlayer = null;
		}
		videoConfigName = string.Empty;
	}

	private void VideoPlayerAddEvent(VideoPlayer videoPlayer)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Expected O, but got Unknown
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Expected O, but got Unknown
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Expected O, but got Unknown
		videoPlayer.isLooping = true;
		videoPlayer.loopPointReached += new EventHandler(EndReached);
		videoPlayer.errorReceived += new ErrorEventHandler(OnVideoPlayError);
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
		videoPlayer.loopPointReached -= new EventHandler(EndReached);
		videoPlayer.errorReceived -= new ErrorEventHandler(OnVideoPlayError);
		videoPlayer.errorReceived -= new ErrorEventHandler(OnVideoPlayError);
	}

	protected override void OnDismiss()
	{
		UnVideoPlayer();
		if (rt != null)
		{
			rt.Release();
		}
		base.OnDismiss();
	}

	private void CreateRendererTexture()
	{
		if (viewModel.VideoClipOpen)
		{
			if (rt == null)
			{
				rt = new RenderTexture(1145, 642, 16, RenderTextureFormat.ARGB32);
				rt.Create();
			}
			prefabVideoPlayer.targetTexture = rt;
			videoTexture.texture = prefabVideoPlayer.targetTexture;
			prefabVideoPlayer.targetTexture.Release();
		}
	}
}
