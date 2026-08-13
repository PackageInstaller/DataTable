class = var_0_10000

local var_0_0 = "BackYardExtendCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BackYardBaseCard"))

function var_0_1.OnInit(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._content

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.Unlock(var_2_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10005)

	return
end

function var_0_1.Unlock(arg_3_0)
	getProxy = var_1_10001
	DormProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getRawData(var_3_0)

	if var_1.getExtendTrainPosShopId(var_3_1) then
		pg = var_3_1

		local var_3_2 = var_3_1.shop_template[var_2].resource_num

		_BackyardMsgBoxMgr = var_1_10004

		local var_3_3 = var_1_10004
		local var_3_4 = var_1_10004.Show
		local var_3_5 = {}

		i18n = var_1_10007
		var_3_5.content = var_1_10007("backyard_backyardShipInfoLayer_quest_openPos", var_3_2)

		function var_3_5.onYes()
			getProxy = var_2_10000
			PlayerProxy = var_2_10001

			local var_4_0 = var_2_10000(var_2_10001)

			if var_0.getRawData(var_4_0) and var_0:getTotalGem() < var_3_2 then
				GoShoppingMsgBox = var_1
				i18n = var_2
				var_2_10003 = "switch_to_shop_tip_3"
				i18n = var_2_10004

				local var_4_1 = var_2(var_2_10003, var_2_10004("word_gem"))

				ChargeScene = var_2_10003

				var_1(var_4_1, var_2_10003.TYPE_DIAMOND)
			else
				local var_4_2 = arg_3_0
				local var_4_3 = var_1.emit

				NewBackYardShipInfoMediator = var_2_10003

				var_4_3(var_4_2, var_2_10003.EXTEND, var_0, 1)
			end

			return
		end

		var_3_4(var_3_3, var_3_5)
	end

	return
end

return var_0_1
