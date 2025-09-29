-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/model/StoreHotTabMo.lua

module("logic.extensions.store.model.StoreHotTabMo", package.seeall)

local M = class("StoreHotTabMo")

function M:ctor()
	self._id = false
	self._name = false
	self._icon = false
	self._sort = false
	self._isOnline = false
	self._startTime = false
	self._endTime = false
	self._storeId = false
	self._goodsId = false
	self._type = false
end

function M:initByCfg(data)
	self._id = data.code
	self._name = data.name
	self._icon = data.icon
	self._sort = data.sortIndex
	self._isOnline = data.isOnline
	self._startTime = data.startTime
	self._endTime = data.endTime
	self._storeId = data.storeId
	self._goodsId = data.goodsId
	self._type = data.type
end

function M:getId()
	return self._id
end

function M:getName()
	return self._name
end

function M:getIcon()
	return self._icon
end

function M:getSort()
	return self._sort
end

function M:getIsOnline()
	if self._type == StoreEnum.BannerType.FirstCharge then
		local isShow = StoreRechargeModel.instance:isShowStoreFirstCharge()

		return isShow and self._isOnline
	end

	return self._isOnline
end

function M:getStoreId()
	return self._storeId
end

function M:getTabId()
	return
end

function M:getIsExpired()
	local beginT = false
	local endT = false
	local canOnLine = false

	if not string.nilorempty(self._startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(self._startTime)
	end

	if not string.nilorempty(self._endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(self._endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
		end
	else
		canOnLine = true
	end

	return not canOnLine
end

function M:getGoodsId()
	return self._goodsId
end

function M:getTips()
	return self._tip
end

function M:getType()
	return self._type
end

return M
