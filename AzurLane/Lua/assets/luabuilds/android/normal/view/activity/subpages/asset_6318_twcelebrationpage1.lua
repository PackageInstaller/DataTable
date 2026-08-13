class = var_0_10000

local var_0_0 = "TWCelebrationPage1"

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
	onButton = var_1_10001

	var_1_10001(arg_2_0, arg_2_0.shop, function()
		configClinet = var_2_10000

		if var_2_10000.shopLinkActID then
			getProxy = var_3_0
			ActivityProxy = var_2_10001
			var_2_10001 = var_3_0(var_2_10001)

			local var_3_0 = var_3_0.getActivitiesById

			configClinet = var_2_10002

			if not var_3_0(var_2_10001, var_2_10002.shopLinkActID) then
				underscore = var_3_0
				var_3_0 = var_3_0.detect
				getProxy = var_2_10001
				ActivityProxy = var_2_10002

				local var_3_1 = var_2_10001(var_2_10002)

				var_2_10001 = var_2_10001.getActivitiesByType
				ActivityConst = var_2_10003
				var_3_0 = var_3_0(var_2_10001(var_3_1, var_2_10003.ACTIVITY_TYPE_SHOP), function(arg_4_0)
					return not arg_4_0:isEnd()
				end)
			end

			if not var_3_0 or var_3_0:isEnd() then
				pg = var_2_10001

				local var_3_2 = var_2_10001.TipsMgr.GetInstance()
				local var_3_3 = var_1.ShowTips

				i18n = var_2_10003

				var_3_3(var_3_2, var_2_10003("common_activity_end"))

				return
			end

			local var_3_4 = arg_2_0
			local var_3_5 = var_1.emit

			ActivityMediator = var_2_10003

			local var_3_6 = var_2_10003.GO_SHOPS_LAYER
			local var_3_7 = {}

			NewShopsScene = var_2_10005
			var_3_7.warp = var_2_10005.TYPE_ACTIVITY
			var_3_7.actId = var_3_0.id

			var_3_5(var_3_4, var_3_6, var_3_7)

			return
		end
	end)

	return
end

return var_0_1
