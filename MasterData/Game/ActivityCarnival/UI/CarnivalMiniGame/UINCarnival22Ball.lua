local UINCarnival22Ball = class("UINCarnival22Ball", UIBaseNode)
local base = UIBaseNode

function UINCarnival22Ball:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  local collider2DTrigger = CS.ColliderEventListener.Get(self.transform)
  collider2DTrigger:CollisionEnter2DEvent("+", BindCallback(self, self.__CollisionEnter))
end

function UINCarnival22Ball:InitWaltermelonItem(id, collisionCallback)
  self._id = id
  self._callback = collisionCallback
end

function UINCarnival22Ball:GetWaltermelonType()
  return self._id
end

function UINCarnival22Ball:SetRigidBody(flag)
  self.ui.rigidbody.simulated = flag
end

function UINCarnival22Ball:GetRigidSpeed()
  return self.ui.rigidbody.velocity
end

function UINCarnival22Ball:GetColliderRadius()
  return self.transform.rect.width / 2
end

function UINCarnival22Ball:__CollisionEnter(other)
  if self._callback ~= nil then
    self._callback(self, other)
  end
end

return UINCarnival22Ball
