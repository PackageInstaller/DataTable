local UINVowSkinItem = class("UINVowSkinItem", UIBaseNode)
local base = UIBaseNode
local SkinEnum = require("Game.Skin.SkinEnum")

function UINVowSkinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINVowSkinItem:InitVowSkinItem(resloader, heroId, skinId)
  self.resloader = resloader
  self.skinCfg = ConfigData.skin[skinId]
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resModelCfg = skinCtr:GetResModel(heroId, skinId)
  self.ui.tex_ThemeName.text = string.format("[%s]", LanguageUtil.GetLocaleText(ConfigData.skinTheme[self.skinCfg.theme].name))
  self.ui.tex_SkinName.text = LanguageUtil.GetLocaleText(self.skinCfg.name)
  self:__LoadHeroSkinImg(resloader)
end

function UINVowSkinItem:__LoadHeroSkinImg(resLoader)
  local picResPath = PathConsts:GetCharacterPicPath(self.resModelCfg.src_id_pic, SkinEnum.fromWhere.heroInfoAndHandbook)
  self.ui.img_HeroPic.enabled = false
  resLoader:LoadABAssetAsync(picResPath, function(texture)
    if not IsNull(self.ui.img_HeroPic) then
      self.ui.img_HeroPic.enabled = true
      self.ui.img_HeroPic.texture = texture
    end
  end)
end

function UINVowSkinItem:OnDelete()
end

return UINVowSkinItem
