local this = class("serverListener")
local playerParser = require("ui.auxiliary.parser.playerParser")
local sceneParser = require("ui.auxiliary.parser.sceneParser")
local homeParser = require("ui.auxiliary.parser.homeParser")
local battleParser = require("ui.auxiliary.parser.battleParser")

function this:initialize()
  L_Net:addListener(MsgGenCode.CSProtoEnterGameCallbackStart, playerParser.socket_5011)
  L_Net:addListener(MsgGenCode.CSProtoEnterGame, playerParser.socket_5001)
  L_Net:addListener(MsgGenCode.CSProtoSyncPlayerData, this.socket_5008)
  L_Net:addListener(MsgGenCode.CSProtoHeroAttrInfoSync, this.socket_10006)
  L_Net:addListener(MsgGenCode.CSProtoInstanceInfoSync, this.socket_9001)
  L_Net:addListener(MsgGenCode.CSProtoMultiCampaignInfoSync, this.socket_9512)
  L_Net:addListener(MsgGenCode.CSProtoCurMultiCampaignInfoSync, this.socket_9513)
  L_Net:addListener(MsgGenCode.CSProtoMatchTeamDataSync, this.socket_9520)
  L_Net:addListener(MsgGenCode.CSProtoMatchReadySync, this.socket_9531)
  L_Net:addListener(MsgGenCode.CSProtoKiboDuelGroupInfoSync, this.socket_10740)
  L_Net:addListener(MsgGenCode.CSProtoPetHandbookInfoSync, this.socket_11020)
  L_Net:addListener(MsgGenCode.CSProtoKiboDuelFightingInfoSync, this.socket_10747)
  L_Net:addListener(MsgGenCode.CSProtoActivityReward, this.socket_10405)
  L_Net:addListener(MsgGenCode.CSProtoEntrustInfoSync, this.socket_9516)
  L_Net:addListener(MsgGenCode.CSProtoEntrustStarRewardSync, this.socket_9517)
  L_Net:addListener(MsgGenCode.CSProtoEntrustKiboInfoSync, this.socket_9519)
  L_Net:addListener(MsgGenCode.CSProtoTeachInfoSync, this.socket_11001)
  L_Net:addListener(MsgGenCode.CSProtoBattleHeroInfoSync, battleParser.scoket_10005)
  L_Net:addListener(MsgGenCode.CSProtoFightReward, battleParser.socket_10729)
  L_Net:addListener(MsgGenCode.CSProtoWorldMapSync, sceneParser.socket_9103)
  L_Net:addListener(MsgGenCode.CSProtoWorldMapPointSync, sceneParser.socket_9105)
  L_Net:addListener(MsgGenCode.CSProtoPlayableStep, sceneParser.socket_9406)
  L_Net:addListener(MsgGenCode.CSProtoWorldObjDiscovery, sceneParser.socket_9137)
  L_Net:addListener(MsgGenCode.CSProtoHomeSync, this.socket_6102)
  L_Net:addListener(MsgGenCode.CSProtoBuildCreate, this.socket_6103)
  L_Net:addListener(MsgGenCode.CSProtoBuildLocate, this.socket_6105)
  L_Net:addListener(MsgGenCode.CSProtoHomeUnlockSync, this.socket_6100)
  L_Net:addListener(MsgGenCode.CSProtoSimpleProductFinish, this.socket_11014)
  L_Net:addListener(MsgGenCode.CSProtoPetHandingProductSync, this.socket_6550)
  L_Net:addListener(MsgGenCode.CSProtoPetEatingFinishNotify, this.socket_6551)
  L_Net:addListener(MsgGenCode.CSProtoUpdateOrnament, this.socket_6029)
  L_Net:addListener(MsgGenCode.CSProtoAllEquipOrnamentSync, this.socket_6028)
  L_Net:addListener(MsgGenCode.CSProtoPlayerInfo, this.socket_5100)
  L_Net:addListener(MsgGenCode.CSProtoFriendSync, this.socket_6230)
  L_Net:addListener(MsgGenCode.CSProtoFriendIncChange, this.socket_6233)
  L_Net:addListener(MsgGenCode.CSProtoFriendShieldNtf, this.socket_6237)
  L_Net:addListener(MsgGenCode.CSProtoPetInfoSync, this.socket_6517)
  L_Net:addListener(MsgGenCode.CSProtoPetEggInfoSync, this.socket_6518)
  L_Net:addListener(MsgGenCode.CSProtoPetBoxInfoSync, this.socket_6547)
  L_Net:addListener(MsgGenCode.CSProtoChatMsgCntSync, this.socket_9929)
  L_Net:addListener(MsgGenCode.CSProtoChatListSync, this.socket_9930)
  L_Net:addListener(MsgGenCode.CSProtoChatInfoChange, this.socket_9932)
  L_Net:addListener(MsgGenCode.CSProtoChatShieldSync, this.socket_9937)
  L_Net:addListener(MsgGenCode.CSProtoDelShieldSync, this.socket_9938)
  L_Net:addListener(MsgGenCode.SCProtoChatIsolateListSync, this.socket_9954)
  L_Net:addListener(MsgGenCode.CSProtoChatEmojiSync, this.socket_9943)
  L_Net:addListener(MsgGenCode.CSProtoChatRoomSync, this.socket_9944)
  L_Net:addListener(MsgGenCode.CSProtoWorldMapLevelSync, this.socket_9115)
  L_Net:addListener(MsgGenCode.SCProtoWorldDifficultyInfo, this.socket_11301)
  L_Net:addListener(MsgGenCode.CSProtoGMCommandsSync, function()
  end)
  L_Net:addListener(MsgGenCode.CSProtoFishSync, this.socket_9910)
  L_Net:addListener(MsgGenCode.CSProtoFishPondSync, this.socket_9911)
  L_Net:addListener(MsgGenCode.CSProtoDailyActiveInfoSync, this.socket_6601)
  L_Net:addListener(MsgGenCode.CSProtoActiveTaskComplete, this.socket_6602)
  L_Net:addListener(MsgGenCode.SCProtoConditionRecord, this.socket_9909)
  L_Net:addListener(MsgGenCode.CSProtoWorldBuffSync, this.socket_9131)
  L_Net:addListener(MsgGenCode.CSProtoUnLockSync, this.socket_10600)
  L_Net:addListener(MsgGenCode.CSProtoGMSystemCloseSync, this.socket_9871)
  L_Net:addListener(MsgGenCode.CSProtoTowerSync, this.socket_6800)
  L_Net:addListener(MsgGenCode.CSProtoTowerScoreSync, this.socket_6801)
  L_Net:addListener(MsgGenCode.CSProtoChargeSync, this.socket_5985)
  L_Net:addListener(MsgGenCode.CSProtoChargeHpSync, this.socket_5986)
  L_Net:addListener(MsgGenCode.CSProtoTrialDatas, this.socket_5988)
  L_Net:addListener(MsgGenCode.CSProtoWorldMapMarkListSync, this.socket_9126)
  L_Net:addListener(MsgGenCode.CSProtoActivitySync, this.socket_10400)
  L_Net:addListener(MsgGenCode.CSProtoAnnouncementNotify, this.socket_10701)
  L_Net:addListener(MsgGenCode.CSProtoHomeBuildLoginSync, this.socket_6538)
  L_Net:addListener(MsgGenCode.CSProtoGuidePush, this.socket_6700)
  L_Net:addListener(MsgGenCode.CSProtoPhotoGraphTempletSync, this.socket_9810)
  L_Net:addListener(MsgGenCode.CSProtoAllRouletteInfoSync, this.socket_6563)
  L_Net:addListener(MsgGenCode.CSProtoObjBattleInfoSync, this.socket_10009)
  L_Net:addListener(MsgGenCode.CSProtoNoviceTaskInfoSync, this.socket_10761)
  L_Net:addListener(MsgGenCode.CSProtoKiboDuelAttrInfoSync, this.socket_10007)
  L_Net:addListener(MsgGenCode.CSProtoReadHandbookInfoSync, this.socket_11025)
  L_Net:addListener(MsgGenCode.CSProtoReadHandbookGet, this.socket_11026)
  L_Net:addListener(MsgGenCode.CSProtoReadHandbookRead, this.socket_11027)
  L_Net:addListener(MsgGenCode.CSProtoReputationInfo, this.socket_11250)
  L_Net:addListener(MsgGenCode.CSProtoLvUpPetSync, this.socket_6505)
  L_Net:addListener(MsgGenCode.CSProtoStandPlatesBagInfo, this.socket_5104)
  L_Net:addListener(MsgGenCode.CSProtoTaskJourneyTypeUnlock, this.socket_9866)
  L_Net:addListener(MsgGenCode.CSProtoNotifyTaskEndNode, this.socket_9868)
  L_Net:addListener(MsgGenCode.SCProtoShopInfoSync, this.socket_6072)
end

function this:dispose()
end

function this.socket_6072(data, errorcode)
  L_ShopStore:rsp_shopInfoDatas(data, errorcode)
end

function this.socket_6052(data, errorcode)
  if table.isEmpty(data.groups) then
    return
  end
  L_WorldLevelStore:rsp_syncTaskMaxLevel(data.groups)
end

function this.socket_6550(data, errorcode)
  L_ProductStore:rsp_onPetFinishProduct(data, errorcode)
end

function this.socket_6551(data, errorcode)
  L_HomeStore:rsp_petEatingFinishNotify(data, errorcode)
end

function this.socket_6100(data, errorCode)
  if table.isEmpty(data.infos) then
    return
  end
  L_HomeStore:rsp_syncHomeUnlock(data)
end

function this.socket_6102(data, errorCode)
  if data then
    L_HomeStore:rsp_generalInfo(data)
    if not table.isEmpty(data.builds) then
      L_HomeStore:rsp_syncBuildingBag(data.builds)
    end
    if not table.isEmpty(data.shortcut_bars) then
      L_HomeStore:rsp_syncHomeBelt(data.shortcut_bars)
    end
    if not table.isEmpty(data.home_builds) then
      L_HomeStore:rsp_syncHomeBuilding(data.home_builds, data.del_builds)
    end
    if not table.isEmpty(data.formula) then
      L_ProductStore:rsp_onSyncHomeFormulaInfo(data.formula)
    end
    if not table.isEmpty(data.wishlist) or not table.isEmpty(data.del_wishlist) then
      L_HomeStore:onHomeWishlistsSync(data.wishlist, data.del_wishlist)
    end
  end
end

function this.socket_6105(data, errorCode)
end

function this.socket_6524(data, errorCode)
end

function this.socket_11014(data, errorCode)
  L_ProductStore:rsp_onSyncFastProductData(data, errorCode)
end

function this.socket_5100(data, errorCode)
  if not table.isEmpty(data) then
    L_FriendStore:rsp_syncPlayerBaseInfos(data)
  end
end

function this.socket_6230(data, errorCode)
  if not table.isEmpty(data) then
    L_FriendStore:rsp_syncPlayerList(data)
  end
end

function this.socket_6233(data, errorCode)
  if not table.isEmpty(data) then
    L_FriendStore:rsp_friendIncChange(data)
  end
end

function this.socket_6237(data, errorCode)
  if not table.isEmpty(data) then
  end
end

function this.socket_6124(data, errorCode)
  if not table.isEmpty(data) then
    L_MailStore:rsp_syncMailInfo(data)
  end
end

function this.socket_9909(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
    L_GuideStore:onConditionRecordChanged(data.u32s)
  end
end

function this.socket_6517(data, errorCode)
  local pet_infos = data.pet_infos
  local free_reward_num = data.free_reward_num
  local last_free_time = data.last_free_time
  local record_pets = data.record_pets
  local scan_using_Id = data.w_pet_len
  if free_reward_num then
    L_PetStore:rsp_syncPetFreeRewardNum(free_reward_num)
  end
  if last_free_time then
    L_PetStore:rsp_syncPetLastFreeTime(last_free_time)
  end
  if record_pets then
    L_CatalogStore:rsp_syncPetCatalog(record_pets)
  end
  if pet_infos then
    L_PetStore:rsp_syncPet(pet_infos)
  end
  if data.lock_box_id then
    L_PetStore:rsp_syncLockBoxId(data.lock_box_id)
  end
  L_CatalogStore:setHasInitSync(true)
  L_PetStore:setHasInitSync(true)
end

function this.socket_6518(data, errorCode)
  local egg_infos = data.egg_infos
  if egg_infos then
    L_PetStore:rsp_syncPetEggItem(egg_infos)
  end
  L_PetStore:setFreeEggRewardNum(data.free_reward_num)
end

function this.socket_6547(data, errorCode)
  if not table.isEmpty(data) then
    L_PetStore:rsp_syncPetBoxInfo(data)
  end
end

function this.socket_6601(data, errorCode)
  local activtyGroupInfo = data.group_infos
  if activtyGroupInfo ~= nil then
    for i, v in pairs(activtyGroupInfo) do
      if v.task_infos ~= nil then
        L_ActivityTaskStore:rsp_syncActivityTaskInfo(v.task_infos)
      end
      if v.reward_ids ~= nil then
        L_ActivityTaskStore:rsp_syncActivityRewardListInfo(v.reward_ids)
      end
      if v.active_value ~= nil then
        if v.task_type == 1 then
          L_ActivityTaskStore:rsp_syncTodayActivityInfo(v.active_value, v.task_type)
        elseif v.task_type == 2 then
          L_ActivityTaskStore:rsp_syncWeekActivityInfo(v.active_value, v.task_type)
        end
      end
    end
  end
end

function this.socket_6602(data, errorCode)
  L_ActivityTaskStore:rsp_syncFinishedActivityTaskInfo(data.task_infos)
end

function this.socket_9001(data, errorCode)
  L_EntrustStore:rsp_entrustInfo(data, errorCode)
end

function this.socket_9115(data, errorCode)
  L_WorldLevelStore:rsp_syncWorldLevel(data)
end

function this.socket_11301(data, errorCode)
  L_WorldMapLvStore:rsp_syncWorldMapLevel(data)
end

function this.socket_9126(data)
  C_MapManager:GetMapStore():rsp_worldMapMarkListSync(data)
end

function this.socket_9131(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_BuffStore:syncWorldBuffData(data)
end

function this.socket_9512(data, errorCode)
  L_MultiDungeonStore:rsp_syncMultiDungeonInfo(data)
end

function this.socket_9513(data, errorCode)
  L_MultiDungeonStore:rsp_syncCurMultiDungeonInfo(data)
end

function this.socket_9520(data, errorCode)
  L_MultiDungeonStore:rsp_syncMatchTeamData(data)
end

function this.socket_9521(data, errorCode)
  L_MultiDungeonStore:rsp_syncMatchTeamInviteData(data)
end

function this.socket_9531(data, errorCode)
  L_MultiDungeonStore:rsp_syncMatchedReadyData(data)
end

function this.socket_9532(data, errorCode)
  L_MultiDungeonStore:rsp_syncRejectInviteJoinMatchTeamData(data)
end

function this.socket_9800(data, errorCode)
  L_ProductStore:rsp_syncTimeQueue(data)
end

function this.socket_9822(data, errorCode)
  if not table.isEmpty(data) then
    L_PlacePointStore:rsp_pointTake(data)
  end
end

function this.socket_9866(data, errorCode)
end

function this.socket_9868(data, errorCode)
end

function this.socket_9910(data, errorCode)
  if table.isEmpty(data) then
    return
  end
  L_FishingStore:rsp_syncFishExternalData(data)
end

function this.socket_9911(data, errorCode)
  if table.isEmpty(data) then
    return
  end
  L_FishingStore:rsp_syncFishPointList(data)
end

function this.socket_9929(data, errorCode)
  if table.isEmpty(data.msg_list) then
    return
  end
  L_ChatStore:rsp_syncConversationMsgNum(data.msg_list)
end

function this.socket_9930(data, errorCode)
  if table.isEmpty(data.info) then
    return
  end
  L_ChatStore:rsp_syncConversationList(data.info)
end

function this.socket_9932(data, errorCode)
  L_ChatStore:rsp_syncConversationMessage(data)
end

function this.socket_9937(data, errorCode)
  if not table.isEmpty(data.infos) then
    L_ChatStore:rsp_syncShieldList(data.infos)
  end
end

function this.socket_9938(data, errorCode)
  L_ChatStore:rsp_unmarkChat(data)
end

function this.socket_9943(data, errorCode)
  L_ChatStore:rsp_chatEmojiSync(data)
end

function this.socket_9944(data, errorCode)
  L_ChatStore:rsp_chatRoomSync(data)
end

function this.socket_9954(data, errorCode)
  L_ChatStore:rsp_chatIsolateListSync(data)
end

function this.socket_9853(data, errorCode)
end

function this.socket_10600(data, errorCode)
end

function this.socket_9871(data, errorCode)
end

function this.socket_6800(data, errorCode)
  if not table.isEmpty(data) then
    L_TowerStore:rsp_towerSync(data, errorCode)
  end
end

function this.socket_6801(data, errorCode)
  if not table.isEmpty(data) then
    L_TowerStore:rsp_towerScoreSync(data, errorCode)
  end
end

function this.socket_5985(data, errorCode)
  if not table.isEmpty(data) then
    L_StarHealingStore:rsp_starHealingChargeSync(data, errorCode)
  end
end

function this.socket_5986(data, errorCode)
  if not table.isEmpty(data) then
    L_StarHealingStore:rsp_starHealingChargeHpSync(data, errorCode)
  end
end

function this.socket_5988(data, errorCode)
  if not table.isEmpty(data) then
    L_PetStore:rsp_syncTrialPetItem(data.trial_pets)
  end
end

function this.socket_10400(data, errorCode)
  L_GameEventStore:syncGameEventDatas(data, errorCode)
end

function this.socket_10701(data, errorCode)
end

function this.socket_6538(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  if not table.isEmpty(data) then
    L_HomeStore:rsp_CSProtoHomeBuildLoginSync(data, errorCode, true)
  end
end

function this.socket_10740(data, errorCode)
  L_PetDuelStore:rsp_petDuelFormationData(data, errorCode)
  L_EntrustStore:rsp_entrustKiboInfo(data, errorCode)
end

function this.socket_10747(data, errorCode)
  L_PetDuelStore:rsp_petDuelFightingInfoSync(data, errorCode)
end

function this.socket_10405(data, errorCode)
  L_GameEventStore:syncRewardSync(data, errorCode)
end

function this.socket_11020(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_CatalogStore:rsp_syncPetCatalogTask(data)
  L_CatalogStore:setCatalogHasInitSync(true)
end

function this.socket_9516(data, errorCode)
  L_EntrustStore:rsp_entrustInfo(data, errorCode)
end

function this.socket_9517(data, errorCode)
  L_EntrustStore:rsp_entrustReward(data, errorCode)
end

function this.socket_9519(data, errorCode)
  L_EntrustStore:rsp_entrustKiboInfo(data, errorCode)
end

function this.socket_11001(data, errorCode)
end

function this.socket_6700(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_GuideStore:updateGuideDataByGM(data.id, data.sub_id, data.complete)
end

function this.socket_11025(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_LibraryBookStore:rsp_syncBookInfo(data)
end

function this.socket_11026(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
end

function this.socket_11027(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_LibraryBookStore:resp_syncBookReddotInfo(data)
end

function this.socket_11250(data, errorCode)
  if errorCode ~= nil and errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_ReputationStore:rsp_syncReputationInfo(data)
end

function this.socket_9810(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_PhotoStore:updateServerTempData(data, errorCode)
end

function this.socket_6563(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_QuickRouletteStore:refreshRouletteInfo(data.roulettes)
end

function this.socket_10009(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_BattleStore:rsp_syncObjBattleInfo(data)
end

function this.socket_10761(data, errCode)
  if errCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_NoviceTaskStore:rsp_syncNoviceTaskInfo(data)
end

function this.socket_10007(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_PetDuelStore:rsp_CSProtoKiboDuelAttrInfoSync(data)
end

function this.socket_10790(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  if data.cur_tran_id == 0 then
  else
  end
end

function this.socket_6505(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_PetDuelStore:rsp_CSProtoKiboDuelBattleFinish(data)
end

function this.socket_5008(data, errorCode)
  if data == nil then
    return
  end
  L_PlayerStore:rsp_syncPlayerInfo(data)
end

function this.socket_10006(data, errorCode)
  if not data or not data.heros then
    return
  end
  for _, v in ipairs(data.heros) do
    if v.type == L_Const.FightObjType.FO_Hero or v.type == L_Const.FightObjType.FO_Trial_Hero then
      L_HeroStore:rsp_syncHeroInfoes(v)
    end
  end
end

function this.socket_5104(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_PlayerDisplayStore:rsp_syncPlayerDisplayItem(data)
end

function this.socket_10409(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc then
    return
  end
  L_LimitedTimeActivityStore:rsp_CSProtoActivityScoreSync(data)
end

return this
