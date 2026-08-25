local CGBaseView, Super = NewClass("CGBaseView", BaseView)
CGBaseView.uiResCls = UI_Collection_Item_CGResource

function CGBaseView:ctor(subFeature)
  Super.ctor(self)
  self.subFeature = subFeature
end

function CGBaseView:OnBuildView()
  Super.OnBuildView(self)
  self:AddViewComponentOnce(self.ui.uiNode, CGViewCom, self.ui, self.subFeature)
end

function CGBaseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_Big, System.fn(self, self.HideBigImage))
end

function CGBaseView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnClickCGImage, self.ShowBigImage, self)
end

function CGBaseView:ShowBigImage(cfgId)
  local collectCfg = DT.CollectionHall[cfgId]
  local featureId = collectCfg.CollectionType
  local featureCfg = DT.FeatureUnlock[featureId]
  if featureCfg.Key ~= self.subFeature then
    return
  end
  UIManager.Instance:Reopen(Urls.CGDisplayView, cfgId)
end

function CGBaseView:HideBigImage()
  self.ui.Image_Big:SetActive(false)
end

return CGBaseView
