local MainSceneBtnItem, Super = System.NewComponent("MainSceneBtnItem")

function MainSceneBtnItem:ctor(res, text, icon, callback, modeleName)
  Super.ctor(self)
  self.ui = Item_MainScene_BtnResource(res)
  self.text = text
  self.icon = icon
  self.callback = callback
  self.modeleName = modeleName
end

function MainSceneBtnItem:OnBind(binder)
  self.binder = binder
  self.binder:BindToImage(self.ui.Image_Icon, function()
    if self.icon == nil then
      return nil
    else
      return self.icon
    end
  end)
  self.binder:BindToText(self.ui.Text_Module, function()
    if self.text == nil then
      return "暂无"
    else
      return self.text
    end
  end)
  self.binder:BindButtonClick(self.ui.uiNode, function()
    if self.callback then
      self.callback(self.text)
    end
  end)
  if self.modeleName and self.modeleName == "Awakers" then
    self.ui.Com_RedDot:SetActive(true)
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, function()
      do return end
      return RedPointDataUtils.ShowMainAwaker, nil
    end))
  end
  if self.modeleName and self.modeleName == "Infrastruture" then
    self.ui.Com_RedDot:SetActive(true)
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, RedPointDataUtils.IsShowAvg))
  end
  if self.modeleName and self.modeleName == "Recruit" then
    self.ui.Com_RedDot:SetActive(true)
    binder:BindComponent(RedDotComponent(self.ui.Com_RedDot, nil, nil, RedPointDataUtils.IsShowSummon))
  end
end

return MainSceneBtnItem
