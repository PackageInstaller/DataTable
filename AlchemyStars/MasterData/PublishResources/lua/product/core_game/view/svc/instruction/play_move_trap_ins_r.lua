require("base_ins_r")
_class("PlayMoveTrapInstruction", BaseInstruction)
PlayMoveTrapInstruction = PlayMoveTrapInstruction

function PlayMoveTrapInstruction:Constructor(paramList)
  self._visible = true
  local str = paramList.disappearLegacyAnimNames
  self._disappearLegacyAnimNames = string.split(str, "|")
  self._disappearEffID = tonumber(paramList.disappearEffID)
  self._moveDelayTime = tonumber(paramList.moveDelayTime) or 0
  str = paramList.appearLegacyAnimNames
  self._appearLegacyAnimNames = string.split(str, "|")
  self._appearEffID = tonumber(paramList.appearEffID)
end

function PlayMoveTrapInstruction:GetCacheResource()
  local t = {}
  if self._disappearEffID and self._disappearEffID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._disappearEffID].ResPath,
      1
    })
  end
  if self._appearEffID and 0 < self._appearEffID then
    table.insert(t, {
      Cfg.cfg_effect[self._appearEffID].ResPath,
      1
    })
  end
  return t
end

function PlayMoveTrapInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MoveTrap)
  if not resultArray or table.count(resultArray) == 0 then
    return
  end
  local playBuffSvc = world:GetService("PlayBuff")
  for _, result in ipairs(resultArray) do
    local entity = world:GetEntityByID(result:GetEntityID())
    if entity then
      self:_DoTrapDisappear(entity)
      if 0 < self._moveDelayTime then
        YIELD(TT, self._moveDelayTime)
      end
      local gridWorldPos = result:GetPosNew()
      entity:SetPosition(gridWorldPos)
      if self._visible then
        entity:SetViewVisible(self._visible)
      end
      self:_DoTrapAppear(entity)
    end
    local replaceTrap = world:GetEntityByID(result:GetReplaceTrapEntityID())
    if replaceTrap then
      local trapServiceRender = world:GetService("TrapRender")
      trapServiceRender:PlayTrapDieSkill(TT, {replaceTrap})
    end
    local NTMoveTrap = NTMoveTrap:New()
    playBuffSvc:PlayBuffView(TT, NTMoveTrap)
  end
end

function PlayMoveTrapInstruction:_DoTrapDisappear(entity)
  if self._disappearEffID then
    local world = entity:GetOwnerWorld()
    local boardSvc = world:GetService("BoardRender")
    local pos = boardSvc:GetRealEntityGridPos(entity)
    local effectSvc = world:GetService("Effect")
    effectSvc:CreateWorldPositionEffect(self._disappearEffID, pos)
  end
  if self._disappearLegacyAnimNames == nil then
    Log.fatal("Legacy animation params is nil!")
    return
  end
  if not entity:HasView() then
    return
  end
  local go = entity:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  if table.count(self._disappearLegacyAnimNames) > 1 then
    anim:Stop()
    for i = 1, #self._disappearLegacyAnimNames do
      anim:PlayQueued(self._disappearLegacyAnimNames[i])
    end
  else
    anim:Play(self._disappearLegacyAnimNames[1])
  end
end

function PlayMoveTrapInstruction:_DoTrapAppear(entity)
  if self._appearLegacyAnimNames then
    if not entity:HasView() then
      return
    end
    local go = entity:View():GetGameObject()
    local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
    if anim == nil then
      Log.fatal("Cant play legacy animation, animation not found in ", go.name)
      return
    end
    if table.count(self._appearLegacyAnimNames) > 1 then
      anim:Stop()
      for i = 1, #self._appearLegacyAnimNames do
        anim:PlayQueued(self._appearLegacyAnimNames[i])
      end
    else
      anim:Play(self._appearLegacyAnimNames[1])
    end
  end
  if self._appearEffID then
    local world = entity:GetOwnerWorld()
    local boardSvc = world:GetService("BoardRender")
    local pos = boardSvc:GetRealEntityGridPos(entity)
    local effectSvc = world:GetService("Effect")
    effectSvc:CreateWorldPositionEffect(self._appearEffID, pos)
  end
end
