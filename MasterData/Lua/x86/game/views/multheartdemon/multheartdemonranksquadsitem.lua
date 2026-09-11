local MultHeartDemonRankSquadsItem = class("MultHeartDemonRankSquadsItem", ReduxView)

function MultHeartDemonRankSquadsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MultHeartDemonRankSquadsItem:initUI()
	self:BindCfgUI()

	self.typeController_ = ControllerUtil.GetController(self.transform_, "type")
end

local function var_0_1(arg_3_0, arg_3_1)
	if arg_3_0 and arg_3_0 ~= 0 then
		return arg_3_0
	end

	return arg_3_1
end

function MultHeartDemonRankSquadsItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0

	if HeroStandardSystemCfg[arg_4_1.skin_id] ~= nil then
		self.heroID_ = HeroStandardSystemCfg[arg_4_1.skin_id].hero_id
		var_4_0 = HeroStandardSystemCfg[arg_4_1.skin_id].skin_id
	else
		self.heroID_ = arg_4_1.hero_id
		var_4_0 = var_0_1(arg_4_1.skin_id, self.heroID_)
	end

	self.portraitImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_4_0)
	self.nameText_.text = GetI18NText(HeroCfg[self.heroID_].name)
	self.rangeTypeText_.text = GetTips("MULTI_HEART_DEMON_ORDER_" .. arg_4_2)

	local var_4_2 = nullable(arg_4_3, arg_4_2) or nullable(arg_4_3, arg_4_1.skin_id) or 100

	self.hp_.text = string.format("%d%%", var_4_2)
	self.hpBar_.fillAmount = var_4_2 / 100
end

function MultHeartDemonRankSquadsItem:SetIsCaptain(arg_5_1)
	self.typeController_:SetSelectedIndex(arg_5_1 and 1 or 0)
end

return MultHeartDemonRankSquadsItem
