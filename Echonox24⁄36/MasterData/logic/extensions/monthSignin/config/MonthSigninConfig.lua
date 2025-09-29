-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/config/MonthSigninConfig.lua

module("logic.extensions.monthSignin.config.MonthSigninConfig", package.seeall)

local M = class("MonthSigninConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.MonthSignin
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.MonthSignin then
		self._list = content
	end
end

function M:getInfoById(id)
	return self._list[id]
end

M.instance = M.New()

return M
