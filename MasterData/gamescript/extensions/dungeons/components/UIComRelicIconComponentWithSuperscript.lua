local UIComRelicIconComponentWithSuperscript, Super = System.NewComponent("UIComRelicIconComponentWithSuperscript", UICompRelicIconItem)

function UIComRelicIconComponentWithSuperscript:ctor(node, view, relicTid, superscript, curSelectIndex)
  self.stageId = DailyChallengeController.Instance:GetSelectedLevelID(curSelectIndex)
  local relicData = {
    relicTid = relicTid,
    stageId = self.stageId
  }
  Super.ctor(self, node, view, relicData)
  self.superscript = superscript
end

function UIComRelicIconComponentWithSuperscript:OnEnterComponent()
  Super.OnEnterComponent(self)
  self.ui.Group_Tab_Nor:SetActive(true)
  self:SetText(self.ui.Text_Tab_Nor, self.superscript)
end

return UIComRelicIconComponentWithSuperscript
