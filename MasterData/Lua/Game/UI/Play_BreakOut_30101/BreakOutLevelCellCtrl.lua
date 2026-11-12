local BreakOutLevelCellCtrl = class("BreakOutLevelCellCtrl", BaseCtrl)
BreakOutLevelCellCtrl._mapNodeConfig = {
  txt_Name = {sComponentName = "TMP_Text"},
  img_FinishIcon = {
    sNodeName = "Icon_Finish"
  },
  obj_TipTime = {
    sNodeName = "TipTimeMask"
  },
  txt_Time = {sComponentName = "TMP_Text"},
  obj_TipUnLock = {
    sNodeName = "TipsUnLockMask"
  },
  txt_Lock = {sComponentName = "TMP_Text"},
  obj_TipEndMask = {sNodeName = "TipEndMask"},
  txt_TipEnd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_End"
  },
  btnGrid = {
    sNodeName = "btnGrid",
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectLevel"
  },
  eventActBannerDrag = {
    sNodeName = "btnGrid",
    sComponentName = "UIDrag",
    callback = "OnDrag_Act"
  },
  redDotNew = {}
}
BreakOutLevelCellCtrl._mapEventConfig = {}
BreakOutLevelCellCtrl._mapRedDotConfig = {}

function BreakOutLevelCellCtrl:SetData(nActId, nLevelId, bIsActEnd)
  self.ActId = nActId
  self.bIsActEnd = bIsActEnd
  self.nActivityGroupId = ConfigTable.GetData("Activity", nActId).MidGroupId
  if self.levelData ~= nil then
    RedDotManager.UnRegisterNode(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {
      self.nActivityGroupId,
      self.levelData.Id
    }, self._mapNode.redDotNew)
  end
  self.LevelId = nLevelId
  self.BreakOutData = PlayerData.Activity:GetActivityDataById(nActId)
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    printError("活动 id:" .. self.ActId .. " 数据为空 用本地临时数据初始化")
    self:InitErrorSate()
    self.levelData = ConfigTable.GetData("BreakOutLevel", self.LevelId)
    NovaAPI.SetTMPText(self._mapNode.txt_Name, self.levelData.Name)
    return
  end
  self.levelData = self.BreakOutData:GetDetailLevelDataById(self.LevelId)
  NovaAPI.SetTMPText(self._mapNode.txt_Name, self.levelData.Name)
  self:RefreshLevelState()
end

function BreakOutLevelCellCtrl:RefreshLevelState()
  self._mapNode.obj_TipTime.gameObject:SetActive(false)
  self._mapNode.obj_TipUnLock.gameObject:SetActive(false)
  self._mapNode.obj_TipEndMask.gameObject:SetActive(false)
  self._mapNode.img_FinishIcon.gameObject:SetActive(false)
  self._mapNode.redDotNew:SetActive(false)
  self.bIsTimeOpen = self:RefreshLevelTime()
  if self.bIsTimeOpen == nil or not self.bIsTimeOpen then
    return
  end
  self._mapNode.obj_TipEndMask.gameObject:SetActive(self.bIsActEnd)
  if self.bIsActEnd then
    RedDotManager.SetValid(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {
      self.nActivityGroupId,
      self.LevelId
    }, false)
    RedDotManager.UnRegisterNode(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {
      self.nActivityGroupId,
      self.LevelId
    }, self._mapNode.redDotNew)
    return
  end
  self:RefreshLevelLockState()
  self:RefreshLevelFinishState()
  RedDotManager.RegisterNode(RedDotDefine.Activity_BreakOut_DifficultyTap_Level, {
    self.nActivityGroupId,
    self.LevelId
  }, self._mapNode.redDotNew)
end

function BreakOutLevelCellCtrl:RefreshLevelTime()
  if self.levelData == nil then
    return
  end
  if self.BreakOutData:IsLevelTimeUnlocked(self.LevelId) then
    self._mapNode.obj_TipTime.gameObject:SetActive(false)
    return true
  else
    local remainTime = self.BreakOutData:GetLevelStartTime(self.LevelId)
    local sTime = self:GetTimeText(remainTime)
    NovaAPI.SetTMPText(self._mapNode.txt_Time, orderedFormat(ConfigTable.GetUIText("TowerDef_TimeTips") or "", sTime))
    self._mapNode.obj_TipTime.gameObject:SetActive(true)
    return false
  end
end

function BreakOutLevelCellCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function BreakOutLevelCellCtrl:RefreshLevelLockState()
  if self.levelData == nil then
    return
  end
  local bIsPreLevelComplete = self.BreakOutData:IsPreLevelComplete(self.LevelId)
  if bIsPreLevelComplete or not self.bIsTimeOpen then
    self._mapNode.obj_TipUnLock.gameObject:SetActive(false)
  else
    local PreLevelIdName = self.BreakOutData:GetBreakoutPreLevelIdName(self.LevelId)
    local sTip = orderedFormat(ConfigTable.GetUIText("BreakOut_Act_OpenAfterClearingLevel") or "", PreLevelIdName)
    NovaAPI.SetTMPText(self._mapNode.txt_Lock, sTip)
    self._mapNode.obj_TipUnLock.gameObject:SetActive(true)
  end
end

function BreakOutLevelCellCtrl:RefreshLevelFinishState()
  self._mapNode.img_FinishIcon.gameObject:SetActive(self.BreakOutData:IsLevelComplete(self.LevelId))
end

function BreakOutLevelCellCtrl:OnBtnClick_SelectLevel()
  if self.BreakOutData == nil or self.BreakOutData ~= nil and self.BreakOutData:GetLevelData() == nil then
    return
  end
  local bTimeUnlock, bPreComplete = self.BreakOutData:IsLevelUnlocked(self.LevelId)
  if not bTimeUnlock or self.bIsActEnd then
    return
  end
  if not bPreComplete then
    self.BreakOutData:EnterLevelSelect(self.LevelId)
    return
  end
  self.BreakOutData:EnterLevelSelect(self.LevelId)
  if self.BreakOutData:IsAllLevelComplete() then
    self.SelectedTab = self.BreakOutData:GetBreakoutLevelDifficult(self.LevelId)
    EventManager.Hit("SetSelectedTab", self.SelectedTab)
  end
  EventManager.Hit("JumpToLevelDetail", self.ActId, self.LevelId)
end

function BreakOutLevelCellCtrl:OnDrag_Act(mDrag)
  EventManager.Hit("DragLevelList", mDrag)
end

function BreakOutLevelCellCtrl:InitErrorSate()
  self._mapNode.obj_TipTime.gameObject:SetActive(false)
  self._mapNode.obj_TipUnLock.gameObject:SetActive(false)
  self._mapNode.img_FinishIcon.gameObject:SetActive(false)
  self._mapNode.redDotNew:SetActive(false)
  self._mapNode.obj_TipEndMask.gameObject:SetActive(true)
end

return BreakOutLevelCellCtrl
