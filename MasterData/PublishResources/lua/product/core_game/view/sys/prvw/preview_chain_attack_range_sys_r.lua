_class("PreviewChainAttackRangeSystem_Render", ReactiveSystem)
PreviewChainAttackRangeSystem_Render = PreviewChainAttackRangeSystem_Render

function PreviewChainAttackRangeSystem_Render:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
end

function PreviewChainAttackRangeSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PreviewChainPath)
  }, {"Added"})
  return c
end

function PreviewChainAttackRangeSystem_Render:Filter(entity)
  local autoSvc = self._world:GetService("AutoFight")
  if autoSvc:IsRunning() then
    return false
  end
  if self._world:MatchType() == MatchType.MT_Chess then
    return false
  end
  return entity:HasPreviewChainPath()
end

function PreviewChainAttackRangeSystem_Render:ExecuteEntities(entities)
  local reBoard = self._world:GetRenderBoardEntity()
  self.previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  self:_DestroyChainSkillRange()
  self.chainSkillRangeDic = self.previewChainSkillRangeCmpt:GetChainSkillRangeOutlineDic()
  self.chainPreviewMonsterBehaviorCmpt = reBoard:ChainPreviewMonsterBehavior()
  for i = 1, #entities do
    self:_RenderChainAttackRange(entities[i])
  end
end

local OutlineDirType = {
  Up = 1,
  Down = 2,
  Left = 3,
  Right = 4,
  LeftUp = 5,
  RightUp = 6,
  RightDown = 7,
  LeftDown = 8
}
local OutlineType = {
  Short = 1,
  LeftShort = 2,
  RightShort = 3,
  Long = 4
}

function PreviewChainAttackRangeSystem_Render:_RenderChainAttackRange(previewEntity)
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local chainPieceType = previewChainPathCmpt:GetPreviewPieceType()
  local chainPathNum = #chainPath
  local lastChainPathPoint = chainPath[chainPathNum]
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    lastChainPathPoint = chainPath[1]
  end
  local previewEntity = self._world:GetPreviewEntity()
  local selectPetCmpt = previewEntity:PreviewChainSelectPet()
  local petIDList = selectPetCmpt:GetRenderPetList()
  local previewIndex = 0
  local previewPstIDAndSkill = {}
  for _, petEntityID in ipairs(petIDList) do
    local petEntity = self._world:GetEntityByID(petEntityID)
    local petCanChainAttack = utilData:OnCheckPetCanCastChainSkill(petEntityID)
    if petCanChainAttack ~= false then
      local chainSkillID = selectPetCmpt:GetPreviewChainSelectPetSkillID(petEntityID)
      local skillSelectMode, preViewType, scopeType = self:_GetSkillPreviewMode(chainSkillID)
      local scopeResult = selectPetCmpt:GetPreviewChainSelectPetScopeResult(petEntityID)
      local outlinePieceType = utilData:GetEntityElementType(petEntity)
      if self._world:MatchType() == MatchType.MT_PopStarPro then
        local isMatch, isActiveFetters = utilData:IsMatchPieceType(petEntityID, chainPieceType)
        if isMatch and isActiveFetters then
          outlinePieceType = chainPieceType
        end
      end
      local atkRange = scopeResult:GetAttackRange()
      if atkRange then
        local hasTarget = true
        previewIndex = previewIndex + 1
        self.previewChainSkillRangeCmpt:AddChainSkillAttackElementType(previewIndex, outlinePieceType)
        if preViewType ~= SkillPreviewType.AddHPChainSkill then
          if preViewType == SkillPreviewType.ScopeSingleChainSkill or preViewType == SkillPreviewType.ScopeSingleChainSkillInScope54 and scopeType == SkillScopeType.NearestInSquareRing then
            local allTargetIDs = scopeResult:GetTargetIDs()
            if next(allTargetIDs) then
              self:_CreateSingleEntitySnipeEffect(previewIndex, allTargetIDs)
              self.chainSkillRangeDic:AddPetChainSkillOutlineRange(previewIndex)
              self:_CreateOutlineRangeEntity(scopeResult:GetAttackRange(), PieceType.None, previewIndex, lastChainPathPoint, scopeResult:GetCenterPos())
              self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.RangeAndSingleEntity)
              table.insert(previewPstIDAndSkill, {
                pstID = petEntity:PetPstID():GetPstID(),
                index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
              })
            else
              hasTarget = false
              previewIndex = previewIndex - 1
            end
          elseif preViewType == SkillPreviewType.SkillEffect191InChain then
            local skillConfigData = self._configService:GetSkillConfigData(chainSkillID)
            local effectArray = utilData:GetLatestEffectParamArray(petEntityID, chainSkillID)
            local is191Found = false
            local centerScopeResult
            for _, effect in ipairs(effectArray) do
              if effect:GetEffectType() == SkillEffectType.DynamicCenterDamage then
                is191Found = true
                local centerScopeType = effect:GetCenterScopeType()
                local centerScopeParam = effect:GetCenterScopeParam()
                local utilScopeSvc = self._world:GetService("UtilScopeCalc")
                local scopeCal = SkillScopeCalculator:New(utilScopeSvc)
                centerScopeResult = scopeCal:ComputeScopeRange(centerScopeType, centerScopeParam, lastChainPathPoint or petEntity:GetGridPosition(), petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), SkillTargetType.Monster, petEntity:GetGridPosition(), petEntity)
                break
              end
            end
            if not is191Found then
              hasTarget = false
              previewIndex = previewIndex - 1
            else
              self.chainSkillRangeDic:AddPetChainSkillOutlineRange(previewIndex)
              self:_CreateOutlineRangeEntity(centerScopeResult:GetAttackRange(), outlinePieceType, previewIndex, lastChainPathPoint, centerScopeResult:GetCenterPos())
              self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.Range)
              table.insert(previewPstIDAndSkill, {
                pstID = petEntity:PetPstID():GetPstID(),
                index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
              })
            end
          elseif preViewType == SkillPreviewType.PetChainRobotBomb then
            local skillEffectArray = utilData:GetLatestEffectParamArray(petEntityID, chainSkillID)
            local targetSkillEffectParamList = {}
            for index, config in ipairs(skillEffectArray) do
              if config:GetEffectType() == SkillEffectType.RobotBomb then
                table.insert(targetSkillEffectParamList, config)
              end
            end
            if table.count(targetSkillEffectParamList) == 0 then
              hasTarget = false
              previewIndex = previewIndex - 1
            end
            local resultArray = {}
            for _, skillEffectParam in ipairs(targetSkillEffectParamList) do
              local calcParam = SkillEffectCalcParam:New(petEntityID, {-1}, skillEffectParam, chainSkillID, scopeResult:GetAttackRange(), nil, petEntity:GetGridPosition(), lastChainPathPoint, scopeResult:GetWholeGridRange())
              local calc_RobotBomb = SkillEffectCalc_RobotBomb:New(self._world)
              local skillResultArray = calc_RobotBomb:DoSkillEffectCalculator(calcParam, true)
              if skillResultArray and 0 < table.count(skillResultArray) then
                table.appendArray(resultArray, skillResultArray)
              end
            end
            if resultArray and 0 < table.count(resultArray) then
              self.chainSkillRangeDic:AddPetChainSkillOutlineRange(previewIndex)
              for _, v in ipairs(resultArray) do
                local resultRobotBomb = v
                local explosionRange = resultRobotBomb.explosionRange
                if explosionRange and 0 < table.count(explosionRange) then
                  self:_CreateOutlineRangeEntity(explosionRange, outlinePieceType, previewIndex, lastChainPathPoint, nil)
                end
              end
              self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.Range)
              table.insert(previewPstIDAndSkill, {
                pstID = petEntity:PetPstID():GetPstID(),
                index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
              })
            else
              hasTarget = false
              previewIndex = previewIndex - 1
            end
          elseif skillSelectMode == SkillTargetSelectionMode.Grid then
            self.chainSkillRangeDic:AddPetChainSkillOutlineRange(previewIndex)
            self:_CreateOutlineRangeEntity(scopeResult:GetAttackRange(), outlinePieceType, previewIndex, lastChainPathPoint, scopeResult:GetCenterPos())
            self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.Range)
            table.insert(previewPstIDAndSkill, {
              pstID = petEntity:PetPstID():GetPstID(),
              index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
            })
          elseif skillSelectMode == SkillTargetSelectionMode.Entity then
            local allTargetIDs = scopeResult:GetTargetIDs()
            if next(allTargetIDs) then
              self:_CreateSingleEntitySnipeEffect(previewIndex, allTargetIDs)
              self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.SingleEntity)
              table.insert(previewPstIDAndSkill, {
                pstID = petEntity:PetPstID():GetPstID(),
                index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
              })
            else
              hasTarget = false
              previewIndex = previewIndex - 1
            end
          end
        else
          self:_AddAddHPPet(previewIndex, petEntity)
          self:_AddPetPreviewTypeByPreviewIndex(previewIndex, PreviewChainSkillType.AddHP)
          table.insert(previewPstIDAndSkill, {
            pstID = petEntity:PetPstID():GetPstID(),
            index = petEntity:SkillInfo():GetChainSkillLevel(chainSkillID)
          })
        end
        if hasTarget then
          self.previewChainSkillRangeCmpt:AddPreviewPetID(previewIndex, petEntity:GetID())
        end
      end
    end
  end
  for _, data in ipairs(previewPstIDAndSkill) do
    local pstID = data.pstID
    local index = data.index
    self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {pstID = pstID, index = index})
  end
  if 0 < previewIndex then
    self.previewChainSkillRangeCmpt:SetPreviewTypeIndex(1)
    self.previewChainSkillRangeCmpt:SetPreviewStartTime(0)
  end
  if 1 < previewIndex then
    self.previewChainSkillRangeCmpt:SetChainSkillRangeFlash(true)
  else
    self.previewChainSkillRangeCmpt:SetChainSkillRangeFlash(false)
  end
  self.chainPreviewMonsterBehaviorCmpt:SetChainPath(chainPath)
  self.chainPreviewMonsterBehaviorCmpt:SetNeedRefresh(true)
end

function PreviewChainAttackRangeSystem_Render:_GetSkillPreviewMode(chainSkillID)
  local skillConfigData = self._configService:GetSkillConfigData(chainSkillID)
  local preViewType = skillConfigData:GetSkillPreviewType()
  local scopeType = skillConfigData:GetSkillScopeType()
  local skillFilter = skillConfigData:GetScopeFilterParam()
  local skillSelectMode = skillFilter:GetTargetSelectionMode()
  return skillSelectMode, preViewType, scopeType
end

function PreviewChainAttackRangeSystem_Render:_CreateOutlineRangeEntity(chainAttackGridData, pieceType, previewIndex, lastChainPathPoint, centerPos)
  local boardServiceRender = self._world:GetService("BoardRender")
  local entityPoolService = self._world:GetService("EntityPool")
  local chainAttackRangeCache = {}
  for _, pos in pairs(chainAttackGridData) do
    local x = pos.x
    local t = chainAttackRangeCache[x]
    if not t then
      t = {}
      chainAttackRangeCache[pos.x] = t
    end
    t[pos.y] = true
  end
  
  local function isContainPos(posList, pos)
    local t = posList[pos.x]
    if not t then
      return false
    end
    return t[pos.y] == true
  end
  
  local tranRenderSvc = self._world:GetService("TransformRenderer")
  if centerPos and centerPos._className == "Vector2" and not table.icontains(chainAttackGridData, centerPos) then
    table.insert(chainAttackGridData, centerPos)
  end
  for _, pos in pairs(chainAttackGridData) do
    local roundPosList = boardServiceRender:GetRoundPosList(pos)
    for i = 1, #roundPosList do
      local roundPos = roundPosList[i]
      if not isContainPos(chainAttackRangeCache, roundPos) and roundPos ~= lastChainPathPoint then
        local cacheEntity = entityPoolService:GetCacheEntityByConfigID(EntityConfigIDRender.SkillRangeOutline)
        local skillRangeOutlineCmp = cacheEntity:SkillRangeOutline()
        skillRangeOutlineCmp:SetIsPreview(true)
        skillRangeOutlineCmp:SetPieceType(pieceType)
        tranRenderSvc:PlaySkillRangeAnim(cacheEntity)
        local outlineDir = roundPos - pos
        local outlineDirType = boardServiceRender:GetOutlineDirType(outlineDir)
        self:_SetOutlineEntityPosAndDir(pos, cacheEntity, outlineDirType, BattleConst.CacheHeight)
        self.chainSkillRangeDic:AddChainSkillRangeOutlineEntityID(previewIndex, cacheEntity:GetID())
      end
    end
  end
end

function PreviewChainAttackRangeSystem_Render:_SetOutlineEntityPosAndDir(pos, outlineEntity, outlineDirType, renderHeight)
  local gridOutlineRadius = 0.52
  local outlinePos = pos
  local outlineDir = Vector2(0, 0)
  if outlineDirType == OutlineDirType.Up then
    outlinePos = pos + Vector2(0, gridOutlineRadius)
    outlineDir = Vector2(0, 1)
  elseif outlineDirType == OutlineDirType.Down then
    outlinePos = pos + Vector2(0, -gridOutlineRadius)
    outlineDir = Vector2(0, -1)
  elseif outlineDirType == OutlineDirType.Left then
    outlinePos = pos + Vector2(-gridOutlineRadius, 0)
    outlineDir = Vector2(-1, 0)
  elseif outlineDirType == OutlineDirType.Right then
    outlinePos = pos + Vector2(gridOutlineRadius, 0)
    outlineDir = Vector2(1, 0)
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local locationPos = boardServiceRender:GridPosition2LocationPos(outlinePos, outlineEntity)
  local locationDir = boardServiceRender:GridDir2LocationDir(outlineDir)
  if renderHeight then
    locationPos.y = renderHeight
  end
  local location = outlineEntity:Location()
  if location then
    location:SetPosition(locationPos)
    location:SetDirection(locationDir)
  else
    Log.fatal("### LocationComponent nil")
  end
  local tranRenderSvc = self._world:GetService("TransformRenderer")
  tranRenderSvc:SetEntityLocation(outlineEntity, locationPos, locationDir)
end

function PreviewChainAttackRangeSystem_Render:_DestroyChainSkillRange()
  local renderBattleService = self._world:GetService("RenderBattle")
  renderBattleService:ClearChainSkillPreviewRenderData()
end

function PreviewChainAttackRangeSystem_Render:_CreateSingleEntitySnipeEffect(preViewIndex, entityList)
  local effectSrv = self._world:GetService("Effect")
  for i, id in ipairs(entityList) do
    if not self.previewChainSkillRangeCmpt:HasSnipeEffect(id) then
      local entity = self._world:GetEntityByID(id)
      if entity then
        local effectEntity = effectSrv:CreateEffect(BattleConst.ChainSkillSnipeEffectID, entity, false)
        self.previewChainSkillRangeCmpt:AddSnipeEffect(id, effectEntity)
      else
        Log.fatal("_CreateSingleEntitySnipeEffect failed,holder is null")
      end
    end
    self.previewChainSkillRangeCmpt:AddChainSkillSingleEntityDic(preViewIndex, id)
  end
end

function PreviewChainAttackRangeSystem_Render:_AddAddHPPet(previewIndex, petEntity)
  self.previewChainSkillRangeCmpt:AddChainSkillAddHPPetDic(previewIndex, petEntity:GetID())
end

function PreviewChainAttackRangeSystem_Render:_AddPetPreviewTypeByPreviewIndex(previewIndex, previewType)
  self.previewChainSkillRangeCmpt:SetPreviewTypeByPreviewIndex(previewIndex, previewType)
end
