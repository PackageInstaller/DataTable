local UINAdjPresetBaseItem = require("Game.AdjCustom.AdjPreset.UINAdjPresetBaseItem")
local UINAdjPresetSingleItem = class("UINAdjPresetSingleItem", UINAdjPresetBaseItem)
local base = UINAdjPresetBaseItem
local UINAdjPresetItemSkinName = require("Game.AdjCustom.AdjPreset.UINAdjPresetItemSkinName")
local SkinEnum = require("Game.Skin.SkinEnum")

function UINAdjPresetSingleItem:__RefreshAdjPresetHero()
  base.__RefreshAdjPresetHero(self)
  local heroPreset = self._data:GetAdjPresetElemMain()
  if heroPreset == nil then
    return
  end
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resModelCfg = skinCtrl:GetResModel(heroPreset.dataId, heroPreset.skinId)
  self.ui.img_Hero.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resModelCfg.src_id_pic, SkinEnum.fromWhere.adjutant), function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_Hero.gameObject:SetActive(true)
    self.ui.img_Hero.texture = texture
  end)
  local skinId = heroPreset.skinId ~= 0 and heroPreset.skinId or ConfigData.hero_data[heroPreset.dataId].default_skin
  if self._skinNameItem == nil then
    self._skinNameItem = UINAdjPresetItemSkinName.New()
    self._skinNameItem:Init(self.ui.obj_HeroName)
  end
  self._skinNameItem:RefreshAdjPresetItemSkinName(skinId, self._data:GetAdjPresetUseL2d())
end

return UINAdjPresetSingleItem
