-- chunkname: @framework/mvc/BaseConfig.lua

module("framework.mvc.BaseConfig", package.seeall)

local BaseConfig = class("BaseConfig")

function BaseConfig:reqConfigNames()
	return nil
end

function BaseConfig:onInit()
	return
end

function BaseConfig:onConfigLoaded(configName, configTable)
	return
end

return BaseConfig
