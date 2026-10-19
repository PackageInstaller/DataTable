using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Rendering;

public static class GameRenderScene
{
	public enum Scene
	{
		AllEnable,
		MainBattle,
		CharacterTeam,
		AVG,
		Room,
		CardDraw,
		UltraCutscene,
		CreateCharacter,
		TimelineConversation,
		SceneTimeline
	}

	private static bool m_SceneWantsGTAO = true;

	private static int m_SceneGTAOSampleStepWidth = 48;

	private static int m_SceneGTAODownSample = 2;

	private static bool m_SceneWantsSSR;

	private static bool m_NativeRenderPassAllowed = true;

	private static bool m_LeftModelSpecialRenderingEnabled;

	public static Scene Current { get; private set; } = Scene.AllEnable;

	public static bool RealtimeLightShadowsEnabled
	{
		get
		{
			if (Current != Scene.CharacterTeam && Current != Scene.AVG)
			{
				return Current != Scene.UltraCutscene;
			}
			return false;
		}
	}

	public static bool GTAOAllowed { get; private set; } = true;

	public static bool SSRAllowed { get; private set; } = true;

	public static void SetGTAOAllowed(bool allowed)
	{
		GTAOAllowed = allowed;
		ApplyGTAO();
	}

	public static void SetSSRAllowed(bool allowed)
	{
		SSRAllowed = allowed;
		ApplySSR();
	}

	public static void Set(Scene scene)
	{
		Current = scene;
		SetLightShadowProfile();
		bool flag = scene == Scene.MainBattle || scene == Scene.TimelineConversation || scene == Scene.SceneTimeline;
		bool characterOutlineProfile = scene != Scene.MainBattle && scene != Scene.TimelineConversation;
		bool characterPureOuterOutlineProfile = flag;
		SetCharacterOutlineProfile(characterOutlineProfile);
		SetCharacterPureOuterOutlineProfile(characterPureOuterOutlineProfile);
		SetCharacterMainLightShadowReceiveProfile(scene == Scene.MainBattle);
		bool num = scene == Scene.MainBattle || scene == Scene.CharacterTeam || scene == Scene.AVG || scene == Scene.Room || scene == Scene.CardDraw || scene == Scene.UltraCutscene || scene == Scene.CreateCharacter || scene == Scene.TimelineConversation;
		SetHDShadowProfile(receiveFaceHDShadow: scene != Scene.Room, enableHDShadow: num && scene != Scene.Room);
		Singleton<GameManager>.instance.characterHDShadowManager.SetScene(scene);
		bool flag2 = scene == Scene.AllEnable || scene == Scene.CreateCharacter;
		SetCapsuleAOProfile(flag | flag2);
		switch (scene)
		{
		case Scene.MainBattle:
		case Scene.TimelineConversation:
		case Scene.SceneTimeline:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: false);
			SetGTAOProfile(enableGTAO: true, 48);
			SetSSRProfile(enableSSR: true);
			break;
		case Scene.UltraCutscene:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: false, 48);
			SetSSRProfile(enableSSR: false);
			break;
		case Scene.CharacterTeam:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: false, 48);
			SetSSRProfile(enableSSR: false);
			break;
		case Scene.AVG:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: false, 48);
			SetSSRProfile(enableSSR: false);
			break;
		case Scene.Room:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: true, 128);
			SetSSRProfile(enableSSR: true);
			break;
		case Scene.CardDraw:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: true, 96);
			SetSSRProfile(enableSSR: true);
			break;
		default:
			SetAdvancedHairRenderingProfile(enableAdvancedHairRendering: true);
			SetGTAOProfile(enableGTAO: true, 48);
			SetSSRProfile(enableSSR: false);
			break;
		}
	}

	public static void Set(int scene)
	{
		Set(ToScene(scene));
	}

	private static Scene ToScene(int scene)
	{
		return scene switch
		{
			1 => Scene.MainBattle, 
			2 => Scene.CharacterTeam, 
			3 => Scene.AVG, 
			4 => Scene.Room, 
			5 => Scene.CardDraw, 
			6 => Scene.UltraCutscene, 
			7 => Scene.CreateCharacter, 
			8 => Scene.TimelineConversation, 
			9 => Scene.SceneTimeline, 
			_ => Scene.AllEnable, 
		};
	}

	public static void SetNativeRenderPassAllowed(bool allowed)
	{
		m_NativeRenderPassAllowed = allowed;
		ApplyNativeRenderPass("PipelineOptimize");
	}

	public static void SetLeftModelSpecialRenderingEnabled(bool enabled)
	{
		m_LeftModelSpecialRenderingEnabled = enabled;
		ApplyNativeRenderPass(enabled ? "LeftModel.Enter" : "LeftModel.Exit");
	}

	private static void ApplyNativeRenderPass(string source)
	{
		bool flag = m_NativeRenderPassAllowed && !m_LeftModelSpecialRenderingEnabled;
		URPGraphicSettings.SetNativeRenderPass(flag);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[NativeRenderPass] {source}, LeftModelRendering={m_LeftModelSpecialRenderingEnabled}, Allowed={m_NativeRenderPassAllowed}, NativeEnabled={flag}, RenderScene={Current}");
		}
	}

	private static void SetLightShadowProfile()
	{
		SettingOptions settingOptions = SettingsManager.Instance?.RuntimeSettings?.GetSettingOptions("Graphic.ShadowQuality");
		if (settingOptions != null && settingOptions.HasConnection())
		{
			settingOptions.PushToConnection();
		}
		else if (!RealtimeLightShadowsEnabled)
		{
			URPGraphicSettings.DisableRealtimeShadows();
		}
	}

	private static void SetCharacterOutlineProfile(bool enable)
	{
		GetUniversalRenderer().SetCharacterOutlineConfiguration(enable);
	}

	private static void SetAdvancedHairRenderingProfile(bool enableAdvancedHairRendering)
	{
		GetUniversalRenderer().SetHairShadowEnable(enableAdvancedHairRendering);
	}

	private static void SetCharacterPureOuterOutlineProfile(bool enableCharacterPureOuterOutline)
	{
		GetUniversalRenderer().SetCharacterOutlineForceGreater(enableCharacterPureOuterOutline);
	}

	private static void SetCharacterMainLightShadowReceiveProfile(bool enable)
	{
		GetUniversalRenderer().SetCharacterMainLightShadowReceive(enable);
	}

	private static void SetGTAOProfile(bool enableGTAO, int sampleStepWidth, int downSample = 2)
	{
		m_SceneWantsGTAO = enableGTAO;
		m_SceneGTAOSampleStepWidth = sampleStepWidth;
		m_SceneGTAODownSample = downSample;
		ApplyGTAO();
	}

	private static void ApplyGTAO()
	{
		GTAOFeature rendererFeature = GetRendererFeature<GTAOFeature>();
		GTAOFeature.Settings runtimeSettings = rendererFeature.runtimeSettings;
		runtimeSettings.enableGTAO = m_SceneWantsGTAO && GTAOAllowed;
		runtimeSettings.sampleStepWidth = Mathf.Clamp(m_SceneGTAOSampleStepWidth, 1, 128);
		runtimeSettings.downSample = Mathf.Clamp(m_SceneGTAODownSample, 1, 6);
		rendererFeature.ApplyRuntimeSettings();
	}

	private static void SetCapsuleAOProfile(bool enableCapsuleAO)
	{
		CapsuleAOFeature rendererFeature = GetRendererFeature<CapsuleAOFeature>();
		rendererFeature.runtimeSettings.enableCapsuleAO = enableCapsuleAO;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static void SetSSRProfile(bool enableSSR)
	{
		m_SceneWantsSSR = enableSSR;
		ApplySSR();
	}

	private static void ApplySSR()
	{
		SSRFeature rendererFeature = GetRendererFeature<SSRFeature>();
		rendererFeature.runtimeSSRSettings.enableSSR = m_SceneWantsSSR && SSRAllowed;
		rendererFeature.runtimeSSGISettings.enableSSGI = false;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static void SetHDShadowProfile(bool enableHDShadow, bool receiveFaceHDShadow)
	{
		HDShadowFeature rendererFeature = GetRendererFeature<HDShadowFeature>();
		rendererFeature.runtimeSettings.shadowQuality = (enableHDShadow ? GetHDShadowQualityForPlatform() : HDCharShadowPass.HDShadowQuality.None);
		rendererFeature.runtimeSettings.receiveFaceHDShadow = receiveFaceHDShadow;
		rendererFeature.ApplyRuntimeSettings();
	}

	private static HDCharShadowPass.HDShadowQuality GetHDShadowQualityForPlatform()
	{
		return HDCharShadowPass.HDShadowQuality.Low;
	}

	private static UniversalRenderer GetUniversalRenderer()
	{
		return (UniversalRenderer)((UniversalRenderPipelineAsset)QualitySettings.renderPipeline).scriptableRenderer;
	}

	private static T GetRendererFeature<T>() where T : ScriptableRendererFeature
	{
		((UniversalRenderPipelineAsset)QualitySettings.renderPipeline).scriptableRendererData.TryGetRendererFeature<T>(out var rendererFeature);
		return rendererFeature;
	}
}
