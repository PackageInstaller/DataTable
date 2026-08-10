local var_0_0 = class("TowerGamePlaneItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI(arg_1_1)

	arg_1_0.islockcontroller_ = ControllerUtil.GetController(arg_1_0.transform_, "islock")
	arg_1_0.imagecontroller_ = ControllerUtil.GetController(arg_1_0.transform_, "image")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.cfg = TowerGameData:GetPlaneCfgByTypeAndIndex(arg_2_2, arg_2_1)
	arg_2_0.nametext_.text = GetI18NText(arg_2_0.cfg.name)
	arg_2_0.desctext_.text = GetI18NText(arg_2_0.cfg.desc)

	arg_2_0.imagecontroller_:SetSelectedState(arg_2_0.cfg.id)

	if TowerGameData:GetPlaneIsUnlock(arg_2_0.cfg.id) then
		arg_2_0.islockcontroller_:SetSelectedState("false")
	else
		arg_2_0.islockcontroller_:SetSelectedState("true")

		local var_2_0 = TowerGamePlaneCfg[arg_2_0.cfg.id].condition
		local var_2_1 = TowerGameCfg[var_2_0].stage_id
		local var_2_2 = BattleTowerGameCfg[var_2_1]

		arg_2_0.locktext_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), GetI18NText(var_2_2.name))
	end
end

return var_0_0
