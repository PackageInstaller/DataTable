local UIDormFightVSFighterItem = class("UIDormFightVSFighterItem", UIBaseNode)
local SkinEnum = require("Game.Skin.SkinEnum")

function UIDormFightVSFighterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIDormFightVSFighterItem:InitUIDormFightVSFighterItem(heroData, resloader)
  self.transform.gameObject:SetActive(true)
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData:GetResPicName(), SkinEnum.fromWhere.otherPlayerHero), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Skin.texture = texture
  end)
  self.ui.tex_name.text = heroData:GetHeroName(true)
end

return UIDormFightVSFighterItem
