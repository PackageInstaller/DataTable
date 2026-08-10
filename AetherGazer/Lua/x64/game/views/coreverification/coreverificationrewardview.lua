local var_0_0 = class("CoreVerificationRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/CoreVerificationQuest_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectIndex_ = 1
	arg_4_0.taskData_ = {}
	arg_4_0.taskUILuaList_ = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.taskUilist_, CoreVerificationRewardItem)
	arg_4_0.getAllController_ = arg_4_0.mainControllerEx_:GetController("getAll")
	arg_4_0.firstController_ = arg_4_0.mainControllerEx_:GetController("first")
	arg_4_0.tree_ = LuaTree.New(arg_4_0.uiTreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), handler(arg_4_0, arg_4_0.OnItemSelect))
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0.lastSelectGroupID_ == arg_5_2 then
		return
	end

	arg_5_0.lastSelectGroupID_ = arg_5_2
	arg_5_0.lastSelectID_ = nil
end

function var_0_0.OnItemSelect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0.lastSelectID_ == arg_6_2 then
		return
	end

	arg_6_0.lastSelectID_ = arg_6_2
	arg_6_0.curActivityId_, arg_6_0.selectIndex_ = tonumber(arg_6_4), arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.CreateTree(arg_7_0)
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

	arg_7_0.tree_:SetData(var_7_0)
end

function var_0_0.BindRedPoint(arg_8_0)
	manager.redPoint:bindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(0), RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.redPoint:bindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(0, 1), RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:bindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(0, 2), RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:bindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(0, 3), RedPointConst.CORE_VERIFICATION_REWARD3)

	if arg_8_0.tree_:GetItemRedPointContainerById(0, 4) then
		manager.redPoint:bindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(0, 4), RedPointConst.CORE_VERIFICATION_REWARD4)
	end

	for iter_8_0, iter_8_1 in ipairs(CoreVerificationChallengeTools.GetAllActivityIds()) do
		manager.redPoint:bindUIandKey(arg_8_0.tree_:GetGroupRedPointContainerById(iter_8_1), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_8_1))
		manager.redPoint:bindUIandKey(arg_8_0.tree_:GetItemRedPointContainerById(iter_8_1, 6), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_8_1))
	end
end

function var_0_0.UnBindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetGroupRedPointContainerById(0), RedPointConst.CORE_VERIFICATION_CHALLENGE_NORMAL_REWARD)
	manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetItemRedPointContainerById(0, 1), RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetItemRedPointContainerById(0, 2), RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetItemRedPointContainerById(0, 3), RedPointConst.CORE_VERIFICATION_REWARD3)

	if arg_9_0.tree_:GetItemRedPointContainerById(0, 4) then
		manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetItemRedPointContainerById(0, 4), RedPointConst.CORE_VERIFICATION_REWARD4)
	end

	for iter_9_0, iter_9_1 in ipairs(CoreVerificationChallengeTools.GetAllActivityIds()) do
		manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetGroupRedPointContainerById(iter_9_1), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_9_1))
		manager.redPoint:unbindUIandKey(arg_9_0.tree_:GetItemRedPointContainerById(iter_9_1, 6), string.format("%s_%s", RedPointConst.CORE_VERIFICATION_REWARD5, iter_9_1))
	end
end

function var_0_0.SetRewardItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.taskData_[arg_10_1], arg_10_0.selectIndex_, arg_10_0.curActivityId_)
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.curActivityId_ = CoreVerificationChallengeTools.GetActivityId()

	arg_11_0:CreateTree()

	if arg_11_0.params_.isChallenge then
		arg_11_0.selectIndex_ = 6
		arg_11_0.params_.isChallenge = false

		arg_11_0.tree_:SelectItem(1 + table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), arg_11_0.curActivityId_), 1)
	elseif arg_11_0.params_.isRank then
		arg_11_0.selectIndex_ = 5

		arg_11_0.tree_:SelectItem(1 + table.indexof(CoreVerificationChallengeTools.GetAllActivityIds(), arg_11_0.curActivityId_), 2)
	else
		arg_11_0.selectIndex_ = 1

		arg_11_0.tree_:SelectItem(1, 1)
	end

	arg_11_0:UpdateView()
	arg_11_0:BindRedPoint()
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
	arg_12_0:UnBindRedPoint()

	arg_12_0.lastSelectGroupID_ = nil
	arg_12_0.lastSelectID_ = nil

	if arg_12_0.updateTimer_ then
		arg_12_0.updateTimer_:Stop()

		arg_12_0.updateTimer_ = nil
	end
end

function var_0_0.AddUIListener(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.allBtn_, nil, function()
		if arg_13_0.selectIndex_ < 5 then
			if CoreVerificationData:GetCanReset() and arg_13_0.selectIndex_ ~= 4 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("CORE_VERIFICATION_RESETTIPS3"),
					OkCallback = function()
						arg_13_0:GetAll()
					end
				})
			else
				arg_13_0:GetAll()
			end
		elseif CoreVerificationChallengeTools.IsJumpAllStage(arg_13_0.curActivityId_) then
			arg_13_0:GetAll()
		elseif CoreVerificationChallengeData:IsGetTaskReward() then
			arg_13_0:GetAll()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CORE_VERIFICATION_CL_LOCK_TIPS_1"),
				OkCallback = function()
					arg_13_0:GetAll()
				end
			})
		end
	end)
end

function var_0_0.GetAll(arg_17_0)
	local var_17_0 = arg_17_0.curActivityId_ or CoreVerificationChallengeTools.GetActivityId()
	local var_17_1 = {
		reward_list = {}
	}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.taskData_) do
		if arg_17_0.selectIndex_ < 5 then
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

	if arg_17_0.selectIndex_ < 5 then
		CoreVerificationAction.GetReward(var_17_1)
	else
		CoreVerificationChallengeTools.GetReward(var_17_0, var_17_1.reward_list)
	end
end

function var_0_0.UpdateView(arg_18_0)
	local var_18_0 = arg_18_0.tree_:GetItem(1, 4)

	SetActive(var_18_0, CoreVerificationData:CheckFirstReward() == "true")
	SetActive(arg_18_0.allBtn_.gameObject, arg_18_0.selectIndex_ ~= 5)
	SetActive(arg_18_0.rankdesGo_.gameObject, arg_18_0.selectIndex_ == 5)
	SetActive(arg_18_0.tGo_, arg_18_0.selectIndex_ == 5)

	if CoreVerificationData:CheckFirstReward() == "false" and arg_18_0.selectIndex_ == 4 then
		arg_18_0.selectIndex_ = 1
	end

	arg_18_0.firstController_:SetSelectedState(CoreVerificationData:CheckFirstReward())

	if arg_18_0.selectIndex_ < 5 then
		arg_18_0.taskData_ = CoreVerificationData:GetRewardListByType(arg_18_0.selectIndex_)

		table.sort(arg_18_0.taskData_, function(arg_19_0, arg_19_1)
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
		arg_18_0.getAllController_:SetSelectedState("false")

		for iter_18_0, iter_18_1 in ipairs(arg_18_0.taskData_) do
			local var_18_1, var_18_2, var_18_3, var_18_4 = CoreVerificationData:GetTaskProcess(iter_18_1)

			if var_18_3 and not var_18_4 then
				arg_18_0.getAllController_:SetSelectedState("true")

				break
			end
		end
	elseif arg_18_0.selectIndex_ == 5 then
		arg_18_0.taskData_ = CoreVerificationChallengeTools.GetTaskInfoByType(arg_18_0.curActivityId_, 0)

		arg_18_0.getAllController_:SetSelectedState("false")
	elseif arg_18_0.selectIndex_ == 6 then
		arg_18_0.taskData_ = CoreVerificationChallengeTools.GetTaskInfoByType(arg_18_0.curActivityId_, 1)

		arg_18_0.getAllController_:SetSelectedState("false")

		for iter_18_2, iter_18_3 in ipairs(arg_18_0.taskData_) do
			if CoreVerificationChallengeTools.GetTaskStateById(iter_18_3, arg_18_0.curActivityId_) == 1 then
				arg_18_0.getAllController_:SetSelectedState("true")

				break
			end
		end
	end

	local var_18_5 = arg_18_0.curActivityId_ or CoreVerificationChallengeTools.GetActivityId()

	arg_18_0.stopTime = ActivityData:GetActivityData(var_18_5).stopTime
	arg_18_0.allfinishtext2Text_.text = manager.time:GetLostTimeStrWith2Unit(arg_18_0.stopTime)
	arg_18_0.updateTimer_ = Timer.New(function()
		arg_18_0.allfinishtext2Text_.text = manager.time:GetLostTimeStrWith2Unit(arg_18_0.stopTime)
	end, 1, 0)

	arg_18_0.updateTimer_:Start()
	arg_18_0.taskUILuaList_:StartScroll(#arg_18_0.taskData_)
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnCoreVerificationGetReward(arg_22_0)
	arg_22_0:UpdateView()
end

function var_0_0.OnCoreVerificationChallengeGetReward(arg_23_0)
	arg_23_0:UpdateView()
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.tree_ then
		arg_24_0.tree_:Dispose()

		arg_24_0.tree_ = nil
	end

	if arg_24_0.taskUILuaList_ then
		arg_24_0.taskUILuaList_:Dispose()

		arg_24_0.taskUILuaList_ = nil
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
