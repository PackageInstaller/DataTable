local var_0_0 = class("RechargeBlessBagView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0.params_.goodID
	local var_1_1 = getShopCfg(var_1_0)

	if var_1_1 ~= nil then
		return "Widget/System/Recharge/RechargeFukubukuroPopUI_" .. var_1_1.description
	end

	return "Widget/System/Recharge/RechargeFukubukuroPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rmbController_ = ControllerUtil.GetController(arg_4_0.transform_, "rmb")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, CommonItemView)
	arg_4_0.grey = arg_4_0.okImage_.material
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_buyBtn, nil, function()
		SendMessageManagerToSDK("purchase_click_gp_once")

		if ShopTools.IsPC() and ShopTools.IsRMB(arg_5_0.goodId_) and not SDKTools.GetIsOverSea() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = arg_5_0.goodId_
		})

		local var_6_0 = getShopCfg(arg_5_0.goodId_).shop_id
		local var_6_1, var_6_2 = ShopTools.IsShopSuspended(var_6_0)

		if var_6_1 then
			ShowTips(var_6_2)

			return
		end

		if ShopTools.IsRMB(arg_5_0.goodId_) then
			local var_6_3
			local var_6_4, var_6_5, var_6_6 = ShopTools.IsOnDiscountArea(arg_5_0.goodId_)

			if var_6_4 and var_6_6 then
				var_6_3 = PaymentCfg[arg_5_0.shopCfg_.cheap_cost_id]
			else
				var_6_3 = PaymentCfg[arg_5_0.shopCfg_.cost_id]
			end

			local var_6_7 = arg_5_0.params_.buy_source or 0

			PayAction.RequestGSPay(var_6_3.id, arg_5_0.selectNum_, arg_5_0.shopCfg_.shop_id, arg_5_0.shopCfg_.goods_id, var_6_7)
		else
			local var_6_8 = arg_5_0.params_.buy_source or 0

			if ShopTools.GetPrice(arg_5_0.goodId_) == 0 then
				arg_5_0:Back()
				ShopAction.BuyItem({
					{
						goodID = arg_5_0.goodId_,
						buyNum = arg_5_0.selectNum_
					}
				}, nil, var_6_8)

				return
			end

			ShopTools.ConfirmBuyItem(arg_5_0.goodId_, arg_5_0.selectNum_, function(arg_7_0)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				arg_5_0:Back()
			end, function()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 1
				})
				arg_5_0:UpdatePreview()
			end, var_6_8)
		end
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_chanceBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = arg_5_0.shopCfg_.description
		})
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_mask, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_11_0)
	return
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.goodId_ = arg_12_0.params_.goodID
	arg_12_0.shopId_ = arg_12_0.params_.shopID
	arg_12_0.selectNum_ = 1
	arg_12_0.shopCfg_ = getShopCfg(arg_12_0.goodId_)
	arg_12_0.itemDesCfg_ = RechargeShopDescriptionCfg[arg_12_0.shopCfg_.description]
	arg_12_0.m_name.text = arg_12_0.itemDesCfg_.name
	arg_12_0.items = ItemCfg[arg_12_0.shopCfg_.description].param

	arg_12_0.list:StartScroll(#arg_12_0.items)
	arg_12_0:UpdatePreview()
	arg_12_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_13_0)
		arg_12_0:Back()
	end)
end

function var_0_0.UpdatePreview(arg_14_0)
	local var_14_0 = ShopTools.GetPrice(arg_14_0.goodId_)

	if #arg_14_0.shopCfg_.close_time > 0 and #arg_14_0.shopCfg_.open_time > 0 then
		local var_14_1 = TimeMgr.GetInstance():parseTimeFromConfig(arg_14_0.shopCfg_.close_time)
		local var_14_2 = TimeMgr.GetInstance():parseTimeFromConfig(arg_14_0.shopCfg_.open_time)

		arg_14_0.m_timeLab.text = string.format("%s-%s", os.date("%Y/%m/%d", var_14_2), os.date("%Y/%m/%d", var_14_1))
	else
		arg_14_0.m_timeLab.text = ""
	end

	if ShopTools.IsRMB(arg_14_0.goodId_) then
		arg_14_0.rmbController_:SetSelectedState("rmb")

		arg_14_0.rmbLabel_.text = GetTips("MONEY_SYMBOL") .. var_14_0
	else
		arg_14_0.rmbController_:SetSelectedState("buy")

		arg_14_0.costIcon_.sprite = ItemTools.getItemLittleSprite(arg_14_0.shopCfg_.cost_id)
		arg_14_0.totleLabel_.text = var_14_0
	end

	if ShopTools.IsRMB(arg_14_0.goodId_) and ShopTools.IsPC() then
		arg_14_0.okImage_.material = arg_14_0.grey
	else
		arg_14_0.okImage_.material = nil
	end
end

function var_0_0.GetHave(arg_15_0)
	local var_15_0 = arg_15_0.shopCfg_

	return ItemTools.getItemNum(var_15_0.cost_id)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.list:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.OnShopBuyResult(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == 0 then
		local var_18_0 = getShopCfg(arg_18_2, arg_18_0.shopId_)
		local var_18_1 = var_18_0.goods_id
		local var_18_2 = var_18_0.give
		local var_18_3 = RechargeShopDescriptionCfg[var_18_1].type

		arg_18_0:Back()

		if var_18_3 == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					id = var_18_1,
					num = var_18_2
				}
			})
		elseif var_18_3 == ItemConst.ITEM_TYPE.EQUIP then
			if EquipData:GetEquipBagFull() then
				showEquipSendMail(nil)
				EquipAction.EquipBagFull(false)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		else
			ShowTips("TRANSACTION_SUCCESS")
		end
	elseif arg_18_1 == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif arg_18_1 == 406 then
		ShowTips("ITEM_INVALID")
	elseif arg_18_1 then
		ShowTips(arg_18_1)
	end
end

function var_0_0.IndexItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.items[arg_20_1]

	CommonTools.SetCommonData(arg_20_2, {
		id = var_20_0[1],
		number = var_20_0[2],
		clickFun = function(arg_21_0)
			ShowPopItem(POP_ITEM, {
				var_20_0[1]
			})
		end
	})
end

return var_0_0
