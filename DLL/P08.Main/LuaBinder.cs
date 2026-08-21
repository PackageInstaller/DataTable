using System;
using System.Net.Sockets;
using Cinemachine;
using CriMana;
using LuaInterface;
using RogoDigital.Lipsync;
using Spine;
using Spine.Unity;
using Unity.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using UnityEngine.U2D;
using UnityEngine.UI;
using UnityEngine.Video;

public static class LuaBinder
{
	public static void Bind(LuaState L)
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		L.BeginModule(null);
		LuaInterface_DebuggerWrap.Register(L);
		CharacterEffectWrap.Register(L);
		PathManagerWrap.Register(L);
		ResourceManagerWrap.Register(L);
		DebugMgrWrap.Register(L);
		LuaHelperWrap.Register(L);
		CustomLogWrap.Register(L);
		RandomUtilWrap.Register(L);
		RandomExWrap.Register(L);
		DRandomWrap.Register(L);
		YSTcpConnectionWrap.Register(L);
		PackStreamWrap.Register(L);
		PacketWrap.Register(L);
		InputFieldHelperWrap.Register(L);
		EmojiTextWrap.Register(L);
		EmojiEffectWrap.Register(L);
		CommonDragWrap.Register(L);
		LeanTweenWrap.Register(L);
		LeanTweenTypeWrap.Register(L);
		TweenListWrap.Register(L);
		TweenManagerWrap.Register(L);
		LTDescrWrap.Register(L);
		TimerCenterWrap.Register(L);
		TimeUtilWrap.Register(L);
		EventTriggerListenerWrap.Register(L);
		UIPolygonWrap.Register(L);
		DftAniEventWrap.Register(L);
		StickControllerWrap.Register(L);
		ParticleSystemEventWrap.Register(L);
		DelayPlayActionWrap.Register(L);
		ChangeEffectPlaySpeedWrap.Register(L);
		StatisticsDataWrap.Register(L);
		DeadAgentWrap.Register(L);
		HurtInfoWrap.Register(L);
		HitRecoverInfoWrap.Register(L);
		DamageTypeWrap.Register(L);
		TextExtensionWrap.Register(L);
		Hanzi2PinyinWrap.Register(L);
		InputFieldExtWrap.Register(L);
		LoadingBarWrap.Register(L);
		CowRunWrap.Register(L);
		TextureUtilWrap.Register(L);
		SceneForLuaWrap.Register(L);
		ScrollRectCastWrap.Register(L);
		SceneLoadAndUnloadManagerWrap.Register(L);
		GeometryTypeWrap.Register(L);
		DrawGeometryWrap.Register(L);
		AssetWrap.Register(L);
		PooledAssetWrap.Register(L);
		AssetExWrap.Register(L);
		AssetBundleLoadOperationWrap.Register(L);
		AtlasManagerWrap.Register(L);
		LuaExchangeHelperWrap.Register(L);
		BattleResultForLuaWrap.Register(L);
		RoleDataForExchangeWrap.Register(L);
		TranslateDataWrap.Register(L);
		LuaForUtilWrap.Register(L);
		LuaForSplashWrap.Register(L);
		VoidLuaCallbackWrap.Register(L);
		RegionServerInfoWrap.Register(L);
		RegionServerUserInfoWrap.Register(L);
		RegionServerMgrWrap.Register(L);
		LoadingUITypeWrap.Register(L);
		LoadingUIManagerWrap.Register(L);
		AudioManagerWrap.Register(L);
		CriAtomExPlaybackWrap.Register(L);
		CriAtomSourceWrap.Register(L);
		CutPictureWrap.Register(L);
		ScreenShotWrap.Register(L);
		ScreenSnapWrap.Register(L);
		WaitRenderFrameUtilWrap.Register(L);
		BulletinBoardMgrWrap.Register(L);
		ArcSliderWrap.Register(L);
		I18NRuntimeManagerWrap.Register(L);
		VideoDataMgrWrap.Register(L);
		CameraTestGizmosWrap.Register(L);
		VerticalCenterOnChildWrap.Register(L);
		ComponentCfgerWrap.Register(L);
		OnClickDownListenerWrap.Register(L);
		UIScaleImageWrap.Register(L);
		SelfUIScaleImageWrap.Register(L);
		TextTypeWriteWrap.Register(L);
		EffectHelperWrap.Register(L);
		LuaProfilerWrap.Register(L);
		ClientInfoWrap.Register(L);
		GameToSDKWrap.Register(L);
		FuncTimerManagerWrap.Register(L);
		ControllerWrap.Register(L);
		ControllerUtilWrap.Register(L);
		CToggleWrap.Register(L);
		StatUtilWrap.Register(L);
		SplineProgressBarWrap.Register(L);
		UIListWrap.Register(L);
		UIListAlignmentWrap.Register(L);
		UIScrollerWrap.Register(L);
		UIScrollerOrientationWrap.Register(L);
		UIScrollerAppearTypeWrap.Register(L);
		UITreeWrap.Register(L);
		UITreeGroupWrap.Register(L);
		UITreeItemWrap.Register(L);
		UITreeGroupDataWrap.Register(L);
		UITreeItemDataWrap.Register(L);
		UITreeDataWrap.Register(L);
		OrientationWrap.Register(L);
		CriManaMovieControllerForUIWrap.Register(L);
		AdaptImageWrap.Register(L);
		SelfAdaptImageWrap.Register(L);
		ExtendTextWrap.Register(L);
		UIPanelWrap.Register(L);
		DrawControllerWrap.Register(L);
		ViewAnimationManagerWrap.Register(L);
		AdaptiveServantSpriteWrap.Register(L);
		DynamicTimelineControllerWrap.Register(L);
		WebViewObjectWrap.Register(L);
		DynamicBoneHelperWrap.Register(L);
		UIPoseMoveControllerWrap.Register(L);
		SceneDataForExcehangeWrap.Register(L);
		MasterSkillDataForExchangeWrap.Register(L);
		CacheAssetInfoWrap.Register(L);
		ChessDataForExchangeWrap.Register(L);
		MapConfigWrap.Register(L);
		GridConfigWrap.Register(L);
		GridChangeDataWrap.Register(L);
		ChessLuaBridgeWrap.Register(L);
		NewCacheAssetInfoWrap.Register(L);
		NewChessDataForExchangeWrap.Register(L);
		NewChessConfigDataWrap.Register(L);
		NewMapConfigWrap.Register(L);
		NewGridConfigWrap.Register(L);
		NewWarChessThingConfigWrap.Register(L);
		NewGridChangeDataWrap.Register(L);
		NewChessLuaBridgeWrap.Register(L);
		ChessBoardDataForExchangeWrap.Register(L);
		ChessBoardGirdChangeDataWrap.Register(L);
		ChessBoardThingChangeDataWrap.Register(L);
		ChessBoardBanDirChangeDataWrap.Register(L);
		ChessBoardConfigDataWrap.Register(L);
		ChessBoardGridConfigWrap.Register(L);
		ChessBoardThingConfigWrap.Register(L);
		ChessBoardNPCDataWrap.Register(L);
		ChessBoardLuaBridgeWrap.Register(L);
		ChessBoardSmallMapDataWrap.Register(L);
		MusicLuaBridgeWrap.Register(L);
		MusicDataForExchangeWrap.Register(L);
		ZumaLuaBridgeWrap.Register(L);
		ZumaDataForExchangeWrap.Register(L);
		ZumaEffectDataWrap.Register(L);
		CooperateSkillBridgeWrap.Register(L);
		FurnitureConfigWrap.Register(L);
		FurnitureInfoWrap.Register(L);
		RoomInfoWrap.Register(L);
		DormCameraParamsWrap.Register(L);
		DormMapCfgWrap.Register(L);
		DormLuaBridgeWrap.Register(L);
		DormDataForExchangeWrap.Register(L);
		DormTagBaseWrap.Register(L);
		DormItemTagWrap.Register(L);
		DormTagConstWrap.Register(L);
		VoiceOfObtainHeroSimplePlayerWrap.Register(L);
		FlipCardGameControllerWrap.Register(L);
		BloodCardManagerWrap.Register(L);
		ColorPuzzleWrap.Register(L);
		BlisterGameLuaBridgeWrap.Register(L);
		CombineGameWorldWrap.Register(L);
		EatSnakeMainWrap.Register(L);
		EatSnakesBridgeWrap.Register(L);
		GuildActivityLuaBridgeWrap.Register(L);
		GuildActivityDataForExchangeWrap.Register(L);
		GuildActivityManagerWrap.Register(L);
		GuildActivityNodeDataListWrap.Register(L);
		GuildActivitySelfDataWrap.Register(L);
		GuildActivityNodeDataWrap.Register(L);
		GuildActivitySPLuaBridgeWrap.Register(L);
		GuildActivitySPDataForExchangeWrap.Register(L);
		GuildActivitySPManagerWrap.Register(L);
		GuildActivitySPNodeDataListWrap.Register(L);
		GuildActivitySPSelfDataWrap.Register(L);
		GuildActivitySPNodeDataWrap.Register(L);
		UITypewriterEffectWrap.Register(L);
		SceneSettingWrap.Register(L);
		BattleUIAdapterWrap.Register(L);
		BattleUIAdapterDataWrap.Register(L);
		VoicePackageManagerWrap.Register(L);
		ScreenRotateUtilWrap.Register(L);
		U3DHudWrap.Register(L);
		Int3Wrap.Register(L);
		RepairAssetsToLuaWrap.Register(L);
		CriManaExMultipleVedioWrap.Register(L);
		LuaForGamepadWrap.Register(L);
		LuaForCursorWrap.Register(L);
		PaperCutManagerWrap.Register(L);
		PaperCutUIImageWrap.Register(L);
		StoryOverlayAnimationControllerWrap.Register(L);
		SailGameManagerWrap.Register(L);
		SailGameDataForExchangeWrap.Register(L);
		FileStreamMgrWrap.Register(L);
		CharPreviewSettingWrap.Register(L);
		AssetDownloadManagerWrap.Register(L);
		CinemachineTransitionChekerWrap.Register(L);
		MutiTouchHelperWrap.Register(L);
		CharacterCameraManagerWrap.Register(L);
		HeroUITimelineBrainWrap.Register(L);
		HeroRaiseTrackControllerWrap.Register(L);
		HeroRaiseTrackDataWrap.Register(L);
		UIRedPointWrap.Register(L);
		UIRedPointStyleWrap.Register(L);
		DanceGameControllerWrap.Register(L);
		AssetPendDownLoadManagerWrap.Register(L);
		PendTypeWrap.Register(L);
		FloGameLuaBridgeWrap.Register(L);
		TangramGameBridgeWrap.Register(L);
		TangramDataExchangeWrap.Register(L);
		SimBusinessMgrWrap.Register(L);
		TetrisGameBridgeWrap.Register(L);
		TetrisGameExchangeWrap.Register(L);
		TetrisGameGuideInfoWrap.Register(L);
		TugGameToLuaBridgeWrap.Register(L);
		TugGameDataWrap.Register(L);
		TugSkillInfoWrap.Register(L);
		TugInfoWrap.Register(L);
		ShootGameToLuaBridgeWrap.Register(L);
		WaterPipeBrigeWrap.Register(L);
		QWorldMapEntityWrap.Register(L);
		QWorldLuaBridgeWrap.Register(L);
		QWorldThingEntityDataWrap.Register(L);
		QWorldBranchCallbackWrap.Register(L);
		QWorldMiniMapUnitWrap.Register(L);
		QWPerformManagerWrap.Register(L);
		QWorldMaxMapUIWrap.Register(L);
		QWorldMiniMapUIWrap.Register(L);
		QWorldMultiTargetTrackerWrap.Register(L);
		QWorldUIWrap.Register(L);
		PinballLuaBridgeWrap.Register(L);
		RoundInfoWrap.Register(L);
		PinballRoleBattleDataWrap.Register(L);
		PinballRoleSkillDataWrap.Register(L);
		PinballDataForExchangeWrap.Register(L);
		PinballMapGenerateDataWrap.Register(L);
		SkuldPuzzleBrigeWrap.Register(L);
		SkuldPuzzleConditionDataWrap.Register(L);
		SkuldPuzzleConditionDataListWrap.Register(L);
		BlendTwoTimelinesWrap.Register(L);
		BilliardGameLuaBridgeWrap.Register(L);
		SummerRaceLuaBridgeWrap.Register(L);
		BilliardGameEventTriggerWrap.Register(L);
		CookingGameBrigeWrap.Register(L);
		T0WorldLuaBridgeWrap.Register(L);
		T0GlobalWaitBubbleEventControllerWrap.Register(L);
		T0World_T0SDKDataWrap.Register(L);
		AutoChessBridgeWrap.Register(L);
		UIParabolaMotionWrap.Register(L);
		RollingNumberTextWrap.Register(L);
		OathLuaBridgeWrap.Register(L);
		InkCoverPureGameManagerWrap.Register(L);
		RogueCardBridgeWrap.Register(L);
		RollingNumberWrap.Register(L);
		CriAtomSourceBaseWrap.Register(L);
		CriMonoBehaviourWrap.Register(L);
		CriManaMovieMaterialWrap.Register(L);
		CriManaMovieMaterialBaseWrap.Register(L);
		CriDisposableWrap.Register(L);
		SimplePlayerBaseWrap.Register(L);
		QWorldEntityDataWrap.Register(L);
		L.RegFunction("OnVoidHandler_string", OnVoidHandler_string);
		L.RegFunction("OnVoidHandler_int", OnVoidHandler_int);
		L.RegFunction("OnVoidHandler_object_object", OnVoidHandler_object_object);
		L.RegFunction("OnVoidHandler_object", OnVoidHandler_object);
		L.RegFunction("OnVoidHandler_UnityEngine_Object", OnVoidHandler_UnityEngine_Object);
		L.RegFunction("OnVoidHandler_UnityEngine_Sprite", OnVoidHandler_UnityEngine_Sprite);
		L.BeginModule("LuaInterface");
		LuaInterface_LuaInjectionStationWrap.Register(L);
		LuaInterface_InjectTypeWrap.Register(L);
		L.EndModule();
		L.BeginModule("UnityEngine");
		UnityEngine_ComponentWrap.Register(L);
		UnityEngine_TransformWrap.Register(L);
		UnityEngine_MaterialWrap.Register(L);
		UnityEngine_CameraWrap.Register(L);
		UnityEngine_AudioSourceWrap.Register(L);
		UnityEngine_AudioListenerWrap.Register(L);
		UnityEngine_PrimitiveTypeWrap.Register(L);
		UnityEngine_BehaviourWrap.Register(L);
		UnityEngine_MonoBehaviourWrap.Register(L);
		UnityEngine_GameObjectWrap.Register(L);
		UnityEngine_TrackedReferenceWrap.Register(L);
		UnityEngine_ApplicationWrap.Register(L);
		UnityEngine_PhysicsWrap.Register(L);
		UnityEngine_Physics2DWrap.Register(L);
		UnityEngine_ColliderWrap.Register(L);
		UnityEngine_TimeWrap.Register(L);
		UnityEngine_TextureWrap.Register(L);
		UnityEngine_Texture2DWrap.Register(L);
		UnityEngine_ShaderWrap.Register(L);
		UnityEngine_RendererWrap.Register(L);
		UnityEngine_MaterialPropertyBlockWrap.Register(L);
		UnityEngine_ScreenWrap.Register(L);
		UnityEngine_ScreenOrientationWrap.Register(L);
		UnityEngine_CameraClearFlagsWrap.Register(L);
		UnityEngine_AudioClipWrap.Register(L);
		UnityEngine_AssetBundleWrap.Register(L);
		UnityEngine_ParticleSystemWrap.Register(L);
		UnityEngine_AsyncOperationWrap.Register(L);
		UnityEngine_SleepTimeoutWrap.Register(L);
		UnityEngine_AnimatorWrap.Register(L);
		UnityEngine_AnimatorClipInfoWrap.Register(L);
		UnityEngine_MotionWrap.Register(L);
		UnityEngine_RuntimeAnimatorControllerWrap.Register(L);
		UnityEngine_AnimationEventWrap.Register(L);
		UnityEngine_InputWrap.Register(L);
		UnityEngine_KeyCodeWrap.Register(L);
		UnityEngine_RuntimePlatformWrap.Register(L);
		UnityEngine_SystemLanguageWrap.Register(L);
		UnityEngine_SkinnedMeshRendererWrap.Register(L);
		UnityEngine_MeshWrap.Register(L);
		UnityEngine_SpaceWrap.Register(L);
		UnityEngine_BoxCollider2DWrap.Register(L);
		UnityEngine_AnimationBlendModeWrap.Register(L);
		UnityEngine_QueueModeWrap.Register(L);
		UnityEngine_PlayModeWrap.Register(L);
		UnityEngine_WrapModeWrap.Register(L);
		UnityEngine_RenderSettingsWrap.Register(L);
		UnityEngine_GizmosWrap.Register(L);
		UnityEngine_ResourcesWrap.Register(L);
		UnityEngine_RectTransformWrap.Register(L);
		UnityEngine_RectWrap.Register(L);
		UnityEngine_CanvasWrap.Register(L);
		UnityEngine_SpriteWrap.Register(L);
		UnityEngine_RectTransformUtilityWrap.Register(L);
		UnityEngine_PlayerPrefsWrap.Register(L);
		UnityEngine_SpriteRendererWrap.Register(L);
		UnityEngine_TextMeshWrap.Register(L);
		UnityEngine_CanvasGroupWrap.Register(L);
		UnityEngine_AnimatorStateInfoWrap.Register(L);
		UnityEngine_SystemInfoWrap.Register(L);
		UnityEngine_NetworkReachabilityWrap.Register(L);
		UnityEngine_TextAnchorWrap.Register(L);
		UnityEngine_TextGeneratorWrap.Register(L);
		UnityEngine_RectOffsetWrap.Register(L);
		UnityEngine_GUIUtilityWrap.Register(L);
		UnityEngine_ResolutionWrap.Register(L);
		UnityEngine_FullScreenModeWrap.Register(L);
		UnityEngine_RenderTextureFormatWrap.Register(L);
		UnityEngine_SpriteMeshTypeWrap.Register(L);
		UnityEngine_AudioBehaviourWrap.Register(L);
		UnityEngine_Collider2DWrap.Register(L);
		UnityEngine_ScriptableObjectWrap.Register(L);
		L.BeginModule("UI");
		UnityEngine_UI_RectMask2DWrap.Register(L);
		UnityEngine_UI_ImageWrap.Register(L);
		UnityEngine_UI_TextWrap.Register(L);
		UnityEngine_UI_ButtonWrap.Register(L);
		UnityEngine_UI_RawImageWrap.Register(L);
		UnityEngine_UI_InputFieldWrap.Register(L);
		UnityEngine_UI_LayoutElementWrap.Register(L);
		UnityEngine_UI_SliderWrap.Register(L);
		UnityEngine_UI_ToggleWrap.Register(L);
		UnityEngine_UI_ToggleGroupWrap.Register(L);
		UnityEngine_UI_DropdownWrap.Register(L);
		UnityEngine_UI_ScrollbarWrap.Register(L);
		UnityEngine_UI_ScrollRectWrap.Register(L);
		UnityEngine_UI_ScrollRectExWrap.Register(L);
		UnityEngine_UI_ContentSizeFitterWrap.Register(L);
		UnityEngine_UI_LayoutRebuilderWrap.Register(L);
		UnityEngine_UI_LayoutUtilityWrap.Register(L);
		UnityEngine_UI_HorizontalLayoutGroupWrap.Register(L);
		UnityEngine_UI_MaskableGraphicWrap.Register(L);
		UnityEngine_UI_GraphicWrap.Register(L);
		UnityEngine_UI_SelectableWrap.Register(L);
		UnityEngine_UI_LayoutGroupWrap.Register(L);
		UnityEngine_UI_RichTextWrap.Register(L);
		UnityEngine_UI_LScrollRectWrap.Register(L);
		UnityEngine_UI_GridLayoutGroupWrap.Register(L);
		UnityEngine_UI_VerticalLayoutGroupWrap.Register(L);
		UnityEngine_UI_BaseMeshEffectWrap.Register(L);
		UnityEngine_UI_HorizontalOrVerticalLayoutGroupWrap.Register(L);
		L.BeginModule("Button");
		UnityEngine_UI_Button_ButtonClickedEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("InputField");
		UnityEngine_UI_InputField_ContentTypeWrap.Register(L);
		UnityEngine_UI_InputField_OnChangeEventWrap.Register(L);
		UnityEngine_UI_InputField_SubmitEventWrap.Register(L);
		L.RegFunction("OnValidateInput", UnityEngine_UI_InputField_OnValidateInput);
		L.EndModule();
		L.BeginModule("Toggle");
		UnityEngine_UI_Toggle_ToggleEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("Dropdown");
		UnityEngine_UI_Dropdown_DropdownEventWrap.Register(L);
		UnityEngine_UI_Dropdown_OptionDataWrap.Register(L);
		UnityEngine_UI_Dropdown_OptionDataListWrap.Register(L);
		L.EndModule();
		L.BeginModule("Scrollbar");
		UnityEngine_UI_Scrollbar_ScrollEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("ScrollRect");
		UnityEngine_UI_ScrollRect_ScrollRectEventWrap.Register(L);
		UnityEngine_UI_ScrollRect_MovementTypeWrap.Register(L);
		L.EndModule();
		L.BeginModule("ContentSizeFitter");
		UnityEngine_UI_ContentSizeFitter_FitModeWrap.Register(L);
		L.EndModule();
		L.BeginModule("Selectable");
		UnityEngine_UI_Selectable_TransitionWrap.Register(L);
		L.EndModule();
		L.BeginModule("Slider");
		UnityEngine_UI_Slider_SliderEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("LScrollRect");
		UnityEngine_UI_LScrollRect_ScrollRectEventWrap.Register(L);
		L.RegFunction("UpdateItems", UnityEngine_UI_LScrollRect_UpdateItems);
		L.EndModule();
		L.EndModule();
		L.BeginModule("EventSystems");
		UnityEngine_EventSystems_PhysicsRaycasterWrap.Register(L);
		UnityEngine_EventSystems_Physics2DRaycasterWrap.Register(L);
		UnityEngine_EventSystems_EventTriggerTypeWrap.Register(L);
		UnityEngine_EventSystems_PointerEventDataWrap.Register(L);
		UnityEngine_EventSystems_EventTriggerWrap.Register(L);
		UnityEngine_EventSystems_BaseEventDataWrap.Register(L);
		UnityEngine_EventSystems_AbstractEventDataWrap.Register(L);
		UnityEngine_EventSystems_UIBehaviourWrap.Register(L);
		UnityEngine_EventSystems_EventSystemWrap.Register(L);
		UnityEngine_EventSystems_BaseRaycasterWrap.Register(L);
		L.EndModule();
		L.BeginModule("Pipelines");
		L.BeginModule("SimPipeline");
		UnityEngine_Pipelines_SimPipeline_DepthOfFieldTypeWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_CameraExtensionWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_SimPipelineSettingsWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_CanvasManagerWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_CanvasAdditionWrap.Register(L);
		L.BeginModule("Character");
		UnityEngine_Pipelines_SimPipeline_Character_ImageEffectWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_Character_InterferenceEffectWrap.Register(L);
		UnityEngine_Pipelines_SimPipeline_Character_EffectBaseWrap.Register(L);
		L.EndModule();
		L.BeginModule("CameraExtension");
		UnityEngine_Pipelines_SimPipeline_CameraExtension_MsaaQualityWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.EndModule();
		L.BeginModule("Events");
		UnityEngine_Events_UnityEvent_System_Net_Sockets_SocketErrorWrap.Register(L);
		UnityEngine_Events_UnityEvent_PacketWrap.Register(L);
		UnityEngine_Events_UnityEventWrap.Register(L);
		UnityEngine_Events_UnityEventBaseWrap.Register(L);
		UnityEngine_Events_UnityEvent_intWrap.Register(L);
		UnityEngine_Events_UnityEvent_boolWrap.Register(L);
		UnityEngine_Events_UnityEvent_stringWrap.Register(L);
		UnityEngine_Events_UnityEvent_floatWrap.Register(L);
		UnityEngine_Events_UnityEvent_UnityEngine_Vector2Wrap.Register(L);
		L.RegFunction("UnityAction", UnityEngine_Events_UnityAction);
		L.RegFunction("UnityAction_System_Net_Sockets_SocketError", UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError);
		L.RegFunction("UnityAction_string", UnityEngine_Events_UnityAction_string);
		L.RegFunction("UnityAction_Packet", UnityEngine_Events_UnityAction_Packet);
		L.RegFunction("UnityAction_UnityEngine_SpriteRenderer", UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer);
		L.RegFunction("UnityAction_UnityEngine_EventSystems_BaseEventData", UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData);
		L.RegFunction("UnityAction_bool", UnityEngine_Events_UnityAction_bool);
		L.RegFunction("UnityAction_int", UnityEngine_Events_UnityAction_int);
		L.RegFunction("UnityAction_float", UnityEngine_Events_UnityAction_float);
		L.RegFunction("UnityAction_UnityEngine_Vector2", UnityEngine_Events_UnityAction_UnityEngine_Vector2);
		L.RegFunction("UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode", UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode);
		L.RegFunction("UnityAction_UnityEngine_SceneManagement_Scene", UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene);
		L.RegFunction("UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene", UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene);
		L.RegFunction("UnityAction_DownloadRequest", UnityEngine_Events_UnityAction_DownloadRequest);
		L.RegFunction("UnityAction_UnityEngine_Sprite", UnityEngine_Events_UnityAction_UnityEngine_Sprite);
		L.EndModule();
		L.BeginModule("RectTransform");
		UnityEngine_RectTransform_AxisWrap.Register(L);
		UnityEngine_RectTransform_EdgeWrap.Register(L);
		L.RegFunction("ReapplyDrivenProperties", UnityEngine_RectTransform_ReapplyDrivenProperties);
		L.EndModule();
		L.BeginModule("Video");
		UnityEngine_Video_VideoPlayerWrap.Register(L);
		UnityEngine_Video_VideoClipWrap.Register(L);
		L.BeginModule("VideoPlayer");
		L.RegFunction("EventHandler", UnityEngine_Video_VideoPlayer_EventHandler);
		L.RegFunction("ErrorEventHandler", UnityEngine_Video_VideoPlayer_ErrorEventHandler);
		L.RegFunction("TimeEventHandler", UnityEngine_Video_VideoPlayer_TimeEventHandler);
		L.RegFunction("FrameReadyEventHandler", UnityEngine_Video_VideoPlayer_FrameReadyEventHandler);
		L.EndModule();
		L.EndModule();
		L.BeginModule("Playables");
		UnityEngine_Playables_PlayableDirectorWrap.Register(L);
		UnityEngine_Playables_PlayableAssetWrap.Register(L);
		UnityEngine_Playables_PlayableBindingWrap.Register(L);
		UnityEngine_Playables_DirectorWrapModeWrap.Register(L);
		L.EndModule();
		L.BeginModule("Timeline");
		UnityEngine_Timeline_TimelineAssetWrap.Register(L);
		UnityEngine_Timeline_TrackAssetWrap.Register(L);
		UnityEngine_Timeline_AnimationTrackWrap.Register(L);
		L.EndModule();
		L.BeginModule("ParticleSystem");
		UnityEngine_ParticleSystem_MainModuleWrap.Register(L);
		L.EndModule();
		L.BeginModule("SceneManagement");
		UnityEngine_SceneManagement_SceneManagerWrap.Register(L);
		UnityEngine_SceneManagement_LoadSceneModeWrap.Register(L);
		UnityEngine_SceneManagement_SceneWrap.Register(L);
		L.EndModule();
		L.BeginModule("U2D");
		UnityEngine_U2D_SpriteAtlasWrap.Register(L);
		L.EndModule();
		L.BeginModule("Rendering");
		UnityEngine_Rendering_VolumeWrap.Register(L);
		UnityEngine_Rendering_GraphicsSettingsWrap.Register(L);
		L.BeginModule("ReplicaExt");
		UnityEngine_Rendering_ReplicaExt_IngameGraphicSettingWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("Camera");
		L.RegFunction("CameraCallback", UnityEngine_Camera_CameraCallback);
		L.EndModule();
		L.BeginModule("Application");
		L.RegFunction("AdvertisingIdentifierCallback", UnityEngine_Application_AdvertisingIdentifierCallback);
		L.RegFunction("LowMemoryCallback", UnityEngine_Application_LowMemoryCallback);
		L.RegFunction("MemoryUsageChangedCallback", UnityEngine_Application_MemoryUsageChangedCallback);
		L.RegFunction("LogCallback", UnityEngine_Application_LogCallback);
		L.EndModule();
		L.BeginModule("Physics");
		L.RegFunction("ContactEventDelegate", UnityEngine_Physics_ContactEventDelegate);
		L.EndModule();
		L.BeginModule("AudioClip");
		L.RegFunction("PCMReaderCallback", UnityEngine_AudioClip_PCMReaderCallback);
		L.RegFunction("PCMSetPositionCallback", UnityEngine_AudioClip_PCMSetPositionCallback);
		L.EndModule();
		L.BeginModule("Canvas");
		L.RegFunction("WillRenderCanvases", UnityEngine_Canvas_WillRenderCanvases);
		L.EndModule();
		L.EndModule();
		L.BeginModule("TMPro");
		TMPro_TMP_TextWrap.Register(L);
		TMPro_TextMeshProWrap.Register(L);
		TMPro_TextMeshProUGUIWrap.Register(L);
		TMPro_TMP_FontAssetWrap.Register(L);
		L.EndModule();
		L.BeginModule("YSTcpConnection");
		YSTcpConnection_ConnectEventWrap.Register(L);
		YSTcpConnection_DisconnectEventWrap.Register(L);
		YSTcpConnection_ErrorEventWrap.Register(L);
		YSTcpConnection_PacketEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("System");
		L.RegFunction("Action", System_Action);
		L.RegFunction("Predicate_int", System_Predicate_int);
		L.RegFunction("Action_int", System_Action_int);
		L.RegFunction("Comparison_int", System_Comparison_int);
		L.RegFunction("Func_int_int", System_Func_int_int);
		L.RegFunction("Action_bool", System_Action_bool);
		L.RegFunction("Action_string", System_Action_string);
		L.RegFunction("Func_bool", System_Func_bool);
		L.RegFunction("Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair", System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair);
		L.RegFunction("Action_UnityEngine_AsyncOperation", System_Action_UnityEngine_AsyncOperation);
		L.RegFunction("Action_UnityEngine_Object", System_Action_UnityEngine_Object);
		L.RegFunction("Action_UnityEngine_UI_Image_string", System_Action_UnityEngine_UI_Image_string);
		L.RegFunction("Func_string_bool", System_Func_string_bool);
		L.RegFunction("Action_object", System_Action_object);
		L.RegFunction("Action_float", System_Action_float);
		L.RegFunction("Action_float_float", System_Action_float_float);
		L.RegFunction("Action_UnityEngine_Color", System_Action_UnityEngine_Color);
		L.RegFunction("Action_UnityEngine_Color_object", System_Action_UnityEngine_Color_object);
		L.RegFunction("Action_UnityEngine_Vector2", System_Action_UnityEngine_Vector2);
		L.RegFunction("Action_UnityEngine_Vector3", System_Action_UnityEngine_Vector3);
		L.RegFunction("Action_float_object", System_Action_float_object);
		L.RegFunction("Action_LTEvent", System_Action_LTEvent);
		L.RegFunction("Action_UnityEngine_Vector3_object", System_Action_UnityEngine_Vector3_object);
		L.RegFunction("Action_UnityEngine_Vector3_int", System_Action_UnityEngine_Vector3_int);
		L.RegFunction("Func_UnityEngine_Vector3_bool", System_Func_UnityEngine_Vector3_bool);
		L.RegFunction("Action_UnityEngine_Playables_PlayableDirector", System_Action_UnityEngine_Playables_PlayableDirector);
		L.RegFunction("Func_UnityEngine_UI_ILayoutElement_float", System_Func_UnityEngine_UI_ILayoutElement_float);
		L.RegFunction("Action_string_string", System_Action_string_string);
		L.RegFunction("Action_UnityEngine_U2D_SpriteAtlas", System_Action_UnityEngine_U2D_SpriteAtlas);
		L.RegFunction("Action_bool_string", System_Action_bool_string);
		L.RegFunction("Action_int_string_string_int", System_Action_int_string_string_int);
		L.RegFunction("Action_LoadingUIType", System_Action_LoadingUIType);
		L.RegFunction("Action_strings_strings", System_Action_strings_strings);
		L.RegFunction("Action_int_UnityEngine_GameObject", System_Action_int_UnityEngine_GameObject);
		L.RegFunction("Action_int_int", System_Action_int_int);
		L.RegFunction("Action_int_int_string_string", System_Action_int_int_string_string);
		L.RegFunction("Action_int_int_UnityEngine_Transform", System_Action_int_int_UnityEngine_Transform);
		L.RegFunction("Action_long_int_int", System_Action_long_int_int);
		L.RegFunction("Action_long_int", System_Action_long_int);
		L.RegFunction("Action_UnityEngine_Vector3_bool", System_Action_UnityEngine_Vector3_bool);
		L.BeginModule("Net");
		L.BeginModule("Sockets");
		System_Net_Sockets_SocketErrorWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("IO");
		System_IO_SeekOriginWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("Spine");
		Spine_AnimationStateWrap.Register(L);
		Spine_TrackEntryWrap.Register(L);
		Spine_AnimationWrap.Register(L);
		L.BeginModule("Unity");
		Spine_Unity_SkeletonGraphicWrap.Register(L);
		Spine_Unity_SkeletonAnimationWrap.Register(L);
		Spine_Unity_SkeletonRendererWrap.Register(L);
		L.RegFunction("UpdateBonesDelegate", Spine_Unity_UpdateBonesDelegate);
		L.RegFunction("MeshGeneratorDelegate", Spine_Unity_MeshGeneratorDelegate);
		L.BeginModule("SkeletonGraphic");
		L.RegFunction("SkeletonRendererDelegate", Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate);
		L.EndModule();
		L.BeginModule("SkeletonRenderer");
		L.RegFunction("InstructionDelegate", Spine_Unity_SkeletonRenderer_InstructionDelegate);
		L.RegFunction("SkeletonRendererDelegate", Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate);
		L.EndModule();
		L.EndModule();
		L.BeginModule("AnimationState");
		L.RegFunction("TrackEntryDelegate", Spine_AnimationState_TrackEntryDelegate);
		L.RegFunction("TrackEntryEventDelegate", Spine_AnimationState_TrackEntryEventDelegate);
		L.EndModule();
		L.EndModule();
		L.BeginModule("UI_Shader_Wrap");
		UI_Shader_Wrap_Effect_distortion_addWrap.Register(L);
		UI_Shader_Wrap_NiuQuGlitchWrap.Register(L);
		UI_Shader_Wrap_UIImageGlitchWrap.Register(L);
		L.EndModule();
		L.BeginModule("P08Main");
		L.BeginModule("Loading");
		P08Main_Loading_CustomLoadingManagerWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("CriAtomEx");
		CriAtomEx_ResumeModeWrap.Register(L);
		L.EndModule();
		L.BeginModule("ComponentCfger");
		ComponentCfger_UIComponentTypeWrap.Register(L);
		ComponentCfger_ComponentFieldWrap.Register(L);
		L.EndModule();
		L.BeginModule("Brent");
		L.BeginModule("UI");
		L.BeginModule("UIInjection");
		Brent_UI_UIInjection_UIInjectWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.EndModule();
		L.BeginModule("ControllerExSpace");
		ControllerExSpace_ControllerExCollectionWrap.Register(L);
		ControllerExSpace_ControllerExWrap.Register(L);
		L.EndModule();
		L.BeginModule("CriMana");
		CriMana_PlayerWrap.Register(L);
		L.BeginModule("Player");
		CriMana_Player_SetModeWrap.Register(L);
		L.RegFunction("CuePointCallback", CriMana_Player_CuePointCallback);
		L.RegFunction("StatusChangeCallback", CriMana_Player_StatusChangeCallback);
		L.RegFunction("SubtitleChangeCallback", CriMana_Player_SubtitleChangeCallback);
		L.RegFunction("ShaderDispatchCallback", CriMana_Player_ShaderDispatchCallback);
		L.EndModule();
		L.EndModule();
		L.BeginModule("RogoDigital");
		L.BeginModule("Lipsync");
		RogoDigital_Lipsync_LipSyncWrap.Register(L);
		RogoDigital_Lipsync_BlendSystemUserWrap.Register(L);
		L.BeginModule("BlendSystem");
		L.RegFunction("BlendSystemGenericDelegate", RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate);
		L.EndModule();
		L.BeginModule("LipSync");
		L.RegFunction("ResetDelegate", RogoDigital_Lipsync_LipSync_ResetDelegate);
		L.EndModule();
		L.EndModule();
		L.EndModule();
		L.BeginModule("Chess");
		Chess_GridDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("NewChess");
		NewChess_NewGridDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("ChessBoard");
		ChessBoard_ChessBoardGridDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("MusicGame");
		MusicGame_MusicSetControllerWrap.Register(L);
		L.EndModule();
		L.BeginModule("Dorm");
		Dorm_DormEntityManagerWrap.Register(L);
		Dorm_SubtitleWrap.Register(L);
		L.BeginModule("DormEntityManager");
		Dorm_DormEntityManager_WaitForNotifyWrap.Register(L);
		L.EndModule();
		L.BeginModule("LuaBridge");
		Dorm_LuaBridge_MiniGameBridgeWrap.Register(L);
		Dorm_LuaBridge_IlluBridgeWrap.Register(L);
		L.EndModule();
		L.BeginModule("UI");
		Dorm_UI_UIFollowWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("BattleUIAdapterData");
		BattleUIAdapterData_DataWrap.Register(L);
		L.EndModule();
		L.BeginModule("P08");
		L.BeginModule("Gamepad");
		P08_Gamepad_En_ButtonTypeWrap.Register(L);
		P08_Gamepad_HIDInputPageWrap.Register(L);
		L.EndModule();
		L.BeginModule("Quiz");
		P08_Quiz_QuizLuaBridgeWrap.Register(L);
		P08_Quiz_QuizDataForExchangeWrap.Register(L);
		P08_Quiz_QuizPlayerInfoWrap.Register(L);
		P08_Quiz_PlayerManagerWrap.Register(L);
		P08_Quiz_QuizPlayerWrap.Register(L);
		P08_Quiz_MonoSingleton_BloodCardManagerWrap.Register(L);
		P08_Quiz_Singleton_P08_Quiz_PlayerManagerWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("Packages");
		L.BeginModule("P08Base");
		Packages_P08Base_LRUWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("Cinemachine");
		Cinemachine_CinemachineBrainWrap.Register(L);
		Cinemachine_CinemachineVirtualCameraWrap.Register(L);
		Cinemachine_CinemachineVirtualCameraBaseWrap.Register(L);
		L.BeginModule("CinemachineVirtualCamera");
		L.RegFunction("CreatePipelineDelegate", Cinemachine_CinemachineVirtualCamera_CreatePipelineDelegate);
		L.RegFunction("DestroyPipelineDelegate", Cinemachine_CinemachineVirtualCamera_DestroyPipelineDelegate);
		L.EndModule();
		L.EndModule();
		L.BeginModule("I18N");
		I18N_I18NTextKeyToValueWrap.Register(L);
		L.EndModule();
		L.BeginModule("QWorld");
		L.BeginModule("Story");
		L.BeginModule("Runtime");
		QWorld_Story_Runtime_QWStoryGraphBlackboardWrap.Register(L);
		QWorld_Story_Runtime_QWStoryGraphActorWrap.Register(L);
		QWorld_Story_Runtime_QWStoryItemWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.EndModule();
		L.BeginModule("QWorldTalkBubbleMgr");
		QWorldTalkBubbleMgr_BubbleContentCfgWrap.Register(L);
		L.EndModule();
		L.BeginModule("Pinball");
		Pinball_PinballGameManagerWrap.Register(L);
		L.BeginModule("Runtime");
		Pinball_Runtime_StageDataWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("TetrisGame");
		TetrisGame_TetrisGameChipEventWrap.Register(L);
		L.EndModule();
		L.BeginModule("civilization");
		civilization_CivilizationLuaBridgeWrap.Register(L);
		civilization_CivilizationExchangeDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("BilliardGame");
		BilliardGame_BilliardHeroOrMonsterDataWrap.Register(L);
		BilliardGame_UseSkillDataWrap.Register(L);
		BilliardGame_BilliardGameExchangeDataWrap.Register(L);
		L.BeginModule("Runtime");
		BilliardGame_Runtime_StageDataWrap.Register(L);
		BilliardGame_Runtime_GridDataWrap.Register(L);
		BilliardGame_Runtime_MonsterDataWrap.Register(L);
		BilliardGame_Runtime_MechanismDataWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("T0WorldLuaBridge");
		T0WorldLuaBridge_T0SubtitleDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("pachinko");
		pachinko_PaChinKoControllerWrap.Register(L);
		pachinko_PaChinKoTriggerWrap.Register(L);
		L.EndModule();
		L.BeginModule("RogueCard");
		RogueCard_RogueCardDataManagerWrap.Register(L);
		RogueCard_HandTypeWrap.Register(L);
		RogueCard_RogueCardResultContextWrap.Register(L);
		RogueCard_RogueCardGameMainWrap.Register(L);
		RogueCard_RogueCardGameContextWrap.Register(L);
		RogueCard_RogueCardSaveDataWrap.Register(L);
		RogueCard_RogueCardSaveCardDataWrap.Register(L);
		RogueCard_RogueCardSaveJokerDataWrap.Register(L);
		RogueCard_RogueCardSaveSettleDataWrap.Register(L);
		L.EndModule();
		L.BeginModule("Sirenix");
		L.BeginModule("OdinInspector");
		Sirenix_OdinInspector_SerializedMonoBehaviourWrap.Register(L);
		L.EndModule();
		L.EndModule();
		L.BeginModule("LTDescr");
		L.RegFunction("EaseTypeDelegate", LTDescr_EaseTypeDelegate);
		L.RegFunction("ActionMethodDelegate", LTDescr_ActionMethodDelegate);
		L.EndModule();
		L.BeginModule("LuaHelper");
		L.RegFunction("ETLCallBack1", LuaHelper_ETLCallBack1);
		L.RegFunction("ETLCallBack2", LuaHelper_ETLCallBack2);
		L.RegFunction("ETLCallBack3", LuaHelper_ETLCallBack3);
		L.EndModule();
		L.BeginModule("CriManaMovieMaterialBase");
		L.RegFunction("OnApplicationPauseCallback", CriManaMovieMaterialBase_OnApplicationPauseCallback);
		L.EndModule();
		L.EndModule();
		L.BeginPreLoad();
		L.AddPreLoad("UnityEngine.MeshRenderer", LuaOpen_UnityEngine_MeshRenderer, typeof(MeshRenderer));
		L.AddPreLoad("UnityEngine.BoxCollider", LuaOpen_UnityEngine_BoxCollider, typeof(BoxCollider));
		L.AddPreLoad("UnityEngine.MeshCollider", LuaOpen_UnityEngine_MeshCollider, typeof(MeshCollider));
		L.AddPreLoad("UnityEngine.SphereCollider", LuaOpen_UnityEngine_SphereCollider, typeof(SphereCollider));
		L.AddPreLoad("UnityEngine.CharacterController", LuaOpen_UnityEngine_CharacterController, typeof(CharacterController));
		L.AddPreLoad("UnityEngine.CapsuleCollider", LuaOpen_UnityEngine_CapsuleCollider, typeof(CapsuleCollider));
		L.AddPreLoad("UnityEngine.Animation", LuaOpen_UnityEngine_Animation, typeof(UnityEngine.Animation));
		L.AddPreLoad("UnityEngine.AnimationClip", LuaOpen_UnityEngine_AnimationClip, typeof(AnimationClip));
		L.AddPreLoad("UnityEngine.AnimationState", LuaOpen_UnityEngine_AnimationState, typeof(UnityEngine.AnimationState));
		L.AddPreLoad("UnityEngine.SkinWeights", LuaOpen_UnityEngine_SkinWeights, typeof(SkinWeights));
		L.AddPreLoad("UnityEngine.RenderTexture", LuaOpen_UnityEngine_RenderTexture, typeof(RenderTexture));
		L.AddPreLoad("UnityEngine.Rigidbody", LuaOpen_UnityEngine_Rigidbody, typeof(Rigidbody));
		L.EndPreLoad();
		Debugger.Log("Register lua type cost time: {0}", Time.realtimeSinceStartup - realtimeSinceStartup);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_object_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<object, object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<object, object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_UnityEngine_Object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<UnityEngine.Object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<UnityEngine.Object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnVoidHandler_UnityEngine_Sprite(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<OnVoidHandler<Sprite>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<OnVoidHandler<Sprite>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_UI_InputField_OnValidateInput(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<InputField.OnValidateInput>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<InputField.OnValidateInput>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_UI_LScrollRect_UpdateItems(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LScrollRect.UpdateItems>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LScrollRect.UpdateItems>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<SocketError>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<SocketError>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_Packet(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Packet>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Packet>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<SpriteRenderer>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<SpriteRenderer>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<BaseEventData>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<BaseEventData>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_float(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<float>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<float>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_Vector2(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Vector2>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Vector2>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Scene, LoadSceneMode>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Scene, LoadSceneMode>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Scene>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Scene>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Scene, Scene>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Scene, Scene>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_DownloadRequest(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<DownloadRequest>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<DownloadRequest>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Events_UnityAction_UnityEngine_Sprite(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UnityAction<Sprite>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UnityAction<Sprite>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_RectTransform_ReapplyDrivenProperties(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<RectTransform.ReapplyDrivenProperties>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<RectTransform.ReapplyDrivenProperties>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_EventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.EventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.EventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_ErrorEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.ErrorEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.ErrorEventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_TimeEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.TimeEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.TimeEventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Video_VideoPlayer_FrameReadyEventHandler(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<VideoPlayer.FrameReadyEventHandler>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<VideoPlayer.FrameReadyEventHandler>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Camera_CameraCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Camera.CameraCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Camera.CameraCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_AdvertisingIdentifierCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.AdvertisingIdentifierCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.AdvertisingIdentifierCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_LowMemoryCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.LowMemoryCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.LowMemoryCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_MemoryUsageChangedCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.MemoryUsageChangedCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.MemoryUsageChangedCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Application_LogCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Application.LogCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Application.LogCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Physics_ContactEventDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Physics.ContactEventDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Physics.ContactEventDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_AudioClip_PCMReaderCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AudioClip.PCMReaderCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AudioClip.PCMReaderCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_AudioClip_PCMSetPositionCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<AudioClip.PCMSetPositionCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<AudioClip.PCMSetPositionCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_Canvas_WillRenderCanvases(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Canvas.WillRenderCanvases>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Canvas.WillRenderCanvases>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Predicate_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Predicate<int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Predicate<int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Comparison_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Comparison<int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Comparison<int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Func_int_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Func<int, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Func<int, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Func_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Func<bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Func<bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<PhysicsScene, NativeArray<ModifiableContactPair>>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<PhysicsScene, NativeArray<ModifiableContactPair>>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_AsyncOperation(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<AsyncOperation>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<AsyncOperation>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<UnityEngine.Object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<UnityEngine.Object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_UI_Image_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Image, string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Image, string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Func_string_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Func<string, bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Func<string, bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_float(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<float>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<float>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_float_float(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<float, float>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<float, float>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Color(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Color>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Color>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Color_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Color, object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Color, object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Vector2(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Vector2>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Vector2>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Vector3(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Vector3>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Vector3>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_float_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<float, object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<float, object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_LTEvent(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<LTEvent>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<LTEvent>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Vector3_object(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Vector3, object>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Vector3, object>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Vector3_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Vector3, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Vector3, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Func_UnityEngine_Vector3_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Func<Vector3, bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Func<Vector3, bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Playables_PlayableDirector(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<PlayableDirector>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<PlayableDirector>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Func_UnityEngine_UI_ILayoutElement_float(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Func<ILayoutElement, float>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Func<ILayoutElement, float>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_string_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<string, string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<string, string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_U2D_SpriteAtlas(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<SpriteAtlas>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<SpriteAtlas>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_bool_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<bool, string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<bool, string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int_string_string_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int, string, string, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int, string, string, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_LoadingUIType(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<LoadingUIType>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<LoadingUIType>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_strings_strings(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<string[], string[]>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<string[], string[]>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int_UnityEngine_GameObject(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int, GameObject>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int, GameObject>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int_int_string_string(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int, int, string, string>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int, int, string, string>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_int_int_UnityEngine_Transform(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<int, int, Transform>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<int, int, Transform>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_long_int_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<long, int, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<long, int, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_long_int(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<long, int>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<long, int>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int System_Action_UnityEngine_Vector3_bool(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Action<Vector3, bool>>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Action<Vector3, bool>>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_UpdateBonesDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<UpdateBonesDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<UpdateBonesDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_MeshGeneratorDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<MeshGeneratorDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<MeshGeneratorDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonGraphic.SkeletonRendererDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonGraphic.SkeletonRendererDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonRenderer_InstructionDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonRenderer.InstructionDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonRenderer.InstructionDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<SkeletonRenderer.SkeletonRendererDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<SkeletonRenderer.SkeletonRendererDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_AnimationState_TrackEntryDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Spine.AnimationState.TrackEntryDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Spine.AnimationState.TrackEntryDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Spine_AnimationState_TrackEntryEventDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Spine.AnimationState.TrackEntryEventDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Spine.AnimationState.TrackEntryEventDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriMana_Player_CuePointCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.CuePointCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.CuePointCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriMana_Player_StatusChangeCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.StatusChangeCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.StatusChangeCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriMana_Player_SubtitleChangeCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.SubtitleChangeCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.SubtitleChangeCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriMana_Player_ShaderDispatchCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<Player.ShaderDispatchCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<Player.ShaderDispatchCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<BlendSystem.BlendSystemGenericDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<BlendSystem.BlendSystemGenericDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RogoDigital_Lipsync_LipSync_ResetDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LipSync.ResetDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LipSync.ResetDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cinemachine_CinemachineVirtualCamera_CreatePipelineDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CinemachineVirtualCamera.CreatePipelineDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CinemachineVirtualCamera.CreatePipelineDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cinemachine_CinemachineVirtualCamera_DestroyPipelineDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CinemachineVirtualCamera.DestroyPipelineDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CinemachineVirtualCamera.DestroyPipelineDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LTDescr_EaseTypeDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LTDescr.EaseTypeDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LTDescr.EaseTypeDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LTDescr_ActionMethodDelegate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LTDescr.ActionMethodDelegate>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LTDescr.ActionMethodDelegate>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaHelper_ETLCallBack1(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LuaHelper.ETLCallBack1>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LuaHelper.ETLCallBack1>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaHelper_ETLCallBack2(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LuaHelper.ETLCallBack2>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LuaHelper.ETLCallBack2>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaHelper_ETLCallBack3(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<LuaHelper.ETLCallBack3>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<LuaHelper.ETLCallBack3>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CriManaMovieMaterialBase_OnApplicationPauseCallback(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_MeshRenderer(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_MeshRendererWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(MeshRenderer));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_BoxCollider(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_BoxColliderWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(BoxCollider));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_MeshCollider(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_MeshColliderWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(MeshCollider));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_SphereCollider(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_SphereColliderWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(SphereCollider));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_CharacterController(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_CharacterControllerWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(CharacterController));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_CapsuleCollider(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_CapsuleColliderWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(CapsuleCollider));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_Animation(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_AnimationWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(UnityEngine.Animation));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_AnimationClip(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_AnimationClipWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(AnimationClip));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_AnimationState(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_AnimationStateWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(UnityEngine.AnimationState));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_SkinWeights(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_SkinWeightsWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(SkinWeights));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_RenderTexture(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_RenderTextureWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(RenderTexture));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_UnityEngine_Rigidbody(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginPreModule("UnityEngine");
			UnityEngine_RigidbodyWrap.Register(luaState);
			int metaReference = luaState.GetMetaReference(typeof(Rigidbody));
			luaState.EndPreModule(L, metaReference);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
