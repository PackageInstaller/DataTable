-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/editorsetting/EditorDebugSetting.lua

module("logic.extensions.hacktool.editorsetting.EditorDebugSetting", package.seeall)

local EditorDebugSetting = {}

EditorDebugSetting.ENABLE_EDITOR_SYN_TICK = "Enable_Editor_SynTick"

local KEY = "EditorDebugSetting-0.0.1"
local settings = {}

local function loadConfig()
	settings = {}

	local settingString = Astral.LocalStorage.Instance:GetString(KEY, "")

	if not string.nilorempty(settingString) then
		local strArr = string.split(settingString, ";")

		for i = 1, #strArr do
			if not string.nilorempty(strArr[i]) then
				local itemArr = string.split(strArr[i], "=")

				settings[itemArr[1]] = itemArr[2]
			end
		end
	end
end

loadConfig()

function EditorDebugSetting.isEnableTick()
	if not isInEditorMode then
		return true
	end

	return EditorDebugSetting.getBoolValue(EditorDebugSetting.ENABLE_EDITOR_SYN_TICK)
end

function EditorDebugSetting.getBoolValue(key)
	return settings[key] == "True"
end

function EditorDebugSetting.getIntValue(key)
	return checkint(settings[key])
end

function EditorDebugSetting.getStringValue(key)
	return settings[key]
end

return EditorDebugSetting
