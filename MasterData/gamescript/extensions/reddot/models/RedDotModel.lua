local RedDotModel = System.NewClass("RedDotModel", BaseModel)

function RedDotModel:OnInit()
end

function RedDotModel:OnReset()
  self:OnInit()
end

return RedDotModel
