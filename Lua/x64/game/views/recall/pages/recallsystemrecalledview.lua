local var_0_0 = import("game.views.recall.pages.RecallPageBase")
local var_0_1 = class("RecallSystemRecalledView", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.getController_ = ControllerUtil.GetController(arg_2_0.rewardGo_.transform, "get")
	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, RecallSystemSignItem)
	arg_2_0.recallRewardList_ = LuaList.New(handler(arg_2_0, arg_2_0.RecallRewardIndexItem), arg_2_0.recallRewardListGo_, CommonItemView)
end

function var_0_1.OnReceivedCodeReward(arg_3_0)
	arg_3_0:UpdateView()
	arg_3_0.getController_:SetSelectedState("true")
end

function var_0_1.OnRecallSignUpdate(arg_4_0)
	arg_4_0:UpdateView()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.inputRecalledCodeBtn_, nil, function()
		JumpTools.GoToSystem("RecallCodeInput")
	end)
	arg_5_0:AddBtnListener(arg_5_0.copyBtn_, nil, function()
		ShowTips("COPY_SUCCESS")

		local var_7_0 = ActivityRecallData:GetDataByPara("recallUserInfo")

		UnityEngine.GUIUtility.systemCopyBuffer = var_7_0.user_id
	end)
end

function var_0_1.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = ActivityRecallData:GetDataByPara("signData")

	arg_8_2:SetData(var_8_0[arg_8_1], arg_8_1)
end

function var_0_1.RecallRewardIndexItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = ActivityRecallData:GetDataByPara("recalledReward")

	CommonTools.SetCommonData(arg_9_2, {
		id = var_9_0[arg_9_1][1],
		number = var_9_0[arg_9_1][2],
		clickFun = function(arg_10_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_10_0.id,
				arg_10_0.number
			})
		end
	})
end

function var_0_1.OnTop(arg_11_0)
	return
end

function var_0_1.UpdateView(arg_12_0)
	ActivityRecallData:UpdateSignState()

	local var_12_0 = ActivityRecallData:GetDataByPara("signData")

	arg_12_0.list_:StartScroll(#var_12_0)

	local var_12_1 = ActivityRecallData:GetDataByPara("recalledReward")

	arg_12_0.recallRewardList_:StartScroll(#var_12_1)

	local var_12_2 = ActivityRecallData:GetDataByPara("isSubmit")
	local var_12_3 = ActivityRecallData:GetDataByPara("recallUserInfo")

	arg_12_0.getController_:SetSelectedState(var_12_2 and "true" or "false")

	if var_12_2 == true then
		arg_12_0.recallNameTxt_.text = var_12_3.base_info.nick
		arg_12_0.recallUIDTxt_.text = var_12_3.user_id
		arg_12_0.recallHeadshotImg_.sprite = ItemTools.getItemSprite(var_12_3.base_info.icon)

		arg_12_0.recallHeadshotImg_:SetNativeSize()

		arg_12_0.serverName.text = string.format(GetTips("RECALLED_SERVER_NAME"), var_12_3.server_name)
	end

	arg_12_0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recalledTime")
end

function var_0_1.OnEnter(arg_13_0)
	arg_13_0:UpdateView()
end

function var_0_1.OnExit(arg_14_0)
	return
end

function var_0_1.Hide(arg_15_0)
	var_0_1.super.Hide(arg_15_0)
end

function var_0_1.Dispose(arg_16_0)
	if arg_16_0.list_ then
		arg_16_0.list_:Dispose()

		arg_16_0.list_ = nil
	end

	if arg_16_0.recallRewardList_ then
		arg_16_0.recallRewardList_:Dispose()

		arg_16_0.recallRewardList_ = nil
	end

	var_0_1.super.Dispose(arg_16_0)
end

return var_0_1
