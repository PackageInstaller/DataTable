local BattleCameraDataUtils = {}
local HASH_MOD = 2147483647
local LEGACY_VM_CACHE_PREFIX = "Camera"
local LEGACY_BATTLE_VM_PREFIX = "CameraBk"

function BattleCameraDataUtils.HashString(str)
  if not str or "" == str then
    return 0
  end
  local h = 0
  for i = 1, #str do
    h = (h * 131 + string.byte(str, i)) % HASH_MOD
  end
  return h
end

function BattleCameraDataUtils.GetBattleKey(data)
  if not data then
    return 0
  end
  local battleUid = data.battleUid
  if battleUid and 0 ~= battleUid then
    return tonumber(battleUid) or 0
  end
  local battleUuid = data.battleUuid
  if nil == battleUuid or "" == battleUuid then
    return 0
  end
  local n = tonumber(battleUuid)
  if n then
    return n
  end
  do return BattleCameraDataUtils.HashString, tostring(battleUuid) end
  return BattleCameraDataUtils.HashString, tostring(battleUuid)
end

function BattleCameraDataUtils.IsSameBattle(a, b)
  if not a or not b then
    return false
  end
  if a.battleUuid ~= nil and b.battleUuid ~= nil and a.battleUuid == b.battleUuid then
    return true
  end
  if nil ~= a.battleUid and nil ~= b.battleUid and a.battleUid == b.battleUid then
    return true
  end
  local keyA = BattleCameraDataUtils.GetBattleKey(a)
  local keyB = BattleCameraDataUtils.GetBattleKey(b)
  return 0 ~= keyA and keyA == keyB
end

function BattleCameraDataUtils.IsSameBattleAsCurrent(data)
  if not (bg and bg.battleData) or not data then
    return false
  end
  do return BattleCameraDataUtils.IsSameBattle, data end
  return BattleCameraDataUtils.IsSameBattle, data, bg.battleData
end

function BattleCameraDataUtils.CameraNameToId(cameraName)
  if not cameraName or "" == cameraName then
    return 0
  end
  do return BattleCameraDataUtils.HashString end
  return BattleCameraDataUtils.HashString, cameraName
end

function BattleCameraDataUtils.FindCameraNameById(sceneHelper, cameraId)
  if not cameraId or 0 == cameraId then
    return nil
  end
  if not (sceneHelper and sceneHelper.virtualCameraRoot) or IsNil(sceneHelper.virtualCameraRoot) then
    return nil
  end
  local root = sceneHelper.virtualCameraRoot.transform
  for i = 0, root.childCount - 1 do
    local child = root:GetChild(i)
    if child and BattleCameraDataUtils.CameraNameToId(child.name) == cameraId then
      return child.name
    end
  end
  return nil
end

function BattleCameraDataUtils.GetLegacyEngineCacheKey()
  if bg and bg.battleRender and bg.battleRender.battleEngineUuid then
    return LEGACY_VM_CACHE_PREFIX .. bg.battleRender.battleEngineUuid
  end
end

function BattleCameraDataUtils.GetLegacyBattleCacheKey(battleKey)
  if battleKey and 0 ~= battleKey then
    return LEGACY_BATTLE_VM_PREFIX .. battleKey
  end
end

function BattleCameraDataUtils.IsLegacyCameraCacheKey(key)
  if type(key) ~= "string" then
    return false
  end
  if string.sub(key, 1, #LEGACY_BATTLE_VM_PREFIX) == LEGACY_BATTLE_VM_PREFIX then
    return #key > #LEGACY_BATTLE_VM_PREFIX
  end
  if string.sub(key, 1, #LEGACY_VM_CACHE_PREFIX) == LEGACY_VM_CACHE_PREFIX then
    return #key > #LEGACY_VM_CACHE_PREFIX
  end
  return false
end

function BattleCameraDataUtils.RemoveLocalFileKey(key)
  if not key then
    return
  end
  local mgr = MobileFileDataManager.Instance
  if mgr.commFileInfo and mgr.commFileInfo.data and mgr.commFileInfo.data[key] ~= nil then
    mgr:SetCommFileValue(key, nil, false)
  end
  if mgr.fileInfo and mgr.fileInfo.data and nil ~= mgr.fileInfo.data[key] then
    mgr:SetPlayerFileValue(key, nil, false)
  end
end

function BattleCameraDataUtils.ForEachLegacyCameraCacheKey(callback)
  if not callback then
    return
  end
  
  local function walk(fileData)
    if not fileData or not fileData.data then
      return
    end
    for k, _ in pairs(fileData.data) do
      if BattleCameraDataUtils.IsLegacyCameraCacheKey(k) then
        callback(k)
      end
    end
  end
  
  local mgr = MobileFileDataManager.Instance
  if mgr.commFileInfo then
    walk(mgr.commFileInfo)
  end
  if mgr.fileInfo then
    walk(mgr.fileInfo)
  end
end

function BattleCameraDataUtils.IsServerCameraReadyForBattleKey(battleKey)
  if not battleKey or 0 == battleKey then
    return false
  end
  local savedKey = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleKey, 0)
  if savedKey ~= battleKey then
    return false
  end
  return 0 ~= ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleCameraId, 0)
end

function BattleCameraDataUtils.TryCleanupLegacyLocalForBattle(battleKey)
  if not BattleCameraDataUtils.IsServerCameraReadyForBattleKey(battleKey) then
    return
  end
  BattleCameraDataUtils.RemoveLocalFileKey(BattleCameraDataUtils.GetLegacyBattleCacheKey(battleKey))
  BattleCameraDataUtils.RemoveLocalFileKey(BattleCameraDataUtils.GetLegacyEngineCacheKey())
end

function BattleCameraDataUtils.PruneLegacyLocalOnNewBattle(curKey)
  if not curKey or 0 == curKey then
    return
  end
  local keepBk = BattleCameraDataUtils.GetLegacyBattleCacheKey(curKey)
  BattleCameraDataUtils.ForEachLegacyCameraCacheKey(function(k)
    if k == keepBk then
      return
    end
    BattleCameraDataUtils.RemoveLocalFileKey(k)
  end)
  local mgr = MobileFileDataManager.Instance
  if mgr.commFileInfo and mgr.commFileInfo.dirty then
    mgr:OnSaveCommInfo()
  end
  if mgr.fileInfo and mgr.fileInfo.dirty then
    mgr:OnSavePlayerFileInfo()
  end
end

function BattleCameraDataUtils.PruneAllLegacyLocalWhenIdle()
  if DataCenter.barrierData.InBattle then
    return
  end
  local savedKey = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleKey, 0)
  if 0 == savedKey or not BattleCameraDataUtils.IsServerCameraReadyForBattleKey(savedKey) then
    return
  end
  BattleCameraDataUtils.ForEachLegacyCameraCacheKey(function(k)
    BattleCameraDataUtils.RemoveLocalFileKey(k)
  end)
  local mgr = MobileFileDataManager.Instance
  if mgr.commFileInfo and mgr.commFileInfo.dirty then
    mgr:OnSaveCommInfo()
  end
  if mgr.fileInfo and mgr.fileInfo.dirty then
    mgr:OnSavePlayerFileInfo()
  end
end

function BattleCameraDataUtils.OnLeaveBattle()
  BattleCameraDataUtils.PruneAllLegacyLocalWhenIdle()
end

function BattleCameraDataUtils.GetSavedCameraNameFromServer(sceneHelper)
  if not bg or not bg.battleData then
    return nil
  end
  local curKey = BattleCameraDataUtils.GetBattleKey(bg.battleData)
  local savedKey = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleKey, 0)
  if 0 == curKey or 0 == savedKey or curKey ~= savedKey then
    return nil
  end
  local cameraId = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleCameraId, 0)
  do return BattleCameraDataUtils.FindCameraNameById, sceneHelper end
  return BattleCameraDataUtils.FindCameraNameById, sceneHelper, cameraId
end

function BattleCameraDataUtils.GetSavedCameraName(sceneHelper)
  if not sceneHelper or bg and bg.isPVP then
    return nil
  end
  local fromServer = BattleCameraDataUtils.GetSavedCameraNameFromServer(sceneHelper)
  if fromServer and sceneHelper:IsCameraValid(fromServer) then
    return fromServer
  end
  return nil
end

function BattleCameraDataUtils.SaveCamera(cameraName)
  if not bg or not bg.battleData then
    return
  end
  local battleKey = BattleCameraDataUtils.GetBattleKey(bg.battleData)
  if 0 == battleKey then
    return
  end
  local cameraId = BattleCameraDataUtils.CameraNameToId(cameraName) or 0
  if 0 == cameraId then
    ClientDataUtils.DelData(cd.ClientDataMainKey.Client, cd.ClientSubKey.LastBattleKey, false)
    ClientDataUtils.DelData(cd.ClientDataMainKey.Client, cd.ClientSubKey.LastBattleCameraId, true)
    BattleCameraDataUtils.TryCleanupLegacyLocalForBattle(battleKey)
    return
  end
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.LastBattleKey, battleKey, false)
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.LastBattleCameraId, cameraId, true)
  BattleCameraDataUtils.TryCleanupLegacyLocalForBattle(battleKey)
end

function BattleCameraDataUtils.ClearSavedCamera(isSave)
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.LastBattleKey, 0, false)
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.LastBattleCameraId, 0, false ~= isSave)
end

function BattleCameraDataUtils.OnBattleInit(battleData)
  if not battleData then
    return
  end
  local curKey = BattleCameraDataUtils.GetBattleKey(battleData)
  local savedKey = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LastBattleKey, 0)
  if 0 ~= savedKey and 0 ~= curKey and savedKey ~= curKey then
    BattleCameraDataUtils.ClearSavedCamera(true)
    BattleCameraDataUtils.PruneLegacyLocalOnNewBattle(curKey)
  end
end

function BattleCameraDataUtils.RefreshStatusUIPosition()
  if bg.battleScene and bg.battleScene.UpdateRootHpAndRootIntentionPosition then
    bg.battleScene:UpdateRootHpAndRootIntentionPosition()
  end
end

function BattleCameraDataUtils.TryApplySavedCamera(sceneHelper)
  if not (sceneHelper and bg and bg.battleScene) or bg.isPVP then
    return false
  end
  local cameraName = BattleCameraDataUtils.GetSavedCameraName(sceneHelper)
  if not cameraName or not sceneHelper:IsCameraValid(cameraName) then
    return false
  end
  bg.battleScene.battleCameraScheme = cameraName
  bg.battleScene:ChangeDefaultVMCamera(cameraName)
  BattleCameraDataUtils.RefreshStatusUIPosition()
  return true
end

return BattleCameraDataUtils
