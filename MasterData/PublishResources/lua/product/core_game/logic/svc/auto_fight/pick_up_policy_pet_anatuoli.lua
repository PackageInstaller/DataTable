require("pick_up_policy_base")
_class("PickUpPolicy_PetANaTuoLi", PickUpPolicy_Base)
PickUpPolicy_PetANaTuoLi = PickUpPolicy_PetANaTuoLi

function PickUpPolicy_PetANaTuoLi:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickUpNum = self:_GetPickUpNumByConfig(activeSkillID)
  local petColor = petEntity:Element():GetPrimaryType()
  local casterPos = petEntity:GridLocation().Position
  local boardService = self._world:GetService("BoardLogic")
  local utilDataSvc = self._world:GetService("UtilData")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local posList = {}
  local targetIdList = {}
  local attackPosList = {}
  local pickMonsterList = {}
  local ringMax = boardService:GetCurBoardRingMax()
  local casterPosIndex = self:_Pos2Index(casterPos)
  local env = self:_GetPickUpPolicyEnv()
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local isRepeatMonster = false
      local isValidTarget = true
      local entity = utilDataSvc:GetMonsterAtPos(pos)
      if entity then
        if entity and entity:HasBuff() and not buffLogicSvc:CheckCanBeMagicAttack(petEntity, entity) then
          isValidTarget = false
        end
        if isValidTarget then
          local entityID = entity:GetID()
          if table.icontains(pickMonsterList, entityID) then
            isRepeatMonster = true
          else
            table.insert(pickMonsterList, entityID)
          end
        end
      end
      if isValidTarget and not isRepeatMonster then
        posList[#posList + 1] = pos
        if pickUpNum <= #posList then
          break
        end
      end
    end
  end
  if 0 < #posList then
    attackPosList = {}
    targetIdList = pickMonsterList
  end
  return posList, attackPosList, targetIdList
end
