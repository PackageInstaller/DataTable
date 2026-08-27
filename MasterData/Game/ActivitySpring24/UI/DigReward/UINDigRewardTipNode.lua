local UINDigRewardTipNode = class("UINDigRewardTipNode", UIBaseNode)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local base = UIBaseNode

function UINDigRewardTipNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINDigRewardTipNode:InitDigRewardTipNode(spring24Data)
  self.spring24Data = spring24Data
  self.treasureData = self.spring24Data:GetTreasureData()
end

function UINDigRewardTipNode:RefreshDigRewardTipNode()
  local nowNum = self.treasureData:GetNowDigRewardNum()
  local nowMaxNum = self.treasureData:GetNowMaxRewardNum()
  local realMaxNum = self.treasureData:GetMaxRewardNum()
  local isNotAttachMax = nowMaxNum < realMaxNum
  local tagId = isNotAttachMax and 1 or 0
  local isShowMaxTip = not isNotAttachMax or self.spring24Data:IsActivityRunning()
  local rate = 0
  if realMaxNum == 0 then
    rate = 0
  elseif nowNum == realMaxNum then
    rate = 1
  else
    rate = nowNum / realMaxNum
  end
  self.ui.tex_Progress:SetIndex(0, tostring(nowNum), tostring(realMaxNum))
  self.ui.bar.value = rate
  self.ui.tex_tag:SetIndex(tagId)
  self.ui.obj_Tag:SetActive(isShowMaxTip)
  local rewardIds, rewardNums, rewardGots = self.treasureData:GetJackPotRewardList()
  self.rewardItemPool:HideAll()
  for i, id in ipairs(rewardIds) do
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(ConfigData.item[id], rewardNums[i], nil, rewardGots[i])
  end
end

function UINDigRewardTipNode:OnHide()
  base.OnHide(self)
  self.rewardItemPool:HideAll()
end

function UINDigRewardTipNode:OnDelete()
end

return UINDigRewardTipNode
