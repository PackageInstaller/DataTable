local PB = require("pb")
local TimerManager = require("GameCore.Timer.TimerManager")
local TimerResetType = require("GameCore.Timer.TimerResetType")
local HttpNetHandlerPlus = require("GameCore.Network.HttpNetHandlerPlus")
local HttpNetHandler = {}
local mapProcessFunction
local mapNetMsgIdFailed = {}
local timerPingPong
local PING_PONG_INTERVAL = 120
local TBRELOGIN_CODE = {
  110107,
  10003,
  110106,
  100106
}

local function SetTokenAES(sToken, pubKey, Cipher)
  NovaAPI.TOKEN = sToken
  NovaAPI.SetAeadKey(pubKey, Cipher)
end

local function SetToken(sToken)
  NovaAPI.TOKEN = sToken
end

local function MakeNetMsgIdMap()
  for k, v in pairs(NetMsgId.Id) do
    if string.find(k, "_req") ~= nil then
      local fail = string.gsub(k, "_req", "_failed_ack")
      local nId_fail = NetMsgId.Id[fail]
      if nId_fail ~= nil then
        mapNetMsgIdFailed[v] = nId_fail
      end
    end
  end
end

local function NOTHING_NEED_TO_BE_DONE(mapData)
end

local function ike_succeed_ack(mapData)
  SetTokenAES(mapData.Token, mapData.PubKey, mapData.Cipher)
  NovaAPI.MarkServerTimeStamp(mapData.ServerTs)
end

local function ike_failed_ack(mapData)
  EventManager.Hit("LoginFailed")
end

local function player_login_succeed_ack(mapMsgData)
  SetToken(mapMsgData.Token)
end

local function player_login_failed_ack(mapMsgData)
  EventManager.Hit("LoginFailed")
  NovaAPI.ResetIke()
end

local function player_data_succeed_ack(mapMsgData)
  PopUpManager.InitLoginQueue()
  NovaAPI.MarkServerTimeStamp(mapMsgData.ServerTs)
  PlayerData.Base:CacheAccInfo(mapMsgData.Acc)
  PlayerData.Base:CacheEnergyInfo(mapMsgData.Energy)
  PlayerData.Base:CacheTitleInfo(mapMsgData.Titles)
  PlayerData.Base:CacheHonorTitleInfo(mapMsgData.Honors)
  PlayerData.Base:CacheHonorTitleList(mapMsgData.HonorList)
  PlayerData.Base:CacheHonorTitleListActivity(mapMsgData.ActivityHonors)
  PlayerData.Base:CacheWorldClassInfo(mapMsgData.WorldClass)
  PlayerData.Base:CacheSendGiftCount(mapMsgData.SendGiftCnt)
  PlayerData.Base:CacheRenameTime(mapMsgData.NicknameResetTime)
  PlayerData.Coin:CacheCoin(mapMsgData.Res)
  PlayerData.Char:CacheCharacters(mapMsgData.Chars)
  PlayerData.Team:CacheFormationInfo(mapMsgData.Formation)
  PlayerData.Item:CacheItemData(mapMsgData.Items)
  PlayerData.Activity:CacheActivityData(mapMsgData.Activities)
  PlayerData.State:CacheStateData(mapMsgData.State)
  PlayerData.RogueBoss:CacheRogueBossData(mapMsgData.RegionBossLevels)
  PlayerData.RogueBoss:CacheWeeklyCopiesData(mapMsgData.WeekBossLevels)
  PlayerData.Quest:CacheTeamFormation(mapMsgData.Assists)
  PlayerData.Quest:CacheTourGroupOrder(mapMsgData.TourGuideQuestGroup)
  PlayerData.Quest:CacheAllQuest(mapMsgData.Quests.List)
  PlayerData.Quest:CacheDailyActiveIds(mapMsgData.DailyActiveIds)
  PlayerData.Quest:CacheWeeklyActiveIds(mapMsgData.WeeklyActiveIds)
  PlayerData.Achievement:CacheBattleAchievementData(mapMsgData.Achievements)
  PlayerData.Daily.CacheDailyData(mapMsgData.SigninIndex)
  PlayerData.Handbook:CacheHandbookData(mapMsgData.Handbook)
  PlayerData.Board:CacheBoardData(mapMsgData.Board)
  PlayerData.DailyInstance:CacheDailyInstanceLevel(mapMsgData.DailyInstances)
  PlayerData.Dictionary:CacheDictionaryData(mapMsgData.Dictionaries)
  PlayerData.Phone:CachePhoneMsgCount(mapMsgData.Phone)
  PlayerData.Disc:CacheDiscData(mapMsgData.Discs)
  PlayerData.Disc:CacheBGMDisc(mapMsgData.MusicInfo)
  PlayerData.EquipmentInstance:CacheEquipmentInstanceLevel(mapMsgData.CharGemInstances)
  PlayerData.StarTower:CachePassedId(mapMsgData.RglPassedIds)
  PlayerData.Avg:CacheAvgData(mapMsgData.Story)
  PlayerData.StarTower:CacheStarTowerTicket(mapMsgData.TowerTicket)
  PlayerData.Shop:CacheDailyShopReward(mapMsgData.DailyShopRewardStatus)
  PlayerData.Mall:CacheDailyMallReward(mapMsgData.DailyMallRewardStatus)
  PlayerData.Mall:CacheMallPackageList(mapMsgData.MallPackageList)
  PlayerData.Dating:CacheDatingCharIds(mapMsgData.DatingCharIds)
  PlayerData.VampireSurvivor:CacheLevelData(mapMsgData.VampireSurvivorRecord)
  PlayerData.SkillInstance:CacheSkillInstanceLevel(mapMsgData.SkillInstances)
  PlayerData.TraceHunt:CacheItemInfo(mapMsgData.HuntPermit, mapMsgData.TraceRequest)
  PlayerData.Reengagement:CacheReturneeInfo(mapMsgData.ActivityReturnee)
  NovaAPI.SetRetryCount()
  PlayerData.Base:SetNextRefreshTime(mapMsgData.ServerTs)
  PlayerData.Dispatch.CacheDispatchData(mapMsgData.Agent)
  PlayerData.Activity:CacheActivityGroupData()
  PlayerData.PopUp:RefreshPopUp()
  PlayerData.TutorialData:CacheTutorialData(mapMsgData.TutorialLevels)
  PlayerData.Story:CacheLastStory(mapMsgData.LastRead)
  PlayerData.Avg:CachePersonalityData(mapMsgData.PersonalityModels)
  PlayerData.PlayerDormData:CacheDormHotInfo(mapMsgData.Dorm)
  local bPlayCond = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.ScoreBoss, false)
  if bPlayCond and not PlayerData.ScoreBoss:GetInitInfoState() then
    PlayerData.ScoreBoss:GetScoreBossInstanceData()
  end
  PlayerData.EventReminder:CacheAddStarTowerTicket(mapMsgData.TowerTicketGrowthBonus)
  PlayerData.Char:UpdateAllCharRecordInfoRedDot()
  if CS.SDKManager.Instance:IsSDKInit() then
    CS.SDKManager.Instance:RoleInfoUpload(tostring(PlayerData.Base._nPlayerId), PlayerData.Base._sPlayerNickName, mapMsgData.ServerTs)
  end
  PlayerData.Talent:UpdateAllCharTalentRedDot()
  PlayerData.Quest:RequestGuideMissionInfo()
  PlayerData.Filter:InitSortData()
  EventManager.Hit("Get_Player_Data_Succeed")
end

local function player_board_set_succeed_ack(mapMsgData)
  PlayerData.Board:SetBoardSuccess()
end

local function player_board_set_failed_ack(mapMsgData)
  PlayerData.Board:SetBoardFail()
end

local function player_world_class_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Base:PlayerWorldClassRewardReceiveSuc(mapMsgData)
end

local function player_world_class_advance_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Base:PlayerWorldClassAdvanceSuc(mapMsgData)
end

local function world_class_reward_state_notify(mapMsgData)
  PlayerData.State:CacheWorldClassRewardState(mapMsgData)
end

local function energy_buy_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Base:RefreshEnergyBuyCount(mapMsgData.Count)
end

local function item_use_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function item_product_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function item_quick_growth_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function fragments_convert_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function player_ping_succeed_ack(mapMsgData)
  NovaAPI.MarkServerTimeStamp(mapMsgData.ServerTs)
end

local function story_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function gacha_spin_succeed_ack(mapMsgData)
  local function CheckNew(nTid)
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    
    if mapItemCfgData == nil then
      return false
    end
    if mapItemCfgData.Type == GameEnum.itemType.Char then
      local mapChar = PlayerData.Char:GetCharDataByTid(nTid)
      return mapChar == nil
    elseif mapItemCfgData.Type == GameEnum.itemType.Disc then
      local mapDisc = PlayerData.Disc:GetDiscById(nTid)
      return mapDisc == nil
    else
      return false
    end
  end
  
  local tbItemId = {}
  for _, v in ipairs(mapMsgData.Cards) do
    local bNewHandBood = CheckNew(v.Card.Tid)
    local bNew = bNewHandBood and table.indexof(tbItemId, v.Card.Tid) < 1
    table.insert(tbItemId, v.Card.Tid)
    v.Card.bNew = bNew
  end
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Item:CacheFragmentsOverflow(nil, mapMsgData.Change)
end

local function mail_list_succeed_ack(mapMsgData)
  PlayerData.Mail:CacheMailData(mapMsgData)
end

local function mail_read_succeed_ack(mapMsgData)
  PlayerData.Mail:ReadMail(mapMsgData)
end

local function mail_recv_succeed_ack(mapMsgData)
  local mapDecodeInfo = UTILS.DecodeChangeInfo(mapMsgData.Items)
  HttpNetHandler.ProcChangeInfo(mapDecodeInfo)
end

local function mail_remove_succeed_ack(mapMsgData)
  PlayerData.Mail:RemoveMail(mapMsgData)
end

local function dictionary_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function char_gem_instance_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function char_gem_instance_sweep_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function skill_instance_sweep_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_detail_succeed_ack(mapMsgData)
  PlayerData.Activity:CacheAllActivityData(mapMsgData)
end

local function activity_periodic_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function activity_periodic_final_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function activity_login_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function activity_trial_reward_receive_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function phone_contacts_info_succeed_ack(mapMsgData)
  PlayerData.Phone:CacheAddressBookData(mapMsgData.List)
end

local function phone_contacts_report_succeed_ack(mapMsgData)
  PlayerData.Phone:PhoneContactReportSuc(mapMsgData)
end

local function star_tower_build_delete_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData.Change)
  PlayerData.StarTower:AddStarTowerTicket(mapMsgData.Ticket)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function quest_reward_recv_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function star_tower_build_whether_save_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  PlayerData.StarTower:AddStarTowerTicket(mapMsgData.Ticket)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function star_tower_give_up_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function star_tower_interact_succeed_ack(mapMsgData)
  if mapMsgData.Settle then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Settle.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
end

local function star_tower_apply_failed_ack()
  PlayerData.StarTower:ClearData()
end

local function tower_growth_node_unlock_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function tower_growth_group_node_unlock_succeed_ack(mapMsgData)
  local tbDecodeChange = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(tbDecodeChange)
end

local function quest_tower_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function npc_affinity_plot_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function npc_affinity_plot_reward_receive_failed_ack(mapMsgData)
  EventManager.Hit(EventId.ClosePanel, PanelId.PureAvgStory)
end

local function friend_receive_energy_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function resident_shop_purchase_succeed_ack(mapMsgData)
  if not mapMsgData.IsRefresh then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
end

local function daily_shop_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function char_advance_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function achievement_reward_receive_succeed_ack(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData))
end

local function achievement_change_notify(mapMsgData)
  PlayerData.Achievement:ChangeAchievementData(mapMsgData)
end

local function achievement_state_notify(mapMsgData)
  PlayerData.State:CacheAchievementState(mapMsgData.New)
end

local function monthly_card_rewards_notify(mapMsgData)
  if mapMsgData.Switch then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  PlayerData.Daily.ProcessMonthlyCard(mapMsgData)
end

local function signin_reward_change_notify(mapMsgData)
  if mapMsgData.Switch then
    local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
    HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  end
  PlayerData.Daily.ProcessDailyCheckIn(mapMsgData)
end

local function battle_pass_info_succeed_ack(mapMsgData)
  PlayerData.BattlePass:CacheBattlePassInfo(mapMsgData)
end

local function battle_pass_quest_reward_receive_succeed_ack(mapMsgData)
  PlayerData.BattlePass:OnQuestReceive(mapMsgData)
end

local function battle_pass_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function battle_pass_level_buy_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function battle_pass_order_collect_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.CollectResp.Items)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function mall_order_collect_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Items)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function mall_package_order_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function mall_shop_order_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function gem_convert_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function talent_unlock_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function talent_reset_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function talent_node_reset_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function talent_group_unlock_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function disc_strengthen_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function disc_promote_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function disc_limit_break_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function disc_read_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function mail_state_notify(mapMsgData)
  PlayerData.Mail:UpdateMailList(mapMsgData)
end

local function player_relogin_expire_ban(mapMsgData)
  HttpNetHandler.UnsetPingPong()
end

local function quest_change_notify(mapMsgData)
  PlayerData.Quest:OnQuestProgressChanged(mapMsgData)
  PlayerData.Quest:UpdateQuestRedDot(mapMsgData.Type)
end

local function chars_final_notify(mapMsgData)
  PlayerData.Char:CacheCharacters(mapMsgData.List)
end

local function character_skin_gain_notify(mapMsgData)
  PlayerData.CharSkin:SkinGainEnqueue(mapMsgData)
end

local function character_skin_change_notify(mapMsgData)
  PlayerData.Char:SetCharSkinId(mapMsgData.CharId, mapMsgData.SkinId)
end

local function world_class_change_notify(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData.Change))
end

local function world_class_number_notify(mapMsgData)
  PlayerData.State:CacheWorldClassRewardStateInBoard(mapMsgData.RewardsFlag)
  PlayerData.Base:ChangeWorldClassInBoard(mapMsgData)
end

local function world_class_quest_complete_notify(mapMsgData)
  for _, v in pairs(mapMsgData.List) do
    PlayerData.Quest:OnQuestProgressChanged(v)
    PlayerData.Quest:UpdateQuestRedDot(v.Type)
  end
end

local function char_reset_notify(mapMsgData)
  PlayerData.Char:CacheCharacters({mapMsgData})
end

local function char_change_notify(mapMsgData)
  PlayerData.Char:CacheCharacters({mapMsgData})
end

local function char_advance_reward_state_notify(mapMsgData)
  PlayerData.State:CacheCharactersAdRewards_Notify(mapMsgData)
end

local function items_change_notify(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData))
end

local function friend_state_notify(mapMsgData)
  PlayerData.Friend:UpdateFriendState(mapMsgData)
end

local function friend_energy_state_notify(mapMsgData)
  PlayerData.Friend:UpdateFriendEnergy(mapMsgData)
end

local function boss_level_final_notify(mapMsgData)
  PlayerData.RogueBoss:CacheRogueBossData({mapMsgData})
end

local function region_boss_level_apply_succeed_ack(mapMsgData)
  PlayerData.RogueBoss:EnterRegionBoss(mapMsgData)
end

local function region_boss_level_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.RogueBoss:RegionBossLevelSettleSuccess(mapMsgData)
end

local function region_boss_level_sweep_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function skill_instance_apply_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function week_boss_apply_succeed_ack(mapMsgData)
  print("week succeed")
  PlayerData.RogueBoss:EnterWeekBoss(mapMsgData)
end

local function week_boss_apply_failed_ack(mapMsgData)
  print("week failed")
end

local function week_boss_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.RogueBoss:WeeklyCopiesLevelSettleReqSuccess(mapMsgData)
end

local function week_boss_settle_failed_ack(mapMsgData)
  print("week settle failed")
end

local function week_boss_refresh_ticket_notify(mapMsgData)
  print("week settle reset")
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function handbook_change_notify(mapMsgData)
  PlayerData.Handbook:UpdateHandbookData(mapMsgData)
end

local function char_up_change_notify(mapMsgData)
  for _, v in pairs(mapMsgData.Handbook) do
    PlayerData.Handbook:UpdateHandbookData(v)
  end
  PlayerData.Char:CacheCharacters({
    mapMsgData.Char
  })
end

local function daily_instance_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function daily_instance_raid_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function mall_package_state_notify(mapMsgData)
  RedDotManager.SetValid(RedDotDefine.Mall_Free, nil, mapMsgData.New)
  EventManager.Hit("Mall_Refresh_Reddot")
end

local function quest_state_notify(mapMessageData)
  PlayerData.Quest:UpdateServerQuestRedDot(mapMessageData)
end

local function dictionary_change_notify(mapMsgData)
  PlayerData.Dictionary:ChangeDictionaryData(mapMsgData)
end

local function clear_all_traveler_due_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.TravelerDuel:CacheTravelerDuelLevelData(mapMsgData)
end

local function clear_all_region_boss_level_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.RogueBoss:CacheRogueBossData(mapMsgData.RegionBossLevels)
end

local function clear_all_week_boss_notify(mapMsgData)
  PlayerData.RogueBoss:CacheWeeklyCopiesData(mapMsgData.WeekBossLevels)
end

local function st_clear_all_star_tower_notify(mapMsgData)
  PlayerData.StarTower:CachePassedId(mapMsgData.Ids)
end

local function clear_all_daily_instance_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.DailyInstance:CacheDailyInstanceLevel(mapMsgData.DailyInstances)
end

local function clear_all_char_gem_instance_notify(mapMsgData)
  PlayerData.EquipmentInstance:CacheEquipmentInstanceLevel(mapMsgData.CharGemInstances)
end

local function st_import_build_notify(mapMsgData)
  PlayerData.Build:CacheRogueBuild(mapMsgData)
end

local function st_export_build_notify(mapMsgData)
  CS.UnityEngine.GUIUtility.systemCopyBuffer = mapMsgData.Value
end

local function char_affinity_final_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

local function char_affinity_reward_state_notify(mapMsgData)
end

local function activity_change_notify(mapMsgData)
  PlayerData.Activity:RefreshActivityData(mapMsgData)
end

local function activity_state_change_notify(mapMsgData)
  PlayerData.Activity:RefreshActivityStateData(mapMsgData)
end

local function activity_quest_change_notify(mapMsgData)
  PlayerData.Activity:RefreshSingleQuest(mapMsgData)
end

local function mail_overflow_notify(mapMsgData)
  PlayerData.State:SetMailOverflow(true)
end

local function infinity_tower_rewards_state_notify(mapMsgData)
  PlayerData.InfinityTower:InfinityTowerRewardsStateNotify(mapMsgData)
end

local function phone_chat_change_notify(mapMsgData)
  PlayerData.Phone:NewChatTrigger(mapMsgData)
end

local function character_fragments_overflow_change_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Item:CacheFragmentsOverflow(mapMsgData)
end

local function infinity_tower_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function infinity_tower_daily_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function infinity_tower_plot_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function disc_reset_notify(mapMsgData)
  PlayerData.Disc:UpdateDiscData(mapMsgData.Id, mapMsgData)
end

local function story_complete_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Avg:CacheAvgData(mapMsgData)
end

local function clear_all_story_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Avg:CacheAvgData(mapMsgData)
end

local function activity_login_rewards_notify(mapMsgData)
  PlayerData.Activity:CacheLoginRewardActData(mapMsgData.ActivityId, mapMsgData)
end

local function activity_malllogin_rewards_notify(mapMsgData)
  PlayerData.Activity:CacheMallLoginActData(mapMsgData.ActivityId, mapMsgData)
end

local function star_tower_book_potential_notify(mapMsgData)
  PlayerData.StarTowerBook:CharPotentialBookChange(mapMsgData)
end

local function star_tower_book_event_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function tower_book_fate_card_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function star_tower_book_potential_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function star_tower_book_event_notify(mapMsgData)
end

local function tower_book_fate_card_collect_notify(mapMsgData)
  PlayerData.StarTowerBook:FateCardBookChange(mapMsgData)
  PlayerData.VampireSurvivor:AddTalentPoint(mapMsgData.Cards)
end

local function tower_book_fate_card_reward_notify(mapMsgData)
  PlayerData.StarTowerBook:FateCardBookRewardChange(mapMsgData)
end

local function region_boss_level_challenge_ticket_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  EventManager.Hit("region_boss_ticket_notify", AllEnum.CoinItemId.RogueHardCoreTick)
end

local function honor_change_notify(mapMsgData)
  PlayerData.Base:CacheHonorTitleInfo(mapMsgData.Honors)
  EventManager.Hit("HonorTitle_Change")
end

local function tower_growth_node_change_notify(mapMsgData)
  PlayerData.StarTower:ParseGrowthData(mapMsgData.Detail)
  PlayerData.StarTower:UpdateGrowthReddot()
end

local function add_vampire_season_score_notify(mapMsgData)
  PlayerData.VampireSurvivor:CacheScore(mapMsgData.Value)
end

local function clear_all_vampire_survivor_notify(mapMsgData)
  PlayerData.VampireSurvivor:CachePassedId(mapMsgData.Ids)
end

local function star_tower_sub_note_skill_info_notify(mapMsgData)
  local sTip = "音符掉落查询：\n"
  
  local function printTableHelper(t, indent)
    indent = indent or 0
    for k, v in pairs(t) do
      local formatting = string.rep(" ", indent) .. tostring(k) .. ": "
      if type(v) == "table" then
        sTip = sTip .. formatting .. "\n"
        printTableHelper(v, indent + 4)
      else
        sTip = sTip .. formatting .. tostring(v) .. "\n"
      end
    end
  end
  
  printTableHelper(mapMsgData.SubNoteSkillInfo, 0)
  print(sTip)
end

local function refresh_agent_notify(mapMsgData)
  PlayerData.Dispatch.RefreshAgentInfos(mapMsgData)
end

local function clear_all_skill_instance_notify(mapMsgData)
  PlayerData.SkillInstance:CacheSkillInstanceLevel(mapMsgData.SkillInstances)
end

local function st_skip_floor_notify(mapMsgData)
  EventManager.Hit("st_skip_floor_notify", mapMsgData)
end

local function st_add_team_exp_notify(mapMsgData)
  EventManager.Hit("st_add_team_exp_notify", mapMsgData)
end

local function st_add_new_case_notify(mapMsgData)
  EventManager.Hit("st_add_new_case_notify", mapMsgData)
end

local function st_items_change_notify(mapMsgData)
  EventManager.Hit("items_change_notify", mapMsgData)
end

local function tower_change_sub_note_skill_notify(mapMsgData)
  EventManager.Hit("note_change_notify", mapMsgData)
end

local function change_npc_affinity_notify(mapMsgData)
  PlayerData.StarTower:ChangeNpcAffinity(mapMsgData)
end

local function traveler_duel_rank_succeed_ack(msgData)
  PlayerData.TravelerDuel:CacheTravelerDuelRankingData(msgData)
end

local function traveler_duel_info_failed_ack()
  EventManager.Hit(EventId.SetTransition)
end

local function vampire_talent_reset_succeed_ack(msgData)
  PlayerData.VampireSurvivor:ResetTalentPoint()
end

local function vampire_talent_unlock_succeed_ack(msgData)
end

local function vampire_talent_detail_failed_ack()
  EventManager.Hit("GetTalentDataVampire", false)
end

local function vampire_survivor_reward_chest_failed_ack()
  EventManager.Hit("VampireRewardChestFailed")
end

local function vampire_survivor_reward_select_failed_ack()
  EventManager.Hit("VampireLevelRewardFailed")
end

local function vampire_survivor_quest_reward_receive_succeed_ack(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData))
end

local function char_affinity_quest_reward_receive_succeed_ack(mapMsgData)
  if mapMsgData.Info ~= nil and mapMsgData.Info.Rewards ~= nil then
    local data
    for _, v in pairs(mapMsgData.Info.Rewards) do
      if data == nil then
        data = {}
      end
      table.insert(data, {
        NewId = v.Tid
      })
    end
    PlayerData.Base:ChangeHonorTitle(data)
  end
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

local function char_affinity_gift_send_succeed_ack(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData.Change))
  PlayerData.Base:RefreshSendGiftCount(mapMsgData.SendGiftCnt)
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

local function char_recruitment_succeed_ack(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData))
end

local function agent_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function agent_new_notify(mapMsgData)
  PlayerData.Dispatch.RefreshWeeklyDispatchs(mapMsgData.Ids)
end

local function agent_apply_failed_ack(mapMsgData)
  PlayerData.Dispatch.ResetReqLock()
end

local function char_dating_landmark_select_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

local function char_dating_event_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function char_dating_gift_send_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Char:ChangeCharAffinityValue(mapMsgData.Info)
end

local function char_archive_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_mining_daily_reward_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  EventManager.Hit("Mining_Daily_Reward", mapMsgData)
end

local function activity_mining_supplement_reward_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  EventManager.Hit("Mining_Supplement_Reward", mapMsgData)
end

local function activity_mining_quest_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_mining_story_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_mining_dig_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.ChangeInfo)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  EventManager.Hit("Mining_UpdateRigResult", mapMsgData)
end

local function activity_mining_energy_convert_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function score_boss_star_reward_receive_succeed_ack(mapMsgData)
  HttpNetHandler.ProcChangeInfo(UTILS.DecodeChangeInfo(mapMsgData))
end

local function redeem_code_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function notice_change_notify(mapMsgData)
  EventManager.Hit("NoticeChangeNotify", mapMsgData)
end

local function joint_drill_apply_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function joint_drill_sweep_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function joint_drill_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function joint_drill_game_over_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData.Change)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function joint_drill_quest_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_joint_drill_refresh_ticket_notify(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_tower_defense_story_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_tower_defense_quest_reward_receive_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function activity_tower_defense_level_settle_succeed_ack(mapMsgData)
  local mapDecodedChangeInfo = UTILS.DecodeChangeInfo(mapMsgData)
  HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
end

local function force_update_notify(mapMsgData)
  local clientVer = NovaAPI.GetResVersion()
  local serVer = tostring(mapMsgData.Value)
  if UTILS.VersionCompare(clientVer, serVer, 1) == -1 then
    PlayerData.Base:NeedHotfix()
  end
end

local function BindProcessFunction()
  mapProcessFunction = {
    [NetMsgId.Id.ike_succeed_ack] = ike_succeed_ack,
    [NetMsgId.Id.ike_failed_ack] = ike_failed_ack,
    [NetMsgId.Id.player_login_succeed_ack] = player_login_succeed_ack,
    [NetMsgId.Id.player_login_failed_ack] = player_login_failed_ack,
    [NetMsgId.Id.player_data_succeed_ack] = player_data_succeed_ack,
    [NetMsgId.Id.player_data_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_reg_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_name_edit_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_name_edit_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_head_icon_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_head_icon_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_board_set_succeed_ack] = player_board_set_succeed_ack,
    [NetMsgId.Id.player_board_set_failed_ack] = player_board_set_failed_ack,
    [NetMsgId.Id.player_skin_show_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_skin_show_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_chars_show_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_chars_show_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_signature_edit_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_signature_edit_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_world_class_reward_receive_succeed_ack] = player_world_class_reward_receive_succeed_ack,
    [NetMsgId.Id.player_world_class_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_world_class_advance_succeed_ack] = player_world_class_advance_succeed_ack,
    [NetMsgId.Id.player_world_class_advance_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_music_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_music_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_destroy_succeed_ack] = HttpNetHandlerPlus.player_destroy_succeed_ack,
    [NetMsgId.Id.player_destroy_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_apply_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_settle_succeed_ack] = story_settle_succeed_ack,
    [NetMsgId.Id.story_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_gender_edit_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_gender_edit_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.energy_buy_succeed_ack] = energy_buy_succeed_ack,
    [NetMsgId.Id.energy_buy_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.energy_extract_succeed_ack] = HttpNetHandlerPlus.energy_extract_succeed_ack,
    [NetMsgId.Id.energy_extract_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.item_use_succeed_ack] = item_use_succeed_ack,
    [NetMsgId.Id.item_use_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.item_product_succeed_ack] = item_product_succeed_ack,
    [NetMsgId.Id.item_product_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.item_quick_growth_succeed_ack] = item_quick_growth_succeed_ack,
    [NetMsgId.Id.item_quick_growth_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.fragments_convert_succeed_ack] = fragments_convert_succeed_ack,
    [NetMsgId.Id.fragments_convert_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_ping_succeed_ack] = player_ping_succeed_ack,
    [NetMsgId.Id.traveler_duel_rank_succeed_ack] = traveler_duel_rank_succeed_ack,
    [NetMsgId.Id.traveler_duel_info_failed_ack] = traveler_duel_info_failed_ack,
    [NetMsgId.Id.traveler_duel_info_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_formation_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_formation_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_advance_reward_receive_succeed_ack] = char_advance_reward_receive_succeed_ack,
    [NetMsgId.Id.char_skin_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_skin_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_favorite_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_favorite_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_spin_succeed_ack] = gacha_spin_succeed_ack,
    [NetMsgId.Id.gacha_spin_failed_ack] = HttpNetHandlerPlus.gacha_spin_failed_ack,
    [NetMsgId.Id.gacha_spin_sync_ack] = HttpNetHandlerPlus.gacha_spin_sync_ack,
    [NetMsgId.Id.gacha_information_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_information_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_guarantee_reward_receive_succeed_ack] = HttpNetHandlerPlus.gacha_guarantee_reward_receive_succeed_ack,
    [NetMsgId.Id.gacha_guarantee_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_info_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_info_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_spin_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_spin_failed_ack] = HttpNetHandlerPlus.gacha_newbie_spin_failed_ack,
    [NetMsgId.Id.gacha_newbie_obtain_succeed_ack] = HttpNetHandlerPlus.gacha_newbie_obtain_succeed_ack,
    [NetMsgId.Id.gacha_newbie_obtain_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_save_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_newbie_save_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gacha_reward_get_succeed_ack] = HttpNetHandlerPlus.gacha_reward_get_succeed_ack,
    [NetMsgId.Id.gacha_reward_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mail_list_succeed_ack] = mail_list_succeed_ack,
    [NetMsgId.Id.mail_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mail_read_succeed_ack] = mail_read_succeed_ack,
    [NetMsgId.Id.mail_read_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mail_recv_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mail_remove_succeed_ack] = mail_remove_succeed_ack,
    [NetMsgId.Id.mail_remove_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_gem_generate_succeed_ack] = HttpNetHandlerPlus.char_gem_generate_succeed_ack,
    [NetMsgId.Id.char_gem_refresh_succeed_ack] = HttpNetHandlerPlus.char_gem_refresh_succeed_ack,
    [NetMsgId.Id.char_gem_replace_attribute_succeed_ack] = HttpNetHandlerPlus.char_gem_replace_attribute_succeed_ack,
    [NetMsgId.Id.char_gem_update_gem_lock_status_succeed_ack] = HttpNetHandlerPlus.char_gem_update_gem_lock_status_succeed_ack,
    [NetMsgId.Id.char_gem_use_preset_succeed_ack] = HttpNetHandlerPlus.char_gem_use_preset_succeed_ack,
    [NetMsgId.Id.char_gem_rename_preset_succeed_ack] = HttpNetHandlerPlus.char_gem_rename_preset_succeed_ack,
    [NetMsgId.Id.char_gem_equip_gem_succeed_ack] = HttpNetHandlerPlus.char_gem_equip_gem_succeed_ack,
    [NetMsgId.Id.char_gem_overlock_succeed_ack] = HttpNetHandlerPlus.char_gem_overlock_succeed_ack,
    [NetMsgId.Id.char_gems_import_notify] = HttpNetHandlerPlus.char_gems_import_notify,
    [NetMsgId.Id.char_gems_export_notify] = HttpNetHandlerPlus.char_gems_export_notify,
    [NetMsgId.Id.star_tower_build_brief_list_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_brief_list_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_detail_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_detail_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_delete_succeed_ack] = star_tower_build_delete_succeed_ack,
    [NetMsgId.Id.star_tower_build_delete_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_name_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_name_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_lock_unlock_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_lock_unlock_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_preference_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_preference_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_whether_save_succeed_ack] = star_tower_build_whether_save_succeed_ack,
    [NetMsgId.Id.star_tower_build_whether_save_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_note_modify_succeed_ack] = HttpNetHandlerPlus.star_tower_build_note_modify_succeed_ack,
    [NetMsgId.Id.star_tower_build_note_modify_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_build_potential_modify_succeed_ack] = HttpNetHandlerPlus.star_tower_build_potential_modify_succeed_ack,
    [NetMsgId.Id.star_tower_build_potential_modify_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_give_up_succeed_ack] = star_tower_give_up_succeed_ack,
    [NetMsgId.Id.star_tower_give_up_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_interact_succeed_ack] = star_tower_interact_succeed_ack,
    [NetMsgId.Id.star_tower_interact_failed_ack] = function(mapError)
      EventManager.Hit("StarTowerSettingRequestFailed", mapError)
    end,
    [NetMsgId.Id.star_tower_apply_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.star_tower_apply_failed_ack] = star_tower_apply_failed_ack,
    [NetMsgId.Id.tower_growth_detail_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_growth_detail_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_growth_node_unlock_succeed_ack] = tower_growth_node_unlock_succeed_ack,
    [NetMsgId.Id.tower_growth_node_unlock_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_growth_group_node_unlock_succeed_ack] = tower_growth_group_node_unlock_succeed_ack,
    [NetMsgId.Id.tower_growth_group_node_unlock_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_update_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_update_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_name_update_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tower_vita_project_name_update_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.quest_tower_reward_receive_succeed_ack] = quest_tower_reward_receive_succeed_ack,
    [NetMsgId.Id.quest_tower_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.quest_assist_reward_receive_succeed_ack] = HttpNetHandlerPlus.quest_assist_reward_receive_succeed_ack,
    [NetMsgId.Id.quest_assist_group_reward_receive_succeed_ack] = HttpNetHandlerPlus.quest_assist_group_reward_receive_succeed_ack,
    [NetMsgId.Id.quest_assist_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.quest_assist_group_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.npc_affinity_plot_reward_receive_succeed_ack] = npc_affinity_plot_reward_receive_succeed_ack,
    [NetMsgId.Id.npc_affinity_plot_reward_receive_failed_ack] = npc_affinity_plot_reward_receive_failed_ack,
    [NetMsgId.Id.friend_list_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_list_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_uid_search_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_uid_search_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_name_search_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_name_search_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_add_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_add_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_add_agree_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_add_agree_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_all_agree_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_all_agree_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_delete_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_delete_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_invites_delete_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_invites_delete_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_receive_energy_succeed_ack] = friend_receive_energy_succeed_ack,
    [NetMsgId.Id.friend_receive_energy_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_send_energy_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_send_energy_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_star_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_star_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_recommendation_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_recommendation_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.achievement_reward_receive_succeed_ack] = achievement_reward_receive_succeed_ack,
    [NetMsgId.Id.achievement_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.achievement_info_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.achievement_info_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.resident_shop_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.resident_shop_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.resident_shop_purchase_succeed_ack] = resident_shop_purchase_succeed_ack,
    [NetMsgId.Id.resident_shop_purchase_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.daily_shop_reward_receive_succeed_ack] = daily_shop_reward_receive_succeed_ack,
    [NetMsgId.Id.daily_shop_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_gem_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_gem_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_gem_order_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_gem_order_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_order_cancel_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_order_cancel_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_order_collect_succeed_ack] = mall_order_collect_succeed_ack,
    [NetMsgId.Id.mall_order_collect_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_monthlyCard_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_monthlyCard_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_monthlyCard_order_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_monthlyCard_order_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_package_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_package_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_package_order_succeed_ack] = mall_package_order_succeed_ack,
    [NetMsgId.Id.mall_package_order_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_shop_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_shop_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mall_shop_order_succeed_ack] = mall_shop_order_succeed_ack,
    [NetMsgId.Id.mall_shop_order_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.gem_convert_succeed_ack] = gem_convert_succeed_ack,
    [NetMsgId.Id.gem_convert_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_blocks_convert_succeed_ack] = HttpNetHandlerPlus.dorm_blocks_convert_succeed_ack,
    [NetMsgId.Id.daily_instance_settle_succeed_ack] = daily_instance_settle_succeed_ack,
    [NetMsgId.Id.daily_instance_raid_succeed_ack] = daily_instance_raid_succeed_ack,
    [NetMsgId.Id.daily_instance_raid_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dictionary_reward_receive_succeed_ack] = dictionary_reward_receive_succeed_ack,
    [NetMsgId.Id.dictionary_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_gem_instance_settle_succeed_ack] = char_gem_instance_settle_succeed_ack,
    [NetMsgId.Id.char_gem_instance_sweep_succeed_ack] = char_gem_instance_sweep_succeed_ack,
    [NetMsgId.Id.char_gem_instance_apply_succeed_ack] = HttpNetHandlerPlus.char_gem_instance_apply_succeed_ack,
    [NetMsgId.Id.skill_instance_sweep_succeed_ack] = skill_instance_sweep_succeed_ack,
    [NetMsgId.Id.skill_instance_sweep_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_detail_succeed_ack] = activity_detail_succeed_ack,
    [NetMsgId.Id.activity_detail_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_periodic_reward_receive_succeed_ack] = activity_periodic_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_periodic_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_periodic_final_reward_receive_succeed_ack] = activity_periodic_final_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_periodic_final_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_login_reward_receive_succeed_ack] = activity_login_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_login_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_malllogin_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_malllogin_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_trial_reward_receive_succeed_ack] = activity_trial_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_shop_purchase_succeed_ack] = HttpNetHandlerPlus.activity_shop_purchase_succeed_ack,
    [NetMsgId.Id.phone_contacts_info_succeed_ack] = phone_contacts_info_succeed_ack,
    [NetMsgId.Id.phone_contacts_info_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.phone_contacts_report_succeed_ack] = phone_contacts_report_succeed_ack,
    [NetMsgId.Id.phone_contacts_report_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.battle_pass_info_succeed_ack] = battle_pass_info_succeed_ack,
    [NetMsgId.Id.battle_pass_info_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.battle_pass_quest_reward_receive_succeed_ack] = battle_pass_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.battle_pass_quest_reward_receive_failed_ack] = HttpNetHandlerPlus.battle_pass_common_fail,
    [NetMsgId.Id.battle_pass_reward_receive_succeed_ack] = battle_pass_reward_receive_succeed_ack,
    [NetMsgId.Id.battle_pass_reward_receive_failed_ack] = HttpNetHandlerPlus.battle_pass_common_fail,
    [NetMsgId.Id.battle_pass_level_buy_succeed_ack] = battle_pass_level_buy_succeed_ack,
    [NetMsgId.Id.battle_pass_level_buy_failed_ack] = HttpNetHandlerPlus.battle_pass_common_fail,
    [NetMsgId.Id.battle_pass_order_collect_succeed_ack] = battle_pass_order_collect_succeed_ack,
    [NetMsgId.Id.battle_pass_order_collect_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.sudo_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.sudo_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_unlock_succeed_ack] = talent_unlock_succeed_ack,
    [NetMsgId.Id.talent_unlock_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_reset_succeed_ack] = talent_reset_succeed_ack,
    [NetMsgId.Id.talent_reset_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_node_reset_succeed_ack] = talent_node_reset_succeed_ack,
    [NetMsgId.Id.talent_node_reset_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_background_set_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_background_set_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.talent_group_unlock_succeed_ack] = talent_group_unlock_succeed_ack,
    [NetMsgId.Id.talent_group_unlock_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.disc_strengthen_succeed_ack] = disc_strengthen_succeed_ack,
    [NetMsgId.Id.disc_strengthen_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.disc_promote_succeed_ack] = disc_promote_succeed_ack,
    [NetMsgId.Id.disc_promote_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.disc_limit_break_succeed_ack] = disc_limit_break_succeed_ack,
    [NetMsgId.Id.disc_limit_break_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.disc_all_limit_break_succeed_ack] = HttpNetHandlerPlus.disc_all_limit_break_succeed_ack,
    [NetMsgId.Id.disc_all_limit_break_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.disc_read_reward_receive_succeed_ack] = disc_read_reward_receive_succeed_ack,
    [NetMsgId.Id.disc_read_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_set_info_succeed_ack] = HttpNetHandlerPlus.story_set_info_succeed_ack,
    [NetMsgId.Id.story_set_info_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_set_reward_receive_succeed_ack] = HttpNetHandlerPlus.story_set_reward_receive_succeed_ack,
    [NetMsgId.Id.story_set_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.story_set_state_notify] = HttpNetHandlerPlus.story_set_state_notify,
    [NetMsgId.Id.vampire_survivor_area_change_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.vampire_survivor_settle_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.vampire_talent_unlock_succeed_ack] = vampire_talent_unlock_succeed_ack,
    [NetMsgId.Id.vampire_talent_reset_succeed_ack] = vampire_talent_reset_succeed_ack,
    [NetMsgId.Id.system_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.vampire_survivor_reward_chest_failed_ack] = vampire_survivor_reward_chest_failed_ack,
    [NetMsgId.Id.vampire_talent_detail_failed_ack] = vampire_talent_detail_failed_ack,
    [NetMsgId.Id.vampire_survivor_reward_select_failed_ack] = vampire_survivor_reward_select_failed_ack,
    [NetMsgId.Id.vampire_survivor_quest_reward_receive_succeed_ack] = vampire_survivor_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.player_new_notify] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.mail_state_notify] = mail_state_notify,
    [NetMsgId.Id.player_relogin_notify] = player_relogin_expire_ban,
    [NetMsgId.Id.token_expire_notify] = player_relogin_expire_ban,
    [NetMsgId.Id.player_ban_notify] = player_relogin_expire_ban,
    [NetMsgId.Id.quest_change_notify] = quest_change_notify,
    [NetMsgId.Id.chars_final_notify] = chars_final_notify,
    [NetMsgId.Id.character_skin_gain_notify] = character_skin_gain_notify,
    [NetMsgId.Id.character_skin_change_notify] = character_skin_change_notify,
    [NetMsgId.Id.world_class_number_notify] = world_class_number_notify,
    [NetMsgId.Id.world_class_quest_complete_notify] = world_class_quest_complete_notify,
    [NetMsgId.Id.world_class_change_notify] = world_class_change_notify,
    [NetMsgId.Id.char_reset_notify] = char_reset_notify,
    [NetMsgId.Id.items_change_notify] = items_change_notify,
    [NetMsgId.Id.region_boss_level_final_notify] = boss_level_final_notify,
    [NetMsgId.Id.friend_state_notify] = friend_state_notify,
    [NetMsgId.Id.friend_energy_state_notify] = friend_energy_state_notify,
    [NetMsgId.Id.char_change_notify] = char_change_notify,
    [NetMsgId.Id.world_class_reward_state_notify] = world_class_reward_state_notify,
    [NetMsgId.Id.char_advance_reward_state_notify] = char_advance_reward_state_notify,
    [NetMsgId.Id.achievement_change_notify] = achievement_change_notify,
    [NetMsgId.Id.achievement_state_notify] = achievement_state_notify,
    [NetMsgId.Id.monthly_card_rewards_notify] = monthly_card_rewards_notify,
    [NetMsgId.Id.signin_reward_change_notify] = signin_reward_change_notify,
    [NetMsgId.Id.handbook_change_notify] = handbook_change_notify,
    [NetMsgId.Id.mall_package_state_notify] = mall_package_state_notify,
    [NetMsgId.Id.quest_state_notify] = quest_state_notify,
    [NetMsgId.Id.dictionary_change_notify] = dictionary_change_notify,
    [NetMsgId.Id.clear_all_traveler_due_notify] = clear_all_traveler_due_notify,
    [NetMsgId.Id.clear_all_region_boss_level_notify] = clear_all_region_boss_level_notify,
    [NetMsgId.Id.clear_all_week_boss_notify] = clear_all_week_boss_notify,
    [NetMsgId.Id.st_clear_all_star_tower_notify] = st_clear_all_star_tower_notify,
    [NetMsgId.Id.clear_all_daily_instance_notify] = clear_all_daily_instance_notify,
    [NetMsgId.Id.clear_all_char_gem_instance_notify] = clear_all_char_gem_instance_notify,
    [NetMsgId.Id.st_import_build_notify] = st_import_build_notify,
    [NetMsgId.Id.st_export_build_notify] = st_export_build_notify,
    [NetMsgId.Id.char_affinity_final_notify] = char_affinity_final_notify,
    [NetMsgId.Id.char_affinity_reward_state_notify] = char_affinity_reward_state_notify,
    [NetMsgId.Id.activity_change_notify] = activity_change_notify,
    [NetMsgId.Id.activity_state_change_notify] = activity_state_change_notify,
    [NetMsgId.Id.activity_quest_change_notify] = activity_quest_change_notify,
    [NetMsgId.Id.mail_overflow_notify] = mail_overflow_notify,
    [NetMsgId.Id.infinity_tower_rewards_state_notify] = infinity_tower_rewards_state_notify,
    [NetMsgId.Id.phone_chat_change_notify] = phone_chat_change_notify,
    [NetMsgId.Id.character_fragments_overflow_change_notify] = character_fragments_overflow_change_notify,
    [NetMsgId.Id.infinity_tower_settle_succeed_ack] = infinity_tower_settle_succeed_ack,
    [NetMsgId.Id.infinity_tower_daily_reward_receive_succeed_ack] = infinity_tower_daily_reward_receive_succeed_ack,
    [NetMsgId.Id.infinity_tower_plot_reward_receive_succeed_ack] = infinity_tower_plot_reward_receive_succeed_ack,
    [NetMsgId.Id.disc_reset_notify] = disc_reset_notify,
    [NetMsgId.Id.story_complete_notify] = story_complete_notify,
    [NetMsgId.Id.clear_all_story_notify] = clear_all_story_notify,
    [NetMsgId.Id.activity_login_rewards_notify] = activity_login_rewards_notify,
    [NetMsgId.Id.activity_malllogin_rewards_notify] = activity_malllogin_rewards_notify,
    [NetMsgId.Id.star_tower_book_potential_notify] = star_tower_book_potential_notify,
    [NetMsgId.Id.star_tower_book_event_notify] = star_tower_book_event_notify,
    [NetMsgId.Id.star_tower_book_event_reward_receive_succeed_ack] = star_tower_book_event_reward_receive_succeed_ack,
    [NetMsgId.Id.tower_book_fate_card_reward_receive_succeed_ack] = tower_book_fate_card_reward_receive_succeed_ack,
    [NetMsgId.Id.star_tower_book_potential_reward_receive_succeed_ack] = star_tower_book_potential_reward_receive_succeed_ack,
    [NetMsgId.Id.change_npc_affinity_notify] = change_npc_affinity_notify,
    [NetMsgId.Id.tower_book_fate_card_collect_notify] = tower_book_fate_card_collect_notify,
    [NetMsgId.Id.tower_book_fate_card_reward_notify] = tower_book_fate_card_reward_notify,
    [NetMsgId.Id.region_boss_level_challenge_ticket_notify] = region_boss_level_challenge_ticket_notify,
    [NetMsgId.Id.honor_change_notify] = honor_change_notify,
    [NetMsgId.Id.tower_growth_node_change_notify] = tower_growth_node_change_notify,
    [NetMsgId.Id.char_up_change_notify] = char_up_change_notify,
    [NetMsgId.Id.clear_all_vampire_survivor_notify] = clear_all_vampire_survivor_notify,
    [NetMsgId.Id.add_vampire_season_score_notify] = add_vampire_season_score_notify,
    [NetMsgId.Id.vampire_survivor_talent_node_notify] = HttpNetHandlerPlus.vampire_survivor_talent_node_notify,
    [NetMsgId.Id.star_tower_sub_note_skill_info_notify] = star_tower_sub_note_skill_info_notify,
    [NetMsgId.Id.refresh_agent_notify] = refresh_agent_notify,
    [NetMsgId.Id.clear_all_skill_instance_notify] = clear_all_skill_instance_notify,
    [NetMsgId.Id.order_paid_notify] = HttpNetHandlerPlus.order_paid_notify,
    [NetMsgId.Id.order_revoke_notify] = HttpNetHandlerPlus.order_revoke_notify,
    [NetMsgId.Id.order_collected_notify] = HttpNetHandlerPlus.order_collected_notify,
    [NetMsgId.Id.vampire_survivor_new_season_notify] = HttpNetHandlerPlus.vampire_survivor_new_season_notify,
    [NetMsgId.Id.item_expired_change_notify] = HttpNetHandlerPlus.item_expired_change_notify,
    [NetMsgId.Id.assist_add_build_notify] = HttpNetHandlerPlus.assist_add_build_notify,
    [NetMsgId.Id.clear_story_set_notify] = HttpNetHandlerPlus.clear_story_set_notify,
    [NetMsgId.Id.unlock_activity_story_notify] = HttpNetHandlerPlus.unlock_activity_story_notify,
    [NetMsgId.Id.st_skip_floor_notify] = st_skip_floor_notify,
    [NetMsgId.Id.st_add_team_exp_notify] = st_add_team_exp_notify,
    [NetMsgId.Id.st_add_new_case_notify] = st_add_new_case_notify,
    [NetMsgId.Id.st_items_change_notify] = st_items_change_notify,
    [NetMsgId.Id.tower_change_sub_note_skill_notify] = tower_change_sub_note_skill_notify,
    [NetMsgId.Id.region_boss_level_apply_succeed_ack] = region_boss_level_apply_succeed_ack,
    [NetMsgId.Id.region_boss_level_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.region_boss_level_settle_succeed_ack] = region_boss_level_settle_succeed_ack,
    [NetMsgId.Id.region_boss_level_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.region_boss_level_sweep_succeed_ack] = region_boss_level_sweep_succeed_ack,
    [NetMsgId.Id.skill_instance_apply_succeed_ack] = skill_instance_apply_succeed_ack,
    [NetMsgId.Id.skill_instance_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.week_boss_apply_succeed_ack] = week_boss_apply_succeed_ack,
    [NetMsgId.Id.week_boss_apply_failed_ack] = week_boss_apply_failed_ack,
    [NetMsgId.Id.week_boss_settle_succeed_ack] = week_boss_settle_succeed_ack,
    [NetMsgId.Id.week_boss_settle_failed_ack] = week_boss_settle_failed_ack,
    [NetMsgId.Id.week_boss_refresh_ticket_notify] = week_boss_refresh_ticket_notify,
    [NetMsgId.Id.player_learn_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.player_learn_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_learn_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_learn_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.soldier_learn_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.soldier_learn_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_affinity_quest_reward_receive_succeed_ack] = char_affinity_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.char_affinity_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_affinity_gift_send_succeed_ack] = char_affinity_gift_send_succeed_ack,
    [NetMsgId.Id.char_affinity_gift_send_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.char_recruitment_succeed_ack] = char_recruitment_succeed_ack,
    [NetMsgId.Id.char_recruitment_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.agent_reward_receive_succeed_ack] = agent_reward_receive_succeed_ack,
    [NetMsgId.Id.agent_new_notify] = agent_new_notify,
    [NetMsgId.Id.agent_apply_failed_ack] = agent_apply_failed_ack,
    [NetMsgId.Id.char_dating_landmark_select_succeed_ack] = char_dating_landmark_select_succeed_ack,
    [NetMsgId.Id.char_dating_event_reward_receive_succeed_ack] = char_dating_event_reward_receive_succeed_ack,
    [NetMsgId.Id.char_dating_gift_send_succeed_ack] = char_dating_gift_send_succeed_ack,
    [NetMsgId.Id.char_archive_reward_receive_succeed_ack] = char_archive_reward_receive_succeed_ack,
    [NetMsgId.Id.char_archive_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_daily_reward_notify] = activity_mining_daily_reward_notify,
    [NetMsgId.Id.activity_mining_supplement_reward_notify] = activity_mining_supplement_reward_notify,
    [NetMsgId.Id.activity_mining_quest_reward_receive_succeed_ack] = activity_mining_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_mining_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_story_reward_receive_succeed_ack] = activity_mining_story_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_mining_story_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_apply_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_move_to_next_layer_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_move_to_next_layer_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_mining_dig_succeed_ack] = activity_mining_dig_succeed_ack,
    [NetMsgId.Id.activity_mining_dig_failed_ack] = HttpNetHandlerPlus.activity_mining_dig_failed_ack,
    [NetMsgId.Id.activity_mining_energy_convert_notify] = activity_mining_energy_convert_notify,
    [NetMsgId.Id.activity_mining_enter_layer_notify] = HttpNetHandlerPlus.activity_mining_enter_layer_notify,
    [NetMsgId.Id.score_boss_star_reward_receive_succeed_ack] = score_boss_star_reward_receive_succeed_ack,
    [NetMsgId.Id.score_boss_reset_score_notify] = HttpNetHandlerPlus.score_boss_reset_score_notify,
    [NetMsgId.Id.activity_cookie_settle_succeed_ack] = HttpNetHandlerPlus.activity_cookie_settle_succeed_ack,
    [NetMsgId.Id.redeem_code_succeed_ack] = redeem_code_succeed_ack,
    [NetMsgId.Id.redeem_code_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.notice_change_notify] = notice_change_notify,
    [NetMsgId.Id.joint_drill_apply_succeed_ack] = joint_drill_apply_succeed_ack,
    [NetMsgId.Id.joint_drill_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.joint_drill_sweep_succeed_ack] = joint_drill_sweep_succeed_ack,
    [NetMsgId.Id.joint_drill_sweep_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.joint_drill_settle_succeed_ack] = joint_drill_settle_succeed_ack,
    [NetMsgId.Id.joint_drill_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.joint_drill_game_over_succeed_ack] = joint_drill_game_over_succeed_ack,
    [NetMsgId.Id.joint_drill_game_over_failed_ack] = HttpNetHandlerPlus.joint_drill_game_over_failed_ack,
    [NetMsgId.Id.joint_drill_quest_reward_receive_succeed_ack] = joint_drill_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.joint_drill_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_joint_drill_refresh_ticket_notify] = activity_joint_drill_refresh_ticket_notify,
    [NetMsgId.Id.joint_drill_sync_failed_ack] = HttpNetHandlerPlus.joint_drill_sync_failed_ack,
    [NetMsgId.Id.joint_drill_give_up_failed_ack] = HttpNetHandlerPlus.joint_drill_give_up_failed_ack,
    [NetMsgId.Id.joint_drill_2_apply_succeed_ack] = HttpNetHandlerPlus.joint_drill_2_apply_succeed_ack,
    [NetMsgId.Id.joint_drill_2_apply_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.joint_drill_2_settle_succeed_ack] = HttpNetHandlerPlus.joint_drill_2_settle_succeed_ack,
    [NetMsgId.Id.joint_drill_2_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.joint_drill_2_game_over_succeed_ack] = HttpNetHandlerPlus.joint_drill_2_game_over_succeed_ack,
    [NetMsgId.Id.joint_drill_2_game_over_failed_ack] = HttpNetHandlerPlus.joint_drill_2_game_over_failed_ack,
    [NetMsgId.Id.joint_drill_2_sync_failed_ack] = HttpNetHandlerPlus.joint_drill_2_sync_failed_ack,
    [NetMsgId.Id.joint_drill_2_give_up_failed_ack] = HttpNetHandlerPlus.joint_drill_2_give_up_failed_ack,
    [NetMsgId.Id.activity_tower_defense_story_reward_receive_succeed_ack] = activity_tower_defense_story_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_tower_defense_story_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_tower_defense_quest_reward_receive_succeed_ack] = activity_tower_defense_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_tower_defense_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_tower_defense_level_settle_succeed_ack] = activity_tower_defense_level_settle_succeed_ack,
    [NetMsgId.Id.activity_tower_defense_level_settle_failed_ack] = HttpNetHandlerPlus.activity_tower_defense_level_settle_failed_ack,
    [NetMsgId.Id.activity_avg_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_story_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_avg_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_task_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_task_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_task_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_task_group_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_task_group_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_task_group_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.force_update_notify] = force_update_notify,
    [NetMsgId.Id.player_head_icon_change_notify] = HttpNetHandlerPlus.player_head_icon_change_notify,
    [NetMsgId.Id.tutorial_level_settle_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tutorial_level_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.tutorial_level_reward_receive_succeed_ack] = HttpNetHandlerPlus.tutorial_level_reward_receive_succeed_ack,
    [NetMsgId.Id.tutorial_level_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_levels_settle_failed_ack] = HttpNetHandlerPlus.activity_levels_settle_failed_ack,
    [NetMsgId.Id.build_convert_detail_list_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.build_convert_detail_list_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.build_convert_submit_succeed_ack] = HttpNetHandlerPlus.build_convert_submit_succeed_ack,
    [NetMsgId.Id.build_convert_submit_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.build_convert_group_reward_receive_succeed_ack] = HttpNetHandlerPlus.build_convert_group_reward_receive_succeed_ack,
    [NetMsgId.Id.build_convert_group_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_story_settle_succeed_ack] = HttpNetHandlerPlus.activity_story_settle_succeed_ack,
    [NetMsgId.Id.activity_history_story_settle_succeed_ack] = HttpNetHandlerPlus.activity_history_story_settle_succeed_ack,
    [NetMsgId.Id.activity_archive_story_settle_succeed_ack] = HttpNetHandlerPlus.activity_archive_story_settle_succeed_ack,
    [NetMsgId.Id.milkout_settle_succeed_ack] = HttpNetHandlerPlus.milkout_settle_succeed_ack,
    [NetMsgId.Id.milkout_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.milkout_character_unlock_notify] = HttpNetHandlerPlus.milkout_character_unlock_notify,
    [NetMsgId.Id.clear_all_activity_breakout_levels_notify] = HttpNetHandlerPlus.clear_all_activity_breakout_levels_notify,
    [NetMsgId.Id.daily_mall_reward_receive_succeed_ack] = HttpNetHandlerPlus.daily_mall_reward_receive_succeed_ack,
    [NetMsgId.Id.daily_mall_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_throw_gift_settle_succeed_ack] = HttpNetHandlerPlus.activity_throw_gift_settle_succeed_ack,
    [NetMsgId.Id.activity_penguin_card_level_settle_succeed_ack] = HttpNetHandlerPlus.activity_penguin_card_level_settle_succeed_ack,
    [NetMsgId.Id.activity_penguin_card_level_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_penguin_card_quest_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_penguin_card_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_penguin_card_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_gds_settle_succeed_ack] = HttpNetHandlerPlus.activity_gds_settle_succeed_ack,
    [NetMsgId.Id.activity_gds_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.clear_all_activity_golden_spy_levels_notify] = HttpNetHandlerPlus.clear_all_activity_golden_spy_levels_notify,
    [NetMsgId.Id.activity_double_quest_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_double_quest_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_double_quest_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_double_reward_times_notify] = HttpNetHandlerPlus.activity_double_reward_times_notify,
    [NetMsgId.Id.activity_share_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_share_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_share_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.trace_hunt_settle_succeed_ack] = HttpNetHandlerPlus.trace_hunt_settle_succeed_ack,
    [NetMsgId.Id.trace_hunt_settle_failed_ack] = HttpNetHandlerPlus.trace_hunt_settle_failed_ack,
    [NetMsgId.Id.trace_hunt_trace_succeed_ack] = HttpNetHandlerPlus.trace_hunt_trace_succeed_ack,
    [NetMsgId.Id.trace_hunt_boss_reward_receive_succeed_ack] = HttpNetHandlerPlus.trace_hunt_boss_reward_receive_succeed_ack,
    [NetMsgId.Id.trace_hunt_new_control_notify] = HttpNetHandlerPlus.trace_hunt_new_control_notify,
    [NetMsgId.Id.trace_hunt_state_notify] = HttpNetHandlerPlus.trace_hunt_state_notify,
    [NetMsgId.Id.trace_hunt_item_change_notify] = HttpNetHandlerPlus.trace_hunt_item_change_notify,
    [NetMsgId.Id.activity_ice_cream_level_settle_succeed_ack] = HttpNetHandlerPlus.activity_ice_cream_level_settle_succeed_ack,
    [NetMsgId.Id.activity_ice_cream_level_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.soldier_apply_succeed_ack] = HttpNetHandlerPlus.soldier_apply_succeed_ack,
    [NetMsgId.Id.soldier_apply_failed_ack] = HttpNetHandlerPlus.soldier_apply_failed_ack,
    [NetMsgId.Id.soldier_give_up_succeed_ack] = HttpNetHandlerPlus.soldier_give_up_succeed_ack,
    [NetMsgId.Id.soldier_give_up_failed_ack] = HttpNetHandlerPlus.soldier_give_up_failed_ack,
    [NetMsgId.Id.soldier_info_succeed_ack] = HttpNetHandlerPlus.soldier_info_succeed_ack,
    [NetMsgId.Id.soldier_info_failed_ack] = HttpNetHandlerPlus.soldier_info_failed_ack,
    [NetMsgId.Id.soldier_interact_succeed_ack] = HttpNetHandlerPlus.soldier_interact_succeed_ack,
    [NetMsgId.Id.soldier_interact_failed_ack] = HttpNetHandlerPlus.soldier_interact_failed_ack,
    [NetMsgId.Id.sd_soldier_info_notify] = HttpNetHandlerPlus.sd_soldier_info_notify,
    [NetMsgId.Id.sd_buff_notify] = HttpNetHandlerPlus.sd_buff_notify,
    [NetMsgId.Id.sd_soldier_effect_notify] = HttpNetHandlerPlus.sd_soldier_effect_notify,
    [NetMsgId.Id.sd_shop_data_notify] = HttpNetHandlerPlus.sd_shop_data_notify,
    [NetMsgId.Id.sd_item_change_notify] = HttpNetHandlerPlus.sd_item_change_notify,
    [NetMsgId.Id.soldier_season_reward_receive_succeed_ack] = HttpNetHandlerPlus.soldier_season_reward_receive_succeed_ack,
    [NetMsgId.Id.soldier_season_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_info_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_info_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_info_update_name_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_info_update_name_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_bag_list_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_bag_list_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_role_interaction_succeed_ack] = HttpNetHandlerPlus.dorm_role_interaction_succeed_ack,
    [NetMsgId.Id.dorm_invitation_role_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_invitation_role_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_layout_reward_receive_succeed_ack] = HttpNetHandlerPlus.dorm_layout_reward_receive_succeed_ack,
    [NetMsgId.Id.dorm_layout_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_reward_receive_succeed_ack] = HttpNetHandlerPlus.dorm_reward_receive_succeed_ack,
    [NetMsgId.Id.dorm_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_room_bgm_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_room_bgm_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_affinity_gift_send_succeed_ack] = HttpNetHandlerPlus.dorm_affinity_gift_send_succeed_ack,
    [NetMsgId.Id.dorm_affinity_gift_send_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_furniture_preset_delete_succeed_ack] = HttpNetHandlerPlus.dorm_affinity_gift_send_succeed_ack,
    [NetMsgId.Id.dorm_furniture_preset_delete_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_list_get_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.friend_list_get_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_room_unlock_notify] = HttpNetHandlerPlus.dorm_room_unlock_notify,
    [NetMsgId.Id.quest_dorm_reward_receive_succeed_ack] = HttpNetHandlerPlus.quest_dorm_reward_receive_succeed_ack,
    [NetMsgId.Id.dorm_get_change_data_succeed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.dorm_achievement_reward_receive_succeed_ack] = HttpNetHandlerPlus.dorm_achievement_reward_receive_succeed_ack,
    [NetMsgId.Id.dorm_achievement_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.activity_returnee_state_notify] = HttpNetHandlerPlus.activity_returnee_state_notify,
    [NetMsgId.Id.activity_returnee_quest_change_notify] = HttpNetHandlerPlus.activity_returnee_quest_change_notify,
    [NetMsgId.Id.activity_math_parkour_level_settle_succeed_ack] = HttpNetHandlerPlus.activity_math_parkour_level_settle_succeed_ack,
    [NetMsgId.Id.activity_math_parkour_level_settle_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.clear_all_activity_mathParkour_levels_notify] = HttpNetHandlerPlus.clear_all_activity_mathParkour_levels_notify,
    [NetMsgId.Id.activity_mail_bind_reward_receive_succeed_ack] = HttpNetHandlerPlus.activity_mail_bind_reward_receive_succeed_ack,
    [NetMsgId.Id.activity_mail_bind_reward_receive_failed_ack] = NOTHING_NEED_TO_BE_DONE,
    [NetMsgId.Id.handbook_complete_notify] = HttpNetHandlerPlus.handbook_complete_notify
  }
end

function HttpNetHandler.Init()
  local pbSchema = NovaAPI.LoadLuaBytes("GameCore/Network/proto.pb")
  assert(PB.load(pbSchema))
  BindProcessFunction()
  MakeNetMsgIdMap()
  EventManager.Add("CS2LuaEvent_OnApplicationFocus", HttpNetHandler, HttpNetHandler.OnCS2LuaEvent_AppFocus)
end

function HttpNetHandler.SendMsg(nNetMsgId, mapMessageData, sUrl, callback)
  if NovaAPI.IsEditorPlatform() == true then
    printLog("发送消息：" .. nNetMsgId)
  end
  if nNetMsgId ~= NetMsgId.Id.player_ping_req and timerPingPong ~= nil then
    timerPingPong:Reset(TimerResetType.ResetElapsed)
  end
  local data = assert(PB.encode(NetMsgId.MsgName[nNetMsgId], mapMessageData))
  NovaAPI.AddSendMsgRequest(nNetMsgId, data, callback, sUrl)
end

function HttpNetHandler.DispatchMsg(MsgReceive, bIsNextMsg, MsgSend, bError, mapMainData)
  if type(bError) == "nil" then
    bError = false
  end
  if type(mapMainData) == "nil" then
    mapMainData = {}
  end
  local nReceiveMsgId = MsgReceive.msgId
  local mapReceiveMsgBody = MsgReceive.msgBody
  local sMsgName = NetMsgId.MsgName[nReceiveMsgId]
  local mapMsgData = assert(PB.decode(sMsgName, mapReceiveMsgBody))
  if mapProcessFunction == nil then
    return
  end
  local ProcessFunction = mapProcessFunction[nReceiveMsgId]
  if ProcessFunction ~= nil then
    printLog("处理消息，发送：" .. MsgSend.msgId .. "，接收：" .. nReceiveMsgId .. "，是否为嵌套消息�?" .. tostring(bIsNextMsg))
    ProcessFunction(mapMsgData)
  else
    printWarn("没有绑定消息处理函数，发送：" .. MsgSend.msgId .. "，接收：" .. nReceiveMsgId .. "，是否为嵌套消息�?" .. tostring(bIsNextMsg))
  end
  if bIsNextMsg == false then
    bError = sMsgName == "proto.Error"
    MsgSend.receiveMsgId = nReceiveMsgId
    mapMainData = mapMsgData
    local nFailId = mapNetMsgIdFailed[MsgSend.msgId]
    if bError == true and nFailId ~= nil and nFailId ~= nReceiveMsgId then
      ProcessFunction = mapProcessFunction[nFailId]
      if ProcessFunction ~= nil then
        printLog("处理消息，收到服务器返回失败或错误，但其id并非对应Req的失败id，收到的：" .. nReceiveMsgId .. "应该对应的：" .. nFailId)
        ProcessFunction()
      end
    end
  end
  local bUseCommonErrorMsgBox = true
  if NovaAPI.IsServerMaintained() == true and (nReceiveMsgId == NetMsgId.Id.player_login_failed_ack or nReceiveMsgId == NetMsgId.Id.ike_failed_ack) then
    bUseCommonErrorMsgBox = false
  end
  if sMsgName == "proto.Error" and bUseCommonErrorMsgBox == true then
    EventManager.Hit(EventId.SetTransition)
    local mapErrorCfg = ConfigTable.GetData("ErrorCode", mapMsgData.Code)
    if mapErrorCfg then
      local sErrorDetail = mapErrorCfg.Template
      if mapMsgData.Arguments and #mapMsgData.Arguments > 0 then
        sErrorDetail = string.format(mapErrorCfg.Template, table.unpack(mapMsgData.Arguments))
      end
      local bNeedTrace = false
      if mapMsgData.TraceId and mapMsgData.TraceId ~= 0 then
        bNeedTrace = true
        sErrorDetail = sErrorDetail .. "\n" .. mapMsgData.TraceId
      end
      printError("服务器返回错误：" .. sErrorDetail)
      local nShowType = mapErrorCfg.ShowType
      if bNeedTrace and nShowType == GameEnum.errorShowType.Tips then
        nShowType = GameEnum.errorShowType.Window
      end
      if nShowType ~= GameEnum.errorShowType.Tips then
        local function AlertCallback()
          if bNeedTrace then
            CS.UnityEngine.GUIUtility.systemCopyBuffer = mapMsgData.TraceId
            
            EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("ErrorCode_Trace"))
          end
          if mapMsgData.Action and mapMsgData.Action == 2 and (MsgSend.msgId == NetMsgId.Id.mail_recv_req or MsgSend.msgId == NetMsgId.Id.mail_remove_req or MsgSend.msgId == NetMsgId.Id.mail_read_req) then
            PlayerData.Mail:GetAgainAllMain()
          end
          if nShowType == GameEnum.errorShowType.Relogin then
            PanelManager.OnConfirmBackToLogIn()
          end
        end
        
        local msg = {
          nType = AllEnum.MessageBox.Alert,
          sContent = sErrorDetail,
          callbackConfirm = AlertCallback,
          bDisableSnap = true
        }
        if bNeedTrace then
          msg.sConfirm = ConfigTable.GetUIText("ErrorCode_Btn_Copy")
        end
        if NovaAPI.GetClientChannel() == AllEnum.ChannelName.BanShu then
          local a = string.gmatch(sErrorDetail, "%a+")
          if a() then
            msg.sContent = "提示：服务器错误，请稍后再试�?"
          end
        end
        if nShowType == GameEnum.errorShowType.Relogin then
          EventManager.Hit(EventId.OpenMessageBox, {
            nType = AllEnum.MessageBox.Alert,
            sContent = sErrorDetail,
            callbackConfirm = AlertCallback,
            sConfirm = ConfigTable.GetUIText("ErrorCode_Btn_Relogin")
          })
        else
          EventManager.Hit(EventId.OpenMessageBox, msg)
        end
      elseif nShowType == GameEnum.errorShowType.Tips then
        EventManager.Hit(EventId.OpenMessageBox, sErrorDetail)
      end
    else
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("ErrorCode_UnknowError") .. "SEC:" .. mapMsgData.Code,
        bDisableSnap = true
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  end
  local dataNext = mapMsgData.NextPackage
  if dataNext == nil or dataNext == "" then
    if bError == false and MsgSend.callback ~= nil then
      printLog("执行 network 回调，发送：" .. MsgSend.msgId .. "，接收：" .. MsgSend.receiveMsgId)
      MsgSend.callback(MsgSend, mapMainData)
      MsgSend.callback = nil
      EventManager.Hit("DispatchMsgDone")
    end
  else
    local msg = NovaAPI.ParseMessage(dataNext, true)
    if msg ~= nil then
      HttpNetHandler.DispatchMsg(msg, true, MsgSend, bError, mapMainData)
    end
  end
end

function HttpNetHandler.SendPingPong(_this, bManual, callback)
  if NovaAPI.IsEditorPlatform() == true then
    printLog("发送心跳消息")
  end
  local msgSend = {}
  HttpNetHandler.SendMsg(NetMsgId.Id.player_ping_req, msgSend, nil, callback)
  if bManual == true and timerPingPong ~= nil then
    timerPingPong:Reset(TimerResetType.ResetElapsed)
  end
end

function HttpNetHandler.SetPingPong()
  if timerPingPong == nil then
    timerPingPong = TimerManager.Add(0, PING_PONG_INTERVAL, HttpNetHandler, HttpNetHandler.SendPingPong, true, false, false, nil)
  else
    timerPingPong:Pause(false)
  end
end

function HttpNetHandler.UnsetPingPong()
  if timerPingPong ~= nil then
    timerPingPong:Pause(true)
  end
end

function HttpNetHandler.OnCS2LuaEvent_AppFocus(_, bFocus)
  if NovaAPI.IsRuntimeWindowsPlayer() == true then
    return
  end
  local bForcePrintLog = false
  if bForcePrintLog == true or NovaAPI.IsEditorPlatform() == false then
    printLog(string.format("Lua HttpNetHandler OnCS2LuaEvent_AppFocus, bFocus:%s, timerPingPong is nil:%s", tostring(bFocus), tostring(timerPingPong == nil)))
  end
  if timerPingPong == nil then
    return
  end
  if bFocus == true then
    timerPingPong:Pause(false)
    if bForcePrintLog == true or NovaAPI.IsEditorPlatform() == false then
      printLog("Lua HttpNetHandler OnCS2LuaEvent_AppFocus, timerPingPong: RUN.")
    end
  else
    timerPingPong:Pause(true)
    if bForcePrintLog == true or NovaAPI.IsEditorPlatform() == false then
      printLog("Lua HttpNetHandler OnCS2LuaEvent_AppFocus, timerPingPong: PAUSE.")
    end
  end
end

function HttpNetHandler.ProcChangeInfo(mapDecodedChangeInfo)
  PlayerData.Coin:ChangeCoin(mapDecodedChangeInfo["proto.Res"])
  PlayerData.Item:ChangeItem(mapDecodedChangeInfo["proto.Item"])
  PlayerData.Char:GetNewChar(mapDecodedChangeInfo["proto.Char"])
  PlayerData.Base:ChangeEnergy(mapDecodedChangeInfo["proto.Energy"])
  PlayerData.Base:ChangeWorldClass(mapDecodedChangeInfo["proto.WorldClass"])
  PlayerData.Base:ChangeTitle(mapDecodedChangeInfo["proto.Title"])
  PlayerData.Disc:CreateNewDisc(mapDecodedChangeInfo["proto.Disc"])
  PlayerData.Base:ChangeHonorTitle(mapDecodedChangeInfo["proto.Honor"])
  PlayerData.HeadData:ChangePlayerHead(mapDecodedChangeInfo["proto.HeadIcon"])
  PlayerData.TraceHunt:ChangeItem(mapDecodedChangeInfo["proto.TraceHuntItem"])
  PlayerData.PlayerDormData:CacheFurnitureChange(mapDecodedChangeInfo["proto.DormItem"])
end

return HttpNetHandler
