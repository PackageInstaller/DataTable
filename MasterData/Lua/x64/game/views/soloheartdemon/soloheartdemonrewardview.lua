local SoloHeartDemonRewardView = class("SoloHeartDemonRewardView", ReduxView)

function SoloHeartDemonRewardView:UIName()
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonRewardUI"
end

function SoloHeartDemonRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloHeartDemonRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.OnSwitchLeftBtnTypeHandler_ = handler(self, self.OnSwitchLeftBtnType)
end

function SoloHeartDemonRewardView:InitUI()
	self:BindCfgUI()

	self.normalList = LuaList.New(handler(self, self.SetRewardItem), self.list1_, SoloHeartDemonRewardItem)
	self.rankList = LuaList.New(handler(self, self.SetRewardItem), self.list2_, SoloHeartDemonRewardItem)
	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.leftBtnList_ = {}

	for iter_4_0 = 1, 2 do
		self.leftBtnList_[iter_4_0] = StoreBtnView.New(self[string.format("leftBtnGo%s_", iter_4_0)], CommonBtnTypeConst.DEMON, iter_4_0)
	end
end

function SoloHeartDemonRewardView:SetRewardItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(((self.selectIndex == 1 or nil) and (self.normalTaskList or self.rankTaskList))[arg_5_1], arg_5_1, self.selectIndex)
end

function SoloHeartDemonRewardView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		local var_7_0 = {
			reward_list = {}
		}

		for iter_7_0, iter_7_1 in ipairs(self.normalTaskList) do
			local var_7_1 = SoloHeartDemonData:GetDataByPara("taskData")[iter_7_1]

			if SoloHeartDemonData:GetDataByPara("rewardList")[iter_7_1] ~= 1 and var_7_1[1] >= var_7_1[2] then
				table.insert(var_7_0.reward_list, iter_7_1)
			end
		end

		if #var_7_0.reward_list == 0 then
			return
		end

		SoloHeartDemonAction.GetReward(var_7_0)
	end)
end

function SoloHeartDemonRewardView:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.normalTaskList = SoloHeartDemonData:GetDataByPara("normalTaskList")
	self.rankTaskList = SoloHeartDemonData:GetDataByPara("rankTaskList")

	self:UpdateList()

	self.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)

	local var_8_0 = self.remainTime - manager.time:GetServerTime()

	self.remainTxt_.text = manager.time:GetLostTimeStr2(self.remainTime)
	self.updateTimer_ = Timer.New(function()
		var_8_0 = self.remainTime - manager.time:GetServerTime()
		self.remainTxt_.text = manager.time:GetLostTimeStr2(self.remainTime)

		if ActivityData:GetActivityIsOpen(self.activityId) == false then
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = self.activityId
			})
			self:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")
		end
	end, 1, var_8_0 + 1, 1)

	self.updateTimer_:Start()
	SetActive(self.rankSelectGo_, self.selectIndex == 2)
	SetActive(self.normalSelectGo_, self.selectIndex == 1)
	self.controller:SetSelectedState(self:GetControllerState())
	self:OnRankUpdate()
	self:RefreshLeftBtn()
end

function SoloHeartDemonRewardView:GetControllerState()
	if self.selectIndex == 2 then
		return "message"
	else
		return self:IsShowAllReceiveBtn() and "receive" or "noReceive"
	end
end

function SoloHeartDemonRewardView:UpdateList()
	SetActive(self.list1_, self.selectIndex == 1)
	SetActive(self.list2_, self.selectIndex == 2)
	self[self.selectIndex == 1 and "normalList" or "rankList"]:StartScroll(#SoloHeartDemonRewardCfg.get_id_list_by_reward_type[2 - self.selectIndex])
end

function SoloHeartDemonRewardView:IsShowAllReceiveBtn()
	local var_12_0 = SoloHeartDemonData:GetDataByPara("rewardList")
	local var_12_1 = SoloHeartDemonData:GetDataByPara("taskData")

	for iter_12_0, iter_12_1 in ipairs(self.normalTaskList) do
		if var_12_0[iter_12_1] ~= 1 and var_12_1[iter_12_1][1] >= var_12_1[iter_12_1][2] then
			return true
		end
	end

	return false
end

function SoloHeartDemonRewardView:OnSoloDemonHeartRewardUpdate(arg_13_1)
	self.controller:SetSelectedState(self:GetControllerState())
	self:UpdateList()
end

function SoloHeartDemonRewardView:OnRankUpdate()
	self.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	if self.selectIndex == 1 or self.rankData == nil then
		return
	end
end

function SoloHeartDemonRewardView:OnEnter()
	self.selectIndex = self.params_.selectIndex or 1
	self.activityId = self.params_.activityId

	self:UpdateView()
	self:BindRedPoint()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchLeftBtnTypeHandler_)
end

function SoloHeartDemonRewardView:OnSoloDemonHeartUpdate()
	self:UpdateView()
end

function SoloHeartDemonRewardView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function SoloHeartDemonRewardView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function SoloHeartDemonRewardView:OnExit()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchLeftBtnTypeHandler_)
	self:UnbindRedPoint()
	manager.windowBar:HideBar()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function SoloHeartDemonRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SoloHeartDemonRewardView:OnSoloDemonHeartUpdate()
	self:UpdateView()
end

function SoloHeartDemonRewardView:RefreshLeftBtn()
	for iter_22_0, iter_22_1 in pairs(self.leftBtnList_) do
		iter_22_1:RefreshUI(self.selectIndex)
	end
end

function SoloHeartDemonRewardView:OnSwitchLeftBtnType(arg_23_1, arg_23_2)
	if arg_23_1 ~= CommonBtnTypeConst.DEMON or self.selectIndex == arg_23_2 then
		return
	end

	self.selectIndex = arg_23_2

	self:UpdateView()
end

function SoloHeartDemonRewardView:Dispose()
	self.OnSwitchLeftBtnTypeHandler_ = nil

	for iter_24_0, iter_24_1 in pairs(self.leftBtnList_) do
		iter_24_1:Dispose()
	end

	self.leftBtnList_ = nil

	if self.normalList then
		self.normalList:Dispose()

		self.normalList = nil
	end

	if self.rankList then
		self.rankList:Dispose()

		self.rankList = nil
	end

	SoloHeartDemonRewardView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SoloHeartDemonRewardView
