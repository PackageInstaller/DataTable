local DoubleDropActCtrl = class("DoubleDropActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
DoubleDropActCtrl._mapNodeConfig = {
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtDoubleCount = {sComponentName = "TMP_Text"},
  goInstanceItem = {
    nCount = 4,
    sCtrlName = "Game.UI.Activity.DoubleDrop.DoubleDropInsItemCtrl"
  },
  btnGoto = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Goto"
  },
  txtBtnGoto = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Double_Drops_Goto_Instance"
  },
  txtQuestTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Double_Drops_Quest_Title"
  },
  txtQuestNum = {sComponentName = "TMP_Text"},
  imgQuestFill = {
    sComponentName = "RectTransform"
  },
  btnQuestDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  redDotQuest = {}
}
DoubleDropActCtrl._mapEventConfig = {
  ReceiveDoubleDropQuest = "OnEvent_RefreshQuest"
}
local nMaxWidth = 372
local nMinWidth = 36

function DoubleDropActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.tbFuncType = self.actData:GetDoubleFuncType()
  if self.tbFuncType == nil then
    return
  end
  self:StartActTimer()
  for k, v in ipairs(self._mapNode.goInstanceItem) do
    v.gameObject:SetActive(self.tbFuncType[k] ~= nil)
    if self.tbFuncType[k] ~= nil then
      v:InitItem(self.tbFuncType[k])
      local bUnlock = PlayerData.Base:CheckFunctionUnlock(self.tbFuncType[k])
      self._mapNode.btnGoto[k].gameObject:SetActive(bUnlock)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtDoubleCount, self.actData:GetDropActString())
  RedDotManager.RegisterNode(RedDotDefine.Activity_DoubleDrop_Quest, self.nActId, self._mapNode.redDotQuest)
  self:RefreshQuest()
end

function DoubleDropActCtrl:RefreshQuest()
  local tbQuest = self.actData:GetAllQuests()
  local nAllCount, nCount = 0, 0
  for _, v in ipairs(tbQuest) do
    if v.nStatus == AllEnum.ActQuestStatus.Received then
      nCount = nCount + 1
    end
    nAllCount = nAllCount + 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestNum, string.format("%s/%s", nCount, nAllCount))
  local nHeight = self._mapNode.imgQuestFill.sizeDelta.y
  local nWidth = 0
  if 0 < nCount then
    nWidth = math.max(nMaxWidth * (nCount / nAllCount), nMinWidth)
  end
  self._mapNode.imgQuestFill.sizeDelta = Vector2(nWidth, nHeight)
end

function DoubleDropActCtrl:GetTimeStr(nRemainTime)
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

function DoubleDropActCtrl:StartActTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  local nOpenTime = self.actData:GetActOpenTime()
  local nCloseTime = self.actData:GetActEndTime()
  
  local function refreshTime()
    local nCurTime = ClientManager.serverTimeStamp
    local sTime = ""
    local nRemainTime = math.max(nCloseTime - nCurTime, 0)
    if nCurTime >= nCloseTime then
      sTime = ConfigTable.GetUIText("Activity_End")
    elseif nCurTime >= nOpenTime then
      sTime = self:GetTimeStr(nRemainTime)
    end
    if nRemainTime <= 0 and self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
    NovaAPI.SetTMPText(self._mapNode.txtTime, sTime)
  end
  
  refreshTime()
  self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
end

function DoubleDropActCtrl:ClearActivity()
end

function DoubleDropActCtrl:OnBtnClick_Detail()
  local mapActCfg = ConfigTable.GetData("ActivityDouble", self.nActId)
  if mapActCfg == nil then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = mapActCfg.DesText,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DoubleDropActCtrl:OnBtnClick_Goto(btn, nIndex)
  local nType = self.tbFuncType[nIndex]
  if nType == nil then
    return
  end
  if nType == GameEnum.OpenFuncType.DailyInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceLevelSelect, 0, 0, true)
  elseif nType == GameEnum.OpenFuncType.RegionBoss then
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel, 0, 0, true)
  elseif nType == GameEnum.OpenFuncType.SkillInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillInstanceLevelSelect)
  elseif nType == GameEnum.OpenFuncType.CharGemInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInstanceLevelSelect)
  end
end

function DoubleDropActCtrl:OnBtnClick_Quest()
  EventManager.Hit(EventId.OpenPanel, PanelId.DoubleDropActQuestPanel_103001, self.nActId)
end

function DoubleDropActCtrl:OnEvent_RefreshQuest()
  self:RefreshQuest()
end

function DoubleDropActCtrl:OnEnable()
end

function DoubleDropActCtrl:OnDisable()
end

return DoubleDropActCtrl
