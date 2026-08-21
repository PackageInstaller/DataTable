local var_0_0 = class("SkinEncoreLoginPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.rtSkinCoupon = arg_1_0._tf:Find("AD/skin_coupon")
	arg_1_0.rtLogin = arg_1_0._tf:Find("AD/login")
	arg_1_0.btnShop = arg_1_0._tf:Find("AD/btn_shop")
	arg_1_0.btnGift = arg_1_0._tf:Find("AD/btn_gift")
	arg_1_0.btnHelp = arg_1_0._tf:Find("AD/btn_help")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.couponItemId = arg_2_0.activity:getConfig("config_client").item_id
	arg_2_0.couponGet = arg_2_0.activity:getData1()

	local var_2_0 = getProxy(ActivityProxy):getActivityById(Item.getConfigData(arg_2_0.couponItemId).link_id)

	arg_2_0.couponCount = var_2_0 and not var_2_0:isEnd() and var_2_0:GetCanUsageCnt() or 0
	arg_2_0.subActivity = getProxy(ActivityProxy):getActivityById(arg_2_0.activity:getConfig("config_client").sub_act_id)
	arg_2_0.nday = arg_2_0.subActivity.data3
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.subActivity:getConfig("config_data")

	return updateActivityTaskStatus(arg_2_0.subActivity)
end

function var_0_0.GetPageLink(arg_3_0)
	return {
		arg_3_0.activity:getConfig("config_client").sub_act_id
	}
end

function var_0_0.OnFirstFlush(arg_4_0)
	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_4_0:GetTips()
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnShop, function()
		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP, {
			page = NewSkinShopScene.PAGE_RETURN
		})

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnGift, function()
		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = arg_4_0:GetGiftShopType()
		})

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskGroup) do
		local var_4_0 = arg_4_0.taskProxy:getTaskVO(iter_4_1[1]) or Task.New({
			id = iter_4_1[1]
		})
		local var_4_1 = arg_4_0.rtLogin:GetChild(iter_4_0 - 1)

		setText(var_4_1:Find("day/Text"), "DAY" .. iter_4_0)
		updateDrop(var_4_1:Find("IconTpl"), (Drop.Create(var_4_0:getConfig("award_display")[1])))
		onButton(arg_4_0, var_4_1:Find("get"), function()
			arg_4_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_0)

			return
		end, SFX_CONFIRM)
		onButton(arg_4_0, var_4_1, function()
			arg_4_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	onButton(arg_4_0, arg_4_0.rtSkinCoupon:Find("icon/get"), function()
		arg_4_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_4_0.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.taskGroup) do
		local var_11_0 = arg_11_0.taskProxy:getTaskVO(iter_11_1[1]) or Task.New({
			id = iter_11_1[1]
		})
		local var_11_1 = arg_11_0.rtLogin:GetChild(iter_11_0 - 1)
		local var_11_2 = var_11_0:isReceive()

		setActive(var_11_1:Find("got"), var_11_2 or iter_11_0 < arg_11_0.nday)
		setActive(var_11_1:Find("get"), not false and not var_11_2 and iter_11_0 == arg_11_0.nday)

		local var_11_3 = false or isActive(var_11_1:Find("get"))
	end

	local var_11_4 = Drop.New({
		type = 8,
		id = arg_11_0.couponItemId,
		count = arg_11_0.couponGet
	})

	onButton(arg_11_0, arg_11_0.rtSkinCoupon:Find("icon"), function()
		arg_11_0:emit(BaseUI.ON_DROP, var_11_4)

		return
	end, SFX_CONFIRM)
	updateDrop(arg_11_0.rtSkinCoupon:Find("icon/IconTpl"), (Drop.New({
		type = 8,
		id = arg_11_0.couponItemId,
		count = arg_11_0.couponGet
	})))
	setActive(arg_11_0.rtSkinCoupon:Find("icon/get"), arg_11_0.couponGet > 0)
	setText(arg_11_0.rtSkinCoupon:Find("count"), i18n("SkinDiscount_Got", arg_11_0:GetCouponCountText()))
	setActive(arg_11_0.rtSkinCoupon:Find("icon/get"), arg_11_0.couponGet > 0)

	return
end

function var_0_0.GetTips(arg_13_0)
	return pg.gametip.SkinDiscountHelp_School.tip
end

function var_0_0.GetCouponCountText(arg_14_0)
	return arg_14_0.couponCount
end

function var_0_0.GetGiftShopType(arg_15_0)
	return ChargeScene.TYPE_GIFT
end

return var_0_0
