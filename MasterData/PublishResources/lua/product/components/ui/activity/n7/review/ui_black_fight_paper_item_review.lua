_class("UIBlackFightPaperItemReview", UICustomWidget)
UIBlackFightPaperItemReview = UIBlackFightPaperItemReview

function UIBlackFightPaperItemReview:OnShow()
  self.root = self:GetGameObject("root")
  self.txtPhase = self:GetUIComponent("UILocalizationText", "txtPhase")
  self.poolL = self:GetUIComponent("UISelectObjectPath", "l")
  self.verticalLayoutGroupL = self:GetUIComponent("VerticalLayoutGroup", "l")
  self.poolR = self:GetUIComponent("UISelectObjectPath", "r")
  self.verticalLayoutGroupR = self:GetUIComponent("VerticalLayoutGroup", "r")
  self.lock = self:GetGameObject("lock")
  self.reputationValue = self:GetUIComponent("UILocalizationText", "reputationValue")
end

function UIBlackFightPaperItemReview:OnHide()
end

function UIBlackFightPaperItemReview:Flush(paper)
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
    local cfg_campaign_mission = Cfg.cfg_campaign_mission[paper.missionId]
    if cfg_campaign_mission then
      local levelName = StringTable.Get(cfg_campaign_mission.Name)
      local str = StringTable.Get("str_n7_review_paper_complete_level_x", levelName)
      self.reputationValue:SetText(str)
    else
      self.reputationValue:SetText("invalid " .. paper.missionId)
    end
  end
  self.lock:SetActive(not unlock)
  self.root:SetActive(unlock)
end

function UIBlackFightPaperItemReview:FlushLR(paper, isL)
  local pool, elements
  if isL then
    pool = self.poolL
    elements = paper.elementsL
  else
    pool = self.poolR
    elements = paper.elementsR
  end
  local len = table.count(elements)
  pool:SpawnObjects("UIBlackFightPaperElementReview", len)
  local uis = pool:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush(elements[i])
  end
end
