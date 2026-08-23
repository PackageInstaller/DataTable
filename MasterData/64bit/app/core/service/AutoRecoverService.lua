local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.event.enum
local var_0_2 = 1
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.common.Goods
local AutoRecoverService = class("AutoRecoverService")

function AutoRecoverService:ctor()
	self._exeTimerLastTime = 0
	self._recoverInfoDict = {}

	for iter_1_0, iter_1_1 in g.core.config.basic_figure_info.ipairs() do
		self._recoverInfoDict[iter_1_1.type .. "_" .. iter_1_1.value] = iter_1_1
	end

	self._recoverPools = {}
	self._runningRecover = false
	self._staminaTempInfo = nil

	var_0_3:addEventListener(var_0_1.EVENT_NET_S2C_FLUSH_RESOURCE, self._onFlush, self)
	var_0_3:addEventListener(var_0_1.EVENT_NET_S2C_OP_OBJECT, self._onOpObject, self)
	var_0_3:addEventListener(var_0_1.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	var_0_3:addEventListener(var_0_1.ACTIVITY_LIFETIME_CARD_BUY_SUCCESS, self._checkStaminaNeedAddToRecoverPool, self)
end

function AutoRecoverService:reset()
	self._exeTimerLastTime = 0
	self._recoverPools = {}
	self._runningRecover = false

	if self._scheduleHandler then
		g.core.common.Scheduler:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function AutoRecoverService:_onFlush(arg_3_1, arg_3_2, arg_3_3)
	self:_updateRecoverPools(arg_3_3.resources or {})
end

function AutoRecoverService:_onOpObject(arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3.resource then
		self:_updateRecoverPools(arg_4_3.resource.update or {})
	end
end

function AutoRecoverService:_onModuleEnter()
	self._exeTimerLastTime = 0

	self:_onRecover()
end

function AutoRecoverService:_recoverStep(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1.info.time_limit

	if arg_6_1.info.type .. "_" .. arg_6_1.info.value == var_0_5.TYPE_RESOURCE .. "_" .. g.core.common.Goods.RESOURCE.TYPE_STAMINA and g.core.model.User.activityLifeTimeCardData:isSubscription(true) then
		var_6_0 = arg_6_1.info.privi_time_limit
	end

	if arg_6_1.isMax then
		return 0
	elseif var_6_0 <= arg_6_1.curValue then
		arg_6_1.isMax = true

		return 0
	elseif arg_6_2 >= arg_6_1.endTime then
		arg_6_1.curValue = var_6_0
		arg_6_1.isMax = true

		return var_6_0 - arg_6_1.curValue
	else
		local var_6_1 = math.floor(math.max(0, arg_6_2 - arg_6_1.startTime) / arg_6_1.info.unit_time)

		if var_6_1 == 0 then
			return 0
		else
			local var_6_2 = math.min(math.uint64_add(arg_6_1.curValue, arg_6_1.info.unit_recover * var_6_1), var_6_0)

			arg_6_1.curValue = var_6_2
			arg_6_1.startTime = arg_6_1.startTime + arg_6_1.info.unit_time * var_6_1

			return var_6_2 - arg_6_1.curValue
		end
	end
end

function AutoRecoverService:_updateRecoverPools(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = var_0_5.TYPE_RESOURCE .. "_" .. tostring(iter_7_1.id)
		local var_7_1 = self._recoverInfoDict[var_7_0]

		if self._recoverInfoDict[var_7_0] then
			local var_7_2 = var_7_1.time_limit
			local var_7_3 = g.core.model.User.activityLifeTimeCardData:isSubscription(true)
			local var_7_4 = var_0_4:getTime()

			if var_7_0 == var_0_5.TYPE_RESOURCE .. "_" .. g.core.common.Goods.RESOURCE.TYPE_STAMINA then
				if not g.core.model.User.activityLifeTimeCardData:isReceivedNet() then
					self._staminaTempInfo = {
						iter_7_1
					}
				elseif var_7_3 then
					var_7_2 = var_7_1.privi_time_limit
				end
			end

			local var_7_5 = var_7_4
			local var_7_6 = math.max(0, iter_7_1.time - var_7_4)

			var_7_5 = var_7_2 - iter_7_1.num < math.ceil(var_7_6 / var_7_1.unit_time) and iter_7_1.time - var_7_1.unit_time * (var_7_2 - iter_7_1.num) or var_7_6 % var_7_1.unit_time == 0 and var_7_4 or var_7_4 - (var_7_1.unit_time - var_7_6 % var_7_1.unit_time)

			local var_7_7 = math.uint64_lt(iter_7_1.num, var_7_2, false)

			if not var_7_7 then
				var_0_3:dispatchEvent(var_0_1.EVENT_FORCE_FRESH, false, {
					fullCountdown = 0,
					nextCountdown = 0,
					isMax = true,
					info = var_7_1,
					curValue = iter_7_1.num,
					startTime = var_7_5,
					endTime = iter_7_1.time
				})
			end

			local var_7_8 = self._recoverPools[var_7_0]

			if self._recoverPools[var_7_0] then
				var_7_8.curValue = iter_7_1.num
				var_7_8.startTime = var_7_5
				var_7_8.endTime = iter_7_1.time
			elseif var_7_7 then
				self._recoverPools[var_7_0] = {
					isMax = false,
					info = var_7_1,
					curValue = iter_7_1.num,
					startTime = var_7_5,
					endTime = iter_7_1.time
				}
			end
		end
	end

	if not self._runningRecover then
		self._runningRecover = true
		self._scheduleHandler = g.core.common.Scheduler:newSchedule(handler(self, self._onRecover), var_0_2)
	end
end

function AutoRecoverService:_checkStaminaTempInfo()
	if not self._staminaTempInfo or not g.core.model.User.activityLifeTimeCardData:isReceivedNet() then
		return
	end

	self:_updateRecoverPools(self._staminaTempInfo)

	self._staminaTempInfo = nil
end

function AutoRecoverService:_checkStaminaNeedAddToRecoverPool()
	local var_9_0 = self._recoverPools[var_0_5.TYPE_RESOURCE .. "_" .. g.core.common.Goods.RESOURCE.TYPE_STAMINA]

	if not self._recoverPools[var_0_5.TYPE_RESOURCE .. "_" .. g.core.common.Goods.RESOURCE.TYPE_STAMINA] then
		local var_9_1

		var_9_0 = {
			curValue = g.core.model.User.resourceData:getVit(),
			startTime = var_0_4:getTime()
		}

		for iter_9_0 = 1, g.core.config.basic_figure_info.getLength() do
			var_9_1 = g.core.config.basic_figure_info.indexOf(iter_9_0)

			if var_9_1.type == var_0_5.TYPE_RESOURCE and var_9_1.value == g.core.common.Goods.RESOURCE.TYPE_STAMINA then
				break
			end
		end

		var_9_0.info = var_9_1
	end

	local var_9_2 = var_9_0.info.time_limit

	if g.core.model.User.activityLifeTimeCardData:isSubscription(true) then
		var_9_2 = var_9_0.info.privi_time_limit

		if var_9_0.curValue > 0 then
			g.core.model.User.resourceData:setVit(var_9_0.curValue + (var_9_0.info.privi_time_limit - var_9_0.info.time_limit))

			var_9_0.curValue = var_9_0.curValue + (var_9_0.info.privi_time_limit - var_9_0.info.time_limit)
		end
	end

	var_9_0.isMax = not math.uint64_lt(var_9_0.curValue, var_9_2, false)
	var_9_0.endTime = var_9_0.startTime + (var_9_2 - var_9_0.curValue) * var_9_0.info.unit_time

	if not var_9_0.isMax then
		self._recoverPools[var_0_5.TYPE_RESOURCE .. "_" .. g.core.common.Goods.RESOURCE.TYPE_STAMINA] = var_9_0
	end
end

function AutoRecoverService:_onRecover()
	local var_10_0 = var_0_4:getTime()

	if var_10_0 - self._exeTimerLastTime < var_0_2 then
		return
	else
		self._exeTimerLastTime = var_10_0

		self:_checkStaminaTempInfo()

		if not next(self._recoverPools) then
			return
		end
	end

	for iter_10_0, iter_10_1 in pairs(self._recoverPools) do
		local var_10_1 = self:_recoverStep(iter_10_1, var_10_0)
		local var_10_2, var_10_3

		if iter_10_1.isMax then
			self._recoverPools[iter_10_0] = nil
			var_10_2 = clone(iter_10_1)
			var_10_3 = math.max(0, var_10_0 - iter_10_1.startTime)
		end

		var_10_2.nextCountdown = iter_10_1.info.unit_time - var_10_3 % iter_10_1.info.unit_time
		var_10_2.fullCountdown = var_10_2.endTime - var_10_0

		var_0_3:dispatchEvent(var_0_1.EVENT_RECOVER_STEP, false, var_10_2)

		if var_10_1 > 0 then
			self:_setRecoverValue(var_10_2)
			var_0_3:dispatchEvent(var_0_1.EVENT_RECOVER_NOTIFY, false, var_10_2)
		end
	end
end

function AutoRecoverService:_setRecoverValue(arg_11_1)
	local var_11_0 = {
		id = arg_11_1.info.value,
		num = arg_11_1.curValue
	}

	if arg_11_1.info.value == var_0_5.RESOURCE.TYPE_STAMINA then
		var_11_0.num = math.max(0, var_11_0.num)

		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setVit(arg_11_1.curValue)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_ROB_NUM then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setRobNum(arg_11_1.curValue)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_REBEL_ATTACK then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setRebelAttack(arg_11_1.curValue)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_MYSTERY_SHOP_FREE_NUM then
		-- block empty
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_GUILD_DUN_TIME then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setResource(var_11_0)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_TIRED then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setTired(arg_11_1.curValue)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_BIOGRAPHIE then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setBioGraphie(arg_11_1.curValue)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_GRAIN then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setResource(var_11_0)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_ARMY_TOKEN then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setResource(var_11_0)
	elseif arg_11_1.info.value == var_0_5.RESOURCE.TYPE_GUILD_WAR then
		g.core.model.User.bagData:updateItem(var_0_0.BAG_TYPE.RESOURCE, var_11_0)
		g.core.model.User.resourceData:setResource(var_11_0)
	end
end

return AutoRecoverService
