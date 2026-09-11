local MatrixRankItem = class("MatrixRankItem", ReduxView)

function MatrixRankItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MatrixRankItem:initUI()
	self:BindCfgUI()

	self.heroCountController_ = ControllerUtil.GetController(self.transform_, "heroCount")
	self.rankController_ = ControllerUtil.GetController(self.transform_, "rank")
end

function MatrixRankItem:Refresh(arg_3_1)
	self.user_id = arg_3_1.user_id
	self.m_rankText.text = arg_3_1.rank
	self.m_scoreText.text = arg_3_1.score
	self.m_difficultyText.text = arg_3_1.difficulty

	local var_3_0 = math.min(table.length(arg_3_1.select_hero_id_list), 3)

	self.heroCountController_:SetSelectedIndex(var_3_0)

	for iter_3_0 = 1, var_3_0 do
		if HeroStandardSystemCfg[arg_3_1.select_hero_id_list[iter_3_0].id] then
			self["m_heroIcon_" .. iter_3_0].sprite = getSpriteViaConfig("HeroLittleIcon", SkinCfg[(arg_3_1.select_hero_id_list[iter_3_0].skin_id == 0 or nil) and HeroStandardSystemCfg[arg_3_1.select_hero_id_list[iter_3_0].id].hero_id].picture_id)
		end
	end

	if arg_3_1.rank <= 3 then
		self.rankController_:SetSelectedIndex(arg_3_1.rank)
	else
		self.rankController_:SetSelectedIndex(0)
	end

	self.m_name.text = GetI18NText(arg_3_1.nick)
	self.m_icon.sprite = ItemTools.getItemSprite(arg_3_1.icon)
	self.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_3_1.icon_frame)
end

return MatrixRankItem
