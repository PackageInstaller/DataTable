class = var_0_10000

local var_0_0 = var_0_10000("BiliTracker")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	TRACKING_USER_LEVELUP = var_1_10004

	if arg_2_1 == var_1_10004 then
		originalPrint = var_1_10004

		var_1_10004("tracking lvl:" .. arg_2_3)

		pg = var_1_10004

		local var_2_0 = var_1_10004.SdkMgr.GetInstance()

		var_4.SdkLevelUp(var_2_0)
	end

	return
end

return var_0_0
