-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/config/ChatConfig.lua

module("logic.extensions.chat.config.ChatConfig", package.seeall)

local M = class("ChatConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.ChatEmoji
	}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end
end

function M:getAllEmojiCfgs()
	return self._dict[ConfigName.ChatEmoji].dataList
end

function M:getEmojiCfg(id)
	local cfgs = self:getAllEmojiCfgs()

	for _, cfg in ipairs(cfgs) do
		if cfg.id == tonumber(id) then
			return cfg
		end
	end
end

M.instance = M.New()

return M
