-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/multiple_drop/MultipleDropActivityData.lua

module("logic.extensions.welfare.model.multiple_drop.MultipleDropActivityData", package.seeall)

local M = class("MultipleDropActivityData", ActivityWelfareData)

function M:ctor(ActivityNO)
	self._strfinish = ActivityNO.data

	M.super.ctor(self, ActivityNO)
end

function M:initConfig()
	MultipleDropModel.instance:setConfigLst(self._configId, tonumber(self._strfinish))
end

return M
