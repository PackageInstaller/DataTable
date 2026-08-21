local var_0_0 = class("ActivityMatrixProcessEventItem", MatrixProcessEventItem)

function var_0_0.Refresh(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.index = arg_1_2

	local var_1_0 = arg_1_0.id and ActivityMatrixEventTemplateCfg[arg_1_0.id] or nil

	if var_1_0 then
		local var_1_1 = var_1_0.event_type

		arg_1_0.typeController_:SetSelectedIndex(var_1_1 - 1)

		if MatrixConst.EVENT_TYPE.CURRENCY == var_1_1 or MatrixConst.EVENT_TYPE.CURRENCY_ELITE == var_1_1 then
			local var_1_2 = ActivityMatrixTools.GetCoinItem(arg_1_3)

			if ItemCfg[var_1_2] then
				arg_1_0.m_name.text = ItemTools.getItemName(var_1_2)
			end
		end

		local var_1_3 = var_1_1 - 1

		if var_1_3 == 0 then
			arg_1_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_1_0.m_name.text = GetTips("SHEN_GE")
		elseif var_1_3 == 1 then
			arg_1_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_1_0.m_name.text = GetTips("KE_YIN")
		elseif var_1_3 == 2 then
			arg_1_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_1_0.m_name.text = GetTips("YAO_CONG")
		elseif var_1_3 == 3 then
			arg_1_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_1_0.m_name.text = GetTips("YAO_CONG")
		elseif var_1_3 == 4 then
			arg_1_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_1_0.m_name.text = GetTips("MIAO_MIAO")
		elseif var_1_3 == 5 then
			arg_1_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_1_0.m_name.text = GetTips("MIAO_MIAO")
		elseif var_1_3 == 6 then
			arg_1_0.m_subName.text = GetTips("NORMAL_BATTLE")
			arg_1_0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif var_1_3 == 7 then
			arg_1_0.m_subName.text = GetTips("JING_YING_ZHAN")
			arg_1_0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif var_1_3 == 8 then
			arg_1_0.m_subName.text = GetTips("BOSS_ZHAN")
			arg_1_0.m_name.text = GetTips("E_MENG_TIAO_ZHAN")
		elseif var_1_3 == 9 then
			arg_1_0.m_subName.text = GetTips("BOSS_ZHAN")
			arg_1_0.m_name.text = GetTips("ZHONG_YAN_TIAO_ZHAN")
		elseif var_1_3 == 10 then
			arg_1_0.m_subName.text = GetTips("TE_SHU")
			arg_1_0.m_name.text = GetTips("DUO_WEI_SHANG_DIAN")
		elseif var_1_3 == 11 then
			arg_1_0.m_subName.text = GetTips("TE_SHU")
			arg_1_0.m_name.text = GetTips("JI_YU")
		end
	end
end

return var_0_0
