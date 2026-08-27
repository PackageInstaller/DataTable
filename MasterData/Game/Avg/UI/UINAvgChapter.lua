local base = require("Game.Avg.UI.Base.UINContentBase")
local UINAvgChapter = class("UINAvgChapter", base)
local CS_ScrambleMode = CS.DG.Tweening.ScrambleMode

function UINAvgChapter:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function UINAvgChapter:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tween_ChapterText.onComplete:AddListener(BindCallback(self, self.OnChapterTextTweenComplete))
  self.ui.tween_ChapterText.isIndependentUpdate = self.avgSystem:AvgIgnoreTimeScale()
  self.ui.tex_ChapterNarrator.onHrefClick:AddListener(self.avgSystem:GetOnClickAvgTextLinkCallback())
end

function UINAvgChapter:ShowAvgChapter(content, shake, immediate, scramble)
  self:Show()
  self:InitAvgTextSplitParam()
  self.shake = shake
  self:ClearShakeTween()
  self.tweenComplete = false
  local extents = self.ui.tex_ChapterNarrator.rectTransform.rect.size
  extents.y = 0
  self.ui.tex_ChapterNarrator:PreSetTextSizeDelta(content, false, true, extents)
  if immediate then
    content = self:InitImmediateContent(content)
    self.ui.tex_ChapterNarrator.text = content
    self:OnChapterTextTweenComplete()
  else
    self:InitAvgTextTween(self.ui.tex_ChapterNarrator, self.ui.tween_ChapterText, content, scramble)
  end
  self.contentLenth = #content
end

function UINAvgChapter:OnChapterTextTweenComplete()
  if self.tweenComplete then
    return
  end
  if self:TryAvgTextSplitPause(self.ui.tex_ChapterNarrator, self.ui.tween_ChapterText) then
    return
  end
  self.tweenComplete = true
  if self.shake then
    self.shakeTween = self.ui.tex_ChapterNarrator.transform:DOShakePosition(0.4, Vector3.New(10, 10, 0), 20):SetUpdate(self.avgSystem:AvgIgnoreTimeScale())
  end
  self.avgSystem:ShowTextComplete(self.contentLenth)
end

function UINAvgChapter:SkipAvgContent()
  if self._playTween:IsPlaying() then
    self.ui.tween_ChapterText:DOComplete()
    return
  end
  self:TryPlayAvgContentSplitTween()
end

function UINAvgChapter:TryPlayAvgContentSplitTween()
  self:TryPlayAvgTextSplitTween(self.ui.tex_ChapterNarrator, self.ui.tween_ChapterText)
end

function UINAvgChapter:EndAvgContent()
  self.ui.tween_ChapterText:DOKill()
end

function UINAvgChapter:ClearShakeTween()
  if self.shakeTween ~= nil then
    self.shakeTween:Rewind()
    self.shakeTween:Kill()
    self.shakeTween = nil
  end
end

function UINAvgChapter:OnDelete()
  self:ClearShakeTween()
  self.ui.tween_ChapterText:DOKill()
  base.OnDelete(self)
end

return UINAvgChapter
