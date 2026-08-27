local base = UIBaseNode
local UINSignInLiveStreamItem = class("UINSignInLiveStreamRewardNodeItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINSignInLiveStreamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.item = UINBaseItemWithReceived.New(UINBaseItemWithReceived)
  self.item:Init(self.ui.uINBaseItemWithReceived)
end

function UINSignInLiveStreamItem:RefreshSILSItem(itemId, itemNum, isPicked)
  self.ui.Tex_Num.gameObject.transform.parent.gameObject:SetActive(not isPicked)
  local itemCfg = ConfigData.item[itemId]
  if isPicked then
    self.item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  else
    self.item:InitItemWithCount(itemCfg, nil, nil, isPicked)
    local totalNum = PlayerDataCenter:GetItemCount(itemId)
    if itemNum <= totalNum then
      self.ui.Tex_Num:SetIndex(0, tostring(itemNum), tostring(totalNum))
    else
      self.ui.Tex_Num:SetIndex(1, tostring(itemNum), tostring(totalNum))
    end
  end
end

function UINSignInLiveStreamItem:OnDelete()
  base.OnDelete(self)
end

return UINSignInLiveStreamItem
