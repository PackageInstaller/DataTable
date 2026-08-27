local UINFairyAttriListNode = class("UINFairyAttriListNode", UIBaseNode)
local base = UIBaseNode
local UINFairyAttrListItem = require("Game.Fairy.UI.Attribute.UINFairyAttrListItem")

function UINFairyAttriListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, function()
    self:Hide()
    UIUtil.ReShowTopStatus()
  end)
  self.attrItemPool = UIItemPool.New(UINFairyAttrListItem, self.ui.obj_attrItem, false)
end

function UINFairyAttriListNode:InitUINFairyAttriListNode(fairyData)
  self:Show()
  self.fairyData = fairyData
  local attrDic = fairyData:GetFairyAttrAdd()
  self.attrItemPool:HideAll()
  local attrAddList = {
    100,
    200,
    0
  }
  local totalAttrNum = 0
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    for _, add in ipairs(attrAddList) do
      local realAttrId = attrId + add
      local attrValue = attrDic[realAttrId]
      if attrValue ~= nil and 0 < attrValue then
        local attrItem = self.attrItemPool:GetOne()
        attrItem:InitFairyAttrListItem(realAttrId, attrValue)
        totalAttrNum = totalAttrNum + 1
      end
      if 5 < totalAttrNum then
        warn("fairy attr above 5.")
        return
      end
    end
  end
end

function UINFairyAttriListNode:OnDelete()
  self.attrItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINFairyAttriListNode
