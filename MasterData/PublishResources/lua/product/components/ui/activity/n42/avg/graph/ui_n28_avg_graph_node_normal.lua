_class("UIN28AVGGraphNodeNormal", UIN28AVGGraphNodeBase)
UIN28AVGGraphNodeNormal = UIN28AVGGraphNodeNormal

function UIN28AVGGraphNodeNormal:FlushName()
  local state = self.node:State()
  if state == N28AVGStoryNodeState.CantPlay then
    self.txtName:SetText("???")
    self.txtName1:SetText("???")
    self.txtName1Outline.effectColor = Color(0.4117647058823529, 0.4117647058823529, 0.5019607843137255, 1)
  else
    self.txtName:SetText(self.node.title)
    self.txtName1:SetText(self.node.title)
    self.txtName1Outline.effectColor = Color(0.24313725490196078, 0.611764705882353, 0.7803921568627451, 1)
  end
end

function UIN28AVGGraphNodeNormal:FlushState()
  self.imgBG1 = self:GetUIComponent("Image", "imgBG1")
  local state = self.node:State()
  if state == N28AVGStoryNodeState.CantPlay then
    self.imgBG.sprite = self.atlas:GetSprite("N28_avg_jd_di03")
    self.imgBG1.sprite = self.atlas:GetSprite("N28_avg_jd_icon06")
  else
    self.imgBG.sprite = self.atlas:GetSprite("N28_avg_jd_di02")
    self.imgBG1.sprite = self.atlas:GetSprite("N28_avg_jd_icon05")
  end
end
