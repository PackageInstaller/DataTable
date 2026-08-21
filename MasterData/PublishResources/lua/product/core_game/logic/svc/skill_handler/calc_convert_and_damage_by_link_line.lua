_class("SkillEffectCalc_ConvertAndDamageByLinkLine", Object)
SkillEffectCalc_ConvertAndDamageByLinkLine = SkillEffectCalc_ConvertAndDamageByLinkLine

function SkillEffectCalc_ConvertAndDamageByLinkLine:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ConvertAndDamageByLinkLine:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local activeSkillPickUpCmpt = casterEntity:ActiveSkillPickUpComponent()
  if not activeSkillPickUpCmpt then
    return
  end
  local chainPath = activeSkillPickUpCmpt:GetAllValidPickUpGridPos()
  local linkCount = #chainPath
  if linkCount <= 1 then
    return
  end
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local convertCount = skillEffectParam:GetConvertCount()
  local canLinkMonster = skillEffectParam:IsCanLinkMonster()
  if convertCount then
    local maxLinkCount = convertCount + 1
    if canLinkMonster then
      maxLinkCount = maxLinkCount + 1
    end
    if linkCount > maxLinkCount then
      return
    end
  end
  local isLinkMonster = false
  local lastPos = chainPath[#chainPath]
  local utilDataSvc = self._world:GetService("UtilData")
  local monsterEntity = utilDataSvc:GetMonsterAtPos(lastPos)
  if monsterEntity then
    isLinkMonster = true
  end
  local effectResult = SkillEffectConvertAndDamageByLinkLineResult:New()
  local linkPosList = table.cloneconf(chainPath)
  local convertLinePosList = table.cloneconf(chainPath)
  local convertEndPos
  local attackPos = casterEntity:GetGridPosition()
  local isMoye = self:IsMoye(skillEffectCalcParam:GetSkillID(), casterEntity)
  if isLinkMonster and not isMoye then
    if #chainPath == 2 then
      linkPosList = {}
      convertLinePosList = {}
      convertEndPos = nil
    else
      table.remove(linkPosList, #linkPosList)
      table.remove(convertLinePosList, 1)
      table.remove(convertLinePosList, #convertLinePosList)
      table.remove(convertLinePosList, #convertLinePosList)
      convertEndPos = chainPath[#chainPath - 1]
      attackPos = convertEndPos
      local teleportRes = self:CalculateTeleportResult(skillEffectCalcParam, attackPos, monsterEntity)
      effectResult:SetTeleportResult(teleportRes)
    end
  else
    table.remove(convertLinePosList, 1)
  end
  effectResult:SetChainPath(linkPosList)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  if 0 < #convertLinePosList then
    local skillRangePosList = {}
    local convertType = skillEffectParam:GetConvertType()
    if convertType then
      for _, pos in pairs(convertLinePosList) do
        local canConverPos = boardServiceLogic:GetCanConvertGridElement(pos)
        local pieceType = boardServiceLogic:GetPieceType(pos)
        if canConverPos and pieceType ~= convertType then
          table.insert(skillRangePosList, pos)
        end
      end
      local convertResult = SkillConvertGridElementEffectResult:New(skillRangePosList, convertType)
      effectResult:SetConvertResult(convertResult)
    end
  end
  if isLinkMonster then
    local damageResult = self:CalculateDamageResult(skillEffectCalcParam, attackPos, monsterEntity)
    effectResult:SetDamageResult(damageResult)
  end
  return {effectResult}
end

function SkillEffectCalc_ConvertAndDamageByLinkLine:CalculateTeleportResult(skillEffectCalcParam, newPos, defenderEntity)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local pieceType = param:GetConvertType()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition():Clone()
  local defenderPos = defenderEntity:GetGridPosition()
  local dirNew = defenderPos - newPos
  if not pieceType then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    boardServiceLogic:RemoveEntityBlockFlag(casterEntity, casterPos)
    pieceType = boardServiceLogic:SupplyPieceList({casterPos})[1].color
  end
  local stageIndex = param:GetSkillEffectDamageStageIndex()
  local result = SkillEffectResult_Teleport:New(casterEntityID, casterPos, pieceType, newPos, dirNew, stageIndex)
  return result
end

function SkillEffectCalc_ConvertAndDamageByLinkLine:CalculateDamageResult(skillEffectCalcParam, attackPos, defenderEntity)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local percentList = param:GetPercent()
  local curFormulaID = param:GetFormulaID()
  if curFormulaID == nil then
    curFormulaID = 5
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local defenderPos = defenderEntity:GetGridPosition()
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = percentList,
    formulaID = curFormulaID,
    damageStageIndex = 1
  })
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, attackPos, defenderEntity, defenderPos, skillEffectCalcParam:GetSkillID(), skillDamageParam, SkillEffectType.ConvertAndDamageByLinkLine, 1)
  local damageRes = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, defenderEntity:GetID(), nTotalDamage, listDamageInfo)
  return damageRes
end

function SkillEffectCalc_ConvertAndDamageByLinkLine:IsMoye(activeSkillID, petEntity)
  local configService = self._world:GetService("Config")
  local skillCfgData = configService:GetSkillConfigData(activeSkillID, petEntity)
  if skillCfgData then
    local pickUpType = skillCfgData:GetSkillPickType()
    return pickUpType == SkillPickUpType.Moye
  end
  return false
end
