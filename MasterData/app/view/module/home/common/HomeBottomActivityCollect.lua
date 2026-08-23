local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock
local H5ActivityConst = require("app.view.module.H5Activity.const.H5ActivityConst")
local var_0_3 = {
	Cfg = {
		[g.core.const.ConstMgr.FUNCTION_TYPE.H5_ACTIVITY] = function()
			if var_0_1:isModuleUnlock(var_0_0.H5_ACTIVITY) then
				return g.core.model.User.h5ActivityData:getH5ActivityInfo()
			end
		end,
		[g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINES_DAY_VOTE] = function()
			if var_0_1:isModuleUnlock(var_0_0.VALENTINES_DAY_VOTE) then
				if g.core.model.User.valentinesDayVoteData:isProcess() then
					return {
						{
							timeStyle = 1,
							redId = 370,
							info = g.core.model.User.valentinesDayVoteData:getEnterBtnInfo(),
							state = H5ActivityConst.ACTIVITY_STATE.OPEN
						}
					}
				end
			end
		end,
		[g.core.const.ConstMgr.FUNCTION_TYPE.HALF_ANNIVERSARY] = function()
			if var_0_1:isModuleUnlock(var_0_0.HALF_ANNIVERSARY) then
				if g.core.model.User.halfAnniversaryData:isActivityOpen() then
					return {
						{
							timeStyle = 2,
							redId = 409,
							info = g.core.model.User.halfAnniversaryData:getHalfAnniversaryBtnInfo(),
							state = H5ActivityConst.ACTIVITY_STATE.OPEN
						}
					}
				end
			end
		end
	}
}

function var_0_3.calHomeBottomShowActivitys()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(var_0_3.Cfg) do
		local var_4_1 = iter_4_1()

		if var_4_1 and next(var_4_1) then
			for iter_4_2 = 1, #var_4_1 do
				table.insert(var_4_0, var_4_1[iter_4_2])
			end
		end
	end

	table.sort(var_4_0, function(arg_5_0, arg_5_1)
		if arg_5_0.info.start_time ~= arg_5_1.info.start_time then
			return arg_5_0.info.start_time > arg_5_1.info.start_time
		end

		if arg_5_0.info.activity_id ~= arg_5_1.info.activity_id then
			return arg_5_0.info.activity_id < arg_5_1.info.activity_id
		end

		return false
	end)

	return var_4_0
end

return var_0_3
