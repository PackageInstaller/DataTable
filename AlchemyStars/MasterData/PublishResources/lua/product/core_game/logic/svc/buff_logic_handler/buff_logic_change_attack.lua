_class("BuffLogicChangeAttack", BuffLogicBase)
BuffLogicChangeAttack = BuffLogicChangeAttack

function BuffLogicChangeAttack:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._mulValueLimit = logicParam.mulValueLimit
  self._addValue = logicParam.addValue or 0
  self._addValueLimit = logicParam.addValueLimit
  self._buffInstance.BuffLogicChangeAttack_RunCount = 0
  self._light = logicParam.light == 1
end

function BuffLogicChangeAttack:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:Attributes() then
    return false
  end
  local context = self._buffInstance:Context()
  local casterEntity = context and context.casterEntity or nil
  local casterId = casterEntity and casterEntity:GetID() or 0
  self._buffInstance.BuffLogicChangeAttack_RunCount = self._buffInstance.BuffLogicChangeAttack_RunCount + 1
  if self._mulValue ~= 0 then
    local val = self._mulValue * self._buffInstance.BuffLogicChangeAttack_RunCount
    if self._mulValueLimit then
      local curMul = self._buffComponent:GetBuffValue("ChangeAttackPercentage") or 0
      if math.abs(curMul + val) > math.abs(self._mulValueLimit) then
        val = self._mulValueLimit - curMul
      end
      self._buffComponent:AddBuffValue("ChangeAttackPercentage", val)
    end
    self._buffLogicService:ChangeBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.AttackPercentage, val)
    self._buffInstance._ChangeAttackType = ModifyBaseAttackType.AttackPercentage
    local result = BuffResultChangeAttack:New(casterId, val, self._light)
    return result
  elseif self._addValue ~= 0 then
    local val = self._addValue * self._buffInstance.BuffLogicChangeAttack_RunCount
    if self._addValueLimit then
      local curAdd = self._buffComponent:GetBuffValue("ChangeAttackConstantFix") or 0
      if math.abs(curAdd + val) > math.abs(self._addValueLimit) then
        val = self._addValueLimit - curAdd
      end
      self._buffComponent:AddBuffValue("ChangeAttackConstantFix", val)
    end
    self._buffLogicService:ChangeBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, val)
    self._buffInstance._ChangeAttackType = ModifyBaseAttackType.AttackConstantFix
    local result = BuffResultChangeAttack:New(casterId, val, self._light)
    return result
  end
end

function BuffLogicChangeAttack:DoOverlap(logicParam)
  return self:DoLogic()
end

_class("BuffLogicChangeAttackUndo", BuffLogicBase)
BuffLogicChangeAttackUndo = BuffLogicChangeAttackUndo

function BuffLogicChangeAttackUndo:Constructor(buffInstance, logicParam)
  self._black = logicParam.black == 1
  self._casterBlack = logicParam.casterBlack == 1
end

function BuffLogicChangeAttackUndo:DoLogic()
  self._buffInstance.BuffLogicChangeAttack_RunCount = 0
  local e = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(e, self:GetBuffSeq(), self._buffInstance._ChangeAttackType)
  if self._buffInstance._ChangeAttackType == ModifyBaseAttackType.AttackPercentage then
    self._buffComponent:SetBuffValue("ChangeAttackPercentage", 0)
  elseif self._buffInstance._ChangeAttackType == ModifyBaseAttackType.AttackConstantFix then
    self._buffComponent:SetBuffValue("ChangeAttackConstantFix", 0)
  end
  local context = self._buffInstance:Context()
  local casterEntity = context and context.casterEntity or nil
  local casterID = casterEntity and casterEntity:GetID() or 0
  local result = BuffResultChangeAttackUndo:New(casterID, self._casterBlack, self._black)
  return result
end

function BuffLogicChangeAttackUndo:DoOverlap(logicParam)
  return self:DoLogic()
end
