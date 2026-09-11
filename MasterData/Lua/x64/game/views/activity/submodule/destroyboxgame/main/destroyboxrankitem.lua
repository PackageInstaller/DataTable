local DestroyBoxRankItem = class("DestroyBoxRankItem", ReduxView)

function DestroyBoxRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function DestroyBoxRankItem:initUI()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()

	self.rankController_ = self.conExCollection_:GetController("rank")
	self.heroCountController_ = self.conExCollection_:GetController("heroCount")
end

function DestroyBoxRankItem:AddListeners()
	return
end

function DestroyBoxRankItem:Refresh(arg_4_1)
	self.user_id = arg_4_1.user_id
	self.rankText_.text = GetI18NText(arg_4_1.rank)
	self.scoreText_.text = GetI18NText(arg_4_1.score)
	self.heroList_ = arg_4_1:GetSingleSelectHeroList()

	self.heroCountController_:SetSelectedState(tostring(#self.heroList_))

	for iter_4_0, iter_4_1 in ipairs(self.heroList_) do
		if HeroStandardSystemCfg[iter_4_1.id] ~= nil then
			self.heroID_ = HeroStandardSystemCfg[davta.id].hero_id
			self[string.format("heroImg_%s", iter_4_0)].sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. iter_4_1.skin_id)
		else
			self.heroID_ = iter_4_1.hero_id
			self[string.format("heroImg_%s", iter_4_0)].sprite = (not iter_4_1.skin_id or iter_4_1.skin_id == 0) and pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. self.heroID_) or pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. iter_4_1.skin_id)
		end
	end

	if arg_4_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_4_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.nickText_.text = GetI18NText(arg_4_1.nick)

	self.commonPortrait_:RenderHead(arg_4_1.portrait)
	self.commonPortrait_:RenderFrame(arg_4_1.frame)
end

function DestroyBoxRankItem:Dispose()
	self.commonPortrait_:Dispose()
	DestroyBoxRankItem.super.Dispose(self)
end

return DestroyBoxRankItem
