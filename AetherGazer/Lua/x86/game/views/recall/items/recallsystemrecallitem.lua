local var_0_0 = class("RecallSystemRecallItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.getController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "getted")

	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		local var_4_0 = ActivityRecallData:GetDataByPara("recallActivityID")

		ActivityRecallAction.RequireRecallReward(var_4_0, arg_3_0.data[1])
	end)
	arg_3_0:AddBtnListener(arg_3_0.item1Btn_, nil, function()
		ShowPopItem(POP_ITEM, arg_3_0.data[2])
	end)
	arg_3_0:AddBtnListener(arg_3_0.item2Btn_, nil, function()
		ShowPopItem(POP_ITEM, arg_3_0.data[3])
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.data = arg_7_1
	arg_7_0.id = arg_7_2

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0.useNum = ActivityRecallData:GetDataByPara("codeUseNum")
	arg_8_0.recallRewardList = ActivityRecallData:GetDataByPara("recallRewardList")

	if arg_8_0.recallRewardList[arg_8_0.id] == nil and arg_8_0.useNum >= arg_8_0.data[1] then
		arg_8_0.getController:SetSelectedState("canget")
	else
		arg_8_0.getController:SetSelectedState(arg_8_0.recallRewardList[arg_8_0.id] and "true" or "false")
	end

	arg_8_0.inviteTxt_.text = string.format(GetTips("RECALLED_INVITE"), arg_8_0.data[1])
	arg_8_0.item1Img_.sprite = ItemTools.getItemSprite(arg_8_0.data[2][1])
	arg_8_0.item2Img_.sprite = ItemTools.getItemSprite(arg_8_0.data[3][1])
	arg_8_0.item1Txt_.text = "+" .. arg_8_0.data[2][2]
	arg_8_0.item2Txt_.text = "+" .. arg_8_0.data[3][2]
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.getController = nil
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
