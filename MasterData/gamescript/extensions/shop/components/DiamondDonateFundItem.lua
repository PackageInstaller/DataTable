local DiamondDonateFundItem, Super = NewViewComponent("DiamondDonateFundItem")

function DiamondDonateFundItem:ctor(uiNode, view, index, awardsData, maxIndex)
  Super.ctor(self, uiNode, view)
  self.index = (index - 1) % #awardsData + 1
  self.realIndex = index
  self.realMaxIndex = maxIndex
  self.ui = UI_Other_Item_AwardResource(uiNode)
  self.data = awardsData[self.index]
  self.awardsData = awardsData
  self.curGroup = self:_GetCurGroup()
  self.oneCycleTotlaExchange = self:_GetOneCycleTotalExchange()
  self.cyclesTotalExchange = self:_GetCyclesNum(self.realIndex) * self.oneCycleTotlaExchange
  self:_CalSliderValueRange()
end

function DiamondDonateFundItem:RegisterNotifications()
end

function DiamondDonateFundItem:RegisterEvents()
end

function DiamondDonateFundItem:OnEnterComponent()
  self:_RefreshComponent()
end

function DiamondDonateFundItem:_RefreshComponent()
  local curExchangdNum = MainShopDataUtils.GetExchangeNum()
  local totalNum = self.cyclesTotalExchange + self.data.NeedTotalExchange
  local isGot = self:_IsGot()
  local canReceived = curExchangdNum >= totalNum and not isGot
  local itemInfoList = self:_GetItemTidAndNumList()
  local parentTs = self.ui.Group_Rewards.transform
  self:ReserveChildren(parentTs, #itemInfoList)
  for i = 1, #itemInfoList do
    local itemInfo = itemInfoList[i]
    local go = parentTs:GetChild(i - 1).gameObject
    go:SetActive(true)
    local viewData = {
      itemTid = itemInfo.tid,
      isShowRing = canReceived,
      itemCount = itemInfo.num,
      isGot = isGot or false,
      isShowEffect = self.data.IsBigReward or false,
      clickFunc = function()
        local tempIsGot = self:_IsGot()
        local tempCanReceived = MainShopDataUtils.GetExchangeNum() >= self.data.NeedTotalExchange + self.cyclesTotalExchange
        if not tempIsGot and tempCanReceived then
          DiamondShopDataUtils.ExchangeGainRewardBatchAll()
        else
          ItemDataUtils.ShowItemDetailTips(self.binder, go, nil, itemInfo.tid)
        end
      end
    }
    self:AddViewComponentOnce(go, CompPublicIconItemType2, viewData)
  end
  for i = #itemInfoList + 1, parentTs.childCount do
    local go = parentTs:GetChild(i - 1).gameObject
    go:SetActive(false)
  end
  self:SetText(self.ui.Text_Victory, totalNum)
  if self.data.IsBigReward then
    self.ui.Image_Bright:SetActive(true)
    self.ui.Image_Dark:SetActive(false)
    self.ui.Bright_Open:SetActive(curExchangdNum >= totalNum)
  else
    self.ui.Image_Bright:SetActive(false)
    self.ui.Image_Dark:SetActive(true)
    self.ui.Dark_Open:SetActive(curExchangdNum >= totalNum)
  end
  local progress = (curExchangdNum - self.sliderMin) / (self.sliderMax - self.sliderMin)
  self:SetImageFillAmount(self.ui.Image_Finish, math.max(0, math.min(progress, 1)))
end

function DiamondDonateFundItem:_GetCurGroup()
  return self:_GetCyclesNum(self.realIndex) + 1
end

function DiamondDonateFundItem:_GetItemTidAndNumList()
  local rst = {}
  self:_CalRankReward(rst, self.data.RankReward)
  self:_CalRankReward(rst, self.data.RankReward2)
  self:_CalRankReward(rst, self.data.RankReward3)
  return rst
end

function DiamondDonateFundItem:_CalRankReward(rst, rankReward)
  for k, count in pairs(rankReward or {}) do
    if type(k) ~= "number" or not DT.Item[k] then
    else
      for idx, rewardInfo in ipairs(rst or {}) do
        if rewardInfo.tid == k then
          rst[idx].num = rst[idx].num + count
          goto lbl_47
        end
      end
      table.insert(rst, {tid = k, num = count})
    end
    ::lbl_47::
  end
end

function DiamondDonateFundItem:_IsGot()
  do return DiamondShopDataUtils.IsDiamondExchangeGot, self.curGroup end
  return DiamondShopDataUtils.IsDiamondExchangeGot, self.curGroup, self.index
end

function DiamondDonateFundItem:_GetCyclesNum(index)
  do return math.floor end
  return math.floor, (index - 1) / #self.awardsData, #self.awardsData
end

function DiamondDonateFundItem:_GetOneCycleTotalExchange()
  return self.awardsData[#self.awardsData].NeedTotalExchange
end

function DiamondDonateFundItem:_CalSliderValueRange()
  local preRealIndex = self.realIndex - 1
  local nextRealIndex = self.realIndex + 1
  if nextRealIndex > self.realMaxIndex then
    nextRealIndex = self.realMaxIndex
  end
  local preIndex = (preRealIndex - 1) % #self.awardsData + 1
  local nextIndex = (nextRealIndex - 1) % #self.awardsData + 1
  local preData = self.awardsData[preIndex]
  local nextData = self.awardsData[nextIndex]
  local pre_cyclesTotalExchange = self:_GetCyclesNum(preRealIndex) * self.oneCycleTotlaExchange
  local next_cyclesTotalExchange = self:_GetCyclesNum(nextRealIndex) * self.oneCycleTotlaExchange
  local curExchangeVal = self.data.NeedTotalExchange + self.cyclesTotalExchange
  local minVal = 0
  local maxVal = curExchangeVal
  if preData then
    local preExchangeVal = pre_cyclesTotalExchange + preData.NeedTotalExchange
    minVal = preExchangeVal + (curExchangeVal - preExchangeVal) * 0.5
  end
  if nextData then
    local nextExchangeVal = nextData.NeedTotalExchange + next_cyclesTotalExchange
    maxVal = curExchangeVal + (nextExchangeVal - curExchangeVal) * 0.5
  end
  self.sliderMin = minVal
  self.sliderMax = maxVal
end

return DiamondDonateFundItem
