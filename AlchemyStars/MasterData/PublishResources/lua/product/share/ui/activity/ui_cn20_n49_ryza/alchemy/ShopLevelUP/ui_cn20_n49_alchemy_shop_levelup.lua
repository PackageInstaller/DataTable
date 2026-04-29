_class("UICN20N49AlchemyShopLevelUP", UIController)
UICN20N49AlchemyShopLevelUP = UICN20N49AlchemyShopLevelUP

function UICN20N49AlchemyShopLevelUP:LoadDataOnEnter(TT, res)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_N20
  local componentIds = {
    ECampaignCN20ComponentID.ECN20_ALCHEMY
  }
  self._campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  res:SetSucc(true)
end

function UICN20N49AlchemyShopLevelUP:OnShow(uiParams)
  self._campaign = uiParams[1]
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self.alchemyComponent = UICN20N49Helper.GetComponent(self._campaign, "alchemy")
  self.alchemyComponentInfo = self.alchemyComponent:GetComponentInfo()
  self.alchemyShopComponentInfo = UICN20N49Helper.GetComponentInfo(self._campaign, "alchemyShop")
  self.alchemyProgressComponent = UICN20N49Helper.GetComponent(self._campaign, "alchemyShop")
  self._cfg = Cfg.cfg_component_alchemy_shop_fitup({
    ComponentID = self.alchemyComponent:GetComponentCfgId()
  })
  self._formulaCfg = {}
  for i, v in pairs(self._cfg) do
    if v.Type == EAlchemyShopItemType.EAlchemyShopItemType_BuyFormula then
      table.insert(self._formulaCfg, {cfg = v, sortWeight = -1})
    end
  end
  self:InitWidget()
  self._goldItemID = Cfg.cfg_global.AlchemyMoneyItemID.IntValue
  self:InitUI()
end

function UICN20N49AlchemyShopLevelUP:IsHasFormula(formulaID)
  return self.itemModule:GetItemCount(formulaID) > 0
end

function UICN20N49AlchemyShopLevelUP:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.formulaListPool = self:GetUIComponent("UISelectObjectPath", "FormulaList")
  self.gratuityListPool = self:GetUIComponent("UISelectObjectPath", "GratuityList")
  self.alchemyUpListPool = self:GetUIComponent("UISelectObjectPath", "AlchemyUpList")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.goldText = self:GetUIComponent("UILocalizationText", "GoldText")
  self.formulaListPool:SpawnObjects("UICN20N49AlchemyShopLevelUPItem", #self._formulaCfg)
  self.alchemyUpListPool:SpawnObjects("UICN20N49AlchemyShopLevelUPItem", 1)
  self.gratuityListPool:SpawnObjects("UICN20N49AlchemyShopLevelUPItem", 1)
  self.alchemyUp = self.alchemyUpListPool:GetAllSpawnList()[1]
  self.gratuity = self.gratuityListPool:GetAllSpawnList()[1]
  self.formulaList = self.formulaListPool:GetAllSpawnList()
end

function UICN20N49AlchemyShopLevelUP:_RefreshBuff(curBuffID, buffType, widget, isFinish)
  if curBuffID == 0 then
    local cfgList = Cfg.cfg_component_alchemy_shop_fitup({Type = buffType})
    for _, v in pairs(cfgList) do
      if v.Money == 0 then
        curBuffID = v.ID
      end
    end
  end
  local cfg = Cfg.cfg_component_alchemy_shop_fitup({ID = curBuffID})[1]
  widget:SetData(cfg, isFinish, self)
end

function UICN20N49AlchemyShopLevelUP:ShowBonus(cfg)
  self:ShowDialog("UICN20N49AlchemyShopLevelUPComplete", cfg)
end

function UICN20N49AlchemyShopLevelUP:SortFormulaCfgList()
  self._curProgress = self.alchemyProgressComponent:GetCurProgress()
  self._gold = self.itemModule:GetItemCount(self._goldItemID)
  for index, v in ipairs(self._formulaCfg) do
    if v.cfg.UnlockLevel >= self._curProgress and v.cfg.Money >= self._gold then
      v.sortWeight = 10
    elseif self:IsHasFormula(v.cfg.FormulaID) then
      v.sortWeight = 1
    else
      v.sortWeight = 5
    end
  end
  table.sort(self._formulaCfg, function(a, b)
    return a.sortWeight > b.sortWeight
  end)
end

function UICN20N49AlchemyShopLevelUP:RefreshWidgetData()
  self:SortFormulaCfgList()
  self._curProgress = self.alchemyProgressComponent:GetCurProgress()
  self._gold = self.itemModule:GetItemCount(self._goldItemID)
  self.goldText:SetText(tostring(self._gold))
  for index, v in ipairs(self._formulaCfg) do
    local isFinish = self:IsHasFormula(v.cfg.FormulaID)
    self.formulaList[index]:SetData(v.cfg, isFinish, self)
  end
  local curTipBuffID = self.alchemyComponentInfo.show_tip_buff_id
  self:_RefreshBuff(curTipBuffID, EAlchemyShopItemType.EAlchemyShopItemType_TipBuff, self.gratuity, self.alchemyComponentInfo.tip_buff_finish)
  local curExtraBuffID = self.alchemyComponentInfo.show_extra_buff_id
  self:_RefreshBuff(curExtraBuffID, EAlchemyShopItemType.EAlchemyShopItemType_ExtraItem, self.alchemyUp, self.alchemyComponentInfo.extra_buff_finsih)
end

function UICN20N49AlchemyShopLevelUP:InitUI()
  self:_InitBackBtn()
  self:RefreshWidgetData()
end

function UICN20N49AlchemyShopLevelUP:OnUpdate(deltaTimeMS)
end

function UICN20N49AlchemyShopLevelUP:_InitBackBtn()
  self.backBtns:SetData(function()
    self._timerHandler = GameGlobal.Timer():AddEventTimes(200, TimerTriggerCount.Once, function()
      self:CloseDialog()
    end)
  end, nil, nil, true, nil, false, nil)
end
