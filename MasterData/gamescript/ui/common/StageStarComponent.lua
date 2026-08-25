local StageStarComponent, Super = System.NewComponent("StageStarComponent")

function StageStarComponent:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Common_Group_StarResource(uiNode)
  self.data = data
end

function StageStarComponent:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.Star_1, function()
    return self.data.star >= 1
  end)
  binder:BindToVisible(self.ui.Star_2, function()
    return self.data.star >= 2
  end)
  binder:BindToVisible(self.ui.Star_3, function()
    return self.data.star >= 3
  end)
  binder:BindButtonClick(self.ui.Btn_Star, function()
    if self.data.stageTid then
      UIManager.Instance:Reopen(Urls.StageStarDetailPanel, self.data)
    else
      Logger.Warn("没有传入stageTid")
    end
  end)
end

return StageStarComponent
