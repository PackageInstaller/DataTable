require("pick_up_policy_base")
_class("PickUpPolicy_MovePathEndPos", PickUpPolicy_Base)
PickUpPolicy_MovePathEndPos = PickUpPolicy_MovePathEndPos

function PickUpPolicy_MovePathEndPos:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local boardService = self._world:GetService("BoardLogic")
  local posList = {}
  local attackPosList = {}
  local targetIdList = {}
  local env = self:_GetPickUpPolicyEnv()
  local autoFightSvc = self._world:GetService("AutoFight")
  local chainPath, pieceType, evalue = autoFightSvc:GetAutoChainPath(calcParam.TT, env.TeamEntity)
  local pos = chainPath[#chainPath]
  local isBlockedSummonTrap = boardService:IsPosBlock(pos, BlockFlag.MonsterLand)
  local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
  if #chainPath == 1 or isBlockedSummonTrap or isBlockedLinkLine then
    return {}, {}, {}
  end
  table.insert(posList, pos)
  local result, targetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pos)
  attackPosList = result:GetAttackRange()
  return posList, attackPosList, targetIds
end
