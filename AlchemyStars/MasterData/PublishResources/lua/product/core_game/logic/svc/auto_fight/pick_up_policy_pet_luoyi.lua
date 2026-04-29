require("pick_up_policy_base")
_class("PickUpPolicy_PetLuoYi", PickUpPolicy_Base)
PickUpPolicy_PetLuoYi = PickUpPolicy_PetLuoYi

function PickUpPolicy_PetLuoYi:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetLuoYi(petEntity, activeSkillID, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetLuoYi:_CalPickPosPolicy_PetLuoYi(petEntity, activeSkillID, casterPos, validPosIdxList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local configService = self._world:GetService("Config")
  local ringMax = boardService:GetCurBoardRingMax()
  local udsvc = self._world:GetService("UtilData")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local casterPosIndex = self:_Pos2Index(casterPos)
  local needCheckPower = false
  local powerIfNoTrap, tarTrapId
  local extraParam = skillConfigData:GetSkillTriggerExtraParam()
  if extraParam and extraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
    needCheckPower = true
    powerIfNoTrap = extraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
    local pickType = skillConfigData:GetSkillPickType()
    if pickType == SkillPickUpType.PickDiffPowerInstruction then
      local pickParams = skillConfigData:GetSkillPickParam()
      tarTrapId = pickParams[3]
    end
  end
  local legendPower = 0
  if needCheckPower then
    local attributeCmpt = petEntity:Attributes()
    if attributeCmpt then
      legendPower = attributeCmpt:GetAttribute("LegendPower")
    end
  end
  local pickExtraParam = {}
  local firstPickPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= PieceType.Yellow then
        if needCheckPower then
          local bPickTrap = false
          local traps = udsvc:GetTrapsAtPos(pos)
          if traps then
            for index, e in ipairs(traps) do
              if tarTrapId == e:Trap():GetTrapID() then
                bPickTrap = true
                break
              end
            end
          end
          if not bPickTrap and powerIfNoTrap <= legendPower then
            firstPickPos = pos
            table.insert(pickExtraParam, SkillTriggerTypeExtraParam.PickPosNoCfgTrap)
            break
          end
        else
          firstPickPos = pos
          break
        end
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}, pickExtraParam
  else
    return {}, {}, {}, {}
  end
end
