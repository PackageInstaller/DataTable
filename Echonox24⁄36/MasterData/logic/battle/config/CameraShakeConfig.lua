-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/CameraShakeConfig.lua

module("logic.battle.config.CameraShakeConfig", package.seeall)

local CameraShakeConfig = class("CameraShakeConfig", BaseConfig)

function CameraShakeConfig:onInit()
	self._cfgInfo = false
end

function CameraShakeConfig:getNames()
	return {
		ConfigName.CameraShake
	}
end

function CameraShakeConfig:handleConfig(name, content)
	if name == ConfigName.CameraShake then
		self._cfgInfo = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function CameraShakeConfig:getCameraShakeCO(code)
	local videoCO = self._cfgInfo[code]

	if code > 0 and not videoCO and enableErrorLog then
		printError(string.format("CameraShakeConfig::cannot find shake config for code[%s]", code))
	end

	return videoCO
end

CameraShakeConfig.instance = CameraShakeConfig.New()

return CameraShakeConfig
