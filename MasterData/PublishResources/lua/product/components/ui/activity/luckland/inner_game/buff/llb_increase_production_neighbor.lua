require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionNeighbor", LLBuffLogicBase)
LLBuffLogicIncreaseProductionNeighbor = LLBuffLogicIncreaseProductionNeighbor

function LLBuffLogicIncreaseProductionNeighbor:Constructor(buffObj, logicParam)
end

function LLBuffLogicIncreaseProductionNeighbor:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local maxRes = 0
  if notifyEntity:GetEntityType() == LuckLandEntityType.Pet then
    local petEntity = notifyEntity
    local pos = petEntity:GetPos()
    local leftPet, rightPet
    local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
    local fightPets = entityMgr:GetFightPets()
    if fightPets then
      for _, pet in ipairs(fightPets) do
        if pet:GetPos() == pos - 1 then
          leftPet = pet
        end
        if pet:GetPos() == pos + 1 then
          rightPet = pet
        end
      end
    end
    if leftPet then
      maxRes = leftPet:CalculateRes()
    end
    if rightPet then
      local resValue = rightPet:CalculateRes()
      if maxRes < resValue then
        maxRes = resValue
      end
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, maxRes)
  end
end

function LLBuffLogicIncreaseProductionNeighbor:DoLogicSingle(target, maxRes)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Temp then
    target:AddTempFixValue(maxRes)
  end
end
