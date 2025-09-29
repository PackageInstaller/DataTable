-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/config/CutImageConfig.lua

module("logic.extensions.characterdepot.config.CutImageConfig", package.seeall)

local M = class("CutImageConfig", BaseConfig)

function M:onInit()
	self._cfgClip = require("logic.config.roleclip.t_role_clip_info")

	self:_createClipCOs()
end

function M:getClipCO(modelCode)
	return self._dictClipCO[modelCode]
end

function M:_createClipCOs()
	self._dictClipCO = {}

	for _, cfg in ipairs(self._cfgClip.clipConfigs) do
		local co = RoleClipCO.New(cfg)

		self._dictClipCO[co:getModelCode()] = co
	end
end

M.instance = M.New()

return M
