local ActivityLevelsLvCtrl = class("ActivityLevelsLvCtrl", BaseCtrl)
local lvIndexTitle = "{0}-{1}"
ActivityLevelsLvCtrl._mapNodeConfig = {
  tog = {sComponentName = "UIButton"},
  Select = {},
  unSelect = {},
  txt_Select = {sComponentName = "TMP_Text"},
  txt_unSelect = {sComponentName = "TMP_Text"},
  rt_Targets = {},
  btnTarget = {sComponentName = "Button", nCount = 3},
  rtLockInfo = {},
  imgLockMask = {},
  imgDbMask = {},
  imgDbMask2 = {},
  imgMaskStar1 = {},
  imgMaskStar2 = {},
  bgCondition = {},
  rtLockPreLv = {},
  redH = {},
  AnimSwitch = {sComponentName = "Animator"},
  imgSlc = {},
  goUnOpen = {}
}

function ActivityLevelsLvCtrl:InitData(parent, nType, activityData, data, isOpen, isLevelUnLock)
  self._mapNode.imgSlc:SetActive(false)
  local txtLockConditionTime = self._mapNode.bgCondition.transform:Find("txtLockCondition"):GetComponent("TMP_Text")
  if self.timerRun ~= nil then
    self.timerRun:Pause(true)
    self.timerRun = nil
  end
  self._mapNode.Select:SetActive(false)
  self.lvLock = false
  self.isOpening = isOpen
  if isOpen and isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(true)
    for i = 1, 3 do
      self._mapNode.btnTarget[i].interactable = i <= data.Star
    end
    self._mapNode.rtLockInfo:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(false)
    self._mapNode.bgCondition:SetActive(false)
    self._mapNode.goUnOpen:SetActive(false)
    self._mapNode.imgDbMask:SetActive(false)
    self._mapNode.imgDbMask2:SetActive(false)
    self._mapNode.imgMaskStar1:SetActive(false)
    self._mapNode.imgMaskStar2:SetActive(false)
  elseif isOpen and not isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(true)
    self._mapNode.bgCondition:SetActive(false)
    self._mapNode.goUnOpen:SetActive(false)
    self._mapNode.imgDbMask:SetActive(false)
    self._mapNode.imgDbMask2:SetActive(false)
    self._mapNode.imgMaskStar1:SetActive(false)
    self._mapNode.imgMaskStar2:SetActive(false)
  elseif not isOpen then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(true)
    self._mapNode.rtLockPreLv:SetActive(false)
    self._mapNode.bgCondition:SetActive(true)
    self._mapNode.goUnOpen:SetActive(false)
    self._mapNode.imgDbMask:SetActive(true)
    self._mapNode.imgDbMask2:SetActive(false)
    self._mapNode.imgMaskStar1:SetActive(false)
    self._mapNode.imgMaskStar2:SetActive(false)
    local day = activityData:GetUnLockDay(nType, data.baseData.Id)
    if day == 0 then
      local function timerCount()
        local hour, min, sec = parent.activityLevelsData:GetUnLockHour(nType, data.baseData.Id)
        
        if 0 < hour then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color_Common"), "08d3d4", hour))
        elseif 0 < min then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color_Common"), "08d3d4", min))
        elseif 0 < sec then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color_Common"), "08d3d4", sec))
        end
      end
      
      timerCount()
      self.timerRun = self:AddTimer(0, 1, function()
        timerCount()
      end, true, true, false)
    else
      NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color_Common"), "08d3d4", day))
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
    self:SetDefault(true, isOpen)
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
end

function ActivityLevelsLvCtrl:SetDefault(isOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  if not self.isOpening then
    if isOn then
      self._mapNode.imgDbMask:SetActive(false)
      self._mapNode.imgDbMask2:SetActive(true)
      self._mapNode.imgMaskStar1:SetActive(true)
      self._mapNode.imgMaskStar2:SetActive(true)
    else
      self._mapNode.imgDbMask:SetActive(true)
      self._mapNode.imgDbMask2:SetActive(false)
      self._mapNode.imgMaskStar1:SetActive(false)
      self._mapNode.imgMaskStar2:SetActive(false)
    end
  end
  if not isOn then
    self:ShowArrowAni(false)
  end
  self._mapNode.Select:SetActive(isOn)
  self._mapNode.unSelect:SetActive(not isOn)
  self._mapNode.imgSlc:SetActive(isOn)
  self._mapNode.txt_Select.gameObject:SetActive(isOn)
  self._mapNode.txt_unSelect.gameObject:SetActive(not isOn)
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
