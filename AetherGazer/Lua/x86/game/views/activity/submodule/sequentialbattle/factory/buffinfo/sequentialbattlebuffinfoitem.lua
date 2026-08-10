local var_0_0 = class("SequentialBattleBuffInfoItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.enabledController_ = arg_1_0.controllerEx_:GetController("enabled")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(SEQUENTIAL_BATTLE_BUFF, arg_3_0.buffID_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.buffID_ = arg_5_1

	if arg_5_2 then
		arg_5_0.enabledController_:SetSelectedState("true")
	else
		arg_5_0.enabledController_:SetSelectedState("false")
	end

	local var_5_0 = SequentialBattleBuffCfg[arg_5_1].affix_id
	local var_5_1 = AffixTypeCfg[var_5_0]
	local var_5_2 = PublicBuffCfg[var_5_1.affix_buff_id].icon

	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MaedukAffix/" .. var_5_2)
end

function var_0_0.RefreshSelect(arg_6_0, arg_6_1)
	if arg_6_0.buffID_ == arg_6_1 then
		arg_6_0.selectController_:SetSelectedState("on")
	else
		arg_6_0.selectController_:SetSelectedState("off")
	end
end

return var_0_0
