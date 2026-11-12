local StarTowerSettingGate = {}
local objLevelData
local nSerial = 0
local objReadyOwner
local mapTransition = {}
local mapOwnerVersion = {}
local mapRequests = {}

function StarTowerSettingGate.Start(objData)
  EventManager.Remove("StarTowerSettingRequestFailed", StarTowerSettingGate, StarTowerSettingGate.OnRequestFailed)
  objLevelData = objData
  nSerial = nSerial + 1
  objReadyOwner = nil
  mapTransition = {}
  mapOwnerVersion = {}
  mapRequests = {}
  if objData ~= nil then
    EventManager.Add("StarTowerSettingRequestFailed", StarTowerSettingGate, StarTowerSettingGate.OnRequestFailed)
  end
end

function StarTowerSettingGate.Stop(objData)
  if objLevelData == objData then
    StarTowerSettingGate.Start(nil)
  end
end

function StarTowerSettingGate.Begin()
  nSerial = nSerial + 1
  objReadyOwner = nil
  return nSerial
end

function StarTowerSettingGate.Ready(objOwner, nExpectedSerial)
  if objLevelData ~= nil and nExpectedSerial == nSerial then
    objReadyOwner = objOwner
  end
end

function StarTowerSettingGate.ReadyAfter(objOwner, nExpectedSerial, nDuration)
  if objLevelData == nil then
    return
  end
  local nOwnerVersion = mapOwnerVersion[objOwner] or 0
  objOwner:AddTimer(1, nDuration, function()
    if (mapOwnerVersion[objOwner] or 0) == nOwnerVersion then
      StarTowerSettingGate.Ready(objOwner, nExpectedSerial)
    end
  end, true, true, true)
end

function StarTowerSettingGate.Transition(objOwner, nDuration)
  if objLevelData == nil then
    return
  end
  local mapToken = {}
  mapTransition[mapToken] = objOwner
  objOwner:AddTimer(1, nDuration, function()
    mapTransition[mapToken] = nil
  end, true, true, true)
end

function StarTowerSettingGate.Clear(objOwner)
  mapOwnerVersion[objOwner] = (mapOwnerVersion[objOwner] or 0) + 1
  if objReadyOwner == objOwner then
    StarTowerSettingGate.Begin()
  end
  for mapToken, objTransitionOwner in pairs(mapTransition) do
    if objTransitionOwner == objOwner then
      mapTransition[mapToken] = nil
    end
  end
end

function StarTowerSettingGate.ResumeAfterSetting()
  local objOwner = objReadyOwner
  if objLevelData == nil or objOwner == nil then
    return
  end
  local nExpectedSerial = StarTowerSettingGate.Begin()
  local nOwnerVersion = mapOwnerVersion[objOwner] or 0
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if (mapOwnerVersion[objOwner] or 0) == nOwnerVersion then
      StarTowerSettingGate.Ready(objOwner, nExpectedSerial)
    end
  end)
end

function StarTowerSettingGate.BeginRequest(failedCallback)
  StarTowerSettingGate.Begin()
  local mapToken = {failedCallback = failedCallback}
  if objLevelData ~= nil then
    mapRequests[mapToken] = nSerial
  end
  return mapToken
end

function StarTowerSettingGate.FinishRequest(mapToken)
  mapRequests[mapToken] = nil
end

function StarTowerSettingGate.OnRequestFailed(_, mapError)
  local mapOldestToken
  local nOldestSerial = math.huge
  for mapToken, nRequestSerial in pairs(mapRequests) do
    if nRequestSerial < nOldestSerial then
      mapOldestToken = mapToken
      nOldestSerial = nRequestSerial
    end
  end
  if mapOldestToken ~= nil then
    mapRequests[mapOldestToken] = nil
    StarTowerSettingGate.Begin()
    if mapOldestToken.failedCallback ~= nil then
      mapOldestToken.failedCallback(mapError)
    end
  end
end

function StarTowerSettingGate.CanOpen(objData)
  return objData ~= nil and objLevelData == objData and objReadyOwner ~= nil and next(mapTransition) == nil and next(mapRequests) == nil and objData.bEnd ~= true and not objData:IsAutoDecisionEnabled() and not objData:IsAutoDecisionBusy()
end

return StarTowerSettingGate
