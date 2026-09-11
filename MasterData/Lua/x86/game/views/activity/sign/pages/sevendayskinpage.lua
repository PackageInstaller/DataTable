local var_0_0 = {
	[2714] = {
		author = "HERO_HADES_NAME",
		name = "hades",
		body = "HADES_WORD"
	},
	[2715] = {
		author = "HERO_ORSIRIS_NAME",
		name = "orsiris",
		body = "ORSIRIS_WORD"
	},
	[2716] = {
		author = "HERO_HELLA_NAME",
		name = "hella",
		body = "HELLA_WORD"
	},
	[1042051] = {
		author = "HERO_HADES_NAME",
		name = "hades",
		body = "HADES_SKIN_WORD"
	}
}

ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDaySkinPage = class("SevenDaySkinPage", ActivityMainBasePanel)

function SevenDaySkinPage:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDaySkinPage:Init()
	self:BindCfgUI()

	self.items = {}
	self.max_sign_day = SevenDaySkinData:MaxSignDay(self.activityID_)
	self.isResign = false

	for iter_2_0 = 1, self.max_sign_day do
		table.insert(self.items, (SevenDaySkinItem.New(self["btn_" .. iter_2_0])))
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)

	self:AddListeners()
end

function SevenDaySkinPage:AddListeners()
	self:AddBtnListener(self.BtnSign, nil, handler(self, self.OnBtnSignClick))
	self:AddBtnListener(self.BtnInfo, nil, handler(self, self.OnBtnInfoClick))
end

function SevenDaySkinPage:OnTop()
	self:UpdateBar()
end

function SevenDaySkinPage:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function SevenDaySkinPage:OnEnter()
	SevenDaySkinPage.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.redPoint:bindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_))

	self.data = SevenDaySkinData:GetActivityData(self.activityID_)
	self.crossDay = false

	self:RefreshView()
end

function SevenDaySkinPage:OnExit()
	SevenDaySkinPage.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.redPoint:unbindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_))
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SevenDaySkinPage:Dispose()
	SevenDaySkinPage.super.Dispose(self)

	for iter_8_0 = 1, #self.items do
		self.items[iter_8_0]:Dispose()
	end
end

function SevenDaySkinPage:RefreshView()
	self:RefreshSignInfo()
	self:RefreshItems()
end

function SevenDaySkinPage:RefreshSignInfo()
	local var_10_0 = self.data:IsReSign()
	local var_10_1 = self.data:SignDay() >= self.max_sign_day

	if self.TxtSign then
		self.TxtSign.text = GetTips(var_10_0 and "RESIGN" or "SIGN")
	end

	if self.BtnSign then
		self.BtnSign:SetActive(not var_10_1)
	end

	if var_10_1 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_), 0)
	end
end

function SevenDaySkinPage:RefreshItems()
	local var_11_0 = self.data:SignDay()
	local var_11_1 = var_11_0 + self.data:LeftSignTimes()
	local var_11_2 = self.data:SignRewardList()

	for iter_11_0 = 1, self.max_sign_day do
		self.items[iter_11_0]:RefreshView(var_11_2[iter_11_0], iter_11_0 <= var_11_0 and 2 or iter_11_0 <= var_11_1 and 1 or 0)
	end
end

function SevenDaySkinPage:OnBtnSignClick()
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

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function SevenDaySkinPage:OnSignSuccess(arg_13_1)
	if var_0_0[arg_13_1.item_list[1].id] then
		JumpTools.OpenPageByJump("sevenDaySkinPopView", {
			msg = var_0_0[arg_13_1.item_list[1].id],
			reward = arg_13_1.item_list
		})
	else
		getReward2(arg_13_1.item_list)
	end

	self:RefreshView()
end

function SevenDaySkinPage:ShowCheckDialog()
	local var_14_0 = GameSetting.activity_supplementary_sign.value[self.data:TodayBuyNum() + 1]
	local var_14_1 = var_14_0[2]
	local var_14_2 = ItemTools.getItemNum(var_14_0[1])

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = {
			GetTips("WHETHER_TO_CONSUME"),
			{
				var_14_0[1],
				var_14_0[2]
			},
			(GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN"))
		},
		OkCallback = function()
			local var_15_0, var_15_1 = ActivityData:GetActivityTime(self.activityID_)

			if var_15_1 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif self.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				self.crossDay = false
			elseif var_14_2 < var_14_1 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(self.activityID_)
			end
		end
	})
end

function SevenDaySkinPage:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function SevenDaySkinPage:OnClearSuccess()
	self.data = SevenDaySkinData:GetActivityData(self.activityID_)

	self:RefreshView()

	self.crossDay = true
end

return SevenDaySkinPage
