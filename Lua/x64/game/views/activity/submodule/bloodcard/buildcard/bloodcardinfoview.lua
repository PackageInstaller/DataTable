local var_0_0 = class("BloodCardInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()

	arg_1_0.specialController_ = arg_1_0.controller_:GetController("special")
	arg_1_0.goldController_ = arg_1_0.controller_:GetController("gold")
	arg_1_0.needPointController_ = arg_1_0.controller_:GetController("needPoint")
	arg_1_0.emptyController_ = arg_1_0.controller_:GetController("empty")
	arg_1_0.noneController_ = arg_1_0.controller_:GetController("none")
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.id_ and arg_4_0.id_ ~= 0 then
		arg_4_0.cardNameText_.text = arg_4_0.cfg_.name
		arg_4_0.typeDescText_.text = BloodCardConst.TYPE_DESC[arg_4_0.cfg_.type]
		arg_4_0.powerNumText_.text = arg_4_0.cfg_.power
		arg_4_0.sepcialDescText_.text = arg_4_0.cfg_.desc

		if arg_4_0.cfg_.type == 2 then
			arg_4_0.needPointController_:SetSelectedState("overlay")
		else
			arg_4_0.needPointController_:SetSelectedState(tostring(arg_4_0.cfg_.need_point))
		end

		arg_4_0.goldController_:SetSelectedState(tostring(arg_4_0.cfg_.kind == BloodCardConst.CARD_KIND.GOLD))
		arg_4_0.specialController_:SetSelectedState(tostring(#arg_4_0.cfg_.effect_list ~= 0))
		arg_4_0.noneController_:SetSelectedState(tostring(arg_4_0.cfg_.kind ~= BloodCardConst.CARD_KIND.GOLD and #arg_4_0.cfg_.effect_list == 0))
	end
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.id_ = arg_5_1
	arg_5_0.cfg_ = BloodCardGameCardCfg[arg_5_0.id_]

	arg_5_0:RefreshUI()
	arg_5_0.emptyController_:SetSelectedState(tostring(not arg_5_1 or arg_5_1 == 0))

	if arg_5_0.cfg_.acquire_text ~= "" then
		arg_5_0.lockText_.text = arg_5_0.cfg_.acquire_text
	else
		arg_5_0.lockText_.text = GetTips("ACTIVITY_BLOOD_CARD_GAME_CARD_LOCK")
	end
end

function var_0_0.SetState(arg_6_0, arg_6_1)
	arg_6_0.emptyController_:SetSelectedState(arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
