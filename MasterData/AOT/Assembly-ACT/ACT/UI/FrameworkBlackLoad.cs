using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class FrameworkBlackLoad : FrameworkComponent
{
	[SerializeField]
	[FormerlySerializedAs("animator")]
	private Animator _animator;

	[SerializeField]
	private Image _backImage;

	private bool enableFinish;

	private bool disableFinish;

	private bool _skipBaseEnabled;

	public override async UniTask Enable(FrameworkComponentData data = null)
	{
		await Fade(active: true, immediate: false);
	}

	public override async UniTask EnableImmediate(FrameworkBlackLoadData data = null)
	{
		await Fade(active: true, immediate: true);
	}

	public override async UniTask Disable(FrameworkComponentData data = null)
	{
		await Fade(active: false, immediate: false);
	}

	public override async UniTask DisableImmediate(FrameworkBlackLoadData data = null)
	{
		await Fade(active: false, immediate: true);
	}

	private async UniTask Fade(bool active, bool immediate)
	{
		if (enable == active)
		{
			return;
		}
		enable = active;
		if (active)
		{
			ResetData();
			gameObject.SetActive(value: true);
			if (immediate)
			{
				_animator.enabled = false;
				Color color = _backImage.color;
				color.a = 1f;
				_backImage.color = color;
				EnableFinish();
			}
			else
			{
				_animator.enabled = true;
				_animator.Play("Show");
			}
			await UniTask.WaitUntil(() => enableFinish);
		}
		else
		{
			SetLoadingBaseCameraSkip(skip: false);
			if (immediate)
			{
				_animator.enabled = false;
				Color color2 = _backImage.color;
				color2.a = 0f;
				_backImage.color = color2;
				disableFinish = true;
			}
			else
			{
				_animator.enabled = true;
				_animator.Play("Hide");
			}
			await UniTask.WaitUntil(() => disableFinish);
			gameObject.SetActive(value: false);
		}
	}

	private void ResetData()
	{
		enableFinish = false;
		disableFinish = false;
	}

	public void EnableFinish()
	{
		enableFinish = true;
		if (enable && isActiveAndEnabled)
		{
			SetLoadingBaseCameraSkip(skip: true);
		}
	}

	public void DisableFinish()
	{
		disableFinish = true;
	}

	private void SetLoadingBaseCameraSkip(bool skip)
	{
		if (_skipBaseEnabled != skip)
		{
			_skipBaseEnabled = skip;
			UniversalRenderPipeline.SetBaseCameraSkip(skip);
		}
	}

	private void OnDisable()
	{
		SetLoadingBaseCameraSkip(skip: false);
	}
}
