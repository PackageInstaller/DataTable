local var_0_0 = class("BattleSequentialBattleResultFinishPanel", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.finishController_ = {}

	for iter_1_0 = 1, 4 do
		table.insert(arg_1_0.finishController_, arg_1_0[string.format("finishControllerEx%s_", iter_1_0)]:GetController("finish"))
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	return
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	for iter_4_0 = 1, 4 do
		if iter_4_0 <= arg_4_1 then
			arg_4_0.finishController_[iter_4_0]:SetSelectedState("true")
		else
			arg_4_0.finishController_[iter_4_0]:SetSelectedState("false")
		end
	end

	arg_4_0.valueText_.text = string.format("%s/4", arg_4_1)
end

return var_0_0
