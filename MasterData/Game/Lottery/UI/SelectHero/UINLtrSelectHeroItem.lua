local UINLtrSelectHeroItem = class("UINLtrSelectHeroItem", UIBaseNode)
local base = UIBaseNode

function UINLtrSelectHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.tog_Root, self, self._OnClickRoot)
end

function UINLtrSelectHeroItem:InitLtrSelectHeroItem(heroId, selectFunc, resLoader)
  self.heroId = heroId
  self.selectFunc = selectFunc
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(heroId, 0)
  self.ui.img_Pic.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    if IsNull(self.transform) or IsNull(texture) then
      return
    end
    self.ui.img_Pic.texture = texture
    self.ui.img_Pic.enabled = true
  end)
  self.ui.isOwned:SetActive(PlayerDataCenter.heroDic[heroId] ~= nil)
end

function UINLtrSelectHeroItem:SetLtrSelectHeroItemIsOn(heroId)
  local isOn = heroId == self.heroId
  self.ui.img_Career.color = isOn and self.ui.color_selectBlack or Color.white
  self.ui.tex_Name.color = isOn and self.ui.color_selectBlack or Color.white
  self.ui.img_NameBg.color = isOn and Color.white or self.ui.color_selectBlack
  self.ui.img_Sel:SetIndex(isOn and 1 or 0)
end

function UINLtrSelectHeroItem:_OnClickRoot()
  if self.selectFunc ~= nil then
    self.selectFunc(self.heroId)
  end
end

function UINLtrSelectHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrSelectHeroItem
