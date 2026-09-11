local var_0_0 = {}

local function var_0_1()
	if PinballSkillCfg.SkillCfgEx ~= nil then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(PinballSkillCfg.all) do
		local var_1_1 = PinballSkillCfg[iter_1_1]
		local var_1_2 = PinballRoleSkillData.New()

		var_1_2.sType = PinballSkillCfg[iter_1_1].effect_type

		local var_1_3 = {
			var_1_1.cost
		}

		if type(var_1_1.effect) == "table" then
			for iter_1_2, iter_1_3 in ipairs(var_1_1.effect) do
				table.insert(var_1_3, iter_1_3)
			end
		else
			table.insert(var_1_3, var_1_1.effect)

			;({})[1] = var_1_1.effect
		end

		var_1_2.sValue = var_1_3
		var_1_2.cooldown = var_1_1.cd
		var_1_2.remainCD = 0
		var_1_2.icon = var_1_1.icon
		var_1_2.animName = var_1_1.action
		var_1_2.effectName = var_1_1.special_effects
		var_1_2.desc = string.format(GetI18NText(var_1_1.description), unpack(var_1_1.effect))
		var_1_2.name = GetI18NText(var_1_1.name)
		var_1_2.level = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_1_1.skill_group], iter_1_1)
		var_1_0[iter_1_1] = var_1_2
	end

	PinballSkillCfg.SkillCfgEx = var_1_0
end

function var_0_0.PlayPinballGame(arg_2_0, arg_2_1)
	var_0_1()

	whereami = "home"
	var_0_0.PlayingStageID = arg_2_0
	var_0_0.PlayingRoleID = arg_2_1
	_G.PinballDataForExchangeVar = nil

	local var_2_0 = GetPinballDataForExchange()
	local var_2_1 = {}

	var_2_0.playerData.model = PinballPlayerCfg[arg_2_1].model
	var_2_0.playerData.maxHealth = PinballTools.CalcRoleProp(arg_2_1, 1)
	var_2_0.playerData.health = PinballTools.CalcRoleProp(arg_2_1, 1)
	var_2_0.playerData.attack = PinballTools.CalcRoleProp(arg_2_1, 2)
	var_2_0.playerData.abilityPower = PinballTools.CalcRoleProp(arg_2_1, 3)
	var_2_0.playerData.maxSkillPoint = PinballTools.CalcRoleProp(arg_2_1, 4)
	var_2_0.playerData.skillPoint = PinballTools.CalcRoleProp(arg_2_1, 6)
	var_2_0.playerData.skillPointRestore = PinballTools.CalcRoleProp(arg_2_1, 5)

	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs((PinballData:GetExraEquipSkill())) do
		table.insert(var_2_2, PinballSkillCfg.SkillCfgEx[iter_2_1])
	end

	var_2_0.playerData.skillList = var_2_2
	var_2_0.mapData.stageIDList = PinballStageCfg[arg_2_0].wellen_id
	var_2_0.mapData.stageData = Asset.Load("PinballGame/StageData/PinBallGameStage_" .. PinballStageCfg[arg_2_0].wellen_id[1])
	var_2_0.mapData.maxAffectBlocks = GameSetting.pinball_game_max_affect_blocks.value[1]
	var_2_0.mapData.maxProtectBlocks = GameSetting.pinball_game_max_protect_blocks.value[1]
	var_2_0.mapData.challengeRound = 0
	var_2_0.mapData.debateOverflowDamageToSkillPointRate = GameSetting.pinball_game_debate_overflow_damage_to_skill_point_rate.value[1]
	var_2_0.mapData.debateSuccessScore = GameSetting.pinball_game_debate_success_score.value[1]
	var_2_0.mapData.debateLoseScore = GameSetting.pinball_game_debate_lose_score.value[1]

	for iter_2_2, iter_2_3 in ipairs(PinballStageCfg[arg_2_0].wellen_id) do
		local var_2_3

		if type(iter_2_3) == "table" then
			iter_2_3 = iter_2_3[1]
			var_2_3 = {}
		end

		for iter_2_4, iter_2_5 in ipairs(PinballWaveCfg[iter_2_3].wellen_monster_list) do
			local var_2_4 = PinballRoleBattleData.New()

			var_2_4.model = PinballPlayerCfg[iter_2_5].model
			var_2_4.maxHealth = PinballPlayerCfg[iter_2_5].base_attributes[1]
			var_2_4.health = PinballPlayerCfg[iter_2_5].base_attributes[1]
			var_2_4.attack = PinballPlayerCfg[iter_2_5].base_attributes[2]
			var_2_4.abilityPower = PinballPlayerCfg[iter_2_5].base_attributes[3]
			var_2_4.maxSkillPoint = PinballPlayerCfg[iter_2_5].base_attributes[4]
			var_2_4.skillPoint = PinballPlayerCfg[iter_2_5].base_attributes[6]
			var_2_4.skillPointRestore = PinballPlayerCfg[iter_2_5].base_attributes[5]
			var_2_4.actionTimes = PinballPlayerCfg[iter_2_5].action_times

			local var_2_5 = {}

			for iter_2_6, iter_2_7 in ipairs(PinballPlayerCfg[iter_2_5].skill_list) do
				local var_2_6 = PinballRoleSkillData.New()

				var_2_6.sType = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].sType
				var_2_6.sValue = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].sValue
				var_2_6.cooldown = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].cooldown
				var_2_6.remainCD = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].remainCD
				var_2_6.icon = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].icon
				var_2_6.animName = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].animName
				var_2_6.effectName = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].effectName
				var_2_6.desc = GetI18NText(PinballSkillCfg.SkillCfgEx[iter_2_7[1]].desc)
				var_2_6.name = GetI18NText(PinballSkillCfg.SkillCfgEx[iter_2_7[1]].name)
				var_2_6.level = PinballSkillCfg.SkillCfgEx[iter_2_7[1]].level
				var_2_6.weight = iter_2_7[2]

				table.insert(var_2_5, var_2_6)
			end

			var_2_4.skillList = var_2_5

			table.insert(var_2_3, var_2_4)
		end

		table.insert(var_2_1, var_2_3)
	end

	PinballBridge.UpgradeStageParamsFromCfg(var_2_0.mapData.stageData)

	var_2_0.enemyDataList = TableTo2DArray(var_2_1, PinballRoleBattleData)

	PinballBridge:EnterPlay()
end

function var_0_0.PlayPinballChallengeGame(arg_3_0, arg_3_1)
	var_0_1()

	whereami = "home"
	var_0_0.PlayingStageID = arg_3_0
	var_0_0.PlayingRoleID = arg_3_1
	_G.PinballDataForExchangeVar = nil

	local var_3_0 = GetPinballDataForExchange()
	local var_3_1 = {}

	var_3_0.playerData.model = PinballPlayerCfg[arg_3_1].model
	var_3_0.playerData.maxHealth = PinballTools.CalcRoleProp(arg_3_1, 1)
	var_3_0.playerData.health = PinballTools.CalcRoleProp(arg_3_1, 1)
	var_3_0.playerData.attack = PinballTools.CalcRoleProp(arg_3_1, 2)
	var_3_0.playerData.abilityPower = PinballTools.CalcRoleProp(arg_3_1, 3)
	var_3_0.playerData.maxSkillPoint = PinballTools.CalcRoleProp(arg_3_1, 4)
	var_3_0.playerData.skillPoint = PinballTools.CalcRoleProp(arg_3_1, 6)
	var_3_0.playerData.skillPointRestore = PinballTools.CalcRoleProp(arg_3_1, 5)

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs((PinballData:GetExraEquipSkill())) do
		table.insert(var_3_2, PinballSkillCfg.SkillCfgEx[iter_3_1])
	end

	var_3_0.playerData.skillList = var_3_2

	local var_3_4, var_3_5 = var_0_0.GetChallengeWaveList(arg_3_0)

	var_0_0.ChallengeWaveList = var_3_4
	var_0_0.ChallengeBoardList = var_3_5
	var_3_0.mapData.stageIDList = var_3_5
	var_3_0.mapData.stageData = Asset.Load("PinballGame/StageData/PinBallGameStage_" .. var_3_5[1])
	var_3_0.mapData.challengeRound = GameSetting.marbles_play_challenge_round.value[1]
	var_3_0.mapData.debateOverflowDamageToSkillPointRate = GameSetting.pinball_game_debate_overflow_damage_to_skill_point_rate.value[1]
	var_3_0.mapData.debateSuccessScore = GameSetting.pinball_game_debate_success_score.value[1]
	var_3_0.mapData.debateLoseScore = GameSetting.pinball_game_debate_lose_score.value[1]

	for iter_3_2, iter_3_3 in ipairs(var_3_4) do
		local var_3_6

		if type(iter_3_3) == "table" then
			iter_3_3 = iter_3_3[1]
			var_3_6 = {}
		end

		for iter_3_4, iter_3_5 in ipairs(PinballWaveCfg[iter_3_3].wellen_monster_list) do
			local var_3_7 = PinballRoleBattleData.New()

			var_3_7.model = PinballPlayerCfg[iter_3_5].model
			var_3_7.maxHealth = PinballPlayerCfg[iter_3_5].base_attributes[1]
			var_3_7.health = PinballPlayerCfg[iter_3_5].base_attributes[1]
			var_3_7.attack = PinballPlayerCfg[iter_3_5].base_attributes[2]
			var_3_7.abilityPower = PinballPlayerCfg[iter_3_5].base_attributes[3]
			var_3_7.maxSkillPoint = PinballPlayerCfg[iter_3_5].base_attributes[4]
			var_3_7.skillPoint = PinballPlayerCfg[iter_3_5].base_attributes[6]
			var_3_7.skillPointRestore = PinballPlayerCfg[iter_3_5].base_attributes[5]
			var_3_7.actionTimes = PinballPlayerCfg[iter_3_5].action_times

			local var_3_8 = {}

			for iter_3_6, iter_3_7 in ipairs(PinballPlayerCfg[iter_3_5].skill_list) do
				local var_3_9 = PinballRoleSkillData.New()

				var_3_9.sType = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].sType
				var_3_9.sValue = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].sValue
				var_3_9.cooldown = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].cooldown
				var_3_9.remainCD = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].remainCD
				var_3_9.icon = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].icon
				var_3_9.animName = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].animName
				var_3_9.effectName = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].effectName
				var_3_9.desc = GetI18NText(PinballSkillCfg.SkillCfgEx[iter_3_7[1]].desc)
				var_3_9.name = GetI18NText(PinballSkillCfg.SkillCfgEx[iter_3_7[1]].name)
				var_3_9.level = PinballSkillCfg.SkillCfgEx[iter_3_7[1]].level
				var_3_9.weight = iter_3_7[2]

				table.insert(var_3_8, var_3_9)
			end

			var_3_7.skillList = var_3_8

			table.insert(var_3_6, var_3_7)
		end

		table.insert(var_3_1, var_3_6)
	end

	PinballBridge.UpgradeStageParamsFromCfg(var_3_0.mapData.stageData)

	var_3_0.enemyDataList = TableTo2DArray(var_3_1, PinballRoleBattleData)

	PinballBridge:EnterPlay()
end

function var_0_0.GetChallengeWaveList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(PinballWaveCfg.get_id_list_by_challenge_general_wellen_id) do
		if iter_4_0 >= 1 then
			local var_4_2 = false

			while not var_4_2 and 0 < 100 do
				local var_4_4 = iter_4_1[math.random(1, #iter_4_1)]

				if table.indexof(PinballStageCfg[arg_4_0].wellen_id, var_4_4) then
					local var_4_5 = PinballWaveCfg[var_4_4].board_id[math.random(1, #PinballWaveCfg[var_4_4].board_id)]

					table.insert(var_4_0, var_4_4)
					table.insert(var_4_1, var_4_5)

					var_4_2 = true
				end
			end

			if not var_4_2 then
				print("Warning: Could not find a valid wave ID in waveIDList after multiple attempts.")
			end
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.EnterPinballGameScene()
	DormMinigame.Launch("PinballGame", nil, {
		isEnter = true,
		isEnterHome = true
	})

	whereami = "home"
end

function var_0_0.RecordStartTime()
	var_0_0.GameStartTime = manager.time:GetServerTime()
end

function var_0_0.EndAndGetTime()
	if not var_0_0.GameStartTime then
		return 0
	end

	return manager.time:GetServerTime() - var_0_0.GameStartTime
end

function var_0_0.InitNormalData(arg_8_0)
	PinballData.activityID = 3840801
	PinballData.stageInfo = {}

	PinballData:SetUnlockSkillList({})
	PinballData:SetRoleLevel(1)
	PinballData:SetExtraEquipSkill({})
	PinballData:SetMaxChallengeScore(0)
	var_0_0.UpdateStageRedPoint()
	var_0_0.InitRedPoint()
end

function var_0_0:InitFromServer()
	PinballData.activityID = 3840801
	PinballData.stageInfo = {}

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self.stage_list) do
		if PinballStageCfg[iter_9_1].barrier_type ~= 3 then
			table.insert(var_9_0, iter_9_1)
		end

		PinballData:SetStageCleared(iter_9_1, true)

		if iter_9_1 >= PinballData:GetLastPassStage() then
			PinballData:SetLastPassStage(iter_9_1)
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_1 < arg_10_0
	end)

	if var_9_0[1] then
		local var_9_1 = PinballData:GetDisplayStageList()

		PinballData:SetLastEnterStageCategory(var_9_1[math.min(#var_9_1, (table.indexof(var_9_1, var_9_0[1]) or 0) + 1)])
	end

	PinballData:SetUnlockSkillList(self.skills)
	PinballData:SetRoleLevel(self.hai_la_level)
	PinballData:SetExtraEquipSkill(self.select_active_skills)
	PinballData:SetMaxChallengeScore(self.challenge_score)
	var_0_0.UpdateStageRedPoint()
	var_0_0.InitRedPoint()
	manager.notify:CallUpdateFunc(PINBALL_SETTMENT_UPDATE_TARGET_STAR)
end

manager.net:Bind(89401, var_0_0.InitFromServer)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_11_0)
	if PinballData.activityID == nil or not PinballTools.IsActivityCoin(arg_11_0) then
		return
	end
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_12_0)
	if PinballData.activityID == nil then
		return
	end
end)

function var_0_0.SendLevelFinish(arg_13_0, arg_13_1, arg_13_2)
	manager.net:SendWithLoadingNew(89402, {
		stage_id = var_0_0.PlayingStageID,
		score = arg_13_0 or 0,
		harm = arg_13_1 or 0
	}, 89403, function(arg_14_0, arg_14_1)
		var_0_0.OnSendLevelFinish(arg_14_0, arg_14_1, arg_13_2)
	end)
end

function var_0_0:OnSendLevelFinish(arg_15_1, arg_15_2)
	if isSuccess(self.result) then
		if arg_15_2 then
			arg_15_2()
		end

		if arg_15_1.stage_id == PinballData:GetChallengeStageID() then
			return
		end

		local var_15_0 = PinballData:GetDisplayStageList()

		PinballData:SetLastEnterStageCategory(var_15_0[math.min(#var_15_0, table.indexof(var_15_0, arg_15_1.stage_id) + 1)])
		PinballData:SetLastPassStage(arg_15_1.stage_id)
	else
		ShowTips(self.result)
	end
end

function var_0_0.SendMessageDataToSDK(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10, arg_16_11)
	local var_16_0 = PinballData:GetEquipedActiveSkill()
	local var_16_1 = {}

	for iter_16_0 = 0, arg_16_10.Count - 1 do
		local var_16_3 = {
			sequence_id = arg_16_10[iter_16_0].sequence_id,
			is_special = arg_16_10[iter_16_0].is_special,
			battle_times = arg_16_10[iter_16_0].battle_times + 1,
			hit_num = arg_16_10[iter_16_0].hit_num,
			remove_num = arg_16_10[iter_16_0].remove_num
		}

		var_16_3.skill_num = "[{" .. (var_16_0[1] or 0) .. "," .. arg_16_10[iter_16_0].activeSkillUseCount[0] .. "}," .. "{" .. (var_16_0[2] or 0) .. "," .. arg_16_10[iter_16_0].activeSkillUseCount[1] .. "}]"
		var_16_3.different_skill_num = arg_16_10[iter_16_0].different_skill_num
		var_16_3.battle_hurt = "[" .. arg_16_10[iter_16_0].enemyHurt .. "," .. arg_16_10[iter_16_0].affectHurt .. "]"
		var_16_3.boss_num = arg_16_10[iter_16_0].leftEnemyCount
		var_16_3.boss_hp = arg_16_10[iter_16_0].leftEnemyWaveHp
		var_16_3.hero_hp = arg_16_10[iter_16_0].leftPlayerHp
		var_16_3.progress = arg_16_10[iter_16_0].debateProgress
		var_16_3.result = arg_16_10[iter_16_0].debateResult
		var_16_3.use_seconds = math.floor(arg_16_10[iter_16_0].useSceond)

		table.insert(var_16_1, var_16_3)
	end

	local var_16_4 = {
		activity_id = PinballData:GetActivityID(),
		stage_id = var_0_0.PlayingStageID,
		result = arg_16_6,
		use_seconds = math.floor(arg_16_7),
		sequence_id = arg_16_8,
		battle_times = arg_16_0 + 1,
		hero_list = "{{ id =" .. var_0_0.PlayingRoleID .. ",level = " .. PinballData:GetRoleLevel(var_0_0.PlayingRoleID) .. "}}"
	}
	local var_16_5 = {}
	local var_16_6 = {}

	var_16_6[1] = var_16_0[1] or 0
	var_16_6[2] = arg_16_9[0]
	var_16_5[1] = var_16_6

	local var_16_7 = {}

	var_16_7[1] = var_16_0[2] or 0
	var_16_7[2] = arg_16_9[1]
	var_16_5[2] = var_16_7
	var_16_4.skill_num = var_16_5
	var_16_4.hero_hp = arg_16_1
	var_16_4.score = arg_16_11
	var_16_4.other_arrayobject = var_16_1

	SDKTools.SendMessageToSDK("activity_combat_over", var_16_4)
end

function var_0_0.EquipSkill(arg_17_0)
	local var_17_0 = PinballData:GetEquipedActiveSkill()

	table.insert(var_17_0, arg_17_0)
	var_0_0.SendEquipExtraSkill(var_17_0)
end

function var_0_0.UnEquipSkill(arg_18_0)
	local var_18_0 = PinballData:GetEquipedActiveSkill()

	table.remove(var_18_0, table.indexof(var_18_0, arg_18_0))
	var_0_0.SendEquipExtraSkill(var_18_0)
end

function var_0_0.SendEquipExtraSkill(arg_19_0)
	manager.net:SendWithLoadingNew(89404, {
		activity_id = PinballData:GetActivityID(),
		skill_list = arg_19_0
	}, 89405, var_0_0.OnSendEquipExtraSkillFinish)
end

function var_0_0:OnSendEquipExtraSkillFinish(arg_20_1)
	if isSuccess(self.result) then
		PinballData:SetExtraEquipSkill(arg_20_1.skill_list)
		manager.notify:CallUpdateFunc(PINBALL_EQUIP_SKILL)
	else
		ShowTips(self.result)
	end
end

function var_0_0.OpenBattle(arg_21_0)
	var_0_0.PlayingStageID = arg_21_0

	if not PinballStageCfg[arg_21_0] then
		return
	end

	local var_21_0 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE, PinballStageCfg[arg_21_0].barrier_id, {
		stageID = arg_21_0
	})

	if not var_21_0 then
		return
	end

	BattleController.GetInstance():LaunchBattle(var_21_0)
end

function var_0_0.InitRedPoint()
	local var_22_0 = PinballData:GetActivityID()
	local var_22_2 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityCfg[var_22_0].sub_activity_list[2])
	local var_22_3 = {}

	for iter_22_0, iter_22_1 in ipairs(ActivityCfg[ActivityCfg[var_22_0].sub_activity_list[2]].sub_activity_list) do
		table.insert(var_22_3, (string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_22_1)))
	end

	manager.redPoint:addGroup(var_22_2, var_22_3)
	manager.redPoint:addGroup(RedPointConst.HELLA_PINBALL_ACTIVITY_MAIN .. var_22_0, {
		RedPointConst.HELLA_PINBALL_FIRST_ENTER .. var_22_0,
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_22_0),
		var_22_2
	})
end

function var_0_0.UpdateStageRedPoint()
	local var_23_0 = PinballData:GetActivityID()

	manager.redPoint:setTip(RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_23_0, 0)

	for iter_23_0, iter_23_1 in ipairs(PinballSkillCfg.get_id_list_by_activity_id_skill_type[var_23_0][1]) do
		if PinballData:IsSkillNew(iter_23_1) then
			manager.redPoint:setTip(RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_23_0, 1)

			break
		end
	end

	local var_23_1 = RedPointConst.HELLA_PINBALL_FIRST_ENTER .. var_23_0

	if not getData("PinballGame", "firstEnter") then
		manager.redPoint:setTip(var_23_1, 1)
	else
		manager.redPoint:setTip(var_23_1, 0)
	end
end

return var_0_0
