using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LoadingSpineWindow : Window
{
	public Image image;

	public float minLoadingDuration;

	public Animator animator;

	public string nextWindowPath;

	private bool _minDurationFinished;

	private OptionBase _parentData;

	private int _enterSkinId;

	protected override void OnCreate(IBundle bundle)
	{
		base.WindowType = WindowType.PROGRESS;
	}

	public void SetParentData(OptionBase parent, int enterSkinId)
	{
		_parentData = parent;
		_enterSkinId = enterSkinId;
	}

	public void SetImage(Sprite sprite)
	{
		image.sprite = sprite;
		image.SetNativeSize();
	}

	public void StartPlay()
	{
		OnInit();
	}

	private async void OnInit()
	{
		await StartEnterAnimation();
		StartMinTimer();
		UGuiWindow nextWindow = await StartLoadingNext();
		await UniTask.WaitUntil(() => _minDurationFinished);
		if (nextWindow == null)
		{
			Dismiss();
			return;
		}
		nextWindow.Show();
		await StartOutAnimation();
		Dismiss();
	}

	private async UniTask StartEnterAnimation()
	{
		float length = animator.runtimeAnimatorController.animationClips.ToList().Find((AnimationClip p) => ((Object)(object)p).name == "enter").length;
		animator.SetTrigger("enter");
		await UniTask.WaitForSeconds(length);
	}

	private async void StartMinTimer()
	{
		_minDurationFinished = false;
		await UniTask.WaitForSeconds(minLoadingDuration);
		_minDurationFinished = true;
	}

	private async UniTask<UGuiWindow> StartLoadingNext()
	{
		return await OpenSpinePlayWindow(nextWindowPath, new SpinePlayViewModel(_parentData, _enterSkinId), "DEFAULT");
	}

	private async UniTask StartOutAnimation()
	{
		float length = animator.runtimeAnimatorController.animationClips.ToList().Find((AnimationClip p) => ((Object)(object)p).name == "out").length;
		animator.SetTrigger("out");
		await UniTask.WaitForSeconds(length);
	}

	protected async Task<UGuiWindow> OpenSpinePlayWindow(string path, object userData, string uiGroupName)
	{
		return await GameEntry.UI.OpenWindow<UGuiWindow>(path, uiGroupName, userData);
	}
}
