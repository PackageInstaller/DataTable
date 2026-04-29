_class("SkillEffectCalc_Puzzle", Object)
SkillEffectCalc_Puzzle = SkillEffectCalc_Puzzle

function SkillEffectCalc_Puzzle:Constructor(world)
  self._world = world
end

function SkillEffectCalc_Puzzle:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    return
  end
  local result = SkillEffectPuzzleResult:New()
  local pickUpPosList = pickupComponent:GetAllValidPickUpGridPos()
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local tmpConvertInfoDic = {}
  for index = 2, #pickUpPosList do
    local oldPos = pickUpPosList[index - 1]
    local newPos = pickUpPosList[index]
    local oldPieceType = boardCmpt:GetPieceType(oldPos)
    local newPieceType = boardCmpt:GetPieceType(newPos)
    boardServiceLogic:SetPieceTypeLogic(oldPieceType, newPos)
    boardServiceLogic:SetPieceTypeLogic(newPieceType, oldPos)
    result:AddExchangePieceType(oldPos, oldPieceType, newPos, newPieceType)
    tmpConvertInfoDic[oldPos:Pos2Index()] = {
      oldPos,
      oldPieceType,
      newPieceType
    }
    tmpConvertInfoDic[newPos:Pos2Index()] = {
      newPos,
      newPieceType,
      oldPieceType
    }
  end
  local convertInfoArray = {}
  for _, info in pairs(tmpConvertInfoDic) do
    local convertInfo = NTGridConvert_ConvertInfo:New(info[1], info[2], info[3])
    table.insert(convertInfoArray, convertInfo)
  end
  local convertPos = pickUpPosList[#pickUpPosList]
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local convertPieceType = param:GetConvertPieceType()
  local beforePieceType = boardCmpt:GetPieceType(convertPos)
  boardServiceLogic:SetPieceTypeLogic(convertPieceType, convertPos)
  result:AddConvertInfo(convertPos, beforePieceType, convertPieceType)
  local convertInfo = NTGridConvert_ConvertInfo:New(convertPos, beforePieceType, convertPieceType)
  table.insert(convertInfoArray, convertInfo)
  local triggerSvc = self._world:GetService("Trigger")
  local ntConvertGrid = NTGridConvert:New(casterEntity, convertInfoArray)
  ntConvertGrid:SetConvertEffectType(param:GetEffectType())
  ntConvertGrid:SetSkillType(param:GetSkillType())
  triggerSvc:Notify(ntConvertGrid)
  result:SetNotifyConvertArray(convertInfoArray)
  return result
end
