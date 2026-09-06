-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cakesign/config/CakeSignConfig.lua

module("logic.extensions.cakesign.config.CakeSignConfig", package.seeall)

local CakeSignConfig = class("CakeSignConfig", BaseConfig)

function CakeSignConfig:onInit()
	CakeSignConfig.super.onInit(self)
	self:onReset()
end

function CakeSignConfig:onReset()
	self._baseCfgs = nil
end

function CakeSignConfig:getNames()
	return {
		"cake_sign_in"
	}
end

function CakeSignConfig:handleConfig(name, content)
	if name == "cake_sign_in" then
		self._baseCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._baseCfgs[v.activityId] = self._baseCfgs[v.activityId] or {}

			table.insert(self._baseCfgs[v.activityId], v)
		end
	end
end

function CakeSignConfig:getActCfgsById(actId)
	if actId == nil or self._baseCfgs == nil then
		return
	end

	return self._baseCfgs[actId]
end

CakeSignConfig.instance = CakeSignConfig.New()

return CakeSignConfig
