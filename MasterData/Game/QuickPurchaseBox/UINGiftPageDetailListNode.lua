local UINGiftPageDetailListNode = class("UINGiftPageDetailListNode", UIBaseNode)
local base = UIBaseNode
local cs_ResLoader = CS.ResLoader
local UINGiftPageDetailListNodeGroup = require("Game.QuickPurchaseBox.UINGiftPageDetailListNodeGroup")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local JumpManager = require("Game.Jump.JumpManager")

function UINGiftPageDetailListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.giftPageGroupPool = UIItemPool.New(UINGiftPageDetailListNodeGroup, self.ui.obj_groupItem, false)
  self.mustGetItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_mustGetItem, false)
  self.resloader = cs_ResLoader.Create()
  self.__OnClickItemView = BindCallback(self, self.OnClickItemView)
end

function UINGiftPageDetailListNode:InitGiftPageDetailListNode(payGiftInfo)
  self.payGiftInfo = payGiftInfo
  local flag, giftCfg, allDay = payGiftInfo:TryGetGiftSubscriptionCfg()
  local isRandom, rGiftCfg = payGiftInfo:TryGetGiftRaffleCfg()
  if not flag and not isRandom then
    error("这个礼包不存在订阅项 id is " .. tostring(payGiftInfo.groupCfg.id) .. ".并且这个礼包不是随机礼包")
    return
  end
  if flag then
    self:RefreshNextGiftInfo(giftCfg, allDay)
  else
    self:RefreshRaffleGiftInfo(rGiftCfg)
  end
end

function UINGiftPageDetailListNode:RefreshNextGiftInfo(giftCfg, allDay)
  local otherPayGiftInfo = ControllerManager:GetController(ControllerTypeId.PayGift).dataDic[giftCfg.particulars]
  if self.payGiftInfo:IsCheckNextGift() then
    self.ui.tex_Tips:SetIndex(1, LanguageUtil.GetLocaleText(self.payGiftInfo.groupCfg.name), LanguageUtil.GetLocaleText(otherPayGiftInfo.groupCfg.name))
  else
    self.ui.tex_Tips:SetIndex(0, tostring(allDay))
  end
  local textureName = otherPayGiftInfo.groupCfg.icon
  self.resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_giftIcon.texture = texture
    end
  end)
  self.ui.tex_Des:SetIndex(0)
  self.ui.obj_raffleGiftList:SetActive(false)
  self.giftPageGroupPool:HideAll()
  self.ui.tex_giftName.text = LanguageUtil.GetLocaleText(otherPayGiftInfo.groupCfg.name)
  local awardIds = otherPayGiftInfo.giftCfgList[1].awardIds
  local awardCounts = otherPayGiftInfo.giftCfgList[1].awardCounts
  for i, itemId in ipairs(awardIds) do
    local itemCfg = ConfigData.item[itemId]
    local item = self.giftPageGroupPool:GetOne(true)
    item:InitGiftPageDetailListNodeGroup(itemCfg, awardCounts[i])
    item:SetItemView(itemCfg, self.__OnClickItemView)
  end
end

function UINGiftPageDetailListNode:RefreshRaffleGiftInfo(giftCfg)
  self.ui.tex_Tips:SetIndex(2)
  local textureName = self.payGiftInfo.groupCfg.icon
  self.resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_giftIcon.texture = texture
    end
  end)
  self.ui.tex_giftName.text = LanguageUtil.GetLocaleText(self.payGiftInfo.groupCfg.name)
  self.ui.obj_raffleGiftList:SetActive(true)
  self.ui.tex_mustGetTip:SetIndex(0)
  self.mustGetItemPool:HideAll()
  self.giftPageGroupPool:HideAll()
  local awardIds = self.payGiftInfo.giftCfgList[1].awardIds
  local awardCounts = self.payGiftInfo.giftCfgList[1].awardCounts
  for i, itemId in ipairs(awardIds) do
    local itemCfg = ConfigData.item[itemId]
    local item = self.mustGetItemPool:GetOne(true)
    item:InitItemWithCount(itemCfg, awardCounts[i])
    if itemCfg.type == eItemType.RaffleBox then
      self.raffleItem = itemCfg
    end
  end
  if self.raffleItem then
    self.ui.tex_Des:SetIndex(1, LanguageUtil.GetLocaleText(self.raffleItem.name))
    local raffleItemList = ConfigData.item.raffleBoxDic[self.raffleItem.id]
    for _, raffleCfg in pairs(raffleItemList) do
      local item = self.giftPageGroupPool:GetOne(true)
      item:InitGiftPageDetailListNodeGroup(ConfigData.item[raffleCfg.rewardId], raffleCfg.rewardCount)
      item:SetRaffleItemWeight(raffleCfg.weight)
      item:SetItemView(ConfigData.item[raffleCfg.rewardId], self.__OnClickItemView)
    end
  end
end

function UINGiftPageDetailListNode:OnClickItemView(curCfg)
  if self.raffleItem then
    local raffleItemList = ConfigData.item.raffleBoxDic[self.raffleItem.id]
    local skinIds = {}
    for _, raffleCfg in pairs(raffleItemList) do
      local itemCfg = ConfigData.item[raffleCfg.rewardId]
      if itemCfg.type == eItemType.Skin then
        table.insert(skinIds, itemCfg.id)
      end
    end
    JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
      curCfg.id,
      require("Game.Skin.SkinEnum").fromWhere.shopOrGift,
      skinIds
    }, true)
  else
    JumpManager:Jump(JumpManager.eJumpTarget.HeroSkin, nil, nil, {
      curCfg.id,
      require("Game.Skin.SkinEnum").fromWhere.shopOrGift
    }, true)
  end
end

function UINGiftPageDetailListNode:OnDelete()
  self.mustGetItemPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UINGiftPageDetailListNode
