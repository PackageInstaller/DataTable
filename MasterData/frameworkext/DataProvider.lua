-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/lmvc/model/databinder/DataProvider.lua

module("frameworkext.lmvc.model.databinder.DataProvider", package.seeall)

local DataProvider = class("DataProvider")

function DataProvider:ctor()
	self._dataBinder = nil
end

function DataProvider:onUpdateData()
	if self._dataBinder then
		self._dataBinder:onUpdateData()
	end
end

function DataProvider:setDataBinder(binder)
	self._dataBinder = binder
end

return DataProvider
