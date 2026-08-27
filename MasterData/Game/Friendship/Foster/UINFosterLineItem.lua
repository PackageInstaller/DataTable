local UINFosterLineItem = class("UINFosterLineItem", UIBaseNode)
local base = UIBaseNode

function UINFosterLineItem:OnInit()
  self.heroId = nil
  self.fosterCfg = nil
  self.clickCallback = nil
  self.lienLevel = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_favorSkillItem, self, self.OnTogValueChange)
end

function UINFosterLineItem:InitFosterItem(heroId, fosterCfg, heroLevel, friendShipLevel, clickCallback)
  self.heroId = heroId
  self.fosterCfg = fosterCfg
  self.herolevel = heroLevel
  self.friendShipLevel = friendShipLevel
  self.clickCallback = clickCallback
  self.ui.tex_SkillName.text = LanguageUtil.GetLocaleText(fosterCfg[1].name)
  self:RefreshCondition()
end

function UINFosterLineItem:Move(bool, pos)
  if bool then
    if pos == nil then
      error("don't have pos")
    end
    self.ui.trans_pos.anchoredPosition = Vector2.New(pos.x + 70, pos.y)
  end
end

function UINFosterLineItem:OnTogValueChange(bool)
  if self.clickCallback ~= nil then
    self.clickCallback(bool)
  end
end

function UINFosterLineItem:RefreshCondition()
  self.lienLevel = PlayerDataCenter.allFriendshipData:GetForestLineLevel(self.heroId, self.fosterCfg[1].id)
  if self:isUnlocked() then
    self.ui.img_condition.gameObject:SetActive(false)
    self.ui.obj_skillLevel:SetActive(true)
    if self.lienLevel == #self.fosterCfg then
      self.ui.tex_SkillLevel:SetIndex(1)
    else
      self.ui.tex_SkillLevel:SetIndex(0, tostring(self.lienLevel))
    end
  else
    self.ui.img_condition.gameObject:SetActive(true)
    self.ui.obj_skillLevel:SetActive(false)
    local requireFriendshipLevel = self.fosterCfg[1].friendship_level
    self.ui.txt_condition:SetIndex(0, tostring(requireFriendshipLevel))
    if requireFriendshipLevel <= self.friendShipLevel then
      self.ui.img_condition.color = self.ui.color_black
    else
      self.ui.img_condition.color = self.ui.color_orange
    end
  end
  self:SetIsUnlock()
end

function UINFosterLineItem:isUnlocked()
  return PlayerDataCenter.allFriendshipData:IsForestLineUnlock(self.heroId, self.fosterCfg[1].id)
end

function UINFosterLineItem:SetIsUnlock(bool)
  if bool == nil then
    bool = self:isUnlocked()
  end
  self.ui.obj_lock:SetActive(not bool)
  self.ui.obj_unlock:SetActive(bool)
  if bool then
    self.ui.img_unlockIcon.sprite = CRH:GetSprite(self.fosterCfg[self.lienLevel].icon)
    self.ui.img_OnSelect.color = self.ui.color_yellow
  else
    self.ui.img_OnSelect.color = self.ui.color_black
  end
end

function UINFosterLineItem:setSelect(bool)
  self.ui.tog_favorSkillItem.isOn = bool
end

function UINFosterLineItem:OnDelete()
  base.OnDelete(self)
end

return UINFosterLineItem
