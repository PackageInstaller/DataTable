-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataDeposit.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityDepositMisc = require("ClientData/ResOpActivityDepositMisc")
local ResOpActivityDepositDetail = require("ClientData/ResOpActivityDepositDetail")
local ActivityDataDeposit = Class("ActivityDataDeposit", ActivityDataBase)

function ActivityDataDeposit:ctor()
	self.serverData = {}
	self.clientData = {}
	self.detailData = {}
end

function ActivityDataDeposit:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityDepositMisc[actId] or {}
	self.isManual = self.clientData.is_single == 1
	self.detailData = ResOpActivityDepositDetail[actId] or {}
end

function ActivityDataDeposit:updateRoleData(roleData)
	self.getTick = roleData.deposit.last_get_tick
	self.lastRefreshTick = roleData.deposit.last_rand_tick
	self.bonus = roleData.deposit.award
	self.hasGotCount = roleData.deposit.get_count
end

function ActivityDataDeposit:checkNew()
	if self.isManual and self.getTick then
		local oneData = self.detailData[1]

		if oneData and oneData.drop_interval then
			local nowTick = ClientUtils.getServerTime()

			if self.actObject:inFreeze() and self.actObject.opActivityMgrItem and self.actObject.opActivityMgrItem.time and self.actObject.opActivityMgrItem.time.freezetime then
				nowTick = math.min(nowTick, self.actObject.opActivityMgrItem.time.freezetime)
			end

			if self.actObject:inFreeze() or self.actObject:inOpenState() then
				return nowTick - self.getTick >= oneData.drop_interval
			end
		end
	end
end

function ActivityDataDeposit:getHookBonus(container)
	container = container or {}

	if self.bonus and not self.isManual then
		for _, info in pairs(self.bonus) do
			if container[info.id] then
				container[info.id] = {
					(container[info.id][1] or 0) + info.num,
					self.actObject
				}
			else
				container[info.id] = {
					info.num,
					self.actObject
				}
			end
		end
	end

	return container
end

function ActivityDataDeposit:onServerStateChange()
	if self.actObject:inOpenState() then
		self:checkOnInit()
	end
end

function ActivityDataDeposit:checkOnInit()
	if not self.getTick and self.isManual then
		RPC.opActDepositRefresh(self.actObject.opId)
	end
end

function ActivityDataDeposit:getHookDetailState(index)
	index = index or 1

	local oneData = self.detailData[index]

	if oneData and oneData.drop_interval then
		local infoTable = {}

		if oneData.max_deposit_time then
			infoTable.maxCount = math.floor(oneData.max_deposit_time / oneData.drop_interval)
		end

		local nowTick = ClientUtils.getServerTime()

		if self.actObject:inFreeze() and self.actObject.opActivityMgrItem and self.actObject.opActivityMgrItem.time and self.actObject.opActivityMgrItem.time.freezetime then
			nowTick = math.min(nowTick, self.actObject.opActivityMgrItem.time.freezetime)
		end

		if self.actObject:inFreeze() or self.actObject:inOpenState() then
			infoTable.passedTime = nowTick - self.getTick
		else
			infoTable.passedTime = 0
		end

		infoTable.oneTime = oneData.drop_interval

		return infoTable
	end
end

return ActivityDataDeposit
