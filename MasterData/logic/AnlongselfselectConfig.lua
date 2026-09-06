-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/config/AnlongselfselectConfig.lua

module("logic.extensions.anlongselfselect.config.AnlongselfselectConfig", package.seeall)

local AnlongselfselectConfig = class("AnlongselfselectConfig", BaseConfig)

function AnlongselfselectConfig:onInit()
	return
end

function AnlongselfselectConfig:getNames()
	return {
		"self_select",
		"self_select_pack",
		"self_select_option"
	}
end

function AnlongselfselectConfig:handleConfig(name, content)
	if name == "self_select" then
		self._self_select = content
	elseif name == "self_select_pack" then
		self._self_select_pack = content
	elseif name == "self_select_option" then
		self._self_select_option = content
	end
end

function AnlongselfselectConfig:getActCfg(actId)
	return self._self_select[actId]
end

function AnlongselfselectConfig:getPackCfgs(actId)
	return self._self_select_pack[actId]
end

function AnlongselfselectConfig:getOptionCfgs(actId, packId)
	local temp = self._self_select_option[actId]
	local list = {}

	for k, v in pairs(temp) do
		if v.packId == packId then
			table.insert(list, v)
		end
	end

	return list
end

AnlongselfselectConfig.instance = AnlongselfselectConfig.New()

return AnlongselfselectConfig
