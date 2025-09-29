-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/LightConfig.lua

module("logic.battle.config.LightConfig", package.seeall)

local LightConfig = class("LightConfig", BaseConfig)

function LightConfig:onInit()
	self._cfgLight = false
end

function LightConfig:getNames()
	return {
		ConfigName.Light
	}
end

function LightConfig:handleConfig(name, content)
	if name == ConfigName.Light then
		self._cfgLight = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function LightConfig:getLightCO(code)
	local lightCO = self._cfgLight[code]

	if code > 0 and not lightCO and BattleLog.enableError then
		BattleLog.error(string.format("LightConfig::cannot find effect config for code[%s]", code))
	end

	return lightCO
end

LightConfig.instance = LightConfig.New()

return LightConfig
