local ReplenishEnergyView, Super = System.NewClass("ReplenishEnergyView", BaseView)
ReplenishEnergyView.uiResCls = UI_Other_Physical_TipsResource
local EnergyRestoreTime = DT.GetConstant("EnergyRestoreTime")
local EnergyExceedRestoreTime = DT.GetConstant("EnergyExceedRestoreTime")

function ReplenishEnergyView:ctor()
  Super.ctor(self)
  self.model = ReplenishEnergyModel.Instance
  self.itemComps = {}
end

function ReplenishEnergyView:OnBuildView()
  Super.OnBuildView(self)
end

function ReplenishEnergyView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self._OnBagUpdated))
end

function ReplenishEnergyView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
end

function ReplenishEnergyView:OnEnterView()
  Super.OnEnterView(self)
  self.model:SetCurSelectCfgId(0)
  self:_BindEnergeRestoreInfo()
  self:_InitMedicineItem()
  self:_RefreshText()
  self:_RefreshVisible()
end

function ReplenishEnergyView:OnExitView()
  Super.OnExitView(self)
end

function ReplenishEnergyView:_OnClickConfirm()
  local tid = self.model:GetCurSelectCfgId()
  local exchangeType = self.model:GetExchangeDescType(tid)
  
  local function useAfterCall()
    self:Close()
  end
  
  ReplenishEnergyController.Instance:OnClickConfirm(tid, exchangeType, useAfterCall)
end

function ReplenishEnergyView:_BindEnergeRestoreInfo()
  self:_RefreshRestoreInfo()
  self:BindTimer(0.3, -1, System.fn(self, self._RefreshRestoreInfo))
end

function ReplenishEnergyView:_RefreshRestoreInfo()
  local countDown = math.floor(DataCenter.playerData.DRole.nextEnergyRestoreTimeStamp - TimeUtils.GetServerTime())
  if countDown < 0 then
    countDown = 0
  end
  local curEnergy = PlayerDataUtils.GetEnergy()
  local maxEnergy = PlayerDataUtils.GetMaxEnergyLimit()
  local commonRecoverLimit = PlayerDataUtils.GetEnergyNaturalRecoverLimit(DataCenter.playerData.DRole.level)
  if curEnergy < maxEnergy then
    local commonRecoverEnergy = commonRecoverLimit - curEnergy
    commonRecoverEnergy = commonRecoverEnergy > 0 and commonRecoverEnergy or 0
    local overRecoverEnergy = math.min(maxEnergy - commonRecoverLimit, maxEnergy - curEnergy)
    local deltaTime
    if curEnergy < commonRecoverLimit then
      deltaTime = EnergyRestoreTime * (commonRecoverEnergy - 1)
    else
      deltaTime = EnergyExceedRestoreTime * (overRecoverEnergy - 1)
    end
    self:SetText(self.ui.Text_NextTime, self.model:GetRestoreShowStr(countDown))
    self:SetText(self.ui.Text_AllTime, self.model:GetRestoreShowStr(deltaTime + countDown))
  else
    self:SetText(self.ui.Text_NextTime, "")
    self:SetText(self.ui.Text_AllTime, "")
  end
  self:_RefreshVisible()
end

function ReplenishEnergyView:_InitMedicineItem()
  local tReplenishEnergyItems = DT.GetOriginalConstant("ReplenishEnergyItem")
  self.itemComps = {}
  for i, v in ipairs(tReplenishEnergyItems) do
    local itemcfgId = tonumber(v)
    local cnt = ItemDataUtils.GetItemNum(itemcfgId)
    self.model:SetExchangeDescIndex(itemcfgId, i)
    if cnt > 0 or 1 ~= i then
      local tItemUids = ItemDataUtils.GetItemUidMap(itemcfgId)
      local uid = table.next(tItemUids or {})
      if 0 == self.model:GetCurSelectCfgId() then
        self.model:SetCurSelectCfgId(itemcfgId)
      end
      local itemData = {
        tid = itemcfgId,
        uid = uid,
        callback = System.fn(self, self._ItemOnClick),
        articleNumberShowFunc = System.fn(self, self._CountShowFunc),
        clickFrameShowFunc = function()
          return itemcfgId == self.model:GetCurSelectCfgId()
        end,
        ShowRedDot = false
      }
      local comp = self:AddViewComponentOnce(self.ui["Medicine_" .. i], CompPublicIconItemType1, itemData)
      self.itemComps[i] = comp
    else
      self.ui["Medicine_" .. i]:SetActive(false)
    end
  end
  self.model:ShowExchangeDesc(self.model:GetCurSelectCfgId())
end

function ReplenishEnergyView:_RefreshText()
  self:SetText(self.ui.Text_Title, LT.Text("ReplenishEnergy_Title"))
  self:SetText(self.ui.Text_Supplement, LT.Text("ReplenishEnergy_Supplement"))
  local tips = self:_GetAutoRecoverTips()
  self:SetText(self.ui.Text_Auto, tips)
  local frequencyDesc = self.model:GetFrequencyDesc()
  self:SetText(self.ui.Text_Frequency, frequencyDesc)
  local promptDesc = self.model:GetPromptDesc()
  self:SetText(self.ui.Text_Prompt, promptDesc)
  local confirmDesc = self:_GetConfirmDesc()
  self:SetText(self.ui.Text_Name, confirmDesc)
end

function ReplenishEnergyView:_RefreshVisible()
  local isShowRestoreInfo = self.model:CheckNeedShowRestoreInfo()
  self.ui.ImageZ:SetActive(isShowRestoreInfo)
  self.ui.ImageE:SetActive(isShowRestoreInfo)
end

function ReplenishEnergyView:_ItemOnClick(tid, _)
  self.model:SetCurSelectCfgId(tid)
  self.model:ShowExchangeDesc(tid)
  self:_RefreshSelectFrame(nil, tid)
  self:_RefreshText()
end

function ReplenishEnergyView:_RefreshSelectFrame(_, tid)
  for _, comp in pairs(self.itemComps) do
    if comp and comp.ui and comp.ui.Image_Select then
      comp.ui.Image_Select:SetActive(comp.tid == tid)
    end
  end
end

function ReplenishEnergyView:_OnBagUpdated()
  for _, comp in pairs(self.itemComps) do
    if comp and comp.ui and comp.ui.Text_Article_Number then
      comp:SetText(comp.ui.Text_Article_Number, comp:Text_Article_Number_Text())
    end
  end
end

function ReplenishEnergyView:_CountShowFunc(tid, num)
  local exchangeType = self.model:GetExchangeDescType(tid)
  if CommonDefine.ExchangeType.DiamondExchange == exchangeType then
    local costCnt, _, _ = self.model:GetParamByExchangeType(exchangeType)
    local str = num >= costCnt and num or string.format("<color=#ff6969>%s</color>", num)
    return str
  else
    return num
  end
end

function ReplenishEnergyView:_GetAutoRecoverTips()
  local recoverLimit = PlayerDataUtils.GetEnergyNaturalRecoverLimit(DataCenter.playerData.DRole.level)
  local itemNum = PlayerDataUtils.GetEnergy()
  return recoverLimit > itemNum and LT.Text("EnergyCommonAutoRecoverTips") or LT.Text("EnergyOverAutoRecoverTips")
end

function ReplenishEnergyView:_GetConfirmDesc()
  local tid = self.model:GetCurSelectCfgId()
  local exchangeType = self.model:GetExchangeDescType(tid)
  do return self.model.GetComfirmDescByExchangeType, self.model end
  return self.model.GetComfirmDescByExchangeType, self.model, exchangeType
end

return ReplenishEnergyView
