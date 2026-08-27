local base = UIBaseNode
local UINReinforceCardSetBuffNode = class("UINReinforceCardSetBuffNode", base)
local UINReinforceCardSetBuffItem = require("Game.Reinforce.UI.CardSet.BuffDes.UINReinforceCardSetBuffItem")

function UINReinforceCardSetBuffNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self.__OnClickClose)
  self.itemPool = UIItemPool.New(UINReinforceCardSetBuffItem, self.ui.obj_buffItem, false)
end

function UINReinforceCardSetBuffNode:InitReinforceCSDN(dynBuffDataList)
  self.dynBuffDataList = dynBuffDataList
  self:__RefreshAllBuff()
end

function UINReinforceCardSetBuffNode:__RefreshAllBuff()
  self.itemPool:HideAll()
  for _, dynBuffData in ipairs(self.dynBuffDataList) do
    local buffItem = self.itemPool:GetOne()
    buffItem:InitReinforceCSDNBuffItem(dynBuffData)
  end
end

function UINReinforceCardSetBuffNode:__OnClickClose()
  self:Hide()
end

function UINReinforceCardSetBuffNode:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINReinforceCardSetBuffNode
