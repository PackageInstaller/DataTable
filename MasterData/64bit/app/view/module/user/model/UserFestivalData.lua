local var_0_0 = g.core.model.User
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.config.skin_info
local UserFestivalData = class("UserFestivalData")

function UserFestivalData:ctor()
	self:initData()
end

function UserFestivalData:initData()
	self._lastReceiveTime = nil
	self._birthRestTimes = var_0_0:getBirthResetTimes()
	self._birthdayMonth, self._birthdayDay = self:getFormatBirthMonthDay()
	self._unlockIds = {}
	self._birthdayRewardsArr = self:_initBirthdayRewardsArr()
end

function UserFestivalData:_initBirthdayRewardsArr()
	return (g.core.common.Drops:getGoodsArray(g.core.config.parameter_info.get(10140).parameter))
end

function UserFestivalData:getFormatBirthMonthDay()
	local var_4_0 = var_0_0:getBirthday()

	if var_4_0 == "" then
		var_4_0 = "0000"
	end

	return string.sub(var_4_0, 1, 2), (string.sub(var_4_0, 3, 4))
end

function UserFestivalData:formatTo02d(arg_5_1)
	return string.format("%02d", arg_5_1)
end

function UserFestivalData:formatMD(arg_6_1)
	return string.format("%02d%02d", math.floor(arg_6_1 / 100), arg_6_1 % 100)
end

function UserFestivalData:formatYMD(arg_7_1)
	local var_7_0 = math.floor(arg_7_1 / 10000)

	return string.format("%04d%02d%02d", var_7_0, math.floor((arg_7_1 - var_7_0 * 10000) / 100), arg_7_1 % 100)
end

function UserFestivalData:updateData(arg_8_1)
	if arg_8_1 then
		self._birthdayMonth = self:formatTo02d(arg_8_1.birthday_Month)
		self._birthdayDay = self:formatTo02d(arg_8_1.birthday_Day)
		self._birthRestTimes = var_0_0:getBirthResetTimes()
	end
end

function UserFestivalData:getBirthResetTimes()
	return self._birthRestTimes
end

function UserFestivalData:updateUnlockIds(arg_10_1)
	if arg_10_1.ids then
		self._unlockIds = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.ids) do
			table.insert(self._unlockIds, iter_10_1)
		end
	end

	self:_patchKnightBirthday()
end

function UserFestivalData:_patchKnightBirthday()
	for iter_11_0, iter_11_1 in ipairs({
		400150,
		500080,
		500160,
		510080,
		400110
	}) do
		local var_11_0 = g.core.config.knight_favorability_info.get(iter_11_1)

		if self:_isCreatePlayerBeforeSpecific(var_11_0.brithday_month, var_11_0.brithday_day) then
			table.insert(self._unlockIds, iter_11_1)
		end
	end

	if self:_isCreatePlayerBeforeSpecific(10, 31) then
		table.insert(self._unlockIds, 7)
	end
end

function UserFestivalData:_isCreatePlayerBeforeSpecific(arg_12_1, arg_12_2)
	return g.core.model.User:getCreateTime() <= g.core.common.ServerTime:getTimeStampByParams({
		year = 2023,
		month = arg_12_1,
		day = arg_12_2
	})
end

function UserFestivalData:isIdUnlock(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self._unlockIds) do
		if arg_13_1 == iter_13_1 then
			return true
		end

		if arg_13_1 == 12 and self:_isSpringFestivalUnlock() then
			return true
		end

		if not g.core.config.knight_show_day_info.fetch(arg_13_1) then
			local var_13_0 = var_0_2.fetch(arg_13_1)

			if var_13_0 and iter_13_1 == var_13_0.knight_advance_id then
				return true
			end
		end
	end

	return false
end

function UserFestivalData:_isSpringFestivalUnlock()
	for iter_14_0, iter_14_1 in ipairs(self._unlockIds) do
		if iter_14_1 == 12 or iter_14_1 == 13 or iter_14_1 == 14 or iter_14_1 == 15 then
			return true
		end
	end

	return false
end

function UserFestivalData:getBirthdayElapsedDay()
	local var_15_0, var_15_1 = self:getFormatBirthMonthDay()

	if var_15_0 == "00" or var_15_1 == "00" then
		return 999
	end

	local var_15_2 = var_0_1:getTime()
	local var_15_3 = var_0_1:getTimeStampByParams({
		month = tonumber(var_15_0),
		day = tonumber(var_15_1)
	})
	local var_15_4 = var_0_1:getElapsedTime(var_15_3).day

	return math.min((var_15_2 < var_15_3 or nil) and 999, var_0_1:getElapsedTime((var_0_1:getTimeStampByParams({
		year = tonumber(var_0_1:getDateObject(var_15_2).year) - 1,
		month = tonumber(var_15_0),
		day = tonumber(var_15_1)
	}))).day)
end

function UserFestivalData:getBirthdayRewardsArr()
	return self._birthdayRewardsArr
end

function UserFestivalData:onS2CFlushRedPoint(arg_17_1)
	if arg_17_1.birthday_award then
		self._lastReceiveTime = arg_17_1.birthday_award
	end
end

function UserFestivalData:hasReceived()
	if not self._lastReceiveTime or self._lastReceiveTime == 0 then
		return false
	end

	return var_0_1:getDateObject(self._lastReceiveTime).year == var_0_1:getDateObject(var_0_1:getTime()).year
end

function UserFestivalData:setLastReceivedTime()
	self._lastReceiveTime = var_0_1:getTime()
end

function UserFestivalData:getReceiveElapsedDay()
	if not self._lastReceiveTime or self._lastReceiveTime == 0 then
		return 0
	end

	return math.floor((var_0_1:getTime() - self._lastReceiveTime) / 86400)
end

function UserFestivalData:isBirthDayExpired()
	local var_21_0 = self:getBirthdayElapsedDay()

	return self:hasReceived() and var_21_0 >= 3 or var_21_0 >= 30
end

function UserFestivalData:isShowEntrance()
	if self:hasReceived() then
		return self:getReceiveElapsedDay() < 3
	else
		local var_22_0 = self:getBirthdayElapsedDay()

		return var_22_0 and var_22_0 < 30
	end
end

function UserFestivalData:isBirthdaySet(arg_23_1)
	local var_23_0, var_23_1 = self:getFormatBirthMonthDay()

	return var_23_0 ~= "00" and var_23_1 ~= "00"
end

function UserFestivalData:hasBirthdayGiftCanReceive(arg_24_1)
	if not self:isBirthdaySet() then
		return false
	end

	return not self:hasReceived()
end

return UserFestivalData
