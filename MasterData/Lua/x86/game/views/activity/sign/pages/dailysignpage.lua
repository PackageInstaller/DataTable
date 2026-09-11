local DailySignPage = class("DailySignPage", BaseSignPage)

function DailySignPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ActivitySign/SignUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function DailySignPage:Init()
	self:InitUI()
	self:AddListeners()
end

function DailySignPage:InitUI()
	self:BindCfgUI()

	self.animPlaying = false
	self.signItem_ = {}
	self.itemList_ = {}
	self.accuController_ = self.accumulateControllerEx_:GetController("sel")
	self.itemNumController_ = self.accumulateControllerEx_:GetController("number")
	self.accuStateontroller_ = self.accumulateControllerEx_:GetController("state")
end

function DailySignPage:AddListeners()
	self:AddBtnListener(self.accumulateBtn_, nil, function()
		JumpTools.OpenPageByJump("accumulateSignView")
	end)
end

function DailySignPage:OnShow()
	self:RefreshSignItem()
end

function DailySignPage:OnHide()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.accutimer_ then
		self.accutimer_:Stop()

		self.accutimer_ = nil
	end
end

function DailySignPage:RefreshSignItem()
	local var_8_0 = SignData:GetDailySignInfo().month
	local var_8_1 = manager.time:CalcMonthDays(manager.time:STimeDescS(manager.time:GetServerTime(), "!%Y"), var_8_0)

	for iter_8_0 = #self.signItem_, var_8_1 + 1, -1 do
		self.signItem_[iter_8_0]:Show(false)
	end

	for iter_8_1 = 1, var_8_1 do
		self.signItem_[iter_8_1] = self.signItem_[iter_8_1] or DailySignItem.New(self, (Object.Instantiate(self.itemGo_, self.contentParent_)))

		self.signItem_[iter_8_1]:SetData({
			month = var_8_0,
			day = iter_8_1,
			state = SignTools.GetDailySignState(iter_8_1)
		})
	end

	local var_8_2, var_8_3, var_8_4, var_8_5, var_8_6 = AccumulateSignData:GetShowProgress()

	self.accumulateSlider_.value = var_8_4
	self.accumulateText_.text = var_8_2 .. "/" .. var_8_3

	if AccumulateSignData:GetCanReward() then
		self.accuController_:SetSelectedIndex(1)
	else
		self.accuController_:SetSelectedIndex(0)
	end

	local var_8_7 = {}

	if AccumulateLoginCfg[var_8_5] then
		var_8_7 = AccumulateLoginCfg[var_8_5].reward
	end

	self.itemNumController_:SetSelectedIndex(#var_8_7 - 1)

	for iter_8_2 = 1, #var_8_7 do
		self.itemList_[iter_8_2] = self.itemList_[iter_8_2] or CommonItemView.New(self["commonItem_" .. iter_8_2], true)

		self.itemList_[iter_8_2]:SetData(var_8_7[iter_8_2])
		self.itemList_[iter_8_2]:RefreshCompleted(var_8_6)
		self.itemList_[iter_8_2]:Show(true)
	end

	if not AccumulateSignData:GetIsOpened() then
		SetActive(self.accumulateGo_, true)
		self.accuStateontroller_:SetSelectedState("normal")
	else
		SetActive(self.accumulateGo_, false)
		self.accuStateontroller_:SetSelectedState("first")
	end
end

function DailySignPage:AutoGetReward()
	self.signIndex_ = SignTools.GetDailySignIndex()

	if self.signIndex_ > 0 then
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		self.timer_ = Timer.New(function()
			SignAction.QueryDailySign()
		end, 0.033, 1)

		self.timer_:Start()
	end
end

function DailySignPage:OnSign(arg_11_1)
	if isSuccess(arg_11_1.result) then
		if self.signIndex_ <= 0 then
			return
		end

		self.signItem_[self.signIndex_]:StartPlayAnimator()

		self.timer_ = Timer.New(function()
			if self.signItem_[self.signIndex_]:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not self.animPlaying then
				if self.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				local var_12_0 = arg_11_1.item_list

				if AccumulateSignData:GetIsOpened() then
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, function()
						manager.ui:UIEventEnabled(false)

						self.accuAnimator_.enabled = true

						self.accuAnimator_:Play("UI_nd_unlock")

						self.accutimer_ = Timer.New(function()
							if self.accuAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.5 then
								manager.ui:UIEventEnabled(true)
								self.accutimer_:Stop()

								self.accutimer_ = nil

								self.accuStateontroller_:SetSelectedState("normal")
								self.accuAnimator_:Play("Default")
								JumpTools.OpenPageByJump("accumulateSignView", {
									check_sign = true
								})
							end
						end, 0.033, -1)

						self.accutimer_:Start()
						self.accuStateontroller_:SetSelectedState("ani")
					end)
				elseif AccumulateSignData:GetCanReward() then
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, function()
						JumpTools.OpenPageByJump("accumulateSignView", {
							check_sign = true
						})
					end)
				else
					getReward2(var_12_0, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.WEAPON_SERVANT
					}, handler(self.hander_, self.hander_.CheckSign))
				end

				self.timer_:Stop()

				self.timer_ = nil
			end
		end, 0.033, -1)

		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		self.timer_:Start()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		ShowTips(arg_11_1.result)
	end
end

function DailySignPage:OnAccumulateLoginRefresh()
	self:RefreshSignItem()
end

function DailySignPage:Dispose()
	for iter_17_0, iter_17_1 in ipairs(self.signItem_) do
		iter_17_1:Dispose()
	end

	for iter_17_2, iter_17_3 in ipairs(self.itemList_) do
		iter_17_3:Dispose()
	end

	self.signItem_ = {}

	DailySignPage.super.Dispose(self)
end

return DailySignPage
