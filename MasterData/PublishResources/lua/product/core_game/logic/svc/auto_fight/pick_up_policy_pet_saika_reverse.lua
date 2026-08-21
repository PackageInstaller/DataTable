require("pick_up_policy_base")
_class("PickUpPolicy_PetSaiKaReverse", PickUpPolicy_Base)
PickUpPolicy_PetSaiKaReverse = PickUpPolicy_PetSaiKaReverse

function PickUpPolicy_PetSaiKaReverse:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local validResults = self:_CalcValidResultByPickUpType_PickUpPolicy(petEntity, activeSkillID, validPosList)
  local minPos
  local minHP = -1
  for _, v in ipairs(validResults) do
    for _, id in ipairs(v[2]) do
      local e = self._world:GetEntityByID(id)
      local hp = e:Attributes():GetCurrentHP()
      if 0 < hp and (minHP < 0 or minHP > hp) then
        minHP = hp
        minPos = v[1]
        targetIdList = v[2]
        attackPosList = v[3]
      end
    end
  end
  return {minPos}, attackPosList, targetIdList
end
