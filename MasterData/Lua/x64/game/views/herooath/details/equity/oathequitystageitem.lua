local OathEquityStageItem = class("OathEquityStageItem", ReduxView)
local var_0_1 = {
	[true] = {
		[true] = "selectunlock",
		[false] = "selectunlock"
	},
	[false] = {
		[true] = "lock",
		[false] = "unlock"
	}
}

function OathEquityStageItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.level = arg_1_2

	self:InitUI()
end

function OathEquityStageItem:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controller_:GetController("state")
end

function OathEquityStageItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickCallback_ then
			self.clickCallback_()
		end
	end)
end

function OathEquityStageItem:SetClickCallback(arg_5_1)
	self.clickCallback_ = arg_5_1
end

function OathEquityStageItem:GetLock()
	return self.isLock
end

function OathEquityStageItem:GetLockState()
	self.isLock = OathCollectionContentData:GetOathLevel(self.heroID) < self.level
end

function OathEquityStageItem:SetData(arg_8_1)
	self.heroID = arg_8_1

	self:GetLockState()
	self:RefreshController()

	self.lvText_.text = OathTools.GetOathLvShowTips(self.level) or self.level
end

function OathEquityStageItem:ChangeSelectState(arg_9_1)
	if self.isSelect == arg_9_1 then
		return
	end

	self.isSelect = arg_9_1

	self:RefreshController()
end

function OathEquityStageItem:RefreshController()
	self.stateController_:SetSelectedState(var_0_1[self.isSelect or false][self.isLock or false])
end

function OathEquityStageItem:Dispose()
	OathEquityStageItem.super.Dispose(self)
end

return OathEquityStageItem
