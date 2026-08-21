require("pick_up_policy_base")
_class("PickUpPolicy_HeroPos", PickUpPolicy_Base)
PickUpPolicy_HeroPos = PickUpPolicy_HeroPos

function PickUpPolicy_HeroPos:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local result, targetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, casterPos)
  return {casterPos}, result:GetAttackRange(), targetIds
end
