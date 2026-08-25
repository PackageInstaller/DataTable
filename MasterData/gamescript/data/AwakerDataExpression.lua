local AwakerDataExpression, Super = System.NewClass("AwakerDataExpression", BaseExpression)

function AwakerDataExpression:ctor()
  Super.ctor(self)
  self.cmdFuncs = {}
  self.awakerData = {}
  self.memberValues = {}
  self.memberFuncs = {}
  self.extraParam = {}
  Super.InitGetter(self)
end

function AwakerDataExpression:SetAwakerData(awakerData)
  self.awakerData = awakerData
  self.memberValues = {}
  self.memberFuncs = {}
  self.extraParam = {}
end

function AwakerDataExpression:SetSkillModel(skillModel)
  self.skillModel = skillModel
end

function AwakerDataExpression:GetAttr(attrName)
  if not self.awakerData then
    return 0
  end
  if not self.awakerData.attrs then
    return 0
  end
  local attrValue = self.awakerData.attrs[attrName]
  return attrValue or 0
end

function AwakerDataExpression:GetStateLayer(stateId)
  do return StateDataUtils.GetLayer end
  return StateDataUtils.GetLayer, stateId
end

return AwakerDataExpression
