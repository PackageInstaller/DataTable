local UINActivityCollectFortuneLotteryNode = class("UINActivityCollectFortuneLotteryNode", UIBaseNode)
local base = UIBaseNode
local UINActivityCollectFortuneGiftLotteryToggleItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneGiftLotteryToggleItem")
local UINActivityCollectFortuneLotteryItem = require("Game.ActivityCollectFortune.UI.UINActivityCollectFortuneLotteryItem")

function UINActivityCollectFortuneLotteryNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._lotteryItemPool = UIItemPool.New(UINActivityCollectFortuneLotteryItem, self.ui.LotteryItem)
  self.ui.LotteryItem:SetActive(false)
  self._toggleItemList = {}
  for index, comp in ipairs(self.ui.ToggleArray) do
    local toggle = UINActivityCollectFortuneGiftLotteryToggleItem.New()
    toggle:Init(comp.gameObject)
    UIUtil.AddValueChangedListener(comp, self, self.OnGiftLotteryToggleItemChanged, index)
    table.insert(self._toggleItemList, toggle)
  end
end

function UINActivityCollectFortuneLotteryNode:InitCollectFortuneLotteryNode(actData)
  self._actData = actData
  local mainCfg = actData:GetActCollectFortuneMainCfg()
  local tradCfg = actData:GetActCollectFortuneTradCfg()
  if mainCfg == nil or tradCfg == nil then
    error("cant find activity collectfortune config!!")
    return
  end
  self.ui.Tex_Rule.text = ConfigData:GetTipContent(mainCfg.pool_rule)
  for index, toggleItem in ipairs(self._toggleItemList) do
    local curTradCfg = tradCfg[index]
    if curTradCfg ~= nil then
      toggleItem:InitCollectFortuneToggleItem(LanguageUtil.GetLocaleText(curTradCfg.pool_name))
    end
  end
  local poolId = self._actData:GetActCollectFortunePoolId()
  local toggleItem = self._toggleItemList[poolId]
  toggleItem:SetToggleItemIsSelected(true)
end

function UINActivityCollectFortuneLotteryNode:RefreshCollectFortuneLotteryList(index)
  local actAwardPoolCfg = self._actData:GetActCollectFortuneAwardCfg()
  if actAwardPoolCfg == nil then
    error("cant find activity collectfortune config!!")
    return
  end
  local poolCfgWithId = actAwardPoolCfg[index]
  if poolCfgWithId == nil then
    error("cant find activity collectfortune config!!")
    return
  end
  self._lotteryItemPool:HideAll()
  for poolRewardId, cfg in ipairs(poolCfgWithId) do
    local item = self._lotteryItemPool:GetOne()
    item:Init(self.ui.LotteryItem)
    local rewards = cfg.reward
    local rewardId, rewardNum
    for id, num in pairs(cfg.reward) do
      rewardId = id
      rewardNum = num
    end
    local gotCount = self._actData:GetActCollectFortunePoolRewardGot(poolRewardId)
    local poolId = self._actData:GetActCollectFortunePoolId()
    if index == 1 and index < poolId then
      gotCount = cfg.quantity
    end
    item:InitCollectFortuneLotteryItem(rewardId, rewardNum, cfg.quantity, gotCount)
  end
end

function UINActivityCollectFortuneLotteryNode:OnGiftLotteryToggleItemChanged(index, isOn)
  if isOn then
    self:RefreshCollectFortuneLotteryList(index)
  end
  local item = self._toggleItemList[index]
  local color = self.ui.NotChooseColor
  local textColor = self.ui.TextNotChooseColor
  if isOn then
    color = self.ui.ChooseColor
    textColor = self.ui.TextChooseColor
  end
  item:OnToggleItemValueChanged(isOn, color, textColor)
end

function UINActivityCollectFortuneLotteryNode:OnDelete()
  self._lotteryItemPool:DeleteAll()
  for _, item in ipairs(self._toggleItemList) do
    item:Delete()
  end
  base.OnDelete(self)
end

return UINActivityCollectFortuneLotteryNode
