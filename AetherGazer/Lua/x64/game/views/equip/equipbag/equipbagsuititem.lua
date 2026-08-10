local var_0_0 = class("EquipBagSuitItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddBtnListener(nil, nil, "OnClick")

	arg_2_0.recommendController_ = arg_2_0.transform_:GetComponent("ControllerExCollection"):GetController("recommend")
	arg_2_0.selectController_ = arg_2_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = EquipRecommendCfg[arg_3_1] and EquipRecommendCfg[arg_3_1].suit_list or {}

	arg_3_0.data = arg_3_2
	arg_3_0.ids = {}

	if table.indexof(var_3_0, arg_3_2) then
		arg_3_0.recommendController_:SetSelectedIndex(0)
	else
		arg_3_0.recommendController_:SetSelectedIndex(1)
	end

	local var_3_1 = EquipSuitCfg[arg_3_2]

	SetSpriteWithoutAtlasAsync(arg_3_0.icon_, SpritePathCfg.EquipIcon_s.path .. var_3_1.icon)

	arg_3_0.name_.text = GetI18NText(var_3_1.name)

	table.insert(arg_3_0.ids, arg_3_2)
end

function var_0_0.RefreshPos(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.num_ = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.ids) do
		arg_4_0.num_ = arg_4_0.num_ + EquipTools.GetSuitEquipNum(iter_4_1, nil, arg_4_1, arg_4_2)
	end

	arg_4_0:SetBottomText()
end

function var_0_0.SetBottomText(arg_5_0)
	arg_5_0.numText_.text = arg_5_0.num_
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.clickFunc = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.OnClick(arg_7_0)
	if arg_7_0.clickFunc and arg_7_0.num_ ~= 0 then
		arg_7_0.clickFunc(arg_7_0.data)
	end
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	if arg_8_0.num_ == 0 then
		arg_8_0.selectController_:SetSelectedIndex(2)
	elseif arg_8_1 then
		arg_8_0.selectController_:SetSelectedIndex(1)
	else
		arg_8_0.selectController_:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

return var_0_0
