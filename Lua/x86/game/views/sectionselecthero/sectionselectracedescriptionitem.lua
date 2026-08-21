local var_0_0 = class("SectionSelectRaceDescriptionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.controllerExCollection_:GetController("stage")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.raceID_ = arg_4_1
	arg_4_0.isActive_ = arg_4_2
	arg_4_0.sameCamp_ = arg_4_3

	local var_4_0 = RaceEffectCfg[arg_4_0.raceID_]

	arg_4_0.raceIcon_.sprite = HeroTools.GetRaceIcon(arg_4_0.raceID_)
	arg_4_0.raceName_.text = var_4_0.name
	arg_4_0.battleDesc_.text = var_4_0.battle_desc
	arg_4_0.desc_.text = var_4_0.desc

	if arg_4_0.isActive_ then
		if arg_4_0.sameCamp_ then
			arg_4_0.stateController_:SetSelectedState("max")
		else
			arg_4_0.stateController_:SetSelectedState("active")
		end
	else
		arg_4_0.stateController_:SetSelectedState("none")
	end
end

return var_0_0
