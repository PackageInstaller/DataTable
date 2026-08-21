local var_0_0 = class("AdvanceTestBossItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.difficultyController_ = ControllerUtil.GetController(arg_1_0.transform_, "difficulty")
	arg_1_0.affix_item_list = {}
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	if arg_2_0.affix_item_list then
		for iter_2_0, iter_2_1 in pairs(arg_2_0.affix_item_list) do
			iter_2_1:Dispose()
		end

		arg_2_0.affix_item_list = {}
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.clickFunc_ then
			arg_3_0.clickFunc_()
		end
	end)
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.affixListTable[arg_5_1])
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = AdvanceTestData:GetCacheActivityID()
	local var_6_1 = AdvanceTestCfg[arg_6_1]
	local var_6_2 = var_6_1.stage_target
	local var_6_3 = MonsterCfg[var_6_2]

	arg_6_0.affixListTable = var_6_1.affix_id

	for iter_6_0 = 1, #arg_6_0.affixListTable do
		if arg_6_0.affix_item_list[iter_6_0] == nil then
			local var_6_4 = Object.Instantiate(arg_6_0.buffGo_, arg_6_0.buffParents_)
			local var_6_5 = AdvanceTestBossAffixItem.New(var_6_4)

			arg_6_0.affix_item_list[iter_6_0] = var_6_5
		end

		local var_6_6 = arg_6_0.affix_item_list[iter_6_0]

		SetActive(var_6_6.gameObject_, true)
		var_6_6:SetData(arg_6_0.affixListTable[iter_6_0])
	end

	for iter_6_1 = #arg_6_0.affixListTable + 1, #arg_6_0.affix_item_list do
		local var_6_7 = arg_6_0.affix_item_list[iter_6_1]

		SetActive(var_6_7.gameObject_, false)
	end

	AdvanceTestData:SetAffixList(arg_6_0.affixListTable)

	arg_6_0.nameText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_2"), GetMonsterName({
		var_6_2
	}))
	arg_6_0.descText_.text = var_6_3.desc
	arg_6_0.riskText_.text = arg_6_0:GetTipsByCfg(var_6_1)
	arg_6_0.bossImg_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_6_2)

	local var_6_8 = arg_6_0:SetLimitTextTop(var_6_1)
	local var_6_9 = string.format(GetTips("TEST_CHALLENGE_TIPS_1"), arg_6_0:GetStrByCharacterStar(var_6_1.character), var_6_1.weapon)

	if var_6_8 ~= "" then
		arg_6_0.limitText_.text = var_6_8 .. "\n" .. var_6_9
	else
		arg_6_0.limitText_.text = var_6_9
	end
end

function var_0_0.SetLimitTextTop(arg_7_0, arg_7_1)
	local var_7_0 = ""
	local var_7_1 = arg_7_1.limit_hero
	local var_7_2 = #var_7_1

	for iter_7_0 = 1, var_7_2 do
		local var_7_3 = var_7_1[iter_7_0]
		local var_7_4 = var_7_3[1]
		local var_7_5 = var_7_3[2]
		local var_7_6 = ""

		for iter_7_1, iter_7_2 in pairs(var_7_5) do
			var_7_6 = var_7_6 .. HeroCfg[iter_7_2].name .. "·" .. HeroCfg[iter_7_2].suffix .. " "

			if var_7_4 == 8 then
				break
			end
		end

		local var_7_7 = string.gsub(var_7_6, "^[%s]*(.-)[%s]*$", "%1")

		if var_7_4 == 1 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_MAIN_HERO_LIMIT"), var_7_7)
		elseif var_7_4 == 2 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_1"), var_7_7)
		elseif var_7_4 == 3 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_1"), var_7_7)
		elseif var_7_4 == 4 then
			var_7_0 = ""
		elseif var_7_4 == 5 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_BAN_HERO"), var_7_7)
		elseif var_7_4 == 6 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_2"), var_7_7)
		elseif var_7_4 == 7 then
			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_2"), var_7_7)
		elseif var_7_4 == 8 then
			local var_7_8 = var_7_5[1]
			local var_7_9 = var_7_5[2]
			local var_7_10 = HeroCfg[var_7_8].astrolabe[var_7_9]
			local var_7_11 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[var_7_10]
			local var_7_12 = HeroAstrolabeCfg[var_7_11[1]].suit_name

			var_7_0 = var_7_0 .. string.format(GetTips("TEST_CHALLENGE_HERO_ASTROLABE_LIMIT"), var_7_7, var_7_12)
		end

		if iter_7_0 ~= var_7_2 then
			var_7_0 = var_7_0 .. "\n"
		end
	end

	return var_7_0
end

function var_0_0.GetTipsByCfg(arg_8_0, arg_8_1)
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

function var_0_0.GetStrByCharacterStar(arg_9_0, arg_9_1)
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

function var_0_0.RegistClickFunc(arg_10_0, arg_10_1)
	arg_10_0.clickFunc_ = arg_10_1
end

return var_0_0
