using System;
using System.Collections.Generic;
using Coffee.UIEffects;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class NovaAPIWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(NovaAPI);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 295, 5, 2);
		Utils.RegisterFunc(L, -4, "GetGlobalTimeScale", _m_GetGlobalTimeScale_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLogicTimeScale", _m_GetLogicTimeScale_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLogicTime", _m_GetLogicTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLogicUnscaledTime", _m_GetLogicUnscaledTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLogicDeltaTime", _m_GetLogicDeltaTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLogicUnscaledDeltaTime", _m_GetLogicUnscaledDeltaTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetNotificationSettings", _m_GetNotificationSettings_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsInputEnabled", _m_IsInputEnabled_xlua_st_);
		Utils.RegisterFunc(L, -4, "InputEnable", _m_InputEnable_xlua_st_);
		Utils.RegisterFunc(L, -4, "InputDisable", _m_InputDisable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTouchScreenSupport", _m_SetTouchScreenSupport_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetNormalSupport", _m_SetNormalSupport_xlua_st_);
		Utils.RegisterFunc(L, -4, "RegisterVirtualJoystick", _m_RegisterVirtualJoystick_xlua_st_);
		Utils.RegisterFunc(L, -4, "RegisterVirtualButton", _m_RegisterVirtualButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "RegisterRealButton", _m_RegisterRealButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "RegisterRealAxisButton", _m_RegisterRealAxisButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "RegisterRealMouseButton", _m_RegisterRealMouseButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterVirtualJoystick", _m_UnRegisterVirtualJoystick_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterVirtualButton", _m_UnRegisterVirtualButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterRealButton", _m_UnRegisterRealButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterRealAxisButton", _m_UnRegisterRealAxisButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterRealMouseButton", _m_UnRegisterRealMouseButton_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRealButtonActive", _m_SetRealButtonActive_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddRecorderKey", _m_AddRecorderKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetRecorderKey", _m_GetRecorderKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRecorderFloorId", _m_SetRecorderFloorId_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRecorderExcludeIds", _m_SetRecorderExcludeIds_xlua_st_);
		Utils.RegisterFunc(L, -4, "StopRecord", _m_StopRecord_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetBuglyPlayerUid", _m_SetBuglyPlayerUid_xlua_st_);
		Utils.RegisterFunc(L, -4, "SendLogsToFeishu", _m_SendLogsToFeishu_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAchievementData", _m_GetAchievementData_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsDirtyWordsInit", _m_IsDirtyWordsInit_xlua_st_);
		Utils.RegisterFunc(L, -4, "InitDirtyWords", _m_InitDirtyWords_xlua_st_);
		Utils.RegisterFunc(L, -4, "ShutdownDirtyWords", _m_ShutdownDirtyWords_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsDirtyString", _m_IsDirtyString_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsChannelString", _m_IsChannelString_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsBinFormatEnabled", _m_IsBinFormatEnabled_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadAllDataTable", _m_LoadAllDataTable_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnLoadAllDataTable", _m_UnLoadAllDataTable_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadTextData", _m_LoadTextData_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadTableData", _m_LoadTableData_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadCommonBinData", _m_LoadCommonBinData_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentModuleName", _m_GetCurrentModuleName_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterModule", _m_EnterModule_xlua_st_);
		Utils.RegisterFunc(L, -4, "ExitCurrentModule", _m_ExitCurrentModule_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLoadParam", _m_GetLoadParam_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDynamicLevelTypeBootConfig", _m_GetDynamicLevelTypeBootConfig_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDynamicLevelParamsBootConfig", _m_GetDynamicLevelParamsBootConfig_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAutoBattleBalanceEET", _m_GetAutoBattleBalanceEET_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAutoBattleBalanceConfigTeam", _m_GetAutoBattleBalanceConfigTeam_xlua_st_);
		Utils.RegisterFunc(L, -4, "ExitGame", _m_ExitGame_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetEntryLevelFade", _m_SetEntryLevelFade_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntryLevelFade", _m_GetEntryLevelFade_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetClientChannel", _m_GetClientChannel_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetServerLoginName", _m_GetServerLoginName_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetServerChannelName", _m_GetServerChannelName_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadLuaBytes", _m_LoadLuaBytes_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsMobilePlatform", _m_IsMobilePlatform_xlua_st_);
		Utils.RegisterFunc(L, -4, "OpenURL", _m_OpenURL_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsRuntimeWindowsPlayer", _m_IsRuntimeWindowsPlayer_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsEditorPlatform", _m_IsEditorPlatform_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDeviceId", _m_GetDeviceId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetClientVersion", _m_GetClientVersion_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetResVersion", _m_GetResVersion_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsReviewServerEnv", _m_IsReviewServerEnv_xlua_st_);
		Utils.RegisterFunc(L, -4, "DispatchEventWithData", _m_DispatchEventWithData_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayGachaOpenDoor", _m_PlayGachaOpenDoor_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayGachaDisc", _m_PlayGachaDisc_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayCustomVideo", _m_PlayCustomVideo_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayVideo", _m_PlayVideo_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetL2DAnimFallbackRules", _m_SetL2DAnimFallbackRules_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayL2DCGAnim", _m_PlayL2DCGAnim_xlua_st_);
		Utils.RegisterFunc(L, -4, "BindL2dColorController", _m_BindL2dColorController_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnBindL2dColorController", _m_UnBindL2dColorController_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetL2DTimeState", _m_SetL2DTimeState_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMaskTextureSize", _m_GetMaskTextureSize_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMaskTextureSize", _m_SetMaskTextureSize_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMaskFilterMode", _m_GetMaskFilterMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMaskFilterMode", _m_SetMaskFilterMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMaskMaxRenderTextureCount", _m_GetMaskMaxRenderTextureCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMaskMaxRenderTextureCount", _m_SetMaskMaxRenderTextureCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMaskRenderTextureCount", _m_GetMaskRenderTextureCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMaskTotalUsedCount", _m_GetMaskTotalUsedCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "DisposeMaskTexture", _m_DisposeMaskTexture_xlua_st_);
		Utils.RegisterFunc(L, -4, "CompressString", _m_CompressString_xlua_st_);
		Utils.RegisterFunc(L, -4, "CompressBytes", _m_CompressBytes_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecompressString", _m_DecompressString_xlua_st_);
		Utils.RegisterFunc(L, -4, "ParseStarTowerData", _m_ParseStarTowerData_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecodeStarTowerData", _m_DecodeStarTowerData_xlua_st_);
		Utils.RegisterFunc(L, -4, "ParseStarTowerDataCompressed", _m_ParseStarTowerDataCompressed_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecodeStarTowerDataCompressed", _m_DecodeStarTowerDataCompressed_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetJointDrillBossMaxHp", _m_GetJointDrillBossMaxHp_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecodeJointDrillData", _m_DecodeJointDrillData_xlua_st_);
		Utils.RegisterFunc(L, -4, "ParseJointDrillDataCompressed", _m_ParseJointDrillDataCompressed_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecodeJointDrillDataCompressed", _m_DecodeJointDrillDataCompressed_xlua_st_);
		Utils.RegisterFunc(L, -4, "ShowGMMonsterAI", _m_ShowGMMonsterAI_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetBuildReportInfo", _m_SetBuildReportInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "TryUploadFile", _m_TryUploadFile_xlua_st_);
		Utils.RegisterFunc(L, -4, "UploadStartowerFile", _m_UploadStartowerFile_xlua_st_);
		Utils.RegisterFunc(L, -4, "DeleteRecFile", _m_DeleteRecFile_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetReportUrl", _m_SetReportUrl_xlua_st_);
		Utils.RegisterFunc(L, -4, "UserEventUpload", _m_UserEventUpload_xlua_st_);
		Utils.RegisterFunc(L, -4, "ChangeAnimatorDefaultState", _m_ChangeAnimatorDefaultState_xlua_st_);
		Utils.RegisterFunc(L, -4, "GuideProloguelSkill", _m_GuideProloguelSkill_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsLQA", _m_IsLQA_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetLQA", _m_SetLQA_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetScreenSleepTimeout", _m_SetScreenSleepTimeout_xlua_st_);
		Utils.RegisterFunc(L, -4, "FileGetLastWriteTime", _m_FileGetLastWriteTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsServerMaintained", _m_IsServerMaintained_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetServerMaintainedInfo", _m_GetServerMaintainedInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetIke", _m_ResetIke_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRetryCount", _m_SetRetryCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "MarkServerTimeStamp", _m_MarkServerTimeStamp_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetAeadKey", _m_SetAeadKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPubKey", _m_GetPubKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "ParseMessage", _m_ParseMessage_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddSendMsgRequest", _m_AddSendMsgRequest_xlua_st_);
		Utils.RegisterFunc(L, -4, "RestartNetwork", _m_RestartNetwork_xlua_st_);
		Utils.RegisterFunc(L, -4, "ClearCachedCookie", _m_ClearCachedCookie_xlua_st_);
		Utils.RegisterFunc(L, -4, "CloseLaunchInfo", _m_CloseLaunchInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "CloseLaunchLoading", _m_CloseLaunchLoading_xlua_st_);
		Utils.RegisterFunc(L, -4, "OpenBooterRepairResourceMode", _m_OpenBooterRepairResourceMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAvailable_TextLanguage", _m_GetAvailable_TextLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDefault_TextLanguage", _m_GetDefault_TextLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCur_TextLanguage", _m_GetCur_TextLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCur_TextLanguage", _m_SetCur_TextLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAvailable_VoLanguage", _m_GetAvailable_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDefault_VoLanguage", _m_GetDefault_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCur_VoiceLanguage", _m_GetCur_VoiceLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCur_VoiceLanguage", _m_SetCur_VoiceLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "HasDownload_VoLanguage", _m_HasDownload_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "HasDownload_Any_VoLanguage", _m_HasDownload_Any_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "Enable_VoLanguage", _m_Enable_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "Disable_VoLanguage", _m_Disable_VoLanguage_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetComponentEnableByName", _m_SetComponentEnableByName_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetComponentEnable", _m_SetComponentEnable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRaycastTarget", _m_SetRaycastTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetColor", _m_SetColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetAlpha", _m_SetAlpha_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetParticleColor", _m_SetParticleColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetAdaptedAreaCustomWidth", _m_SetAdaptedAreaCustomWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAdaptedAreaCustomWidth", _m_GetAdaptedAreaCustomWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetParentAndNormalized", _m_SetParentAndNormalized_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetViewPointX", _m_GetViewPointX_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasSortingOrder", _m_SetCanvasSortingOrder_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCanvasSortingOrder", _m_GetCanvasSortingOrder_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasSortingName", _m_SetCanvasSortingName_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasSortingId", _m_SetCanvasSortingId_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasOverrideSorting", _m_SetCanvasOverrideSorting_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasWorldCamera", _m_SetCanvasWorldCamera_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasPlaneDistance", _m_SetCanvasPlaneDistance_xlua_st_);
		Utils.RegisterFunc(L, -4, "ForceUpdateCanvases", _m_ForceUpdateCanvases_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMaskAllDirty", _m_SetMaskAllDirty_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTopGridCanvasSorting", _m_SetTopGridCanvasSorting_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetVariableJoystickMode", _m_SetVariableJoystickMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasGroupAlpha", _m_SetCanvasGroupAlpha_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCanvasGroupAlpha", _m_GetCanvasGroupAlpha_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasGroupBlocksRaycasts", _m_SetCanvasGroupBlocksRaycasts_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasGroupInteractable", _m_SetCanvasGroupInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetCanvasGroupDoFade", _m_SetCanvasGroupDoFade_xlua_st_);
		Utils.RegisterFunc(L, -4, "UIEffectSnapShotCapture", _m_UIEffectSnapShotCapture_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetButtonInteractable", _m_SetButtonInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetNaviButtonAction", _m_SetNaviButtonAction_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddButtonListener", _m_AddButtonListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveButtonListener", _m_RemoveButtonListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetButtonExHoldThreshold", _m_SetButtonExHoldThreshold_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddUIButtonListener", _m_AddUIButtonListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveUIButtonListener", _m_RemoveUIButtonListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetPersonalityRing", _m_SetPersonalityRing_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageSprite", _m_SetImageSprite_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageSpriteAsset", _m_SetImageSpriteAsset_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageRaycastTarget", _m_SetImageRaycastTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageNativeSize", _m_SetImageNativeSize_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageColor", _m_SetImageColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetImageColor", _m_GetImageColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetImageSpriteWidth", _m_GetImageSpriteWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetImageSpriteHeight", _m_GetImageSpriteHeight_xlua_st_);
		Utils.RegisterFunc(L, -4, "ImageDoFade", _m_ImageDoFade_xlua_st_);
		Utils.RegisterFunc(L, -4, "ImageDoColor", _m_ImageDoColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "ImageDoFillAmount", _m_ImageDoFillAmount_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageFillAmount", _m_SetImageFillAmount_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetImageFillAmount", _m_GetImageFillAmount_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTextureByPath", _m_SetTextureByPath_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTexture", _m_SetTexture_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetTexture", _m_GetTexture_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRawImageColor", _m_SetRawImageColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetRawImageColor", _m_GetRawImageColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRawImageMaterial", _m_SetRawImageMaterial_xlua_st_);
		Utils.RegisterFunc(L, -4, "DoRawImageColor", _m_DoRawImageColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSpriteRendererSprite", _m_SetSpriteRendererSprite_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSpriteRendererColor", _m_SetSpriteRendererColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSPSortingOrder", _m_SetSPSortingOrder_xlua_st_);
		Utils.RegisterFunc(L, -4, "SpriteRendererDoColor", _m_SpriteRendererDoColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SpriteRendererDoFade", _m_SpriteRendererDoFade_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetText", _m_SetText_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetText", _m_GetText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTextColor", _m_SetTextColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPText", _m_SetTMPText_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetTMPText", _m_GetTMPText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPColor", _m_SetTMPColor_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPRaycastTarget", _m_SetTMPRaycastTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPFontSize", _m_SetTMPFontSize_xlua_st_);
		Utils.RegisterFunc(L, -4, "TMPSetAllDirty", _m_TMPSetAllDirty_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPSourceText", _m_SetTMPSourceText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPWrappingEnable", _m_SetTMPWrappingEnable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetText_RubyTMP", _m_SetText_RubyTMP_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetText_RubyTMP", _m_GetText_RubyTMP_xlua_st_);
		Utils.RegisterFunc(L, -4, "DOText_RubyTMP", _m_DOText_RubyTMP_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTextColor_RubyTMP", _m_SetTextColor_RubyTMP_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetRubyPos", _m_GetRubyPos_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMP_AutoLineWrap", _m_SetTMP_AutoLineWrap_xlua_st_);
		Utils.RegisterFunc(L, -4, "AvgCalcTMPLastWordPos", _m_AvgCalcTMPLastWordPos_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPInputFieldText", _m_SetTMPInputFieldText_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetTMPInputFieldText", _m_GetTMPInputFieldText_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetTMPInputFieldTextComponent", _m_GetTMPInputFieldTextComponent_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPInputFieldInteractable", _m_SetTMPInputFieldInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTMPInputFieldPlaceholderText", _m_SetTMPInputFieldPlaceholderText_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddTMPEndEditListener", _m_AddTMPEndEditListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveTMPEndEditListener", _m_RemoveTMPEndEditListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetScrollRectVertical", _m_SetScrollRectVertical_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetScrollHorizontal", _m_SetScrollHorizontal_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetVerticalNormalizedPosition", _m_SetVerticalNormalizedPosition_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetHorizontalNormalizedPosition", _m_SetHorizontalNormalizedPosition_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetVerticalNormalizedPosition", _m_GetVerticalNormalizedPosition_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetHorizontalNormalizedPosition", _m_GetHorizontalNormalizedPosition_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddScrollRectListener", _m_AddScrollRectListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveScrollRectListener", _m_RemoveScrollRectListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "UIScrollRectScrollTo", _m_UIScrollRectScrollTo_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDropDownValue", _m_SetDropDownValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDropDownValue", _m_GetDropDownValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "ClearDropDownOptions", _m_ClearDropDownOptions_xlua_st_);
		Utils.RegisterFunc(L, -4, "DropDownAddOptions", _m_DropDownAddOptions_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurDDOptionsText", _m_GetCurDDOptionsText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDDInteractable", _m_SetDDInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetDDInteractable", _m_GetDDInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDDValueWithoutNotify", _m_SetDDValueWithoutNotify_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddDropDownListener", _m_AddDropDownListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveDropDownListener", _m_RemoveDropDownListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetInputFieldText", _m_SetInputFieldText_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetInputFieldText", _m_GetInputFieldText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetInputFieldPlaceholderText", _m_SetInputFieldPlaceholderText_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetInputFieldInteractable", _m_SetInputFieldInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddEndEditListener", _m_AddEndEditListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveEndEditListener", _m_RemoveEndEditListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddIPValueChangedListener", _m_AddIPValueChangedListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveIPValueChangedListener", _m_RemoveIPValueChangedListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetToggleInteractable", _m_SetToggleInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetToggleIsOn", _m_SetToggleIsOn_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetToggleIsOn", _m_GetToggleIsOn_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddToggleListener", _m_AddToggleListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveToggleListener", _m_RemoveToggleListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddUIToggleListener", _m_AddUIToggleListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveUIToggleListener", _m_RemoveUIToggleListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSliderInteractable", _m_SetSliderInteractable_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSliderValue", _m_SetSliderValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSliderValue", _m_GetSliderValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSliderMinValue", _m_SetSliderMinValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSliderMaxValue", _m_SetSliderMaxValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddSliderListener", _m_AddSliderListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveSliderListener", _m_RemoveSliderListener_xlua_st_);
		Utils.RegisterFunc(L, -4, "LayerMaskGetMask", _m_LayerMaskGetMask_xlua_st_);
		Utils.RegisterFunc(L, -4, "LayerMaskName2Layer", _m_LayerMaskName2Layer_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayFX", _m_PlayFX_xlua_st_);
		Utils.RegisterFunc(L, -4, "StopFX", _m_StopFX_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetEnable_Gradient2", _m_SetEnable_Gradient2_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayGradient2Anim", _m_PlayGradient2Anim_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetImageSpriteWithPrefab", _m_SetImageSpriteWithPrefab_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnloadWwiseSoundBank", _m_UnloadWwiseSoundBank_xlua_st_);
		Utils.RegisterFunc(L, -4, "ReadDataFromExcel", _m_ReadDataFromExcel_xlua_st_);
		Utils.RegisterFunc(L, -4, "WriteDataToExcel", _m_WriteDataToExcel_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSkillIndicatorTarget", _m_SetSkillIndicatorTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "DoShakeEffect", _m_DoShakeEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "StopShakeEffect", _m_StopShakeEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "RestartShakeEffect", _m_RestartShakeEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetUIEffectAndTransition", _m_SetUIEffectAndTransition_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAnimClipLength", _m_GetAnimClipLength_xlua_st_);
		Utils.RegisterFunc(L, -4, "CtrlDotweenAnimation", _m_CtrlDotweenAnimation_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetAnimatorSpeed", _m_SetAnimatorSpeed_xlua_st_);
		Utils.RegisterFunc(L, -4, "ClearSelectedUI", _m_ClearSelectedUI_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSelectedUI", _m_SetSelectedUI_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSelectedUI", _m_GetSelectedUI_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetGamepadUINavigation", _m_SetGamepadUINavigation_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRectMaskPadding", _m_SetRectMaskPadding_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetLayoutGroupPadding", _m_SetLayoutGroupPadding_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetLayoutElementMinHeight", _m_SetLayoutElementMinHeight_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetLayoutElementPreferredWidth", _m_SetLayoutElementPreferredWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddRedDotNode", _m_AddRedDotNode_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnRegisterRedDotNode", _m_UnRegisterRedDotNode_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetTouchEffect", _m_ResetTouchEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetupUIParallaxStageCameraControllerForModelView", _m_SetupUIParallaxStageCameraControllerForModelView_xlua_st_);
		Utils.RegisterFunc(L, -4, "BindUIParallaxStageCameraControllerModel", _m_BindUIParallaxStageCameraControllerModel_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnbindUIParallaxStageCameraControllerModel", _m_UnbindUIParallaxStageCameraControllerModel_xlua_st_);
		Utils.RegisterFunc(L, -4, "UnLoadBankByEventName", _m_UnLoadBankByEventName_xlua_st_);
		Utils.RegisterFunc(L, -4, "AttachPrefabLuaInspector", _m_AttachPrefabLuaInspector_xlua_st_);
		Utils.RegisterFunc(L, -2, "ApplicationDataPath", _g_get_ApplicationDataPath);
		Utils.RegisterFunc(L, -2, "StreamingAssetsPath", _g_get_StreamingAssetsPath);
		Utils.RegisterFunc(L, -2, "dictL2DFallbackOrder", _g_get_dictL2DFallbackOrder);
		Utils.RegisterFunc(L, -2, "TOKEN", _g_get_TOKEN);
		Utils.RegisterFunc(L, -2, "ServerListInfo", _g_get_ServerListInfo);
		Utils.RegisterFunc(L, -1, "dictL2DFallbackOrder", _s_set_dictL2DFallbackOrder);
		Utils.RegisterFunc(L, -1, "TOKEN", _s_set_TOKEN);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		return Lua.luaL_error(L, "NovaAPI does not have a constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetGlobalTimeScale_xlua_st_(IntPtr L)
	{
		try
		{
			float globalTimeScale = NovaAPI.GetGlobalTimeScale();
			Lua.lua_pushnumber(L, globalTimeScale);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLogicTimeScale_xlua_st_(IntPtr L)
	{
		try
		{
			float logicTimeScale = NovaAPI.GetLogicTimeScale();
			Lua.lua_pushnumber(L, logicTimeScale);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLogicTime_xlua_st_(IntPtr L)
	{
		try
		{
			float logicTime = NovaAPI.GetLogicTime();
			Lua.lua_pushnumber(L, logicTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLogicUnscaledTime_xlua_st_(IntPtr L)
	{
		try
		{
			float logicUnscaledTime = NovaAPI.GetLogicUnscaledTime();
			Lua.lua_pushnumber(L, logicUnscaledTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLogicDeltaTime_xlua_st_(IntPtr L)
	{
		try
		{
			float logicDeltaTime = NovaAPI.GetLogicDeltaTime();
			Lua.lua_pushnumber(L, logicDeltaTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLogicUnscaledDeltaTime_xlua_st_(IntPtr L)
	{
		try
		{
			float logicUnscaledDeltaTime = NovaAPI.GetLogicUnscaledDeltaTime();
			Lua.lua_pushnumber(L, logicUnscaledDeltaTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetNotificationSettings_xlua_st_(IntPtr L)
	{
		try
		{
			string notificationSettings = NovaAPI.GetNotificationSettings();
			Lua.lua_pushstring(L, notificationSettings);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsInputEnabled_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsInputEnabled();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_InputEnable_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.InputEnable();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_InputDisable_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.InputDisable();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTouchScreenSupport_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetTouchScreenSupport(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetNormalSupport_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetNormalSupport(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RegisterVirtualJoystick_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string x = Lua.lua_tostring(L, 1);
			string y = Lua.lua_tostring(L, 2);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 3, typeof(GameObject));
			NovaAPI.RegisterVirtualJoystick(x, y, go);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RegisterVirtualButton_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string buttonName = Lua.lua_tostring(L, 1);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			NovaAPI.RegisterVirtualButton(buttonName, go);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RegisterRealButton_xlua_st_(IntPtr L)
	{
		try
		{
			string buttonName = Lua.lua_tostring(L, 1);
			float holdThreshold = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.RegisterRealButton(buttonName, holdThreshold);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RegisterRealAxisButton_xlua_st_(IntPtr L)
	{
		try
		{
			string buttonName = Lua.lua_tostring(L, 1);
			float holdThreshold = (float)Lua.lua_tonumber(L, 2);
			float pressThreshold = (float)Lua.lua_tonumber(L, 3);
			NovaAPI.RegisterRealAxisButton(buttonName, holdThreshold, pressThreshold);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RegisterRealMouseButton_xlua_st_(IntPtr L)
	{
		try
		{
			string buttonName = Lua.lua_tostring(L, 1);
			float holdThreshold = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.RegisterRealMouseButton(buttonName, holdThreshold);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterVirtualJoystick_xlua_st_(IntPtr L)
	{
		try
		{
			string x = Lua.lua_tostring(L, 1);
			string y = Lua.lua_tostring(L, 2);
			NovaAPI.UnRegisterVirtualJoystick(x, y);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterVirtualButton_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnRegisterVirtualButton(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterRealButton_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnRegisterRealButton(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterRealAxisButton_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnRegisterRealAxisButton(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterRealMouseButton_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnRegisterRealMouseButton(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRealButtonActive_xlua_st_(IntPtr L)
	{
		try
		{
			string name = Lua.lua_tostring(L, 1);
			bool active = Lua.lua_toboolean(L, 2);
			NovaAPI.SetRealButtonActive(name, active);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddRecorderKey_xlua_st_(IntPtr L)
	{
		try
		{
			string key = Lua.lua_tostring(L, 1);
			int val = Lua.xlua_tointeger(L, 2);
			NovaAPI.AddRecorderKey(key, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetRecorderKey_xlua_st_(IntPtr L)
	{
		try
		{
			bool recorderKey = NovaAPI.GetRecorderKey(Lua.lua_tostring(L, 1), out var val);
			Lua.lua_pushboolean(L, recorderKey);
			Lua.xlua_pushinteger(L, val);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRecorderFloorId_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetRecorderFloorId(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRecorderExcludeIds_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetRecorderExcludeIds((List<int>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<int>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopRecord_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.StopRecord();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetBuglyPlayerUid_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetBuglyPlayerUid(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SendLogsToFeishu_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string name = Lua.lua_tostring(L, 1);
			Action onSuccessCallback = objectTranslator.GetDelegate<Action>(L, 2);
			Action<string> onErrorCallback = objectTranslator.GetDelegate<Action<string>>(L, 3);
			NovaAPI.SendLogsToFeishu(name, onSuccessCallback, onErrorCallback);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAchievementData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			AchievementManager.AchievementDataDic achievementData = NovaAPI.GetAchievementData();
			objectTranslator.Push(L, achievementData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsDirtyWordsInit_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsDirtyWordsInit();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_InitDirtyWords_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.InitDirtyWords();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ShutdownDirtyWords_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ShutdownDirtyWords();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsDirtyString_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsDirtyString(Lua.lua_tostring(L, 1));
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsChannelString_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsChannelString(Lua.lua_tostring(L, 1));
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsBinFormatEnabled_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsBinFormatEnabled();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadAllDataTable_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.LoadAllDataTable(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnLoadAllDataTable_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnLoadAllDataTable();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadTextData_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPI.LoadTextData(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadTableData_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPI.LoadTableData(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadCommonBinData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string filepath = Lua.lua_tostring(L, 1);
			LuaTable tab = (LuaTable)objectTranslator.GetObject(L, 2, typeof(LuaTable));
			NovaAPI.LoadCommonBinData(filepath, tab);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentModuleName_xlua_st_(IntPtr L)
	{
		try
		{
			string currentModuleName = NovaAPI.GetCurrentModuleName();
			Lua.lua_pushstring(L, currentModuleName);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterModule_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<Action>(L, 4))
			{
				string moduleName = Lua.lua_tostring(L, 1);
				bool clearHistory = Lua.lua_toboolean(L, 2);
				int loadingType = Lua.xlua_tointeger(L, 3);
				Action callback = objectTranslator.GetDelegate<Action>(L, 4);
				NovaAPI.EnterModule(moduleName, clearHistory, loadingType, callback);
				return 0;
			}
			if (num == 3 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				string moduleName2 = Lua.lua_tostring(L, 1);
				bool clearHistory2 = Lua.lua_toboolean(L, 2);
				int loadingType2 = Lua.xlua_tointeger(L, 3);
				NovaAPI.EnterModule(moduleName2, clearHistory2, loadingType2);
				return 0;
			}
			if (num == 2 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2))
			{
				string moduleName3 = Lua.lua_tostring(L, 1);
				bool clearHistory3 = Lua.lua_toboolean(L, 2);
				NovaAPI.EnterModule(moduleName3, clearHistory3);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.EnterModule!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ExitCurrentModule_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ExitCurrentModule();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLoadParam_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			NovaAPI.GetLoadParam(out var loadType, out var mapId, out var id, out var floor, out var actors, out var fixedRoguelikeRoomData, out var affixes, out var breakCounts, out var levels, out var stageId, out var outfitList, out var isVampireFirstHalf, out var noteList, out var skins);
			objectTranslator.Push(L, loadType);
			Lua.lua_pushstring(L, mapId);
			Lua.lua_pushstring(L, id);
			Lua.xlua_pushinteger(L, floor);
			objectTranslator.Push(L, actors);
			objectTranslator.Push(L, fixedRoguelikeRoomData);
			objectTranslator.Push(L, affixes);
			objectTranslator.Push(L, breakCounts);
			objectTranslator.Push(L, levels);
			Lua.xlua_pushinteger(L, stageId);
			objectTranslator.Push(L, outfitList);
			Lua.lua_pushboolean(L, isVampireFirstHalf);
			objectTranslator.Push(L, noteList);
			objectTranslator.Push(L, skins);
			return 14;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDynamicLevelTypeBootConfig_xlua_st_(IntPtr L)
	{
		try
		{
			int dynamicLevelTypeBootConfig = NovaAPI.GetDynamicLevelTypeBootConfig();
			Lua.xlua_pushinteger(L, dynamicLevelTypeBootConfig);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDynamicLevelParamsBootConfig_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string[] dynamicLevelParamsBootConfig = NovaAPI.GetDynamicLevelParamsBootConfig();
			objectTranslator.Push(L, dynamicLevelParamsBootConfig);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAutoBattleBalanceEET_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			HotfixEnum.elementType autoBattleBalanceEET = NovaAPI.GetAutoBattleBalanceEET();
			objectTranslator.Push(L, autoBattleBalanceEET);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAutoBattleBalanceConfigTeam_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<ABTeam> autoBattleBalanceConfigTeam = NovaAPI.GetAutoBattleBalanceConfigTeam();
			objectTranslator.Push(L, autoBattleBalanceConfigTeam);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ExitGame_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ExitGame();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEntryLevelFade_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetEntryLevelFade(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntryLevelFade_xlua_st_(IntPtr L)
	{
		try
		{
			bool entryLevelFade = NovaAPI.GetEntryLevelFade();
			Lua.lua_pushboolean(L, entryLevelFade);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetClientChannel_xlua_st_(IntPtr L)
	{
		try
		{
			string clientChannel = NovaAPI.GetClientChannel();
			Lua.lua_pushstring(L, clientChannel);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetServerLoginName_xlua_st_(IntPtr L)
	{
		try
		{
			string serverLoginName = NovaAPI.GetServerLoginName();
			Lua.lua_pushstring(L, serverLoginName);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetServerChannelName_xlua_st_(IntPtr L)
	{
		try
		{
			string serverChannelName = NovaAPI.GetServerChannelName();
			Lua.lua_pushstring(L, serverChannelName);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadLuaBytes_xlua_st_(IntPtr L)
	{
		try
		{
			string filepath = Lua.lua_tostring(L, 1);
			byte[] str = NovaAPI.LoadLuaBytes(ref filepath);
			Lua.lua_pushstring(L, str);
			Lua.lua_pushstring(L, filepath);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsMobilePlatform_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsMobilePlatform();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_OpenURL_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.OpenURL(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsRuntimeWindowsPlayer_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsRuntimeWindowsPlayer();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsEditorPlatform_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsEditorPlatform();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDeviceId_xlua_st_(IntPtr L)
	{
		try
		{
			string deviceId = NovaAPI.GetDeviceId();
			Lua.lua_pushstring(L, deviceId);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetClientVersion_xlua_st_(IntPtr L)
	{
		try
		{
			string clientVersion = NovaAPI.GetClientVersion();
			Lua.lua_pushstring(L, clientVersion);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetResVersion_xlua_st_(IntPtr L)
	{
		try
		{
			string resVersion = NovaAPI.GetResVersion();
			Lua.lua_pushstring(L, resVersion);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsReviewServerEnv_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsReviewServerEnv();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DispatchEventWithData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string type = Lua.lua_tostring(L, 1);
			object sender = objectTranslator.GetObject(L, 2, typeof(object));
			object data = objectTranslator.GetObject(L, 3, typeof(object));
			bool value = NovaAPI.DispatchEventWithData(type, sender, data);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayGachaOpenDoor_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			int rare = Lua.xlua_tointeger(L, 2);
			int type = Lua.xlua_tointeger(L, 3);
			NovaAPI.PlayGachaOpenDoor(go, rare, type);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayGachaDisc_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			int type = Lua.xlua_tointeger(L, 2);
			int rare = Lua.xlua_tointeger(L, 3);
			bool sup = Lua.lua_toboolean(L, 4);
			NovaAPI.PlayGachaDisc(go, type, rare, sup);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayCustomVideo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			string[] path = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
			bool[] loop = (bool[])objectTranslator.GetObject(L, 3, typeof(bool[]));
			bool[] canJump = (bool[])objectTranslator.GetObject(L, 4, typeof(bool[]));
			int[] closeIdx = (int[])objectTranslator.GetObject(L, 5, typeof(int[]));
			int[] reopenIdx = (int[])objectTranslator.GetObject(L, 6, typeof(int[]));
			bool[] showEft = (bool[])objectTranslator.GetObject(L, 7, typeof(bool[]));
			NovaAPI.PlayCustomVideo(go, path, loop, canJump, closeIdx, reopenIdx, showEft);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayVideo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 5 && objectTranslator.Assignable<GameObject>(L, 1) && objectTranslator.Assignable<string[]>(L, 2) && objectTranslator.Assignable<string[]>(L, 3) && objectTranslator.Assignable<string[]>(L, 4) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5))
			{
				GameObject goPlayerVideo = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
				string[] videoFileNameOrder = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
				string[] soundTrackNameOrder = (string[])objectTranslator.GetObject(L, 3, typeof(string[]));
				string[] srtFileNameOrder = (string[])objectTranslator.GetObject(L, 4, typeof(string[]));
				bool bDebugLog = Lua.lua_toboolean(L, 5);
				NovaAPI.PlayVideo(goPlayerVideo, videoFileNameOrder, soundTrackNameOrder, srtFileNameOrder, bDebugLog);
				return 0;
			}
			if (num == 4 && objectTranslator.Assignable<GameObject>(L, 1) && objectTranslator.Assignable<string[]>(L, 2) && objectTranslator.Assignable<string[]>(L, 3) && objectTranslator.Assignable<string[]>(L, 4))
			{
				GameObject goPlayerVideo2 = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
				string[] videoFileNameOrder2 = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
				string[] soundTrackNameOrder2 = (string[])objectTranslator.GetObject(L, 3, typeof(string[]));
				string[] srtFileNameOrder2 = (string[])objectTranslator.GetObject(L, 4, typeof(string[]));
				NovaAPI.PlayVideo(goPlayerVideo2, videoFileNameOrder2, soundTrackNameOrder2, srtFileNameOrder2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.PlayVideo!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetL2DAnimFallbackRules_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetL2DAnimFallbackRules(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayL2DCGAnim_xlua_st_(IntPtr L)
	{
		try
		{
			float num = NovaAPI.PlayL2DCGAnim((Transform)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Transform)));
			Lua.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_BindL2dColorController_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject goController = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			GameObject goL2d = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			NovaAPI.BindL2dColorController(goController, goL2d);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnBindL2dColorController_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnBindL2dColorController((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetL2DTimeState_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetL2DTimeState(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMaskTextureSize_xlua_st_(IntPtr L)
	{
		try
		{
			int maskTextureSize = NovaAPI.GetMaskTextureSize();
			Lua.xlua_pushinteger(L, maskTextureSize);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMaskTextureSize_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetMaskTextureSize(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMaskFilterMode_xlua_st_(IntPtr L)
	{
		try
		{
			int maskFilterMode = NovaAPI.GetMaskFilterMode();
			Lua.xlua_pushinteger(L, maskFilterMode);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMaskFilterMode_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetMaskFilterMode(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMaskMaxRenderTextureCount_xlua_st_(IntPtr L)
	{
		try
		{
			int maskMaxRenderTextureCount = NovaAPI.GetMaskMaxRenderTextureCount();
			Lua.xlua_pushinteger(L, maskMaxRenderTextureCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMaskMaxRenderTextureCount_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetMaskMaxRenderTextureCount(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMaskRenderTextureCount_xlua_st_(IntPtr L)
	{
		try
		{
			int maskRenderTextureCount = NovaAPI.GetMaskRenderTextureCount();
			Lua.xlua_pushinteger(L, maskRenderTextureCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMaskTotalUsedCount_xlua_st_(IntPtr L)
	{
		try
		{
			int maskTotalUsedCount = NovaAPI.GetMaskTotalUsedCount();
			Lua.xlua_pushinteger(L, maskTotalUsedCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DisposeMaskTexture_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.DisposeMaskTexture();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CompressString_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPI.CompressString(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CompressBytes_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPI.CompressBytes(Lua.lua_tobytes(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecompressString_xlua_st_(IntPtr L)
	{
		try
		{
			byte[] str = NovaAPI.DecompressString(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ParseStarTowerData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out StarTowerTempData v);
			string str = NovaAPI.ParseStarTowerData(v);
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecodeStarTowerData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			StarTowerTempData starTowerTempData = NovaAPI.DecodeStarTowerData(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, starTowerTempData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ParseStarTowerDataCompressed_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out StarTowerTempData v);
			string str = NovaAPI.ParseStarTowerDataCompressed(v, out var length);
			Lua.lua_pushstring(L, str);
			Lua.xlua_pushinteger(L, length);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecodeStarTowerDataCompressed_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			StarTowerTempData starTowerTempData = NovaAPI.DecodeStarTowerDataCompressed(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, starTowerTempData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetJointDrillBossMaxHp_xlua_st_(IntPtr L)
	{
		try
		{
			int monsterId = Lua.xlua_tointeger(L, 1);
			int difficulty = Lua.xlua_tointeger(L, 2);
			long jointDrillBossMaxHp = NovaAPI.GetJointDrillBossMaxHp(monsterId, difficulty);
			Lua.lua_pushint64(L, jointDrillBossMaxHp);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecodeJointDrillData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			JointDrillTempData jointDrillTempData = NovaAPI.DecodeJointDrillData(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, jointDrillTempData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ParseJointDrillDataCompressed_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out JointDrillTempData v);
			string str = NovaAPI.ParseJointDrillDataCompressed(v, out var length);
			Lua.lua_pushstring(L, str);
			Lua.xlua_pushinteger(L, length);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecodeJointDrillDataCompressed_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			JointDrillTempData jointDrillTempData = NovaAPI.DecodeJointDrillDataCompressed(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, jointDrillTempData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ShowGMMonsterAI_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ShowGMMonsterAI(Lua.lua_toint64(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetBuildReportInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string buildJson = Lua.lua_tostring(L, 1);
			string buildName = Lua.lua_tostring(L, 2);
			BuildCharData[] buildCharData = (BuildCharData[])objectTranslator.GetObject(L, 3, typeof(BuildCharData[]));
			BuildDiscData[] buildDiscData = (BuildDiscData[])objectTranslator.GetObject(L, 4, typeof(BuildDiscData[]));
			int[] secondarySkills = (int[])objectTranslator.GetObject(L, 5, typeof(int[]));
			int[][] notes = (int[][])objectTranslator.GetObject(L, 6, typeof(int[][]));
			NovaAPI.SetBuildReportInfo(buildJson, buildName, buildCharData, buildDiscData, secondarySkills, notes);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_TryUploadFile_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.TryUploadFile();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UploadStartowerFile_xlua_st_(IntPtr L)
	{
		try
		{
			string token = Lua.lua_tostring(L, 1);
			string reportId = Lua.lua_tostring(L, 2);
			NovaAPI.UploadStartowerFile(token, reportId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DeleteRecFile_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.DeleteRecFile(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetReportUrl_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetReportUrl(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UserEventUpload_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string strEventName = Lua.lua_tostring(L, 1);
			List<List<string>> parameter = (List<List<string>>)objectTranslator.GetObject(L, 2, typeof(List<List<string>>));
			NovaAPI.UserEventUpload(strEventName, parameter);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ChangeAnimatorDefaultState_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ChangeAnimatorDefaultState((Transform)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Transform)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GuideProloguelSkill_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.GuideProloguelSkill();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsLQA_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsLQA();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetLQA_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetLQA(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetScreenSleepTimeout_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetScreenSleepTimeout(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_FileGetLastWriteTime_xlua_st_(IntPtr L)
	{
		try
		{
			long n = NovaAPI.FileGetLastWriteTime(Lua.lua_tostring(L, 1));
			Lua.lua_pushint64(L, n);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsServerMaintained_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.IsServerMaintained();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetServerMaintainedInfo_xlua_st_(IntPtr L)
	{
		try
		{
			string serverMaintainedInfo = NovaAPI.GetServerMaintainedInfo();
			Lua.lua_pushstring(L, serverMaintainedInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetIke_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ResetIke();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRetryCount_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetRetryCount();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_MarkServerTimeStamp_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.MarkServerTimeStamp(Lua.lua_toint64(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetAeadKey_xlua_st_(IntPtr L)
	{
		try
		{
			byte[] pubKey = Lua.lua_tobytes(L, 1);
			int function = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetAeadKey(pubKey, function);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPubKey_xlua_st_(IntPtr L)
	{
		try
		{
			byte[] pubKey = NovaAPI.GetPubKey();
			Lua.lua_pushstring(L, pubKey);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ParseMessage_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			byte[] messageData = Lua.lua_tobytes(L, 1);
			bool isNextPackage = Lua.lua_toboolean(L, 2);
			HttpNetMsg o = NovaAPI.ParseMessage(messageData, isNextPackage);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddSendMsgRequest_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			short msgId = (short)Lua.xlua_tointeger(L, 1);
			byte[] msgBody = Lua.lua_tobytes(L, 2);
			Action<HttpNetMsg, object> callbackAction = objectTranslator.GetDelegate<Action<HttpNetMsg, object>>(L, 3);
			string url = Lua.lua_tostring(L, 4);
			NovaAPI.AddSendMsgRequest(msgId, msgBody, callbackAction, url);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RestartNetwork_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.RestartNetwork();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearCachedCookie_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ClearCachedCookie();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CloseLaunchInfo_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.CloseLaunchInfo((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CloseLaunchLoading_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.CloseLaunchLoading((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_OpenBooterRepairResourceMode_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.OpenBooterRepairResourceMode();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAvailable_TextLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string[] available_TextLanguage = NovaAPI.GetAvailable_TextLanguage();
			objectTranslator.Push(L, available_TextLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDefault_TextLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			string default_TextLanguage = NovaAPI.GetDefault_TextLanguage();
			Lua.lua_pushstring(L, default_TextLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCur_TextLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			string cur_TextLanguage = NovaAPI.GetCur_TextLanguage();
			Lua.lua_pushstring(L, cur_TextLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCur_TextLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetCur_TextLanguage(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAvailable_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string[] available_VoLanguage = NovaAPI.GetAvailable_VoLanguage();
			objectTranslator.Push(L, available_VoLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDefault_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			string default_VoLanguage = NovaAPI.GetDefault_VoLanguage();
			Lua.lua_pushstring(L, default_VoLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCur_VoiceLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			string cur_VoiceLanguage = NovaAPI.GetCur_VoiceLanguage();
			Lua.lua_pushstring(L, cur_VoiceLanguage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCur_VoiceLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetCur_VoiceLanguage(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_HasDownload_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.HasDownload_VoLanguage(Lua.lua_tostring(L, 1), out var totalSize, out var needDownloadSize);
			Lua.lua_pushboolean(L, value);
			Lua.lua_pushint64(L, totalSize);
			Lua.lua_pushint64(L, needDownloadSize);
			return 3;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_HasDownload_Any_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = NovaAPI.HasDownload_Any_VoLanguage();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Enable_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			int num = Lua.lua_gettop(L);
			if (num == 2 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2))
			{
				string language = Lua.lua_tostring(L, 1);
				bool downloadPackageUseResourceSupplement = Lua.lua_toboolean(L, 2);
				NovaAPI.Enable_VoLanguage(language, downloadPackageUseResourceSupplement);
				return 0;
			}
			if (num == 1 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TSTRING))
			{
				NovaAPI.Enable_VoLanguage(Lua.lua_tostring(L, 1));
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.Enable_VoLanguage!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Disable_VoLanguage_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.Disable_VoLanguage(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetComponentEnableByName_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string componentName = Lua.lua_tostring(L, 2);
			bool enable = Lua.lua_toboolean(L, 3);
			NovaAPI.SetComponentEnableByName(go, componentName, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetComponentEnable_xlua_st_(IntPtr L)
	{
		try
		{
			Component component = (Component)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Component));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetComponentEnable(component, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRaycastTarget_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetRaycastTarget(go, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetColor_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			float r = (float)Lua.lua_tonumber(L, 2);
			float g = (float)Lua.lua_tonumber(L, 3);
			float b = (float)Lua.lua_tonumber(L, 4);
			float a = (float)Lua.lua_tonumber(L, 5);
			NovaAPI.SetColor(go, r, g, b, a);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetAlpha_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			float a = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetAlpha(go, a);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetParticleColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetParticleColor(go, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetAdaptedAreaCustomWidth_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetAdaptedAreaCustomWidth(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAdaptedAreaCustomWidth_xlua_st_(IntPtr L)
	{
		try
		{
			int adaptedAreaCustomWidth = NovaAPI.GetAdaptedAreaCustomWidth();
			Lua.xlua_pushinteger(L, adaptedAreaCustomWidth);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetParentAndNormalized_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Transform trTarget = (Transform)objectTranslator.GetObject(L, 1, typeof(Transform));
			Transform trParent = (Transform)objectTranslator.GetObject(L, 2, typeof(Transform));
			NovaAPI.SetParentAndNormalized(trTarget, trParent);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetViewPointX_xlua_st_(IntPtr L)
	{
		try
		{
			float viewPointX = NovaAPI.GetViewPointX((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			Lua.lua_pushnumber(L, viewPointX);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasSortingOrder_xlua_st_(IntPtr L)
	{
		try
		{
			Canvas canvas = (Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas));
			int value = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetCanvasSortingOrder(canvas, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCanvasSortingOrder_xlua_st_(IntPtr L)
	{
		try
		{
			int canvasSortingOrder = NovaAPI.GetCanvasSortingOrder((Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas)));
			Lua.xlua_pushinteger(L, canvasSortingOrder);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasSortingName_xlua_st_(IntPtr L)
	{
		try
		{
			Canvas canvas = (Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas));
			string name = Lua.lua_tostring(L, 2);
			NovaAPI.SetCanvasSortingName(canvas, name);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasSortingId_xlua_st_(IntPtr L)
	{
		try
		{
			Canvas canvas = (Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas));
			int id = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetCanvasSortingId(canvas, id);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasOverrideSorting_xlua_st_(IntPtr L)
	{
		try
		{
			Canvas canvas = (Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetCanvasOverrideSorting(canvas, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasWorldCamera_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Canvas canvas = (Canvas)objectTranslator.GetObject(L, 1, typeof(Canvas));
			Camera camera = (Camera)objectTranslator.GetObject(L, 2, typeof(Camera));
			NovaAPI.SetCanvasWorldCamera(canvas, camera);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasPlaneDistance_xlua_st_(IntPtr L)
	{
		try
		{
			Canvas canvas = (Canvas)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Canvas));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetCanvasPlaneDistance(canvas, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ForceUpdateCanvases_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ForceUpdateCanvases();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMaskAllDirty_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetMaskAllDirty((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTopGridCanvasSorting_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			int value = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetTopGridCanvasSorting(go, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetVariableJoystickMode_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetVariableJoystickMode((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasGroupAlpha_xlua_st_(IntPtr L)
	{
		try
		{
			CanvasGroup canvasGroup = (CanvasGroup)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(CanvasGroup));
			float alpha = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetCanvasGroupAlpha(canvasGroup, alpha);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCanvasGroupAlpha_xlua_st_(IntPtr L)
	{
		try
		{
			float canvasGroupAlpha = NovaAPI.GetCanvasGroupAlpha((CanvasGroup)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(CanvasGroup)));
			Lua.lua_pushnumber(L, canvasGroupAlpha);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasGroupBlocksRaycasts_xlua_st_(IntPtr L)
	{
		try
		{
			CanvasGroup canvasGroup = (CanvasGroup)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(CanvasGroup));
			bool visible = Lua.lua_toboolean(L, 2);
			NovaAPI.SetCanvasGroupBlocksRaycasts(canvasGroup, visible);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasGroupInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			CanvasGroup canvasGroup = (CanvasGroup)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(CanvasGroup));
			bool visible = Lua.lua_toboolean(L, 2);
			NovaAPI.SetCanvasGroupInteractable(canvasGroup, visible);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetCanvasGroupDoFade_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && objectTranslator.Assignable<CanvasGroup>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				CanvasGroup canvasGroup = (CanvasGroup)objectTranslator.GetObject(L, 1, typeof(CanvasGroup));
				float value = (float)Lua.lua_tonumber(L, 2);
				float duration = (float)Lua.lua_tonumber(L, 3);
				bool update = Lua.lua_toboolean(L, 4);
				Tweener o = NovaAPI.SetCanvasGroupDoFade(canvasGroup, value, duration, update);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 3 && objectTranslator.Assignable<CanvasGroup>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				CanvasGroup canvasGroup2 = (CanvasGroup)objectTranslator.GetObject(L, 1, typeof(CanvasGroup));
				float value2 = (float)Lua.lua_tonumber(L, 2);
				float duration2 = (float)Lua.lua_tonumber(L, 3);
				Tweener o2 = NovaAPI.SetCanvasGroupDoFade(canvasGroup2, value2, duration2);
				objectTranslator.Push(L, o2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.SetCanvasGroupDoFade!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UIEffectSnapShotCapture_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UIEffectSnapShotCapture((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetButtonInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			Button btn = (Button)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Button));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetButtonInteractable(btn, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetNaviButtonAction_xlua_st_(IntPtr L)
	{
		try
		{
			NaviButton btn = (NaviButton)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(NaviButton));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetNaviButtonAction(btn, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddButtonListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Button btn = (Button)objectTranslator.GetObject(L, 1, typeof(Button));
			UnityAction handle = objectTranslator.GetDelegate<UnityAction>(L, 2);
			NovaAPI.AddButtonListener(btn, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveButtonListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Button btn = (Button)objectTranslator.GetObject(L, 1, typeof(Button));
			UnityAction handle = objectTranslator.GetDelegate<UnityAction>(L, 2);
			NovaAPI.RemoveButtonListener(btn, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetButtonExHoldThreshold_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			float fThreshold = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetButtonExHoldThreshold(go, fThreshold);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddUIButtonListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			UIButton btn = (UIButton)objectTranslator.GetObject(L, 1, typeof(UIButton));
			UnityAction handle = objectTranslator.GetDelegate<UnityAction>(L, 2);
			NovaAPI.AddUIButtonListener(btn, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveUIButtonListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			UIButton btn = (UIButton)objectTranslator.GetObject(L, 1, typeof(UIButton));
			UnityAction handle = objectTranslator.GetDelegate<UnityAction>(L, 2);
			NovaAPI.RemoveUIButtonListener(btn, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetPersonalityRing_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			float[] fillAmount = (float[])objectTranslator.GetObject(L, 2, typeof(float[]));
			NovaAPI.SetPersonalityRing(go, fillAmount);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageSprite_xlua_st_(IntPtr L)
	{
		try
		{
			Image image = (Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image));
			string assetsPath = Lua.lua_tostring(L, 2);
			bool value = NovaAPI.SetImageSprite(image, assetsPath);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageSpriteAsset_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Image image = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
			Sprite sprite = (Sprite)objectTranslator.GetObject(L, 2, typeof(Sprite));
			NovaAPI.SetImageSpriteAsset(image, sprite);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageRaycastTarget_xlua_st_(IntPtr L)
	{
		try
		{
			Image image = (Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetImageRaycastTarget(image, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageNativeSize_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetImageNativeSize((Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Image image = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetImageColor(image, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetImageColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Color imageColor = NovaAPI.GetImageColor((Image)objectTranslator.GetObject(L, 1, typeof(Image)));
			objectTranslator.PushUnityEngineColor(L, imageColor);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetImageSpriteWidth_xlua_st_(IntPtr L)
	{
		try
		{
			float imageSpriteWidth = NovaAPI.GetImageSpriteWidth((Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image)));
			Lua.lua_pushnumber(L, imageSpriteWidth);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetImageSpriteHeight_xlua_st_(IntPtr L)
	{
		try
		{
			float imageSpriteHeight = NovaAPI.GetImageSpriteHeight((Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image)));
			Lua.lua_pushnumber(L, imageSpriteHeight);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ImageDoFade_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && objectTranslator.Assignable<Image>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				Image image = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				float value = (float)Lua.lua_tonumber(L, 2);
				float duration = (float)Lua.lua_tonumber(L, 3);
				bool update = Lua.lua_toboolean(L, 4);
				Tweener o = NovaAPI.ImageDoFade(image, value, duration, update);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 3 && objectTranslator.Assignable<Image>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				Image image2 = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				float value2 = (float)Lua.lua_tonumber(L, 2);
				float duration2 = (float)Lua.lua_tonumber(L, 3);
				Tweener o2 = NovaAPI.ImageDoFade(image2, value2, duration2);
				objectTranslator.Push(L, o2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.ImageDoFade!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ImageDoColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && objectTranslator.Assignable<Image>(L, 1) && objectTranslator.Assignable<Color>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				Image image = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				objectTranslator.Get(L, 2, out Color val);
				Tweener o = NovaAPI.ImageDoColor(duration: (float)Lua.lua_tonumber(L, 3), update: Lua.lua_toboolean(L, 4), image: image, color: val);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 3 && objectTranslator.Assignable<Image>(L, 1) && objectTranslator.Assignable<Color>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				Image image2 = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				objectTranslator.Get(L, 2, out Color val2);
				Tweener o2 = NovaAPI.ImageDoColor(duration: (float)Lua.lua_tonumber(L, 3), image: image2, color: val2);
				objectTranslator.Push(L, o2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.ImageDoColor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ImageDoFillAmount_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && objectTranslator.Assignable<Image>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				Image image = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				float value = (float)Lua.lua_tonumber(L, 2);
				float duration = (float)Lua.lua_tonumber(L, 3);
				bool update = Lua.lua_toboolean(L, 4);
				Tweener o = NovaAPI.ImageDoFillAmount(image, value, duration, update);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 3 && objectTranslator.Assignable<Image>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				Image image2 = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
				float value2 = (float)Lua.lua_tonumber(L, 2);
				float duration2 = (float)Lua.lua_tonumber(L, 3);
				Tweener o2 = NovaAPI.ImageDoFillAmount(image2, value2, duration2);
				objectTranslator.Push(L, o2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.ImageDoFillAmount!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageFillAmount_xlua_st_(IntPtr L)
	{
		try
		{
			Image image = (Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetImageFillAmount(image, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetImageFillAmount_xlua_st_(IntPtr L)
	{
		try
		{
			float imageFillAmount = NovaAPI.GetImageFillAmount((Image)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Image)));
			Lua.lua_pushnumber(L, imageFillAmount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTextureByPath_xlua_st_(IntPtr L)
	{
		try
		{
			RawImage image = (RawImage)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RawImage));
			string assetsPath = Lua.lua_tostring(L, 2);
			bool value = NovaAPI.SetTextureByPath(image, assetsPath);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTexture_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RawImage rawImage = (RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage));
			Texture texture = (Texture)objectTranslator.GetObject(L, 2, typeof(Texture));
			bool value = NovaAPI.SetTexture(rawImage, texture);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTexture_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Texture texture = NovaAPI.GetTexture((RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage)));
			objectTranslator.Push(L, texture);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRawImageColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RawImage rawImage = (RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetRawImageColor(rawImage, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetRawImageColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Color rawImageColor = NovaAPI.GetRawImageColor((RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage)));
			objectTranslator.PushUnityEngineColor(L, rawImageColor);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRawImageMaterial_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RawImage rawImage = (RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage));
			Material mt = (Material)objectTranslator.GetObject(L, 2, typeof(Material));
			NovaAPI.SetRawImageMaterial(rawImage, mt);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DoRawImageColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RawImage image = (RawImage)objectTranslator.GetObject(L, 1, typeof(RawImage));
			objectTranslator.Get(L, 2, out Color val);
			Tweener o = NovaAPI.DoRawImageColor(time: (float)Lua.lua_tonumber(L, 3), image: image, color: val);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSpriteRendererSprite_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SpriteRenderer spriteRenderer = (SpriteRenderer)objectTranslator.GetObject(L, 1, typeof(SpriteRenderer));
			Sprite sprite = (Sprite)objectTranslator.GetObject(L, 2, typeof(Sprite));
			NovaAPI.SetSpriteRendererSprite(spriteRenderer, sprite);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSpriteRendererColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SpriteRenderer spriteRenderer = (SpriteRenderer)objectTranslator.GetObject(L, 1, typeof(SpriteRenderer));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetSpriteRendererColor(spriteRenderer, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSPSortingOrder_xlua_st_(IntPtr L)
	{
		try
		{
			SpriteRenderer spriteRenderer = (SpriteRenderer)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SpriteRenderer));
			int value = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetSPSortingOrder(spriteRenderer, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpriteRendererDoColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SpriteRenderer spriteRenderer = (SpriteRenderer)objectTranslator.GetObject(L, 1, typeof(SpriteRenderer));
			objectTranslator.Get(L, 2, out Color val);
			Tweener o = NovaAPI.SpriteRendererDoColor(duration: (float)Lua.lua_tonumber(L, 3), spriteRenderer: spriteRenderer, color: val);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpriteRendererDoFade_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SpriteRenderer spriteRenderer = (SpriteRenderer)objectTranslator.GetObject(L, 1, typeof(SpriteRenderer));
			float value = (float)Lua.lua_tonumber(L, 2);
			float duration = (float)Lua.lua_tonumber(L, 3);
			Tweener o = NovaAPI.SpriteRendererDoFade(spriteRenderer, value, duration);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetText_xlua_st_(IntPtr L)
	{
		try
		{
			Text text = (Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Text));
			string content = Lua.lua_tostring(L, 2);
			NovaAPI.SetText(text, content);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetText_xlua_st_(IntPtr L)
	{
		try
		{
			string text = NovaAPI.GetText((Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Text)));
			Lua.lua_pushstring(L, text);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTextColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Text text = (Text)objectTranslator.GetObject(L, 1, typeof(Text));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetTextColor(text, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPText_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_Text tmpText = (TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text));
			string content = Lua.lua_tostring(L, 2);
			NovaAPI.SetTMPText(tmpText, content);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTMPText_xlua_st_(IntPtr L)
	{
		try
		{
			string tMPText = NovaAPI.GetTMPText((TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text)));
			Lua.lua_pushstring(L, tMPText);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPColor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			TMP_Text tmpText = (TMP_Text)objectTranslator.GetObject(L, 1, typeof(TMP_Text));
			objectTranslator.Get(L, 2, out Color val);
			NovaAPI.SetTMPColor(tmpText, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPRaycastTarget_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_Text tmpText = (TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetTMPRaycastTarget(tmpText, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPFontSize_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_Text tmpText = (TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text));
			float size = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetTMPFontSize(tmpText, size);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_TMPSetAllDirty_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.TMPSetAllDirty((TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPSourceText_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<TMP_Text>(L, 1) && (Lua.lua_isnil(L, 2) || Lua.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				TMP_Text tmpText = (TMP_Text)objectTranslator.GetObject(L, 1, typeof(TMP_Text));
				string content = Lua.lua_tostring(L, 2);
				bool syncTextInputBox = Lua.lua_toboolean(L, 3);
				NovaAPI.SetTMPSourceText(tmpText, content, syncTextInputBox);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<TMP_Text>(L, 1) && (Lua.lua_isnil(L, 2) || Lua.lua_type(L, 2) == LuaTypes.LUA_TSTRING))
			{
				TMP_Text tmpText2 = (TMP_Text)objectTranslator.GetObject(L, 1, typeof(TMP_Text));
				string content2 = Lua.lua_tostring(L, 2);
				NovaAPI.SetTMPSourceText(tmpText2, content2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.SetTMPSourceText!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPWrappingEnable_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_Text tmpText = (TMP_Text)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_Text));
			bool enabled = Lua.lua_toboolean(L, 2);
			NovaAPI.SetTMPWrappingEnable(tmpText, enabled);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetText_RubyTMP_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RubyTextMeshProUGUI rubyTMP_a = (RubyTextMeshProUGUI)objectTranslator.GetObject(L, 1, typeof(RubyTextMeshProUGUI));
			string sContent = Lua.lua_tostring(L, 2);
			RubyTextMeshProUGUI rubyTMP_b = (RubyTextMeshProUGUI)objectTranslator.GetObject(L, 3, typeof(RubyTextMeshProUGUI));
			NovaAPI.SetText_RubyTMP(rubyTMP_a, sContent, rubyTMP_b);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetText_RubyTMP_xlua_st_(IntPtr L)
	{
		try
		{
			string text_RubyTMP = NovaAPI.GetText_RubyTMP((RubyTextMeshProUGUI)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RubyTextMeshProUGUI)));
			Lua.lua_pushstring(L, text_RubyTMP);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DOText_RubyTMP_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RubyTextMeshProUGUI rubyTMP = (RubyTextMeshProUGUI)objectTranslator.GetObject(L, 1, typeof(RubyTextMeshProUGUI));
			string sContent = Lua.lua_tostring(L, 2);
			float fDuration = (float)Lua.lua_tonumber(L, 3);
			Tweener o = NovaAPI.DOText_RubyTMP(rubyTMP, sContent, fDuration);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTextColor_RubyTMP_xlua_st_(IntPtr L)
	{
		try
		{
			RubyTextMeshProUGUI rubyTMP = (RubyTextMeshProUGUI)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RubyTextMeshProUGUI));
			string sColor = Lua.lua_tostring(L, 2);
			NovaAPI.SetTextColor_RubyTMP(rubyTMP, sColor);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetRubyPos_xlua_st_(IntPtr L)
	{
		try
		{
			RubyTextMeshProUGUI rubyTMP = (RubyTextMeshProUGUI)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RubyTextMeshProUGUI));
			string sBaseText = Lua.lua_tostring(L, 2);
			string sRubyText = Lua.lua_tostring(L, 3);
			bool rubyPos = NovaAPI.GetRubyPos(rubyTMP, sBaseText, sRubyText, out var fP, out var fP2);
			Lua.lua_pushboolean(L, rubyPos);
			Lua.lua_pushnumber(L, fP);
			Lua.lua_pushnumber(L, fP2);
			return 3;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMP_AutoLineWrap_xlua_st_(IntPtr L)
	{
		try
		{
			RubyTextMeshProUGUI rubyTMP = (RubyTextMeshProUGUI)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RubyTextMeshProUGUI));
			bool bEnableAutoWrap = Lua.lua_toboolean(L, 2);
			NovaAPI.SetTMP_AutoLineWrap(rubyTMP, bEnableAutoWrap);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AvgCalcTMPLastWordPos_xlua_st_(IntPtr L)
	{
		try
		{
			float num = NovaAPI.AvgCalcTMPLastWordPos((RubyTextMeshProUGUI)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(RubyTextMeshProUGUI)));
			Lua.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPInputFieldText_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_InputField tmpInputField = (TMP_InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_InputField));
			string content = Lua.lua_tostring(L, 2);
			NovaAPI.SetTMPInputFieldText(tmpInputField, content);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTMPInputFieldText_xlua_st_(IntPtr L)
	{
		try
		{
			string tMPInputFieldText = NovaAPI.GetTMPInputFieldText((TMP_InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_InputField)));
			Lua.lua_pushstring(L, tMPInputFieldText);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTMPInputFieldTextComponent_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			TMP_Text tMPInputFieldTextComponent = NovaAPI.GetTMPInputFieldTextComponent((TMP_InputField)objectTranslator.GetObject(L, 1, typeof(TMP_InputField)));
			objectTranslator.Push(L, tMPInputFieldTextComponent);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPInputFieldInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_InputField tmpInputField = (TMP_InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_InputField));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetTMPInputFieldInteractable(tmpInputField, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTMPInputFieldPlaceholderText_xlua_st_(IntPtr L)
	{
		try
		{
			TMP_InputField tmpInputField = (TMP_InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(TMP_InputField));
			string content = Lua.lua_tostring(L, 2);
			NovaAPI.SetTMPInputFieldPlaceholderText(tmpInputField, content);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddTMPEndEditListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			TMP_InputField tmpInputField = (TMP_InputField)objectTranslator.GetObject(L, 1, typeof(TMP_InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.AddTMPEndEditListener(tmpInputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveTMPEndEditListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			TMP_InputField tmpInputField = (TMP_InputField)objectTranslator.GetObject(L, 1, typeof(TMP_InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.RemoveTMPEndEditListener(tmpInputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetScrollRectVertical_xlua_st_(IntPtr L)
	{
		try
		{
			ScrollRect sr = (ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect));
			bool vertical = Lua.lua_toboolean(L, 2);
			NovaAPI.SetScrollRectVertical(sr, vertical);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetScrollHorizontal_xlua_st_(IntPtr L)
	{
		try
		{
			ScrollRect sr = (ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect));
			bool horizontal = Lua.lua_toboolean(L, 2);
			NovaAPI.SetScrollHorizontal(sr, horizontal);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetVerticalNormalizedPosition_xlua_st_(IntPtr L)
	{
		try
		{
			ScrollRect sr = (ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetVerticalNormalizedPosition(sr, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetHorizontalNormalizedPosition_xlua_st_(IntPtr L)
	{
		try
		{
			ScrollRect sr = (ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetHorizontalNormalizedPosition(sr, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetVerticalNormalizedPosition_xlua_st_(IntPtr L)
	{
		try
		{
			float verticalNormalizedPosition = NovaAPI.GetVerticalNormalizedPosition((ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect)));
			Lua.lua_pushnumber(L, verticalNormalizedPosition);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetHorizontalNormalizedPosition_xlua_st_(IntPtr L)
	{
		try
		{
			float horizontalNormalizedPosition = NovaAPI.GetHorizontalNormalizedPosition((ScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(ScrollRect)));
			Lua.lua_pushnumber(L, horizontalNormalizedPosition);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddScrollRectListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ScrollRect sr = (ScrollRect)objectTranslator.GetObject(L, 1, typeof(ScrollRect));
			UnityAction<Vector2> handle = objectTranslator.GetDelegate<UnityAction<Vector2>>(L, 2);
			NovaAPI.AddScrollRectListener(sr, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveScrollRectListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ScrollRect sr = (ScrollRect)objectTranslator.GetObject(L, 1, typeof(ScrollRect));
			UnityAction<Vector2> handle = objectTranslator.GetDelegate<UnityAction<Vector2>>(L, 2);
			NovaAPI.RemoveScrollRectListener(sr, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UIScrollRectScrollTo_xlua_st_(IntPtr L)
	{
		try
		{
			UIScrollRect sr = (UIScrollRect)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(UIScrollRect));
			int index = Lua.xlua_tointeger(L, 2);
			bool reverse = Lua.lua_toboolean(L, 3);
			NovaAPI.UIScrollRectScrollTo(sr, index, reverse);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDropDownValue_xlua_st_(IntPtr L)
	{
		try
		{
			Dropdown dd = (Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown));
			int value = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetDropDownValue(dd, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDropDownValue_xlua_st_(IntPtr L)
	{
		try
		{
			int dropDownValue = NovaAPI.GetDropDownValue((Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown)));
			Lua.xlua_pushinteger(L, dropDownValue);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearDropDownOptions_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ClearDropDownOptions((Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DropDownAddOptions_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Dropdown dd = (Dropdown)objectTranslator.GetObject(L, 1, typeof(Dropdown));
			List<string> options = (List<string>)objectTranslator.GetObject(L, 2, typeof(List<string>));
			NovaAPI.DropDownAddOptions(dd, options);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurDDOptionsText_xlua_st_(IntPtr L)
	{
		try
		{
			string curDDOptionsText = NovaAPI.GetCurDDOptionsText((Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown)));
			Lua.lua_pushstring(L, curDDOptionsText);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDDInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			Dropdown dd = (Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetDDInteractable(dd, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetDDInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			bool dDInteractable = NovaAPI.GetDDInteractable((Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown)));
			Lua.lua_pushboolean(L, dDInteractable);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDDValueWithoutNotify_xlua_st_(IntPtr L)
	{
		try
		{
			Dropdown dd = (Dropdown)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dropdown));
			int value = Lua.xlua_tointeger(L, 2);
			NovaAPI.SetDDValueWithoutNotify(dd, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddDropDownListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Dropdown dd = (Dropdown)objectTranslator.GetObject(L, 1, typeof(Dropdown));
			UnityAction<int> handle = objectTranslator.GetDelegate<UnityAction<int>>(L, 2);
			NovaAPI.AddDropDownListener(dd, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveDropDownListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Dropdown dd = (Dropdown)objectTranslator.GetObject(L, 1, typeof(Dropdown));
			UnityAction<int> handle = objectTranslator.GetDelegate<UnityAction<int>>(L, 2);
			NovaAPI.RemoveDropDownListener(dd, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetInputFieldText_xlua_st_(IntPtr L)
	{
		try
		{
			InputField inputField = (InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(InputField));
			string text = Lua.lua_tostring(L, 2);
			NovaAPI.SetInputFieldText(inputField, text);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetInputFieldText_xlua_st_(IntPtr L)
	{
		try
		{
			string inputFieldText = NovaAPI.GetInputFieldText((InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(InputField)));
			Lua.lua_pushstring(L, inputFieldText);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetInputFieldPlaceholderText_xlua_st_(IntPtr L)
	{
		try
		{
			InputField inputField = (InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(InputField));
			string content = Lua.lua_tostring(L, 2);
			NovaAPI.SetInputFieldPlaceholderText(inputField, content);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetInputFieldInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			InputField inputField = (InputField)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(InputField));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetInputFieldInteractable(inputField, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddEndEditListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InputField inputField = (InputField)objectTranslator.GetObject(L, 1, typeof(InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.AddEndEditListener(inputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveEndEditListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InputField inputField = (InputField)objectTranslator.GetObject(L, 1, typeof(InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.RemoveEndEditListener(inputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddIPValueChangedListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InputField inputField = (InputField)objectTranslator.GetObject(L, 1, typeof(InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.AddIPValueChangedListener(inputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveIPValueChangedListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			InputField inputField = (InputField)objectTranslator.GetObject(L, 1, typeof(InputField));
			UnityAction<string> handle = objectTranslator.GetDelegate<UnityAction<string>>(L, 2);
			NovaAPI.RemoveIPValueChangedListener(inputField, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetToggleInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			Toggle toggle = (Toggle)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Toggle));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetToggleInteractable(toggle, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetToggleIsOn_xlua_st_(IntPtr L)
	{
		try
		{
			Toggle toggle = (Toggle)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Toggle));
			bool isOn = Lua.lua_toboolean(L, 2);
			NovaAPI.SetToggleIsOn(toggle, isOn);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetToggleIsOn_xlua_st_(IntPtr L)
	{
		try
		{
			bool toggleIsOn = NovaAPI.GetToggleIsOn((Toggle)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Toggle)));
			Lua.lua_pushboolean(L, toggleIsOn);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddToggleListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Toggle toggle = (Toggle)objectTranslator.GetObject(L, 1, typeof(Toggle));
			UnityAction<bool> handle = objectTranslator.GetDelegate<UnityAction<bool>>(L, 2);
			NovaAPI.AddToggleListener(toggle, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveToggleListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Toggle toggle = (Toggle)objectTranslator.GetObject(L, 1, typeof(Toggle));
			UnityAction<bool> handle = objectTranslator.GetDelegate<UnityAction<bool>>(L, 2);
			NovaAPI.RemoveToggleListener(toggle, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddUIToggleListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			UIToggle toggle = (UIToggle)objectTranslator.GetObject(L, 1, typeof(UIToggle));
			UnityAction<bool> handle = objectTranslator.GetDelegate<UnityAction<bool>>(L, 2);
			NovaAPI.AddUIToggleListener(toggle, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveUIToggleListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			UIToggle toggle = (UIToggle)objectTranslator.GetObject(L, 1, typeof(UIToggle));
			UnityAction<bool> handle = objectTranslator.GetDelegate<UnityAction<bool>>(L, 2);
			NovaAPI.RemoveUIToggleListener(toggle, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSliderInteractable_xlua_st_(IntPtr L)
	{
		try
		{
			Slider slider = (Slider)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Slider));
			bool enable = Lua.lua_toboolean(L, 2);
			NovaAPI.SetSliderInteractable(slider, enable);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSliderValue_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<Slider>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				Slider slider = (Slider)objectTranslator.GetObject(L, 1, typeof(Slider));
				float value = (float)Lua.lua_tonumber(L, 2);
				bool withoutNotify = Lua.lua_toboolean(L, 3);
				NovaAPI.SetSliderValue(slider, value, withoutNotify);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<Slider>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2))
			{
				Slider slider2 = (Slider)objectTranslator.GetObject(L, 1, typeof(Slider));
				float value2 = (float)Lua.lua_tonumber(L, 2);
				NovaAPI.SetSliderValue(slider2, value2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.SetSliderValue!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSliderValue_xlua_st_(IntPtr L)
	{
		try
		{
			float sliderValue = NovaAPI.GetSliderValue((Slider)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Slider)));
			Lua.lua_pushnumber(L, sliderValue);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSliderMinValue_xlua_st_(IntPtr L)
	{
		try
		{
			Slider slider = (Slider)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Slider));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetSliderMinValue(slider, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSliderMaxValue_xlua_st_(IntPtr L)
	{
		try
		{
			Slider slider = (Slider)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Slider));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetSliderMaxValue(slider, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddSliderListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Slider slider = (Slider)objectTranslator.GetObject(L, 1, typeof(Slider));
			UnityAction<float> handle = objectTranslator.GetDelegate<UnityAction<float>>(L, 2);
			NovaAPI.AddSliderListener(slider, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveSliderListener_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Slider slider = (Slider)objectTranslator.GetObject(L, 1, typeof(Slider));
			UnityAction<float> handle = objectTranslator.GetDelegate<UnityAction<float>>(L, 2);
			NovaAPI.RemoveSliderListener(slider, handle);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LayerMaskGetMask_xlua_st_(IntPtr L)
	{
		try
		{
			int value = NovaAPI.LayerMaskGetMask(Lua.lua_tostring(L, 1));
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LayerMaskName2Layer_xlua_st_(IntPtr L)
	{
		try
		{
			int value = NovaAPI.LayerMaskName2Layer(Lua.lua_tostring(L, 1));
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayFX_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			bool bEnablePostProcessing = Lua.lua_toboolean(L, 1);
			string sPath = Lua.lua_tostring(L, 2);
			float fPlaySpeed = (float)Lua.lua_tonumber(L, 3);
			bool value = NovaAPI.PlayFX(bEnablePostProcessing, sPath, fPlaySpeed, out var goIns);
			Lua.lua_pushboolean(L, value);
			objectTranslator.Push(L, goIns);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopFX_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.StopFX((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEnable_Gradient2_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			bool bShadowMask = Lua.lua_toboolean(L, 2);
			NovaAPI.SetEnable_Gradient2(go, bShadowMask);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayGradient2Anim_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			float fStart = (float)Lua.lua_tonumber(L, 2);
			float fEnd = (float)Lua.lua_tonumber(L, 3);
			float fDuration = (float)Lua.lua_tonumber(L, 4);
			NovaAPI.PlayGradient2Anim(go, fStart, fEnd, fDuration);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetImageSpriteWithPrefab_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Image imgHeadIcon = (Image)objectTranslator.GetObject(L, 1, typeof(Image));
			GameObject prefab = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			NovaAPI.SetImageSpriteWithPrefab(imgHeadIcon, prefab);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnloadWwiseSoundBank_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnloadWwiseSoundBank(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ReadDataFromExcel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string[][] o = NovaAPI.ReadDataFromExcel(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_WriteDataToExcel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 3 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TTABLE) && (Lua.lua_isnil(L, 2) || Lua.lua_type(L, 2) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				LuaTable writeData = (LuaTable)objectTranslator.GetObject(L, 1, typeof(LuaTable));
				string xlsxFileFullPath = Lua.lua_tostring(L, 2);
				bool bRenameExistedFileByTimeStampSurfix = Lua.lua_toboolean(L, 3);
				NovaAPI.WriteDataToExcel(writeData, xlsxFileFullPath, bRenameExistedFileByTimeStampSurfix);
				return 0;
			}
			if (num == 2 && (Lua.lua_isnil(L, 1) || Lua.lua_type(L, 1) == LuaTypes.LUA_TTABLE) && (Lua.lua_isnil(L, 2) || Lua.lua_type(L, 2) == LuaTypes.LUA_TSTRING))
			{
				LuaTable writeData2 = (LuaTable)objectTranslator.GetObject(L, 1, typeof(LuaTable));
				string xlsxFileFullPath2 = Lua.lua_tostring(L, 2);
				NovaAPI.WriteDataToExcel(writeData2, xlsxFileFullPath2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.WriteDataToExcel!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSkillIndicatorTarget_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long entityId = Lua.lua_toint64(L, 1);
			GameObject gameObject = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			objectTranslator.Get(L, 3, out Vector3 val);
			NovaAPI.SetSkillIndicatorTarget(entityId, gameObject, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DoShakeEffect_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject go = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			float[][] v3Pos = (float[][])objectTranslator.GetObject(L, 2, typeof(float[][]));
			float[][] v3Rot = (float[][])objectTranslator.GetObject(L, 3, typeof(float[][]));
			bool bLoop = Lua.lua_toboolean(L, 4);
			NovaAPI.DoShakeEffect(go, v3Pos, v3Rot, bLoop);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopShakeEffect_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.StopShakeEffect((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RestartShakeEffect_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.RestartShakeEffect((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetUIEffectAndTransition_xlua_st_(IntPtr L)
	{
		try
		{
			UIEffectAndTransition eft = (UIEffectAndTransition)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(UIEffectAndTransition));
			int nEftMode = Lua.xlua_tointeger(L, 2);
			float width = (float)Lua.lua_tonumber(L, 3);
			float softness = (float)Lua.lua_tonumber(L, 4);
			NovaAPI.SetUIEffectAndTransition(eft, nEftMode, width, softness);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAnimClipLength_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Animator anim = (Animator)objectTranslator.GetObject(L, 1, typeof(Animator));
			string[] clipNames = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
			float animClipLength = NovaAPI.GetAnimClipLength(anim, clipNames);
			Lua.lua_pushnumber(L, animClipLength);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CtrlDotweenAnimation_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			int nStatus = Lua.xlua_tointeger(L, 2);
			NovaAPI.CtrlDotweenAnimation(go, nStatus);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetAnimatorSpeed_xlua_st_(IntPtr L)
	{
		try
		{
			Animator anim = (Animator)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Animator));
			float fSpeed = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetAnimatorSpeed(anim, fSpeed);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearSelectedUI_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.ClearSelectedUI();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSelectedUI_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.SetSelectedUI((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSelectedUI_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject selectedUI = NovaAPI.GetSelectedUI();
			objectTranslator.Push(L, selectedUI);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetGamepadUINavigation_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<Selectable[]>(L, 1) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				Selectable[] selectables = (Selectable[])objectTranslator.GetObject(L, 1, typeof(Selectable[]));
				bool isHorizontal = Lua.lua_toboolean(L, 2);
				bool isLoop = Lua.lua_toboolean(L, 3);
				NovaAPI.SetGamepadUINavigation(selectables, isHorizontal, isLoop);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<Selectable[]>(L, 1) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 2))
			{
				Selectable[] selectables2 = (Selectable[])objectTranslator.GetObject(L, 1, typeof(Selectable[]));
				bool isHorizontal2 = Lua.lua_toboolean(L, 2);
				NovaAPI.SetGamepadUINavigation(selectables2, isHorizontal2);
				return 0;
			}
			if (num == 1 && objectTranslator.Assignable<Selectable[]>(L, 1))
			{
				NovaAPI.SetGamepadUINavigation((Selectable[])objectTranslator.GetObject(L, 1, typeof(Selectable[])));
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.SetGamepadUINavigation!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRectMaskPadding_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject obj = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			float left = (float)Lua.lua_tonumber(L, 2);
			float bottom = (float)Lua.lua_tonumber(L, 3);
			float right = (float)Lua.lua_tonumber(L, 4);
			float top = (float)Lua.lua_tonumber(L, 5);
			NovaAPI.SetRectMaskPadding(obj, left, bottom, right, top);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetLayoutGroupPadding_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject obj = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			int left = Lua.xlua_tointeger(L, 2);
			int right = Lua.xlua_tointeger(L, 3);
			int top = Lua.xlua_tointeger(L, 4);
			int bottom = Lua.xlua_tointeger(L, 5);
			NovaAPI.SetLayoutGroupPadding(obj, left, right, top, bottom);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetLayoutElementMinHeight_xlua_st_(IntPtr L)
	{
		try
		{
			LayoutElement layout = (LayoutElement)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(LayoutElement));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetLayoutElementMinHeight(layout, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetLayoutElementPreferredWidth_xlua_st_(IntPtr L)
	{
		try
		{
			LayoutElement layout = (LayoutElement)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(LayoutElement));
			float value = (float)Lua.lua_tonumber(L, 2);
			NovaAPI.SetLayoutElementPreferredWidth(layout, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddRedDotNode_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject obj = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string key = Lua.lua_tostring(L, 2);
			string paramJson = Lua.lua_tostring(L, 3);
			NovaAPI.AddRedDotNode(obj, key, paramJson);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnRegisterRedDotNode_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnRegisterRedDotNode((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetTouchEffect_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Transform target = (Transform)objectTranslator.GetObject(L, 1, typeof(Transform));
			GameObject prefabMain = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			GameObject prefabSlide = (GameObject)objectTranslator.GetObject(L, 3, typeof(GameObject));
			NovaAPI.ResetTouchEffect(target, prefabMain, prefabSlide);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetupUIParallaxStageCameraControllerForModelView_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			UIParallaxStageCameraController component = (UIParallaxStageCameraController)objectTranslator.GetObject(L, 1, typeof(UIParallaxStageCameraController));
			Camera modelProjectionOverrideCamera = (Camera)objectTranslator.GetObject(L, 2, typeof(Camera));
			NovaAPI.SetupUIParallaxStageCameraControllerForModelView(component, modelProjectionOverrideCamera);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_BindUIParallaxStageCameraControllerModel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 4 && objectTranslator.Assignable<UIParallaxStageCameraController>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<GameObject>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				UIParallaxStageCameraController component = (UIParallaxStageCameraController)objectTranslator.GetObject(L, 1, typeof(UIParallaxStageCameraController));
				int index = Lua.xlua_tointeger(L, 2);
				GameObject model = (GameObject)objectTranslator.GetObject(L, 3, typeof(GameObject));
				bool updateImmediately = Lua.lua_toboolean(L, 4);
				NovaAPI.BindUIParallaxStageCameraControllerModel(component, index, model, updateImmediately);
				return 0;
			}
			if (num == 3 && objectTranslator.Assignable<UIParallaxStageCameraController>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<GameObject>(L, 3))
			{
				UIParallaxStageCameraController component2 = (UIParallaxStageCameraController)objectTranslator.GetObject(L, 1, typeof(UIParallaxStageCameraController));
				int index2 = Lua.xlua_tointeger(L, 2);
				GameObject model2 = (GameObject)objectTranslator.GetObject(L, 3, typeof(GameObject));
				NovaAPI.BindUIParallaxStageCameraControllerModel(component2, index2, model2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to NovaAPI.BindUIParallaxStageCameraControllerModel!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnbindUIParallaxStageCameraControllerModel_xlua_st_(IntPtr L)
	{
		try
		{
			UIParallaxStageCameraController component = (UIParallaxStageCameraController)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(UIParallaxStageCameraController));
			int index = Lua.xlua_tointeger(L, 2);
			NovaAPI.UnbindUIParallaxStageCameraControllerModel(component, index);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UnLoadBankByEventName_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPI.UnLoadBankByEventName(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AttachPrefabLuaInspector_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject obj = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string luaCtrlPath = Lua.lua_tostring(L, 2);
			string luaPanelPath = Lua.lua_tostring(L, 3);
			string prefabPath = Lua.lua_tostring(L, 4);
			NovaAPI.AttachPrefabLuaInspector(obj, luaCtrlPath, luaPanelPath, prefabPath);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_ApplicationDataPath(IntPtr L)
	{
		try
		{
			Lua.lua_pushstring(L, NovaAPI.ApplicationDataPath);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_StreamingAssetsPath(IntPtr L)
	{
		try
		{
			Lua.lua_pushstring(L, NovaAPI.StreamingAssetsPath);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_dictL2DFallbackOrder(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Push(L, NovaAPI.dictL2DFallbackOrder);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_TOKEN(IntPtr L)
	{
		try
		{
			Lua.lua_pushstring(L, NovaAPI.TOKEN);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_ServerListInfo(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Push(L, NovaAPI.ServerListInfo);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_dictL2DFallbackOrder(IntPtr L)
	{
		try
		{
			NovaAPI.dictL2DFallbackOrder = (Dictionary<string, string[]>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Dictionary<string, string[]>));
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_TOKEN(IntPtr L)
	{
		try
		{
			NovaAPI.TOKEN = Lua.lua_tostring(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
