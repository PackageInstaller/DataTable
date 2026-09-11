local SevenDaySignPage = class("SevenDaySignPage", BaseSignPage)

function SevenDaySignPage:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.hander_ = arg_1_1
	self.activit_id = arg_1_3
	self.gameObject_ = Object.Instantiate(Asset.Load(ActivityCumulativeSignCfg[self.activit_id].ui_path), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SevenDaySignPage:Init()
	self:InitUI()
	self:Refresh()
end

function SevenDaySignPage:InitUI()
	self:BindCfgUI()

	self.animPlaying = false
	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.m_list, SevenDaySignItem)
end

function SevenDaySignPage:OnEnter()
	self:Show()
end

function SevenDaySignPage:OnShow()
	self:Refresh()
	self:RefreshSignItem()
end

function SevenDaySignPage:OnHide()
	if self.remainingTimer then
		self.remainingTimer:Stop()

		self.remainingTimer = nil
	end
end

function SevenDaySignPage:RefreshSignItem()
	local var_7_0 = SignData:GetSevenDaySignInfo(self.activit_id)
	local var_7_1 = SignTools.GetSevenDaySignIndex(self.activit_id)
	local var_7_2 = 0

	if var_7_1 ~= 0 then
		var_7_2 = var_7_1
	elseif var_7_0 ~= nil then
		var_7_2 = var_7_0.signCount
	end

	self.scrollHelper:StartScroll(#ActivityCumulativeSignCfg[self.activit_id].config_list, var_7_2)
end

function SevenDaySignPage:indexItem(arg_8_1, arg_8_2)
	arg_8_2:Refresh(arg_8_1, ActivityCumulativeSignCfg[self.activit_id].config_list[arg_8_1], SignTools.GetSevenDaySignState(self.activit_id, arg_8_1), #ActivityCumulativeSignCfg[self.activit_id].config_list == 14)
end

function SevenDaySignPage:Refresh()
	if self.remainingTimer then
		self.remainingTimer:Stop()

		self.remainingTimer = nil
	end

	self.remainingTimer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.remainingTimer:Start()
	self:RefreshTime()
end

function SevenDaySignPage:RefreshTime()
	local var_11_0 = ActivityData:GetActivityData(self.activit_id)

	if var_11_0 then
		self.m_timer.text = string.format(GetTips("LEFT_TIME"), (manager.time:GetLostTimeStrWith2Unit(var_11_0.stopTime)))
	end
end

function SevenDaySignPage:AutoGetReward()
	self.signIndex_ = SignTools.GetSevenDaySignIndex(self.activit_id)

	if self.signIndex_ > 0 then
		manager.notify:CallUpdateFunc(SIGN_INPUT, false)

		if self.timer_ then
			self.timer_:Stop()
		end

		local var_12_0 = #ActivityCumulativeSignCfg[self.activit_id].config_list or 7

		if var_12_0 > 7 then
			var_12_0 = 7
		end

		self.timer_ = nil
		self.limitTime = 0
		self.timer_ = Timer.New(function()
			self.limitTime = self.limitTime + 0.033

			if #self.scrollHelper:GetItemList() >= var_12_0 or self.limitTime > 1 then
				SignAction.QuerySevenDaySign(self.activit_id)
				self.timer_:Stop()

				self.timer_ = nil
			end
		end, 0.033, -1)

		self.timer_:Start()
	end
end

function SevenDaySignPage:GetItem(arg_14_1)
	for iter_14_0, iter_14_1 in pairs((self.scrollHelper:GetItemList())) do
		if arg_14_1 == iter_14_1.index then
			return iter_14_1
		end
	end

	return nil
end

function SevenDaySignPage:OnSign(arg_15_1)
	if isSuccess(arg_15_1.result) then
		if self.signIndex_ <= 0 then
			return
		end

		local var_15_0 = self:GetItem(self.signIndex_)

		if not var_15_0 then
			manager.notify:CallUpdateFunc(SIGN_INPUT, true)
			self:RefreshSignItem()

			return
		end

		var_15_0:StartPlayAnimator()

		self.timer_ = Timer.New(function()
			if var_15_0:GetAnimator():GetCurrentAnimatorStateInfo(0).normalizedTime >= 2 or not self.animPlaying then
				if self.animPlaying then
					manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, true)
				end

				getReward2(arg_15_1.item_list, nil, handler(self.hander_, self.hander_.CheckSign))
				self.timer_:Stop()

				self.timer_ = nil
			end
		end, 0.033, -1)

		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		manager.notify:CallUpdateFunc(READY_TO_SKIP_SIGN_ANIMATION, false)
		self.timer_:Start()
	else
		manager.notify:CallUpdateFunc(SIGN_INPUT, true)
		ShowTips(arg_15_1.result)
	end
end

function SevenDaySignPage:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.scrollHelper:Dispose()
	SevenDaySignPage.super.Dispose(self)
end

return SevenDaySignPage
