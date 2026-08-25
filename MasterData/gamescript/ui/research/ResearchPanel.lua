local ResearchPanel, Super = System.NewClass("ResearchPanel", UIBasePanel)
ResearchPanel.uiResCls = UI_Research_Panel_MainResource

function ResearchPanel:ctor()
  Super.ctor(self)
end

function ResearchPanel:OnBind(binder)
  self.model = binder:createModel(ResearchModel)
  self.closeBtn = binder:BindComponent(BtnCloseItem(self.ui.UI_Common_Btn_Back3, function()
    self:ClosePanel()
  end))
  binder:BindToCircularListView(self.ui.ScrollView_Bag_Material, function()
    do return self.model.GetFunctionList end
    return self.model.GetFunctionList, self.model
  end, function(itemBinder, gameObj, index)
    local unlockCfg = self.model:GetFunctionCfgByIndex(index)
    local tFuncData = self.model:GetFunctionDataByFeature(unlockCfg.Feature, unlockCfg.Key)
    itemBinder:BindComponent(ResearchMainItem(gameObj, unlockCfg, tFuncData))
  end)
  binder:PlayCircularScrollViewFadeInAnim(self.ui.ScrollView_Bag_Material)
end

function ResearchPanel:ClosePanel()
  self.closeBtn:PlayCloseAnim()
  self:Close()
end

return ResearchPanel
