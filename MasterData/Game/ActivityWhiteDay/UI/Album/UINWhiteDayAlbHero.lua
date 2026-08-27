local UINWhiteDayAlbHero = class("UINWhiteDayAlbHero", UIBaseNode)
local base = UIBaseNode

function UINWhiteDayAlbHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.heroItem, self, self.OnClickSelect)
end

function UINWhiteDayAlbHero:InitAlbHero(photoHeroCfg, resloader, callback)
  self._photoHeroCfg = photoHeroCfg
  self._callback = callback
  self:SetAlbHeroSelectState(false)
  self.ui.tex_HeroName.text = ConfigData:GetHeroNameById(self._photoHeroCfg.photo_hero)
  local skinCfg = ConfigData.skin[self._photoHeroCfg.skinId]
  self.ui.img_HeroPic.gameObject:SetActive(false)
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(skinCfg.src_id_pic), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_HeroPic.gameObject:SetActive(true)
    self.ui.img_HeroPic.texture = texture
  end)
end

function UINWhiteDayAlbHero:SetAlbHeroSelectState(flag)
  self.ui.bottom:SetIndex(flag and 1 or 0)
end

function UINWhiteDayAlbHero:OnClickSelect()
  if self._callback ~= nil then
    self._callback(self._photoHeroCfg, self)
  end
end

function UINWhiteDayAlbHero:GetPhotoHeroCfg()
  return self._photoHeroCfg
end

return UINWhiteDayAlbHero
