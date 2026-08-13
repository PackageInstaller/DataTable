class = var_0_10000

local var_0_0 = "NewServerShopMultiWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..msgbox.ShopMultiWindow"))

function var_0_1.InitWindow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}
	local var_1_1, var_1_2, var_1_3 = arg_1_1:CheckTimeLimit()

	setActive = var_1_10007

	var_1_10007(arg_1_0.timeLimitTF, var_1_1)

	if var_1_1 and var_1_2 then
		getProxy = var_1_10007
		ActivityProxy = var_8

		local var_1_4 = var_1_10007(var_8)
		local var_1_5 = var_1_10007.getActivityById

		Item = var_1_10010

		local var_1_6 = var_1_5(var_1_4, var_1_10010.getConfigData(var_1_0.id).link_id)

		pg = var_1_4

		local var_1_7 = var_1_4.TimeMgr.GetInstance()
		local var_1_8 = var_9.STimeDescS(var_1_7, var_1_6.stopTime, "%m.%d")
		local var_1_9 = var_1_6
		local var_1_10 = var_1_6.IsMaintenanceFinish(var_1_9) and "eventshop_time_hint" or "eventshop_time_hint2"

		setText = var_1_9

		local var_1_11 = arg_1_0.timeLimitTF
		local var_1_12 = var_12.Find(var_1_11, "Text")

		i18n = var_1_11

		var_1_9(var_1_12, var_1_11(var_1_10, var_1_8))
	end

	Drop = var_1_10007

	local var_1_13 = var_1_10007.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	})
	local var_1_14 = var_7.getOwnedCount(var_1_13)

	math = var_1_13

	local var_1_15 = var_1_13.max

	math = var_9

	local var_1_16 = var_1_15(var_9.floor(var_1_14 / arg_1_1:getConfig("resource_num")), 1)

	if arg_1_1:getConfig("goods_purchase_limit") ~= 0 then
		local var_1_17 = arg_1_1
		local var_1_18 = arg_1_1.GetPurchasableCnt(var_1_17)

		math = var_1_17

		local var_1_19 = var_1_17.min
		local var_1_20 = var_1_16

		math = var_12
		var_1_16 = var_1_19(var_1_20, var_12.max(0, var_1_18))
	end

	;(function(arg_2_0)
		math = var_2_10001
		arg_2_0 = var_2_10001.max(arg_2_0, 1)
		math = var_1
		arg_2_0 = var_1.min(arg_2_0, var_1_16)
		arg_1_0.countTF.text = arg_2_0
		arg_1_0.curCount = arg_2_0

		local var_2_0 = arg_1_0.itemCountTF
		local var_2_1 = arg_1_1

		var_2_0.text = arg_2_0 * var_2.getConfig(var_2_1, "num")

		return
	end)(1)

	updateDrop = var_10

	local var_1_21 = arg_1_0.topItem

	var_10(var_11.Find(var_1_21, "left/IconTpl"), var_1_0)

	UpdateOwnDisplay = var_10

	var_10(arg_1_0.ownerTF, var_1_0)

	RegisterDetailButton = var_10

	var_10(arg_1_0, arg_1_0.detailTF, var_1_0)

	arg_1_0.nameTF.text = var_1_0:getConfig("name")

	local var_1_22 = arg_1_0.descTF
	local var_1_23

	if not var_1_0.desc then
		var_1_23 = var_1_0:getConfig("desc")
	end

	var_1_22.text = var_1_23
	updateDrop = var_1_22

	var_1_22(arg_1_0.bottomItem, var_1_0)

	onButton = var_1_22

	local var_1_24 = arg_1_0
	local var_1_25 = arg_1_0.confirmBtn

	local function var_1_26()
		if arg_1_2 then
			local var_3_0 = arg_1_2
			local var_3_1 = arg_1_1
			local var_3_2 = arg_1_0.curCount
			local var_3_3 = var_1_0

			var_3_0(var_3_1, var_3_2, var_3.getConfig(var_3_3, "name"))
		end

		local var_3_4 = arg_1_0

		var_0.Close(var_3_4)

		return
	end

	SFX_PANEL = var_1_10014

	var_1_22(var_1_24, var_1_25, var_1_26, var_1_10014)

	onButton = var_1_22

	var_1_22(arg_1_0, arg_1_0.leftBtn, function()
		var_0(arg_1_0.curCount - 1)

		return
	end)

	onButton = var_1_22

	var_1_22(arg_1_0, arg_1_0.rightBtn, function()
		var_0(arg_1_0.curCount + 1)

		return
	end)

	onButton = var_1_22

	var_1_22(arg_1_0, arg_1_0.maxBtn, function()
		var_0(var_1_16)

		return
	end)

	return
end

return var_0_1
