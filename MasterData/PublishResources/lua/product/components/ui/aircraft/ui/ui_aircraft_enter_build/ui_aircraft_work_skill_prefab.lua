_class("UIAircraftWorkSkillPrefab", UICustomWidget)
UIAircraftWorkSkillPrefab = UIAircraftWorkSkillPrefab

function UIAircraftWorkSkillPrefab:OnShow(uiParams)
  self._workIndexName = self:GetUIComponent("UILocalizationText", "workIndexName")
  self._workSkillDesc = self:GetUIComponent("UILocalizationText", "workSkillDesc")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._mask = self:GetGameObject("mask")
  self._lock = self:GetGameObject("lock")
  self._workSkillText = self:GetUIComponent("UILocalizationText", "workSkillText")
  self._condition = self:GetUIComponent("UILocalizationText", "condition")
  self._nameBg = self:GetUIComponent("Image", "nameBg")
  local nameTr = self._nameBg:GetComponent("RectTransform")
  nameTr.anchoredPosition = Vector2(0, 0)
  self._altas = self:GetAsset("UIAircraftEnterBuild.spriteatlas", LoadType.SpriteAtlas)
end

function UIAircraftWorkSkillPrefab:SetData(index, skillCls, roomType)
  local cfg_work_skill = Cfg.cfg_work_skill[skillCls.ID]
  if cfg_work_skill then
    self._icon:LoadImage(cfg_work_skill.Icon)
    self._workIndexName:SetText(StringTable.Get(cfg_work_skill.Name))
    self._workSkillDesc:SetText(StringTable.Get(cfg_work_skill.Desc))
    self._workSkillText.color = Color(1, 1, 1, 1)
    self._workSkillDesc.color = Color(1, 1, 1, 1)
    self._nameBg.color = Color(1, 1, 1, 1)
    if skillCls.isLock then
      Log.error("skillCls.isLock")
    end
    self._lock:SetActive(skillCls.isLock)
    if not skillCls.isLock and cfg_work_skill.RoomType ~= roomType then
      self._mask:SetActive(true)
    else
      self._mask:SetActive(false)
    end
    if skillCls.isLock then
      local str = StringTable.Get("str_aircraft_tip_grade_behind")
      str = string.format(str, skillCls.grade)
      self._condition:SetText(str)
      return
    end
  end
end
