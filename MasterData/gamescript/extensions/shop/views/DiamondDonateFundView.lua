local DiamondDonateFundView, Super = NewClass("DiamondDonateFundView", BaseView)
DiamondDonateFundView.uiResCls = UI_Other_Fund_TipsResource

function DiamondDonateFundView:OnBuildView()
  Super.OnBuildView(self)
end

function DiamondDonateFundView:RegisterEvents()
  Super.RegisterEvents(self)
  self.awardsView = self:CreateTableview(self.ui.ScrollView, function()
    return self.maxCellsNum
  end, function(view, index)
    local cell = self:DequeueCell(view, self.ui.UI_Other_Item_Award)
    self:_FillCell(cell, index)
    return cell
  end, function()
    return 263, 429
  end)
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:Close()
  end)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickBtnTips))
  
  function self.awardsView.reloadFinishCallback()
    self:_DisplayFirstViewItem()
  end
  
  self:AddButtonClickListener(self.ui.Btn_Click_UP, System.fn(self, self._OnClickReserScrollview))
  self:AddButtonClickListener(self.ui.Btn_Click_Down, System.fn(self, self._OnClickReserScrollview))
end

function DiamondDonateFundView:_GetTargetIndex()
  local exchangeNum = MainShopDataUtils.GetExchangeNum()
  local totalExchange = self.awardsData[#self.awardsData].NeedTotalExchange
  local cyclesNum = math.ceil(exchangeNum / totalExchange) + 1
  local targetIndex
  for i = 1, cyclesNum do
    for j = 1, #self.awardsData do
      local curExchangeNum = totalExchange * (i - 1) + self.awardsData[j].NeedTotalExchange
      if exchangeNum >= curExchangeNum and not DiamondShopDataUtils.IsDiamondExchangeGot(i, j) then
        targetIndex = (i - 1) * #self.awardsData + j
        break
      end
    end
    if targetIndex then
      break
    end
  end
  if not targetIndex then
    for i = 1, cyclesNum do
      for j = 1, #self.awardsData do
        local curExchangeNum = totalExchange * (i - 1) + self.awardsData[j].NeedTotalExchange
        if exchangeNum < curExchangeNum then
          targetIndex = (i - 1) * #self.awardsData + j
          break
        end
      end
      if targetIndex then
        break
      end
    end
  end
  return targetIndex or 1
end

function DiamondDonateFundView:_DisplayFirstViewItem()
  local targetIndex = self:_GetTargetIndex()
  if targetIndex then
    self.awardsView:MoveCellToCenter(targetIndex - 1)
  end
  self.defaultTargetIndex = targetIndex
end

function DiamondDonateFundView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:RegisterNotify(NotifyId.OnGetDiamondExchangeAwardsBatch, self._OnGetDiamondExchangeAwardsBatch, self)
end

function DiamondDonateFundView:OnEnterView()
  Super.OnEnterView(self)
  self.awardsData = DiamondShopDataUtils.awardsData
  self.maxCellsNum = #self.awardsData * 500
  self.awardsView:ReloadData()
  self:_RefreshView()
  LateUpdateBeat.Instance:Add(self.LateUpdate, self)
end

function DiamondDonateFundView:OnExitView()
  Super.OnExitView(self)
  LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
end

function DiamondDonateFundView:LateUpdate()
  if not self.awardsView.isReady or not self.defaultTargetIndex then
    return
  end
  local curMinIndex = math.huge
  local curMaxIndex = -1
  local cnt = self.awardsView:GetVisibleCount()
  for i = 0, cnt - 1 do
    local cell = self.awardsView:GetCellByIndex(i)
    if curMaxIndex < cell.index then
      curMaxIndex = cell.index
    end
    if curMinIndex > cell.index then
      curMinIndex = cell.index
    end
  end
  curMinIndex = curMinIndex + 1
  curMaxIndex = curMaxIndex + 1
  if curMinIndex <= self.defaultTargetIndex and curMaxIndex >= self.defaultTargetIndex then
    self.ui.Group_UP:SetActive(false)
    self.ui.Group_Down:SetActive(false)
    return
  end
  if curMinIndex > self.defaultTargetIndex then
    self.ui.Group_UP:SetActive(true)
    self.ui.Group_Down:SetActive(false)
    return
  end
  if curMaxIndex < self.defaultTargetIndex then
    self.ui.Group_UP:SetActive(false)
    self.ui.Group_Down:SetActive(true)
    return
  end
end

function DiamondDonateFundView:_RefreshView()
  self:SetText(self.ui.Text_Number, MainShopDataUtils.GetExchangeNum())
end

function DiamondDonateFundView:_FillCell(cell, index)
  self:AddViewComponentOnce(cell.gameObject, DiamondDonateFundItem, index, self.awardsData, self.maxCellsNum)
end

function DiamondDonateFundView:_OnClickBtnTips()
  UIManager.Instance:Reopen(Urls.CommonillustrateView, LT.Text("DiamondDonateTipTitle"), LT.Text("DiamondDonateTipContent"))
end

function DiamondDonateFundView:_OnClickReserScrollview()
  if self.awardsView.isReady and self.defaultTargetIndex then
    self.awardsView:MoveCellToCenter(self.defaultTargetIndex - 1)
  end
end

function DiamondDonateFundView:_OnGetDiamondExchangeAwardsBatch(group, indexList)
  for _, index in ipairs(indexList) do
    local realIndex = (group - 1) * #self.awardsData + index
    if realIndex == self.defaultTargetIndex then
      self.defaultTargetIndex = self:_GetTargetIndex()
    end
  end
  self.awardsView:ReloadData()
end

return DiamondDonateFundView
