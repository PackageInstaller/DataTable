class = var_0_10000

local var_0_0 = "SkinEncoreLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.rtSkinCoupon = var_1.Find(var_1_0, "AD/skin_coupon")

	local var_1_1 = arg_1_0._tf

	arg_1_0.rtLogin = var_1.Find(var_1_1, "AD/login")

	local var_1_2 = arg_1_0._tf

	arg_1_0.btnShop = var_1.Find(var_1_2, "AD/btn_shop")

	local var_1_3 = arg_1_0._tf

	arg_1_0.btnGift = var_1.Find(var_1_3, "AD/btn_gift")

	local var_1_4 = arg_1_0._tf

	arg_1_0.btnHelp = var_1.Find(var_1_4, "AD/btn_help")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.couponItemId = var_1.getConfig(var_2_0, "config_client").item_id

	local var_2_1 = arg_2_0.activity

	arg_2_0.couponGet = var_1.getData1(var_2_1)
	getProxy = var_1
	ActivityProxy = var_2_1

	local var_2_2 = var_1(var_2_1)
	local var_2_3 = var_1.getActivityById

	Item = var_3

	if var_2_3(var_2_2, var_3.getConfigData(arg_2_0.couponItemId).link_id) then
		local var_2_4 = var_1

		if not var_1.isEnd(var_2_4) then
			var_2_4 = var_1

			local var_2_5

			if not var_1.GetCanUsageCnt(var_2_4) then
				var_2_5 = 0
			end

			arg_2_0.couponCount = var_2_5
			getProxy = var_2_5
			ActivityProxy = var_2_4

			local var_2_6 = var_2_5(var_2_4)
			local var_2_7 = var_2.getActivityById
			local var_2_8 = arg_2_0.activity

			arg_2_0.subActivity = var_2_7(var_2_6, var_4.getConfig(var_2_8, "config_client").sub_act_id)
			arg_2_0.nday = arg_2_0.subActivity.data3
			getProxy = var_2
			TaskProxy = var_2_6
			arg_2_0.taskProxy = var_2(var_2_6)

			local var_2_9 = arg_2_0.subActivity

			arg_2_0.taskGroup = var_2.getConfig(var_2_9, "config_data")
			updateActivityTaskStatus = var_2

			return var_2(arg_2_0.subActivity)
		end
	end
end

function var_0_1.GetPageLink(arg_3_0)
	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client").sub_act_id

	return {
		var_3_1
	}
end

function var_0_1.OnFirstFlush(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnHelp

	local function var_4_2()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003

		local var_5_3 = arg_4_0

		var_5_2.helps = var_3.GetTips(var_5_3)

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnShop

	local function var_4_5()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_6_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_6_3 = var_2_10003.SKINSHOP
		local var_6_4 = {}

		NewSkinShopScene = var_2_10005
		var_6_4.page = var_2_10005.PAGE_RETURN

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10005)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.btnGift

	local function var_4_8()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_7_3 = var_2_10003.CHARGE
		local var_7_4 = {}
		local var_7_5 = arg_4_0

		var_7_4.wrap = var_5.GetGiftShopType(var_7_5)

		var_7_1(var_7_0, var_7_2, var_7_3, var_7_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10005)

	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.taskGroup) do
		local var_4_9 = iter_4_1[1]
		local var_4_10 = arg_4_0.taskProxy
		local var_4_11

		if not var_7.getTaskVO(var_4_10, var_4_9) then
			Task = var_4_11
			var_4_11 = var_4_11.New({
				id = var_4_9
			})
		end

		local var_4_12 = arg_4_0.rtLogin
		local var_4_13 = var_8.GetChild(var_4_12, iter_4_0 - 1)

		setText = var_4_12

		var_4_12(var_4_13:Find("day/Text"), "DAY" .. iter_4_0)

		Drop = var_4_12

		local var_4_14 = var_4_12.Create(var_4_11:getConfig("award_display")[1])

		updateDrop = var_10

		var_10(var_4_13:Find("IconTpl"), var_4_14)

		onButton = var_10

		local var_4_15 = arg_4_0
		local var_4_16 = var_4_13:Find("get")

		local function var_4_17()
			local var_8_0 = arg_4_0
			local var_8_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_8_1(var_8_0, var_2_10002.ON_TASK_SUBMIT, var_4_11)

			return
		end

		SFX_CONFIRM = var_14

		var_10(var_4_15, var_4_16, var_4_17, var_14)

		onButton = var_10

		var_10(arg_4_0, var_4_13, function()
			local var_9_0 = arg_4_0
			local var_9_1 = var_0.emit

			BaseUI = var_2_10002

			var_9_1(var_9_0, var_2_10002.ON_DROP, var_4_14)

			return
		end)
	end

	onButton = var_1

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.rtSkinCoupon
	local var_4_20 = var_3.Find(var_4_19, "icon/get")

	local function var_4_21()
		local var_10_0 = arg_4_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_4_0.activity.id
		})

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_4_18, var_4_20, var_4_21, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	local var_11_0 = false

	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.taskGroup) do
		local var_11_1 = iter_11_1[1]
		local var_11_2 = arg_11_0.taskProxy
		local var_11_3

		if not var_8.getTaskVO(var_11_2, var_11_1) then
			Task = var_11_3
			var_11_3 = var_11_3.New({
				id = var_11_1
			})
		end

		local var_11_4 = arg_11_0.rtLogin
		local var_11_5 = var_9.GetChild(var_11_4, iter_11_0 - 1)
		local var_11_6 = var_11_3
		local var_11_7 = var_11_3.isReceive(var_11_6)

		setActive = var_11_6

		var_11_6(var_11_5:Find("got"), var_11_7 or iter_11_0 < arg_11_0.nday)

		setActive = var_11_6

		var_11_6(var_11_5:Find("get"), not var_11_0 and not var_11_7 and iter_11_0 == arg_11_0.nday)

		if not var_11_0 then
			isActive = var_11_6
			var_11_0 = var_11_6(var_11_5:Find("get"))
		end
	end

	Drop = var_2

	local var_11_8 = var_2.New({
		type = 8,
		id = arg_11_0.couponItemId,
		count = arg_11_0.couponGet
	})

	onButton = var_3

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0.rtSkinCoupon
	local var_11_11 = var_5.Find(var_11_10, "icon")

	local function var_11_12()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		BaseUI = var_2_10002

		var_12_1(var_12_0, var_2_10002.ON_DROP, var_11_8)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_11_9, var_11_11, var_11_12, var_7)

	updateDrop = var_3

	local var_11_13 = arg_11_0.rtSkinCoupon

	var_3(var_4.Find(var_11_13, "icon/IconTpl"), var_11_8)

	setActive = var_3

	local var_11_14 = arg_11_0.rtSkinCoupon

	var_3(var_4.Find(var_11_14, "icon/get"), arg_11_0.couponGet > 0)

	setText = var_3

	local var_11_15 = arg_11_0.rtSkinCoupon
	local var_11_16 = var_4.Find(var_11_15, "count")

	i18n = var_11_15

	var_3(var_11_16, var_11_15("SkinDiscount_Got", arg_11_0:GetCouponCountText()))

	setActive = var_3

	local var_11_17 = arg_11_0.rtSkinCoupon

	var_3(var_4.Find(var_11_17, "icon/get"), arg_11_0.couponGet > 0)

	return
end

function var_0_1.GetTips(arg_13_0)
	pg = var_1_10001

	return var_1_10001.gametip.SkinDiscountHelp_School.tip
end

function var_0_1.GetCouponCountText(arg_14_0)
	return arg_14_0.couponCount
end

function var_0_1.GetGiftShopType(arg_15_0)
	ChargeScene = var_1_10001

	return var_1_10001.TYPE_GIFT
end

return var_0_1
