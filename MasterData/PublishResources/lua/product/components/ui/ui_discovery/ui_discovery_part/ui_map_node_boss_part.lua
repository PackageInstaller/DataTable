_class("UIMapNodeBossPart", UIMapNodeBasePart)
UIMapNodeBossPart = UIMapNodeBossPart

function UIMapNodeBossPart:OnShow()
  UIMapNodeBossPart.super.OnShow(self)
  self.imgCG = self:GetUIComponent("RawImageLoader", "imgCG")
end

function UIMapNodeBossPart:OnHide()
  UIMapNodeBossPart.super.OnHide(self)
  self.imgCG:DestoryLastImage()
end

function UIMapNodeBossPart:Flush()
  UIMapNodeBossPart.super.Flush(self)
  self.imgCG:LoadImage(self.nodeInfo.monstercg)
end
