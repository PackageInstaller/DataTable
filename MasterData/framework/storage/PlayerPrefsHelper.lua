-- chunkname: @framework/storage/PlayerPrefsHelper.lua

module("framework.storage.PlayerPrefsHelper", package.seeall)

local PlayerPrefsHelper = {}

PlayerPrefsHelper.FlushInterval = 0.1
PlayerPrefsHelper._keySet = {}
PlayerPrefsHelper._dict = {}
PlayerPrefsHelper._needFlushDict = {}
PlayerPrefsHelper._needFlush = false
PlayerPrefsHelper._needSave = false

function PlayerPrefsHelper.getNumber(key, defaultValue)
	return PlayerPrefsHelper._get(key, defaultValue, true)
end

function PlayerPrefsHelper.getString(key, defaultValue)
	return PlayerPrefsHelper._get(key, defaultValue, false)
end

function PlayerPrefsHelper.setNumber(key, value)
	PlayerPrefsHelper._set(key, tonumber(value))
end

function PlayerPrefsHelper.setString(key, value)
	PlayerPrefsHelper._set(key, tostring(value))
end

function PlayerPrefsHelper.hasKey(key)
	local hasKey = PlayerPrefsHelper._keySet[key]

	if hasKey ~= nil then
		return hasKey
	end

	hasKey = UnityEngine.PlayerPrefs.HasKey(key)
	PlayerPrefsHelper._keySet[key] = hasKey

	return hasKey
end

function PlayerPrefsHelper.deleteKey(key)
	local hasKey = PlayerPrefsHelper._keySet[key]

	if hasKey == false then
		return
	end

	PlayerPrefsHelper._keySet[key] = false
	PlayerPrefsHelper._dict[key] = nil
	PlayerPrefsHelper._needFlushDict[key] = nil

	UnityEngine.PlayerPrefs.DeleteKey(key)
end

function PlayerPrefsHelper.deleteAll()
	PlayerPrefsHelper._keySet = {}
	PlayerPrefsHelper._dict = {}
	PlayerPrefsHelper._needFlushDict = {}

	UnityEngine.PlayerPrefs.DeleteAll()
end

function PlayerPrefsHelper._get(key, defaultValue, numOrStr)
	if PlayerPrefsHelper._keySet[key] == true then
		if PlayerPrefsHelper._dict[key] == nil then
			PlayerPrefsHelper._dict[key] = numOrStr and UnityEngine.PlayerPrefs.GetFloat(key) or UnityEngine.PlayerPrefs.GetString(key)
			PlayerPrefsHelper._keySet[key] = true
		end

		return PlayerPrefsHelper._dict[key]
	elseif PlayerPrefsHelper._keySet[key] == nil then
		local hasKey = UnityEngine.PlayerPrefs.HasKey(key)

		if hasKey then
			local value = numOrStr and UnityEngine.PlayerPrefs.GetFloat(key) or UnityEngine.PlayerPrefs.GetString(key)

			PlayerPrefsHelper._dict[key] = value
			PlayerPrefsHelper._keySet[key] = true

			return value
		else
			PlayerPrefsHelper._keySet[key] = false

			return defaultValue
		end
	else
		return defaultValue
	end
end

function PlayerPrefsHelper._set(key, value)
	if value ~= nil then
		if PlayerPrefsHelper._dict[key] ~= value then
			PlayerPrefsHelper._dict[key] = value
			PlayerPrefsHelper._keySet[key] = true
			PlayerPrefsHelper._needFlushDict[key] = value

			if not PlayerPrefsHelper._needFlush then
				PlayerPrefsHelper._needFlush = true
				PlayerPrefsHelper._needSave = true

				TaskDispatcher.runDelay(PlayerPrefsHelper.flush, nil, PlayerPrefsHelper.FlushInterval)
			end
		end
	else
		logError("PlayerPrefsHelper._set error, value can't be nil, use deleteKey instead")
	end
end

function PlayerPrefsHelper.flush()
	if PlayerPrefsHelper._needFlush then
		PlayerPrefsHelper._needFlush = false

		for key, value in pairs(PlayerPrefsHelper._needFlushDict) do
			local numOrStr = type(value) == "number"

			if numOrStr then
				UnityEngine.PlayerPrefs.SetFloat(key, value)
			else
				UnityEngine.PlayerPrefs.SetString(key, value)
			end
		end

		PlayerPrefsHelper._needFlushDict = {}
	end
end

function PlayerPrefsHelper.save()
	if PlayerPrefsHelper._needSave then
		PlayerPrefsHelper._needSave = false

		UnityEngine.PlayerPrefs.Save()
	end
end

return PlayerPrefsHelper
