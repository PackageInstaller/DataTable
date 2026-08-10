local var_0_0 = class("CatchDuckStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.statusController_ = arg_2_0.itemCon_:GetController("status")
	arg_2_0.selectController_ = arg_2_0.itemCon_:GetController("sel")
	arg_2_0.isSelect_ = false
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnSelect_, nil, function()
		arg_4_0.selectCallBack_(arg_4_0, arg_4_0.stageData_, arg_4_0.index_)
	end)
end

function var_0_0.SetSelectCallBack(arg_6_0, arg_6_1)
	arg_6_0.selectCallBack_ = arg_6_1
end

function var_0_0.SelectItem(arg_7_0, arg_7_1)
	arg_7_0.isSelect_ = arg_7_1

	arg_7_0.selectController_:SetSelectedState(arg_7_0.isSelect_ and "on" or "off")
end

function var_0_0.RefreshUI(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.isComplete and "complete" or arg_8_1.isLock and "lock" or "unlock"

	arg_8_0.statusController_:SetSelectedState(var_8_0)

	if arg_8_1.isEndless then
		arg_8_0.textScore_.text = arg_8_1.score and arg_8_1.score or GetTips("NO_DUCK_DATA")
	end

	local var_8_1 = BattleCatchDuckStageCfg[arg_8_1.stage_id]

	arg_8_0.textName_.text = var_8_1.name
	arg_8_0.stageData_ = arg_8_1
	arg_8_0.index_ = arg_8_2
end

function var_0_0.RefreshSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
