using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class DynamicTimelineTrackBinding : MonoBehaviour
{
	public enum EnumTimelineType
	{
		TL_DEFAULT,
		TL_REAL_TIME,
		TL_UI_WIN,
		TL_MINIGAME,
		TL_MULTIPLE
	}

	public EnumTimelineType _timelineType;

	[NonSerialized]
	private bool _isInstall;

	[NonSerialized]
	private bool _dontLoadChar;

	[NonSerialized]
	private bool _noNeedRoot;

	[NonSerialized]
	private bool _dontClearCtrl;

	[NonSerialized]
	private bool _dontHideOnStop;

	public PlayableDirector playableDirector;

	public List<P08CharBinding> CharBindings = new List<P08CharBinding>();

	public List<P08SceneBinding> SceneBindings = new List<P08SceneBinding>();

	public List<P08MixBinding> MixBindings = new List<P08MixBinding>();

	public Dictionary<string, P08CharBinding> dict = new Dictionary<string, P08CharBinding>();

	private void OnValueChanged_TimelineType()
	{
	}

	private void OnOnCollectionChanged_CharBindings()
	{
	}

	private void Awake()
	{
		InitConfig();
		if (!_dontLoadChar)
		{
			AutoInit();
		}
	}

	public virtual void AutoInit()
	{
		ManualInit();
	}

	public virtual void ManualInit()
	{
		LoadDict();
		BuildBindings();
	}

	public virtual void ManualInit(GameObject extGo)
	{
		if (_timelineType != EnumTimelineType.TL_MINIGAME)
		{
			Debug.LogError("非小游戏 Timline 类型禁止调用此方法 ManualInit(GameObject extGo)");
			return;
		}
		InitConfig();
		LoadDict(extGo);
		BuildBindings();
	}

	public virtual void ManualInit(Dictionary<string, P08ObjectBinding> extDict)
	{
		if (_timelineType != EnumTimelineType.TL_MULTIPLE)
		{
			Debug.LogError("非多实例 Timline 类型禁止调用此方法 ManualInit(Dictionary<string, P08ObjectBinding> extDict)");
			return;
		}
		InitConfig();
		LoadDict(extDict);
		BuildBindings();
	}

	private void OnStop(PlayableDirector director)
	{
		SetCharActive(flag: false);
	}

	private void OnPlay(PlayableDirector director)
	{
		SetCharActive(flag: true);
	}

	private void OnDestroy()
	{
		if (_dontLoadChar || !Application.isPlaying)
		{
			return;
		}
		foreach (KeyValuePair<string, P08CharBinding> item in dict)
		{
			if (!string.IsNullOrEmpty(item.Value.path))
			{
				Asset.Unload(item.Value.path);
			}
		}
	}

	private void InitConfig()
	{
		if (!_isInstall)
		{
			switch (_timelineType)
			{
			case EnumTimelineType.TL_REAL_TIME:
				_dontLoadChar = false;
				_noNeedRoot = true;
				_dontClearCtrl = true;
				_dontHideOnStop = false;
				break;
			case EnumTimelineType.TL_UI_WIN:
				_dontLoadChar = false;
				_noNeedRoot = false;
				_dontClearCtrl = false;
				_dontHideOnStop = true;
				break;
			case EnumTimelineType.TL_MINIGAME:
			case EnumTimelineType.TL_MULTIPLE:
				_dontLoadChar = true;
				_noNeedRoot = true;
				_dontClearCtrl = true;
				_dontHideOnStop = false;
				break;
			default:
				_dontLoadChar = false;
				_noNeedRoot = false;
				_dontClearCtrl = false;
				_dontHideOnStop = false;
				break;
			}
			_isInstall = true;
		}
	}

	protected void LoadDict()
	{
		foreach (P08CharBinding charBinding in CharBindings)
		{
			if (charBinding.go == null)
			{
				GameObject inst = charBinding.GetInst(base.gameObject);
				if (inst != null && !_dontLoadChar)
				{
					if (_noNeedRoot)
					{
						inst.transform.parent = base.transform;
						inst.transform.SetLocalPositionAndRotation(charBinding.position, charBinding.rotation);
					}
					else
					{
						GameObject gameObject = new GameObject("root");
						gameObject.transform.parent = base.transform;
						inst.transform.parent = gameObject.transform;
						gameObject.transform.SetLocalPositionAndRotation(charBinding.position, charBinding.rotation);
						inst.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
					}
				}
				charBinding.go = inst;
			}
			if (!dict.TryGetValue(charBinding.key, out var value) || value == null || value.go == null)
			{
				dict[charBinding.key] = charBinding;
			}
		}
	}

	protected void LoadDict(GameObject extGo)
	{
		if (!(extGo == null) && CharBindings.Count != 0)
		{
			P08CharBinding p08CharBinding = CharBindings[0];
			p08CharBinding.go = extGo;
			if (!dict.TryGetValue(p08CharBinding.key, out var value) || value == null || value.go == null)
			{
				dict[p08CharBinding.key] = p08CharBinding;
			}
		}
	}

	protected void LoadDict(Dictionary<string, P08ObjectBinding> exDict)
	{
		if (exDict == null || CharBindings.Count == 0)
		{
			return;
		}
		foreach (P08CharBinding charBinding in CharBindings)
		{
			if (!string.IsNullOrEmpty(charBinding.key) && exDict.TryGetValue(charBinding.key, out var value) && value != null)
			{
				charBinding.go = value.go;
				if (!dict.TryGetValue(charBinding.key, out var value2) || value2 == null || value2.go == null)
				{
					dict[charBinding.key] = charBinding;
				}
			}
		}
	}

	protected void BuildBindings()
	{
		if (playableDirector == null)
		{
			return;
		}
		foreach (P08SceneBinding sceneBinding in SceneBindings)
		{
			if (string.IsNullOrEmpty(sceneBinding.key) || !dict.TryGetValue(sceneBinding.key, out var value) || value == null || sceneBinding.track == null)
			{
				continue;
			}
			GameObject go = value.go;
			if (!string.IsNullOrEmpty(sceneBinding.subPath) && sceneBinding.subPath != "$gua")
			{
				Transform transform = go.transform.Find(sceneBinding.subPath);
				if (transform != null)
				{
					go = transform.gameObject;
				}
			}
			if (sceneBinding.track is AnimationTrack animTrack)
			{
				Animator component = go.GetComponent<Animator>();
				if (component != null && component.runtimeAnimatorController != null)
				{
					CheckAnimationTrack(animTrack, component);
				}
			}
			if (sceneBinding.subPath == "$gua")
			{
				continue;
			}
			UnityEngine.Object value2 = go;
			if (!string.IsNullOrEmpty(sceneBinding.componentType))
			{
				Component component2 = go.GetComponent(sceneBinding.componentType);
				if (component2 != null)
				{
					value2 = component2;
				}
			}
			playableDirector.SetGenericBinding(sceneBinding.track, value2);
		}
		foreach (P08MixBinding mixBinding in MixBindings)
		{
			if (string.IsNullOrEmpty(mixBinding.key) || !dict.TryGetValue(mixBinding.key, out var value3) || value3 == null)
			{
				continue;
			}
			GameObject go2 = value3.go;
			if (!string.IsNullOrEmpty(mixBinding.subPath))
			{
				Transform transform2 = go2.transform.Find(mixBinding.subPath);
				if (transform2 != null)
				{
					go2 = transform2.gameObject;
				}
			}
			if (!string.IsNullOrEmpty(mixBinding.componentType))
			{
				if (mixBinding.componentType == "CameraLookAt" || mixBinding.componentType == "CinemachineVirtualCamera")
				{
					mixBinding.component.GetComponent<CinemachineVirtualCamera>().LookAt = go2.transform;
				}
				else if (mixBinding.componentType == "CameraFollow")
				{
					mixBinding.component.GetComponent<CinemachineVirtualCamera>().Follow = go2.transform;
				}
				else if (mixBinding.componentType == "CameraBoth")
				{
					CinemachineVirtualCamera component3 = mixBinding.component.GetComponent<CinemachineVirtualCamera>();
					component3.Follow = go2.transform;
					component3.LookAt = go2.transform;
				}
			}
		}
		foreach (P08CharBinding charBinding in CharBindings)
		{
			if (charBinding.go == null)
			{
				continue;
			}
			Animator component4 = charBinding.go.GetComponent<Animator>();
			if (component4 == null)
			{
				continue;
			}
			if (_dontLoadChar)
			{
				if (component4.applyRootMotion && charBinding.enumRootMotion == P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
				{
					component4.applyRootMotion = false;
				}
				else if (!component4.applyRootMotion && charBinding.enumRootMotion == P08CharBinding.EnumRootMontion.ROOT_MONTION)
				{
					component4.applyRootMotion = true;
				}
				continue;
			}
			component4.cullingMode = AnimatorCullingMode.AlwaysAnimate;
			if (component4.applyRootMotion && charBinding.enumRootMotion == P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
			{
				component4.applyRootMotion = false;
			}
			else if (!component4.applyRootMotion && charBinding.enumRootMotion != P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
			{
				component4.applyRootMotion = true;
			}
			if (!(component4.runtimeAnimatorController == null) && !_dontClearCtrl)
			{
				component4.runtimeAnimatorController = null;
			}
		}
		if (!(playableDirector == null))
		{
			playableDirector.RebuildGraph();
			playableDirector.played += OnPlay;
			if (!_dontHideOnStop)
			{
				playableDirector.stopped += OnStop;
			}
			if (!playableDirector.playOnAwake)
			{
				SetCharActive(flag: false);
			}
		}
	}

	private static bool CheckAnimationTrack(AnimationTrack animTrack, Animator ani)
	{
		return CheckAnimationTrack(animTrack, ani.runtimeAnimatorController.animationClips, ani.gameObject.name);
	}

	private static bool CheckAnimationTrack(AnimationTrack animTrack, AnimationClip[] clips, string goName)
	{
		bool result = true;
		foreach (TimelineClip clip in animTrack.GetClips())
		{
			AnimationPlayableAsset animationPlayableAsset = clip.asset as AnimationPlayableAsset;
			if (!(animationPlayableAsset.clip != null))
			{
				AnimationClip animationClip = GetAnimationClip(clips, clip.displayName);
				if (animationClip == null)
				{
					Debug.LogError("===>>> " + goName + " 找不到动画: " + clip.displayName);
					result = false;
				}
				else
				{
					animationPlayableAsset.clip = animationClip;
				}
			}
		}
		return result;
	}

	private static AnimationClip GetAnimationClip(AnimationClip[] clips, string checkName)
	{
		foreach (AnimationClip animationClip in clips)
		{
			if (animationClip.name == checkName)
			{
				return animationClip;
			}
		}
		return null;
	}

	private void SetCharActive(bool flag)
	{
		if (!_dontLoadChar && Application.isPlaying)
		{
			foreach (KeyValuePair<string, P08CharBinding> item in dict)
			{
				item.Value.go?.SetActive(flag);
			}
		}
		if (_timelineType != EnumTimelineType.TL_REAL_TIME && _timelineType != EnumTimelineType.TL_MULTIPLE)
		{
			return;
		}
		foreach (KeyValuePair<string, P08CharBinding> item2 in dict)
		{
			P08CharBinding value = item2.Value;
			if (value.go == null)
			{
				continue;
			}
			Animator component = value.go.GetComponent<Animator>();
			if (component == null)
			{
				continue;
			}
			if (_dontLoadChar)
			{
				if (component.applyRootMotion && value.enumRootMotion == P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
				{
					component.applyRootMotion = false;
				}
				else if (!component.applyRootMotion && value.enumRootMotion == P08CharBinding.EnumRootMontion.ROOT_MONTION)
				{
					component.applyRootMotion = true;
				}
			}
			else if (component.applyRootMotion && value.enumRootMotion == P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
			{
				component.applyRootMotion = false;
			}
			else if (!component.applyRootMotion && value.enumRootMotion != P08CharBinding.EnumRootMontion.NON_ROOT_MONTION)
			{
				component.applyRootMotion = true;
			}
		}
	}
}
