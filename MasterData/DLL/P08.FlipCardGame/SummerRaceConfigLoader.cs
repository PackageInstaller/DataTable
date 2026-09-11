using System;
using System.Collections.Generic;
using Spine.Unity;
using UnityEngine;

public static class SummerRaceConfigLoader
{
	public readonly struct BodyPrefabRuntimeData(Vector2[] colliderPoints, Vector3 bodyVisualLocalPosition, Quaternion bodyVisualLocalRotation, Vector3 bodyVisualLocalScale, Vector2 bodyVisualTargetSize, float battleBodyVisualScale, SkeletonDataAsset bodySkeletonData, Vector3 frontWheelVisualLocalPosition, Quaternion frontWheelVisualLocalRotation, Vector3 frontWheelVisualLocalScale, Sprite frontWheelOuterSprite, Sprite frontWheelInnerSprite, float frontWheelVisualScale, Vector3 backWheelVisualLocalPosition, Quaternion backWheelVisualLocalRotation, Vector3 backWheelVisualLocalScale, Sprite backWheelOuterSprite, Sprite backWheelInnerSprite, float backWheelVisualScale)
	{
		public readonly Vector2[] ColliderPoints = colliderPoints;

		public readonly Vector3 BodyVisualLocalPosition = bodyVisualLocalPosition;

		public readonly Quaternion BodyVisualLocalRotation = bodyVisualLocalRotation;

		public readonly Vector3 BodyVisualLocalScale = bodyVisualLocalScale;

		public readonly Vector2 BodyVisualTargetSize = bodyVisualTargetSize;

		public readonly float BattleBodyVisualScale = battleBodyVisualScale;

		public readonly SkeletonDataAsset BodySkeletonData = bodySkeletonData;

		public readonly Vector3 FrontWheelVisualLocalPosition = frontWheelVisualLocalPosition;

		public readonly Quaternion FrontWheelVisualLocalRotation = frontWheelVisualLocalRotation;

		public readonly Vector3 FrontWheelVisualLocalScale = frontWheelVisualLocalScale;

		public readonly Sprite FrontWheelOuterSprite = frontWheelOuterSprite;

		public readonly Sprite FrontWheelInnerSprite = frontWheelInnerSprite;

		public readonly float FrontWheelVisualScale = frontWheelVisualScale;

		public readonly Vector3 BackWheelVisualLocalPosition = backWheelVisualLocalPosition;

		public readonly Quaternion BackWheelVisualLocalRotation = backWheelVisualLocalRotation;

		public readonly Vector3 BackWheelVisualLocalScale = backWheelVisualLocalScale;

		public readonly Sprite BackWheelOuterSprite = backWheelOuterSprite;

		public readonly Sprite BackWheelInnerSprite = backWheelInnerSprite;

		public readonly float BackWheelVisualScale = backWheelVisualScale;
	}

	private const string ConfigFolder = "SummerRaceActivity/Config/";

	private const string PrefabFolder = "SummerRaceActivity/Prefabs/";

	private const string EditorAssetRoot = "Assets/ABResources/";

	private const string BodyAssetPrefix = "SummerRaceBody_";

	private const string WeaponAssetPrefix = "SummerRaceWeapon_";

	private const string EquipAssetPrefix = "SummerRaceEquip_";

	private const string BuildAssetPrefix = "SummerRaceBuild_";

	private const string WheelVisualPrefabName = "SummerRaceWheelVisual";

	private const string SoftOvalShadowPrefabName = "SummerRaceSoftOvalShadow";

	public static T LoadBodyConfig<T>(SummerRaceBodyType bodyType) where T : UnityEngine.Object
	{
		return LoadBodyConfigByAssetName<T>(GetBodyAssetName(bodyType));
	}

	public static T LoadBodyConfigByAssetName<T>(string assetName) where T : UnityEngine.Object
	{
		if (string.IsNullOrWhiteSpace(assetName))
		{
			throw new ArgumentException("SummerRace body asset_name is empty.", "assetName");
		}
		string text = "SummerRaceBody_" + assetName;
		return LoadAssetWithEditorFallback<T>("SummerRaceActivity/Config/" + text, "Assets/ABResources/SummerRaceActivity/Config/" + text + ".asset");
	}

	public static SummerRaceBodyDefSO LoadBodyDef(SummerRaceBodyType bodyType)
	{
		return LoadBodyConfig<SummerRaceBodyDefSO>(bodyType);
	}

	public static GameObject LoadBodyPrefab(SummerRaceBodyType bodyType)
	{
		string text = "SummerRaceBody_" + GetBodyAssetName(bodyType);
		return LoadAssetWithEditorFallback<GameObject>("SummerRaceActivity/Prefabs/" + text, "Assets/ABResources/SummerRaceActivity/Prefabs/" + text + ".prefab");
	}

	public static BodyPrefabRuntimeData LoadBodyPrefabRuntimeData(SummerRaceBodyType bodyType)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = LoadBodyDef(bodyType);
		if (summerRaceBodyDefSO == null)
		{
			throw new InvalidOperationException("Missing body config for " + bodyType);
		}
		if (summerRaceBodyDefSO.wheels == null || summerRaceBodyDefSO.wheels.Count < 2)
		{
			throw new InvalidOperationException("Body wheel definitions are incomplete for " + bodyType.ToString() + ": " + summerRaceBodyDefSO.name);
		}
		SummerRaceWheelDefConfig summerRaceWheelDefConfig = summerRaceBodyDefSO.wheels[0];
		SummerRaceWheelDefConfig summerRaceWheelDefConfig2 = summerRaceBodyDefSO.wheels[1];
		if (summerRaceWheelDefConfig == null || summerRaceWheelDefConfig2 == null)
		{
			throw new InvalidOperationException("Body wheel definitions contain null entries for " + bodyType.ToString() + ": " + summerRaceBodyDefSO.name);
		}
		GameObject gameObject = LoadBodyPrefab(bodyType);
		if (gameObject == null)
		{
			throw new InvalidOperationException("Missing body prefab for " + bodyType);
		}
		Transform transform = gameObject.transform.Find("BodyVisual");
		if (transform == null)
		{
			throw new InvalidOperationException("Body prefab BodyVisual child is missing for " + bodyType.ToString() + ": " + gameObject.name);
		}
		Transform transform2 = gameObject.transform.Find("FrontWheelVisual");
		if (transform2 == null)
		{
			throw new InvalidOperationException("Body prefab FrontWheelVisual child is missing for " + bodyType.ToString() + ": " + gameObject.name);
		}
		Transform transform3 = gameObject.transform.Find("BackWheelVisual");
		if (transform3 == null)
		{
			throw new InvalidOperationException("Body prefab BackWheelVisual child is missing for " + bodyType.ToString() + ": " + gameObject.name);
		}
		PolygonCollider2D component = gameObject.GetComponent<PolygonCollider2D>();
		if (component == null || component.pathCount <= 0)
		{
			throw new InvalidOperationException("Body prefab collider is missing for " + bodyType.ToString() + ": " + gameObject.name);
		}
		List<Vector2> list = new List<Vector2>();
		component.GetPath(0, list);
		if (list.Count < 3)
		{
			throw new InvalidOperationException("Body prefab collider path is invalid for " + bodyType.ToString() + ": " + gameObject.name);
		}
		Vector2 bodyVisualTargetSize = ComputePolygonBoundsSize(list, "body=" + summerRaceBodyDefSO.name + " colliderPath");
		SkeletonDataAsset bodySkeletonData = LoadSkeletonDataAssetOrThrow(summerRaceBodyDefSO.battleBodySkeletonDataPath, "body=" + summerRaceBodyDefSO.name + " field=battleBodySkeletonDataPath");
		LoadWheelVisualTemplateOrThrow(out var outerSprite, out var innerSprite, out var _, out var _, "body=" + summerRaceBodyDefSO.name + " wheel visual template");
		return new BodyPrefabRuntimeData(list.ToArray(), transform.localPosition, transform.localRotation, transform.localScale, bodyVisualTargetSize, Mathf.Max(0.01f, summerRaceBodyDefSO.battleBodyVisualScale), bodySkeletonData, transform2.localPosition, transform2.localRotation, transform2.localScale, outerSprite, innerSprite, Mathf.Max(0.01f, summerRaceWheelDefConfig.wheelVisualScale), transform3.localPosition, transform3.localRotation, transform3.localScale, outerSprite, innerSprite, Mathf.Max(0.01f, summerRaceWheelDefConfig2.wheelVisualScale));
	}

	private static Vector2 ComputePolygonBoundsSize(IReadOnlyList<Vector2> points, string context)
	{
		if (points == null || points.Count < 3)
		{
			throw new InvalidOperationException("Invalid polygon points for bounds solve. context=" + context);
		}
		float num = points[0].x;
		float num2 = points[0].x;
		float num3 = points[0].y;
		float num4 = points[0].y;
		for (int i = 1; i < points.Count; i++)
		{
			Vector2 vector = points[i];
			num = Mathf.Min(num, vector.x);
			num2 = Mathf.Max(num2, vector.x);
			num3 = Mathf.Min(num3, vector.y);
			num4 = Mathf.Max(num4, vector.y);
		}
		float num5 = num2 - num;
		float num6 = num4 - num3;
		if (num5 <= 0.0001f || num6 <= 0.0001f)
		{
			throw new InvalidOperationException("Invalid polygon bounds size for " + context + ": width=" + num5 + ", height=" + num6);
		}
		return new Vector2(num5, num6);
	}

	public static VehicleSimpleProjectile LoadVehicleSimpleProjectilePrefab()
	{
		GameObject gameObject = LoadAssetWithEditorFallback<GameObject>("SummerRaceActivity/Prefabs/SummerRaceVehicleSimpleProjectile", "Assets/ABResources/SummerRaceActivity/Prefabs/SummerRaceVehicleSimpleProjectile.prefab");
		if (gameObject == null)
		{
			SummerRaceRuntimeLog.Error("Projectile prefab not found: SummerRaceActivity/Prefabs/SummerRaceVehicleSimpleProjectile");
			throw new Exception("Projectile prefab not found: SummerRaceVehicleSimpleProjectile");
		}
		VehicleSimpleProjectile component = gameObject.GetComponent<VehicleSimpleProjectile>();
		if (component == null)
		{
			SummerRaceRuntimeLog.Error("Projectile prefab missing VehicleSimpleProjectile: SummerRaceActivity/Prefabs/SummerRaceVehicleSimpleProjectile");
			throw new Exception("Projectile prefab missing VehicleSimpleProjectile: SummerRaceVehicleSimpleProjectile");
		}
		return component;
	}

	public static GameObject LoadWheelVisualPrefab()
	{
		return LoadAssetWithEditorFallback<GameObject>("SummerRaceActivity/Prefabs/SummerRaceWheelVisual", "Assets/ABResources/SummerRaceActivity/Prefabs/SummerRaceWheelVisual.prefab");
	}

	public static GameObject LoadSoftOvalShadowPrefab()
	{
		return LoadAssetWithEditorFallback<GameObject>("SummerRaceActivity/Prefabs/SummerRaceSoftOvalShadow", "Assets/ABResources/SummerRaceActivity/Prefabs/SummerRaceSoftOvalShadow.prefab");
	}

	public static GameObject LoadWheelVisualPrefabOrThrow(string context)
	{
		GameObject gameObject = LoadWheelVisualPrefab();
		if (gameObject == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing wheel visual prefab. context=" + context + ", path=SummerRaceActivity/Prefabs/SummerRaceWheelVisual");
		}
		return gameObject;
	}

	public static GameObject LoadSoftOvalShadowPrefabOrThrow(string context)
	{
		GameObject gameObject = LoadSoftOvalShadowPrefab();
		if (gameObject == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing soft oval shadow prefab. context=" + context + ", path=SummerRaceActivity/Prefabs/SummerRaceSoftOvalShadow");
		}
		return gameObject;
	}

	public static void LoadWheelVisualTemplateOrThrow(out Sprite outerSprite, out Sprite innerSprite, out Material outerMaterial, out Material innerMaterial, string context)
	{
		GameObject gameObject = LoadWheelVisualPrefabOrThrow(context);
		SpriteRenderer component = gameObject.GetComponent<SpriteRenderer>();
		if (component == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing outer SpriteRenderer. context=" + context + ", prefab=" + gameObject.name);
		}
		if (component.sprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing outer sprite. context=" + context + ", prefab=" + gameObject.name);
		}
		if (component.sharedMaterial == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing outer material. context=" + context + ", prefab=" + gameObject.name);
		}
		Transform transform = gameObject.transform.Find("InnerTireVisual");
		SpriteRenderer spriteRenderer = ((transform != null) ? transform.GetComponent<SpriteRenderer>() : null);
		if (spriteRenderer == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing InnerTireVisual SpriteRenderer. context=" + context + ", prefab=" + gameObject.name);
		}
		if (spriteRenderer.sprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing inner sprite. context=" + context + ", prefab=" + gameObject.name);
		}
		if (spriteRenderer.sharedMaterial == null)
		{
			throw new InvalidOperationException("[SummerRace] Wheel visual prefab missing inner material. context=" + context + ", prefab=" + gameObject.name);
		}
		outerSprite = component.sprite;
		innerSprite = spriteRenderer.sprite;
		outerMaterial = component.sharedMaterial;
		innerMaterial = spriteRenderer.sharedMaterial;
	}

	private static string GetBodyAssetName(SummerRaceBodyType bodyType)
	{
		return bodyType switch
		{
			SummerRaceBodyType.Light => "Light", 
			SummerRaceBodyType.Medium => "Medium", 
			SummerRaceBodyType.Heavy => "Heavy", 
			_ => throw new ArgumentOutOfRangeException("bodyType", bodyType, "Unsupported SummerRace body type"), 
		};
	}

	public static SummerRaceWeaponDefSO LoadWeaponDef(WeaponKind weaponKind)
	{
		return LoadWeaponDefByAssetName(weaponKind.ToString());
	}

	public static SummerRaceWeaponDefSO LoadWeaponDefByAssetName(string assetName)
	{
		if (string.IsNullOrWhiteSpace(assetName))
		{
			throw new ArgumentException("SummerRace weapon asset_name is empty.", "assetName");
		}
		string text = "SummerRaceWeapon_" + assetName;
		SummerRaceWeaponDefSO summerRaceWeaponDefSO = LoadAssetWithEditorFallback<SummerRaceWeaponDefSO>("SummerRaceActivity/Config/" + text, "Assets/ABResources/SummerRaceActivity/Config/" + text + ".asset");
		if (summerRaceWeaponDefSO == null)
		{
			SummerRaceRuntimeLog.Error("Weapon config not found: SummerRaceActivity/Config/" + text);
			throw new Exception("Weapon config not found: " + text);
		}
		if (!summerRaceWeaponDefSO.ValidateModularData(out var reason))
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Invalid weapon config " + text + ": " + reason);
		}
		ValidateWeaponSpineAnimationContractOrThrow(text, summerRaceWeaponDefSO);
		return summerRaceWeaponDefSO;
	}

	public static SummerRaceEquipDefSO LoadEquipDef(EquipKind equipKind)
	{
		return LoadEquipDefByAssetName(equipKind.ToString());
	}

	public static SummerRaceEquipDefSO LoadEquipDefByAssetName(string assetName)
	{
		if (string.IsNullOrWhiteSpace(assetName))
		{
			throw new ArgumentException("SummerRace equip asset_name is empty.", "assetName");
		}
		string text = "SummerRaceEquip_" + assetName;
		SummerRaceEquipDefSO summerRaceEquipDefSO = LoadAssetWithEditorFallback<SummerRaceEquipDefSO>("SummerRaceActivity/Config/" + text, "Assets/ABResources/SummerRaceActivity/Config/" + text + ".asset");
		if (summerRaceEquipDefSO == null)
		{
			SummerRaceRuntimeLog.Error("Equip config not found: SummerRaceActivity/Config/" + text);
			throw new Exception("Equip config not found: " + text);
		}
		if (!summerRaceEquipDefSO.ValidateModularData(out var reason))
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Invalid equip config " + text + ": " + reason);
		}
		ValidateEquipSpineAnimationContractOrThrow(text, summerRaceEquipDefSO);
		return summerRaceEquipDefSO;
	}

	public static SummerRaceBuildDefSO LoadBuildDef(string buildName)
	{
		if (string.IsNullOrWhiteSpace(buildName))
		{
			throw new ArgumentException("SummerRace build asset_name is empty.", "buildName");
		}
		string text = NormalizeBuildAssetName(buildName);
		SummerRaceBuildDefSO summerRaceBuildDefSO = LoadAssetWithEditorFallback<SummerRaceBuildDefSO>("SummerRaceActivity/Config/" + text, "Assets/ABResources/SummerRaceActivity/Config/" + text + ".asset");
		if (summerRaceBuildDefSO == null)
		{
			SummerRaceRuntimeLog.Error("Build config not found: SummerRaceActivity/Config/" + text);
			throw new Exception("Build config not found: " + buildName);
		}
		return summerRaceBuildDefSO;
	}

	private static string NormalizeBuildAssetName(string buildName)
	{
		string text = buildName.Trim();
		if (!text.StartsWith("SummerRaceBuild_", StringComparison.Ordinal))
		{
			return "SummerRaceBuild_" + text;
		}
		return text;
	}

	public static SummerRaceBuildDatabaseSO LoadBuildDatabase(string databaseName)
	{
		SummerRaceBuildDatabaseSO summerRaceBuildDatabaseSO = LoadAssetWithEditorFallback<SummerRaceBuildDatabaseSO>("SummerRaceActivity/Config/" + databaseName, "Assets/ABResources/SummerRaceActivity/Config/" + databaseName + ".asset");
		if (summerRaceBuildDatabaseSO == null)
		{
			SummerRaceRuntimeLog.Error("Build database not found: SummerRaceActivity/Config/" + databaseName);
			throw new Exception("Build database not found: " + databaseName);
		}
		return summerRaceBuildDatabaseSO;
	}

	private static T LoadAssetWithEditorFallback<T>(string runtimePath, string editorAssetPath) where T : UnityEngine.Object
	{
		T val = AssetManager.Load<T>(runtimePath);
		if (val != null)
		{
			return val;
		}
		return null;
	}

	public static string NormalizeAssetRuntimePath(string rawPath)
	{
		string text = (rawPath ?? string.Empty).Trim().Replace("\\", "/");
		if (string.IsNullOrEmpty(text))
		{
			return string.Empty;
		}
		if (text.StartsWith("Assets/ABResources/", StringComparison.OrdinalIgnoreCase))
		{
			text = text.Substring("Assets/ABResources/".Length);
		}
		if (text.EndsWith(".asset", StringComparison.OrdinalIgnoreCase))
		{
			text = text.Substring(0, text.Length - ".asset".Length);
		}
		return text.TrimStart('/');
	}

	public static string ResolveEditorAssetPath(string rawPath)
	{
		string text = (rawPath ?? string.Empty).Trim().Replace("\\", "/");
		if (string.IsNullOrEmpty(text))
		{
			return string.Empty;
		}
		if (text.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase))
		{
			if (!text.EndsWith(".asset", StringComparison.OrdinalIgnoreCase))
			{
				text += ".asset";
			}
			return text;
		}
		string text2 = NormalizeAssetRuntimePath(text);
		if (string.IsNullOrEmpty(text2))
		{
			return string.Empty;
		}
		return "Assets/ABResources/" + text2 + ".asset";
	}

	public static bool TryLoadSkeletonDataAsset(string rawPath, out SkeletonDataAsset skeletonDataAsset)
	{
		skeletonDataAsset = null;
		string text = NormalizeAssetRuntimePath(rawPath);
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		string editorAssetPath = ResolveEditorAssetPath(rawPath);
		skeletonDataAsset = LoadAssetWithEditorFallback<SkeletonDataAsset>(text, editorAssetPath);
		return skeletonDataAsset != null;
	}

	public static bool TryLoadSprite(string rawPath, out Sprite sprite)
	{
		sprite = null;
		string text = (rawPath ?? string.Empty).Trim().Replace("\\", "/");
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (TryResolveAtlasSpritePath(text, out var atlasName, out var spriteName))
		{
			sprite = AtlasManager.GetSprite(atlasName, spriteName);
			return sprite != null;
		}
		string text2;
		string editorAssetPath;
		if (text.StartsWith("Assets/", StringComparison.OrdinalIgnoreCase))
		{
			text2 = text;
			if (text2.StartsWith("Assets/ABResources/", StringComparison.OrdinalIgnoreCase))
			{
				text2 = text2.Substring("Assets/ABResources/".Length);
			}
			int num = text2.LastIndexOf('.');
			if (num > text2.LastIndexOf('/'))
			{
				text2 = text2.Substring(0, num);
			}
			editorAssetPath = text;
		}
		else
		{
			text2 = NormalizeAssetRuntimePath(text);
			editorAssetPath = string.Empty;
		}
		if (string.IsNullOrEmpty(text2))
		{
			return false;
		}
		sprite = LoadAssetWithEditorFallback<Sprite>(text2, editorAssetPath);
		return sprite != null;
	}

	private static bool TryResolveAtlasSpritePath(string normalizedPath, out string atlasName, out string spriteName)
	{
		atlasName = string.Empty;
		spriteName = string.Empty;
		if (!normalizedPath.StartsWith("Atlas/", StringComparison.OrdinalIgnoreCase))
		{
			return false;
		}
		int num = normalizedPath.LastIndexOf('/');
		if (num <= "Atlas/".Length || num >= normalizedPath.Length - 1)
		{
			return false;
		}
		atlasName = normalizedPath.Substring(0, num);
		spriteName = normalizedPath.Substring(num + 1);
		int num2 = spriteName.LastIndexOf('.');
		if (num2 > 0)
		{
			spriteName = spriteName.Substring(0, num2);
		}
		return !string.IsNullOrEmpty(spriteName);
	}

	public static Sprite LoadSpriteOrThrow(string rawPath, string context)
	{
		if (string.IsNullOrWhiteSpace(rawPath))
		{
			throw new InvalidOperationException("[SummerRace] missing sprite path. context=" + context);
		}
		if (!TryLoadSprite(rawPath, out var sprite))
		{
			throw new InvalidOperationException("[SummerRace] failed to load sprite. context=" + context + ", path=" + rawPath);
		}
		return sprite;
	}

	public static bool TryValidateSkeletonDataPath(string rawPath, out string reason)
	{
		if (string.IsNullOrEmpty(NormalizeAssetRuntimePath(rawPath)))
		{
			reason = "path is empty";
			return false;
		}
		if (!TryLoadSkeletonDataAsset(rawPath, out var _))
		{
			reason = "asset cannot be loaded: " + rawPath;
			return false;
		}
		reason = "OK";
		return true;
	}

	public static SkeletonDataAsset LoadSkeletonDataAssetOrThrow(string rawPath, string context)
	{
		if (string.IsNullOrWhiteSpace(rawPath))
		{
			throw new InvalidOperationException("[SummerRace] missing skeleton path. context=" + context);
		}
		if (!TryLoadSkeletonDataAsset(rawPath, out var skeletonDataAsset))
		{
			throw new InvalidOperationException("[SummerRace] failed to load skeleton data asset. context=" + context + ", path=" + rawPath);
		}
		return skeletonDataAsset;
	}

	private static void ValidateWeaponSpineAnimationContractOrThrow(string configName, SummerRaceWeaponDefSO config)
	{
		if (config == null)
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Weapon config is null: " + configName);
		}
		SkeletonDataAsset skeletonDataAsset = LoadSkeletonDataAssetOrThrow(config.modularSpineSkeletonDataPath, "weapon=" + configName + " field=modularSpineSkeletonDataPath");
		if (!IsNoneAnimationToken(config.emitterIdleAnimName))
		{
			ValidateAnimationExistsOrThrow(skeletonDataAsset, config.emitterIdleAnimName, configName, "weapon_emitter_idle");
		}
		ValidateAnimationExistsOrThrow(skeletonDataAsset, config.emitterFireAnimName, configName, "weapon_emitter_fire");
		if (!config.isMelee)
		{
			SkeletonDataAsset skeletonDataAsset2 = LoadSkeletonDataAssetOrThrow(config.projectileSpineSkeletonDataPath, "weapon=" + configName + " field=projectileSpineSkeletonDataPath");
			ValidateAnimationExistsOrThrow(skeletonDataAsset2, config.projectileLoopAnimName, configName, "weapon_projectile_loop");
			ValidateAnimationExistsOrThrow(skeletonDataAsset2, config.projectileDespawnAnimName, configName, "weapon_projectile_despawn");
			if (!string.IsNullOrWhiteSpace(config.impactSpineSkeletonDataPath))
			{
				ValidateAnimationExistsOrThrow(LoadSkeletonDataAssetOrThrow(config.impactSpineSkeletonDataPath, "weapon=" + configName + " field=impactSpineSkeletonDataPath"), config.projectileDespawnAnimName, configName, "weapon_impact_despawn");
			}
		}
	}

	private static void ValidateEquipSpineAnimationContractOrThrow(string configName, SummerRaceEquipDefSO config)
	{
		if (config == null)
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Equip config is null: " + configName);
		}
		SkeletonDataAsset skeletonDataAsset = LoadSkeletonDataAssetOrThrow(config.modularSpineSkeletonDataPath, "equip=" + configName + " field=modularSpineSkeletonDataPath");
		if (!IsNoneAnimationToken(config.emitterIdleAnimName))
		{
			ValidateAnimationExistsOrThrow(skeletonDataAsset, config.emitterIdleAnimName, configName, "equip_emitter_idle");
		}
		ValidateAnimationExistsOrThrow(skeletonDataAsset, config.emitterFireAnimName, configName, "equip_emitter_fire");
	}

	private static void ValidateAnimationExistsOrThrow(SkeletonDataAsset skeletonDataAsset, string animationName, string configName, string field)
	{
		if (skeletonDataAsset == null)
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Missing skeleton data asset while validating animation. config=" + configName + ", field=" + field);
		}
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Empty animation name while validating contract. config=" + configName + ", field=" + field);
		}
		if ((skeletonDataAsset.GetSkeletonData(quiet: false) ?? throw new InvalidOperationException("[SummerRaceConfigLoader] Skeleton data is null while validating animation. config=" + configName + ", field=" + field)).FindAnimation(animationName) == null)
		{
			throw new InvalidOperationException("[SummerRaceConfigLoader] Animation not found in skeleton. config=" + configName + ", field=" + field + ", animation=" + animationName + ", skeleton=" + skeletonDataAsset.name);
		}
	}

	private static bool IsNoneAnimationToken(string animationName)
	{
		if (!string.IsNullOrWhiteSpace(animationName))
		{
			return string.Equals(animationName.Trim(), "none", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	public static SummerRaceBodyType ToRuntimeBodyType(SummerRaceBodyTypeConfig bodyType)
	{
		return bodyType switch
		{
			SummerRaceBodyTypeConfig.Light => SummerRaceBodyType.Light, 
			SummerRaceBodyTypeConfig.Medium => SummerRaceBodyType.Medium, 
			SummerRaceBodyTypeConfig.Heavy => SummerRaceBodyType.Heavy, 
			_ => throw new ArgumentOutOfRangeException("bodyType", bodyType, "Unsupported SummerRace body type config"), 
		};
	}

	public static WeaponKind ToRuntimeWeaponKind(SummerRaceWeaponTypeConfig weaponType)
	{
		return weaponType switch
		{
			SummerRaceWeaponTypeConfig.RocketLauncher => WeaponKind.RocketLauncher, 
			SummerRaceWeaponTypeConfig.MachineGun => WeaponKind.MachineGun, 
			SummerRaceWeaponTypeConfig.Boomerang => WeaponKind.Boomerang, 
			SummerRaceWeaponTypeConfig.ScatterShell => WeaponKind.ScatterShell, 
			SummerRaceWeaponTypeConfig.LaserCannon => WeaponKind.LaserCannon, 
			SummerRaceWeaponTypeConfig.Drill => WeaponKind.Drill, 
			SummerRaceWeaponTypeConfig.RotatingSaw => WeaponKind.RotatingSaw, 
			SummerRaceWeaponTypeConfig.Shovel => WeaponKind.Shovel, 
			_ => throw new ArgumentOutOfRangeException("weaponType", weaponType, "Unsupported SummerRace weapon type config"), 
		};
	}

	public static EquipKind ToRuntimeEquipKind(SummerRaceEquipTypeConfig equipType)
	{
		return equipType switch
		{
			SummerRaceEquipTypeConfig.Thruster => EquipKind.Thruster, 
			SummerRaceEquipTypeConfig.BoxingGlove => EquipKind.BoxingGlove, 
			SummerRaceEquipTypeConfig.ElectricNet => EquipKind.ElectricNet, 
			SummerRaceEquipTypeConfig.Hook => EquipKind.Hook, 
			SummerRaceEquipTypeConfig.ShieldGenerator => EquipKind.ShieldGenerator, 
			_ => throw new ArgumentOutOfRangeException("equipType", equipType, "Unsupported SummerRace equip type config"), 
		};
	}

	public static void ApplyToRuntimeSpec(this SummerRaceWeaponDefSO config, SummerRaceWeaponSpec spec, WeaponKind kind)
	{
		if (config == null)
		{
			throw new ArgumentNullException("config");
		}
		if (spec == null)
		{
			throw new ArgumentNullException("spec");
		}
		spec.Kind = kind;
		spec.Label = config.displayName;
		spec.FireMode = config.fireMode;
		spec.BurstCount = Mathf.Max(1, config.burstCount);
		spec.BurstInterval = Mathf.Max(0.02f, config.burstInterval);
		spec.Damage = Mathf.Max(0, config.damage);
		spec.Cooldown = Mathf.Max(0.02f, config.cooldown);
		spec.ProjectileSpeed = Mathf.Max(0f, config.projectileSpeed);
		spec.ProjectileLifetime = Mathf.Max(0.05f, config.projectileLifetime);
		spec.ProjectileCount = Mathf.Max(1, config.projectileCount);
		spec.IsMelee = config.isMelee;
		spec.MeleeRange = Mathf.Max(0f, config.meleeRange);
		spec.MeleeRadius = Mathf.Max(0f, config.meleeRadius);
		spec.AttackRange = Mathf.Max(0f, config.isMelee ? config.meleeRange : config.range);
		spec.AttackRadius = Mathf.Max(0f, config.meleeRadius);
		spec.Cost = Mathf.Max(0, config.cost);
		spec.EnergyCost = Mathf.Max(0f, config.energyCost);
		spec.LoadWeight = config.loadWeight;
		spec.Knockback = Mathf.Max(0f, config.knockback);
		spec.StunDuration = Mathf.Max(0f, config.stunDuration);
		spec.SlowMultiplier = config.slowMultiplier;
		spec.SlowDuration = Mathf.Max(0f, config.slowDuration);
		spec.BurnDps = Mathf.Max(0, config.burnDps);
		spec.BurnDuration = Mathf.Max(0f, config.burnDuration);
		spec.BoomerangFlight = config.boomerangFlight;
		spec.DisableEnemyWeapons = config.disableEnemyWeapons;
		spec.DisableDuration = Mathf.Max(0f, config.disableDuration);
		spec.BaseSpread = Mathf.Max(0f, config.baseSpread);
		spec.SpreadIncreasePerShot = Mathf.Max(0f, config.spreadIncreasePerShot);
		spec.MaxSpread = Mathf.Max(0f, config.maxSpread);
		spec.SpreadDecayPerSecond = Mathf.Max(0f, config.spreadDecayPerSecond);
		spec.AdsSpreadMultiplier = Mathf.Clamp(config.adsSpreadMultiplier, 0.05f, 1f);
		spec.RecoilBackImpulse = Mathf.Max(0f, config.recoilBackImpulse);
		spec.RecoilUpImpulse = Mathf.Max(0f, config.recoilUpImpulse);
		spec.RecoilSideImpulse = Mathf.Max(0f, config.recoilSideImpulse);
		spec.RecoilSpring = Mathf.Max(1f, config.recoilSpring);
		spec.RecoilDamping = Mathf.Max(0.1f, config.recoilDamping);
		spec.AdsRecoilMultiplier = Mathf.Clamp(config.adsRecoilMultiplier, 0.05f, 1f);
		spec.ViewPunchUp = Mathf.Max(0f, config.viewPunchUp);
		spec.ViewPunchSide = Mathf.Max(0f, config.viewPunchSide);
		spec.ViewSpring = Mathf.Max(1f, config.viewSpring);
		spec.ViewDamping = Mathf.Max(0.1f, config.viewDamping);
		spec.EnableShake = config.enableShake;
		spec.ShakeAmplitude = Mathf.Max(0f, config.shakeAmplitude);
		spec.ShakeDuration = Mathf.Max(0f, config.shakeDuration);
		spec.ProjectileSpineSkeletonDataPath = config.projectileSpineSkeletonDataPath ?? string.Empty;
		spec.ProjectileSpineLocalOffset = config.projectileSpineLocalOffset;
		spec.ProjectileSpineLocalAngle = config.projectileSpineLocalAngle;
		spec.ProjectileSpineScale = Mathf.Max(0.01f, config.projectileSpineScale);
		spec.ImpactSpineSkeletonDataPath = config.impactSpineSkeletonDataPath ?? string.Empty;
		spec.ImpactSpineLocalOffset = config.impactSpineLocalOffset;
		spec.ImpactSpineLocalAngle = config.impactSpineLocalAngle;
		spec.ImpactSpineScale = Mathf.Max(0.01f, config.impactSpineScale);
	}

	public static SummerRaceWeaponSpec ToRuntimeSpec(this SummerRaceWeaponDefSO config, WeaponKind kind)
	{
		SummerRaceWeaponSpec summerRaceWeaponSpec = new SummerRaceWeaponSpec();
		config.ApplyToRuntimeSpec(summerRaceWeaponSpec, kind);
		return summerRaceWeaponSpec;
	}

	public static void ApplyToRuntimeSpec(this SummerRaceEquipDefSO config, SummerRaceEquipSpec spec, EquipKind kind)
	{
		if (config == null)
		{
			throw new ArgumentNullException("config");
		}
		if (spec == null)
		{
			throw new ArgumentNullException("spec");
		}
		spec.Kind = kind;
		spec.Label = config.displayName;
		spec.Cost = config.cost;
		spec.EnergyCost = config.energyCost;
		spec.Cooldown = config.cooldown;
		spec.Duration = config.duration;
		spec.Strength = config.strength;
		spec.Radius = config.radius;
		spec.LoadWeight = config.loadWeight;
		spec.HookHeadSpineSkeletonDataPath = config.hookHeadSpineSkeletonDataPath ?? string.Empty;
		spec.HookHeadSpineLocalOffset = config.hookHeadSpineLocalOffset;
		spec.HookHeadSpineLocalAngle = config.hookHeadSpineLocalAngle;
		spec.HookHeadSpineScale = Mathf.Max(0.01f, config.hookHeadSpineScale);
		spec.HookRopeSpineSkeletonDataPath = config.hookRopeSpineSkeletonDataPath ?? string.Empty;
		spec.HookRopeBoneCount = Mathf.Max(2, config.hookRopeBoneCount);
		spec.HookRopeMaxLength = Mathf.Max(0.1f, config.hookRopeMaxLength);
		spec.HookRopeDamping = Mathf.Max(0f, config.hookRopeDamping);
		spec.HookRopeStiffness = Mathf.Max(0f, config.hookRopeStiffness);
	}

	public static SummerRaceEquipSpec ToRuntimeSpec(this SummerRaceEquipDefSO config, EquipKind kind)
	{
		SummerRaceEquipSpec summerRaceEquipSpec = new SummerRaceEquipSpec();
		config.ApplyToRuntimeSpec(summerRaceEquipSpec, kind);
		return summerRaceEquipSpec;
	}
}
