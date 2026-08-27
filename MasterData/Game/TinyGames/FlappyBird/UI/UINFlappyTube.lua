local UINFlappyTube = class("UINFlappyTube", UIBaseNode)
local base = UIBaseNode

function UINFlappyTube:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFlappyTube:SetImgWithTubeType(tubeType)
  self.ui.img:SetIndex(tubeType)
end

function UINFlappyTube:SetTubeUISize(colliderBox)
  self.ui.tubeRect.sizeDelta = Vector2.New(colliderBox.right / 500, colliderBox.top / 500)
end

function UINFlappyTube:OnDelete()
  base.OnDelete(self)
end

return UINFlappyTube
