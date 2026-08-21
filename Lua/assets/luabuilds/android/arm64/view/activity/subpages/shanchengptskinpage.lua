local var_0_0 = class("ShanChengPtSkinPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.shop = arg_1_0.bg:Find("go")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	local var_2_0 = _.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_3_0)
		return arg_3_0:getConfig("config_client").pt_id == arg_2_0.activity:getConfig("config_client").pt_id
	end)

	onButton(arg_2_0, arg_2_0.shop, function()
		({
			warp = NewShopsScene.TYPE_ACTIVITY
		}).actId = var_2_0 and var_2_0.id

		arg_2_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
			warp = NewShopsScene.TYPE_ACTIVITY
		})

		return
	end)

	return
end

return var_0_0
