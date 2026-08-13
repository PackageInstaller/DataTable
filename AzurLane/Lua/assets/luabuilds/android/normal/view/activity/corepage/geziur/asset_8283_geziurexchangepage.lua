class = var_0_10000

local var_0_0 = "GeZiURExchangePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaUrExchangePage"))

local function var_0_2(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.SdkMgr.GetInstance()
	local var_1_1 = var_1.GetChannelUIDIncludeHarmony(var_1_0)
	local var_1_2 = arg_1_0._tf

	return (var_2.Find(var_1_2, "AD/rw/hx_ch" .. var_1_1))
end

function var_0_1.Hx4Channel(arg_2_0)
	local var_2_0 = var_0_2(arg_2_0)

	IsNil = var_2

	if not var_2(var_2_0) then
		setActive = var_2

		local var_2_1 = var_2_0

		HXSet = var_1_10004

		var_2(var_2_1, var_1_10004.isHx())
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)
	arg_3_0:Hx4Channel()

	return
end

return var_0_1
