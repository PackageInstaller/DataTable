local var_0_0 = g.core.config.check_in_info
local var_0_1 = g.core.common.ModuleUnlock
local HomeAutoConditions = import(".HomeAutoConditions")
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = 0

function var_0_3.checkHaveLoginPopShow()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if g.core.module.ModuleManager:getCurModule().module == g.view.entrance.HOME then
		var_0_5 = 1

		local var_1_1 = var_0_3.getShowPopList()

		if #var_1_1 > 0 then
			g.core.utils.Tools.exeQueue(var_1_1)

			var_0_4 = var_1_1
			var_0_4[#var_0_4 + 1] = var_0_3.checkListIsEnd
		end
	end
end

function var_0_3.getSortPopListData()
	local var_2_0 = {}

	for iter_2_0 = 1, var_0_0.getLength() do
		table.insert(var_2_0, (var_0_0.indexOf(iter_2_0).toObject()))
	end

	if #var_2_0 > 0 then
		table.sort(var_2_0, function(arg_3_0, arg_3_1)
			return arg_3_0.priority_level > arg_3_1.priority_level
		end)
	end

	if config.DEBUG_VERSION then
		local var_2_1 = g.core.common.Storage:load("closeOpenScreen.json", false)

		if var_2_1 and var_2_1.isClose then
			return {}
		else
			return var_2_0
		end
	else
		return var_2_0
	end
end

function var_0_3.getShowPopList()
	local var_4_0 = {}
	local var_4_1 = var_0_3.getSortPopListData()
	local var_4_2 = g.core.model.User.homeData

	if #var_4_1 > 0 then
		for iter_4_0 = 1, #var_4_1 do
			local var_4_3 = var_4_1[iter_4_0].function_id
			local var_4_4 = HomeAutoConditions.AUTO_POPUP_COND[var_4_1[iter_4_0].function_id]

			if var_0_1:isModuleUnlock(var_4_1[iter_4_0].function_id) and HomeAutoConditions.AUTO_POPUP_COND[var_4_1[iter_4_0].function_id] then
				if HomeAutoConditions.AUTO_POPUP_COND[var_4_1[iter_4_0].function_id].cond and HomeAutoConditions.AUTO_POPUP_COND[var_4_1[iter_4_0].function_id].cond() and not g.core.model.User.homeData:isRecordPop(var_4_1[iter_4_0].function_id) then
					table.insert(var_4_0, function(arg_5_0)
						var_4_2:setAutoPopFunc(var_4_3)
						g.core.module.ModuleManager:pushModule(var_4_4.module, {
							endcall = arg_5_0,
							param = var_4_4.params
						})
					end)
				end
			end
		end
	end

	return var_4_0
end

function var_0_3.clearPopList()
	var_0_4 = nil
end

function var_0_3.isCurHavePopup()
	if not var_0_4 or #var_0_4 == 0 then
		return false
	else
		return true
	end
end

function var_0_3.isShowAllPopToday()
	return var_0_5 >= #var_0_3.getShowPopList()
end

function var_0_3.checkNextSevenPop()
	local var_9_0 = HomeAutoConditions.AUTO_POPUP_COND[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN]

	if var_0_1:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN) and HomeAutoConditions.AUTO_POPUP_COND[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN] then
		if HomeAutoConditions.AUTO_POPUP_COND[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN].cond and HomeAutoConditions.AUTO_POPUP_COND[g.core.const.ConstMgr.FUNCTION_TYPE.SEVEN_DAYS_SIGN_IN].cond() then
			local function var_9_1(arg_10_0)
				var_0_5 = var_0_5 + 1

				g.core.common.Scheduler:newScheduleOnce(function(arg_11_0)
					g.core.module.ModuleManager:pushModule(var_9_0.module, {
						endcall = arg_10_0
					})
				end, 0.2)
			end

			if var_0_4 then
				table.insert(var_0_4, var_9_1)
			else
				var_0_4 = {
					var_9_1
				}

				g.core.utils.Tools.exeQueue(var_0_4)
			end

			var_0_4[#var_0_4 + 1] = var_0_3.checkListIsEnd
		end
	end
end

function var_0_3.checkListIsEnd(arg_12_0)
	if var_0_4 then
		if #var_0_4 == 0 then
			var_0_4 = nil
			var_0_5 = #var_0_3.getShowPopList()

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.HOME_AUTO_POP_END, false)
		else
			arg_12_0()
		end
	end
end

return var_0_3
