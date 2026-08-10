local var_0_0 = class("ActivityPointTaskCommonModule", ReduxView)

function var_0_0.GetLevelIDList(arg_1_0)
	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_1_0.activityPointRewardActivityID_]
end

function var_0_0.GetLevelInfo(arg_2_0)
	local var_2_0 = arg_2_0:GetLevelIDList()
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_2 = ActivityPointRewardCfg[iter_2_1]

		if ItemTools.getItemNum(var_2_2.need_item_id) >= var_2_2.need then
			var_2_1 = var_2_1 + 1
		end
	end

	return var_2_1, #var_2_0
end

function var_0_0.UpdateLevelRewardRedPoint(arg_3_0)
	local var_3_0 = arg_3_0:GetLevelIDList()
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = ActivityPointRewardCfg[iter_3_1]
		local var_3_3 = point and math.max(point, ItemTools.getItemNum(var_3_2.need_item_id)) or ItemTools.getItemNum(var_3_2.need_item_id)

		if not ActivityPointData:IsCompleteID(iter_3_1) and var_3_3 >= var_3_2.need then
			var_3_1 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.QWORLD_BOOKLET_LEVEL_REWARD, var_3_1)
end

function var_0_0.UIName(arg_4_0)
	return "Widget/Common/Com_Prefab/Com_Activity_RewardTrustUI"
end

function var_0_0.SetActivityID(arg_5_0)
	arg_5_0.activityPointRewardActivityID_ = 1
end

function var_0_0.BindRedPoint(arg_6_0)
	return
end

function var_0_0.UnBindRedPoint(arg_7_0)
	return
end

function var_0_0.UIParent(arg_8_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_9_0)
	arg_9_0:InitUI()
	arg_9_0:AddUIListener()
	arg_9_0:SetActivityID()

	arg_9_0.idList_ = arg_9_0:GetLevelIDList()
	arg_9_0.receiveList_ = {}
	arg_9_0.showIdList_ = {}
	arg_9_0.curLv_ = 0
	arg_9_0.maxLv_ = 0
	arg_9_0.levelLuaList_ = LuaList.New(handler(arg_9_0, arg_9_0.IndexItem), arg_9_0.levelUilist_, ActivityPointTaskCommonItem)
	arg_9_0.receivePointRewardHandler_ = handler(arg_9_0, arg_9_0.OnReceivePointReward)
	arg_9_0.onekeyController_ = arg_9_0.mainControllerEx_:GetController("onekey")
end

function var_0_0.InitUI(arg_10_0)
	arg_10_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.receiveBtn_, nil, function()
		ActivityPointAction.ReceivePointReward(arg_11_0.receiveList_)
	end)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_0.showIdList_[arg_13_1].id, arg_13_0.showIdList_[arg_13_1].ind, arg_13_0.showIdList_[arg_13_1].state, arg_13_0.activityPointRewardActivityID_)
end

function var_0_0.OnEnter(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_14_0.curLv_, arg_14_0.maxLv_ = arg_14_0:GetLevelInfo()
	arg_14_0.levelText_.text = arg_14_0.curLv_ .. "<size=60>/" .. arg_14_0.maxLv_ .. "</size>"

	if arg_14_0.progressImg_ then
		arg_14_0.progressImg_.fillAmount = arg_14_0.curLv_ / arg_14_0.maxLv_
	end

	arg_14_0:UpdateView()
	arg_14_0:BindRedPoint()
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:UnBindRedPoint()
end

function var_0_0.OnReceivePointReward(arg_16_0)
	arg_16_0:UpdateView()
	arg_16_0:UpdateLevelRewardRedPoint()
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.receiveList_ = {}
	arg_17_0.showIdList_ = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.idList_) do
		local var_17_0 = ""

		if ActivityPointData:IsCompleteID(iter_17_1) then
			var_17_0 = "complete"
		elseif iter_17_0 <= arg_17_0.curLv_ then
			var_17_0 = "receive"

			table.insert(arg_17_0.receiveList_, iter_17_1)
		else
			var_17_0 = "lock"
		end

		table.insert(arg_17_0.showIdList_, {
			id = iter_17_1,
			ind = iter_17_0,
			state = var_17_0
		})
	end

	arg_17_0.levelLuaList_:StartScroll(#arg_17_0.showIdList_)
	arg_17_0.onekeyController_:SetSelectedState(#arg_17_0.receiveList_ > 0 and "true" or "false")
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	if arg_18_0.levelLuaList_ then
		arg_18_0.levelLuaList_:Dispose()

		arg_18_0.levelLuaList_ = nil
	end
end

return var_0_0
