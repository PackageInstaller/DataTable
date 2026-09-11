local MonthCardPage = class("MonthCardPage", BaseSignPage)

function MonthCardPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ActivitySign/MonthCardUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MonthCardPage:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonthCardPage:InitUI()
	self:BindCfgUI()

	self.haveGetController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveGet")
	self.bonusIcon_.sprite = ItemTools.getItemSprite(GameSetting.monthly_card_reward_daily.value[1])
	self.bonusLabel_.text = "x" .. GetI18NText(GameSetting.monthly_card_reward_daily.value[2])
end

function MonthCardPage:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		return
	end)
end

function MonthCardPage:OnShow()
	self:UpdateView()
end

function MonthCardPage:UpdateView()
	print(debug.traceback("MonthCardView::UpdateView, sign = " .. tostring(RechargeData:IsSignToday())))

	if RechargeData:IsSignToday() then
		self.haveGetController_:SetSelectedState("true")
	else
		self.haveGetController_:SetSelectedState("false")
	end

	self.surplusDay_.text = RechargeData:GetMonthCardLastDay() .. GetTips("DAY")
end

function MonthCardPage:OnMonthCardDailyReward()
	manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	self:UpdateView()
end

function MonthCardPage:AutoGetReward()
	manager.notify:CallUpdateFunc(SIGN_INPUT, false)
	TimeTools.StartAfterSeconds(1, function()
		PayAction.GetMonthCardBonus()
	end, {})
end

return MonthCardPage
