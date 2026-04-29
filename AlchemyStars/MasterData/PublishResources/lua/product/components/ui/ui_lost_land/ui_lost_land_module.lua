_class("UILostLandModule", UIModule)
UILostLandModule = UILostLandModule

function UILostLandModule:Dispose()
end

function UILostLandModule:Constructor()
  self._module = GameGlobal.GetModule(LostAreaModule)
  self._nextTime = 0
  self._pet_award_count = 5
  self._filterType = UILostLandFilterType.OR
  self._currentEnterData = nil
  self:CreateConditionFunc()
end

function UILostLandModule:GetPetAwardCount()
  return self._pet_award_count
end

function UILostLandModule:GetPetAwardInfo()
  return self._recommend_reward
end

function UILostLandModule:GetCurrentEnterData()
  return self._currentEnterData
end

function UILostLandModule:InitEnterData()
  self._enterList = {}
  self._enter_cfg_map = self._module:GetLostAreaDesignConfig()
  self._level_cfg_map = self._module:GetLostAreaLevelGroupConfig()
  self._nextTime, self._enterStatusMap = self._module:GetDifficultyStatusData()
  self:CreateEnterData()
  for key, value in pairs(self._enter_cfg_map) do
    self._recommend_reward = value.recommend_reward
    self._recommendList = value.recommend_cond
  end
end

function UILostLandModule:CreateEnterData()
  for id, status in pairs(self._enterStatusMap) do
    local cfg = self._enter_cfg_map[id]
    local enterData = UILostLandEnterData:New(id, status, cfg, self._level_cfg_map)
    table.insert(self._enterList, enterData)
  end
  table.sort(self._enterList, function(a, b)
    return a:GetType() < b:GetType()
  end)
end

function UILostLandModule:CreateMissionMap(missionStatusMap)
  Log.debug("###[UILostLandModule] 创建关卡数据")
  self._missionMap = {}
  self._currentStageID = nil
  local enterData = self:GetCurrentEnterData()
  local missionTable = enterData:GetMissionTable()
  for i = 1, #missionTable do
    local group = missionTable[i]
    for j = 1, #group do
      local missionid = group[j]
      local info = missionStatusMap[missionid]
      if not self._currentStageID and info.pass_time <= 0 then
        self._currentStageID = missionid
      end
      local missionData = self:CreateMissionDataByMissionID(missionid, info, self._currentStageID)
      self._missionMap[missionid] = missionData
    end
  end
  if not self._currentStageID then
    local group = missionTable[#missionTable]
    local stage = group[#group]
    self._currentStageID = stage
  end
end

function UILostLandModule:CreateMissionDataByMissionID(missionid, missionInfo, currentid)
  local cfg = self:GetLevelCfgByID(missionid)
  local missionData = UILostLandMissionData:New(missionid, cfg, missionInfo, currentid)
  return missionData
end

function UILostLandModule:GetCurrentStageID()
  return self._currentStageID
end

function UILostLandModule:ChooseEnter(enterData)
  GameGlobal.UIStateManager():Lock("UILostLandModule:ChooseEnter")
  GameGlobal.TaskManager():StartTask(self._OnChooseEnter, self, enterData)
end

function UILostLandModule:_OnChooseEnter(TT, enterData)
  local enterid = enterData:GetEnterID()
  local res = self._module:RequestLostAreaChooseWeekDifficulty(TT, enterid)
  GameGlobal.UIStateManager():UnLock("UILostLandModule:ChooseEnter")
  if res:GetSucc() then
    local missionStatusMap = self._module:GetLostAreadifficultyMission()
    self._currentEnterData = enterData
    self:CreateMissionMap(missionStatusMap)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UILostLandStage)
  else
    Log.error("###[UILostLandModule] UILostLandModule:_OnChooseEnter fail ! result --> ", res:GetResult())
  end
end

function UILostLandModule:ResetTime(resetDialog)
  GameGlobal.UIStateManager():Lock("UILostLandModule:ResetTime")
  GameGlobal.TaskManager():StartTask(self._OnResetTime, self, resetDialog)
end

function UILostLandModule:_OnResetTime(TT, resetDialog)
  local res = self._module:RequestLostAreadifficultyStatus(TT)
  GameGlobal.UIStateManager():UnLock("UILostLandModule:ResetTime")
  if res:GetSucc() then
    self:InitEnterData()
    self:ResetTimeEvent(resetDialog)
  else
    Log.error("###[UILostLandModule] RequestLostAreadifficultyStatus fail ! result --> ", res:GetResult())
  end
end

function UILostLandModule:ResetTimeEvent(resetDialog)
  if resetDialog == UILostLandResetTimeDialog.Main then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnLostLandTimeReset)
  elseif resetDialog == UILostLandResetTimeDialog.Stage then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UILostLandMain, true)
  elseif resetDialog == UILostLandResetTimeDialog.BattleEnd then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UILostLandMain, true)
  end
end

function UILostLandModule:GetResetTime()
  return self._nextTime
end

function UILostLandModule:Time2Tex(sec)
  local timeStr = ""
  local minAll = sec // 60
  local min = minAll % 60
  local hourAll = minAll // 60
  local hour = hourAll % 24
  local day = hourAll // 24
  if day and 0 < day then
    timeStr = StringTable.Get("str_lost_land_reset_time_day_and_hour", day, hour)
    return timeStr
  end
  if hour and 0 < hour then
    timeStr = StringTable.Get("str_lost_land_reset_time_hour_and_min", hour, min)
    return timeStr
  end
  if min and 0 < min then
    timeStr = StringTable.Get("str_lost_land_reset_time_only_min", min)
    return timeStr
  end
  timeStr = StringTable.Get("str_lost_land_reset_time_only_sec")
  return timeStr
end

function UILostLandModule:SwitchState()
  GameGlobal.UIStateManager():Lock("UILostLandModule:SwitchState")
  GameGlobal.TaskManager():StartTask(self._OnSwitchState, self)
end

function UILostLandModule:_OnSwitchState(TT)
  local res = self._module:RequestLostAreadifficultyStatus(TT)
  GameGlobal.UIStateManager():UnLock("UILostLandModule:SwitchState")
  if res:GetSucc() then
    self:InitEnterData()
    self:_ShowDialog()
  else
    Log.error("###[UILostLandModule] self._module:RequestLostAreadifficultyStatus fail ! result --> ", res:GetResult())
  end
end

function UILostLandModule:_ShowDialog()
  local choose = false
  for key, value in pairs(self._enterStatusMap) do
    if value == DifficultyStatus.DS_ThisWeekChoosed then
      self._currentEnterData = self:GetEnterDataByID(key)
      choose = true
      break
    end
  end
  if choose then
    GameGlobal.UIStateManager():Lock("UILostLandModule:_ShowDialog")
    GameGlobal.TaskManager():StartTask(self._OnShowDialog, self)
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UILostLandMain)
  end
end

function UILostLandModule:_OnShowDialog(TT)
  local currentid = self._currentEnterData:GetEnterID()
  local res = self._module:RequestLostAreadifficultyMission(TT, currentid)
  GameGlobal.UIStateManager():UnLock("UILostLandModule:_ShowDialog")
  if res:GetSucc() then
    local missionStatusMap = self._module:GetLostAreadifficultyMission()
    self:CreateMissionMap(missionStatusMap)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UILostLandStage)
  else
    Log.error("###[UILostLandModule] self._module:RequestLostAreadifficultyStatus fail ! result --> ", res:GetResult())
  end
end

function UILostLandModule:GetEnterDataByID(id)
  if self._enterList and #self._enterList then
    for i = 1, #self._enterList do
      local enterData = self._enterList[i]
      local enterid = enterData:GetEnterID()
      if enterid == id then
        return enterData
      end
    end
  end
end

function UILostLandModule:GetEnterCfgByID(id)
  local enterCfg = self._enter_cfg_map[id]
  return enterCfg
end

function UILostLandModule:GetEnterData()
  return self._enterList
end

function UILostLandModule:GetMissionDataByMissionID(missionid)
  return self._missionMap[missionid]
end

function UILostLandModule:GetLevelCfgByID(stageid)
  return self._level_cfg_map[stageid]
end

function UILostLandModule:DeleteData()
end

function UILostLandModule:CheckPetRecommend(pstid)
  if self._recommendList and table.count(self._recommendList) > 0 then
    if not self._petModule then
      self._petModule = GameGlobal.GetModule(PetModule)
    end
    local pet = self._petModule:GetPet(pstid)
    for i = 1, #self._recommendList do
      local innerOne = false
      local recommend = self._recommendList[i]
      local condition = recommend.cond1
      local filter = recommend.cond2
      innerOne = self._conditionFunc[condition](filter, pet)
      if self._filterType == UILostLandFilterType.OR then
        if innerOne then
          return true
        end
      elseif self._filterType == UILostLandFilterType.AND and not innerOne then
        return false
      end
    end
    if self._filterType == UILostLandFilterType.OR then
      return false
    elseif self._filterType == UILostLandFilterType.AND then
      return true
    end
  else
    Log.error("###[UILostLandModule] self._recommendList is nil or empty !")
  end
end

function UILostLandModule:GetRecommendConditionList()
  return self._recommendList
end

function UILostLandModule:CreateConditionFunc()
  self._conditionFunc = {}
  self._conditionFunc[PetFilterCondType.RFCT_Color] = function(filterColor, pet)
    if not pet then
      return false
    end
    local petColor = pet:GetPetFirstElement()
    if petColor == filterColor then
      return true
    end
    return false
  end
  self._conditionFunc[PetFilterCondType.RFCT_Force] = function(filterForce, pet)
    if not pet then
      return false
    end
    local petTags = pet:GetPetTags()
    for i = 1, #petTags do
      local tag = petTags[i]
      if tag == filterForce then
        return true
      end
    end
    return false
  end
  self._conditionFunc[PetFilterCondType.RFCT_Prof] = function(filterProf, pet)
    if not pet then
      return false
    end
    local petProf = pet:GetProf()
    if petProf == filterProf then
      return true
    end
    return false
  end
end

local UILostLandResetTimeDialog = {
  Main = 1,
  Stage = 2,
  BattleEnd = 3
}
_enum("UILostLandResetTimeDialog", UILostLandResetTimeDialog)
