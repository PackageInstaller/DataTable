_class("UIAircraftPetWorkSkillPrefab", UICustomWidget)
UIAircraftPetWorkSkillPrefab = UIAircraftPetWorkSkillPrefab

function UIAircraftPetWorkSkillPrefab:OnShow(uiParams)
  self._icon = self:GetUIComponent("RawImageLoader", "RawImage")
  self._mask = self:GetGameObject("mask")
  self._lock = self:GetGameObject("lock")
end

function UIAircraftPetWorkSkillPrefab:SetData(index, skillCls, roomType)
  local cfg_work_skill = Cfg.cfg_work_skill[skillCls.ID]
  if cfg_work_skill then
    self._icon:LoadImage(cfg_work_skill.Icon)
    self._mask:SetActive(cfg_work_skill.RoomType ~= roomType)
    self._lock:SetActive(skillCls.isLock)
  end
end
