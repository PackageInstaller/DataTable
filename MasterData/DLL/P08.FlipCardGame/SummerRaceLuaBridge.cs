using System;
using System.Reflection;
using LuaInterface;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class SummerRaceLuaBridge
{
	[Serializable]
	private sealed class BodyMountLayoutPayload
	{
		public string chassisPrefabPath = string.Empty;

		public string bodySkeletonDataPath = string.Empty;

		public BodyWheelPayload[] wheels = Array.Empty<BodyWheelPayload>();

		public BodyMountPointPayload[] mountPoints = Array.Empty<BodyMountPointPayload>();

		public Vector2 bodyBoundsSize = Vector2.zero;

		public Vector2 bodyBoundsCenter = Vector2.zero;

		public string mappingVersion = string.Empty;
	}

	[Serializable]
	private sealed class BodyWheelPayload
	{
		public string name = string.Empty;

		public Vector2 localPosition;

		public float radius;

		public float width;

		public string wheelSpritePath = string.Empty;

		public string innerWheelSpritePath = string.Empty;

		public float wheelVisualScale = 1f;
	}

	[Serializable]
	private sealed class BodyMountPointPayload
	{
		public int slotType;

		public int slotIndex;

		public Vector2 localPosition;

		public Vector2 displayLocalPosition;

		public float localAngle;
	}

	[Serializable]
	private sealed class OptionVisualLayoutPayload
	{
		public string skeletonDataPath = string.Empty;

		public Vector2 localOffset = Vector2.zero;

		public float localAngle;

		public float scale = 1f;

		public Vector2 moduleSize = Vector2.one;

		public Vector2 muzzleLocalOffset = Vector2.zero;

		public string projectileSpineSkeletonDataPath = string.Empty;

		public Vector2 projectileSpineLocalOffset = Vector2.zero;

		public float projectileSpineLocalAngle;

		public float projectileSpineScale = 1f;

		public string impactSpineSkeletonDataPath = string.Empty;

		public Vector2 impactSpineLocalOffset = Vector2.zero;

		public float impactSpineLocalAngle;

		public float impactSpineScale = 1f;

		public string hookHeadSpineSkeletonDataPath = string.Empty;

		public Vector2 hookHeadSpineLocalOffset = Vector2.zero;

		public float hookHeadSpineLocalAngle;

		public float hookHeadSpineScale = 1f;

		public string hookRopeSpineSkeletonDataPath = string.Empty;

		public int hookRopeBoneCount = 12;

		public float hookRopeMaxLength = 3f;

		public float hookRopeDamping = 8f;

		public float hookRopeStiffness = 28f;
	}

	[Serializable]
	public sealed class SummerRaceDamageTextEvent
	{
		public int amount;

		public string state = string.Empty;

		public float worldX;

		public float worldY;

		public float worldZ;

		public string targetTeam = string.Empty;

		public string source = string.Empty;
	}

	[Serializable]
	public sealed class SummerRacePlayerLabelPoseEvent
	{
		public float playerLabelWorldX;

		public float playerLabelWorldY;

		public float playerLabelWorldZ;

		public float playerLabelScreenOffsetY;
	}

	public const string RuntimeSnapshotEventName = "SummerRace.BattleSnapshot";

	public const string SettlementEventName = "SummerRace.BattleSettlement";

	public const string StageResolvedEventName = "SummerRace.StageResolved";

	public const string SpecialDefeatEventName = "SummerRace.SpecialDefeat";

	public const string SpecialDefeatFinishedEventName = "SummerRace.SpecialDefeatFinished";

	public const string EnemyDefeatBeforeFxEventName = "SummerRace.EnemyDefeatBeforeFx";

	public const string TimeoutResultEventName = "SummerRace.TimeoutResult";

	public const string BattleResultBannerEventName = "SummerRace.BattleResultBanner";

	private const bool TraceBridgeLog = true;

	private static readonly string[] DefaultBodySkinStack = new string[3] { "default", "car/che_1", "car/che_2" };

	private static Skin BuildRuntimeSkinStack(SkeletonData skeletonData, string[] skinNames)
	{
		Skin skin = new Skin("SummerRaceRuntimeSkin");
		if (skeletonData == null || skinNames == null)
		{
			return skin;
		}
		foreach (string text in skinNames)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				Skin skin2 = skeletonData.FindSkin(text.Trim());
				if (skin2 == null)
				{
					SummerRaceRuntimeLog.Warning("[SummerRace][LuaBridge] missing body skin: " + text);
				}
				else
				{
					skin.AddSkin(skin2);
				}
			}
		}
		return skin;
	}

	private static SummerRaceFightManager GetManager()
	{
		return SummerRaceFightManager.Instance;
	}

	private static SummerRacePlayerController GetPlayer()
	{
		SummerRaceFightManager manager = GetManager();
		if (!(manager != null))
		{
			return null;
		}
		return manager.CurrentPlayer;
	}

	private static void TraceLog(string message)
	{
		SummerRaceRuntimeLog.Log(message);
	}

	private static LuaFunction GetOptionalBridgeCallback(string functionName)
	{
		LuaState luaState = LuaHelper.GetLuaState();
		if (luaState == null)
		{
			return null;
		}
		return luaState.GetFunction(functionName, beLogMiss: false);
	}

	private static void CallOptionalBridgeCallback(string functionName, params object[] args)
	{
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback(functionName);
		if (optionalBridgeCallback == null)
		{
			return;
		}
		try
		{
			optionalBridgeCallback.LazyCall(args);
		}
		catch (Exception innerException)
		{
			SummerRaceRuntimeLog.Exception(new InvalidOperationException("[SummerRace][LuaBridge] callback failed: " + functionName, innerException));
		}
	}

	private static void LogSkillRequest(string action, int slotIndex, bool success, string reason, SummerRaceFightManager manager, SummerRacePlayerController player)
	{
		SummerRaceBattleSnapshot summerRaceBattleSnapshot = ((manager != null) ? manager.GetBattleRuntimeSnapshot() : null);
		string text = ((summerRaceBattleSnapshot != null) ? summerRaceBattleSnapshot.mode : "None");
		string text2 = ((manager != null) ? manager.DebugPhase : "None");
		string text3 = ((player != null) ? (player.CurrentHP.ToString("F1") + "/" + player.MaxHP.ToString("F1")) : "N/A");
		string text4 = ((player != null) ? (player.CurrentEnergy.ToString("F1") + "/" + player.MaxEnergy.ToString("F1")) : "N/A");
		string text5 = reason;
		if (player != null && player.LastSkillAction == action && player.LastSkillSlotIndex == slotIndex)
		{
			text5 = player.LastSkillReason;
		}
		SummerRaceRuntimeLog.Log("[SummerRace][LuaBridgeSkill] action=" + action + " slot=" + slotIndex + " success=" + success + " reason=" + text5 + " mode=" + text + " phase=" + text2 + " hp=" + text3 + " energy=" + text4);
	}

	private static bool IsSkillInputEnabled(SummerRaceFightManager manager)
	{
		if (manager != null)
		{
			return manager.IsBattleActive;
		}
		return false;
	}

	public static bool RequestUseWeaponSlot(int slotIndex)
	{
		SummerRaceFightManager manager = GetManager();
		SummerRacePlayerController summerRacePlayerController = ((manager != null) ? manager.CurrentPlayer : null);
		if (!IsSkillInputEnabled(manager))
		{
			LogSkillRequest("weapon_use", slotIndex, success: false, "phase_blocked", manager, summerRacePlayerController);
			return false;
		}
		if (summerRacePlayerController == null)
		{
			LogSkillRequest("weapon_use", slotIndex, success: false, "player_nil", manager, summerRacePlayerController);
			return false;
		}
		bool flag = summerRacePlayerController.RequestUseWeaponSlot(slotIndex);
		manager?.ForcePublishRuntimeSnapshot();
		LogSkillRequest("weapon_use", slotIndex, flag, flag ? "ok" : "player_reject", manager, summerRacePlayerController);
		return flag;
	}

	public static bool RequestUseEquipSlot(int slotIndex)
	{
		SummerRaceFightManager manager = GetManager();
		SummerRacePlayerController summerRacePlayerController = ((manager != null) ? manager.CurrentPlayer : null);
		if (!IsSkillInputEnabled(manager))
		{
			LogSkillRequest("equip_use", slotIndex, success: false, "phase_blocked", manager, summerRacePlayerController);
			return false;
		}
		if (summerRacePlayerController == null)
		{
			LogSkillRequest("equip_use", slotIndex, success: false, "player_nil", manager, summerRacePlayerController);
			return false;
		}
		bool flag = summerRacePlayerController.RequestUseEquipSlot(slotIndex);
		manager?.ForcePublishRuntimeSnapshot();
		LogSkillRequest("equip_use", slotIndex, flag, flag ? "ok" : "player_reject", manager, summerRacePlayerController);
		return flag;
	}

	public static bool RequestOverloadWeaponSlot(int slotIndex)
	{
		SummerRaceFightManager manager = GetManager();
		SummerRacePlayerController summerRacePlayerController = ((manager != null) ? manager.CurrentPlayer : null);
		if (!IsSkillInputEnabled(manager))
		{
			LogSkillRequest("weapon_overload", slotIndex, success: false, "phase_blocked", manager, summerRacePlayerController);
			return false;
		}
		if (summerRacePlayerController == null)
		{
			LogSkillRequest("weapon_overload", slotIndex, success: false, "player_nil", manager, summerRacePlayerController);
			return false;
		}
		bool flag = summerRacePlayerController.RequestOverloadWeaponSlot(slotIndex);
		manager?.ForcePublishRuntimeSnapshot();
		LogSkillRequest("weapon_overload", slotIndex, flag, flag ? "ok" : "player_reject", manager, summerRacePlayerController);
		return flag;
	}

	public static bool RequestToggleAds()
	{
		SummerRacePlayerController player = GetPlayer();
		if (player == null)
		{
			return false;
		}
		player.RequestToggleAds();
		return true;
	}

	public static bool RequestSetManualAccelerationNormalized(float normalized)
	{
		SummerRacePlayerController player = GetPlayer();
		if (player == null)
		{
			return false;
		}
		player.RequestSetManualAccelerationNormalized(normalized);
		return true;
	}

	public static bool RequestSetPaused(bool paused)
	{
		SummerRaceFightManager manager = GetManager();
		if (manager == null)
		{
			return false;
		}
		return manager.RequestSetPaused(paused);
	}

	public static bool RequestGiveUpBattle()
	{
		SummerRaceFightManager manager = GetManager();
		if (manager == null)
		{
			return false;
		}
		return manager.RequestGiveUpBattle();
	}

	public static bool RequestNotifySpecialDefeatBlackoutFinished(int token)
	{
		SummerRaceFightManager manager = GetManager();
		if (manager == null)
		{
			return false;
		}
		manager.NotifySpecialDefeatBlackoutFinished(token);
		return true;
	}

	public static bool RequestNotifySpecialDefeatGuideFinished(int token)
	{
		SummerRaceFightManager manager = GetManager();
		if (manager == null)
		{
			return false;
		}
		manager.NotifySpecialDefeatGuideFinished(token);
		return true;
	}

	public static bool RequestNotifyEnemyDefeatGuideFinished(int token)
	{
		SummerRaceFightManager manager = GetManager();
		if (manager == null)
		{
			return false;
		}
		manager.NotifyEnemyDefeatGuideFinished(token);
		return true;
	}

	public static bool RequestUsePrimarySkill()
	{
		return RequestUseWeaponSlot(0);
	}

	public static bool RequestUseEquipSkill()
	{
		return RequestUseEquipSlot(0);
	}

	public static bool RequestPrepareBattleConfig(string launchJson)
	{
		try
		{
			TraceLog("[SummerRace][LuaBridge] RequestPrepareBattleConfig launchJsonLength=" + (launchJson?.Length ?? 0));
			SummerRaceFightManager.SetPendingLaunchConfigFromLuaJson(launchJson);
			return true;
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] RequestPrepareBattleConfig failed: " + ex.Message);
			return false;
		}
	}

	public static bool Launcher(string launchJson)
	{
		try
		{
			TraceLog("[SummerRace][LuaBridge] Launcher begin launchJsonLength=" + (launchJson?.Length ?? 0) + " currentScene=" + (SceneManager.GetActiveScene().name ?? string.Empty));
			if (SceneDirector.Instance != null && SceneDirector.Instance.isHanding)
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][LuaBridge] Launcher rejected while SceneDirector is handling.");
				return false;
			}
			SummerRaceFightManager.SetPendingLaunchConfigFromLuaJson(launchJson);
			SummerRaceSceneLoader summerRaceSceneLoader = NScene.Load<SummerRaceSceneLoader>();
			if (summerRaceSceneLoader == null)
			{
				SummerRaceFightManager.ClearPendingLaunchConfig();
				SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] Launcher failed: NScene.Load returned null.");
				return false;
			}
			TraceLog("[SummerRace][LuaBridge] Launcher accepted. sceneLoader=" + summerRaceSceneLoader.GetType().Name);
			return true;
		}
		catch (Exception ex)
		{
			SummerRaceFightManager.ClearPendingLaunchConfig();
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] Launcher failed: " + ex.Message);
			return false;
		}
	}

	public static bool ExitScene(Action callback)
	{
		try
		{
			Action action = callback ?? ((Action)delegate
			{
			});
			if (SceneDirector.Instance == null || NScene.GetCurrentScene() == null)
			{
				action();
				return true;
			}
			if (SceneDirector.Instance.isHanding)
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][LuaBridge] ExitScene rejected while SceneDirector is handling.");
				return false;
			}
			SceneDirector.Instance.LoadEmptyScene(action);
			return true;
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] ExitScene failed: " + ex.Message);
			return false;
		}
	}

	public static bool RequestPrepareOutGameStoryCamera(float orthographicSize)
	{
		try
		{
			SummerRaceFightManager manager = GetManager();
			if (manager != null)
			{
				manager.PrepareOutGameStoryCamera(orthographicSize);
				return true;
			}
			Camera main = Camera.main;
			if (main == null)
			{
				return false;
			}
			main.orthographic = false;
			main.orthographicSize = Mathf.Max(0.01f, orthographicSize);
			return true;
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] RequestPrepareOutGameStoryCamera failed: " + ex.Message);
			return false;
		}
	}

	public static bool RequestApplyPreparedLaunchForStandaloneValidation()
	{
		try
		{
			return SummerRaceFightManager.TryApplyPreparedLaunchForRuntimeRestart();
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] RequestApplyPreparedLaunchForStandaloneValidation failed: " + ex.Message);
			return false;
		}
	}

	public static string RequestGetBodyMountLayout(string bodyAssetName)
	{
		try
		{
			SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyConfigByAssetName<SummerRaceBodyDefSO>(bodyAssetName);
			if (summerRaceBodyDefSO == null)
			{
				return string.Empty;
			}
			int num = ((summerRaceBodyDefSO.mountPoints != null) ? summerRaceBodyDefSO.mountPoints.Count : 0);
			int num2 = ((summerRaceBodyDefSO.wheels != null) ? summerRaceBodyDefSO.wheels.Count : 0);
			BodyWheelPayload[] array = new BodyWheelPayload[num2];
			BodyMountPointPayload[] array2 = new BodyMountPointPayload[num];
			for (int i = 0; i < num2; i++)
			{
				SummerRaceWheelDefConfig summerRaceWheelDefConfig = summerRaceBodyDefSO.wheels[i] ?? new SummerRaceWheelDefConfig();
				if (string.IsNullOrWhiteSpace(summerRaceWheelDefConfig.wheelSpritePath))
				{
					throw new InvalidOperationException("[SummerRace][LuaBridge] missing wheel sprite path: bodyAsset=" + bodyAssetName + ", wheelIndex=" + i);
				}
				if (string.IsNullOrWhiteSpace(summerRaceWheelDefConfig.innerWheelSpritePath))
				{
					throw new InvalidOperationException("[SummerRace][LuaBridge] missing inner wheel sprite path: bodyAsset=" + bodyAssetName + ", wheelIndex=" + i);
				}
				if (summerRaceWheelDefConfig.wheelVisualScale <= 0f)
				{
					throw new InvalidOperationException("[SummerRace][LuaBridge] invalid wheel visual scale: bodyAsset=" + bodyAssetName + ", wheelIndex=" + i + ", scale=" + summerRaceWheelDefConfig.wheelVisualScale);
				}
				SummerRaceConfigLoader.LoadSpriteOrThrow(summerRaceWheelDefConfig.wheelSpritePath, "luaBridge bodyAsset=" + bodyAssetName + " wheelIndex=" + i + " field=wheelSpritePath");
				SummerRaceConfigLoader.LoadSpriteOrThrow(summerRaceWheelDefConfig.innerWheelSpritePath, "luaBridge bodyAsset=" + bodyAssetName + " wheelIndex=" + i + " field=innerWheelSpritePath");
				array[i] = new BodyWheelPayload
				{
					name = (summerRaceWheelDefConfig.name ?? string.Empty),
					localPosition = summerRaceWheelDefConfig.localPosition,
					radius = summerRaceWheelDefConfig.radius,
					width = summerRaceWheelDefConfig.width,
					wheelSpritePath = (summerRaceWheelDefConfig.wheelSpritePath ?? string.Empty),
					innerWheelSpritePath = (summerRaceWheelDefConfig.innerWheelSpritePath ?? string.Empty),
					wheelVisualScale = summerRaceWheelDefConfig.wheelVisualScale
				};
			}
			string text = summerRaceBodyDefSO.normalBodySpineSkeletonDataPath ?? string.Empty;
			SummerRaceBodyLayoutMapper.BodySkeletonBounds bodySkeletonBounds = SummerRaceBodyLayoutMapper.ResolveBodySkeletonBounds(summerRaceBodyDefSO, text);
			SummerRaceConfigLoader.BodyPrefabRuntimeData bodyPrefabRuntimeData = SummerRaceConfigLoader.LoadBodyPrefabRuntimeData((SummerRaceBodyType)summerRaceBodyDefSO.bodyType);
			for (int j = 0; j < num; j++)
			{
				SummerRaceMountPointDefConfig summerRaceMountPointDefConfig = summerRaceBodyDefSO.mountPoints[j] ?? new SummerRaceMountPointDefConfig();
				Vector2 displayLocalPosition = SummerRaceBodyLayoutMapper.AuthoringToDisplaySkeletonLocal(summerRaceMountPointDefConfig.localPosition, bodyPrefabRuntimeData.BodyVisualLocalPosition, bodyPrefabRuntimeData.BodyVisualLocalScale);
				array2[j] = new BodyMountPointPayload
				{
					slotType = (int)summerRaceMountPointDefConfig.slotType,
					slotIndex = summerRaceMountPointDefConfig.slotIndex,
					localPosition = summerRaceMountPointDefConfig.localPosition,
					displayLocalPosition = displayLocalPosition,
					localAngle = summerRaceMountPointDefConfig.localAngle
				};
			}
			BodyMountLayoutPayload obj = new BodyMountLayoutPayload
			{
				chassisPrefabPath = (summerRaceBodyDefSO.chassisPrefabPath ?? string.Empty),
				bodySkeletonDataPath = text,
				wheels = array,
				mountPoints = array2,
				bodyBoundsSize = bodySkeletonBounds.Size,
				bodyBoundsCenter = bodySkeletonBounds.Center,
				mappingVersion = "body_layout_mapper_v1"
			};
			if (string.IsNullOrWhiteSpace(obj.bodySkeletonDataPath))
			{
				throw new InvalidOperationException("[SummerRace][LuaBridge] missing body spine path: bodyAsset=" + bodyAssetName);
			}
			return JsonUtility.ToJson(obj);
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] RequestGetBodyMountLayout failed: " + ex.Message);
			return string.Empty;
		}
	}

	public static string RequestGetOptionVisualLayout(string optionType, string optionAssetName)
	{
		try
		{
			bool num = string.Equals(optionType, "weapon", StringComparison.OrdinalIgnoreCase);
			string empty = string.Empty;
			Vector2 zero = Vector2.zero;
			float num2 = 0f;
			float num3 = 1f;
			Vector2 one = Vector2.one;
			Vector2 muzzleLocalOffset = Vector2.zero;
			string projectileSpineSkeletonDataPath = string.Empty;
			Vector2 projectileSpineLocalOffset = Vector2.zero;
			float projectileSpineLocalAngle = 0f;
			float projectileSpineScale = 1f;
			string impactSpineSkeletonDataPath = string.Empty;
			Vector2 impactSpineLocalOffset = Vector2.zero;
			float impactSpineLocalAngle = 0f;
			float impactSpineScale = 1f;
			string hookHeadSpineSkeletonDataPath = string.Empty;
			Vector2 hookHeadSpineLocalOffset = Vector2.zero;
			float hookHeadSpineLocalAngle = 0f;
			float hookHeadSpineScale = 1f;
			string hookRopeSpineSkeletonDataPath = string.Empty;
			int hookRopeBoneCount = 12;
			float hookRopeMaxLength = 3f;
			float hookRopeDamping = 8f;
			float hookRopeStiffness = 28f;
			if (num)
			{
				SummerRaceWeaponDefSO summerRaceWeaponDefSO = SummerRaceConfigLoader.LoadWeaponDefByAssetName(optionAssetName);
				if (summerRaceWeaponDefSO == null)
				{
					return string.Empty;
				}
				empty = summerRaceWeaponDefSO.modularSpineSkeletonDataPath ?? string.Empty;
				zero = summerRaceWeaponDefSO.modularSpineLocalOffset;
				num2 = summerRaceWeaponDefSO.modularSpineLocalAngle;
				num3 = summerRaceWeaponDefSO.modularSpineScale;
				one = summerRaceWeaponDefSO.modularModuleSize;
				muzzleLocalOffset = summerRaceWeaponDefSO.modularMuzzleLocalOffset;
				projectileSpineSkeletonDataPath = summerRaceWeaponDefSO.projectileSpineSkeletonDataPath ?? string.Empty;
				projectileSpineLocalOffset = summerRaceWeaponDefSO.projectileSpineLocalOffset;
				projectileSpineLocalAngle = summerRaceWeaponDefSO.projectileSpineLocalAngle;
				projectileSpineScale = summerRaceWeaponDefSO.projectileSpineScale;
				impactSpineSkeletonDataPath = summerRaceWeaponDefSO.impactSpineSkeletonDataPath ?? string.Empty;
				impactSpineLocalOffset = summerRaceWeaponDefSO.impactSpineLocalOffset;
				impactSpineLocalAngle = summerRaceWeaponDefSO.impactSpineLocalAngle;
				impactSpineScale = summerRaceWeaponDefSO.impactSpineScale;
			}
			else
			{
				SummerRaceEquipDefSO summerRaceEquipDefSO = SummerRaceConfigLoader.LoadEquipDefByAssetName(optionAssetName);
				if (summerRaceEquipDefSO == null)
				{
					return string.Empty;
				}
				empty = summerRaceEquipDefSO.modularSpineSkeletonDataPath ?? string.Empty;
				zero = summerRaceEquipDefSO.modularSpineLocalOffset;
				num2 = summerRaceEquipDefSO.modularSpineLocalAngle;
				num3 = summerRaceEquipDefSO.modularSpineScale;
				one = summerRaceEquipDefSO.modularModuleSize;
				hookHeadSpineSkeletonDataPath = summerRaceEquipDefSO.hookHeadSpineSkeletonDataPath ?? string.Empty;
				hookHeadSpineLocalOffset = summerRaceEquipDefSO.hookHeadSpineLocalOffset;
				hookHeadSpineLocalAngle = summerRaceEquipDefSO.hookHeadSpineLocalAngle;
				hookHeadSpineScale = summerRaceEquipDefSO.hookHeadSpineScale;
				hookRopeSpineSkeletonDataPath = summerRaceEquipDefSO.hookRopeSpineSkeletonDataPath ?? string.Empty;
				hookRopeBoneCount = summerRaceEquipDefSO.hookRopeBoneCount;
				hookRopeMaxLength = summerRaceEquipDefSO.hookRopeMaxLength;
				hookRopeDamping = summerRaceEquipDefSO.hookRopeDamping;
				hookRopeStiffness = summerRaceEquipDefSO.hookRopeStiffness;
			}
			if (string.IsNullOrWhiteSpace(empty))
			{
				throw new InvalidOperationException("[SummerRace][LuaBridge] missing modular spine path: type=" + optionType + ", asset=" + optionAssetName);
			}
			if (num3 <= 0f)
			{
				throw new InvalidOperationException("[SummerRace][LuaBridge] invalid modular spine scale: type=" + optionType + ", asset=" + optionAssetName + ", scale=" + num3);
			}
			return JsonUtility.ToJson(new OptionVisualLayoutPayload
			{
				skeletonDataPath = empty,
				localOffset = zero,
				localAngle = num2,
				scale = num3,
				moduleSize = one,
				muzzleLocalOffset = muzzleLocalOffset,
				projectileSpineSkeletonDataPath = projectileSpineSkeletonDataPath,
				projectileSpineLocalOffset = projectileSpineLocalOffset,
				projectileSpineLocalAngle = projectileSpineLocalAngle,
				projectileSpineScale = projectileSpineScale,
				impactSpineSkeletonDataPath = impactSpineSkeletonDataPath,
				impactSpineLocalOffset = impactSpineLocalOffset,
				impactSpineLocalAngle = impactSpineLocalAngle,
				impactSpineScale = impactSpineScale,
				hookHeadSpineSkeletonDataPath = hookHeadSpineSkeletonDataPath,
				hookHeadSpineLocalOffset = hookHeadSpineLocalOffset,
				hookHeadSpineLocalAngle = hookHeadSpineLocalAngle,
				hookHeadSpineScale = hookHeadSpineScale,
				hookRopeSpineSkeletonDataPath = hookRopeSpineSkeletonDataPath,
				hookRopeBoneCount = hookRopeBoneCount,
				hookRopeMaxLength = hookRopeMaxLength,
				hookRopeDamping = hookRopeDamping,
				hookRopeStiffness = hookRopeStiffness
			});
		}
		catch (Exception ex)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][LuaBridge] RequestGetOptionVisualLayout failed: " + ex.Message);
			return string.Empty;
		}
	}

	public static bool RequestApplySkeletonGraphicSkinStack(SkeletonGraphic graphic, string skinListText)
	{
		if (graphic == null || graphic.skeletonDataAsset == null)
		{
			return false;
		}
		Skeleton skeleton = graphic.Skeleton;
		SkeletonData skeletonData = graphic.skeletonDataAsset.GetSkeletonData(quiet: false);
		if (skeleton == null || skeletonData == null)
		{
			return false;
		}
		string[] skinNames = (skinListText ?? string.Empty).Split(new char[1] { ';' }, StringSplitOptions.RemoveEmptyEntries);
		Skin skin = BuildRuntimeSkinStack(skeletonData, skinNames);
		skeleton.SetSkin(skin);
		skeleton.SetSlotsToSetupPose();
		skeleton.UpdateWorldTransform();
		graphic.UpdateMesh();
		return true;
	}

	public static bool RequestSetDamageText(GameObject root, string text)
	{
		if (root == null)
		{
			return false;
		}
		return (byte)(0u | (TrySetChildText(root.transform, "root/TextMe", text) ? 1u : 0u) | (TrySetChildText(root.transform, "root/TextEnemy", text) ? 1u : 0u) | (TrySetChildText(root.transform, "root/TextOverclock", text) ? 1u : 0u)) != 0;
	}

	private static bool TrySetChildText(Transform root, string childName, string text)
	{
		if (root == null || string.IsNullOrEmpty(childName))
		{
			return false;
		}
		Transform transform = root.Find(childName);
		if (transform == null)
		{
			return false;
		}
		Component[] components = transform.GetComponents<Component>();
		foreach (Component component in components)
		{
			if (!(component == null))
			{
				PropertyInfo property = component.GetType().GetProperty("text", BindingFlags.Instance | BindingFlags.Public);
				if (!(property == null) && !(property.PropertyType != typeof(string)) && property.CanWrite)
				{
					property.SetValue(component, text ?? string.Empty, null);
					return true;
				}
			}
		}
		return false;
	}

	[NoToLua]
	public static void NotifySceneReady()
	{
		TraceLog("[SummerRace][LuaBridge] NotifySceneReady activeScene=" + SceneManager.GetActiveScene().name);
		CallOptionalBridgeCallback("SummerRaceBridge.OnSceneReady");
	}

	[NoToLua]
	public static void NotifySceneExit(bool isReload)
	{
		CallOptionalBridgeCallback("SummerRaceBridge.OnSceneExit", isReload);
	}

	[NoToLua]
	public static void PushRuntimeSnapshot(SummerRaceBattleSnapshot snapshot)
	{
		if (snapshot == null)
		{
			throw new ArgumentNullException("snapshot");
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnBattleSnapshot");
		if (!(optionalBridgeCallback == null))
		{
			optionalBridgeCallback.LazyCall(JsonUtility.ToJson(snapshot));
		}
	}

	[NoToLua]
	public static void PushPlayerLabelPose(SummerRacePlayerLabelPose pose)
	{
		if (pose != null)
		{
			LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnPlayerLabelPose");
			if (!(optionalBridgeCallback == null))
			{
				optionalBridgeCallback.LazyCall(JsonUtility.ToJson(new SummerRacePlayerLabelPoseEvent
				{
					playerLabelWorldX = pose.playerLabelWorldX,
					playerLabelWorldY = pose.playerLabelWorldY,
					playerLabelWorldZ = pose.playerLabelWorldZ,
					playerLabelScreenOffsetY = pose.playerLabelScreenOffsetY
				}));
			}
		}
	}

	[NoToLua]
	public static void PushSettlement(SummerRaceBattleSettlement settlement)
	{
		if (settlement == null)
		{
			throw new ArgumentNullException("settlement");
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnBattleSettlement");
		if (!(optionalBridgeCallback == null))
		{
			optionalBridgeCallback.LazyCall(JsonUtility.ToJson(settlement));
		}
	}

	[NoToLua]
	public static void PushStageResolved(SummerRaceBattleStageResolved stageResolved)
	{
		if (stageResolved == null)
		{
			throw new ArgumentNullException("stageResolved");
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnStageResolved");
		if (!(optionalBridgeCallback == null))
		{
			optionalBridgeCallback.LazyCall(JsonUtility.ToJson(stageResolved));
		}
	}

	[NoToLua]
	public static void PushSpecialDefeatEvent(string payloadJson)
	{
		if (!string.IsNullOrWhiteSpace(payloadJson))
		{
			LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnSpecialDefeatTriggered");
			if (!(optionalBridgeCallback == null))
			{
				optionalBridgeCallback.LazyCall(payloadJson);
			}
		}
	}

	[NoToLua]
	public static void PushSpecialDefeatFinished(string payloadJson)
	{
		if (!string.IsNullOrWhiteSpace(payloadJson))
		{
			LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnSpecialDefeatFinished");
			if (!(optionalBridgeCallback == null))
			{
				optionalBridgeCallback.LazyCall(payloadJson);
			}
		}
	}

	[NoToLua]
	public static bool PushEnemyDefeatBeforeFxEvent(string payloadJson)
	{
		if (string.IsNullOrWhiteSpace(payloadJson))
		{
			return false;
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnEnemyDefeatBeforeFxTriggered");
		if (optionalBridgeCallback == null)
		{
			return false;
		}
		optionalBridgeCallback.LazyCall(payloadJson);
		return true;
	}

	[NoToLua]
	public static bool PushTimeoutResultEvent(string payloadJson)
	{
		if (string.IsNullOrWhiteSpace(payloadJson))
		{
			return false;
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnTimeoutResult");
		if (optionalBridgeCallback == null)
		{
			return false;
		}
		optionalBridgeCallback.LazyCall(payloadJson);
		return true;
	}

	[NoToLua]
	public static bool PushBattleResultBannerEvent(string payloadJson)
	{
		if (string.IsNullOrWhiteSpace(payloadJson))
		{
			return false;
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnBattleResultBanner");
		if (optionalBridgeCallback == null)
		{
			return false;
		}
		optionalBridgeCallback.LazyCall(payloadJson);
		return true;
	}

	[NoToLua]
	public static void PushDamageTextEvent(SummerRaceDamageTextEvent damageTextEvent)
	{
		if (damageTextEvent == null || damageTextEvent.amount <= 0 || string.IsNullOrWhiteSpace(damageTextEvent.state))
		{
			return;
		}
		LuaFunction optionalBridgeCallback = GetOptionalBridgeCallback("SummerRaceBridge.OnDamageText");
		if (!(optionalBridgeCallback == null))
		{
			optionalBridgeCallback.LazyCall(JsonUtility.ToJson(damageTextEvent));
			SummerRaceFightManager instance = SummerRaceFightManager.Instance;
			if (instance != null)
			{
				Transform sourceTransform = ((instance.CurrentPlayer != null) ? instance.CurrentPlayer.transform : instance.transform);
				Vector2 position = new Vector2(damageTextEvent.worldX, damageTextEvent.worldY);
				SummerRaceCombatAudioEventRouter.Publish(sourceTransform, SummerRaceCombatAudioEvent.DamageText(sourceTransform, position, damageTextEvent.amount));
			}
		}
	}

	[NoToLua]
	public static void PushDamageTextEvent(int amount, SummerRaceCombatTeam targetTeam, Vector3 worldPosition, string source)
	{
		PushDamageTextEvent(amount, targetTeam, worldPosition, source, null);
	}

	[NoToLua]
	public static void PushDamageTextEvent(int amount, SummerRaceCombatTeam targetTeam, Vector3 worldPosition, string source, ICombatSourceContext sourceContext)
	{
		if (amount > 0)
		{
			string text = ResolveDamageTextState(targetTeam, sourceContext);
			if (!string.IsNullOrEmpty(text))
			{
				Vector3 vector = worldPosition + new Vector3(UnityEngine.Random.Range(-0.25f, 0.25f), UnityEngine.Random.Range(0.25f, 0.65f), 0f);
				PushDamageTextEvent(new SummerRaceDamageTextEvent
				{
					amount = amount,
					state = text,
					worldX = vector.x,
					worldY = vector.y,
					worldZ = vector.z,
					targetTeam = targetTeam.ToString(),
					source = (source ?? string.Empty)
				});
			}
		}
	}

	private static string ResolveDamageTextState(SummerRaceCombatTeam targetTeam)
	{
		return targetTeam switch
		{
			SummerRaceCombatTeam.Enemy => "me", 
			SummerRaceCombatTeam.Player => "enemy", 
			_ => string.Empty, 
		};
	}

	private static string ResolveDamageTextState(SummerRaceCombatTeam targetTeam, ICombatSourceContext sourceContext)
	{
		if (sourceContext != null && sourceContext.OverclockDamageTextActive)
		{
			return "overclock";
		}
		return ResolveDamageTextState(targetTeam);
	}
}
