using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

[DisallowMultipleComponent]
public sealed class SummerRaceCombatPresentationComEffectSink : MonoBehaviour, ISummerRaceCombatPresentationSink
{
	private readonly struct TimedFxEntry(GameObject instance, float endTime, string path)
	{
		public readonly GameObject Instance = instance;

		public readonly float EndTime = endTime;

		public readonly string Path = path ?? string.Empty;
	}

	private readonly struct EffectPlayRequest(string path, bool loop, bool attachToMount, bool attachToSource, bool attachToTarget, bool attachToProjectile, float explicitLifetimeSeconds = 0f)
	{
		public readonly string Path = path ?? string.Empty;

		public readonly bool Loop = loop;

		public readonly bool AttachToMount = attachToMount;

		public readonly bool AttachToSource = attachToSource;

		public readonly bool AttachToTarget = attachToTarget;

		public readonly bool AttachToProjectile = attachToProjectile;

		public readonly float ExplicitLifetimeSeconds = explicitLifetimeSeconds;
	}

	private readonly struct RoutedEffectEntry(EffectPlayRequest request, bool stopLoop)
	{
		public readonly EffectPlayRequest Request = request;

		public readonly bool StopLoop = stopLoop;
	}

	private sealed class ElectricNetLoopState
	{
		public string Path = string.Empty;

		public string LoopKey = string.Empty;

		public readonly HashSet<string> SourceSlotClaims = new HashSet<string>(StringComparer.Ordinal);

		public readonly Dictionary<string, float> SourceSlotExpireAt = new Dictionary<string, float>(StringComparer.Ordinal);
	}

	private const string EffectPathRoot = "summerrace/effect/";

	private const float EffectLifetimeSafetyTail = 0.08f;

	private const string ComEffectBundlePrefix = "comeffect/";

	private const int DefaultOneShotPoolSize = 2;

	private const int BodyBand = 0;

	private const int WeaponEquipEffectBackBand = 1;

	private const int ProjectileBand = 2;

	private const int WeaponEquipBand = 3;

	private const int WeaponEquipEffectFrontBand = 4;

	private const int BodyAuraBand = 5;

	private const string MachineGunFxPath = "summerrace/effect/fx_summerrace_machinegun";

	private const string HookFxPath = "summerrace/effect/fx_summerrace_hook";

	private const string WeaponOverloadFxPath = "effect/summerrace/fx_SummerRace_Overh";

	private const string WeaponOverloadBundleName = "comeffect/effect/summerrace/fx_summerrace_overheat.ys";

	private const float ShieldEndOneShotLifetimeSeconds = 1f;

	private const float DefaultOneShotLifetimeSeconds = 1f;

	private static readonly Vector3 ShieldCenterAutoLocalPositionLight = new Vector3(0.18f, 0.3f, 0f);

	private static readonly Quaternion ShieldCenterAutoLocalRotationLight = Quaternion.Euler(0f, 0f, 0f);

	private static readonly Vector3 ShieldCenterAutoLocalScaleLight = new Vector3(1f, 1f, 1f);

	private static readonly Vector3 ShieldCenterAutoLocalPositionMedium = new Vector3(0.3f, 0.45f, 0f);

	private static readonly Quaternion ShieldCenterAutoLocalRotationMedium = Quaternion.Euler(0f, 0f, 0f);

	private static readonly Vector3 ShieldCenterAutoLocalScaleMedium = new Vector3(1f, 1f, 1f);

	private static readonly Vector3 ShieldCenterAutoLocalPositionHeavy = new Vector3(0.23f, 0.3f, 0f);

	private static readonly Quaternion ShieldCenterAutoLocalRotationHeavy = Quaternion.Euler(0f, 180f, 0f);

	private static readonly Vector3 ShieldCenterAutoLocalScaleHeavy = new Vector3(0.85f, 0.85f, 0.85f);

	private const string ShieldEffectSpriteLightPath = "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Light_Effect.png";

	private const string ShieldEffectSpriteMediumPath = "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Medium_Effect.png";

	private const string ShieldEffectSpriteHeavyPath = "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Heavy_Effect.png";

	[SerializeField]
	private bool verboseLog;

	private readonly List<TimedFxEntry> timedEffects = new List<TimedFxEntry>(32);

	private readonly Dictionary<string, GameObject> activeLoopEffects = new Dictionary<string, GameObject>(16);

	private readonly Dictionary<string, GameObject> effectPrefabCache = new Dictionary<string, GameObject>(32, StringComparer.Ordinal);

	private readonly Dictionary<string, Queue<GameObject>> oneShotEffectPool = new Dictionary<string, Queue<GameObject>>(16, StringComparer.Ordinal);

	private readonly HashSet<string> warmedOneShotPaths = new HashSet<string>(StringComparer.Ordinal);

	private readonly Dictionary<Renderer, int> effectAuthoredSortingOrderCache = new Dictionary<Renderer, int>(64);

	private readonly List<Renderer> effectRenderersScratch = new List<Renderer>(12);

	private readonly Dictionary<SummerRaceBodyType, Sprite> shieldEffectSpriteCache = new Dictionary<SummerRaceBodyType, Sprite>(3);

	private Transform effectRoot;

	private static readonly Dictionary<string, int> OneShotPoolWarmupSizes = new Dictionary<string, int>(StringComparer.Ordinal)
	{
		{ "summerrace/effect/fx_summerrace_machinegun", 6 },
		{ "summerrace/effect/fx_summerrace_rocketlauncher_baozha_1", 4 },
		{ "summerrace/effect/fx_summerrace_scattershel_baozha", 4 },
		{ "summerrace/effect/fx_summerrace_boxing", 4 },
		{ "summerrace/effect/fx_summerrace_electricnet", 4 }
	};

	private static readonly Dictionary<string, RoutedEffectEntry> WeaponEffectRouteTable = new Dictionary<string, RoutedEffectEntry>(StringComparer.Ordinal)
	{
		{
			BuildRouteKey(WeaponKind.MachineGun.ToString(), SummerRacePresentationPhase.Fired),
			BuildOneShotMountRoute("fx_summerrace_machinegun", 0.12f)
		},
		{
			BuildRouteKey(WeaponKind.RocketLauncher.ToString(), SummerRacePresentationPhase.Fired),
			BuildOneShotMountRoute("fx_summerrace_rocketlauncher")
		},
		{
			BuildRouteKey(WeaponKind.RocketLauncher.ToString(), SummerRacePresentationPhase.Impact),
			BuildOneShotTargetRoute("fx_summerrace_rocketlauncher_baozha_1")
		},
		{
			BuildRouteKey(WeaponKind.ScatterShell.ToString(), SummerRacePresentationPhase.Fired),
			BuildOneShotMountRoute("fx_summerrace_scattershel")
		},
		{
			BuildRouteKey(WeaponKind.ScatterShell.ToString(), SummerRacePresentationPhase.Impact),
			BuildOneShotTargetRoute("fx_summerrace_scattershel_baozha")
		},
		{
			BuildRouteKey(WeaponKind.LaserCannon.ToString(), SummerRacePresentationPhase.Fired),
			BuildOneShotMountRoute("fx_summerrace_lasercannon_juqi")
		},
		{
			BuildRouteKey(WeaponKind.LaserCannon.ToString(), SummerRacePresentationPhase.Impact),
			BuildOneShotMountRoute("fx_summerrace_lasercannon")
		},
		{
			BuildRouteKey(WeaponKind.RotatingSaw.ToString(), SummerRacePresentationPhase.Activated),
			BuildLoopMountRoute("fx_summerrace_rotatingsaw", stopLoop: false)
		},
		{
			BuildRouteKey(WeaponKind.RotatingSaw.ToString(), SummerRacePresentationPhase.ActiveExpired),
			BuildLoopMountRoute("fx_summerrace_rotatingsaw", stopLoop: true)
		}
	};

	private static readonly Dictionary<string, RoutedEffectEntry> EquipEffectRouteTable = new Dictionary<string, RoutedEffectEntry>(StringComparer.Ordinal)
	{
		{
			BuildRouteKey(EquipKind.Thruster.ToString(), SummerRacePresentationPhase.Activated),
			BuildLoopMountRoute("fx_summerrace_thruster", stopLoop: false)
		},
		{
			BuildRouteKey(EquipKind.Thruster.ToString(), SummerRacePresentationPhase.ActiveExpired),
			BuildLoopMountRoute("fx_summerrace_thruster", stopLoop: true)
		},
		{
			BuildRouteKey(EquipKind.BoxingGlove.ToString(), SummerRacePresentationPhase.Activated),
			BuildOneShotMountRoute("fx_summerrace_boxing")
		},
		{
			BuildRouteKey(EquipKind.BoxingGlove.ToString(), SummerRacePresentationPhase.Spawned),
			BuildOneShotMountRoute("fx_summerrace_boxing")
		},
		{
			BuildRouteKey(EquipKind.BoxingGlove.ToString(), SummerRacePresentationPhase.Impact),
			BuildOneShotTargetRoute("fx_summerrace_boxing")
		},
		{
			BuildRouteKey(EquipKind.ElectricNet.ToString(), SummerRacePresentationPhase.Activated),
			BuildOneShotMountRoute("fx_summerrace_electricnet")
		},
		{
			BuildRouteKey(EquipKind.Hook.ToString(), SummerRacePresentationPhase.Activated),
			BuildOneShotMountRoute("fx_summerrace_hook")
		}
	};

	private static readonly string ElectricNetBodyLoopPathLight = "summerrace/effect/fx_summerracebody_light_electricnet";

	private static readonly string ElectricNetBodyLoopPathMedium = "summerrace/effect/fx_summerracebody_medium_electricnet";

	private static readonly string ElectricNetBodyLoopPathHeavy = "summerrace/effect/fx_summerracebody_heavy_electricnet";

	private static readonly Dictionary<string, RoutedEffectEntry> ProjectileEffectRouteTable = new Dictionary<string, RoutedEffectEntry>(StringComparer.Ordinal)
	{
		{
			BuildRouteKey(SummerRacePresentationDeliveryKind.Rocket.ToString(), SummerRacePresentationPhase.Spawned),
			BuildLoopProjectileRoute("fx_summerrace_rocket_trail", stopLoop: false)
		},
		{
			BuildRouteKey(SummerRacePresentationDeliveryKind.Rocket.ToString(), SummerRacePresentationPhase.Hit),
			BuildLoopProjectileRoute("fx_summerrace_rocket_trail", stopLoop: true)
		},
		{
			BuildRouteKey(SummerRacePresentationDeliveryKind.Rocket.ToString(), SummerRacePresentationPhase.Recycled),
			BuildLoopProjectileRoute("fx_summerrace_rocket_trail", stopLoop: true)
		}
	};

	private readonly List<string> loopKeyScratch = new List<string>(16);

	private readonly Dictionary<int, ElectricNetLoopState> electricNetLoopByTarget = new Dictionary<int, ElectricNetLoopState>(8);

	private readonly List<int> electricNetTargetKeyScratch = new List<int>(8);

	private readonly Dictionary<string, HashSet<int>> electricNetTargetsBySourceSlot = new Dictionary<string, HashSet<int>>(8, StringComparer.Ordinal);

	private readonly List<string> electricNetSourceSlotScratch = new List<string>(8);

	private readonly Dictionary<int, float> electricNetLoopExpireAtByTarget = new Dictionary<int, float>(8);

	private bool ShouldVerboseLog
	{
		get
		{
			if (verboseLog)
			{
				return SummerRaceRuntimeLog.IsGameplayVerboseEnabled;
			}
			return false;
		}
	}

	private void Awake()
	{
		if (GetComponent<SummerRaceCombatPresentationAudioSink>() == null)
		{
			base.gameObject.AddComponent<SummerRaceCombatPresentationAudioSink>();
		}
	}

	private void LateUpdate()
	{
		float time = Time.time;
		for (int num = timedEffects.Count - 1; num >= 0; num--)
		{
			TimedFxEntry timedFxEntry = timedEffects[num];
			if (timedFxEntry.Instance == null || time < timedFxEntry.EndTime)
			{
				if (timedFxEntry.Instance == null)
				{
					timedEffects.RemoveAt(num);
				}
			}
			else
			{
				if (ShouldVerboseLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][ComEffect] recycle one-shot path=" + timedFxEntry.Path);
				}
				RecycleOneShotEffectInstance(timedFxEntry.Instance, timedFxEntry.Path);
				timedEffects.RemoveAt(num);
			}
		}
		if (activeLoopEffects.Count <= 0)
		{
			return;
		}
		loopKeyScratch.Clear();
		foreach (KeyValuePair<string, GameObject> activeLoopEffect in activeLoopEffects)
		{
			if (activeLoopEffect.Value == null)
			{
				loopKeyScratch.Add(activeLoopEffect.Key);
			}
		}
		for (int i = 0; i < loopKeyScratch.Count; i++)
		{
			activeLoopEffects.Remove(loopKeyScratch[i]);
		}
		if (electricNetLoopByTarget.Count <= 0)
		{
			return;
		}
		electricNetTargetKeyScratch.Clear();
		foreach (KeyValuePair<int, ElectricNetLoopState> item in electricNetLoopByTarget)
		{
			ElectricNetLoopState value = item.Value;
			bool flag = value == null || string.IsNullOrEmpty(value.LoopKey) || !activeLoopEffects.ContainsKey(value.LoopKey);
			bool flag2 = false;
			if (!flag && value != null)
			{
				TrimExpiredElectricNetClaims(value, Time.time);
				if (value.SourceSlotClaims.Count <= 0)
				{
					flag2 = true;
				}
			}
			if (flag2 && value != null)
			{
				StopLoop(value.LoopKey, value.Path, "equip_body", SummerRacePresentationPhase.ActiveExpired, EquipKind.ElectricNet.ToString());
				flag = true;
			}
			if (flag)
			{
				electricNetTargetKeyScratch.Add(item.Key);
			}
		}
		for (int j = 0; j < electricNetTargetKeyScratch.Count; j++)
		{
			int num2 = electricNetTargetKeyScratch[j];
			electricNetLoopByTarget.Remove(num2);
			electricNetLoopExpireAtByTarget.Remove(num2);
			RemoveTargetFromAllElectricNetSourceSlotMaps(num2);
		}
		PruneEmptyElectricNetSourceSlotMaps();
	}

	private void OnDestroy()
	{
		for (int i = 0; i < timedEffects.Count; i++)
		{
			if (timedEffects[i].Instance != null)
			{
				UnityEngine.Object.Destroy(timedEffects[i].Instance);
			}
		}
		timedEffects.Clear();
		foreach (KeyValuePair<string, GameObject> activeLoopEffect in activeLoopEffects)
		{
			if (activeLoopEffect.Value != null)
			{
				UnityEngine.Object.Destroy(activeLoopEffect.Value);
			}
		}
		activeLoopEffects.Clear();
		electricNetLoopByTarget.Clear();
		electricNetTargetsBySourceSlot.Clear();
		electricNetLoopExpireAtByTarget.Clear();
		foreach (KeyValuePair<string, Queue<GameObject>> item in oneShotEffectPool)
		{
			Queue<GameObject> value = item.Value;
			if (value == null)
			{
				continue;
			}
			while (value.Count > 0)
			{
				GameObject gameObject = value.Dequeue();
				if (gameObject != null)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
			}
		}
		oneShotEffectPool.Clear();
		effectPrefabCache.Clear();
		warmedOneShotPaths.Clear();
		effectAuthoredSortingOrderCache.Clear();
		if (effectRoot != null)
		{
			UnityEngine.Object.Destroy(effectRoot.gameObject);
			effectRoot = null;
		}
	}

	public void HandleWeaponPresentation(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		if (TryResolveWeaponRequest(presentationEvent, out var request, out var stopLoop))
		{
			string loopKey = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, request.Path);
			if (stopLoop)
			{
				StopLoop(loopKey, request.Path, "weapon", presentationEvent.Phase, presentationEvent.WeaponKind.ToString());
			}
			else
			{
				PlayEffect(request, loopKey, presentationEvent.SourceTransform, (presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null, presentationEvent.TargetTransform, null, presentationEvent.Position, presentationEvent.Direction, "weapon", presentationEvent.Phase.ToString(), presentationEvent.WeaponKind.ToString());
			}
		}
	}

	public void HandleWeaponOverloadPresentation(SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
		bool num = presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired;
		EffectPlayRequest request = new EffectPlayRequest("effect/summerrace/fx_SummerRace_Overh", loop: true, attachToMount: true, attachToSource: false, attachToTarget: false, attachToProjectile: false);
		string loopKey = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, request.Path);
		if (num)
		{
			StopLoop(loopKey, request.Path, "weapon_overload", presentationEvent.Phase, "Overload");
			return;
		}
		Transform mountTransform = ((presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null);
		PlayEffect(request, loopKey, presentationEvent.SourceTransform, mountTransform, null, null, presentationEvent.Position, presentationEvent.Direction, "weapon_overload", presentationEvent.Phase.ToString(), "Overload");
	}

	public void HandleEquipPresentation(SummerRaceEquipPresentationEvent presentationEvent)
	{
		if (ShouldVerboseLog)
		{
			string[] obj = new string[12]
			{
				"[SummerRace][ComEffect][EquipEvent] kind=",
				presentationEvent.EquipKind.ToString(),
				" phase=",
				presentationEvent.Phase.ToString(),
				" delivery=",
				presentationEvent.DeliveryKind.ToString(),
				" slot=",
				null,
				null,
				null,
				null,
				null
			};
			int slotIndex = presentationEvent.SlotIndex;
			obj[7] = slotIndex.ToString();
			obj[8] = " activeDuration=";
			float activeDuration = presentationEvent.ActiveDuration;
			obj[9] = activeDuration.ToString("F3");
			obj[10] = " source=";
			obj[11] = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.name : "<null>");
			SummerRaceRuntimeLog.Log(string.Concat(obj));
		}
		if (TryResolveEquipRequest(presentationEvent, out var request, out var stopLoop))
		{
			string loopKey = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, request.Path);
			if (stopLoop)
			{
				StopLoop(loopKey, request.Path, "equip", presentationEvent.Phase, presentationEvent.EquipKind.ToString());
			}
			else
			{
				PlayEffect(request, loopKey, presentationEvent.SourceTransform, (presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null, presentationEvent.TargetTransform, null, presentationEvent.Position, presentationEvent.Direction, "equip", presentationEvent.Phase.ToString(), presentationEvent.EquipKind.ToString());
			}
		}
		if (presentationEvent.EquipKind == EquipKind.ElectricNet && (presentationEvent.Phase == SummerRacePresentationPhase.Activated || presentationEvent.Phase == SummerRacePresentationPhase.Impact))
		{
			if (presentationEvent.Phase == SummerRacePresentationPhase.Impact && presentationEvent.TargetTransform != null && presentationEvent.ActiveDuration > 0f)
			{
				PlayOrRefreshElectricNetTargetLoop(presentationEvent);
			}
		}
		else if (presentationEvent.EquipKind == EquipKind.ElectricNet && presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired)
		{
			TryStopElectricNetLoopBySourceSlot(presentationEvent.SourceTransform, presentationEvent.SlotIndex, presentationEvent.Phase, presentationEvent.EquipKind.ToString());
		}
		else
		{
			if (presentationEvent.EquipKind != EquipKind.ShieldGenerator && presentationEvent.DeliveryKind != SummerRacePresentationDeliveryKind.ShieldAura)
			{
				return;
			}
			if (ShouldVerboseLog)
			{
				string[] obj2 = new string[8]
				{
					"[SummerRace][ComEffect][Shield] enter shield branch. kind=",
					presentationEvent.EquipKind.ToString(),
					" delivery=",
					presentationEvent.DeliveryKind.ToString(),
					" phase=",
					presentationEvent.Phase.ToString(),
					" slot=",
					null
				};
				int slotIndex = presentationEvent.SlotIndex;
				obj2[7] = slotIndex.ToString();
				SummerRaceRuntimeLog.Log(string.Concat(obj2));
			}
			if (presentationEvent.Phase == SummerRacePresentationPhase.Activated)
			{
				EffectPlayRequest request2 = ResolveShieldBodyRequestOrThrow(presentationEvent.SourceTransform, loop: true, end: false);
				string text = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, request2.Path);
				if (ShouldVerboseLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][Shield] play loop path=" + request2.Path + " key=" + text);
				}
				PlayEffect(request2, text, presentationEvent.SourceTransform, (presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null, presentationEvent.TargetTransform, null, presentationEvent.Position, presentationEvent.Direction, "equip_body", presentationEvent.Phase.ToString(), presentationEvent.EquipKind.ToString());
			}
			else if (presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired)
			{
				EffectPlayRequest effectPlayRequest = ResolveShieldBodyRequestOrThrow(presentationEvent.SourceTransform, loop: true, end: false);
				string text2 = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, effectPlayRequest.Path);
				if (ShouldVerboseLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][Shield] stop loop path=" + effectPlayRequest.Path + " key=" + text2);
				}
				StopLoop(text2, effectPlayRequest.Path, "equip_body", presentationEvent.Phase, presentationEvent.EquipKind.ToString());
				EffectPlayRequest request3 = ResolveShieldBodyRequestOrThrow(presentationEvent.SourceTransform, loop: false, end: true);
				if (ShouldVerboseLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][Shield] play end path=" + request3.Path);
				}
				PlayEffect(request3, string.Empty, presentationEvent.SourceTransform, (presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null, presentationEvent.TargetTransform, null, presentationEvent.Position, presentationEvent.Direction, "equip_body", presentationEvent.Phase.ToString(), presentationEvent.EquipKind.ToString());
			}
		}
	}

	public void HandleProjectilePresentation(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		if (TryResolveProjectileRequest(presentationEvent, out var request, out var stopLoop))
		{
			string loopKey = BuildLoopKey(presentationEvent.SourceTransform, presentationEvent.CorrelationId, request.Path);
			if (stopLoop)
			{
				StopLoop(loopKey, request.Path, "projectile", presentationEvent.Phase, presentationEvent.WeaponKind.ToString());
			}
			else
			{
				PlayEffect(request, loopKey, presentationEvent.SourceTransform, (presentationEvent.MountPoint != null) ? presentationEvent.MountPoint.transform : null, null, presentationEvent.ProjectileTransform, presentationEvent.Position, presentationEvent.Direction, "projectile", presentationEvent.Phase.ToString(), presentationEvent.WeaponKind.ToString());
			}
		}
	}

	public float HandleDefeatPresentation(SummerRaceDefeatPresentationEvent presentationEvent)
	{
		string text = NormalizeEffectPath(presentationEvent.EffectPath);
		if (string.IsNullOrWhiteSpace(text))
		{
			return 0f;
		}
		EffectPlayRequest request = new EffectPlayRequest(text, loop: false, attachToMount: false, attachToSource: false, attachToTarget: false, attachToProjectile: false, IsBoom1DefeatEffect(text) ? 0.5f : 0f);
		Transform sourceTransform = ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform : presentationEvent.TargetTransform);
		Vector2 direction = ((presentationEvent.Direction.sqrMagnitude > 0.0001f) ? presentationEvent.Direction.normalized : Vector2.right);
		return PlayEffect(request, string.Empty, sourceTransform, null, presentationEvent.TargetTransform, null, presentationEvent.Position, direction, "defeat", SummerRacePresentationPhase.Impact.ToString(), "defeat");
	}

	private float PlayEffect(EffectPlayRequest request, string loopKey, Transform sourceTransform, Transform mountTransform, Transform targetTransform, Transform projectileTransform, Vector2 worldPosition, Vector2 direction, string channel, string phase, string kind)
	{
		if (request.Loop)
		{
			if (string.IsNullOrEmpty(loopKey))
			{
				SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] loop effect key is empty. path=" + request.Path);
			}
			else
			{
				if (activeLoopEffects.TryGetValue(loopKey, out var value) && value != null)
				{
					return 0f;
				}
				GameObject gameObject = InstantiateEffectInstance(request.Path, usePool: false);
				if (gameObject == null)
				{
					return 0f;
				}
				Transform transform = ResolveAttachTarget(request, sourceTransform, mountTransform, targetTransform, projectileTransform);
				if (transform == null)
				{
					SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] loop attach target missing. path=" + request.Path + " channel=" + channel + " phase=" + phase);
					UnityEngine.Object.Destroy(gameObject);
					return 0f;
				}
				gameObject.transform.SetParent(transform, worldPositionStays: false);
				gameObject.transform.localPosition = ResolveAttachLocalOffset(request.Path, transform);
				gameObject.transform.localRotation = Quaternion.identity;
				ApplyShieldBodyVisualBindingIfNeeded(gameObject, request.Path, transform, sourceTransform, mountTransform);
				ApplyBodyAuraMirrorCompensationIfNeeded(gameObject.transform, request.Path, transform, sourceTransform);
				ApplyDirectionalRotationForLoopFxIfNeeded(gameObject.transform, request.Path, sourceTransform, mountTransform);
				ApplyEffectSortingFromPrefabBaseline(gameObject, request, sourceTransform, mountTransform, targetTransform, projectileTransform, channel, phase);
				if (string.Equals(channel, "weapon_overload", StringComparison.Ordinal))
				{
					RaiseEffectAboveTargetVisual(gameObject, mountTransform, 1);
				}
				activeLoopEffects[loopKey] = gameObject;
				if (ShouldVerboseLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][ComEffect] start loop channel=" + channel + " phase=" + phase + " kind=" + kind + " path=" + request.Path + " key=" + loopKey);
				}
			}
			return 0f;
		}
		GameObject gameObject2 = InstantiateEffectInstance(request.Path, usePool: true);
		if (gameObject2 == null)
		{
			return 0f;
		}
		TraceMachineGunReuseState("spawn:after_get_instance", request.Path, gameObject2, null, worldPosition, direction, channel, phase);
		int num;
		if (!request.AttachToSource && !request.AttachToMount && !request.AttachToTarget)
		{
			num = (request.AttachToProjectile ? 1 : 0);
			if (num == 0)
			{
				gameObject2.transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
				gameObject2.transform.position = worldPosition;
				gameObject2.transform.rotation = ResolveWorldRotation(direction);
				TraceMachineGunReuseState("spawn:direct_world_attach", request.Path, gameObject2, null, worldPosition, direction, channel, phase);
				goto IL_03a8;
			}
		}
		else
		{
			num = 1;
		}
		Transform transform2 = ResolveAttachTarget(request, sourceTransform, mountTransform, targetTransform, projectileTransform);
		if (transform2 != null)
		{
			gameObject2.transform.SetParent(transform2, worldPositionStays: false);
			gameObject2.transform.localPosition = ResolveAttachLocalOffset(request.Path, transform2);
			gameObject2.transform.localRotation = Quaternion.identity;
			ApplyShieldBodyVisualBindingIfNeeded(gameObject2, request.Path, transform2, sourceTransform, mountTransform);
			ApplyBodyAuraMirrorCompensationIfNeeded(gameObject2.transform, request.Path, transform2, sourceTransform);
			Vector2 rotationDirection = direction;
			if (request.AttachToMount && mountTransform != null)
			{
				rotationDirection = ResolveEffectForwardAxis(mountTransform);
			}
			ApplyDirectionalRotationForMuzzleFxIfNeeded(gameObject2.transform, request.Path, rotationDirection, direction, mountTransform, channel, phase);
			TraceMachineGunReuseState("spawn:attached_to_target", request.Path, gameObject2, transform2, worldPosition, direction, channel, phase);
		}
		else
		{
			gameObject2.transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
			gameObject2.transform.position = worldPosition;
			gameObject2.transform.rotation = ResolveWorldRotation(direction);
			TraceMachineGunReuseState("spawn:fallback_world_attach", request.Path, gameObject2, null, worldPosition, direction, channel, phase);
		}
		goto IL_03a8;
		IL_03a8:
		if (num == 0)
		{
			gameObject2.transform.rotation = ResolveWorldRotation(direction);
		}
		ApplyEffectSortingFromPrefabBaseline(gameObject2, request, sourceTransform, mountTransform, targetTransform, projectileTransform, channel, phase);
		if (string.Equals(channel, "defeat", StringComparison.Ordinal))
		{
			RaiseEffectAboveTargetVisual(gameObject2, targetTransform, 5);
		}
		TraceMachineGunReuseState("spawn:before_activate", request.Path, gameObject2, gameObject2.transform.parent, worldPosition, direction, channel, phase);
		try
		{
			PrepareAndActivateOneShotEffect(gameObject2, request.Path, worldPosition, direction, channel, phase);
			TraceMachineGunReuseState("spawn:after_activate", request.Path, gameObject2, gameObject2.transform.parent, worldPosition, direction, channel, phase);
			float num2 = ResolveOneShotLifetimeOrThrow(gameObject2, request.Path, request.ExplicitLifetimeSeconds);
			timedEffects.Add(new TimedFxEntry(gameObject2, Time.time + num2 + 0.08f, request.Path));
			if (ShouldVerboseLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][ComEffect] spawn one-shot channel=" + channel + " phase=" + phase + " kind=" + kind + " path=" + request.Path + " lifetime=" + num2.ToString("F2"));
			}
			return num2;
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] one-shot spawn failed. channel=" + channel + " phase=" + phase + " kind=" + kind + " path=" + request.Path + "\n" + ex);
			if (gameObject2 != null)
			{
				UnityEngine.Object.Destroy(gameObject2);
			}
			return 0f;
		}
	}

	private void StopLoop(string loopKey, string path, string channel, SummerRacePresentationPhase phase, string kind)
	{
		if (!string.IsNullOrEmpty(loopKey) && activeLoopEffects.TryGetValue(loopKey, out var value))
		{
			if (value != null)
			{
				UnityEngine.Object.Destroy(value);
			}
			activeLoopEffects.Remove(loopKey);
			if (ShouldVerboseLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][ComEffect] stop loop channel=" + channel + " phase=" + phase.ToString() + " kind=" + kind + " path=" + path + " key=" + loopKey);
			}
		}
	}

	private GameObject InstantiateEffectInstance(string path, bool usePool)
	{
		if (string.IsNullOrWhiteSpace(path))
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] effect path is empty.");
			return null;
		}
		GameObject gameObject = (usePool ? InstantiateOneShotFromPool(path) : InstantiateEffectWithoutPool(path));
		if (gameObject == null)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] failed to load effect prefab: " + path);
			return null;
		}
		return gameObject;
	}

	private GameObject InstantiateOneShotFromPool(string path)
	{
		EnsureOneShotPoolWarm(path);
		if (!oneShotEffectPool.TryGetValue(path, out var value))
		{
			value = new Queue<GameObject>(2);
			oneShotEffectPool[path] = value;
		}
		GameObject gameObject = null;
		while (value.Count > 0 && gameObject == null)
		{
			gameObject = value.Dequeue();
			TraceMachineGunReuseState("pool:dequeue_candidate", path, gameObject, (gameObject != null) ? gameObject.transform.parent : null, Vector2.zero, Vector2.zero, "pool", "dequeue");
		}
		if (gameObject == null)
		{
			gameObject = CreateEffectInstance(path);
			TraceMachineGunReuseState("pool:create_new", path, gameObject, (gameObject != null) ? gameObject.transform.parent : null, Vector2.zero, Vector2.zero, "pool", "create");
		}
		if (gameObject == null)
		{
			return null;
		}
		gameObject.SetActive(value: false);
		TraceMachineGunReuseState("pool:return_inactive", path, gameObject, gameObject.transform.parent, Vector2.zero, Vector2.zero, "pool", "return");
		return gameObject;
	}

	private void EnsureOneShotPoolWarm(string path)
	{
		if (string.IsNullOrEmpty(path) || warmedOneShotPaths.Contains(path))
		{
			return;
		}
		if (!oneShotEffectPool.TryGetValue(path, out var value))
		{
			value = new Queue<GameObject>(2);
			oneShotEffectPool[path] = value;
		}
		int num = 2;
		if (OneShotPoolWarmupSizes.TryGetValue(path, out var value2))
		{
			num = Mathf.Max(1, value2);
		}
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			GameObject gameObject = CreateEffectInstance(path);
			if (gameObject == null)
			{
				break;
			}
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
			value.Enqueue(gameObject);
			num2++;
		}
		if (num2 > 0)
		{
			warmedOneShotPaths.Add(path);
		}
	}

	private GameObject InstantiateEffectWithoutPool(string path)
	{
		return CreateEffectInstance(path);
	}

	private GameObject CreateEffectInstance(string path)
	{
		if (!TryGetEffectPrefab(path, out var prefab) || prefab == null)
		{
			return null;
		}
		GameObject obj = UnityEngine.Object.Instantiate(prefab);
		obj.name = prefab.name;
		return obj;
	}

	private bool TryGetEffectPrefab(string path, out GameObject prefab)
	{
		if (effectPrefabCache.TryGetValue(path, out prefab) && prefab != null)
		{
			return true;
		}
		string text = ToEffectBundleName(path);
		GameObject[] array = Asset.LoadAllFromBundle<GameObject>(text);
		if (array == null || array.Length == 0)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] bundle has no GameObject prefab. bundle=" + text + " path=" + path);
			prefab = null;
			return false;
		}
		string pathLeafName = GetPathLeafName(path);
		prefab = array[0];
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (!(gameObject == null) && string.Equals(gameObject.name, pathLeafName, StringComparison.OrdinalIgnoreCase))
			{
				prefab = gameObject;
				break;
			}
		}
		effectPrefabCache[path] = prefab;
		return true;
	}

	private void RecycleOneShotEffectInstance(GameObject instance, string path)
	{
		if (instance == null)
		{
			return;
		}
		if (string.Equals(path, "summerrace/effect/fx_summerrace_hook", StringComparison.Ordinal))
		{
			if (ShouldVerboseLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][ComEffect] destroy one-shot path=" + path);
			}
			UnityEngine.Object.Destroy(instance);
			return;
		}
		if (string.IsNullOrEmpty(path))
		{
			UnityEngine.Object.Destroy(instance);
			return;
		}
		instance.SetActive(value: false);
		instance.transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
		TraceMachineGunReuseState("recycle:after_parent_root", path, instance, instance.transform.parent, Vector2.zero, Vector2.zero, "recycle", "recycle");
		if (!oneShotEffectPool.TryGetValue(path, out var value))
		{
			value = new Queue<GameObject>(2);
			oneShotEffectPool[path] = value;
		}
		value.Enqueue(instance);
		TraceMachineGunReuseState("recycle:enqueue", path, instance, instance.transform.parent, Vector2.zero, Vector2.zero, "recycle", "enqueue");
	}

	private static string ToEffectBundleName(string path)
	{
		if (string.Equals(path, "effect/summerrace/fx_SummerRace_Overh", StringComparison.Ordinal))
		{
			return "comeffect/effect/summerrace/fx_summerrace_overheat.ys";
		}
		return "comeffect/" + path + ".ys";
	}

	private void PrepareAndActivateOneShotEffect(GameObject effectInstance, string path, Vector2 expectedWorldPosition, Vector2 expectedDirection, string channel, string phase)
	{
		if (effectInstance == null)
		{
			return;
		}
		TraceMachineGunReuseState("activate:before_reset", path, effectInstance, effectInstance.transform.parent, expectedWorldPosition, expectedDirection, channel, phase);
		ParticleSystem[] componentsInChildren = effectInstance.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		ParticleSystem[] array = componentsInChildren;
		foreach (ParticleSystem particleSystem in array)
		{
			if (particleSystem != null)
			{
				particleSystem.Stop(withChildren: true, ParticleSystemStopBehavior.StopEmittingAndClear);
				particleSystem.Clear(withChildren: true);
			}
		}
		Animator[] componentsInChildren2 = effectInstance.GetComponentsInChildren<Animator>(includeInactive: true);
		foreach (Animator animator in componentsInChildren2)
		{
			if (!(animator == null) && animator.runtimeAnimatorController != null)
			{
				animator.Rebind();
				animator.Update(0f);
			}
		}
		effectInstance.SetActive(value: true);
		TraceMachineGunReuseState("activate:after_set_active", path, effectInstance, effectInstance.transform.parent, expectedWorldPosition, expectedDirection, channel, phase);
		array = componentsInChildren;
		foreach (ParticleSystem particleSystem2 in array)
		{
			if (particleSystem2 != null)
			{
				particleSystem2.Play(withChildren: true);
			}
		}
		TraceMachineGunReuseState("activate:after_play_particles", path, effectInstance, effectInstance.transform.parent, expectedWorldPosition, expectedDirection, channel, phase);
	}

	private void TraceMachineGunReuseState(string stage, string path, GameObject effectInstance, Transform attachTarget, Vector2 expectedWorldPosition, Vector2 expectedDirection, string channel, string phase)
	{
		if (!ShouldVerboseLog || !string.Equals(path, "summerrace/effect/fx_summerrace_machinegun", StringComparison.Ordinal))
		{
			return;
		}
		if (effectInstance == null)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][MG-TRACE] stage=" + stage + " inst=<null> channel=" + channel + " phase=" + phase);
			return;
		}
		Transform obj = effectInstance.transform;
		Transform parent = obj.parent;
		string text = ((parent != null) ? parent.name : "<null>");
		string text2 = ((attachTarget != null) ? attachTarget.name : "<null>");
		Vector3 position = obj.position;
		Vector3 localPosition = obj.localPosition;
		Vector3 eulerAngles = obj.eulerAngles;
		ParticleSystem[] componentsInChildren = effectInstance.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		string text3 = string.Empty;
		foreach (ParticleSystem particleSystem in componentsInChildren)
		{
			if (!(particleSystem == null))
			{
				ParticleSystem.MainModule main = particleSystem.main;
				text3 = text3 + "[" + particleSystem.transform.name + " sim=" + main.simulationSpace.ToString() + " loop=" + main.loop + " alive=" + particleSystem.particleCount + " playing=" + particleSystem.isPlaying + "]";
			}
		}
		string[] obj2 = new string[32]
		{
			"[SummerRace][ComEffect][MG-TRACE] stage=",
			stage,
			" frame=",
			Time.frameCount.ToString(),
			" t=",
			Time.time.ToString("F3"),
			" channel=",
			channel,
			" phase=",
			phase,
			" inst=",
			effectInstance.GetInstanceID().ToString(),
			" activeSelf=",
			effectInstance.activeSelf.ToString(),
			" activeInHierarchy=",
			effectInstance.activeInHierarchy.ToString(),
			" parent=",
			text,
			" attachTarget=",
			text2,
			" worldPos=",
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null,
			null
		};
		Vector3 vector = position;
		obj2[21] = vector.ToString();
		obj2[22] = " localPos=";
		vector = localPosition;
		obj2[23] = vector.ToString();
		obj2[24] = " rotZ=";
		obj2[25] = eulerAngles.z.ToString("F1");
		obj2[26] = " expectWorld=";
		Vector2 vector2 = expectedWorldPosition;
		obj2[27] = vector2.ToString();
		obj2[28] = " expectDir=";
		vector2 = expectedDirection;
		obj2[29] = vector2.ToString();
		obj2[30] = " particles=";
		obj2[31] = text3;
		SummerRaceRuntimeLog.Log(string.Concat(obj2));
	}

	private static string GetPathLeafName(string path)
	{
		int num = path.LastIndexOf('/');
		if (num < 0 || num + 1 >= path.Length)
		{
			return path;
		}
		return path.Substring(num + 1);
	}

	private static Transform ResolveAttachTarget(EffectPlayRequest request, Transform sourceTransform, Transform mountTransform, Transform targetTransform, Transform projectileTransform)
	{
		if (IsShieldBodyEffect(request.Path))
		{
			Transform transform = ResolveShieldVisualCenterAttachTarget(mountTransform, sourceTransform);
			if (transform != null)
			{
				return transform;
			}
		}
		if (request.AttachToTarget && targetTransform != null)
		{
			return targetTransform;
		}
		if (request.AttachToSource && sourceTransform != null)
		{
			return sourceTransform;
		}
		if (request.AttachToMount && mountTransform != null)
		{
			if (IsRotatingSawLoopEffect(request.Path))
			{
				MountPoint component = mountTransform.GetComponent<MountPoint>();
				if (component == null)
				{
					throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw effect mount point is missing.");
				}
				if (!(component.InstalledModule is WeaponModuleDefinition weaponModuleDefinition))
				{
					throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw effect module is not a weapon definition.");
				}
				if (SummerRaceCombatPresentationRouter.ResolveWeaponKind(weaponModuleDefinition) != WeaponKind.RotatingSaw)
				{
					throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw effect mounted on non-RotatingSaw module. weapon=" + weaponModuleDefinition.name);
				}
				if (component.VisualInstance == null)
				{
					throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw mount visual instance is missing. weapon=" + weaponModuleDefinition.name);
				}
				return component.VisualInstance.transform;
			}
			return mountTransform;
		}
		if (request.AttachToProjectile && projectileTransform != null)
		{
			return projectileTransform;
		}
		return null;
	}

	private static bool IsShieldBodyEffect(string path)
	{
		if (!string.IsNullOrEmpty(path) && path.StartsWith("summerrace/effect/fx_summerracebody_", StringComparison.Ordinal))
		{
			return path.IndexOf("_shield_", StringComparison.Ordinal) >= 0;
		}
		return false;
	}

	private static bool IsBodyAuraEffect(string path)
	{
		if (!string.IsNullOrEmpty(path))
		{
			return path.StartsWith("summerrace/effect/fx_summerracebody_", StringComparison.Ordinal);
		}
		return false;
	}

	private static Transform ResolveShieldVisualCenterAttachTarget(Transform mountTransform, Transform sourceTransform)
	{
		Transform transform = ((sourceTransform != null) ? sourceTransform : mountTransform);
		if (transform == null)
		{
			return null;
		}
		MountPoint mountPoint = transform.GetComponent<MountPoint>();
		if (mountPoint == null)
		{
			mountPoint = transform.GetComponentInParent<MountPoint>();
		}
		if (mountPoint != null && mountPoint.VisualInstance != null)
		{
			transform = mountPoint.VisualInstance.transform;
		}
		Transform transform2 = FindShieldCenterAnchor(transform);
		if (transform2 != null && transform2 != transform)
		{
			return transform2;
		}
		return EnsureShieldCenterChild(transform, sourceTransform);
	}

	private static Transform EnsureShieldCenterChild(Transform visualRoot, Transform sourceTransform)
	{
		if (visualRoot == null)
		{
			return null;
		}
		SummerRaceBodyType bodyType = ResolveBodyTypeFromSourceOrFallback(sourceTransform);
		float positionXSign = ResolveShieldCenterPositionXSign(sourceTransform);
		Transform transform = visualRoot.Find("ShieldCenter_Auto");
		if (transform != null)
		{
			ApplyShieldCenterAutoTransform(transform, bodyType, positionXSign);
			return transform;
		}
		transform = new GameObject("ShieldCenter_Auto").transform;
		transform.SetParent(visualRoot, worldPositionStays: false);
		ApplyShieldCenterAutoTransform(transform, bodyType, positionXSign);
		return transform;
	}

	private static void ApplyShieldCenterAutoTransform(Transform autoCenter, SummerRaceBodyType bodyType, float positionXSign)
	{
		if (!(autoCenter == null))
		{
			Vector3 localPosition;
			Quaternion localRotation;
			Vector3 localScale;
			switch (bodyType)
			{
			case SummerRaceBodyType.Light:
				localPosition = ShieldCenterAutoLocalPositionLight;
				localRotation = ShieldCenterAutoLocalRotationLight;
				localScale = ShieldCenterAutoLocalScaleLight;
				break;
			case SummerRaceBodyType.Medium:
				localPosition = ShieldCenterAutoLocalPositionMedium;
				localRotation = ShieldCenterAutoLocalRotationMedium;
				localScale = ShieldCenterAutoLocalScaleMedium;
				break;
			case SummerRaceBodyType.Heavy:
				localPosition = ShieldCenterAutoLocalPositionHeavy;
				localRotation = ShieldCenterAutoLocalRotationHeavy;
				localScale = ShieldCenterAutoLocalScaleHeavy;
				break;
			default:
				localPosition = ShieldCenterAutoLocalPositionLight;
				localRotation = ShieldCenterAutoLocalRotationLight;
				localScale = ShieldCenterAutoLocalScaleLight;
				break;
			}
			localPosition.x *= positionXSign;
			autoCenter.localPosition = localPosition;
			autoCenter.localRotation = localRotation;
			autoCenter.localScale = localScale;
		}
	}

	private static float ResolveShieldCenterPositionXSign(Transform sourceTransform)
	{
		if (!(sourceTransform != null) || !(sourceTransform.GetComponentInParent<SummerRaceEnemy>() != null))
		{
			return 1f;
		}
		return -1f;
	}

	private static SummerRaceBodyType ResolveBodyTypeFromSourceOrFallback(Transform sourceTransform)
	{
		if (sourceTransform == null)
		{
			return SummerRaceBodyType.Light;
		}
		ISummerRaceBuildProfileProvider summerRaceBuildProfileProvider = sourceTransform.GetComponent<ISummerRaceBuildProfileProvider>();
		if (summerRaceBuildProfileProvider == null)
		{
			summerRaceBuildProfileProvider = sourceTransform.GetComponentInParent<ISummerRaceBuildProfileProvider>();
		}
		return summerRaceBuildProfileProvider?.GetBuildProfile().BodyType ?? SummerRaceBodyType.Light;
	}

	private void ApplyShieldBodyVisualBindingIfNeeded(GameObject effectInstance, string effectPath, Transform attachTarget, Transform sourceTransform, Transform mountTransform)
	{
		if (!(effectInstance == null) && IsShieldBodyEffect(effectPath))
		{
			SummerRaceBodyType bodyType = ResolveBodyTypeFromSourceOrThrow(sourceTransform);
			Sprite sprite = ResolveShieldBodyEffectSprite(bodyType);
			ApplyShieldEffectSprite(effectInstance, sprite);
		}
	}

	private static void ApplyBodyAuraMirrorCompensationIfNeeded(Transform effectTransform, string effectPath, Transform attachTarget, Transform sourceTransform)
	{
		if (!(effectTransform == null) && !(attachTarget == null) && IsBodyAuraEffect(effectPath))
		{
			Vector3 localScale = effectTransform.localScale;
			localScale.x = Mathf.Abs(localScale.x);
			if ((sourceTransform != null && sourceTransform.GetComponentInParent<SummerRaceEnemy>() != null) || attachTarget.lossyScale.x < 0f)
			{
				localScale.x = 0f - localScale.x;
			}
			effectTransform.localScale = localScale;
		}
	}

	private static bool IsBoom1DefeatEffect(string effectPath)
	{
		if (!string.IsNullOrEmpty(effectPath))
		{
			return effectPath.IndexOf("fx_summerrace_boom_1", StringComparison.OrdinalIgnoreCase) >= 0;
		}
		return false;
	}

	private static MountPoint ResolveMountPoint(Transform mountTransform, Transform attachTarget)
	{
		MountPoint mountPoint = null;
		if (mountTransform != null)
		{
			mountPoint = mountTransform.GetComponent<MountPoint>();
			if (mountPoint == null)
			{
				mountPoint = mountTransform.GetComponentInParent<MountPoint>();
			}
		}
		if (mountPoint == null && attachTarget != null)
		{
			mountPoint = attachTarget.GetComponent<MountPoint>();
			if (mountPoint == null)
			{
				mountPoint = attachTarget.GetComponentInParent<MountPoint>();
			}
		}
		return mountPoint;
	}

	private Sprite ResolveShieldBodyEffectSprite(SummerRaceBodyType bodyType)
	{
		if (shieldEffectSpriteCache.TryGetValue(bodyType, out var value) && value != null)
		{
			return value;
		}
		string text = bodyType switch
		{
			SummerRaceBodyType.Light => "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Light_Effect.png", 
			SummerRaceBodyType.Medium => "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Medium_Effect.png", 
			SummerRaceBodyType.Heavy => "Assets/ABResources/SummerRaceActivity/Texture/SummerRaceBody_Heavy_Effect.png", 
			_ => string.Empty, 
		};
		if (string.IsNullOrEmpty(text) || !SummerRaceConfigLoader.TryLoadSprite(text, out var sprite) || sprite == null)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect][Shield] failed to load shield body effect sprite. bodyType=" + bodyType.ToString() + " path=" + text);
			return null;
		}
		shieldEffectSpriteCache[bodyType] = sprite;
		return sprite;
	}

	private static void ApplyShieldEffectSprite(GameObject effectInstance, Sprite sprite)
	{
		if (effectInstance == null || sprite == null)
		{
			return;
		}
		SpriteRenderer[] componentsInChildren = effectInstance.GetComponentsInChildren<SpriteRenderer>(includeInactive: true);
		foreach (SpriteRenderer spriteRenderer in componentsInChildren)
		{
			if (!(spriteRenderer == null))
			{
				spriteRenderer.sprite = sprite;
			}
		}
	}

	private static Transform FindShieldCenterAnchor(Transform visualRoot)
	{
		if (visualRoot == null)
		{
			return null;
		}
		Transform[] componentsInChildren = visualRoot.GetComponentsInChildren<Transform>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length <= 1)
		{
			return null;
		}
		string[] array = new string[7] { "ShieldCenter", "Shield_Center", "shield_center", "Center", "center", "FxRoot", "EffectRoot" };
		foreach (string b in array)
		{
			foreach (Transform transform in componentsInChildren)
			{
				if (!(transform == null) && transform != visualRoot && !IsShieldCenterAuto(transform) && string.Equals(transform.name, b, StringComparison.OrdinalIgnoreCase))
				{
					return transform;
				}
			}
		}
		foreach (Transform transform2 in componentsInChildren)
		{
			if (!(transform2 == null) && !(transform2 == visualRoot) && !IsShieldCenterAuto(transform2))
			{
				string text = transform2.name.ToLowerInvariant();
				if (text.Contains("shield") && text.Contains("center"))
				{
					return transform2;
				}
			}
		}
		foreach (Transform transform3 in componentsInChildren)
		{
			if (!(transform3 == null) && !(transform3 == visualRoot) && !IsShieldCenterAuto(transform3) && transform3.name.ToLowerInvariant().Contains("center"))
			{
				return transform3;
			}
		}
		return null;
	}

	private static bool IsShieldCenterAuto(Transform candidate)
	{
		if (candidate != null)
		{
			return string.Equals(candidate.name, "ShieldCenter_Auto", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private void ApplyEffectSortingFromPrefabBaseline(GameObject effectInstance, EffectPlayRequest request, Transform sourceTransform, Transform mountTransform, Transform targetTransform, Transform projectileTransform, string channel, string phase)
	{
		if (effectInstance == null || !TryResolveBodySortAnchor(request, sourceTransform, mountTransform, targetTransform, projectileTransform, out var bodySortingOrder, out var sortingLayerId))
		{
			return;
		}
		int num = ResolveRuntimeEffectBand(channel, phase);
		effectRenderersScratch.Clear();
		Renderer[] componentsInChildren = effectInstance.GetComponentsInChildren<Renderer>(includeInactive: true);
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer == null))
			{
				effectRenderersScratch.Add(renderer);
				if (!effectAuthoredSortingOrderCache.ContainsKey(renderer))
				{
					effectAuthoredSortingOrderCache[renderer] = renderer.sortingOrder;
				}
			}
		}
		int num2 = int.MaxValue;
		int a = int.MinValue;
		int num3 = int.MaxValue;
		int a2 = int.MinValue;
		for (int j = 0; j < effectRenderersScratch.Count; j++)
		{
			Renderer renderer2 = effectRenderersScratch[j];
			if (!(renderer2 == null))
			{
				int b = (effectAuthoredSortingOrderCache.TryGetValue(renderer2, out var value) ? value : renderer2.sortingOrder);
				num2 = Mathf.Min(num2, b);
				a = Mathf.Max(a, b);
			}
		}
		if (num2 == int.MaxValue)
		{
			return;
		}
		for (int k = 0; k < effectRenderersScratch.Count; k++)
		{
			Renderer renderer3 = effectRenderersScratch[k];
			if (!(renderer3 == null))
			{
				int num4 = (effectAuthoredSortingOrderCache.TryGetValue(renderer3, out var value2) ? value2 : renderer3.sortingOrder);
				renderer3.sortingLayerID = sortingLayerId;
				int num5 = num4 - num2;
				int i = (renderer3.sortingOrder = bodySortingOrder + num + num5);
				int b2 = i;
				num3 = Mathf.Min(num3, b2);
				a2 = Mathf.Max(a2, b2);
			}
		}
		if (ShouldVerboseLog && num2 != int.MaxValue && num3 != int.MaxValue)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][Sorting] path=" + request.Path + " channel=" + channel + " phase=" + phase + " bodyOrder=" + bodySortingOrder + " authored=[" + num2 + "," + a + "] targetBand=" + num + " final=[" + num3 + "," + a2 + "] rendererCount=" + effectRenderersScratch.Count);
		}
	}

	private static int ResolveRuntimeEffectBand(string channel, string phase)
	{
		if (string.Equals(channel, "weapon_overload", StringComparison.Ordinal))
		{
			return 4;
		}
		if (string.Equals(channel, "equip_body", StringComparison.Ordinal))
		{
			return 5;
		}
		if (string.Equals(phase, SummerRacePresentationPhase.Impact.ToString(), StringComparison.Ordinal) || string.Equals(phase, SummerRacePresentationPhase.Hit.ToString(), StringComparison.Ordinal) || string.Equals(phase, SummerRacePresentationPhase.ReturnStarted.ToString(), StringComparison.Ordinal) || string.Equals(phase, SummerRacePresentationPhase.ActiveExpired.ToString(), StringComparison.Ordinal))
		{
			return 4;
		}
		return 1;
	}

	private static bool TryResolveBodySortAnchor(EffectPlayRequest request, Transform sourceTransform, Transform mountTransform, Transform targetTransform, Transform projectileTransform, out int bodySortingOrder, out int sortingLayerId)
	{
		if (request.AttachToTarget && TryResolveBodySortAnchorFromTransform(targetTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (request.AttachToSource && TryResolveBodySortAnchorFromTransform(sourceTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (request.AttachToMount && TryResolveBodySortAnchorFromTransform(mountTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (request.AttachToProjectile && TryResolveBodySortAnchorFromTransform(projectileTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (TryResolveBodySortAnchorFromTransform(targetTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (TryResolveBodySortAnchorFromTransform(sourceTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (TryResolveBodySortAnchorFromTransform(mountTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		if (TryResolveBodySortAnchorFromTransform(projectileTransform, out bodySortingOrder, out sortingLayerId))
		{
			return true;
		}
		bodySortingOrder = 0;
		sortingLayerId = 0;
		return false;
	}

	private static bool TryResolveBodySortAnchorFromTransform(Transform anchor, out int bodySortingOrder, out int sortingLayerId)
	{
		if (anchor == null)
		{
			bodySortingOrder = 0;
			sortingLayerId = 0;
			return false;
		}
		if (TryResolveBodyRenderer(anchor, out var bodyRenderer) && bodyRenderer != null)
		{
			bodySortingOrder = bodyRenderer.sortingOrder;
			sortingLayerId = bodyRenderer.sortingLayerID;
			return true;
		}
		VehicleSimpleProjectile componentInParent = anchor.GetComponentInParent<VehicleSimpleProjectile>();
		if (componentInParent != null && componentInParent.TryGetVisualSortAnchor(out var sortingOrder, out var sortingLayerId2))
		{
			bodySortingOrder = sortingOrder - 2;
			sortingLayerId = sortingLayerId2;
			return true;
		}
		Renderer componentInChildren = anchor.GetComponentInChildren<Renderer>(includeInactive: true);
		if (componentInChildren != null)
		{
			bodySortingOrder = componentInChildren.sortingOrder - 3;
			sortingLayerId = componentInChildren.sortingLayerID;
			return true;
		}
		bodySortingOrder = 0;
		sortingLayerId = 0;
		return false;
	}

	private static bool TryResolveBodyRenderer(Transform anchor, out Renderer bodyRenderer)
	{
		Transform transform = anchor;
		while (transform != null)
		{
			Transform transform2 = transform.Find("BodyVisual");
			if (transform2 != null)
			{
				bodyRenderer = transform2.GetComponentInChildren<Renderer>(includeInactive: true);
				if (bodyRenderer != null)
				{
					return true;
				}
			}
			transform = transform.parent;
		}
		bodyRenderer = null;
		return false;
	}

	private static string NormalizeEffectPath(string rawPath)
	{
		if (string.IsNullOrWhiteSpace(rawPath))
		{
			return string.Empty;
		}
		string text = rawPath.Trim();
		if (text.StartsWith("summerrace/effect/", StringComparison.OrdinalIgnoreCase))
		{
			return text;
		}
		if (text.IndexOf('/') >= 0)
		{
			return text;
		}
		return "summerrace/effect/" + text;
	}

	private static void RaiseEffectAboveTargetVisual(GameObject effectInstance, Transform targetTransform, int minOffset)
	{
		if (effectInstance == null || targetTransform == null || !TryResolveTopRendererSortAnchor(targetTransform, out var sortingLayerId, out var sortingOrder))
		{
			return;
		}
		int num = sortingOrder + Mathf.Max(0, minOffset);
		SortingGroup[] componentsInChildren = effectInstance.GetComponentsInChildren<SortingGroup>(includeInactive: true);
		if (componentsInChildren != null && componentsInChildren.Length != 0)
		{
			int num2 = int.MaxValue;
			foreach (SortingGroup sortingGroup in componentsInChildren)
			{
				if (!(sortingGroup == null))
				{
					num2 = Mathf.Min(num2, sortingGroup.sortingOrder);
				}
			}
			int num3 = ((num2 != int.MaxValue) ? (num - num2) : 0);
			foreach (SortingGroup sortingGroup2 in componentsInChildren)
			{
				if (!(sortingGroup2 == null))
				{
					sortingGroup2.sortingLayerID = sortingLayerId;
					sortingGroup2.sortingOrder += num3;
				}
			}
		}
		Renderer[] componentsInChildren2 = effectInstance.GetComponentsInChildren<Renderer>(includeInactive: true);
		if (componentsInChildren2 == null || componentsInChildren2.Length == 0)
		{
			return;
		}
		int num4 = int.MaxValue;
		foreach (Renderer renderer in componentsInChildren2)
		{
			if (!(renderer == null))
			{
				num4 = Mathf.Min(num4, renderer.sortingOrder);
			}
		}
		int num5 = ((num4 != int.MaxValue) ? (num - num4) : 0);
		foreach (Renderer renderer2 in componentsInChildren2)
		{
			if (!(renderer2 == null))
			{
				renderer2.sortingLayerID = sortingLayerId;
				renderer2.sortingOrder += num5;
			}
		}
	}

	private static bool TryResolveTopRendererSortAnchor(Transform root, out int sortingLayerId, out int sortingOrder)
	{
		sortingLayerId = 0;
		sortingOrder = 0;
		if (root == null)
		{
			return false;
		}
		Renderer[] componentsInChildren = root.GetComponentsInChildren<Renderer>(includeInactive: true);
		bool flag = false;
		int num = int.MinValue;
		int num2 = 0;
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer == null) && (!flag || renderer.sortingOrder > num))
			{
				flag = true;
				num = renderer.sortingOrder;
				num2 = renderer.sortingLayerID;
			}
		}
		if (!flag)
		{
			return false;
		}
		sortingLayerId = num2;
		sortingOrder = num;
		return true;
	}

	private Transform EnsureEffectRoot()
	{
		if (effectRoot != null)
		{
			return effectRoot;
		}
		GameObject gameObject = new GameObject(base.name + "_ComEffectRoot");
		gameObject.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
		effectRoot = gameObject.transform;
		return effectRoot;
	}

	private static Quaternion ResolveWorldRotation(Vector2 direction)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float z = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		return Quaternion.Euler(0f, 0f, z);
	}

	private static void ApplyDirectionalRotationForLoopFxIfNeeded(Transform effectTransform, string path, Transform sourceTransform, Transform mountTransform)
	{
		if (!(effectTransform == null) && !string.IsNullOrEmpty(path) && string.Equals(path, "summerrace/effect/fx_summerrace_thruster", StringComparison.Ordinal))
		{
			Vector2 direction = ResolveThrusterExpectedJetDirection(sourceTransform, mountTransform);
			effectTransform.rotation = ResolveWorldRotation(direction) * Quaternion.Euler(0f, 0f, 180f);
		}
	}

	private static Vector2 ResolveThrusterExpectedJetDirection(Transform sourceTransform, Transform mountTransform)
	{
		if (sourceTransform != null)
		{
			Vector2 vector = ResolveEffectForwardAxis(sourceTransform);
			if (vector.sqrMagnitude <= 0.0001f)
			{
				vector = Vector2.right;
			}
			if (sourceTransform.GetComponent<SummerRacePlayerController>() != null)
			{
				return -vector;
			}
			if (sourceTransform.GetComponent<SummerRaceEnemy>() != null)
			{
				return vector;
			}
		}
		Vector2 vector2 = ResolveEffectForwardAxis((mountTransform != null) ? mountTransform : sourceTransform);
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			vector2 = Vector2.right;
		}
		return -vector2;
	}

	private static void ApplyDirectionalRotationForMuzzleFxIfNeeded(Transform effectTransform, string path, Vector2 rotationDirection, Vector2 eventDirection, Transform mountTransform, string channel, string phase)
	{
		if (!(effectTransform == null) && !string.IsNullOrEmpty(path))
		{
			Vector2 vector = ((eventDirection.sqrMagnitude > 0.0001f) ? eventDirection.normalized : ((rotationDirection.sqrMagnitude > 0.0001f) ? rotationDirection.normalized : Vector2.right));
			if (ShouldApplyPresentationDirectionRotation(path))
			{
				effectTransform.rotation = ResolveWorldRotation(vector) * Quaternion.Euler(0f, 0f, 180f);
				TraceMuzzleDirection(path, channel, phase, eventDirection, vector, mountTransform, effectTransform);
			}
			else
			{
				TraceMuzzleDirection(path, channel, phase, eventDirection, vector, mountTransform, effectTransform);
			}
		}
	}

	private static bool ShouldApplyPresentationDirectionRotation(string path)
	{
		if (!string.Equals(path, "summerrace/effect/fx_summerrace_machinegun", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_scattershel", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_scattershel_baozha", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_lasercannon_juqi", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_lasercannon", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_boxing", StringComparison.Ordinal) && !string.Equals(path, "summerrace/effect/fx_summerrace_electricnet", StringComparison.Ordinal))
		{
			return string.Equals(path, "summerrace/effect/fx_summerrace_hook", StringComparison.Ordinal);
		}
		return true;
	}

	private static void TraceMuzzleDirection(string path, string channel, string phase, Vector2 eventDirection, Vector2 desiredDirection, Transform mountTransform, Transform effectTransform)
	{
		if (!(mountTransform == null) && !(effectTransform == null))
		{
			Vector2 vector = ResolveEffectForwardAxis(mountTransform);
			Vector2 lhs = ResolveEffectForwardAxis(effectTransform);
			SummerRaceRuntimeLog.Verbose("[SummerRace][ComEffect][Dir] path=" + path + " channel=" + channel + " phase=" + phase + " eventDir=" + eventDirection.ToString() + " desiredDir=" + desiredDirection.ToString() + " mountForward=" + vector.ToString() + " finalForward=" + lhs.ToString() + " dot(final,desired)=" + Vector2.Dot(lhs, desiredDirection).ToString("F3"));
		}
	}

	private static Vector2 ResolveEffectForwardAxis(Transform effectTransform)
	{
		if (effectTransform == null)
		{
			return Vector2.right;
		}
		float num = ((effectTransform.lossyScale.x >= 0f) ? 1f : (-1f));
		Vector3 vector = effectTransform.right * num;
		Vector2 vector2 = new Vector2(vector.x, vector.y);
		if (!(vector2.sqrMagnitude > 0.0001f))
		{
			return Vector2.right;
		}
		return vector2.normalized;
	}

	private static string BuildRouteKey(string kind, SummerRacePresentationPhase phase)
	{
		return kind + ":" + phase;
	}

	private static bool IsRotatingSawLoopEffect(string path)
	{
		return string.Equals(path, "summerrace/effect/fx_summerrace_rotatingsaw", StringComparison.Ordinal);
	}

	private static Vector3 ResolveAttachLocalOffset(string path, Transform attachTarget)
	{
		if (attachTarget == null || string.IsNullOrEmpty(path))
		{
			return Vector3.zero;
		}
		if (!IsRotatingSawLoopEffect(path))
		{
			return Vector3.zero;
		}
		MountPoint componentInParent = attachTarget.GetComponentInParent<MountPoint>();
		if (componentInParent == null)
		{
			throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw attach target has no mount point parent.");
		}
		if (!(componentInParent.InstalledModule is WeaponModuleDefinition weaponModuleDefinition))
		{
			throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw attach target module is invalid.");
		}
		if (SummerRaceCombatPresentationRouter.ResolveWeaponKind(weaponModuleDefinition) != WeaponKind.RotatingSaw)
		{
			throw new InvalidOperationException("[SummerRace][ComEffect] RotatingSaw attach target module kind mismatch. weapon=" + weaponModuleDefinition.name);
		}
		return new Vector3(-1.45f, 0f, 0f);
	}

	private static RoutedEffectEntry BuildOneShotMountRoute(string leafPath, float explicitLifetimeSeconds = 0f)
	{
		return new RoutedEffectEntry(new EffectPlayRequest("summerrace/effect/" + leafPath, loop: false, attachToMount: true, attachToSource: false, attachToTarget: false, attachToProjectile: false, explicitLifetimeSeconds), stopLoop: false);
	}

	private static RoutedEffectEntry BuildOneShotTargetRoute(string leafPath)
	{
		return new RoutedEffectEntry(new EffectPlayRequest("summerrace/effect/" + leafPath, loop: false, attachToMount: false, attachToSource: false, attachToTarget: true, attachToProjectile: false), stopLoop: false);
	}

	private static RoutedEffectEntry BuildLoopMountRoute(string leafPath, bool stopLoop)
	{
		return new RoutedEffectEntry(new EffectPlayRequest("summerrace/effect/" + leafPath, loop: true, attachToMount: true, attachToSource: false, attachToTarget: false, attachToProjectile: false), stopLoop);
	}

	private static RoutedEffectEntry BuildLoopProjectileRoute(string leafPath, bool stopLoop)
	{
		return new RoutedEffectEntry(new EffectPlayRequest("summerrace/effect/" + leafPath, loop: true, attachToMount: false, attachToSource: false, attachToTarget: false, attachToProjectile: true), stopLoop);
	}

	private static float ResolveOneShotLifetimeOrThrow(GameObject instance, string path, float explicitLifetimeSeconds)
	{
		if (instance == null)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] instance is null while resolving lifetime. fallback=" + 1f + " path=" + path);
			return 1f;
		}
		if (explicitLifetimeSeconds > 0f)
		{
			return explicitLifetimeSeconds;
		}
		float num = 0f;
		bool flag = false;
		ParticleSystem[] componentsInChildren = instance.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		foreach (ParticleSystem particleSystem in componentsInChildren)
		{
			if (particleSystem == null)
			{
				continue;
			}
			ParticleSystem.MainModule main = particleSystem.main;
			if (!main.loop)
			{
				float num2 = Mathf.Max(0.0001f, main.simulationSpeed);
				float num3 = ResolveMinMaxCurveDuration(main.startLifetime);
				float num4 = (main.duration + num3) / num2;
				if (!(num4 <= 0f))
				{
					flag = true;
					num = Mathf.Max(num, num4);
				}
			}
		}
		Animator[] componentsInChildren2 = instance.GetComponentsInChildren<Animator>(includeInactive: true);
		foreach (Animator animator in componentsInChildren2)
		{
			if (animator == null || animator.runtimeAnimatorController == null)
			{
				continue;
			}
			AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
			foreach (AnimationClip animationClip in animationClips)
			{
				if (!(animationClip == null) && !(animationClip.length <= 0f))
				{
					flag = true;
					num = Mathf.Max(num, animationClip.length / Mathf.Max(0.0001f, animator.speed));
				}
			}
		}
		if (!flag || num <= 0f)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][ComEffect] failed to resolve finite one-shot lifetime. fallback=" + 1f + " path=" + path + ". Please author non-looping particle or animation clip.");
			return 1f;
		}
		return num;
	}

	private static float ResolveMinMaxCurveDuration(ParticleSystem.MinMaxCurve curve)
	{
		switch ((int)curve.mode)
		{
		case 0:
			return Mathf.Max(0f, curve.constant);
		case 3:
			return Mathf.Max(0f, Mathf.Max(curve.constantMin, curve.constantMax));
		case 1:
			if (curve.curve == null || curve.curve.length <= 0)
			{
				return 0f;
			}
			return Mathf.Max(0f, curve.curve.keys[curve.curve.length - 1].value) * curve.curveMultiplier;
		case 2:
		{
			float a = ((curve.curveMax != null && curve.curveMax.length > 0) ? curve.curveMax.keys[curve.curveMax.length - 1].value : 0f);
			float b = ((curve.curveMin != null && curve.curveMin.length > 0) ? curve.curveMin.keys[curve.curveMin.length - 1].value : 0f);
			return Mathf.Max(0f, Mathf.Max(a, b)) * curve.curveMultiplier;
		}
		default:
			return 0f;
		}
	}

	private static string BuildLoopKey(Transform sourceTransform, int slotOrCorrelation, string path)
	{
		int num = ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0);
		return num + ":" + slotOrCorrelation + ":" + path;
	}

	private static bool TryResolveWeaponRequest(SummerRaceWeaponPresentationEvent presentationEvent, out EffectPlayRequest request, out bool stopLoop)
	{
		string key = BuildRouteKey(presentationEvent.WeaponKind.ToString(), presentationEvent.Phase);
		if (!WeaponEffectRouteTable.TryGetValue(key, out var value))
		{
			request = default(EffectPlayRequest);
			stopLoop = false;
			return false;
		}
		request = value.Request;
		stopLoop = value.StopLoop;
		return true;
	}

	private static bool TryResolveEquipRequest(SummerRaceEquipPresentationEvent presentationEvent, out EffectPlayRequest request, out bool stopLoop)
	{
		string key = BuildRouteKey(presentationEvent.EquipKind.ToString(), presentationEvent.Phase);
		if (!EquipEffectRouteTable.TryGetValue(key, out var value))
		{
			request = default(EffectPlayRequest);
			stopLoop = false;
			return false;
		}
		request = value.Request;
		stopLoop = value.StopLoop;
		return true;
	}

	private static bool TryResolveProjectileRequest(SummerRaceProjectilePresentationEvent presentationEvent, out EffectPlayRequest request, out bool stopLoop)
	{
		string key = BuildRouteKey(presentationEvent.DeliveryKind.ToString(), presentationEvent.Phase);
		if (!ProjectileEffectRouteTable.TryGetValue(key, out var value))
		{
			request = default(EffectPlayRequest);
			stopLoop = false;
			return false;
		}
		request = value.Request;
		stopLoop = value.StopLoop;
		return true;
	}

	private static EffectPlayRequest ResolveShieldBodyRequestOrThrow(Transform sourceTransform, bool loop, bool end)
	{
		SummerRaceBodyType summerRaceBodyType = ResolveBodyTypeFromSourceOrThrow(sourceTransform);
		string text = (end ? "shield_end" : "shield_loop");
		float explicitLifetimeSeconds = (end ? 1f : 0f);
		return new EffectPlayRequest("summerrace/effect/fx_summerracebody_" + summerRaceBodyType switch
		{
			SummerRaceBodyType.Light => "light", 
			SummerRaceBodyType.Medium => "medium", 
			SummerRaceBodyType.Heavy => "heavy", 
			_ => throw new InvalidOperationException("[SummerRace][ComEffect] unsupported body type for shield effect: " + summerRaceBodyType), 
		} + "_" + text, loop, attachToMount: false, attachToSource: true, attachToTarget: false, attachToProjectile: false, explicitLifetimeSeconds);
	}

	private static EffectPlayRequest ResolveElectricNetBodyRequestOrThrow(Transform targetTransform, bool loop, float explicitLifetimeSeconds)
	{
		SummerRaceBodyType summerRaceBodyType = ResolveBodyTypeFromSourceOrThrow(targetTransform);
		return new EffectPlayRequest(summerRaceBodyType switch
		{
			SummerRaceBodyType.Light => ElectricNetBodyLoopPathLight, 
			SummerRaceBodyType.Medium => ElectricNetBodyLoopPathMedium, 
			SummerRaceBodyType.Heavy => ElectricNetBodyLoopPathHeavy, 
			_ => throw new InvalidOperationException("[SummerRace][ComEffect] unsupported body type for electric net effect: " + summerRaceBodyType), 
		}, loop, attachToMount: false, attachToSource: false, attachToTarget: true, attachToProjectile: false, explicitLifetimeSeconds);
	}

	private static string BuildElectricNetLoopKey(Transform sourceTransform, int slotIndex, string path, int targetKey)
	{
		int num = ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0);
		return "electricnet:" + num + ":" + slotIndex + ":" + targetKey + ":" + path;
	}

	private static int ResolveElectricNetTargetKey(Transform targetTransform)
	{
		if (!(targetTransform != null))
		{
			return 0;
		}
		return targetTransform.GetInstanceID();
	}

	private static string BuildElectricNetSourceSlotKey(Transform sourceTransform, int slotIndex)
	{
		return ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0) + ":" + slotIndex;
	}

	private void PlayOrRefreshElectricNetTargetLoop(SummerRaceEquipPresentationEvent presentationEvent)
	{
		if (presentationEvent.TargetTransform == null)
		{
			return;
		}
		int num = ResolveElectricNetTargetKey(presentationEvent.TargetTransform);
		if (num == 0)
		{
			return;
		}
		string text = BuildElectricNetSourceSlotKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex);
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		AddElectricNetSourceSlotTargetClaim(text, num);
		EffectPlayRequest request = ResolveElectricNetBodyRequestOrThrow(presentationEvent.TargetTransform, loop: true, 0f);
		if (ShouldVerboseLog)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][ComEffect][ElectricNetBody] target=" + presentationEvent.TargetTransform.name + " path=" + request.Path + " source=" + ((presentationEvent.SourceTransform != null) ? presentationEvent.SourceTransform.name : "<null>"));
		}
		if (electricNetLoopByTarget.TryGetValue(num, out var value) && value != null)
		{
			value.SourceSlotClaims.Add(text);
			float value2 = Time.time + Mathf.Max(0.1f, presentationEvent.ActiveDuration);
			value.SourceSlotExpireAt[text] = value2;
			electricNetLoopExpireAtByTarget[num] = ResolveMaxClaimExpireAt(value);
		}
		if (!electricNetLoopByTarget.TryGetValue(num, out var value3) || value3 == null || string.IsNullOrEmpty(value3.LoopKey) || !activeLoopEffects.ContainsKey(value3.LoopKey))
		{
			string text2 = BuildElectricNetLoopKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex, request.Path, num);
			PlayEffect(request, text2, presentationEvent.SourceTransform, presentationEvent.TargetTransform, presentationEvent.TargetTransform, null, presentationEvent.Position, presentationEvent.Direction, "equip_body", presentationEvent.Phase.ToString(), presentationEvent.EquipKind.ToString());
			if (activeLoopEffects.ContainsKey(text2))
			{
				ElectricNetLoopState electricNetLoopState = new ElectricNetLoopState
				{
					Path = request.Path,
					LoopKey = text2
				};
				electricNetLoopState.SourceSlotClaims.Add(text);
				electricNetLoopState.SourceSlotExpireAt[text] = Time.time + Mathf.Max(0.1f, presentationEvent.ActiveDuration);
				electricNetLoopByTarget[num] = electricNetLoopState;
				electricNetLoopExpireAtByTarget[num] = ResolveMaxClaimExpireAt(electricNetLoopState);
			}
		}
	}

	private void TryStopElectricNetLoopBySourceSlot(Transform sourceTransform, int slotIndex, SummerRacePresentationPhase phase, string equipKind)
	{
		string text = BuildElectricNetSourceSlotKey(sourceTransform, slotIndex);
		if (string.IsNullOrEmpty(text) || !electricNetTargetsBySourceSlot.TryGetValue(text, out var value) || value == null || value.Count <= 0)
		{
			return;
		}
		electricNetTargetKeyScratch.Clear();
		foreach (int item in value)
		{
			electricNetTargetKeyScratch.Add(item);
		}
		for (int i = 0; i < electricNetTargetKeyScratch.Count; i++)
		{
			int key = electricNetTargetKeyScratch[i];
			if (electricNetLoopByTarget.TryGetValue(key, out var value2) && value2 != null)
			{
				value2.SourceSlotClaims.Remove(text);
				value2.SourceSlotExpireAt.Remove(text);
				if (value2.SourceSlotClaims.Count > 0)
				{
					electricNetLoopExpireAtByTarget[key] = ResolveMaxClaimExpireAt(value2);
					continue;
				}
				StopLoop(value2.LoopKey, value2.Path, "equip_body", phase, equipKind);
				electricNetLoopByTarget.Remove(key);
				electricNetLoopExpireAtByTarget.Remove(key);
			}
		}
		electricNetTargetsBySourceSlot.Remove(text);
	}

	private void AddElectricNetSourceSlotTargetClaim(string sourceSlotKey, int targetKey)
	{
		if (!string.IsNullOrEmpty(sourceSlotKey) && targetKey != 0)
		{
			if (!electricNetTargetsBySourceSlot.TryGetValue(sourceSlotKey, out var value) || value == null)
			{
				value = new HashSet<int>();
				electricNetTargetsBySourceSlot[sourceSlotKey] = value;
			}
			value.Add(targetKey);
		}
	}

	private void RemoveTargetFromAllElectricNetSourceSlotMaps(int targetKey)
	{
		if (targetKey == 0 || electricNetTargetsBySourceSlot.Count <= 0)
		{
			return;
		}
		electricNetSourceSlotScratch.Clear();
		foreach (KeyValuePair<string, HashSet<int>> item in electricNetTargetsBySourceSlot)
		{
			HashSet<int> value = item.Value;
			if (value != null && value.Remove(targetKey) && value.Count <= 0)
			{
				electricNetSourceSlotScratch.Add(item.Key);
			}
		}
		for (int i = 0; i < electricNetSourceSlotScratch.Count; i++)
		{
			electricNetTargetsBySourceSlot.Remove(electricNetSourceSlotScratch[i]);
		}
	}

	private void PruneEmptyElectricNetSourceSlotMaps()
	{
		if (electricNetTargetsBySourceSlot.Count <= 0)
		{
			return;
		}
		electricNetSourceSlotScratch.Clear();
		foreach (KeyValuePair<string, HashSet<int>> item in electricNetTargetsBySourceSlot)
		{
			if (item.Value == null || item.Value.Count <= 0)
			{
				electricNetSourceSlotScratch.Add(item.Key);
			}
		}
		for (int i = 0; i < electricNetSourceSlotScratch.Count; i++)
		{
			electricNetTargetsBySourceSlot.Remove(electricNetSourceSlotScratch[i]);
		}
	}

	private static float ResolveMaxClaimExpireAt(ElectricNetLoopState state)
	{
		if (state == null || state.SourceSlotExpireAt == null || state.SourceSlotExpireAt.Count <= 0)
		{
			return 0f;
		}
		float num = 0f;
		foreach (KeyValuePair<string, float> item in state.SourceSlotExpireAt)
		{
			num = Mathf.Max(num, item.Value);
		}
		return num;
	}

	private static void TrimExpiredElectricNetClaims(ElectricNetLoopState state, float now)
	{
		if (state == null || state.SourceSlotExpireAt == null || state.SourceSlotExpireAt.Count <= 0)
		{
			return;
		}
		List<string> list = null;
		foreach (KeyValuePair<string, float> item in state.SourceSlotExpireAt)
		{
			if (!(now < item.Value))
			{
				if (list == null)
				{
					list = new List<string>(2);
				}
				list.Add(item.Key);
			}
		}
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				string text = list[i];
				state.SourceSlotExpireAt.Remove(text);
				state.SourceSlotClaims.Remove(text);
			}
		}
	}

	private static SummerRaceBodyType ResolveBodyTypeFromSourceOrThrow(Transform sourceTransform)
	{
		if (sourceTransform == null)
		{
			throw new InvalidOperationException("[SummerRace][ComEffect] source transform is null while resolving body type.");
		}
		ISummerRaceBuildProfileProvider summerRaceBuildProfileProvider = sourceTransform.GetComponent<ISummerRaceBuildProfileProvider>();
		if (summerRaceBuildProfileProvider == null)
		{
			summerRaceBuildProfileProvider = sourceTransform.GetComponentInParent<ISummerRaceBuildProfileProvider>();
		}
		if (summerRaceBuildProfileProvider == null)
		{
			throw new InvalidOperationException("[SummerRace][ComEffect] missing build profile provider on source transform " + sourceTransform.name);
		}
		return summerRaceBuildProfileProvider.GetBuildProfile().BodyType;
	}
}
