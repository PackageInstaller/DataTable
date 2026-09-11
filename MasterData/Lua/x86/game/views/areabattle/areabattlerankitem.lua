local AreaBattleRankItem = class("AreaBattleRankItem", ReduxView)

function AreaBattleRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AreaBattleRankItem:Init()
	self:InitUI()
end

function AreaBattleRankItem:InitUI()
	self:BindCfgUI()

	self.rankController_ = self.conExCollection_:GetController("rank")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddBtnListener(self.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("AreaBattleRankSquadsView", {
			list = self.heroList
		})
	end)
end

function AreaBattleRankItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	self.index = arg_5_2
	self.data = arg_5_1
	self.type = arg_5_3
	self.heroList = arg_5_1:GetSingleSelectHeroList()

	self:UpdateView()
end

function AreaBattleRankItem:UpdateView()
	if self.data == nil then
		self.rankController_:SetSelectedState("5")

		self.rankText_.text = ""

		return
	end

	self.nickText_.text = self.data.nick
	self.rankText_.text = self.data.rank

	self.rankController_:SetSelectedState(tostring(self.data.rank > 3 and 0 or self.data.rank))
	self.commonPortrait_:RenderHead(self.data.portrait)
	self.commonPortrait_:RenderFrame(self.data.frame)

	self.scoreText_.text = self.data.score
end

function AreaBattleRankItem:OnEnter()
	self:UpdateView()
end

function AreaBattleRankItem:Dispose()
	self.commonPortrait_:Dispose()
	AreaBattleRankItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleRankItem
