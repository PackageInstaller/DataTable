local UINFosterUnlockNode = class("UINFosterUnlockNode", UIBaseNode)
local base = UIBaseNode
local UINFosterUnlockRewardItem = require("Game.Friendship.Foster.UINFosterUnlockRewardItem")

function UINFosterUnlockNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.unlockRewardItemPool = UIItemPool.New(UINFosterUnlockRewardItem, self.ui.obj_materialItem)
  self.ui.obj_materialItem:SetActive(false)
end

function UINFosterUnlockNode:InitUnlockNode(heroId, heroLevel, friendShipLevel)
  self.heroId = heroId
  self.friendShipLevel = friendShipLevel or 1
  self.heroLevel = heroLevel or 1
end

function UINFosterUnlockNode:RefreshAndShowLockedInfo(fosterCfg)
  local requireFlevel = fosterCfg[1].friendship_level
  local requireHlevel = fosterCfg[1].hero_level
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
  self.unlockRewardItemPool:HideAll()
  for index, itemId in ipairs(fosterCfg[1].unlockIds) do
    local itemNum = fosterCfg[1].unlockNums[index]
    local item = self.unlockRewardItemPool:GetOne(true)
    item:InitItem(itemId, itemNum)
  end
  self.ui.btn_Unlock.onClick:RemoveAllListeners()
  UIUtil.AddButtonListener(self.ui.btn_Unlock, self, function()
    if self.friendShipLevel >= requireFlevel and self.heroLevel >= requireHlevel then
      self.networkCtrl:CS_INTIMACY_UpgradeLine(self.heroId, fosterCfg[1].id)
    else
      print("条件不满足")
    end
  end)
  if requireFlevel <= self.friendShipLevel and requireHlevel <= self.heroLevel then
    self.ui.img_btn_Unlock.color = self.ui.color_canClick
  else
    self.ui.img_btn_Unlock.color = self.ui.color_canNotClick
  end
end

function UINFosterUnlockNode:OnDelete()
  self.unlockRewardItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINFosterUnlockNode
