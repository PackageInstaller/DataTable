_class("EffectLineRendererSystem_Render", Object)
EffectLineRendererSystem_Render = EffectLineRendererSystem_Render

function EffectLineRendererSystem_Render:Constructor(world)
  self._world = world
  self._group = world:GetGroup(world.BW_WEMatchers.EffectLineRenderer)
end

function EffectLineRendererSystem_Render:Filter(entity)
  return entity:HasEffectLineRenderer()
end

function EffectLineRendererSystem_Render:Execute()
  self:ExecuteEntities(self._group:GetEntities())
end

function EffectLineRendererSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:_OnRefreshLineRenderer(entities[i])
  end
end

function EffectLineRendererSystem_Render:_OnRefreshLineRenderer(entity)
  if not entity:IsViewVisible() then
    return
  end
  local effectLineRenderer = entity:EffectLineRenderer()
  local isShow = effectLineRenderer:GetEffectLineRendererIsShow()
  if not isShow then
    return
  end
  local curRootList = effectLineRenderer:GetEffectLineRendererCurrent()
  local targetRootList = effectLineRenderer:GetEffectLineRendererTarget()
  local entityViewRootList = effectLineRenderer:GetEffectLineRendererEntityViewRoot()
  local renderersList = effectLineRenderer:GetEffectLineRendererEffect()
  local ignoreEntityViewRootPos = effectLineRenderer:GetIgnoreEntityViewRootPos()
  local targetRootOff = effectLineRenderer:GetTargetRootOff()
  local currentRootOff = effectLineRenderer:GetCurrentRootOff()
  if table.count(renderersList) == 0 or table.count(entityViewRootList) == 0 then
    return
  end
  for i = 1, table.count(renderersList) do
    local curRoot = curRootList[i]
    local targetRoot = targetRootList[i]
    local entityViewRoot = entityViewRootList[i]
    local renderers = renderersList[i]
    if tolua.isnull(curRoot) or tolua.isnull(targetRoot) or tolua.isnull(entityViewRoot) or tolua.isnull(renderers) then
      return
    end
    local change = effectLineRenderer:OnCheckEffectPos(entity:GetID(), curRoot.position, targetRoot.position, entityViewRoot.position)
    if not change then
      return
    end
    local currentPos, targetPos
    if ignoreEntityViewRootPos then
      currentPos = curRoot.position
      targetPos = targetRoot.position
    else
      currentPos = curRoot.position - entityViewRoot.position
      targetPos = targetRoot.position - entityViewRoot.position
    end
    if targetRootOff then
      targetPos = targetPos + targetRootOff
    end
    if currentRootOff then
      currentPos = currentPos + currentRootOff
    end
    for i = 0, renderers.Length - 1 do
      local line = renderers[i]
      if line then
        line:SetPosition(0, currentPos)
        line:SetPosition(1, targetPos)
      end
    end
  end
end
