using System.Collections.Generic;
using UnityEngine;

public class AdventureFXPlayer_AfterImage : AdventureFXPlayer_Component
{
	protected enum PlaybackState
	{
		Delaying,
		Played,
		Stoped
	}

	public float afterImageFXDelay;

	public float afterImageFXDuration = 1f;

	public bool afterImageLoop;

	[Space]
	public string tintPropertyName = "_TintColor";

	[Space]
	public string[] subParts;

	[Space]
	public AfterImageEffectComponentGroup.AfterImageEffectComponentSetting afterImageFXSetting;

	protected AfterImageEffectComponentGroup _afterImageCompGroup;

	protected List<AfterImageEffectComponent> _activeAfterImageComps;

	protected List<AfterImageEffectComponent> _deactiveAfterImageComps;

	protected PlaybackState _playbackState;

	public override bool isLoop => afterImageLoop;

	public override bool isStoped
	{
		get
		{
			if (_afterImageCompGroup != null && _fxPlayer.playbackTime <= afterImageFXDelay + afterImageFXDuration)
			{
				return false;
			}
			return true;
		}
	}

	public override void Release()
	{
		Stop();
		_afterImageCompGroup = null;
		if (_activeAfterImageComps != null)
		{
			_activeAfterImageComps.Clear();
		}
		if (_deactiveAfterImageComps != null)
		{
			_deactiveAfterImageComps.Clear();
		}
	}

	protected void Play_Internal()
	{
		if (_afterImageCompGroup != null && afterImageFXSetting != null)
		{
			_afterImageCompGroup.EnableAfterImageEffect(afterImageFXSetting);
		}
		_playbackState = PlaybackState.Played;
	}

	public override void Stop()
	{
		if (_afterImageCompGroup != null && afterImageFXSetting != null && _playbackState == PlaybackState.Played)
		{
			_afterImageCompGroup.DisableAfterImageEffect();
		}
		if (_deactiveAfterImageComps != null && _deactiveAfterImageComps.Count > 0)
		{
			for (int i = 0; i < _deactiveAfterImageComps.Count; i++)
			{
				_deactiveAfterImageComps.get_Item(i).EnableEffect();
			}
			_deactiveAfterImageComps.Clear();
		}
		_playbackState = PlaybackState.Stoped;
	}

	public override void Pause()
	{
		if (_afterImageCompGroup != null)
		{
			_afterImageCompGroup.effectTimeScale = 0f;
		}
	}

	public override void Resume()
	{
		if (_afterImageCompGroup != null)
		{
			_afterImageCompGroup.effectTimeScale = _fxPlayer.finalTimeScale;
		}
	}

	public override void UpdatePlayback(float dt)
	{
		if (!(_afterImageCompGroup != null))
		{
			return;
		}
		switch (_playbackState)
		{
		case PlaybackState.Delaying:
			if (_fxPlayer.playbackTime >= afterImageFXDelay)
			{
				Play_Internal();
			}
			break;
		case PlaybackState.Played:
			if (!afterImageLoop && _fxPlayer.playbackTime >= afterImageFXDelay + afterImageFXDuration)
			{
				Stop();
			}
			break;
		}
	}

	public override void OnBind(GameObject owner)
	{
		_afterImageCompGroup = AfterImageEffectComponentGroup.Setup(owner);
		_afterImageCompGroup.UpdateMaterialPropertyName(tintPropertyName);
		if (subParts != null && subParts.Length != 0)
		{
			if (_activeAfterImageComps == null)
			{
				_activeAfterImageComps = new List<AfterImageEffectComponent>();
			}
			if (_deactiveAfterImageComps == null)
			{
				_deactiveAfterImageComps = new List<AfterImageEffectComponent>();
			}
			CustomModelLODGroup component = owner.GetComponent<CustomModelLODGroup>();
			for (int i = 0; i < subParts.Length; i++)
			{
				Transform transform = _afterImageCompGroup.transform.Find(subParts[i]);
				if (!(transform != null))
				{
					continue;
				}
				AfterImageEffectComponent afterImageEffectComponent = _afterImageCompGroup.GetAfterImageEffectComponent(transform.gameObject);
				if (afterImageEffectComponent != null)
				{
					_activeAfterImageComps.Add(afterImageEffectComponent);
				}
				if (!(component != null))
				{
					continue;
				}
				Renderer renderer = component.FindLowLevelModelRendererFromHighLevelModelRenderer(transform.gameObject);
				if (renderer != null)
				{
					afterImageEffectComponent = _afterImageCompGroup.GetAfterImageEffectComponent(renderer.gameObject);
					if (afterImageEffectComponent != null)
					{
						_activeAfterImageComps.Add(afterImageEffectComponent);
					}
				}
			}
			AfterImageEffectComponent[] afterImageEffectComponents = _afterImageCompGroup.GetAfterImageEffectComponents();
			foreach (AfterImageEffectComponent afterImageEffectComponent2 in afterImageEffectComponents)
			{
				if (!_activeAfterImageComps.Contains(afterImageEffectComponent2))
				{
					afterImageEffectComponent2.DisableEffect();
					_deactiveAfterImageComps.Add(afterImageEffectComponent2);
				}
			}
			_activeAfterImageComps.Clear();
		}
		if (afterImageFXDelay > float.Epsilon)
		{
			_playbackState = PlaybackState.Delaying;
		}
		else
		{
			Play_Internal();
		}
	}

	public override void OnUpdatePlaybackSpeed(float playbackSpeed, float timeScale)
	{
		if (_afterImageCompGroup != null && !_fxPlayer.paused)
		{
			_afterImageCompGroup.effectTimeScale = timeScale;
		}
	}

	public override void OnIndependentUpdateChanged(bool value)
	{
		if (_afterImageCompGroup != null)
		{
			_afterImageCompGroup.independentUpdate = value;
		}
	}
}
