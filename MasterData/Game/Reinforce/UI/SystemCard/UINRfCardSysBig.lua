local base = require("Game.Reinforce.UI.Card.UINReinforceCardBase")
local UINRfCardSysBig = class("UINRfCardSysBig", base)

function UINRfCardSysBig:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRfCardSysBig:InitRfCardSysBig(rfCardData, resloader)
  base.InitRfCardBase(self, rfCardData, resloader)
end

function UINRfCardSysBig:InitRfCDBaseSystem()
  base.InitRfCDBaseSystem(self)
  self.ui.tex_DesSys.text = self._rfCardData:GetRfCdSysDes()
  self.ui.tex_ActName.text = self._rfCardData:GetRfCdActName()
  self.ui.tex_ActTime.text = self._rfCardData:GetRfCdActTimeStr()
end

function UINRfCardSysBig:OnDelete()
  base.OnDelete(self)
end

return UINRfCardSysBig
