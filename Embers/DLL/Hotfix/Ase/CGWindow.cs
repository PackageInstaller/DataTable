#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UnityEngine.Video;

namespace Ase;

public class CGWindow : UGuiWindow, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	[SerializeField]
	private VideoPlayer videoPlayer;

	[SerializeField]
	private Image skipBar;

	[SerializeField]
	private GameObject skipRoot;

	[SerializeField]
	private float skipTime;

	[SerializeField]
	private bool enableTouchSkip = true;

	private bool isTouchSkip;

	private CGViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		//IL_0347: Unknown result type (might be due to invalid IL or missing references)
		//IL_0351: Expected O, but got Unknown
		//IL_035e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0368: Expected O, but got Unknown
		base.OnCreate(bundle);
		viewModel = GetData<CGViewModel>();
		viewModel.UpdateSkipTime(Mathf.Clamp(skipTime, 3f, 10f));
		BindingSet<CGWindow, CGViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((CGWindow v) => v.PlayVideo).To((CGViewModel vm) => vm.PlayVideoRequest);
		bindingSet.Bind().For((CGWindow v) => v.OnCloseWindowRequest).To((CGViewModel vm) => vm.CloseRequest);
		bindingSet.Bind(skipBar).For((Image v) => v.fillAmount).ToExpression((CGViewModel vm) => vm.SkipProgress / vm.SkipTime);
		bindingSet.Bind(skipRoot).For((GameObject v) => v.activeSelf).ToExpression((CGViewModel vm) => vm.SkipProgress > 0f);
		bindingSet.Build();
		videoPlayer.loopPointReached += new EventHandler(EndReached);
		videoPlayer.errorReceived += new ErrorEventHandler(OnVideoPlayError);
	}

	private void PlayVideo(object sender, InteractionEventArgs e)
	{
		videoPlayer.Play();
	}

	private void OnVideoPlayError(VideoPlayer source, string message)
	{
		Log.Error("播放视频出错. 错误信息 ： " + message);
		viewModel.Exit();
	}

	private void EndReached(VideoPlayer source)
	{
		viewModel.Exit();
	}

	private void OnCloseWindowRequest(object sender, InteractionEventArgs args)
	{
		Dismiss();
	}

	private void Update()
	{
		if (enableTouchSkip)
		{
			if (isTouchSkip)
			{
				viewModel.UpdateSkipProgress(Time.deltaTime);
			}
			else if (viewModel.SkipProgress > 0f && viewModel.SkipProgress < skipTime)
			{
				viewModel.UpdateSkipProgress(0f - Time.deltaTime);
			}
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		isTouchSkip = true;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		isTouchSkip = false;
	}
}
