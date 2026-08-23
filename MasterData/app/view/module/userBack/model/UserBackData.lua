local UserBackData = class("UserBackData")
local var_0_1 = g.core.config.back_turn_info
local var_0_2 = g.core.config.back_sign_info
local var_0_3 = g.core.config.back_gift_info
local var_0_4 = g.core.config.back_resource_info
local var_0_5 = g.core.common.ServerTime
local var_0_6 = g.core.common.Storage
local var_0_7 = g.core.const.ConstMgr.FUNCTION_TYPE
local UserBackConst = require("app.view.module.userBack.const.UserBackConst")

function UserBackData:ctor()
	self:initData()
end

function UserBackData:initData()
	self._info = nil
	self._lostDays = 0
	self._backRoleLevel = 0
	self._backVipLevel = 0
	self._turnId = 0
	self._dueTime = 0
	self._loginDays = 0
	self._day = 0
	self._hasRecAwards = {}
	self._hasRecGifts = {}
	self._signCfgData = {}
	self._giftCfgData = {}
	self._resourceGroupId = 0
	self._resourceDayIdList = {}
	self._resourceGetIdList = {}
	self._resourceActionList = {}
	self._isFromOpenMessage = false
end

function UserBackData:updateUserBackInfo(arg_3_1)
	self._info = arg_3_1.info

	if arg_3_1.info then
		self._lostDays = arg_3_1.info.lost_days or 0
		self._backRoleLevel = arg_3_1.info.back_role_level or 0
		self._backVipLevel = arg_3_1.info.back_vip_level or 0
		self._turnId = arg_3_1.info.turn_id or 0
		self._dueTime = arg_3_1.info.due_time or 0
		self._loginDays = arg_3_1.info.login_days or 0
		self._day = arg_3_1.info.day or 0
		self._hasRecAwards = arg_3_1.info.ok_sign_rewards or {}
		self._hasRecGifts = arg_3_1.info.ok_gifts or {}

		self:updateResourceGetIdList(arg_3_1.info.ok_back_res or {})
		self:updateResourceActionValue(arg_3_1.info.ok_back_res or {})
	end

	self:updateResourceGroupId()
end

function UserBackData:updateResourceGetIdList(arg_4_1)
	self._resourceGetIdList = {}

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_0 = arg_4_1[iter_4_0].ok_ids or {}

		for iter_4_1 = 1, #var_4_0 do
			self._resourceGetIdList[10 * arg_4_1[iter_4_0].day + var_4_0[iter_4_1]] = true
		end
	end
end

function UserBackData:updateResourceActionValue(arg_5_1)
	arg_5_1 = arg_5_1 or {}
	self._resourceActionList = {}

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_0 = arg_5_1[iter_5_0].actions or {}

		for iter_5_1 = 1, #var_5_0 do
			self._resourceActionList[arg_5_1[iter_5_0].day] = self._resourceActionList[arg_5_1[iter_5_0].day] or {}
			self._resourceActionList[arg_5_1[iter_5_0].day][var_5_0[iter_5_1].id] = var_5_0[iter_5_1].num
		end
	end
end

function UserBackData:updateResourceGet(arg_6_1, arg_6_2)
	self._resourceGetIdList[10 * arg_6_1 + arg_6_2] = true
end

function UserBackData:isResourceGet(arg_7_1, arg_7_2)
	return self._resourceGetIdList[10 * arg_7_1 + arg_7_2] or false
end

function UserBackData:isDayCanGetResource(arg_8_1)
	return arg_8_1 <= self._loginDays
end

function UserBackData:getCurShowLoginDays()
	return math.max(1, math.min(self._loginDays, 3))
end

function UserBackData:getCurBackTurnCfg()
	if self._turnId == 0 then
		return
	end

	return var_0_1.get(self._turnId)
end

function UserBackData:updateResourceGroupId()
	if self._turnId == 0 then
		return
	end

	local var_11_0 = var_0_1.get(self._turnId)

	for iter_11_0 = 1, 6 do
		if var_11_0["level_min_" .. iter_11_0] <= self._backRoleLevel and var_11_0["level_max_" .. iter_11_0] > self._backRoleLevel then
			self._resourceGroupId = var_11_0["level_group_" .. iter_11_0]

			break
		end
	end

	local var_11_1 = var_0_4.match(function(arg_12_0)
		return arg_12_0.group == self._resourceGroupId
	end)

	for iter_11_1 = 1, #var_11_1 do
		self._resourceDayIdList[var_11_1[iter_11_1].day] = var_11_1[iter_11_1].id
	end
end

function UserBackData:getResourceEventListByDay(arg_13_1)
	if not self._resourceDayIdList[arg_13_1] then
		return {}
	end

	local var_13_0 = var_0_4.get(self._resourceDayIdList[arg_13_1])
	local var_13_1 = {}

	for iter_13_0 = 1, 3 do
		if var_13_0["action_" .. iter_13_0] > 0 then
			table.insert(var_13_1, {
				day = arg_13_1,
				id = iter_13_0,
				action = var_13_0["action_" .. iter_13_0],
				actionValue = var_13_0["action_value_" .. iter_13_0],
				type = var_13_0["type_" .. iter_13_0],
				value = var_13_0["value_" .. iter_13_0],
				size = var_13_0["size_" .. iter_13_0],
				description = var_13_0["description_" .. iter_13_0]
			})
		end
	end

	return var_13_1
end

function UserBackData:getResourceActionValueByDay(arg_14_1, arg_14_2)
	return (self._resourceActionList[arg_14_1] and self._resourceActionList[arg_14_1][arg_14_2] or nil) and self._resourceActionList[arg_14_1][arg_14_2]
end

function UserBackData:isResourceAllGetByDay(arg_15_1)
	local var_15_0 = self:getResourceEventListByDay(arg_15_1)

	for iter_15_0 = 1, #var_15_0 do
		if not self:isResourceGet(arg_15_1, var_15_0[iter_15_0].id) then
			return false
		end
	end

	return true
end

function UserBackData:getResourceCanGetMaxDay()
	local var_16_0 = self:getCurShowLoginDays()

	for iter_16_0 = 1, self:getCurShowLoginDays() do
		local var_16_1 = 0
		local var_16_2 = self:getResourceEventListByDay(iter_16_0)

		for iter_16_1 = 1, #var_16_2 do
			if self:getResourceActionValueByDay(iter_16_0, var_16_2[iter_16_1].action) >= var_16_2[iter_16_1].actionValue and not self:isResourceGet(iter_16_0, var_16_2[iter_16_1].id) then
				var_16_1 = var_16_1 + 1
			end
		end

		local var_16_3

		if 0 <= var_16_1 then
			var_16_3 = var_16_1
			var_16_0 = iter_16_0
		end
	end

	return var_16_0
end

function UserBackData:setIsFromOpenMessage(arg_17_1)
	self._isFromOpenMessage = arg_17_1
end

function UserBackData:getIsFromOpenMessage()
	return self._isFromOpenMessage
end

function UserBackData:updateSignData(arg_19_1)
	if arg_19_1.day then
		table.insert(self._hasRecAwards, arg_19_1.day)
	end
end

function UserBackData:updateGiftData(arg_20_1)
	if arg_20_1.id then
		table.insert(self._hasRecGifts, arg_20_1.id)
	end

	self:sortGiftCfgData()
end

function UserBackData:initCfgData()
	self._signCfgData = {}
	self._giftCfgData = {}

	local var_21_0 = self:getTurnId()

	if not var_21_0 or var_21_0 == 0 then
		return
	end

	local var_21_1 = var_0_1.get(var_21_0)

	for iter_21_0 = 1, var_0_2.getLength() do
		local var_21_2 = var_0_2.indexOf(iter_21_0)

		if var_21_2.group == var_21_1.sign then
			table.insert(self._signCfgData, var_21_2)
		end
	end

	for iter_21_1 = 1, var_0_3.getLength() do
		local var_21_3 = var_0_3.indexOf(iter_21_1)

		if var_21_3.group == var_21_1.gift and var_21_3.day == self._day and self._day ~= 0 then
			table.insert(self._giftCfgData, var_21_3)
		end
	end

	self:sortGiftCfgData()
end

function UserBackData:getAllBackGift()
	local var_22_0 = self:getTurnId()

	if not var_22_0 or var_22_0 == 0 then
		return {}
	end

	local var_22_1 = var_0_1.get(var_22_0).gift
	local var_22_2 = {}

	for iter_22_0 = 1, var_0_3.getLength() do
		local var_22_3 = var_0_3.indexOf(iter_22_0)

		if var_22_3.group == var_22_1 and self._day ~= 0 then
			table.insert(var_22_2, var_22_3)
		end
	end

	return var_22_2
end

function UserBackData:sortGiftCfgData()
	table.sort(self._giftCfgData, function(arg_24_0, arg_24_1)
		local var_24_0 = self:getGiftItemStatus(arg_24_0.id)
		local var_24_1 = self:getGiftItemStatus(arg_24_1.id)

		if var_24_0 == UserBackConst.GIFT_STATUS.CAN_BUY and var_24_1 == UserBackConst.GIFT_STATUS.CAN_BUY then
			return arg_24_0.id < arg_24_1.id
		elseif var_24_0 == UserBackConst.GIFT_STATUS.CAN_NOT_BUY and var_24_1 == UserBackConst.GIFT_STATUS.CAN_BUY then
			return false
		elseif var_24_0 == UserBackConst.GIFT_STATUS.CAN_BUY and var_24_1 == UserBackConst.GIFT_STATUS.CAN_NOT_BUY then
			return true
		elseif var_24_0 == UserBackConst.GIFT_STATUS.CAN_NOT_BUY and var_24_1 == UserBackConst.GIFT_STATUS.CAN_NOT_BUY then
			return arg_24_0.id < arg_24_1.id
		end
	end)
end

function UserBackData:getSignCfgData()
	return self._signCfgData
end

function UserBackData:getGiftCfgData()
	return self._giftCfgData
end

function UserBackData:getSignItemStatus(arg_27_1)
	local var_27_0 = false

	for iter_27_0 = 1, #self._hasRecAwards do
		if self._hasRecAwards[iter_27_0] == arg_27_1 then
			var_27_0 = true
		end
	end

	return var_27_0 and UserBackConst.SIGN_STATUS.HAD_SIGNED or arg_27_1 <= self._loginDays and UserBackConst.SIGN_STATUS.CAN_SIGN or UserBackConst.SIGN_STATUS.CAN_NOT_SIGH
end

function UserBackData:getGiftItemStatus(arg_28_1)
	local var_28_0 = false

	for iter_28_0 = 1, #self._hasRecGifts do
		if self._hasRecGifts[iter_28_0] == arg_28_1 then
			var_28_0 = true
		end
	end

	return var_28_0 and UserBackConst.GIFT_STATUS.CAN_NOT_BUY or UserBackConst.GIFT_STATUS.CAN_BUY
end

function UserBackData:getTurnId()
	return self._turnId
end

function UserBackData:getUserBackType()
	return nil
end

function UserBackData:getEndTime()
	return self._dueTime
end

function UserBackData:showEntrance()
	if self._dueTime and var_0_5:getTime() < self._dueTime and self._info and next(self._info) then
		return true
	end

	return false
end

function UserBackData:showOpenScreen()
	if self:showEntrance() then
		local var_33_0 = var_0_6:load("userBack_todayShow.json") or {}
		local var_33_1 = var_0_5:getDate()

		if var_33_0[var_33_1] and var_33_0[var_33_1].show then
			return false
		end

		return true
	end

	return false
end

function UserBackData:saveUserBackTodayShow()
	var_0_6:save("userBack_todayShow.json", {
		[var_0_5:getDate()] = {
			show = true
		}
	})
end

function UserBackData:hasRedPoint()
	local var_35_0 = false

	if #self._hasRecAwards >= 7 then
		var_35_0 = false
	elseif #self._hasRecAwards < self._loginDays then
		var_35_0 = true
	end

	return var_35_0
end

function UserBackData:convertChargeInfo(arg_36_1)
	local var_36_0 = clone(arg_36_1.toObject())

	var_36_0.discount = 0
	var_36_0.times = 1
	var_36_0.limit_type = g.core.const.ConstMgr.RechargeConst.GIFT_LIMIT_TYPE.NORMAL

	return var_36_0
end

function UserBackData:canBeatFace()
	local var_37_0 = var_0_6:load("userBack_beatFace.json") or {}

	if self._turnId == 0 then
		return false
	end

	if var_37_0 and var_37_0[tostring(self._turnId) .. tostring(self._dueTime)] then
		return false
	end

	return true
end

function UserBackData:setBeatFace()
	var_0_6:save("userBack_beatFace.json", {
		[tostring(self._turnId) .. tostring(self._dueTime)] = true
	})
end

function UserBackData:getDay()
	return self._day
end

function UserBackData:getLostDay()
	return self._lostDays
end

function UserBackData:hasSignAwardGet()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_7.USER_BACK) or not self:showEntrance() then
		return false
	end

	return self:hasRedPoint()
end

function UserBackData:hasFreeGiftGet()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_7.USER_BACK) or not self:showEntrance() then
		return false
	end

	for iter_42_0 = 1, #self._giftCfgData do
		if self._giftCfgData[iter_42_0].pay_type == UserBackConst.DIAMOND_TYPE and self._giftCfgData[iter_42_0].pay_value == 0 and self:getGiftItemStatus(self._giftCfgData[iter_42_0].id) == UserBackConst.GIFT_STATUS.CAN_BUY then
			return true
		end
	end

	return false
end

function UserBackData:hasCanGetResourceAward(arg_43_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_7.USER_BACK) or not self:showEntrance() then
		return false
	end

	local var_43_0 = 1
	local var_43_1 = self:getCurShowLoginDays()

	if arg_43_1 and arg_43_1.day then
		var_43_0 = arg_43_1.day
		var_43_1 = arg_43_1.day
	end

	for iter_43_0 = var_43_0, var_43_1 do
		local var_43_2 = self:getResourceEventListByDay(iter_43_0)

		for iter_43_1 = 1, #var_43_2 do
			if self:getResourceActionValueByDay(iter_43_0, var_43_2[iter_43_1].action) >= var_43_2[iter_43_1].actionValue and not self:isResourceGet(iter_43_0, var_43_2[iter_43_1].id) then
				return true
			end
		end
	end

	return false
end

return UserBackData
