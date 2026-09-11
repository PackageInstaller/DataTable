local SPHeroChallengeCommonItem = class("SPHeroChallengeCommonItem", ReduxView)

function SPHeroChallengeCommonItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SPHeroChallengeCommonItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
end

function SPHeroChallengeCommonItem:RefreshUI(arg_3_1)
	self.itemID = arg_3_1.id

	if arg_3_1.state then
		self.stateController:SetSelectedState(arg_3_1.state)

		if self.itemID > 0 and ItemCfg[self.itemID] then
			-- block empty
		end
	end
end

function SPHeroChallengeCommonItem:Dispose()
	self:RemoveAllListeners()
	SPHeroChallengeCommonItem.super.Dispose(self)
end

return SPHeroChallengeCommonItem
