local function cardsSortFunc(a, b)
  local aAwaker = a.awaker or 0
  
  local bAwaker = b.awaker or 0
  if aAwaker ~= bAwaker then
    if 0 == aAwaker then
      return true
    end
    if 0 == bAwaker then
      return false
    end
  end
  if a.timeStamp == b.timeStamp then
    return a.configId > b.configId
  end
  return a.timeStamp > b.timeStamp
end

local WorldStageCardPanelEx, Super = System.NewClass("WorldStageCardPanelEx", UIBasePanel)
WorldStageCardPanelEx.uiResCls = UI_Card_Panel_DiscardResource

function WorldStageCardPanelEx:ctor(params)
  Super.ctor(self)
  self.drawCards = self:GetDrawCards(params)
  self.dropCards = self:GetDropCards(params)
  self.title = params.title
  AudioManager.Instance:PostSoundEvent("EXPLORE_DECK_POP")
end

function WorldStageCardPanelEx:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Closure, function()
    self:Close()
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Card, function()
    return self.drawCards
  end, function(itemBinder, item, index)
    local card = self.drawCards[index]
    local uid = card.uid
    local configId = card.configId
    local battleDesc
    local cost = card.cost
    if bg.IsInBattle() and card.GetCardDescription then
      battleDesc = card:GetCardDescription()
      cost = card:GetCost()
    end
    local cardComp = itemBinder:BindComponent(CardBaseComponent(item, uid, configId, false, cost, battleDesc, nil, nil, card.level))
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
    if card.lock then
      cardComp:SetAblCardLock(true)
    else
      cardComp:SetAblCardLock(false)
    end
  end)
  binder:SetText(self.ui.Text_Quantity, string.format("数量：%s", #self.drawCards))
  binder:SetText(self.ui.Text_Title, self.title)
end

function WorldStageCardPanelEx:GetDropCards(params)
  local dropCards = params.dropCards
  if not CardDataUtils.GetRealOrderShowCard() then
    dropCards = {}
    for _, card in ipairs(params.dropCards or {}) do
      table.insert(dropCards, card)
    end
    if params.needOrder then
      table.sort(dropCards, cardsSortFunc)
    end
  end
  return dropCards or {}
end

function WorldStageCardPanelEx:GetDrawCards(params)
  local drawCards = params.drawCards
  if not CardDataUtils.GetRealOrderShowCard() then
    drawCards = {}
    for _, card in ipairs(params.drawCards or {}) do
      if not card.lock then
        table.insert(drawCards, card)
      end
    end
    if params.needOrder then
      table.sort(drawCards, cardsSortFunc)
    end
  end
  return drawCards or {}
end

return WorldStageCardPanelEx
