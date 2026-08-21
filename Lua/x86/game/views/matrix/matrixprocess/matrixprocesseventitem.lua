local var_0_0 = class("MatrixProcessEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.m_clickBtn, nil, function()
		if arg_2_0.clickFunc then
			arg_2_0.clickFunc(arg_2_0.index)
		end
	end)
end

function var_0_0.initUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectedController_ = ControllerUtil.GetController(arg_4_0.m_controller, "selected")
	arg_4_0.typeController_ = ControllerUtil.GetController(arg_4_0.m_controller, "type")
end

function var_0_0.Refresh(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1
	arg_5_0.index = arg_5_2

	local var_5_0 = arg_5_0.id and MatrixEventCfg[arg_5_0.id] or nil

	if var_5_0 then
		local var_5_1 = var_5_0.event_type

		arg_5_0.typeController_:SetSelectedIndex(var_5_1 - 1)

		local var_5_2 = var_5_1 - 1

		if var_5_2 == 0 then
			arg_5_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_5_0.m_name.text = GetTips("SHEN_GE")
		elseif var_5_2 == 1 then
			arg_5_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_5_0.m_name.text = GetTips("KE_YIN")
		elseif var_5_2 == 2 then
			arg_5_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_5_0.m_name.text = GetTips("YAO_CONG")
		elseif var_5_2 == 3 then
			arg_5_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_5_0.m_name.text = GetTips("YAO_CONG")
		elseif var_5_2 == 4 then
			arg_5_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_5_0.m_name.text = GetTips("MIAO_MIAO")
		elseif var_5_2 == 5 then
			arg_5_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_5_0.m_name.text = GetTips("MIAO_MIAO")
		elseif var_5_2 == 6 then
			arg_5_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_5_0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif var_5_2 == 7 then
			arg_5_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_5_0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif var_5_2 == 8 then
			arg_5_0.m_subName.text = GetTips("BOSS_ZHAN")
			arg_5_0.m_name.text = GetTips("E_MENG_TIAO_ZHAN")
		elseif var_5_2 == 9 then
			arg_5_0.m_subName.text = GetTips("BOSS_ZHAN")
			arg_5_0.m_name.text = GetTips("ZHONG_YAN_TIAO_ZHAN")
		elseif var_5_2 == 10 then
			arg_5_0.m_subName.text = GetTips("TE_SHU")
			arg_5_0.m_name.text = GetTips("DUO_WEI_SHANG_DIAN")
		elseif var_5_2 == 11 then
			arg_5_0.m_subName.text = GetTips("TE_SHU")
			arg_5_0.m_name.text = GetTips("JI_YU")
		end

		arg_5_0.m_name.text = GetI18NText(var_5_0.name)
		arg_5_0.m_subName.text = GetI18NText(var_5_0.sub_name)
	end
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickFunc = arg_6_1
end

function var_0_0.GetTypeName(arg_7_0, arg_7_1)
	local var_7_0 = "MATRIX_TYPE_NOTE_" .. arg_7_1

	return GetTips(var_7_0)
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectedController_:SetSelectedIndex(arg_8_1 and 1 or 0)
end

function var_0_0.GetIndex(arg_9_0)
	return arg_9_0.index
end

return var_0_0
