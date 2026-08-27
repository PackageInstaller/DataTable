local base = UIBaseNode
local UINLtrResultFrag = class("UINLtrResultFrag", base)
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINLtrResultFrag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrResultFrag:InitLtrResultFrag(hasRepeatConvert, upHeroExtraFragNum, extraFragId)
  self.ui.obj_RepeatFrag:SetActive(hasRepeatConvert)
  local hasExtraFrag = 0 < upHeroExtraFragNum
  self.ui.extraFragItem:SetActive(hasExtraFrag)
  if hasExtraFrag then
    local extraItem = UINBaseItem.New()
    extraItem:Init(self.ui.uINBaseItem)
    extraItem:SetItemNoClickEvent(true)
    local itemCfg = ConfigData.item[extraFragId]
    extraItem:InitBaseItem(itemCfg)
    self.extraItem = extraItem
    self.ui.tex_ExtraFragNum.text = "x" .. tostring(upHeroExtraFragNum)
  end
end

function UINLtrResultFrag:OnDelete()
  if self.extraItem ~= nil then
    self.extraItem:Delete()
  end
  base.OnDelete(self)
end

return UINLtrResultFrag
