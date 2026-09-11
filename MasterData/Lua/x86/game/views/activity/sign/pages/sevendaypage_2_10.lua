local var_0_0 = {}

ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local SevenDayPage_2_10 = class("SevenDayPage_2_10", ActivityMainBasePanel)

function SevenDayPage_2_10:GetUIName()
	return ActivityCumulativeSignCfg[self.activityID_].ui_path
end

function SevenDayPage_2_10:Init()
	self:BindCfgUI()

	self.items = {}
	self.max_sign_day = SevenDaySkinData:MaxSignDay(self.activityID_)

	for iter_2_0 = 1, self.max_sign_day do
		table.insert(self.items, (SevenDaySkinItem_2_10.New(self["btn_" .. iter_2_0])))
	end

	self.onSignHandler = handler(self, self.OnSignSuccess)
	self.onClearHandler = handler(self, self.OnClearSuccess)

	self:AddListeners()
end

function SevenDayPage_2_10:AddListeners()
	self:AddBtnListener(self.BtnSign, nil, handler(self, self.OnBtnSignClick))
end

function SevenDayPage_2_10:OnTop()
	self:UpdateBar()
end

function SevenDayPage_2_10:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function SevenDayPage_2_10:OnEnter()
	SevenDayPage_2_10.super.OnEnter(self)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.redPoint:bindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_))

	self.data = SevenDaySkinData:GetActivityData(self.activityID_)
	self.random = 0

	self:RefreshView()
	self:ResetNum()
end

function SevenDayPage_2_10:OnExit()
	SevenDayPage_2_10.super.OnExit(self)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, self.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, self.onClearHandler)
	manager.redPoint:unbindUIandKey(self.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_))
	manager.windowBar:HideBar()

	if self.text4Timer then
		self.text4Timer:Stop()

		self.text4Timer = nil
	end

	if self.text3Timer then
		self.text3Timer:Stop()

		self.text3Timer = nil
	end
end

function SevenDayPage_2_10:Dispose()
	SevenDayPage_2_10.super.Dispose(self)

	for iter_8_0 = 1, #self.items do
		self.items[iter_8_0]:Dispose()
	end
end

function SevenDayPage_2_10:RefreshView()
	self:RefreshSignInfo()
	self:RefreshItems()
	SetActive(self.signEfc, self.data:LeftSignTimes() > 0)
end

function SevenDayPage_2_10:RefreshSignInfo()
	local var_10_0 = self.data:SignDay() >= self.max_sign_day

	if self.TxtSign then
		self.TxtSign.text = GetTips("SIGN")
	end

	if self.BtnSign then
		self.BtnSign:SetActive(not var_10_0)
	end

	if var_10_0 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, self.activityID_), 0)
	end
end

function SevenDayPage_2_10:RefreshItems()
	local var_11_0 = self.data:SignDay()
	local var_11_1 = var_11_0 + self.data:LeftSignTimes()
	local var_11_2 = self.data:SignRewardList()

	for iter_11_0 = 1, self.max_sign_day do
		self.items[iter_11_0]:RefreshView(var_11_2[iter_11_0], iter_11_0 <= var_11_0 and 2 or iter_11_0 <= var_11_1 and 1 or 0)
	end
end

function SevenDayPage_2_10:OnBtnSignClick()
	if self.data:SignDay() >= self.max_sign_day then
		return
	end

	if self.data:LeftSignTimes() > 0 then
		SevenDaySkinAction.ReqSign(self.activityID_)

		return
	end

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function SevenDayPage_2_10:OnSignSuccess(arg_13_1)
	local var_13_0 = self.data:SignRewardList()[arg_13_1.sign_num]

	if var_0_0[var_13_0[1]] then
		JumpTools.OpenPageByJump("sevenDaySkinPopView", {
			msg = var_0_0[var_13_0[1]],
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
	self:ResetNum()
end

function SevenDayPage_2_10:ShowCheckDialog()
	local var_14_0 = GameSetting.activity_supplementary_sign_new.value[2]
	local var_14_1 = ItemTools.getItemNum(GameSetting.activity_supplementary_sign_new.value[1])

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = {
			GetTips("WHETHER_TO_CONSUME"),
			{
				GameSetting.activity_supplementary_sign_new.value[1],
				GameSetting.activity_supplementary_sign_new.value[2]
			},
			(GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN"))
		},
		OkCallback = function()
			if var_14_1 < var_14_0 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(self.activityID_)
			end
		end
	})
end

function SevenDayPage_2_10:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function SevenDayPage_2_10:OnClearSuccess()
	self.data = SevenDaySkinData:GetActivityData(self.activityID_)

	self:RefreshView()
end

function SevenDayPage_2_10:ResetNum()
	local var_18_0 = self.data:SignDay()

	if var_18_0 > 0 then
		self.anim2:Play("num03", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function()
			self.text2.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. var_18_0)
		end, {})
		self:RefreshTimer(var_18_0)
	end
end

function SevenDayPage_2_10:TracaBack()
	local var_20_0 = math.random(0, 5)

	if var_20_0 == self.random then
		self:TracaBack()
	else
		self.random = var_20_0

		return
	end
end

function SevenDayPage_2_10:RefreshTimer(arg_21_1)
	if self.text3Timer then
		self.text3Timer:Stop()

		self.text3Timer = nil
	end

	if self.text4Timer then
		self.text4Timer:Stop()

		self.text4Timer = nil
	end

	self.text4Timer = Timer.New(function()
		self.anim4:Play("num02", -1, 0)
		self.anim5:Play("num04", -1, 0)
		self.anim6:Play("num", -1, 0)
		self.anim7:Play("num03", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function()
			self.text4.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			self.text5.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			self.text6.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			self.text7.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
		end, {})
	end, 7, -1)
	self.text3Timer = Timer.New(function()
		local var_24_0 = math.random(0, 5)

		if var_24_0 == self.random then
			self:TracaBack()
		else
			self.random = var_24_0
		end

		self.anim3:Play("num", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function()
			self.text3.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. self.random)
		end, {})
	end, GameSetting.activity_supplementary_sign_change_time.value[arg_21_1], -1)

	self.text4Timer:Start()
	self.text3Timer:Start()
end

return SevenDayPage_2_10
