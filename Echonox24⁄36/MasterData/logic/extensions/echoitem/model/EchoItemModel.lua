-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/model/EchoItemModel.lua

module("logic.extensions.echoitem.model.EchoItemModel", package.seeall)

local M = class("EchoItemModel", BaseModel)

function M:ctor()
	self._echoItemDataList = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._echoItemDataList = BaseListModel.New()
end

function M:getEchoItemData()
	return self._echoItemDataList
end

M.instance = M.New()

return M
