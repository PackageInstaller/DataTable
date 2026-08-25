local TutorialMainPanelScrollItem, Super = System.NewComponent("TutorialMainPanelScrollItem")

function TutorialMainPanelScrollItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Course_Panel_Main_ItemResource(uiNode)
  self.clickFunc = data.clickFunc
  self.selectBgFunc = data.selectBgFunc
  self.redFunc = data.redFunc
  self.showTextFunc = data.showTextFunc
end

function TutorialMainPanelScrollItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Name, function()
    if self.showTextFunc then
      do return end
      return self.showTextFunc, nil
    end
    return ""
  end)
  binder:BindToVisible(self.ui.Group_Sel, function()
    if self.selectBgFunc then
      do return end
      return self.selectBgFunc, nil
    end
    return false
  end)
  binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, CommonDefine.RedDotType.Dot, nil, function()
    if self.redFunc then
      do return end
      return self.redFunc, nil
    end
    return false
  end))
  binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.clickFunc then
      self.clickFunc()
    end
  end)
end

return TutorialMainPanelScrollItem
