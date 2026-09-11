local ActivityOathDiscountInfo = class("ActivityOathDiscountInfo", ReduxView)

function ActivityOathDiscountInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function ActivityOathDiscountInfo:InitUI()
	self:BindCfgUI()
	self:AddUIListeners()
end

function ActivityOathDiscountInfo:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 5,
			page = 2
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
end

function ActivityOathDiscountInfo:SetData(arg_5_1)
	self.activityID_ = arg_5_1
	self.discountItemID_ = OathDrawTools.GetCouponID()

	self:RefreshUI()
end

function ActivityOathDiscountInfo:RefreshUI()
	if ItemTools.getItemTotalNumIgnoreTimeValid(self.discountItemID_) <= 0 then
		SetActive(self.gameObject_, false)

		return
	end

	local var_6_1
	local var_6_0

	do
		SetActive(self.gameObject_, false)

		do return end

		var_6_0 = self.nameText_
		var_6_1 = GetI18NText
	end

	var_6_0.text = var_6_1(ItemCfg[self.discountItemID_].name)
	self.couponSprite_.sprite = ItemTools.getItemSprite(self.discountItemID_)
	self.discountText_.text = GetTips("WEDDING_RING_SALE_DESC_41720")
	self.timeText_.text = ItemTools.GetItemCountdownText(ItemTools.GetItemExpiredTimeByID(self.discountItemID_))
end

function ActivityOathDiscountInfo:OnExit()
	self:RemoveAllEventListener()
end

function ActivityOathDiscountInfo:Dispose()
	ActivityOathDiscountInfo.super.Dispose(self)
end

return ActivityOathDiscountInfo
