_class("TrapViewAddSystem_Render", ReactiveSystem)
TrapViewAddSystem_Render = TrapViewAddSystem_Render

function TrapViewAddSystem_Render:Constructor(world)
  self._world = world
end

function TrapViewAddSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({group}, {"Added"})
  return c
end

function TrapViewAddSystem_Render:Filter(entity)
  if not entity:HasTrapID() then
    return false
  end
  local trapIDCmpt = entity:TrapID()
  local trapID = trapIDCmpt:GetTrapID()
  local cfg_trap = Cfg.cfg_trap[trapID]
  local shaderEffect = cfg_trap.ShaderEffect
  if shaderEffect then
    return true
  end
  return false
end

function TrapViewAddSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:OnTrapViewAdded(entities[i])
  end
end

function TrapViewAddSystem_Render:OnTrapViewAdded(trapEntity)
  local viewWrapper = trapEntity:View().ViewWrapper
  local matAnimMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(MaterialAnimation))
  if matAnimMonoCmpt then
    UnityEngine.Object.Destroy(matAnimMonoCmpt)
  end
  matAnimMonoCmpt = viewWrapper.GameObject:AddComponent(typeof(MaterialAnimation))
  trapEntity:RemoveMaterialAnimationComponent()
  local resServ = self._world.BW_Services.ResourcesPool
  local cfg_trap = Cfg.cfg_trap[trapEntity:TrapRender():GetTrapID()]
  local shaderEffect = cfg_trap.ShaderEffect
  if shaderEffect then
    local containerShaderEffect = resServ:LoadAsset(shaderEffect)
    if not containerShaderEffect then
      local respool = self._world.BW_Services.ResourcesPool
      respool:CacheAsset(shaderEffect, 1)
      containerShaderEffect = resServ:LoadAsset(shaderEffect)
    end
    trapEntity:AddMaterialAnimationComponent(containerShaderEffect, matAnimMonoCmpt)
  end
end
