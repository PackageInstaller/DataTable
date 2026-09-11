local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init(arg_1_0)
	if var_0_1 then
		return
	end

	var_0_1 = true

	var_0_0.RefreshRedPoint(arg_1_0)
end

function var_0_0.InitRedPointKey(arg_2_0)
	manager.redPoint:addGroup(RedPointConst.ACTIVITY_MEMORY .. "_" .. arg_2_0, {
		RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. arg_2_0,
		RedPointConst.ACTIVITY_TASK .. "_" .. ActivityMemoryTools.GetTaskActivityID(arg_2_0)
	})
end

function var_0_0.RefreshRedPoint(arg_3_0)
	if manager.redPoint:getTipValue(RedPointConst.ACTIVITY_MEMORY .. "_" .. arg_3_0) == 1 then
		return
	end

	local var_3_0 = ActivityData:GetActivityData(arg_3_0)

	if not var_3_0 or var_3_0:IsActivitying() then
		return
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. arg_3_0, (ActivityTools.IsUnlockActivity(arg_3_0) and not (getData(RedPointConst.ACTIVITY_MEMORY_OPEN, tostring(arg_3_0)) or false) or nil) and true and 1 or 0)
end

return var_0_0
