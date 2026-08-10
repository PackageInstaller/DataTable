local var_0_0 = class("GuildFoundedToggleView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.foundedType_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		arg_2_0:Go("guildFounded", {
			guildFoundedType = arg_2_0.foundedType_
		})
	end)
end

function var_0_0.RefreshSelectType(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.foundedType_ == arg_4_1

	SetActive(arg_4_0.selectMission_, var_4_0)
	SetActive(arg_4_0.unselectMission_, not var_4_0)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
