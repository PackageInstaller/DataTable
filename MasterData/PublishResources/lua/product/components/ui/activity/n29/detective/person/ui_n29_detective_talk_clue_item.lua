_class("UIN29DetectiveTalkClueItem", UICustomWidget)
UIN29DetectiveTalkClueItem = UIN29DetectiveTalkClueItem

function UIN29DetectiveTalkClueItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN29DetectiveTalkClueItem:InitWidget()
  self._select = self:GetGameObject("select")
  self._clue = self:GetUIComponent("RawImageLoader", "Clue")
end

function UIN29DetectiveTalkClueItem:SetData(clueId, callback)
  self.clueId = clueId
  self.callback = callback
  local cfg = Cfg.cfg_component_detective_item[self.clueId]
  self._clue:LoadImage(cfg.Icon)
end

function UIN29DetectiveTalkClueItem:SetSelected(isSelected)
  self._select:SetActive(isSelected)
end

function UIN29DetectiveTalkClueItem:ClueOnClick()
  if self.callback then
    self.callback(self)
    Log.fatal("点击线索" .. self.clueId)
  end
end

function UIN29DetectiveTalkClueItem:GetClue()
  return self.clueId
end
