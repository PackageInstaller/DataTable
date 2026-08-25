local function createAwakerLevelUpModellState(awakerModel)
  local state = {}
  
  state.awakerModel = awakerModel
  state.isSingle = true
  
  function state.levelUpText()
    local btnTextKey = "RoleDetailsAttributeLevelUp_Btn_LevelUpLimit"
    if state.isSingle then
      btnTextKey = "RoleDetailsAttributeLevelUp_Btn_LevelUp"
    end
    if state.level == state.targetLevel then
      btnTextKey = "Common_Button_Confirm"
    end
    do return LT.Text end
    return LT.Text, btnTextKey
  end
  
  function state.level()
    do return state.awakerModel.GetAwakerLevel, state.awakerModel, state:GetBaseTypeAwakerId() end
    return state.awakerModel.GetAwakerLevel, state.awakerModel, state:GetBaseTypeAwakerId()
  end
  
  state.targetLevel = 0
  
  function state.exp()
    do return state.awakerModel.GetAwakerExp, state.awakerModel, state:GetBaseTypeAwakerId() end
    return state.awakerModel.GetAwakerExp, state.awakerModel, state:GetBaseTypeAwakerId()
  end
  
  function state.maxLevel()
    local awakerMaxLevel = state.awakerModel:GetAwakerCurrLevelLimit(state:GetBaseTypeAwakerId())
    return awakerMaxLevel
  end
  
  function state.isMaxLevel()
    return state.level >= state.maxLevel
  end
  
  function state.canMaxLevel()
    return state.targetLevel >= state.maxLevel
  end
  
  function state.needReduceExp()
    local awakerId = state:GetBaseTypeAwakerId()
    local exp = state.exp
    local level = state.level
    local targetLevel = state.targetLevel
    local maxLevel = state.maxLevel
    local value = AwakerDataUtils.GetNeedReduceExpUpgrade(awakerId, exp, level, targetLevel, maxLevel)
    return value
  end
  
  function state.needExp()
    if state.isMaxLevel then
      return 0
    end
    if state.canMaxLevel then
      local awakerId = state:GetBaseTypeAwakerId()
      local need = AwakerDataUtils.GetExpUpgradeEx(awakerId, state.level, state.targetLevel)
      return need - state.exp
    end
    local totalExp = 0
    for _, v in ipairs(state.tSlotDatas) do
      totalExp = totalExp + v.expValue * v.useCnt
    end
    return totalExp
  end
  
  function state.improveAttrList()
    local awakerId = state:GetBaseTypeAwakerId()
    do return AwakerDataUtils.GetAwakerLevelChangeAttrImprove, awakerId, state.level end
    return AwakerDataUtils.GetAwakerLevelChangeAttrImprove, awakerId, state.level, state.targetLevel
  end
  
  function state.tSlotDatas()
    local tData = {}
    local oriList = DT.GetOriginalConstant("AwakerExpItem")
    local cnt = #oriList
    if 0 ~= cnt % 2 then
      Logger.Error("常量表AwakerExpItem字段配置异常，请煜铭检查")
      return tData
    end
    for i = 1, cnt, 2 do
      local tItems = {
        itemId = oriList[i],
        expValue = oriList[i + 1],
        useCnt = 0
      }
      table.insert(tData, tItems)
    end
    return tData
  end
  
  function state.tSlotDatas_Sorted()
    local t = {}
    for _, v in ipairs(state.tSlotDatas) do
      table.insert(t, v)
    end
    table.sort(t, function(a, b)
      return a.expValue < b.expValue
    end)
    return t
  end
  
  return state
end

local function createAwakerLevelUpModellViews(data)
  local views = {}
  
  function views:GetExpIcon()
    do return ItemDataUtils.GetSmallIcon end
    return ItemDataUtils.GetSmallIcon, CommonDefine.CurrencyType.AwakerUpgradeExp
  end
  
  function views:GetBaseTypeAwakerId()
    local awakerId = data.awakerModel.selectAwakerId
    if AwakerDataUtils.IsOriginType(awakerId) then
      awakerId = AwakerDataUtils.GetChangerForm(awakerId)
    end
    return awakerId
  end
  
  function views:GetExpItemSlotDatas()
    return data.tSlotDatas
  end
  
  function views:GetSlotData(index)
    return data.tSlotDatas[index]
  end
  
  function views:GetTotalCurrencyCost()
    do return AwakerDataUtils.CalcLevelUpCoinCost end
    return AwakerDataUtils.CalcLevelUpCoinCost, data.needExp
  end
  
  function views:GetTotalOriCost()
    local rate = DT.GetConstant("AwakerExpCoinRatio") or 0
    local billableExp = AwakerDataUtils.CalcLevelUpBillableExp(data.needExp)
    do return math.floor end
    return math.floor, billableExp * rate
  end
  
  function views:Get_ItemUsedProvide_Exp()
    local provideValue = 0
    for i, v in ipairs(data.tSlotDatas) do
      provideValue = provideValue + v.expValue * v.useCnt
    end
    return provideValue
  end
  
  function views:Get_ItemCanProvide_Exp()
    local provideValue = 0
    for i, v in ipairs(data.tSlotDatas) do
      local itemId = v.itemId
      local itemCnt = ItemDataUtils.GetItemNum(itemId)
      provideValue = provideValue + v.expValue * itemCnt
    end
    return provideValue
  end
  
  function views:GetImproveAttrList()
    return data.improveAttrList
  end
  
  function views:GetTargetLevel()
    return data.targetLevel
  end
  
  function views:GetSelectAwakerId()
    return self.awakerModel.selectAwakerId
  end
  
  function views:IsUseAllByIndex(index)
    local tSlotData = self:GetSlotData(index)
    local itemId = tSlotData.itemId
    local ownCnt = ItemDataUtils.GetItemNum(itemId)
    return tSlotData.useCnt == ownCnt
  end
  
  return views
end

local function createAwakerLevelUpModellActions(data)
  local actions = {}
  
  function actions:SetSingle(state)
    data.isSingle = state
  end
  
  function actions:SetTargetLevel(targetLevel)
    self.targetLevel = targetLevel
  end
  
  function actions:ReqAwakerLevelUp(cb)
    if data.maxLevel <= data.level then
      Alert.Show(10419)
      return
    end
    local currencyItemId = DT.GetConstant("GeneralCultivationNeedCurreny")
    local own = ItemDataUtils.GetItemNum(currencyItemId)
    if own < self:GetTotalCurrencyCost() then
      Alert.Show(10474)
      return
    end
    local tCostItem = {}
    for i, v in ipairs(data.tSlotDatas) do
      if v.useCnt > 0 then
        table.insert(tCostItem, {
          itemId = v.itemId,
          cnt = v.useCnt
        })
      end
    end
    if #tCostItem <= 0 then
      Alert.Show(10603)
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnAwakerLevelUpgrade", function(svrData)
      GlobalDispatcher:Dispatch(NotifyId.OnAwakerLevelUp, data.awakerModel.selectAwakerId)
      if cb then
        cb(svrData)
      end
    end, function()
    end, data.awakerModel.selectAwakerId, tCostItem)
  end
  
  function actions:SetSlotMaterialUseCnt(index, reqCnt)
    local tSlotData = self:GetSlotData(index)
    local itemId = tSlotData.itemId
    local ownCnt = ItemDataUtils.GetItemNum(itemId)
    if reqCnt > 0 and ownCnt <= 0 then
      return
    end
    if data.targetLevel >= data.maxLevel and reqCnt > 0 then
      Alert.Show(10600)
      return
    end
    local newUseCnt = tSlotData.useCnt + reqCnt
    newUseCnt = newUseCnt > 0 and newUseCnt or 0
    newUseCnt = ownCnt >= newUseCnt and newUseCnt or ownCnt
    tSlotData.useCnt = newUseCnt
    self:Match_TargetLevel()
  end
  
  function actions:Match_TargetLevel()
    local provideExp = self:Get_ItemUsedProvide_Exp() + data.exp
    self:SetMatchLevel(provideExp)
  end
  
  function actions:SetMatchLevel(provideExp)
    local lv = data.level
    local maxLevel = data.maxLevel
    while provideExp > 0 and not (lv >= maxLevel) do
      local nextLvNeedExp = AwakerDataUtils.GetExpUpgrade(data:GetBaseTypeAwakerId(), lv)
      provideExp = provideExp - nextLvNeedExp
      if provideExp >= 0 then
        lv = lv + 1
      end
    end
    self:SetTargetLevel(lv)
  end
  
  function actions:Max_TargetLevel()
    local provideExp = self:Get_ItemCanProvide_Exp() + data.exp
    self:SetMatchLevel(provideExp)
  end
  
  function actions:AutoSetExpItem()
    self:Max_TargetLevel()
    self:CleanAutoSetExp()
    local currencyItemId = DT.GetConstant("GeneralCultivationNeedCurreny")
    local playerGold = ItemDataUtils.GetItemNum(currencyItemId)
    
    local function CheckCoinNotEnough(needExp, useCountMap)
      local totalPlaced = 0
      for _, cnt in pairs(useCountMap) do
        totalPlaced = totalPlaced + cnt
      end
      if 0 == totalPlaced then
        local coinRatio = DT.GetConstant("AwakerExpCoinRatio") or 0
        local smallExp = AwakerDataUtils.GetSortedExpBottleInfos()[1].expValue
        local goldMaxUnits = coinRatio > 0 and smallExp > 0 and math.floor(playerGold / (coinRatio * smallExp)) or math.huge
        local isGoldBottleneck = goldMaxUnits < math.ceil(needExp / smallExp)
        if isGoldBottleneck then
          Alert.ShowStr("AwakerAutoInsertCoinNotEnoughTips")
        end
      end
    end
    
    local awakerId = data:GetBaseTypeAwakerId()
    local needExp = AwakerDataUtils.GetExpUpgradeEx(awakerId, data.level, data.targetLevel) - data.exp
    if needExp <= 0 then
      if data.targetLevel <= data.level then
        local totalItemExp = self:Get_ItemCanProvide_Exp()
        if totalItemExp > 0 then
          local useCountMap = AwakerDataUtils.CalcAutoPlaceExpItemUseCounts(totalItemExp, playerGold)
          for _, slotData in ipairs(data.tSlotDatas) do
            slotData.useCnt = useCountMap[slotData.itemId] or 0
          end
          self:Match_TargetLevel()
          CheckCoinNotEnough(totalItemExp, useCountMap)
        end
      end
      return
    end
    local useCountMap = AwakerDataUtils.CalcAutoPlaceExpItemUseCounts(needExp, playerGold)
    for _, slotData in ipairs(data.tSlotDatas) do
      slotData.useCnt = useCountMap[slotData.itemId] or 0
    end
    CheckCoinNotEnough(needExp, useCountMap)
    self:Match_TargetLevel()
  end
  
  function actions:CleanAutoSetExp()
    for i, v in ipairs(data.tSlotDatas) do
      v.useCnt = 0
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, _, _)
    local tmpLv = model.awakerModel:GetAwakerLevel(model:GetBaseTypeAwakerId())
    model:SetTargetLevel(tmpLv)
    model:CleanAutoSetExp()
  end, function()
    return model.awakerModel.selectAwakerId
  end)
end

local AwakerLevelUpModel = Vue.model("AwakerLevelUpModel", createAwakerLevelUpModellState):views(createAwakerLevelUpModellViews):actions(createAwakerLevelUpModellActions):setup(onSetup)
return AwakerLevelUpModel
