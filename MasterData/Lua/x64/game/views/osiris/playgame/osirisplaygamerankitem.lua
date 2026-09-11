local OsirisPlayGameRankItem = class("OsirisPlayGameRankItem", ReduxView)

function OsirisPlayGameRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function OsirisPlayGameRankItem:Init()
	self:InitUI()
end

function OsirisPlayGameRankItem:InitUI()
	self:BindCfgUI()

	self.rankController_ = self.conExCollection_:GetController("rank")
	self.heroCountController_ = self.conExCollection_:GetController("heroCount")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function OsirisPlayGameRankItem:SetData(arg_4_1, arg_4_2)
	self.index = arg_4_2
	self.data = arg_4_1
	self.heroList = arg_4_1:GetSingleSelectHeroList()

	self:UpdateView()
end

function OsirisPlayGameRankItem:UpdateView()
	self.nickText_.text = self.data.nick
	self.rankText_.text = self.data.rank

	self.rankController_:SetSelectedState(tostring(self.data.rank > 3 and 0 or self.data.rank))
	self.commonPortrait_:RenderHead(self.data.portrait)
	self.commonPortrait_:RenderFrame(self.data.frame)

	self.scoreText_.text = self.data.score
	self.team_list_ = {}

	for iter_5_0, iter_5_1 in ipairs(self.data.stage_team_list[0]) do
		self.team_list_[iter_5_0] = {}

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			table.insert(self.team_list_[iter_5_0], {
				hero_id = iter_5_3.hero_id,
				skin_id = iter_5_3.skin_id
			})
		end
	end

	local var_5_0 = math.min(table.length(self.team_list_), 3)

	self.heroCountController_:SetSelectedState(var_5_0)

	for iter_5_4 = 1, var_5_0 do
		self["heroImg_" .. iter_5_4].sprite = getSpriteViaConfig("HeroItemshead", (self.team_list_[iter_5_4][1].skin_id == 0 or nil) and self.team_list_[iter_5_4][1].hero_id)
	end
end

function OsirisPlayGameRankItem:OnEnter()
	self:UpdateView()
end

function OsirisPlayGameRankItem:Dispose()
	self.commonPortrait_:Dispose()
	OsirisPlayGameRankItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return OsirisPlayGameRankItem
