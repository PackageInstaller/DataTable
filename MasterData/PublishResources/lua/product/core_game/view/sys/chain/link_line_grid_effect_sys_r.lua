_class("LinkLineGridEffectSystem_Render", ReactiveSystem)
LinkLineGridEffectSystem_Render = LinkLineGridEffectSystem_Render

function LinkLineGridEffectSystem_Render:Constructor(world)
  self.world = world
  self._lineMpb = UnityEngine.MaterialPropertyBlock:New()
  self._lineColorIntensityStart = 1
  self._lineColorIntensityEnd = 2
  self._baseColorDicLine = {}
end

function LinkLineGridEffectSystem_Render:GetTrigger(world)
  local eGroup = world:GetGroup(world.BW_WEMatchers.GridEffect)
  local vGroup = world:GetGroup(world.BW_WEMatchers.View)
  local c = Collector:New({eGroup, vGroup}, {"Added", "Added"})
  return c
end

function LinkLineGridEffectSystem_Render:Filter(entity)
  return entity:HasGridEffect() and entity:HasView()
end

function LinkLineGridEffectSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function LinkLineGridEffectSystem_Render:HandleEntity(e)
  local linkLineGridType = e:GridEffect():GetGridEffectType()
  local baseColorDic, mbp
  local colorIntensityStart = 0
  local colorIntensityEnd = 0
  if linkLineGridType == "LinkLine" then
    baseColorDic = self._baseColorDicLine
    mbp = self._lineMpb
    colorIntensityStart = self._lineColorIntensityStart
    colorIntensityEnd = self._lineColorIntensityEnd
  else
    return
  end
  local renderer = e:View():GetGameObject():GetComponentInChildren(typeof(UnityEngine.Renderer))
  if not renderer then
    return
  end
  local pieceType = e:GridEffect():GetPieceType()
  if not pieceType then
    return
  end
  local baseColor = baseColorDic[pieceType]
  if not baseColor then
    baseColor = renderer.sharedMaterial:GetVector("_MainColor")
    baseColorDic[pieceType] = baseColor
  end
  local utilData = self.world:GetService("UtilData")
  local superChainCount = utilData:GetCurrentTeamSuperChainCount()
  local t = e:GridEffect():GetPathIndex() - 2
  local max = superChainCount - 1
  if t > max then
    t = max
  end
  if 0 < t then
    local res = Mathf.Lerp(colorIntensityStart, colorIntensityEnd, t / max)
    local resColor = baseColor * (1 + res)
    resColor.w = baseColor.w
    mbp:SetVector("_MainColor", resColor)
    renderer:SetPropertyBlock(mbp)
  end
end
