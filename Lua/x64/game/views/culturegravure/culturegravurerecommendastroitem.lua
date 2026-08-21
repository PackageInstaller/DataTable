local var_0_0 = class("CultureGravureRecommendAstroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.colorController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "color")
	arg_2_0.lockController_ = ControllerUtil.GetController(arg_2_0.gameObject_.transform, "lockstate")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index_ = arg_3_1
	arg_3_0.id_ = arg_3_2
	arg_3_0.heroID_ = arg_3_3
	arg_3_0.cfg_ = HeroAstrolabeCfg[arg_3_0.id_]
	arg_3_0.type_ = string.sub(tostring(arg_3_0.id_), -2, -2)

	arg_3_0:RefreshUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		local var_5_0 = arg_4_0.transform_.position
		local var_5_1 = AstrolabeEffectCfg[arg_4_0.id_].desc[1]
		local var_5_2 = GetCfgDescription(var_5_1, 1)
		local var_5_3 = HeroAstrolabeCfg[arg_4_0.id_]

		arg_4_0.callback(var_5_3.name, var_5_2, Vector3(var_5_0.x, var_5_0.y, var_5_0.z), arg_4_0.rightTrans_, true)
	end)
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()
end

function var_0_0.SetClickCallBack(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.callback = arg_7_1
	arg_7_0.rightTrans_ = arg_7_2
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.nameText_.text = arg_8_0.cfg_.name

	arg_8_0.colorController_:SetSelectedState(arg_8_0.type_)

	arg_8_0.isUnlock = CultureGravureData:GetHasUnlockAllAstro(arg_8_0.heroID_, {
		arg_8_0.id_
	})

	if arg_8_0.isUnlock then
		arg_8_0.lockController_:SetSelectedState("normal")
	else
		arg_8_0.lockController_:SetSelectedState("lock")
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
