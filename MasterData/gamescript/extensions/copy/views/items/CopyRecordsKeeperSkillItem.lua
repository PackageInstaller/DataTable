local CopyRecordsKeeperSkillItem, Super = NewViewComponent("CopyRecordsKeeperSkillItem")

function CopyRecordsKeeperSkillItem:ctor(uiNode, view, keeperSkill)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Social_PvpRecordAwakerResource(uiNode)
  self.keeperSkill = keeperSkill
end

function CopyRecordsKeeperSkillItem:RegisterNotifications()
end

function CopyRecordsKeeperSkillItem:RegisterEvents()
end

function CopyRecordsKeeperSkillItem:OnBuildComponent()
  Super.OnBuildComponent(self)
end

function CopyRecordsKeeperSkillItem:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:SetKeeperSkill()
end

function CopyRecordsKeeperSkillItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function CopyRecordsKeeperSkillItem:SetKeeperSkill()
  self:SetActive(self.ui.Image_Icon, true)
  self:SetActive(self.ui.Image_School, false)
  self:SetActive(self.ui.Text_Level, false)
  self:SetActive(self.ui.Image_Quality, false)
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetItemConfigByField("SpIcon", self.keeperSkill))
end

return CopyRecordsKeeperSkillItem
