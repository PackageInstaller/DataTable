local var_0_0 = class("ActivityOathDiscountInfo", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 5,
			page = 2
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.activityID_ = arg_5_1
	arg_5_0.discountItemID_ = OathDrawTools.GetCouponID()

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	if not (ItemTools.getItemTotalNumIgnoreTimeValid(arg_6_0.discountItemID_) > 0) then
		SetActive(arg_6_0.gameObject_, false)

		return
	else
		SetActive(arg_6_0.gameObject_, false)

		return
	end

	local var_6_0 = ItemCfg[arg_6_0.discountItemID_]

	arg_6_0.nameText_.text = GetI18NText(var_6_0.name)
	arg_6_0.couponSprite_.sprite = ItemTools.getItemSprite(arg_6_0.discountItemID_)
	arg_6_0.discountText_.text = GetTips("WEDDING_RING_SALE_DESC_41720")
	arg_6_0.timeText_.text = ItemTools.GetItemCountdownText(ItemTools.GetItemExpiredTimeByID(arg_6_0.discountItemID_))
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
