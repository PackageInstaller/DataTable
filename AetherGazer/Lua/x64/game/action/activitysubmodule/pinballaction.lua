local var_0_0 = {}

local function var_0_1()
	if PinballSkillCfg.SkillCfgEx ~= nil then
		return
	end

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(PinballSkillCfg.all) do
		local var_1_1 = PinballSkillCfg[iter_1_1]
		local var_1_2 = PinballRoleSkillData.New()

		var_1_2.sType = var_1_1.effect_type

		local var_1_3 = {
			var_1_1.cost
		}
		local var_1_4 = var_1_1.effect

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
	local var_2_1 = var_2_0.playerData
	local var_2_2 = {}
	local var_2_3 = var_2_0.mapData

	var_2_1.model = PinballPlayerCfg[arg_2_1].model
	var_2_1.maxHealth = PinballTools.CalcRoleProp(arg_2_1, 1)
	var_2_1.health = PinballTools.CalcRoleProp(arg_2_1, 1)
	var_2_1.attack = PinballTools.CalcRoleProp(arg_2_1, 2)
	var_2_1.abilityPower = PinballTools.CalcRoleProp(arg_2_1, 3)
	var_2_1.maxSkillPoint = PinballTools.CalcRoleProp(arg_2_1, 4)
	var_2_1.skillPoint = PinballTools.CalcRoleProp(arg_2_1, 6)
	var_2_1.skillPointRestore = PinballTools.CalcRoleProp(arg_2_1, 5)

	local var_2_4 = {}
	local var_2_5 = PinballData:GetExraEquipSkill()

	for iter_2_0, iter_2_1 in ipairs(var_2_5) do
		local var_2_6 = PinballSkillCfg.SkillCfgEx[iter_2_1]

		table.insert(var_2_4, var_2_6)
	end

	var_2_1.skillList = var_2_4

	local var_2_7 = PinballStageCfg[arg_2_0].wellen_id

	var_2_3.stageIDList = var_2_7
	var_2_3.stageData = Asset.Load("PinballGame/StageData/PinBallGameStage_" .. var_2_7[1])
	var_2_3.maxAffectBlocks = GameSetting.pinball_game_max_affect_blocks.value[1]
	var_2_3.maxProtectBlocks = GameSetting.pinball_game_max_protect_blocks.value[1]
	var_2_3.challengeRound = 0
	var_2_3.debateOverflowDamageToSkillPointRate = GameSetting.pinball_game_debate_overflow_damage_to_skill_point_rate.value[1]
	var_2_3.debateSuccessScore = GameSetting.pinball_game_debate_success_score.value[1]
	var_2_3.debateLoseScore = GameSetting.pinball_game_debate_lose_score.value[1]

	for iter_2_2, iter_2_3 in ipairs(var_2_7) do
		if type(iter_2_3) == "table" then
			iter_2_3 = iter_2_3[1]
		end

		local var_2_8 = PinballWaveCfg[iter_2_3]
		local var_2_9 = {}

		for iter_2_4, iter_2_5 in ipairs(var_2_8.wellen_monster_list) do
			local var_2_10 = PinballPlayerCfg[iter_2_5]
			local var_2_11 = PinballRoleBattleData.New()

			var_2_11.model = var_2_10.model
			var_2_11.maxHealth = var_2_10.base_attributes[1]
			var_2_11.health = var_2_10.base_attributes[1]
			var_2_11.attack = var_2_10.base_attributes[2]
			var_2_11.abilityPower = var_2_10.base_attributes[3]
			var_2_11.maxSkillPoint = var_2_10.base_attributes[4]
			var_2_11.skillPoint = var_2_10.base_attributes[6]
			var_2_11.skillPointRestore = var_2_10.base_attributes[5]
			var_2_11.actionTimes = var_2_10.action_times

			local var_2_12 = {}

			for iter_2_6, iter_2_7 in ipairs(var_2_10.skill_list) do
				local var_2_13 = PinballSkillCfg.SkillCfgEx[iter_2_7[1]]
				local var_2_14 = PinballRoleSkillData.New()

				var_2_14.sType = var_2_13.sType
				var_2_14.sValue = var_2_13.sValue
				var_2_14.cooldown = var_2_13.cooldown
				var_2_14.remainCD = var_2_13.remainCD
				var_2_14.icon = var_2_13.icon
				var_2_14.animName = var_2_13.animName
				var_2_14.effectName = var_2_13.effectName
				var_2_14.desc = GetI18NText(var_2_13.desc)
				var_2_14.name = GetI18NText(var_2_13.name)
				var_2_14.level = var_2_13.level
				var_2_14.weight = iter_2_7[2]

				table.insert(var_2_12, var_2_14)
			end

			var_2_11.skillList = var_2_12

			table.insert(var_2_9, var_2_11)
		end

		table.insert(var_2_2, var_2_9)
	end

	PinballBridge.UpgradeStageParamsFromCfg(var_2_3.stageData)

	var_2_0.enemyDataList = TableTo2DArray(var_2_2, PinballRoleBattleData)

	PinballBridge:EnterPlay()
end

function var_0_0.PlayPinballChallengeGame(arg_3_0, arg_3_1)
	var_0_1()

	whereami = "home"
	var_0_0.PlayingStageID = arg_3_0
	var_0_0.PlayingRoleID = arg_3_1
	_G.PinballDataForExchangeVar = nil

	local var_3_0 = GetPinballDataForExchange()
	local var_3_1 = var_3_0.playerData
	local var_3_2 = {}
	local var_3_3 = var_3_0.mapData

	var_3_1.model = PinballPlayerCfg[arg_3_1].model
	var_3_1.maxHealth = PinballTools.CalcRoleProp(arg_3_1, 1)
	var_3_1.health = PinballTools.CalcRoleProp(arg_3_1, 1)
	var_3_1.attack = PinballTools.CalcRoleProp(arg_3_1, 2)
	var_3_1.abilityPower = PinballTools.CalcRoleProp(arg_3_1, 3)
	var_3_1.maxSkillPoint = PinballTools.CalcRoleProp(arg_3_1, 4)
	var_3_1.skillPoint = PinballTools.CalcRoleProp(arg_3_1, 6)
	var_3_1.skillPointRestore = PinballTools.CalcRoleProp(arg_3_1, 5)

	local var_3_4 = {}
	local var_3_5 = PinballData:GetExraEquipSkill()

	for iter_3_0, iter_3_1 in ipairs(var_3_5) do
		local var_3_6 = PinballSkillCfg.SkillCfgEx[iter_3_1]

		table.insert(var_3_4, var_3_6)
	end

	var_3_1.skillList = var_3_4

	local var_3_7 = PinballStageCfg[arg_3_0]
	local var_3_8, var_3_9 = var_0_0.GetChallengeWaveList(arg_3_0)

	var_0_0.ChallengeWaveList = var_3_8
	var_0_0.ChallengeBoardList = var_3_9
	var_3_3.stageIDList = var_3_9
	var_3_3.stageData = Asset.Load("PinballGame/StageData/PinBallGameStage_" .. var_3_9[1])
	var_3_3.challengeRound = GameSetting.marbles_play_challenge_round.value[1]
	var_3_3.debateOverflowDamageToSkillPointRate = GameSetting.pinball_game_debate_overflow_damage_to_skill_point_rate.value[1]
	var_3_3.debateSuccessScore = GameSetting.pinball_game_debate_success_score.value[1]
	var_3_3.debateLoseScore = GameSetting.pinball_game_debate_lose_score.value[1]

	for iter_3_2, iter_3_3 in ipairs(var_3_8) do
		if type(iter_3_3) == "table" then
			iter_3_3 = iter_3_3[1]
		end

		local var_3_10 = PinballWaveCfg[iter_3_3]
		local var_3_11 = {}

		for iter_3_4, iter_3_5 in ipairs(var_3_10.wellen_monster_list) do
			local var_3_12 = PinballPlayerCfg[iter_3_5]
			local var_3_13 = PinballRoleBattleData.New()

			var_3_13.model = var_3_12.model
			var_3_13.maxHealth = var_3_12.base_attributes[1]
			var_3_13.health = var_3_12.base_attributes[1]
			var_3_13.attack = var_3_12.base_attributes[2]
			var_3_13.abilityPower = var_3_12.base_attributes[3]
			var_3_13.maxSkillPoint = var_3_12.base_attributes[4]
			var_3_13.skillPoint = var_3_12.base_attributes[6]
			var_3_13.skillPointRestore = var_3_12.base_attributes[5]
			var_3_13.actionTimes = var_3_12.action_times

			local var_3_14 = {}

			for iter_3_6, iter_3_7 in ipairs(var_3_12.skill_list) do
				local var_3_15 = PinballSkillCfg.SkillCfgEx[iter_3_7[1]]
				local var_3_16 = PinballRoleSkillData.New()

				var_3_16.sType = var_3_15.sType
				var_3_16.sValue = var_3_15.sValue
				var_3_16.cooldown = var_3_15.cooldown
				var_3_16.remainCD = var_3_15.remainCD
				var_3_16.icon = var_3_15.icon
				var_3_16.animName = var_3_15.animName
				var_3_16.effectName = var_3_15.effectName
				var_3_16.desc = GetI18NText(var_3_15.desc)
				var_3_16.name = GetI18NText(var_3_15.name)
				var_3_16.level = var_3_15.level
				var_3_16.weight = iter_3_7[2]

				table.insert(var_3_14, var_3_16)
			end

			var_3_13.skillList = var_3_14

			table.insert(var_3_11, var_3_13)
		end

		table.insert(var_3_2, var_3_11)
	end

	PinballBridge.UpgradeStageParamsFromCfg(var_3_3.stageData)

	var_3_0.enemyDataList = TableTo2DArray(var_3_2, PinballRoleBattleData)

	PinballBridge:EnterPlay()
end

function var_0_0.GetChallengeWaveList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = PinballStageCfg[arg_4_0].wellen_id
	local var_4_3 = PinballWaveCfg.get_id_list_by_challenge_general_wellen_id

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		if iter_4_0 >= 1 then
			local var_4_4 = false
			local var_4_5 = 0
			local var_4_6 = 100

			while not var_4_4 and var_4_5 < var_4_6 do
				var_4_5 = var_4_5 + 1

				local var_4_7 = iter_4_1[math.random(1, #iter_4_1)]

				if table.indexof(var_4_2, var_4_7) then
					local var_4_8 = PinballWaveCfg[var_4_7].board_id[math.random(1, #PinballWaveCfg[var_4_7].board_id)]

					table.insert(var_4_0, var_4_7)
					table.insert(var_4_1, var_4_8)

					var_4_4 = true
				end
			end

			if not var_4_4 then
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

function var_0_0.InitFromServer(arg_9_0)
	PinballData.activityID = 3840801
	PinballData.stageInfo = {}

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.stage_list) do
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
		local var_9_2 = table.indexof(var_9_1, var_9_0[1]) or 0

		PinballData:SetLastEnterStageCategory(var_9_1[math.min(#var_9_1, var_9_2 + 1)])
	end

	PinballData:SetUnlockSkillList(arg_9_0.skills)
	PinballData:SetRoleLevel(arg_9_0.hai_la_level)
	PinballData:SetExtraEquipSkill(arg_9_0.select_active_skills)
	PinballData:SetMaxChallengeScore(arg_9_0.challenge_score)
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
	local var_13_0 = var_0_0.PlayingStageID

	manager.net:SendWithLoadingNew(89402, {
		stage_id = var_13_0,
		score = arg_13_0 or 0,
		harm = arg_13_1 or 0
	}, 89403, function(arg_14_0, arg_14_1)
		var_0_0.OnSendLevelFinish(arg_14_0, arg_14_1, arg_13_2)
	end)
end

function var_0_0.OnSendLevelFinish(arg_15_0, arg_15_1, arg_15_2)
	if isSuccess(arg_15_0.result) then
		if arg_15_2 then
			arg_15_2()
		end

		if arg_15_1.stage_id == PinballData:GetChallengeStageID() then
			return
		end

		local var_15_0 = PinballData:GetDisplayStageList()
		local var_15_1 = table.indexof(var_15_0, arg_15_1.stage_id)
		local var_15_2 = var_15_0[math.min(#var_15_0, var_15_1 + 1)]

		PinballData:SetLastEnterStageCategory(var_15_2)
		PinballData:SetLastPassStage(arg_15_1.stage_id)
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.SendMessageDataToSDK(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9, arg_16_10, arg_16_11)
	local var_16_0 = PinballData:GetEquipedActiveSkill()
	local var_16_1 = {}

	for iter_16_0 = 0, arg_16_10.Count - 1 do
		table.insert(var_16_1, {
			sequence_id = arg_16_10[iter_16_0].sequence_id,
			is_special = arg_16_10[iter_16_0].is_special,
			battle_times = arg_16_10[iter_16_0].battle_times + 1,
			hit_num = arg_16_10[iter_16_0].hit_num,
			remove_num = arg_16_10[iter_16_0].remove_num,
			skill_num = "[{" .. (var_16_0[1] or 0) .. "," .. arg_16_10[iter_16_0].activeSkillUseCount[0] .. "}," .. "{" .. (var_16_0[2] or 0) .. "," .. arg_16_10[iter_16_0].activeSkillUseCount[1] .. "}]",
			different_skill_num = arg_16_10[iter_16_0].different_skill_num,
			battle_hurt = "[" .. arg_16_10[iter_16_0].enemyHurt .. "," .. arg_16_10[iter_16_0].affectHurt .. "]",
			boss_num = arg_16_10[iter_16_0].leftEnemyCount,
			boss_hp = arg_16_10[iter_16_0].leftEnemyWaveHp,
			hero_hp = arg_16_10[iter_16_0].leftPlayerHp,
			progress = arg_16_10[iter_16_0].debateProgress,
			result = arg_16_10[iter_16_0].debateResult,
			use_seconds = math.floor(arg_16_10[iter_16_0].useSceond)
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = PinballData:GetActivityID(),
		stage_id = var_0_0.PlayingStageID,
		result = arg_16_6,
		use_seconds = math.floor(arg_16_7),
		sequence_id = arg_16_8,
		battle_times = arg_16_0 + 1,
		hero_list = "{{ id =" .. var_0_0.PlayingRoleID .. ",level = " .. PinballData:GetRoleLevel(var_0_0.PlayingRoleID) .. "}}",
		skill_num = {
			{
				var_16_0[1] or 0,
				arg_16_9[0]
			},
			{
				var_16_0[2] or 0,
				arg_16_9[1]
			}
		},
		hero_hp = arg_16_1,
		score = arg_16_11,
		other_arrayobject = var_16_1
	})
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
	local var_19_0 = PinballData:GetActivityID()

	manager.net:SendWithLoadingNew(89404, {
		activity_id = var_19_0,
		skill_list = arg_19_0
	}, 89405, var_0_0.OnSendEquipExtraSkillFinish)
end

function var_0_0.OnSendEquipExtraSkillFinish(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		PinballData:SetExtraEquipSkill(arg_20_1.skill_list)
		manager.notify:CallUpdateFunc(PINBALL_EQUIP_SKILL)
	else
		ShowTips(arg_20_0.result)
	end
end

function var_0_0.OpenBattle(arg_21_0)
	var_0_0.PlayingStageID = arg_21_0

	local var_21_0 = PinballStageCfg[arg_21_0]

	if not var_21_0 then
		return
	end

	local var_21_1 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.HELLA_PINBALL_BATTLE, var_21_0.barrier_id, {
		stageID = arg_21_0
	})

	if not var_21_1 then
		return
	end

	BattleController.GetInstance():LaunchBattle(var_21_1)
end

function var_0_0.InitRedPoint()
	local var_22_0 = PinballData:GetActivityID()
	local var_22_1 = RedPointConst.HELLA_PINBALL_ACTIVITY_MAIN .. var_22_0
	local var_22_2 = RedPointConst.HELLA_PINBALL_FIRST_ENTER .. var_22_0
	local var_22_3 = RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_22_0
	local var_22_4 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_22_0)
	local var_22_5 = ActivityCfg[var_22_0].sub_activity_list[2]
	local var_22_6 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, var_22_5)
	local var_22_7 = ActivityCfg[var_22_5]
	local var_22_8 = {}

	for iter_22_0, iter_22_1 in ipairs(var_22_7.sub_activity_list) do
		local var_22_9 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_22_1)

		table.insert(var_22_8, var_22_9)
	end

	manager.redPoint:addGroup(var_22_6, var_22_8)
	manager.redPoint:addGroup(var_22_1, {
		var_22_2,
		var_22_4,
		var_22_6
	})
end

function var_0_0.UpdateStageRedPoint()
	local var_23_0 = PinballData:GetActivityID()
	local var_23_1 = RedPointConst.HELLA_PINBALL_NEW_UNLOCK_SKILL .. var_23_0

	manager.redPoint:setTip(var_23_1, 0)

	for iter_23_0, iter_23_1 in ipairs(PinballSkillCfg.get_id_list_by_activity_id_skill_type[var_23_0][1]) do
		if PinballData:IsSkillNew(iter_23_1) then
			manager.redPoint:setTip(var_23_1, 1)

			break
		end
	end

	local var_23_2 = RedPointConst.HELLA_PINBALL_FIRST_ENTER .. var_23_0

	if not getData("PinballGame", "firstEnter") then
		manager.redPoint:setTip(var_23_2, 1)
	else
		manager.redPoint:setTip(var_23_2, 0)
	end
end

return var_0_0
