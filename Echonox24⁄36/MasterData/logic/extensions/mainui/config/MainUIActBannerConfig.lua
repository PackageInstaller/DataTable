-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/config/MainUIActBannerConfig.lua

module("logic.extensions.mainui.config.MainUIActBannerConfig", package.seeall)

local M = class("MainUIActBannerConfig", BaseConfig)

function M:onInit()
	self._const = {}
end

function M:getNames()
	return {
		ConfigName.MainUIActBanner
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.MainUIActBanner then
		self._const = content
	end
end

function M:getConfigList()
	return self._const
end

M.instance = M.New()

return M
