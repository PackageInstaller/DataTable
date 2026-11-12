local ClientManager = CS.ClientManager.Instance
local ReengagementDoubleDropCtrl = class("ReengagementDoubleDropCtrl", BaseCtrl)
ReengagementDoubleDropCtrl._mapNodeConfig = {
  txtActName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_DoubleDrop_Title"
  },
  btnActDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnActDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtDoubleCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_DoubleDrop_Count"
  },
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
  }
}
ReengagementDoubleDropCtrl._mapEventConfig = {}

function ReengagementDoubleDropCtrl:Refresh(nCurTog)
  if nCurTog ~= AllEnum.ReengagementTog.DoubleDrop then
    return
  end
  self:InitActData()
end

local tbInstanceToFunc = {
  [GameEnum.instanceType.DailyInstance] = GameEnum.OpenFuncType.DailyInstance,
  [GameEnum.instanceType.RegionBoss] = GameEnum.OpenFuncType.RegionBoss,
  [GameEnum.instanceType.SkillInstance] = GameEnum.OpenFuncType.SkillInstance,
  [GameEnum.instanceType.CharGemInstance] = GameEnum.OpenFuncType.CharGemInstance
}

function ReengagementDoubleDropCtrl:InitActData()
  self.nActId = 0
  self.tbFuncType = PlayerData.Reengagement:GetDoubleFuncType()
  if self.tbFuncType == nil then
    return
  end
  self:StartActTimer()
  for k, v in ipairs(self._mapNode.goInstanceItem) do
    v.gameObject:SetActive(self.tbFuncType[k] ~= nil)
    if self.tbFuncType[k] ~= nil then
      local nFuncType = tbInstanceToFunc[self.tbFuncType[k]]
      v:InitItem(nFuncType)
      local bUnlock = PlayerData.Base:CheckFunctionUnlock(nFuncType)
      self._mapNode.btnGoto[k].gameObject:SetActive(bUnlock)
    end
  end
  local sText = ConfigTable.GetUIText("Reengagement_DoubleDrop_Count") .. PlayerData.Reengagement:GetDoubleDropCount() .. "/" .. PlayerData.Reengagement:GetMaxDoubleDropCount()
  NovaAPI.SetTMPText(self._mapNode.txtDoubleCount, sText)
end

function ReengagementDoubleDropCtrl:GetTimeStr(nRemainTime)
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

function ReengagementDoubleDropCtrl:StartActTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  local nOpenTime = PlayerData.Reengagement:GetReengagementOpenTime()
  local nCloseTime = PlayerData.Reengagement:GetReengagementCloseTime()
  
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
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
        callbackConfirm = function()
          EventManager.Hit(EventId.ClosePanel, PanelId.ReengagementPanel)
        end
      })
    end
    NovaAPI.SetTMPText(self._mapNode.txtTime, sTime)
  end
  
  refreshTime()
  self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
end

function ReengagementDoubleDropCtrl:OnBtnClick_Detail()
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

function ReengagementDoubleDropCtrl:OnBtnClick_Goto(btn, nIndex)
  local nType = self.tbFuncType[nIndex]
  if nType == nil then
    return
  end
  if nType == GameEnum.instanceType.DailyInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.DailyInstanceLevelSelect, 0, 0, true)
  elseif nType == GameEnum.instanceType.RegionBoss then
    EventManager.Hit(EventId.OpenPanel, PanelId.RogueBossLevel, 0, 0, true)
  elseif nType == GameEnum.instanceType.SkillInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillInstanceLevelSelect)
  elseif nType == GameEnum.instanceType.CharGemInstance then
    EventManager.Hit(EventId.OpenPanel, PanelId.EquipmentInstanceLevelSelect)
  end
end

return ReengagementDoubleDropCtrl
