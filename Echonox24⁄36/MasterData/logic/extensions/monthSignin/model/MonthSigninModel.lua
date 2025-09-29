-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/model/MonthSigninModel.lua

module("logic.extensions.monthSignin.model.MonthSigninModel", package.seeall)

local M = class("MonthSigninModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._finishCount = 0
	self._isTodayFinish = false
	self._rewardList = {}
end

function M:setModelList(msg)
	self._finishCount = msg.signInDay
	self._isTodayFinish = msg.signedIn

	local days = self:getDays()

	self._rewardList = {}

	for i = 1, days do
		local tempMo = MonthSignItemMo.New()
		local tempTable = {}

		if i <= self._finishCount then
			tempTable.id = i
			tempTable.status = 1
		else
			tempTable.id = i
			tempTable.status = 3
		end

		if not msg.signedIn and i == self._finishCount + 1 then
			tempTable.status = 2
		end

		tempMo:setSignMo(tempTable)

		self._rewardList[i] = tempMo
	end
end

function M:getDays()
	local month = TimeUtil.instance:getNowMonth()
	local date = TimeUtil.instance:getNowDate()
	local days = 0

	if date == 1 then
		local hourN = os.date("%H", ServerTime.now())

		if tonumber(hourN) < 5 then
			if month == 1 then
				days = TimeUtil.instance:getMonthHaveDay(12)
			else
				days = TimeUtil.instance:getMonthHaveDay(month - 1)
			end
		else
			days = TimeUtil.instance:getMonthHaveDay(month)
		end
	else
		days = TimeUtil.instance:getMonthHaveDay(month)
	end

	return days
end

function M:getCurrentMonth()
	local month = TimeUtil.instance:getNowMonth()
	local date = TimeUtil.instance:getNowDate()

	if date == 1 then
		local hourN = os.date("%H", ServerTime.now())

		if tonumber(hourN) < 5 then
			if month == 1 then
				return 12
			else
				return month - 1
			end
		else
			return month
		end
	else
		return month
	end
end

function M:getList()
	return self._rewardList
end

function M:getTodayRewardInfo()
	local num = self._finishCount

	if not self._isTodayFinish then
		num = num + 1
	end

	return self._rewardList[num]
end

function M:getTodayIsFinish()
	return self._isTodayFinish
end

M.instance = M.New()

return M
