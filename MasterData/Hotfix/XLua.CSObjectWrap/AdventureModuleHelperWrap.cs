using System;
using System.Collections.Generic;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using UnityEngine;
using UnityEngine.Playables;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class AdventureModuleHelperWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(AdventureModuleHelper);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 191, 7, 7);
		Utils.RegisterFunc(L, -4, "SetSemiAutoBattleMode", _m_SetSemiAutoBattleMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetAutoCastUltimateSkill", _m_SetAutoCastUltimateSkill_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSummonMonsterInfos", _m_GetSummonMonsterInfos_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetSummonMonsters", _m_SetSummonMonsters_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetActorAttributes", _m_ResetActorAttributes_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerActorStatus", _m_GetPlayerActorStatus_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerActorSpecialStatusTime", _m_GetPlayerActorSpecialStatusTime_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerActorLocalDataJson", _m_GetPlayerActorLocalDataJson_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerActorAmmoType", _m_GetPlayerActorAmmoType_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerActorAmmoCount", _m_GetPlayerActorAmmoCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetActorSkillInfo", _m_ResetActorSkillInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetActorSkillInfos", _m_GetActorSkillInfos_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetBuff", _m_ResetBuff_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityBuffList", _m_GetEntityBuffList_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetShield", _m_ResetShield_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityShieldList", _m_GetEntityShieldList_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityShieldListForGM", _m_GetEntityShieldListForGM_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRglTheme", _m_SetRglTheme_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetFateCardThemes", _m_SetFateCardThemes_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetFateCardInfos", _m_SetFateCardInfos_xlua_st_);
		Utils.RegisterFunc(L, -4, "UpdateFateCardInfos", _m_UpdateFateCardInfos_xlua_st_);
		Utils.RegisterFunc(L, -4, "ChangeThemePerkIds", _m_ChangeThemePerkIds_xlua_st_);
		Utils.RegisterFunc(L, -4, "ChangePersonalPerkIds", _m_ChangePersonalPerkIds_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDiscInfo", _m_SetDiscInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetNoteInfo", _m_SetNoteInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetUnFinishedAchievementInfo", _m_SetUnFinishedAchievementInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetActorAttribute", _m_SetActorAttribute_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetActorStatus", _m_SetActorStatus_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetBuildLevel", _m_SetBuildLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetActorAmmoInfos", _m_SetActorAmmoInfos_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetActorEffect", _m_SetActorEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveActorEffect", _m_RemoveActorEffect_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEffectList", _m_GetEffectList_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResetBTalentAndStoneHeart", _m_ResetBTalentAndStoneHeart_xlua_st_);
		Utils.RegisterFunc(L, -4, "SelectSupply", _m_SelectSupply_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityHp", _m_GetEntityHp_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetActorSkillCD", _m_GetActorSkillCD_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetActorSkillEnergy", _m_GetActorSkillEnergy_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetActorSkillSectionAmount", _m_GetActorSkillSectionAmount_xlua_st_);
		Utils.RegisterFunc(L, -4, "CheckSkillAvailable", _m_CheckSkillAvailable_xlua_st_);
		Utils.RegisterFunc(L, -4, "ForceSyncSkillBtnToLua", _m_ForceSyncSkillBtnToLua_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentGroupPlayers", _m_GetCurrentGroupPlayers_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentActivePlayer", _m_GetCurrentActivePlayer_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentMonsters", _m_GetCurrentMonsters_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentTraps", _m_GetCurrentTraps_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentDynamicActors", _m_GetCurrentDynamicActors_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCharacterId", _m_GetCharacterId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetHudDamageSourceGroup", _m_GetHudDamageSourceGroup_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCharacterDamage", _m_GetCharacterDamage_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCharacterTotalDamage", _m_GetCharacterTotalDamage_xlua_st_);
		Utils.RegisterFunc(L, -4, "ClearCharacterDamageRecord", _m_ClearCharacterDamageRecord_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerEntityId", _m_GetPlayerEntityId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerAttributeValue", _m_GetPlayerAttributeValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetPlayerAttributeValue", _m_SetPlayerAttributeValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityId", _m_GetEntityId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMonsterToughness", _m_GetMonsterToughness_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMonsterToughnessMax", _m_GetMonsterToughnessMax_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetCurrentActorBindSkillId", _m_GetCurrentActorBindSkillId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityInfo", _m_GetEntityInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityHealthInfo", _m_GetEntityHealthInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityElementInfo", _m_GetEntityElementInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityShieldInfo", _m_GetEntityShieldInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityAmmoInfo", _m_GetEntityAmmoInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityToughnessInfo", _m_GetEntityToughnessInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityEffectList", _m_GetEntityEffectList_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityEffectUniqueIdList", _m_GetEntityEffectUniqueIdList_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddEntityEffectById", _m_AddEntityEffectById_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveEntityEffectById", _m_RemoveEntityEffectById_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddEntityBuffById", _m_AddEntityBuffById_xlua_st_);
		Utils.RegisterFunc(L, -4, "RemoveEntityBuffById", _m_RemoveEntityBuffById_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetPlayerSkillCd", _m_GetPlayerSkillCd_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityMaxHp", _m_GetEntityMaxHp_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityHaveBuffTimeReduce", _m_GetEntityHaveBuffTimeReduce_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityShieldValue", _m_GetEntityShieldValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityAlive", _m_GetEntityAlive_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityAmmoMax", _m_GetEntityAmmoMax_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityAmmoCount", _m_GetEntityAmmoCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityBulletType", _m_GetEntityBulletType_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetJointDrillBossData", _m_GetJointDrillBossData_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetJointDrillBossData", _m_SetJointDrillBossData_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetJointDrillBossEnergy", _m_GetJointDrillBossEnergy_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetRoguelikeChestData", _m_SetRoguelikeChestData_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_RoguelikeOpenTeleporter", _m_Lua2CSharp_RoguelikeOpenTeleporter_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_ChangeVisionAttackRange", _m_Lua2CSharp_ChangeVisionAttackRange_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterMainlineMap", _m_EnterMainlineMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterBattleTestComboClipMap", _m_EnterBattleTestComboClipMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterProloguelMap", _m_EnterProloguelMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterProloguelBattleMap", _m_EnterProloguelBattleMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterDailyInstanceMap", _m_EnterDailyInstanceMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterEquipmentInstanceMap", _m_EnterEquipmentInstanceMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterInfinityTowerFloor", _m_EnterInfinityTowerFloor_xlua_st_);
		Utils.RegisterFunc(L, -4, "InfinityTowerFloorEffects", _m_InfinityTowerFloorEffects_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterVampireFloor", _m_EnterVampireFloor_xlua_st_);
		Utils.RegisterFunc(L, -4, "VampireFloorEffects", _m_VampireFloorEffects_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterScoreBossFloor", _m_EnterScoreBossFloor_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterSkillInstanceMap", _m_EnterSkillInstanceMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterDynamic", _m_EnterDynamic_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterTowerDefenseLevel", _m_EnterTowerDefenseLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterBrickBreakerLevel", _m_EnterBrickBreakerLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "TowerDefense_SetTimeScale", _m_TowerDefense_SetTimeScale_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterAutoBattleClearPlayer", _m_EnterAutoBattleClearPlayer_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterAutoBattleBalance", _m_EnterAutoBattleBalance_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterActivityLevelsInstance", _m_EnterActivityLevelsInstance_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterActivityStoryLevelsInstance", _m_EnterActivityStoryLevelsInstance_xlua_st_);
		Utils.RegisterFunc(L, -4, "RefreshRoomEffects", _m_RefreshRoomEffects_xlua_st_);
		Utils.RegisterFunc(L, -4, "FixedRoguelikeRoomEffects", _m_FixedRoguelikeRoomEffects_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterRogueBossMap", _m_EnterRogueBossMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterTravelerDuel", _m_EnterTravelerDuel_xlua_st_);
		Utils.RegisterFunc(L, -4, "RoguelikeEnterNextFloor", _m_RoguelikeEnterNextFloor_xlua_st_);
		Utils.RegisterFunc(L, -4, "LevelStateChanged", _m_LevelStateChanged_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetHudFollowTarget", _m_SetHudFollowTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetBossIndicatorTarget", _m_SetBossIndicatorTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "IsPlayerGroup", _m_IsPlayerGroup_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetHudValue", _m_SetHudValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "RefreshHudValue", _m_RefreshHudValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetHudStringValue", _m_SetHudStringValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetHudToughnessDamageValue", _m_SetHudToughnessDamageValue_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetHudOffsetWidth", _m_GetHudOffsetWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetHudOffsetHeight", _m_GetHudOffsetHeight_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityColliderHeight", _m_GetEntityColliderHeight_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityMonsterBarHeight", _m_GetEntityMonsterBarHeight_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetEntityColliderWidth", _m_GetEntityColliderWidth_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlaySettlementPerform", _m_PlaySettlementPerform_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayTeamUpgradeFX", _m_PlayTeamUpgradeFX_xlua_st_);
		Utils.RegisterFunc(L, -4, "LeaveAdventure", _m_LeaveAdventure_xlua_st_);
		Utils.RegisterFunc(L, -4, "SpawnPrefabInstance", _m_SpawnPrefabInstance_xlua_st_);
		Utils.RegisterFunc(L, -4, "DespawnPrefabInstance", _m_DespawnPrefabInstance_xlua_st_);
		Utils.RegisterFunc(L, -4, "PauseLogic", _m_PauseLogic_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResumeLogic", _m_ResumeLogic_xlua_st_);
		Utils.RegisterFunc(L, -4, "ExitSelectTeam", _m_ExitSelectTeam_xlua_st_);
		Utils.RegisterFunc(L, -4, "OpenActiveTeleporter", _m_OpenActiveTeleporter_xlua_st_);
		Utils.RegisterFunc(L, -4, "OpenTreasureAndNpcNew", _m_OpenTreasureAndNpcNew_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetLevelTeleporters", _m_GetLevelTeleporters_xlua_st_);
		Utils.RegisterFunc(L, -4, "CheckTimelineClipFinish", _m_CheckTimelineClipFinish_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMiniMapFeatureActive", _m_SetMiniMapFeatureActive_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetMapCameraActive", _m_SetMapCameraActive_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMiniMapRenderTexture", _m_GetMiniMapRenderTexture_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetMapRenderTexture", _m_GetMapRenderTexture_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDirectorState", _m_SetDirectorState_xlua_st_);
		Utils.RegisterFunc(L, -4, "PausePerformTimeline", _m_PausePerformTimeline_xlua_st_);
		Utils.RegisterFunc(L, -4, "ResumePerformTimeline", _m_ResumePerformTimeline_xlua_st_);
		Utils.RegisterFunc(L, -4, "StopPerformTimeline", _m_StopPerformTimeline_xlua_st_);
		Utils.RegisterFunc(L, -4, "PausePlayableDirector", _m_PausePlayableDirector_xlua_st_);
		Utils.RegisterFunc(L, -4, "StopPlayableDirector", _m_StopPlayableDirector_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetFirstSlotPlayer", _m_GetFirstSlotPlayer_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSecondSlotPlayer", _m_GetSecondSlotPlayer_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetGuideLogicTimeScale", _m_SetGuideLogicTimeScale_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterViewSceneLevel", _m_EnterViewSceneLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetBattleSamples", _m_GetBattleSamples_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterStarTowerTestMap", _m_EnterStarTowerTestMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "EnterStarTowerMap", _m_EnterStarTowerMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetDamageRecordId", _m_SetDamageRecordId_xlua_st_);
		Utils.RegisterFunc(L, -4, "RandomStarTowerMap", _m_RandomStarTowerMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "LogStarTowerMap", _m_LogStarTowerMap_xlua_st_);
		Utils.RegisterFunc(L, -4, "SpawnNPC", _m_SpawnNPC_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetProloguelBattleMsg", _m_SetProloguelBattleMsg_xlua_st_);
		Utils.RegisterFunc(L, -4, "UpdateUIPanlelId", _m_UpdateUIPanlelId_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSoldierActorInfo", _m_GetSoldierActorInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSoldierHealthInfo", _m_GetSoldierHealthInfo_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_OpenFrameShow", _m_Lua2CSharp_GMOrder_OpenFrameShow_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetGameFrame", _m_Lua2CSharp_GMOrder_SetGameFrame_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_JumpoverCurLevel", _m_Lua2CSharp_GMOrder_JumpoverCurLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetMonsterSkill", _m_Lua2CSharp_GMOrder_SetMonsterSkill_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_ChangeMonsterAIState", _m_Lua2CSharp_GMOrder_ChangeMonsterAIState_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_MonsterPlaySkill", _m_Lua2CSharp_GMOrder_MonsterPlaySkill_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SpawnMonster", _m_Lua2CSharp_GMOrder_SpawnMonster_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetIndicatorMode", _m_Lua2CSharp_GMOrder_SetIndicatorMode_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_SwichTarget", _m_Lua2CSharp_SwichTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetTimeScale", _m_Lua2CSharp_GMOrder_SetTimeScale_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_KillCurChar", _m_Lua2CSharp_GMOrder_KillCurChar_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetCurCharResidualHp", _m_Lua2CSharp_GMOrder_SetCurCharResidualHp_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_AddCurCharAttack", _m_Lua2CSharp_GMOrder_AddCurCharAttack_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_KillCurMonsters", _m_Lua2CSharp_GMOrder_KillCurMonsters_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_KillMonstersByActorId", _m_Lua2CSharp_GMOrder_KillMonstersByActorId_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_KillMonstersById", _m_Lua2CSharp_GMOrder_KillMonstersById_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SkipLevel", _m_Lua2CSharp_GMOrder_SkipLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_ChangeAllCharDef", _m_Lua2CSharp_GMOrder_ChangeAllCharDef_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_UltimateIgnoreCDAndEnergy", _m_Lua2CSharp_GMOrder_UltimateIgnoreCDAndEnergy_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_SetEntityMoveSpeedPercent", _m_Lua2CSharp_GMOrder_SetEntityMoveSpeedPercent_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_FastCD", _m_Lua2CSharp_GMOrder_FastCD_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_Revive", _m_Lua2CSharp_GMOrder_Revive_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_ChangeAttribute", _m_Lua2CSharp_GMOrder_ChangeAttribute_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_StarTowerConfigExtension", _m_Lua2CSharp_GMOrder_StarTowerConfigExtension_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_StarTowerGameplayType", _m_Lua2CSharp_GMOrder_StarTowerGameplayType_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_StarTowerScenePrefabId", _m_Lua2CSharp_GMOrder_StarTowerScenePrefabId_xlua_st_);
		Utils.RegisterFunc(L, -4, "Lua2CSharp_GMOrder_StarTowerFloorSetRoomType", _m_Lua2CSharp_GMOrder_StarTowerFloorSetRoomType_xlua_st_);
		Utils.RegisterFunc(L, -4, "GMOrder_GetMonsterLevel", _m_GMOrder_GetMonsterLevel_xlua_st_);
		Utils.RegisterFunc(L, -4, "GMOrder_ConvertAttributeTypeAndElementTypeToKey", _m_GMOrder_ConvertAttributeTypeAndElementTypeToKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "GMOrder_ConvertAttributeTypeAndDamageTypeToKey", _m_GMOrder_ConvertAttributeTypeAndDamageTypeToKey_xlua_st_);
		Utils.RegisterFunc(L, -4, "GMOrder_GetAttributeValueWithElementOrDamageType", _m_GMOrder_GetAttributeValueWithElementOrDamageType_xlua_st_);
		Utils.RegisterFunc(L, -2, "playerUid", _g_get_playerUid);
		Utils.RegisterFunc(L, -2, "lastPanelId", _g_get_lastPanelId);
		Utils.RegisterFunc(L, -2, "showHPBar", _g_get_showHPBar);
		Utils.RegisterFunc(L, -2, "showDMGNum", _g_get_showDMGNum);
		Utils.RegisterFunc(L, -2, "showDMG", _g_get_showDMG);
		Utils.RegisterFunc(L, -2, "showEffect", _g_get_showEffect);
		Utils.RegisterFunc(L, -2, "currentPanelid", _g_get_currentPanelid);
		Utils.RegisterFunc(L, -1, "playerUid", _s_set_playerUid);
		Utils.RegisterFunc(L, -1, "lastPanelId", _s_set_lastPanelId);
		Utils.RegisterFunc(L, -1, "showHPBar", _s_set_showHPBar);
		Utils.RegisterFunc(L, -1, "showDMGNum", _s_set_showDMGNum);
		Utils.RegisterFunc(L, -1, "showDMG", _s_set_showDMG);
		Utils.RegisterFunc(L, -1, "showEffect", _s_set_showEffect);
		Utils.RegisterFunc(L, -1, "currentPanelid", _s_set_currentPanelid);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		return Lua.luaL_error(L, "AdventureModuleHelper does not have a constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSemiAutoBattleMode_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetSemiAutoBattleMode(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetAutoCastUltimateSkill_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetAutoCastUltimateSkill(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSummonMonsterInfos_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<Lua2CSharpInfo_SummonMonsterInfo> summonMonsterInfos = AdventureModuleHelper.GetSummonMonsterInfos();
			objectTranslator.Push(L, summonMonsterInfos);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSummonMonsters_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetSummonMonsters((List<Lua2CSharpInfo_SummonMonsterInfo>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<Lua2CSharpInfo_SummonMonsterInfo>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetActorAttributes_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResetActorAttributes((Lua2CSharpInfo_ActorAttribute[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_ActorAttribute[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerActorStatus_xlua_st_(IntPtr L)
	{
		try
		{
			int playerActorStatus = AdventureModuleHelper.GetPlayerActorStatus(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, playerActorStatus);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerActorSpecialStatusTime_xlua_st_(IntPtr L)
	{
		try
		{
			long playerActorSpecialStatusTime = AdventureModuleHelper.GetPlayerActorSpecialStatusTime(Lua.lua_toint64(L, 1));
			Lua.lua_pushint64(L, playerActorSpecialStatusTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerActorLocalDataJson_xlua_st_(IntPtr L)
	{
		try
		{
			string playerActorLocalDataJson = AdventureModuleHelper.GetPlayerActorLocalDataJson(Lua.lua_toint64(L, 1));
			Lua.lua_pushstring(L, playerActorLocalDataJson);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerActorAmmoType_xlua_st_(IntPtr L)
	{
		try
		{
			int playerActorAmmoType = AdventureModuleHelper.GetPlayerActorAmmoType(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, playerActorAmmoType);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerActorAmmoCount_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int[] playerActorAmmoCount = AdventureModuleHelper.GetPlayerActorAmmoCount(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, playerActorAmmoCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetActorSkillInfo_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResetActorSkillInfo((MapField<int, RepeatedField<Lua2CSharpInfo_ResetSkillInfo>>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(MapField<int, RepeatedField<Lua2CSharpInfo_ResetSkillInfo>>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetActorSkillInfos_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<SkillInfo> actorSkillInfos = AdventureModuleHelper.GetActorSkillInfos(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, actorSkillInfos);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetBuff_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResetBuff((MapField<int, RepeatedField<Lua2CSharpInfo_ResetBuffInfo>>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(MapField<int, RepeatedField<Lua2CSharpInfo_ResetBuffInfo>>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityBuffList_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<BuffEntity> entityBuffList = AdventureModuleHelper.GetEntityBuffList(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityBuffList);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetShield_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int actorId = Lua.xlua_tointeger(L, 1);
			List<Lua2CSharpInfo_ReseShieldInfo> shieldInfo = (List<Lua2CSharpInfo_ReseShieldInfo>)objectTranslator.GetObject(L, 2, typeof(List<Lua2CSharpInfo_ReseShieldInfo>));
			AdventureModuleHelper.ResetShield(actorId, shieldInfo);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityShieldList_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<Lua2CSharpInfo_ReseShieldInfo> entityShieldList = AdventureModuleHelper.GetEntityShieldList(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityShieldList);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityShieldListForGM_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<Lua2CSharpInfo_ReseShieldInfo> entityShieldListForGM = AdventureModuleHelper.GetEntityShieldListForGM(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityShieldListForGM);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRglTheme_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetRglTheme((int[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(int[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetFateCardThemes_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetFateCardThemes((Lua2CSharpInfo_FateCardThemeInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_FateCardThemeInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetFateCardInfos_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetFateCardInfos((Lua2CSharpInfo_FateCardInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_FateCardInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UpdateFateCardInfos_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.UpdateFateCardInfos((Lua2CSharpInfo_FateCardInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_FateCardInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ChangeThemePerkIds_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ChangeThemePerkIds((Lua2CSharpInfo_TPPerkInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_TPPerkInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ChangePersonalPerkIds_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<Lua2CSharpInfo_TPPerkInfo[]>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				Lua2CSharpInfo_TPPerkInfo[] infos = (Lua2CSharpInfo_TPPerkInfo[])objectTranslator.GetObject(L, 1, typeof(Lua2CSharpInfo_TPPerkInfo[]));
				int actorId = Lua.xlua_tointeger(L, 2);
				bool change = Lua.lua_toboolean(L, 3);
				AdventureModuleHelper.ChangePersonalPerkIds(infos, actorId, change);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<Lua2CSharpInfo_TPPerkInfo[]>(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2))
			{
				Lua2CSharpInfo_TPPerkInfo[] infos2 = (Lua2CSharpInfo_TPPerkInfo[])objectTranslator.GetObject(L, 1, typeof(Lua2CSharpInfo_TPPerkInfo[]));
				int actorId2 = Lua.xlua_tointeger(L, 2);
				AdventureModuleHelper.ChangePersonalPerkIds(infos2, actorId2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to AdventureModuleHelper.ChangePersonalPerkIds!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDiscInfo_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetDiscInfo((Lua2CSharpInfo_DiscInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_DiscInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetNoteInfo_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetNoteInfo((Lua2CSharpInfo_NoteInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_NoteInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetUnFinishedAchievementInfo_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetUnFinishedAchievementInfo((List<int>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<int>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetActorAttribute_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int actorId = Lua.xlua_tointeger(L, 1);
			objectTranslator.Get(L, 2, out Lua2CSharpInfo_CharAttribute v);
			AdventureModuleHelper.SetActorAttribute(actorId, v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetActorStatus_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetActorStatus((Lua2CSharpInfo_ActorStatus[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_ActorStatus[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetBuildLevel_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetBuildLevel(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetActorAmmoInfos_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetActorAmmoInfos((Lua2CSharpInfo_ActorAmmoInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_ActorAmmoInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetActorEffect_xlua_st_(IntPtr L)
	{
		try
		{
			int num = Lua.lua_gettop(L);
			if (num == 6 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) || Lua.lua_isint64(L, 4)) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6))
			{
				int actorDataId = Lua.xlua_tointeger(L, 1);
				int effectId = Lua.xlua_tointeger(L, 2);
				int takeEffectLimit = Lua.xlua_tointeger(L, 3);
				long initCD = Lua.lua_toint64(L, 4);
				bool shareCD = Lua.lua_toboolean(L, 5);
				bool shareTimes = Lua.lua_toboolean(L, 6);
				int value = AdventureModuleHelper.SetActorEffect(actorDataId, effectId, takeEffectLimit, initCD, shareCD, shareTimes);
				Lua.xlua_pushinteger(L, value);
				return 1;
			}
			if (num == 5 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) || Lua.lua_isint64(L, 4)) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5))
			{
				int actorDataId2 = Lua.xlua_tointeger(L, 1);
				int effectId2 = Lua.xlua_tointeger(L, 2);
				int takeEffectLimit2 = Lua.xlua_tointeger(L, 3);
				long initCD2 = Lua.lua_toint64(L, 4);
				bool shareCD2 = Lua.lua_toboolean(L, 5);
				int value2 = AdventureModuleHelper.SetActorEffect(actorDataId2, effectId2, takeEffectLimit2, initCD2, shareCD2);
				Lua.xlua_pushinteger(L, value2);
				return 1;
			}
			if (num == 4 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) || Lua.lua_isint64(L, 4)))
			{
				int actorDataId3 = Lua.xlua_tointeger(L, 1);
				int effectId3 = Lua.xlua_tointeger(L, 2);
				int takeEffectLimit3 = Lua.xlua_tointeger(L, 3);
				long initCD3 = Lua.lua_toint64(L, 4);
				int value3 = AdventureModuleHelper.SetActorEffect(actorDataId3, effectId3, takeEffectLimit3, initCD3);
				Lua.xlua_pushinteger(L, value3);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to AdventureModuleHelper.SetActorEffect!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveActorEffect_xlua_st_(IntPtr L)
	{
		try
		{
			int actorDataId = Lua.xlua_tointeger(L, 1);
			int effectUniqueId = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.RemoveActorEffect(actorDataId, effectUniqueId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEffectList_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<AdventureEffect> effectList = AdventureModuleHelper.GetEffectList(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, effectList);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResetBTalentAndStoneHeart_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResetBTalentAndStoneHeart();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SelectSupply_xlua_st_(IntPtr L)
	{
		try
		{
			int effectId = Lua.xlua_tointeger(L, 1);
			bool revive = Lua.lua_toboolean(L, 2);
			AdventureModuleHelper.SelectSupply(effectId, revive);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityHp_xlua_st_(IntPtr L)
	{
		try
		{
			long entityHp = AdventureModuleHelper.GetEntityHp(Lua.lua_toint64(L, 1));
			Lua.lua_pushint64(L, entityHp);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetActorSkillCD_xlua_st_(IntPtr L)
	{
		try
		{
			long id = Lua.lua_toint64(L, 1);
			int skillId = Lua.xlua_tointeger(L, 2);
			int actorSkillCD = AdventureModuleHelper.GetActorSkillCD(id, skillId);
			Lua.xlua_pushinteger(L, actorSkillCD);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetActorSkillEnergy_xlua_st_(IntPtr L)
	{
		try
		{
			long id = Lua.lua_toint64(L, 1);
			int skillId = Lua.xlua_tointeger(L, 2);
			int actorSkillEnergy = AdventureModuleHelper.GetActorSkillEnergy(id, skillId);
			Lua.xlua_pushinteger(L, actorSkillEnergy);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetActorSkillSectionAmount_xlua_st_(IntPtr L)
	{
		try
		{
			long id = Lua.lua_toint64(L, 1);
			int skillId = Lua.xlua_tointeger(L, 2);
			int actorSkillSectionAmount = AdventureModuleHelper.GetActorSkillSectionAmount(id, skillId);
			Lua.xlua_pushinteger(L, actorSkillSectionAmount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CheckSkillAvailable_xlua_st_(IntPtr L)
	{
		try
		{
			long id = Lua.lua_toint64(L, 1);
			int nSkillId = Lua.xlua_tointeger(L, 2);
			bool value = AdventureModuleHelper.CheckSkillAvailable(id, nSkillId);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ForceSyncSkillBtnToLua_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ForceSyncSkillBtnToLua(Lua.lua_toint64(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentGroupPlayers_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<long> currentGroupPlayers = AdventureModuleHelper.GetCurrentGroupPlayers();
			objectTranslator.Push(L, currentGroupPlayers);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentActivePlayer_xlua_st_(IntPtr L)
	{
		try
		{
			long currentActivePlayer = AdventureModuleHelper.GetCurrentActivePlayer();
			Lua.lua_pushint64(L, currentActivePlayer);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentMonsters_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<long> currentMonsters = AdventureModuleHelper.GetCurrentMonsters();
			objectTranslator.Push(L, currentMonsters);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentTraps_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<long> currentTraps = AdventureModuleHelper.GetCurrentTraps();
			objectTranslator.Push(L, currentTraps);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentDynamicActors_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<long> currentDynamicActors = AdventureModuleHelper.GetCurrentDynamicActors();
			objectTranslator.Push(L, currentDynamicActors);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCharacterId_xlua_st_(IntPtr L)
	{
		try
		{
			int characterId = AdventureModuleHelper.GetCharacterId(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, characterId);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetHudDamageSourceGroup_xlua_st_(IntPtr L)
	{
		try
		{
			int hudDamageSourceGroup = AdventureModuleHelper.GetHudDamageSourceGroup(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, hudDamageSourceGroup);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCharacterDamage_xlua_st_(IntPtr L)
	{
		try
		{
			int actorDataId = Lua.xlua_tointeger(L, 1);
			bool isStage = Lua.lua_toboolean(L, 2);
			long characterDamage = AdventureModuleHelper.GetCharacterDamage(actorDataId, isStage);
			Lua.lua_pushint64(L, characterDamage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCharacterTotalDamage_xlua_st_(IntPtr L)
	{
		try
		{
			long characterTotalDamage = AdventureModuleHelper.GetCharacterTotalDamage(Lua.xlua_tointeger(L, 1));
			Lua.lua_pushint64(L, characterTotalDamage);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearCharacterDamageRecord_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ClearCharacterDamageRecord(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerEntityId_xlua_st_(IntPtr L)
	{
		try
		{
			long playerEntityId = AdventureModuleHelper.GetPlayerEntityId(Lua.xlua_tointeger(L, 1));
			Lua.lua_pushint64(L, playerEntityId);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerAttributeValue_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int dataID = Lua.xlua_tointeger(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.playerAttributeType v);
			float playerAttributeValue = AdventureModuleHelper.GetPlayerAttributeValue(dataID, v);
			Lua.lua_pushnumber(L, playerAttributeValue);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetPlayerAttributeValue_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int dataID = Lua.xlua_tointeger(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.playerAttributeType v);
			int value = Lua.xlua_tointeger(L, 3);
			bool isIntFloat = Lua.lua_toboolean(L, 4);
			AdventureModuleHelper.SetPlayerAttributeValue(dataID, v, value, isIntFloat);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityId_xlua_st_(IntPtr L)
	{
		try
		{
			int entityId = AdventureModuleHelper.GetEntityId(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, entityId);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMonsterToughness_xlua_st_(IntPtr L)
	{
		try
		{
			long monsterToughness = AdventureModuleHelper.GetMonsterToughness(Lua.lua_toint64(L, 1));
			Lua.lua_pushint64(L, monsterToughness);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMonsterToughnessMax_xlua_st_(IntPtr L)
	{
		try
		{
			long monsterToughnessMax = AdventureModuleHelper.GetMonsterToughnessMax(Lua.lua_toint64(L, 1));
			Lua.lua_pushint64(L, monsterToughnessMax);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurrentActorBindSkillId_xlua_st_(IntPtr L)
	{
		try
		{
			long id = Lua.lua_toint64(L, 1);
			int actionKey = Lua.xlua_tointeger(L, 2);
			int currentActorBindSkillId = AdventureModuleHelper.GetCurrentActorBindSkillId(id, actionKey);
			Lua.xlua_pushinteger(L, currentActorBindSkillId);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorInfo entityInfo = AdventureModuleHelper.GetEntityInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityHealthInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorHealthInfo entityHealthInfo = AdventureModuleHelper.GetEntityHealthInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityHealthInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityElementInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorElementInfo entityElementInfo = AdventureModuleHelper.GetEntityElementInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityElementInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityShieldInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorShield entityShieldInfo = AdventureModuleHelper.GetEntityShieldInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityShieldInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityAmmoInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			AmmoInfo entityAmmoInfo = AdventureModuleHelper.GetEntityAmmoInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityAmmoInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityToughnessInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			MonsterToughnessInfo entityToughnessInfo = AdventureModuleHelper.GetEntityToughnessInfo(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityToughnessInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityEffectList_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<int> entityEffectList = AdventureModuleHelper.GetEntityEffectList(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityEffectList);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityEffectUniqueIdList_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<int> entityEffectUniqueIdList = AdventureModuleHelper.GetEntityEffectUniqueIdList(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, entityEffectUniqueIdList);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddEntityEffectById_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int effectId = Lua.xlua_tointeger(L, 2);
			int value = AdventureModuleHelper.AddEntityEffectById(entityId, effectId);
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveEntityEffectById_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int effectId = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.RemoveEntityEffectById(entityId, effectId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddEntityBuffById_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int buffId = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.AddEntityBuffById(entityId, buffId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveEntityBuffById_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int buffId = Lua.xlua_tointeger(L, 2);
			bool reduceNum = Lua.lua_toboolean(L, 3);
			AdventureModuleHelper.RemoveEntityBuffById(entityId, buffId, reduceNum);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPlayerSkillCd_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			PlayerSkillCd playerSkillCd = AdventureModuleHelper.GetPlayerSkillCd(Lua.lua_toint64(L, 1));
			objectTranslator.Push(L, playerSkillCd);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityMaxHp_xlua_st_(IntPtr L)
	{
		try
		{
			long entityMaxHp = AdventureModuleHelper.GetEntityMaxHp(Lua.lua_toint64(L, 1));
			Lua.lua_pushint64(L, entityMaxHp);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityHaveBuffTimeReduce_xlua_st_(IntPtr L)
	{
		try
		{
			bool entityHaveBuffTimeReduce = AdventureModuleHelper.GetEntityHaveBuffTimeReduce(Lua.lua_toint64(L, 1));
			Lua.lua_pushboolean(L, entityHaveBuffTimeReduce);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityShieldValue_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.GetEntityShieldValue(Lua.lua_toint64(L, 1), out var shiledValue, out var shieldMax);
			Lua.lua_pushint64(L, shiledValue);
			Lua.lua_pushint64(L, shieldMax);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityAlive_xlua_st_(IntPtr L)
	{
		try
		{
			bool entityAlive = AdventureModuleHelper.GetEntityAlive(Lua.lua_toint64(L, 1));
			Lua.lua_pushboolean(L, entityAlive);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityAmmoMax_xlua_st_(IntPtr L)
	{
		try
		{
			int entityAmmoMax = AdventureModuleHelper.GetEntityAmmoMax(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, entityAmmoMax);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityAmmoCount_xlua_st_(IntPtr L)
	{
		try
		{
			int entityAmmoCount = AdventureModuleHelper.GetEntityAmmoCount(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, entityAmmoCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityBulletType_xlua_st_(IntPtr L)
	{
		try
		{
			int entityBulletType = AdventureModuleHelper.GetEntityBulletType(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, entityBulletType);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetJointDrillBossData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long bossId = Lua.lua_toint64(L, 1);
			bool changeTeam = Lua.lua_toboolean(L, 2);
			bool saveEnergy = Lua.lua_toboolean(L, 3);
			bool saveResilience = Lua.lua_toboolean(L, 4);
			JointDrillBoss jointDrillBossData = AdventureModuleHelper.GetJointDrillBossData(bossId, changeTeam, saveEnergy, saveResilience);
			objectTranslator.Push(L, jointDrillBossData);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetJointDrillBossData_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long bossId = Lua.lua_toint64(L, 1);
			objectTranslator.Get(L, 2, out JointDrillBoss v);
			AdventureModuleHelper.SetJointDrillBossData(bossId, v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetJointDrillBossEnergy_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.GetJointDrillBossEnergy(Lua.lua_toint64(L, 1), out var mEnergy, out var cEnergy);
			Lua.xlua_pushinteger(L, mEnergy);
			Lua.xlua_pushinteger(L, cEnergy);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetRoguelikeChestData_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetRoguelikeChestData((Lua2CSharpInfo_RoguelikeChestInfo[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Lua2CSharpInfo_RoguelikeChestInfo[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_RoguelikeOpenTeleporter_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_RoguelikeOpenTeleporter();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_ChangeVisionAttackRange_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_ChangeVisionAttackRange(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterMainlineMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			int[] openedChest = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			AdventureModuleHelper.EnterMainlineMap(id, team, openedChest);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterBattleTestComboClipMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			int[] openedChest = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			AdventureModuleHelper.EnterBattleTestComboClipMap(id, team, openedChest);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterProloguelMap_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.EnterProloguelMap(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterProloguelBattleMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			int[] openedChest = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			bool isThreeP = Lua.lua_toboolean(L, 4);
			objectTranslator.Get(L, 5, out Vector3 val);
			List<string> btns = (List<string>)objectTranslator.GetObject(L, 6, typeof(List<string>));
			int boxID = Lua.xlua_tointeger(L, 7);
			AdventureModuleHelper.EnterProloguelBattleMap(id, team, openedChest, isThreeP, val, btns, boxID);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterDailyInstanceMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			AdventureModuleHelper.EnterDailyInstanceMap(id, team);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterEquipmentInstanceMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			AdventureModuleHelper.EnterEquipmentInstanceMap(id, team);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterInfinityTowerFloor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			bool isContinue = Lua.lua_toboolean(L, 3);
			AdventureModuleHelper.EnterInfinityTowerFloor(id, team, isContinue);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_InfinityTowerFloorEffects_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.InfinityTowerFloorEffects((int[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(int[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterVampireFloor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 8 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && objectTranslator.Assignable<int[]>(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3) && objectTranslator.Assignable<int[]>(L, 4) && objectTranslator.Assignable<int[]>(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6) && objectTranslator.Assignable<VampireDropData[]>(L, 7) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 8))
			{
				int id = Lua.xlua_tointeger(L, 1);
				int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
				bool isFirstHalf = Lua.lua_toboolean(L, 3);
				int[] specialEnemySet = (int[])objectTranslator.GetObject(L, 4, typeof(int[]));
				int[] treasureSet = (int[])objectTranslator.GetObject(L, 5, typeof(int[]));
				bool isHalfBattle = Lua.lua_toboolean(L, 6);
				VampireDropData[] dropData = (VampireDropData[])objectTranslator.GetObject(L, 7, typeof(VampireDropData[]));
				bool isRestart = Lua.lua_toboolean(L, 8);
				AdventureModuleHelper.EnterVampireFloor(id, team, isFirstHalf, specialEnemySet, treasureSet, isHalfBattle, dropData, isRestart);
				return 0;
			}
			if (num == 7 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && objectTranslator.Assignable<int[]>(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3) && objectTranslator.Assignable<int[]>(L, 4) && objectTranslator.Assignable<int[]>(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6) && objectTranslator.Assignable<VampireDropData[]>(L, 7))
			{
				int id2 = Lua.xlua_tointeger(L, 1);
				int[] team2 = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
				bool isFirstHalf2 = Lua.lua_toboolean(L, 3);
				int[] specialEnemySet2 = (int[])objectTranslator.GetObject(L, 4, typeof(int[]));
				int[] treasureSet2 = (int[])objectTranslator.GetObject(L, 5, typeof(int[]));
				bool isHalfBattle2 = Lua.lua_toboolean(L, 6);
				VampireDropData[] dropData2 = (VampireDropData[])objectTranslator.GetObject(L, 7, typeof(VampireDropData[]));
				AdventureModuleHelper.EnterVampireFloor(id2, team2, isFirstHalf2, specialEnemySet2, treasureSet2, isHalfBattle2, dropData2);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to AdventureModuleHelper.EnterVampireFloor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_VampireFloorEffects_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.VampireFloorEffects((int[])ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(int[])));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterScoreBossFloor_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			AdventureModuleHelper.EnterScoreBossFloor(id, team);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterSkillInstanceMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			AdventureModuleHelper.EnterSkillInstanceMap(id, team);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterDynamic_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			int levelType = Lua.xlua_tointeger(L, 3);
			string[] levelParams = (string[])objectTranslator.GetObject(L, 4, typeof(string[]));
			AdventureModuleHelper.EnterDynamic(id, team, levelType, levelParams);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterTowerDefenseLevel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int floorID = Lua.xlua_tointeger(L, 1);
			string[] levelParams = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
			AdventureModuleHelper.EnterTowerDefenseLevel(floorID, levelParams);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterBrickBreakerLevel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int floorID = Lua.xlua_tointeger(L, 1);
			string[] levelParams = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
			AdventureModuleHelper.EnterBrickBreakerLevel(floorID, levelParams);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_TowerDefense_SetTimeScale_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.TowerDefense_SetTimeScale(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterAutoBattleClearPlayer_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.EnterAutoBattleClearPlayer();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterAutoBattleBalance_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			float mainPlayerHPPre = (float)Lua.lua_tonumber(L, 3);
			int teamIndex = Lua.xlua_tointeger(L, 4);
			AdventureModuleHelper.EnterAutoBattleBalance(id, team, mainPlayerHPPre, teamIndex);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterActivityLevelsInstance_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			string[] levelParams = (string[])objectTranslator.GetObject(L, 3, typeof(string[]));
			AdventureModuleHelper.EnterActivityLevelsInstance(id, team, levelParams);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterActivityStoryLevelsInstance_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			AdventureModuleHelper.EnterActivityStoryLevelsInstance(id, team);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RefreshRoomEffects_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.RefreshRoomEffects((List<int>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<int>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_FixedRoguelikeRoomEffects_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.FixedRoguelikeRoomEffects((List<int>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<int>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterRogueBossMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int[] team = (int[])objectTranslator.GetObject(L, 2, typeof(int[]));
			int bosslvId = Lua.xlua_tointeger(L, 3);
			int chestId = Lua.xlua_tointeger(L, 4);
			int isWeekBoss = Lua.xlua_tointeger(L, 5);
			AdventureModuleHelper.EnterRogueBossMap(id, team, bosslvId, chestId, isWeekBoss);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterTravelerDuel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int id = Lua.xlua_tointeger(L, 1);
			int floorId = Lua.xlua_tointeger(L, 2);
			int[] team = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			int[] affixes = (int[])objectTranslator.GetObject(L, 4, typeof(int[]));
			AdventureModuleHelper.EnterTravelerDuel(id, floorId, team, affixes);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RoguelikeEnterNextFloor_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.RoguelikeEnterNextFloor();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LevelStateChanged_xlua_st_(IntPtr L)
	{
		try
		{
			int num = Lua.lua_gettop(L);
			if (num == 3 && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				bool isLevelFinish = Lua.lua_toboolean(L, 1);
				float fadeTime = (float)Lua.lua_tonumber(L, 2);
				bool isFailOrAbandon = Lua.lua_toboolean(L, 3);
				AdventureModuleHelper.LevelStateChanged(isLevelFinish, fadeTime, isFailOrAbandon);
				return 0;
			}
			if (num == 2 && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2))
			{
				bool isLevelFinish2 = Lua.lua_toboolean(L, 1);
				float fadeTime2 = (float)Lua.lua_tonumber(L, 2);
				AdventureModuleHelper.LevelStateChanged(isLevelFinish2, fadeTime2);
				return 0;
			}
			if (num == 1 && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 1))
			{
				AdventureModuleHelper.LevelStateChanged(Lua.lua_toboolean(L, 1));
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to AdventureModuleHelper.LevelStateChanged!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetHudFollowTarget_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long entityId = Lua.lua_toint64(L, 1);
			GameObject gameObject = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			objectTranslator.Get(L, 3, out Vector3 val);
			bool head = Lua.lua_toboolean(L, 4);
			AdventureModuleHelper.SetHudFollowTarget(entityId, gameObject, val, head);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetBossIndicatorTarget_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long entityId = Lua.lua_toint64(L, 1);
			GameObject gameObject = (GameObject)objectTranslator.GetObject(L, 2, typeof(GameObject));
			objectTranslator.Get(L, 3, out Vector3 val);
			AdventureModuleHelper.SetBossIndicatorTarget(entityId, gameObject, val);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsPlayerGroup_xlua_st_(IntPtr L)
	{
		try
		{
			bool value = AdventureModuleHelper.IsPlayerGroup(Lua.lua_toint64(L, 1));
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetHudValue_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject gameObject = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			long entityId = Lua.lua_toint64(L, 2);
			int id = Lua.xlua_tointeger(L, 3);
			long val = Lua.lua_toint64(L, 4);
			bool isHeal = Lua.lua_toboolean(L, 5);
			HitDamage hitDamage = (HitDamage)objectTranslator.GetObject(L, 6, typeof(HitDamage));
			long formEntityId = Lua.lua_toint64(L, 7);
			bool isCrit = Lua.lua_toboolean(L, 8);
			bool isDot = Lua.lua_toboolean(L, 9);
			int fromElementType = Lua.xlua_tointeger(L, 10);
			int hudColorIndex = Lua.xlua_tointeger(L, 11);
			AdventureModuleHelper.SetHudValue(gameObject, entityId, id, val, isHeal, hitDamage, formEntityId, isCrit, isDot, fromElementType, hudColorIndex);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RefreshHudValue_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject gameObject = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			long val = Lua.lua_toint64(L, 2);
			int hudColorIndex = Lua.xlua_tointeger(L, 3);
			AdventureModuleHelper.RefreshHudValue(gameObject, val, hudColorIndex);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetHudStringValue_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject gameObject = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			long entityId = Lua.lua_toint64(L, 2);
			int id = Lua.xlua_tointeger(L, 3);
			string val = Lua.lua_tostring(L, 4);
			int valType = Lua.xlua_tointeger(L, 5);
			bool useVariant = Lua.lua_toboolean(L, 6);
			AdventureModuleHelper.SetHudStringValue(gameObject, entityId, id, val, valType, useVariant);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetHudToughnessDamageValue_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject gameObject = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			long entityId = Lua.lua_toint64(L, 2);
			int id = Lua.xlua_tointeger(L, 3);
			string val = Lua.lua_tostring(L, 4);
			bool useVariant = Lua.lua_toboolean(L, 5);
			bool isChange = Lua.lua_toboolean(L, 6);
			AdventureModuleHelper.SetHudToughnessDamageValue(gameObject, entityId, id, val, useVariant, isChange);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetHudOffsetWidth_xlua_st_(IntPtr L)
	{
		try
		{
			float hudOffsetWidth = AdventureModuleHelper.GetHudOffsetWidth(Lua.lua_toint64(L, 1));
			Lua.lua_pushnumber(L, hudOffsetWidth);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetHudOffsetHeight_xlua_st_(IntPtr L)
	{
		try
		{
			float hudOffsetHeight = AdventureModuleHelper.GetHudOffsetHeight(Lua.lua_toint64(L, 1));
			Lua.lua_pushnumber(L, hudOffsetHeight);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityColliderHeight_xlua_st_(IntPtr L)
	{
		try
		{
			float entityColliderHeight = AdventureModuleHelper.GetEntityColliderHeight(Lua.lua_toint64(L, 1));
			Lua.lua_pushnumber(L, entityColliderHeight);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityMonsterBarHeight_xlua_st_(IntPtr L)
	{
		try
		{
			float entityMonsterBarHeight = AdventureModuleHelper.GetEntityMonsterBarHeight(Lua.lua_toint64(L, 1));
			Lua.lua_pushnumber(L, entityMonsterBarHeight);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetEntityColliderWidth_xlua_st_(IntPtr L)
	{
		try
		{
			float entityColliderWidth = AdventureModuleHelper.GetEntityColliderWidth(Lua.lua_toint64(L, 1));
			Lua.lua_pushnumber(L, entityColliderWidth);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlaySettlementPerform_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string scenePath = Lua.lua_tostring(L, 1);
			string outfitSoundStateName = Lua.lua_tostring(L, 2);
			int[] actorIds = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
			Action<bool> callBack = objectTranslator.GetDelegate<Action<bool>>(L, 4);
			AdventureModuleHelper.PlaySettlementPerform(scenePath, outfitSoundStateName, actorIds, callBack);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayTeamUpgradeFX_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.PlayTeamUpgradeFX();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LeaveAdventure_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.LeaveAdventure();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpawnPrefabInstance_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject prefab = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			string poolName = Lua.lua_tostring(L, 2);
			GameObject parent = (GameObject)objectTranslator.GetObject(L, 3, typeof(GameObject));
			GameObject o = AdventureModuleHelper.SpawnPrefabInstance(prefab, poolName, parent);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DespawnPrefabInstance_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject instance = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string poolName = Lua.lua_tostring(L, 2);
			AdventureModuleHelper.DespawnPrefabInstance(instance, poolName);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PauseLogic_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.PauseLogic();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResumeLogic_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResumeLogic();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ExitSelectTeam_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ExitSelectTeam();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_OpenActiveTeleporter_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.OpenActiveTeleporter();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_OpenTreasureAndNpcNew_xlua_st_(IntPtr L)
	{
		try
		{
			List<int[]> prizeList = (List<int[]>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<int[]>));
			bool showNpc = Lua.lua_toboolean(L, 2);
			AdventureModuleHelper.OpenTreasureAndNpcNew(prizeList, showNpc);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetLevelTeleporters_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<Transform> levelTeleporters = AdventureModuleHelper.GetLevelTeleporters();
			objectTranslator.Push(L, levelTeleporters);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CheckTimelineClipFinish_xlua_st_(IntPtr L)
	{
		try
		{
			PlayableDirector director = (PlayableDirector)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(PlayableDirector));
			string clipName = Lua.lua_tostring(L, 2);
			bool value = AdventureModuleHelper.CheckTimelineClipFinish(director, clipName);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMiniMapFeatureActive_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetMiniMapFeatureActive(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMapCameraActive_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetMapCameraActive(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMiniMapRenderTexture_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RenderTexture miniMapRenderTexture = AdventureModuleHelper.GetMiniMapRenderTexture();
			objectTranslator.Push(L, miniMapRenderTexture);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMapRenderTexture_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			RenderTexture mapRenderTexture = AdventureModuleHelper.GetMapRenderTexture();
			objectTranslator.Push(L, mapRenderTexture);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDirectorState_xlua_st_(IntPtr L)
	{
		try
		{
			string directorPath = Lua.lua_tostring(L, 1);
			bool isPause = Lua.lua_toboolean(L, 2);
			AdventureModuleHelper.SetDirectorState(directorPath, isPause);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PausePerformTimeline_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.PausePerformTimeline();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ResumePerformTimeline_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.ResumePerformTimeline();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopPerformTimeline_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.StopPerformTimeline();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PausePlayableDirector_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.PausePlayableDirector(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopPlayableDirector_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.StopPlayableDirector();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetFirstSlotPlayer_xlua_st_(IntPtr L)
	{
		try
		{
			bool firstSlotPlayer = AdventureModuleHelper.GetFirstSlotPlayer(out var dataId, out var playerId);
			Lua.lua_pushboolean(L, firstSlotPlayer);
			Lua.xlua_pushinteger(L, dataId);
			Lua.lua_pushint64(L, playerId);
			return 3;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSecondSlotPlayer_xlua_st_(IntPtr L)
	{
		try
		{
			bool secondSlotPlayer = AdventureModuleHelper.GetSecondSlotPlayer(out var dataId, out var playerId);
			Lua.lua_pushboolean(L, secondSlotPlayer);
			Lua.xlua_pushinteger(L, dataId);
			Lua.lua_pushint64(L, playerId);
			return 3;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetGuideLogicTimeScale_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetGuideLogicTimeScale(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterViewSceneLevel_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int num = Lua.lua_gettop(L);
			if (num == 9 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 6) && (Lua.lua_isnil(L, 7) || Lua.lua_type(L, 7) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 8) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 9))
			{
				int levelType = Lua.xlua_tointeger(L, 1);
				int id = Lua.xlua_tointeger(L, 2);
				int[] teamIDs = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode = Lua.lua_toboolean(L, 4);
				int starTowerFloorSetID = Lua.xlua_tointeger(L, 5);
				int prefabID = Lua.xlua_tointeger(L, 6);
				string prefabExtension = Lua.lua_tostring(L, 7);
				int playType = Lua.xlua_tointeger(L, 8);
				bool sceneDoMir = Lua.lua_toboolean(L, 9);
				AdventureModuleHelper.EnterViewSceneLevel(levelType, id, teamIDs, isViewSceneMode, starTowerFloorSetID, prefabID, prefabExtension, playType, sceneDoMir);
				return 0;
			}
			if (num == 8 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 6) && (Lua.lua_isnil(L, 7) || Lua.lua_type(L, 7) == LuaTypes.LUA_TSTRING) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 8))
			{
				int levelType2 = Lua.xlua_tointeger(L, 1);
				int id2 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs2 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode2 = Lua.lua_toboolean(L, 4);
				int starTowerFloorSetID2 = Lua.xlua_tointeger(L, 5);
				int prefabID2 = Lua.xlua_tointeger(L, 6);
				string prefabExtension2 = Lua.lua_tostring(L, 7);
				int playType2 = Lua.xlua_tointeger(L, 8);
				AdventureModuleHelper.EnterViewSceneLevel(levelType2, id2, teamIDs2, isViewSceneMode2, starTowerFloorSetID2, prefabID2, prefabExtension2, playType2);
				return 0;
			}
			if (num == 7 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 6) && (Lua.lua_isnil(L, 7) || Lua.lua_type(L, 7) == LuaTypes.LUA_TSTRING))
			{
				int levelType3 = Lua.xlua_tointeger(L, 1);
				int id3 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs3 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode3 = Lua.lua_toboolean(L, 4);
				int starTowerFloorSetID3 = Lua.xlua_tointeger(L, 5);
				int prefabID3 = Lua.xlua_tointeger(L, 6);
				string prefabExtension3 = Lua.lua_tostring(L, 7);
				AdventureModuleHelper.EnterViewSceneLevel(levelType3, id3, teamIDs3, isViewSceneMode3, starTowerFloorSetID3, prefabID3, prefabExtension3);
				return 0;
			}
			if (num == 6 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 6))
			{
				int levelType4 = Lua.xlua_tointeger(L, 1);
				int id4 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs4 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode4 = Lua.lua_toboolean(L, 4);
				int starTowerFloorSetID4 = Lua.xlua_tointeger(L, 5);
				int prefabID4 = Lua.xlua_tointeger(L, 6);
				AdventureModuleHelper.EnterViewSceneLevel(levelType4, id4, teamIDs4, isViewSceneMode4, starTowerFloorSetID4, prefabID4);
				return 0;
			}
			if (num == 5 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5))
			{
				int levelType5 = Lua.xlua_tointeger(L, 1);
				int id5 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs5 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode5 = Lua.lua_toboolean(L, 4);
				int starTowerFloorSetID5 = Lua.xlua_tointeger(L, 5);
				AdventureModuleHelper.EnterViewSceneLevel(levelType5, id5, teamIDs5, isViewSceneMode5, starTowerFloorSetID5);
				return 0;
			}
			if (num == 4 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				int levelType6 = Lua.xlua_tointeger(L, 1);
				int id6 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs6 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				bool isViewSceneMode6 = Lua.lua_toboolean(L, 4);
				AdventureModuleHelper.EnterViewSceneLevel(levelType6, id6, teamIDs6, isViewSceneMode6);
				return 0;
			}
			if (num == 3 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 1) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && objectTranslator.Assignable<int[]>(L, 3))
			{
				int levelType7 = Lua.xlua_tointeger(L, 1);
				int id7 = Lua.xlua_tointeger(L, 2);
				int[] teamIDs7 = (int[])objectTranslator.GetObject(L, 3, typeof(int[]));
				AdventureModuleHelper.EnterViewSceneLevel(levelType7, id7, teamIDs7);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to AdventureModuleHelper.EnterViewSceneLevel!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetBattleSamples_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<AdventureModuleController.BattleSample> battleSamples = AdventureModuleHelper.GetBattleSamples(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, battleSamples);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterStarTowerTestMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out Lua2CSharpInfo_FixedRoguelike v);
			AdventureModuleHelper.EnterStarTowerTestMap(v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterStarTowerMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			int difficulty = Lua.xlua_tointeger(L, 1);
			bool battleEnd = Lua.lua_toboolean(L, 2);
			bool isFinal = Lua.lua_toboolean(L, 3);
			int[] dropInfo = (int[])objectTranslator.GetObject(L, 4, typeof(int[]));
			int nextStageType = Lua.xlua_tointeger(L, 5);
			AdventureModuleHelper.EnterStarTowerMap(difficulty, battleEnd, isFinal, dropInfo, nextStageType);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetDamageRecordId_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetDamageRecordId(Lua.lua_tostring(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RandomStarTowerMap_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslatorPool.Instance.Find(L).Get(L, 1, out Lua2CSharpInfo_FixedRoguelike v);
			int value = AdventureModuleHelper.RandomStarTowerMap(v, out var floorID, out var extension, out var scenePrefabID);
			Lua.xlua_pushinteger(L, value);
			Lua.xlua_pushinteger(L, floorID);
			Lua.lua_pushstring(L, extension);
			Lua.xlua_pushinteger(L, scenePrefabID);
			return 4;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LogStarTowerMap_xlua_st_(IntPtr L)
	{
		try
		{
			int curSavedMapCount = Lua.xlua_tointeger(L, 1);
			int mapType = Lua.xlua_tointeger(L, 2);
			long mapId = Lua.lua_toint64(L, 3);
			bool bEnter = Lua.lua_toboolean(L, 4);
			bool bReenter = Lua.lua_toboolean(L, 5);
			AdventureModuleHelper.LogStarTowerMap(curSavedMapCount, mapType, mapId, bEnter, bReenter);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpawnNPC_xlua_st_(IntPtr L)
	{
		try
		{
			int npcDataID = Lua.xlua_tointeger(L, 1);
			int npcSkinID = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.SpawnNPC(npcDataID, npcSkinID);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetProloguelBattleMsg_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.SetProloguelBattleMsg((List<string>)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(List<string>)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UpdateUIPanlelId_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.UpdateUIPanlelId(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierActorInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorInfo soldierActorInfo = AdventureModuleHelper.GetSoldierActorInfo(Lua.xlua_tointeger(L, 1));
			objectTranslator.Push(L, soldierActorInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierHealthInfo_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			ActorHealthInfo soldierHealthInfo = AdventureModuleHelper.GetSoldierHealthInfo(Lua.xlua_tointeger(L, 1));
			objectTranslator.Push(L, soldierHealthInfo);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_OpenFrameShow_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_OpenFrameShow(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetGameFrame_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetGameFrame(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_JumpoverCurLevel_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_JumpoverCurLevel();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetMonsterSkill_xlua_st_(IntPtr L)
	{
		try
		{
			int monsterID = Lua.xlua_tointeger(L, 1);
			int skillID = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetMonsterSkill(monsterID, skillID);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_ChangeMonsterAIState_xlua_st_(IntPtr L)
	{
		try
		{
			int monsterID = Lua.xlua_tointeger(L, 1);
			bool startOrStop = Lua.lua_toboolean(L, 2);
			AdventureModuleHelper.Lua2CSharp_GMOrder_ChangeMonsterAIState(monsterID, startOrStop);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_MonsterPlaySkill_xlua_st_(IntPtr L)
	{
		try
		{
			int monsterID = Lua.xlua_tointeger(L, 1);
			int skillID = Lua.xlua_tointeger(L, 2);
			int loopTimes = Lua.xlua_tointeger(L, 3);
			AdventureModuleHelper.Lua2CSharp_GMOrder_MonsterPlaySkill(monsterID, skillID, loopTimes);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SpawnMonster_xlua_st_(IntPtr L)
	{
		try
		{
			int monsterID = Lua.xlua_tointeger(L, 1);
			int spawnNum = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.Lua2CSharp_GMOrder_SpawnMonster(monsterID, spawnNum);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetIndicatorMode_xlua_st_(IntPtr L)
	{
		try
		{
			int value = Lua.xlua_tointeger(L, 1);
			int value2 = Lua.xlua_tointeger(L, 2);
			int value3 = Lua.xlua_tointeger(L, 3);
			int value4 = Lua.xlua_tointeger(L, 4);
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetIndicatorMode(value, value2, value3, value4);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_SwichTarget_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_SwichTarget();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetTimeScale_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetTimeScale(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_KillCurChar_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_KillCurChar();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetCurCharResidualHp_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetCurCharResidualHp();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_AddCurCharAttack_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_AddCurCharAttack();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_KillCurMonsters_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_KillCurMonsters();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_KillMonstersByActorId_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_KillMonstersByActorId(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_KillMonstersById_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_KillMonstersById(Lua.xlua_tointeger(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SkipLevel_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_SkipLevel();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_ChangeAllCharDef_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_ChangeAllCharDef(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_UltimateIgnoreCDAndEnergy_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_UltimateIgnoreCDAndEnergy(Lua.lua_toboolean(L, 1));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_SetEntityMoveSpeedPercent_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int moveSpeedPercent = Lua.xlua_tointeger(L, 2);
			AdventureModuleHelper.Lua2CSharp_GMOrder_SetEntityMoveSpeedPercent(entityId, moveSpeedPercent);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_FastCD_xlua_st_(IntPtr L)
	{
		try
		{
			bool active = Lua.lua_toboolean(L, 1);
			long entityId = Lua.lua_toint64(L, 2);
			AdventureModuleHelper.Lua2CSharp_GMOrder_FastCD(active, entityId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_Revive_xlua_st_(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.Lua2CSharp_GMOrder_Revive();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_ChangeAttribute_xlua_st_(IntPtr L)
	{
		try
		{
			long entityId = Lua.lua_toint64(L, 1);
			int firstSubType = Lua.xlua_tointeger(L, 2);
			int secondSubType = Lua.xlua_tointeger(L, 3);
			float value = (float)Lua.lua_tonumber(L, 4);
			AdventureModuleHelper.Lua2CSharp_GMOrder_ChangeAttribute(entityId, firstSubType, secondSubType, value);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_StarTowerConfigExtension_xlua_st_(IntPtr L)
	{
		try
		{
			string str = AdventureModuleHelper.Lua2CSharp_GMOrder_StarTowerConfigExtension();
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_StarTowerGameplayType_xlua_st_(IntPtr L)
	{
		try
		{
			int value = AdventureModuleHelper.Lua2CSharp_GMOrder_StarTowerGameplayType();
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_StarTowerScenePrefabId_xlua_st_(IntPtr L)
	{
		try
		{
			int value = AdventureModuleHelper.Lua2CSharp_GMOrder_StarTowerScenePrefabId();
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Lua2CSharp_GMOrder_StarTowerFloorSetRoomType_xlua_st_(IntPtr L)
	{
		try
		{
			int value = AdventureModuleHelper.Lua2CSharp_GMOrder_StarTowerFloorSetRoomType();
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GMOrder_GetMonsterLevel_xlua_st_(IntPtr L)
	{
		try
		{
			int value = AdventureModuleHelper.GMOrder_GetMonsterLevel(Lua.lua_toint64(L, 1));
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GMOrder_ConvertAttributeTypeAndElementTypeToKey_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out HotfixEnum.effectAttributeType v);
			objectTranslator.Get(L, 2, out HotfixEnum.elementType v2);
			int value = AdventureModuleHelper.GMOrder_ConvertAttributeTypeAndElementTypeToKey(v, v2);
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GMOrder_ConvertAttributeTypeAndDamageTypeToKey_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			objectTranslator.Get(L, 1, out HotfixEnum.effectAttributeType v);
			objectTranslator.Get(L, 2, out HotfixEnum.damageType v2);
			int value = AdventureModuleHelper.GMOrder_ConvertAttributeTypeAndDamageTypeToKey(v, v2);
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GMOrder_GetAttributeValueWithElementOrDamageType_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long entityId = Lua.lua_toint64(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.effectAttributeType v);
			objectTranslator.Get(L, 3, out HotfixEnum.elementType v2);
			objectTranslator.Get(L, 4, out HotfixEnum.damageType v3);
			float num = AdventureModuleHelper.GMOrder_GetAttributeValueWithElementOrDamageType(entityId, v, v2, v3);
			Lua.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_playerUid(IntPtr L)
	{
		try
		{
			Lua.lua_pushint64(L, AdventureModuleHelper.playerUid);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_lastPanelId(IntPtr L)
	{
		try
		{
			Lua.xlua_pushinteger(L, AdventureModuleHelper.lastPanelId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_showHPBar(IntPtr L)
	{
		try
		{
			Lua.lua_pushboolean(L, AdventureModuleHelper.showHPBar);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_showDMGNum(IntPtr L)
	{
		try
		{
			Lua.lua_pushboolean(L, AdventureModuleHelper.showDMGNum);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_showDMG(IntPtr L)
	{
		try
		{
			Lua.lua_pushboolean(L, AdventureModuleHelper.showDMG);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_showEffect(IntPtr L)
	{
		try
		{
			Lua.lua_pushboolean(L, AdventureModuleHelper.showEffect);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_currentPanelid(IntPtr L)
	{
		try
		{
			Lua.xlua_pushinteger(L, AdventureModuleHelper.currentPanelid);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_playerUid(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.playerUid = Lua.lua_toint64(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_lastPanelId(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.lastPanelId = Lua.xlua_tointeger(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_showHPBar(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.showHPBar = Lua.lua_toboolean(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_showDMGNum(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.showDMGNum = Lua.lua_toboolean(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_showDMG(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.showDMG = Lua.lua_toboolean(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_showEffect(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.showEffect = Lua.lua_toboolean(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_currentPanelid(IntPtr L)
	{
		try
		{
			AdventureModuleHelper.currentPanelid = Lua.xlua_tointeger(L, 1);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
