local var_0_0 = g.core.config.recharge_gift_info
local var_0_1 = g.core.model.User.firstRechargeData
local var_0_2 = g.core.config.first_recharge_info
local var_0_3 = g.core.common.Path
local PhoenixGiftConst = require("app.view.module.phoenixGift.const.PhoenixGiftConst")
local PhoenixGiftData = class("PhoenixGiftData")

function PhoenixGiftData:ctor()
	self:initData()
end

function PhoenixGiftData:initData()
	self._curGiftId = 0
	self._firstGiftId = 0
	self._lastGiftId = 0
	self._hasBuyLastGift = false
	self._FRechargeActId = var_0_1:getFirstRechargeActId()

	self:_initGift()
end

function PhoenixGiftData:_initGift()
	self._giftDict = {}
	self._giftArray = {}

	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		if iter_3_1.activity_type == PhoenixGiftConst.GIFT_TYPE then
			if iter_3_1.activity_id > 0 then
				if self._FRechargeActId == (iter_3_1.activity_id or 1) then
					if self._firstGiftId == 0 then
						self._firstGiftId = iter_3_1.id
					end

					if iter_3_1.id > self._lastGiftId then
						self._lastGiftId = iter_3_1.id
					end

					self._giftDict[iter_3_1.id] = iter_3_1
				end
			end
		end
	end

	self._giftArray = table.values(self._giftDict)

	table.sort(self._giftArray, function(arg_4_0, arg_4_1)
		return arg_4_0.id < arg_4_1.id
	end)

	self._curGiftId = self._giftArray[1].id

	for iter_3_2 = 1, #self._giftArray do
		local var_3_1 = g.core.model.User.giftData:getGiftDataById(self._giftArray[iter_3_2].id)

		if not var_3_1 then
			break
		end

		if var_3_1.buyTimes > 0 then
			self._curGiftId = self._curGiftId + 1
		end
	end
end

function PhoenixGiftData:refreshCurGiftId(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._curGiftId = arg_5_1.id + 1

	if self._curGiftId > self._lastGiftId then
		self._hasBuyLastGift = true
	end
end

function PhoenixGiftData:getCurrentGift()
	return self._giftDict[self._curGiftId]
end

function PhoenixGiftData:getCurGiftId()
	return self._curGiftId
end

function PhoenixGiftData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PHOENIX_GIFT) then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_FIRST_RECHARGE) then
		return false
	end

	local var_8_0 = var_0_1:isGetFirstAward()
	local var_8_1 = true

	for iter_8_0 = 1, #self._giftArray do
		local var_8_2 = g.core.model.User.giftData:getGiftDataById(self._giftArray[iter_8_0].id)

		if not var_8_2 then
			break
		end

		if var_8_2.buyTimes == 0 then
			var_8_1 = false

			break
		end
	end

	return var_8_0 and not var_8_1
end

function PhoenixGiftData:getHomeEntranceIconAndName()
	local var_9_2 = var_0_1:getFirstRechargeActId()
	local var_9_3 = var_0_3:getPhoenixHomeBtnIconUrl(var_9_2)
	local var_9_4 = var_0_2.fetch(var_9_2)

	return var_9_3, checkbool(var_0_2.hasKey("gift_name") and var_9_4) and var_9_4.gift_name or g.core.lang:get(405504)
end

function PhoenixGiftData:getDiscount()
	return self:getCurrentGift().discount
end

function PhoenixGiftData:checkIsNewGift()
	local var_11_0, var_11_1

	if not self:isShowEntrance() then
		do return false end

		var_11_0 = g.core.common.Storage:load("phoenix_gift_status.json", true) or {}
		var_11_1 = checkbool
	end

	return not var_11_1(var_11_0["gift_" .. self:getCurGiftId()])
end

function PhoenixGiftData:saveGiftStatus(arg_12_1)
	local var_12_0 = g.core.common.Storage:load("phoenix_gift_status.json", true) or {}

	var_12_0["gift_" .. arg_12_1] = true

	g.core.common.Storage:save("phoenix_gift_status.json", var_12_0, true)
end

return PhoenixGiftData
