local base = require("Game.WarChess.UI.Event.UINWarChessEventTypeNodeBase")
local UINWarChessEventLongNode = class("UINWarChessEventLongNode", base)
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_Tweening = CS.DG.Tweening

function UINWarChessEventLongNode:OnInit()
  base.OnInit(self)
end

function UINWarChessEventLongNode:RefreshEventText()
  local eventText = LanguageUtil.GetLocaleText(self.eventCfg.event_txt)
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

function UINWarChessEventLongNode:RefreshEntChoiceList()
  base.RefreshEntChoiceList(self)
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect)
  local size = self.ui.eventContent.sizeDelta
  size.y = self.transform.sizeDelta.y - self.ui.rect.sizeDelta.y + self.ui.eventContent.anchoredPosition.y
  self.ui.eventContent.sizeDelta = size
end

return UINWarChessEventLongNode
