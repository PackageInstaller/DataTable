local AdminCatExploreRewardAniView = class("AdminCatExploreRewardAniView", ReduxView)

function AdminCatExploreRewardAniView:UIName()
	return "Widget/System/ExploreUI/ExploCalculusAnimationUI"
end

function AdminCatExploreRewardAniView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminCatExploreRewardAniView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreRewardAniView:InitUI()
	self:BindCfgUI()

	self.rewardList_ = LuaList.New(handler(self, self.SetItemData), self.listGo_, AdminCatExploreRewardItem)
	self.rateController = ControllerUtil.GetController(self.gameObject_.transform, "rate")
	self.itemList = {}
end

function AdminCatExploreRewardAniView:AddUIListener()
	self:AddBtnListener(self.getRewardBtn_, nil, function()
		if self.isOver ~= true then
			return
		end

		self.isOver = nil

		local var_6_0 = LeanTween.value(self.nullGo_, self.exploreDay, 0, self.exploreDay * 0.2)

		var_6_0:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
			self.handle_.fillAmount = arg_7_0 / 7
			self.numTxt_.text = math.ceil(self.rate[self.exploreDay] / 7 * arg_7_0 * 100) .. "<size=24>%</size>"

			self.rateController:SetSelectedState(tostring((math.floor(arg_7_0))))
		end))
		var_6_0:setOnComplete(System.Action(function()
			LeanTween.cancel(self.nullGo_)
			var_6_0:setOnUpdate(nil):setOnComplete(nil)
			AdminCatExploreAction.GetWeekReward()
		end))
		manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. self.exploreDay .. "_down", "")
	end)
end

function AdminCatExploreRewardAniView:SetItemData(arg_9_1, arg_9_2)
	arg_9_2:SetItemData(self.reward[arg_9_1], arg_9_1)
	table.insert(self.itemList, arg_9_2)
end

function AdminCatExploreRewardAniView:OnGetWeeklyReward()
	self:Back()
end

function AdminCatExploreRewardAniView:UpdateView()
	self.rate = AdminCatExploreData:GetDataByPara("rate")
	self.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	self.reward = {}

	for iter_11_0, iter_11_1 in ipairs(ExploreLevelCfg[AdminCatExploreData:GetDataByPara("level")].accumulate_rewards) do
		table.insert(self.reward, {
			iter_11_1[1],
			iter_11_1[2] * self.rate[self.exploreDay]
		})
	end

	for iter_11_2 = 1, 7 do
		self["txt" .. iter_11_2].text = "x" .. self.rate[iter_11_2]
	end

	self.rewardList_:StartScroll(#self.reward)

	if self.exploreDay == 0 then
		self.handle_.fillAmount = 0

		self.rateController:SetSelectedState("0")

		self.numTxt_.text = "0<size=24>%</size>"

		for iter_11_3, iter_11_4 in ipairs(self.itemList) do
			iter_11_4:UpdateText(0)
		end

		return
	end

	local var_11_0 = LeanTween.value(self.nullGo_, 0, self.exploreDay, self.exploreDay * 0.1)

	var_11_0:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		self.handle_.fillAmount = arg_12_0 / 7
		self.numTxt_.text = math.ceil(self.rate[self.exploreDay] / self.exploreDay * arg_12_0 * 100) .. "<size=24>%</size>"

		for iter_12_0, iter_12_1 in ipairs(self.itemList) do
			iter_12_1:UpdateText(math.ceil(self.reward[iter_12_0][2] / self.exploreDay * arg_12_0))
		end

		self.rateController:SetSelectedState(tostring((math.floor(arg_12_0))))
	end))
	var_11_0:setOnComplete(System.Action(function()
		LeanTween.cancel(self.nullGo_)

		self.isOver = true

		var_11_0:setOnUpdate(nil):setOnComplete(nil)
	end))
	manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. self.exploreDay .. "_up", "")
end

function AdminCatExploreRewardAniView:OnEnter()
	self:UpdateView()
end

function AdminCatExploreRewardAniView:OnExit()
	self.isOver = nil
	self.itemList = {}
end

function AdminCatExploreRewardAniView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
end

function AdminCatExploreRewardAniView:Dispose()
	if self.rewardList_ then
		self.rewardList_:Dispose()

		self.rewardList_ = nil
	end

	AdminCatExploreRewardAniView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreRewardAniView
