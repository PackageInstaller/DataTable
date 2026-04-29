require("base_ins_r")
_class("PlayMultiTractionInstruction", BaseInstruction)
PlayMultiTractionInstruction = PlayMultiTractionInstruction

function PlayMultiTractionInstruction:Constructor(paramList)
  self._targetEffectID = tonumber(paramList.targetEffectID) or 0
  self._moveSpeed = paramList.moveSpeed or BattleConst.TractionSpeed
end

function PlayMultiTractionInstruction:GetCacheResource()
  local t = {}
  if self._targetEffectID and self._targetEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._targetEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayMultiTractionInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.MultiTraction)
  if not result then
    return
  end
  local taskIDs = {}
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local entityRenderService = world:GetService("RenderEntity")
  local pieceService = world:GetService("Piece")
  local teamTractionData, teamEntity
  local array = result:GetResultArray()
  for _, info in ipairs(array) do
    local entity = world:GetEntityByID(info.entityID)
    if entity then
      if info.beginPos ~= info.finalPos then
        if self._targetEffectID > 0 then
          effectService:CreateEffect(self._targetEffectID, entity)
        end
        local currentPos = boardServiceRender:GetRealEntityGridPos(entity)
        local playSkillSvc = world:GetService("PlaySkill")
        playSkillSvc:SetTargetDirection(entity, info.finalPos - currentPos)
        entity:SetAnimatorControllerBools({
          [BattleConst.DefaultMovementAnimatorBool] = true
        })
        local gridPos = boardServiceRender:GetRealEntityGridPos(entity)
        entity:AddGridMove(self._moveSpeed, info.finalPos, gridPos)
        entityRenderService:DestroyMonsterAreaOutLineEntity(entity)
        pieceService:RefreshMonsterPiece(entity, true)
        local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._CheckMoveFinish, self, entity)
        table.insert(taskIDs, taskID)
        if entity:HasTeam() then
          teamTractionData = info
          teamEntity = entity
          local supply = result:GetSupplyPlayerPiece()
          if supply then
            boardServiceRender:ReCreateGridEntity(supply.color, info.beginPos)
            local svcPlayBuff = world:GetService("PlayBuff")
            svcPlayBuff:_SendNTGridConvertRender(TT, info.beginPos, supply.color, SkillEffectType.MultiTraction)
            local colorNew = result:GetColorNew()
            boardServiceRender:ReCreateGridEntity(colorNew, info.finalPos)
          end
        end
      end
      local svcPlayBuff = self._world:GetService("PlayBuff")
      svcPlayBuff:PlayBuffView(TT, NTTractionEnd:New(casterEntity, entity, info.beginPos, info.finalPos))
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
  if teamTractionData then
    local posOld = teamTractionData.beginPos
    local posNew = teamTractionData.finalPos
    local pets = teamEntity:Team():GetTeamPetEntities()
    for i, petEntity in ipairs(pets) do
      petEntity:SetLocation(posNew)
    end
    teamEntity:SetLocation(posNew)
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:CanChangePieceToGray() then
      boardServiceRender:ReCreateGridEntity(PieceType.None, posNew)
    end
  end
  if self._targetEffectID > 0 then
    effectService:DestroyEffectByID(self._targetEffectID)
  end
  local trapServiceRender = world:GetService("TrapRender")
  for _, info in ipairs(array) do
    local entity = world:GetEntityByID(info.entityID)
    if entity and info.beginPos ~= info.finalPos then
      local listTrapTrigger = info:GetTriggerTraps()
      trapServiceRender:PlayTrapTriggerSkillTasks(TT, listTrapTrigger, false, entity)
    end
  end
  return
end

function PlayMultiTractionInstruction:_CheckMoveFinish(TT, entity)
  while entity:HasGridMove() do
    YIELD(TT)
  end
  local world = entity:GetOwnerWorld()
  local trapServiceRender = world:GetService("TrapRender")
  local boardServiceRender = world:GetService("BoardRender")
  local pieceService = world:GetService("Piece")
  local realPos = boardServiceRender:GetRealEntityGridPos(entity)
  local entityRenderService = world:GetService("RenderEntity")
  pieceService:RefreshMonsterPiece(entity, false)
  entityRenderService:CreateMonsterAreaOutlineEntity(entity)
  trapServiceRender:ShowHideTrapAtPos(realPos, false)
  entity:SetAnimatorControllerBools({
    [BattleConst.DefaultMovementAnimatorBool] = false
  })
end
