local UINCSTSkillOverrideLvItem = class("UINCSTSkillOverrideLvItem", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillOverrideLvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSTSkillOverrideLvItem:InitCSTSkillOverrideLvItem(resLoader, iconName)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
    self.ui.img_Icon.enabled = true
  end)
end

function UINCSTSkillOverrideLvItem:SetCSTSkillOverrideLvItemLock(lock, equipColor)
  if lock then
    self.ui.img_Bg.color = Color.black
  else
    self.ui.img_Bg.color = equipColor or Color.white
  end
  self.ui.img_Icon.color = lock and Color.white or Color.black
  self.ui.canvasGroup.alpha = lock and 0.4 or 1
end

function UINCSTSkillOverrideLvItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillOverrideLvItem
