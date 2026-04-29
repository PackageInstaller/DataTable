_class("UIN20AVGGraphNodeNormal", UIN20AVGGraphNodeBase)
UIN20AVGGraphNodeNormal = UIN20AVGGraphNodeNormal

function UIN20AVGGraphNodeNormal:FlushName()
  local state = self.node:State()
  if state == AVGStoryNodeState.CantPlay then
    self.txtName:SetText("???")
  else
    self.txtName:SetText(self.node.title)
  end
end

function UIN20AVGGraphNodeNormal:FlushState()
  local state = self.node:State()
  if state == AVGStoryNodeState.CantPlay then
    self.imgBG.sprite = self.atlas:GetSprite("N20_avg_lcxz_di02")
  else
    self.imgBG.sprite = self.atlas:GetSprite("N20_avg_lcxz_di01")
  end
end
