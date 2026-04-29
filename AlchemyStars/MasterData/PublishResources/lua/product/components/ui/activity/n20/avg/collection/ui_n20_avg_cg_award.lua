_class("UIN20AVGCGAward", UICustomWidget)
UIN20AVGCGAward = UIN20AVGCGAward

function UIN20AVGCGAward:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.got = self:GetGameObject("got")
end

function UIN20AVGCGAward:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN20AVGCGAward:Flush(ra, callback)
  self.callback = callback
  local cfgv = Cfg.cfg_item[ra.assetid]
  self.imgIcon:LoadImage(cfgv.Icon)
  self.txtCount:SetText(ra.count)
end

function UIN20AVGCGAward:FlushGot(isShow)
  self.got:SetActive(isShow)
end

function UIN20AVGCGAward:btnOnClick(go)
  if self.callback then
    self:callback()
  end
end
