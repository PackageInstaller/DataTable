local ClientData = DataCenter.clientData
local ClientDataUtils = {}
local _DirtyKeys = {}

function ClientDataUtils.ResetAll()
  ClientData.AllData = Vue.reactive({})
  _DirtyKeys = {}
end

function ClientDataUtils.GetAllData()
  return ClientData.AllData
end

function ClientDataUtils.GetData(mainKey, subKey, defaultValue)
  local data = ClientData.AllData[mainKey]
  return data and data[tostring(subKey)] or defaultValue
end

function ClientDataUtils.SetData(mainKey, subKey, value, isSave)
  subKey = tostring(subKey)
  local data = ClientData.AllData[mainKey] or {}
  local preValue = data[subKey]
  if value == preValue then
    return
  end
  data[subKey] = value
  ClientData.AllData[mainKey] = data
  if not _DirtyKeys[mainKey] then
    _DirtyKeys[mainKey] = {}
  end
  _DirtyKeys[mainKey][subKey] = true
  if nil == isSave or isSave then
    ClientDataUtils.ReqSaveClientData(mainKey)
  end
end

function ClientDataUtils.GetClientSubData(subKey, defaultValue)
  local mainKey = cd.ClientDataMainKey.Client
  do return ClientDataUtils.GetData, mainKey, subKey end
  return ClientDataUtils.GetData, mainKey, subKey, defaultValue
end

function ClientDataUtils.SetClientSubData(subKey, value, isSave)
  local mainKey = cd.ClientDataMainKey.Client
  ClientDataUtils.SetData(mainKey, subKey, value, isSave)
end

function ClientDataUtils.GetSubTable(mainKey)
  return ClientData.AllData[mainKey]
end

function ClientDataUtils.DelData(mainKey, subKey, isSave)
  subKey = tostring(subKey)
  local data = ClientData.AllData[mainKey]
  if not data or nil == data[subKey] then
    return
  end
  data[subKey] = nil
  if _DirtyKeys[mainKey] then
    _DirtyKeys[mainKey][subKey] = nil
    if nil == next(_DirtyKeys[mainKey]) then
      _DirtyKeys[mainKey] = nil
    end
  end
  if nil == isSave or isSave then
    ClientDataUtils.ReqDelClientData(mainKey, {subKey}, false)
  end
end

function ClientDataUtils.DelSubKeys(mainKey, subKeys, isSave)
  if not subKeys or 0 == #subKeys then
    return
  end
  local data = ClientData.AllData[mainKey]
  if not data then
    return
  end
  local hasData = false
  for _, k in ipairs(subKeys) do
    k = tostring(k)
    if nil ~= data[k] then
      hasData = true
      break
    end
  end
  if not hasData then
    return
  end
  local keyList = {}
  for _, k in ipairs(subKeys) do
    k = tostring(k)
    if nil ~= data[k] then
      data[k] = nil
      table.insert(keyList, k)
      if _DirtyKeys[mainKey] then
        _DirtyKeys[mainKey][k] = nil
      end
    end
  end
  if _DirtyKeys[mainKey] and nil == next(_DirtyKeys[mainKey]) then
    _DirtyKeys[mainKey] = nil
  end
  if #keyList > 0 and (nil == isSave or isSave) then
    ClientDataUtils.ReqDelClientData(mainKey, keyList, false)
  end
end

function ClientDataUtils.DelMainKey(mainKey, isSave)
  if ClientData.AllData[mainKey] == nil then
    return
  end
  ClientData.AllData[mainKey] = nil
  _DirtyKeys[mainKey] = nil
  if nil == isSave or isSave then
    ClientDataUtils.ReqDelClientData(mainKey, nil, true)
  end
end

function ClientDataUtils.ReqDelClientData(mainKey, in_keys, del_main, callback)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  if 0 == playerUid then
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnDelClientData", function(data)
    Logger.Info("========== 请求删除客户端数据成功 ==========\n", mainKey, table.tostring(in_keys or {}), tostring(del_main))
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnClientDataChanged)
    EventMgr.Instance.OnClientDataChanged:Dispatch()
  end, function(data)
    Logger.Info("========== 请求删除客户端数据失败 ==========\n", table.tostring(data or {}))
  end, mainKey, in_keys, del_main and 1 or 0)
end

function ClientDataUtils.Print()
  print("-------------ClientDataUtils.Print", table.tostring(ClientData.AllData))
end

function ClientDataUtils.SetSubTable(mainKey, kvTbl, isSave)
  local allData = ClientDataUtils.GetAllData()
  allData[mainKey] = table.clone(kvTbl)
  if nil == isSave or isSave then
    _DirtyKeys[mainKey] = {}
    for k in pairs(kvTbl) do
      if "" ~= k then
        _DirtyKeys[mainKey][tostring(k)] = true
      end
    end
    ClientDataUtils.ReqSaveClientData(mainKey)
  else
    _DirtyKeys[mainKey] = nil
  end
end

function ClientDataUtils.ParseSvrData(svrData)
  local clientData = svrData.kvs
  for mainKey, kvsTbl in pairs(clientData) do
    ClientDataUtils.SetSubTable(mainKey, kvsTbl, false)
  end
end

function ClientDataUtils.ReqSaveClientData(mainKey, callback)
  local playerUid = PlayerDataUtils.GetPlayerUid()
  if 0 == playerUid then
    return
  end
  local dirty = _DirtyKeys[mainKey]
  if not dirty or next(dirty) == nil then
    if callback then
      callback()
    end
    return
  end
  local kvTbl = ClientDataUtils.GetSubTable(mainKey) or {}
  local saveTbl = {}
  local keysSent = {}
  for subKey, _ in pairs(dirty) do
    if "" ~= subKey and nil ~= kvTbl[subKey] then
      saveTbl[tostring(subKey)] = kvTbl[subKey]
      keysSent[subKey] = true
    end
  end
  if next(saveTbl) == nil then
    _DirtyKeys[mainKey] = nil
    if callback then
      callback()
    end
    return
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnSaveClientData", function(data)
    Logger.Info("========== 请求存储客户端数据成功 ==========\n", table.tostring(data or {}))
    local d = _DirtyKeys[mainKey]
    if d then
      for subKey, _ in pairs(keysSent) do
        d[subKey] = nil
      end
      if nil == next(d) then
        _DirtyKeys[mainKey] = nil
      end
    end
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnClientDataChanged)
    EventMgr.Instance.OnClientDataChanged:Dispatch()
  end, function(data)
    Logger.Info("========== 请求存储客户端数据失败 ==========\n", table.tostring(data or {}))
  end, mainKey, saveTbl)
end

function ClientDataUtils.ReqOpenClientData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenClientData", function(data)
    Logger.Info("========== 请求拉取客户端数据成功 ==========\n", table.tostring(data or {}))
    ClientDataUtils.ParseSvrData(data)
    if callback then
      callback()
    end
    ClientDataUtils.OnAfterGotClientData()
    GlobalDispatcher:Dispatch(NotifyId.OnClientDataInit)
    GlobalDispatcher:Dispatch(NotifyId.OnClientDataChanged)
    EventMgr.Instance.OnClientDataInit:Dispatch()
    EventMgr.Instance.OnClientDataChanged:Dispatch()
    PvpMatchModel.Instance:UpdateByClientData()
  end, function(data)
    Logger.Info("========== 请求拉取客户端数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function ClientDataUtils.OnAfterGotClientData()
  if SettingManager.Instance:IsAutoFight() then
    SettingManager.Instance:SetAutoFight(false)
  end
end

function ClientDataUtils.OnDayChanged()
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.PlayedSkinSummon, cd.NumberFalse, false)
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.CloseBestPromptToday, cd.NumberFalse, false)
  ClientDataUtils.ReqSaveClientData(cd.ClientDataMainKey.Client)
end

return ClientDataUtils
