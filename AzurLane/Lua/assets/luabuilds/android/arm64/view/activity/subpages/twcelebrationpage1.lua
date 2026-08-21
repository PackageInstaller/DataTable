local var_0_0 = class("TWCelebrationPage1", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.shop = arg_1_0.bg:Find("go")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.shop, function()
		if configClinet.shopLinkActID then
			local var_3_0 = getProxy(ActivityProxy):getActivitiesById(configClinet.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_4_0)
				return not arg_4_0:isEnd()
			end)

			if not var_3_0 or var_3_0:isEnd() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			arg_2_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
				warp = NewShopsScene.TYPE_ACTIVITY,
				actId = var_3_0.id
			})

			return
		end
	end)

	return
end

return var_0_0
