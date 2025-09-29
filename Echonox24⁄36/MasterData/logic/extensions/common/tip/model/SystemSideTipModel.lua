-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/model/SystemSideTipModel.lua

module("logic.extensions.common.tip.model.SystemSideTipModel", package.seeall)

local M = class("SystemSideTipModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._allSideTipsQuene = false
	self._allMonumentData = false
end

function M:onInit()
	self._allSideTipsQuene = Queue.create()
	self._allMonumentData = Queue.create()
end

function M:onReset()
	self._allSideTipsQuene:clear()
	self._allMonumentData:clear()
end

function M:addMountData(data)
	self._allMonumentData:enqueue(data)
end

function M:getMonumentData()
	if self._allMonumentData:size() <= 0 then
		return false
	end

	local data = self._allMonumentData:dequeue()

	return data
end

function M:addData(data)
	self._allSideTipsQuene:enqueue(data)
end

function M:getData()
	if self._allSideTipsQuene:size() <= 0 then
		return false
	end

	local data = self._allSideTipsQuene:dequeue()

	return data
end

M.instance = M.New()

return M
