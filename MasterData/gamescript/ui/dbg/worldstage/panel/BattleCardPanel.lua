local BattleCardPanel, Super = System.NewClass("BattleCardPanel", UIBasePanel)
BattleCardPanel.uiResCls = UI_Common_Popup_Card_ListResource

function BattleCardPanel:ctor(params, maskClickClose)
  Super.ctor(self)
  self.maskClickClose = maskClickClose
  
  local function sortByCardType(a, b)
    local aType = DT.Skill[a.configId].Type
    local bType = DT.Skill[b.configId].Type
    local aWeight = 0
    if "Card_Strike" == aType then
      aWeight = 4
    elseif "Card_Defend" == aType then
      aWeight = 3
    elseif "Card_Skill" == aType then
      aWeight = 2
    elseif "Card_Awake" == aType then
      aWeight = 1
    end
    local bWeight = 0
    if "Card_Strike" == bType then
      bWeight = 4
    elseif "Card_Defend" == bType then
      bWeight = 3
    elseif "Card_Skill" == bType then
      bWeight = 2
    elseif "Card_Awake" == bType then
      bWeight = 1
    end
    if aWeight ~= bWeight then
      return aWeight > bWeight
    else
      return a.configId > b.configId
    end
  end
  
  local function sortFunc(a, b)
    local skillCfgA = DT.Skill[a.configId]
    local skillCfgB = DT.Skill[b.configId]
    if skillCfgA.AwakerID ~= skillCfgB.AwakerID then
      return a.configId > b.configId
    end
    do return sortByCardType, a end
    return sortByCardType, a, b
  end
  
  local drawCards = params.drawCards
  if not CardDataUtils.GetRealOrderShowCard() then
    drawCards = {}
    for _, card in ipairs(params.drawCards or {}) do
      table.insert(drawCards, card)
    end
    if params.needOrder then
      table.sort(drawCards, sortFunc)
    end
  end
  self.drawCards = drawCards or {}
  self.isEnableDrop = params.dropCards ~= nil
  local dropCards = params.dropCards
  if not CardDataUtils.GetRealOrderShowCard() then
    dropCards = {}
    for _, card in ipairs(params.dropCards or {}) do
      table.insert(dropCards, card)
    end
    if params.needOrder then
      table.sort(dropCards, sortFunc)
    end
  end
  self.dropCards = dropCards or {}
  self.title = params.title
  self.iconType = Vue.ref(params.iconType)
end

function BattleCardPanel:OnBind(binder)
  self.binder = binder
  self.ui.ScrollView_DrawCard:SetActive(true)
  self.ui.ScrollView_AbandonCard:SetActive(false)
  self.showDrawCard = Vue.ref(true)
  self.showAbandonCard = Vue.ref(false)
  self:BindNoCardTip()
  binder:BindZ1Button(self.ui.Btn_DrawCard, function()
    self.ui.ScrollView_DrawCard:SetActive(true)
    self.ui.ScrollView_AbandonCard:SetActive(false)
    self.showDrawCard.value = true
    self.showAbandonCard.value = false
  end, nil, nil, nil, function()
    return self.showDrawCard.value
  end)
  binder:BindZ1Button(self.ui.Btn_AbandonCard, function()
    self.ui.ScrollView_DrawCard:SetActive(false)
    self.ui.ScrollView_AbandonCard:SetActive(true)
    self.showDrawCard.value = false
    self.showAbandonCard.value = true
  end, nil, nil, nil, function()
    return self.showAbandonCard.value
  end)
  self.ui.Btn_AbandonCard:SetActive(self.isEnableDrop)
  self.ui.Line:SetActive(self.isEnableDrop)
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Common_Toggle_01)
  binder:BindToRaw(function(_, num)
    binder:SetText(self.ui.Text_DrawCard_1, LT.Textf("Battle_DrawCardGroup_Str", num))
    binder:SetText(self.ui.Text_DrawCard_2, LT.Textf("Battle_DrawCardGroup_Str", num))
  end, function()
    local unlockNum = 0
    for _, card in ipairs(self.drawCards) do
      if not card.showUnLock then
        unlockNum = unlockNum + 1
      end
    end
    return unlockNum
  end)
  binder:BindToRaw(function(_, num)
    binder:SetText(self.ui.Text_AbandonCard_1, LT.Textf("Battle_DisCardGroup_Str", num))
    binder:SetText(self.ui.Text_AbandonCard_2, LT.Textf("Battle_DisCardGroup_Str", num))
  end, function()
    return #self.dropCards
  end)
  binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.Close))
  binder:BindToCircularListView(self.ui.ScrollView_DrawCard, function()
    return self.drawCards
  end, function(itemBinder, item, index)
    local card = self.drawCards[index]
    local uid = card.uid
    local configId = card.configId
    local battleDesc, cost
    local cardLevel = card.level
    if DataCenter.barrierData.InBattle then
      battleDesc = card:GetCardDescription()
      cost = card:GetCost()
    else
      cost = card.cost
    end
    local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, false, cost, battleDesc))
    cardComp:SetSkipAutoKeywordTips(true)
    cardComp:SetClickCallback(function()
      local panelData = {
        cardUid = uid,
        cardTid = configId,
        imageBgHideFlag = false,
        cardDesc = battleDesc,
        cost = cost,
        cardLevel = cardLevel
      }
      UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
    end)
    if card.lock then
      cardComp:SetAblCardLock(true)
    else
      cardComp:SetAblCardLock(false)
    end
  end)
  binder:BindToRaw(function(childBinder, isShow)
    if not isShow then
      return
    end
    childBinder:BindToCircularListView(self.ui.ScrollView_AbandonCard, function()
      return self.dropCards
    end, function(itemBinder, item, index)
      local card = self.dropCards[index]
      local uid = card.uid
      local configId = card.configId
      local battleDesc, cost
      if DataCenter.barrierData.InBattle then
        battleDesc = card:GetCardDescription()
        cost = card:GetCost()
      else
        cost = card.cost
      end
      local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, false, cost, battleDesc))
      cardComp:SetSkipAutoKeywordTips(true)
      cardComp:SetClickCallback(function()
        local panelData = {
          cardUid = uid,
          cardTid = configId,
          imageBgHideFlag = false,
          cardDesc = battleDesc,
          cost = cost,
          cardLevel = card.level
        }
        UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
      end)
      if card.showUnLock then
        cardComp:SetAblCardLock(true)
      else
        cardComp:SetAblCardLock(false)
      end
    end)
  end, function()
    return self.showAbandonCard.value
  end)
  if self.maskClickClose then
    binder:BindButtonClick(self.ui.Btn_Mask, function()
      self:Close()
    end)
  end
end

function BattleCardPanel:BindNoCardTip()
  self.binder:BindToVisible(self.ui.Group_Null_Black, function()
    local isDrawDeck = self.showDrawCard.value
    local isDropDeck = self.showAbandonCard.value
    if isDrawDeck and 0 == #(self.drawCards or {}) then
      return true
    end
    if isDropDeck and 0 == #(self.dropCards or {}) then
      return true
    end
  end)
end

return BattleCardPanel
