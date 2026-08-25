local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local TMPTypewriter = CS.TMPTypewriter
local DialogContextComp, Super = System.NewClass("DialogContextComp")

function DialogContextComp:ctor(ui, binder, data)
  Super.ctor(self)
  self.ui = ui
  self.binder = binder
  self.textWaitTimer = nil
  self.contentTmpComp = self.ui.Text_Content:GetComponent(typeof(TextMeshProUGUI))
  self.shakeTmp = self.ui.Text_Content:GetComponent(typeof(CS.Z1Client.DynamicTMP))
  self.shakeTmp.enabled = true
  self.curMaxCharCount = 0
  self.data = data
end

function DialogContextComp:Awake()
  self:SetDialogText()
end

function DialogContextComp:SetFastModeAndPlaySpeed(isFastMode, playSpeed)
  self.isFastMode = Vue.ref(isFastMode)
  self.playSpeed = Vue.ref(playSpeed)
end

function DialogContextComp:ClearDialogText()
  self.binder:SetText(self.ui.Text_Content, "")
end

function DialogContextComp:SetDialogText()
  local dialogInfo = self.data.dialogInfo
  if not self.ui.Text_Content.activeInHierarchy then
    self.binder:BindTimer(0.2, 0, nil, function()
      self:SetDialogText()
    end)
    return
  end
  if self.ui.Image_Next_Icon then
    self.ui.Image_Next_Icon:SetActive(false)
  end
  local content = StrUtils.ReplaceAvgContent(dialogInfo.Content, false)
  self.isTextToErrCode = string.find(content, "<Change>", 0, true)
  content = string.replace(content, "<Change>", "", true)
  self.binder:SetText(self.ui.Text_Content, content)
  local isActiveShake = true
  if isActiveShake then
    self.ui.Text_Content:SetActive(false)
    self.ui.Text_Content:SetActive(true)
    self.shakeTmp:CheckShakeRange()
  end
  self.contentTmpComp:ForceMeshUpdate()
  local textInfo = self.contentTmpComp.textInfo
  local maxCharacterNum = textInfo and textInfo.characterCount or 0
  if 0 == maxCharacterNum then
    maxCharacterNum = #content / 2
  end
  self.curMaxCharCount = maxCharacterNum
  self.compTMPTypewriter = TMPTypewriter.Get(self.contentTmpComp.gameObject)
  self.compTMPTypewriter.chAppearSpeed = tonumber(DT.GetConstant("AvgDialog_OneWordTime")) or 0.05
  self.compTMPTypewriter.chFadeInSpeed = 0.5
  self.compTMPTypewriter.showErrCode = self.isTextToErrCode ~= nil and self.isTextToErrCode ~= false
  self.compTMPTypewriter.chAppearPace = self:GetScale()
  
  function self.compTMPTypewriter.onAppearedFinished()
    self:PrintTextDone()
  end
  
  self.compTMPTypewriter:StartPrinting()
end

function DialogContextComp:StopTyping()
  if self:IsPrinting() then
    self.compTMPTypewriter:ToEnd(true)
  else
    self:PrintTextDone()
  end
end

function DialogContextComp:GetScale()
  if self.isFastMode.value then
    return 4
  end
  if 1 == self.playSpeed.value then
    return 1
  end
  if 2 == self.playSpeed.value then
    return 3
  end
  if 4 == self.playSpeed.value then
    return 100
  end
  return self.playSpeed.value
end

function DialogContextComp:IsPrinting()
  return self.compTMPTypewriter and self.compTMPTypewriter.enabled and not self.compTMPTypewriter:IsDone()
end

function DialogContextComp:IsWaitToRead()
  return self.textWaitTimer
end

function DialogContextComp:PrintTextDone()
  if self.ui.Image_Next_Icon then
    self.ui.Image_Next_Icon:SetActive(true)
  end
  self.timeOfPrintDown = CS.Framework.TimeUtil.GetRealtimeSinceStartup()
  if self.isTextToErrCode then
    self.compTMPTypewriter:ShowOrgString()
    self.binder:BindTimer(0.1, 0, nil, function()
      self.shakeTmp:ShowErrCodeString()
    end)
  end
  local autoDelay = tonumber(DT.GetConstant("AvgDialog_BubbleAutoDelay", false)) or 1
  self.textWaitTimer = self.binder:BindTimer(autoDelay, 0, nil, function()
    self.textWaitTimer = nil
  end)
end

return DialogContextComp
