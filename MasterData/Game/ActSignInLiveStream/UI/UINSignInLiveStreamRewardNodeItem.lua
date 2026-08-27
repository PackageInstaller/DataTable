local base = UIBaseNode
local UINSignInLiveStreamRewardNodeItem = class("UINSignInLiveStreamRewardNodeItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINSignInLiveStreamRewardNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Img_Pic, self, self.OnClick)
  self.itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINSignInLiveStreamRewardNodeItem:RefreshSILSRewardItem(SILSData, rewardId, resloader, isCollected)
  local itemId, name, icon_src = SILSData:GetSILSDataRewardItemIdAndName(rewardId)
  local itemIdList, itemNumList = SILSData:GetSILSDataRewardItemInfo(rewardId)
  self.itemCfg = ConfigData.item[itemId]
  resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("UI_SignInLiveStream"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.Img_Pic.sprite = AtlasUtil.GetResldSprite(spriteAtlas, icon_src)
  end)
  self.ui.Tex_Name.text = name
  self.itemPool:HideAll()
  for index, rewardId in ipairs(itemIdList) do
    local itemCfg = ConfigData.item[rewardId]
    local rewardNum = itemNumList[index]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, rewardNum, nil, isCollected)
  end
end

function UINSignInLiveStreamRewardNodeItem:OnClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitCommonItemDetail(self.itemCfg)
    end
  end)
end

function UINSignInLiveStreamRewardNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINSignInLiveStreamRewardNodeItem
