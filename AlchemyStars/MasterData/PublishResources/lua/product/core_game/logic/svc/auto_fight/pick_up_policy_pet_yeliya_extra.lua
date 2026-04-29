require("pick_up_policy_base")
_class("PickUpPolicy_PetYeliyaExtra", PickUpPolicy_Base)
PickUpPolicy_PetYeliyaExtra = PickUpPolicy_PetYeliyaExtra

function PickUpPolicy_PetYeliyaExtra:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetYeliyaExtra(petEntity, activeSkillID, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetYeliyaExtra:_CalPickPosPolicy_PetYeliyaExtra(petEntity, activeSkillID, casterPos, validPosIdxList)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local checkDamageSkillID = 30018411
  local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
  if policyParam and policyParam.checkDamageSkillID then
    checkDamageSkillID = tonumber(policyParam.checkDamageSkillID)
  end
  local pickPosList = {}
  local retScopeResult = {}
  local retTargetIds = {}
  local testPickPos
  local tmpPickList = {}
  testPickPos = self:_YeliyaFindValidPosWithMaxTargetCount(petEntity, casterPos, validPosIdxList, tmpPickList, checkDamageSkillID)
  if testPickPos then
    table.insert(pickPosList, testPickPos)
  else
    return {}, {}, {}
  end
  return pickPosList, retScopeResult, retTargetIds
end

function PickUpPolicy_PetYeliyaExtra:_YeliyaFindValidPosWithMaxTargetCount(petEntity, centerPos, validPosIdxList, alreadyPickList, checkDamageSkillID)
  local pickPos
  checkDamageSkillID = 30018411
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local centerPosIndex = self:_Pos2Index(centerPos)
  local maxTargetCount = 0
  local maxTargetPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(centerPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if not table.icontains(alreadyPickList, pos) then
        local isBlockedLinkLine = boardService:IsPosBlock(pos, BlockFlag.LinkLine)
        if not isBlockedLinkLine then
          local result, targetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, checkDamageSkillID, pos)
          if targetIds then
            local targetCount = #targetIds
            if maxTargetCount < targetCount then
              maxTargetCount = targetCount
              maxTargetPos = pos
            end
          end
        end
      end
    end
  end
  if maxTargetPos then
    pickPos = maxTargetPos
  end
  return pickPos
end
