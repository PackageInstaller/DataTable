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
	arg_3_0.lockController_ = arg_3_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selfBtn_, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.ID_)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.type_ = arg_6_1
	arg_6_0.ID_ = arg_6_2
	arg_6_0.callback_ = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = ActivityCivilizationIlluCfg[arg_7_0.ID_]

	if arg_7_0.type_ == 1 then
		arg_7_0.cardController_:SetSelectedState("grid")

		arg_7_0.gridImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.picture)
	elseif arg_7_0.type_ == 4 then
		arg_7_0.cardController_:SetSelectedState("skill")

		arg_7_0.techImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.picture)
	else
		arg_7_0.cardController_:SetSelectedState("hex")

		arg_7_0.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", var_7_0.picture)
	end

	local var_7_1 = CivilizationGameData:GetDataByPara("illu_list")

	if table.indexof(var_7_1, arg_7_0.ID_) then
		arg_7_0.lockController_:SetSelectedState("off")
	else
		arg_7_0.lockController_:SetSelectedState("on")
	end
end

function var_0_0.GetID(arg_8_0)
	return arg_8_0.ID_
end

function var_0_0.SetActive(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.SetSelect(arg_10_0, arg_10_1)
	arg_10_0.selectController_:SetSelectedState(arg_10_1 and "on" or "off")
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
