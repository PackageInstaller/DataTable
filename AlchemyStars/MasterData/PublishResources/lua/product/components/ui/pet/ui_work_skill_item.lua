_class("UIWorkSkillItem", UICustomWidget)

function UIWorkSkillItem:Constructor()
end

function UIWorkSkillItem:OnShow(uiParams)
  self._skillInfo = nil
  self._skillIconRawImageLoader = self:GetUIComponent("RawImageLoader", "skillIcon")
  self._skillDes = self:GetUIComponent("UILocalizationText", "skillDes")
  self._skillName = self:GetUIComponent("UILocalizationText", "skillName")
  self._rectTransform = self:GetUIComponent("RectTransform", "UIWorkSkillItem")
  self._uiItemAtlas = self:GetAsset("UISpiritDetail.spriteatlas", LoadType.SpriteAtlas)
  self._showTipBtnGo = self:GetGameObject("showTipBtn")
  self._showTipBtnGo:SetActive(false)
  self._callback = nil
end

function UIWorkSkillItem:OnHide()
  self:Release()
end

function UIWorkSkillItem:Release()
  self._skillInfo = nil
  self._skillIconRawImageLoader = nil
  self._skillDes = nil
  self._skillName = nil
  self._uiItemAtlas = nil
end

function UIWorkSkillItem:showTipBtnOnClick(go)
  if self.isExceed == false then
    return
  end
  if self._callback then
    self._isOnClickChainSkill = false
    local vePos = Vector3(-225, 0, 0)
    local worldPos = self._rectTransform:TransformPoint(vePos)
    local index = 0
    index = self._index
    if self._index == 0 then
      index = self._chaincount
    end
    if self._isChainSkill == true then
      self._isOnClickChainSkill = true
    end
    self._callback(1, self._skillInfo, worldPos)
  end
end

function UIWorkSkillItem:CheckDesExceed()
  self.isExceed = ExtendText.StringEllipsis(self._skillDes, 1083)
  if self.isExceed then
    self._showTipBtnGo:SetActive(true)
  else
    self._showTipBtnGo:SetActive(false)
  end
end

function UIWorkSkillItem:SetData(skillInfo, callback)
  self._skillInfo = skillInfo
  self._callback = callback
  local cfg = Cfg.cfg_work_skill[skillInfo]
  if cfg then
    self._skillIconRawImageLoader:LoadImage(cfg.Icon)
    self._skillName.text = StringTable.Get(cfg.Name)
    self._skillDes.text = StringTable.Get(cfg.Desc)
  end
  self:CheckDesExceed()
end
