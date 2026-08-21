_class("UIN28AVGGraphNodeEnd", UIN28AVGGraphNodeBase)
UIN28AVGGraphNodeEnd = UIN28AVGGraphNodeEnd

function UIN28AVGGraphNodeEnd:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN28AVGGraphNodeEnd:InitComponent()
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtName1 = self:GetUIComponent("UILocalizationText", "txtName1")
end

function UIN28AVGGraphNodeEnd:FlushName()
  self.txtName:SetText(self.node.title)
  self.txtName1:SetText(self.node.title)
end

function UIN28AVGGraphNodeEnd:FlushState()
  local state = self.node:State()
  if state == N28AVGStoryNodeState.CanPlay then
    self.imgIcon:LoadImage(self.node.cgCanplayCGNode)
  elseif state == N28AVGStoryNodeState.Complete then
    self.imgIcon:LoadImage(self.node.cgNode)
  else
    Log.warn("### invalid N28AVGStoryNodeState:", state)
  end
end
