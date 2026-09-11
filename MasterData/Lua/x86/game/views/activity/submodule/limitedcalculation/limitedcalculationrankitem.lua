local LimitedCalculationRankItem = class("LimitedCalculationRankItem", ReduxView)

function LimitedCalculationRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function LimitedCalculationRankItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationRankItem:InitUI()
	self:BindCfgUI()

	self.heroCountController_ = ControllerUtil.GetController(self.transform_, "heroCount")
	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
end

function LimitedCalculationRankItem:AddUIListeners()
	return
end

function LimitedCalculationRankItem:OnEner()
	return
end

function LimitedCalculationRankItem:RefreshUI(arg_6_1)
	self.userID_ = arg_6_1.user_id
	self.name_.text = GetI18NText(arg_6_1.nick)
	self.icon_.sprite = ItemTools.getItemSprite(arg_6_1.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_6_1.frame)
	self.rank_.text = GetI18NText(arg_6_1.rank)
	self.score_.text = GetI18NText(arg_6_1.score)
	self.difficulty_.text = GetI18NText(arg_6_1.difficulty)

	local var_6_0 = arg_6_1:GetSingleSelectHeroList()
	local var_6_1 = math.min(table.length(var_6_0), 3)

	self.heroCountController_:SetSelectedState(var_6_1)

	for iter_6_0 = 1, var_6_1 do
		self["m_heroIcon_" .. iter_6_0].sprite = getSpriteViaConfig("HeroLittleIcon", (var_6_0[iter_6_0].skin_id == 0 or nil) and var_6_0[iter_6_0].hero_id)
	end

	if arg_6_1.rank <= 3 then
		self.rankController_:SetSelectedState(arg_6_1.rank)
	else
		self.rankController_:SetSelectedState(0)
	end
end

function LimitedCalculationRankItem:OnExit()
	return
end

function LimitedCalculationRankItem:Dispose()
	self:RemoveAllListeners()
	LimitedCalculationRankItem.super.Dispose(self)
end

return LimitedCalculationRankItem
