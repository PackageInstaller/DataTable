local var_0_0 = class("MardukSpecialRankView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/special/MardukSpecialTaskUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.activityOpenHandler_ = handler(arg_5_0, arg_5_0.ActivityOpen)
	arg_5_0.tree_ = LuaTree.New(arg_5_0.treeGo_)

	arg_5_0.tree_:SetRenderer(handler(arg_5_0, arg_5_0.GroupRenderer))

	local var_5_0 = ActivityCfg[arg_5_0.params_.activityID].sub_activity_list
	local var_5_1 = {}

	arg_5_0.resultActivityIds_ = var_5_1
	arg_5_0.activityIds_ = var_5_0

	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_3 = ActivityCfg[iter_5_1]

		if var_5_3.sub_activity_list ~= nil and #var_5_3.sub_activity_list > 0 then
			table.insert(var_5_1, iter_5_1)
			table.insert(var_5_2, ActivityQuickTrainingCfg[iter_5_1].stage_id)
		end
	end

	local var_5_4 = UITreeData.New()

	arg_5_0.activityIds_ = var_5_1
	arg_5_0.battleIds_ = var_5_2

	for iter_5_2 = 1, #var_5_1 do
		local var_5_5 = var_5_1[iter_5_2]
		local var_5_6 = ActivityCfg[var_5_5]
		local var_5_7 = BattleQuickTrainingCfg[var_5_2[iter_5_2]]
		local var_5_8 = UITreeGroupData.New()

		var_5_8.id = var_5_5
		var_5_8.text = GetI18NText(var_5_7.name)

		var_5_4.groupDatas:Add(var_5_8)
	end

	arg_5_0.tree_:SetData(var_5_4)
	arg_5_0.tree_:SetSelectedHandler(handler(arg_5_0, arg_5_0.OnGroupSelect))

	arg_5_0.rankContentView_ = MardukSpecialRankContentView.New(arg_5_0.rankContentGo_)
end

function var_0_0.GroupRenderer(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ControllerUtil.GetController(arg_6_2.transform, "lock")

	if ActivityData:GetActivityIsOpen(arg_6_1) then
		var_6_0:SetSelectedState("false")
	else
		var_6_0:SetSelectedState("true")
	end
end

function var_0_0.OnGroupSelect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = arg_7_0.activityIds_[arg_7_1]

	if not ActivityData:GetActivityIsOpen(var_7_0) then
		if ActivityData:GetActivityData(var_7_0).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			local var_7_1 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(var_7_0).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_7_1))
		end

		arg_7_0.tree_:SelectGroup(arg_7_0.curIndex_)

		return
	end

	arg_7_0.curIndex_ = arg_7_1

	local var_7_2 = arg_7_0.activityIds_[arg_7_1]
	local var_7_3 = arg_7_0.battleIds_[arg_7_1]

	arg_7_0.rankContentView_:SetMySelfData(var_7_3)
	arg_7_0:GetRankData(arg_7_1)
end

function var_0_0.GetRankData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityCfg[arg_8_0.activityIds_[arg_8_1]].sub_activity_list[1]

	RankAction.QueryActivityRank(var_8_0)
end

function var_0_0.UpdateGroupView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.activityIds_[arg_9_1]
	local var_9_1 = arg_9_0.battleIds_[arg_9_1]
	local var_9_2 = ActivityCfg[var_9_0].sub_activity_list[1]

	arg_9_0.rankContentView_:SetData(var_9_1, var_9_2)
end

function var_0_0.AddEventListeners(arg_10_0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_10_0.activityOpenHandler_)
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_13_0)
	arg_13_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0:AddEventListeners()

	local var_14_0 = 1

	for iter_14_0 = 1, #arg_14_0.resultActivityIds_ do
		if arg_14_0.resultActivityIds_[iter_14_0] == arg_14_0.params_.subActivityId then
			var_14_0 = iter_14_0
		end
	end

	local var_14_1 = arg_14_0.activityIds_[var_14_0]
	local var_14_2 = arg_14_0.battleIds_[var_14_0]

	arg_14_0.rankContentView_:SetMySelfData(var_14_2)
	arg_14_0:GetRankData(var_14_0)
	arg_14_0.tree_:SelectGroup(var_14_0)
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_15_0.activityOpenHandler_)
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_16_0)
	return
end

function var_0_0.ActivityOpen(arg_17_0, arg_17_1)
	if table.indexof(arg_17_0.activityIds_, arg_17_1) then
		arg_17_0.tree_:Refresh()
	end
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.tree_ then
		arg_18_0.tree_:Dispose()

		arg_18_0.tree_ = nil
	end

	if arg_18_0.rankContentView_ then
		arg_18_0.rankContentView_:Dispose()

		arg_18_0.rankContentView_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.OnRankUpdate(arg_19_0)
	arg_19_0:UpdateGroupView(arg_19_0.curIndex_)
end

return var_0_0
