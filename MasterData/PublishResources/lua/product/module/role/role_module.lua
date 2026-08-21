_class("RoleModule", GameModule)
RoleModule = RoleModule
SkillAnimationPermissionType = {
  Open = 1,
  Close = 2,
  Once = 3
}
_enum("SkillAnimationPermissionType", SkillAnimationPermissionType)
local SKILL_ANIMATION_SETTING_KEY = "SkillAnimationSettingKey"

function RoleModule:Constructor()
  self.m_char_info = MobileCharInfo:New()
  self.m_choose_painting = MobileChoosePainting:New()
  self.m_Level_info = {}
  self.m_stSignText = ""
  self.m_mapImageData = {}
  self.m_mapFrameData = {}
  self.curTimeGotten = false
  self.BattleType = 0
  self.MissionId = 0
  self.PetsTemplateIdList = {}
  self.m_today_first_login = false
  self.m_minor_chat = true
  self.m_zone_id_type = 0
  self:_InitCheckCondition()
  self.m_store_review = false
  self.apppublishsubtype = 0
  self.m_cur_login_time = 0
  self.is_push_login_ext_data = false
end

function RoleModule:Init()
  self.caller:RegisterPushHandler(CEventMinorChatResult, self.HandleCEventMinorChatResult, self)
  self.caller:RegisterPushHandler(CEventPushPropertyChange, self.HandlePropertyChange, self)
  self.caller:RegisterPushHandler(CEventPushModuleUnlocked, self.HandleModuleUnlocked, self)
  self.caller:RegisterPushHandler(CEventPushLevelChange, self.HandleLevelChange, self)
  self:AttachEvent(GameEventType.UIChangeTeamLeader, self.ChangeTeamLeader)
  self:AttachEvent(GameEventType.MazeChangeTeamLeader, self.MazeChangeTeamLeader)
  self:AttachEvent(GameEventType.AppHome, self.TssSdkAppHome)
  self:AttachEvent(GameEventType.AppResume, self.TssSdkAppAppResume)
end

function RoleModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventMinorChatResult)
  self.caller:UnRegisterPushHandler(CEventPushPropertyChange)
  self.caller:UnRegisterPushHandler(CEventPushModuleUnlocked)
  self.caller:UnRegisterPushHandler(CEventPushLevelChange)
end

function RoleModule:Update()
  TSSSDKProxy:GetInstance():Tick()
  self:ReportTssData2Server()
end

function RoleModule:GameSingleInitCharInfo()
  local saveKey = "m_char_info"
  local jsonStr = PlayerPrefsGetPersonString(saveKey, nil)
  if jsonStr ~= nil and jsonStr ~= "" then
    local info = cjson.decode(jsonStr)
    if info ~= nil then
      self.m_char_info = info
    end
  end
  if self.m_char_info == nil or self.m_char_info.m_nHeadImageID == 0 then
    jsonStr = "{\"phy_point\":920,\"daily_vig_point\":0,\"tmServerBase\":1735118196,\"pstid\":0,\"title_used\":-1,\"_className\":\"MobileCharInfo\",\"guide_info\":{\"guide_id2count\":{},\"_className\":\"GuideInfo\"},\"m_nHeadFrameID\":1000,\"exp\":0,\"chapter_id\":0,\"vig_reward_state\":0,\"nick\":\"ass666\",\"m_dan\":0,\"light\":100,\"growth_quest_days\":1,\"ach_point\":0,\"unlock_modules\":4329324937215,\"double_res_num\":0,\"m_nHeadColorID\":1,\"m_grading\":0,\"m_nAmendNameCount\":0,\"level\":1,\"ext_flag\":0,\"fifure_used\":6500001,\"m_bBadgeSwitch\":true,\"m_nTotalLoginDays\":1,\"damage\":0,\"phy_last_time\":1735118196,\"active_token_accumulative\":0,\"active_token_num\":5,\"m_nTotalChangeLoginDays\":1,\"m_nHeadImageID\":1001,\"sailing_mission\":0,\"ach_reward_state\":0,\"phy_point_rate\":360,\"phy_point_max\":20,\"create_time\":1735095721,\"difficulty_mission\":0}"
    local info = cjson.decode(jsonStr)
    if info ~= nil then
      self.m_char_info = info
    end
  end
end

function RoleModule:InitCharInfo(charinfo)
  if GameSingle then
    self:GameSingleInitCharInfo()
    return
  end
  self.m_char_info = charinfo
  local time_mod = self:GetModule(SvrTimeModule)
  time_mod:InitServerTime(charinfo.tmServerBase)
  self.m_cur_login_time = charinfo.tmServerBase
end

function RoleModule:GameSingleInitChosePainting()
  local saveKey = "m_choose_painting"
  local jsonStr = PlayerPrefsGetPersonString(saveKey, nil)
  if jsonStr ~= nil then
    self.m_choose_painting = cjson.decode(jsonStr)
  end
  if self.m_choose_painting == nil then
    jsonStr = "{\"bgm_aircraft\":0,\"bgm_main\":0,\"bgm_homeland\":0,\"back_id\":2,\"board_pet\":-1,\"background_type\":1,\"_className\":\"MobileChoosePainting\",\"spine_id\":0,\"is_hand_operate\":false,\"background_scale\":1,\"background_y\":0,\"background_x\":0,\"skin_id\":-1,\"pet_grade\":-1,\"pet_template_id\":-1}"
    self.m_choose_painting = cjson.decode(jsonStr)
  end
  if self.m_choose_painting == nil then
    self:CreateChoosePainting()
  end
end

function RoleModule:CreateChoosePainting()
  local info = MobileChoosePainting:New()
  info.pet_template_id = 1500331
  info.pet_grade = 10
  info.skin_id = 90331
  info.back_id = 2000
  info.bgm_main = 2
  info.bgm_aircraft = 4
  info.board_pet = 1500331
  info.bgm_homeland = 2
  info.background_type = 1
  info.background_x = 0
  info.background_y = 0
  info.background_scale = 1
  info.is_hand_operate = false
  info.spine_id = 1500331
  self.m_choose_painting = info
end

function RoleModule:InitChosePainting(choose_painting)
  local jsonInfo = cjson.encode(choose_painting)
  Log.debug("painting jsonInfo", jsonInfo)
  if GameSingle then
    self:GameSingleInitChosePainting()
    return
  end
  self.m_choose_painting.pet_template_id = choose_painting.pet_template_id
  self.m_choose_painting.pet_grade = choose_painting.pet_grade
  self.m_choose_painting.skin_id = choose_painting.skin_id
  self.m_choose_painting.back_id = choose_painting.back_id
  self.m_choose_painting.bgm_main = choose_painting.bgm_main
  self.m_choose_painting.bgm_aircraft = choose_painting.bgm_aircraft
  self.m_choose_painting.board_pet = choose_painting.board_pet
  self.m_choose_painting.bgm_homeland = choose_painting.bgm_homeland
  self.m_choose_painting.background_type = choose_painting.background_type
  self.m_choose_painting.background_x = choose_painting.background_x
  self.m_choose_painting.background_y = choose_painting.background_y
  self.m_choose_painting.background_scale = choose_painting.background_scale
  self.m_choose_painting.is_hand_operate = choose_painting.is_hand_operate
  self.m_choose_painting.spine_id = choose_painting.spine_id
end

function RoleModule:InitTodayFirstLoginState(bTodayIsFirstLogin)
  self.m_today_first_login = bTodayIsFirstLogin
end

function RoleModule:GetTotalLoginDays()
  return self.m_char_info.m_nTotalLoginDays
end

function RoleModule:GetWorldBossRecordDan()
  return self.m_char_info.m_dan
end

function RoleModule:GetWorldBossRecordRank()
  return self.m_char_info.m_grading
end

function RoleModule:GetWorldBossRecordDamage()
  return self.m_char_info.damage
end

function RoleModule:GetBadgeSwitch()
  return self.m_char_info.m_bBadgeSwitch
end

function RoleModule:GetTotalLoginChangeDays()
  return self.m_char_info.m_nTotalChangeLoginDays
end

function RoleModule:SetStoreReview(values)
  self.m_store_review = values
end

function RoleModule:CanStoreReview()
  return self.m_store_review
end

function RoleModule:SetAPPPublishSubType(values)
  self.apppublishsubtype = values
end

function RoleModule:GetAPPPublishSubType()
  return self.apppublishsubtype
end

function RoleModule:isAPPPublishSubType(values)
  return self.apppublishsubtype == values
end

function RoleModule:TodayIsFirstLogin()
  return self.m_today_first_login
end

function RoleModule:SetMinorChat(values)
  self.m_minor_chat = values
end

function RoleModule:GetCanChat()
  if SDKProxy:GetInstance():IsAdult() == true then
    return true
  end
  return self.m_minor_chat
end

function RoleModule:HandleCEventMinorChatResult(msg)
  self:SetMinorChat(msg.minor_chat_open)
end

function RoleModule:HandlePropertyChange(msg)
  self.m_char_info = msg.info
  local time_mod = self:GetModule(SvrTimeModule)
  time_mod:InitServerTime(msg.info.tmServerBase)
  local questModule = GameGlobal.GetModule(QuestModule)
  questModule:CalcRedPoint()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RolePropertyChanged, self:GetHealthPoint(), self:GetHpLevelMax())
end

function RoleModule:GetResId()
  if GameSingle and self.m_choose_painting.pet_template_id == 0 then
    self.m_choose_painting.pet_template_id = 1500331
  end
  return self.m_choose_painting.pet_template_id
end

function RoleModule:GetResGrade()
  return self.m_choose_painting.pet_grade
end

function RoleModule:GetName()
  if GameSingle then
    local loginModule = GameGlobal.GetModule(LoginModule)
    return loginModule:GetReadStrByIdx(4)
  end
  return self.m_char_info.nick
end

function RoleModule:GetSaveName()
  return GetQR_Local.StringToUnicode(self:GetName())
end

function RoleModule:SetName(newName)
  self.m_char_info.nick = newName
end

function RoleModule:RequestChangeName(TT, new_name)
  local res = AsyncRequestRes:New()
  if new_name == nil or new_name == "" then
    res:SetResult(ROLE_RESULT_CODE.ROLE_ERROR_CHANGE_NICK_INVALID)
    return res
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChangePlayerName)
  request.new_name = new_name
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res
end

function RoleModule:GameSingleRequestChoosePainting(pet_template_id, pet_grade, skin_id, board_pet)
  self.m_choose_painting.pet_template_id = pet_template_id
  self.m_choose_painting.pet_grade = pet_grade ~= nil and pet_grade or 0
  self.m_choose_painting.skin_id = skin_id ~= nil and skin_id or 0
  self.m_choose_painting.board_pet = board_pet ~= nil and board_pet or 0
  self:GameSingleSaveChoosePainting()
  return EmptyRes
end

function RoleModule:GameSingleSaveChoosePainting()
  local jsonStr = cjson.encode(self.m_choose_painting)
  local saveKey = "m_choose_painting"
  Log.debug("savekey m_choose_painting=", jsonStr)
  PlayerPrefsSetPersonString(saveKey, jsonStr)
end

function RoleModule:RequestChoosePainting(TT, pet_template_id, pet_grade, skin_id, board_pet)
  if GameSingle then
    return self:GameSingleRequestChoosePainting(pet_template_id, pet_grade, skin_id, board_pet)
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChoosePainting)
  request.pet_template_id = pet_template_id
  request.pet_grade = pet_grade ~= nil and pet_grade or 0
  request.skin_id = skin_id ~= nil and skin_id or 0
  request.board_pet = board_pet ~= nil and board_pet or 0
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_choose_painting.pet_template_id = pet_template_id
    self.m_choose_painting.pet_grade = pet_grade ~= nil and pet_grade or 0
    self.m_choose_painting.skin_id = skin_id ~= nil and skin_id or 0
    self.m_choose_painting.board_pet = board_pet ~= nil and board_pet or 0
  end
  res:SetResult(replyEvent.ret)
  return res
end

function RoleModule:HandleModuleUnlocked(msg)
  self.m_char_info.unlock_modules = msg.unlock_modules
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ModuleUnlocked, msg.unlock_module_id)
end

function RoleModule:HandleLevelChange(msg)
  self.m_Level_info[msg.level_id] = true
end

function RoleModule:SetLevelInfo(info)
  for k, v in pairs(info) do
    self.m_Level_info[v] = true
  end
end

function RoleModule:IsPassLevel(levelId)
  if self.m_Level_info[levelId] ~= nil then
    return true
  end
  return false
end

function RoleModule:GetLevelInfo()
  return self.m_Level_info
end

function RoleModule:GetAssetCount(assetid)
  if assetid == RoleAssetID.RoleAssetPhyPoint then
    return self:GetHealthPoint()
  elseif assetid == RoleAssetID.RoleAssetExp then
    return self:GetRoleExp()
  elseif assetid == RoleAssetID.RoleAssetLight then
    return self:GetLight()
  elseif assetid == RoleAssetID.RoleAssetFirefly then
    return self:GetFirfly()
  elseif assetid == RoleAssetID.RoleAssetVigorous then
    return self.m_char_info.daily_vig_point
  elseif assetid == RoleAssetID.RoleAssetAchPoint then
    return self.m_char_info.ach_point
  elseif assetid == RoleAssetID.RoleAssetAtom then
    return self:GetModule(ItemModule):GetItemCount(assetid)
  elseif assetid == RoleAssetID.RoleAssetDoubleRes then
    return self:GetModule(ResDungeonModule):GetDoubleResNum()
  elseif assetid == RoleAssetID.RoleAssetMazeCoin then
    return self:GetMazeCoin()
  elseif assetid > RoleAssetID.RoleAssetPetBegin and assetid < RoleAssetID.RoleAssetPetEnd then
    return self:GetModule(PetModule):HasPet(assetid) and 1 or 0
  elseif assetid > RoleAssetID.RoleAssetItemBegin and assetid < RoleAssetID.RoleAssetItemEnd then
    return self:GetModule(ItemModule):GetItemCount(assetid)
  elseif assetid > RoleAssetID.RoleAssetPetSkinBegin and assetid < RoleAssetID.RoleAssetPetSkinEnd then
    local petModule = self:GetModule(PetModule)
    local skinId = petModule:GetSkinIDFromItemID(assetid)
    return self:GetModule(PetModule):HaveSkin(skinId) and 1 or 0
  else
    return self:GetModule(ItemModule):GetItemCount(assetid)
  end
end

function RoleModule:GetPstId()
  return self.m_char_info.pstid
end

function RoleModule:GetLight()
  return self.m_char_info.light
end

function RoleModule:GetLevel()
  return self.m_char_info.level
end

function RoleModule:GetRoleExp()
  return self.m_char_info.exp
end

function RoleModule:GetGold()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetGold)
end

function RoleModule:GetGlow()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetGlow)
end

function RoleModule:GetDiamond()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetDiamond)
end

function RoleModule:GetMazeCoin()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetMazeCoin)
end

function RoleModule:GetWorldBossCoin()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetWorldBossCoin)
end

function RoleModule:GetWorldBossCoin2()
  local itemMd = self:GetModule(ItemModule)
  return itemMd:GetItemCount(RoleAssetID.RoleAssetWorldBossCoin2)
end

function RoleModule:GetFirfly()
  local airMD = self:GetModule(AircraftModule)
  return airMD:GetFirefly()
end

function RoleModule:GetHealthPoint()
  return self.m_char_info.phy_point
end

function RoleModule:GetHpLevelMax()
  return self.m_char_info.phy_point_max
end

function RoleModule:GetAutoRecoverTime()
  return self.m_char_info.phy_last_time
end

function RoleModule:_SaveHealthPointResult(msg)
  self.m_char_info.phy_point = msg.phy_point
  self.m_char_info.phy_point_max = msg.phy_point_max
  self.m_char_info.phy_point_rate = msg.phy_point_rate
  self.m_char_info.phy_last_time = msg.phy_last_time
end

function RoleModule:GetAtom()
  return self:GetModule(ItemModule):GetItemCount(RoleAssetID.RoleAssetAtom)
end

function RoleModule:GetZoneIdType()
  return self.m_zone_id_type
end

function RoleModule:IsJapanZone()
  return self.apppublishsubtype == APPPublishSubType.APST_JA
end

function RoleModule:SetZoneIdType(zId)
  self.m_zone_id_type = zId
end

function RoleModule:_GetServerTime()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmSecond, nMilliSecond = math.modf(time_mod:GetServerTime() / 1000)
  return tmSecond
end

function RoleModule:_GetRecoverData()
  local tmNow = self:_GetServerTime()
  local phyNow = self.m_char_info.phy_point
  local phyMax = self:GetHpLevelMax()
  local lastTime = self.m_char_info.phy_last_time
  local oneTime = self.m_char_info.phy_point_rate
  local nRecoverLeftTimeOne = lastTime + oneTime - tmNow
  local nRecoverLeftTimeTotal = nRecoverLeftTimeOne + (phyMax - phyNow - 1) * oneTime
  if phyNow >= phyMax then
    nRecoverLeftTimeOne = 0
    nRecoverLeftTimeTotal = 0
  end
  if nRecoverLeftTimeOne < 0 then
    nRecoverLeftTimeOne = 0
  end
  if nRecoverLeftTimeTotal < 0 then
    nRecoverLeftTimeTotal = 0
  end
  return tmNow, oneTime, nRecoverLeftTimeOne, nRecoverLeftTimeTotal
end

function RoleModule:GetRecoverData(TT, pid)
  if GameSingle then
    local res = AsyncRequestRes:New()
    return res, self:_GetRecoverData()
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRoleHealthPoint)
  request.persistid = pid
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  self:_SaveHealthPointResult(reply.msg)
  return res, self:_GetRecoverData()
end

function RoleModule:GameSingleSetExtFlag(flag, value)
  if value then
    self.m_char_info.ext_flag = self.m_char_info.ext_flag | 1 << flag
  else
    self.m_char_info.ext_flag = self.m_char_info.ext_flag & ~(1 << flag)
  end
  self:GameSingleSaveCharInfo()
  return EmptyRes
end

function RoleModule:GameSingleSaveCharInfo(...)
  local jsonStr = cjson.encode(self.m_char_info)
  local saveKey = "m_char_info"
  PlayerPrefsSetPersonString(saveKey, jsonStr)
end

function RoleModule:SetExtFlag(TT, flag, value)
  if GameSingle then
    return self:GameSingleSetExtFlag(flag, value)
  end
  if value then
    self.m_char_info.ext_flag = self.m_char_info.ext_flag | 1 << flag
  else
    self.m_char_info.ext_flag = self.m_char_info.ext_flag & ~(1 << flag)
  end
  local msg = CEventSetExtFlag:New()
  msg.ext_flag = flag
  msg.value = value
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, msg)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
end

function RoleModule:GetExtFlag(flag)
  local value = self.m_char_info.ext_flag & 1 << flag
  return value ~= 0
end

function RoleModule:CheckModuleUnlock(module_id)
  if GameSingle then
    return true
  end
  if EngineGameHelper.EnableAppleVerifyBulletin() and module_id == GameModuleID.MD_HomeLand then
    return true
  end
  local value = self.m_char_info.unlock_modules & 1 << module_id
  return value ~= 0
end

function RoleModule:SkillAnimationLocalDBKey()
  return SKILL_ANIMATION_SETTING_KEY
end

function RoleModule:OnHomePageEnter(entranceId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventHomePageEnter)
  request.entrance_id = entranceId
  self:Push(request)
end

function RoleModule:OnSkipStory(TT, storyId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSkipStory)
  request.skip_id = storyId
  self:Call(TT, request, false)
end

function RoleModule:OnEndStory(TT, storyID, paragraphID, sectionID, BeSkipped, costSecond, beMission)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventEndStory)
  request.story_id = storyID
  request.paragraph_id = paragraphID
  request.section_id = sectionID
  request.be_skipped = BeSkipped
  request.cost_second = costSecond
  request.be_mission = beMission
  local reply = self:Call(TT, request, false)
  if reply.res ~= CallResultType.Normal then
    return false
  end
  return true
end

function RoleModule:GetAutoFightStatusUI(ids, matchType, out)
  local cfg = Cfg.cfg_global.auto_fight_need_pass_main_mission_id
  local mainMissionID = cfg.IntValue
  local cfg = Cfg.cfg_global.auto_fight_need_role_level
  if cfg and cfg.IntValue then
    local needLevel = cfg.IntValue
    if needLevel > self:GetLevel() then
      return false, cfg.StrValue
    end
  end
  cfg = Cfg.cfg_global.auto_fight_need_aircraft_level
  if cfg and cfg.ArrayValue then
    local airType, airLevel = table.unpack(cfg.ArrayValue)
    local cnt = self:GetModule(AircraftModule):GetRoomCount(airType, airLevel)
    if cnt == 0 then
      return false, cfg.StrValue
    end
  end
  cfg = Cfg.cfg_global.auto_fight_need_mission_id
  if cfg and cfg.IntValue then
    local needMissionId = cfg.IntValue
    if not self:GetModule(MissionModule):IsPassMissionID(needMissionId) then
      return false, cfg.StrValue
    end
  end
  cfg = Cfg.cfg_global.auto_fight_need_pass
  if cfg and cfg.IntValue and cfg.IntValue == 1 then
    if matchType == MatchType.MT_ResDungeon then
      local resModule = self:GetModule(ResDungeonModule)
      local isPass = resModule:IsResDungeonPassed(ids[1])
      if not isPass then
        return false, cfg.StrValue
      end
    elseif matchType == MatchType.MT_Mission then
      if out then
        local missionModule = self:GetModule(MissionModule)
        local missionId = ids[1]
        local passStage = missionModule:GetPassMissionById(missionId)
        if not passStage then
          return false, cfg.StrValue
        end
        local cfgMission = Cfg.cfg_mission[missionId]
        if cfgMission and cfgMission.EnableAutoFight == 0 then
          local cfgGlobal = Cfg.cfg_global.auto_fight_disable_in_mission
          return false, cfgGlobal.StrValue
        end
      else
        local missionModule = self:GetModule(MissionModule)
        local missionId = ids[1]
        local passStage = missionModule:GetPassMissionById(missionId)
        local passMain = missionModule:GetPassMissionById(mainMissionID)
        local cfgMission = Cfg.cfg_mission[missionId]
        if not cfgMission then
          return false
        end
        if cfgMission.EnableAutoFight == 0 then
          local cfgGlobal = Cfg.cfg_global.auto_fight_can_not_use
          return false, cfgGlobal.StrValue
        elseif cfgMission.EnableAutoFight == 1 then
          return true
        elseif cfgMission.EnableAutoFight == 2 then
          local cfgGlobal = Cfg.cfg_global.auto_fight_need_pass_boss_level
          if passStage then
            return true
          else
            return false, cfgGlobal.StrValue
          end
        elseif cfgMission.EnableAutoFight == 3 then
          local cfgGlobal = Cfg.cfg_global.auto_fight_need_pass_mainLine_level
          if passMain or passStage then
            return true
          else
            return false, cfgGlobal.StrValue
          end
        end
      end
    elseif matchType == MatchType.MT_ExtMission then
      local extMissionModule = self:GetModule(ExtMissionModule)
      local missionId = ids[1]
      local chapterId = ids[2]
      if not extMissionModule:IsExtTaskPass(chapterId) then
        return false, cfg.StrValue
      end
    end
  end
  cfg = Cfg.cfg_global.auto_fight_need_3_star
  if cfg and cfg.IntValue and cfg.IntValue == 1 then
    if matchType == MatchType.MT_Mission then
      local missionModule = self:GetModule(MissionModule)
      local missionId = ids[1]
      local passStage = missionModule:GetPassMissionById(missionId)
      if not passStage then
        return false, cfg.StrValue
      end
      local starCount, completeStarList = missionModule:ParseStarInfo(passStage.star)
      if starCount < 3 then
        return false, cfg.StrValue
      end
      local cfgMission = Cfg.cfg_mission[missionId]
      if cfgMission and cfgMission.EnableAutoFight ~= 1 then
        local cfgGlobal = Cfg.cfg_global.auto_fight_disable_in_mission
        return false, cfgGlobal.StrValue
      end
    elseif matchType == MatchType.MT_ExtMission then
      local extMissionModule = self:GetModule(ExtMissionModule)
      local missionId = ids[1]
      local chapterId = ids[2]
      local starCount = extMissionModule:UI_GetExtTaskState(missionId, chapterId)
      if starCount < 3 then
        return false, cfg.StrValue
      end
    end
  end
  return true
end

function RoleModule:CheckWordBuff(ids, matchType)
  if matchType == MatchType.MT_Mission then
    local missionModule = self:GetModule(MissionModule)
    local missionId = ids[1]
    local passStage = missionModule:GetPassMissionById(missionId)
    if not passStage then
      return false
    end
    local starCount, completeStarList = missionModule:ParseStarInfo(passStage.star)
    return 3 <= starCount
  elseif matchType == MatchType.MT_ExtMission then
    local extMissionModule = self:GetModule(ExtMissionModule)
    local missionId = ids[1]
    local chapterId = ids[2]
    local starCount = extMissionModule:UI_GetExtTaskState(missionId, chapterId)
    return 3 <= starCount
  elseif matchType == MatchType.MT_ResDungeon then
    local resDungeonModule = self:GetModule(ResDungeonModule)
    return resDungeonModule:IsResDungeonPassed(ids[1])
  else
    return false
  end
  return false
end

_class("DRoleHeadImage", Object)
DRoleHeadImage = DRoleHeadImage

function DRoleHeadImage:Constructor(nImageID, bLock, canUnlock)
  self.m_nImageID = nImageID
  self.m_bLock = bLock
  self._canUnlock = canUnlock
  self.m_vecPassCondition = {}
end

function DRoleHeadImage:AddPassCondition(nConditionID)
  table.insert(self.m_vecPassCondition, nConditionID)
end

function DRoleHeadImage:PassConditionAll()
  local cfgHeadImage = Cfg.cfg_role_head_image[self.m_nImageID]
  if nil == cfgHeadImage then
    return nil
  end
  self.m_vecPassCondition = cfgHeadImage.LockCondition
end

function DRoleHeadImage:ResetPassCondition()
  table.clear(self.m_vecPassCondition)
end

function DRoleHeadImage:IsConditionPass(nConditionID)
  if false == self.m_bLock then
    return true
  end
  return table.icontains(self.m_vecPassCondition, nConditionID)
end

function DRoleHeadImage:IsLock(bLock)
  return self.m_bLock
end

function DRoleHeadImage:SetLock(bLock)
  self.m_bLock = bLock
end

function DRoleHeadImage:CanUnLock()
  return self._canUnlock
end

function DRoleHeadImage:SetCanUnLock(canUnlock)
  self._canUnlock = canUnlock
end

function RoleModule:CanUnLock(nImageID)
  local roleHeadImage = self.m_mapImageData[nImageID]
  if roleHeadImage then
    return roleHeadImage:CanUnLock()
  end
  return false
end

function RoleModule:HasCanUnLock()
  if not self.m_mapImageData then
    return false
  end
  for k, v in pairs(self.m_mapImageData) do
    local canUnlock = v:CanUnLock()
    if canUnlock then
      return true
    end
  end
  for k, v in pairs(self.m_mapFrameData) do
    local canUnlock = v:CanUnLock()
    if canUnlock then
      return true
    end
  end
  return false
end

function RoleModule:GetHeadImageUnLockCount()
  local nCount = 0
  for nImageID, roleHeadImage in pairs(self.m_mapImageData) do
    if false == roleHeadImage:IsLock() then
      nCount = nCount + 1
    end
  end
  return nCount
end

function RoleModule:_FindMapDataByType(listMapData, nWorkID)
  local pFindImageData = listMapData[nWorkID]
  if nil == pFindImageData then
    listMapData[nWorkID] = DRoleHeadImage:New(nWorkID, true, false)
    pFindImageData = listMapData[nWorkID]
  end
  return pFindImageData
end

function RoleModule:_FindRoleImageData(nImageID)
  local pFindImageData = self.m_mapImageData[nImageID]
  if nil == pFindImageData then
    self.m_mapImageData[nImageID] = DRoleHeadImage:New(nImageID, true, false)
    pFindImageData = self.m_mapImageData[nImageID]
  end
  return pFindImageData
end

function RoleModule:_FindRoleFrameData(nFrameID)
  return self:_FindMapDataByType(self.m_mapFrameData, nFrameID)
end

function RoleModule:_Request_Handle(TT, request)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ROLE_RESULT_CODE.ROLE_FAILED)
    end
  else
    res:SetSucc(true)
  end
  return res, reply
end

function RoleModule:Request_RoleImageInfo(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRoleInfo_Req)
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  self.m_stSignText = recvPacket.m_stSignText
  table.clear(self.m_mapImageData)
  self.m_mapImageData = {}
  for key, value in pairs(recvPacket.m_mapImageData) do
    local headImageLock = DRoleHeadImage:New(key, value <= 0, false)
    self.m_mapImageData[key] = headImageLock
  end
  for key, nHeadImageID in pairs(recvPacket.m_vecCanUnlockImage) do
    local headImageLock = DRoleHeadImage:New(nHeadImageID, true, true)
    headImageLock:PassConditionAll()
    self.m_mapImageData[nHeadImageID] = headImageLock
  end
  table.clear(self.m_mapFrameData)
  self.m_mapFrameData = {}
  for key, value in pairs(recvPacket.m_mapImageFrame) do
    local headFrameLock = DRoleHeadImage:New(key, value <= 0, false)
    self.m_mapFrameData[key] = headFrameLock
  end
  for key, nHeadFrameID in pairs(recvPacket.m_vecCanUnlockFrame) do
    local headFrameLock = DRoleHeadImage:New(nHeadFrameID, true, true)
    headFrameLock:PassConditionAll()
    self.m_mapFrameData[nHeadFrameID] = headFrameLock
  end
  res:SetResult(recvPacket.ret)
  return res
end

function RoleModule:Request_AmendRoleName(TT, stNewName)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAmendRoleName_Req)
  request.m_stRoleName = stNewName
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_char_info.nick = stNewName
    self.m_char_info.m_nAmendNameCount = self.m_char_info.m_nAmendNameCount + 1
  end
  return res
end

function RoleModule:Request_AmendSignText(TT, stSignText)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAmendSignText_Req)
  request.m_stSignText = stSignText
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_stSignText = stSignText
  end
  return res
end

function RoleModule:Request_TitleAndFifure(TT, type, itemid)
  if GameSingle then
    return self:GameSingleRequest_TitleAndFifure(type, itemid)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChangeTitle)
  request.type = type
  request.id = itemid
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
  end
  return res
end

function RoleModule:GameSingleRequest_TitleAndFifure(type, itemid)
  if type == 1 then
    self.m_char_info.title_used = itemid
  elseif type == 2 then
    self.m_char_info.fifure_used = itemid
  elseif type == 4 then
    self.m_char_info.m_nHeadImageID = itemid
  elseif type == 5 then
    self.m_char_info.m_nHeadFrameID = itemid
  end
  self:GameSingleSaveCharInfo()
  return EmptyRes
end

function RoleModule:GameSingleRequest_AmendHeadImage(nImageID, nColorID, nFrameID)
  self.m_char_info.m_nHeadImageID = nImageID
  self.m_char_info.m_nHeadColorID = nColorID
  self.m_char_info.m_nHeadFrameID = nFrameID
  self:GameSingleSaveCharInfo()
  return EmptyRes
end

function RoleModule:Request_AmendHeadImage(TT, nImageID, nColorID, nFrameID)
  if GameSingle then
    return self:GameSingleRequest_AmendHeadImage(nImageID, nColorID, nFrameID)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAmendHeadImage_Req)
  request.m_nImageID = nImageID
  request.m_nColorID = nColorID
  request.m_nFrameID = nFrameID or 0
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_char_info.m_nHeadImageID = nImageID
    self.m_char_info.m_nHeadColorID = nColorID
    self.m_char_info.m_nHeadFrameID = nFrameID
  end
  return res
end

function RoleModule:Request_ClearHeadImageLock(TT, nImageID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClearHeadImageLock_Req)
  request.m_nImageID = nImageID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    local pFindImageData = self:_FindRoleImageData(nImageID)
    pFindImageData:SetLock(false)
    pFindImageData:SetCanUnLock(false)
  end
  return res
end

function RoleModule:Request_GetHeadImageLockInfo(TT, nImageID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRoleHeadImageLock_Req)
  request.m_nImageID = nImageID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  local pFindImageData = self:_FindRoleImageData(nImageID)
  pFindImageData:ResetPassCondition()
  for key, value in pairs(recvPacket.m_vecLockCondition) do
    pFindImageData:AddPassCondition(value)
  end
  return res
end

function RoleModule:CheckLimitedShowRed(subType, id)
  if self.m_overt_info then
    for key, date in pairs(self.m_overt_info) do
      if id then
        if key == id then
          return LocalDB.GetInt(GameGlobal.GetModule(LoginModule):GetRoleShowID() .. "LimitedShowRed_" .. key .. date, 0) <= 0
        end
      else
        local cfg = Cfg.cfg_item[key]
        if cfg and cfg.ItemSubType == subType then
          local record = LocalDB.GetInt(GameGlobal.GetModule(LoginModule):GetRoleShowID() .. "LimitedShowRed_" .. key .. date, 0)
          if record <= 0 then
            return true
          end
        end
      end
    end
  end
  return false
end

_class("PlayerRoleBaseInfo", Object)
PlayerRoleBaseInfo = PlayerRoleBaseInfo

function PlayerRoleBaseInfo:Constructor()
  self.m_stRoleName = ""
  self.m_nHeadImageID = 0
  self.m_nHeadColorID = 0
  self.m_nHeadFrameID = 0
  self.m_stSignText = ""
  self.m_nCreateTime = 0
  self.m_player_showid = 0
  self.m_player_lv = 0
  self.m_player_exp = 0
end

function RoleModule:GetRoleCreateTime()
  return self.m_char_info.create_time
end

function RoleModule:UI_GetPlayerInfo()
  local playerInfo = PlayerRoleBaseInfo:New()
  playerInfo.m_stRoleName = self:GetName()
  local charInfo = cjson.encode(self.m_char_info)
  Log.debug("charinfo=", charInfo)
  playerInfo.m_nHeadImageID = self.m_char_info.m_nHeadImageID
  playerInfo.m_nHeadColorID = self.m_char_info.m_nHeadColorID
  playerInfo.m_nHeadFrameID = self.m_char_info.m_nHeadFrameID
  playerInfo.m_stSignText = self.m_stSignText
  playerInfo.m_nCreateTime = self.m_char_info.create_time
  playerInfo.m_difficulty_mission = self.m_char_info.difficulty_mission
  playerInfo.m_sailing_mission = self.m_char_info.sailing_mission
  playerInfo.m_title_used = self.m_char_info.title_used
  playerInfo.m_fifure_used = self.m_char_info.fifure_used
  local loginModule = GameGlobal.GetModule(LoginModule)
  playerInfo.m_player_showid = loginModule:GetRoleShowID()
  local nPlayerExp = self:GetRoleExp()
  local nPlayerLevel = HelperProxy:GetInstance():GetLvByExp(nPlayerExp)
  playerInfo.m_player_lv = nPlayerLevel
  local deltaExp = 0
  if nPlayerLevel ~= HelperProxy:GetInstance():GetMaxLevel() then
    local curLvExp = HelperProxy:GetInstance():GetLevelExp(nPlayerLevel)
    deltaExp = nPlayerExp - curLvExp
  end
  playerInfo.m_player_exp = deltaExp
  return playerInfo
end

_class("PlayerScheduleInfo", Object)
PlayerScheduleInfo = PlayerScheduleInfo

function PlayerScheduleInfo:Constructor()
  self.m_player_current_missionid = ""
  self.m_player_mission_star = 0
  self.m_player_pet_count = 0
  self.m_player_achievement_point = 0
  self.m_player_achievement_all_point = 0
  self.m_player_tower_info = {}
end

function RoleModule:UI_GetPlayerScheduleInfo()
  local playerInfo = PlayerScheduleInfo:New()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local discoveryData = missionModule:GetDiscoveryData()
  local node = discoveryData:GetCanPlayNode()
  playerInfo.m_player_current_missionid = node.stages[1].id
  local chapterInfos = missionModule:GetChapterInfo()
  local star = 0
  for i = 1, #chapterInfos do
    local chapterInfo = chapterInfos[i]
    local starTemp = 0
    if chapterInfo and chapterInfo.star_count then
      starTemp = chapterInfo.star_count
    end
    star = star + starTemp
  end
  playerInfo.m_player_mission_star = star
  local petModule = GameGlobal.GetModule(PetModule)
  local pets = petModule:GetPets()
  local petCount = table.count(pets)
  playerInfo.m_player_pet_count = petCount
  local questModule = GameGlobal.GetModule(QuestModule)
  local achievementPoint = 0
  local achievementPointAll = 0
  achievementPoint, achievementPointAll = questModule:GetAchieveCount(AchieveType.AT_All)
  playerInfo.m_player_achievement_point = achievementPoint
  playerInfo.m_player_achievement_all_point = achievementPointAll
  local towerModule = GameGlobal.GetModule(TowerModule)
  local towerInfo = towerModule:GetPlayerTowerData()
  playerInfo.m_player_tower_info.tower_water = 0
  playerInfo.m_player_tower_info.tower_fire = 0
  playerInfo.m_player_tower_info.tower_wood = 0
  playerInfo.m_player_tower_info.tower_thunder = 0
  if towerInfo then
    if towerInfo.tower_water then
      playerInfo.m_player_tower_info.tower_water = towerInfo.tower_water
    end
    if towerInfo.tower_fire then
      playerInfo.m_player_tower_info.tower_fire = towerInfo.tower_fire
    end
    if towerInfo.tower_wood then
      playerInfo.m_player_tower_info.tower_wood = towerInfo.tower_wood
    end
    if towerInfo.tower_thunder then
      playerInfo.m_player_tower_info.tower_thunder = towerInfo.tower_thunder
    end
  end
  return playerInfo
end

_class("HeadImageLockCondition", Object)
HeadImageLockCondition = HeadImageLockCondition

function HeadImageLockCondition:Constructor(nConditionID)
  self.m_nConditionID = nConditionID
  self.m_stDesc = ""
  self.m_bPass = false
  self.m_listParam = {}
end

function HeadImageLockCondition:SetConditionParam(stConditionParam)
  if nil == stConditionParam then
    return
  end
  self.m_listParam = {}
  local listParam = string.split(stConditionParam, ",")
  for i = 1, #listParam do
    self.m_listParam[i] = tonumber(listParam[i])
  end
end

_class("HeadImageLockInfo", Object)
HeadImageLockInfo = HeadImageLockInfo

function HeadImageLockInfo:Constructor(nImageID)
  self.m_nImageID = nImageID
  self.m_nTag = 0
  self.m_stIcon = nil
  self.m_stDesc = ""
  self.m_bLock = false
  self.m_tItem = {}
  self.m_lockConditionList = {}
end

function RoleModule:UI_GetHeadImageLockInfo(nImageID)
  local cfgWorkData = Cfg.cfg_role_head_image[nImageID]
  if nil == cfgWorkData then
    return nil
  end
  local pFindHeadImage = self:_FindRoleImageData(nImageID)
  if nil == pFindHeadImage then
    return nil
  end
  local headLockInfo = HeadImageLockInfo:New(nImageID)
  headLockInfo.m_nTag = cfgWorkData.Tag
  headLockInfo.m_stIcon = cfgWorkData.Icon
  headLockInfo.m_stDesc = cfgWorkData.Desc
  headLockInfo.m_bLock = pFindHeadImage.m_bLock
  headLockInfo.m_tItem = cfgWorkData.FlagItem
  headLockInfo.m_lockConditionList = self:_UI_GetLockCondition(cfgWorkData.LockCondition, pFindHeadImage, Cfg.cfg_role_head_image_lock_condition)
  return headLockInfo
end

function RoleModule:UI_GetHeadImageListByTag(nTag)
  local cfgv = Cfg.cfg_role_head_image()
  local list = {}
  for k, v in pairs(cfgv) do
    if 0 == nTag or nTag == v.Tag then
      table.insert(list, self:UI_GetHeadImageLockInfo(k))
    end
  end
  
  local function Compare(sordDataA, sordDataB)
    local dataA = sordDataA
    local dataB = sordDataB
    if not dataA.m_bLock and dataB.m_bLock then
      return 1
    elseif dataA.m_bLock and not dataB.m_bLock then
      return -1
    elseif dataA.m_nTag < dataB.m_nTag then
      return 1
    elseif dataA.m_nTag > dataB.m_nTag then
      return -1
    elseif dataA.m_nImageID < dataB.m_nImageID then
      return 1
    elseif dataA.m_nImageID > dataB.m_nImageID then
      return -1
    else
      return 0
    end
    return 0
  end
  
  local sortedArray = SortedArray:New(Algorithm.COMPARE_CUSTOM, Compare)
  for i = 1, #list do
    sortedArray:Insert(list[i])
  end
  local listReturn = {}
  sortedArray:ForEach(function(element)
    table.insert(listReturn, element)
  end)
  return listReturn
end

function RoleModule:UI_GetHeadBgList()
  local bgs = {}
  local cfg_head_bg = Cfg.cfg_player_head_bg({})
  local count = table.count(cfg_head_bg)
  for i = 1, count do
    table.insert(bgs, cfg_head_bg[i].ID)
  end
  return bgs
end

function RoleModule:ReportTssData2Server()
  if os.time() % 5 ~= 0 then
    self.curTimeGotten = false
    return
  end
  if self.curTimeGotten == true then
    return
  end
  local antiData = TSSSDKProxy:GetInstance():GetTssReportDataString()
  Log.debug("GetReportData : ", antiData)
  self.curTimeGotten = true
  if type(antiData) == "string" and string.len(antiData) ~= 0 then
    self:SendAntiDataToServer(antiData)
  end
end

function RoleModule:TssSdkAppHome()
  GameGlobal.UAReportForceGuideEvent("SwitchOut", {}, true)
  if SDKProxy:GetInstance():IsInternationalSDK() then
    TSSSDKProxy:GetInstance():OnPause()
    Log.debug("OnApplicationPause")
  elseif SDKProxy:GetInstance():IsInlandSDK() then
    Log.debug("OnApplicationPause")
  end
  local moduleMain = self:GetModule(LoginModule)
  if not moduleMain:IsLogin() then
    return
  end
  local msg = CEventAppHome:New()
  msg.log_data = GameGlobal.UIStateManager().uiControllerManager.lockManager:GetLocksNameString()
  Log.debug(msg.log_data)
  self:Push(msg)
end

function RoleModule:HelpFun()
end

function RoleModule:TssSdkAppAppResume()
  GameGlobal.UAReportForceGuideEvent("SwitchResume", {}, true)
  if SDKProxy:GetInstance():IsInternationalSDK() then
    TSSSDKProxy:GetInstance():OnPause()
    Log.debug("OnApplicationResume")
  elseif SDKProxy:GetInstance():IsInlandSDK() then
    Log.debug("OnApplicationResume")
  end
  local moduleMain = self:GetModule(LoginModule)
  if not moduleMain:IsLogin() then
    return
  end
  local msg = CEventAppResume:New()
  msg.log_data = GameGlobal.UIStateManager().uiControllerManager.lockManager:GetLocksNameString()
  Log.debug(msg.log_data)
  self:Push(msg)
end

function RoleModule:SendAntiDataToServer(data)
  local moduleMain = self:GetModule(LoginModule)
  if not moduleMain:IsLogin() then
    return
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTssReportData)
  request.pst_ID = self:GetPstId()
  Log.debug("GetReportData : ", data)
  Log.debug("GetReportData len : ", string.len(data))
  request.report_data = data
  local res = self:Push(request)
end

function RoleModule:PushNewSettingTLog(setting_info)
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventMobileSettingInfo)
  msg.bgmVolume = setting_info.bgmVolume
  msg.soundVolume = setting_info.soundVolume
  msg.voiceVolume = setting_info.voiceVolume
  msg.bgmMute = setting_info.bgmMute
  msg.soundMute = setting_info.soundMute
  msg.voiceMute = setting_info.voiceMute
  msg.GraphicsLevel = setting_info.GraphicsLevel
  msg.skillAnmiIndex = setting_info.skillAnmiIndex
  msg.BangWidth = setting_info.BangWidth
  msg.danSwitch = setting_info.danSwitch
  self:Push(msg)
end

function RoleModule:PushBadgeSwitchSetting(badgeSwitch)
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventMobileBadgeInfo)
  msg.badgeSwitch = badgeSwitch
  self:Push(msg)
  self.m_char_info.m_bBadgeSwitch = badgeSwitch
end

function RoleModule:ChangeLeaderFlow(ChangeLeaderTimes, BeforeLeaderId, AfterLeaderId, RemainChangeTime, BeActiveChange)
  local petModule = GameGlobal.GetModule(PetModule)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChangeLeader)
  request.battle_type = self.BattleType
  request.mission_id = self.MissionId
  request.change_leader_times = ChangeLeaderTimes
  local curPet = petModule:GetPet(BeforeLeaderId)
  if curPet ~= nil then
    request.before_leader_id = curPet:GetTemplateID()
  else
    request.before_leader_id = BeforeLeaderId
  end
  curPet = petModule:GetPet(AfterLeaderId)
  if curPet ~= nil then
    request.after_leader_id = curPet:GetTemplateID()
  else
    request.after_leader_id = AfterLeaderId
  end
  request.remain_change_time = RemainChangeTime
  request.pets_ids = self.PetsTemplateIdList
  request.be_active_change = BeActiveChange
  self:Push(request)
end

function RoleModule:UpdateMatchInfo(BattleType, MissionId)
  self.BattleType = BattleType
  self.MissionId = MissionId
end

function RoleModule:UpdateMatchPetsList(PetsList)
  local petModule = GameGlobal.GetModule(PetModule)
  for i, pstid in ipairs(PetsList) do
    local curPet = petModule:GetPet(pstid)
    local pet_template_id = 0
    if curPet ~= nil then
      pet_template_id = curPet:GetTemplateID()
    else
      pet_template_id = pstid
    end
    self.PetsTemplateIdList[i] = pet_template_id
  end
end

function RoleModule:ChangeTeamLeader(BeforeLeaderId, AfterLeaderId, RemainChangeTime, teamOrderBefore, teamOrderAfter)
  self:ChangeLeaderFlow(Cfg.cfg_global.changeTeamLeaderCount.IntValue - RemainChangeTime, BeforeLeaderId, AfterLeaderId, RemainChangeTime, true)
end

function RoleModule:MazeChangeTeamLeader(BeforeLeaderId, AfterLeaderId)
  self:ChangeLeaderFlow(0, BeforeLeaderId, AfterLeaderId, 0, false)
end

function RoleModule:PushClientLog(stLogKey, stLogValue)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientSaveLog)
  request.m_stKey = stLogKey
  request.m_stValue = stLogValue
  self:Push(request)
end

function RoleModule:GetHelpPetData(playerPstId, sourceType, roleHelpPetInfo)
  local helpInfo = DHelpPet_PetData:New()
  helpInfo.m_nPlayerID = playerPstId
  helpInfo.m_nTemplateID = roleHelpPetInfo.pet_template_id
  helpInfo.m_nPstID = roleHelpPetInfo.pet_pst_id
  helpInfo.m_nLevel = roleHelpPetInfo.level
  helpInfo.m_nAwake = roleHelpPetInfo.awake
  helpInfo.m_nGrade = roleHelpPetInfo.grade
  helpInfo.m_nEquipLevel = roleHelpPetInfo.equip_level
  helpInfo.m_nEquipRefineLevel = roleHelpPetInfo.equip_refine_level
  helpInfo.m_nSkinID = roleHelpPetInfo.skin_id
  helpInfo.m_nSourceType = sourceType
  helpInfo.m_nAwakeLock = roleHelpPetInfo.awake_lock
  return helpInfo
end

function RoleModule:GetChangeNameTimes()
  return self.m_char_info.m_nAmendNameCount
end

function RoleModule:Request_AmendHeadFrame(TT, nFrameID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAmendHeadFrame_Req)
  request.m_nFrameID = nFrameID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_char_info.m_nHeadFrameID = nFrameID
  end
  return res
end

function RoleModule:Request_ClearHeadFrameLock(TT, nFrameID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClearHeadFrameLock_Req)
  request.m_nFrameID = nFrameID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    local pFindFrameData = self:_FindRoleFrameData(nFrameID)
    pFindFrameData:SetLock(false)
    pFindFrameData:SetCanUnLock(false)
  end
  return res
end

function RoleModule:Request_GetHeadFrameLockInfo(TT, nFrameID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRoleHeadFrameLock_Req)
  request.m_nFrameID = nFrameID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  local pFindFrameData = self:_FindRoleFrameData(nFrameID)
  pFindFrameData:ResetPassCondition()
  for key, value in pairs(recvPacket.m_vecLockCondition) do
    pFindFrameData:AddPassCondition(value)
  end
  return res
end

function RoleModule:_UI_GetLockCondition(lockCondition, pFindHeadFrame, cfgTableLockCondition)
  local listCondition = {}
  if GameSingle then
    return listCondition
  end
  if nil == lockCondition then
    return listCondition
  end
  for key, nConditionID in pairs(lockCondition) do
    local headFrameLockCondition = HeadImageLockCondition:New(nConditionID)
    headFrameLockCondition.m_bPass = pFindHeadFrame:IsConditionPass(nConditionID)
    local cfgLockCondition = cfgTableLockCondition[nConditionID]
    if cfgLockCondition then
      headFrameLockCondition.m_stDesc = cfgLockCondition.LockDesc
    end
    headFrameLockCondition:SetConditionParam(cfgLockCondition.ConditionParam)
    table.insert(listCondition, headFrameLockCondition)
  end
  return listCondition
end

function RoleModule:UI_GetHeadFrameLockInfo(nFrameID)
  local cfgWorkData = Cfg.cfg_role_head_frame[nFrameID]
  if nil == cfgWorkData then
    return nil
  end
  local pFindHeadFrame = self:_FindRoleFrameData(nFrameID)
  if nil == pFindHeadFrame then
    return nil
  end
  local headLockInfo = HeadImageLockInfo:New(nFrameID)
  headLockInfo.m_nTag = cfgWorkData.Tag
  headLockInfo.m_stIcon = cfgWorkData.Icon
  headLockInfo.m_stDesc = cfgWorkData.Desc
  headLockInfo.m_bLock = pFindHeadFrame.m_bLock
  headLockInfo.m_tItem = cfgWorkData.FlagItem
  headLockInfo.m_lockConditionList = self:_UI_GetLockCondition(cfgWorkData.LockCondition, pFindHeadFrame, Cfg.cfg_role_head_frame_lock_condition)
  return headLockInfo
end

function RoleModule:UI_GetMainBgID()
  return self.m_choose_painting.back_id
end

function RoleModule:GameSingleRequestRole_BackID(param)
  self.m_choose_painting.back_id = param.nBackImageID
  self.m_choose_painting.background_type = param.background_type
  self.m_choose_painting.background_x = param.background_x
  self.m_choose_painting.background_y = param.background_y
  self.m_choose_painting.background_scale = param.background_scale
  self.m_choose_painting.is_hand_operate = param.is_hand_operate
  self.m_choose_painting.spine_id = param.spine_id
  self:GameSingleSaveChoosePainting()
  return EmptyRes
end

function RoleModule:RequestRole_BackID(TT, param)
  if GameSingle then
    return self:GameSingleRequestRole_BackID(param)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChooseBackImage)
  request.m_nBackImageID = param.nBackImageID
  request.m_background_type = param.background_type
  request.m_background_x = param.background_x
  request.m_background_y = param.background_y
  request.m_background_scale = param.background_scale
  request.is_hand_operate = param.is_hand_operate
  request.spine_id = param.spine_id
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local replyEvent = reply.msg
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.m_choose_painting.back_id = param.nBackImageID
    self.m_choose_painting.background_type = param.background_type
    self.m_choose_painting.background_x = param.background_x
    self.m_choose_painting.background_y = param.background_y
    self.m_choose_painting.background_scale = param.background_scale
    self.m_choose_painting.is_hand_operate = param.is_hand_operate
    self.m_choose_painting.spine_id = param.spine_id
  end
  res:SetResult(replyEvent.ret)
  return res
end

function RoleModule:GameSingleRequestRole_Music(nBgmType, nBgmID)
  if EnumBgmType.E_Bgm_Main == nBgmType then
    self.m_choose_painting.bgm_main = nBgmID
  elseif EnumBgmType.E_Bgm_AirCraft == nBgmType then
    self.m_choose_painting.bgm_aircraft = nBgmID
  elseif EnumBgmType.E_Bgm_Homeland == nBgmType then
    self.m_choose_painting.bgm_homeland = nBgmID
  end
  self:GameSingleSaveChoosePainting()
  return EmptyRes
end

function RoleModule:RequestRole_Music(TT, nBgmType, nBgmID)
  if GameSingle then
    return self:GameSingleRequestRole_Music(nBgmType, nBgmID)
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventChooseBgm)
  request.m_nBgmType = nBgmType
  request.m_nBgmID = nBgmID
  local res, reply = self:_Request_Handle(TT, request)
  if not res:GetSucc() then
    return res
  end
  local recvPacket = reply.msg
  res:SetResult(recvPacket.ret)
  if recvPacket.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    if EnumBgmType.E_Bgm_Main == nBgmType then
      self.m_choose_painting.bgm_main = nBgmID
    elseif EnumBgmType.E_Bgm_AirCraft == nBgmType then
      self.m_choose_painting.bgm_aircraft = nBgmID
    elseif EnumBgmType.E_Bgm_Homeland == nBgmType then
      self.m_choose_painting.bgm_homeland = nBgmID
    end
  end
  return res
end

function RoleModule:UI_GetMusic(nBgmType)
  if EnumBgmType.E_Bgm_Main == nBgmType then
    return self.m_choose_painting.bgm_main
  elseif EnumBgmType.E_Bgm_AirCraft == nBgmType then
    return self.m_choose_painting.bgm_aircraft
  elseif EnumBgmType.E_Bgm_Homeland == nBgmType then
    return self.m_choose_painting.bgm_homeland
  end
end

function RoleModule:UI_CheckMusicLock(cfg)
  local seasonMissionID = cfg.SeasonMissionID
  if seasonMissionID then
    if not self._missionModule then
      self._missionModule = GameGlobal.GetModule(MissionModule)
    end
    local missionid = seasonMissionID[1]
    local type = seasonMissionID[2]
    local isactive = self._missionModule:IsMissionStoryActive(missionid, type)
    if isactive then
      return false
    end
  end
  return self:UI_CheckLockCondition(cfg.LockCondition)
end

function RoleModule:UI_CheckMusicShow(cfg)
  if cfg.IsShow then
    local timeCheck = self:UI_CheckTimeUnlock(cfg)
    if not timeCheck then
      return false
    end
    local lock = self:UI_CheckMusicLock(cfg)
    if lock and cfg.UnLockUnShow then
      return false
    end
    return true
  end
  return false
end

function RoleModule:UI_CheckTimeUnlock(cfg)
  if cfg.IsShow then
    if cfg.UnLockTime then
      local type = cfg.TimeTransform
      local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      if type and type == 0 then
        timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local unlockTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(cfg.UnLockTime, timeType)
      local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
      return unlockTime > svrTime
    else
      return true
    end
  end
  return false
end

function RoleModule:UI_CheckLockCondition(cfgCondition)
  if cfgCondition == nil then
    return false
  end
  return not self:_CheckCondition(cfgCondition[1], cfgCondition[2], cfgCondition[3], cfgCondition[4])
end

function RoleModule:UI_CheckLockConditionNew(lockInfo)
  if lockInfo == nil then
    return false
  end
  local item = lockInfo.m_tItem
  if item ~= nil then
    local itemMd = self:GetModule(ItemModule)
    local num = itemMd:GetItemCount(item[1])
    if num >= item[2] then
      return true
    end
  end
  local conditions = lockInfo.m_lockConditionList
  local _tempCanLock = true
  for i = 1, #conditions do
    local cfgCondition = conditions[i].m_listParam
    _tempCanLock = self:_CheckCondition(cfgCondition[1], cfgCondition[2], cfgCondition[3], cfgCondition[4])
    if _tempCanLock == false then
      break
    end
  end
  return _tempCanLock
end

function RoleModule:_InitCheckCondition(nConditionType, nParam1, nParam2, nParam3)
  self.m_listCheckCondition = {}
  self.m_listCheckCondition[ConditionType.CT_RoleLevel] = self._CheckCondition_CT_RoleLevel
  self.m_listCheckCondition[ConditionType.CT_MissionID] = self._CheckCondition_CT_MissionID
  self.m_listCheckCondition[ConditionType.CT_ModuleUnlock] = self._CheckCondition_CT_ModuleUnlock
  self.m_listCheckCondition[ConditionType.CT_ExMissionID] = self._CheckCondition_CT_ExMissionID
  self.m_listCheckCondition[ConditionType.CT_ResDungeonID] = self._CheckCondition_CT_ResDungeonID
  self.m_listCheckCondition[ConditionType.CT_TowerID] = self._CheckCondition_CT_TowerID
  self.m_listCheckCondition[ConditionType.CT_TowerType] = self._CheckCondition_CT_TowerType
  self.m_listCheckCondition[ConditionType.CT_UnlockHeadNum] = self._CheckCondition_CT_UnlockHeadNum
  self.m_listCheckCondition[ConditionType.CT_AirRoomTypeY] = self._CheckCondition_CT_AirRoomTypeY
  self.m_listCheckCondition[ConditionType.CT_AirRoomLevelY] = self._CheckCondition_CT_AirRoomLevelY
  self.m_listCheckCondition[ConditionType.CT_PetYElementZLevel] = self._CheckCondition_CT_PetYElementZLevel
  self.m_listCheckCondition[ConditionType.CT_PetYStar] = self._CheckCondition_CT_PetYStar
  self.m_listCheckCondition[ConditionType.CT_PetYAffinity] = self._CheckCondition_CT_PetYAffinity
  self.m_listCheckCondition[ConditionType.CT_PetEnterAirRoom] = self._CheckCondition_CT_PetEnterAirRoom
  self.m_listCheckCondition[ConditionType.CT_PetYElementZStar] = self._CheckCondition_CT_PetYElementZStar
  self.m_listCheckCondition[ConditionType.CT_PetGradeY] = self._CheckCondition_CT_PetGradeY
  self.m_listCheckCondition[ConditionType.CT_PetAwakeY] = self._CheckCondition_CT_PetAwakeY
  self.m_listCheckCondition[ConditionType.CT_PetGradeLevel] = self._CheckCondition_CT_PetGradeLevel
  self.m_listCheckCondition[ConditionType.CT_PetAwakeLevel] = self._CheckCondition_CT_PetAwakeLevel
  self.m_listCheckCondition[ConditionType.CT_PeAffinityLevel] = self._CheckCondition_CT_PetAffinityLevel
  self.m_listCheckCondition[ConditionType.CT_PetGradeTo] = self._CheckCondition_CT_PetGradeTo
  self.m_listCheckCondition[ConditionType.CT_FriendTeamPetsGradeLevel] = self._CheckCondition_CT_FriendTeamPetsGradeLevel
  self.m_listCheckCondition[ConditionType.CT_PetEquipLv] = self._CheckCondition_CT_PetEquipLv
  self.m_listCheckCondition[ConditionType.CT_PetNumEquipLv] = self._CheckCondition_CT_PetNumEquipLv
  self.m_listCheckCondition[ConditionType.CT_ItemCount] = self._CheckCondition_CT_ItemCount
  self.m_listCheckCondition[ConditionType.CT_BattleWinYTZID] = nil
  self.m_listCheckCondition[ConditionType.CT_PlayerLogin] = self._CheckCondition_CT_PlayerLogin
  self.m_listCheckCondition[ConditionType.CT_PlayerChangeLogin] = self._CheckCondition_CT_PlayerChangeLogin
  self.m_listCheckCondition[ConditionType.CT_TotalComStoryEventNum] = nil
  self.m_listCheckCondition[ConditionType.CT_QuestChatPetCompleteNum] = self._CheckCondition_CT_QuestChatPetCompleteNum
  self.m_listCheckCondition[ConditionType.CT_QuestChatIsReaded] = self._CheckCondition_CT_QuestChatTalkComplete
  self.m_listCheckCondition[ConditionType.CT_QuestChatTotalCompleteNum] = self._CheckCondition_CT_QuestChatTotalCompleteNum
  self.m_listCheckCondition[ConditionType.CT_AircraftUpdateAmusementNum] = self._CheckCondition_CT_AircraftUpdateAmusementNum
  self.m_listCheckCondition[ConditionType.CT_AircraftUpdateAmusementType] = self._CheckCondition_CT_AircraftUpdateAmusementType
  self.m_listCheckCondition[ConditionType.CT_ComPetStoryEventNum] = self._CheckCondition_CT_ComPetStoryEventNum
  self.m_listCheckCondition[ConditionType.CT_ComAssignStoryEventNum] = self._CheckCondition_CT_ComAssignStoryEventNum
  self.m_listCheckCondition[ConditionType.CT_Ambient] = self._CheckCondition_CT_Ambient
  self.m_listCheckCondition[ConditionType.CT_FurnitureNum] = self._CheckCondition_CT_FurnitureNum
end

function RoleModule:_CheckCondition(nConditionType, nParam1, nParam2, nParam3)
  local pFunction = self.m_listCheckCondition[nConditionType]
  if pFunction == nil then
    Log.error("No Support ConditionType ", nConditionType)
    return false
  end
  return pFunction(self, nParam1, nParam2, nParam3)
end

function RoleModule:_CheckCondition_CT_RoleLevel(nLevel)
  return nLevel <= self:GetLevel(), self:GetLevel(), nLevel
end

function RoleModule:_CheckCondition_CT_MissionID(nLimitCount, nMissionID)
  local moduleWork = self:GetModule(MissionModule)
  return moduleWork:IsPassMissionID(nMissionID)
end

function RoleModule:_CheckCondition_CT_ModuleUnlock(nModuleID)
  return self:CheckModuleUnlock(nModuleID)
end

function RoleModule:_CheckCondition_CT_ExMissionID(nExtTaskID)
  local moduleWork = self:GetModule(ExtMissionModule)
  return moduleWork:IsExtTaskPass(nExtTaskID)
end

function RoleModule:_CheckCondition_CT_ResDungeonID(nInstanceId)
  local moduleWork = self:GetModule(ResDungeonModule)
  return moduleWork:IsResDungeonPassed(nInstanceId)
end

function RoleModule:_CheckCondition_CT_TowerID(nTowerID)
  local moduleWork = self:GetModule(TowerModule)
  return moduleWork:IsTowerPass(nTowerID)
end

function RoleModule:_CheckCondition_CT_TowerType(nTowerType, nNeedPassLevel)
  if nTowerType < ElementType.ElementType_None or nTowerType > ElementType.ElementType_Any then
    return false
  end
  local moduleWork = self:GetModule(TowerModule)
  local nTowerLayer = 0
  local listTowerType = {
    ElementType.ElementType_Blue,
    ElementType.ElementType_Red,
    ElementType.ElementType_Green,
    ElementType.ElementType_Yellow
  }
  if ElementType.ElementType_None == nTowerType then
    for i = 1, #listTowerType do
      local nTempLayer = moduleWork:GetTowerLayer(listTowerType[i])
      if nTowerLayer > nTempLayer or i == 1 then
        nTowerLayer = nTempLayer
      end
    end
  elseif ElementType.ElementType_Any == nTowerType then
    for i = 1, #listTowerType do
      local nTempLayer = moduleWork:GetTowerLayer(listTowerType[i])
      if nTowerLayer < nTempLayer or i == 1 then
        nTowerLayer = nTempLayer
      end
    end
  else
    nTowerLayer = moduleWork:GetTowerLayer(nTowerType)
  end
  return nNeedPassLevel <= nTowerLayer, nTowerLayer, nNeedPassLevel
end

function RoleModule:_CheckCondition_CT_UnlockHeadNum(nLimitCount)
  local nCount = self:GetHeadImageUnLockCount()
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_AirRoomTypeY(nLimitCount, nRoomType)
  local workModule = self:GetModule(AircraftModule)
  local nCount = workModule:GetRoomCount(nRoomType, 0)
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_AirRoomLevelY(nLimitCount, nLimitLevel)
  local workModule = self:GetModule(AircraftModule)
  local nCount = workModule:GetRoomCountWithOutAmusement(0, nLimitLevel)
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetYElementZLevel(nLimitCount, nElementType, nLimitGrade, nLimitLevel, nLimitStar)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if (petData:GetPetFirstElement() == nElementType or 0 == nElementType) and (nLimitGrade <= petData:GetPetGrade() or 0 == nLimitGrade) and (nLimitLevel <= petData:GetPetLevel() or 0 == nLimitLevel) and (nLimitStar <= petData:GetPetStar() or 0 == nLimitStar) then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount, nElementType, nLimitGrade, nLimitLevel, nLimitStar
end

function RoleModule:_CheckCondition_CT_PetYStar(nLimitCount, nLimitStar)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if nLimitStar <= petData:GetPetStar() or 0 == nLimitStar then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetYAffinity(nLimitCount, nLimitAffinity)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if nLimitAffinity <= petData:GetPetAffinityLevel() then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetEnterAirRoom(nLimitCount)
  local nCount = self:GetModule(AircraftModule):GetAllRoomPetCount()
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetYElementZStar(nLimitCount, nElementType, nLimitStar)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if (petData:GetPetFirstElement() == nElementType or 0 == nElementType) and (nLimitStar <= petData:GetPetStar() or 0 == nLimitStar) then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetGradeY(nLimitCount, nLimitGrade)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if petData:GetPetGrade() == nLimitGrade or 0 == nLimitGrade then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetAwakeY(nLimitCount, nLimitAwake)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  for pstid, petData in pairs(petList) do
    if petData:GetPetAwakening() == nLimitAwake or 0 == nLimitAwake then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetGradeLevel(nPetTemplateID, nLimitGrade, nLimitLevel)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false, 0, 0
  end
  nLimitGrade = nLimitGrade or 0
  if nLimitGrade > petFind:GetPetGrade() then
    return false, petFind:GetPetGrade(), nLimitGrade
  end
  nLimitLevel = nLimitLevel or 0
  if nLimitLevel > petFind:GetPetLevel() then
    return false, petFind:GetPetLevel(), nLimitLevel
  end
  return true, petFind:GetPetLevel(), nLimitLevel
end

function RoleModule:_CheckCondition_CT_PetAwakeLevel(nPetTemplateID, nLimitAwake)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false, 0, 0
  end
  nLimitAwake = nLimitAwake or 0
  if nLimitAwake > petFind:GetPetAwakening() then
    return false, petFind:GetPetAwakening(), nLimitAwake
  end
  return true, petFind:GetPetAwakening(), nLimitAwake
end

function RoleModule:_CheckCondition_CT_PetAffinityLevel(nPetTemplateID, nLimitAffinity)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false, 0, 0
  end
  nLimitAffinity = nLimitAffinity or 0
  if nLimitAffinity > petFind:GetPetAffinityLevel() then
    return false, petFind:GetPetAffinityLevel(), nLimitAffinity
  end
  return true, petFind:GetPetAffinityLevel(), nLimitAffinity
end

function RoleModule:_CheckCondition_CT_PetGradeTo(nPetTemplateID, nLimitGrade)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false, 0, 0
  end
  nLimitGrade = nLimitGrade or 0
  if nLimitGrade > petFind:GetPetGrade() then
    return false, petFind:GetPetGrade(), nLimitGrade
  end
  return true, petFind:GetPetGrade(), nLimitGrade
end

function RoleModule:_CheckCondition_CT_FriendTeamPetsGradeLevel(nLimitTag, nLimitCount, nLimitGrade, nLimitLevel)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  nLimitTag = nLimitTag or 0
  nLimitGrade = nLimitGrade or 0
  nLimitLevel = nLimitLevel or 0
  for pstid, petData in pairs(petList) do
    if (0 == nLimitTag or petData:IsMyTag(nLimitTag)) and (nLimitGrade <= petData:GetPetGrade() or 0 == nLimitGrade) and (nLimitLevel <= petData:GetPetLevel() or 0 == nLimitLevel) then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_PetEquipLv(nPetTemplateID, nLimitEquipLevel)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false, 0, 0
  end
  nLimitEquipLevel = nLimitEquipLevel or 0
  if nLimitEquipLevel > petFind:GetEquipLv() then
    return false, petFind:GetEquipLv(), nLimitEquipLevel
  end
  return true, petFind:GetEquipLv(), nLimitEquipLevel
end

function RoleModule:_CheckCondition_CT_PetNumEquipLv(nLimitCount, nLimitEquipLevel)
  local nCount = 0
  local petList = self:GetModule(PetModule):GetPets()
  nLimitEquipLevel = nLimitEquipLevel or 0
  for pstid, petData in pairs(petList) do
    if petData:GetEquipLv() == nLimitEquipLevel or 0 == nLimitEquipLevel then
      nCount = nCount + 1
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_ItemCount(nItemCount, nItemID)
  local workModule = self:GetModule(ItemModule)
  local nHaveCount = workModule:GetItemCount(nItemID)
  return nItemCount <= nHaveCount, nHaveCount, nItemCount
end

function RoleModule:_CheckCondition_CT_BattleWinYTZID(nCount, nMatchType, nMatchID)
  return false
end

function RoleModule:_CheckCondition_CT_PlayerLogin(nLoginDays)
  local nHaveCount = self:GetTotalLoginDays()
  return nLoginDays <= nHaveCount, nHaveCount, nLoginDays
end

function RoleModule:_CheckCondition_CT_PlayerChangeLogin(nLoginDays)
  local nHaveCount = self:GetTotalLoginChangeDays()
  return nLoginDays <= nHaveCount, nHaveCount, nLoginDays
end

function RoleModule:_CheckCondition_CT_TotalComStoryEventNum(nLoginDays)
  local workModule = self:GetModule(AircraftModule)
  return false
end

function RoleModule:_CheckCondition_CT_QuestChatPetCompleteNum(nPetTemplateID, nLimitCount)
  local workModule = self:GetModule(QuestChatModule)
  nPetTemplateID = nPetTemplateID or 0
  local nCount = workModule:UI_StatCompleteCount(nPetTemplateID)
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_QuestChatTalkComplete(chatid, talkid)
  local workModule = self:GetModule(QuestChatModule)
  local complete = workModule:UI_StatCompleteTalkInChat(chatid, talkid)
  return complete
end

function RoleModule:_CheckCondition_CT_QuestChatTotalCompleteNum(nLimitCount)
  local workModule = self:GetModule(QuestChatModule)
  local nCount = workModule:UI_StatCompleteCount(0)
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_AircraftUpdateAmusementNum(nLimitCount)
  local workModule = self:GetModule(AircraftModule)
  local nCount = 0
  local nAmusementBaseLevel = 1
  for nRoomType = AirRoomType.AmusementBegin, AirRoomType.AmusementEnd - 1 do
    nCount = nCount + workModule:GetRoomCount(nRoomType, nAmusementBaseLevel)
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_AircraftUpdateAmusementType(nRoomType)
  local workModule = self:GetModule(AircraftModule)
  local nCount = 0
  local nAmusementBaseLevel = 1
  nCount = nCount + workModule:GetRoomCount(nRoomType, nAmusementBaseLevel)
  return 1 <= nCount, nCount, 1
end

function RoleModule:_CheckCondition_CT_ComPetStoryEventNum(nLimitCount, nPetTemplateID)
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false
  end
  local nCount = petFind:GetFinishedStoryCount()
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:_CheckCondition_CT_ComAssignStoryEventNum(nStroyEventID)
  local cfg_story = Cfg.cfg_aircraft_pet_stroy_refresh[nStroyEventID]
  if nil == cfg_story then
    return false
  end
  local nPetTemplateID = cfg_story.PetID
  if nil == nPetTemplateID then
    return false
  end
  local petFind = self:GetModule(PetModule):GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    return false
  end
  local bFinish = petFind:IsFinishedStory(nStroyEventID)
  return bFinish
end

function RoleModule:_CheckCondition_CT_Ambient(nAmbientLimit)
  local workModule = self:GetModule(AircraftModule)
  local nAmbient = workModule:GetValidAmbient()
  return nAmbientLimit <= nAmbient, nAmbient, nAmbientLimit
end

function RoleModule:_CheckCondition_CT_FurnitureNum(nLimitCount, nFurnitureID)
  local workModule = self:GetModule(ItemModule)
  local furnitureList = workModule:GetItemListBySubType(ItemSubType.ItemSubType_Furniture)
  if nil == furnitureList then
    return false, 0, 0
  end
  local nCount = 0
  for nItemID, nItemCount in pairs(furnitureList) do
    if 0 == nFurnitureID or nFurnitureID == nItemID then
      nCount = nCount + nItemCount
    end
  end
  return nLimitCount <= nCount, nCount, nLimitCount
end

function RoleModule:GetLoginTme()
  return self.m_cur_login_time
end

function RoleModule:GetHeadFrameID()
  return self.m_char_info.m_nHeadFrameID
end

function RoleModule:SetIsFixItem(is_fix)
  self.is_fix = is_fix
end

function RoleModule:GetIsFix()
  return self.is_fix
end

function RoleModule:SetNotEnough(not_enough)
  self.not_enough = not_enough
end

function RoleModule:GetNotEnough()
  return self.not_enough
end

function RoleModule:GetReviewCoinAddedCount()
  return self.m_char_info.active_token_accumulative
end

function RoleModule:LoginCompleteEvent()
  if self.is_push_login_ext_data then
    return
  end
  self.is_push_login_ext_data = true
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventPushLoginComplete)
  self:Push(msg)
end
