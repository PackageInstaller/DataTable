local base = require("Game.Reinforce.UI.Card.Item.UINRfCdBuffItem")
local UINReinforceCardDunBuffItem = class("UINReinforceCardDunBuffItem", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINReinforceCardDunBuffItem:OnInit()
  base.OnInit(self)
end

function UINReinforceCardDunBuffItem:BindLayerBuffDes(des)
  self.layerBuffDes = des
end

function UINReinforceCardDunBuffItem:SetReinfoceDunBuffCount(num)
  self.ui.Tex_Num.gameObject:SetActive(num ~= nil)
  self.ui.Tex_Num.text = tostring(num)
end

function UINReinforceCardDunBuffItem:_OnClickRoot()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  if self.layerBuffDes ~= nil then
    win:SetTitleAndContext(LanguageUtil.GetLocaleText(self.buffCfg.name), self.layerBuffDes)
  else
    win:SetTitleAndContext(LanguageUtil.GetLocaleText(self.buffCfg.name), LanguageUtil.GetLocaleText(self.buffCfg.describe))
  end
  win:FloatTo(self.transform, HAType.autoCenter, VAType.down, 0, 0.5)
end

function UINReinforceCardDunBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunBuffItem
