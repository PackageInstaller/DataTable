local UINWhiteDayHeroItem = class("UINWhiteDayHeroItem", UIBaseNode)
local base = UIBaseNode

function UINWhiteDayHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_heroItem, self, self.__OnClick)
end

function UINWhiteDayHeroItem:InitWDHeroItem(heroCfg, isPickPhoto, heroAssistType, clickEvent, resloader)
  self.heroCfg = heroCfg
  self.clickEvent = clickEvent
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local heroData = PlayerDataCenter.heroDic[heroCfg.id]
  local picPath
  if heroData ~= nil then
    picPath = PathConsts:GetCharacterPicPath(heroData:GetResPicName())
  else
    local defaultSkin = heroCfg.default_skin
    local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
    local resCfg = skinCtr:GetResModel(heroCfg.id, defaultSkin)
    picPath = PathConsts:GetCharacterPicPath(resCfg.res_Name)
  end
  resloader:LoadABAssetAsync(picPath, function(texture)
    if IsNull(self.transform) then
      return
    end
    if self.heroCfg ~= heroCfg then
      return
    end
    self.ui.img_HeroPic.texture = texture
    self.ui.img_HeroPic.enabled = true
  end)
  if isPickPhoto then
    self.ui.obj_icon:SetActive(false)
  else
    self.ui.obj_icon:SetActive(true)
    self.ui.img_Icon:SetIndex(heroAssistType - 1)
  end
end

function UINWhiteDayHeroItem:__OnClick()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINWhiteDayHeroItem:SetWDHeroItemSelected(bool)
  if bool then
    self.ui.img_bottom:SetIndex(1)
  else
    self.ui.img_bottom:SetIndex(0)
  end
end

function UINWhiteDayHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayHeroItem
