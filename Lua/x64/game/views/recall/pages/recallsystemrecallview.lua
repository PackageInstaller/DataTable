local var_0_0 = import("game.views.recall.pages.RecallPageBase")
local var_0_1 = class("RecallSystemRecallView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.listGo_, RecallSystemRecallItem)
	arg_2_0.sendCDStateController_ = arg_2_0.mainControllerEx_:GetController("shareCD")
end

function var_0_1.indexItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ActivityRecallData:GetDataByPara("recallReward")

	arg_3_2:SetData(var_3_0[arg_3_1], arg_3_1)
end

function var_0_1.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.CopyBtn_, nil, function()
		local var_5_0 = ActivityRecallData:GetDataByPara("recallActivityID")

		ActivityRecallAction.RequireRecallShareCode(var_5_0)
		ShowTips("COPY_SUCCESS")
	end)
	arg_4_0:AddBtnListener(arg_4_0.recallInfoBtn_, nil, function()
		local var_6_0 = ActivityRecallData:GetDataByPara("recallActivityID")

		ActivityRecallAction.RequireRecallInfo(var_6_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.shareBtn_, nil, function()
		local var_7_0 = ActivityRecallData:GetDataByPara("recallActivityID")

		if not ActivityData:GetActivityIsOpen(var_7_0) then
			ShowTips("TIME_OVER")

			return
		end

		local var_7_1 = ActivityRecallData:GetLastShareTimestamp()

		if manager.time:GetServerTime() - var_7_1 < GameSetting.recall_share_colddown.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		ActivityRecallAction.RequireRecallShareCode(var_7_0)

		local var_7_2 = ActivityRecallData:GetDataByPara("recallCode")

		ActivityRecallAction.RecallShare(var_7_2, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				ActivityRecallData:SetLastShareTimestamp()
				ChatAction.RequireRecallInfo()
				arg_4_0:UpdateSendTimeCD()
				ShowTips("RECALLED_SHARE")
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end)
end

function var_0_1.OnRecallRewardUpdate(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_1.OnTop(arg_10_0)
	return
end

function var_0_1.UpdateView(arg_11_0)
	local var_11_0 = ActivityRecallData:GetDataByPara("recallReward")

	arg_11_0.list_:StartScroll(#var_11_0)

	arg_11_0.recallCodeTxt_.text = ActivityRecallData:GetDataByPara("recallCode")
	arg_11_0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recallTime")
end

function var_0_1.OnEnter(arg_12_0)
	arg_12_0:UpdateView()

	if not arg_12_0.sendTipsCD_ then
		arg_12_0.sendTipsCD_ = 0
	end

	arg_12_0:UpdateSendTimeCD()

	if not arg_12_0.sendTipsTimer_ then
		arg_12_0.sendTipsTimer_ = Timer.New(function()
			if arg_12_0.sendTipsCD_ > 0 then
				arg_12_0.sendTipsText_.text = arg_12_0.sendTipsCD_ .. GetTips("SECOND")
				arg_12_0.sendTipsCD_ = arg_12_0.sendTipsCD_ - 1
			else
				arg_12_0.sendCDStateController_:SetSelectedState("false")
			end
		end, 1, -1)

		arg_12_0.sendTipsTimer_:Start()
	end
end

function var_0_1.UpdateSendTimeCD(arg_14_0)
	local var_14_0 = ActivityRecallData:GetLastShareTimestamp()

	if manager.time:GetServerTime() - var_14_0 < GameSetting.recall_share_colddown.value[1] then
		arg_14_0.sendTipsCD_ = GameSetting.recall_share_colddown.value[1] - manager.time:GetServerTime() + var_14_0
		arg_14_0.sendTipsText_.text = arg_14_0.sendTipsCD_ .. GetTips("SECOND")

		arg_14_0.sendCDStateController_:SetSelectedState("true")
	else
		arg_14_0.sendTipsCD_ = 0

		arg_14_0.sendCDStateController_:SetSelectedState("false")
	end
end

function var_0_1.OnExit(arg_15_0)
	if arg_15_0.sendTipsTimer_ then
		arg_15_0.sendTipsTimer_:Stop()

		arg_15_0.sendTipsTimer_ = nil
	end
end

function var_0_1.Hide(arg_16_0)
	var_0_1.super.Hide(arg_16_0)
end

function var_0_1.Dispose(arg_17_0)
	if arg_17_0.list_ then
		arg_17_0.list_:Dispose()

		arg_17_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_17_0)
end

return var_0_1
