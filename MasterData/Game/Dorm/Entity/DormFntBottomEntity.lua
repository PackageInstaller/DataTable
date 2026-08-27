local DormFntBottomEntity = class("DormFntBottomEntity")
local DormEnum = require("Game.Dorm.DormEnum")

function DormFntBottomEntity:ctor()
  self.wallAngle = Vector3.New(90, 0, 0)
end

function DormFntBottomEntity:InitFntBottomGo(go)
  self.gameObject = go
  self.transform = go.transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.transform, self.bind)
end

function DormFntBottomEntity:InitFntBottom(scale, fntType, parent, pos)
  self.transform:SetParent(parent, false)
  self.transform.localPosition = pos or Vector3.zero
  self.transform.localScale = scale
  if DormEnum.IsFntWallType(fntType) then
    self.transform.localEulerAngles = self.wallAngle
  else
    self.transform.localEulerAngles = Vector3.zero
  end
end

function DormFntBottomEntity:ShowOverlap(overlap)
  self.bind.meshRender.sharedMaterial = overlap and self.bind.redMat or self.bind.greenMat
end

return DormFntBottomEntity
