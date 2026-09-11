ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage_3_4 = class("SevenDaySkinPage_3_4", ActivityMainBasePanel)
local var_0_1 = {
	[113907] = {
		author = "HERO_BOSAIDONG_NAME",
		name = "hades",
		body = "BOSAIDONG_SKIN_WORD"
	}
}

function SevenDaySkinPage_3_4:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage_3_4:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinPage_3_4:InitUI()
	self:BindCfgUI()

	self.items_ = {}
	self.maxDay_ = SevenDaySkinData:MaxSignDay(self.activityID_)

	for iter_3_0 = 1, self.maxDay_ do
		self.items_[iter_3_0] = SevenDaySkinItem_3_4.New(self["btn_" .. iter_3_0])

		self.items_[iter_3_0]:RegisterClickFunc(function()
			self:OnBtnSignClick()
		end)
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)
end

function SevenDaySkinPage_3_4:AddUIListeners()
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_INSTRUSCTIONS")
		})
	end)
	self:AddBtnListener(self.videoBtn_, nil, function()
		OperationRecorder.RecordButtonTouch(string.format("activity_%s_video_play", self.activityID_))
		JumpTools.OpenPageByJump("/videoShowView", {
			start_path = GameSetting.activity_sign_bosaidong_video.value[1]
		})
	end)
end

function SevenDaySkinPage_3_4:OnEnter()
	SevenDaySkinPage_3_4.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)

	self.crossDay_ = false
	self.data_ = SevenDaySkinData:GetActivityData(self.activityID_)

	self:RefreshView()
end

function SevenDaySkinPage_3_4:RefreshView()
	self.descText_.text = GetTips("BOSAIDONG_SIGN_DESCRIPTION")

	self:RefreshItems()
	self:RefreshBtn()
end

function SevenDaySkinPage_3_4:RefreshItems()
	local var_10_0 = self.data_:SignDay()
	local var_10_1 = var_10_0 + self.data_:LeftSignTimes()
	local var_10_2 = self.data_:SignRewardList()

	self.skinCfg = SkinCfg[var_10_2[1][1]]

	for iter_10_0 = 1, self.maxDay_ do
		local var_10_3 = var_10_2[iter_10_0]
		local var_10_4 = 0
		local var_10_5 = iter_10_0 == var_10_0 + 1 and self.data_:IsReSign()

		if iter_10_0 <= var_10_0 then
			var_10_4 = 2
		elseif iter_10_0 <= var_10_1 or var_10_5 then
			var_10_4 = 1
		end

		self.items_[iter_10_0]:RefreshView(var_10_3, var_10_4, var_10_5)
	end
end

function SevenDaySkinPage_3_4:RefreshBtn()
	local var_11_0 = GameSetting.activity_sign_bosaidong_button_open_time.value[1]
	local var_11_2
	local var_11_1

	if not GameSetting.activity_sign_bosaidong_button_open_time.value[1] then
		var_11_0 = 0
		var_11_1 = manager.time:GetServerTime()
		var_11_2 = SetActive
	end

	var_11_2(self.videoBtn_.gameObject, var_11_1 >= ActivityData:GetActivityData(self.activityID_).startTime + var_11_0 * 3600)
end

function SevenDaySkinPage_3_4:OnBtnSignClick()
	if self.data_:SignDay() >= self.maxDay_ then
		return
	end

	if self.data_:LeftSignTimes() > 0 then
		SevenDaySkinAction.ReqSign(self.activityID_)

		return
	end

	if self.data_:IsReSign() then
		self:ShowCheckDialog()

		return
	end

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function SevenDaySkinPage_3_4:OnSignSuccess(arg_13_1)
	local var_13_0 = self.data_:SignRewardList()[arg_13_1.sign_num]

	if var_0_1[var_13_0[1]] then
		JumpTools.OpenPageByJump("sevenDaySkinPopView_3_4", {
			msg = var_0_1[var_13_0[1]],
			reward = {
				var_13_0
			}
		})
	else
		getReward(formatRewardCfgList({
			var_13_0
		}))
	end

	self:RefreshView()

	self.crossDay_ = false
end

function SevenDaySkinPage_3_4:OnClearSuccess()
	self.data_ = SevenDaySkinData:GetActivityData(self.activityID_)

	self:RefreshView()

	self.crossDay_ = true
end

function SevenDaySkinPage_3_4:ShowCheckDialog()
	local var_15_0 = GameSetting.activity_supplementary_sign_new.value[2]
	local var_15_1 = CurrencyData:GetCurrencyNum(GameSetting.activity_supplementary_sign_new.value[1])

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(GameSetting.activity_supplementary_sign_new.value[1]), GameSetting.activity_supplementary_sign_new.value[2], GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")),
		OkCallback = function()
			local var_16_0, var_16_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_16_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay_ then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay_ = false
			elseif var_15_1 < var_15_0 then
				ShopTools.DiamondEnoughMessageBox()
			else
				SevenDaySkinAction.ReqSign(self.activityID_)
			end
		end
	})
end

function SevenDaySkinPage_3_4:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function SevenDaySkinPage_3_4:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage_3_4:OnExit()
	self:StopTimer()
	SevenDaySkinPage_3_4.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
end

function SevenDaySkinPage_3_4:Dispose()
	self:RemoveAllListeners()

	for iter_20_0 = 1, #self.items_ do
		self.items_[iter_20_0]:Dispose()
	end

	SevenDaySkinPage_3_4.super.Dispose(self)
end

return SevenDaySkinPage_3_4
