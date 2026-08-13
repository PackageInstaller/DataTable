class = var_0_10000

local var_0_0 = "ChargeOrPurchaseHandler"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.Mediator)

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_1

	local var_1_0 = var_1.m02

	var_1.registerMediator(var_1_0, arg_1_0)

	return
end

function var_0_1.ChargeOrPurchaseAsyn(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.FetchFirstChargeIds(var_3_0, arg_2_1, function(arg_4_0)
				var_2_0 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.ChargeOrPurchase(var_5_0, var_2_0, arg_2_1)
			arg_5_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_1.FetchFirstChargeIds(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1

	if not arg_6_1.isChargeType(var_6_0) then
		arg_6_2()

		return
	end

	getProxy = var_3
	ShopsProxy = var_6_0

	local var_6_1 = var_3(var_6_0)

	local function var_6_2()
		local var_7_0 = var_6_1
		local var_7_1 = var_0.getFirstChargeList(var_7_0)

		arg_6_2(var_7_1)

		return
	end

	if var_6_1:ShouldRefreshChargeList() then
		pg = var_5

		local var_6_3 = var_5.m02
		local var_6_4 = var_5.sendNotification

		GAME = var_1_10007

		var_6_4(var_6_3, var_1_10007.GET_CHARGE_LIST, {
			callback = var_6_2
		})
	else
		var_6_2()
	end

	return
end

function var_0_1.ChargeOrPurchase(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2:isChargeType() then
		if arg_8_2:isMonthCard() or arg_8_2:isGiftBox() or arg_8_2:isItemBox() or arg_8_2:isPassItem() then
			return arg_8_0:ChargeMonthCardAndGiftPack(arg_8_1, arg_8_2)
		elseif arg_8_2:isGem() then
			return arg_8_0:ChargeGem(arg_8_1, arg_8_2)
		end
	else
		arg_8_0:PurchaseItem(arg_8_2)
	end

	return
end

function var_0_1.PurchaseItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1
	local var_9_1 = arg_9_1.getDropInfo(var_9_0)

	assert = var_9_0

	local var_9_2 = var_9_1.type

	DROP_TYPE_ITEM = var_1_10005

	var_9_0(var_9_2 == var_1_10005)

	Item = var_9_0

	local var_9_3 = var_9_0.getConfigData(var_9_1.id)
	local var_9_4 = {
		isLocalPrice = false,
		isChargeType = false,
		isMonthCard = false,
		commodity = arg_9_1,
		icon = var_9_3.icon,
		name = var_9_3.name
	}

	i18n = var_5
	var_9_4.tipExtra = var_5("charge_title_getitem")
	var_9_4.extraItems = arg_9_1:GetDropList()
	var_9_4.price = arg_9_1:getConfig("resource_num")
	var_9_4.tagType = arg_9_1:getConfig("tag")

	function var_9_4.onYes()
		local var_10_0 = arg_9_0

		var_0.Purchase(var_10_0, var_9_3.name, arg_9_1)

		return
	end

	arg_9_0:ShowMsgBox(var_9_4)

	return
end

function var_0_1.ChargeMonthCardAndGiftPack(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:GetExtraServiceItem()
	local var_11_1 = arg_11_2:GetExtraDrop()
	local var_11_2 = arg_11_2:GetGemCnt()
	local var_11_3 = arg_11_2:GetBonusItem()
	local var_11_4, var_11_5 = arg_11_2:GetChargeTip()
	local var_11_6 = "chargeicon/" .. arg_11_2:getConfig("picture")
	local var_11_7 = arg_11_2:getConfig("name_display")
	local var_11_8 = arg_11_2:getConfig("money")
	local var_11_9 = arg_11_2:IsLocalPrice()
	local var_11_10 = arg_11_2:isMonthCard()
	local var_11_11 = arg_11_2
	local var_11_12 = arg_11_2.getConfig(var_11_11, "descrip_extra")

	table = var_11_11

	local var_11_13 = not var_11_11.contains(arg_11_1, arg_11_2.id) and arg_11_2:firstPayDouble() and 4 or arg_11_2:getConfig("tag")
	local var_11_14 = {
		isChargeType = true,
		commodity = arg_11_2,
		infoTip = arg_11_2:GetInfoTip(),
		icon = var_11_6,
		name = var_11_7,
		tipExtra = var_11_4,
		extraItems = var_11_0,
		price = var_11_8,
		isLocalPrice = var_11_9,
		tagType = var_11_13,
		isMonthCard = var_11_10,
		tipBonus = var_11_5,
		bonusItem = var_11_3,
		extraDrop = var_11_1,
		descExtra = var_11_12,
		onYes = function()
			local var_12_0 = arg_11_0

			var_0.Charge(var_12_0, arg_11_2)

			return
		end
	}

	arg_11_0:ShowMsgBox(var_11_14)

	return
end

function var_0_1.ChargeGem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2:getConfig("money")
	local var_13_1 = arg_13_2
	local var_13_2 = arg_13_2.getConfig(var_13_1, "gem")

	table = var_13_1

	local var_13_3 = not var_13_1.contains(arg_13_1, arg_13_2.id) and arg_13_2:firstPayDouble() and 4 or arg_13_2:getConfig("tag")

	if var_6 then
		var_13_2 = var_13_2 + arg_13_2:getConfig("gem")
	else
		var_13_2 = var_13_2 + arg_13_2:getConfig("extra_gem")
	end

	local var_13_4 = "chargeicon/" .. arg_13_2:getConfig("picture")
	local var_13_5 = arg_13_2:getConfig("name_display")
	local var_13_6 = arg_13_2:getConfig("money")
	local var_13_7 = arg_13_2
	local var_13_8 = arg_13_2.IsLocalPrice(var_13_7)

	i18n = var_13_7

	local var_13_9 = var_13_7("charge_start_tip", var_13_0, var_13_2)
	local var_13_10 = {
		isChargeType = true,
		commodity = arg_13_2,
		infoTip = arg_13_2:GetInfoTip(),
		icon = var_13_4,
		name = var_13_5,
		price = var_13_6,
		isLocalPrice = var_13_8,
		tagType = var_13_3,
		normalTip = var_13_9,
		onYes = function()
			local var_14_0 = arg_13_0

			var_0.Charge(var_14_0, arg_13_2)

			return
		end
	}

	arg_13_0:ShowMsgBox(var_13_10)

	return
end

function var_0_1.ShowMsgBox(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.addSubLayers

	Context = var_1_10004

	local var_15_2 = var_1_10004.New
	local var_15_3 = {}

	ChargeItemPanelMediator = var_1_10006
	var_15_3.mediator = var_1_10006
	ChargeItemPanelLayer = var_1_10006
	var_15_3.viewComponent = var_1_10006
	var_15_3.data = {
		panelConfig = arg_15_1
	}

	var_15_1(var_15_0, var_15_2(var_15_3))

	return
end

function var_0_1.Purchase(arg_16_0, arg_16_1, arg_16_2)
	pg = var_1_10003

	local var_16_0 = var_1_10003.MsgboxMgr.GetInstance()
	local var_16_1 = var_3.ShowMsgBox
	local var_16_2 = {}

	i18n = var_1_10006
	var_16_2.content = var_1_10006("charge_scene_buy_confirm", arg_16_2:getConfig("resource_num"), arg_16_1)

	function var_16_2.onYes()
		pg = var_2_10000

		local var_17_0 = var_2_10000.m02
		local var_17_1 = var_0.sendNotification

		GAME = var_2_10002

		var_17_1(var_17_0, var_2_10002.SHOPPING, {
			count = 1,
			id = arg_16_2.id
		})

		return
	end

	var_16_1(var_16_0, var_16_2)

	return
end

function var_0_1.Charge(arg_18_0, arg_18_1)
	ChargeConst = var_1_10002

	local var_18_1

	if var_1_10002.isNeedSetBirth() then
		local var_18_0 = arg_18_0

		var_18_1 = arg_18_0.addSubLayers
		Context = var_1_10004
		var_1_10004 = var_1_10004.New

		local var_18_2 = {}

		ChargeBirthdayMediator = var_1_10006
		var_18_2.mediator = var_1_10006
		ChargeBirthdayLayer = var_1_10006
		var_18_2.viewComponent = var_1_10006
		var_18_2.data = {}

		var_18_1(var_18_0, var_1_10004(var_18_2))
	else
		pg = var_18_1

		local var_18_3 = var_18_1.m02
		local var_18_4 = var_2.sendNotification

		GAME = var_1_10004

		var_18_4(var_18_3, var_1_10004.CHARGE_OPERATION, {
			shopId = arg_18_1.id
		})
	end

	return
end

function var_0_1.addSubLayers(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	assert = var_1_10004
	isa = var_1_10005

	local var_19_0 = arg_19_1

	Context = var_1_10007

	var_1_10004(var_1_10005(var_19_0, var_1_10007), "should be an instance of Context")

	getProxy = var_1_10004
	ContextProxy = var_5

	local var_19_1 = var_1_10004(var_5)
	local var_19_2 = var_4.getCurrentContext(var_19_1)

	if arg_19_2 then
		while var_19_2.parent do
			var_19_2 = var_19_2.parent
		end
	end

	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0.sendNotification

	GAME = var_1_10008

	var_19_4(var_19_3, var_1_10008.LOAD_LAYERS, {
		parentContext = var_19_2,
		context = arg_19_1,
		callback = arg_19_3
	})

	return
end

function var_0_1.Dispose(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.m02

	var_1.removeMediator(var_20_0, arg_20_0.__cname)

	return
end

return var_0_1
