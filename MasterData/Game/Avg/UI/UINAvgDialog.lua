local base = require("Game.Avg.UI.Base.UINContentBase")
local UINAvgDialog = class("UINAvgDialog", base)
local CS_ResLoader = CS.ResLoader
local CS_Canvas = CS.UnityEngine.Canvas
local CS_ScrambleMode = CS.DG.Tweening.ScrambleMode
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local SpecialStr = "bravo"

function UINAvgDialog:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function UINAvgDialog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tween_Narrator.onComplete:AddListener(BindCallback(self, self.OnDialogTweenComplete))
  self.ui.tween_Dialog.onComplete:AddListener(BindCallback(self, self.OnDialogTweenComplete))
  self.ui.tween_Narrator.isIndependentUpdate = self.avgSystem:AvgIgnoreTimeScale()
  self.ui.tween_Dialog.isIndependentUpdate = self.avgSystem:AvgIgnoreTimeScale()
  CS_Canvas.ForceUpdateCanvases()
  self.ui.text_Dialog.onHrefClick:AddListener(self.avgSystem:GetOnClickAvgTextLinkCallback())
  self.ui.tex_TextNarrator.onHrefClick:AddListener(self.avgSystem:GetOnClickAvgTextLinkCallback())
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

function UINAvgDialog:SetAvgDialogBottom(height)
  local anchoredPosition = self.ui.textNarratorNode.anchoredPosition
  anchoredPosition.y = height
  self.ui.textNarratorNode.anchoredPosition = anchoredPosition
end

function UINAvgDialog:ShowAvgDialog(content, shake, immediate, scramble, speakerName, isNarratage, posX)
  self:Show()
  self:InitAvgTextSplitParam()
  self.shake = shake
  self:ClearShakeTween()
  self.isNarratage = isNarratage
  if self.isNarratage then
    self.ui.textNarratorNode.gameObject:SetActive(true)
    self.ui.dialogNode:SetActive(false)
    if speakerName == SpecialStr then
      self.ui.tex_TextNarratorSpeaker.text = PlayerDataCenter.playerName
    else
      self.ui.tex_TextNarratorSpeaker.text = speakerName
    end
    if immediate then
      content = self:InitImmediateContent(content)
      self.ui.tex_TextNarrator.text = content
      self:OnDialogTweenComplete()
    else
      self:InitAvgTextTween(self.ui.tex_TextNarrator, self.ui.tween_Narrator, content, scramble)
    end
  else
    self.ui.textNarratorNode.gameObject:SetActive(false)
    self.ui.dialogNode:SetActive(true)
    if speakerName ~= -1 then
      content = speakerName .. "：" .. content
    end
    local extents = self.ui.text_Dialog.rectTransform.sizeDelta
    extents.y = 0
    local sizeDelta = self.ui.text_Dialog:PreSetTextSizeDelta(content, false, true, extents)
    self.ui.text_Dialog_Layout.preferredHeight = sizeDelta.y
    if immediate then
      content = self:InitImmediateContent(content)
      self.ui.text_Dialog.text = content
      self:OnDialogTweenComplete()
    else
      self:InitAvgTextTween(self.ui.text_Dialog, self.ui.tween_Dialog, content, scramble)
    end
    local pos = self.ui.dialogNode.transform.anchoredPosition
    pos.x = posX or 0
    self.ui.dialogNode.transform.anchoredPosition = pos
  end
  self.contentLenth = #content
end

function UINAvgDialog:_GetTextComp()
  if self.isNarratage then
    return self.ui.tex_TextNarrator, self.ui.tween_Narrator
  else
    return self.ui.text_Dialog, self.ui.tween_Dialog
  end
end

function UINAvgDialog:OnDialogTweenComplete()
  local textComp, textDtanim = self:_GetTextComp()
  if self:TryAvgTextSplitPause(textComp, textDtanim) then
    return
  end
  if self.shake then
    if self.isNarratage then
      self.shakeTween = self.ui.tex_TextNarrator.transform:DOShakePosition(0.4, Vector3.New(10, 10, 0), 20):SetUpdate(self.avgSystem:AvgIgnoreTimeScale())
    else
      cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.text_Dialog.transform.parent)
      self.shakeTween = self.ui.text_Dialog.transform:DOShakePosition(0.4, Vector3.New(10, 10, 0), 20):SetUpdate(self.avgSystem:AvgIgnoreTimeScale())
    end
  end
  self.avgSystem:ShowTextComplete(self.contentLenth)
end

function UINAvgDialog:SkipAvgContent()
  local textComp, textDtanim = self:_GetTextComp()
  if self._playTween:IsPlaying() then
    textDtanim:DOComplete()
    return
  end
  self:TryPlayAvgContentSplitTween()
end

function UINAvgDialog:TryPlayAvgContentSplitTween()
  local textComp, textDtanim = self:_GetTextComp()
  self:TryPlayAvgTextSplitTween(textComp, textDtanim)
end

function UINAvgDialog:EndAvgContent()
  if self.isNarratage then
    self.ui.tween_Narrator:DOKill()
  else
    self.ui.tween_Dialog:DOKill()
  end
end

function UINAvgDialog:ClearShakeTween()
  if self.shakeTween ~= nil then
    self.shakeTween:Rewind()
    self.shakeTween:Kill()
    self.shakeTween = nil
  end
end

function UINAvgDialog:ShowAvgUI(show)
  self.ui.canvasGroup.alpha = show and 1 or 0
  self.ui.canvasGroup.interactable = show
end

function UINAvgDialog:OnDelete()
  self:ClearShakeTween()
  self.ui.tween_Narrator:DOKill()
  self.ui.tween_Dialog:DOKill()
  base.OnDelete(self)
end

return UINAvgDialog
