_class("ResStoryData", Object)
ResStoryData = ResStoryData

function ResStoryData:Constructor()
  self.TypeList = {}
end

_class("BookModule", GameModule)
BookModule = BookModule

function BookModule:GetCGStoryData()
  self.mCGStoryData.TypeList = {}
  for i = BookCGType.Main, BookCGType.Max do
    self.mCGStoryData.TypeList[i] = {}
  end
  local openList = self:GetShowCfgs()
  local displayAllData = self:DisplayAllCGStoryData()
  for key, value in pairs(openList) do
    local ids, act = self:GetStoryIdList(value)
    if ids ~= nil then
      if displayAllData then
        self.mCGStoryData.TypeList[value.Type][key] = true
      else
        self.mCGStoryData.TypeList[value.Type][key] = act
      end
    end
  end
  return self.mCGStoryData
end

function BookModule:GetShowCfgs()
  local cfgv = Cfg.cfg_cg_book()
  local ret = {}
  for key, value in pairs(cfgv) do
    if self:CheckTimeUnLock(value) then
      ret[key] = value
    end
  end
  return ret
end

function BookModule:GetShowCfgsWithType(bookType)
  local cfgv = Cfg.cfg_cg_book()
  local ret = {}
  for key, value in pairs(cfgv) do
    if value.Type == bookType and self:CheckTimeUnLock(value) then
      table.insert(ret, value)
    end
  end
  return ret
end

function BookModule:CheckTimeUnLock(cfg)
  if GameSingle then
    return true
  end
  if cfg.UnLockTime then
    if not self._svrTimeModule then
      self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    end
    if not self._loginModule then
      self._loginModule = GameGlobal.GetModule(LoginModule)
    end
    local type = cfg.TimeTransform
    local timeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
    if type and type == 0 then
      timeType = Enum_DateTimeZoneType.E_ZoneType_GMT
    end
    local svrTime = self._svrTimeModule:GetServerTime() * 0.001
    local openTime = self._loginModule:GetTimeStampByTimeStr(cfg.UnLockTime, timeType)
    return svrTime >= openTime
  end
  return true
end

function BookModule:GetResBookData(tagId)
  if tagId == nil then
    return nil
  end
  local cv = Cfg.cfg_pet_tags[tagId]
  if cv == nil then
    return nil
  end
  if cv.BookType == BookRoleType.Pet then
    return self:GetPetData()
  elseif cv.BookType == BookRoleType.Monster then
    return self:GetLevelData()
  end
  return nil
end

function BookModule:GetPetData()
  local info = {}
  local cfgft = Cfg.cfg_pet_tags()
  for key, value in pairs(cfgft) do
    if value.tagType == PetTagType.Friend then
      info[key] = {}
    end
  end
  local cfgv = Cfg.cfg_pet()
  for key, value in pairs(cfgv) do
    if value.FriendTeam ~= 0 then
      local ds = self.mPetModule:GetPetByTemplateId(key)
      if ds ~= nil then
        if info[value.FriendTeam] then
          info[value.FriendTeam][key] = ds:GetPstID()
        end
      elseif info[value.FriendTeam] then
        info[value.FriendTeam][key] = 0
      end
    elseif value.AloneGroup ~= 0 then
      local ds = self.mPetModule:GetPetByTemplateId(key)
      if ds ~= nil then
        if info[value.AloneGroup] then
          info[value.AloneGroup][key] = ds:GetPstID()
        end
      elseif info[value.AloneGroup] then
        info[value.AloneGroup][key] = 0
      end
    end
  end
  return info
end

function BookModule:GetLevelData()
  local ids = self.mRoleModule:GetLevelInfo()
  local info = {}
  local cfgft = Cfg.cfg_pet_tags()
  for key, value in pairs(cfgft) do
    if value.tagType == PetTagType.Friend then
      info[key] = {}
    end
  end
  
  local function cb(monsterId, isPass)
    local mon = Cfg.cfg_monster[monsterId]
    if mon ~= nil and mon.ClassID > 0 then
      local moncla = Cfg.cfg_monster_class[mon.ClassID]
      if moncla ~= nil and 0 < moncla.bookShowClassId then
        local monsterBook = Cfg.cfg_monster_book[moncla.bookShowClassId]
        if not monsterBook then
          Log.fatal("缺少ID：", moncla.bookShowClassId)
        elseif monsterBook.FriendTeam ~= 0 then
          if isPass == true then
            info[monsterBook.FriendTeam][monsterBook.ID] = monsterId
          else
            local a = info[monsterBook.FriendTeam][monsterBook.ID]
            if not a or a <= 0 then
              info[monsterBook.FriendTeam][monsterBook.ID] = 0
            end
          end
        elseif monsterBook.AloneGroup ~= 0 then
          if isPass == true then
            info[monsterBook.AloneGroup][monsterBook.ID] = monsterId
          else
            if not info[monsterBook.AloneGroup] then
              Log.fatal("cfg_pet_tags 表中没有该id，请检查：", monsterBook.AloneGroup)
            end
            local a = info[monsterBook.AloneGroup][monsterBook.ID]
            if not a or a <= 0 then
              info[monsterBook.AloneGroup][monsterBook.ID] = 0
            end
          end
        end
      end
    end
  end
  
  local cfgvv = Cfg.cfg_level()
  for lvId, value in pairs(cfgvv) do
    for kk, vv in pairs(value.MonsterBook) do
      cb(vv, ids[lvId])
    end
    for kk, vv in pairs(value.MonsterWave) do
      local cmwvv = Cfg.cfg_monster_wave[vv]
      if cmwvv ~= nil then
        local crvv = Cfg.cfg_refresh[cmwvv.WaveBeginRefreshID]
        if crvv ~= nil then
          local len = #crvv.MonsterRefreshIDList
          if len == 1 then
            local cmrd = Cfg.cfg_refresh_monster[crvv.MonsterRefreshIDList[1]]
            if cmrd ~= nil and cmrd.MonsterIDList ~= nil then
              for krmd, vrmd in pairs(cmrd.MonsterIDList) do
                cb(vrmd, ids[lvId])
              end
            end
          end
        end
      end
    end
  end
  return info
end

function BookModule:GetMonsterData()
  return self:GetLevelData()
end

function BookModule:Constructor()
end

function BookModule:Init()
  BookModule.super.Init(self)
  self.mMissionModule = self:GetModule(MissionModule)
  self.mExtMissionModule = self:GetModule(ExtMissionModule)
  self.mPetModule = self:GetModule(PetModule)
  self.mRoleModule = self:GetModule(RoleModule)
  self.mCGStoryData = ResStoryData:New()
  self.mUnlockAllCGData = false
  self.caller:RegisterPushHandler(CEventPushUnlockCG, self.HandleGetCGStoryData, self)
end

function BookModule:HandleGetCGStoryData(msg)
  Log.debug("[BookModule] HandleGetCGStoryData unlock CGbook")
  self.mUnlockAllCGData = true
  self:GetCGStoryData()
  local loginModule = GameGlobal.GetModule(LoginModule)
  LocalDB.SetInt("CGBook" .. loginModule:GetRoleShowID(), 1)
end

function BookModule:Dispose()
  BookModule.super.Dispose(self)
end

function BookModule:Update()
end

function BookModule:GetStoryIdList(cfgValue)
  if cfgValue == nil then
    return nil
  end
  if cfgValue.Type == BookCGType.Main then
    return self:GetMissionStory(cfgValue.MissionId[1], cfgValue.MissionId[2])
  elseif cfgValue.Type == BookCGType.Ext then
    return self:GetExtMissionStory(cfgValue.ExtMissionId[1], cfgValue.ExtMissionId[2])
  elseif cfgValue.Type == BookCGType.Season then
    return self:GetSeasonStory(cfgValue)
  elseif cfgValue.Type == BookCGType.Pet then
    return self:GetPetSkin(cfgValue.SkinID)
  end
  return nil
end

function BookModule:GetSeasonStory(cfg)
  if GameSingle then
    return 0, true
  end
  if cfg.SeasonMissionID then
    local missionid = cfg.SeasonMissionID[1]
    local type = cfg.SeasonMissionID[2]
    local isactive = self.mMissionModule:IsMissionStoryActive(missionid, type)
    if not isactive then
      return 0, false
    end
  end
  if cfg.LockCondition then
    local lock = self.mRoleModule:UI_CheckLockCondition(cfg.LockCondition)
    if lock then
      return 0, false
    end
  end
  return 0, true
end

function BookModule:GetPetSkin(skinID)
  local petModule = GameGlobal.GetModule(PetModule)
  local cfg_pet_skin = Cfg.cfg_pet_skin[skinID]
  if not cfg_pet_skin then
    Log.error("###[BookModule] cfg_pet_skin is nil ! id --> ", skinID)
  end
  local petid = cfg_pet_skin.PetId
  local petSkinData = GameGlobal.GetModule(PetModule):GetPetSkinsData(petid)
  local hadSkin = false
  if petSkinData and petSkinData.skin_info then
    for _, skinInfo in pairs(petSkinData.skin_info) do
      if skinInfo.skin_id == skinID and skinInfo.unlock_CG == 1 then
        hadSkin = true
        break
      end
    end
  end
  local cfg_pet_skin_story_id = cfg_pet_skin.StoryId
  return cfg_pet_skin_story_id, hadSkin
end

function BookModule:GetMissionStory(missionID, missionType)
  local isactive = self.mMissionModule:IsMissionStoryActive(missionID, missionType)
  local cfg_mission_story = Cfg.cfg_mission_story[missionID]
  if not cfg_mission_story then
    Log.exception("cfg_mission_story中缺少配置:", missionID)
  end
  local storyActiveType = cfg_mission_story.StoryActiveType
  local idx = 0
  for i = 1, #storyActiveType do
    if storyActiveType[i] == missionType then
      idx = i
      break
    end
  end
  local mMission = self:GetModule(MissionModule)
  local discoveryData = mMission:GetDiscoveryData()
  local chapter = discoveryData:GetChapterByStageId(missionID)
  if chapter then
    return Cfg.cfg_mission_story[missionID].StoryID[idx], isactive
  end
end

function BookModule:GetExtMissionStory(missionID, missionType)
  local isactive = self.mExtMissionModule:IsMissionStoryActive(missionID, missionType)
  local cfg_extra_mission_story = Cfg.cfg_extra_mission_story({ExtMissionTaskID = missionID})[1]
  local storyActiveType = cfg_extra_mission_story.StoryActiveType
  local idx = 0
  for i = 1, #storyActiveType do
    if storyActiveType[i] == missionType then
      idx = i
      break
    end
  end
  return Cfg.cfg_extra_mission_story({ExtMissionTaskID = missionID})[1].StoryID[idx], isactive
end

function BookModule:DisplayAllCGStoryData()
  if GameSingle then
    return true
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  if self.mUnlockAllCGData or LocalDB.GetInt("CGBook" .. loginModule:GetRoleShowID(), 0) == 1 then
    return true
  else
    return false
  end
end

function BookModule:GetMultiSpinesSkinCgs()
  local petModule = GameGlobal.GetModule(PetModule)
  local skins = {}
  local cfgs = Cfg.cfg_cg_book({Type = 5})
  if not cfgs then
    return skins
  end
  for k, subCfg in pairs(cfgs) do
    if subCfg.SkinID and petModule:HaveSkin(subCfg.SkinID) then
      table.insert(skins, subCfg)
    end
  end
  return skins
end
