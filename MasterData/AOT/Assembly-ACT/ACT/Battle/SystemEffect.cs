using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.Battle;

public class SystemEffect : EntitySystem
{
	public enum EffectPlaySpace
	{
		World,
		UI
	}

	public enum UIEffectAnchor
	{
		TopLeft,
		TopCenter,
		TopRight,
		MiddleLeft,
		Center,
		MiddleRight,
		BottomLeft,
		BottomCenter,
		BottomRight,
		Custom,
		FollowRect
	}

	public struct EffectParams
	{
		public FindTargetResult target;

		public YooAssetReference patternAssetID;

		public Vector3 constPointPos;

		public bool removeWhenMotionExit;

		public bool removeWhenConfigMotionExit;

		public string configMotionName;

		public TimeScale timescale;

		public EffectDataType type;

		public EffectPoint point1;

		public EffectPoint point2;

		public bool removeWhenStop;

		public bool changeScale;

		public EffectRangeEnum effectRangeEnum;

		public Vector3 transformScaleMulBase;

		public EffectModelType modelType;

		public bool isChangeWithEntity;

		public Quaternion initRotation;

		public bool isAttach;

		public bool ignoreOwnerVisible;

		public MotionState motioState;

		public bool xMirror;

		public float warningEffectTime;

		public bool exclusivePriority;

		public int priority;

		public EffectPlaySpace playSpace;

		public UIEffectAnchor uiAnchor;

		public Vector2 uiAnchoredOffset;

		public bool uiRespectSafeArea;

		public Vector2 uiCustomAnchorPos;

		public RectTransform uiFollowRect;

		public int uiSiblingOrder;
	}

	private sealed class PlayEffectRuntime
	{
		public readonly EffectPlayRequest request;

		public readonly EffectRuntimeItem runtime;

		public PlayEffectRuntime(EffectPlayRequest request, EffectRuntimeItem runtime)
		{
			this.request = request;
			this.runtime = runtime;
		}
	}

	private struct EffectPlayRequest
	{
		public ActionPlayEffectBase action;

		public ActionMemory memory;

		public YooAssetReference effectReference;

		public Ability ability;

		public Entity anchorEntity;

		public Entity logicDirectionEntity;

		public Entity lifetimeEntity;

		public Entity runtimeOwner;

		public Entity timeScaleOwner;

		public TimeScale timeScale;

		public Vector3 positionOffset;

		public EffectPositionUpdateRule positionUpdateRule;

		public float positionFollowSpeed;

		public EffectInvalidAnchorRule invalidAnchorRule;

		public EffectRotationUpdateRule rotationUpdateRule;

		public EffectScaleRule scaleRule;

		public Vector3 randomRotationOffset;

		public bool changeWithAnchorVisibility;

		public bool isDetached;

		public bool checkMotionExit;

		public bool removeWhenMotionExit;

		public bool removeWhenConfigMotionExit;

		public MotionState motionState;

		public string configMotionName;

		public EffectStopBehavior stopBehavior;

		public bool isUIEffect;

		public bool isCameraEffect;

		public bool isUIVisibilityControlled;

		public EffectUIPlayPoint uiAnchor;

		public Vector2 uiCustomAnchorPosition;

		public Vector2 uiAnchoredOffset;

		public bool uiRespectSafeArea;

		public int uiSiblingOrder;
	}

	private readonly struct EffectAnchor(Vector3 position, Quaternion rotation, Vector3 scale, Transform transform)
	{
		public readonly Vector3 position = position;

		public readonly Quaternion rotation = rotation;

		public readonly Vector3 scale = scale;

		public readonly Transform transform = transform;
	}

	private struct RecentSpatialEffectPlay
	{
		public Vector2 position;

		public float expireAt;
	}

	private List<EffectRuntimeItem> m_AllEffects;

	private ObjectPool<EffectRuntimeItem> m_EffectPool;

	private List<EffectRuntimeItem> m_UIEffectList;

	private bool _allUIEffectsVisible = true;

	private Filter _filter;

	private EntityAction<CompEffect> _lateUpdateEffectAction;

	private EntityAction<CompEffect> _fixedUpdateEffectAction;

	private EntityAction<CompEffect> _updateEffectAction;

	private float _updateLerp;

	private readonly List<PlayEffectRuntime> _effects = new List<PlayEffectRuntime>();

	private static readonly bool EnableSpatialPlayLimit = true;

	private static readonly int SpatialPlayMaxCount = 1;

	private static readonly float SpatialPlayRadius = 0.35f;

	private static readonly float SpatialPlayRadiusSqr = SpatialPlayRadius * SpatialPlayRadius;

	private static readonly float SpatialPlayWindowSeconds = 0.05f;

	private Dictionary<string, List<RecentSpatialEffectPlay>> _recentSpatialEffectPlays;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompAbility>().Build();
		_lateUpdateEffectAction = LateUpdateEffect;
		_fixedUpdateEffectAction = FixedUpdateEffect;
		_updateEffectAction = UpdateEffect;
		m_AllEffects = new List<EffectRuntimeItem>();
		m_UIEffectList = new List<EffectRuntimeItem>();
		m_EffectPool = new ObjectPool<EffectRuntimeItem>((EffectRuntimeItem x) =>
		{
			x.OnGet();
		}, (EffectRuntimeItem x) =>
		{
			x.Reset();
		}, 20);
	}

	public override void LateUpdate()
	{
		_filter.ForEachStable(_lateUpdateEffectAction);
		LateUpdatePlayEffects();
	}

	private void LateUpdateEffect(Entity entity, CompEffect compEffect)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		List<EffectRuntimeItem> myEffects = compEffect.myEffects;
		int count = myEffects.Count;
		for (int i = 0; i < count; i++)
		{
			if (myEffects[i].status == AsyncOperationStatus.Succeeded)
			{
				myEffects[i].Sync(init: false);
			}
		}
	}

	public override void FixedUpdate()
	{
		_filter.ForEachStable(_fixedUpdateEffectAction);
		FixedUpdateAbilityOwnedEffects();
		FixedUpdatePlayEffects();
	}

	private void FixedUpdateEffect(Entity entity, CompEffect compEffect)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		List<EffectRuntimeItem> myEffects = compEffect.myEffects;
		int count = myEffects.Count;
		CompTime compTime = entity.GetCompTime();
		CompMotion compMotion = entity.GetCompMotion();
		for (int i = 0; i < count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = myEffects[i];
			effectRuntimeItem.lastTime = effectRuntimeItem.time;
			effectRuntimeItem.time += (compTime.effectSpeedChange ? compTime.motionFixedDeltaTime : compTime.motionFixedDeltaTimeOS);
			if (effectRuntimeItem.removeWhenMotionExit != MotionState.None && compMotion.curMotionState != effectRuntimeItem.removeWhenMotionExit && compMotion.curMotionState != MotionState.Move)
			{
				effectRuntimeItem.SetToBeRemove();
			}
			else if (!string.IsNullOrEmpty(effectRuntimeItem.removeWhenConfigMotionExit) && compMotion.layer0PeakConfig != null && compMotion.curMotionState != MotionState.Move && !string.Equals(compMotion.layer0PeakConfig.name, effectRuntimeItem.removeWhenConfigMotionExit, StringComparison.Ordinal))
			{
				effectRuntimeItem.SetToBeRemove();
			}
		}
	}

	public override void Update()
	{
		float num = Time.time - Time.fixedTime;
		_updateLerp = Mathf.Clamp01(num / Time.fixedDeltaTime);
		for (int i = 0; i < m_AllEffects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = m_AllEffects[i];
			if (effectRuntimeItem.isDone)
			{
				if (effectRuntimeItem.isUIEffect)
				{
					m_UIEffectList.Remove(effectRuntimeItem);
				}
				if (effectRuntimeItem.owner.IsActive() && effectRuntimeItem.owner.HasCompAbility())
				{
					effectRuntimeItem.owner.GetCompEffect()?.myEffects.Remove(effectRuntimeItem);
				}
				m_AllEffects.RemoveAt(i);
				i--;
				ReleaseEffectItem(effectRuntimeItem);
			}
		}
		_filter.ForEachStable(_updateEffectAction);
		UpdateAbilityOwnedEffects();
		UpdatePlayEffects();
	}

	private void UpdateEffect(Entity entity, CompEffect compEffect)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		CompTime compTime = entity.GetCompTime();
		foreach (EffectRuntimeItem myEffect in compEffect.myEffects)
		{
			if (myEffect.timeScale == TimeScale.Owner)
			{
				float num = Mathf.Lerp(myEffect.lastTime, myEffect.time, compTime.isFrameHalt() ? 1f : _updateLerp);
				float deltaTime = num - myEffect.lastSimulateTime;
				if (entity.IsActive() || !myEffect.isAttach)
				{
					myEffect.Simulate(deltaTime, restart: false);
				}
				myEffect.lastSimulateTime = num;
			}
		}
	}

	private float GetAbilityOwnedFixedDeltaTime()
	{
		SystemTime timeSystem = GameManager.timeSystem;
		if (timeSystem == null || MonoECS.instance == null || !MonoECS.instance.running)
		{
			return 0f;
		}
		return Time.fixedDeltaTime * timeSystem.globalSpeed * timeSystem.LogicSpeed;
	}

	private void FixedUpdateAbilityOwnedEffects()
	{
		float abilityOwnedFixedDeltaTime = GetAbilityOwnedFixedDeltaTime();
		if (abilityOwnedFixedDeltaTime <= 0f)
		{
			return;
		}
		for (int i = 0; i < m_AllEffects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = m_AllEffects[i];
			if (effectRuntimeItem.ignoreOwnerVisible)
			{
				effectRuntimeItem.lastTime = effectRuntimeItem.time;
				effectRuntimeItem.time += abilityOwnedFixedDeltaTime;
			}
		}
	}

	private void UpdateAbilityOwnedEffects()
	{
		for (int i = 0; i < m_AllEffects.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = m_AllEffects[i];
			if (effectRuntimeItem.ignoreOwnerVisible && effectRuntimeItem.timeScale == TimeScale.Owner)
			{
				float num = Mathf.Lerp(effectRuntimeItem.lastTime, effectRuntimeItem.time, _updateLerp);
				float deltaTime = num - effectRuntimeItem.lastSimulateTime;
				effectRuntimeItem.Simulate(deltaTime, restart: false);
				effectRuntimeItem.lastSimulateTime = num;
			}
		}
	}

	public EffectRuntimeItem GetEffectItem()
	{
		return m_EffectPool.Get();
	}

	public void ReleaseEffectItem(EffectRuntimeItem d)
	{
		m_EffectPool.Release(d);
	}

	private static bool TryAcceptEffectLoad(EffectRuntimeItem runtime, uint version, InstanceHandle handle)
	{
		bool flag = runtime.LoadVersion == version;
		if (flag && !runtime.toBeRemove && handle != null && handle.IsValid && handle.Result != null)
		{
			return true;
		}
		if (flag)
		{
			runtime.status = AsyncOperationStatus.Failed;
		}
		if (handle != null && handle.IsValid)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
		}
		return false;
	}

	internal EffectRuntimeItem FireEffect(YooAssetReference pattern, Vector3 effectPos, Quaternion rotate, float realWarningEffectTime = -1f)
	{
		EffectRuntimeItem runtime = GetEffectItem();
		uint version = runtime.LoadVersion;
		GameObject effectRoot = MonoECS.instance.GetRoot(SceneRootType.Effect);
		PrecacheManager.Instance.GetInstanceHandle(pattern.GUID).Completed += (InstanceHandle l) =>
		{
			if (TryAcceptEffectLoad(runtime, version, l))
			{
				l.Result.transform.SetParent(effectRoot?.transform);
				if (TryAcceptEffectLoad(runtime, version, l))
				{
					runtime.OnLoadedNoOwner(l, pattern, effectPos, rotate);
					if (runtime.LoadVersion == version && runtime.status == AsyncOperationStatus.Succeeded && !(runtime.go == null))
					{
						runtime.effectName = pattern.GUID;
						if (realWarningEffectTime > 0f)
						{
							MonoEffectTimer component = runtime.go.GetComponent<MonoEffectTimer>();
							if (component != null)
							{
								component.duration = realWarningEffectTime;
							}
						}
					}
				}
			}
		};
		m_AllEffects.Add(runtime);
		return runtime;
	}

	internal EffectRuntimeItem FireConnectEffect(YooAssetReference pattern, Vector3 effectPos, Quaternion rotate, Transform endPos, Transform startPos)
	{
		EffectRuntimeItem runtime = GetEffectItem();
		uint version = runtime.LoadVersion;
		GameObject effectRoot = MonoECS.instance.GetRoot(SceneRootType.Effect);
		PrecacheManager.Instance.GetInstanceHandle(pattern.GUID).Completed += (InstanceHandle l) =>
		{
			if (TryAcceptEffectLoad(runtime, version, l))
			{
				l.Result.transform.SetParent(effectRoot?.transform);
				if (TryAcceptEffectLoad(runtime, version, l))
				{
					runtime.OnLoadedConnectEffect(l, pattern, effectPos, rotate, endPos, startPos);
					if (runtime.LoadVersion == version && runtime.status == AsyncOperationStatus.Succeeded && !(runtime.go == null))
					{
						runtime.effectName = pattern.GUID;
					}
				}
			}
		};
		m_AllEffects.Add(runtime);
		return runtime;
	}

	internal EffectRuntimeItem FireEffect(EffectParams effectParams)
	{
		Entity targetEntity = effectParams.target.entity;
		EffectRuntimeItem runtime = GetEffectItem();
		uint version = runtime.LoadVersion;
		runtime.timeScale = effectParams.timescale;
		runtime.type = effectParams.type;
		runtime.point1 = effectParams.point1;
		runtime.point1.initRotation = effectParams.initRotation;
		runtime.point1.SetStartTrans(effectParams.target, effectParams.constPointPos);
		if (effectParams.type == EffectDataType.Line || effectParams.type == EffectDataType.ScaleX)
		{
			runtime.point2 = effectParams.point2;
			runtime.point2.SetStartTrans(effectParams.target, effectParams.constPointPos);
		}
		runtime.owner = targetEntity;
		runtime.removeWhenStop = effectParams.removeWhenStop;
		runtime.isChangeWithEntity = effectParams.isChangeWithEntity;
		runtime.xMirror = effectParams.xMirror;
		runtime.isAttach = effectParams.isAttach;
		runtime.ignoreOwnerVisible = effectParams.ignoreOwnerVisible;
		if (effectParams.removeWhenMotionExit)
		{
			runtime.removeWhenMotionExit = effectParams.motioState;
		}
		else
		{
			runtime.removeWhenMotionExit = MotionState.None;
		}
		if (effectParams.removeWhenConfigMotionExit && !string.IsNullOrEmpty(effectParams.configMotionName))
		{
			runtime.removeWhenConfigMotionExit = effectParams.configMotionName;
		}
		else
		{
			runtime.removeWhenConfigMotionExit = null;
		}
		if (!effectParams.ignoreOwnerVisible)
		{
			CompEffect compEffect = targetEntity.GetCompEffect();
			if (compEffect != null && targetEntity.HasCompAbility())
			{
				compEffect.myEffects.Add(runtime);
				runtime.ownerList = compEffect.myEffects;
			}
		}
		GameObject effectRoot = MonoECS.instance.GetRoot(SceneRootType.Effect);
		PrecacheManager.Instance.GetInstanceHandle(effectParams.patternAssetID.GUID).Completed += (InstanceHandle l) =>
		{
			if (TryAcceptEffectLoad(runtime, version, l))
			{
				if (effectParams.playSpace == EffectPlaySpace.UI)
				{
					RectTransform rectTransform = l.Result.transform as RectTransform;
					if (rectTransform == null)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError("UI特效 " + effectParams.patternAssetID.GUID + " 根节点必须是 RectTransform");
						}
						runtime.status = AsyncOperationStatus.Failed;
						PrecacheManager.Instance.ReleaseInstanceHandle(l);
						return;
					}
					RectTransform rectTransform2 = Singleton<NewUIManager>.instance?.UIEffectRoot;
					if (rectTransform2 == null)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError("UIEffectRoot 未设置，UI特效 " + effectParams.patternAssetID.GUID + " 无法挂载");
						}
						runtime.status = AsyncOperationStatus.Failed;
						PrecacheManager.Instance.ReleaseInstanceHandle(l);
						return;
					}
					rectTransform.SetParent(rectTransform2, worldPositionStays: false);
					if (effectParams.uiSiblingOrder >= 0)
					{
						rectTransform.SetSiblingIndex(Mathf.Min(effectParams.uiSiblingOrder, rectTransform.parent.childCount - 1));
					}
					if (!TryAcceptEffectLoad(runtime, version, l))
					{
						return;
					}
					runtime.isUIEffect = true;
					runtime.uiAnchor = effectParams.uiAnchor;
					runtime.uiAnchoredOffset = effectParams.uiAnchoredOffset;
					runtime.uiRespectSafeArea = effectParams.uiRespectSafeArea;
					runtime.uiCustomAnchorPos = effectParams.uiCustomAnchorPos;
					runtime.uiFollowRect = effectParams.uiFollowRect;
					runtime.uiSiblingOrder = effectParams.uiSiblingOrder;
				}
				else
				{
					l.Result.transform.SetParent(effectRoot?.transform);
					if (!TryAcceptEffectLoad(runtime, version, l))
					{
						return;
					}
				}
				runtime.OnLoaded(l, effectParams.patternAssetID);
				if (runtime.LoadVersion == version && runtime.status == AsyncOperationStatus.Succeeded && !(runtime.go == null))
				{
					runtime.effectName = effectParams.patternAssetID.GUID;
					Entity entity = (runtime.owner.IsValid ? runtime.owner : targetEntity);
					if (!effectParams.ignoreOwnerVisible)
					{
						CompEffect compEffect2 = entity.GetCompEffect();
						if (compEffect2 != null)
						{
							runtime.SetOwnerVisible(!compEffect2.EffectsHidden);
						}
					}
					if (effectParams.playSpace == EffectPlaySpace.UI)
					{
						m_UIEffectList.Add(runtime);
						if (!_allUIEffectsVisible && runtime.go != null)
						{
							runtime.go.SetActive(value: false);
						}
					}
					float x = 1f;
					float y = 1f;
					float z = 1f;
					if (effectParams.changeScale)
					{
						ConfigCharacter config = entity.GetConfig();
						if ((object)config != null)
						{
							switch (config.monsterWeigtType)
							{
							case MonsterWeigtType.Normal:
							case MonsterWeigtType.Small:
								x = (y = (z = 1f));
								break;
							case MonsterWeigtType.Middle:
								x = (y = (z = 1.5f));
								break;
							case MonsterWeigtType.Big:
								x = (y = (z = 2f));
								break;
							case MonsterWeigtType.Giant:
								x = (y = (z = 2.5f));
								break;
							}
							runtime.go.transform.localScale = new Vector3(x, y, z);
						}
					}
					if (effectParams.effectRangeEnum != EffectRangeEnum.none)
					{
						switch (effectParams.effectRangeEnum)
						{
						case EffectRangeEnum.circle:
							runtime.go.transform.localScale = effectParams.transformScaleMulBase;
							break;
						case EffectRangeEnum.range:
							runtime.go.transform.localScale = effectParams.transformScaleMulBase;
							break;
						}
						MonoEffectTimer component = runtime.go.GetComponent<MonoEffectTimer>();
						if (component != null)
						{
							component.duration = effectParams.warningEffectTime;
						}
					}
					if (!effectParams.ignoreOwnerVisible && !entity.IsActive() && runtime.status == AsyncOperationStatus.Succeeded)
					{
						runtime.go.SetActive(value: false);
					}
					if (effectParams.exclusivePriority)
					{
						entity.GetCompAbility()?.ApplyEffect(runtime, effectParams.priority);
					}
				}
			}
		};
		m_AllEffects.Add(runtime);
		return runtime;
	}

	internal void RebindAttachedEffects(List<EffectRuntimeItem> effects, Entity oldOwner, Entity newOwner)
	{
		if (effects != null && effects.Count != 0 && newOwner.IsValid)
		{
			for (int i = 0; i < effects.Count; i++)
			{
				RebindAttachedEffect(effects[i], oldOwner, newOwner);
			}
		}
	}

	private void RebindAttachedEffect(EffectRuntimeItem effect, Entity oldOwner, Entity newOwner)
	{
		if (effect == null || effect.toBeRemove || effect.status == AsyncOperationStatus.Failed || effect.owner == newOwner)
		{
			return;
		}
		effect.ownerList?.Remove(effect);
		effect.ownerList = null;
		int num;
		if (oldOwner.IsValid)
		{
			CompAbility compAbility = oldOwner.GetCompAbility();
			if (compAbility != null)
			{
				num = (compAbility.RemoveEffect(effect) ? 1 : 0);
				goto IL_005b;
			}
		}
		num = 0;
		goto IL_005b;
		IL_005b:
		effect.owner = newOwner;
		CompEffect compEffect = null;
		if (!effect.ignoreOwnerVisible)
		{
			CompEffect compEffect2 = newOwner.GetCompEffect();
			if (compEffect2 != null && newOwner.HasCompAbility())
			{
				compEffect = compEffect2;
				compEffect.myEffects.Add(effect);
				effect.ownerList = compEffect.myEffects;
			}
		}
		FindTargetResult target = FindTargetResult.EntityOnly(newOwner);
		effect.point1.RefreshFollowOwner(target);
		if (effect.type == EffectDataType.Line || effect.type == EffectDataType.ScaleX)
		{
			effect.point2.RefreshFollowOwner(target);
		}
		if (num != 0)
		{
			newOwner.GetCompAbility()?.ApplyEffect(effect, effect._priority);
		}
		if (compEffect != null)
		{
			effect.SetOwnerVisible(!compEffect.EffectsHidden);
		}
		effect.SetExternalVisible(visible: true);
		if (effect.status == AsyncOperationStatus.Succeeded)
		{
			effect.Sync(init: true);
		}
	}

	internal void CleanEffect(EffectRuntimeItem effect)
	{
		if (effect.isUIEffect)
		{
			m_UIEffectList.Remove(effect);
		}
		if (effect.owner.IsActive())
		{
			effect.owner.GetCompEffect()?.myEffects.Remove(effect);
		}
		m_AllEffects.Remove(effect);
	}

	public void CleanAllEffect()
	{
		m_UIEffectList.Clear();
		foreach (EffectRuntimeItem allEffect in m_AllEffects)
		{
			ReleaseEffectItem(allEffect);
		}
		m_AllEffects.Clear();
		CleanAllPlayEffects();
		ClearLegacySpatialEffectRecords();
	}

	public void ClearAllNoBindEffects()
	{
		for (int num = m_AllEffects.Count - 1; num >= 0; num--)
		{
			EffectRuntimeItem effectRuntimeItem = m_AllEffects[num];
			if (!effectRuntimeItem.isAttach)
			{
				ReleaseEffectItem(effectRuntimeItem);
				m_AllEffects.Remove(effectRuntimeItem);
			}
		}
		ClearAllNoBindPlayEffects();
	}

	public void SetAllUIEffectsVisible(bool visible)
	{
		_allUIEffectsVisible = visible;
		for (int i = 0; i < m_UIEffectList.Count; i++)
		{
			EffectRuntimeItem effectRuntimeItem = m_UIEffectList[i];
			effectRuntimeItem.hiddenByUI = !visible;
			effectRuntimeItem.RefreshVisibility();
		}
		SetAllPlayEffectsUIVisible(visible);
	}

	internal void PlayNewEffect(ActionPlayEffectBase action, ActionMemory memory)
	{
		if (TryBuildRequest(action, memory, out var request))
		{
			Play(request);
			YooAssetReference yooAssetReference = ResolveHitMaterialEffect(action, memory);
			if (yooAssetReference != null && yooAssetReference.RuntimeKeyIsValid())
			{
				request.effectReference = yooAssetReference;
				Play(request);
			}
		}
	}

	private void Play(EffectPlayRequest request)
	{
		EffectAnchor anchor = default;
		if (!request.isUIEffect && !TryResolveAnchor(request, out anchor))
		{
			LogInvalidAnchor(request);
			return;
		}
		EffectRuntimeItem effectItem = GetEffectItem();
		effectItem.owner = request.runtimeOwner;
		effectItem.timeScale = request.timeScale;
		effectItem.removeWhenStop = request.stopBehavior == EffectStopBehavior.ClearImmediately;
		effectItem.type = EffectDataType.Point;
		effectItem.point1 = new EffectPoint
		{
			type = EffectPoint.EffectPointType.ConstPoint
		};
		if (!request.isUIEffect)
		{
			effectItem.point1.SetConstTrans(anchor.position + request.positionOffset, ResolveInitialRotation(request, anchor));
		}
		PlayEffectRuntime entry = new PlayEffectRuntime(request, effectItem);
		_effects.Add(entry);
		request.ability?.playEffects.Add(effectItem);
		if (!request.isDetached)
		{
			request.lifetimeEntity.GetCompEffect()?.playEffects.Add(effectItem);
		}
		PrecacheManager.Instance.GetInstanceHandle(request.effectReference.GUID).Completed += (InstanceHandle loadedHandle) =>
		{
			OnLoaded(entry, loadedHandle);
		};
	}

	private void OnLoaded(PlayEffectRuntime entry, InstanceHandle handle)
	{
		EffectRuntimeItem runtime = entry.runtime;
		if (runtime.toBeRemove)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			runtime.status = AsyncOperationStatus.Failed;
			return;
		}
		if (entry.request.isUIEffect)
		{
			RectTransform rectTransform = handle.Result.transform as RectTransform;
			RectTransform rectTransform2 = Singleton<NewUIManager>.instance?.UIEffectRoot;
			if (rectTransform == null || rectTransform2 == null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
				runtime.status = AsyncOperationStatus.Failed;
				return;
			}
			rectTransform.SetParent(rectTransform2, worldPositionStays: false);
			if (entry.request.uiSiblingOrder >= 0)
			{
				rectTransform.SetSiblingIndex(Mathf.Min(entry.request.uiSiblingOrder, rectTransform.parent.childCount - 1));
			}
		}
		else if (entry.request.isCameraEffect)
		{
			if (!TryResolveAnchor(entry.request, out var anchor) || anchor.transform == null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
				runtime.status = AsyncOperationStatus.Failed;
				return;
			}
			handle.Result.transform.SetParent(anchor.transform, worldPositionStays: false);
		}
		else
		{
			GameObject root = MonoECS.instance.GetRoot(SceneRootType.Effect);
			handle.Result.transform.SetParent(root?.transform);
		}
		runtime.OnLoaded(handle, entry.request.effectReference);
		runtime.effectName = entry.request.effectReference.GUID;
		if (!entry.request.isDetached)
		{
			CompEffect compEffect = entry.request.lifetimeEntity.GetCompEffect();
			if (compEffect != null)
			{
				runtime.SetOwnerVisible(!compEffect.EffectsHidden);
			}
		}
		if (runtime.status == AsyncOperationStatus.Succeeded)
		{
			if (entry.request.isUIEffect)
			{
				ApplyUITransform(entry);
			}
			else if (entry.request.isCameraEffect)
			{
				ApplyCameraTransform(entry, isInitial: true);
			}
			else
			{
				ApplyWorldTransform(entry, isInitial: true);
			}
			SetPlayEffectUIVisible(entry, _allUIEffectsVisible);
		}
	}

	private void FixedUpdatePlayEffects()
	{
		for (int i = 0; i < _effects.Count; i++)
		{
			PlayEffectRuntime entry = _effects[i];
			UpdateLifecycle(entry);
			AdvanceOwnerEffectTime(entry);
		}
	}

	private void LateUpdatePlayEffects()
	{
		for (int i = 0; i < _effects.Count; i++)
		{
			PlayEffectRuntime playEffectRuntime = _effects[i];
			if (playEffectRuntime.runtime.status == AsyncOperationStatus.Succeeded && !playEffectRuntime.runtime.toBeRemove)
			{
				if (playEffectRuntime.request.isUIEffect)
				{
					ApplyUITransform(playEffectRuntime);
				}
				else if (playEffectRuntime.request.isCameraEffect)
				{
					ApplyCameraTransform(playEffectRuntime, isInitial: false);
				}
				else
				{
					ApplyWorldTransform(playEffectRuntime, isInitial: false);
				}
			}
		}
	}

	private void UpdatePlayEffects()
	{
		for (int num = _effects.Count - 1; num >= 0; num--)
		{
			PlayEffectRuntime playEffectRuntime = _effects[num];
			SimulateOwnerEffect(playEffectRuntime);
			if (playEffectRuntime.runtime.isDone)
			{
				ReleasePlayEffect(playEffectRuntime);
				_effects.RemoveAt(num);
			}
		}
	}

	internal void StopAbilityEffects(List<EffectRuntimeItem> effects)
	{
		if (effects != null)
		{
			for (int i = 0; i < effects.Count; i++)
			{
				RequestStop(effects[i]);
			}
		}
	}

	private void CleanAllPlayEffects()
	{
		for (int i = 0; i < _effects.Count; i++)
		{
			RequestStop(_effects[i].runtime, clearImmediately: true);
		}
	}

	private void ClearAllNoBindPlayEffects()
	{
		for (int i = 0; i < _effects.Count; i++)
		{
			if (_effects[i].request.isDetached)
			{
				RequestStop(_effects[i].runtime, clearImmediately: true);
			}
		}
	}

	private void SetAllPlayEffectsUIVisible(bool visible)
	{
		for (int i = 0; i < _effects.Count; i++)
		{
			SetPlayEffectUIVisible(_effects[i], visible);
		}
	}

	private static void SetPlayEffectUIVisible(PlayEffectRuntime entry, bool visible)
	{
		if (entry.request.isUIVisibilityControlled)
		{
			entry.runtime.hiddenByUI = !visible;
			entry.runtime.RefreshVisibility();
		}
	}

	private static void UpdateLifecycle(PlayEffectRuntime entry)
	{
		if (!entry.runtime.toBeRemove && entry.request.checkMotionExit)
		{
			Entity lifetimeEntity = entry.request.lifetimeEntity;
			if (!lifetimeEntity.IsValid || !lifetimeEntity.TryGetCompMotion(out CompMotion component))
			{
				RequestStop(entry.runtime);
			}
			else if (entry.request.removeWhenMotionExit && component.curMotionState != entry.request.motionState)
			{
				RequestStop(entry.runtime);
			}
			else if (entry.request.removeWhenConfigMotionExit && component.layer0PeakConfig != null && !string.Equals(component.layer0PeakConfig.name, entry.request.configMotionName, StringComparison.Ordinal))
			{
				RequestStop(entry.runtime);
			}
		}
	}

	private static void AdvanceOwnerEffectTime(PlayEffectRuntime entry)
	{
		if (entry.runtime.status == AsyncOperationStatus.Succeeded && entry.runtime.timeScale == TimeScale.Owner && entry.request.timeScaleOwner.TryGetCompTime(out CompTime component))
		{
			float num = (component.effectSpeedChange ? component.motionFixedDeltaTime : component.motionFixedDeltaTimeOS);
			entry.runtime.lastTime = entry.runtime.time;
			entry.runtime.time += num;
		}
	}

	private void SimulateOwnerEffect(PlayEffectRuntime entry)
	{
		EffectRuntimeItem runtime = entry.runtime;
		if (runtime.status == AsyncOperationStatus.Succeeded && runtime.timeScale == TimeScale.Owner && entry.request.timeScaleOwner.TryGetCompTime(out CompTime component))
		{
			float num = Mathf.Lerp(runtime.lastTime, runtime.time, component.isFrameHalt() ? 1f : _updateLerp);
			float num2 = num - runtime.lastSimulateTime;
			if (!(num2 <= 0f))
			{
				runtime.Simulate(num2, restart: false);
				runtime.lastSimulateTime = num;
			}
		}
	}

	private static void RequestStop(EffectRuntimeItem runtime, bool clearImmediately = false)
	{
		if (runtime != null)
		{
			if (clearImmediately)
			{
				runtime.removeWhenStop = true;
			}
			runtime.SetToBeRemove();
		}
	}

	private void ReleasePlayEffect(PlayEffectRuntime entry)
	{
		entry.request.ability?.playEffects.Remove(entry.runtime);
		if (entry.request.lifetimeEntity.IsValid)
		{
			entry.request.lifetimeEntity.GetCompEffect()?.playEffects.Remove(entry.runtime);
		}
		ReleaseEffectItem(entry.runtime);
	}

	private static void ApplyCameraTransform(PlayEffectRuntime entry, bool isInitial)
	{
		EffectRuntimeItem runtime = entry.runtime;
		if (runtime.go == null || !TryResolveAnchor(entry.request, out var anchor) || anchor.transform == null)
		{
			if (!isInitial && entry.request.invalidAnchorRule == EffectInvalidAnchorRule.StopEffect)
			{
				RequestStop(runtime);
			}
			return;
		}
		Transform transform = runtime.go.transform;
		if (transform.parent != anchor.transform)
		{
			transform.SetParent(anchor.transform, worldPositionStays: false);
		}
		if (entry.request.changeWithAnchorVisibility)
		{
			runtime.hiddenByAnchor = !anchor.transform.gameObject.activeInHierarchy;
			runtime.RefreshVisibility();
		}
		if (isInitial)
		{
			transform.localPosition = entry.request.positionOffset;
			transform.rotation = ResolveInitialRotation(entry.request, anchor);
			transform.localScale = ResolveScale(entry.request, anchor);
			return;
		}
		switch (entry.request.rotationUpdateRule)
		{
		case EffectRotationUpdateRule.FollowLogicDirection:
			transform.rotation = ApplyRotationOffset(entry.request, GetEntityRotation(entry.request.logicDirectionEntity));
			break;
		case EffectRotationUpdateRule.FollowFunctionRotation:
			transform.rotation = ApplyRotationOffset(entry.request, entry.request.action.rotationFunction?.Return(entry.request.memory) ?? Quaternion.identity);
			break;
		}
		if (entry.request.scaleRule == EffectScaleRule.MultiplyPlayPointScale)
		{
			transform.localScale = ResolveScale(entry.request, anchor);
		}
	}

	private static void ApplyWorldTransform(PlayEffectRuntime entry, bool isInitial)
	{
		EffectRuntimeItem runtime = entry.runtime;
		if (runtime.go == null)
		{
			return;
		}
		EffectPlayRequest request = entry.request;
		bool num = isInitial || request.positionUpdateRule != EffectPositionUpdateRule.None || request.rotationUpdateRule == EffectRotationUpdateRule.FollowPlayPointRotation || request.scaleRule == EffectScaleRule.MultiplyPlayPointScale || request.changeWithAnchorVisibility;
		EffectAnchor anchor = default;
		if (num && !TryResolveAnchor(request, out anchor))
		{
			if (!isInitial && request.invalidAnchorRule == EffectInvalidAnchorRule.StopEffect)
			{
				RequestStop(runtime);
			}
			return;
		}
		if (request.changeWithAnchorVisibility && anchor.transform != null)
		{
			runtime.hiddenByAnchor = !anchor.transform.gameObject.activeInHierarchy;
			runtime.RefreshVisibility();
		}
		if (isInitial || request.positionUpdateRule != EffectPositionUpdateRule.None)
		{
			Vector3 vector = anchor.position + request.positionOffset;
			runtime.go.transform.position = ((request.positionUpdateRule == EffectPositionUpdateRule.SmoothFollow && !isInitial) ? Vector3.Lerp(runtime.go.transform.position, vector, request.positionFollowSpeed * Time.deltaTime) : vector);
		}
		if (isInitial)
		{
			runtime.go.transform.rotation = ResolveInitialRotation(request, anchor);
			runtime.go.transform.localScale = ResolveScale(request, anchor);
			return;
		}
		switch (request.rotationUpdateRule)
		{
		case EffectRotationUpdateRule.FollowPlayPointRotation:
			runtime.go.transform.rotation = ApplyRotationOffset(request, anchor.rotation);
			break;
		case EffectRotationUpdateRule.FollowLogicDirection:
			runtime.go.transform.rotation = ApplyRotationOffset(request, GetEntityRotation(request.logicDirectionEntity));
			break;
		case EffectRotationUpdateRule.FollowFunctionRotation:
			runtime.go.transform.rotation = ApplyRotationOffset(request, request.action.rotationFunction?.Return(request.memory) ?? Quaternion.identity);
			break;
		}
		if (request.scaleRule == EffectScaleRule.MultiplyPlayPointScale)
		{
			runtime.go.transform.localScale = ResolveScale(request, anchor);
		}
	}

	private static void ApplyUITransform(PlayEffectRuntime entry)
	{
		if (!(entry.runtime.go == null) && entry.runtime.go.transform is RectTransform rectTransform)
		{
			EffectPlayRequest request = entry.request;
			Vector2 vector = GetUIAnchor(request.uiAnchor, request.uiCustomAnchorPosition);
			if (request.uiRespectSafeArea)
			{
				Rect safeArea = Screen.safeArea;
				vector = new Vector2(safeArea.xMin / (float)Screen.width + vector.x * safeArea.width / (float)Screen.width, safeArea.yMin / (float)Screen.height + vector.y * safeArea.height / (float)Screen.height);
			}
			rectTransform.anchorMin = vector;
			rectTransform.anchorMax = vector;
			rectTransform.anchoredPosition = request.uiAnchoredOffset;
			rectTransform.localRotation = ResolveInitialRotation(request, default);
			rectTransform.localScale = ResolveScale(request, default);
		}
	}

	private static bool TryResolveAnchor(EffectPlayRequest request, out EffectAnchor anchor)
	{
		anchor = default;
		switch (request.action.playPointType)
		{
		case EffectPlayPointType.CharacterFoot:
		{
			if (!request.anchorEntity.TryGetCompTransform(out CompTransform component))
			{
				return false;
			}
			Transform rootTransform = request.anchorEntity.GetRootTransform();
			anchor = new EffectAnchor(component.physicsPosition, (rootTransform != null) ? rootTransform.rotation : GetEntityRotation(request.anchorEntity), (rootTransform != null) ? rootTransform.lossyScale : Vector3.one, rootTransform);
			return true;
		}
		case EffectPlayPointType.AttachPoint:
		{
			MonoEntity mono = request.anchorEntity.GetMono();
			if (mono == null)
			{
				return false;
			}
			AttachPoint attachPointAll = mono.GetAttachPointAll(request.action.attachPoint);
			Transform transform2 = ((attachPointAll.forward != null) ? attachPointAll.forward : attachPointAll.transform);
			if (transform2 == null)
			{
				return false;
			}
			if (attachPointAll.forward != null)
			{
				attachPointAll.forward.position = attachPointAll.GetPos();
			}
			anchor = new EffectAnchor(transform2.position, transform2.rotation, transform2.lossyScale, transform2);
			return true;
		}
		case EffectPlayPointType.HitPoint:
		{
			Entity entity = request.memory.target.entity;
			if (!entity.IsValid)
			{
				return false;
			}
			Vector3 touchPos = request.memory.target.TouchPos;
			Transform rootTransform2 = entity.GetRootTransform();
			if (rootTransform2 != null)
			{
				touchPos.z = rootTransform2.position.z;
			}
			Quaternion rotation = (request.memory.target.TouchForward.isZero() ? Quaternion.identity : Quaternion.LookRotation(request.memory.target.TouchForward));
			anchor = new EffectAnchor(touchPos, rotation, Vector3.one, null);
			return true;
		}
		case EffectPlayPointType.FunctionPosition:
			if (request.action.positionFunction == null)
			{
				return false;
			}
			anchor = new EffectAnchor(request.action.positionFunction.Return(request.memory), Quaternion.identity, Vector3.one, null);
			return true;
		case EffectPlayPointType.FunctionTransform:
		{
			Transform transform3 = request.action.transformFunction?.Return(request.memory);
			if (transform3 == null)
			{
				return false;
			}
			anchor = new EffectAnchor(transform3.position, transform3.rotation, transform3.lossyScale, transform3);
			return true;
		}
		case EffectPlayPointType.CurrentCamera:
		{
			Camera camera = MonoECS.instance?.entityLocal?.compCamera?.mainCamera;
			if (camera == null)
			{
				return false;
			}
			Transform transform = camera.transform;
			anchor = new EffectAnchor(transform.position, transform.rotation, transform.lossyScale, transform);
			return true;
		}
		default:
			return false;
		}
	}

	private static Quaternion ResolveInitialRotation(EffectPlayRequest request, EffectAnchor anchor)
	{
		Quaternion rotation = request.action.initialRotationRule switch
		{
			EffectInitialRotationRule.PlayPointRotation => anchor.rotation, 
			EffectInitialRotationRule.LogicDirection => GetEntityRotation(request.logicDirectionEntity), 
			EffectInitialRotationRule.FunctionRotation => request.action.initialRotationFunction?.Return(request.memory) ?? Quaternion.identity, 
			_ => Quaternion.identity, 
		};
		return ApplyRotationOffset(request, rotation);
	}

	private static Quaternion ApplyRotationOffset(EffectPlayRequest request, Quaternion rotation)
	{
		return rotation * Quaternion.Euler(request.action.rotationOffset + request.randomRotationOffset);
	}

	private static Vector3 ResolveScale(EffectPlayRequest request, EffectAnchor anchor)
	{
		Vector3 vector = request.action.baseScale;
		switch (request.scaleRule)
		{
		case EffectScaleRule.MultiplyPlayPointScale:
			vector = Vector3.Scale(vector, anchor.scale);
			break;
		case EffectScaleRule.MultiplyEntitySize:
			vector *= GetEntitySizeScale(request.anchorEntity);
			break;
		}
		return vector;
	}

	private static Quaternion GetEntityRotation(Entity entity)
	{
		Transform modelTrans = entity.GetModelTrans();
		if (modelTrans != null)
		{
			return modelTrans.rotation;
		}
		Transform rootTransform = entity.GetRootTransform();
		if (!(rootTransform != null))
		{
			return Quaternion.identity;
		}
		return rootTransform.rotation;
	}

	private static float GetEntitySizeScale(Entity entity)
	{
		ConfigCharacter config = entity.GetConfig();
		if (config == null)
		{
			return 1f;
		}
		switch (config.monsterWeigtType)
		{
		case MonsterWeigtType.Normal:
		case MonsterWeigtType.Small:
			return 1f;
		case MonsterWeigtType.Middle:
			return 1.5f;
		case MonsterWeigtType.Big:
			return 2f;
		case MonsterWeigtType.Giant:
			return 2.5f;
		default:
			return 1f;
		}
	}

	private static Vector2 GetUIAnchor(EffectUIPlayPoint anchor, Vector2 custom)
	{
		return anchor switch
		{
			EffectUIPlayPoint.TopLeft => new Vector2(0f, 1f), 
			EffectUIPlayPoint.TopCenter => new Vector2(0.5f, 1f), 
			EffectUIPlayPoint.TopRight => new Vector2(1f, 1f), 
			EffectUIPlayPoint.MiddleLeft => new Vector2(0f, 0.5f), 
			EffectUIPlayPoint.Center => new Vector2(0.5f, 0.5f), 
			EffectUIPlayPoint.MiddleRight => new Vector2(1f, 0.5f), 
			EffectUIPlayPoint.BottomLeft => new Vector2(0f, 0f), 
			EffectUIPlayPoint.BottomCenter => new Vector2(0.5f, 0f), 
			EffectUIPlayPoint.BottomRight => new Vector2(1f, 0f), 
			EffectUIPlayPoint.Custom => custom, 
			_ => new Vector2(0.5f, 0.5f), 
		};
	}

	private static bool TryBuildRequest(ActionPlayEffectBase action, ActionMemory memory, out EffectPlayRequest request)
	{
		request = default;
		YooAssetReference effectReference = action.effectReferenceAssetID;
		YooAssetReference leftEffectReference = action.leftEffectReferenceAssetID;
		if (action.useSkinBattleMapping)
		{
			RemapEffectReferences(memory, ref effectReference, ref leftEffectReference);
		}
		Entity entityReference = memory.GetEntityReference(action.directionEntity);
		if (action.useDirectionVariant && entityReference.IsFaceLeft() && leftEffectReference != null && leftEffectReference.RuntimeKeyIsValid())
		{
			effectReference = leftEffectReference;
		}
		if (effectReference == null || !effectReference.RuntimeKeyIsValid())
		{
			return false;
		}
		request = new EffectPlayRequest
		{
			action = action,
			memory = memory,
			effectReference = effectReference,
			anchorEntity = memory.GetEntityReference(action.anchorEntity),
			logicDirectionEntity = memory.GetEntityReference(action.logicDirectionEntity),
			timeScaleOwner = memory.owner,
			timeScale = action.timeScale,
			positionOffset = action.positionOffset,
			positionUpdateRule = action.positionUpdateRule,
			positionFollowSpeed = action.positionFollowSpeed,
			invalidAnchorRule = action.invalidAnchorRule,
			rotationUpdateRule = action.rotationUpdateRule,
			scaleRule = action.scaleRule,
			changeWithAnchorVisibility = action.changeWithAnchorVisibility,
			isUIEffect = (action.playPointType == EffectPlayPointType.UIAnchor),
			isCameraEffect = (action.playPointType == EffectPlayPointType.CurrentCamera),
			isUIVisibilityControlled = (action.playPointType == EffectPlayPointType.UIAnchor || action.playPointType == EffectPlayPointType.CurrentCamera),
			uiAnchor = action.uiAnchor,
			uiCustomAnchorPosition = action.uiCustomAnchorPosition,
			uiAnchoredOffset = action.uiAnchoredOffset,
			uiRespectSafeArea = action.uiRespectSafeArea,
			uiSiblingOrder = action.uiSiblingOrder,
			stopBehavior = EffectStopBehavior.StopEmissionAndWait
		};
		if (action.useRandomRotation)
		{
			request.randomRotationOffset = new Vector3(UnityEngine.Random.Range(action.randomRotationMin.x, action.randomRotationMax.x), UnityEngine.Random.Range(action.randomRotationMin.y, action.randomRotationMax.y), UnityEngine.Random.Range(action.randomRotationMin.z, action.randomRotationMax.z));
		}
		if (!(action is ActionPlayOnceEffect actionPlayOnceEffect))
		{
			if (!(action is ActionPlayLoopEffect actionPlayLoopEffect))
			{
				return false;
			}
			if (memory.ability == null)
			{
				return false;
			}
			request.ability = memory.ability;
			request.lifetimeEntity = memory.ability.owner;
			request.runtimeOwner = request.lifetimeEntity;
			request.stopBehavior = actionPlayLoopEffect.stopBehavior;
		}
		else
		{
			request.isDetached = actionPlayOnceEffect.ownership == EffectOnceOwnership.Detached;
			request.lifetimeEntity = (request.isDetached ? default(Entity) : memory.GetEntityReference(actionPlayOnceEffect.lifetimeEntity));
			request.runtimeOwner = (request.isDetached ? request.anchorEntity : request.lifetimeEntity);
			request.checkMotionExit = !request.isDetached;
			request.removeWhenMotionExit = actionPlayOnceEffect.removeWhenMotionExit;
			request.removeWhenConfigMotionExit = actionPlayOnceEffect.removeWhenConfigMotionExit;
			request.motionState = ((actionPlayOnceEffect.motionState != MotionState.None) ? actionPlayOnceEffect.motionState : (request.lifetimeEntity.GetCompMotion()?.curMotionState ?? MotionState.None));
			request.configMotionName = ((!string.IsNullOrEmpty(actionPlayOnceEffect.configMotionName)) ? actionPlayOnceEffect.configMotionName : request.lifetimeEntity.GetCompMotion()?.layer0PeakConfig?.name);
			request.removeWhenConfigMotionExit &= !string.IsNullOrEmpty(request.configMotionName);
			request.stopBehavior = actionPlayOnceEffect.stopBehavior;
			if (!request.isDetached && !request.lifetimeEntity.IsValid)
			{
				return false;
			}
		}
		return true;
	}

	private static void RemapEffectReferences(ActionMemory memory, ref YooAssetReference effectReference, ref YooAssetReference leftEffectReference)
	{
		if (TryGetBattleMapping(memory.owner, out var battleMapping) || TryGetBattleMapping(memory.caster, out battleMapping) || (memory.owner != default(Entity) && TryGetBattleMapping(memory.owner.GetCaster(), out battleMapping)) || (memory.caster != default(Entity) && TryGetBattleMapping(memory.caster.GetCaster(), out battleMapping)) || TryGetBattleMapping(memory.target.entity, out battleMapping) || (memory.target.entity != default(Entity) && TryGetBattleMapping(memory.target.entity.GetCaster(), out battleMapping)))
		{
			if (effectReference != null && battleMapping.effects.TryGetValue(effectReference, out var value) && value != null && value.IsValid())
			{
				effectReference = value;
			}
			if (leftEffectReference != null && battleMapping.effects.TryGetValue(leftEffectReference, out var value2) && value2 != null && value2.IsValid())
			{
				leftEffectReference = value2;
			}
		}
	}

	private static bool TryGetBattleMapping(Entity entity, out ConfigSkinBattleMapping battleMapping)
	{
		battleMapping = ((!(entity != default(Entity))) ? null : entity.GetCompBehave()?.ConfigSkinBattleMapping);
		return battleMapping?.effects != null;
	}

	private static YooAssetReference ResolveHitMaterialEffect(ActionPlayEffectBase action, ActionMemory memory)
	{
		if (!action.extraHitMaterialEffect || !memory.target.entity.IsValid || !GameLoader.meta.hitEffectComparisonTable.tableAssetID.TryGetValue(action.extraEffectSheet, out var value))
		{
			return null;
		}
		Entity entity = memory.target.entity;
		ConfigCharacter config = entity.GetConfig();
		CompAbility compAbility = entity.GetCompAbility();
		if (config == null || compAbility == null)
		{
			return null;
		}
		bool flag = ((config.postureType == PostureType.Multi) ? (!compAbility.IsWeak) : (compAbility.posture > 0));
		if ((entity.GetHitMaterial() < HitMaterial.Erosion_Red) & flag)
		{
			return null;
		}
		if (!value.TryGetValue(entity.GetHitMaterial(), out var value2))
		{
			return null;
		}
		return value2;
	}

	private static void LogInvalidAnchor(EffectPlayRequest request)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"新版特效播放点无效：{request.action.playPointType}，特效 {request.effectReference.GUID} 未播放。");
		}
	}

	internal bool TryAdmitLegacySpatialEffect(YooAssetReference finalEffectReference, Vector2 position)
	{
		if (!EnableSpatialPlayLimit || finalEffectReference == null || SpatialPlayMaxCount <= 0 || SpatialPlayRadius <= 0f || SpatialPlayWindowSeconds <= 0f)
		{
			return true;
		}
		string gUID = finalEffectReference.GUID;
		if (string.IsNullOrEmpty(gUID))
		{
			return true;
		}
		List<RecentSpatialEffectPlay> value = null;
		if (_recentSpatialEffectPlays == null || !_recentSpatialEffectPlays.TryGetValue(gUID, out value))
		{
			if (!finalEffectReference.RuntimeKeyIsValid())
			{
				return true;
			}
			if (_recentSpatialEffectPlays == null)
			{
				_recentSpatialEffectPlays = new Dictionary<string, List<RecentSpatialEffectPlay>>();
			}
			value = new List<RecentSpatialEffectPlay>();
			_recentSpatialEffectPlays.Add(gUID, value);
		}
		float unscaledTime = Time.unscaledTime;
		int num = 0;
		bool flag = false;
		for (int num2 = value.Count - 1; num2 >= 0; num2--)
		{
			RecentSpatialEffectPlay recentSpatialEffectPlay = value[num2];
			if (recentSpatialEffectPlay.expireAt <= unscaledTime)
			{
				int index = value.Count - 1;
				value[num2] = value[index];
				value.RemoveAt(index);
			}
			else if (!flag && (recentSpatialEffectPlay.position - position).sqrMagnitude <= SpatialPlayRadiusSqr)
			{
				num++;
				flag = num >= SpatialPlayMaxCount;
			}
		}
		if (flag)
		{
			return false;
		}
		value.Add(new RecentSpatialEffectPlay
		{
			position = position,
			expireAt = unscaledTime + SpatialPlayWindowSeconds
		});
		return true;
	}

	private void ClearLegacySpatialEffectRecords()
	{
		_recentSpatialEffectPlays?.Clear();
	}
}
