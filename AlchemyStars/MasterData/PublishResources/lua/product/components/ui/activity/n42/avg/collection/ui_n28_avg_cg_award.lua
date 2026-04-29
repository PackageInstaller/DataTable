_class("UIN28AVGCGAward", UICustomWidget)
UIN28AVGCGAward = UIN28AVGCGAward

function UIN28AVGCGAward:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.got = self:GetGameObject("got")
end

function UIN28AVGCGAward:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGCGAward:Flush(ra, callback)
  self.callback = callback
  local cfgv = Cfg.cfg_item[ra.assetid]
  self.imgIcon:LoadImage(cfgv.Icon)
  self.txtCount:SetText(ra.count)
end

function UIN28AVGCGAward:FlushGot(isShow)
  self.got:SetActive(isShow)
end

function UIN28AVGCGAward:BtnOnClick(go)
  if self.callback then
    self:callback()
  end
end
