local var_0_0 = class("WeaponModuleConditionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
	arg_1_0:AddUIListener()
end

function var_0_0.Init(arg_2_0)
	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)

	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "condition")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.jumpBtn_, nil, function()
		JumpTools.JumpToPage(arg_3_0.source_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.desText_.text = GetI18NText(ConditionCfg[arg_5_1].desc)

	if ConditionCfg[arg_5_1].type == 5001 then
		local var_5_0 = HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[arg_5_2][1]]
		local var_5_1 = StoryCfg[var_5_0.plot_id[#var_5_0.plot_id]].name

		arg_5_0.desText_.text = string.format(GetI18NText(ConditionCfg[arg_5_1].desc), GetI18NText(var_5_1))
	end

	if IsConditionAchieved(arg_5_1, {
		heroId = arg_5_2
	}) then
		arg_5_0.controller_:SetSelectedState("clear")
		SetActive(arg_5_0.jumpBtn_.gameObject, false)
	else
		arg_5_0.controller_:SetSelectedState("notClear")

		if arg_5_3 and arg_5_3[1] then
			arg_5_0.source_ = arg_5_3

			SetActive(arg_5_0.jumpBtn_.gameObject, true)
		else
			SetActive(arg_5_0.jumpBtn_.gameObject, false)
		end
	end
end

function var_0_0.SetIsShow(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
