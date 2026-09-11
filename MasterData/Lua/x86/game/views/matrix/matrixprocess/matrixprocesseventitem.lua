local MatrixProcessEventItem = class("MatrixProcessEventItem", ReduxView)

function MatrixProcessEventItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:initUI()
	self:AddUIListener()
end

function MatrixProcessEventItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function MatrixProcessEventItem:initUI()
	self:BindCfgUI()

	self.selectedController_ = ControllerUtil.GetController(self.m_controller, "selected")
	self.typeController_ = ControllerUtil.GetController(self.m_controller, "type")
end

function MatrixProcessEventItem:Refresh(arg_5_1, arg_5_2)
	self.id = arg_5_1
	self.index = arg_5_2

	if self.id then
		local var_5_0 = MatrixEventCfg[self.id] or nil

		if var_5_0 then
			self.typeController_:SetSelectedIndex(var_5_0.event_type - 1)

			if var_5_0.event_type - 1 == 0 then
				self.m_subName.text = GetTips("NORMAL_BATTLE")
				self.m_name.text = GetTips("SHEN_GE")
			elseif var_5_0.event_type - 1 == 1 then
				self.m_subName.text = GetTips("NORMAL_BATTLE")
				self.m_name.text = GetTips("KE_YIN")
			elseif var_5_0.event_type - 1 == 2 then
				self.m_subName.text = GetTips("NORMAL_BATTLE")
				self.m_name.text = GetTips("YAO_CONG")
			elseif var_5_0.event_type - 1 == 3 then
				self.m_subName.text = GetTips("JING_YING_ZHAN")
				self.m_name.text = GetTips("YAO_CONG")
			elseif var_5_0.event_type - 1 == 4 then
				self.m_subName.text = GetTips("NORMAL_BATTLE")
				self.m_name.text = GetTips("MIAO_MIAO")
			elseif var_5_0.event_type - 1 == 5 then
				self.m_subName.text = GetTips("JING_YING_ZHAN")
				self.m_name.text = GetTips("MIAO_MIAO")
			elseif var_5_0.event_type - 1 == 6 then
				self.m_subName.text = GetTips("NORMAL_BATTLE")
				self.m_name.text = GetTips("JI_YI_ZHEN_BAO")
			elseif var_5_0.event_type - 1 == 7 then
				self.m_subName.text = GetTips("JING_YING_ZHAN")
				self.m_name.text = GetTips("JI_YI_ZHEN_BAO")
			elseif var_5_0.event_type - 1 == 8 then
				self.m_subName.text = GetTips("BOSS_ZHAN")
				self.m_name.text = GetTips("E_MENG_TIAO_ZHAN")
			elseif var_5_0.event_type - 1 == 9 then
				self.m_subName.text = GetTips("BOSS_ZHAN")
				self.m_name.text = GetTips("ZHONG_YAN_TIAO_ZHAN")
			elseif var_5_0.event_type - 1 == 10 then
				self.m_subName.text = GetTips("TE_SHU")
				self.m_name.text = GetTips("DUO_WEI_SHANG_DIAN")
			elseif var_5_0.event_type - 1 == 11 then
				self.m_subName.text = GetTips("TE_SHU")
				self.m_name.text = GetTips("JI_YU")
			end

			self.m_name.text = GetI18NText(var_5_0.name)
			self.m_subName.text = GetI18NText(var_5_0.sub_name)
		end
	end
end

function MatrixProcessEventItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

function MatrixProcessEventItem:GetTypeName(arg_7_1)
	return GetTips("MATRIX_TYPE_NOTE_" .. arg_7_1)
end

function MatrixProcessEventItem:SetSelected(arg_8_1)
	self.selectedController_:SetSelectedIndex(arg_8_1 and 1 or 0)
end

function MatrixProcessEventItem:GetIndex()
	return self.index
end

return MatrixProcessEventItem
