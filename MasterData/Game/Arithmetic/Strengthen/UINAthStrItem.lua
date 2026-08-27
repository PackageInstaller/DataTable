local UINAthStrItem = class("UINAthStrItem", UIBaseNode)
local base = UIBaseNode

function UINAthStrItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthStrItem:InitAthStrItem(athData, resLoader)
  local athCfg = athData.athCfg
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, athCfg.icon)
  end)
  self.ui.img_Quality.color = ItemQualityColor[athData:GetAthQuality()]
  self.ui.img_QualityAttr.color = athData:GetAthColor()
  local suitId = athCfg.suit
  local suitParamCfg = ConfigData.ath_suit.suitParamDic[suitId]
  self.ui.img_Suit.enabled = suitParamCfg ~= nil
  if suitParamCfg ~= nil then
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_Suit.sprite = AtlasUtil.GetResldSprite(spriteAtlas, suitParamCfg.icon)
    end)
  end
  local areaCfg = ConfigData.ath_area[athCfg.area_type]
  if areaCfg == nil then
    error("Can't find ath areaCfg by area_type, area_type = " .. tostring(athCfg.area_type))
    return
  end
  self.ui.tex_Name.text = athData:GetName()
  if #athData.athMainAttrCfg.attrtibute_id > 0 then
    local attrId = athData.athMainAttrCfg.attrtibute_id[1]
    local attrValue = athData.athMainAttrCfg.attrtibute_num[1]
    local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
    self.ui.tex_Vlaue.text = valueStr
    self.ui.img_Icon.sprite = CRH:GetSprite(icon)
  end
end

function UINAthStrItem:OnDelete()
  base.OnDelete(self)
end

return UINAthStrItem
