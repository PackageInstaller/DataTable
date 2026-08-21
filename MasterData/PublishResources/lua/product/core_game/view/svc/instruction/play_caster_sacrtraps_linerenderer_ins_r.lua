require("base_ins_r")
_class("PlayCasterSacrificeTrapsLineRendererInstruction", BaseInstruction)
PlayCasterSacrificeTrapsLineRendererInstruction = PlayCasterSacrificeTrapsLineRendererInstruction

function PlayCasterSacrificeTrapsLineRendererInstruction:Constructor(paramList)
  self._casterEffectID = tonumber(paramList.casterEffectID)
  self._lineCasterBindPos = paramList.lineCasterBindPos
  self._lineEffectID = tonumber(paramList.lineEffectID)
  self._lineEffectWaitTime = tonumber(paramList.lineEffectWaitTime)
  self._gridBindPos = paramList.gridBindPos or "spot"
  self._gridEffectID = tonumber(paramList.gridEffectID)
  self._gridEffectWaitTime = tonumber(paramList.gridEffectWaitTime)
  self._lineDuration = paramList.lineDuration
end

function PlayCasterSacrificeTrapsLineRendererInstruction:GetCacheResource()
  local t = {}
  if self._casterEffectID and self._casterEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._casterEffectID].ResPath,
      1
    })
  end
  if self._lineEffectID and 0 < self._lineEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._lineEffectID].ResPath,
      1
    })
  end
  if self._gridEffectID and 0 < self._gridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayCasterSacrificeTrapsLineRendererInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._casterEntity = casterEntity
  self._world = world
  local effectService = world:GetService("Effect")
  local casterEffectEntity = effectService:CreateEffect(self._casterEffectID, casterEntity)
  local targetRoot = GameObjectHelper.FindChild(casterEffectEntity:View().ViewWrapper.GameObject.transform, self._lineCasterBindPos)
  if not targetRoot then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SacrificeTraps)
  results = results or skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PetSacrificeSuperGridTraps)
  local result = results[1]
  if not result then
    Log.fatal("11111111111")
  end
  local trapIDs = result:GetTrapIDs()
  local taskIDList = {}
  local extraGrids
  if result.GetExtraGrids then
    extraGrids = result:GetExtraGrids()
  end
  local taskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayGridEffectAtTraps, self, trapIDs, extraGrids)
  table.insert(taskIDList, taskID)
  taskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayLineEffect, self, trapIDs, targetRoot, extraGrids)
  table.insert(taskIDList, taskID)
  while not TaskHelper:GetInstance():IsAllTaskFinished(self.taskIDList) do
    YIELD(TT)
  end
end

function PlayCasterSacrificeTrapsLineRendererInstruction:PlayLineEffect(TT, trapIDs, targetRoot, extraGrids)
  YIELD(TT, self._lineEffectWaitTime)
  local effectService = self._world:GetService("Effect")
  local pieceSvc = self._world:GetService("Piece")
  local tarPosList = {}
  for i, id in ipairs(trapIDs) do
    local trapEntity = self._world:GetEntityByID(id)
    local trapPos = trapEntity:GetGridPosition()
    table.insert(tarPosList, trapPos)
  end
  if extraGrids then
    for index, pos in ipairs(extraGrids) do
      table.insert(tarPosList, pos)
    end
  end
  for i, gridPos in ipairs(tarPosList) do
    local trapPos = gridPos
    local pieceEntity = pieceSvc:FindPieceEntity(trapPos)
    local linkLineEntity = self._gridEffectEntityList[i]
    local effectLineRenderer = linkLineEntity:EffectLineRenderer()
    local entityViewRoot = linkLineEntity:View().ViewWrapper.GameObject.transform
    local curRoot = GameObjectHelper.FindChild(entityViewRoot, self._gridBindPos)
    if not curRoot and EDITOR then
      Log.exception("Pos:", tostring(trapPos), " Grid no  :", self._gridBindPos)
    end
    if curRoot then
      if not effectLineRenderer then
        linkLineEntity:AddEffectLineRenderer()
        effectLineRenderer = linkLineEntity:EffectLineRenderer()
      end
      local effectHolderCmpt = linkLineEntity:EffectHolder()
      if not effectHolderCmpt then
        linkLineEntity:AddEffectHolder()
        effectHolderCmpt = linkLineEntity:EffectHolder()
      end
      local effectEntityIdList = effectHolderCmpt:GetEffectIDEntityDic()[self._lineEffectID]
      local effect
      if effectEntityIdList then
        effect = self._world:GetEntityByID(effectEntityIdList[1])
      end
      if not effect then
        effect = effectService:CreateEffect(self._lineEffectID, linkLineEntity)
        effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      end
      local go = effect:View():GetGameObject()
      local renderers
      renderers = go.transform:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      for i = 0, renderers.Length - 1 do
        local line = renderers[i]
        if line then
          line.gameObject:SetActive(true)
        end
      end
      effectLineRenderer:InitEffectLineRenderer(self._casterEntity:GetID(), curRoot, targetRoot, entityViewRoot, renderers, effect:GetID())
      effectLineRenderer:SetEffectLineRendererShow(self._casterEntity:GetID(), true)
    end
  end
end

function PlayCasterSacrificeTrapsLineRendererInstruction:PlayGridEffectAtTraps(TT, trapIDs, extraGrids)
  YIELD(TT, self._gridEffectWaitTime)
  self._gridEffectEntityList = {}
  local effectService = self._world:GetService("Effect")
  local pieceSvc = self._world:GetService("Piece")
  for i, id in ipairs(trapIDs) do
    local trapEntity = self._world:GetEntityByID(id)
    local effectLineRenderer = trapEntity:EffectLineRenderer()
    local trapPos = trapEntity:GetGridPosition()
    if trapPos then
      local entity = effectService:CreateCommonGridEffect(self._gridEffectID, trapPos)
      entity:SetViewVisible(true)
      table.insert(self._gridEffectEntityList, entity)
    end
  end
  if extraGrids then
    for index, pos in ipairs(extraGrids) do
      local entity = effectService:CreateCommonGridEffect(self._gridEffectID, pos)
      entity:SetViewVisible(true)
      table.insert(self._gridEffectEntityList, entity)
    end
  end
end
