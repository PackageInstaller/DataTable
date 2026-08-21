local var_0_0 = class("RechargeOathRingShopCouponItem", BaseView)
local var_0_1 = ItemConst.OATH_RING_COUPON

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.selectController = arg_1_0.controllers_:GetController("select")
	arg_1_0.showExpireTimeController = arg_1_0.controllers_:GetController("showExpireTime")

	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		if arg_1_0.onClick then
			arg_1_0:onClick()
		end
	end)
	arg_1_0:AddBtnListener(arg_1_0.itemBtn_, nil, function()
		arg_1_0:OnClickItemIcon()
	end)
end

function var_0_0.OnClickItemIcon(arg_4_0)
	ShowPopItemOnly(POP_SOURCE_DES_ITEM, arg_4_0.info)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.info = arg_5_1
	arg_5_0.index = arg_5_2
	arg_5_0.nameText_.text = ItemTools.getItemName(arg_5_1.id)
	arg_5_0.couponSprite_.spriteAsync = ItemTools.getItemSprite(arg_5_1.id, true)

	local var_5_0 = string.format("WEDDING_RING_SALE_DESC_%d", var_0_1)

	arg_5_0.discountText_.text = GetTips(var_5_0)

	arg_5_0:UpdateLastTime()
end

function var_0_0.UpdateLastTime(arg_6_0)
	local var_6_0 = ItemTools.GetItemExpiredTimeByInfo(arg_6_0.info)

	if var_6_0 ~= nil and var_6_0 ~= 0 then
		arg_6_0.showExpireTimeController:SetSelectedState("true")

		arg_6_0.timeText_.text = manager.time:GetLostTimeStr(var_6_0, true, true)
	else
		arg_6_0.showExpireTimeController:SetSelectedState("false")
	end
end

function var_0_0.SetOnClick(arg_7_0, arg_7_1)
	arg_7_0.onClick = arg_7_1
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	if arg_8_0.selectController then
		arg_8_0.selectController:SetSelectedState(arg_8_1 and "true" or "false")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
