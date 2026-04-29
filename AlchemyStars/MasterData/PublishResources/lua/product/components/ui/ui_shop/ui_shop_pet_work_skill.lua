_class("UIShopPetWorkSkill", UICustomWidget)
UIShopPetWorkSkill = UIShopPetWorkSkill

function UIShopPetWorkSkill:OnShow(uiParams)
  self._workIndexName = self:GetUIComponent("UILocalizationText", "workIndexName")
  self._workSkillDesc = self:GetUIComponent("UILocalizationText", "workSkillDesc")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._workSkillText = self:GetUIComponent("UILocalizationText", "workSkillText")
  self._Anim = self:GetUIComponent("Animation", "Anim")
  self._topCanvasGroup = self:GetUIComponent("CanvasGroup", "top")
end

function UIShopPetWorkSkill:SetData(index, skillCls, roomType)
  local cfg_work_skill = Cfg.cfg_work_skill[skillCls.ID]
  if cfg_work_skill then
    self._icon:LoadImage(cfg_work_skill.Icon)
    self._workIndexName:SetText(StringTable.Get(cfg_work_skill.Name))
    self._workSkillDesc:SetText(StringTable.Get(cfg_work_skill.Desc))
    self._workSkillText.color = Color(1, 1, 1, 1)
    self._workSkillDesc.color = Color(1, 1, 1, 1)
  end
end

function UIShopPetWorkSkill:ShowInAnim()
  self._Anim:Play("uieff_UIShopPetWorkSkill_in")
end

function UIShopPetWorkSkill:HideAnim()
  self._topCanvasGroup.alpha = 0
end
