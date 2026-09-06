-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/config/BaseConfig.lua

module("frameworkext.lmvc.config.BaseConfig", package.seeall)

local BaseConfig = class("BaseConfig")

function BaseConfig:ctor()
	self:onInit()

	local names = self:getNames()

	if names then
		for i, v in ipairs(names) do
			ConfigMgr.instance:requestConfig(v, self)
		end
	end
end

function BaseConfig:onInit()
	return
end

function BaseConfig:getNames()
	return nil
end

function BaseConfig:handleConfig(name, content)
	return
end

return BaseConfig
