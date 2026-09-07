local SkinEncoreLoginPage = class("SkinEncoreLoginPage", import("view.base.BaseActivityPage"))

function SkinEncoreLoginPage:OnInit()
	self.rtSkinCoupon = self._tf:Find("AD/skin_coupon")
	self.rtLogin = self._tf:Find("AD/login")
	self.btnShop = self._tf:Find("AD/btn_shop")
	self.btnGift = self._tf:Find("AD/btn_gift")
	self.btnHelp = self._tf:Find("AD/btn_help")

	return
end

function SkinEncoreLoginPage:OnDataSetting()
	self.couponItemId = self.activity:getConfig("config_client").item_id
	self.couponGet = self.activity:getData1()

	local var_2_0 = getProxy(ActivityProxy):getActivityById(Item.getConfigData(self.couponItemId).link_id)

	self.couponCount = var_2_0 and not var_2_0:isEnd() and var_2_0:GetCanUsageCnt() or 0
	self.subActivity = getProxy(ActivityProxy):getActivityById(self.activity:getConfig("config_client").sub_act_id)
	self.nday = self.subActivity.data3
	self.taskProxy = getProxy(TaskProxy)
	self.taskGroup = self.subActivity:getConfig("config_data")

	return updateActivityTaskStatus(self.subActivity)
end

function SkinEncoreLoginPage:GetPageLink()
	return {
		self.activity:getConfig("config_client").sub_act_id
	}
end

function SkinEncoreLoginPage:OnFirstFlush()
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self:GetTips()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnShop, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP, {
			page = NewSkinShopScene.PAGE_RETURN
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnGift, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = self:GetGiftShopType()
		})

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(self.taskGroup) do
		local var_4_0 = self.taskProxy:getTaskVO(iter_4_1[1]) or Task.New({
			id = iter_4_1[1]
		})
		local var_4_1 = self.rtLogin:GetChild(iter_4_0 - 1)

		setText(var_4_1:Find("day/Text"), "DAY" .. iter_4_0)

		local var_4_2 = Drop.Create(var_4_0:getConfig("award_display")[1])

		updateDrop(var_4_1:Find("IconTpl"), var_4_2)
		onButton(self, var_4_1:Find("get"), function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_4_0)

			return
		end, SFX_CONFIRM)
		onButton(self, var_4_1, function()
			self:emit(BaseUI.ON_DROP, var_4_2)

			return
		end)
	end

	onButton(self, self.rtSkinCoupon:Find("icon/get"), function()
		self:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = self.activity.id
		})

		return
	end, SFX_CONFIRM)

	return
end

function SkinEncoreLoginPage:OnUpdateFlush()
	for iter_11_0, iter_11_1 in ipairs(self.taskGroup) do
		local var_11_0 = self.taskProxy:getTaskVO(iter_11_1[1]) or Task.New({
			id = iter_11_1[1]
		})
		local var_11_1 = self.rtLogin:GetChild(iter_11_0 - 1)
		local var_11_2 = var_11_0:isReceive()

		setActive(var_11_1:Find("got"), var_11_2 or iter_11_0 < self.nday)
		setActive(var_11_1:Find("get"), not false and not var_11_2 and iter_11_0 == self.nday)

		local var_11_3 = false or isActive(var_11_1:Find("get"))
	end

	local var_11_4 = Drop.New({
		type = 8,
		id = self.couponItemId,
		count = self.couponGet
	})

	onButton(self, self.rtSkinCoupon:Find("icon"), function()
		self:emit(BaseUI.ON_DROP, var_11_4)

		return
	end, SFX_CONFIRM)
	updateDrop(self.rtSkinCoupon:Find("icon/IconTpl"), var_11_4)
	setActive(self.rtSkinCoupon:Find("icon/get"), self.couponGet > 0)
	setText(self.rtSkinCoupon:Find("count"), i18n("SkinDiscount_Got", self:GetCouponCountText()))
	setActive(self.rtSkinCoupon:Find("icon/get"), self.couponGet > 0)

	return
end

function SkinEncoreLoginPage:GetTips()
	return pg.gametip.SkinDiscountHelp_School.tip
end

function SkinEncoreLoginPage:GetCouponCountText()
	return self.couponCount
end

function SkinEncoreLoginPage:GetGiftShopType()
	return ChargeScene.TYPE_GIFT
end

return SkinEncoreLoginPage
