local AdminCatExploreRewardView = class("AdminCatExploreRewardView", ReduxView)

function AdminCatExploreRewardView:UIName()
	return "Widget/System/ExploreUI/ExploCalculusPopUI"
end

function AdminCatExploreRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExploreRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreRewardView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.SetItemData), self.listGo_, AdminCatExploreRewardItem)
	self.rateController = ControllerUtil.GetController(self.gameObject_.transform, "rate")
	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function AdminCatExploreRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonBtn_, nil, function()
		if self.stateController:GetSelectedState() == "go" then
			self:Back()
			JumpTools.GoToSystem("/adminCatExploreRewardAni", {})
		end
	end)
end

function AdminCatExploreRewardView:SetItemData(arg_8_1, arg_8_2)
	arg_8_2:SetItemData(self.reward[arg_8_1], arg_8_1)
end

function AdminCatExploreRewardView:UpdateBar()
	return
end

function AdminCatExploreRewardView:UpdateView()
	local var_10_0 = AdminCatExploreData:GetDataByPara("level")

	self.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	self.handle_.fillAmount = self.exploreDay / 7
	self.dayTxt_.text = string.format(GetTips("EXPLORE_ACCUMULATE_TIME"), self.exploreDay)
	self.isGet = AdminCatExploreData:GetDataByPara("getWeeklyReward") == 1
	self.rate = AdminCatExploreData:GetDataByPara("rate")
	self.reward = {}
	self.rateTxt_.text = "x" .. self.rate[self.exploreDay]

	for iter_10_0, iter_10_1 in ipairs(ExploreLevelCfg[var_10_0].accumulate_rewards) do
		table.insert(self.reward, {
			iter_10_1[1],
			iter_10_1[2] * self.rate[self.exploreDay]
		})
	end

	if AdminCatExploreData:CheckCanGetWeeklyReward() then
		self.stateController:SetSelectedState(self.isGet and "get" or "go")
	else
		self.stateController:SetSelectedState("normal")
	end

	for iter_10_2 = 1, 7 do
		self["txt" .. iter_10_2].text = "x" .. self.rate[iter_10_2]
	end

	self.rewardList_:StartScroll(#self.reward)
	self.rateController:SetSelectedState(tostring(self.exploreDay))
end

function AdminCatExploreRewardView:OnEnter()
	self:UpdateView()

	local var_11_0 = AdminCatExploreData:CheckCanGetWeeklyReward()

	self.updateTimer_ = Timer.New(function()
		if AdminCatExploreData:CheckCanGetWeeklyReward() ~= var_11_0 then
			self:UpdateView()
			self.updateTimer_:Stop()
		end
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function AdminCatExploreRewardView:OnExit()
	manager.windowBar:HideBar()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function AdminCatExploreRewardView:Hide()
	SetActive(self.gameObject_, false)
end

function AdminCatExploreRewardView:Show()
	SetActive(self.gameObject_, true)
end

function AdminCatExploreRewardView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	AdminCatExploreRewardView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreRewardView
