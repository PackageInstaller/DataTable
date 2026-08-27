local UINFosterUpgradeNode = class("UINFosterUpgradeNode", UIBaseNode)
local base = UIBaseNode
local UINFosterUpgradeCostItem = require("Game.Friendship.Foster.UINFosterUpgradeCostItem")
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")

function UINFosterUpgradeNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.CostItemPool = UIItemPool.New(UINFosterUpgradeCostItem, self.ui.obj_materialItem)
  self.ui.obj_materialItem:SetActive(false)
end

function UINFosterUpgradeNode:InitUpgradekNode(heroId, heroLevel, friendShipLevel)
  self.heroId = heroId
  self.friendShipLevel = friendShipLevel or 1
  self.heroLevel = heroLevel or 1
end

function UINFosterUpgradeNode:RefreshAndShowInfo(fosterCfg, nowlevel)
  local cfg = fosterCfg[nowlevel + 1]
  local requireFlevel = cfg.friendship_level
  local requireHlevel = cfg.hero_level
  self.ui.tex_Condition1:SetIndex(0, tostring(requireFlevel))
  if requireFlevel <= self.friendShipLevel then
    self.ui.img_conditionItem1.color = self.ui.color_fullfill
  else
    self.ui.img_conditionItem1.color = self.ui.color_notFullfill
  end
  self.ui.tex_Condition2:SetIndex(1, tostring(requireHlevel))
  if requireHlevel <= self.heroLevel then
    self.ui.img_conditionItem2.color = self.ui.color_fullfill
  else
    self.ui.img_conditionItem2.color = self.ui.color_notFullfill
  end
  local allItemList = {}
  self.CostItemPool:HideAll()
  for index, id in ipairs(cfg.deduct_itemIds) do
    if id ~= ConstGlobalItem.NormalGold then
      local item = self.CostItemPool:GetOne(true)
      item:InitCostItem(id, cfg.deduct_itemNums[index])
      table.insert(allItemList, item)
    end
  end
  local gindex = table.indexof(cfg.deduct_itemIds, ConstGlobalItem.NormalGold)
  local requireGNum = cfg.deduct_itemNums[gindex] or 0
  local totalG = PlayerDataCenter:GetItemCount(ConstGlobalItem.NormalGold)
  self.ui.tex_GName:SetIndex(0, LanguageUtil.GetLocaleText(ConfigData.item[ConstGlobalItem.NormalGold].name))
  if requireGNum > totalG then
    self.ui.tex_GConsumeNum:SetIndex(1, tostring(requireGNum))
  else
    self.ui.tex_GConsumeNum:SetIndex(0, tostring(requireGNum))
  end
  self.ui.btn_Confirm.onClick:RemoveAllListeners()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, function()
    if self.friendShipLevel >= requireFlevel and self.heroLevel >= requireHlevel and self:__IsHaveEnoughItem(allItemList) and totalG >= requireGNum then
      self.networkCtrl:CS_INTIMACY_UpgradeLine(self.heroId, cfg.id)
    else
      print("条件不满足")
    end
  end)
  if requireFlevel <= self.friendShipLevel and requireHlevel <= self.heroLevel and self:__IsHaveEnoughItem(allItemList) and requireGNum <= totalG then
    self.ui.img_btn_Confirm.color = self.ui.color_canClick
  else
    self.ui.img_btn_Confirm.color = self.ui.color_canNotClick
  end
end

function UINFosterUpgradeNode:__IsHaveEnoughItem(allItemList)
  for index, item in ipairs(allItemList) do
    if item:IsHaveEnoughItem() == false then
      return false
    end
  end
  return true
end

function UINFosterUpgradeNode:OnDelete()
  base.OnDelete(self)
end

return UINFosterUpgradeNode
