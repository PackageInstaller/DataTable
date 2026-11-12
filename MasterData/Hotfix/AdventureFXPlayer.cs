using System;
using System.Collections.Generic;
using Cinemachine;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;

[AddComponentMenu("Game/FX/FX Player")]
[DisallowMultipleComponent]
public class AdventureFXPlayer : AdventureFXHandler
{
	[Flags]
	public enum LifeCycleBindExtraOption
	{
		[InspectorName("无")]
		None = 0,
		[InspectorName("非循环特效中也启用生命周期绑定")]
		ActiveInNonLoop = 1,
		[InspectorName("特效残留阶段也启用生命周期绑定")]
		ActiveInRemainPhase = 2
	}

	public enum FullScreenScaleMode
	{
		[InspectorName("宽高不等比拉伸至全屏")]
		StretchToFill,
		[InspectorName("按宽高中较大值等比缩放至全屏")]
		ScaleAndCrop,
		[InspectorName("按宽高中较小值等比缩放至全屏")]
		ScaleToFit
	}

	[Flags]
	public enum InheritOption
	{
		[InspectorName("生命周期等绑定控制")]
		Binding = 1,
		[InspectorName("挂点与方位同步")]
		SyncSlot = 2
	}

	[Serializable]
	public class EmbedFX
	{
		public string triggerAnimEventName;

		public AdventureFXPlayer fxPlayer;

		public bool playOnceInLoop;

		public bool stopInRemainPhase;

		public GameObject bindOwner;

		internal long _fxToken;

		internal bool _playedOnce;

		internal void Play()
		{
			fxPlayer.Play();
			_fxToken = fxPlayer.token;
			if (bindOwner != null)
			{
				fxPlayer.Bind(bindOwner);
				fxPlayer.syncSlotRotation = true;
				fxPlayer.syncSlotScale = true;
				fxPlayer.syncNode = bindOwner.transform;
			}
			else
			{
				fxPlayer.Bind(fxPlayer.gameObject);
			}
		}

		internal void Stop(bool isRelease)
		{
			if (fxPlayer != null && fxPlayer.token == _fxToken && fxPlayer.isPlaying)
			{
				fxPlayer.Stop(isRelease);
			}
			_fxToken = 0L;
			if (isRelease)
			{
				_playedOnce = false;
			}
		}
	}

	protected Transform _source;

	protected Vector3 _sourcePosition;

	protected Transform _target;

	protected Vector3 _targetPosition;

	[Header("-- 显示绑定配置 --")]
	public bool bindVisible;

	[Header("-- 时间绑定配置 --")]
	public bool disableBindTimeScale;

	[Header("-- 生命周期绑定配置 --")]
	[FormerlySerializedAs("onwerless")]
	public bool disableLifeCycleBind;

	public LifeCycleBindExtraOption lifeCycleBindExtraOptions;

	public bool disableBindActorState;

	public bool disableBindCombo;

	public bool disableBindActorDead;

	protected long _entityID;

	protected GameObject _owner;

	protected LogicEntity _entity;

	protected AdventureActor _actor;

	protected ActorState _actorState;

	protected Combo _combo;

	protected Combo.Phase _comboPhase;

	protected bool _cancelOnInterrupt;

	protected AdventureActor _ownerActor;

	protected Renderer[] _renderers;

	protected FP _logicTimeScale = FP.One;

	protected bool _syncHiden;

	public AnimationSlotConfigComponent.SlotType syncSlot;

	public bool syncSlotRotation = true;

	public bool syncSlotScale = true;

	public bool keepSyncOffset;

	public bool lockRotation;

	public bool lockOnGround;

	public float lockOnGroundOffset;

	[Header("-- 全屏特效 --")]
	public bool isFullScreenFX;

	[Range(-5f, 5f)]
	public int fullScreenFXLayer;

	public bool drawFullScreenFXInUILayer = true;

	public FullScreenScaleMode fullscreenScaleMode;

	private AnimationSlotConfigComponent _syncSlotConfigComponent;

	protected GameObject _syncTarget;

	protected Transform _syncNode;

	protected float _size = 1f;

	protected float _sizeScale = 1f;

	[Min(0f)]
	public float fadeInTime;

	[Min(0f)]
	public float remainTime;

	public bool fadeOutInRemainPhase;

	public bool keepSyncInRemainPhase;

	[Header("-- 动画组件特殊控制 --")]
	[Min(0f)]
	public float animationDelay;

	[Min(0f)]
	public float animationCrossFadeTime = 0.25f;

	public bool stopLoopOnAnimationDone;

	[Header("-- Buff堆叠 --")]
	public bool enableBuffStackSupport;

	public float buffStackAnimationSmoothTime = 0.5f;

	public bool buffStackNoAnimationSmoothOnFirstPlay;

	[Header("-- 空特效 --")]
	public bool isEmptyFX;

	public float emptyFXDuration;

	protected float _playbackTimer;

	protected float _remainTimer;

	private List<Material> _buffStackMaterials;

	private float _currentBuffStackProgress;

	private float _targetBuffStackProgress;

	private float _currentBuffStackVelocity;

	private bool _doBuffStackNoAnimationSmoothOnFirstPlay;

	private bool _isPlaying;

	private float _playbackSpeed = 1f;

	private bool _paused;

	public GameObject nextFXPrefab;

	public bool playNextFXOnEnd = true;

	public float playNextFXDelayTime;

	public bool useCustomInheritOptions;

	public InheritOption customInheritOptions;

	protected bool _nextFXPlayed;

	public AdventureFXPlayer_Component.ComponentType subComponentType;

	protected List<AdventureFXPlayer_Component> subComponents = new List<AdventureFXPlayer_Component>(4);

	protected AdventureFXPlayer_Animation _animtionSubComponent;

	protected AdventureFXPlayer_Timeline _timelineSubComponent;

	protected AdventureFXPlayer_AnimationEventReceiver _animationEventReceiver;

	protected AkPrefabTrigger[] _akAudioPlayers;

	public EmbedFX[] embedFXes;

	private const float FULL_SCREEN_FX_DISTANCE = 1f;

	private const float FULL_SCREEN_FX_DISTANCE_LAYER_STEP = -0.1f;

	private const float FULL_SCREEN_FX_SCALE = 1f;

	private const float FULL_SCREEN_FX_REF_ASPECT = 2f;

	private const float FULL_SCREEN_FX_REF_FOV = 40f;

	private static readonly float FULL_SCREEN_FX_REF_FOV_TAN = Mathf.Tan(0.34906584f);

	public Transform source
	{
		get
		{
			return _source;
		}
		set
		{
			_source = value;
		}
	}

	public Vector3 sourcePosition
	{
		get
		{
			if (_source != null)
			{
				return _source.position;
			}
			return _sourcePosition;
		}
		set
		{
			_sourcePosition = value;
		}
	}

	public Quaternion sourceRotation
	{
		get
		{
			if (_source != null)
			{
				return _source.rotation;
			}
			return transform.rotation;
		}
	}

	public Transform target
	{
		get
		{
			return _target;
		}
		set
		{
			_target = value;
		}
	}

	public Vector3 targetPosition
	{
		get
		{
			if (_target != null)
			{
				return _target.position;
			}
			return _targetPosition;
		}
		set
		{
			_targetPosition = value;
		}
	}

	public Quaternion targetRotation
	{
		get
		{
			if (_target != null)
			{
				return _target.rotation;
			}
			return transform.rotation;
		}
	}

	public GameObject owner => _owner;

	public LogicEntity bindEntity => _entity;

	public AdventureActor bindActor => _actor;

	public AdventureActor ownerActor
	{
		get
		{
			return _ownerActor;
		}
		set
		{
			_ownerActor = value;
			AdventureFXManager.onFXPlayerOwnerActorBind?.Invoke(this);
		}
	}

	public bool cancelOnInterrupt
	{
		get
		{
			return _cancelOnInterrupt;
		}
		set
		{
			_cancelOnInterrupt = value;
		}
	}

	public Vector3 syncLocalOffsetPosition { get; set; } = Vector3.zero;

	public Quaternion syncLocalOffsetRotation { get; set; } = Quaternion.identity;

	public AnimationSlotConfigComponent syncSlotComponent
	{
		get
		{
			return _syncSlotConfigComponent;
		}
		set
		{
			if (_syncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent syncSlotConfigComponent = _syncSlotConfigComponent;
				syncSlotConfigComponent.onSlotGroupChange = (Action)Delegate.Remove(syncSlotConfigComponent.onSlotGroupChange, new Action(OnSlotGroupChange));
			}
			_syncSlotConfigComponent = value;
			if (_syncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent syncSlotConfigComponent2 = _syncSlotConfigComponent;
				syncSlotConfigComponent2.onSlotGroupChange = (Action)Delegate.Combine(syncSlotConfigComponent2.onSlotGroupChange, new Action(OnSlotGroupChange));
			}
		}
	}

	public Transform syncNode
	{
		get
		{
			return _syncNode;
		}
		set
		{
			_syncNode = value;
			if (_syncNode != null && keepSyncOffset)
			{
				syncLocalOffsetPosition = _syncNode.InverseTransformPoint(transform.position);
				Vector3 forward = _syncNode.InverseTransformDirection(transform.forward);
				syncLocalOffsetRotation = Quaternion.LookRotation(forward);
			}
		}
	}

	public virtual float size
	{
		get
		{
			return _size;
		}
		set
		{
			_size = value;
			float num = _size * _sizeScale;
			transform.localScale = new Vector3(num, num, num);
		}
	}

	public virtual float sizeScale
	{
		get
		{
			return _sizeScale;
		}
		set
		{
			_sizeScale = value;
			float num = _size * _sizeScale;
			transform.localScale = new Vector3(num, num, num);
		}
	}

	public bool isLoop { get; protected set; }

	public bool isPlaying
	{
		get
		{
			if (_isPlaying)
			{
				return gameObject.activeSelf;
			}
			return false;
		}
	}

	public float playbackTime => _playbackTimer;

	public float remainTimer => _remainTimer;

	public bool inRemainPhase => _remainTimer > float.Epsilon;

	public float playbackSpeed
	{
		get
		{
			return _playbackSpeed;
		}
		set
		{
			_playbackSpeed = value;
			UpdateSubComponentsPlaybackSpeed(_playbackSpeed, finalTimeScale);
		}
	}

	public bool paused => _paused;

	public float playbackDeltaTime
	{
		get
		{
			float result = 0f;
			if (!_paused)
			{
				result = deltaTime * playbackSpeed;
			}
			return result;
		}
	}

	public long rootPlayerToken { get; internal set; }

	protected bool isSubComponentsLoop
	{
		get
		{
			for (int i = 0; i < subComponents.Count; i++)
			{
				if (subComponents.get_Item(i).isLoop)
				{
					return true;
				}
			}
			return false;
		}
	}

	protected bool isSubComponentsStoped
	{
		get
		{
			for (int i = 0; i < subComponents.Count; i++)
			{
				if (!subComponents.get_Item(i).isStoped)
				{
					return false;
				}
			}
			return true;
		}
	}

	public static Dictionary<int, AdventureFXPlayer> currentFullScreenFXInstances { get; protected set; } = new Dictionary<int, AdventureFXPlayer>();

	protected void Awake()
	{
		if (!isEmptyFX)
		{
			InitializeSubComponents();
			_renderers = GetComponentsInChildren<Renderer>();
			_akAudioPlayers = GetComponents<AkPrefabTrigger>();
		}
		destroyMode = DestroyMode.Disable;
	}

	protected override void OnEnable()
	{
		_playbackTimer = 0f;
		_paused = false;
		if (!isEmptyFX)
		{
			isLoop = isSubComponentsLoop;
		}
		else if (emptyFXDuration < 0f)
		{
			isLoop = true;
		}
		else
		{
			isLoop = false;
		}
		if (fadeOutInRemainPhase)
		{
			Fade(1f);
		}
		base.OnEnable();
	}

	protected override void OnDisable()
	{
		ReleaseAllSelfFX();
		ReleaseSubComponents();
		_owner = null;
		_entity = null;
		_entityID = 0L;
		_actor = null;
		_actorState = ActorState.Null;
		_combo = null;
		_comboPhase = Combo.Phase.None;
		_cancelOnInterrupt = false;
		_ownerActor = null;
		_syncTarget = null;
		syncLocalOffsetPosition = Vector3.zero;
		syncLocalOffsetRotation = Quaternion.identity;
		syncSlotComponent = null;
		syncNode = null;
		_size = 1f;
		_sizeScale = 1f;
		_source = null;
		_target = null;
		_remainTimer = 0f;
		_syncHiden = false;
		rootPlayerToken = 0L;
		_isPlaying = false;
		if (isFullScreenFX)
		{
			OnFullScreenFXStop();
		}
		base.OnDisable();
	}

	public override void DoUpdate()
	{
		if (_entity != null && _entity.Id == _entityID)
		{
			if (!disableBindTimeScale && _logicTimeScale != _entity.logicTimeScale)
			{
				SyncTimeScale(_entity.logicTimeScale);
			}
			else if (ignoreTimeScale != _entity.ignoreGlobalLogicTimeScale)
			{
				ignoreTimeScale = _entity.ignoreGlobalLogicTimeScale;
				SyncTimeScale(_entity.logicTimeScale);
			}
		}
		float num = playbackDeltaTime;
		_playbackTimer += num;
		if (!disableLifeCycleBind && (!inRemainPhase || (lifeCycleBindExtraOptions & LifeCycleBindExtraOption.ActiveInRemainPhase) > LifeCycleBindExtraOption.None))
		{
			if (_actor != null && (isLoop || (lifeCycleBindExtraOptions & LifeCycleBindExtraOption.ActiveInNonLoop) > LifeCycleBindExtraOption.None))
			{
				if (_combo != null && (_actor.playingCombo != _combo || (_comboPhase & _actor.attackComboPhase) == 0))
				{
					Stop();
					return;
				}
				if (_actorState != ActorState.Null && _actor.state != _actorState)
				{
					Stop();
					return;
				}
				if (!disableBindActorDead && _actor.isDead)
				{
					Stop();
					return;
				}
			}
			if (_entity != null)
			{
				if (!_entity.gameObject.activeInHierarchy || _entity.Id != _entityID)
				{
					Stop();
					return;
				}
			}
			else if ((object)_owner != null && (_owner == null || !_owner.activeInHierarchy))
			{
				Stop();
				return;
			}
		}
		UpdatePlayback(num);
	}

	public override void DoLateUpdate()
	{
		if (!inRemainPhase || keepSyncInRemainPhase || isFullScreenFX)
		{
			UpdateTransformSync();
		}
	}

	protected static AdventureFXPlayer Spawn(GameObject fxPrefab, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f, bool isPreloadSpawn = false)
	{
		AdventureFXPlayer adventureFXPlayer = Setup(AdventureFXHandler.SpawnInstance(fxPrefab, spawnPosition, spawnRotation, Vector3.one, isPreloadSpawn, out var destroyMode).gameObject);
		adventureFXPlayer.destroyMode = destroyMode;
		adventureFXPlayer.size = spawnSize;
		return adventureFXPlayer;
	}

	protected static void Despawn(AdventureFXPlayer fxPlayer)
	{
		AdventureFXHandler.DestroyInstance(fxPlayer);
	}

	public static AdventureFXPlayer Setup(GameObject fxInstance)
	{
		AdventureFXPlayer adventureFXPlayer = fxInstance.GetComponent<AdventureFXPlayer>();
		if (adventureFXPlayer == null)
		{
			adventureFXPlayer = fxInstance.AddComponent<AdventureFXPlayer>();
		}
		return adventureFXPlayer;
	}

	internal static void PreloadFX(GameObject fxPrefab)
	{
		if (!(fxPrefab == null))
		{
			AdventureFXPlayer adventureFXPlayer = Spawn(fxPrefab, Vector3.zero, Quaternion.identity, 1f, isPreloadSpawn: true);
			adventureFXPlayer.Preload_Internal();
			Despawn(adventureFXPlayer);
		}
	}

	protected virtual void Preload_Internal()
	{
		if (nextFXPrefab != null)
		{
			PreloadFX(nextFXPrefab);
		}
	}

	public static AdventureFXPlayer PlayFX(GameObject fxPrefab, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f, Transform source = null, Vector3 sourcePosition = default(Vector3), Transform target = null, Vector3 targetPosition = default(Vector3))
	{
		if (fxPrefab == null)
		{
			return null;
		}
		AdventureFXPlayer adventureFXPlayer = Spawn(fxPrefab, spawnPosition, spawnRotation, spawnSize);
		adventureFXPlayer.Play(playbackSpeed, source, sourcePosition, target, targetPosition);
		return adventureFXPlayer;
	}

	public static AdventureFXPlayer PlayFX(GameObject callerEntity, bool useActorSizeScale, bool useTransformSync, GameObject fxPrefab, float playbackSpeed, Vector3 spawnPosition, Quaternion spawnRotation, float spawnSize = 1f, Transform source = null, Vector3 sourcePosition = default(Vector3), Transform target = null, Vector3 targetPosition = default(Vector3))
	{
		if (fxPrefab == null)
		{
			return null;
		}
		if (callerEntity == null)
		{
			return PlayFX(fxPrefab, playbackSpeed, spawnPosition, spawnRotation, spawnSize, source, sourcePosition, target, targetPosition);
		}
		AdventureFXPlayer adventureFXPlayer = Spawn(fxPrefab, spawnPosition, spawnRotation, spawnSize);
		adventureFXPlayer.Play(playbackSpeed, source, sourcePosition, target, targetPosition);
		if (useActorSizeScale)
		{
			callerEntity.TryGetParentComponent<AdventureActor>(out var comp);
			if (comp != null)
			{
				adventureFXPlayer.sizeScale = comp.transform.localScale.x;
			}
		}
		GameObject syncTarget = null;
		if (useTransformSync && callerEntity.TryGetParentComponent<AnimationSlotConfigComponent>(out var comp2))
		{
			syncTarget = comp2.gameObject;
		}
		AdventureActor component = callerEntity.GetComponent<AdventureActor>();
		if (component != null)
		{
			adventureFXPlayer.Bind(callerEntity.gameObject, syncTarget, component.state);
		}
		else
		{
			adventureFXPlayer.Bind(callerEntity.gameObject, syncTarget);
		}
		return adventureFXPlayer;
	}

	protected override void OnHide()
	{
		if (_renderers != null)
		{
			for (int i = 0; i < _renderers.Length; i++)
			{
				_renderers[i].forceRenderingOff = true;
			}
		}
		HideSubComponents();
	}

	protected override void OnVisible()
	{
		if (_renderers != null)
		{
			for (int i = 0; i < _renderers.Length; i++)
			{
				_renderers[i].forceRenderingOff = false;
			}
		}
		VisibleSubComponents();
	}

	public override void SetRenderLayer(int layer)
	{
		if (_renderers != null)
		{
			for (int i = 0; i < _renderers.Length; i++)
			{
				_renderers[i].gameObject.layer = layer;
			}
		}
	}

	public override void ResetRenderLayer()
	{
		if (_renderers != null)
		{
			for (int i = 0; i < _renderers.Length; i++)
			{
				_renderers[i].gameObject.layer = 1;
			}
		}
	}

	protected void SyncVisible()
	{
		if (bindVisible && _actor != null)
		{
			if (_actor.isHide && !_syncHiden)
			{
				Hide();
				_syncHiden = true;
			}
			else if (!_actor.isHide && _syncHiden)
			{
				Visible();
				_syncHiden = false;
			}
		}
	}

	protected void Fade(float t)
	{
		for (int i = 0; i < _renderers.Length; i++)
		{
			Material material = _renderers[i].material;
			Color color = material.color;
			color.a = t;
			material.color = color;
		}
	}

	public virtual void Bind(GameObject owner, GameObject syncTarget = null, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		_owner = owner;
		_entity = owner.GetComponent<LogicEntity>();
		if (_entity != null)
		{
			_actor = _entity as AdventureActor;
			_entityID = _entity.Id;
		}
		if (!disableLifeCycleBind)
		{
			_actorState = ((!disableBindActorState) ? actorState : ActorState.Null);
			_combo = ((!disableBindCombo) ? combo : null);
			_comboPhase = ((!disableBindCombo) ? comboPhase : Combo.Phase.None);
		}
		_cancelOnInterrupt = cancelOnInterrupt;
		if (!disableBindTimeScale && _entity != null)
		{
			SyncTimeScale(_entity.logicTimeScale);
		}
		InitTransformSync((syncTarget != null) ? syncTarget : owner);
		SyncVisible();
		BindSubComponents(owner);
		AdventureFXManager.onFXPlayerBind?.Invoke(this);
	}

	protected void SyncTimeScale(FP logicTimeScale)
	{
		_logicTimeScale = logicTimeScale;
		timeScale = (float)logicTimeScale;
	}

	public override void OnTimeScaleChanged()
	{
		UpdateSubComponentsPlaybackSpeed(_playbackSpeed, finalTimeScale);
	}

	public void InitTransformSync(GameObject syncTarget)
	{
		_syncTarget = syncTarget;
		AnimationSlotConfigComponent component;
		if (isFullScreenFX)
		{
			if (drawFullScreenFXInUILayer)
			{
				for (int i = 0; i < _renderers.Length; i++)
				{
					_renderers[i].sortingLayerName = "UI";
				}
			}
		}
		else if (syncSlot == AnimationSlotConfigComponent.SlotType.Base)
		{
			syncNode = syncTarget.transform;
		}
		else if (syncSlot != AnimationSlotConfigComponent.SlotType.None && syncTarget.TryGetComponent<AnimationSlotConfigComponent>(out component))
		{
			syncSlotComponent = component;
			syncNode = component.GetSlotNode(syncSlot, allowFallback: true);
		}
		UpdateTransformSync();
	}

	protected void UpdateTransformSync()
	{
		if (isFullScreenFX)
		{
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			if (mainCamera != null)
			{
				float num = 1f + -0.1f * (float)fullScreenFXLayer;
				Vector3 forward = mainCamera.transform.forward;
				transform.position = mainCamera.transform.position + forward * (mainCamera.nearClipPlane + num);
				transform.forward = -forward;
				float num2 = Mathf.Tan(mainCamera.GetVerticalOrHorizontalFieldOfView() * 0.5f * (MathF.PI / 180f)) / FULL_SCREEN_FX_REF_FOV_TAN;
				float num3 = 1f * num2 * (mainCamera.nearClipPlane + num);
				float num4 = mainCamera.aspect / 2f;
				float num5 = 0f;
				switch (fullscreenScaleMode)
				{
				case FullScreenScaleMode.StretchToFill:
					transform.localScale = new Vector3(num4 * num3, num3, num3);
					break;
				case FullScreenScaleMode.ScaleAndCrop:
					num5 = Mathf.Max(num4 * num3, num3);
					transform.localScale = new Vector3(num5, num5, num3);
					break;
				case FullScreenScaleMode.ScaleToFit:
					num5 = Mathf.Min(num4 * num3, num3);
					transform.localScale = new Vector3(num5, num5, num3);
					break;
				}
			}
			return;
		}
		if (syncNode != null && syncNode.gameObject.activeInHierarchy)
		{
			transform.position = syncNode.TransformPoint(syncLocalOffsetPosition);
			if (syncSlotRotation)
			{
				transform.rotation = syncNode.rotation * syncLocalOffsetRotation;
			}
			if (syncSlotScale)
			{
				sizeScale = syncNode.lossyScale.x;
			}
		}
		if (lockRotation)
		{
			transform.rotation = Quaternion.identity;
		}
		if (lockOnGround)
		{
			Vector3 position = transform.position;
			float terrainHeight = CommonHelper.GetTerrainHeight(new Vector2(position.x, position.z), position.y, out var _);
			position.y = terrainHeight + lockOnGroundOffset;
			transform.position = position;
		}
	}

	protected virtual void OnSlotGroupChange()
	{
		syncNode = syncSlotComponent.GetSlotNode(syncSlot, allowFallback: true);
		UpdateTransformSync();
	}

	public virtual void Play(float playbackSpeed = 1f, Transform source = null, Vector3 sourcePosition = default(Vector3), Transform target = null, Vector3 targetPosition = default(Vector3))
	{
		_isPlaying = true;
		gameObject.SetActive(value: true);
		_source = source;
		_sourcePosition = sourcePosition;
		_target = target;
		_targetPosition = targetPosition;
		SetIndependentUpdate(value: false);
		PlaySubComponents();
		_logicTimeScale = FP.One;
		_timeScale = 1f;
		this.playbackSpeed = playbackSpeed;
		_remainTimer = 0f;
		_nextFXPlayed = false;
		if (fadeInTime > float.Epsilon)
		{
			Fade(0f);
		}
		if (isFullScreenFX)
		{
			OnFullScreenFXPlay();
		}
		if (enableBuffStackSupport)
		{
			SetupBuffStack();
		}
		AdventureFXManager.onFXPlayerPlay?.Invoke(this);
	}

	public virtual void Stop(bool dontPlaySubFX = false)
	{
		if (isPlaying && (!inRemainPhase || dontPlaySubFX))
		{
			bool flag;
			if (remainTime > float.Epsilon && !dontPlaySubFX)
			{
				EnterRemainPhase();
				flag = false;
			}
			else
			{
				Stop_Internal();
				flag = true;
			}
			if (!dontPlaySubFX && nextFXPrefab != null && playNextFXOnEnd && !_nextFXPlayed)
			{
				PlayNextFX();
			}
			if (flag)
			{
				Despawn(this);
			}
		}
	}

	protected void EnterRemainPhase()
	{
		_remainTimer = remainTime;
		StopSelfFXInRemainPhase();
		PlaySubComponentsInRemain();
		AdventureFXManager.onFXPlayerPlayInRemain?.Invoke(this);
		if (_akAudioPlayers != null)
		{
			for (int i = 0; i < _akAudioPlayers.Length; i++)
			{
				_akAudioPlayers[i].OnExit();
			}
		}
	}

	protected void Stop_Internal()
	{
		StopSubComponents();
		_isPlaying = false;
	}

	public virtual void Pause()
	{
		if (!_paused)
		{
			PauseSubComponents();
			_paused = true;
		}
	}

	public virtual void Resume()
	{
		if (_paused)
		{
			ResumeSubComponents();
			_paused = false;
		}
	}

	protected virtual void UpdatePlayback(float dt)
	{
		if (inRemainPhase)
		{
			_remainTimer -= dt;
			if (_remainTimer <= 0f)
			{
				Stop_Internal();
				Despawn(this);
				return;
			}
			UpdateSubComponentsPlaybackInRemain(dt);
			if (fadeOutInRemainPhase)
			{
				Fade(_remainTimer / remainTime);
			}
		}
		else
		{
			SyncVisible();
			if (!isLoop)
			{
				if (!isEmptyFX)
				{
					if (PlaybackStoped())
					{
						Stop();
						return;
					}
				}
				else if (_playbackTimer >= emptyFXDuration)
				{
					Stop();
					return;
				}
			}
			if (_timelineSubComponent != null && !_timelineSubComponent.isLoop && _timelineSubComponent.isStoped)
			{
				Stop();
				return;
			}
			if (stopLoopOnAnimationDone && _animtionSubComponent != null && !_animtionSubComponent.isLoop && _animtionSubComponent.isStoped)
			{
				Stop();
				return;
			}
			UpdateSubComponentsPlayback(dt);
			if (fadeInTime > float.Epsilon)
			{
				Fade(Mathf.Clamp01(_playbackTimer / fadeInTime));
			}
			if (nextFXPrefab != null && !playNextFXOnEnd && !_nextFXPlayed && _playbackTimer >= playNextFXDelayTime)
			{
				PlayNextFX();
			}
		}
		if (enableBuffStackSupport)
		{
			UpdateBuffStack(dt);
		}
	}

	protected virtual bool PlaybackStoped()
	{
		return isSubComponentsStoped;
	}

	private void SetupBuffStack()
	{
		if (_buffStackMaterials == null)
		{
			_buffStackMaterials = new List<Material>();
			for (int i = 0; i < _renderers.Length; i++)
			{
				Renderer renderer = _renderers[i];
				if (renderer.sharedMaterial != null && renderer.sharedMaterial.HasFloat(GlobalShaderPropertyName.BuffStackProgressID))
				{
					_buffStackMaterials.Add(renderer.material);
				}
			}
		}
		_currentBuffStackProgress = 0f;
		_targetBuffStackProgress = 0f;
		_currentBuffStackVelocity = 0f;
		_doBuffStackNoAnimationSmoothOnFirstPlay = buffStackNoAnimationSmoothOnFirstPlay;
		for (int j = 0; j < _buffStackMaterials.Count; j++)
		{
			_buffStackMaterials.get_Item(j).SetFloat(GlobalShaderPropertyName.BuffStackProgressID, 0f);
		}
	}

	internal void UpdateBuffStack(int currentStackCount, int maxStackCount)
	{
		if (currentStackCount < 0 || currentStackCount > maxStackCount)
		{
			throw new ArgumentException("UpdateBuffStack Argument Error", "currentStackCount");
		}
		if (maxStackCount <= 0)
		{
			throw new ArgumentException("UpdateBuffStack Argument Error", "maxStackCount");
		}
		if (isPlaying && enableBuffStackSupport)
		{
			_targetBuffStackProgress = (float)currentStackCount / (float)maxStackCount;
		}
	}

	private void UpdateBuffStack(float dt)
	{
		if (dt > 0f && _buffStackMaterials.Count > 0)
		{
			if (buffStackAnimationSmoothTime < 0f || _doBuffStackNoAnimationSmoothOnFirstPlay)
			{
				_currentBuffStackProgress = _targetBuffStackProgress;
				_doBuffStackNoAnimationSmoothOnFirstPlay = false;
			}
			else
			{
				_currentBuffStackProgress = Mathf.SmoothDamp(_currentBuffStackProgress, _targetBuffStackProgress, ref _currentBuffStackVelocity, buffStackAnimationSmoothTime, float.PositiveInfinity, dt);
			}
			for (int i = 0; i < _buffStackMaterials.Count; i++)
			{
				_buffStackMaterials.get_Item(i).SetFloat(GlobalShaderPropertyName.BuffStackProgressID, _currentBuffStackProgress);
			}
		}
	}

	protected void PlayNextFX()
	{
		AdventureFXPlayer adventureFXPlayer = PlayFX(nextFXPrefab, playbackSpeed, transform.position, transform.rotation, size, source, sourcePosition, target, targetPosition);
		adventureFXPlayer.sizeScale = sizeScale;
		if (rootPlayerToken == 0L)
		{
			adventureFXPlayer.rootPlayerToken = token;
		}
		else
		{
			adventureFXPlayer.rootPlayerToken = rootPlayerToken;
		}
		InheritOption inheritOption = ((!useCustomInheritOptions) ? InheritOption.Binding : customInheritOptions);
		if ((inheritOption & InheritOption.Binding) > (InheritOption)0)
		{
			adventureFXPlayer.bindVisible = bindVisible;
			adventureFXPlayer.disableBindTimeScale = disableBindTimeScale;
			adventureFXPlayer.disableLifeCycleBind = disableLifeCycleBind;
			adventureFXPlayer.disableBindActorState = disableBindActorState;
			adventureFXPlayer.disableBindCombo = disableBindCombo;
			adventureFXPlayer.disableBindActorDead = disableBindActorDead;
		}
		if ((inheritOption & InheritOption.SyncSlot) > (InheritOption)0)
		{
			adventureFXPlayer.syncSlot = syncSlot;
			adventureFXPlayer.syncSlotRotation = syncSlotRotation;
			adventureFXPlayer.syncSlotScale = syncSlotScale;
			adventureFXPlayer.keepSyncOffset = keepSyncOffset;
			adventureFXPlayer.syncLocalOffsetPosition = syncLocalOffsetPosition;
			adventureFXPlayer.syncLocalOffsetRotation = syncLocalOffsetRotation;
		}
		if (_owner != null)
		{
			adventureFXPlayer.Bind(_owner, _syncTarget, _actorState, _combo, _comboPhase);
		}
		else if ((inheritOption & InheritOption.SyncSlot) > (InheritOption)0 && _syncTarget != null)
		{
			adventureFXPlayer.InitTransformSync(_syncTarget);
		}
		_nextFXPlayed = true;
	}

	protected void InitializeSubComponents()
	{
		ParticleSystem particleSystem = SimpleGetComponentInChildren<ParticleSystem>();
		if (particleSystem != null)
		{
			gameObject.AddComponent<AdventureFXPlayer_ParticleSystem>().rootParticleSystem = particleSystem;
		}
		SimpleAnimation simpleAnimation = SimpleGetComponentInChildren<SimpleAnimation>();
		if (simpleAnimation != null)
		{
			_animtionSubComponent = gameObject.AddComponent<AdventureFXPlayer_Animation>();
			_animtionSubComponent.animationController = simpleAnimation;
			_animationEventReceiver = simpleAnimation.gameObject.AddComponent<AdventureFXPlayer_AnimationEventReceiver>();
			_animationEventReceiver.ownerPlayer = this;
		}
		PlayableDirector playableDirector = SimpleGetComponentInChildren<PlayableDirector>();
		if (playableDirector != null)
		{
			_timelineSubComponent = gameObject.AddComponent<AdventureFXPlayer_Timeline>();
			_timelineSubComponent.playableDirector = playableDirector;
		}
		TrailRenderer trailRenderer = SimpleGetComponentInChildren<TrailRenderer>();
		if (trailRenderer != null)
		{
			gameObject.AddComponent<AdventureFXPlayer_Trail>().trail = trailRenderer;
		}
		SimpleGetComponentInChildren<TimelineCinemachineImpulseMakerReceiver>();
		if (playableDirector == null || SimpleGetComponentInChildren<TimelineCinemachineImpulseMakerReceiver>() == null)
		{
			CinemachineImpulseSource[] array = SimpleGetComponentsInChildren<CinemachineImpulseSource>();
			if (array != null && array.Length != 0)
			{
				gameObject.AddComponent<AdventureFXPlayer_ImpulseSource>().impulseSources = array;
			}
		}
		subComponents.AddRange(SimpleGetComponentsInChildren<AdventureFXPlayer_Component>());
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Initialize(this);
		}
	}

	protected void ReleaseSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Release();
		}
	}

	protected void PlaySubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Play();
		}
	}

	protected void StopSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Stop();
		}
	}

	protected void PauseSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Pause();
		}
	}

	protected void ResumeSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).Resume();
		}
	}

	protected void UpdateSubComponentsPlayback(float dt)
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).UpdatePlayback(dt);
		}
	}

	protected void PlaySubComponentsInRemain()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).PlayInRemain();
		}
	}

	protected void UpdateSubComponentsPlaybackInRemain(float dt)
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).UpdatePlaybackInRemain(dt);
		}
	}

	protected void BindSubComponents(GameObject owner)
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).OnBind(owner);
		}
	}

	protected void UpdateSubComponentsPlaybackSpeed(float speed, float timeScale)
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).OnUpdatePlaybackSpeed(speed, timeScale);
		}
	}

	protected void HideSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).OnHide();
		}
	}

	protected void VisibleSubComponents()
	{
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).OnVisible();
		}
	}

	public override void SetIndependentUpdate(bool value)
	{
		base.SetIndependentUpdate(value);
		for (int i = 0; i < subComponents.Count; i++)
		{
			subComponents.get_Item(i).OnIndependentUpdateChanged(value);
		}
	}

	internal T SimpleGetComponentInChildren<T>() where T : Component
	{
		T component = GetComponent<T>();
		if (component != null)
		{
			return component;
		}
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			component = child.GetComponent<T>();
			if (component != null && child.GetComponent<AdventureFXHandler>() == null)
			{
				return component;
			}
		}
		return null;
	}

	internal T[] SimpleGetComponentsInChildren<T>() where T : Component
	{
		List<T> list = new List<T>();
		list.AddRange(GetComponents<T>());
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			T component = child.GetComponent<T>();
			if (component != null && child.GetComponent<AdventureFXHandler>() == null)
			{
				list.Add(component);
			}
		}
		return list.ToArray();
	}

	internal void PlaySelfFX(string fxName)
	{
		if (embedFXes == null)
		{
			return;
		}
		for (int i = 0; i < embedFXes.Length; i++)
		{
			EmbedFX embedFX = embedFXes[i];
			if (!(embedFX.triggerAnimEventName == fxName) || embedFX.fxPlayer == null || (embedFX.stopInRemainPhase && inRemainPhase))
			{
				continue;
			}
			if (embedFX.playOnceInLoop)
			{
				if (embedFX._playedOnce)
				{
					continue;
				}
				embedFX._playedOnce = true;
			}
			embedFX.Play();
		}
	}

	internal void StopSelfFX(string fxName)
	{
		if (embedFXes == null)
		{
			return;
		}
		for (int i = 0; i < embedFXes.Length; i++)
		{
			EmbedFX embedFX = embedFXes[i];
			if (embedFX.triggerAnimEventName == fxName)
			{
				embedFX.Stop(isRelease: false);
			}
		}
	}

	private void ReleaseAllSelfFX()
	{
		if (embedFXes != null)
		{
			for (int i = 0; i < embedFXes.Length; i++)
			{
				embedFXes[i].Stop(isRelease: true);
			}
		}
	}

	private void StopSelfFXInRemainPhase()
	{
		if (embedFXes == null)
		{
			return;
		}
		for (int i = 0; i < embedFXes.Length; i++)
		{
			EmbedFX embedFX = embedFXes[i];
			if (embedFX.stopInRemainPhase)
			{
				embedFX.Stop(isRelease: false);
			}
		}
	}

	public bool IsEmbedFX(AdventureFXPlayer fxPlayer)
	{
		if (embedFXes == null)
		{
			return false;
		}
		for (int i = 0; i < embedFXes.Length; i++)
		{
			if (embedFXes[i].fxPlayer == fxPlayer)
			{
				return true;
			}
		}
		return false;
	}

	protected void OnFullScreenFXPlay()
	{
		if (currentFullScreenFXInstances.TryGetValue(fullScreenFXLayer, out var value) && value != this)
		{
			value.Stop(dontPlaySubFX: true);
			currentFullScreenFXInstances.Remove(fullScreenFXLayer);
		}
		currentFullScreenFXInstances.Add(fullScreenFXLayer, this);
	}

	protected void OnFullScreenFXStop()
	{
		if (currentFullScreenFXInstances.TryGetValue(fullScreenFXLayer, out var value) && value == this)
		{
			currentFullScreenFXInstances.Remove(fullScreenFXLayer);
		}
	}

	public static Quaternion RandomLocalRotation(Vector3 rotationRandomAngle)
	{
		return Quaternion.Euler(UnityEngine.Random.Range(0f - rotationRandomAngle.x, rotationRandomAngle.x), UnityEngine.Random.Range(0f - rotationRandomAngle.y, rotationRandomAngle.y), UnityEngine.Random.Range(0f - rotationRandomAngle.z, rotationRandomAngle.z));
	}

	public void AdsorptionTo(Transform target, Vector3 rotationRandomAngle = default(Vector3))
	{
		if (rotationRandomAngle.x > float.Epsilon || rotationRandomAngle.y > float.Epsilon || rotationRandomAngle.z > float.Epsilon)
		{
			Quaternion quaternion = RandomLocalRotation(rotationRandomAngle);
			transform.rotation *= quaternion;
		}
		syncSlotRotation = true;
		keepSyncOffset = true;
		syncNode = target;
	}

	public static bool CheckValidate(GameObject prefab)
	{
		if (prefab.TryGetComponent<AdventureFXPlayer>(out var component))
		{
			AdventureFXPlayer[] componentsInChildren = prefab.GetComponentsInChildren<AdventureFXPlayer>(includeInactive: true);
			if (componentsInChildren.Length > 1)
			{
				AdventureFXPlayer[] array = componentsInChildren;
				foreach (AdventureFXPlayer adventureFXPlayer in array)
				{
					if (!(adventureFXPlayer == component) && !component.IsEmbedFX(adventureFXPlayer))
					{
						Debug.Log("特效预制体上有多个不是嵌套的特效的FX Player组件:" + prefab.name);
						return false;
					}
				}
			}
		}
		else if (prefab.GetComponentsInChildren<AdventureFXPlayer>(includeInactive: true).Length != 0)
		{
			Debug.Log("特效预制体顶层没有FX Player组件的情况下，子节点上有多余的FX Player组件:" + prefab.name);
			return false;
		}
		return true;
	}
}
