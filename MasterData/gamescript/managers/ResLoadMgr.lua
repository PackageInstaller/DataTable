local CsObject = typeof(CS.UnityEngine.Object)
local CsSprite = typeof(CS.UnityEngine.Sprite)
local CsVideoClip = typeof(CS.UnityEngine.Video.VideoClip)
local CsMaterial = typeof(CS.UnityEngine.Material)
local ResLoadMgr = System.NewClass("ResLoadMgr", Component)
local ResPathMap = ArtResMap

local function GetFinalResPath(originPath)
  local newPath = ResPathMap[originPath]
  if newPath then
    return newPath
  end
  newPath = originPath
  return newPath
end

ResLoadMgr.target2agent = {}
ResLoadMgr.pathCountMap = {}
ResLoadMgr.persistentFontSet = {}
ResLoadMgr.agentList = {}
local invalidResMap, using_resVersion

function ResLoadMgr.Init()
end

function ResLoadMgr.GetLoadAgent(target)
  local agent = ResLoadMgr.target2agent[target]
  if not agent then
    agent = table.remove(ResLoadMgr.agentList) or CS.ResourceManager.LoadAgent()
    ResLoadMgr.target2agent[target] = agent
  end
  return agent
end

function ResLoadMgr.GetResCSType(assetType)
  local targetType = assetType
  local csType = CsObject
  if "png" == targetType then
    csType = CsSprite
  elseif "video" == targetType then
    csType = CsVideoClip
  elseif "mat" == targetType then
    csType = CsMaterial
  else
    csType = CsObject
  end
  return csType
end

function ResLoadMgr._DbgGetFontRefCnt(path)
  local ok, cnt = pcall(function()
    local info = CS.ResourceManager.Runtime.Impl.LoadGlobal.loadManager:GM_GetTextAsset(path)
    return info and string.match(info, "refCnt=(%-?%d+)")
  end)
  if ok and cnt then
    return cnt
  end
  return "?"
end

function ResLoadMgr.DbgDumpPersistentFonts()
  print("[TmpPersistent] ===== 常驻字体清单 =====")
  local n = 0
  for p in pairs(ResLoadMgr.persistentFontSet) do
    n = n + 1
    print(string.format("[TmpPersistent] #%d refCnt=%s path=%s", n, ResLoadMgr._DbgGetFontRefCnt(p), p))
  end
  print(string.format("[TmpPersistent] ===== 合计 %d 个 =====", n))
end

function ResLoadMgr.LoadAsset(path, target, assetType)
  if not path then
    return
  end
  if ApplicationUtils.is_editor_mode() and string.startswith(path, "Assets/ArtRes/") then
    error("LoadAsset路径配置错误==配置表或者代码中的路径，请把前面的Assets/ArtRes/去掉，路径=", path)
    return
  end
  path = GetFinalResPath(path)
  assert(target and type(target) == "table", "ResLoadMgr.LoadAsset need table target")
  if nil == assetType then
    local fileExName = path:sub((path:lastindexof(".") or 0) + 1)
    local targetType = fileExName
    if "bytes" == targetType or "txt" == targetType then
      do return ResLoadMgr.LoadFileData, path end
      return ResLoadMgr.LoadFileData, path, targetType, nil, nil, nil
    end
    assetType = ResLoadMgr.GetResCSType(targetType)
  end
  local loadAgent = ResLoadMgr.GetLoadAgent(target)
  local csType = assetType
  local countMap = ResLoadMgr.pathCountMap[target] or {}
  ResLoadMgr.pathCountMap[target] = countMap
  countMap[path] = (countMap[path] or 0) + 1
  local ret, asset = pcall(loadAgent.LoadAsset, loadAgent, path, csType)
  if not ret then
    pcall(ResLoadMgr.CheckInvalidAsset, path)
  end
  return asset
end

function ResLoadMgr.CheckInvalidAsset(path)
  if ApplicationUtils.is_editor_mode() then
    return
  end
  path = GetFinalResPath(path)
  invalidResMap = invalidResMap or {}
  if invalidResMap[path] then
    return
  end
  invalidResMap[path] = true
  using_resVersion = using_resVersion or Utils.GetQZCurResVersion()
  local E = require("ejoysdk_lua.ejoysdk")
  local storage_data = E and E.Sysinfo and E.Sysinfo.get_storage_info() or nil
  local free_size = storage_data and storage_data.internal_available_storage_size or -1
  local ret, bytes = pcall(CS.Framework.AssetLoadUtil.LoadTextData, "artres/" .. string.lower(path) .. ".ab", true)
  if not ret or not bytes then
    local str = string.format("资源不存在：%s  存储空间大小:%s  轻舟资源：%s", path, free_size, using_resVersion or "")
    Logger.ReportApusInfo("[ResLoadMgr_AssetCheck]{info}", str)
  else
    local md5 = SdkMgr.MD5Sumhexa(bytes)
    local str = string.format("资源存在，但是可能损坏：%s  md5:%s 存储空间大小:%s  轻舟资源：%s", path, md5 or "", free_size, using_resVersion or "")
    Logger.ReportApusInfo("[ResLoadMgr_AssetCheck]{info}", str)
  end
end

function ResLoadMgr.UnloadAsset(path, target)
  if not path then
    return
  end
  path = GetFinalResPath(path)
  local loadAgent = ResLoadMgr.target2agent[target]
  if not loadAgent then
    return
  end
  loadAgent:UnLoadAsset(path)
end

function ResLoadMgr.LoadAssetAsync(path, target, callback, assetType)
  assert(target and type(target) == "table", "ResLoadMgr.LoadAsset need table target")
  
  local function cb(asset)
    if callback then
      callback(asset)
    end
  end
  
  if ApplicationUtils.is_editor_mode() and string.startswith(path, "Assets/ArtRes/") then
    error("LoadAssetAsync路径配置错误==配置表或者代码中的路径，请把前面的Assets/ArtRes/去掉，路径=", path)
    cb(nil)
    return
  end
  path = GetFinalResPath(path)
  local csFinishCb = CS.Framework.AssetLoadUtil.GetLoadFinishCall(cb)
  local loadAgent = ResLoadMgr.GetLoadAgent(target)
  if nil == assetType then
    local fileExName = path:sub((path:lastindexof(".") or 0) + 1)
    local targetType = fileExName
    if "bytes" == targetType or "txt" == targetType then
      do return ResLoadMgr.LoadFileData, path end
      return ResLoadMgr.LoadFileData, path, targetType
    end
    assetType = ResLoadMgr.GetResCSType(targetType)
  end
  do return loadAgent.LoadAssetAsync, loadAgent, path, assetType end
  return loadAgent.LoadAssetAsync, loadAgent, path, assetType, csFinishCb
end

function ResLoadMgr.LoadFileData(path, dataType)
  if "bytes" == dataType then
    do return CS.Framework.AssetLoadUtil.LoadByteData, path end
    return CS.Framework.AssetLoadUtil.LoadByteData, path, true
  else
    do return CS.Framework.AssetLoadUtil.LoadTextData, path end
    return CS.Framework.AssetLoadUtil.LoadTextData, path, true
  end
end

function ResLoadMgr.UnloadAssetByTarget(target)
  local agent = ResLoadMgr.target2agent[target]
  if agent then
    agent:Free(true)
    ResLoadMgr.target2agent[target] = nil
    table.insert(ResLoadMgr.agentList, agent)
    ResLoadMgr.pathCountMap[target] = nil
  end
end

function ResLoadMgr.SubRef(assetPath, target, unloadImmeditely)
  assetPath = GetFinalResPath(assetPath)
  if nil == unloadImmeditely then
    unloadImmeditely = true
  end
  CS.ResourceManager.ResMgrExtend.SubRef(assetPath, unloadImmeditely)
  local countMap = ResLoadMgr.pathCountMap[target] or {}
  ResLoadMgr.pathCountMap[target] = countMap
  countMap[assetPath] = (countMap[assetPath] or 0) - 1
  if 0 == countMap[assetPath] then
    countMap[assetPath] = nil
  end
end

function ResLoadMgr.PrintUnloadTarget()
  for target, value in pairs(ResLoadMgr.target2agent) do
    Logger.Info("[ResLoadMgr]当前未卸载target", target.__name)
    local countMap = ResLoadMgr.pathCountMap[target]
    for path, count in pairs(countMap or {}) do
      Logger.Info("[ResLoadMgr]----当前未卸载资源", path, count)
    end
  end
end

function ResLoadMgr.UnloadNoRefAssets()
  CS.Framework.AssetLoadUtil.UnloadNoRefAssets()
end

function ResLoadMgr.LoadScene(sceneName, modeType)
  CS.Framework.AssetLoadUtil.LoadScene(sceneName, modeType)
end

function ResLoadMgr.UnLoadScene(sceneName)
  CS.Framework.AssetLoadUtil.UnLoadScene(sceneName)
end

function ResLoadMgr.LoadSceneAsync(sceneName, modeType, callBack)
  CS.Framework.AssetLoadUtil.LoadSceneAsync(sceneName, modeType, callBack)
end

return ResLoadMgr
