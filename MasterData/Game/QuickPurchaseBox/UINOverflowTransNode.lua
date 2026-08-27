local UINOverflowTransNode = class("UINOverflowTransNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local ShopEnum = require("Game.Shop.ShopEnum")

function UINOverflowTransNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.leftUINBaseItemWithCount = UINBaseItemWithCount.New()
  self.leftUINBaseItemWithCount:Init(self.ui.obj_leftUINBaseItemWithCount)
  self.leftUINBaseItemWithCount:SetNotNeedAnyJump(true)
  self.rightUINBaseItemWithCount = UINBaseItemWithCount.New()
  self.rightUINBaseItemWithCount:Init(self.ui.obj_rightUINBaseItemWithCount)
  self.rightUINBaseItemWithCount:SetNotNeedAnyJump(true)
end

function UINOverflowTransNode:InitOverflowTransItemInfo(goodData)
  self.ui.tex_Des.text = ConfigData:GetTipContent(15001)
  self.leftUINBaseItemWithCount:InitItemWithCount(goodData.itemCfg, goodData.itemNum, nil)
  self.ui.tex_leftItemName.text = LanguageUtil.GetLocaleText(goodData.itemCfg.name)
  local right, rightId, rightNum = self:GetOverflowIdAndNum(goodData)
  if not right then
    error("cant trans overflow item,itemId is :" .. goodData.itemCfg.id)
    return
  end
  local rightItemCfg = ConfigData.item[rightId]
  self.rightUINBaseItemWithCount:InitItemWithCount(rightItemCfg, rightNum * goodData.itemNum)
  self.ui.tex_rightItemName.text = LanguageUtil.GetLocaleText(rightItemCfg.name)
end

function UINOverflowTransNode:GetOverflowIdAndNum(goodData)
  local isId, id, num = true
  if goodData.itemCfg.overflow_type == eItemTransType.actMoneyX then
    for i, v in ipairs(goodData.itemCfg.overflow_para) do
      if isId then
        id = v
        isId = false
      else
        num = v
        isId = true
      end
    end
    return true, id, num
  end
  return false
end

return UINOverflowTransNode
