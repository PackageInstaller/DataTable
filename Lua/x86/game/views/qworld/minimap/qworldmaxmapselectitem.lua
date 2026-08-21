local var_0_0 = class("QWorldMaxMapSelectItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	arg_1_0:AddListeners()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.IconTypeController = arg_2_0.iconState_:GetController("type")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.choiceBtn_, nil, function()
		if arg_3_0.callback_ then
			arg_3_0.callback_(arg_3_0.entityId)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.entityId = arg_5_1
	arg_5_0.board = arg_5_2
	arg_5_0.choiceTxt_.text = arg_5_0.board:GetName()

	local var_5_0, var_5_1 = arg_5_2:GetIcon()

	arg_5_0.IconTypeController:SetSelectedIndex(var_5_1)

	arg_5_0.iconImg_.sprite = pureGetSpriteWithoutAtlas(var_5_0)

	print("ddddddd", arg_5_1)
	print_r(arg_5_2)
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback_ = arg_6_1
end

return var_0_0
