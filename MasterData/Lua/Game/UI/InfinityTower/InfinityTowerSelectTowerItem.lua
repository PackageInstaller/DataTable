local InfinityTowerSelectTowerItem = class("InfinityTowerSelectTowerItem", BaseCtrl)
local texNameColor = {
  Color(0.8901960784313725, 0.8901960784313725, 0.8901960784313725, 1),
  Color(0.611764705882353, 0.611764705882353, 0.611764705882353, 1)
}
InfinityTowerSelectTowerItem._mapNodeConfig = {
  tex_Name = {sComponentName = "TMP_Text"},
  obj_Passed = {},
  bg_1 = {sComponentName = "Image"},
  obj_LockTime = {},
  obj_UnLock = {},
  tex_UnLock = {sComponentName = "TMP_Text"},
  obj_week = {},
  tex_Week = {sComponentName = "TMP_Text"},
  obj_Property = {},
  img_Property = {sComponentName = "Image"},
  tex_LevelCount = {sComponentName = "TMP_Text"},
  obj_PropertyBlock = {}
}
InfinityTowerSelectTowerItem._mapEventConfig = {}

function InfinityTowerSelectTowerItem:InitTowerMsg(index)
  self.towerId = index
  self._mapNode.obj_Passed:SetActive(false)
  self._mapNode.obj_LockTime:SetActive(false)
  self._mapNode.obj_UnLock:SetActive(false)
  self._mapNode.obj_week:SetActive(false)
  local sPath = "Icon/MapChallenge/zs_infinitytower_lspic_0" .. index - 1
  NovaAPI.SetImageSprite(self._mapNode.bg_1, Settings.AB_ROOT_PATH .. sPath .. ".png")
  local towerData = ConfigTable.GetData("InfinityTower", index)
  NovaAPI.SetTMPText(self._mapNode.tex_Name, towerData.Name)
  NovaAPI.SetTMPColor(self._mapNode.tex_Name, texNameColor[1])
  NovaAPI.SetImageColor(self._mapNode.bg_1, Color(1, 1, 1, 1))
  local isOpenDay = PlayerData.InfinityTower:CheckOpenDay(index)
  local openDayLength = #towerData.OpenDay
  local isUnLock = PlayerData.InfinityTower:CheckTowerUnLock(self.towerId, towerData.PreTowerLevelId)
  local passAll = PlayerData.InfinityTower:GetTowerPassAll(index)
  if index == 1 then
    local activityBg = self.gameObject.transform:Find("AnimRoot/activityBg").gameObject
    local openDayActivityId = ConfigTable.GetConfigNumber("InfinityOpenDayActivityId")
    local activityData = PlayerData.Activity:GetActivityDataById(openDayActivityId)
    if activityData ~= nil then
      local curTimeStamp = CS.ClientManager.Instance.serverTimeStamp
      if curTimeStamp > activityData.nOpenTime and curTimeStamp < activityData.nEndTime then
        self.activityRemainTime = activityData.nEndTime - curTimeStamp
        local tex_Activity = activityBg.transform:Find("imgActTipsBg/tex_Activity"):GetComponent("TMP_Text")
        local txtActTime = activityBg.transform:Find("imgActTimeBg/txtActTime"):GetComponent("TMP_Text")
        NovaAPI.SetTMPText(tex_Activity, ConfigTable.GetUIText("Infinity_OpenDay_Activity"))
        NovaAPI.SetTMPText(txtActTime, self:GetTimeStr(self.activityRemainTime))
        
        local function refreshTime()
          self.activityRemainTime = self.activityRemainTime - 1
          NovaAPI.SetTMPText(txtActTime, self:GetTimeStr(self.activityRemainTime))
          if self.activityRemainTime <= 0 and self.timer ~= nil then
            self.timer:Cancel()
            self.timer = nil
          end
        end
        
        self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
        activityBg:SetActive(true)
      else
        activityBg:SetActive(false)
      end
    else
      activityBg:SetActive(false)
    end
  end
  if passAll then
    NovaAPI.SetTMPText(self._mapNode.tex_LevelCount, ConfigTable.GetUIText("Infinity_Clear"))
  else
    local lastLv = PlayerData.InfinityTower:GetTowerPassLv(self.towerId)
    local diff = 0
    if lastLv == 0 then
      diff = 1
    else
      local nextLv = lastLv + 1
      local lvData = ConfigTable.GetData("InfinityTowerLevel", nextLv)
      if lvData then
        local diffData = ConfigTable.GetData("InfinityTowerDifficulty", lvData.DifficultyId)
        diff = diffData.Sort
      end
    end
    NovaAPI.SetTMPText(self._mapNode.tex_LevelCount, string.format(ConfigTable.GetUIText("Infinity_Diff"), diff))
  end
  NovaAPI.SetTMPColor(self._mapNode.tex_LevelCount, texNameColor[1])
  self._mapNode.obj_PropertyBlock:SetActive(false)
  self._mapNode.obj_Property:SetActive(isUnLock and towerData.ElementType ~= GameEnum.elementType.NONE)
  self._mapNode.tex_Name.gameObject:SetActive(isUnLock)
  self._mapNode.tex_LevelCount.gameObject:SetActive(isUnLock)
  self:SetAtlasSprite(self._mapNode.img_Property, "12_rare", AllEnum.ElementIconType.Icon .. towerData.ElementType)
  local btn = self.gameObject:GetComponent("UIButton")
  btn.onClick:RemoveAllListeners()
  
  local function clickCb()
    if not isUnLock then
      local strTips = orderedFormat(ConfigTable.GetUIText("InfinityTower_LockTips"), towerData.Name)
      EventManager.Hit(EventId.OpenMessageBox, strTips)
      return
    elseif openDayLength == 0 then
      local strTips = ConfigTable.GetUIText("InfinityTower_OpenNone")
      EventManager.Hit(EventId.OpenMessageBox, strTips)
      return
    elseif not isOpenDay then
      EventManager.Hit("Infinity_Select_Tower", self.towerId, true, true)
    else
      EventManager.Hit("Infinity_Select_Tower", self.towerId, true, true)
    end
  end
  
  btn.onClick:AddListener(clickCb)
  if not isUnLock then
    self._mapNode.obj_UnLock:SetActive(true)
    local towerLvDate = ConfigTable.GetData("InfinityTowerLevel", towerData.PreTowerLevelId)
    NovaAPI.SetTMPText(self._mapNode.tex_UnLock, orderedFormat(ConfigTable.GetUIText("InfinityTower_Lock"), towerLvDate.Name))
    NovaAPI.SetImageColor(self._mapNode.bg_1, Color(1, 1, 1, 0.5))
    NovaAPI.SetTMPColor(self._mapNode.tex_Name, texNameColor[2])
    NovaAPI.SetTMPColor(self._mapNode.tex_LevelCount, texNameColor[2])
  else
    self._mapNode.tex_Name.gameObject:SetActive(true)
    if not isOpenDay then
      self._mapNode.obj_LockTime:SetActive(true)
      NovaAPI.SetTMPColor(self._mapNode.tex_Name, texNameColor[2])
      NovaAPI.SetTMPColor(self._mapNode.tex_LevelCount, texNameColor[2])
      self._mapNode.obj_week:SetActive(true)
      self.totalSec = PlayerData.InfinityTower:GetNextDaySec(self.towerId)
      if self.totalSec > 0 then
        if self.timerCountDown then
          self.timerCountDown = nil
        end
        if self.timerCountDown == nil then
          self.timerCountDown = self:AddTimer(0, 1, "SetCountdownOpen", false, true, false)
        end
        self:SetCountdownOpen()
        self.timerCountDown:Pause(false)
      else
        NovaAPI.SetTMPText(self._mapNode.tex_Week, "")
      end
      NovaAPI.SetImageColor(self._mapNode.bg_1, Color(1, 1, 1, 0.5))
      self._mapNode.obj_PropertyBlock:SetActive(true)
      return
    end
    if passAll then
      self._mapNode.obj_Passed:SetActive(true)
      NovaAPI.SetTMPColor(self._mapNode.tex_Name, texNameColor[2])
      NovaAPI.SetTMPColor(self._mapNode.tex_LevelCount, texNameColor[2])
      NovaAPI.SetImageColor(self._mapNode.bg_1, Color(1, 1, 1, 0.5))
      self._mapNode.obj_PropertyBlock:SetActive(true)
    else
    end
  end
end

function InfinityTowerSelectTowerItem:SetCountdownOpen()
  self.totalSec = self.totalSec - 1
  if self.totalSec > 3600 then
    local nHour = math.floor(self.totalSec / 3600)
    NovaAPI.SetTMPText(self._mapNode.tex_Week, string.format(ConfigTable.GetUIText("Infinity_Hour_Open"), nHour))
  elseif self.totalSec > 60 then
    local nMin = math.floor(self.totalSec / 60)
    NovaAPI.SetTMPText(self._mapNode.tex_Week, string.format(ConfigTable.GetUIText("Infinity_Min_Open"), nMin))
  elseif self.totalSec > 0 then
    NovaAPI.SetTMPText(self._mapNode.tex_Week, string.format(ConfigTable.GetUIText("Infinity_Sec_Open"), self.totalSec))
  else
    NovaAPI.SetTMPText(self._mapNode.tex_Week, "")
  end
end

function InfinityTowerSelectTowerItem:GetTimeStr(nRemainTime)
  local sTimeStr = ""
  if nRemainTime <= 60 then
    local sec = math.floor(nRemainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < nRemainTime and nRemainTime <= 3600 then
    local min = math.floor(nRemainTime / 60)
    local sec = math.floor(nRemainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    local hour = math.floor(nRemainTime / 3600)
    local min = math.floor((nRemainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < nRemainTime then
    local day = math.floor(nRemainTime / 86400)
    local hour = math.floor((nRemainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function InfinityTowerSelectTowerItem:OnDisable()
end

return InfinityTowerSelectTowerItem
