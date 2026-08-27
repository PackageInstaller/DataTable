local UINAdjPresetBaseItem = require("Game.AdjCustom.AdjPreset.UINAdjPresetBaseItem")
local UINAdjPresetMultItem = class("UINAdjPresetMultItem", UINAdjPresetBaseItem)
local base = UINAdjPresetBaseItem
local CS_UnityEngine_GameObject = CS.UnityEngine.GameObject
local UINAdjPresetItemSkinName = require("Game.AdjCustom.AdjPreset.UINAdjPresetItemSkinName")
local SkinEnum = require("Game.Skin.SkinEnum")

function UINAdjPresetMultItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_sec, self, self.OnClickSecLoad)
  self._heroIconPool = {}
  table.insert(self._heroIconPool, self.ui.img_Hero)
  self.ui.img_Hero.gameObject:SetActive(false)
  self._heroNameTextPool = UIItemPool.New(UINAdjPresetItemSkinName, self.ui.obj_HeroName)
  self.ui.obj_HeroName:SetActive(false)
  self._heroNameIconDic = {}
end

function UINAdjPresetMultItem:__RefreshAdjPresetHero()
  base.__RefreshAdjPresetHero(self)
  self:__CycleResource()
  local heroList = self._data:GetAdjPresetHeroList()
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  for index, heorId in ipairs(heroList) do
    local heroPreset = self._data:GetAdjPresetElemData(heorId)
    local heroNameText = self._heroNameTextPool:GetOne()
    heroNameText.transform:SetAsLastSibling()
    local skinId = heroPreset.skinId ~= 0 and heroPreset.skinId or ConfigData.hero_data[heroPreset.dataId].default_skin
    heroNameText:RefreshAdjPresetItemSkinName(skinId, index == 1 and self._data:GetAdjPresetUseL2d())
    local heroIcon = self:__GetNewHeroIcon()
    heroIcon.transform:SetAsLastSibling()
    local resModelCfg = skinCtrl:GetResModel(heroPreset.dataId, heroPreset.skinId)
    self._resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resModelCfg.src_id_pic, SkinEnum.fromWhere.adjutant), function(texture)
      if IsNull(self.transform) or IsNull(texture) then
        return
      end
      heroIcon.gameObject:SetActive(true)
      heroIcon.texture = texture
    end)
    self._heroNameIconDic[heorId] = heroIcon
  end
  self.ui.heroEmpty:SetActive(#heroList < 2)
  self.ui.heroEmpty.transform:SetAsLastSibling()
end

function UINAdjPresetMultItem:__GetNewHeroIcon()
  local total = #self._heroIconPool
  if 0 < total then
    local img = self._heroIconPool[total]
    table.remove(self._heroIconPool, total)
    return img
  end
  local obj = CS_UnityEngine_GameObject.Instantiate(self.ui.img_Hero.gameObject, self.ui.img_Hero.transform.parent)
  local img = obj:GetComponent(typeof(CS.UnityEngine.UI.RawImage))
  return img
end

function UINAdjPresetMultItem:__CycleResource()
  self._heroNameTextPool:HideAll()
  for k, heroIcon in pairs(self._heroNameIconDic) do
    table.insert(self._heroIconPool, heroIcon)
    heroIcon.gameObject:SetActive(false)
    self._heroNameIconDic[k] = nil
  end
end

function UINAdjPresetMultItem:OnClickSecLoad()
  if self._clickEditFunc ~= nil then
    self._clickEditFunc(self._teamId, 2)
  end
end

return UINAdjPresetMultItem
