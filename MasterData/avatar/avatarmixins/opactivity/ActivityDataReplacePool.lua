-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataReplacePool.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityReplacePoolDetail = require("ClientData/ResOpActivityReplacePoolDetail")
local ActivityDataReplacePool = Class("ActivityDataReplacePool", ActivityDataBase)

function ActivityDataReplacePool:ctor()
	self.serverData = {}
	self.replaceSvrData = {}
end

function ActivityDataReplacePool:updateClientData(actId)
	self.actId = actId

	local detailData = ResOpActivityReplacePoolDetail[actId]

	if not detailData then
		return
	end

	self.clientData = {}

	for idx, detail in ipairs(detailData) do
		local poolId = detail.pool_id

		if not self.clientData[poolId] then
			self.clientData[poolId] = {}
		end

		table.insert(self.clientData[poolId], detail)
	end

	for poolId, v in pairs(self.clientData) do
		self.poolId = poolId
	end
end

function ActivityDataReplacePool:updateRoleData(roleData)
	local replaceData = roleData.replace

	if replaceData then
		local idx = replaceData.select_index
		local replacePoolId = self.poolId

		if replacePoolId then
			self.replaceSvrData[replacePoolId] = {
				lastSetTick = replaceData.set_tick,
				selectIdx = idx,
				alreadyShared = replaceData.shared == 1
			}
		end
	end
end

function ActivityDataReplacePool:checkNew()
	return
end

function ActivityDataReplacePool:lastSetValid(poolId)
	local svrData = self.replaceSvrData[poolId]

	if not svrData or not svrData.lastSetTick then
		return false
	end

	return svrData.lastSetTick >= ClientUtils.getServerTimeTodayStart()
end

function ActivityDataReplacePool:getNowUpDetail(poolId)
	local clientData = self.clientData[poolId]

	if not clientData then
		return
	end

	local idx = self:getNowSelection(poolId)

	if idx == 0 then
		return
	else
		for _, detail in ipairs(clientData) do
			if detail.index == idx then
				return detail
			end
		end
	end
end

function ActivityDataReplacePool:getNowSelection(poolId)
	local svrData = self.replaceSvrData[poolId]

	if svrData and self:lastSetValid(poolId) then
		return svrData.selectIdx
	end

	return self:_defaultSelection(poolId)
end

function ActivityDataReplacePool:_defaultSelection(poolId)
	local clientData = self.clientData[poolId]

	if not clientData then
		return 0
	end

	if #clientData > 1 then
		return 0
	else
		return clientData[1].index
	end
end

function ActivityDataReplacePool:getDefaultDetail(poolId)
	local clientData = self.clientData[poolId]

	if not clientData then
		return
	end

	return clientData[1]
end

function ActivityDataReplacePool:isMultiUp(poolId)
	local clientData = self.clientData[poolId]

	if not clientData then
		return false
	end

	return #clientData > 1
end

function ActivityDataReplacePool:hasShared()
	if self.replaceSvrData and self.replaceSvrData[self.poolId] then
		return self.replaceSvrData[self.poolId].alreadyShared
	end
end

return ActivityDataReplacePool
