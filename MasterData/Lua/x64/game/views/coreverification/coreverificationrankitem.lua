local CoreVerificationRankItem = class("CoreVerificationRankItem", ReduxView)

function CoreVerificationRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddListeners()
end

function CoreVerificationRankItem:InitUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.rankController_ = self.conExCollection_:GetController("rank")
end

function CoreVerificationRankItem:AddListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		CoreVerificationChallengeTools.ShowTeamFromRankInfoAndModeIndex(self.coreVerificationModeIndex, self.data)
	end)
end

function CoreVerificationRankItem:Refresh(arg_5_1, arg_5_2)
	self.data = arg_5_1
	self.coreVerificationModeIndex = arg_5_2
	self.user_id = arg_5_1.user_id
	self.rankText_.text = GetI18NText(arg_5_1.rank)
	self.scoreText_.text = GetI18NText(arg_5_1.score)
	self.layerText_.text = GetI18NText(arg_5_1.difficulty == 0 and 9 or arg_5_1.difficulty)

	if arg_5_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_5_1.nick)

	self.commonPortrait_:RenderHead(arg_5_1.portrait)
	self.commonPortrait_:RenderFrame(arg_5_1.frame)
end

function CoreVerificationRankItem:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	CoreVerificationRankItem.super.Dispose(self)
end

return CoreVerificationRankItem
