class = var_0_10000

local var_0_0 = "ShanChengPtSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.shop = var_1.Find(var_1_1, "go")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	_ = var_1_10001

	local var_2_0 = var_1_10001.detect

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_2_1 = var_1_10002(var_1_10003)
	local var_2_2 = var_2.getActivitiesByType

	ActivityConst = var_1_10004

	local var_2_3 = var_2_0(var_2_2(var_2_1, var_1_10004.ACTIVITY_TYPE_SHOP), function(arg_3_0)
		local var_3_0 = arg_3_0:getConfig("config_client").pt_id
		local var_3_1 = arg_2_0.activity

		return var_3_0 == var_2.getConfig(var_3_1, "config_client").pt_id
	end)

	onButton = var_2

	var_2(arg_2_0, arg_2_0.shop, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.GO_SHOPS_LAYER
		local var_4_3 = {}

		NewShopsScene = var_2_10004
		var_4_3.warp = var_2_10004.TYPE_ACTIVITY

		local var_4_4

		if var_2_3 then
			var_4_4 = var_2_3.id
		end

		var_4_3.actId = var_4_4

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	return
end

return var_0_1
