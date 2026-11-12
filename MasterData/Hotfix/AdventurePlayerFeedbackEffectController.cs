using System;
using System.Collections.Generic;
using PostProcess;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class AdventurePlayerFeedbackEffectController : SceneSingleton<AdventurePlayerFeedbackEffectController>
{
	protected class PostProcessHandler
	{
		public enum State
		{
			FadeIn,
			Hold,
			FadeOut,
			Stoped
		}

		public VolumeProfile profile;

		public Volume volume;

		public float fadeIn;

		public float duration;

		public float fadeOut;

		public State state = State.Stoped;

		public float timer;

		public void Play(float fadeIn, float duration, float fadeOut)
		{
			this.fadeIn = fadeIn;
			this.duration = duration;
			this.fadeOut = fadeOut;
			volume.gameObject.SetActive(value: true);
			if (fadeIn > float.Epsilon)
			{
				volume.weight = 0f;
				state = State.FadeIn;
				timer = 0f;
			}
			else if (duration > float.Epsilon)
			{
				volume.weight = 1f;
				state = State.Hold;
				timer = 0f;
			}
			else
			{
				volume.weight = 1f;
				state = State.FadeOut;
				timer = 0f;
			}
		}

		public void Stop()
		{
			volume.weight = 0f;
			volume.gameObject.SetActive(value: false);
			state = State.Stoped;
			timer = 0f;
		}

		public void Update(float dt)
		{
			timer += dt;
			switch (state)
			{
			case State.FadeIn:
				if (fadeIn > float.Epsilon)
				{
					volume.weight = Mathf.Clamp01(timer / fadeIn);
				}
				else
				{
					volume.weight = 1f;
				}
				if (timer >= fadeIn)
				{
					state = State.Hold;
					timer = 0f;
				}
				break;
			case State.Hold:
				volume.weight = 1f;
				if (timer >= duration)
				{
					state = State.FadeOut;
					timer = 0f;
				}
				break;
			case State.FadeOut:
				if (fadeOut > float.Epsilon)
				{
					volume.weight = 1f - Mathf.Clamp01(timer / fadeOut);
				}
				else
				{
					volume.weight = 0f;
				}
				if (timer >= fadeOut)
				{
					Stop();
				}
				break;
			}
		}
	}

	public VolumeProfile racialBlurProfile;

	private long _racialBlurUniqueId;

	protected List<PostProcessHandler> _postprocessHandlers = new List<PostProcessHandler>();

	protected GameObject _frozenTimeFXPrefab;

	protected AdventureFXPlayer _frozenTimeFXPlayer;

	public bool isPlayingWitchTimeFX { get; private set; }

	public bool isPlayingFrozenTimeFX { get; private set; }

	protected void Start()
	{
		AdventureFXManager.onFXPlayerOwnerActorBind = (Action<AdventureFXPlayer>)Delegate.Combine(AdventureFXManager.onFXPlayerOwnerActorBind, new Action<AdventureFXPlayer>(OnFXPlayerOwnerActorBind));
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ENTER_WITCHTIME", OnWitchTimeEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_EXIT_WITCHTIME", OnWitchTimeExit);
	}

	protected void OnDisable()
	{
		AdventureFXManager.onFXPlayerOwnerActorBind = (Action<AdventureFXPlayer>)Delegate.Remove(AdventureFXManager.onFXPlayerOwnerActorBind, new Action<AdventureFXPlayer>(OnFXPlayerOwnerActorBind));
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ENTER_WITCHTIME", OnWitchTimeEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_EXIT_WITCHTIME", OnWitchTimeExit);
	}

	protected void LateUpdate()
	{
		UpdatePostProcess();
	}

	public (long, long) Play(AdventurePlayerFeedbackEffectConfigureData configData, Vector3 effectPosition, GameObject effectTarget, int _cameraShakeSort = 0)
	{
		Vector3 centerScreenPosition = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToViewportPointAsHFOV(effectPosition);
		centerScreenPosition.x = Mathf.Clamp01(centerScreenPosition.x);
		centerScreenPosition.y = Mathf.Clamp01(centerScreenPosition.y);
		long item = -1L;
		long item2 = -1L;
		if (configData.enableCameraShake && configData.cameraShakeFadeIn + configData.cameraShakeDuration + configData.cameraShakeFadeOut > float.Epsilon)
		{
			item = SceneSingleton<AdventurePlayerController>.Instance.CameraShake(configData.cameraShakeDuration, configData.cameraShakeStrength, configData.cameraShakeVibrato, configData.cameraShakeRandomness, configData.cameraShakeRotate, configData.cameraShakeDepth, configData.cameraShakeFadeIn, configData.cameraShakeFadeOut, _cameraShakeSort);
		}
		if (configData.enableRacialBlur && configData.racialBlurFadeIn + configData.racialBlurDuration + configData.racialBlurFadeOut > float.Epsilon)
		{
			item2 = PlayRacialBlur(configData, centerScreenPosition);
		}
		return (item, item2);
	}

	public void Stop(AdventurePlayerFeedbackEffectConfigureData configData, long cameraShakeUniqueId = -1L, long racialBlurUniqueId = -1L)
	{
		if (configData.enableCameraShake)
		{
			SceneSingleton<AdventurePlayerController>.Instance.StopCameraShake(cameraShakeUniqueId);
		}
		if (configData.enableRacialBlur)
		{
			StopRacialBlur(racialBlurUniqueId);
		}
	}

	protected long PlayRacialBlur(AdventurePlayerFeedbackEffectConfigureData configData, Vector3 centerScreenPosition)
	{
		if (PlayPostProcess(racialBlurProfile, configData.racialBlurFadeIn, configData.racialBlurDuration, configData.racialBlurFadeOut).volume.profile.TryGet<RacialBlur>(out var component))
		{
			component.intensity.value = 1f;
			component.blurCenter.value = new Vector2(centerScreenPosition.x, centerScreenPosition.y);
			component.blurStrength.value = configData.racialBlurStrength;
			component.blurDirection.value = configData.racialBlurDirection;
			component.invertScattered.value = configData.racialBlurInvertScattered;
			component.blurRange.value = configData.racialBlurRange;
		}
		_racialBlurUniqueId++;
		return _racialBlurUniqueId;
	}

	protected void StopRacialBlur(long racialBlurUniqueId)
	{
		if (racialBlurUniqueId != _racialBlurUniqueId)
		{
			return;
		}
		for (int i = 0; i < _postprocessHandlers.Count; i++)
		{
			if (_postprocessHandlers.get_Item(i).profile == racialBlurProfile)
			{
				_postprocessHandlers.get_Item(i).Stop();
				break;
			}
		}
	}

	protected PostProcessHandler PlayPostProcess(VolumeProfile profile, float fadeIn, float duration, float fadeOut)
	{
		PostProcessHandler postProcessHandler = null;
		for (int i = 0; i < _postprocessHandlers.Count; i++)
		{
			if (_postprocessHandlers.get_Item(i).profile == profile)
			{
				postProcessHandler = _postprocessHandlers.get_Item(i);
				break;
			}
		}
		if (postProcessHandler == null)
		{
			Volume volume = SRPPostProcessVolumeExtensions.QuickCreatePostProcessVolume(isGlobal: true, 31, 100f, profile, transform);
			postProcessHandler = new PostProcessHandler
			{
				profile = profile,
				volume = volume
			};
			_postprocessHandlers.Add(postProcessHandler);
		}
		postProcessHandler.Play(fadeIn, duration, fadeOut);
		return postProcessHandler;
	}

	protected void UpdatePostProcess()
	{
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		for (int i = 0; i < _postprocessHandlers.Count; i++)
		{
			PostProcessHandler postProcessHandler = _postprocessHandlers.get_Item(i);
			if (postProcessHandler.state != PostProcessHandler.State.Stoped)
			{
				postProcessHandler.Update(unscaledDeltaTime);
			}
		}
	}

	public void PlayWitchTimeFX(AdventureActor witchTimeOwner, AdventureActor witchtimeAttackTarget)
	{
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		for (int i = 0; i < playerActors.Count; i++)
		{
			AdventureActor adventureActor = (AdventureActor)playerActors.get_Item(i);
			if (adventureActor != null && adventureActor.ActiveSelf)
			{
				EnableActorWitchTimeFX(adventureActor);
			}
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int j = 0; j < monsterActors.Count; j++)
		{
			AdventureActor adventureActor2 = (AdventureActor)monsterActors.get_Item(j);
			if (adventureActor2 != null && adventureActor2.ActiveSelf)
			{
				EnableActorWitchTimeFX(adventureActor2);
			}
		}
		if (GameMainLight.Instance != null)
		{
			GameMainLight.Instance.light.cullingMask |= 67108864;
		}
		SceneSingleton<AdventurePlayerController>.Instance.EnableCloseupCamera(0f, config.WitchTime_BackgroundColor, withMainCamera: true, replaceMainCameraCullingMask: false, 26, clearDepth: false);
		if (witchTimeOwner != null)
		{
			SceneSingleton<AdventureFXManager>.Instance.SetFXPlayersRenderLayerByOwnerActor(witchTimeOwner, 26);
		}
		if (witchtimeAttackTarget != null)
		{
			SceneSingleton<AdventureFXManager>.Instance.SetFXPlayersRenderLayerByOwnerActor(witchtimeAttackTarget, 26, bindWithActorOnly: true);
		}
		isPlayingWitchTimeFX = true;
		static void EnableActorWitchTimeFX(AdventureActor actor)
		{
			if (actor.isWitchTimeOwner || actor.isWitchTimeAttacker)
			{
				actor.SetRenderLayer(26);
			}
		}
	}

	public void StopWitchTimeFX()
	{
		List<LogicEntity> playerActors = ModuleController<AdventureModuleController>.Instance.playerActors;
		for (int i = 0; i < playerActors.Count; i++)
		{
			AdventureActor adventureActor = (AdventureActor)playerActors.get_Item(i);
			if (adventureActor != null)
			{
				DisableActorWitchTimeFX(adventureActor);
			}
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int j = 0; j < monsterActors.Count; j++)
		{
			AdventureActor adventureActor2 = (AdventureActor)monsterActors.get_Item(j);
			if (adventureActor2 != null)
			{
				DisableActorWitchTimeFX(adventureActor2);
			}
		}
		if (GameMainLight.Instance != null)
		{
			GameMainLight.Instance.light.cullingMask &= -67108865;
		}
		SceneSingleton<AdventurePlayerController>.Instance.DisableCloseupCamera(0f);
		SceneSingleton<AdventureFXManager>.Instance.ResetAllFXPlayersRenderLayer();
		isPlayingWitchTimeFX = false;
		static void DisableActorWitchTimeFX(AdventureActor actor)
		{
			actor.ResetRenderLayer();
		}
	}

	public void PlayFrozenTimeFX()
	{
		if (_frozenTimeFXPrefab == null)
		{
			AdventureModuleConfigureData config = AdventureModuleController.Config;
			if (!string.IsNullOrEmpty(config.FrozenTime_FXPath))
			{
				string assetName = "Assets/AssetBundles/" + config.FrozenTime_FXPath + ".prefab";
				_frozenTimeFXPrefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
			}
		}
		if (_frozenTimeFXPrefab != null)
		{
			_frozenTimeFXPlayer = AdventureFXPlayer.PlayFX(_frozenTimeFXPrefab, 1f, Vector3.zero, Quaternion.identity);
			isPlayingFrozenTimeFX = true;
		}
	}

	public void StopFrozenTimeFX()
	{
		if (_frozenTimeFXPlayer != null && _frozenTimeFXPlayer.isPlaying)
		{
			_frozenTimeFXPlayer.Stop();
			_frozenTimeFXPlayer = null;
		}
		isPlayingFrozenTimeFX = false;
	}

	protected void OnWitchTimeEnter(IEvent e)
	{
		if (isPlayingWitchTimeFX)
		{
			StopWitchTimeFX();
		}
		if (isPlayingFrozenTimeFX)
		{
			StopFrozenTimeFX();
		}
		AdventureActorEnterWitchTime adventureActorEnterWitchTime = (AdventureActorEnterWitchTime)e;
		if (adventureActorEnterWitchTime.owner != null)
		{
			PlayWitchTimeFX(adventureActorEnterWitchTime.owner, adventureActorEnterWitchTime.attackTarget);
		}
		else
		{
			PlayFrozenTimeFX();
		}
	}

	protected void OnWitchTimeExit(IEvent e)
	{
		if (isPlayingWitchTimeFX)
		{
			StopWitchTimeFX();
		}
		if (isPlayingFrozenTimeFX)
		{
			StopFrozenTimeFX();
		}
	}

	protected void OnFXPlayerOwnerActorBind(AdventureFXPlayer fxPlayer)
	{
		if (isPlayingWitchTimeFX && fxPlayer.ownerActor != null && fxPlayer.ownerActor.isWitchTimeOwner)
		{
			fxPlayer.SetRenderLayer(26);
		}
	}

	public void StopAllFX()
	{
		if (isPlayingWitchTimeFX)
		{
			StopWitchTimeFX();
		}
		if (isPlayingFrozenTimeFX)
		{
			StopFrozenTimeFX();
		}
	}
}
