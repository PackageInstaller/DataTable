local ActivityLevelsLvCtrl = class("ActivityLevelsLvCtrl", BaseCtrl)
local lvIndexTitle = "{0}-{1}"
local colorLockSelectImage = Color(0.23921568627450981, 0.27450980392156865, 0.3843137254901961, 1)
local colorLockUnSelectImage = Color(0.4, 0.48627450980392156, 0.5647058823529412, 1)
ActivityLevelsLvCtrl._mapNodeConfig = {
  tog = {sComponentName = "UIButton"},
  Select = {},
  SelectAni = {sNodeName = "Select", sComponentName = "Animator"},
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
  AnimSwitch = {sComponentName = "Animator"},
  imgSlc = {},
  imgDeco4 = {},
  imgDeco5 = {},
  imgDeco6 = {},
  imgDeco7 = {}
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
  elseif isOpen and not isLevelUnLock then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(false)
    self._mapNode.rtLockPreLv:SetActive(true)
    self._mapNode.bgCondition:SetActive(false)
  elseif not isOpen then
    self._mapNode.rt_Targets:SetActive(false)
    self._mapNode.rtLockInfo:SetActive(true)
    self._mapNode.imgLockMask:SetActive(true)
    self._mapNode.rtLockInfoDay.gameObject:SetActive(true)
    self._mapNode.rtLockPreLv:SetActive(false)
    self._mapNode.bgCondition:SetActive(true)
    local day = activityData:GetUnLockDay(nType, data.baseData.Id)
    if day == 0 then
      local function timerCount()
        local hour, min, sec = parent.activityLevelsData:GetUnLockHour(nType, data.baseData.Id)
        
        if 0 < hour then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Hour_Color_Common"), "ff96b7", hour))
        elseif 0 < min then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Min_Color_Common"), "ff96b7", min))
        elseif 0 < sec then
          NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Sec_Color_Common"), "ff96b7", sec))
        end
      end
      
      timerCount()
      self.timerRun = self:AddTimer(0, 1, function()
        timerCount()
      end, true, true, false)
    else
      NovaAPI.SetTMPText(txtLockConditionTime, orderedFormat(ConfigTable.GetUIText("ActivityLevels_Lock_Day_Color_Common"), "ff96b7", day))
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
end

function ActivityLevelsLvCtrl:SetDefault(isOn)
  if self._mapNode.AnimSwitch.enabled == true then
    self._mapNode.AnimSwitch.enabled = false
  end
  if not isOn then
    self:ShowArrowAni(false)
  end
  self._mapNode.Select:SetActive(isOn)
  self._mapNode.imgSlc:SetActive(isOn)
  if isOn then
    self._mapNode.SelectAni:Play("10111_ActitvityLevels_Select")
  end
  if self.lvLock then
    NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco4, 2)
    NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco5, 2)
    NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco6, 2)
    NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco7, 2)
  end
  NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco4, not (not isOn or self.lvLock) and 1 or 0)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco5, not (not isOn or self.lvLock) and 1 or 0)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco6, not (not isOn or self.lvLock) and 1 or 0)
  NovaAPI.CtrlDotweenAnimation(self._mapNode.imgDeco7, not (not isOn or self.lvLock) and 1 or 0)
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
