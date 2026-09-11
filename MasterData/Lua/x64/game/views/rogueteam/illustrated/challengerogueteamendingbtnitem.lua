local ChallengeRogueTeamEndingBtnItem = class("ChallengeRogueTeamEndingBtnItem", ReduxView)

function ChallengeRogueTeamEndingBtnItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
	self.lockController_ = self.controller_:GetController("lock")
end

function ChallengeRogueTeamEndingBtnItem:Dispose()
	ChallengeRogueTeamEndingBtnItem.super.Dispose(self)
end

function ChallengeRogueTeamEndingBtnItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack_ then
			self.callBack_(self.index_)
		end
	end)
end

function ChallengeRogueTeamEndingBtnItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
end

function ChallengeRogueTeamEndingBtnItem:SetClickCallBack(arg_6_1)
	self.callBack_ = arg_6_1
end

function ChallengeRogueTeamEndingBtnItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(arg_7_1 == self.index_))
end

return ChallengeRogueTeamEndingBtnItem
