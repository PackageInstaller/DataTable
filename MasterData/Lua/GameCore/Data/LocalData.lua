local RapidJson = require("rapidjson")
local String = CS.System.String
local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local LocalData = {}

function LocalData.SetLocalData(sMainKey, sSubKey, sValue)
  local sJson = PlayerPrefs.GetString(sMainKey)
  local mapData
  if String.IsNullOrEmpty(sJson) == true then
    mapData = {}
    mapData[sSubKey] = sValue
  else
    mapData = RapidJson.decode(sJson)
    mapData[sSubKey] = sValue
  end
  sJson = RapidJson.encode(mapData)
  PlayerPrefs.SetString(sMainKey, sJson)
  PlayerPrefs.Save()
end

function LocalData.GetLocalData(sMainKey, sSubKey)
  local sJson = PlayerPrefs.GetString(sMainKey)
  if String.IsNullOrEmpty(sJson) == true then
    return nil
  else
    local mapData = RapidJson.decode(sJson)
    return mapData[sSubKey]
  end
end

function LocalData.DelLocalData(sMainKey, sSubKey)
  local sJson = PlayerPrefs.GetString(sMainKey)
  if String.IsNullOrEmpty(sJson) == false then
    local mapData = RapidJson.decode(sJson)
    mapData[sSubKey] = nil
    sJson = RapidJson.encode(mapData)
    PlayerPrefs.SetString(sMainKey, sJson)
    PlayerPrefs.Save()
  end
end

function LocalData.SetPlayerLocalData(sKey, sValue)
  local nPlayerId = PlayerData.Base:GetPlayerId()
  if type(nPlayerId) == "number" then
    LocalData.SetLocalData(tostring(nPlayerId), sKey, sValue)
  end
end

function LocalData.GetPlayerLocalData(sKey)
  local nPlayerId = PlayerData.Base:GetPlayerId()
  if type(nPlayerId) == "number" then
    return LocalData.GetLocalData(tostring(nPlayerId), sKey)
  end
end

function LocalData.DelPlayerLocalData(sKey)
  local nPlayerId = PlayerData.Base:GetPlayerId()
  if type(nPlayerId) == "number" then
    LocalData.DelLocalData(tostring(nPlayerId), sKey)
  end
end

return LocalData
