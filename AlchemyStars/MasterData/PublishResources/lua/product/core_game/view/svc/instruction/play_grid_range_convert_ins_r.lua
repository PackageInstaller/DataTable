require("base_ins_r")
_class("PlayGridRangeConvertInstruction", BaseInstruction)
PlayGridRangeConvertInstruction = PlayGridRangeConvertInstruction

function PlayGridRangeConvertInstruction:Constructor(paramList)
  self._dataSource = tonumber(paramList.dataSource)
  self._dataSourceHigher = tonumber(paramList.dataSourceHigher)
  self._userData = 0
  if paramList.userData then
    self._userData = tonumber(paramList.userData)
  end
  self._setPieceViewShow = tonumber(paramList.setPieceViewShow)
end

function PlayGridRangeConvertInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    if EDITOR then
      Log.exception("No scopeGridRange")
    end
    return InstructionConst.PhaseEnd
  end
  local maxScopeRangeCount = phaseContext:GetMaxRangeCount()
  if not maxScopeRangeCount then
    if EDITOR then
      Log.exception("No maxScopeRangeCount")
    end
    return InstructionConst.PhaseEnd
  end
  local curScopeGridRangeIndex = phaseContext:GetCurScopeGridRangeIndex()
  if maxScopeRangeCount < curScopeGridRangeIndex then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local world = casterEntity:GetOwnerWorld()
  local pieceService = world:GetService("Piece")
  local svcPlayBuff = world:GetService("PlayBuff")
  local tConvertInfo = {}
  local notifyBuff = true
  for _, range in pairs(scopeGridRange) do
    if range then
      local posList = range[curScopeGridRangeIndex]
      if posList then
        for __, pos in pairs(posList) do
          local nOldGridType = PieceType.None
          local gridEntity = pieceService:FindPieceEntity(pos)
          if gridEntity then
            if self._setPieceViewShow == 1 then
              gridEntity:View():GetGameObject():SetActive(true)
            end
            local pieceCmpt = gridEntity:Piece()
            nOldGridType = pieceCmpt:GetPieceType()
            local nNewGridType
            local flushTraps = {}
            nNewGridType, flushTraps, notifyBuff = self:_GetConvertSkillResult(world, skillEffectResultContainer, pos, self._dataSource)
            if self._dataSourceHigher then
              local nNewGridTypeHigher = self:_GetConvertSkillResult(world, skillEffectResultContainer, pos, self._dataSourceHigher)
              if nNewGridTypeHigher then
                nNewGridType = nNewGridTypeHigher
              end
            end
            self:_Convert(world, pos, nNewGridType, flushTraps, casterEntity, TT)
            local convertInfo = NTGridConvert_ConvertInfo:New(pos, nOldGridType, nNewGridType)
            table.insert(tConvertInfo, convertInfo)
            local trapServiceRender = world:GetService("TrapRender")
            if SkillEffectType.ResetGridElement == self._dataSource then
              local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
              if skillResultArray then
                local trapEntityID = skillResultArray:GetSummontTrapEntityID(pos)
                if trapEntityID then
                  local trapEntity = world:GetEntityByID(trapEntityID)
                  if trapEntity then
                    trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
                  end
                end
              end
            end
            if SkillEffectType.AddGridEffect == self._dataSource then
              local skillResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.AddGridEffect)
              if skillResult then
                local trapEntityID = skillResult:GetSummontTrapEntityID(pos)
                if trapEntityID then
                  local trapEntity = world:GetEntityByID(trapEntityID)
                  if trapEntity then
                    trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
                  end
                end
              end
            end
            if SkillEffectType.ExChangeGridColor == self._dataSource then
              local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ExChangeGridColor)
              if skillResultArray then
                local trapEntityID = skillResultArray:GetSummonTrapEntityID(pos)
                if trapEntityID then
                  local trapEntity = world:GetEntityByID(trapEntityID)
                  if trapEntity then
                    trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
                  end
                end
              end
            end
            if SkillEffectType.ConvertOccupiedGridElement == self._dataSource then
              local skillResultArray = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.ConvertOccupiedGridElement)
              self:_ShowTrapAtPos_ConvertOccupiedGridElement(TT, world, skillResultArray, pos)
            end
          end
        end
      end
    end
  end
  if 0 < #tConvertInfo and notifyBuff then
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(self._dataSource)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
  if SkillEffectType.ExChangeGridColor == self._dataSource then
    local notify = NTExChangeGridColor:New()
    svcPlayBuff:PlayBuffView(TT, notify)
  end
end

function PlayGridRangeConvertInstruction:_GetConvertSkillResult(world, skillEffectResultContainer, pos, dataSource)
  local nNewGridType
  local flushTraps = {}
  local notifyBuff = true
  if 0 == dataSource then
    nNewGridType = self._userData or PieceType.None
  elseif SkillEffectType.ResetGridElement == dataSource then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
    if skillResultArray then
      nNewGridType = skillResultArray:FindGridDataNew(pos)
      flushTraps = skillResultArray:GetFlushTrapsAt(pos)
    end
  elseif SkillEffectType.AddGridEffect == dataSource then
    local skillResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.AddGridEffect)
    if skillResult then
      nNewGridType = skillResult:GetGridConvertType(pos)
    end
    if not nNewGridType then
      local utilDataSvc = world:GetService("UtilData")
      nNewGridType = utilDataSvc:GetPieceType(pos)
    end
  elseif SkillEffectType.ExChangeGridColor == dataSource then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ExChangeGridColor)
    if skillResultArray then
      nNewGridType = skillResultArray:FindGridData(pos)
    end
  elseif SkillEffectType.ResetSingleColorGridElement == dataSource then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetSingleColorGridElement)
    if skillResultArray then
      nNewGridType = skillResultArray:GetNewGridPieceType(pos)
      local trapIDList = skillResultArray:GetFlushTrapList()
      for _, v in ipairs(trapIDList) do
        local trapEntity = world:GetEntityByID(v)
        flushTraps[#flushTraps + 1] = trapEntity
      end
    end
  elseif SkillEffectType.ConvertGridElement == dataSource then
    local convertResult = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.ConvertGridElement)
    if convertResult then
      for _, result in ipairs(convertResult) do
        local gridArray = result:GetTargetGridArray()
        for __, v2 in ipairs(gridArray) do
          if v2 == pos then
            nNewGridType = result:GetTargetElementType()
            notifyBuff = result:GetNotifyBuff()
            break
          end
        end
      end
    end
  elseif SkillEffectType.ManualConvert == dataSource then
    local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ManualConvert)
    if convertResult then
      nNewGridType = convertResult:GetTargetElementType()
    end
  elseif SkillEffectType.ConvertOccupiedGridElement == dataSource then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.ConvertOccupiedGridElement)
    if skillResultArray and 0 < #skillResultArray then
      for i = 1, #skillResultArray do
        local skillResult = skillResultArray[i]
        nNewGridType = skillResult:GetNewGridPieceType(pos)
        if nNewGridType then
          break
        end
      end
    end
  end
  return nNewGridType, flushTraps, notifyBuff
end

function PlayGridRangeConvertInstruction:_Convert(world, gridPos, newGridType, flushTraps, casterEntity, TT)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:PlayTrapDieSkill(TT, flushTraps)
  for _, trap in ipairs(flushTraps) do
    trapServiceRender:DestroyTrap(TT, trap)
  end
  if newGridType and newGridType >= PieceType.None and newGridType <= PieceType.Any then
    local boardServiceR = world:GetService("BoardRender")
    local newGridEntity = boardServiceR:ReCreateGridEntity(newGridType, gridPos)
    if newGridEntity then
      local pieceSvc = world:GetService("Piece")
      pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
    end
  end
end

function PlayGridRangeConvertInstruction:_ShowTrapAtPos_ConvertOccupiedGridElement(TT, world, skillResultArray, pos)
  if skillResultArray and 0 < #skillResultArray then
    local trapServiceRender = world:GetService("TrapRender")
    for _, result in ipairs(skillResultArray) do
      local trapResults = result:GetTrapResults()
      for __, trapResult in ipairs(trapResults) do
        if pos == trapResult:GetPos() then
          local trapIDList = trapResult:GetTrapIDList()
          local eTrapList = {}
          for __, eidTrap in ipairs(trapIDList) do
            table.insert(eTrapList, world:GetEntityByID(eidTrap))
          end
          trapServiceRender:ShowTraps(TT, eTrapList, true)
        end
      end
    end
  end
end
