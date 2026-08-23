local SignInData = class("SignInData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.sign_in_info
local var_0_2 = g.core.config.sign_in_cumulate_info

function SignInData:ctor()
	self:initData()
end

function SignInData:initData()
	self.super.ctor(self)

	self._cumulateSize = 0
	self._curTurnDays = 0
	self._curSignDay = 0
	self._signState = -1
	self._signAwardSzie = 0
	self._signStamp = 0
	self._cumulateItems = {}
	self._signAwardsItem = {}
end

function SignInData:loadSignInData(arg_3_1)
	if arg_3_1 == nil then
		return
	end

	self._signStamp = g.core.common.ServerTime:getTime()

	local var_3_0 = arg_3_1.total

	if arg_3_1.signed == 0 then
		var_3_0 = var_3_0 + 1
	end

	local var_3_1, var_3_2 = self:_getCurTurnAndDay(var_3_0)
	local var_3_3 = 0

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_4 = var_0_1.indexOf(iter_3_0)

		if var_3_4.turn == var_3_1 then
			var_3_3 = var_3_3 + 1
			self._signAwardsItem[var_3_4.id] = {
				day = var_3_4.id,
				type = var_3_4.reward_type,
				value = var_3_4.reward_value,
				size = var_3_4.reward_size,
				vip_level = var_3_4.vip_level
			}
		end
	end

	local var_3_5 = 0

	for iter_3_1 = 1, var_0_2.getLength() do
		local var_3_6 = var_0_2.indexOf(iter_3_1)

		if var_3_6.turn == var_3_1 then
			var_3_5 = var_3_5 + 1

			local var_3_7 = {
				state = self:_getGiftState(arg_3_1.ids, arg_3_1.signed, var_3_2, var_3_6),
				id = var_3_6.id,
				days = var_3_6.days,
				award = {}
			}

			for iter_3_2 = 1, 4 do
				if var_3_6["reward_type_" .. iter_3_2] ~= 0 then
					table.insert(var_3_7.award, {
						type = var_3_6["reward_type_" .. iter_3_2],
						value = var_3_6["reward_value_" .. iter_3_2],
						size = var_3_6["reward_size_" .. iter_3_2]
					})
				end
			end

			self._cumulateItems[var_3_6.id] = var_3_7
		end
	end

	self._cumulateSize = var_3_5
	self._curTurnDays = var_3_3
	self._curSignDay = var_3_2
	self._signState = arg_3_1.signed
end

function SignInData:_getCurTurnAndDay(arg_4_1)
	local var_4_0 = {}

	for iter_4_0 = 1, var_0_1.getLength() do
		local var_4_1 = var_0_1.indexOf(iter_4_0)

		if var_4_0[var_4_1.turn] == nil then
			var_4_0[var_4_1.turn] = var_4_1.id
		elseif var_4_0[var_4_1.turn] < var_4_1.id then
			var_4_0[var_4_1.turn] = var_4_1.id
		end
	end

	local var_4_2 = 0
	local var_4_3 = 0
	local var_4_4 = false

	for iter_4_1 = 1, #var_4_0 do
		assert(var_4_0[iter_4_1], "read error in sign_in_info")

		if arg_4_1 > var_4_0[iter_4_1] then
			arg_4_1 = arg_4_1 - var_4_0[iter_4_1]
			var_4_3 = arg_4_1
			var_4_2 = iter_4_1
			var_4_4 = false
		else
			var_4_3 = arg_4_1
			var_4_2 = iter_4_1
			var_4_4 = true

			break
		end
	end

	if not var_4_4 then
		while var_4_0[#var_4_0] < arg_4_1 do
			arg_4_1 = arg_4_1 - var_4_0[#var_4_0]
			var_4_3 = arg_4_1
		end
	end

	return var_4_2, var_4_3
end

function SignInData:_getGiftState(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = {}

	if arg_5_1 ~= nil then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			var_5_0[iter_5_1] = 1
		end
	end

	if var_5_0[arg_5_4.id] ~= nil then
		return 2
	end

	if arg_5_3 < arg_5_4.days then
		return 0
	elseif arg_5_4.days == arg_5_3 then
		if arg_5_2 == 0 then
			return 0
		else
			return 1
		end
	else
		return 1
	end
end

function SignInData:onSignInSignHandler(arg_6_1)
	if self._signState == -1 then
		self._signState = 0
	end

	self._signAwardSzie = arg_6_1 > self._signState and arg_6_1 - self._signState or 0

	for iter_6_0, iter_6_1 in ipairs(self._cumulateItems) do
		if iter_6_1.days == self._curSignDay and iter_6_1.state == 0 then
			iter_6_1.state = 1

			break
		end
	end

	self._signState = arg_6_1
end

function SignInData:onSignInAwardHandler(arg_7_1)
	self._cumulateItems[arg_7_1].state = 2
end

function SignInData:getCumulateSize()
	return self._cumulateSize
end

function SignInData:getCumulateItem(arg_9_1)
	return self._cumulateItems[arg_9_1]
end

function SignInData:getAvailReceiveAward()
	for iter_10_0, iter_10_1 in ipairs(self._cumulateItems) do
		if iter_10_1.state ~= 2 then
			return iter_10_1
		end
	end

	return self._cumulateItems[#self._cumulateItems]
end

function SignInData:getCumulateDays()
	if self._signState == 0 then
		return self._curSignDay - 1
	end

	return self._curSignDay
end

function SignInData:getCurTurnDays()
	return self._curTurnDays
end

function SignInData:getCurSignDay()
	return self._curSignDay
end

function SignInData:getSignAwardsByDay(arg_14_1)
	return self._signAwardsItem[arg_14_1]
end

function SignInData:getSignState()
	return self._signState
end

function SignInData:getSignAwardSize()
	return self._signAwardSzie
end

function SignInData:isNeedSignInfo()
	return self:checkExpired(self._signStamp)
end

function SignInData:getPreviewAwardList()
	local var_18_0 = {}

	for iter_18_0 = 1, self:getCumulateSize() do
		table.insert(var_18_0, (self:getCumulateItem(iter_18_0)))
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		if arg_19_0.state == 2 ~= (arg_19_1.state == 2) then
			return arg_19_0.state ~= 2
		end

		if arg_19_0.days ~= arg_19_1.days then
			return arg_19_0.days < arg_19_1.days
		end
	end)

	return var_18_0
end

function SignInData:isCanActivityDailySignIn()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_SIGNIN) then
		return false
	end

	local var_20_0 = self:getSignState()

	if var_20_0 == 0 then
		return true
	end

	if var_20_0 == 1 then
		local var_20_1 = self:getSignAwardsByDay((self:getCurSignDay())).vip_level

		if var_20_1 ~= 0 and var_20_1 <= g.core.model.User:getVipLevel() then
			return true
		end
	end

	for iter_20_0 = 1, self:getCumulateSize() do
		if self:getCumulateItem(iter_20_0).state == 1 then
			return true
		end
	end

	return false
end

function SignInData:isCanGetSignAwards()
	if self:getSignState() == 0 then
		return true
	end

	return false
end

function SignInData:isCanGetCumulateAwards()
	for iter_22_0 = 1, self:getCumulateSize() do
		if self:getCumulateItem(iter_22_0).state == 1 then
			return true
		end
	end

	return false
end

return SignInData
