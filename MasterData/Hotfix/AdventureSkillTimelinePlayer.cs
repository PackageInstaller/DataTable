using System;
using MagicaCloth;
using PathologicalGames;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering;

[AddComponentMenu("Game/FX/Adventure Skill Timeline Player")]
[RequireComponent(typeof(PlayableDirector))]
public class AdventureSkillTimelinePlayer : MonoBehaviour
{
	protected PlayableDirector _director;

	public bool isCloseUp = true;

	[Space]
	public float fadeInTime = 0.5f;

	public float fadeOutTime;

	[Space]
	public bool useCustomFadeInBackgroundColor;

	public Color fadeInBackgroundColor = new Color(0f, 0f, 0f, 0.5f);

	[Space]
	public Light closeupAnimMainLight;

	[Space]
	public bool useCustomAmbientColor;

	[ColorUsage(false)]
	public Color ambientSkyColor;

	[ColorUsage(false)]
	public Color ambientEquatorColor;

	[ColorUsage(false)]
	public Color ambientGroundColor;

	protected AdventureActor _actor;

	protected AdventureSelfFXHandler[] _actorModelSelfHandlers;

	protected CustomModelMaterialVariantComponent[] _actorModelMaterialVariantControllers;

	protected Action _onTimelineComplete;

	protected bool _isPlaying;

	protected double _remainingTime;

	protected AmbientMode _originAmbientMode;

	protected Color _originAmbientSkyColor;

	protected Color _originAmbientEquatorColor;

	protected Color _originAmbientGroundColor;

	public AdventureActor actor => _actor;

	public bool isPlaying => _isPlaying;

	public double remainingTime => _remainingTime;

	protected void Awake()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			_director = GetComponent<PlayableDirector>();
			_director.stopped += OnStoped;
		}
	}

	protected static AdventureSkillTimelinePlayer Spawn(GameObject prefab, AdventureActor actor)
	{
		AdventureSkillTimelinePlayer component = null;
		if (actor != null)
		{
			PrefabPool prefabPool = PoolManager.Pools.get_Item("Timeline").GetPrefabPool(prefab);
			if (prefabPool != null)
			{
				for (int i = 0; i < prefabPool.despawned.Count; i++)
				{
					AdventureSkillTimelinePlayer component2 = prefabPool.despawned.get_Item(i).GetComponent<AdventureSkillTimelinePlayer>();
					if (component2 != null && component2.actor == actor)
					{
						component = prefabPool.SpawnFromDespawnedInstanceAt(i, Vector3.zero, Quaternion.identity, null).GetComponent<AdventureSkillTimelinePlayer>();
						break;
					}
				}
			}
		}
		if (component == null)
		{
			Transform transform = null;
			SpawnPool spawnPool = PoolManager.Pools.get_Item("Timeline");
			transform = ((!(spawnPool != null)) ? UnityEngine.Object.Instantiate(prefab, Vector3.zero, Quaternion.identity).transform : spawnPool.Spawn(prefab.transform, Vector3.zero, Quaternion.identity));
			transform.SetParent(ObjectPoolUtils.GetPoolRootNode("Timeline"));
			if (!transform.TryGetComponent<AdventureSkillTimelinePlayer>(out component))
			{
				component = transform.gameObject.AddComponent<AdventureSkillTimelinePlayer>();
			}
		}
		return component;
	}

	protected static void Despawn(AdventureSkillTimelinePlayer instance)
	{
		SpawnPool spawnPool = null;
		if (PoolManager.Pools.TryGetValue("Timeline", out spawnPool))
		{
			spawnPool.Despawn(instance.transform, spawnPool.group);
		}
		instance.gameObject.SetActive(value: false);
	}

	public static void PreLoad(GameObject prefab)
	{
		Despawn(Spawn(prefab, null));
	}

	public static AdventureSkillTimelinePlayer Play(GameObject prefab, AdventureActor actor, Action onComplete = null)
	{
		AdventureSkillTimelinePlayer adventureSkillTimelinePlayer = Spawn(prefab, actor);
		adventureSkillTimelinePlayer.Play(actor, onComplete);
		return adventureSkillTimelinePlayer;
	}

	public void Play(AdventureActor actor, Action onComplete = null)
	{
		_actor = actor;
		_onTimelineComplete = onComplete;
		if (gameObject.layer != 26)
		{
			transform.SetLayerRecursively(26);
		}
		_director.transform.position = actor.transform.position;
		_director.transform.rotation = actor.transform.rotation;
		_director.enabled = true;
		if (isCloseUp)
		{
			AdventureTimelinePlayer.BindCameraBrain(_director, MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain);
			if (closeupAnimMainLight != null)
			{
				closeupAnimMainLight.cullingMask = 67108864;
				if (CustomMainLightOverride.Instance != null)
				{
					CustomMainLightOverride.Instance.SyncLightComponent(closeupAnimMainLight);
				}
			}
			SceneSingleton<AdventurePlayerController>.Instance.EnableCloseupCamera(0f, useCustomFadeInBackgroundColor ? fadeInBackgroundColor : default(Color), withMainCamera: false);
			if (useCustomAmbientColor)
			{
				_originAmbientMode = RenderSettings.ambientMode;
				_originAmbientSkyColor = RenderSettings.ambientSkyColor;
				_originAmbientEquatorColor = RenderSettings.ambientEquatorColor;
				_originAmbientGroundColor = RenderSettings.ambientGroundColor;
				RenderSettings.ambientMode = AmbientMode.Trilight;
				RenderSettings.ambientSkyColor = ambientSkyColor;
				RenderSettings.ambientEquatorColor = ambientEquatorColor;
				RenderSettings.ambientGroundColor = ambientGroundColor;
			}
		}
		else
		{
			AdventureTimelinePlayer.BindCameraBrain(_director, null);
			MonoSingleton<GameCameraStackManager>.Instance.mainCamera.cullingMask |= 67108864;
			if (GameMainLight.Instance != null)
			{
				GameMainLight.Instance.light.cullingMask |= 67108864;
			}
			if (actor != null && actor.actorScaleInfo != null)
			{
				_director.transform.localScale = Vector3.one * (float)actor.actorScaleInfo.modelScale;
			}
		}
		_actor.Hide(performanceMode: true);
		_actor.EnableInvincible();
		if (_actorModelSelfHandlers == null)
		{
			_actorModelSelfHandlers = gameObject.GetComponentsInChildren<AdventureSelfFXHandler>();
			for (int i = 0; i < _actorModelSelfHandlers.Length; i++)
			{
				_actorModelSelfHandlers[i].Initialize();
			}
		}
		if (_actorModelMaterialVariantControllers == null)
		{
			_actorModelMaterialVariantControllers = gameObject.GetComponentsInChildren<CustomModelMaterialVariantComponent>();
		}
		for (int j = 0; j < _actorModelMaterialVariantControllers.Length; j++)
		{
			_actorModelMaterialVariantControllers[j].SetVariant(CustomModelMaterialVariantComponent.VariantNames.CloseupView);
		}
		SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
		MonoSingleton<LuaManager>.Instance.FireEvent("OnEventPlayerSkillTimeLine", a1: true);
		_director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
		_director.extrapolationMode = DirectorWrapMode.Hold;
		_remainingTime = _director.duration;
		_director.Play();
		_isPlaying = true;
		ModuleController<AdventureModuleController>.Instance.PauseLogic();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_END", OnLevelEnd);
	}

	public void Stop()
	{
		if (_isPlaying)
		{
			_director.Stop();
		}
	}

	private void Update()
	{
		if (_isPlaying)
		{
			if (_remainingTime > 0.0)
			{
				_remainingTime -= Time.unscaledDeltaTime;
			}
			else
			{
				_director.Stop();
			}
		}
	}

	private void OnLevelEnd(IEvent _)
	{
		Stop();
	}

	protected void OnStoped(PlayableDirector director)
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_LEVEL_END", OnLevelEnd);
		_isPlaying = false;
		_remainingTime = 0.0;
		if (isCloseUp)
		{
			if (closeupAnimMainLight != null && CustomMainLightOverride.Instance != null)
			{
				CustomMainLightOverride.Instance.SyncLightComponent(null);
			}
			SceneSingleton<AdventurePlayerController>.Instance.DisableCloseupCamera(0f);
			if (useCustomAmbientColor)
			{
				RenderSettings.ambientSkyColor = _originAmbientSkyColor;
				RenderSettings.ambientEquatorColor = _originAmbientEquatorColor;
				RenderSettings.ambientGroundColor = _originAmbientGroundColor;
				RenderSettings.ambientMode = _originAmbientMode;
			}
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.mainCamera.cullingMask &= -67108865;
			if (GameMainLight.Instance != null)
			{
				GameMainLight.Instance.light.cullingMask &= -67108865;
			}
		}
		_actor.Visible();
		_actor.DisableInvincible();
		SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		MonoSingleton<LuaManager>.Instance.FireEvent("OnEventPlayerSkillTimeLine", a1: false);
		ModuleController<AdventureModuleController>.Instance.ResumeLogic();
		_onTimelineComplete?.Invoke();
		_onTimelineComplete = null;
		Despawn(this);
	}

	public void AutoSetup()
	{
		transform.SetLayerRecursively(26);
		Light[] componentsInChildren = gameObject.GetComponentsInChildren<Light>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].cullingMask = 67108864;
		}
		Animator[] componentsInChildren2 = gameObject.GetComponentsInChildren<Animator>(includeInactive: true);
		for (int i = 0; i < componentsInChildren2.Length; i++)
		{
			componentsInChildren2[i].cullingMode = AnimatorCullingMode.AlwaysAnimate;
		}
		MagicaBoneCloth[] componentsInChildren3 = gameObject.GetComponentsInChildren<MagicaBoneCloth>(includeInactive: true);
		for (int i = 0; i < componentsInChildren3.Length; i++)
		{
			componentsInChildren3[i].gameObject.SetActive(value: false);
		}
		MagicaBoneSpring[] componentsInChildren4 = gameObject.GetComponentsInChildren<MagicaBoneSpring>(includeInactive: true);
		for (int i = 0; i < componentsInChildren4.Length; i++)
		{
			componentsInChildren4[i].gameObject.SetActive(value: false);
		}
		Renderer[] componentsInChildren5 = gameObject.GetComponentsInChildren<Renderer>(includeInactive: true);
		for (int i = 0; i < componentsInChildren5.Length; i++)
		{
			componentsInChildren5[i].lightProbeUsage = LightProbeUsage.Off;
		}
	}

	public void OnSpecialExitEmitted()
	{
		SceneSingleton<AdventurePlayerController>.Instance.hudCamera.enabled = false;
		MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraBlackScreenTransition(0.1f);
	}
}
