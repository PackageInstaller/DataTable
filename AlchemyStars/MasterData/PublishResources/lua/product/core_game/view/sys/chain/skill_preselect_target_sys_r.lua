_class("SkillPreselectTargetSystem_Render", ReactiveSystem)
SkillPreselectTargetSystem_Render = SkillPreselectTargetSystem_Render

function SkillPreselectTargetSystem_Render:Constructor(world)
  self._world = world
end

function SkillPreselectTargetSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {"Added"})
  return c
end

function SkillPreselectTargetSystem_Render:Filter(entity)
  local autoSvc = self._world:GetService("AutoFight")
  return entity:HasPreviewChainPath() and not autoSvc:IsRunning()
end

function SkillPreselectTargetSystem_Render:ExecuteEntities(entities)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  for _, e in ipairs(entities) do
    local entity = e
    local chainPathCmpt = entity:PreviewChainPath()
    local path = chainPathCmpt:GetPreviewChainPath()
    local pieceType = chainPathCmpt:GetPreviewPieceType()
    local firstElementType, firstElementIndex = chainPathCmpt:GetFirstElementData()
    if path ~= nil and next(path) then
      self:_SelectPreviewChainTarget(teamEntity, pieceType, firstElementType)
    end
  end
end

function SkillPreselectTargetSystem_Render:_SelectPreviewChainTarget(teamEntity, pieceType, firstElementType)
  local prvwEntity = self._world:GetPreviewEntity()
  local selectPetCmpt = prvwEntity:PreviewChainSelectPet()
  selectPetCmpt:ClearPreviewChainSelectPet()
  local battlePetList = self:_SelectPetList(teamEntity, pieceType, firstElementType)
  for _, petEntityID in ipairs(battlePetList) do
    local chainSkillID = self:_GetPetChainSkillIDByChainPathCount(petEntityID)
    if 0 < chainSkillID then
      selectPetCmpt:AddPreviewChainSelectPet(petEntityID)
      selectPetCmpt:AddPreviewChainSelectPetSkillID(petEntityID, chainSkillID)
      local scopeResult = self:_CalcChainSkillScopeAndTarget(petEntityID, chainSkillID)
      selectPetCmpt:AddPreviewChainSelectPetScopeResult(petEntityID, scopeResult)
      if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
        local petEntity = self._world:GetEntityByID(petEntityID)
        self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, petEntity:PetPstID():GetPstID(), true)
      end
    end
  end
end

function SkillPreselectTargetSystem_Render:_CalcChainSkillScopeAndTarget(petEntityID, chainSkillID)
  local castSkillPos = self:_GetChainSkillCastPos()
  local scopeResult = self:_CalcChainSkillScopeResult(petEntityID, chainSkillID, castSkillPos)
  local targetIDList = self:_CalcScopeResultTargetList(petEntityID, chainSkillID, scopeResult)
  scopeResult = self:ReplaceScopeResult(scopeResult, petEntityID, chainSkillID, castSkillPos)
  self:_FillSkillScopeResult(scopeResult, targetIDList)
  return scopeResult
end

function SkillPreselectTargetSystem_Render:_FillSkillScopeResult(scopeResult, targetIDList)
  local attackRange = scopeResult:GetAttackRange()
  for _, gridPos in ipairs(attackRange) do
    for _, targetEntityID in ipairs(targetIDList) do
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local gridLocationCmpt = targetEntity:GridLocation()
      local bodyAreaCmpt = targetEntity:BodyArea()
      local bodyAreaList = bodyAreaCmpt:GetArea()
      for i, bodyArea in ipairs(bodyAreaList) do
        local curBodyPos = Vector2(gridLocationCmpt.Position.x + bodyArea.x, gridLocationCmpt.Position.y + bodyArea.y)
        if curBodyPos == gridPos then
          scopeResult:AddTargetIDAndPos(targetEntityID, gridPos)
        end
      end
    end
  end
end

function SkillPreselectTargetSystem_Render:_CalcScopeResultTargetList(petEntityID, chainSkillID, scopeResult)
  local selector = SkillScopeTargetSelector:New(self._world)
  local castEntity = self._world:GetEntityByID(petEntityID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, castEntity)
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local entityIDArray = selector:DoSelectSkillTarget(castEntity, skillTargetType, scopeResult, chainSkillID)
  return entityIDArray
end

function SkillPreselectTargetSystem_Render:_CalcChainSkillScopeResult(petEntityID, chainSkillID, castSkillPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local petEntity = self._world:GetEntityByID(petEntityID)
  local skillConfigData = configService:GetSkillConfigData(chainSkillID, petEntity)
  local utilData = self._world:GetService("UtilData")
  skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, petEntity)
  local castePos = castSkillPos:Clone()
  local replaceChainEntityID = petEntity:BuffView():GetBuffValue("ReplaceEntityID")
  if replaceChainEntityID then
    local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
    castePos = replaceChainEntity:GridLocation():GetGridPos():Clone()
  end
  local scopeResult = utilScopeSvc:CalcSkillScopeForChainSkillPreview(skillConfigData, castePos, petEntity)
  utilScopeSvc:ExpandMaxChainSkillScope(petEntity, chainSkillID, scopeResult, castePos)
  return scopeResult
end

function SkillPreselectTargetSystem_Render:_GetChainSkillCastPos()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPathList = previewChainPathCmpt:GetPreviewChainPath()
  local chainTotalCount = previewChainPathCmpt:GetPreviewChainTotalCount()
  local casterPos = chainPathList[chainTotalCount]
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    casterPos = chainPathList[1]
  end
  return casterPos
end

function SkillPreselectTargetSystem_Render:_GetPetChainSkillIDByChainPathCount(petEntityID)
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local chainCount, superGridNum = utilCalcSvc:GetChainDamageRateAtIndex(chainPath, #chainPath)
  if 3 <= chainCount then
  end
  local petEntity = self._world:GetEntityByID(petEntityID)
  local skillInfoCmpt = petEntity:SkillInfo()
  local rule = skillInfoCmpt._chainSkillIDSelector:GetRule()
  local tmpChainSkillID = rule[1].Skill
  local configSvc = self._world:GetService("Config")
  local firstChainConfig = configSvc:GetSkillConfigData(tmpChainSkillID)
  local previewType = firstChainConfig:GetSkillPreviewType()
  if previewType ~= SkillPreviewType.Pet1502051Chain then
    local fix = petEntity:RenderAttributes():GetAttribute("ChainSkillReleaseFix") or 0
    local chainCountMul = petEntity:RenderAttributes():GetAttribute("ChainSkillReleaseMul") or 0
    local fixedChainCount = math.ceil((chainCount + fix) * (1 + chainCountMul))
    local utilData = self._world:GetService("UtilData")
    local chainExtraFix = utilData:GetEntityBuffValue(petEntity, "ChangeExtraChainSkillReleaseFixForSkill")
    local skillID = utilData:GetChainSkillByChainCount(petEntity, fixedChainCount, chainExtraFix)
    return skillID
  else
    local previewLinkLineSvc = self._world:GetService("PreviewLinkLine")
    local skillID, useless = previewLinkLineSvc:CalcReplaceChainPreviewParamsPet1502051(petEntity, chainPath)
    return skillID or 0
  end
end

function SkillPreselectTargetSystem_Render:_SelectPetList(teamEntity, pieceType, firstElementType)
  local petResultList = {}
  local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsTeamLeaderCanAttack(teamEntity, pieceType) and (not utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() or utilDataSvc:GetPreviewPetEntityID() == teamLeaderEntityID) then
    petResultList[#petResultList + 1] = teamLeaderEntityID
  end
  local teamOrder = teamEntity:Team():GetTeamOrder()
  for i = 2, #teamOrder do
    local curPetPstID = teamOrder[i]
    local petEntity = teamEntity:Team():GetPetEntityByPetPstID(curPetPstID)
    if not petEntity:HasBuffFlag(BuffFlags.SealedCurse) and (not petEntity:HasBuffFlag(BuffFlags.Pet1702361NotLinkLine) or utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep()) then
      local isMatch = false
      local forceMatch = utilDataSvc:GetEntityBuffValue(petEntity, "PetForceMatch")
      if forceMatch then
        isMatch = true
      else
        isMatch = self:_IsPetEntityMatchPieceType(petEntity, pieceType)
        if not isMatch and firstElementType then
          isMatch = self:_IsPetEntityMatchPieceType(petEntity, firstElementType)
        end
      end
      local PetForcepetForceChain = utilDataSvc:OnCheckPetForceChain(petEntity)
      if (isMatch == true or PetForcepetForceChain == true) and not petEntity:HasPetDeadMark() then
        petResultList[#petResultList + 1] = petEntity:GetID()
      end
    end
  end
  return petResultList
end

function SkillPreselectTargetSystem_Render:_IsPetEntityMatchPieceType(petEntity, pieceType)
  local utilDataSvc = self._world:GetService("UtilData")
  if self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local isMatch = true
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    if teamEntity then
      local onlyTeamLeaderColorPet = teamEntity:BuffView():GetBuffValue("OnlyTeamLeaderColorPet")
      if onlyTeamLeaderColorPet and onlyTeamLeaderColorPet == 1 then
        local teamLeaderEntityID = teamEntity:Team():GetTeamLeaderEntityID()
        local teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
        if teamLeaderEntity then
          local teamLeaderElementCmpt = teamLeaderEntity:Element()
          if teamLeaderElementCmpt then
            local teamLeaderPrimaryType = teamLeaderElementCmpt:GetPrimaryType()
            local primaryMatch = utilDataSvc:IsMatchPieceType(petEntity:GetID(), teamLeaderPrimaryType)
            if primaryMatch then
              isMatch = true
            else
              isMatch = false
            end
          end
        end
      end
    end
    return isMatch
  elseif utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    return petEntity:GetID() == utilDataSvc:GetPreviewPetEntityID()
  end
  local elementCmpt = petEntity:Element()
  local sencondardType = elementCmpt:GetSecondaryType()
  local primaryMatch = utilDataSvc:IsMatchPieceType(petEntity:GetID(), pieceType)
  local secondaryMatch = CanMatchPieceType(sencondardType, pieceType)
  if primaryMatch or secondaryMatch then
    return true
  end
  return false
end

function SkillPreselectTargetSystem_Render:ReplaceScopeResult(scopeResult, petEntityID, chainSkillID, castSkillPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local petEntity = self._world:GetEntityByID(petEntityID)
  local configService = self._world:GetService("Config")
  local castePos = castSkillPos:Clone()
  local replaceChainEntityID = petEntity:BuffView():GetBuffValue("ReplaceEntityID")
  if replaceChainEntityID then
    local replaceChainEntity = self._world:GetEntityByID(replaceChainEntityID)
    castePos = replaceChainEntity:GridLocation():GetGridPos():Clone()
  end
  local skillConfigData = configService:GetSkillConfigData(chainSkillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  if scopeType == SkillScopeType.NearestInSquareRing and skillConfigData:GetSkillPreviewType() == SkillPreviewType.ScopeSingleChainSkillInScope54 then
    local param = skillConfigData:GetSkillScopeParam()
    local newSkillConfigData = SkillConfigData:New()
    local utilData = self._world:GetService("UtilData")
    local scopeParamAppender = utilData:GetEntityBuffValue(petEntity, "ChainSkillPreviewScopeParamAppender" .. chainSkillID)
    if scopeParamAppender then
      if type(param) == "table" then
        local copyScopeParam = {}
        for k, v in pairs(param) do
          copyScopeParam[k] = v
        end
        for index, val in ipairs(scopeParamAppender) do
          copyScopeParam[index] = copyScopeParam[index] + val
        end
        param = copyScopeParam
      elseif type(param) == "number" then
        local appendVal = scopeParamAppender[1] or 0
        param = param + appendVal
      end
    end
    newSkillConfigData._scopeParamData = {
      param[1]
    }
    utilData:ExpandSingleChainScope(petEntity, scopeType, newSkillConfigData._scopeParamData)
    if scopeType == SkillScopeType.NearestInSquareRing and param[3] and 0 < param[3] then
      newSkillConfigData._scopeParamData[5] = param[3]
    end
    newSkillConfigData._scopeType = SkillScopeType.SquareRing
    newSkillConfigData._scopeCenterType = skillConfigData:GetSkillScopeCenterType()
    newSkillConfigData._targetType = skillConfigData:GetSkillTargetType()
    newSkillConfigData._scopeFilterParam = skillConfigData:GetScopeFilterParam()
    scopeResult = utilScopeSvc:CalcSkillScope(newSkillConfigData, castePos, petEntity)
  elseif skillConfigData:GetSkillPreviewType() == SkillPreviewType.ScopeSingleChainSkillWithParam then
    local newSkillConfigData = SkillConfigData:New()
    local skillPreviewParam = skillConfigData:GetSkillPreviewParam()
    local scopeType = skillPreviewParam.scopeType
    local scopeParam = skillPreviewParam.scopeParam
    local utilData = self._world:GetService("UtilData")
    local scopeParamAppender = utilData:GetEntityBuffValue(petEntity, "ChainSkillPreviewScopeParamAppender" .. chainSkillID)
    if scopeParamAppender then
      if type(scopeParam) == "table" then
        local copyScopeParam = {}
        for k, v in pairs(scopeParam) do
          copyScopeParam[k] = v
        end
        for index, val in ipairs(scopeParamAppender) do
          copyScopeParam[index] = copyScopeParam[index] + val
        end
        scopeParam = copyScopeParam
      elseif type(scopeParam) == "number" then
        local appendVal = scopeParamAppender[1] or 0
        scopeParam = scopeParam + appendVal
      end
    end
    newSkillConfigData._scopeType = scopeType
    newSkillConfigData._scopeParamData = scopeParam
    newSkillConfigData._scopeCenterType = skillConfigData:GetSkillScopeCenterType()
    newSkillConfigData._targetType = skillConfigData:GetSkillTargetType()
    newSkillConfigData._scopeFilterParam = skillConfigData:GetScopeFilterParam()
    scopeResult = utilScopeSvc:CalcSkillScope(newSkillConfigData, castePos, petEntity)
  end
  return scopeResult
end
