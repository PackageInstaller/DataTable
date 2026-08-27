local UINEventGrowBag = class("UINEventGrowBag", UIBaseNode)
local base = UIBaseNode
local UINEventGrowBagReward = require("Game.EventGrowBag.UI.UINEventGrowBagReward")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UINEventGrowBag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardPool = UIItemPool.New(UINEventGrowBagReward, self.ui.rewardItem)
  self.ui.rewardItem.gameObject:SetActive(false)
end

function UINEventGrowBag:InitItem(cfg, data, buyCallback)
  self.cfg = cfg
  self.data = data
  self.buyCallback = buyCallback
  self:Refresh()
end

function UINEventGrowBag:Refresh()
  self.rewardPool:HideAll()
  local rewardState = self.data.taken[self.cfg.level]
  local isNormalLocked = PlayerDataCenter.playerLevel.level < self.cfg.level
  local isNormalGetReward = rewardState ~= nil and rewardState.base
  local itemId = self.cfg.base_item_ids[1]
  local num = self.cfg.base_item_nums[1]
  if itemId ~= nil and num ~= nil then
    local item = self.rewardPool:GetOne(true)
    item:InitItem(itemId, num, isNormalGetReward, isNormalLocked)
    item.transform:SetParent(self.ui.fixedItemList.transform)
    item.transform.localPosition = Vector3(0, 0, 0)
  end
  local isSeniorLocked = isNormalLocked or not self.data.unlockSenior
  local isSeniorGetReward = rewardState ~= nil and rewardState.senior
  for i, v in ipairs(self.cfg.senior_item_ids) do
    local num = self.cfg.senior_item_nums[i]
    local item = self.rewardPool:GetOne(true)
    item.gameObject:SetActive(true)
    item:InitItem(v, num, isSeniorGetReward, isSeniorLocked)
    item.transform:SetParent(self.ui.seniorItemList.transform)
  end
  local baseCanGet = rewardState == nil or not rewardState.base
  local seniorCanGet = self.data.unlockSenior and (rewardState == nil or not rewardState.senior)
  self.isCanGet = baseCanGet or seniorCanGet
  if isNormalLocked then
    self.itemState = -1
  elseif self.isCanGet or not self.data.unlockSenior then
    self.itemState = 0
  else
    self.itemState = 1
  end
  self.ui.tex_TaskIntro:SetIndex(0, tostring(self.cfg.level))
  local schedule = PlayerDataCenter.playerLevel.level
  local aim = self.cfg.level
  if schedule > aim then
    schedule = aim
  end
  local progress = schedule / aim
  progress = progress < 1 and progress or 1
  self.barWidth = self.ui.bar.rectTransform.rect.width
  local vec = self.ui.img_Fill.rectTransform.sizeDelta
  vec.x = self.barWidth * progress
  self.ui.img_Fill.rectTransform.sizeDelta = vec
end

return UINEventGrowBag
