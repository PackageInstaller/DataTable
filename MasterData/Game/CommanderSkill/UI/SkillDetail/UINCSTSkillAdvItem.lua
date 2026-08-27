local UINCSTSkillAdvItem = class("UINCSTSkillAdvItem", UIBaseNode)
local base = UIBaseNode

function UINCSTSkillAdvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSTSkillAdvItem:InitCSTSkillAdvItem(resLoader, iconName, advLevel, desc, unlock, unlockLevel)
  self.ui.img_Icon.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, iconName)
    self.ui.img_Icon.enabled = true
  end)
  self.ui.tex_Name:SetIndex(0, tostring(advLevel))
  self.ui.tex_Unlock:SetIndex(0, tostring(unlockLevel))
  self.ui.tex_Unlock.gameObject:SetActive(not unlock)
  self.ui.tex_Desc.text = desc
  self.ui.img_Title.color = unlock and self.ui.color_unlock or self.ui.color_lock
  self.ui.tex_Desc.color = unlock and self.ui.color_unlock or self.ui.color_lock
end

function UINCSTSkillAdvItem:OnDelete()
  base.OnDelete(self)
end

return UINCSTSkillAdvItem
