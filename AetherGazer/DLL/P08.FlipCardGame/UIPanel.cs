using P08.Gamepad;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

[RequireComponent(typeof(CanvasGroup))]
public class UIPanel : MonoBehaviour
{
	[SerializeField]
	private bool ignoreAnimator;

	private CanvasGroup _canvasGroup;

	public bool defaultActive = true;

	private bool _setedActive;

	private bool _active;

	private UIBGM _uiBGM;

	private TipsAudio _tipsAudio;

	private StopAudioBeforeExit _stopAudio;

	private HIDInputPage _hidPage;

	private void Awake()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
		_uiBGM = GetComponent<UIBGM>();
		_tipsAudio = GetComponent<TipsAudio>();
		_stopAudio = GetComponent<StopAudioBeforeExit>();
		_hidPage = GetComponent<HIDInputPage>();
	}

	private void Start()
	{
		if (!_setedActive)
		{
			SetActive(defaultActive, isInit: true);
		}
	}

	public bool GetActive()
	{
		return _active;
	}

	public void SetActive(bool value, bool isInit = false)
	{
		_active = value;
		_setedActive = true;
		if (_canvasGroup != null)
		{
			_canvasGroup.alpha = (value ? 1 : 0);
			_canvasGroup.blocksRaycasts = value;
		}
		Graphic[] componentsInChildren = GetComponentsInChildren<Graphic>();
		foreach (Graphic graphic in componentsInChildren)
		{
			if (value)
			{
				if (graphic.IsActive())
				{
					GraphicRegistry.RegisterGraphicForCanvas(graphic.canvas, graphic);
				}
			}
			else
			{
				GraphicRegistry.UnregisterGraphicForCanvas(graphic.canvas, graphic);
			}
		}
		if (value && !ignoreAnimator)
		{
			Animator[] componentsInChildren2 = GetComponentsInChildren<Animator>(includeInactive: true);
			foreach (Animator animator in componentsInChildren2)
			{
				if (animator.isActiveAndEnabled && animator.runtimeAnimatorController != null)
				{
					animator.Play(animator.GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 0f);
					animator.speed = 1f;
				}
			}
			PlayableDirector[] componentsInChildren3 = GetComponentsInChildren<PlayableDirector>();
			for (int k = 0; k < componentsInChildren3.Length; k++)
			{
				if (componentsInChildren3[k].isActiveAndEnabled)
				{
					componentsInChildren3[k].Play();
					componentsInChildren3[k].time = 0.0;
				}
			}
			HoverEffect[] componentsInChildren4 = GetComponentsInChildren<HoverEffect>();
			for (int l = 0; l < componentsInChildren4.Length; l++)
			{
				if (componentsInChildren4[l].isActiveAndEnabled)
				{
					componentsInChildren4[l].RecoverState();
				}
			}
			UIRedPoint[] componentsInChildren5 = GetComponentsInChildren<UIRedPoint>();
			for (int m = 0; m < componentsInChildren5.Length; m++)
			{
				componentsInChildren5[m].OnEnable();
			}
		}
		else
		{
			Animator[] componentsInChildren6 = GetComponentsInChildren<Animator>(includeInactive: true);
			foreach (Animator animator2 in componentsInChildren6)
			{
				if (animator2.isActiveAndEnabled && animator2.runtimeAnimatorController != null)
				{
					animator2.speed = 0f;
				}
			}
			PlayableDirector[] componentsInChildren7 = GetComponentsInChildren<PlayableDirector>();
			for (int num = 0; num < componentsInChildren7.Length; num++)
			{
				componentsInChildren7[num].Stop();
			}
			UIRedPoint[] componentsInChildren8 = GetComponentsInChildren<UIRedPoint>();
			for (int num2 = 0; num2 < componentsInChildren8.Length; num2++)
			{
				componentsInChildren8[num2].OnDisable();
			}
		}
		if (null != _uiBGM)
		{
			_uiBGM.mute = !value;
			if (value)
			{
				_uiBGM.RestartBGM();
			}
		}
		if (null != _tipsAudio)
		{
			_tipsAudio.enabled = value;
		}
		if (null != _stopAudio && !value)
		{
			_stopAudio.StopAudio();
		}
		if (_hidPage != null)
		{
			if (value)
			{
				_hidPage.EnablePageIfNeed();
			}
			else
			{
				_hidPage.DisablePageIfNeed();
			}
		}
	}

	private void OnDestroy()
	{
		Graphic[] componentsInChildren = GetComponentsInChildren<Graphic>();
		foreach (Graphic graphic in componentsInChildren)
		{
			GraphicRegistry.UnregisterGraphicForCanvas(graphic.canvas, graphic);
		}
	}
}
