---@class DPlayerPrefs
local DPlayerPrefs = class("DPlayerPrefs")

local PlayerPrefs = UnityEngine.PlayerPrefs

function DPlayerPrefs:ctor(name)
	self.name = name
end

function DPlayerPrefs:getRealKey(key)
	return string.format("%s_%s", self.name, key)
end

function DPlayerPrefs:SetInt(key, value)
	PlayerPrefs.SetInt(self:getRealKey(key), value)
	PlayerPrefs.Save()
end

function DPlayerPrefs:GetInt(key, defaultValue)
	return PlayerPrefs.GetInt(self:getRealKey(key), defaultValue or 0)
end

function DPlayerPrefs:SetBool(key, value)
	PlayerPrefs.SetInt(self:getRealKey(key), value and 1 or 0)
	PlayerPrefs.Save()
end

function DPlayerPrefs:GetBool(key, defaultValue)
	local def = defaultValue == true and 1 or 0
	return PlayerPrefs.GetInt(self:getRealKey(key), def) == 1 and true or false
end

function DPlayerPrefs:SetString(key, value)
	if value then
		PlayerPrefs.SetString(self:getRealKey(key), value)
		PlayerPrefs.Save()
	end
end

function DPlayerPrefs:GetString(key, defaultValue)
	-- LuaLogger.ws("GetString", self:getRealKey(key))
	return PlayerPrefs.GetString(self:getRealKey(key), defaultValue or "")
end

function DPlayerPrefs:HasKey(key)
	-- LuaLogger.ws("HasKey", self:getRealKey(key))
	return PlayerPrefs.HasKey(self:getRealKey(key))
end

return DPlayerPrefs