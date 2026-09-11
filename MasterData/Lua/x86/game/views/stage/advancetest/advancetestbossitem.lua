local AdvanceTestBossItem = class("AdvanceTestBossItem", ReduxView)

function AdvanceTestBossItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.difficultyController_ = ControllerUtil.GetController(self.transform_, "difficulty")
	self.affix_item_list = {}
end

function AdvanceTestBossItem:Dispose()
	AdvanceTestBossItem.super.Dispose(self)

	if self.affix_item_list then
		for iter_2_0, iter_2_1 in pairs(self.affix_item_list) do
			iter_2_1:Dispose()
		end

		self.affix_item_list = {}
	end
end

function AdvanceTestBossItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function AdvanceTestBossItem:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.affixListTable[arg_5_1])
end

function AdvanceTestBossItem:RefreshUI(arg_6_1)
	local var_6_0 = AdvanceTestData:GetCacheActivityID()

	self.affixListTable = AdvanceTestCfg[arg_6_1].affix_id

	for iter_6_0 = 1, #self.affixListTable do
		if self.affix_item_list[iter_6_0] == nil then
			self.affix_item_list[iter_6_0] = AdvanceTestBossAffixItem.New((Object.Instantiate(self.buffGo_, self.buffParents_)))
		end

		local var_6_1 = self.affix_item_list[iter_6_0]

		SetActive(self.affix_item_list[iter_6_0].gameObject_, true)
		var_6_1:SetData(self.affixListTable[iter_6_0])
	end

	for iter_6_1 = #self.affixListTable + 1, #self.affix_item_list do
		SetActive(self.affix_item_list[iter_6_1].gameObject_, false)
	end

	AdvanceTestData:SetAffixList(self.affixListTable)

	self.nameText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_2"), GetMonsterName({
		AdvanceTestCfg[arg_6_1].stage_target
	}))
	self.descText_.text = MonsterCfg[AdvanceTestCfg[arg_6_1].stage_target].desc
	self.riskText_.text = self:GetTipsByCfg(AdvanceTestCfg[arg_6_1])
	self.bossImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. AdvanceTestCfg[arg_6_1].stage_target)

	local var_6_2 = self:SetLimitTextTop(AdvanceTestCfg[arg_6_1])
	local var_6_3 = string.format(GetTips("TEST_CHALLENGE_TIPS_1"), self:GetStrByCharacterStar(AdvanceTestCfg[arg_6_1].character), AdvanceTestCfg[arg_6_1].weapon)

	self.limitText_.text = var_6_2 ~= "" and var_6_2 .. "\n" .. var_6_3 or var_6_3
end

function AdvanceTestBossItem:SetLimitTextTop(arg_7_1)
	local var_7_0 = ""
	local var_7_1 = #arg_7_1.limit_hero

	for iter_7_0 = 1, #arg_7_1.limit_hero do
		local var_7_2 = ""

		for iter_7_1, iter_7_2 in pairs(arg_7_1.limit_hero[iter_7_0][2]) do
			var_7_2 = var_7_2 .. HeroCfg[iter_7_2].name .. "·" .. HeroCfg[iter_7_2].suffix .. " "

			if arg_7_1.limit_hero[iter_7_0][1] == 8 then
				break
			end
		end

		local var_7_3 = string.gsub(var_7_2, "^[%s]*(.-)[%s]*$", "%1")

		if arg_7_1.limit_hero[iter_7_0][1] == 1 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_MAIN_HERO_LIMIT"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 2 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_1"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 3 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_1"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 4 then
			var_7_0 = ""
		elseif arg_7_1.limit_hero[iter_7_0][1] == 5 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_BAN_HERO"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 6 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_2"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 7 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_2"), var_7_3)
		elseif arg_7_1.limit_hero[iter_7_0][1] == 8 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_ASTROLABE_LIMIT"), var_7_3, HeroAstrolabeCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[HeroCfg[arg_7_1.limit_hero[iter_7_0][2][1]].astrolabe[arg_7_1.limit_hero[iter_7_0][2][2]]][1]].suit_name)
		end

		if iter_7_0 ~= var_7_1 then
			var_7_0 = var_7_0 .. "\n"
		end
	end

	return var_7_0
end

function AdvanceTestBossItem:GetTipsByCfg(arg_8_1)
	local var_8_0

	if arg_8_1.stage_type == 1 then
		var_8_0 = GetTips("TEST_CHALLENGE_TIPS_3")
	elseif arg_8_1.stage_type == 2 then
		var_8_0 = GetTips("TEST_CHALLENGE_TIPS_4")
	elseif arg_8_1.stage_type == 3 then
		var_8_0 = GetTips("TEST_CHALLENGE_TIPS_5")
	end

	return var_8_0
end

function AdvanceTestBossItem:GetStrByCharacterStar(arg_9_1)
	local var_9_0

	if arg_9_1 == 400 then
		var_9_0 = "SS"
	elseif arg_9_1 == 500 then
		var_9_0 = "SSS"
	elseif arg_9_1 == 600 then
		var_9_0 = "Ω"
	end

	return var_9_0
end

function AdvanceTestBossItem:RegistClickFunc(arg_10_1)
	self.clickFunc_ = arg_10_1
end

return AdvanceTestBossItem
