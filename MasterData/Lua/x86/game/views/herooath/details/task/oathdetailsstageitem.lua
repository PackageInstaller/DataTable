local OathDetailsStageItem = class("OathDetailsStageItem", ReduxView)

function OathDetailsStageItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.level = arg_1_2

	self:InitUI()
end

function OathDetailsStageItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.selectStateController_ = self.controller_:GetController("select")
	self.processStateController_ = self.controller_:GetController("process")
end

function OathDetailsStageItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self:GetProcessState() == "lock" then
			ShowTips("WEDDING_RIGHT_LOCK_TIP")

			return
		end

		if self.clickCallback_ then
			self.clickCallback_()
		end
	end)
end

function OathDetailsStageItem:SetClickCallback(arg_5_1)
	self.clickCallback_ = arg_5_1
end

function OathDetailsStageItem:SetData(arg_6_1)
	self.heroID = arg_6_1

	self:RefreshUI()
	self:UpdateProcessState()
end

function OathDetailsStageItem:CheckIsOpen()
	return OathCollectionContentData:GetOathLevel(self.heroID) >= self.level
end

function OathDetailsStageItem:SetSelectState(arg_8_1)
	if arg_8_1 then
		self.selectStateController_:SetSelectedState("select")
	elseif self:CheckIsOpen() then
		self.selectStateController_:SetSelectedState("normal")
	else
		self.selectStateController_:SetSelectedState("gray")
	end
end

function OathDetailsStageItem:UpdateProcessState()
	if self:CheckIsOpen() then
		local var_9_0, var_9_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, self.level)

		if var_9_1 <= var_9_0 then
			self.processStateController_:SetSelectedState("finish")
		else
			self.processStateController_:SetSelectedState("normal")
		end
	else
		self.processStateController_:SetSelectedState("lock")
	end
end

function OathDetailsStageItem:GetProcessState()
	return self.processStateController_:GetSelectedState()
end

function OathDetailsStageItem:RefreshUI()
	self.titleText_.text = OathTools.GetOathLvShowTips(self.level)

	local var_11_0, var_11_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, self.level)

	self.processText_.text = string.format("%d/%d", var_11_0, var_11_1)
end

function OathDetailsStageItem:Dispose()
	OathDetailsStageItem.super.Dispose(self)
end

return OathDetailsStageItem
