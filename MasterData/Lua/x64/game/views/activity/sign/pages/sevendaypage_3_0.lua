ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDayPage_3_0 = class("SevenDayPage_3_0", ActivityMainBasePanel)

function SevenDayPage_3_0:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDayPage_3_0:Init()
	self:BindCfgUI()

	self.items = {}
	self.max_sign_day = SevenDaySkinData:MaxSignDay(self.activityID_)

	for iter_2_0 = 1, self.max_sign_day do
		local var_2_0 = SevenDaySkinItem_3_0.New(self["btn_" .. iter_2_0])

		var_2_0:RegisterListener(function()
			if self.data:SignDay() >= self.max_sign_day then
				return
			end

			if self.data:LeftSignTimes() > 0 then
				SevenDaySkinAction.ReqSign(self.activityID_)

				return
			end

			if self.data:IsReSign() then
				self:ShowCheckDialog()

				return
			end
		end)
		table.insert(self.items, var_2_0)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)

	self:AddListeners()
end

function SevenDayPage_3_0:AddListeners()
	self:AddBtnListener(self.BtnSign, nil, handler(self, self.OnBtnSignClick))
	self:AddBtnListener(self.btn_desc, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_RULE")
		})
	end)
end

function SevenDayPage_3_0:OnTop()
	self:UpdateBar()
end

function SevenDayPage_3_0:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
end

function SevenDayPage_3_0:OnEnter()
	SevenDayPage_3_0.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.redPoint:bindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))

	self.data = SevenDaySkinData:GetActivityData(self.activityID_)
	self.crossDay = false

	self:RefreshView()
end

function SevenDayPage_3_0:OnExit()
	SevenDayPage_3_0.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.redPoint:unbindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()
end

function SevenDayPage_3_0:Dispose()
	SevenDayPage_3_0.super.Dispose(self)

	for iter_10_0 = 1, #self.items do
		self.items[iter_10_0]:Dispose()
	end
end

function SevenDayPage_3_0:RefreshView()
	self:RefreshSignInfo()
	self:RefreshItems()

	local var_11_0 = self.data:LeftSignTimes()
end

function SevenDayPage_3_0:RefreshSignInfo()
	self.descText_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_BACKDROP")
end

function SevenDayPage_3_0:RefreshItems()
	self.receiveState = false

	local var_13_0 = self.data:SignDay()
	local var_13_1 = var_13_0 + self.data:LeftSignTimes()
	local var_13_2 = self.data:SignRewardList()
	local var_13_3 = var_13_0 + self.data:ReSignNum()

	for iter_13_0 = 1, self.max_sign_day do
		if iter_13_0 <= var_13_0 then
			self.receiveState = false
		else
			self.receiveState = iter_13_0 <= var_13_1
		end
	end

	for iter_13_1 = 1, self.max_sign_day do
		local var_13_5 = var_13_2[iter_13_1]

		if iter_13_1 == var_13_0 + 1 and not self.receiveState then
			self.items[iter_13_1]:RefreshView(var_13_5, iter_13_1 <= var_13_0 and 2 or iter_13_1 <= var_13_1 and 1 or 0, var_13_3 > 0)
		else
			self.items[iter_13_1]:RefreshView(var_13_5, iter_13_1 <= var_13_0 and 2 or iter_13_1 <= var_13_1 and 1 or 0, false)
		end

		var_13_3 = var_13_3 - 1
	end
end

function SevenDayPage_3_0:OnBtnSignClick()
	JumpTools.OpenPageByJump("/norseSurpriseGiftMachinePage")
end

function SevenDayPage_3_0:OnSignSuccess(arg_15_1)
	getReward(arg_15_1.item_list)
	self:RefreshView()

	self.crossDay = false
end

function SevenDayPage_3_0:ShowCheckDialog()
	local var_16_0 = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2]
	local var_16_1 = ItemTools.getItemNum(ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1])

	JumpTools.OpenPageByJump("popCostItem", {
		costId = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1],
		costCount = ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2],
		content = string.format(GetTips("ACTIVITY_OPTIONAL_RANDOM_SIGN_COST"), GetI18NText(ItemCfg[ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][1]].name), ActivityCumulativeSignCfg[self.activityID_].cost_item_list[1][2]),
		popCostCallBack = function()
			local var_17_0, var_17_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_17_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay = false
			elseif var_16_1 < var_16_0 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(self.activityID_)
			end
		end,
		CancelCallback = function()
			manager.windowBar:HideBar()
			self:UpdateBar()
		end,
		MaskCallback = function()
			manager.windowBar:HideBar()
			self:UpdateBar()
		end
	})
end

function SevenDayPage_3_0:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function SevenDayPage_3_0:OnClearSuccess()
	self.data = SevenDaySkinData:GetActivityData(self.activityID_)

	self:RefreshView()

	self.crossDay = true
end

return SevenDayPage_3_0
