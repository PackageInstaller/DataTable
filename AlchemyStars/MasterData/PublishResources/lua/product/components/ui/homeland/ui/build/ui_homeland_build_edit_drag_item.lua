_class("UIHomelandBuildEditDragItem", UICustomWidget)
UIHomelandBuildEditDragItem = UIHomelandBuildEditDragItem

function UIHomelandBuildEditDragItem:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
end

function UIHomelandBuildEditDragItem:OnShow()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
end

function UIHomelandBuildEditDragItem:OnHide()
end

function UIHomelandBuildEditDragItem:Flush(id)
  self.id = id
end
