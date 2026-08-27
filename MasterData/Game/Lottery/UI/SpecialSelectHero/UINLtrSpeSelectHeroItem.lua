local base = UIBaseNode
local UINLtrSpeSelectHeroItem = class("UINLtrSpeSelectHeroItem", base)

function UINLtrSpeSelectHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrSpeSelectHeroItem:InitLtrSpeSelectHeroItem(heroId, resLoader)
  self.ui.empty:SetActive(false)
  self.ui.obj_Own:SetActive(false)
  self.ui.normal:SetActive(false)
  if heroId == nil then
    self.ui.empty:SetActive(true)
    return
  end
  self.ui.normal:SetActive(true)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return
  end
  local campCfg = ConfigData.camp[heroCfg.camp]
  self.ui.img_Camp.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Camp.texture = texture
    self.ui.img_Camp.enabled = true
  end)
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  self.ui.heroPic.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.heroPic.texture = texture
    self.ui.heroPic.enabled = true
  end)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.obj_Own:SetActive(PlayerDataCenter.heroDic[heroId] ~= nil)
end

function UINLtrSpeSelectHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrSpeSelectHeroItem
