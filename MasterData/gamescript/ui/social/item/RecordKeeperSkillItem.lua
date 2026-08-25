local RecordKeeperSkillItem, Super = System.NewComponent("RecordKeeperSkillItem")

function RecordKeeperSkillItem:ctor(gameObj, keeperSkill)
  Super.ctor(self)
  self.ui = UIBaseResource(gameObj)
  self.keeperSkill = keeperSkill
end

function RecordKeeperSkillItem:OnBind(binder)
  self.binder = binder
  self:SetKeeperSkill()
end

function RecordKeeperSkillItem:SetKeeperSkill()
  self.binder:SetActive(self.ui.Image_Icon, true)
  self.binder:SetActive(self.ui.Image_School, false)
  self.binder:SetActive(self.ui.Text_Level, false)
  self.binder:SetActive(self.ui.Image_Quality, false)
  self.binder:SetImage(self.ui.Image_Icon, ItemDataUtils.GetItemConfigByField("SpIcon", self.keeperSkill))
end

return RecordKeeperSkillItem
