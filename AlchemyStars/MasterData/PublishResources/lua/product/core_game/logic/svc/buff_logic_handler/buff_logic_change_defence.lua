_class("BuffLogicChangeDefence", BuffLogicBase)
BuffLogicChangeDefence = BuffLogicChangeDefence

function BuffLogicChangeDefence:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._mulValueLimit = logicParam.mulValueLimit
  self._addValue = logicParam.addValue or 0
  self._addValueLimit = logicParam.addValueLimit
  self._buffInstance.BuffLogicChangeDefence_RunCount = 0
  self._light = logicParam.light == 1
end

function BuffLogicChangeDefence:DoLogic()
  self._buffInstance.BuffLogicChangeDefence_RunCount = self._buffInstance.BuffLogicChangeDefence_RunCount + 1
  local val = 0
  local e = self._buffInstance:Entity()
  local baseDefence = e:Attributes():GetAttribute("Defense")
  if not baseDefence then
    return
  end
  if self._mulValue ~= 0 then
    val = self._mulValue * self._buffInstance.BuffLogicChangeDefence_RunCount
    if self._mulValueLimit then
      local curMul = self._buffComponent:GetBuffValue("ChangeDefencePercentage") or 0
      if math.abs(curMul + val) > math.abs(self._mulValueLimit) then
        val = self._mulValueLimit - curMul
      end
      self._buffComponent:AddBuffValue("ChangeDefencePercentage", val)
    end
    self._buffLogicService:ChangeBaseDefence(e, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage, val)
    self._buffInstance._ChangeDefenceType = ModifyBaseDefenceType.DefencePercentage
  elseif self._addValue ~= 0 then
    val = self._addValue * self._buffInstance.BuffLogicChangeDefence_RunCount
    if self._addValueLimit then
      local curAdd = self._buffComponent:GetBuffValue("ChangeDefenceConstantFix") or 0
      if math.abs(curAdd + val) > math.abs(self._addValueLimit) then
        val = self._addValueLimit - curAdd
      end
      self._buffComponent:AddBuffValue("ChangeDefenceConstantFix", val)
    end
    self._buffLogicService:ChangeBaseDefence(e, self:GetBuffSeq(), ModifyBaseDefenceType.DefenceConstantFix, val)
    self._buffInstance._ChangeDefenceType = ModifyBaseDefenceType.DefenceConstantFix
  end
  if e:HasPetPstID() then
    local teamEntity = e:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
  local result = BuffResultChangeDefence:New(self._buffInstance._ChangeDefenceType, val, e:GetID(), self._light)
  return result
end

function BuffLogicChangeDefence:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicChangeDefenceUndo", BuffLogicBase)
BuffLogicChangeDefenceUndo = BuffLogicChangeDefenceUndo

function BuffLogicChangeDefenceUndo:Constructor(buffInstance, logicParam)
  self._black = logicParam.black == 1
end

function BuffLogicChangeDefenceUndo:DoLogic()
  self._buffInstance.BuffLogicChangeDefence_RunCount = 0
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseDefence(e, self:GetBuffSeq(), self._buffInstance._ChangeDefenceType)
  if e:HasPetPstID() then
    local teamEntity = e:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
  if self._buffInstance._ChangeDefenceType == ModifyBaseDefenceType.DefencePercentage then
    self._buffComponent:SetBuffValue("ChangeDefencePercentage", 0)
  elseif self._buffInstance._ChangeDefenceType == ModifyBaseDefenceType.DefenceConstantFix then
    self._buffComponent:SetBuffValue("ChangeDefenceConstantFix", 0)
  end
  return BuffResultChangeDefenceUndo:New(self._black)
end
