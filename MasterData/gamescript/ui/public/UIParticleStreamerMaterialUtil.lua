local UIParticleStreamerMaterialUtil = {}
local T_Material = typeof(CS.UnityEngine.Material)
local T_Renderer = typeof(CS.UnityEngine.Renderer)
local T_ParticleSystem = typeof(CS.UnityEngine.ParticleSystem)

function UIParticleStreamerMaterialUtil._IsolateRendererSharedMaterials(renderer)
  if not renderer then
    return
  end
  local mats = renderer.sharedMaterials
  if not mats or mats.Length <= 0 then
    return
  end
  local len = mats.Length
  local arr = CS.System.Array.CreateInstance(T_Material, len)
  local any = false
  for j = 0, len - 1 do
    local src = mats[j]
    if src then
      arr[j] = CS.UnityEngine.Material(src)
      any = true
    end
  end
  if any then
    renderer.sharedMaterials = arr
  end
end

function UIParticleStreamerMaterialUtil.TryIsolateStreamerGroup(streamerGroupGo)
  if not streamerGroupGo then
    return
  end
  local psArr = streamerGroupGo:GetComponentsInChildren(T_ParticleSystem, true)
  if not psArr or psArr.Length <= 0 then
    return
  end
  for i = 0, psArr.Length - 1 do
    local ps = psArr[i]
    if ps then
      local r = ps.gameObject:GetComponent(T_Renderer)
      UIParticleStreamerMaterialUtil._IsolateRendererSharedMaterials(r)
    end
  end
end

return UIParticleStreamerMaterialUtil
