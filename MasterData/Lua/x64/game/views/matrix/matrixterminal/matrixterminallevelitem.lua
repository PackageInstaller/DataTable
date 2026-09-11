local MatrixLevelItem = class("MatrixLevelItem", ReduxView)

function MatrixLevelItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixLevelItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

function MatrixLevelItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.level)
		end
	end)
end

function MatrixLevelItem:Refresh(arg_5_1, arg_5_2)
	self.level = arg_5_1
	self.m_levelLab.text = "" .. arg_5_1
	self.m_selectLab.text = "" .. arg_5_1

	if arg_5_1 <= arg_5_2 then
		self.typeController_:SetSelectedIndex(0)
	else
		self.typeController_:SetSelectedIndex(1)
	end
end

function MatrixLevelItem:SetChoice(arg_6_1)
	self.selectController_:SetSelectedIndex(self.level == arg_6_1 and 1 or 0)
end

function MatrixLevelItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function MatrixLevelItem:Dispose()
	MatrixLevelItem.super.Dispose(self)
end

return MatrixLevelItem
