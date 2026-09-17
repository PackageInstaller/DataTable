local this = class("cellAccessorySubAttStarUp", G_UIModuleBase)

function this.bind()
  return {
    txt_name = "",
    txt_level = "",
    txt_nextLevel = "",
    go_nextLevel = false,
    go_level = false,
    img_icon = "",
    txt_UpLevel = "",
    go_mask = false,
    txt_starLevel = "",
    txt_namePreview = "",
    txt_levelPreview = "",
    img_iconPreview = "",
    go_descNode = true,
    go_descNodePreview = false,
    go_LayoutNode = false
  }
end

function this.methods()
  return {
    btn_OnClick = function(self)
      L_UI:open("pageSkillEntryTips", {
        id = self.bind.id,
        skillEntryId = self.bind.skillEntryId,
        Lv = self.bind.level,
        needCompare = false,
        previewSkillLv = self.bind.level,
        locked = self.bind.isLock
      })
    end
  }
end

function this:open()
  self:refreshUI()
end

function this:refreshUI()
  local bind = self.bind
  local isUnlockable = bind.isCanUnlockSkill
  bind.go_descNode = not isUnlockable
  bind.go_descNodePreview = isUnlockable
  bind.go_mask = bind.isLock or isUnlockable
  self:refreshCellContent(isUnlockable)
  bind.txt_starLevel = tostring(bind.star)
  self.lastMaskStat = bind.go_mask
  self.lastSkillLevel = bind.level
  self.bind.go_LayoutNode = not bind.go_descNode or bind.go_mask
end

function this:LevelUpAnim()
  if self.bind.isLock or self.bind.isCanUnlockSkill then
    return
  end
  local anim = self.bindComponents.anim
  local levelChanged = self.lastSkillLevel ~= self.bind.level
  if levelChanged then
    anim:Play("anim_AStrength_cellAccessorySubAttStarUp_LevelUp")
  else
    anim:Play("anim_AStrength_cellAccessorySubAttStarUp_Unlock")
  end
end

function this:refreshCellContent(isUnlockable)
  if isUnlockable then
    self.bindComponents.anim:Play("anim_AStrength_cellAccessorySubAttStarUp_Locked")
    self:showDescNodePreview()
  else
    self:showDescNode()
  end
end

function this:showDescNode()
  local bind = self.bind
  bind.txt_name = bind.name
  bind.img_icon = bind.skillIconPath
  if bind.lvNodeActive and not self.bind.notAttributeupAnim then
    self:playLevelUpAnimation()
  end
  bind.go_nextLevel = bind.lvNodeActive
  bind.go_level = not bind.lvNodeActive
  bind.txt_level = "Lv." .. tostring(bind.level)
  bind.txt_nextLevel = "Lv." .. tostring(bind.level)
  bind.txt_UpLevel = tostring(bind.previewLv)
end

function this:playLevelUpAnimation()
  local anim = self.bindComponents.anim
  local animName = self.bind.go_nextLevel and "anim_AStrength_cellAccessorySubAttStarUp_attributeup" or "anim_AStrength_cellAccessorySubAttStarUp_attributeupfadein"
  self.bind.go_LayoutNode = false
  anim:Play(animName)
end

function this:showDescNodePreview()
  local bind = self.bind
  local namePrefix = bind.isCanUnlockSkill and L_WordsTpl:getValue("ui_accessory_upgrade_skill_activate_text") or ""
  bind.txt_namePreview = string.format("%s%s", namePrefix, bind.name)
  bind.img_iconPreview = bind.skillIconPath
  bind.txt_levelPreview = "Lv." .. tostring(bind.level)
  bind.go_nextLevel = false
end

return this
