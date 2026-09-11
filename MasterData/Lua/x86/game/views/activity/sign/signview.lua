local SignView = class("SignView", ReduxView)

function SignView:UIName()
	return "Widget/System/ActivitySign/ActivityUI"
end

function SignView:UIParent()
	return manager.ui.uiPop.transform
end

function SignView:Init()
	self:InitUI()
	self:AddListeners()

	self.selectIndex = -1
	self.allToggles = {
		ActivityDailySignToggle.New(),
		ActivityMonthCardToggle.New(),
		ActivityBigMonthCardToggle.New()
	}

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}) do
		table.insert(self.allToggles, ActivitySevenSignToggle.New(iter_3_1))
	end

	self.pages = {}
end

function SignView:InitUI()
	self:BindCfgUI()

	self.toggleList = LuaList.New(handler(self, self.IndexItem), self.m_list, SignToggleItem)
end

function SignView:AddListeners()
	self:AddBtnListener(self.m_maskBtn, nil, function()
		if self.signReady_ then
			self:Back()
		end
	end)
end

function SignView:OnTop()
	if self.params_.check then
		self:CheckSign()

		self.params_.check = nil
	end
end

function SignView:OnEnter()
	JumpTools.RefreshGaussianBg()

	self.toggles = {}

	for iter_8_0, iter_8_1 in pairs(self.allToggles) do
		if iter_8_1:IsActivity() and PlayerData:GetPlayerInfo().userLevel >= iter_8_1:GetLimitLevel() then
			table.insert(self.toggles, iter_8_1)
		end
	end

	table.sort(self.toggles, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:Check() and 1 or 0
		local var_9_1 = arg_9_1:Check() and 1 or 0

		if var_9_0 == var_9_1 then
			local var_9_2 = arg_9_0:IsManual() and 0 or 1
			local var_9_3 = arg_9_1:IsManual() and 0 or 1

			if var_9_2 == var_9_3 then
				return arg_9_0:Order() > arg_9_1:Order()
			else
				return var_9_3 < var_9_2
			end
		else
			return var_9_1 < var_9_0
		end
	end)
	self.toggleList:StartScroll(#self.toggles)

	if self.params_.isBack then
		self:SetSelectPage(SignData:GetHistoryIndex() or 1)
	elseif self.params_.systemID then
		local var_8_0 = 1

		for iter_8_2, iter_8_3 in pairs(self.toggles) do
			if iter_8_3:GetSystemID() == self.params_.systemID then
				var_8_0 = iter_8_2

				break
			end
		end

		self.params_.systemID = nil

		self:SetSelectPage(var_8_0)
	else
		self:SetSelectPage(1)
	end

	self.signReady_ = true
end

function SignView:OnExit()
	self.signReady_ = false

	SignData:SetHistoryIndex(self.selectIndex)

	self.selectIndex = -1

	if self.curPage then
		self.curPage:SetActive(false)

		self.curPage = nil
	end
end

function SignView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.toggles[arg_11_1])
	arg_11_2:SetSelect(self.selectIndex)
	arg_11_2:RegistCallBack(handler(self, self.SetSelectPage))
end

function SignView:SetSelectPage(arg_12_1)
	if arg_12_1 == self.selectIndex then
		return
	end

	arg_12_1 = math.min(arg_12_1, #self.toggles)

	local var_12_0 = self.toggles[arg_12_1]:GetLimitLevel()

	if var_12_0 > PlayerData:GetPlayerInfo().userLevel then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_12_0))

		return
	end

	self.selectIndex = arg_12_1

	for iter_12_0, iter_12_1 in ipairs((self.toggleList:GetItemList())) do
		iter_12_1:SetSelect(self.selectIndex)
	end

	self:RefreshUI()
end

function SignView:RefreshUI()
	if self.curPage then
		self.curPage:SetActive(false)
	end

	local var_13_0 = self.toggles[self.selectIndex]
	local var_13_1 = self.toggles[self.selectIndex]:GetName()

	self.pages[var_13_1] = self.pages[var_13_1] or var_13_0:UIClass().New(self, self.m_content, (var_13_0:GetParams()))
	self.curPage = self.pages[var_13_1]

	self.curPage:SetActive(true)
	self.curPage.transform_:SetAsLastSibling()
end

function SignView:CheckSign()
	for iter_14_0, iter_14_1 in ipairs(self.toggles) do
		if iter_14_1:Check() then
			self:SetSelectPage(iter_14_0)
			self.curPage:AutoGetReward()

			return
		end
	end

	if not self.selectIndex or self.selectIndex == -1 then
		self:SetSelectPage(1)
	end

	self.signReady_ = true
end

function SignView:OnReadyToSkipAnimation(arg_15_1)
	self.curPage.animPlaying = not arg_15_1

	SetActive(self.m_skipBtn.gameObject, not arg_15_1)
end

function SignView:OnSign(arg_16_1, arg_16_2)
	if self.curPage and self.curPage.OnSign then
		self.curPage:OnSign(arg_16_1)
	end
end

function SignView:OnMonthCardDailyReward()
	if self.curPage and self.curPage.OnMonthCardDailyReward then
		self.curPage:OnMonthCardDailyReward()
	end

	self:CheckSign()
end

function SignView:OnGetFatigueSuccess(arg_18_1)
	if self.curPage and self.curPage.OnGetFatigueSuccess then
		self.curPage:OnGetFatigueSuccess(arg_18_1)
	end
end

function SignView:OnAccumulateLoginRefresh()
	if self.curPage and self.curPage.RefreshSignItem then
		self.curPage:RefreshSignItem()
	end
end

function SignView:OnBigMonthCardSign(arg_20_1, arg_20_2, arg_20_3)
	if self.curPage then
		local var_20_0 = self.curPage.btnAni
		local var_20_1

		if self.curPage.btnAni ~= nil then
			self.curPage.btnAni.enabled = true

			if arg_20_3 > 0 then
				var_20_1 = self.curPage.itemAni[arg_20_3]
				var_20_1.enabled = true
			end

			self.aniTimer_ = Timer.New(function()
				if not self.curPage then
					if self.aniTimer_ then
						self.aniTimer_:Stop()

						self.aniTimer_ = nil
					end

					return
				end

				if var_20_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not self.curPage.animPlaying then
					if self.curPage.animPlaying then
						self:OnReadyToSkipAnimation(true)
					end

					getReward(arg_20_1, nil, function()
						self:CheckSign()
					end)
					BigMonthCardData:SetRecord(arg_20_2)

					var_20_0.enabled = false

					if var_20_1 then
						var_20_1.enabled = false
					end

					manager.notify:Invoke(GET_BIG_MONTH_SIGN)

					if self.aniTimer_ then
						self.aniTimer_:Stop()

						self.aniTimer_ = nil
					end
				end
			end, 0.033, -1)

			manager.notify:CallUpdateFunc(SIGN_INPUT, true)
			self:OnReadyToSkipAnimation(false)
			self.aniTimer_:Start()
		end
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
	end
end

function SignView:OnSignViewInputChange(arg_23_1)
	self.signReady_ = arg_23_1

	manager.ui:UIEventEnabledByUI(arg_23_1, not arg_23_1)
end

function SignView:StopAniTimer()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end
end

function SignView:Dispose()
	self:StopAniTimer()
	self.toggleList:Dispose()

	for iter_25_0, iter_25_1 in pairs(self.pages) do
		iter_25_1:Dispose()
	end

	self.pages = {}

	SignView.super.Dispose(self)
end

return SignView
