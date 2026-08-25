local GOLD_TID = DT.GetConstant("GoldItemTid")
local AwakerLevelLimitIncreaseComp, Super = System.NewComponent("AwakerLevelLimitIncreaseComp", AwakerBasePageComp)

function AwakerLevelLimitIncreaseComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_PotentialResource(uiNode)
  self.awakerModel = model
end

function AwakerLevelLimitIncreaseComp:OnBind(binder)
  binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, {GOLD_TID}))
  binder:BindToText(self.ui.Text_CurrentLv, function()
    local strFmt = "Lv.{s1}/{s2}"
    local awakerLevel = AwakerDataUtils.GetAwakerLevel(self.awakerModel.selectAwakerId)
    do return LT.Textf, strFmt, awakerLevel end
    return LT.Textf, strFmt, awakerLevel, awakerLevel
  end)
  binder:BindToText(self.ui.Text_NewLv, function()
    local strFmt = "{s1}/"
    local awakerLevel = AwakerDataUtils.GetAwakerLevel(self.awakerModel.selectAwakerId)
    do return LT.Textf, strFmt end
    return LT.Textf, strFmt, awakerLevel
  end)
  binder:BindToText(self.ui.Text_NextLvMax, function()
    do return AwakerDataUtils.GetAwakerNextMaxLevelWithLimitIncrease end
    return AwakerDataUtils.GetAwakerNextMaxLevelWithLimitIncrease, self.awakerModel.selectAwakerId
  end)
  binder:BindToText(self.ui.Text_Need, function()
    do return AwakerDataUtils.GetGoldCostNum end
    return AwakerDataUtils.GetGoldCostNum, self.awakerModel.selectAwakerId
  end)
  binder:BindToTextColorOld(self.ui.Text_Need, function()
    local haveNum = ItemDataUtils.GetItemNum(GOLD_TID)
    local costNum = AwakerDataUtils.GetGoldCostNum(self.awakerModel.selectAwakerId) or 0
    if haveNum >= costNum then
      return DT.ColorConfig.Selected.Dark
    else
      return DT.ColorConfig.Selected.Light
    end
  end)
  local commonIconItemModel = binder:createModel(CommonIconItemModel)
  binder:BindToRaw(function(cBinder)
    local showCostItems = AwakerDataUtils.GetCostItemsWithoutGold(self.awakerModel.selectAwakerId)
    if showCostItems then
      for _, showData in pairs(showCostItems) do
        local color = DT.ColorConfig.Selected.Dark
        local haveNum = ItemDataUtils.GetItemNum(showData.tid)
        if haveNum < showData.num then
          color = DT.ColorConfig.Selected.Light
        end
        local strFmt = "<color=" .. color .. ">{s1}</color>/{s2}"
        local showNum = LT.Textf(strFmt, haveNum, showData.num)
        local itemData = {
          tid = showData.tid,
          num = showNum,
          model = commonIconItemModel,
          callback = function()
            ItemDataUtils.ShowItemDetailTips(cBinder, self.ui.Group_Material, nil, showData.tid)
          end
        }
        cBinder:BindNewComponent(self.ui.Group_Material, CommonIconItem, UI_Common_Item_WuPin_Type1Resource, itemData)
      end
    end
  end, function()
    local showCostItems = AwakerDataUtils.GetCostItemsWithoutGold(self.awakerModel.selectAwakerId)
    local haveNumMap = {}
    if showCostItems then
      for key, showData in pairs(showCostItems) do
        local haveNum = ItemDataUtils.GetItemNum(showData.tid)
        haveNumMap[key] = haveNum
      end
    end
    return {
      self.awakerModel.selectAwakerId,
      haveNumMap
    }
  end)
  binder:BindZ1Button(self.ui.Btn_Potential, function()
    local awakerName = AwakerDataUtils.GetAwakerName(self.awakerModel.selectAwakerId)
    if not AwakerDataUtils.CheckCostItemEnough(self.awakerModel.selectAwakerId, false, true) then
      if not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(self.awakerModel.selectAwakerId)) then
        Alert.ShowStr(LT.Text("SpiritualDeepenInsufficientMaterials"))
      end
      return
    end
    Alert.ShowWithParams(20133, {awakerName}, nil, function()
      AwakerDataUtils.ReqOnIncreaseLimitLevel(self.awakerModel.selectAwakerId, function()
        UIManager.Instance:Reopen(Urls.AwakerLevelLimitIncreaseTip, self.awakerModel.selectAwakerId)
        self.awakerModel:SetAwakerPage(CommonDefine.AwakerPage.Detail)
      end)
    end)
  end, function()
    if not AwakerDataUtils.CheckCostItemEnough(self.awakerModel.selectAwakerId) then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    if AwakerDataUtils.CheckCostItemEnough(self.awakerModel.selectAwakerId, false, true) or not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(self.awakerModel.selectAwakerId), true) then
      do return LT.Text end
      return LT.Text, "SpiritualDeepen", true, true
    else
      do return LT.Text end
      return LT.Text, "AwakerUpgradeMaterialCompose", true, true
    end
  end, function()
    if AwakerDataUtils.CheckCostItemEnough(self.awakerModel.selectAwakerId) then
      return "red"
    end
    return false
  end)
end

function AwakerLevelLimitIncreaseComp:GetOpenAnim()
end

function AwakerLevelLimitIncreaseComp:GetCloseAnim()
end

function AwakerLevelLimitIncreaseComp:GetEnterDetailAnim()
  return "UI_Awaker_Item_Topped_Detail_Open"
end

function AwakerLevelLimitIncreaseComp:GetExitDetailAnim()
  return "UI_Awaker_Item_Topped_Detail_Close"
end

function AwakerLevelLimitIncreaseComp:OnOpen()
end

function AwakerLevelLimitIncreaseComp:OnClose()
end

function AwakerLevelLimitIncreaseComp:OnEnterDetail()
  self.ui.uiNode:SetActive(true)
end

function AwakerLevelLimitIncreaseComp:OnExitDetail()
  self.ui.uiNode:SetActive(false)
end

function AwakerLevelLimitIncreaseComp:OnOpenAnimFinish()
end

function AwakerLevelLimitIncreaseComp:OnCloseAnimFinish()
end

function AwakerLevelLimitIncreaseComp:OnEnterDetailAnimFinish()
end

function AwakerLevelLimitIncreaseComp:OnExitDetailAnimFinish()
end

return AwakerLevelLimitIncreaseComp
