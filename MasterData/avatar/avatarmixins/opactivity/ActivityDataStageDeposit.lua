-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataStageDeposit.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityStageDepositUp = require("ClientData/ResOpActivityStageDepositUp")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityDataStageDeposit = Class("ActivityDataStageDeposit", ActivityDataBase)

function ActivityDataStageDeposit:ctor()
	self.serverData = {}
end

function ActivityDataStageDeposit:updateClientData(actId)
	self.actId = actId
end

function ActivityDataStageDeposit:updateRoleData(roleData)
	self.bonus = roleData.deposit_up.award
end

function ActivityDataStageDeposit:checkNew()
	return
end

function ActivityDataStageDeposit:getHookBonus(container)
	container = container or {}

	if not self.upDetail then
		self.upDetail = {}

		local upData = ResOpActivityStageDepositUp[self.actId] or {}

		upData = upData.deposit_up or {}

		for index, info in ipairs(upData) do
			self.upDetail[info.id] = info.times
		end
	end

	if self.actObject.roleData then
		local limitTime = math.min(CurAvatar.stageHookAwardGotTime + Const.MAIN_STAGE_DEPOSIT_MAX_TIME, ClientUtils.getServerTime())

		limitTime = math.min(limitTime, self.actObject.roleData.deposit_up.freeze_time)

		local hookTime = limitTime - math.max(CurAvatar.stageHookAwardUpdateTime, self.actObject.roleData.deposit_up.open_time)
		local times = math.max(0, math.floor(hookTime / Const.STAGE_HOOK_UPDATE_CD))
		local baseAwards = ResRandClient[CurAvatar.mainStageCur.deposit_assgin_award] or {}
		local baseAwardIDs = baseAwards.show_ids or {}
		local baseAwardNums = baseAwards.show_nums or {}

		for i, awardID in ipairs(baseAwardIDs) do
			if self.upDetail[awardID] then
				local awardNum = baseAwardNums[i] or 0

				container[awardID] = {
					math.floor(times * awardNum * self.upDetail[awardID] * 0.0001),
					self.actObject
				}
			end
		end
	end

	if self.bonus then
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

return ActivityDataStageDeposit
