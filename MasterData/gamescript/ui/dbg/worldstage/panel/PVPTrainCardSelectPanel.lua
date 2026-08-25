local PVPTrainCardSelectPanel, Super = System.NewClass("PVPTrainCardSelectPanel", UIBasePanel)
PVPTrainCardSelectPanel.uiResCls = UI_Dbgcopy_Panel_StoreResource

function PVPTrainCardSelectPanel:ctor(cards, extraProperties)
  Super.ctor(self)
  self.cards = Vue.ref(cards)
  self.extraProperties = extraProperties
  self.totalCard = #cards
  self.selectedCards = Vue.ref({})
  self.cardItemList = {}
  self.selectNum = extraProperties.selectNum or 1
  self.minNum = extraProperties.minNum or 0
end

function PVPTrainCardSelectPanel:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Title, function()
    if self.extraProperties.desc then
      do return LT.Text end
      return LT.Text, self.extraProperties.desc, nil, nil
    else
      do return LT.Textf, "Battle_ChooseCardToHand", tostring(self.selectNum) end
      return LT.Textf, "Battle_ChooseCardToHand", tostring(self.selectNum)
    end
  end)
  self.ui.Text_Remove:SetActive(false)
  self.ui.Image_Icon:SetActive(false)
  self.ui.Text_Enchant:SetActive(false)
  binder:SetActive(self.ui.UI_Common_Item_Btn_2, true)
  binder:BindToText(self.ui.Text_Remove, function()
    return self.extraProperties.tip or ""
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Card, function()
    return self.cards.value
  end, function(itemBinder, item, index)
    local card = self.cards.value[index]
    if card then
      local cardComp = itemBinder:BindComponent(CardBaseComponent(item, nil, card.tid, false, card.cost, nil))
      cardComp:SetClickCallback(function()
        if table.contains(self.selectedCards.value, card.tid) then
          table.remove(self.selectedCards.value, table.findvalue(self.selectedCards.value, card.tid))
        else
          table.insert(self.selectedCards.value, 1, card.tid)
        end
        for i = #self.selectedCards.value, self.selectNum + 1, -1 do
          table.remove(self.selectedCards.value, i)
        end
        self:OnCardSelect()
      end)
      cardComp:SetSelectShow(SystemUtils.Contain(self.selectedCards.value, card.tid))
      self.cardItemList[card.tid] = cardComp
    end
  end, function(index)
    local tid = self.cards.value[index].tid
    if self.cardItemList[tid] then
      self.cardItemList[tid] = nil
    end
  end)
  self.btnState = Vue.ref(CommonDefine.BtnType.Unclickable)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, function()
    if #self.selectedCards.value < self.minNum or #self.selectedCards.value < self.selectNum then
      Logger.Info("没有选择卡牌", #self.selectedCards.value, self.minNum)
      return
    end
    if self.extraProperties.callback then
      self.extraProperties.callback(self.selectedCards.value)
    end
    if self.extraProperties.desc == "Card_Select_Copy_Tips1_Ruins" then
      AudioManager.Instance:PostSoundEvent("Play_SFX_UI_Enchant_Advanced_Card")
    end
    self:Close()
  end, function()
    return self.btnState.value
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  self:EnableConfirmButton(false)
  binder:BindButtonClick(self.ui.Btn_Closure, function()
    self:Close()
  end)
end

function PVPTrainCardSelectPanel:SetCardItemSelectShow(uid, show)
  if self.cardItemList[uid] == nil then
    return
  end
  self.cardItemList[uid]:SetSelectShow(show)
end

function PVPTrainCardSelectPanel:EnableConfirmButton(enabled)
  if enabled then
    self.btnState.value = CommonDefine.BtnType.High
  else
    self.btnState.value = CommonDefine.BtnType.Unclickable
  end
end

function PVPTrainCardSelectPanel:OnCardSelect()
  if self.selectNum <= 0 then
    return
  end
  for tid, cardItem in pairs(self.cardItemList) do
    cardItem:SetSelectShow(SystemUtils.Contain(self.selectedCards.value, tid))
  end
  self:EnableConfirmButton(#self.selectedCards.value >= self.selectNum)
end

function PVPTrainCardSelectPanel:OnCardDeselect(uid)
  for index, value in ipairs(self.selectedCards.value) do
    if value == uid then
      table.remove(self.selectedCards.value, index)
      self:SetCardItemSelectShow(uid, false)
      break
    end
  end
  self:EnableConfirmButton(#self.selectedCards.value >= self.selectNum or #self.selectedCards.value >= self.totalCard)
end

return PVPTrainCardSelectPanel
