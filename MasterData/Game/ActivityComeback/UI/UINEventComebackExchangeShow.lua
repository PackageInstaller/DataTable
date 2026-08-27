local UINEventComebackExchangeShow = class("UINEventComebackExchangeShow", UIBaseNode)
local base = UIBaseNode
local UINEventComebackExchangeShowTitle = require("Game.ActivityComeback.UI.UINEventComebackExchangeShowTitle")
local UINAct21SumExcgRewardItem = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgRewardItem")

function UINEventComebackExchangeShow:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseShow)
  UIUtil.AddButtonListener(self.ui.closeBg, self, self.OnClickCloseShow)
  self.titlePool = UIItemPool.New(UINEventComebackExchangeShowTitle, self.ui.groupItems)
  self.ui.groupItems:SetActive(false)
  self._itemPool = UIItemPool.New(UINAct21SumExcgRewardItem, self.ui.exchangeItem)
  self.ui.exchangeItem:SetActive(false)
end

function UINEventComebackExchangeShow:UpdateExchangeShow(roundData, poolData)
  if self._roundData == roundData and self._poolData == poolData then
    self:__RefreshShow()
    return
  end
  self._roundData = roundData
  self._poolData = poolData
  self:__InitShow()
end

function UINEventComebackExchangeShow:__InitShow()
  self._rewardItemDic = {}
  self.titlePool:HideAll()
  self._itemPool:HideAll()
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  local bigRewardIds = poolparaCfg.reward_id
  self.ui.tex_ShelfIdx:SetIndex(0, LanguageUtil.GetLocaleText(poolparaCfg.pool_name))
  local bigRewardTitle = self.titlePool:GetOne()
  bigRewardTitle.transform:SetParent(self.ui.rect)
  bigRewardTitle:InitExchangeShowTitle(0)
  local poolIds = self._roundData:GetRoundIds()
  if poolIds[#poolIds] ~= self._poolData:GetRoundId() then
    local index = table.indexof(poolIds, self._poolData:GetRoundId())
    index = index + 1
    local nextPool = self._roundData:GetRoundPoolData(poolIds[index])
    local nextPollCfg = nextPool:GetPoolParaCfg()
    bigRewardTitle:SetNextPoolTip(LanguageUtil.GetLocaleText(nextPollCfg.pool_name))
  end
  for i, rewardId in ipairs(bigRewardIds) do
    local usedMun, allNum = self._poolData:GetRoundSingleRewardCount(rewardId)
    local poolContent = poolparaCfg.poolContent[rewardId]
    local item = self._itemPool:GetOne()
    item.transform:SetParent(bigRewardTitle.transform)
    local remainCount = allNum - usedMun
    item:InitAct21SumExcgRewardItem(ConfigData.item[poolContent.rewardId], poolContent.rewardNum, remainCount)
    self._rewardItemDic[rewardId] = item
  end
  local normalTitle = self.titlePool:GetOne()
  normalTitle.transform:SetParent(self.ui.rect)
  normalTitle:InitExchangeShowTitle(1)
  local normalRewardIdList = {}
  for rewardId, _ in pairs(poolparaCfg.poolContent) do
    if self._rewardItemDic[rewardId] == nil then
      table.insert(normalRewardIdList, rewardId)
    end
  end
  table.sort(normalRewardIdList)
  for i, rewardId in ipairs(normalRewardIdList) do
    local usedMun, allNum = self._poolData:GetRoundSingleRewardCount(rewardId)
    local poolContent = poolparaCfg.poolContent[rewardId]
    local item = self._itemPool:GetOne()
    item.transform:SetParent(normalTitle.transform)
    local remainCount = allNum - usedMun
    item:InitAct21SumExcgRewardItem(ConfigData.item[poolContent.rewardId], poolContent.rewardNum, remainCount)
    self._rewardItemDic[rewardId] = item
  end
end

function UINEventComebackExchangeShow:__RefreshShow()
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  for rewardId, item in pairs(self._rewardItemDic) do
    local usedMun, allNum = self._poolData:GetRoundSingleRewardCount(rewardId)
    local poolContent = poolparaCfg.poolContent[rewardId]
    local remainCount = allNum - usedMun
    item:InitAct21SumExcgRewardItem(ConfigData.item[poolContent.rewardId], poolContent.rewardNum, remainCount)
  end
end

function UINEventComebackExchangeShow:OnClickCloseShow()
  self:Hide()
end

return UINEventComebackExchangeShow
