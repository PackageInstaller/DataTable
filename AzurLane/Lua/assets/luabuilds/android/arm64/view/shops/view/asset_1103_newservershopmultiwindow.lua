class = var_0_10000

local var_0_0 = "NewServerShopMultiWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..msgbox.ShopMultiWindow"))

function var_0_1.InitWindow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}
	local var_1_1, var_1_2, var_1_3 = arg_1_1:CheckTimeLimit()

	setActive = var_7

	var_7(arg_1_0.timeLimitTF, var_1_1)

	if var_1_1 and var_1_2 then
		getProxy = var_7
		ActivityProxy = var_9

		local var_1_4 = var_7(var_9)

		var_1_10008 = var_7.getActivityById
		Item = var_1_10011
		var_1_10008 = var_1_10008(var_1_4, var_1_10011.getConfigData(var_1_0.id).link_id)
		pg = var_9

		local var_1_5 = var_9.TimeMgr.GetInstance()
		local var_1_6 = var_9.STimeDescS(var_1_5, var_1_10008.stopTime, "%m.%d")
		local var_1_7 = var_1_10008:IsMaintenanceFinish() and "eventshop_time_hint" or "eventshop_time_hint2"

		setText = var_1_5

		local var_1_8 = arg_1_0.timeLimitTF
		local var_1_9 = var_13.Find(var_1_8, "Text")

		i18n = var_1_10014

		var_1_5(var_1_9, var_1_10014(var_1_7, var_1_6))
	end

	Drop = var_7

	local var_1_10 = var_7.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	})
	local var_1_11 = var_7.getOwnedCount(var_1_10)

	math = var_1_10008

	local var_1_12 = var_1_10008.max

	math = var_10

	local var_1_13 = var_1_12(var_10.floor(var_1_11 / arg_1_1:getConfig("resource_num")), 1)

	if arg_1_1:getConfig("goods_purchase_limit") ~= 0 then
		local var_1_14 = arg_1_1:GetPurchasableCnt()

		math = var_10

		local var_1_15 = var_10.min
		local var_1_16 = var_1_13

		math = var_13
		var_1_13 = var_1_15(var_1_16, var_13.max(0, var_1_14))
	end

	;(function(arg_2_0)
		math = var_2_10001
		arg_2_0 = var_2_10001.max(arg_2_0, 1)
		math = var_1
		arg_2_0 = var_1.min(arg_2_0, var_1_13)
		arg_1_0.countTF.text = arg_2_0
		arg_1_0.curCount = arg_2_0

		local var_2_0 = arg_1_0.itemCountTF
		local var_2_1 = arg_1_1

		var_2_0.text = arg_2_0 * var_2.getConfig(var_2_1, "num")

		return
	end)(1)

	updateDrop = var_10

	local var_1_17 = arg_1_0.topItem

	var_10(var_12.Find(var_1_17, "left/IconTpl"), var_1_0)

	UpdateOwnDisplay = var_10

	var_10(arg_1_0.ownerTF, var_1_0)

	RegisterDetailButton = var_10

	var_10(arg_1_0, arg_1_0.detailTF, var_1_0)

	arg_1_0.nameTF.text = var_1_0:getConfig("name")

	local var_1_18 = arg_1_0.descTF
	local var_1_19

	if not var_1_0.desc then
		var_1_19 = var_1_0:getConfig("desc")
	end

	var_1_18.text = var_1_19
	updateDrop = var_1_18

	var_1_18(arg_1_0.bottomItem, var_1_0)

	onButton = var_1_18

	local var_1_20 = arg_1_0
	local var_1_21 = arg_1_0.confirmBtn

	local function var_1_22()
		if arg_1_2 then
			local var_3_0 = arg_1_2
			local var_3_1 = arg_1_1
			local var_3_2 = arg_1_0.curCount
			local var_3_3 = var_1_0

			var_3_0(var_3_1, var_3_2, var_4.getConfig(var_3_3, "name"))
		end

		local var_3_4 = arg_1_0

		var_0.Close(var_3_4)

		return
	end

	SFX_PANEL = var_15

	var_1_18(var_1_20, var_1_21, var_1_22, var_15)

	onButton = var_1_18

	var_1_18(arg_1_0, arg_1_0.leftBtn, function()
		var_0(arg_1_0.curCount - 1)

		return
	end)

	onButton = var_1_18

	var_1_18(arg_1_0, arg_1_0.rightBtn, function()
		var_0(arg_1_0.curCount + 1)

		return
	end)

	onButton = var_1_18

	var_1_18(arg_1_0, arg_1_0.maxBtn, function()
		var_0(var_1_13)

		return
	end)

	return
end

return var_0_1
