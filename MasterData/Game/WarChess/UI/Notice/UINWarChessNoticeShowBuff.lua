local base = UIBaseNode
local UINWarChessNoticeShowBuff = class("UINWarChessNoticeShowBuff", base)
local UINBuffDescItem = require("Game.Exploration.UI.EpBuffDesc.UINBuffDescItem")

function UINWarChessNoticeShowBuff:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.buffDescItem = UINBuffDescItem.New()
  self.buffDescItem:Init(self.ui.epBuffDescItem)
end

function UINWarChessNoticeShowBuff:InitWCNShowBuffItem(buffData)
  if buffData == nil then
    error("show buff not have buff data")
    return
  end
  self.buffDescItem:InitBuffDescItemForWCBuff(buffData)
end

return UINWarChessNoticeShowBuff
