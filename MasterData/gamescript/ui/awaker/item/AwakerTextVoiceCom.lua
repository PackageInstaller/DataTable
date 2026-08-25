local TextMeshProUGUI = CS.TMPro.TextMeshProUGUI
local RectTransform = CS.UnityEngine.RectTransform
local Mathf = CS.UnityEngine.Mathf
local ScrollRect = CS.UnityEngine.UI.ScrollRect
local DefaultShowLineCnt = 3
local Wait2Clear = 1
local AwakerTextVoiceCom, Super = System.NewComponent("AwakerTextVoiceCom")

function AwakerTextVoiceCom:ctor(model, uiScrollView, ui_Text_Voice)
  Super.ctor(self)
  self.ui_ScrollView = uiScrollView
  self.ui_Text_Voice = ui_Text_Voice
  self.textPrintTimer = nil
  self.Wait2CloseTimer = nil
  self.ScrollMoveTimer = nil
  self.contentTmpComp = self.ui_Text_Voice:GetComponent(typeof(TextMeshProUGUI))
  self.ScrollViewCom = self.ui_ScrollView:GetComponent(typeof(ScrollRect))
  self.curMaxCharCount = 0
  self.model = model
end

function AwakerTextVoiceCom:OnBind(binder)
  self.binder = binder
  self:SetPlaySpeed(10)
  self.binder:onDestroy(function()
    TimerManager.Instance:StopTimer(self.textPrintTimer)
  end)
  binder:BindToRaw(function(_, _, _)
    self:UpdateVoiceText()
  end, function()
    return self.model.curAwakerVoiceContent
  end)
  self.ui_Text_Voice:SetActive(true)
end

function AwakerTextVoiceCom:SetPlaySpeed(playSpeed)
  self.playSpeed = Vue.ref(playSpeed)
end

function AwakerTextVoiceCom:ClearDialogText()
  self.model:SetCurAwakerVoice("", "")
end

function AwakerTextVoiceCom:ClearPrintTimer()
  self.binder:StopTimer(self.textPrintTimer)
  self.textPrintTimer = nil
end

function AwakerTextVoiceCom:ClearWait2CloseTimer()
  self.binder:StopTimer(self.Wait2CloseTimer)
  self.Wait2CloseTimer = nil
end

function AwakerTextVoiceCom:ClearScrollMoveTimer()
  self.binder:StopTimer(self.ScrollMoveTimer)
  self.ScrollMoveTimer = nil
end

function AwakerTextVoiceCom:UpdateVoiceText()
  self:ClearPrintTimer()
  self:ClearWait2CloseTimer()
  self:ClearScrollMoveTimer()
  self.ScrollViewCom.verticalNormalizedPosition = 1
  local content = self.model.curAwakerVoiceContent
  if "" == content then
    return
  end
  local data = LT.Text(content)
  self.binder:SetText(self.ui_Text_Voice, data)
  StrUtils.SetPreferredHeight(self.ui_Text_Voice)
  local cnt = utf8.len(data) + 1
  local maxCharacterNum = cnt
  self.curMaxCharCount = maxCharacterNum
  self.contentTmpComp.maxVisibleCharacters = 0
  local nowCharacterNum = 0
  self.textPrintTimer = TimerManager.Instance:CreateTimer(0.05, maxCharacterNum, function()
    local addCount = self:GetScale()
    nowCharacterNum = nowCharacterNum + addCount
    self.contentTmpComp.maxVisibleCharacters = math.min(maxCharacterNum, nowCharacterNum)
    if nowCharacterNum >= maxCharacterNum then
      self:ClearPrintTimer()
      local soundEventName = self.model.curAwakerVoiceEventName
      local soundDuration = AudioManager.Instance:GetEventDuration(soundEventName)
      local totalLineCnt = self:GetTextLineCnt()
      local leftLineCnt = totalLineCnt - DefaultShowLineCnt
      local duration = 0
      if leftLineCnt > 0 then
        duration = leftLineCnt / totalLineCnt * soundDuration
      end
      self.ScrollMoveTimer = self.binder:BindTimer(2, 0, nil, function()
        if duration > 0 then
          self.ScrollViewCom:DOVerticalNormalizedPos(0, 1):OnComplete(System.fn(self, self.VoiceDone))
        else
          self:VoiceDone()
        end
        self:ClearScrollMoveTimer()
      end)
    end
  end)
end

function AwakerTextVoiceCom:ClearContent()
  self:ClearPrintTimer()
  self:ClearWait2CloseTimer()
  self:ClearScrollMoveTimer()
end

function AwakerTextVoiceCom:GetTextLineCnt()
  local rectTransform = self.contentTmpComp:GetComponent(typeof(RectTransform))
  local containerWidth = rectTransform.rect.width
  local textWidth = self.contentTmpComp.preferredWidth
  local newLineCount = Mathf.CeilToInt(textWidth / containerWidth)
  local lineCount = Mathf.Clamp(newLineCount, 1, 10)
  return lineCount
end

function AwakerTextVoiceCom:GetScale()
  return self.playSpeed.value
end

function AwakerTextVoiceCom:VoiceDone()
  self.contentTmpComp.maxVisibleCharacters = self.curMaxCharCount
  self.Wait2CloseTimer = self.binder:BindTimer(Wait2Clear, 0, nil, function()
    self:ClearContent()
  end)
end

return AwakerTextVoiceCom
