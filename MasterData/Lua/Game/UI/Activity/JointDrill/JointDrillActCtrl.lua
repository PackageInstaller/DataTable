local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillActCtrl = class("JointDrillActCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
JointDrillActCtrl._mapNodeConfig = {
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Detail"
  },
  btnWaitStart = {
    sComponentName = "UIButton",
    callback = "OnEvent_WaitStart"
  },
  txtBtnWaitStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Act_Wait_Start"
  },
  imgBtnMask = {},
  btnStart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtBtnStart = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Act_Goto"
  },
  txtActDesc = {sComponentName = "TMP_Text"},
  txtActTime = {sComponentName = "TMP_Text"},
  txtFuncLock = {sComponentName = "TMP_Text"},
  txtBeta = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Beta_Tip"
  },
  goCommon = {
    sNodeName = "---Common---"
  }
}
JointDrillActCtrl._mapEventConfig = {
  PlayJointDrillActAnim = "OnEvent_PlayAnim"
}

function JointDrillActCtrl:InitActData(actData)
  self.actData = actData
  self.nActId = actData:GetActId()
  self.mapActCfg = self.actData:GetJointDrillActCfg()
  if self.mapActCfg == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtActDesc, self.mapActCfg.DescText)
  self:StartActTimer()
  local bPlayCond, sTips = self.actData:CheckActJumpCond()
  self._mapNode.txtFuncLock.gameObject:SetActive(not bPlayCond)
  if not bPlayCond then
    NovaAPI.SetTMPText(self._mapNode.txtFuncLock, sTips)
  end
end

function JointDrillActCtrl:GetTimeStr(nRemainTime)
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

function JointDrillActCtrl:StartActTimer()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
  local nOpenTime = self.actData:GetActOpenTime()
  local nCloseTime = self.actData:GetActEndTime()
  local nStartTime = nOpenTime + self.mapActCfg.DrillStartTime
  local nEndTime = nStartTime + self.mapActCfg.DrillDurationTime
  local nStatus = 0
  
  local function refreshTime()
    local nCurTime = ClientManager.serverTimeStamp
    local sTime = ""
    local nRemainTime = 0
    if nCurTime < nStartTime then
      nStatus = AllEnum.JointDrillActStatus.WaitStart
      nRemainTime = math.max(nStartTime - nCurTime, 0)
      sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Act_Wait_Start_Time"), self:GetTimeStr(nRemainTime))
    elseif nCurTime >= nStartTime and nCurTime < nEndTime then
      nStatus = AllEnum.JointDrillActStatus.Start
      nRemainTime = math.max(nEndTime - nCurTime, 0)
      sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Act_Start_Time"), self:GetTimeStr(nRemainTime))
    else
      nStatus = AllEnum.JointDrillActStatus.WaitClose
      nRemainTime = math.max(nCloseTime - nCurTime, 0)
      sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Act_Wait_Close_Time"), self:GetTimeStr(nRemainTime))
    end
    if nRemainTime <= 0 and self.timer ~= nil then
      self.timer:Cancel()
      self.timer = nil
    end
    self._mapNode.btnStart.gameObject:SetActive(nStatus ~= AllEnum.JointDrillActStatus.WaitStart)
    self._mapNode.btnWaitStart.gameObject:SetActive(nStatus == AllEnum.JointDrillActStatus.WaitStart)
    NovaAPI.SetTMPText(self._mapNode.txtActTime, sTime)
  end
  
  refreshTime()
  self.timer = self:AddTimer(0, 1, refreshTime, true, true, true)
end

function JointDrillActCtrl:ClearActivity()
end

function JointDrillActCtrl:OnEvent_WaitStart()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Act_Wait_Start_Tip"))
end

function JointDrillActCtrl:OnBtnClick_Start()
  local bPlayCond = self.actData:CheckActJumpCond(true)
  if not bPlayCond then
    return
  end
  EventManager.Hit("PlayJointDrillActAnim", "JointDrill_Act_01_out", function()
    EventManager.Hit(EventId.OpenPanel, JointDrillContext.GetPanelId(self.actData.nActId, "LevelSelect"), self.actData.nActId)
  end)
end

function JointDrillActCtrl:OnBtnClick_Detail()
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

function JointDrillActCtrl:OnEvent_PlayAnim(sAnim, callback)
  if self.animRoot ~= nil then
    local nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {sAnim})
    self.animRoot:Play(sAnim, 0, 0)
    self:AddTimer(1, nAnimTime, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
  elseif callback ~= nil then
    callback()
  end
end

function JointDrillActCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function JointDrillActCtrl:OnDisable()
end

return JointDrillActCtrl
