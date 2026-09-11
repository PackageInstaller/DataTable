using System.Collections.Generic;
using Ara;
using PigeonCoopToolkit.Effects.Trails;
using UnityEngine;

[RequireComponent(typeof(EffectPaticleSystemRenderHelper))]
public class EffectQualityManager : MonoBehaviour
{
	public List<Component> _low = new List<Component>();

	public List<Component> _medium = new List<Component>();

	public List<Component> _high = new List<Component>();

	public List<Component> _fantastic = new List<Component>();

	public List<Component> _allComponents = new List<Component>();

	public List<Component> _hideList = new List<Component>();

	private Dictionary<Component, bool> _notplayerHide = new Dictionary<Component, bool>();

	private List<Component>[] _qualitys = new List<Component>[4];

	private EffectPaticleSystemRenderHelper _helper;

	private bool _isMainPlayerEffect = true;

	private void Awake()
	{
		InitializeQualits();
	}

	public void InitializeQualits()
	{
		_qualitys[0] = _low;
		_qualitys[1] = _medium;
		_qualitys[2] = _high;
		_qualitys[3] = _fantastic;
		for (int i = 0; i < _hideList.Count; i++)
		{
			if (_hideList[i] == null)
			{
				Debug.LogError(base.gameObject.name);
			}
			else if (!_notplayerHide.ContainsKey(_hideList[i]))
			{
				_notplayerHide.Add(_hideList[i], value: false);
			}
		}
	}

	public void Enable(EEffectQuality quality, bool enable, Component component)
	{
		List<Component> list = _qualitys[(int)quality];
		bool flag = list.Contains(component);
		if (enable && !flag)
		{
			list.Add(component);
		}
		else if (!enable & flag)
		{
			list.Remove(component);
		}
	}

	public bool IsEnable(EEffectQuality quality, Component component)
	{
		return _qualitys[(int)quality].Contains(component);
	}

	public void EnableDontHideByPlayer(bool enable, Component component)
	{
		bool flag = _hideList.Contains(component);
		if (enable && !flag)
		{
			_hideList.Add(component);
		}
		else if (!enable & flag)
		{
			_hideList.Remove(component);
		}
	}

	public bool IsInHideDictionaryAndNoMainPlayer(Component component)
	{
		if (_notplayerHide.ContainsKey(component))
		{
			return !_isMainPlayerEffect;
		}
		return false;
	}

	public bool IsNotPlayerHide(Component component)
	{
		return _hideList.Contains(component);
	}

	public List<Component> GetComponents(EEffectQuality quality)
	{
		return _qualitys[(int)quality];
	}

	public void SetPlaySpeed(EEffectQuality quality, float speed)
	{
		List<Component> list = _qualitys[(int)quality];
		for (int i = 0; i < list.Count; i++)
		{
			Component component = list[i];
			if (component is GPUParticleRenderer)
			{
				(component as GPUParticleRenderer).SetTimeScale(speed);
			}
			else if (component is ParticleSystem)
			{
				ParticleSystem.MainModule main = (component as ParticleSystem).main;
				main.simulationSpeed = speed;
			}
			else if (component is Animator)
			{
				(component as Animator).speed = speed;
			}
			else
			{
				if (!(component is Animation))
				{
					continue;
				}
				foreach (AnimationState item in component as Animation)
				{
					item.speed = speed;
				}
			}
		}
	}

	public void Simulator(EEffectQuality quality, float startTime, float timescale, bool isMainPlayer = true, bool isFriend = false, bool isVirtualCamera = false)
	{
		List<Component> list = _qualitys[(int)quality];
		_isMainPlayerEffect = isMainPlayer;
		if (isFriend && BattleScene.IsHideFriendEffect && !isVirtualCamera)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			Component component = list[i];
			if (!isMainPlayer && _notplayerHide.ContainsKey(component))
			{
				continue;
			}
			if (component is GPUParticleRenderer)
			{
				(component as GPUParticleRenderer).Play(timescale, startTime);
			}
			else if (component is ParticleSystem)
			{
				ParticleSystem obj = component as ParticleSystem;
				obj.Simulate(startTime, withChildren: true);
				obj.Play();
				obj.playbackSpeed = timescale;
			}
			else if (component is Animator)
			{
				Animator animator = component as Animator;
				animator.speed = timescale;
				RuntimeAnimatorController runtimeAnimatorController = animator.runtimeAnimatorController;
				if (null == runtimeAnimatorController)
				{
					Debug.Log("RuntimeAnimatorController Is Null " + base.name);
					continue;
				}
				AnimationClip[] animationClips = runtimeAnimatorController.animationClips;
				if (animationClips == null || animationClips.Length == 0)
				{
					Debug.LogError("Animctor clips null or empty " + base.name + ", " + animator.name);
					continue;
				}
				AnimationClip animationClip = animationClips[0];
				if (null == animationClip)
				{
					Debug.LogError("AnimationClip null " + base.name + ", " + animator.name);
				}
				else
				{
					animator.PlayInFixedTime(animationClip.name, 0, startTime);
				}
			}
			else
			{
				if (!(component is Animation))
				{
					continue;
				}
				Animation animation = component as Animation;
				AnimationClip clip = animation.clip;
				if (null == clip)
				{
					Debug.LogError("请检查Animation的动画片段是否设置 " + base.gameObject.name);
					continue;
				}
				AnimationState animationState = animation.get_Item(animation.clip.name);
				if (null == animationState)
				{
					Debug.LogError("请检查是否将Animator的动画片段作用于Animation上了 " + base.gameObject.name);
					continue;
				}
				animationState.time = startTime;
				animation.Play();
			}
		}
	}

	public void SetActive(EEffectQuality quality, bool active, bool isMainPlayer = true, bool isFriend = false, bool isVirtualCamera = false)
	{
		List<Component> list = (active ? _qualitys[(int)quality] : _allComponents);
		_isMainPlayerEffect = isMainPlayer;
		if (list == null || ((active & isFriend) && BattleScene.IsHideFriendEffect && !isVirtualCamera))
		{
			return;
		}
		List<Component>.Enumerator enumerator = list.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Component current = enumerator.Current;
			if (current == null)
			{
				Debug.LogError(base.gameObject.name);
			}
			else
			{
				if (active && !isMainPlayer && _notplayerHide.ContainsKey(current))
				{
					continue;
				}
				if (current is GPUParticleRenderer)
				{
					GPUParticleRenderer gPUParticleRenderer = current as GPUParticleRenderer;
					gPUParticleRenderer.enabled = active;
					gPUParticleRenderer.meshRenderer.enabled = active;
					if (active)
					{
						gPUParticleRenderer.Play();
					}
				}
				else if (current is Animator)
				{
					Animator animator = current as Animator;
					if (active)
					{
						continue;
					}
					animator.speed = 0f;
					RuntimeAnimatorController runtimeAnimatorController = animator.runtimeAnimatorController;
					if (!(runtimeAnimatorController != null))
					{
						continue;
					}
					AnimationClip[] animationClips = runtimeAnimatorController.animationClips;
					if (animationClips != null && animationClips.Length != 0)
					{
						AnimationClip animationClip = animationClips[0];
						if (animationClip != null)
						{
							animator.Play(animationClip.name, 0, 0f);
						}
					}
				}
				else if (current is Animation)
				{
					Animation animation = current as Animation;
					if (!active)
					{
						animation.Stop();
					}
				}
				else if (current is ParticleSystem)
				{
					ParticleSystem particleSystem = current as ParticleSystem;
					if (active)
					{
						particleSystem.Play();
						GetHelper().Play(particleSystem);
					}
					else
					{
						particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
						GetHelper().Stop(particleSystem);
					}
				}
				else if (current is LineRenderer)
				{
					(current as LineRenderer).enabled = active;
				}
				else if (current is TrailRenderer_Base)
				{
					(current as TrailRenderer_Base).enabled = active;
				}
				else if (current is Light)
				{
					(current as Light).enabled = active;
				}
				else if (current is Renderer)
				{
					(current as Renderer).enabled = active;
				}
				else if (current is AraTrail)
				{
					(current as AraTrail).enabled = active;
				}
				else if (current is MonoBehaviour monoBehaviour)
				{
					monoBehaviour.enabled = active;
				}
			}
		}
	}

	public void SetParticleSystemRendererMPB(int property, float value)
	{
		GetHelper().SetParticleSystemRendererMPB(property, value);
	}

	public void HideRenderer(EEffectQuality quality, bool hide)
	{
		List<Component> list = _qualitys[(int)quality];
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			Component component = list[i];
			if ((hide || _isMainPlayerEffect || !_notplayerHide.ContainsKey(component)) && component != null)
			{
				if (component is GPUParticleRenderer)
				{
					(component as GPUParticleRenderer).meshRenderer.enabled = !hide;
				}
				else if (component is LineRenderer)
				{
					(component as LineRenderer).enabled = !hide;
				}
				else if (component is TrailRenderer_Base)
				{
					(component as TrailRenderer_Base).enabled = !hide;
				}
				else if (component is AraTrail)
				{
					(component as AraTrail).enabled = !hide;
				}
				else if (component is Light)
				{
					(component as Light).enabled = !hide;
				}
				else if (component is Renderer)
				{
					(component as Renderer).enabled = !hide;
				}
				else if (component is ParticleSystem)
				{
					ParticleSystem particleSystem = component as ParticleSystem;
					GetHelper().HideRenderer(particleSystem, hide);
				}
			}
		}
	}

	internal List<Component> Get(EEffectQuality level)
	{
		return level switch
		{
			EEffectQuality.Low => _low, 
			EEffectQuality.Medium => _medium, 
			EEffectQuality.High => _high, 
			EEffectQuality.Fantastic => _fantastic, 
			_ => null, 
		};
	}

	internal uint GetQuality(Component ps)
	{
		uint num = 0u;
		if (_low.Contains(ps))
		{
			num = 1u;
		}
		if (_medium.Contains(ps))
		{
			num |= 2;
		}
		if (_high.Contains(ps))
		{
			num |= 4;
		}
		return num |= 8;
	}

	internal bool IsQuality(uint key, EEffectQuality quality)
	{
		return (key & (uint)(1 << (int)quality)) != 0;
	}

	private EffectPaticleSystemRenderHelper GetHelper()
	{
		if (_helper == null)
		{
			_helper = U3DUtil.Get<EffectPaticleSystemRenderHelper>(base.gameObject);
		}
		return _helper;
	}
}
