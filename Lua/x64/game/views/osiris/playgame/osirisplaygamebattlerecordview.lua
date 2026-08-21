local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonModule")
local var_0_1 = class("OsirisPlayGameBattleRecordView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_RewardTrustUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:SetActivityID()

	arg_2_0.idList_ = arg_2_0:GetLevelIDList()
	arg_2_0.receiveList_ = {}
	arg_2_0.showIdList_ = {}
	arg_2_0.curLv_ = 0
	arg_2_0.maxLv_ = 0
	arg_2_0.onekeyController_ = arg_2_0.mainControllerEx_:GetController("onekey")
	arg_2_0.taskUpdateHandler_ = handler(arg_2_0, arg_2_0.TaskUpdate)
	arg_2_0.levelLuaList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.levelUilist_, OsirisPlayGamePointTaskCommonItem)
end

function var_0_1.SetActivityID(arg_3_0)
	arg_3_0.activityPointRewardActivityID_ = ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME
end

function var_0_1.GetLevelInfo(arg_4_0)
	local var_4_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_4_0.activityPointRewardActivityID_]

	return OsirisPlayGameData:GetNum(), #var_4_0
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		OsirisPlayGameAction.GetPointReward(arg_5_0.receiveList_)
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0.super.OnEnter(arg_7_0)
	manager.notify:RegistListener(OSIRISPLAYGAME_UPDATE_TASK, arg_7_0.taskUpdateHandler_)
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)
	manager.notify:RemoveListener(OSIRISPLAYGAME_UPDATE_TASK, arg_8_0.taskUpdateHandler_)
end

function var_0_1.Dispose(arg_9_0)
	arg_9_0.taskUpdateHandler_ = nil

	arg_9_0.super.Dispose(arg_9_0)
end

function var_0_1.UpdateView(arg_10_0)
	arg_10_0.receiveList_ = {}
	arg_10_0.showIdList_ = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.idList_) do
		local var_10_0 = ""

		if OsirisPlayGameData:IsCompleteID(iter_10_1) == 2 then
			var_10_0 = "complete"
		elseif OsirisPlayGameData:IsCompleteID(iter_10_1) == 1 then
			var_10_0 = "receive"

			table.insert(arg_10_0.receiveList_, iter_10_1)
		else
			var_10_0 = "lock"
		end

		table.insert(arg_10_0.showIdList_, {
			id = iter_10_1,
			ind = iter_10_0,
			state = var_10_0
		})
	end

	local var_10_1 = 0

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.showIdList_) do
		if iter_10_3.state == "receive" then
			var_10_1 = iter_10_2

			break
		end
	end

	if var_10_1 <= 0 then
		for iter_10_4, iter_10_5 in ipairs(arg_10_0.showIdList_) do
			if iter_10_5.state == "lock" then
				var_10_1 = iter_10_4

				break
			end
		end
	end

	arg_10_0.levelLuaList_:StartScroll(#arg_10_0.showIdList_, var_10_1)
	arg_10_0.onekeyController_:SetSelectedState(#arg_10_0.receiveList_ > 0 and "true" or "false")
end

function var_0_1.TaskUpdate(arg_11_0)
	arg_11_0:GetLevelInfo()
	arg_11_0:UpdateView()
end

return var_0_1
