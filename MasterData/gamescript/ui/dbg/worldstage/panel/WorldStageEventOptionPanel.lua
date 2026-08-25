local UI_Dbgcopy_Item_Select_Creation_QuoteResource = _ENV.UI_Dbgcopy_Item_Select_Creation_QuoteResource
local WorldStageEventOptionPanel, Super = System.NewClass("WorldStageEventOptionPanel", UIBasePanel)
WorldStageEventOptionPanel.uiResCls = UI_Dbgcopy_Panel_ShowResource

function WorldStageEventOptionPanel:ctor(optionDisplayList)
  Super.ctor(self)
  self.optionDisplayList = optionDisplayList
  self.optionBindMap = {
    [CommonDefine.WorldEventOptionType.DisplayListPanel] = System.fn(self, self.BindDisplayListPanel),
    [CommonDefine.WorldEventOptionType.DisplayPanel] = System.fn(self, self.BindDisplayPanel),
    [CommonDefine.WorldEventOptionType.DisplayCardList] = System.fn(self, self.BindDisplayCardList)
  }
end

function WorldStageEventOptionPanel:OnBind(binder)
  self.model = binder:createModel(WorldStageEventOptionPanelModel, self.optionDisplayList)
  self.ui.ScrollView:SetActive(false)
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSEvent))
  self:BindUI(binder)
end

function WorldStageEventOptionPanel:BindUI(binder)
  local model = self.model
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:Close()
  end)
  binder:BindButtonClick(self.ui.Btn_Click_Down, function()
    model.SetCurShowIdx(model.curShowIdx + 1)
  end)
  binder:BindButtonClick(self.ui.Btn_Click_UP, function()
    model.SetCurShowIdx(model.curShowIdx - 1)
  end)
  binder:BindToVisible(self.ui.Group_UP, function()
    return #self.optionDisplayList > 1
  end)
  binder:BindToVisible(self.ui.Group_Down, function()
    return #self.optionDisplayList > 1
  end)
  binder:BindToRaw(function(itemBinder, nVal, _)
    self.optionBindMap[nVal](itemBinder)
  end, function()
    return model.curShowType
  end)
  binder:BindToVisible(self.ui.UI_Dbgcopy_Popup_Display_List, function()
    return model.curShowType == CommonDefine.WorldEventOptionType.DisplayListPanel
  end)
  if model.curShowType == CommonDefine.WorldEventOptionType.DisplayListPanel then
    local res = UIBaseResource(self.ui.UI_Dbgcopy_Popup_Display_List)
    res.UI_Common_Item_Btn_2:SetActive(false)
  end
  binder:BindToVisible(self.ui.UI_Dbgcopy_Popup_Display, function()
    return model.curShowType == CommonDefine.WorldEventOptionType.DisplayPanel
  end)
  binder:BindToVisible(self.ui.UI_Dbgcopy_Popup_Display_Card, function()
    return model.curShowType == CommonDefine.WorldEventOptionType.DisplayCardList
  end)
end

function WorldStageEventOptionPanel:BindDisplayListPanel(binder)
  local maxDisplayCount = CommonDefine.MaxNodeOptionNum
  for index = 1, maxDisplayCount do
    local displayItemNode = self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. index]
    local displayItemUI = displayItemNode and UI_Dbgcopy_Item_Select_Creation_QuoteResource(displayItemNode)
    local data = self.model.GetArgList()[index]
    if displayItemUI then
      displayItemUI.uiNode:SetActive(nil ~= data)
    end
    if data and displayItemUI then
      local displayModel = binder:createModel(WorldStageDisplayModel, data.cfgName, data.cfgId)
      binder:BindToText(displayItemUI.Text_Creation_Name, function()
        do return displayModel.GetName end
        return displayModel.GetName, displayModel
      end)
      binder:BindToText(displayItemUI.Text_Creation_Creation, function()
        do return displayModel.GetSubName end
        return displayModel.GetSubName, displayModel
      end)
      binder:BindToText(displayItemUI.Text_Creation_Desc, function()
        do return displayModel.GetDescription end
        return displayModel.GetDescription, displayModel
      end)
      binder:BindToImage(displayItemUI.Image_Icon, function()
        do return displayModel.GetDisplayIcon end
        return displayModel.GetDisplayIcon, displayModel
      end)
      binder:BindButtonClick(displayItemUI.Btn_Click, function()
        local desc = displayModel:GetDescription()
        if StrUtils.CheckDescContainKeywords(desc) then
          UIManager.Instance:Reopen(Urls.CommonCardKeyWorldDescPanel, {desc}, displayItemUI.uiNode)
        end
      end)
    end
  end
end

function WorldStageEventOptionPanel:BindDisplayPanel(binder)
  local displayModel = binder:createModel(WorldStageDisplayModel, self.model.GetCfgName(), self.model.GetArgList()[1].cfgId)
  binder:BindToText(self.ui.Text_Special, function()
    do return displayModel.GetSpecialDesc end
    return displayModel.GetSpecialDesc, displayModel
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    do return displayModel.GetDescription end
    return displayModel.GetDescription, displayModel
  end, nil, nil, {
    lockParentNode = self.ui.KeyWordTips_Node
  })
  binder:BindToText(self.ui.Text_Enchantment, function()
    do return displayModel.GetSubName end
    return displayModel.GetSubName, displayModel
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return displayModel.GetName end
    return displayModel.GetName, displayModel
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    do return displayModel.GetDisplayIcon end
    return displayModel.GetDisplayIcon, displayModel
  end)
  binder:BindTimer(0.02, 0, nil, function()
    StrUtils.SetPreferredHeight(self.ui.Text_Special)
    StrUtils.SetPreferredHeight(self.ui.Text_Introduce)
  end)
end

function WorldStageEventOptionPanel:BindDisplayCardList(binder)
  local maxCardCount = 4
  for index = 1, maxCardCount do
    local cardUINode = self.ui["Card_" .. index]
    local cardUI = cardUINode and UI_Dbgcopy_Item_Select_CardResource(cardUINode)
    local data = self.model.GetArgList()[index]
    if cardUI then
      cardUI.uiNode:SetActive(nil ~= data)
    end
    if data and cardUI then
      binder:BindComponent(WorldStageCardSelectItem(cardUINode, {
        runeTid = nil,
        cardUid = nil,
        cardTid = data.cfgId
      }))
    end
  end
end

function WorldStageEventOptionPanel:OnCSEvent(eventName, _)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
  self.ui.ScrollView:SetActive(true)
end

return WorldStageEventOptionPanel
