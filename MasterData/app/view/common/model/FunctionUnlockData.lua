local var_0_0 = g.core.const.ConstMgr.FuncUnlockConst
local var_0_1 = g.core.config.function_info
local FunctionUnlockData = class("FunctionUnlockData")

function FunctionUnlockData:ctor()
	self:initData()
end

function FunctionUnlockData:initData()
	return
end

function FunctionUnlockData:isNewFuncUnlocked(arg_3_1)
	arg_3_1 = self:isValidFunctionId(arg_3_1)

	if arg_3_1 then
		if not self:_isOtherCondFunc(arg_3_1) then
			return false
		end

		if self:_isSavedUnlockedState(arg_3_1) then
			return false
		else
			return g.core.common.ModuleUnlock:isModuleUnlock(arg_3_1)
		end
	end
end

function FunctionUnlockData:_isOtherCondFunc(arg_4_1)
	if arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS then
		if g.core.common.ServerTime:getOpenDays() < g.core.const.ConstMgr.GuildBossConst.SHOW_NEED_OPEN_DAYS then
			return false
		end
	elseif arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.PERMANENT_RECHARGE then
		if not g.core.model.User.activityPermanentRechargeData:isShowEntrance() then
			return false
		end
	elseif arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG then
		if not g.core.model.User.newSlgData:isOpen() then
			return false
		end
	elseif arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.WEDDING_ACTIVITY then
		if not g.core.model.User.weddingActivityData:isOpen() then
			return false
		end
	elseif arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_RECRUIT then
		if g.core.common.ModuleUnlock:isModuleUnlock(arg_4_1) and g.core.model.User.userBackData:showEntrance() then
			local var_4_0 = g.core.model.User.userBackData:getLostDay()
			local var_4_1 = {}

			for iter_4_0 = 1, g.core.config.back_turn_info.getLength() do
				local var_4_3 = g.core.config.back_turn_info.indexOf(iter_4_0)

				if var_4_0 >= var_4_3.day and var_4_0 < var_4_3.day_max then
					var_4_1[#var_4_1 + 1] = var_4_3.recruit_id

					break
				end
			end

			return #var_4_1 > 0
		else
			return false
		end
	elseif arg_4_1 == g.core.const.ConstMgr.FUNCTION_TYPE.PUBG then
		return g.core.model.User.pubgData:isActivityOpen()
	end

	return true
end

function FunctionUnlockData:isNewFuncUnlockedWithCustomData(arg_5_1)
	return self:isNewFuncUnlocked(arg_5_1 and arg_5_1.functionId)
end

function FunctionUnlockData:saveUnlockedFunc(arg_6_1)
	arg_6_1 = self:isValidFunctionId(arg_6_1)

	if not arg_6_1 then
		return
	elseif self:_isSavedUnlockedState(arg_6_1) then
		return
	elseif g.core.common.ModuleUnlock:isModuleUnlock(arg_6_1) then
		local var_6_0 = self:_getJsonMap()

		var_6_0[self:_getSaveKey(arg_6_1)] = var_0_0.SAVED_UNLOCK_STATE.UNLOCKED

		g.core.common.Storage:save(var_0_0.JSON_NAME, var_6_0)
	else
		g.core.log:info("--------   功能未解锁，“已解锁”状态设置无效， functionId: ", arg_6_1)
	end
end

function FunctionUnlockData:saveUnlockedFuncList(arg_7_1)
	if type(arg_7_1) ~= "table" then
		return
	end

	local var_7_0 = self:_getJsonMap()
	local var_7_1 = false

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_2 = self:isValidFunctionId(iter_7_1)

		if var_7_2 and not self:_isSavedUnlockedState(var_7_2) and g.core.common.ModuleUnlock:isModuleUnlock(var_7_2) then
			var_7_1 = true
			var_7_0[self:_getSaveKey(var_7_2)] = var_0_0.SAVED_UNLOCK_STATE.UNLOCKED
		end
	end

	if var_7_1 then
		g.core.common.Storage:save(var_0_0.JSON_NAME, var_7_0)
	end
end

function FunctionUnlockData:isValidFunctionId(arg_8_1)
	arg_8_1 = checknumber(arg_8_1)

	if arg_8_1 == 0 then
		g.core.log:info("---------      func:isNewUnlock input invalid functionId:", arg_8_1)

		return false
	elseif var_0_1.hasData(arg_8_1) then
		return arg_8_1
	else
		g.core.log:info("---------      func:isNewUnlock input invalid functionId:", arg_8_1)

		return false
	end
end

function FunctionUnlockData:_isSavedUnlockedState(arg_9_1)
	return self:_getJsonMap()[self:_getSaveKey(arg_9_1)] == var_0_0.SAVED_UNLOCK_STATE.UNLOCKED
end

function FunctionUnlockData:_getSaveKey(arg_10_1)
	return tostring(arg_10_1)
end

function FunctionUnlockData:_getJsonMap()
	return g.core.common.Storage:load(var_0_0.JSON_NAME) or {}
end

return FunctionUnlockData
