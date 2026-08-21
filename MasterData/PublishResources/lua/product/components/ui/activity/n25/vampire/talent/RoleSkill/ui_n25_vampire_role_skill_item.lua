_class("UIN25VampireRoleSkillItem", UICustomWidget)
UIN25VampireRoleSkillItem = UIN25VampireRoleSkillItem

function UIN25VampireRoleSkillItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
end

function UIN25VampireRoleSkillItem:OnShow(uiParams)
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.cur = self:GetGameObject("cur")
  self.lock = self:GetGameObject("lock")
  self.select = self:GetGameObject("select")
  self:Select(false)
end

function UIN25VampireRoleSkillItem:OnHide()
  self.Icon:DestoryLastImage()
end

function UIN25VampireRoleSkillItem:Flush(skill, ui, callback)
  self.skill = skill
  self.ui = ui
  self.callback = callback
  self.cur:SetActive(false)
  self.lock:SetActive(false)
  if skill then
    local icon, name, desc = skill:IconNameDesc()
    self.Icon:LoadImage(icon)
    if self.ui:IsRoleSkillLock(skill.skillId) then
      self.lock:SetActive(true)
    else
      local roleSkill = self.data:GetCurRoleSkill()
      if roleSkill and roleSkill.skillId == skill.skillId then
        self.cur:SetActive(true)
      end
    end
  else
    self.lock:SetActive(true)
  end
end

function UIN25VampireRoleSkillItem:SkillId()
  return self.skill.skillId
end

function UIN25VampireRoleSkillItem:Select(isSelect)
  self.select:SetActive(isSelect)
end

function UIN25VampireRoleSkillItem:IconOnClick(go)
  if self.callback then
    self.callback()
  end
end
