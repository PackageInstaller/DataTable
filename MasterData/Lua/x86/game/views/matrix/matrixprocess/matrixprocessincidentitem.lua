local MatrixProcessIncidentItem = class("MatrixProcessIncidentItem", ReduxView)

function MatrixProcessIncidentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixProcessIncidentItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.index)
		end
	end)
end

function MatrixProcessIncidentItem:initUI()
	self:BindCfgUI()

	self.selectedController_ = ControllerUtil.GetController(self.m_controller, "selected")
end

function MatrixProcessIncidentItem:Refresh(arg_5_1, arg_5_2)
	self.id = arg_5_1
	self.index = arg_5_2
	self.m_tipLab.text = arg_5_2
	self.m_desLab.text = MatrixDescCfg[arg_5_1] and GetI18NText(MatrixDescCfg[arg_5_1].desc) or ""
end

function MatrixProcessIncidentItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

function MatrixProcessIncidentItem:SetSelected(arg_7_1)
	self.selectedController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function MatrixProcessIncidentItem:GetIndex()
	return self.index
end

return MatrixProcessIncidentItem
