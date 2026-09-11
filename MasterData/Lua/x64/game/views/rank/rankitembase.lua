local RankItemBase = class("RankItemBase", ReduxView)

function RankItemBase:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function RankItemBase:initUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.rankController_ = self.conExCollection_:GetController("rank")
end

function RankItemBase:AddListeners()
	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("polyhedronRankSquads", {
			list = self.heroList_
		})
	end)
end

function RankItemBase:Refresh(arg_5_1)
	self.user_id = arg_5_1.user_id
	self.rankText_.text = GetI18NText(arg_5_1.rank)
	self.scoreText_.text = GetI18NText(arg_5_1.score)
	self.layerText_.text = GetI18NText(arg_5_1.difficulty)
	self.heroList_ = arg_5_1:GetSingleSelectHeroList()

	if arg_5_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_5_1.nick)

	self.commonPortrait_:RenderHead(arg_5_1.portrait)
	self.commonPortrait_:RenderFrame(arg_5_1.frame)
end

function RankItemBase:Dispose()
	self.commonPortrait_:Dispose()
	RankItemBase.super.Dispose(self)
end

return RankItemBase
