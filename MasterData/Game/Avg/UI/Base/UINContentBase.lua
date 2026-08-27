local UINContentBase = class("UINContentBase", UIBaseNode)
local base = UIBaseNode
local CS_ScrambleMode = CS.DG.Tweening.ScrambleMode

function UINContentBase:OnInit()
end

function UINContentBase:InitAvgTextSplitParam()
  self._lastTextPos = 0
  self._hasSplit = false
  self.avgSystem:AvgShowTextSplitPause(false)
  self:SetAvgTextSpliteIdx(nil)
end

function UINContentBase:InitImmediateContent(content)
  content = AvgUtil.GetAvgContentShow(content)
  return content
end

function UINContentBase:SetAvgTextSpliteIdx(idx)
  self._contentSplitIdx = idx
  self.avgSystem:SetCurActContentSplitIdx(idx)
end

function UINContentBase:InitAvgTextTween(textComp, textDtanim, content, scramble)
  textDtanim.optionalScrambleMode = scramble and CS_ScrambleMode.Uppercase or CS_ScrambleMode.None
  local hasSplit = string.find(content, AvgUtil.contentSpliter)
  if hasSplit then
    self._hasSplit = true
    self._contentList = string.split(content, AvgUtil.contentSpliter)
    self:SetAvgTextSpliteIdx(1)
    self._contentTo = self._contentList[self._contentSplitIdx]
  else
    self._contentTo = content
  end
  self._contenFrom = ""
  self:PlayAvgTextTween(textComp, textDtanim, self._contenFrom, self._contentTo)
end

function UINContentBase:PlayAvgTextTween(textComp, textDtanim, fromStr, toStr)
  textComp.text = fromStr
  self._playTween = nil
  textDtanim:DOKill()
  textDtanim:CreateTween()
  local textSpeed = ConfigData.buildinConfig.AvgTextTweenSpeed * LanguageUtil.GetWriterSpeed()
  textDtanim.tween:ChangeEndValue(toStr, textSpeed, false)
  if self._lastTextPos ~= 0 then
    textDtanim.tween:Goto(self._lastTextPos)
  end
  self._playTween = textDtanim.tween
  textDtanim:DOPlayForward()
end

function UINContentBase:TryPlayAvgTextSplitTween(textComp, textDtanim)
  if self._hasSplit and self._contentSplitIdx < #self._contentList then
    self:SetAvgTextSpliteIdx(self._contentSplitIdx + 1)
    self._contenFrom = self._contentTo
    self._contentTo = self._contentTo .. self._contentList[self._contentSplitIdx]
    self.avgSystem:AvgShowTextSplitPause(false)
    self:PlayAvgTextTween(textComp, textDtanim, self._contenFrom, self._contentTo)
  end
end

function UINContentBase:TryAvgTextSplitPause(textComp, textDtanim)
  if self._hasSplit and self._contentSplitIdx < #self._contentList then
    self.avgSystem:AvgShowTextSplitPause(true)
    self._lastTextPos = self._playTween.position
    if self.avgSystem.avgCtrl:GetAvgAutoPlayMode() then
      self:TryPlayAvgTextSplitTween(textComp, textDtanim)
    end
    return true
  end
  self.avgSystem:AvgShowTextSplitPause(false)
  return false
end

function UINContentBase:OnDelete()
  self._playTween = nil
  base.OnDelete(self)
end

return UINContentBase
