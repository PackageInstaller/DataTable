local base = UIBaseNode
local UINWarChessEventTypeNodeBase = class("UINWarChessEventTypeNodeBase", base)

function UINWarChessEventTypeNodeBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.tex_EventText.text = ""
end

function UINWarChessEventTypeNodeBase:InitWCEventNode(uiEvent, eventCfg, choiceDatas, onChoiceClick)
  self.uiEvent = uiEvent
  self.eventCfg = eventCfg
  self.choiceDatas = choiceDatas
  self.onChoiceClick = onChoiceClick
  self:RefreshEventText()
  self:RefreshEntChoiceList()
end

function UINWarChessEventTypeNodeBase:RefreshEventText()
  local eventText = LanguageUtil.GetLocaleText(self.eventCfg.event_txt)
  self.ui.tex_EventText:DOKill()
  self.ui.tex_EventText:DOText(eventText, 1, true):SetLink(self.ui.tex_EventText.gameObject)
end

function UINWarChessEventTypeNodeBase:RefreshEntChoiceList()
  local choicePool = self.uiEvent:GetWCChoicePool()
  choicePool:HideAll()
  for index, choiceData in ipairs(self.choiceDatas) do
    local choiceItem = choicePool:GetOne()
    choiceItem.transform:SetParent(self.ui.rect)
    choiceItem:InitWCEventChoiceItem(choiceData, self.onChoiceClick)
  end
end

function UINWarChessEventTypeNodeBase:OnDelete()
  base.OnDelete(self)
end

return UINWarChessEventTypeNodeBase
