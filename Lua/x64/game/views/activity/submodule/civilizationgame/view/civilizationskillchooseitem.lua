local var_0_0 = class("CivilizationSkillChooseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
	arg_3_0.cardController_ = arg_3_0.mainControllerEx_:GetController("card")
	arg_3_0.skillController_ = arg_3_0.mainControllerEx_:GetController("bg02")
	arg_3_0.newController_ = arg_3_0.mainControllerEx_:GetController("new")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnLook_, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.skillID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.type_ = arg_6_1
	arg_6_0.skillID_ = arg_6_2
	arg_6_0.callback_ = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = ActivityCivilizationFactorCfg[arg_7_0.skillID_]

	if arg_7_0.type_ == CivilizationGameConst.techType.TECH then
		arg_7_0.cardController_:SetSelectedState("skill")

		arg_7_0.skillTypeText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
		arg_7_0.skillTitleText_.text = var_7_0.name
		arg_7_0.skillDescText_.text = var_7_0.description
		arg_7_0.skillImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.icon)
	else
		arg_7_0.cardController_:SetSelectedState("hex")

		local var_7_1 = 1

		for iter_7_0, iter_7_1 in ipairs(ActivityCivilizationHeroCfg.all) do
			local var_7_2 = ActivityCivilizationHeroCfg[iter_7_1]

			if table.indexof(var_7_2.hex_skill_1, arg_7_0.skillID_) or table.indexof(var_7_2.hex_skill_2, arg_7_0.skillID_) or table.indexof(var_7_2.hex_skill_3, arg_7_0.skillID_) then
				var_7_1 = iter_7_1
			end
		end

		if var_7_1 == 1 then
			arg_7_0.hexTypeText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4")
		else
			arg_7_0.hexTypeText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
		end

		arg_7_0.hexTitleText_.text = var_7_0.name
		arg_7_0.hexDescText_.text = var_7_0.description
		arg_7_0.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.icon)
	end

	arg_7_0.skillController_:SetSelectedState("state1")

	if var_7_0.associated_illustrations ~= 0 then
		arg_7_0.skillController_:SetSelectedState("state2")

		local var_7_3 = ActivityCivilizationIlluCfg[var_7_0.associated_illustrations]

		arg_7_0.skillIcon_.sprite = getSpriteViaConfig("CivilizationGame", var_7_3.picture)
		arg_7_0.skillText_.text = var_7_3.name
	end

	local var_7_4 = ActivityCivilizationIlluCfg.get_id_list_by_target_id[arg_7_0.skillID_]

	if var_7_4 and var_7_4[1] then
		local var_7_5 = CivilizationGameData:GetDataByPara("illu_list")

		if table.indexof(var_7_5, var_7_4[1]) then
			arg_7_0.newController_:SetSelectedState("off")
		else
			arg_7_0.newController_:SetSelectedState("on")
		end
	end
end

function var_0_0.GetID(arg_8_0)
	return arg_8_0.skillID_
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.SetSelected(arg_10_0, arg_10_1)
	arg_10_0.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
