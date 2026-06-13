local PlayerPrefTools = {}

function PlayerPrefTools.SetPlayerPrefs(key, value)
    if type(key) ~= "string" then
        Logger.LogError("key just can be string ")
        return
    end
    local valueTypeName = type(value)
    if valueTypeName == "string" then
        GameHelper.SetPlayerPrefsStr(key, value)
    elseif valueTypeName == "number" then
        GameHelper.SetPlayerPrefsInt(key, value)
    end
end

function PlayerPrefTools.GetPlayerPrefsInt(key, defaultValue)
    if type(key) ~= "string" then
        Logger.LogError("key just can be string ")
        return
    end
    if defaultValue == nil then
        defaultValue = 0
    end
    return GameHelper.GetPlayerPrefsInt(key, defaultValue)
end

function PlayerPrefTools.GetPlayerPrefsString(key, defaultValue)
    if type(key) ~= "string" then
        Logger.LogError("key just can be string ")
        return
    end
    if defaultValue == nil then
        defaultValue = ""
    end
    return GameHelper.GetPlayerPrefsStr(key, defaultValue)
end

return PlayerPrefTools
