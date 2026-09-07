local NewServerShopMultiWindow = class("NewServerShopMultiWindow", import("..msgbox.ShopMultiWindow"))

function NewServerShopMultiWindow:InitWindow(arg_1_1, arg_1_2)
	local var_1_0 = {
		id = arg_1_1:getConfig("goods")[1],
		type = arg_1_1:getConfig("type"),
		count = arg_1_1:getConfig("num")
	}
	local var_1_1, var_1_2, var_1_3 = arg_1_1:CheckTimeLimit()

	setActive(self.timeLimitTF, var_1_1)

	if var_1_1 and var_1_2 then
		local var_1_4 = getProxy(ActivityProxy):getActivityById(Item.getConfigData(var_1_0.id).link_id)

		setText(self.timeLimitTF:Find("Text"), i18n(var_1_4:IsMaintenanceFinish() and "eventshop_time_hint" or "eventshop_time_hint2", (pg.TimeMgr.GetInstance():STimeDescS(var_1_4.stopTime, "%m.%d"))))
	end

	local var_1_5 = math.max(math.floor(Drop.New({
		type = arg_1_1:getConfig("resource_category"),
		id = arg_1_1:getConfig("resource_type")
	}):getOwnedCount() / arg_1_1:getConfig("resource_num")), 1)

	if arg_1_1:getConfig("goods_purchase_limit") ~= 0 then
		var_1_5 = math.min(var_1_5, math.max(0, (arg_1_1:GetPurchasableCnt())))
	end

	local function var_1_6(arg_2_0)
		arg_2_0 = math.max(arg_2_0, 1)
		arg_2_0 = math.min(arg_2_0, var_1_5)
		self.countTF.text = arg_2_0
		self.curCount = arg_2_0
		self.itemCountTF.text = arg_2_0 * arg_1_1:getConfig("num")

		return
	end

	var_1_6(1)
	updateDrop(self.topItem:Find("left/IconTpl"), var_1_0)
	UpdateOwnDisplay(self.ownerTF, var_1_0)
	RegisterDetailButton(self, self.detailTF, var_1_0)

	self.nameTF.text = var_1_0:getConfig("name")
	self.descTF.text = var_1_0.desc or var_1_0:getConfig("desc")

	updateDrop(self.bottomItem, var_1_0)
	onButton(self, self.confirmBtn, function()
		if arg_1_2 then
			arg_1_2(arg_1_1, self.curCount, var_1_0:getConfig("name"))
		end

		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.leftBtn, function()
		var_1_6(self.curCount - 1)

		return
	end)
	onButton(self, self.rightBtn, function()
		var_1_6(self.curCount + 1)

		return
	end)
	onButton(self, self.maxBtn, function()
		var_1_6(var_1_5)

		return
	end)

	return
end

return NewServerShopMultiWindow
