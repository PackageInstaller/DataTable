local AccumulateSignView = class("AccumulateSignView", ReduxView)

function AccumulateSignView:UIName()
	return "Widget/System/ActivitySign/StreakBonusPopUI"
end

function AccumulateSignView:UIParent()
	return manager.ui.uiPop.transform
end

function AccumulateSignView:Init()
	self:InitUI()
	self:AddUIListener()

	self.monthCardController_ = self.monthCardControllerEx_:GetController("status")
	self.passportController_ = self.passportControllerEx_:GetController("status")
	self.passportNextController_ = self.passportControllerEx_:GetController("next")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, AccumulateSignItem)
	self.rewardList_ = {}
end

function AccumulateSignView:InitUI()
	self:BindCfgUI()
end

function AccumulateSignView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		JumpTools.Back(1, {
			check = true
		})
	end)
	self:AddBtnListener(self.mainTitleBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CUMULATIVE_LOGIN_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CUMULATIVE_LOGIN_DESC")
		})
	end)
	self:AddBtnListener(self.discountBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CUMULATIVE_SALE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CUMULATIVE_SALE_DESC")
		})
	end)
	self:AddBtnListener(self.monthCardBtn_, nil, function()
		JumpTools.GoToSystem("/rechargeMain", {
			childShopIndex = 1,
			page = 3
		}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	end)
	self:AddBtnListener(self.passportBtn_, nil, function()
		if not PassportData:IsOpen() then
			ShowTips("NOT_IN_OPEN_TIME")

			return
		end

		JumpTools.OpenPageByJump("/passportMain", nil, ViewConst.SYSTEM_ID.PASSPORT_MAIN)
	end)
end

function AccumulateSignView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(AccumulateLoginCfg.get_id_list_by_version[self.curVersion_][arg_11_1], function(arg_12_0)
		self:OnClickPointReward(arg_12_0)
	end)
end

function AccumulateSignView:OnClickPointReward(arg_13_1)
	AccumulateSignAction.GetAccumulateRewardView({
		arg_13_1
	})
end

function AccumulateSignView:OnEnter()
	self:RefreshUI()
	AccumulateSignAction.OpenAccumulateSignView()
end

function AccumulateSignView:RefreshUI()
	self.curVersion_ = AccumulateSignData:GetVersion()
	self.monthCardNum_, self.monthcardLv_ = AccumulateSignData:GetMonthCardNumAndLv()
	self.passportNum_, self.passportLv_ = AccumulateSignData:GetPassportNumAndLv()
	self.loginNum_ = AccumulateSignData:GetLoginNum()
	self.rewardList_ = AccumulateLoginCfg.get_id_list_by_version[self.curVersion_]

	self.uiList_:StartScroll(#self.rewardList_)

	local var_15_0, var_15_1, var_15_2, var_15_3, var_15_4, var_15_5 = AccumulateSignData:GetShowProgress()

	self.uiList_:ScrollToIndex(var_15_5, false, false)
	self.monthCardController_:SetSelectedIndex(self.monthcardLv_)

	if PassportData:GetPayLevel() > 0 then
		self.passportNextController_:SetSelectedIndex(1)
		self.passportController_:SetSelectedIndex(math.min(self.passportLv_ + 1, 3))
	elseif not PassportData:IsOpen() then
		self.passportNextController_:SetSelectedIndex(1)
		self.passportController_:SetSelectedIndex(math.min(self.passportLv_, 3))
	else
		self.passportNextController_:SetSelectedIndex(0)
		self.passportController_:SetSelectedIndex(math.min(self.passportLv_, 3))
	end

	self.accumulateNumText_.text = tostring(self.loginNum_) .. GetTips("DAY")
	self.mainTitleText_.text = GetTips("CUMULATIVE_LOGIN_TIPS")
	self.discountText_.text = GetTips("CUMULATIVE_LOGIN_SALE_NAME")
end

function AccumulateSignView:OnAccumulateLoginRefresh()
	self:RefreshUI()
end

function AccumulateSignView:Dispose()
	self:RemoveAllListeners()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	self.super.Dispose(self)
end

return AccumulateSignView
