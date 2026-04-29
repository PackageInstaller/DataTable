_class("LLBuffLogicRecoverHP", LLBuffLogicBase)
LLBuffLogicRecoverHP = LLBuffLogicRecoverHP

function LLBuffLogicRecoverHP:Constructor(buffObj, logicParam)
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicRecoverHP:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicRecoverHP:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    local module = GameGlobal:GetLuckLandModule()
    local curHp, maxHp = module:GetCurHP()
    local recoverHp = maxHp * self._perVal + self._fixVal
    module:AddHP(recoverHp)
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
    if target:IsDead() then
      return
    end
    target:AddHP(self._fixVal)
  end
end
