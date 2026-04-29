require("base_ins_r")
_class("PlayAquaGronruEffectInstruction", BaseInstruction)
PlayAquaGronruEffectInstruction = PlayAquaGronruEffectInstruction

function PlayAquaGronruEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._lineEffectID = tonumber(paramList.lineEffectID)
end

function PlayAquaGronruEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local casterRenderPos = casterEntity:GetPosition()
  local effectService = world:GetService("Effect")
  local effectEntity = effectService:CreatePositionEffect(self._effectID, casterRenderPos)
  local csgo = effectEntity:View():GetGameObject()
  local water = GameObjectHelper.FindChild(csgo.transform, "water")
  if not water or tostring(water) == "null" then
    return
  end
  local csRenderer = water.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  if not csRenderer then
    return
  end
  local v4 = Vector4.zero
  v4.x = casterRenderPos.x
  v4.y = casterRenderPos.y
  v4.z = casterRenderPos.z
  csRenderer.sharedMaterial:SetVector("_Location_xyz", v4)
  if not self._lineEffectID then
    return
  end
  local lineEffect = effectService:CreatePositionEffect(self._lineEffectID, casterRenderPos)
  local csLineGO = lineEffect:View():GetGameObject()
  local line = GameObjectHelper.FindChild(csLineGO.transform, "line")
  if not line or tostring(line) == "null" then
    return
  end
  local csLineRenderer = line.gameObject:GetComponent(typeof(UnityEngine.MeshRenderer))
  if not csLineRenderer then
    return
  end
  csLineRenderer.sharedMaterial:SetVector("_Location_xyz", v4)
end

function PlayAquaGronruEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._lineEffectID and 0 < self._lineEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._lineEffectID].ResPath,
      1
    })
  end
  return t
end
