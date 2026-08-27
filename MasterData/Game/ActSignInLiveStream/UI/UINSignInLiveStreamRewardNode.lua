local base = UIBaseNode
local UINSignInLiveStreamRewardNode = class("UINSignInLiveStreamRewardNode", base)
local UINSignInLiveStreamRewardNodeItem = require("Game.ActSignInLiveStream.UI.UINSignInLiveStreamRewardNodeItem")

function UINSignInLiveStreamRewardNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self.Hide)
  UIUtil.AddButtonListener(self.ui.Btn_BG, self, self.Hide)
  self.itemPool = UIItemPool.New(UINSignInLiveStreamRewardNodeItem, self.ui.Item, false)
end

function UINSignInLiveStreamRewardNode:RefreshSILSRewardNode(SILSData)
  local collectedIdDic = SILSData:GetSILSDataCollectedRewardIdDic()
  local ids = SILSData:GetSILSDataAllRewardIds()
  self.itemPool:HideAll()
  for _, rewardId in ipairs(ids) do
    local item = self.itemPool:GetOne(true)
    local isCollected = collectedIdDic[rewardId]
    item:RefreshSILSRewardItem(SILSData, rewardId, self.resloader, isCollected)
  end
end

function UINSignInLiveStreamRewardNode:BindResloader(resloader)
  self.resloader = resloader
end

function UINSignInLiveStreamRewardNode:OnDelete()
  base.OnDelete(self)
end

return UINSignInLiveStreamRewardNode
