local _GetUICenterPosition = CS.Framework.TransformUtil.GetUICenterPosition
local UIEffect, Super = NewClass("UIEffect", ResGameObject)

function UIEffect:ctor()
  Super.ctor(self)
  self.uiNode = nil
  self.offsetX = 0
  self.offsetY = 0
  self.autoDestroy = true
end

function UIEffect:OnPlayedFinish()
  Super.OnPlayedFinish(self)
  if self.autoDestroy then
    UIEffectMgr.Instance:StopEffect(self)
  end
end

function UIEffect:OnEnable()
  Super.OnEnable(self)
  self:UpdatePosition()
end

function UIEffect:UpdatePosition()
  if IsNil(self.gameObject) or IsNil(self.uiNode) then
    return
  end
  local x, y, z = _GetUICenterPosition(self.uiNode.transform, 0, 0, nil, nil, nil)
  CS.Framework.TransformUtil.SetPos(self.gameObject.transform, x, y, z)
end

return UIEffect
