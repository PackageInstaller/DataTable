local UINTDBtParticle = class("UINTDBtParticle", UIBaseNode)
local base = UIBaseNode
local UINTDBtCoinAddItem = require("Game.BattleTowerDefence.UI.Battle.UINTDBtCoinAddItem")

function UINTDBtParticle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._returnCoinAddFxFunc = BindCallback(self, self._ReturnCoinAddFx)
  self.ui.fX_CoinAdd:SetActive(false)
  self.coinAddItemPool = UIItemPool.New(UINTDBtCoinAddItem, self.ui.fX_CoinAdd)
end

function UINTDBtParticle:InitTDBtParticle()
end

function UINTDBtParticle:TDBtPlayCoinAddFx(coinNum, position)
  local coinAddItem = self.coinAddItemPool:GetOne()
  coinAddItem:InitTDBtCoinAddItem(coinNum, position, self._returnCoinAddFxFunc)
end

function UINTDBtParticle:_ReturnCoinAddFx(coinAddItem)
  self.coinAddItemPool:HideOne(coinAddItem)
end

function UINTDBtParticle:OnDelete()
  self.coinAddItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINTDBtParticle
