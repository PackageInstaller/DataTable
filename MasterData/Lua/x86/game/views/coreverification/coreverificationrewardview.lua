local CoreVerificationRewardView = class("CoreVerificationRewardView", ReduxView)

function CoreVerificationRewardView:UIName()
	return "Widget/System/Core_verification_new/CoreVerificationQuest_new"
end

function CoreVerificationRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CoreVerificationRewardView:InitUI()
	self:BindCfgUI()

	self.selectIndex_ = 1
	self.taskData_ = {}
	self.taskUILuaList_ = LuaList.New(handler(self, self.SetRewardItem), self.taskUilist_, CoreVerificationRewardItem)
	self.getAllController_ = self.mainControllerEx_:GetController("getAll")
	self.firstController_ = self.mainControllerEx_:GetController("first")
	self.tree_ = LuaTree.New(self.uiTreeGo_)

	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect), handler(self, self.OnItemSelect))
end

function CoreVerificationRewardView:OnGroupSelect(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self.lastSelectGroupID_ == arg_5_2 then
		return
	end

	self.lastSelectGroupID_ = arg_5_2
	self.lastSelectID_ = nil
end

function CoreVerificationRewardView:OnItemSelect(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if self.lastSelectID_ == arg_6_2 then
		return
	end

	self.lastSelectID_ = arg_6_2
	self.curActivityId_, self.selectIndex_ = tonumber(arg_6_4), arg_6_2

	self:UpdateView()
end

function CoreVerificationRewardView:CreateTree()
	local var_7_0 = UITreeData.New()
	local var_7_1 = UITreeGroupData.New()

	var_7_1.id = 0
	var_7_1.text = GetTips("CORE_VERIFICATION_TAB_TIPS1")

	local var_7_2 = UITreeItemData.New()

	var_7_2.id = 1
	var_7_2.text = GetTips("CORE_VERIFICATION_BOSS_1")

	var_7_1.itemDatas:Add(var_7_2)

	local var_7_3 = UITreeItemData.New()

	var_7_3.id = 2
	var_7_3.text = GetTips("CORE_VERIFICATION_BOSS_2")

	var_7_1.itemDatas:Add(var_7_3)

	local var_7_4 = UITreeItemData.New()

	var_7_4.id = 3
	var_7_4.text = GetTips("CORE_VERIFICATION_LEVEL")

	var_7_1.itemDatas:Add(var_7_4)

	local var_7_5 = UITreeItemData.New()

	var_7_5.id = 4
	var_7_5.text = GetTips("CORE_VERIFICATION_FIRST_PASS")

	var_7_1.itemDatas:Add(var_7_5)
	var_7_0.groupDatas:Add(var_7_1)

	for iter_7_0, iter_7_1 in ipairs(CoreVerificationChallengeTools.GetAllActivityIds()) do
		local var_7_6 = UITreeGroupData.New()

		var_7_6.id = iter_7_1
		var_7_6.text = ActivityCfg[iter_7_1].remark

		local var_7_7 = UITreeItemData.New()

		var_7_7.id = 6
		var_7_7.extraData = iter_7_1
		var_7_7.text = GetTips("CORE_VERIFICATION_TAB_TIPS2")

		var_7_6.itemDatas:Add(var_7_7)

		local var_7_8 = UITreeItemData.New()

		var_7_8.id = 5
		var_7_8.extraData = iter_7_1
		var_7_8.text = GetTips("CORE_VERIFICATION_TAB_TIPS3")

		var_7_6.itemDatas:Add(var_7_8)
		var_7_0.groupDatas:Add(var_7_6)
	end

	self.tree_:SetData(var_7_0)
end

function CoreVerificationRewardView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(0), RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(0, 1), RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(0, 2), RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(0, 3), RedPointConst.CORE_VERIFICATION_REWARD3)

	if self.tree_:GetItemRedPointContainerById(0, 4) then
		manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(0, 4), RedPointConst.CORE_VERIFICATION_REWARD4)
	end

	for iter_8_0, iter_8_1 in ipairs(CoreVerificationChallengeTools.GetAllActivityIds()) do
		manager.redPoint:bindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_8_1), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_8_1))
		manager.redPoint:bindUIandKey(self.tree_:GetItemRedPointContainerById(iter_8_1, 6), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_8_1))
	end
end

function CoreVerificationRewardView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(0), RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(0, 1), RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(0, 2), RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(0, 3), RedPointConst.CORE_VERIFICATION_REWARD3)

	if self.tree_:GetItemRedPointContainerById(0, 4) then
		manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(0, 4), RedPointConst.CORE_VERIFICATION_REWARD4)
	end

	for iter_9_0, iter_9_1 in ipairs(CoreVerificationChallengeTools.GetAllActivityIds()) do
		manager.redPoint:unbindUIandKey(self.tree_:GetGroupRedPointContainerById(iter_9_1), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_9_1))
		manager.redPoint:unbindUIandKey(self.tree_:GetItemRedPointContainerById(iter_9_1, 6), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_9_1))
	end
end

function CoreVerificationRewardView:SetRewardItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.taskData_[arg_10_1], self.selectIndex_, self.curActivityId_)
end

function CoreVerificationRewardView:OnEnter()
	self.curActivityId_ = CoreVerificationChallengeTools.GetActivityId()

	self:CreateTree()

	if self.params_.isChallenge then
		self.selectIndex_ = 6
		self.params_.isChallenge = false

		self.tree_:SelectItem(1 + table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), self.curActivityId_), 1)
	elseif self.params_.isRank then
		self.selectIndex_ = 5

		self.tree_:SelectItem(1 + table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), self.curActivityId_), 2)
	else
		self.selectIndex_ = 1

		self.tree_:SelectItem(1, 1)
	end

	self:UpdateView()
	self:BindRedPoint()
end

function CoreVerificationRewardView:OnExit()
	manager.windowBar:HideBar()
	self:UnBindRedPoint()

	self.lastSelectGroupID_ = nil
	self.lastSelectID_ = nil

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function CoreVerificationRewardView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		if self.selectIndex_ < 5 then
			if CoreVerificationData:GetCanReset() and self.selectIndex_ ~= 4 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CORE_VERIFICATION_RESETTIPS3"),
					OkCallback = function()
						self:GetAll()
					end
				})
			else
				self:GetAll()
			end
		elseif CoreVerificationChallengeTools.IsJumpAllStage(self.curActivityId_) then
			self:GetAll()
		elseif CoreVerificationChallengeData:IsGetTaskReward() then
			self:GetAll()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CORE_VERIFICATION_CL_LOCK_TIPS_1"),
				OkCallback = function()
					self:GetAll()
				end
			})
		end
	end)
end

function CoreVerificationRewardView:GetAll()
	local var_17_0 = self.curActivityId_ or CoreVerificationChallengeTools.GetActivityId()
	local var_17_1 = {
		reward_list = {}
	}

	for iter_17_0, iter_17_1 in ipairs(self.taskData_) do
		if self.selectIndex_ < 5 then
			local var_17_2, var_17_3, var_17_4, var_17_5 = CoreVerificationData:GetTaskProcess(iter_17_1)

			if var_17_4 and not var_17_5 then
				table.insert(var_17_1.reward_list, iter_17_1)
			end
		elseif CoreVerificationChallengeTools.GetTaskStateById(iter_17_1, var_17_0) == 1 then
			table.insert(var_17_1.reward_list, iter_17_1)
		end
	end

	if #var_17_1.reward_list == 0 then
		return
	end

	if self.selectIndex_ < 5 then
		CoreVerificationAction.GetReward(var_17_1)
	else
		CoreVerificationChallengeTools.GetReward(var_17_0, var_17_1.reward_list)
	end
end

function CoreVerificationRewardView:UpdateView()
	SetActive(self.tree_:GetItem(1, 4), CoreVerificationData:CheckFirstReward() == "true")
	SetActive(self.allBtn_.gameObject, self.selectIndex_ ~= 5)
	SetActive(self.rankdesGo_.gameObject, self.selectIndex_ == 5)
	SetActive(self.tGo_, self.selectIndex_ == 5)

	if CoreVerificationData:CheckFirstReward() == "false" and self.selectIndex_ == 4 then
		self.selectIndex_ = 1
	end

	self.firstController_:SetSelectedState(CoreVerificationData:CheckFirstReward())

	if self.selectIndex_ < 5 then
		self.taskData_ = CoreVerificationData:GetRewardListByType(self.selectIndex_)

		table.sort(self.taskData_, function(arg_19_0, arg_19_1)
			local var_19_0, var_19_1, var_19_2, var_19_3 = CoreVerificationData:GetTaskProcess(arg_19_0)
			local var_19_4, var_19_5, var_19_6, var_19_7 = CoreVerificationData:GetTaskProcess(arg_19_1)

			if var_19_3 ~= var_19_7 then
				return var_19_7
			end

			if var_19_2 ~= var_19_6 then
				return var_19_2
			end

			return arg_19_0 < arg_19_1
		end)
		self.getAllController_:SetSelectedState("false")

		for iter_18_0, iter_18_1 in ipairs(self.taskData_) do
			local var_18_0, var_18_1, var_18_2, var_18_3 = CoreVerificationData:GetTaskProcess(iter_18_1)

			if var_18_2 and not var_18_3 then
				self.getAllController_:SetSelectedState("true")

				break
			end
		end
	elseif self.selectIndex_ == 5 then
		self.taskData_ = CoreVerificationChallengeTools.GetTaskInfoByType(self.curActivityId_, 0)

		self.getAllController_:SetSelectedState("false")
	elseif self.selectIndex_ == 6 then
		self.taskData_ = CoreVerificationChallengeTools.GetTaskInfoByType(self.curActivityId_, 1)

		self.getAllController_:SetSelectedState("false")

		for iter_18_2, iter_18_3 in ipairs(self.taskData_) do
			if CoreVerificationChallengeTools.GetTaskStateById(iter_18_3, self.curActivityId_) == 1 then
				self.getAllController_:SetSelectedState("true")

				break
			end
		end
	end

	self.stopTime = ActivityData:GetActivityData(self.curActivityId_ or CoreVerificationChallengeTools.GetActivityId()).stopTime
	self.allfinishtext2Text_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime)
	self.updateTimer_ = Timer.New(function()
		self.allfinishtext2Text_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime)
	end, 1, 0)

	self.updateTimer_:Start()
	self.taskUILuaList_:StartScroll(#self.taskData_)
end

function CoreVerificationRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CoreVerificationRewardView:OnCoreVerificationGetReward()
	self:UpdateView()
end

function CoreVerificationRewardView:OnCoreVerificationChallengeGetReward()
	self:UpdateView()
end

function CoreVerificationRewardView:Dispose()
	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	if self.taskUILuaList_ then
		self.taskUILuaList_:Dispose()

		self.taskUILuaList_ = nil
	end

	CoreVerificationRewardView.super.Dispose(self)
end

return CoreVerificationRewardView
