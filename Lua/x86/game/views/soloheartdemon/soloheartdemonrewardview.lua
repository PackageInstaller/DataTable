local var_0_0 = class("SoloHeartDemonRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.OnSwitchLeftBtnTypeHandler_ = handler(arg_3_0, arg_3_0.OnSwitchLeftBtnType)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.normalList = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.list1_, SoloHeartDemonRewardItem)
	arg_4_0.rankList = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.list2_, SoloHeartDemonRewardItem)
	arg_4_0.controller = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.leftBtnList_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.leftBtnList_[iter_4_0] = StoreBtnView.New(arg_4_0[string.format("leftBtnGo%s_", iter_4_0)], CommonBtnTypeConst.DEMON, iter_4_0)
	end
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = (arg_5_0.selectIndex == 1 and arg_5_0.normalTaskList or arg_5_0.rankTaskList)[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, arg_5_0.selectIndex)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		local var_7_0 = {
			reward_list = {}
		}

		for iter_7_0, iter_7_1 in ipairs(arg_6_0.normalTaskList) do
			local var_7_1 = SoloHeartDemonData:GetDataByPara("rewardList")[iter_7_1]
			local var_7_2 = SoloHeartDemonData:GetDataByPara("taskData")[iter_7_1]

			if var_7_1 ~= 1 and var_7_2[1] >= var_7_2[2] then
				table.insert(var_7_0.reward_list, iter_7_1)
			end
		end

		if #var_7_0.reward_list == 0 then
			return
		end

		SoloHeartDemonAction.GetReward(var_7_0)
	end)
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.updateTimer_ then
		arg_8_0.updateTimer_:Stop()

		arg_8_0.updateTimer_ = nil
	end

	arg_8_0.normalTaskList = SoloHeartDemonData:GetDataByPara("normalTaskList")
	arg_8_0.rankTaskList = SoloHeartDemonData:GetDataByPara("rankTaskList")

	arg_8_0:UpdateList()

	arg_8_0.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)

	local var_8_0 = arg_8_0.remainTime - manager.time:GetServerTime()

	arg_8_0.remainTxt_.text = manager.time:GetLostTimeStr2(arg_8_0.remainTime)
	arg_8_0.updateTimer_ = Timer.New(function()
		var_8_0 = arg_8_0.remainTime - manager.time:GetServerTime()
		arg_8_0.remainTxt_.text = manager.time:GetLostTimeStr2(arg_8_0.remainTime)

		if ActivityData:GetActivityIsOpen(arg_8_0.activityId) == false then
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = arg_8_0.activityId
			})
			arg_8_0:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")
		end
	end, 1, var_8_0 + 1, 1)

	arg_8_0.updateTimer_:Start()
	SetActive(arg_8_0.rankSelectGo_, arg_8_0.selectIndex == 2)
	SetActive(arg_8_0.normalSelectGo_, arg_8_0.selectIndex == 1)
	arg_8_0.controller:SetSelectedState(arg_8_0:GetControllerState())
	arg_8_0:OnRankUpdate()
	arg_8_0:RefreshLeftBtn()
end

function var_0_0.GetControllerState(arg_10_0)
	if arg_10_0.selectIndex == 2 then
		return "message"
	else
		return arg_10_0:IsShowAllReceiveBtn() and "receive" or "noReceive"
	end
end

function var_0_0.UpdateList(arg_11_0)
	SetActive(arg_11_0.list1_, arg_11_0.selectIndex == 1)
	SetActive(arg_11_0.list2_, arg_11_0.selectIndex == 2)
	arg_11_0[arg_11_0.selectIndex == 1 and "normalList" or "rankList"]:StartScroll(#SoloHeartDemonRewardCfg.get_id_list_by_reward_type[2 - arg_11_0.selectIndex])
end

function var_0_0.IsShowAllReceiveBtn(arg_12_0)
	local var_12_0 = SoloHeartDemonData:GetDataByPara("rewardList")
	local var_12_1 = SoloHeartDemonData:GetDataByPara("taskData")

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.normalTaskList) do
		if var_12_0[iter_12_1] ~= 1 and var_12_1[iter_12_1][1] >= var_12_1[iter_12_1][2] then
			return true
		end
	end

	return false
end

function var_0_0.OnSoloDemonHeartRewardUpdate(arg_13_0, arg_13_1)
	arg_13_0.controller:SetSelectedState(arg_13_0:GetControllerState())
	arg_13_0:UpdateList()
end

function var_0_0.OnRankUpdate(arg_14_0)
	arg_14_0.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	if arg_14_0.selectIndex == 1 or arg_14_0.rankData == nil then
		return
	end
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.selectIndex = arg_15_0.params_.selectIndex or 1
	arg_15_0.activityId = arg_15_0.params_.activityId

	arg_15_0:UpdateView()
	arg_15_0:BindRedPoint()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, arg_15_0.OnSwitchLeftBtnTypeHandler_)
end

function var_0_0.OnSoloDemonHeartUpdate(arg_16_0)
	arg_16_0:UpdateView()
end

function var_0_0.BindRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function var_0_0.UnbindRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.leftBtnGo1_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
end

function var_0_0.OnExit(arg_19_0)
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, arg_19_0.OnSwitchLeftBtnTypeHandler_)
	arg_19_0:UnbindRedPoint()
	manager.windowBar:HideBar()

	if arg_19_0.updateTimer_ then
		arg_19_0.updateTimer_:Stop()

		arg_19_0.updateTimer_ = nil
	end
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnSoloDemonHeartUpdate(arg_21_0)
	arg_21_0:UpdateView()
end

function var_0_0.RefreshLeftBtn(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.leftBtnList_) do
		iter_22_1:RefreshUI(arg_22_0.selectIndex)
	end
end

function var_0_0.OnSwitchLeftBtnType(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= CommonBtnTypeConst.DEMON or arg_23_0.selectIndex == arg_23_2 then
		return
	end

	arg_23_0.selectIndex = arg_23_2

	arg_23_0:UpdateView()
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.OnSwitchLeftBtnTypeHandler_ = nil

	for iter_24_0, iter_24_1 in pairs(arg_24_0.leftBtnList_) do
		iter_24_1:Dispose()
	end

	arg_24_0.leftBtnList_ = nil

	if arg_24_0.normalList then
		arg_24_0.normalList:Dispose()

		arg_24_0.normalList = nil
	end

	if arg_24_0.rankList then
		arg_24_0.rankList:Dispose()

		arg_24_0.rankList = nil
	end

	var_0_0.super.Dispose(arg_24_0)
	Object.Destroy(arg_24_0.gameObject_)
end

return var_0_0
