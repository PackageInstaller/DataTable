local base = UIBaseNode
local UINRfCardSetSelectSetNodeSysNodeItem = class("UINRfCardSetSelectSetNodeSysNodeItem", base)
local UINRfCardSetSysItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectSysItem")
local UINRfCardSetFacItem = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectFacItem")
local eReinforce = require("Game.Reinforce.Enum.eReinforce")

function UINRfCardSetSelectSetNodeSysNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.facItem = UINRfCardSetFacItem.New()
  self.facItem:Init(self.ui.facItem)
  self.sysItem = UINRfCardSetSysItem.New()
  self.sysItem:Init(self.ui.sysItem)
end

function UINRfCardSetSelectSetNodeSysNodeItem:InitCardSetSelectTotalItem(cardType, data, resLoader, isEquip, setNode, curInstallIndex, cardIndex)
  self.type = cardType
  self._resLoader = resLoader
  self.cardIndex = cardIndex
  if cardType == eReinforce.eRfCardType.System then
    self.facItem:Hide()
    self.sysItem:Show()
    self.sysItem:InitRfCardSetSelectFacItem(data, self._resLoader, isEquip, setNode, curInstallIndex)
  else
    self.facItem:Show()
    self.sysItem:Hide()
    self.facItem:InitRfCardSetSelectFacItem(data, self._resLoader, isEquip, setNode, curInstallIndex)
  end
end

function UINRfCardSetSelectSetNodeSysNodeItem:PlayTotalItemTween(delayTime, constTime)
  if self.type == eReinforce.eRfCardType.System then
    self.sysItem:PlaySelectItemTween(delayTime, constTime)
  else
    self.facItem:PlaySelectItemTween(delayTime, constTime)
  end
end

return UINRfCardSetSelectSetNodeSysNodeItem
