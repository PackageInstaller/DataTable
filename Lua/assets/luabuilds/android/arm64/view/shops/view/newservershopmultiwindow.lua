local var_0_0 = class("NewServerShopMultiWindow", import("..msgbox.ShopMultiWindow"))

function var_0_0.InitWindow(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}
	local var_1_1, var_1_2, var_1_3 = arg_1_1:CheckTimeLimit()

	setActive(arg_1_0.timeLimitTF, var_1_1)

	if var_1_1 and var_1_2 then
		local var_1_4 = getProxy(ActivityProxy):getActivityById(Item.getConfigData(var_1_0.id).link_id)
		local var_1_5 = pg.TimeMgr.GetInstance()

		setText(arg_1_0.timeLimitTF:Find("Text"), i18n(var_1_4:IsMaintenanceFinish() and "eventshop_time_hint" or "eventshop_time_hint2", (var_1_5:STimeDescS(var_1_4.stopTime, "%m.%d"))))
	end

	local var_1_6 = Drop.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	})
	local var_1_7 = math.max(math.floor(var_1_6:getOwnedCount() / arg_1_1:getConfig("resource_num")), 1)

	if arg_1_1:getConfig("goods_purchase_limit") ~= 0 then
		var_1_7 = math.min(var_1_7, math.max(0, (arg_1_1:GetPurchasableCnt())))
	end

	;(function(arg_2_0)
		arg_2_0 = math.max(arg_2_0, 1)
		arg_2_0 = math.min(arg_2_0, var_1_7)
		arg_1_0.countTF.text = arg_2_0
		arg_1_0.curCount = arg_2_0
		arg_1_0.itemCountTF.text = arg_2_0 * arg_1_1:getConfig("num")

		return
	end)(1)
	updateDrop(arg_1_0.topItem:Find("left/IconTpl"), var_1_0)
	UpdateOwnDisplay(arg_1_0.ownerTF, var_1_0)
	RegisterDetailButton(arg_1_0, arg_1_0.detailTF, var_1_0)

	arg_1_0.nameTF.text = var_1_0:getConfig("name")
	arg_1_0.descTF.text = var_1_0.desc or var_1_0:getConfig("desc")

	updateDrop(arg_1_0.bottomItem, var_1_0)
	onButton(arg_1_0, arg_1_0.confirmBtn, function()
		if arg_1_2 then
			arg_1_2(arg_1_1, arg_1_0.curCount, var_1_0:getConfig("name"))
		end

		arg_1_0:Close()

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.leftBtn, function()
		var_0(arg_1_0.curCount - 1)

		return
	end)
	onButton(arg_1_0, arg_1_0.rightBtn, function()
		var_0(arg_1_0.curCount + 1)

		return
	end)
	onButton(arg_1_0, arg_1_0.maxBtn, function()
		var_0(var_1_7)

		return
	end)

	return
end

return var_0_0
