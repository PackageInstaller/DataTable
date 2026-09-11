local RechargeBlessBagView = class("RechargeBlessBagView", ReduxView)

function RechargeBlessBagView:UIName()
	local var_1_0 = getShopCfg(self.params_.goodID)

	if var_1_0 ~= nil then
		return "Widget/System/Recharge/RechargeFukubukuroPopUI_" .. var_1_0.description
	end

	return "Widget/System/Recharge/RechargeFukubukuroPopUI"
end

function RechargeBlessBagView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeBlessBagView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RechargeBlessBagView:InitUI()
	self:BindCfgUI()

	self.rmbController_ = ControllerUtil.GetController(self.transform_, "rmb")
	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, CommonItemView)
	self.grey = self.okImage_.material
end

function RechargeBlessBagView:AddUIListener()
	self:AddBtnListener(self.m_buyBtn, nil, function()
		SendMessageManagerToSDK("purchase_click_gp_once")

		if ShopTools.IsPC() and ShopTools.IsRMB(self.goodId_) and not SDKTools.GetIsOverSea() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = self.goodId_
		})

		local var_6_0, var_6_1 = ShopTools.IsShopSuspended(getShopCfg(self.goodId_).shop_id)

		if var_6_0 then
			ShowTips(var_6_1)

			return
		end

		if ShopTools.IsRMB(self.goodId_) then
			local var_6_3, var_6_4, var_6_5 = ShopTools.IsOnDiscountArea(self.goodId_)

			PayAction.RequestGSPay((var_6_3 and var_6_5 and PaymentCfg[self.shopCfg_.cheap_cost_id] or PaymentCfg[self.shopCfg_.cost_id]).id, self.selectNum_, self.shopCfg_.shop_id, self.shopCfg_.goods_id, self.params_.buy_source or 0)
		else
			local var_6_6 = self.params_.buy_source or 0

			if ShopTools.GetPrice(self.goodId_) == 0 then
				self:Back()
				ShopAction.BuyItem({
					{
						goodID = self.goodId_,
						buyNum = self.selectNum_
					}
				}, nil, var_6_6)

				return
			end

			ShopTools.ConfirmBuyItem(self.goodId_, self.selectNum_, function(arg_7_0)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				self:Back()
			end, function()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 1
				})
				self:UpdatePreview()
			end, var_6_6)
		end
	end)
	self:AddBtnListener(nil, self.m_chanceBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = self.shopCfg_.description
		})
	end)
	self:AddBtnListener(nil, self.m_mask, function()
		self:Back()
	end)
end

function RechargeBlessBagView:OnTop()
	return
end

function RechargeBlessBagView:OnEnter()
	self.goodId_ = self.params_.goodID
	self.shopId_ = self.params_.shopID
	self.selectNum_ = 1
	self.shopCfg_ = getShopCfg(self.goodId_)
	self.itemDesCfg_ = RechargeShopDescriptionCfg[self.shopCfg_.description]
	self.m_name.text = self.itemDesCfg_.name
	self.items = ItemCfg[self.shopCfg_.description].param

	self.list:StartScroll(#self.items)
	self:UpdatePreview()
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_13_0)
		self:Back()
	end)
end

function RechargeBlessBagView:UpdatePreview()
	local var_14_0 = ShopTools.GetPrice(self.goodId_)

	self.m_timeLab.text = #self.shopCfg_.close_time > 0 and #self.shopCfg_.open_time > 0 and string.format("%s-%s", os.date("%Y/%m/%d", (TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg_.open_time))), os.date("%Y/%m/%d", (TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg_.close_time)))) or ""

	if ShopTools.IsRMB(self.goodId_) then
		self.rmbController_:SetSelectedState("rmb")

		self.rmbLabel_.text = GetTips("MONEY_SYMBOL") .. var_14_0
	else
		self.rmbController_:SetSelectedState("buy")

		self.costIcon_.sprite = ItemTools.getItemLittleSprite(self.shopCfg_.cost_id)
		self.totleLabel_.text = var_14_0
	end

	self.okImage_.material = ShopTools.IsRMB(self.goodId_) and ShopTools.IsPC() and self.grey or nil
end

function RechargeBlessBagView:GetHave()
	return ItemTools.getItemNum(self.shopCfg_.cost_id)
end

function RechargeBlessBagView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function RechargeBlessBagView:Dispose()
	self.list:Dispose()
	RechargeBlessBagView.super.Dispose(self)
end

function RechargeBlessBagView:OnShopBuyResult(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == 0 then
		local var_18_0 = getShopCfg(arg_18_2, self.shopId_)

		self:Back()

		if RechargeShopDescriptionCfg[var_18_0.goods_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					id = var_18_0.goods_id,
					num = var_18_0.give
				}
			})
		elseif RechargeShopDescriptionCfg[var_18_0.goods_id].type == ItemConst.ITEM_TYPE.EQUIP then
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

function RechargeBlessBagView:IndexItem(arg_20_1, arg_20_2)
	local var_20_0 = self.items[arg_20_1]

	CommonTools.SetCommonData(arg_20_2, {
		id = self.items[arg_20_1][1],
		number = self.items[arg_20_1][2],
		clickFun = function(arg_21_0)
			ShowPopItem(POP_ITEM, {
				var_20_0[1]
			})
		end
	})
end

return RechargeBlessBagView
