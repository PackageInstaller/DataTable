local UINWarChessStrategySelectItem = class("UINWarChessStrategySelectItem", UIBaseNode)
local base = UIBaseNode

function UINWarChessStrategySelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.srData = nil
  self.srSubItemId = nil
  UIUtil.AddButtonListener(self.ui.btn_StrategyItem, self, self.__OnClick)
end

function UINWarChessStrategySelectItem:InitAsWCStrategySelectItem(srData, onSelect)
  self.srData = srData
  self.srSubItemId = nil
  self.onSelect = onSelect
  local srId = self.srData.srId
  local wcStrategyEffectCfg = ConfigData.warchess_strategy_effect[srId]
  self.ui.tex_name.text = LanguageUtil.GetLocaleText(wcStrategyEffectCfg.name)
  self.des = LanguageUtil.GetLocaleText(wcStrategyEffectCfg.describ)
end

function UINWarChessStrategySelectItem:InitAsWCStrategySubSelectItem(data, rewardType, onSelect, index)
  self.srData = nil
  self.onSelect = onSelect
  self.index = index
  if rewardType == 1 then
  elseif rewardType == 2 then
    local buffData = data
    self.srSubItemId = buffData.id
    self.ui.img_Icon.sprite = CRH:GetSprite(buffData:GetWCBuffIcon(), CommonAtlasType.ExplorationIcon)
    self.ui.tex_name = LanguageUtil.GetLocaleText(buffData:GetWCBuffName())
    self.des = LanguageUtil.GetLocaleText(buffData:GetWCBuffDes())
  end
end

function UINWarChessStrategySelectItem:__OnClick()
  if self.onSelect ~= nil then
    self.onSelect(true, self)
  end
end

function UINWarChessStrategySelectItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessStrategySelectItem
