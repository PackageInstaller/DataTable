local GuildActivityRaceRankItem = class("GuildActivityRaceRankItem", ReduxView)

function GuildActivityRaceRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function GuildActivityRaceRankItem:Init()
	self:InitUI()
end

function GuildActivityRaceRankItem:InitUI()
	self:BindCfgUI()

	self.heroCountController_ = ControllerUtil.GetController(self.transform_, "heroCount")
	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
end

function GuildActivityRaceRankItem:RefreshUI(arg_4_1)
	self.userID_ = arg_4_1.user_id
	self.name_.text = GetI18NText(arg_4_1.nick)
	self.icon_.sprite = ItemTools.getItemSprite(arg_4_1.icon)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_4_1.icon_frame)
	self.rank_.text = arg_4_1.rank
	self.score_.text = arg_4_1.score

	local var_4_0 = math.min(table.length(arg_4_1.select_hero_id_list), 3)

	self.heroCountController_:SetSelectedState(var_4_0)

	for iter_4_0 = 1, var_4_0 do
		self["m_heroIcon_" .. iter_4_0].sprite = getSpriteViaConfig("HeroLittleIcon", arg_4_1.select_hero_id_list[iter_4_0])
	end

	if arg_4_1.rank <= 3 then
		self.rankController_:SetSelectedState(arg_4_1.rank)
	else
		self.rankController_:SetSelectedState(0)
	end
end

return GuildActivityRaceRankItem
