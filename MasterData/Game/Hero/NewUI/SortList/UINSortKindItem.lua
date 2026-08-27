local UINSortKindItem = class("UINSortKindItem", UIBaseNode)
local base = UIBaseNode
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")

function UINSortKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

function UINSortKindItem:InitSortKindItem(kindType, index, onSelectFunc)
  self.kindType = kindType
  self.index = index
  self.onSelectFunc = onSelectFunc
  self.isStarType = false
  if self.kindType == HeroFilterEnum.eKindType.Rank then
    self.isStarType = true
    self.ui.tex_KindName.text = tostring(index)
  elseif self.kindType == HeroFilterEnum.eKindType.Camp then
    if index == ConfigData:GetCampCountWithOther() then
      self.ui.tex_KindName.text = ConfigData:GetTipContent(TipContent.CampTip_Other)
    else
      local campCfg = ConfigData.camp[index]
      self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(campCfg.name)
    end
  elseif self.kindType == HeroFilterEnum.eKindType.Vowed then
    if index == ConfigData.game_config.heroVowed then
      self.ui.tex_KindName.text = ConfigData:GetTipContent(23011)
    else
      self.ui.tex_KindName.text = ConfigData:GetTipContent(23012)
    end
  else
    local carrerCfg = ConfigData.career[index]
    self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(carrerCfg.name)
  end
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
end

function UINSortKindItem:__OnKindItemClick()
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    self.onSelectFunc(self.kindType, self.index, self.select)
  end
end

function UINSortKindItem:SetSelectUIActive()
  self.ui.obj_OnSelect:SetActive(self.select)
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
  local selColor = self.select and Color.black or Color.white
  self.ui.tex_KindName.color = selColor
  self.ui.img_Star.color = selColor
end

function UINSortKindItem:SetSelectState(flag)
  self.select = flag
  self:SetSelectUIActive()
end

function UINSortKindItem:OnDelete()
  base.OnDelete(self)
end

return UINSortKindItem
