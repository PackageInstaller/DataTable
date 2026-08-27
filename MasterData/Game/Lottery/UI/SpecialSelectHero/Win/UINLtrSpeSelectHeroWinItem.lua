local base = UIBaseNode
local UINLtrSpeSelectHeroWinItem = class("UINLtrSpeSelectHeroWinItem", base)

function UINLtrSpeSelectHeroWinItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINLtrSpeSelectHeroWinItem:InitLtrSpeSelectHeroWinItem(itemId, resLoader, selectFunc)
  self._itemId = itemId
  self._heroId = ConfigData:GetHeroIdByItem(itemId)
  self._selectFunc = selectFunc
  local heroCfg = ConfigData.hero_data[self._heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(self._heroId))
    return
  end
  local careerCfg = ConfigData.career[heroCfg.career]
  self.ui.img_Carrer.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local resCfg = ConfigData.resource_model[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return
  end
  self.ui.img_Hero.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.img_Hero.texture = texture
    self.ui.img_Hero.enabled = true
  end)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.obj_OwnTag:SetActive(PlayerDataCenter.heroDic[self._heroId] ~= nil)
  self:SelectLtrSpeHeroWinItem(false)
end

function UINLtrSpeSelectHeroWinItem:SelectLtrSpeHeroWinItem(isSelected)
  self.ui.obj_Selected:SetActive(isSelected)
end

function UINLtrSpeSelectHeroWinItem:_OnClickRoot()
  if self._selectFunc then
    self._selectFunc(self._itemId, self)
  end
end

function UINLtrSpeSelectHeroWinItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrSpeSelectHeroWinItem
