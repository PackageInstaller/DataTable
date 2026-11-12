local InfinityTowerActCtrl = class("InfinityTowerActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local rabbitRightId = 917302
local rabbitLeftId = 917402
InfinityTowerActCtrl._mapNodeConfig = {
  txtActTime = {sComponentName = "TMP_Text"},
  txtActDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_TowerAllOpen_Des"
  },
  txtActTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_TowerAllOpen_Tip"
  },
  btn_Go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_TowerAllOpen_Go"
  },
  imgActTimeBg = {},
  trRoot_L = {
    sNodeName = "----Actor2DLeft302----",
    sComponentName = "Transform"
  },
  trRoot_R = {
    sNodeName = "----Actor2DRight402----",
    sComponentName = "Transform"
  },
  Actor2DLeft = {
    sNodeName = "rawImg_L_302",
    sComponentName = "RawImage"
  },
  Actor2DPngL = {sNodeName = "png_L_302", sComponentName = "Transform"},
  Actor2DRight = {
    sNodeName = "rawImg_R_402",
    sComponentName = "RawImage"
  },
  Actor2DPngR = {sNodeName = "png_R_402", sComponentName = "Transform"}
}
InfinityTowerActCtrl._mapEventConfig = {}

function InfinityTowerActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self:StartActTimer()
  self.UseLive2D = LocalSettingData.mapData.UseLive2D
  self:LoadRabbit()
end

function InfinityTowerActCtrl:ClearActivity()
end

function InfinityTowerActCtrl:OnDisable()
  self:UnLoadRabbit()
end

function InfinityTowerActCtrl:GetTimeStr(nRemainTime)
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

function InfinityTowerActCtrl:StartActTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  local nStartTime = self.actData:GetActOpenTime()
  local nEndTime = self.actData:GetActEndTime()
  self.isTimeVisible = self._mapNode.imgActTimeBg.gameObject.activeSelf
  
  local function refreshTime()
    local nCurTime = ClientManager.serverTimeStamp
    local sTime = ""
    local IsTimeVisible = true
    local nRemainTime = 0
    if nCurTime >= nStartTime and nCurTime < nEndTime then
      nRemainTime = math.max(nEndTime - nCurTime, 0)
      sTime = self:GetTimeStr(nRemainTime)
    else
      nRemainTime = math.max(nEndTime - nCurTime, 0)
      sTime = self:GetTimeStr(nRemainTime)
    end
    if nRemainTime <= 0 then
      IsTimeVisible = false
      if self.timer ~= nil then
        self.timer:Cancel()
        self.timer = nil
      end
    end
    if self.isTimeVisible ~= IsTimeVisible then
      self._mapNode.imgActTimeBg.gameObject:SetActive(IsTimeVisible)
    end
    NovaAPI.SetTMPText(self._mapNode.txtActTime, sTime)
  end
  
  refreshTime()
  self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
end

function InfinityTowerActCtrl:OnBtnClick_Detail()
  if self.mapActCfg == nil then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = self.mapActCfg.DetailDesc,
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function InfinityTowerActCtrl:OnBtnClick_Go()
  local nEndTime = self.actData:GetActEndTime()
  local nCurTime = ClientManager.serverTimeStamp
  if nEndTime < nCurTime then
    return
  end
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.InfinityTowerSelectTower)
  end
  
  EventManager.Hit(EventId.SetTransition, 8, func)
end

function InfinityTowerActCtrl:LoadRabbit()
  self._mapNode.Actor2DLeft.transform.localScale = self.UseLive2D == true and Vector3.one or Vector3.zero
  self._mapNode.Actor2DRight.transform.localScale = self.UseLive2D == true and Vector3.one or Vector3.zero
  self._mapNode.Actor2DPngL.localScale = self.UseLive2D == true and Vector3.zero or Vector3.one
  self._mapNode.Actor2DPngR.localScale = self.UseLive2D == true and Vector3.zero or Vector3.one
  if self.UseLive2D == true then
    Actor2DManager.SetBoardNPC2D(PanelId.ActivityInfinity, self._mapNode.Actor2DLeft, rabbitLeftId, nil, nil, 1)
    Actor2DManager.SetBoardNPC2D(PanelId.ActivityInfinity, self._mapNode.Actor2DRight, rabbitRightId, nil, nil, 2)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.Actor2DPngL, PanelId.ActivityInfinity, rabbitLeftId)
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.Actor2DPngR, PanelId.ActivityInfinity, rabbitRightId)
  end
end

function InfinityTowerActCtrl:UnLoadRabbit()
  Actor2DManager.UnsetBoardNPC2D(1)
  Actor2DManager.UnsetBoardNPC2D(2)
end

return InfinityTowerActCtrl
