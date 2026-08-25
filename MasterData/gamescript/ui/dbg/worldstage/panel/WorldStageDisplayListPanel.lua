local WorldStageDisplayListPanel, Super = System.NewClass("WorldStageDisplayListPanel", UIBasePanel)
WorldStageDisplayListPanel.uiResCls = UI_Dbgcopy_Popup_Display_ListResource

function WorldStageDisplayListPanel:ctor(displayList)
  Super.ctor(self)
  self.displayList = displayList
end

function WorldStageDisplayListPanel:OnBind(binder)
  local maxDisplayCount = CommonDefine.MaxNodeOptionNum
  for index = 1, maxDisplayCount do
    local displayItemNode = self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. index]
    local displayItemUI = displayItemNode and UI_Dbgcopy_Item_Select_Creation_QuoteResource(displayItemNode)
    local data = self.displayList[index]
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
    end
  end
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

return WorldStageDisplayListPanel
