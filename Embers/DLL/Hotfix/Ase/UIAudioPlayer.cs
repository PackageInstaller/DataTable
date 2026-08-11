using System.Collections.Generic;
using FMOD.Studio;
using UnityEngine;
using UnityEngine.UI;
using Yarn.Unity;

namespace Ase;

public class UIAudioPlayer : MonoBehaviour
{
	public FMOD_Define.UIAudioEnum uiEnum = FMOD_Define.UIAudioEnum.BUTTON_CLICK;

	public AudioType audioType = AudioType.SoundEffect;

	public int configId;

	public float volume = 1f;

	public bool clearBgmStack;

	public STOP_MODE stopMode;

	public bool bgmPause;

	public Transform snapshotTrans;

	public float fadeInTime = 3f;

	public float fadeOutTime = 3f;

	public List<AudioParameterSerializable> paramList = new List<AudioParameterSerializable>();

	public bool hostingAudioPause;

	private EventInstance _instance;

	private void Awake()
	{
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		if (audioType == AudioType.SoundEffect || audioType == AudioType.PlaySnapshot || audioType == AudioType.StopSnapshot)
		{
			_instance = (EventInstance)((Singleton<AudioSystem>.Instance == null) ? default(EventInstance) : Singleton<AudioSystem>.Instance.CreateInstance(configId, volume, paramList));
		}
		TryBinding();
	}

	private void Start()
	{
		HandleGameEvent(FMOD_Define.UIAudioEnum.ObjectStart);
	}

	private void OnDestroy()
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		HandleGameEvent(FMOD_Define.UIAudioEnum.ObjectDestroy);
		if (((EventInstance)(ref _instance)).isValid())
		{
			EventDescription val = default(EventDescription);
			((EventInstance)(ref _instance)).getDescription(ref val);
			bool flag = default(bool);
			((EventDescription)(ref val)).isOneshot(ref flag);
			if (!flag)
			{
				((EventInstance)(ref _instance)).stop(stopMode);
				((EventInstance)(ref _instance)).release();
				((EventInstance)(ref _instance)).clearHandle();
			}
		}
	}

	private void OnEnable()
	{
		HandleGameEvent(FMOD_Define.UIAudioEnum.ObjectEnable);
	}

	private void OnDisable()
	{
		HandleGameEvent(FMOD_Define.UIAudioEnum.ObjectDisable);
	}

	public void AudioInvoke()
	{
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_018c: Unknown result type (might be due to invalid IL or missing references)
		//IL_020a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b4: Unknown result type (might be due to invalid IL or missing references)
		switch (audioType)
		{
		case AudioType.SoundEffect:
			((EventInstance)(ref _instance)).start();
			break;
		case AudioType.BGM:
			Singleton<AudioSystem>.Instance?.PlayBgm(configId, new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.BGMCheckId:
			Singleton<AudioSystem>.Instance?.PlayBgmWithIdCheck(configId, new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode, fadeInTime, fadeOutTime));
			break;
		case AudioType.SetBGMParameter:
			Singleton<AudioSystem>.Instance?.SetBgmParameter(configId, new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBgmParameter:
			Singleton<AudioSystem>.Instance?.SetCurBgmParameter(new FMOD_Define.BgmParameter(volume, paramList, !clearBgmStack, stopMode));
			break;
		case AudioType.SetCurBGMPause:
		{
			float fadeTime = (bgmPause ? fadeOutTime : fadeInTime);
			Singleton<AudioSystem>.Instance?.SetBgmPause(bgmPause, fadeTime);
			break;
		}
		case AudioType.StopBGM:
			Singleton<AudioSystem>.Instance?.StopBgm(configId, stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.StopCurBGM:
			Singleton<AudioSystem>.Instance?.StopCurBgm(stopMode, clearBgmStack, fadeInTime, fadeOutTime);
			break;
		case AudioType.PlaySnapshot:
			Singleton<AudioSystem>.Instance?.PlayGlobalSnapshot(configId, new FMOD_Define.SoundEffectParameter(volume, paramList));
			break;
		case AudioType.StopSnapshot:
			Singleton<AudioSystem>.Instance?.StopGlobalSnapshot(configId, stopMode);
			break;
		case AudioType.SetHostAudioPause:
			Singleton<AudioSystem>.Instance?.SetHostingAudioPause(hostingAudioPause);
			break;
		case AudioType.DebugBgmInfos:
			Singleton<AudioSystem>.Instance?.DebugBgmList();
			break;
		case AudioType.ClearSnapshot:
			Singleton<AudioSystem>.Instance?.ClearGlobalSnapshot();
			break;
		}
	}

	private void HandleGameEvent(FMOD_Define.UIAudioEnum audioEnum)
	{
		if (audioEnum.Equals(uiEnum))
		{
			AudioInvoke();
		}
	}

	public void TryBinding()
	{
		switch (uiEnum)
		{
		case FMOD_Define.UIAudioEnum.BUTTON_CLICK:
			BindButtonClick();
			break;
		case FMOD_Define.UIAudioEnum.TOGGLE_IN:
			BindToggle(state: true);
			break;
		case FMOD_Define.UIAudioEnum.TOGGLE_OUT:
			BindToggle(state: false);
			break;
		case FMOD_Define.UIAudioEnum.VIEW_ANIMATION_ENTER:
			BindViewAnimation(state: true);
			break;
		case FMOD_Define.UIAudioEnum.VIEW_ANIMATION_OUT:
			BindViewAnimation(state: false);
			break;
		case FMOD_Define.UIAudioEnum.AnimationUIView_Show:
			BindAnimationUIView(state: true);
			break;
		case FMOD_Define.UIAudioEnum.AnimationUIView_Hide:
			BindAnimationUIView(state: false);
			break;
		case FMOD_Define.UIAudioEnum.OnPointerDown:
			BindOnPointerDown();
			break;
		case FMOD_Define.UIAudioEnum.OnPointerClick:
			BindOnPointerClick();
			break;
		case FMOD_Define.UIAudioEnum.NONE:
		case FMOD_Define.UIAudioEnum.ObjectStart:
		case FMOD_Define.UIAudioEnum.ObjectDestroy:
		case FMOD_Define.UIAudioEnum.ObjectEnable:
		case FMOD_Define.UIAudioEnum.ObjectDisable:
			break;
		}
	}

	private void BindButtonClick()
	{
		Button component = GetComponent<Button>();
		if (component != null)
		{
			component.onClick.AddListener(AudioInvoke);
			return;
		}
		ButtonLong component2 = GetComponent<ButtonLong>();
		if (component2 != null)
		{
			component2.onClick.AddListener(AudioInvoke);
			return;
		}
		OptionView component3 = GetComponent<OptionView>();
		if (component3 != null)
		{
			component3.onClick.AddListener(AudioInvoke);
		}
	}

	private void BindToggle(bool state)
	{
		Toggle component = GetComponent<Toggle>();
		if (!(component != null))
		{
			return;
		}
		component.onValueChanged.AddListener(delegate(bool p)
		{
			if (p == state)
			{
				AudioInvoke();
			}
		});
	}

	private void BindViewAnimation(bool state)
	{
		AnimatorAnimation[] components = GetComponents<AnimatorAnimation>();
		if (components == null)
		{
			return;
		}
		AnimatorAnimation[] array = components;
		foreach (AnimatorAnimation animatorAnimation in array)
		{
			if (state && animatorAnimation.animName.Equals("enter"))
			{
				animatorAnimation.OnStart(AudioInvoke);
			}
			else if (!state && animatorAnimation.animName.Equals("out"))
			{
				animatorAnimation.OnEnd(AudioInvoke);
			}
		}
	}

	private void BindAnimationUIView(bool state)
	{
		AnimationUIView component = GetComponent<AnimationUIView>();
		if (!(component == null))
		{
			if (state)
			{
				component.OnShow(AudioInvoke);
			}
			else
			{
				component.OnHide(AudioInvoke);
			}
		}
	}

	private void BindOnPointerDown()
	{
		CustomSlider component = GetComponent<CustomSlider>();
		if (component != null)
		{
			component.OnPointerDownEvent.AddListener(delegate
			{
				AudioInvoke();
			});
			return;
		}
		ButtonLong component2 = GetComponent<ButtonLong>();
		if (component2 != null)
		{
			component2.onPointUDown.AddListener(AudioInvoke);
		}
	}

	private void BindOnPointerClick()
	{
		TabToggle component = GetComponent<TabToggle>();
		if (component != null)
		{
			component.AddPointerClickAction(AudioInvoke);
		}
	}
}
