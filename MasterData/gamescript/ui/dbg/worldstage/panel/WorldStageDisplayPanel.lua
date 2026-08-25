local WorldStageDisplayPanel, Super = System.NewClass("WorldStageDisplayPanel", UIBasePanel)
WorldStageDisplayPanel.uiResCls = UI_Dbgcopy_Popup_DisplayResource

function WorldStageDisplayPanel:ctor(itemType, itemTid)
  Super.ctor(self)
  self.itemType = itemType
  self.itemTid = itemTid
end

function WorldStageDisplayPanel:OnBind(binder)
  local displayModel = binder:createModel(WorldStageDisplayModel, self.itemType, self.itemTid)
  binder:BindToText(self.ui.Text_Special, function()
    do return displayModel.GetSpecialDesc end
    return displayModel.GetSpecialDesc, displayModel
  end)
  binder:BindToText(self.ui.Text_Introduce, function()
    do return displayModel.GetDescription end
    return displayModel.GetDescription, displayModel
  end)
  StrUtils.SetPreferredHeight(self.ui.Text_Special)
  StrUtils.SetPreferredHeight(self.ui.Text_Introduce)
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
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
end

return WorldStageDisplayPanel
