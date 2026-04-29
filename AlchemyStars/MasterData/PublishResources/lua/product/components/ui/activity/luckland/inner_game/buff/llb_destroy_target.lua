require("llb_logic_base")
_class("LLBuffLogicDestroyTarget", LLBuffLogicBase)
LLBuffLogicDestroyTarget = LLBuffLogicDestroyTarget

function LLBuffLogicDestroyTarget:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicDestroyTarget:DoLogic(notify)
  self._notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  local count = #targets
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, self._notifyEntity)
  end
  if self._incType and not self._notifyEntity:HasDeleteFlag() then
    if self._incType == LuckLandIncType.Accumulate then
      if self._fixVal then
        self._notifyEntity:AddAccFixValue(self._fixVal * count)
      end
      if self._perVal then
        self._notifyEntity:AddAccPerValue(self._perVal * count)
      end
    elseif self._incType == LuckLandIncType.Temp then
      if self._fixVal then
        self._notifyEntity:AddTempFixValue(self._fixVal * count)
      end
      if self._perVal then
        self._notifyEntity:AddTempPerValue(self._perVal * count)
      end
    end
  end
end

function LLBuffLogicDestroyTarget:DoLogicSingle(target)
  if target:GetEntityType() ~= LuckLandEntityType.Pet then
    Log.error("[LuckLand] Destroy entity is not pet, buff ID = ", self._buffObj:BuffID())
    return
  end
  target:GetLuckLandModule():GetEntityMng():DeleteCard(target:ID(), self._notifyEntity)
  target:SetDeleteFlag()
end
