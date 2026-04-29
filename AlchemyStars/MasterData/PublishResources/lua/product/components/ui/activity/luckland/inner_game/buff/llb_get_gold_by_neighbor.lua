require("llb_logic_base")
_class("LLBuffLogicGetGoldByNeighbor", LLBuffLogicBase)
LLBuffLogicGetGoldByNeighbor = LLBuffLogicGetGoldByNeighbor

function LLBuffLogicGetGoldByNeighbor:Constructor(buffObj, logicParam)
  self._multiple = logicParam.multiple
end

function LLBuffLogicGetGoldByNeighbor:DoLogic(notify)
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
    self:DoLogicSingle(target, maxRes * self._multiple)
  end
end

function LLBuffLogicGetGoldByNeighbor:DoLogicSingle(target, gold)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:AddDirectGold(gold)
end
