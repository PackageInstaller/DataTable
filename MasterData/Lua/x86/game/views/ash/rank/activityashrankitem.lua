local ActivityAshRankItem = class("ActivityAshRankItem", ReduxView)

function ActivityAshRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityAshRankItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function ActivityAshRankItem:InitUI()
	self:BindCfgUI()

	self.rankController_ = self.conExCollection_:GetController("rank")
end

function ActivityAshRankItem:RefreshUI(arg_4_1)
	self.userID_ = arg_4_1.user_id
	self.nickText_.text = arg_4_1.nick

	self.commonPortrait_:RenderHead(arg_4_1.portrait)
	self.commonPortrait_:RenderFrame(arg_4_1.frame)

	self.rankText_.text = arg_4_1.rank
	self.scoreText_.text = arg_4_1.score

	if arg_4_1.rank <= 3 then
		self.rankController_:SetSelectedState(arg_4_1.rank)
	else
		self.rankController_:SetSelectedState(0)
	end
end

function ActivityAshRankItem:Dispose()
	self.commonPortrait_:Dispose()
	ActivityAshRankItem.super.Dispose(self)
end

return ActivityAshRankItem
