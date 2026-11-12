local EventReminderCellCtrl = class("EventReminderCellCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local IconPath = "Icon/ZZZOther/"
EventReminderCellCtrl._mapNodeConfig = {
  imgTitleIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  rtReward = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReward = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Jump"
  },
  btnUnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UnJump"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtBtnUnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  txtLock = {sComponentName = "TMP_Text"},
  txtUnopen = {sComponentName = "TMP_Text"},
  ImgProgressIcon = {sComponentName = "Image"},
  txtProgress = {sNodeName = "txtProgess", sComponentName = "TMP_Text"},
  imgTimeIcon = {nCount = 3, sComponentName = "Image"},
  txtTime = {sComponentName = "TMP_Text"},
  imgTimeLine = {}
}
EventReminderCellCtrl._mapEventConfig = {}
EventReminderCellCtrl._mapRedDotConfig = {}

function EventReminderCellCtrl:SetData(data)
  self.data = data
  self.cfg = ConfigTable.GetData("EventReminder", self.data.nId)
  self:RefreshUI()
end

function EventReminderCellCtrl:RefreshUI()
  self:SetPngSprite(self._mapNode.imgTitleIcon, self.cfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, self:GetName())
  for i = 1, 2 do
    local nItemId = self.cfg["Item" .. i .. "Id"]
    self._mapNode.btnReward[i].gameObject:SetActive(0 < nItemId)
    if nItemId == 0 then
      self._mapNode.btnReward[i].gameObject:SetActive(false)
    else
      self._mapNode.rtReward[i]:SetItem(nItemId)
      self._mapNode.btnReward[i].gameObject:SetActive(true)
    end
  end
  self:SetTime()
  self:SetProgress()
  self:SetJumpTo()
end

function EventReminderCellCtrl:GetName()
  if self.data == nil then
    return ""
  end
  if not self.data.bUnlock then
    return self.cfg.Name
  end
  if self.data.nType == GameEnum.EventReminderType.Vampire and self.data.tbCusParam.bSeasonUnlock and self.data.tbCusParam.bHardUnlock and self.data.tbCusParam.nSeason ~= nil then
    return self.cfg.Name .. orderedFormat(ConfigTable.GetUIText("Level_Season_Count"), self.data.tbCusParam.nSeason)
  end
  if self.data.nType == GameEnum.EventReminderType.ScoreBoss and not self.data.tbCusParam.bSettlement and self.data.tbCusParam.nSeason ~= nil then
    return self.cfg.Name .. orderedFormat(ConfigTable.GetUIText("Level_Season_Count"), self.data.tbCusParam.nSeason)
  end
  return self.cfg.Name
end

function EventReminderCellCtrl:SetTime()
  if self.data == nil then
    return
  end
  for i = 1, 3 do
    self._mapNode.imgTimeIcon[i].gameObject:SetActive(false)
  end
  self._mapNode.txtTime.gameObject:SetActive(false)
  self._mapNode.imgTimeLine.gameObject:SetActive(false)
  if self.data.nType == GameEnum.EventReminderType.ScoreBoss and self.data.tbCusParam ~= nil and self.data.tbCusParam.bSettlement then
    return
  end
  local nEndTime = PlayerData.EventReminder:GetEndTime(self.data.nType)
  if nEndTime == 0 then
    return
  end
  local nRemainTime = nEndTime - CS.ClientManager.Instance.serverTimeStamp
  if nRemainTime <= 0 then
    return
  end
  local sTimeStr = ""
  if nRemainTime <= 60 then
    local sec = math.floor(nRemainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < nRemainTime and nRemainTime <= 3600 then
    local min = math.floor(nRemainTime / 60)
    local sec = math.floor(nRemainTime - min * 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    local hour = math.floor(nRemainTime / 3600)
    local min = math.floor((nRemainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < nRemainTime then
    local day = math.floor(nRemainTime / 86400)
    local hour = math.floor((nRemainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTime, sTimeStr)
  self._mapNode.txtTime.gameObject:SetActive(true)
  self._mapNode.imgTimeLine.gameObject:SetActive(true)
  for i = 1, 3 do
    self._mapNode.imgTimeIcon[i].gameObject:SetActive(false)
  end
  if nRemainTime >= self.cfg.LimitDay2 * 86400 then
    self._mapNode.imgTimeIcon[1].gameObject:SetActive(true)
  elseif nRemainTime >= self.cfg.LimitDay * 86400 then
    self._mapNode.imgTimeIcon[2].gameObject:SetActive(true)
  else
    self._mapNode.imgTimeIcon[3].gameObject:SetActive(true)
  end
end

function EventReminderCellCtrl:SetProgress()
  if self.data == nil then
    return
  end
  self._mapNode.txtUnopen.gameObject:SetActive(false)
  self._mapNode.ImgProgressIcon.gameObject:SetActive(false)
  self._mapNode.txtProgress.gameObject:SetActive(false)
  if not self.data.bUnlock then
    local sStr = PlayerData.EventReminder:GetEventReminderLockTips(self.data.nType)
    NovaAPI.SetTMPText(self._mapNode.txtUnopen, sStr)
    self._mapNode.txtUnopen.gameObject:SetActive(true)
    return
  end
  if self.data.nType == GameEnum.EventReminderType.Vampire then
    if self.data.tbCusParam.bSeasonUnlock then
      if not self.data.tbCusParam.bHardUnlock then
        NovaAPI.SetTMPText(self._mapNode.txtUnopen, ConfigTable.GetUIText("Vampire_PrevLevelNotComplete"))
        self._mapNode.txtUnopen.gameObject:SetActive(true)
        return
      end
    else
      NovaAPI.SetTMPText(self._mapNode.txtUnopen, ConfigTable.GetUIText("NewTutorialsAct_WaitSeasonOpen"))
      self._mapNode.txtUnopen.gameObject:SetActive(true)
      return
    end
  end
  if self.data.nType ~= GameEnum.EventReminderType.ScoreBoss or not self.data.tbCusParam.bSettlement and self.data.tbCusParam.nSeason ~= nil then
  else
    NovaAPI.SetTMPText(self._mapNode.txtUnopen, ConfigTable.GetUIText("ScoreBoss_Settlement"))
    self._mapNode.txtUnopen.gameObject:SetActive(true)
    return
  end
  self:SetPngSprite(self._mapNode.ImgProgressIcon, self.cfg.ItemIcon)
  NovaAPI.SetTMPText(self._mapNode.txtProgress, self.data.tbProgressData.nCur .. "/" .. self.data.tbProgressData.nMax)
  self._mapNode.ImgProgressIcon.gameObject:SetActive(true)
  self._mapNode.txtProgress.gameObject:SetActive(true)
end

function EventReminderCellCtrl:SetJumpTo()
  if self.data == nil then
    return
  end
  self._mapNode.txtLock.gameObject:SetActive(false)
  self._mapNode.btnJump.gameObject:SetActive(false)
  self._mapNode.btnUnJump.gameObject:SetActive(false)
  if not self.data.bUnlock then
    self._mapNode.btnUnJump.gameObject:SetActive(true)
    return
  end
  if self.data.nType == GameEnum.EventReminderType.Vampire then
    if self.data.tbCusParam.bSeasonUnlock and self.data.tbCusParam.nSeason ~= nil then
    else
      self._mapNode.btnUnJump.gameObject:SetActive(true)
      return
    end
  else
    if self.data.nType == GameEnum.EventReminderType.ScoreBoss and self.data.tbCusParam.bSettlement then
      self._mapNode.btnUnJump.gameObject:SetActive(true)
      return
    else
    end
  end
  self._mapNode.btnJump.gameObject:SetActive(true)
end

function EventReminderCellCtrl:OnBtnClick_Reward(btn, nIndex)
  local nItemId = self.cfg["Item" .. nIndex .. "Id"]
  if nItemId == 0 then
    return
  end
  UTILS.ClickItemGridWithTips(nItemId, btn, true, true, false)
end

function EventReminderCellCtrl:OnBtnClick_Jump(btn)
  JumpUtil.JumpTo(self.cfg.JumpTo)
end

function EventReminderCellCtrl:OnBtnClick_UnJump(btn)
  if not self.data.bUnlock then
    local sStr = PlayerData.EventReminder:GetEventReminderLockTips(self.data.nType)
    EventManager.Hit(EventId.OpenMessageBox, sStr)
    return
  end
  if self.data.nType == GameEnum.EventReminderType.Vampire then
    if self.data.tbCusParam.bSeasonUnlock then
      if not self.data.tbCusParam.bHardUnlock then
        EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Vampire_PrevLevelNotComplete"))
        return
      end
    else
      local sStr = ConfigTable.GetUIText("NewTutorialsAct_WaitSeasonOpen")
      EventManager.Hit(EventId.OpenMessageBox, sStr)
      return
    end
  end
  if self.data.nType ~= GameEnum.EventReminderType.ScoreBoss or not self.data.tbCusParam.bSettlement and self.data.tbCusParam.nSeason ~= nil then
  else
    local sStr = ConfigTable.GetUIText("ScoreBoss_Settlement")
    EventManager.Hit(EventId.OpenMessageBox, sStr)
    return
  end
end

return EventReminderCellCtrl
