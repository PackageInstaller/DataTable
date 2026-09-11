local TetrisGameSkillIconItem = class("TetrisGameSkillIconItem", ReduxView)

function TetrisGameSkillIconItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TetrisGameSkillIconItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function TetrisGameSkillIconItem:InitUI()
	self:BindCfgUI()

	if self.controller_ then
		self.stateController = self.controller_:GetController("state")
	end
end

function TetrisGameSkillIconItem:AddUIListener()
	self:AddBtnListener(self.btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.skillID)
		end
	end)
end

function TetrisGameSkillIconItem:RefreshUI(arg_6_1)
	self.skillID = arg_6_1
	self.icon.sprite = TetrisGameTools:GetSkillIcon(arg_6_1)

	self:RefreshCountShow()
end

function TetrisGameSkillIconItem:RefreshCountShow()
	if self.controller_ then
		local var_7_0 = TetrisGameRunTimeManager:GetSkillCD(self.skillID)

		if var_7_0 then
			self.numTxt_.text = var_7_0

			self.stateController:SetSelectedState("show")
		else
			self.stateController:SetSelectedState("hide")
		end
	end
end

function TetrisGameSkillIconItem:Dispose()
	TetrisGameSkillIconItem.super.Dispose(self)
end

function TetrisGameSkillIconItem:RegisterClickFunc(arg_9_1)
	if arg_9_1 then
		self.clickFunc = arg_9_1
	end
end

return TetrisGameSkillIconItem
