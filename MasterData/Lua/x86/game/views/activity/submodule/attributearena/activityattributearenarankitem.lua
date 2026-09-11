local ActivityAttributeArenaRankItem = class("ActivityAttributeArenaRankItem", ReduxView)

function ActivityAttributeArenaRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityAttributeArenaRankItem:Init()
	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function ActivityAttributeArenaRankItem:InitUI()
	self:BindCfgUI()

	self.heroCountController_ = self.conExCollection_:GetController("heroCount")
	self.rankController_ = self.conExCollection_:GetController("rank")
end

function ActivityAttributeArenaRankItem:RefreshUI(arg_4_1)
	self.userID_ = arg_4_1.user_id
	self.nickText_.text = arg_4_1.nick

	self.commonPortrait_:RenderHead(arg_4_1.portrait)
	self.commonPortrait_:RenderFrame(arg_4_1.frame)

	self.rankText_.text = arg_4_1.rank
	self.scoreText_.text = arg_4_1.score

	local var_4_0 = arg_4_1:GetSingleSelectHeroList()
	local var_4_1 = math.min(table.length(var_4_0), 3)

	if self.heroCountController_ then
		self.heroCountController_:SetSelectedState(var_4_1)
	end

	for iter_4_0 = 1, var_4_1 do
		self["heroImg_" .. iter_4_0].sprite = getSpriteViaConfig("HeroItemshead", (var_4_0[iter_4_0].skin_id == 0 or nil) and var_4_0[iter_4_0].hero_id)
	end

	if arg_4_1.rank <= 3 then
		self.rankController_:SetSelectedState(arg_4_1.rank)
	else
		self.rankController_:SetSelectedState(0)
	end
end

function ActivityAttributeArenaRankItem:Dispose()
	self.commonPortrait_:Dispose()
	ActivityAttributeArenaRankItem.super.Dispose(self)
end

return ActivityAttributeArenaRankItem
