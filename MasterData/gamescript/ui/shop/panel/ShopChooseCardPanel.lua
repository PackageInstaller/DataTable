local ShopChooseCardPanel, Super = System.NewClass("ShopChooseCardPanel", UIBasePanel)
ShopChooseCardPanel.uiResCls = Panel_Operating_ShopRemoveResource

function ShopChooseCardPanel:ctor(data)
  Super.ctor(self)
  self.cardUid = Vue.ref(data.cardUid or 0)
  self.configId = data.configId
  self.confirmCb = data.confirmCb
  self.cancelCb = data.cancelCb
  self.confirmWord = data.confirmWord
  self.cancelWord = data.cancelWord
  self.costItemId = data.costItemId
  self.cost = data.cost
  self.runeTid = data.runeTid
  self.tips = Vue.ref({})
end

function ShopChooseCardPanel:OnBind(binder)
  if self.costItemId then
    local costItemCfg = DT.EnchantConfig[self.costItemId]
    local isAddRune = costItemCfg.Type == CommonDefine.ItemType.Rune
    binder:SetActive(self.ui.Image_Icon, not isAddRune)
    binder:SetActive(self.ui.Item_Addrune_Tips, isAddRune)
    if costItemCfg.Type == CommonDefine.ItemType.Rune then
      local data = {
        name = LT.Text(costItemCfg.Name),
        desc = LT.Text(costItemCfg.Desc)
      }
      binder:BindComponent(CardRuneDescComponent(self.ui.Item_Addrune_Tips, data))
    else
      binder:SetImage(self.ui.Image_Icon, DT.EnchantConfig[self.costItemId].SmallIcon)
    end
  else
    self.ui.Image_Icon:SetActive(false)
  end
  if self.cost then
    self.ui.Text_Number:SetActive(true)
    binder:BindToText(self.ui.Text_Number, function()
      local hasGold = CopiesDataUtils.GetCopiesMoney()
      local cost = math.abs(self.cost)
      local isEnough = hasGold >= cost
      do return StrUtils.GetCostStr, cost end
      return StrUtils.GetCostStr, cost, isEnough
    end)
  else
    self.ui.Text_Number:SetActive(false)
  end
  binder:BindToVisible(self.ui.Item_Card_Base, function()
    return self.cardUid.value > 0
  end)
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.Close), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, self.confirmWord
  end)
  binder:BindZ1Button(self.ui.Btn_Remove, System.fn(self, self.OnConfirm), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, self.confirmWord
  end)
  binder:BindToRaw(function(_, newUid, _)
    if self.chooseCard ~= nil then
      self.chooseCard.binder:Unbind()
      self.chooseCard = nil
    end
    if newUid and newUid > 0 and CardDataUtils.GetCardInfo(newUid) then
      self.configId = CardDataUtils.GetCardInfo(newUid).configId
    end
    if self.chooseCard == nil then
      self.chooseCard = binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, newUid, self.configId))
    end
  end, function()
    return self.cardUid.value
  end)
  if self.configId then
    local tipsList = CardDataUtils.GetCardKeywordTips(self.configId, self.cardUid.value)
    if self.runeTid then
      local parserEnv = {
        card = CardDataUtils.GetCardInfo(self.cardUid.value),
        awaker = CardDataUtils.GetCardOwner(self.cardUid.value),
        skillId = self.configId
      }
      local cmdParser = BattleCmdParserClient(parserEnv)
      for _, stateId in pairs(DT.EnchantConfig[self.runeTid].State) do
        local stateCfg = DT.State[stateId]
        if stateCfg.ShowJudgement and not cmdParser:GetValueByCmd(stateCfg.ShowJudgement) then
        elseif stateCfg.ShowType ~= CommonDefine.StateShowType.Hide then
          table.insert(tipsList, {
            name = stateCfg.Name,
            desc = stateCfg.Desc,
            isYellow = false
          })
        end
      end
    end
    self.tips.value = tipsList
    binder:BindToCircularListView(self.ui.ScrollView_Tips_List, function()
      return self.tips.value
    end, function(itemBinder, obj, index)
      itemBinder:BindComponent(CardKeyWordTipItem(obj, self.tips.value[index]))
    end)
  end
end

function ShopChooseCardPanel:Close()
  if self.cancelCb then
    self.cancelCb()
  end
  Super.Close(self)
end

function ShopChooseCardPanel:OnConfirm()
  if self.confirmCb then
    self.confirmCb()
  end
  Super.Close(self)
end

return ShopChooseCardPanel
