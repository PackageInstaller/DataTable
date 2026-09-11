local SPHeroChallengeEntrustView = class("SPHeroChallengeEntrustView", ReduxView)

function SPHeroChallengeEntrustView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustView"
end

function SPHeroChallengeEntrustView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeEntrustView:OnCtor()
	return
end

function SPHeroChallengeEntrustView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SPHeroChallengeEntrustView:InitUI()
	self:BindCfgUI()

	self.activityID = SPHeroChallengeData:GetActivityID()
	self.curEntrustItemList = {}

	for iter_5_0 = 1, SPHeroChallengeTools:GetMaxStartEntrustPosNum(self.activityID) do
		local var_5_0 = SPHeroChallengeEntrustStartItem.New(self["entrustitem" .. iter_5_0 .. "Go_"], iter_5_0)

		var_5_0:ClickEmptyFunc(handler(self, self.OpenChooseList))

		self.curEntrustItemList[iter_5_0] = var_5_0
	end

	self.waitEntrustItemScroll = LuaList.New(handler(self, self.indexWaitEntrust), self.waitListGo_, SPHeroChallengeEntrustWaitItem)
end

function SPHeroChallengeEntrustView:OnEnter()
	self.activityInfo = SPHeroChallengeData:GetCurActivityInfo()

	self:RefreshStartEntrust()
	self:RefreshWaitEntrustList()
	self:StartTimer()
	self:RefreshBar()
	self:RegisterEvents()
end

function SPHeroChallengeEntrustView:OnTop()
	self:BindRedPonit()
	self:StartTimer()
	SPHeroChallengeAction:RefreshEntrust()
end

function SPHeroChallengeEntrustView:OnExit()
	self:StopTimer()
	manager.windowBar:HideBar()
end

function SPHeroChallengeEntrustView:BindRedPonit()
	return
end

function SPHeroChallengeEntrustView:UnBindRedPonit()
	return
end

function SPHeroChallengeEntrustView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_TICKET
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_TICKET, true)
end

function SPHeroChallengeEntrustView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:UnBindRedPonit()
	self:RemoveAllEventListener()
end

function SPHeroChallengeEntrustView:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_14_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_14_0 then
			local var_14_1 = var_14_0:GetCanGetRewardEntrustIndexList()

			if #var_14_1 > 0 then
				SPHeroChallengeAction:GetEntrustAward(var_14_1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function SPHeroChallengeEntrustView:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function()
		self:RefreshStartEntrust()
		self:RefreshWaitEntrustList()
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_FIN_ENTRUST, function()
		self:RefreshStartEntrust()
		self:RefreshWaitEntrustList()
	end)
end

function SPHeroChallengeEntrustView:Dispose()
	if self.curEntrustItemList then
		for iter_18_0, iter_18_1 in pairs(self.curEntrustItemList) do
			iter_18_1:Dispose()
		end
	end

	if self.waitEntrustItemList then
		self.waitEntrustItemList:Dispose()
	end

	if self.waitEntrustItemScroll then
		self.waitEntrustItemScroll:Dispose()
	end

	self:StopTimer()
	SPHeroChallengeEntrustView.super.Dispose(self)
end

function SPHeroChallengeEntrustView:RefreshStartEntrust()
	if self.curEntrustItemList then
		for iter_19_0, iter_19_1 in ipairs(self.curEntrustItemList) do
			local var_19_0 = self.activityInfo:GetShowIndexEntrustInfo(iter_19_0)
			local var_19_1 = {
				showIndex = iter_19_0
			}

			var_19_1.state = var_19_0 and (self.activityInfo:GetEntrustEndTime(var_19_0.index) and "end" or "start") or SPHeroChallengeTools:GetEntrustPosState(self.activityID, iter_19_0) == SpHeroChallengeConst.EntrustPosState.empty and "empty" or "lock"

			iter_19_1:RefreshUI(var_19_1)
		end
	end
end

function SPHeroChallengeEntrustView:RefreshWaitEntrustList()
	self.startWaitList = {}

	local var_20_0 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(self.activityID)

	for iter_20_0 = 1, SPHeroChallengeTools:GetMaxWaitEntrustPosNum(self.activityID) do
		local var_20_1 = {}
		local var_20_2 = self.activityInfo:GetShowIndexEntrustInfo(iter_20_0 + var_20_0)

		var_20_1 = var_20_2 and {
			showIndex = iter_20_0 + var_20_0,
			entrustIndex = var_20_2.index
		} or SPHeroChallengeTools:GetEntrustPosState(self.activityID, iter_20_0 + var_20_0) == SpHeroChallengeConst.EntrustPosState.lock and {
			state = "lock"
		} or {
			state = "empty"
		}
		var_20_1.showiIndex = iter_20_0 + var_20_0
		self.startWaitList[iter_20_0] = var_20_1
	end

	self.waitEntrustItemScroll:StartScroll(#self.startWaitList)
end

function SPHeroChallengeEntrustView:indexCanEntrust(arg_21_1, arg_21_2)
	arg_21_2:RefreshUI({
		index = arg_21_1,
		id = self.canChooseList[arg_21_1]
	})
end

function SPHeroChallengeEntrustView:indexWaitEntrust(arg_22_1, arg_22_2)
	arg_22_2:RefreshUI(self.startWaitList[arg_22_1])
	arg_22_2:ClickEmptyFunc(handler(self, self.OpenChooseList))
end

function SPHeroChallengeEntrustView:OpenChooseList()
	JumpTools.OpenPageByJump("spHeroChallengeChooseEntrustPop")
end

function SPHeroChallengeEntrustView:StartTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		if self.curEntrustItemList then
			for iter_25_0, iter_25_1 in pairs(self.curEntrustItemList) do
				iter_25_1:RefreshTime()
			end
		end
	end, 1, -1)

	self.timer:Start()
end

function SPHeroChallengeEntrustView:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

return SPHeroChallengeEntrustView
