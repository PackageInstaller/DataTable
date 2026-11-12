local ActivityLevelsLvCtrl = class("ActivityLevelsLvCtrl", BaseCtrl)
local lvIndexTitle = "{0}-{1}"
local colorLockSelectImage = Color(0.047058823529411764, 0.1803921568627451, 0.23529411764705882, 1)
local colorLockUnSelectImage = Color(0.047058823529411764, 0.1803921568627451, 0.23529411764705882, 1)
ActivityLevelsLvCtrl._mapNodeConfig = {
  tog = {sComponentName = "UIButton"},
  Select = {},
  unSelect = {},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  rt_Targets = {},
  btnTarget = {sComponentName = "Button", nCount = 3},
  rtLockInfo = {},
  rtLockInfoDay = {sComponentName = "Image"},
  imgLockMask = {},
  bgCondition = {},
  rtLockPreLv = {},
  rtLockPreLvSelect = {sComponentName = "Image"},
  redH = {},
  AnimRoot = {sComponentName = "Animator"},
  AnimSwitch = {sComponentName = "Animator"}
}

function ActivityLevelsLvCtrl:InitData(parent, nType, activityData, data, isOpen, isLevelUnLock, isPreLevelOpen)
  local txtLockConditionTime = self._mapNode.bgCondition.transform:Find("txtLockCondition"):GetComponent("TMP_Text")
  if self.timerRun ~= nil then
    self.timerRun:Pause(true)
    self.timerRun = nil
  end
  self.circleAni = self._mapNode.unSelect.transform:Find("imgdb/imgdb/circle").gameObject
  self.imgdb_glowAni = self._mapNode.unSelect.transform:Find("imgdb/imgdb/imgdb_glow/imgdb_glow").gameObject
  self._mapNode.Select:SetActive(false)
  self.lvLock = false
  self._mapNode.rtLockInfoDay.gameObject:SetActive(false)
  self.isShowTexLv = false
  self.isOpen = isOpen
  if isOpen and isLevelUnLock then
    self.isShowTexLv = true
    self._mapNode.rt_Targets:SetActive(true)
    for i = 1, 3 do
      self._mapNode.btnTarget[i].interactable = i <= data.Star
    end
    self._mapNode.rtLockInfo:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(false)
    self._mapNode.bgCondition:SetActive(false)
    self._mapNode.AnimRoot:Play("ActivityToggle_in_ready")
    self:AddTimer(1, data.baseData.Difficulty * 0.1, function()
      self._mapNode.AnimRoot:Play("ActivityToggle_in")
    end, true, true, true)
  elseif isOpen and not isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(true)
    self._mapNode.bgCondition:SetActive(false)
    self._mapNode.AnimRoot:Play("ActivityToggle_in_ready")
    self:AddTimer(1, data.baseData.Difficulty * 0.1, function()
      self._mapNode.AnimRoot:Play("ActivityToggle_in")
    end, true, true, true)
  elseif not isOpen then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(true)
    self._mapNode.rtLockInfoDay.gameObject:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(false)
    if data.baseData.Difficulty ~= 1 then
      self._mapNode.bgCondition:SetActive(isPreLevelOpen)
    else
      self._mapNode.bgCondition:SetActive(true)
    end
    self._mapNode.AnimRoot:Play("ActivityToggle_in_lockready")
    self:AddTimer(1, data.baseData.Difficulty * 0.1, function()
      self._mapNode.AnimRoot:Play("ActivityToggle_in_lock")
    end, true, true, true)
    local day = activityData:GetUnLockDay(nType, data.baseData.Id)
    if day == 0 then
      local function timerCount()
        local hour, min, sec = parent.activityLevelsData:GetUnLockHour(nType, data.baseData.Id)
        
        if 0 < hour then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color_Common"), "f0e1c0", hour))
        elseif 0 < min then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color_Common"), "f0e1c0", min))
        elseif 0 < sec then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color_Common"), "f0e1c0", sec))
        end
      end
      
      timerCount()
      self.timerRun = self:AddTimer(0, 1, function()
        timerCount()
      end, true, true, false)
    else
      NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color_Common"), "f0e1c0", day))
    end
    self.lvLock = true
  end
  local strTitle = ""
  if nType == GameEnum.ActivityLevelType.Explore then
    strTitle = orderedFormat(lvIndexTitle, 1, data.baseData.Difficulty)
  elseif nType == GameEnum.ActivityLevelType.Adventure then
    strTitle = orderedFormat(lvIndexTitle, 2, data.baseData.Difficulty)
  elseif nType == GameEnum.ActivityLevelType.HARD then
    strTitle = orderedFormat(lvIndexTitle, 3, data.baseData.Difficulty)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_Select, strTitle)
  NovaAPI.SetTMPText(self._mapNode.txt_unSelect, strTitle)
  self._mapNode.tog.onClick:RemoveAllListeners()
  
  local function clickCb()
    if self._mapNode.Select.activeSelf == true then
      return
    end
    self:SetDefault(true)
    parent:SetSelectObj(self)
    parent:RefreshInstanceInfo(nType, data.baseData.Difficulty, false)
    parent.activityLevelsData:ChangeRedDot(nType, data.baseData.Id)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  end
  
  self._mapNode.tog.onClick:AddListener(clickCb)
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(parent.nActId)
  if bInActGroup then
    if nType == GameEnum.ActivityLevelType.Explore then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Explore_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redH)
    elseif nType == GameEnum.ActivityLevelType.Adventure then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Adventure_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redH)
    elseif nType == GameEnum.ActivityLevelType.HARD then
      RedDotManager.RegisterNode(RedDotDefine.ActivityLevel_Hard_Level, {
        nActGroupId,
        data.baseData.Id
      }, self._mapNode.redH)
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.CtrlDotweenAnimation(self.circleAni, 2)
    NovaAPI.CtrlDotweenAnimation(self.imgdb_glowAni, 2)
  end
  
  cs_coroutine.start(wait)
end

function ActivityLevelsLvCtrl:SetDefault(isOn)
  if not isOn then
    self:ShowArrowAni(false)
  end
  self._mapNode.Select:SetActive(isOn)
  self._mapNode.unSelect:SetActive(true)
  self._mapNode.txt_Select.gameObject:SetActive(isOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not isOn)
  if isOn then
    NovaAPI.SetImageColor(self._mapNode.rtLockInfoDay, colorLockSelectImage)
    NovaAPI.SetImageColor(self._mapNode.rtLockPreLvSelect, colorLockSelectImage)
    self._mapNode.AnimSwitch.enabled = true
    self._mapNode.AnimSwitch:Play("DecoRoot_in")
    NovaAPI.CtrlDotweenAnimation(self.circleAni, 1)
    NovaAPI.CtrlDotweenAnimation(self.imgdb_glowAni, 1)
  else
    NovaAPI.SetImageColor(self._mapNode.rtLockInfoDay, colorLockUnSelectImage)
    NovaAPI.SetImageColor(self._mapNode.rtLockPreLvSelect, colorLockUnSelectImage)
    NovaAPI.CtrlDotweenAnimation(self.circleAni, 2)
    NovaAPI.CtrlDotweenAnimation(self.imgdb_glowAni, 2)
  end
  if not self.isOpen then
    self._mapNode.imgLockMask:SetActive(not isOn)
  end
end

function ActivityLevelsLvCtrl:ShowArrowAni(isShow)
end

function ActivityLevelsLvCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
end

function ActivityLevelsLvCtrl:OnDisable()
  if self.timerRun ~= nil then
    self.timerRun:Pause(true)
    self.timerRun = nil
  end
end

return ActivityLevelsLvCtrl
