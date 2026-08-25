local ComCostComponent, Super = System.NewComponent("ComCostComponent")

function ComCostComponent:ctor(uiNode, imgPath, count)
  Super.ctor(self)
  self.ui = Com_CostResource(uiNode)
  self.imgPath = imgPath
  self.count = count
end

function ComCostComponent:OnBind(binder)
  self.binder = binder
  binder:SetImage(self.ui.Image_Icon, self.imgPath)
  binder:SetText(self.ui.Text_Num, self.count)
end

function ComCostComponent:UpdateImage(imgPath)
  self.imgPath = imgPath
  self.binder:SetImage(self.ui.Image_Icon, self.imgPath)
end

function ComCostComponent:UpdateCount(count)
  self.count = count
  self.binder:SetText(self.ui.Text_Num, self.count)
end

return ComCostComponent
