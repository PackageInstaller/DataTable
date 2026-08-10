local var_0_0 = class("SkinBuyCheckDLCItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.discountController = ControllerUtil.GetController(arg_2_0.transform_, "discount")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.itemController = ControllerUtil.GetController(arg_3_0.transform_, "icon")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		arg_4_0.clickFunc(arg_4_0.index)
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_addBtn, nil, function()
		if arg_4_0.index == 1 then
			return
		end

		local var_6_0 = getShopCfg(arg_4_0.id)

		if ShopConst.SHOP_ID.DLC_SHOP ~= var_6_0.shop_id then
			return
		end

		arg_4_0.selectClickFunc(arg_4_0.id)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index = arg_7_1
	arg_7_0.id = arg_7_2

	local var_7_0 = getShopCfg(arg_7_2)
	local var_7_1 = var_7_0.give_id or var_7_0.description

	if not var_7_0.give then
		local var_7_2 = 1
	end

	local var_7_3
	local var_7_4

	if var_7_0.description then
		local var_7_5 = var_7_0.description

		var_7_4 = RechargeShopDescriptionCfg[var_7_5]
	else
		var_7_4 = ItemCfg[var_7_1]
	end

	arg_7_0.isDlc = var_7_4.type ~= ItemConst.ITEM_TYPE.HERO_SKIN

	if var_7_4.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		arg_7_0.itemController:SetSelectedIndex(1)

		arg_7_0.m_skinIcon.sprite = ItemTools.getItemSprite(var_7_4.id)
	else
		arg_7_0.itemController:SetSelectedIndex(0)

		arg_7_0.m_icon.sprite = ItemTools.getItemSprite(var_7_4.id)
	end

	arg_7_0.m_currency.sprite = ItemTools.getItemLittleSprite(var_7_0.cost_id)

	arg_7_0:UpdateTimer()
end

function var_0_0.UpdateTimer(arg_8_0)
	local var_8_0 = arg_8_0.id
	local var_8_1 = getShopCfg(var_8_0)
	local var_8_2, var_8_3, var_8_4 = ShopTools.GetPrice(var_8_0, var_8_1.shop_id)

	arg_8_0.m_num.text = var_8_2
	arg_8_0.m_oldPriceLabel.text = var_8_3

	local var_8_5, var_8_6, var_8_7 = ShopTools.IsOnDiscountArea(var_8_0, var_8_1.shop_id)

	if var_8_5 and var_8_7 then
		if var_8_6 then
			arg_8_0.discountController:SetSelectedState("time_limit_discount")

			if arg_8_0.isDlc then
				local var_8_8 = TimeMgr.GetInstance():parseTimeFromConfig(var_8_1.cheap_close_time)

				arg_8_0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(var_8_8))
			else
				arg_8_0.discountLastTimeLabel_.text = ""
			end
		else
			arg_8_0.discountController:SetSelectedState("discount")
		end
	else
		arg_8_0.discountController:SetSelectedState("null")
	end
end

function var_0_0.GetIndex(arg_9_0)
	return arg_9_0.index
end

function var_0_0.SetSelect(arg_10_0, arg_10_1)
	arg_10_0.selectController:SetSelectedIndex(arg_10_1 and 1 or 0)
end

function var_0_0.SetState(arg_11_0, arg_11_1)
	if arg_11_1 == 2 then
		arg_11_0.m_btn.interactable = false
	else
		arg_11_0.m_btn.interactable = true
	end

	arg_11_0.stateController:SetSelectedIndex(arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.RegistCallBack(arg_13_0, arg_13_1)
	arg_13_0.clickFunc = arg_13_1
end

function var_0_0.RegistSelectCallBack(arg_14_0, arg_14_1)
	arg_14_0.selectClickFunc = arg_14_1
end

return var_0_0
