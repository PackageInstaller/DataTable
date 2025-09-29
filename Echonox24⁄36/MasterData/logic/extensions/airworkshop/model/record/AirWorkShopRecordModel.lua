-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/record/AirWorkShopRecordModel.lua

module("logic.extensions.airworkshop.model.record.AirWorkShopRecordModel", package.seeall)

local M = class("AirWorkShopRecordModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._recordMoLst = {}

	self:setDataDirty(true)
end

function M:updateLstFromServer(LstPlayRecordNO, recordReqInfo)
	local type = recordReqInfo.type
	local page = recordReqInfo.page

	if not self._recordMoLst[type] then
		self._recordMoLst[type] = {}
	end

	self._recordMoLst[type][page] = {}

	local count = LstPlayRecordNO and #LstPlayRecordNO or 0

	if count > 0 then
		for index, PlayRecordNO in ipairs(LstPlayRecordNO) do
			local mo = AirWorkShopRecordMo.New()

			mo:updateFromServer(PlayRecordNO)
			table.insert(self._recordMoLst[type][page], mo)
		end
	end

	self:setDataDirty(false)
end

function M:setDataDirty(dirty)
	self._dataDirty = dirty
end

function M:getDataDirty()
	return self._dataDirty
end

function M:getRecordLstByTypeAndPage(type, page)
	return self._recordMoLst[type][page]
end

function M:setMapIdLiked(mapId, liked)
	return
end

M.instance = M.New()

return M
