class = var_0_10000

local var_0_0 = "BackYardExtendCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardBaseCard"))

function var_0_1.OnInit(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._content

	local function var_1_2()
		local var_2_0 = arg_1_0

		var_0.Unlock(var_2_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.Unlock(arg_3_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getRawData(var_3_0)

	if var_1.getExtendTrainPosShopId(var_3_1) then
		pg = var_3_0

		local var_3_2 = var_3_0.shop_template[var_2].resource_num

		_BackyardMsgBoxMgr = var_3_1

		local var_3_3 = var_3_1
		local var_3_4 = var_3_1.Show
		local var_3_5 = {}

		i18n = var_1_10008
		var_3_5.content = var_1_10008("backyard_backyardShipInfoLayer_quest_openPos", var_3_2)

		function var_3_5.onYes()
			getProxy = var_2_10000
			PlayerProxy = var_2_10002

			local var_4_0 = var_2_10000(var_2_10002)

			if var_0.getRawData(var_4_0) then
				local var_4_1 = var_0

				if var_0.getTotalGem(var_4_1) < var_3_2 then
					GoShoppingMsgBox = var_1
					i18n = var_4_1

					local var_4_2 = "switch_to_shop_tip_3"

					i18n = var_2_10006

					local var_4_3 = var_4_1(var_4_2, var_2_10006("word_gem"))

					ChargeScene = var_2_10004

					var_1(var_4_3, var_2_10004.TYPE_DIAMOND)

					goto label_4_0
				end
			end

			do
				local var_4_4 = arg_3_0
				local var_4_5 = var_1.emit

				NewBackYardShipInfoMediator = var_2_10004

				var_4_5(var_4_4, var_2_10004.EXTEND, var_0, 1)
			end

			::label_4_0::

			return
		end

		var_3_4(var_3_3, var_3_5)
	end

	return
end

return var_0_1
