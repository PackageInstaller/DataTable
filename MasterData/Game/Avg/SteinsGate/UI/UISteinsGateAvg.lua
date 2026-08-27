local base = UIBaseWindow
local UISteinsGateAvg = class("UISteinsGateAvg", base)
local UINSteinsMobileAnim = require("Game.Activity23SteinsGate.UI.MobileAnim.UINSteinsMobileAnim")
local UISGAvgMobileMsgItem = require("Game.Avg.SteinsGate.UI.UISGAvgMobileMsgItem")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UISteinsGateAvg:OnInit()
  self._mobileAnim = UINSteinsMobileAnim.New()
  self._mobileAnim:Init(self.ui.animation)
  self.ui.checkSend:SetActive(false)
  self._msgItemPool = UIItemPool.New(UISGAvgMobileMsgItem, self.ui.msgItem, false)
  self.ui.dt_msg.onComplete:AddListener(BindCallback(self, self._OnMsgTweenComplete))
  self.ui.dt_msg.onUpdate:AddListener(BindCallback(self, self._OnMsgTweenUpdate))
end

function UISteinsGateAvg:InitSteinsGateAvg(avgSystem)
  self.avgSystem = avgSystem
end

function UISteinsGateAvg:ShowSGAvgMobileAnim(callBack)
  self.ui.checkSend:SetActive(false)
  self.ui.black:SetActive(true)
  self._mobileAnim:PlayTextureAnim(false, self.ui.mobile, callBack)
end

function UISteinsGateAvg:HideSGAvgMobileAnim(callBack)
  self._mobileAnim:PlayTextureAnim(true, self.ui.mobile, function()
    UIManager:DeleteWindow(UIWindowTypeID.SteinsGateAvg)
    if callBack then
      callBack()
    end
  end)
end

function UISteinsGateAvg:SGAvgMobileReceiveMsgAnim(callBack)
  self:ShowSGAvgMobileAnim(callBack)
  self.ui.black:SetActive(false)
  self:_ReceiveNewMsgNot()
end

function UISteinsGateAvg:SGAvgMobileReceiveMsg(receiveMsgCfg, callBack)
  self.ui.obj_Info:SetActive(false)
  self.ui.checkSend:SetActive(true)
  self.ui.tex_TitleName:SetIndex(1)
  local avgCtrl = self.avgSystem.avgCtrl
  self._msgItemPool:HideAll()
  local dateStr = avgCtrl:GetAvgLanguage(receiveMsgCfg.date)
  self._msgItemPool:GetOne():InitSGAvgMobileMsgItem(dateStr, 0)
  local senderStr = avgCtrl:GetAvgLanguage(receiveMsgCfg.sender)
  self._msgItemPool:GetOne():InitSGAvgMobileMsgItem(senderStr, 1)
  local titleStr = avgCtrl:GetAvgLanguage(receiveMsgCfg.title)
  self._msgItemPool:GetOne():InitSGAvgMobileMsgItem(titleStr, 2)
  self.ui.tex_Message.text = avgCtrl:GetAvgLanguage(receiveMsgCfg.contentMsg)
  self.ui.messageInfo:SetAsLastSibling()
  self.ui.scrollRect:DOKill()
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.scrollRect.transform)
  local y = self.ui.scrollRect.content.sizeDelta.y - self.ui.scrollRect.transform.sizeDelta.y
  if y <= 0 then
    if callBack then
      callBack()
    end
    return
  end
  local duration = y / 100
  CS.DG.Tweening.DOTween.Sequence():AppendInterval(3):Append(self.ui.scrollRect:DOVerticalNormalizedPos(0, duration):SetEase(CS.DG.Tweening.Ease.Linear)):AppendCallback(function()
    if callBack then
      callBack()
    end
    callBack = nil
  end):AppendInterval(3):SetLoops(-1, CS.DG.Tweening.LoopType.Restart):SetTarget(self.ui.scrollRect):SetLink(self.gameObject)
end

function UISteinsGateAvg:SGAvgMobileSendMsgAnim(sendMsgCfg, callBack)
  self:ShowSGAvgMobileAnim(function()
    self:SGAvgMobileSendMsg(sendMsgCfg, callBack)
  end)
end

function UISteinsGateAvg:SGAvgMobileSendMsg(sendMsgCfg, callBack)
  self._msgTweenTextcallBack = callBack
  self.ui.checkSend:SetActive(true)
  self.ui.black:SetActive(false)
  self.ui.tex_TitleName:SetIndex(0)
  local avgCtrl = self.avgSystem.avgCtrl
  self._msgItemPool:HideAll()
  local receiverStr = avgCtrl:GetAvgLanguage(sendMsgCfg.receiver)
  self._msgItemPool:GetOne():InitSGAvgMobileMsgItem(receiverStr, 3)
  local titleStr = avgCtrl:GetAvgLanguage(sendMsgCfg.title)
  self._msgItemPool:GetOne():InitSGAvgMobileMsgItem(titleStr, 2)
  local contentStr = avgCtrl:GetAvgLanguage(sendMsgCfg.contentMsg)
  local textSpeed = ConfigData.buildinConfig.AvgTextTweenSpeed * LanguageUtil.GetWriterSpeed()
  self.ui.dt_msg.tween:ChangeValues("", contentStr, textSpeed)
  self.ui.dt_msg:DOPlayForward()
  self.ui.messageInfo:SetAsLastSibling()
  local typerAuId = 7020
  local audioCfg = AudioManager:GetAudioCfg(typerAuId)
  avgCtrl:RecordAvgAudioSheet(audioCfg.Sheet)
  self._TyperAuBack = AudioManager:PlayAudioById(typerAuId, function()
    self._TyperAuBack = nil
  end)
end

function UISteinsGateAvg:_OnMsgTweenUpdate()
  if IsNull(self.gameObject) then
    return
  end
  self.ui.scrollRect.verticalNormalizedPosition = 0
end

function UISteinsGateAvg:_OnMsgTweenComplete()
  if self._msgTweenTextcallBack then
    self._msgTweenTextcallBack()
  end
  self._msgTweenTextcallBack = nil
  if self._TyperAuBack ~= nil then
    AudioManager:StopAudioByBack(self._TyperAuBack)
    self._TyperAuBack = nil
  end
end

function UISteinsGateAvg:_ReceiveNewMsgNot()
  self.ui.checkSend:SetActive(true)
  self.ui.obj_Info:SetActive(true)
  self.ui.obj_ReceiveBg:SetActive(true)
  self.ui.tex_Info:SetIndex(0)
end

function UISteinsGateAvg:SendMsgConfirmSGAnim(callBack)
  self:_SendMsgNot(false)
  TimerManager:StopTimer(self._confirmSendTimer)
  self._confirmSendTimer = TimerManager:StartTimer(3, function()
    self:_SendMsgNot(true)
    if callBack then
      callBack()
    end
  end)
end

function UISteinsGateAvg:_SendMsgNot(isComplete)
  self.ui.obj_Info:SetActive(true)
  self.ui.obj_ReceiveBg:SetActive(false)
  self.ui.tex_Info:SetIndex(isComplete and 2 or 1)
  if isComplete then
    local typerAuId = 7023
    local audioCfg = AudioManager:GetAudioCfg(typerAuId)
    self.avgSystem.avgCtrl:RecordAvgAudioSheet(audioCfg.Sheet)
    AudioManager:PlayAudioById(typerAuId)
  end
end

function UISteinsGateAvg:OnDelete()
  self._mobileAnim:Delete()
  self._msgItemPool:DeleteAll()
  TimerManager:StopTimer(self._confirmSendTimer)
  base.OnDelete(self)
end

return UISteinsGateAvg
