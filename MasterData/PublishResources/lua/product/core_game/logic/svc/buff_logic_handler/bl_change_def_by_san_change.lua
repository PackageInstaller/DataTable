_class("BuffLogicChangeDefenceBySanChange", BuffLogicBase)
BuffLogicChangeDefenceBySanChange = BuffLogicChangeDefenceBySanChange

function BuffLogicChangeDefenceBySanChange:Constructor(buffInstance, logicParam)
  self._maxDefMul = tonumber(logicParam.maxDefMul)
end

function BuffLogicChangeDefenceBySanChange:DoLogic(notify)
  if not NTSanValueChange:IsInstanceOfType(notify) then
    return
  end
  local def = self._entity:Attributes():GetAttribute("Defense")
  if not def then
    return
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  local sanVal = lsvcFeature:GetSanValue()
  local maxSanVal = lsvcFeature:GetSanMaxValue()
  if maxSanVal <= 0 then
    return
  end
  local sanRate = sanVal / maxSanVal
  local val = def * self._maxDefMul * (1 - sanRate)
  self._buffLogicService:ChangeBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix, val)
  if self._entity:HasPetPstID() then
    local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
  local result = BuffResultChangeDefence:New(ModifyBaseDefenceType.DefenceConstantFix, val, self._entity:GetID(), self._light)
  return result
end

_class("BuffLogicChangeDefenceBySanChangeUndo", BuffLogicBase)
BuffLogicChangeDefenceBySanChangeUndo = BuffLogicChangeDefenceBySanChangeUndo

function BuffLogicChangeDefenceBySanChangeUndo:Constructor(buffInstance, logicParam)
end

function BuffLogicChangeDefenceBySanChangeUndo:DoLogic()
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseDefence(e, self:GetBuffSeq(), self._buffInstance._ChangeDefenceType)
  if e:HasPetPstID() then
    local teamEntity = e:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
  self._buffComponent:SetBuffValue("ChangeDefenceConstantFix", 0)
  return BuffResultChangeDefenceUndo:New(self._black)
end
