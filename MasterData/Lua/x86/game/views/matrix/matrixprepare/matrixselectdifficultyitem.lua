local MatrixSelectDifficultyItem = class("MatrixSelectDifficultyItem", ReduxView)

function MatrixSelectDifficultyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixSelectDifficultyItem:initUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.m_controller, "state")
	self.difficultyController_ = ControllerUtil.GetController(self.m_controller, "difficulty")
end

function MatrixSelectDifficultyItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc()
		end
	end)
end

function MatrixSelectDifficultyItem:Refresh(arg_5_1, arg_5_2)
	self.stateController_:SetSelectedIndex(arg_5_2 and 1 or 0)
	self.difficultyController_:SetSelectedIndex(arg_5_1 - 1)

	self.difficultText_.text = arg_5_1 == 1 and GetTips("HARDLEVEL_EASY") or GetTips("HARDLEVEL_HARD")
end

function MatrixSelectDifficultyItem:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

return MatrixSelectDifficultyItem
