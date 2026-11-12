local SpineManager = {}
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local mapInstance = {}
local nNextId = 1

local function LoadPrefab(sPath, panelId)
  if panelId == nil then
    panelId = "SpineManager"
  end
  prefab = GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Object), "UI", panelId)
  if prefab == nil then
    printError("[SpineManager] 加载预制体失败, path = " .. tostring(sPath))
    return nil
  end
  return prefab
end

local function GetSkeletonGraphic(go)
  if go == nil then
    return nil
  end
  local comp
  local trSkeleton = go.transform:Find("Skeleton")
  if trSkeleton ~= nil and trSkeleton:IsNull() == false then
    comp = trSkeleton:GetComponent("SkeletonGraphic")
  end
  if comp == nil then
    comp = go:GetComponent("SkeletonGraphic")
  end
  return comp
end

function SpineManager.Create(nId, trParent, panelId)
  local sPath = "Actor2D_Spine/" .. nId .. "/" .. nId .. ".prefab"
  local prefab = LoadPrefab(sPath, panelId)
  if prefab == nil then
    return nil
  end
  local go = instantiate(prefab, trParent)
  if go == nil then
    printError("[SpineManager] instantiate 失败, path = " .. tostring(sPath))
    return nil
  end
  return go
end

function SpineManager.Destroy(go)
  if go ~= nil and go:IsNull() == false then
    destroyImmediate(go)
  end
end

function SpineManager.ClearAll()
  GameResourceLoader.UnloadAsset("SpineManager")
end

function SpineManager.PlayAnim(go, sAnimName, bLoop, nTrackIndex)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return
  end
  nTrackIndex = nTrackIndex or 0
  NovaAPIHotfix.PlayAnim_Graphic(skel, nTrackIndex, sAnimName, bLoop == true)
end

function SpineManager.AddAnim(go, sAnimName, bLoop, fDelay, nTrackIndex)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return
  end
  nTrackIndex = nTrackIndex or 0
  fDelay = fDelay or 0
  NovaAPIHotfix.AddAnim_Graphic(skel, nTrackIndex, sAnimName, bLoop == true, fDelay)
end

function SpineManager.SetTimeScale(go, fScale)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return
  end
  if fScale == nil then
    fScale = 1
  end
  NovaAPIHotfix.SetTimeScale_Graphic(skel, fScale)
end

function SpineManager.GetTimeScale(go)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return 1
  end
  return NovaAPIHotfix.GetTimeScale_Graphic(skel)
end

function SpineManager.Pause(go)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return
  end
  NovaAPIHotfix.SetTimeScale_Graphic(skel, 0)
end

function SpineManager.Resume(go, fScale)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return
  end
  NovaAPIHotfix.SetTimeScale_Graphic(skel, fScale or 1)
end

function SpineManager.IsPaused(go)
  return SpineManager.GetTimeScale(go) == 0
end

function SpineManager.GetAnimDuration(go, sAnimName)
  local skel = GetSkeletonGraphic(go)
  if skel == nil then
    return 0
  end
  if sAnimName == nil or sAnimName == "" then
    return 0
  end
  local Duration = NovaAPIHotfix.GetAnimDuration(skel, sAnimName)
  if Duration == 0 then
    printError(string.format("[SpineManager] GetAnimDuration: 找不到动画 %s", tostring(sAnimName)))
  end
  return Duration
end

return SpineManager
