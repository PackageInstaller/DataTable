_class("GuideTrigger", Object)

function GuideTrigger:Constructor(manager)
  self.triggers = {}
  self.manager = manager
end

function GuideTrigger:AddListener()
  self.cb = GameHelper:GetInstance():CreateCallback(self.OnTrigger, self)
  GameGlobal.EventDispatcher():AddCallbackListener(self.eventType, self.cb)
end

function GuideTrigger:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(self.eventType, self.cb)
end

function GuideTrigger:PreHandleCfg(v)
end

function GuideTrigger:OnTrigger()
end

_class("GuideDoneTrigger", GuideTrigger)

function GuideDoneTrigger:Constructor()
  self.eventType = GameEventType.GuideDone
end

function GuideDoneTrigger:PreHandleCfg(v)
end

function GuideDoneTrigger:OnTrigger(id)
  if id then
    self.manager:ActivateGuide(id)
  end
end

_class("BattleStartTrigger", GuideTrigger)

function BattleStartTrigger:Constructor()
  self.eventType = GameEventType.GuideBattleStart
end

function BattleStartTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.BattleStartTrigger then
    local levelId = v.triggerParam[1]
    if not self.triggers[levelId] then
      self.triggers[levelId] = {}
    end
    table.insert(self.triggers[levelId], v)
  end
end

function BattleStartTrigger:OnTrigger(levelId, callBack)
  self.manager.skillTimesAtWave = {}
  if not levelId then
    return
  end
  local guides = self.triggers[levelId]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end

_class("RoundTrigger", GuideTrigger)

function RoundTrigger:Constructor()
  self.eventType = GameEventType.GuideRound
end

function RoundTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.RoundTrigger then
    local cfgRound = v.triggerParam
    if cfgRound then
      local roundFlag = cfgRound[1] .. "|" .. cfgRound[2] .. "|" .. cfgRound[3] .. "|" .. cfgRound[4]
      if not self.triggers[roundFlag] then
        self.triggers[roundFlag] = {}
      end
      table.insert(self.triggers[roundFlag], v)
    end
  end
end

function RoundTrigger:OnTrigger(levelId, wave, round, mOrEaction, callBack)
  if not levelId then
    return
  end
  local roundFlag = levelId .. "|" .. wave .. "|" .. round .. "|" .. mOrEaction
  local guides = self.triggers[roundFlag]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end

_class("OpenUITrigger", GuideTrigger)

function OpenUITrigger:Constructor()
  self.eventType = GameEventType.GuideOpenUI
end

function OpenUITrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.OpenUITrigger then
    local uiName = v.triggerParam[1]
    if v.triggerParam then
      if not self.triggers[uiName] then
        self.triggers[uiName] = {}
      end
      table.insert(self.triggers[uiName], v.id)
    end
  end
end

function OpenUITrigger:OnTrigger(uiName)
  if uiName then
    local guides = self.triggers[uiName]
    if not guides then
      return
    end
    for _, v in next, guides, nil do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("PlayerHandleFinishTrigger", GuideTrigger)

function PlayerHandleFinishTrigger:Constructor()
  self.eventType = GameEventType.GuidePlayerHandleFinish
end

function PlayerHandleFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlayerHandleFinishTrigger then
    local cfg = v.triggerParam
    if cfg then
      local mark = cfg[1] .. "|" .. cfg[2] .. "|" .. cfg[3] .. "|" .. cfg[4] .. "|" .. (cfg[5] or 0)
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function PlayerHandleFinishTrigger:OnTrigger(levelId, wave, round, playerHandleType, petTempId, callBack)
  if playerHandleType then
    local mark = levelId .. "|" .. wave .. "|" .. round .. "|" .. playerHandleType .. "|" .. petTempId
    local guides = self.triggers[mark]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    for _, cfg in next, guides, nil do
      self.manager:ActivateGuide(cfg.id, callBack)
    end
    return
  end
end

_class("PlaySkillFinishTrigger", GuideTrigger)

function PlaySkillFinishTrigger:Constructor()
  self.eventType = GameEventType.GuidePlayerSkillFinish
end

function PlaySkillFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlaySkillFinishTrigger then
    local cfg = v.triggerParam
    if cfg then
      local mark = cfg[1] .. "|" .. cfg[2] .. "|" .. cfg[3] .. "|" .. cfg[4] .. "|" .. (cfg[5] or 0)
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function PlaySkillFinishTrigger:OnTrigger(levelId, wave, round, playerHandleType, petTempId, callBack)
  if playerHandleType then
    local mark = levelId .. "|" .. wave .. "|" .. round .. "|" .. playerHandleType .. "|" .. petTempId
    local guides = self.triggers[mark]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    for _, cfg in next, guides, nil do
      self.manager:ActivateGuide(cfg.id, callBack)
    end
    return
  end
end

_class("LevelFinishTrigger", GuideTrigger)

function LevelFinishTrigger:Constructor()
  self.eventType = GameEventType.GuideLevelFinish
end

function LevelFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.LevelFinishTrigger and v.triggerParam then
    local levelId = v.triggerParam[1]
    if not self.triggers[levelId] then
      self.triggers[levelId] = {}
    end
    table.insert(self.triggers[levelId], v.id)
  end
end

function LevelFinishTrigger:OnTrigger(levelId, callBack)
  if levelId then
    local guides = self.triggers[levelId]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    local triggerGuide = false
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideLevelFinishAircraft, levelId, function(trigger)
      triggerGuide = trigger
    end)
    if not triggerGuide then
      for _, v in next, guides, nil do
        local cfg = Cfg.cfg_guide_trigger[v]
        if self.manager:IsGuideDone(cfg.guide) or self.manager:IsGuideDone(cfg.exclusiveGuide) then
          return
        end
        self.manager:ActivateGuide(v, callBack)
      end
    elseif callBack then
      callBack(true)
    end
    return
  end
end

_class("ShowGuideCancelAreaTrigger", GuideTrigger)

function ShowGuideCancelAreaTrigger:Constructor()
  self.eventType = GameEventType.ShowGuideCancelArea
end

function ShowGuideCancelAreaTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.ShowGuideCancelAreaTrigger then
    local cfgRound = v.triggerParam
    if cfgRound then
      local roundFlag = cfgRound[1] .. "|" .. cfgRound[2]
      if not self.triggers[roundFlag] then
        self.triggers[roundFlag] = {}
      end
      table.insert(self.triggers[roundFlag], v)
    end
  end
end

function ShowGuideCancelAreaTrigger:OnTrigger(levelId, wave, callBack)
  if not levelId then
    return
  end
  local roundFlag = levelId .. "|" .. wave
  local guides = self.triggers[roundFlag]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end

_class("PowerReadyTrigger", GuideTrigger)

function PowerReadyTrigger:Constructor()
  self.eventType = GameEventType.ShowGuidePowerReady
end

function PowerReadyTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PowerReadyTrigger then
    local cfgRound = v.triggerParam
    if cfgRound then
      local roundFlag = cfgRound[1] .. "|" .. cfgRound[2]
      if not self.triggers[roundFlag] then
        self.triggers[roundFlag] = {}
      end
      table.insert(self.triggers[roundFlag], v)
    end
  end
end

function PowerReadyTrigger:OnTrigger(levelId, wave, callBack)
  if not levelId then
    return
  end
  local roundFlag = levelId .. "|" .. wave
  local guides = self.triggers[roundFlag]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end

_class("LoginTrigger", GuideTrigger)

function LoginTrigger:Constructor()
  self.eventType = GameEventType.GuideLogin
end

function LoginTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.LoginTrigger then
    local param = v.triggerParam
    if param then
      local doneGuideId = param[1]
      local unDoneGuideId = param[2]
      local flag = doneGuideId .. "|" .. unDoneGuideId
      if not self.triggers[flag] then
        self.triggers[flag] = {}
      end
      table.insert(self.triggers[flag], v.id)
    end
  end
end

function LoginTrigger:OnTrigger(callBack)
  for flag, guides in pairs(self.triggers) do
    local param = string.split(flag, "|")
    local doneGuideId = tonumber(param[1])
    local unDoneGuideId = tonumber(param[2])
    if (0 < doneGuideId and self.manager:IsGuideDone(doneGuideId) or doneGuideId < 0) and not self.manager:IsGuideDone(unDoneGuideId) then
      for _, id in next, guides, nil do
        self.manager:ActivateGuide(id, callBack)
        local guide = self.manager.triggerGuides[id]
        if guide and self.manager:IsGuideProcess(guide:GetID()) then
          return
        end
      end
    end
  end
end

_class("BattleCompleteTrigger", GuideTrigger)

function BattleCompleteTrigger:Constructor()
  self.eventType = GameEventType.GuideBattleComplete
end

function BattleCompleteTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.BattleCompleteTrigger then
    local levelId = v.triggerParam[1]
    if not self.triggers[levelId] then
      self.triggers[levelId] = {}
    end
    table.insert(self.triggers[levelId], v.id)
  end
end

function BattleCompleteTrigger:OnTrigger(levelId)
  if not levelId then
    return
  end
  local guides = self.triggers[levelId]
  if not guides then
    return
  end
  for _, id in next, guides, nil do
    self.manager:ActivateGuide(id)
  end
end

_class("PetGradeTrigger", GuideTrigger)

function PetGradeTrigger:Constructor()
  self.eventType = GameEventType.GuideGrade
end

function PetGradeTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PetGradeTrigger then
    table.insert(self.triggers, v.id)
  end
end

function PetGradeTrigger:OnTrigger(callBack)
  for index, id in pairs(self.triggers) do
    self.manager:ActivateGuide(id, callBack)
  end
end

_class("PetAwakeTrigger", GuideTrigger)

function PetAwakeTrigger:Constructor()
  self.eventType = GameEventType.GuideAwake
end

function PetAwakeTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PetAwakeTrigger then
    table.insert(self.triggers, v.id)
  end
end

function PetAwakeTrigger:OnTrigger()
  for index, id in pairs(self.triggers) do
    self.manager:ActivateGuide(id)
  end
end

_class("RoomEnterTrigger", GuideTrigger)

function RoomEnterTrigger:Constructor()
  self.eventType = GameEventType.GuideRoomEnter
end

function RoomEnterTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.RoomEnterTrigger then
    local spaceId = v.triggerParam[1]
    if not self.triggers[spaceId] then
      self.triggers[spaceId] = {}
    end
    table.insert(self.triggers[spaceId], v.id)
  end
end

function RoomEnterTrigger:OnTrigger(spaceId, callBack)
  local guides = self.triggers[spaceId]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, id in next, guides, nil do
    self.manager:ActivateGuide(id, callBack)
  end
end

_class("ShowResSwitchTrigger", GuideTrigger)

function ShowResSwitchTrigger:Constructor()
  self.eventType = GameEventType.GuideShowResDouble
end

function ShowResSwitchTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.ShowResSwitchTrigger then
    table.insert(self.triggers, v.id)
  end
end

function ShowResSwitchTrigger:OnTrigger()
  for index, id in pairs(self.triggers) do
    self.manager:ActivateGuide(id)
  end
end

_class("MissionAutoBattleTrigger", GuideTrigger)

function MissionAutoBattleTrigger:Constructor()
  self.eventType = GameEventType.GuideMissionAutoBattle
end

function MissionAutoBattleTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.MissionAutoBattleTrigger then
    table.insert(self.triggers, v.id)
  end
end

function MissionAutoBattleTrigger:OnTrigger()
  for index, id in pairs(self.triggers) do
    self.manager:ActivateGuide(id)
  end
end

_class("ResAutoBattleTrigger", GuideTrigger)

function ResAutoBattleTrigger:Constructor()
  self.eventType = GameEventType.GuideResAutoBattle
end

function ResAutoBattleTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.ResAutoBattleTrigger then
    table.insert(self.triggers, v.id)
  end
end

function ResAutoBattleTrigger:OnTrigger()
  for index, id in pairs(self.triggers) do
    self.manager:ActivateGuide(id)
  end
end

_class("PlotEnterFinishTrigger", GuideTrigger)

function PlotEnterFinishTrigger:Constructor()
  self.eventType = GameEventType.GuidePlotEnterFinish
end

function PlotEnterFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlotEnterFinishTrigger then
    local missionId = v.triggerParam[1]
    if not self.triggers[missionId] then
      self.triggers[missionId] = {}
    end
    table.insert(self.triggers[missionId], v)
  end
end

function PlotEnterFinishTrigger:OnTrigger(missionId, callBack)
  if not missionId then
    return
  end
  local guides = self.triggers[missionId]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end

_class("LevelFinishAircraftTrigger", GuideTrigger)

function LevelFinishAircraftTrigger:Constructor()
  self.eventType = GameEventType.GuideLevelFinishAircraft
end

function LevelFinishAircraftTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.LevelFinishAircraftTrigger and v.triggerParam then
    local levelId = v.triggerParam[1]
    if not self.triggers[levelId] then
      self.triggers[levelId] = {}
    end
    table.insert(self.triggers[levelId], v)
  end
end

function LevelFinishAircraftTrigger:OnTrigger(levelId, callBack)
  if levelId then
    local guides = self.triggers[levelId]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    local module = GameGlobal.GetModule(AircraftModule)
    for _, v in next, guides, nil do
      local room = module:GetRoom(v.triggerParam[2])
      if not room then
        self.manager:ActivateGuide(v.id, callBack)
      end
    end
    return
  end
end

_class("LeaveAircraftTrigger", GuideTrigger)

function LeaveAircraftTrigger:Constructor()
  self.eventType = GameEventType.GuideLeaveAircraft
end

function LeaveAircraftTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.LeaveAircraftTrigger then
    table.insert(self.triggers, v)
  end
end

function LeaveAircraftTrigger:OnTrigger(callBack)
  for index, v in pairs(self.triggers) do
    if self.manager:IsGuideProcess(v.guide) then
      self.manager:ActivateGuide(v.id, callBack)
    end
  end
end

_class("PetGradeDoneTrigger", GuideTrigger)

function PetGradeDoneTrigger:Constructor()
  self.eventType = GameEventType.GuideGradeUpDone
end

function PetGradeDoneTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PetGradeDoneTrigger then
    local GradeLv = v.triggerParam[1]
    if not self.triggers[GradeLv] then
      self.triggers[GradeLv] = {}
    end
    table.insert(self.triggers[GradeLv], v.id)
  end
end

function PetGradeDoneTrigger:OnTrigger(gradeLv)
  if gradeLv then
    local guides = self.triggers[gradeLv]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("OpenTeamUITrigger", GuideTrigger)

function OpenTeamUITrigger:Constructor()
  self.eventType = GameEventType.GuideOpenTeamUI
end

function OpenTeamUITrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.OpenTeamUITrigger then
    local missionType = v.triggerParam[1]
    local missionID = v.triggerParam[2]
    if not self.triggers[missionType] then
      self.triggers[missionType] = {}
    end
    if not self.triggers[missionType][missionID] then
      self.triggers[missionType][missionID] = {}
    end
    table.insert(self.triggers[missionType][missionID], v.id)
  end
end

function OpenTeamUITrigger:OnTrigger(missionType, missionID)
  if missionType and missionID then
    if not self.triggers[missionType] or not self.triggers[missionType][missionID] then
      return
    end
    local guides = self.triggers[missionType][missionID]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("EntertainmentRoomUnlockTrigger", GuideTrigger)

function EntertainmentRoomUnlockTrigger:Constructor()
  self.eventType = GameEventType.GuideEntertainmentRoomUnlock
end

function EntertainmentRoomUnlockTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.EntertainmentRoomUnlockTrigger and v.triggerParam and #v.triggerParam > 0 then
    local spaceID = v.triggerParam[1]
    if not self.triggers[spaceID] then
      self.triggers[spaceID] = {}
    end
    table.insert(self.triggers[spaceID], v.id)
  end
end

function EntertainmentRoomUnlockTrigger:OnTrigger(spaceID)
  if spaceID then
    local guides = self.triggers[spaceID]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("OpenAirRoomFacilityTrigger", GuideTrigger)

function OpenAirRoomFacilityTrigger:Constructor()
  self.eventType = GameEventType.GuideOpenAirRoomFacilityUI
end

function OpenAirRoomFacilityTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.OpenAirRoomFacilityTrigger then
    local roomType = v.triggerParam[1]
    if not self.triggers[roomType] then
      self.triggers[roomType] = {}
    end
    table.insert(self.triggers[roomType], v.id)
  end
end

function OpenAirRoomFacilityTrigger:OnTrigger(roomType)
  if roomType then
    local guides = self.triggers[roomType]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("OpenAirRoomSettleTrigger", GuideTrigger)

function OpenAirRoomSettleTrigger:Constructor()
  self.eventType = GameEventType.GuideOpenAirRoomSettleUI
end

function OpenAirRoomSettleTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.OpenAirRoomSettleTrigger then
    local roomType = v.triggerParam[1]
    if not self.triggers[roomType] then
      self.triggers[roomType] = {}
    end
    table.insert(self.triggers[roomType], v.id)
  end
end

function OpenAirRoomSettleTrigger:OnTrigger(roomType)
  if roomType then
    local guides = self.triggers[roomType]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("BuildAirRoomTrigger", GuideTrigger)

function BuildAirRoomTrigger:Constructor()
  self.eventType = GameEventType.GuideBuildAirRoom
end

function BuildAirRoomTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.BuildAirRoomTrigger and v.triggerParam and #v.triggerParam > 0 then
    local spaceID = v.triggerParam[1]
    if not self.triggers[spaceID] then
      self.triggers[spaceID] = {}
    end
    table.insert(self.triggers[spaceID], v.id)
  end
end

function BuildAirRoomTrigger:OnTrigger(spaceID)
  if spaceID then
    local guides = self.triggers[spaceID]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("TaskStateTrigger", GuideTrigger)

function TaskStateTrigger:Constructor()
  self.eventType = GameEventType.GuideTaskState
end

function TaskStateTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.TaskStateTrigger and v.triggerParam and #v.triggerParam > 0 then
    local id = v.triggerParam[1]
    local state = v.triggerParam[2]
    local key = id .. "|" .. state
    if not self.triggers[key] then
      self.triggers[key] = {}
    end
    table.insert(self.triggers[key], v.id)
  end
end

function TaskStateTrigger:OnTrigger(id, state)
  if id and state then
    local key = id .. "|" .. state
    local guides = self.triggers[key]
    if not guides then
      return
    end
    for _, v in ipairs(guides) do
      self.manager:ActivateGuide(v)
    end
    return
  end
end

_class("BattleFinishTrigger", GuideTrigger)

function BattleFinishTrigger:Constructor()
  self.eventType = GameEventType.GuideBattleFinish
end

function BattleFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.BattleFinishTrigger then
    local missionID = v.triggerParam[1]
    if not self.triggers[missionID] then
      self.triggers[missionID] = {}
    end
    table.insert(self.triggers[missionID], v.id)
  end
end

function BattleFinishTrigger:OnTrigger(missionID, callBack)
  if missionID then
    local guides = self.triggers[missionID]
    if guides then
      for _, v in ipairs(guides) do
        self.manager:ActivateGuide(v, callBack)
      end
    elseif callBack then
      callBack(false)
    end
  end
end

_class("PlaySkillRealFinishTrigger", GuideTrigger)
PlaySkillRealFinishTrigger = PlaySkillRealFinishTrigger

function PlaySkillRealFinishTrigger:Constructor()
  self.eventType = GameEventType.GuidePlayerSkillRealFinish
end

function PlaySkillRealFinishTrigger:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlaySkillRealFinishTrigger then
    local cfg = v.triggerParam
    if cfg then
      local mark = cfg[1] .. "|" .. cfg[2] .. "|" .. cfg[3] .. "|" .. cfg[4] .. "|" .. (cfg[5] or 0)
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function PlaySkillRealFinishTrigger:OnTrigger(levelId, wave, round, playerHandleType, petTempId, callBack)
  if playerHandleType then
    local mark = levelId .. "|" .. wave .. "|" .. round .. "|" .. playerHandleType .. "|" .. petTempId
    local guides = self.triggers[mark]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    for _, cfg in next, guides, nil do
      self.manager:ActivateGuide(cfg.id, callBack)
    end
    return
  end
end

_class("PlaySkillRealFinishTriggerWithoutRoundLimit", GuideTrigger)
PlaySkillRealFinishTriggerWithoutRoundLimit = PlaySkillRealFinishTriggerWithoutRoundLimit

function PlaySkillRealFinishTriggerWithoutRoundLimit:Constructor()
  self.eventType = GameEventType.GuidePlayerSkillRealFinish
end

function PlaySkillRealFinishTriggerWithoutRoundLimit:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlaySkillRealFinishTriggerWithoutRoundLimit then
    local cfg = v.triggerParam
    if cfg then
      local mark = cfg[1] .. "|" .. cfg[2] .. "|" .. cfg[3] .. "|" .. cfg[4] .. "|" .. (cfg[5] or 0)
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function PlaySkillRealFinishTriggerWithoutRoundLimit:OnTrigger(levelId, wave, round, playerHandleType, petTempId, callBack)
  if playerHandleType then
    round = 0
    local mark = levelId .. "|" .. wave .. "|" .. round .. "|" .. playerHandleType .. "|" .. petTempId
    local guides = self.triggers[mark]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    for _, cfg in next, guides, nil do
      self.manager:ActivateGuide(cfg.id, callBack)
    end
    return
  end
end

_class("PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes", GuideTrigger)
PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes = PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes

function PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes:Constructor()
  self.eventType = GameEventType.GuidePlayerSkillRealFinish
end

function PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes then
    local cfg = v.triggerParam
    if cfg then
      local mark = cfg[1] .. "|" .. cfg[2] .. "|" .. cfg[3] .. "|" .. cfg[4] .. "|" .. (cfg[5] or 0)
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function PlaySkillRealFinishTriggerWithoutRoundLimitWithTimes:OnTrigger(levelId, wave, round, playerHandleType, petTempId, callBack)
  if playerHandleType then
    round = 0
    local mark = levelId .. "|" .. wave .. "|" .. round .. "|" .. playerHandleType .. "|" .. petTempId
    local guides = self.triggers[mark]
    if not guides then
      if callBack then
        callBack(false)
      end
      return
    end
    if not self.manager.skillTimesAtWave[wave] then
      self.manager.skillTimesAtWave[wave] = {}
    end
    local waveDic = self.manager.skillTimesAtWave[wave]
    local skillTimes = 0
    if not waveDic[petTempId] then
      waveDic[petTempId] = 1
      skillTimes = 1
    else
      skillTimes = waveDic[petTempId] + 1
      waveDic[petTempId] = skillTimes
    end
    for _, cfg in next, guides, nil do
      local trigerParam = cfg.triggerParam
      local paramNum = tonumber(trigerParam[6])
      if paramNum == skillTimes then
        self.manager:ActivateGuide(cfg.id, callBack)
      end
    end
    return
  end
end

_class("N28BounceGameArriveTarget", GuideTrigger)
N28BounceGameArriveTarget = N28BounceGameArriveTarget

function N28BounceGameArriveTarget:Constructor()
  self.eventType = GameEventType.N28BounceGameArriveTarget
end

function N28BounceGameArriveTarget:PreHandleCfg(v)
  if v.triggerType == GuideTriggerType.N28BounceGameArriveTarget then
    local cfg = v.triggerParam
    if cfg then
      local mark = "guide" .. cfg[1]
      if not self.triggers[mark] then
        self.triggers[mark] = {}
      end
      table.insert(self.triggers[mark], v)
    end
  end
end

function N28BounceGameArriveTarget:OnTrigger(target, callBack)
  local mark = target
  local guides = self.triggers[mark]
  if not guides then
    if callBack then
      callBack(false)
    end
    return
  end
  for _, cfg in next, guides, nil do
    self.manager:ActivateGuide(cfg.id, callBack)
  end
end
