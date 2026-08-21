require("base_ins_r")
_class("PlaySpliceBoardInstruction", BaseInstruction)
PlaySpliceBoardInstruction = PlaySpliceBoardInstruction

function PlaySpliceBoardInstruction:Constructor(paramList)
  self._moveRootName = "BoardCenter"
  self._moveTime = tonumber(paramList.moveTime) or 1000
  self._startWaitTime = tonumber(paramList.startWaitTime) or 0
  self._startEffectID = tonumber(paramList.startEffectID)
  self._rotateEffectID = tonumber(paramList.rotateEffectID)
  self._completeEffectID = tonumber(paramList.completeEffectID)
  self._glowEffectID1 = tonumber(paramList.glowEffectID1)
  self._glowEffectID2 = tonumber(paramList.glowEffectID2)
  local trapIDList = paramList.trapIDList
  self._trapIDList = {}
  if trapIDList then
    local arr = string.split(trapIDList, "|")
    for k, idStr in ipairs(arr) do
      local trapID = tonumber(idStr)
      table.insert(self._trapIDList, trapID)
    end
  end
  local playDieSkillTrapIDList = paramList.playDieSkillTrapIDList
  self._playDieSkillTrapIDList = {}
  if playDieSkillTrapIDList then
    local arr = string.split(playDieSkillTrapIDList, "|")
    for k, idStr in ipairs(arr) do
      local trapID = tonumber(idStr)
      table.insert(self._playDieSkillTrapIDList, trapID)
    end
  end
end

function PlaySpliceBoardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SpliceBoard)
  if resultArray == nil then
    Log.fatal("PlaySpliceBoardInstruction, result is nil.")
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  local pieceService = world:GetService("Piece")
  local boardServiceRender = world:GetService("BoardRender")
  local playBuffService = world:GetService("PlayBuff")
  local renderEntityService = world:GetService("RenderEntity")
  local effectService = world:GetService("Effect")
  local trapServiceRender = world:GetService("TrapRender")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardComponent = renderBoardEntity:RenderBoard()
  local renderBoardSpliceComponent = renderBoardEntity:RenderBoardSplice()
  local previewEnvComponent = world:GetPreviewEntity():PreviewEnv()
  local moveRoot = UnityEngine.GameObject.Find(self._moveRootName)
  moveRoot = moveRoot or UnityEngine.GameObject:New(self._moveRootName)
  for _, resultSpliceBoard in ipairs(resultArray) do
    local result = resultSpliceBoard
    local distance, direction = result:GetMoveParam()
    local entityResult = result:GetMoveEntities()
    local prismResult = result:GetSpliceBoardPrisms()
    local convertResult = result:GetConvertColors()
    local spliceResult = result:GetSpliceBoardGrid()
    local spliceOnlyPlayDarkResult = result:GetSpliceBoardOnlyPlayDark()
    local notifyStartTrapEntityID = result:GetNotifyStartTrapEntityID()
    local notifyStartTrapEntity = world:GetEntityByID(notifyStartTrapEntityID)
    local notifyEndTrapEntityID = result:GetNotifyEndTrapEntityID()
    local notifyEndTrapEntity = world:GetEntityByID(notifyEndTrapEntityID)
    local destroyTrapList = result:GetDestroyTrapList()
    local isDieSkillDisabled = true
    for _, entityID in ipairs(destroyTrapList) do
      local tarpEntity = world:GetEntityByID(entityID)
      isDieSkillDisabled = false
      trapServiceRender:PlayTrapDieSkill(TT, {tarpEntity}, false)
      local trapID = tarpEntity:TrapID():GetTrapID()
      if table.icontains(self._playDieSkillTrapIDList, trapID) then
        local trapRenderComponent = tarpEntity:TrapRender()
        local aurasEntityList = trapRenderComponent:GetAllAurasEntity()
        if aurasEntityList then
          for i, id in ipairs(aurasEntityList) do
            local aurasEntity = world:GetEntityByID(id)
            world:DestroyEntity(aurasEntity)
          end
        end
        local entities = world:GetGroupEntities(world.BW_WEMatchers.TrapAurasOutline)
        if entities then
          for i, e in ipairs(entities) do
            if not e:HasDeadMark() and not e:HasDeadFlag() then
              e:ReplaceTrapAurasOutline()
            end
          end
        end
      end
    end
    if 0 < distance then
      local arrPiece = {}
      local allEntity = {}
      for i, r in ipairs(convertResult) do
        local oldPos, newPos, pieceType, isAddGrid, isRemoveGrid = r[1], r[2], r[3], r[4], r[5]
        local pieceEntity = pieceService:FindPieceEntity(oldPos)
        if pieceEntity then
          local t = {
            pieceEntity,
            oldPos,
            newPos
          }
          allEntity[#allEntity + 1] = t
        end
      end
      for i, r in ipairs(entityResult) do
        local eid, oldPos, newPos = table.unpack(r)
        local e = world:GetEntityByID(eid)
        if e then
          local t = {
            e,
            oldPos,
            newPos
          }
          allEntity[#allEntity + 1] = t
        end
      end
      for i, v in ipairs(allEntity) do
        local e = v[1]
        local oldPos = v[2]
        local newPos = v[3]
        if e:HasView() then
          local entityTransform = e:View():GetGameObject().transform
          entityTransform.parent = moveRoot.transform
        end
        if e:HasMonsterID() then
          renderEntityService:DestroyMonsterAreaOutLineEntity(e)
        elseif e:HasTrapID() then
          if e:HasTrapRoundInfoRender() then
            local eid = e:TrapRoundInfoRender():GetRoundInfoEntityID()
            if eid then
              local eff = world:GetEntityByID(eid)
              local entityTransform = eff:View():GetGameObject().transform
              entityTransform.parent = moveRoot.transform
            end
          end
          local cEffectHolder = e:EffectHolder()
          if cEffectHolder then
            local effectList = cEffectHolder:GetIdleEffect()
            if 0 < table.count(effectList) then
              for i, eff in ipairs(effectList) do
                local effectEntity = world:GetEntityByID(eff)
                if effectEntity and effectEntity:HasView() then
                  local curGridPos = boardServiceRender:GetRealEntityGridPos(effectEntity)
                  local newGridPos = curGridPos + direction
                  local entityTransform = effectEntity:View():GetGameObject().transform
                  entityTransform.parent = moveRoot.transform
                end
              end
            end
          end
          local trapRenderComponent = e:TrapRender()
          if trapRenderComponent then
            local aurasEntityList = trapRenderComponent:GetAllAurasEntity()
            if aurasEntityList then
              for i, id in ipairs(aurasEntityList) do
                local aurasEntity = world:GetEntityByID(id)
                local entityTransform = aurasEntity:View():GetGameObject().transform
                entityTransform.parent = moveRoot.transform
              end
            end
          end
        end
        if e:HasMonsterID() or e:HasTeam() then
          self:_ShowMonsterHPBar(e, false)
        end
      end
      local targetMovePos = moveRoot.transform.position + Vector3(direction.x * distance, 0, direction.y * distance)
      moveRoot.transform:DOMove(targetMovePos, self._moveTime / 1000)
      if notifyStartTrapEntity then
        local ntSpliceBoard = NTSpliceBoardBegin:New(notifyStartTrapEntity)
        playBuffService:PlayBuffView(TT, ntSpliceBoard)
      end
      local cameraPos, boardCenter
      if direction == Vector2(1, 0) then
        cameraPos = Vector3(27, 28, -21)
        boardCenter = Vector3(2.5, 0, 3.5)
      elseif direction == Vector2(0, -1) then
        cameraPos = Vector3(25, 25.2, -21)
        boardCenter = Vector3(2.5, 0, 0.5)
      elseif direction == Vector2(-1, 0) then
        cameraPos = Vector3(22, 25, -21)
        boardCenter = Vector3(-0.5, 0, 0.5)
      elseif direction == Vector2(0, 1) then
        cameraPos = Vector3(23, 27, -20)
        boardCenter = Vector3(-0.5, 0, 3.5)
      end
      local mainCameraCmpt = world:MainCamera()
      local mainCamera = mainCameraCmpt:Camera()
      local cameraTran = mainCamera.transform
      cameraTran:DOMove(cameraPos, self._moveTime / 1000.0, false)
      YIELD(TT, self._moveTime)
      local mainCameraCmpt = world:MainCamera()
      mainCameraCmpt:SetCameraPos(cameraPos)
      local battleRenderCmpt = world:BattleRenderConfig()
      battleRenderCmpt:SetCurWaveBoardCenter(boardCenter)
      local monsterGroup = world:GetGroup(world.BW_WEMatchers.HP)
      for _, e in ipairs(monsterGroup:GetEntities()) do
        local hpComponent = e:HP()
        if e:IsViewVisible() and hpComponent then
          hpComponent:SetHPPosDirty(true)
        end
      end
      for i, r in ipairs(entityResult) do
        local eid, oldPos, newPos = table.unpack(r)
        local e = world:GetEntityByID(eid)
        if e then
          if e:HasView() then
            local entityTransform = e:View():GetGameObject().transform
            entityTransform.parent = nil
          end
          e:SetPosition(newPos)
          if e:HasMonsterID() then
            renderEntityService:CreateMonsterAreaOutlineEntity(e)
          end
          if e:HasMonsterID() or e:HasTeam() then
            self:_ShowMonsterHPBar(e, true)
          end
          if e:HasTeam() then
            local petList = e:Team():GetTeamPetEntities()
            for k, pet in pairs(petList) do
              pet:SetPosition(newPos)
            end
          end
        end
      end
      local notRefreshPrism = true
      for i, r in ipairs(convertResult) do
        local oldPos, newPos, pieceType, isAddGrid, isRemoveGrid = r[1], r[2], r[3], r[4], r[5]
        local pieceEntity = renderBoardComponent:GetGridRenderEntity(oldPos)
        if pieceEntity then
          if pieceEntity:HasView() then
            local entityTransform = pieceEntity:View():GetGameObject().transform
            entityTransform.parent = nil
          end
          pieceEntity:SetPosition(newPos)
          renderBoardComponent:SetGridRenderEntityData(newPos, pieceEntity)
        end
        if isAddGrid then
        end
        if isRemoveGrid then
        end
        local newGridEntity = boardServiceRender:ReCreateGridEntity(pieceType, newPos, false, false, notRefreshPrism)
        previewEnvComponent:SetPieceType(newPos, pieceType)
      end
      for _, r in pairs(prismResult) do
        local oldPos, newPos, pieceEffectType = r[1], r[2], r[3]
        pieceService:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
        pieceService:SetPieceRenderEffect(newPos, pieceEffectType)
      end
      self:PlaySpliceResult(spliceResult, world)
    else
      self:PlaySpliceResult(spliceResult, world)
      for _, pos in ipairs(spliceOnlyPlayDarkResult) do
        local newGridFakeEntity = pieceService:FindPieceFakeEntity(pos)
        if newGridFakeEntity then
          pieceService:SetPieceFakeEntityAnimDark(newGridFakeEntity)
        end
      end
    end
    if notifyEndTrapEntity then
      local ntSpliceBoard = NTSpliceBoardEnd:New(notifyEndTrapEntity)
      playBuffService:PlayBuffView(TT, ntSpliceBoard)
    end
    YIELD(TT)
  end
  YIELD(TT)
end

function PlaySpliceBoardInstruction:_ShowMonsterHPBar(monsterEntity, isShow)
  local cHP = monsterEntity:HP()
  if not cHP then
    return
  end
  cHP:SetShowHPSliderState(isShow)
  monsterEntity:ReplaceHPComponent()
end

function PlaySpliceBoardInstruction:PlaySpliceResult(spliceResult, world)
  local pieceService = world:GetService("Piece")
  local boardServiceRender = world:GetService("BoardRender")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local renderBoardComponent = renderBoardEntity:RenderBoard()
  local renderBoardSpliceComponent = renderBoardEntity:RenderBoardSplice()
  local previewEnvComponent = world:GetPreviewEntity():PreviewEnv()
  for i, r in ipairs(spliceResult) do
    local pos, isAddGrid, isRemoveGrid, pieceType, isPrism, pieceEffectType = r[1], r[2], r[3], r[4], r[5], r[6]
    local pieceEntity = pieceService:FindPieceEntity(pos)
    local pieceFakeEntity = pieceService:FindPieceFakeEntity(pos)
    if isAddGrid == true then
      local newGridEntity
      if not pieceEntity then
        newGridEntity = boardServiceRender:CreateGridEntity(pieceType, pos, false, pieceEffectType)
      else
        local pieceComponent = pieceEntity:Piece()
        pieceComponent:SetRenderPieceEffectType(pieceEffectType)
        newGridEntity = boardServiceRender:ReCreateGridEntity(pieceType, pos, false)
      end
      if isPrism then
        pieceService:SetPieceEntityAnimNormal(newGridEntity)
      end
      renderBoardComponent:SetGridRenderEntityData(pos, newGridEntity)
      previewEnvComponent:SetPieceType(pos, pieceType)
      if pieceFakeEntity then
        world:DestroyEntity(pieceFakeEntity)
      end
    end
    if isRemoveGrid == true then
      local newGridFakeEntity = boardServiceRender:CreateGridFakeEntity(pieceType, pos, pieceEffectType)
      pieceService:SetPieceFakeEntityAnimDark(newGridFakeEntity)
      renderBoardComponent:SetGridRenderEntityData(pos, nil)
      previewEnvComponent:SetPieceType(pos, nil)
      if pieceEntity then
        world:DestroyEntity(pieceEntity)
      end
    end
  end
end
