local UINAct21SumExcgRewardList = class("UINAct21SumExcgRewardList", UIBaseNode)
local base = UIBaseNode
local UINAct21SumExcgRewardGroup = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgRewardGroup")
local UINAct21SumExcgRewardItem = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgRewardItem")

function UINAct21SumExcgRewardList:ctor(excgRoot)
  self.excgRoot = excgRoot
end

function UINAct21SumExcgRewardList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self._OnClickInfo)
  self.ui.groupItems:SetActive(false)
  self.ui.exchangeItem:SetActive(false)
  self.rewardGroupPool = UIItemPool.New(UINAct21SumExcgRewardGroup, self.ui.groupItems)
  self.rewardItemPool = UIItemPool.New(UINAct21SumExcgRewardItem, self.ui.exchangeItem)
end

function UINAct21SumExcgRewardList:InitAct21SumExcgRewardList(poolId, poolIdx, pickedRewardPoolIdDic, curPoolId)
  local poolParaCfg = ConfigData.activity_time_limit_pool_para[poolId]
  if poolParaCfg == nil then
    error("Cant get activity_time_limit_pool_para,id = " .. tostring(poolId))
    return
  end
  local rewardLvDic = {}
  local maxQuality = 1
  for k, poolCfg in pairs(poolParaCfg.poolContent) do
    rewardLvDic[poolCfg.reward_type] = rewardLvDic[poolCfg.reward_type] or {}
    local rewardList = rewardLvDic[poolCfg.reward_type]
    table.insert(rewardList, poolCfg)
    maxQuality = math.max(maxQuality, poolCfg.reward_type)
  end
  for k, rewardList in pairs(rewardLvDic) do
    table.sort(rewardList, self.excgRoot.ActSum21ExchangeRewardSortFunc)
  end
  self.ui.tex_ShelfIdx:SetIndex(0, tostring(poolIdx))
  self.rewardGroupPool:HideAll()
  self.rewardItemPool:HideAll()
  for i = 1, maxQuality do
    local rewardList = rewardLvDic[i]
    if rewardList ~= nil then
      local groupItem = self.rewardGroupPool:GetOne()
      groupItem.transform:SetParent(self.ui.rectHolder)
      local totalNum = 0
      local usedNum = 0
      for k, poolCfg in ipairs(rewardList) do
        local itemCfg = ConfigData.item[poolCfg.rewardId]
        local itemNum = poolCfg.rewardNum
        local surplusNum
        if poolId < curPoolId then
          surplusNum = 0
          usedNum = usedNum + poolCfg.num
        elseif curPoolId == poolId then
          surplusNum = poolCfg.num - pickedRewardPoolIdDic[poolCfg.id]
          usedNum = usedNum + pickedRewardPoolIdDic[poolCfg.id]
        else
          surplusNum = poolCfg.num
        end
        totalNum = totalNum + poolCfg.num
        local rewardItem = self.rewardItemPool:GetOne()
        rewardItem:InitAct21SumExcgRewardItem(itemCfg, itemNum, surplusNum)
        rewardItem.transform:SetParent(groupItem.transform)
        rewardItem.transform:SetAsLastSibling()
      end
      groupItem:InitAct21SumExcgRewardGroup(i, usedNum, totalNum)
    end
  end
end

function UINAct21SumExcgRewardList:_OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(7006), ConfigData:GetTipContent(326))
  end)
end

function UINAct21SumExcgRewardList:ShowRefreshUITween()
  self.ui.fade:DOKill()
  self.ui.fade.alpha = 0
  self.ui.fade:DOFade(1, 1)
end

function UINAct21SumExcgRewardList:OnDelete()
  self.rewardGroupPool:DeleteAll()
  self.rewardItemPool:DeleteAll()
  self.ui.fade:DOKill()
  base.OnDelete(self)
end

return UINAct21SumExcgRewardList
