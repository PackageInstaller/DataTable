local UISimpleGameObjectTag, Super = NewClass("UISimpleGameObject")

function UISimpleGameObjectTag:ctor()
  self.realGo = nil
end

function UISimpleGameObjectTag:SetRealGo(realGo)
  self.realGo = realGo
end

function UISimpleGameObjectTag:GetRealGo()
  return self.realGo
end

return UISimpleGameObjectTag
