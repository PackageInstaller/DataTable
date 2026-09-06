-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/ConfigMgr.lua

module("frameworkext.lmvc.config.ConfigMgr", package.seeall)

local ConfigMgr = class("ConfigMgr")

function ConfigMgr:ctor()
	self._configDict = {}
	self._requestorDict = {}
	self._pathPrefix = nil
end

function ConfigMgr:init(pathPrefix)
	self._pathPrefix = pathPrefix
end

function ConfigMgr:loadConfigs(configNames)
	local len = #configNames

	for i = 1, len do
		local path = self._pathPrefix .. configNames[i]
		local content = require(path)

		self:_addConfig(configNames[i], content)
	end
end

function ConfigMgr:_addConfig(name, content)
	local requestors = self._requestorDict[name]

	if requestors then
		local count = #requestors

		for i = 1, count do
			requestors[i]:handleConfig(name, content)
		end
	else
		self._configDict[name] = content
	end
end

function ConfigMgr:requestConfig(name, configObj)
	if self._configDict[name] then
		local content = self._configDict[name]

		configObj:handleConfig(name, content)
	else
		local path = self._pathPrefix .. name
		local content = require(path)

		self._configDict[name] = content

		configObj:handleConfig(name, content)
	end
end

function ConfigMgr:clear()
	self._configDict = nil
	self._requestorDict = nil
end

ConfigMgr.instance = ConfigMgr.New()

return ConfigMgr
