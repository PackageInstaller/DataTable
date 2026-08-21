_class("UIBlackFightPaperItem", UICustomWidget)
UIBlackFightPaperItem = UIBlackFightPaperItem

function UIBlackFightPaperItem:OnShow()
  self.root = self:GetGameObject("root")
  self.txtPhase = self:GetUIComponent("UILocalizationText", "txtPhase")
  self.poolL = self:GetUIComponent("UISelectObjectPath", "l")
  self.verticalLayoutGroupL = self:GetUIComponent("VerticalLayoutGroup", "l")
  self.poolR = self:GetUIComponent("UISelectObjectPath", "r")
  self.verticalLayoutGroupR = self:GetUIComponent("VerticalLayoutGroup", "r")
  self.lock = self:GetGameObject("lock")
  self.reputationValue = self:GetUIComponent("UILocalizationText", "reputationValue")
end

function UIBlackFightPaperItem:OnHide()
end

function UIBlackFightPaperItem:Flush(paper)
  local unlock = paper:IsUnlock()
  if unlock then
    self.txtPhase:SetText(218 + paper.idx)
    self:FlushLR(paper, true)
    self:FlushLR(paper, false)
    self:StartTask(function(TT)
      self.root:SetActive(false)
      YIELD(TT)
      self.root:SetActive(true)
    end, self)
  else
    self.reputationValue:SetText(paper.unlockReputation)
  end
  self.lock:SetActive(not unlock)
  self.root:SetActive(unlock)
end

function UIBlackFightPaperItem:FlushLR(paper, isL)
  local pool, elements
  if isL then
    pool = self.poolL
    elements = paper.elementsL
  else
    pool = self.poolR
    elements = paper.elementsR
  end
  local len = table.count(elements)
  pool:SpawnObjects("UIBlackFightPaperElement", len)
  local uis = pool:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(elements[i])
  end
end
