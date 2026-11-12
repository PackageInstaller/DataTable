local ActivityLevelsLvCtrl = class("ActivityLevelsLvCtrl", BaseCtrl)
ActivityLevelsLvCtrl._mapNodeConfig = {
  lockBg = {},
  UnLockBg = {},
  rt_Targets = {},
  btnTarget = {sComponentName = "Button", nCount = 3},
  lock = {},
  attaCount = {},
  texAttaCount = {sComponentName = "TMP_Text"},
  select = {},
  redDot = {}
}

function ActivityLevelsLvCtrl:InitData(parent, nType, activityData, data, isOpen, isLevelUnLock)
  if self.timerRun ~= nil then
    self.timerRun:Pause(true)
    self.timerRun = nil
  end
  self._mapNode.select:SetActive(false)
  if isOpen and isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(true)
    for i = 1, 3 do
      self._mapNode.btnTarget[i].interactable = i <= data.Star
    end
    self._mapNode.lock:SetActive(false)
    self._mapNode.attaCount:SetActive(false)
    self._mapNode.lockBg:SetActive(true)
    self._mapNode.UnLockBg:SetActive(true)
  elseif isOpen and not isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.lock:SetActive(true)
    self._mapNode.attaCount:SetActive(false)
    self._mapNode.lockBg:SetActive(true)
    self._mapNode.UnLockBg:SetActive(true)
  elseif not isOpen then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.lockBg:SetActive(true)
    self._mapNode.UnLockBg:SetActive(false)
    local day = activityData:GetUnLockDay(nType, data.baseData.Id)
    if day == 0 then
      self._mapNode.lock:SetActive(false)
      self._mapNode.attaCount:SetActive(true)
      
      local function timerCount()
        local hour, min, sec = parent.activityLevelsData:GetUnLockHour(nType, data.baseData.Id)
        if 0 < hour then
          NovaAPI.SetTMPText(self._mapNode.texAttaCount, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_NoneUnLock"), hour))
        elseif 0 < min then
          NovaAPI.SetTMPText(self._mapNode.texAttaCount, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_NoneUnLock"), min))
        elseif 0 < sec then
          NovaAPI.SetTMPText(self._mapNode.texAttaCount, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_NoneUnLock"), sec))
        end
      end
      
      timerCount()
      self.timerRun = self:AddTimer(0, 1, function()
        timerCount()
      end, true, true, false)
    else
      self._mapNode.lock:SetActive(false)
      self._mapNode.attaCount:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.texAttaCount, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_DayOpen"), day))
    end
  end
  local btn = self.gameObject:GetComponent("UIButton")
  btn.onClick:RemoveAllListeners()
  
  local function clickCb()
    if self._mapNode.select.activeSelf == true then
      return
    end
    self._mapNode.select:SetActive(true)
    parent:SetSelectObj(self._mapNode.select)
    parent:RefreshInstanceInfo(nType, data.baseData.Difficulty, nil, false)
    parent.activityLevelsData:ChangeRedDot(nType, data.baseData.Id)
  end
  
  btn.onClick:AddListener(clickCb)
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(parent.nActId)
  if bInActGroup then
    if nType == GameEnum.ActivityLevelType.Explore then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Explore_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redDot)
    elseif nType == GameEnum.ActivityLevelType.Adventure then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Adventure_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redDot)
    elseif nType == GameEnum.ActivityLevelType.HARD then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Hard_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redDot)
    end
  end
end

function ActivityLevelsLvCtrl:OnDisable()
  if self.timerRun ~= nil then
    self.timerRun:Pause(true)
    self.timerRun = nil
  end
end

return ActivityLevelsLvCtrl
