local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpEntLongTexNode = class("UINEpEntLongTexNode", base)
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_Tweening = CS.DG.Tweening
local EpCommonUtil = require("Game.Exploration.Util.EpCommonUtil")

function UINEpEntLongTexNode:OnInit()
  base.OnInit(self)
end

function UINEpEntLongTexNode:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
end

function UINEpEntLongTexNode:RefreshBranchPage()
  self:Show()
  self:RefreshEntChoiceList()
  self:RefreshEventText()
end

function UINEpEntLongTexNode:RefreshEventText()
  local eventText = EpCommonUtil.GetEventReplaceText(self.uiEvent.eventCfg, "event_txt")
  self.ui.tex_EventText.text = eventText
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.tex_EventText.transform)
  self.ui.contentScrollRect:DOKill()
  self.ui.tex_EventText:DOKill()
  self.ui.tex_EventText.raycastTarget = true
  if self.ui.tex_EventText.transform.sizeDelta.y > self.ui.contentScrollRect.transform.rect.height then
    self.ui.contentScrollRect.verticalNormalizedPosition = 1
    self.ui.tex_EventText.raycastTarget = false
    self.ui.contentScrollRect:DOVerticalNormalizedPos(0, 0.25):SetSpeedBased():SetEase(cs_Tweening.Ease.Linear):SetDelay(1):OnComplete(function()
      self.ui.tex_EventText.raycastTarget = true
    end):SetLink(self.ui.contentScrollRect.gameObject)
    return
  end
  self.ui.tex_EventText.text = ""
  self.ui.tex_EventText:DOText(eventText, 1, true):SetLink(self.ui.tex_EventText.gameObject)
end

function UINEpEntLongTexNode:RefreshEntChoiceList()
  base.RefreshEntChoiceList(self)
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect)
  local size = self.ui.eventContent.sizeDelta
  size.y = self.transform.sizeDelta.y - self.ui.rect.sizeDelta.y + self.ui.eventContent.anchoredPosition.y
  self.ui.eventContent.sizeDelta = size
end

function UINEpEntLongTexNode:OnDelete()
  base.OnDelete(self)
end

return UINEpEntLongTexNode
