require("pick_up_policy_base")
_class("PickUpPolicy_PetSaiKa", PickUpPolicy_Base)
PickUpPolicy_PetSaiKa = PickUpPolicy_PetSaiKa

function PickUpPolicy_PetSaiKa:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local validResults = self:_CalcValidResultByPickUpType_PickUpPolicy(petEntity, activeSkillID, validPosList)
  local maxPos
  local maxHP = 0
  for _, v in ipairs(validResults) do
    for _, id in ipairs(v[2]) do
      local e = self._world:GetEntityByID(id)
      local hp = e:Attributes():GetCurrentHP()
      if maxHP < hp then
        maxHP = hp
        maxPos = v[1]
        targetIdList = v[2]
        attackPosList = v[3]
      end
    end
  end
  return {maxPos}, attackPosList, targetIdList
end
