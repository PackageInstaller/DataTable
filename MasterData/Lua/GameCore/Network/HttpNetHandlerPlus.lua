local HttpNetHandlerPlus = {}

function HttpNetHandlerPlus.char_gem_generate_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.char_gem_refresh_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.char_gem_replace_attribute_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.char_gem_update_gem_lock_status_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.char_gem_use_preset_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.char_gem_rename_preset_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.char_gem_equip_gem_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.char_gem_overlock_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.char_gems_import_notify(mapMsgData)
  PlayerData.Equipment:CacheEquipmentDataForChar(mapMsgData)
end

function HttpNetHandlerPlus.char_gems_export_notify(mapMsgData)
  CS.UnityEngine.GUIUtility.systemCopyBuffer = mapMsgData.Value
end

function HttpNetHandlerPlus.char_gem_instance_apply_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.disc_all_limit_break_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.order_paid_notify(mapMsgData)
  PlayerData.Mall:ProcessOrderPaidNotify(mapMsgData)
end

function HttpNetHandlerPlus.order_revoke_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.order_collected_notify(mapMsgData)
  PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.MessageBox, ConfigTable.GetUIText("Order_Collected_Notify"))
end

function HttpNetHandlerPlus.activity_shop_purchase_succeed_ack(mapMsgData)
  if not mapMsgData.IsRefresh then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
end

function HttpNetHandlerPlus.energy_extract_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.gacha_guarantee_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.gacha_reward_get_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.gacha_newbie_obtain_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Item:CacheFragmentsOverflow(nil, mapMsgData)
end

function HttpNetHandlerPlus.gacha_newbie_spin_failed_ack(mapMsgData)
  EventManager.Hit("GachaProcessStart", false)
end

function HttpNetHandlerPlus.gacha_spin_failed_ack(mapMsgData)
  EventManager.Hit("GachaProcessStart", false)
  EventManager.Hit("GachaNeedRefresh")
end

function HttpNetHandlerPlus.gacha_spin_sync_ack(mapMsgData)
  PlayerData.Coin:CacheCoin(mapMsgData.Res)
  PlayerData.Item:CacheItemData(mapMsgData.Items)
end

function HttpNetHandlerPlus.activity_story_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_task_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_task_group_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.player_head_icon_change_notify(mapMsgData)
  PlayerData.Base:ChangePlayerHeadId(mapMsgData.Set)
  PlayerData.HeadData:DelHeadId(mapMsgData.Del)
end

function HttpNetHandlerPlus.activity_mining_enter_layer_notify(mapMsgData)
  EventManager.Hit("Mining_UpdateLevelData", mapMsgData)
end

function HttpNetHandlerPlus.activity_mining_dig_failed_ack(mapMsgData)
  if mapMsgData.Code == 110111 then
    EventManager.Hit("Mining_Error", mapMsgData)
  end
end

function HttpNetHandlerPlus.activity_cookie_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.tutorial_level_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.story_set_info_succeed_ack(mapMsgData)
  PlayerData.StorySet:CacheStorySetData(mapMsgData)
end

function HttpNetHandlerPlus.story_set_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.story_set_state_notify(mapMsgData)
  PlayerData.StorySet:UnlockNewChapter(mapMsgData.Value)
end

function HttpNetHandlerPlus.unlock_activity_story_notify(mapMsgData)
  if mapMsgData == nil or mapMsgData.Stories == nil then
    return
  end
  local nStoryId
  for _, story in pairs(mapMsgData.Stories) do
    if story ~= nil and story.Id ~= nil and story.Id ~= 0 then
      nStoryId = story.Id
      break
    end
  end
  if nStoryId == nil then
    return
  end
  local storyCfg = ConfigTable.GetData("ActivityStory", nStoryId)
  if storyCfg == nil then
    printError("unlock_activity_story_notify story cfg missing:" .. tostring(nStoryId))
    return
  end
  local nChapterId = mapMsgData.ChapterId or storyCfg.ChapterId
  local chapterCfg = CacheTable.GetData("_ActivityStoryChapter", nChapterId)
  if chapterCfg == nil then
    chapterCfg = PlayerData.ActivityAvg:GetActivityChapterConfigByChapterId(nChapterId)
  end
  local nActivityId = chapterCfg and chapterCfg.Id or 0
  if nActivityId == 0 then
    printError("unlock_activity_story_notify activity id missing, chapter:" .. tostring(nChapterId))
    return
  end
  PlayerData.ActivityAvg:CacheAvgData(mapMsgData, nActivityId)
  PlayerData.ActivityAvg:RefreshAvgRedDot()
  PlayerData.StoryReview:CacheAvgData(mapMsgData, nActivityId)
  PlayerData.StoryReview.mapLoadedChapterIds[nChapterId] = true
  EventManager.Hit("Story_Done", false)
end

function HttpNetHandlerPlus.clear_story_set_notify(mapMsgData)
  PlayerData.StorySet:CacheStorySetData(mapMsgData)
end

function HttpNetHandlerPlus.vampire_survivor_new_season_notify(mapMsgData)
  PlayerData.VampireSurvivor:OnNotifyRefresh(mapMsgData.Value)
end

function HttpNetHandlerPlus.vampire_survivor_talent_node_notify(mapData)
  PlayerData.VampireSurvivor:CacheTalentData(mapData)
end

function HttpNetHandlerPlus.battle_pass_common_fail(mapMsgData)
  EventManager.Hit("BattlePassNeedRefresh")
end

function HttpNetHandlerPlus.activity_levels_settle_failed_ack()
  EventManager.Hit("ActivityLevelSettle_Failed")
end

function HttpNetHandlerPlus.joint_drill_game_over_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.joint_drill_sync_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.joint_drill_give_up_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.joint_drill_2_apply_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.joint_drill_2_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.joint_drill_2_game_over_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.joint_drill_2_game_over_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.joint_drill_2_sync_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.joint_drill_2_give_up_failed_ack(mapMsgData)
  if mapMsgData ~= nil and mapMsgData.Code ~= nil and (mapMsgData.Code == 112701 or mapMsgData.Code == 112704 or mapMsgData.Code == 119905) then
    EventManager.Hit("JointDrillChallengeFinishError")
  end
end

function HttpNetHandlerPlus.build_convert_submit_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.build_convert_group_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.star_tower_build_note_modify_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.star_tower_build_potential_modify_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.item_expired_change_notify(mapMsgData)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Item_Change_Expired_Tips"))
end

function HttpNetHandlerPlus.quest_assist_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.quest_assist_group_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.assist_add_build_notify(mapMsgData)
  if mapMsgData.BuildInfo ~= nil then
    if mapMsgData.BuildInfo.Brief ~= nil then
      PlayerData.Build:CacheRogueBuild(mapMsgData.BuildInfo)
    elseif mapMsgData.BuildInfo.BuildCoin ~= nil and mapMsgData.BuildInfo.BuildCoin > 0 then
      local function checkLimitCb()
        local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
        
        local nCur = PlayerData.StarTower:GetStarTowerTicket()
        if nLimit < mapMsgData.BuildInfo.BuildCoin + nCur then
          local sTip = ConfigTable.GetUIText("BUILD_12")
          EventManager.Hit(EventId.OpenMessageBox, sTip)
        end
      end
      
      PlayerData.StarTower:SendTowerGrowthDetailReq(checkLimitCb)
    end
  end
  if mapMsgData.Change ~= nil then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    if mapDecodedChangeInfo["proto.Res"] ~= nil then
      for _, mapCoin in ipairs(mapDecodedChangeInfo["proto.Res"]) do
        if mapCoin.Tid == AllEnum.CoinItemId.FRRewardCurrency then
          PlayerData.StarTower:AddStarTowerTicket(mapCoin.Qty)
        end
      end
    end
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
    UTILS.OpenReceiveByDisplayItem(mapDecodedChangeInfo["proto.Res"], mapMsgData.Change)
  end
end

function HttpNetHandlerPlus.activity_trekker_versus_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.player_destroy_succeed_ack(mapMsgData)
  if mapMsgData.NotifyUrl ~= nil then
    PlayerData.Base:SetDestoryUrl(mapMsgData.NotifyUrl)
  end
end

function HttpNetHandlerPlus.activity_story_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_history_story_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_archive_story_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.milkout_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.milkout_character_unlock_notify(mapMsgData)
  EventManager.Hit("MilkoutCharacterUnlock", mapMsgData)
end

function HttpNetHandlerPlus.daily_mall_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.clear_all_activity_breakout_levels_notify(mapMsgData)
  EventManager.Hit("ClearAllLevels", mapMsgData)
end

function HttpNetHandlerPlus.activity_throw_gift_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_tower_defense_level_settle_failed_ack(mapMsgData)
end

function HttpNetHandlerPlus.activity_penguin_card_level_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_penguin_card_quest_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_gds_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.clear_all_activity_golden_spy_levels_notify(mapMsgData)
  EventManager.Hit("ClearAllGoldenSpyLevels", mapMsgData)
end

function HttpNetHandlerPlus.activity_double_quest_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_double_reward_times_notify(mapMsgData)
  local actData = PlayerData.Activity:GetActivityDataById(mapMsgData.ActivityId)
  if actData ~= nil then
    actData:UpdateDoubleCount(mapMsgData.UseTimes)
    EventManager.Hit("UpdateInstanceDoubleCount")
  end
  local bReengagement = PlayerData.Reengagement:GetActIsOpen()
  if bReengagement then
    PlayerData.Reengagement:UpdateDoubleCount(mapMsgData.ReturneeTimes)
  end
end

function HttpNetHandlerPlus.activity_share_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  UTILS.OpenReceiveByChangeInfo(mapMsgData)
end

function HttpNetHandlerPlus.trace_hunt_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.trace_hunt_settle_failed_ack(mapMsgData)
  PlayerData.TraceHunt:ReceiveTraceHuntSettleFailed()
end

function HttpNetHandlerPlus.trace_hunt_trace_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.trace_hunt_boss_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.trace_hunt_new_control_notify(mapMsgData)
  PlayerData.TraceHunt:SetNewControl(true)
end

function HttpNetHandlerPlus.trace_hunt_state_notify(mapMsgData)
  PlayerData.TraceHunt:UpdateBossRewardRedDot(true)
end

function HttpNetHandlerPlus.trace_hunt_item_change_notify(mapMsgData)
  PlayerData.TraceHunt:ChangeItemNotify(mapMsgData)
end

function HttpNetHandlerPlus.activity_ice_cream_level_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.soldier_interact_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_interact_failed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_apply_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_apply_failed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_give_up_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_give_up_failed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_info_succeed_ack(mapMsgData)
end

function HttpNetHandlerPlus.soldier_info_failed_ack(mapMsgData)
end

function HttpNetHandlerPlus.sd_soldier_info_notify(mapMsgData)
  PlayerData.SoldierData:OnSoldierInfoNotify(mapMsgData)
end

function HttpNetHandlerPlus.sd_soldier_effect_notify(mapMsgData)
  PlayerData.SoldierData:OnSoldierEffectNotify(mapMsgData)
end

function HttpNetHandlerPlus.sd_shop_data_notify(mapMsgData)
  PlayerData.SoldierData:OnShopDataNotify(mapMsgData)
end

function HttpNetHandlerPlus.sd_item_change_notify(mapMsgData)
  PlayerData.SoldierData:OnItemChangeNotify(mapMsgData)
end

function HttpNetHandlerPlus.sd_buff_notify(mapMsgData)
  PlayerData.SoldierData:OnBuffAddNotify(mapMsgData)
end

function HttpNetHandlerPlus.soldier_season_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.score_boss_reset_score_notify()
  PlayerData.ScoreBoss.isGetScInfo = false
  PlayerData.ScoreBoss:GetScoreBossInstanceData(nil)
end

function HttpNetHandlerPlus.dorm_layout_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.dorm_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.dorm_affinity_gift_send_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

function HttpNetHandlerPlus.dorm_room_unlock_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.PlayerDormData:UnlockRoom(mapMsgData.DormRoomId)
  if mapMsgData.DormRoomId == 701001 then
    local tbHonorChange = {
      {NewId = 140001, Level = 0}
    }
    PlayerData.Base:ChangeHonorTitle(tbHonorChange)
  end
  EventManager.Hit("DormNewRoomUnlock", mapMsgData.DormRoomId)
end

function HttpNetHandlerPlus.dorm_role_interaction_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  for _, AffinityInfo in ipairs(mapMsgData.InfoList) do
    PlayerData.Char:ChangeCharAffinityValue(AffinityInfo.AffinityInfo)
  end
end

function HttpNetHandlerPlus.quest_dorm_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.change_info)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.PlayerDormData:UpdateGroup(mapMsgData.TaskGroup)
end

function HttpNetHandlerPlus.dorm_achievement_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.dorm_blocks_convert_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.activity_returnee_state_notify(mapMsgData)
  PlayerData.Reengagement:OnStateNotify(mapMsgData)
end

function HttpNetHandlerPlus.activity_returnee_quest_change_notify(mapMsgData)
  PlayerData.Reengagement:OnQuestChangeNotify(mapMsgData)
end

function HttpNetHandlerPlus.activity_math_parkour_level_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.clear_all_activity_mathParkour_levels_notify(mapMsgData)
  EventManager.Hit("ClearAllMathParkourLevels", mapMsgData)
end

function HttpNetHandlerPlus.activity_malllogin_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

function HttpNetHandlerPlus.activity_mail_bind_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

function HttpNetHandlerPlus.handbook_complete_notify(mapMsgData)
  for _, v in pairs(mapMsgData.Handbook) do
    PlayerData.Handbook:UpdateHandbook(v)
  end
end

return HttpNetHandlerPlus
