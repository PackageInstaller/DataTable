-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/config/ModelConfig.lua

module("logic.extensions.character.config.ModelConfig", package.seeall)

local ModelConfig = class("ModelConfig", BaseConfig)

function ModelConfig:onInit()
	self._cfgModel = false
	self._cfgModelSlotEffect = false
	self._modelData = {}
end

function ModelConfig:getNames()
	return {
		ConfigName.Model,
		ConfigName.ModelSlotEffect
	}
end

function ModelConfig:handleConfig(name, content)
	if name == ConfigName.Model then
		self._cfgModel = content
	elseif name == ConfigName.ModelSlotEffect then
		self._cfgModelSlotEffect = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function ModelConfig:getModelConfig(code)
	local config = self._cfgModel[code]

	if not config and enableErrorLog then
		printError("ModelConfig::Cannot find config for", code)
	end

	return config
end

function ModelConfig:getModelData(code)
	if self._modelData[code] == nil then
		self._modelData[code] = ModelData.New(code)
	end

	return self._modelData[code]
end

function ModelConfig:getModelSlotEffectConfig(code)
	local config = self._cfgModelSlotEffect[code]

	return config
end

ModelConfig.instance = ModelConfig.New()

return ModelConfig
