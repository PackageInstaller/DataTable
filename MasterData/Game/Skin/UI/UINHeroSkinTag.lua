local UINHeroSkinTag = class("UINHeroSkinTag", UIBaseNode)
local base = UIBaseNode
local SkinEnum = require("Game.Skin.SkinEnum")

function UINHeroSkinTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroSkinTag:InitSkinTag(tagIndex)
  self.tagIndex = tagIndex
  local name = ConfigData.skin_lable[self.tagIndex].name
  name = LanguageUtil.GetLocaleText(name)
  self.ui.tex_Tag:SetText(name)
  self.ui.img_tag.color = SkinEnum.ColorShowTags[self.tagIndex + 1]
end

function UINHeroSkinTag:InitSkinTagLive2dLevel(live2dLevel)
  if live2dLevel == 2 then
    self:InitSkinTag(2)
  else
    self:InitSkinTag(1)
  end
end

function UINHeroSkinTag:SetSelectState(isSelect)
  if isSelect then
    self.ui.img_tag.color = SkinEnum.ColorShowTags[self.tagIndex + 1]
  else
    self.ui.img_tag.color = SkinEnum.ColorHideTags[self.tagIndex + 1]
  end
end

return UINHeroSkinTag
