local var_0_0, var_0_1 = pcall(require, "bit")

if not var_0_0 then
	local var_0_2

	var_0_2, var_0_1 = pcall(require, "bit32")
end

local function var_0_3()
	if not manager.ui.mainCamera:GetComponent("CinemachineBrain") then
		local var_1_0 = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", true)
	manager.ui.mainCamera:AddComponent(typeof(Physics2DRaycaster))

	manager.ui.mainCamera:GetComponent("Physics2DRaycaster").eventMask = var_0_1.band(UnityEngine.Physics.DefaultRaycastLayers, var_0_1.bnot(LayerMask.GetMask("UI"), LayerMask.GetMask("Ignore Raycast")))
end

local function var_0_4()
	manager.ui:SetMainCameraCom("CinemachineBrain", false)

	local var_2_0 = manager.ui.mainCamera:GetComponent(typeof(Physics2DRaycaster))

	if var_2_0 ~= nil then
		Object.Destroy(var_2_0)
	end
end

function LaunchBilliardGame(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 0
	local var_3_1 = false

	if arg_3_1 == SummerPubLevelCfg[arg_3_0].stage_id[1] then
		var_3_1 = true
		var_3_0 = SummerPubData:GetClearNumByStageID(arg_3_0, 1)
	end

	local function var_3_2()
		BilliardGameMgr:BuildContext(arg_3_0, arg_3_1, arg_3_2[1], arg_3_2[2], arg_3_2[3])
		BilliardGameLuaBridge.EntraceLauncher(arg_3_1, arg_3_2[1], arg_3_2[2], arg_3_2[3])
	end

	if SummerPubLevelCfg[arg_3_0].pre_story_id ~= 0 and var_3_1 and var_3_0 == 0 then
		manager.story:StartStoryById(SummerPubLevelCfg[arg_3_0].pre_story_id, function(arg_5_0)
			var_3_2()
		end)
	else
		var_3_2()
	end
end

function LaunchBilliardGame_5_1(arg_6_0, arg_6_1)
	local function var_6_0()
		BilliardGameMgr:BuildVehicleContext(arg_6_0, arg_6_1)
		BilliardGameLuaBridge.EntraceLauncher(arg_6_0, arg_6_1)
	end

	if MergeBallStageCfg[arg_6_0].pre_story and MergeBallStageCfg[arg_6_0].pre_story ~= 0 then
		manager.story:StartStoryById(MergeBallStageCfg[arg_6_0].pre_story, function(arg_8_0)
			var_6_0()
		end)
	else
		var_6_0()
	end
end

function OnBilliardGameEnter()
	BilliardGameMgr:EnterGame()
end

function OnBilliardGameLoaded()
	gameContext:SetSystemLayer("battle")
	BilliardGameMgr:OnGameSceneLoaded()
end

function OnBilliardGameReady()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()
	var_0_3()
	OpenBilliardGameMainUI()
end

function OpenBilliardGameMainUI()
	if BilliardGameMgr:GetGameType() == BilliardGameConst.GameType.BALL then
		JumpTools.OpenPageByJump("/billiardGameMainView")
	else
		JumpTools.OpenPageByJump("/billiardGameMainView_5_1")
	end
end

function BilliardBattleNeedJumpToCook(arg_13_0)
	if arg_13_0 then
		local var_13_0 = BilliardGameMgr:GetStageId()
		local var_13_1 = 0
		local var_13_2 = false

		if var_13_0 == SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].stage_id[1] then
			var_13_2 = true
			var_13_1 = SummerPubData:GetClearNumByStageID(BilliardGameMgr:GetLevelId(), 1)
		end

		if not BilliardStageCfg[var_13_0].monster_unlock then
			-- block empty
		end

		if var_13_1 == 0 and var_13_2 then
			local var_13_4 = SummerPubLevelCfg[BilliardGameMgr:GetLevelId()]

			return var_13_4.auto_jump_screen ~= "", var_13_4.drop_lib_id ~= 0, var_13_4.drop_lib_id
		end
	end

	return false
end

function OnExitBilliardBattle(arg_14_0)
	local var_14_0 = SummerPubLevelCfg[BilliardGameMgr:GetLevelId()]
	local var_14_1 = 0
	local var_14_2 = false

	if BilliardGameMgr:GetStageId() == var_14_0.stage_id[1] then
		var_14_2 = true
		var_14_1 = SummerPubData:GetClearNumByStageID(BilliardGameMgr:GetLevelId(), 1)
	end

	local function var_14_3()
		if SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen ~= "" and SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen[2] == 1 then
			LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Night)
			SummerPubData:SetTimeState(2)

			if SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.STAGE_SEA then
				OpenPageUntilLoaded("/summerPubStageView")
			elseif SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.COOK then
				OpenPageUntilLoaded("summerCookMenuView", {
					dishIndex = SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen[3]
				})
			elseif SummerPubLevelCfg[BilliardGameMgr:GetLevelId()].auto_jump_screen[1] == SummerPubConst.AUTO_JUMP_TYPE.MAIN then
				OpenPageUntilLoaded("/summerPubEnterView")
			end
		else
			OpenPageUntilLoaded("/summerPubStageView")
			LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
		end
	end

	if var_14_1 == 1 and var_14_2 then
		if BilliardGameMgr:GetLevelId() == BilliardGameConst.FirstLevelId and var_14_0.next_unlock_id_list[1] then
			manager.ui:SetCanvasAlpha(0)
			SummerPubData:SetStageAreaIndex(var_14_0.next_unlock_id_list[1])
			LaunchBilliardGame(var_14_0.next_unlock_id_list[1], SummerPubLevelCfg[var_14_0.next_unlock_id_list[1]].stage_id[1], BilliardGameMgr:GetHero())
		elseif var_14_0.post_story_id ~= 0 then
			manager.ui:SetMainCameraCom("CinemachineBrain", false)

			manager.ui.mainCameraCom_.orthographic = false

			manager.story:StartStoryById(var_14_0.post_story_id, function(arg_16_0)
				manager.ui:SetCanvasAlpha(0)
				var_14_3()
			end)
		else
			manager.ui:SetCanvasAlpha(0)
			var_14_3()
		end
	elseif var_14_2 and var_14_0.post_story_id ~= 0 then
		manager.ui:SetMainCameraCom("CinemachineBrain", false)

		manager.ui.mainCameraCom_.orthographic = false

		manager.story:StartStoryById(var_14_0.post_story_id, function(arg_17_0)
			manager.ui:SetCanvasAlpha(0)
			LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
		end)
	else
		manager.ui:SetCanvasAlpha(0)
		LuaExchangeHelper.GoToMain(CustomLoadingConst.BilliardGame_Loading)
	end
end

function OnExitVehiclBilliardBattle(arg_18_0)
	local var_18_0 = MergeBallStageCfg[BilliardGameMgr:GetStageId()]

	if arg_18_0 and var_18_0.post_story and var_18_0.post_story ~= 0 then
		manager.ui:SetMainCameraCom("CinemachineBrain", false)

		manager.ui.mainCameraCom_.orthographic = false

		manager.story:StartStoryById(var_18_0.post_story, function(arg_19_0)
			manager.ui:SetCanvasAlpha(0)
			LuaExchangeHelper.GoToMain()
		end)
	else
		manager.ui:SetCanvasAlpha(0)
		LuaExchangeHelper.GoToMain()
	end
end

function OnBilliardGameExit()
	gameContext:SetSystemLayer("home")
	BilliardGameMgr:ExitGame()
	var_0_4()
	DestroyLua()
end

function GetPlayerData()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(SummerPubHeroCfg.all) do
		if SummerPubHeroCfg[iter_21_1].type ~= 2 then
			if SummerPubHeroCfg[iter_21_1].type == 3 then
				local var_21_1 = {
					id = iter_21_1,
					name = GetI18NText(SummerPubHeroCfg[iter_21_1].hero_name),
					baseHP = SummerPubHeroCfg[iter_21_1].base_attribute[2],
					baseAttack = SummerPubHeroCfg[iter_21_1].base_attribute[1],
					baseSpeed = SummerPubHeroCfg[iter_21_1].base_attribute[3],
					baseCollide = SummerPubHeroCfg[iter_21_1].base_attribute[4],
					hero_skill_image = SummerPubHeroCfg[iter_21_1].hero_skill_image,
					hero_head_image = SummerPubHeroCfg[iter_21_1].profile_icon_head,
					hero_ball_image = SummerPubHeroCfg[iter_21_1].profile_icon_ball,
					passive_skill = BilliardSkillCfg[SummerPubHeroCfg[iter_21_1].skill].passive_skill,
					active_skill = BilliardSkillCfg[SummerPubHeroCfg[iter_21_1].skill].active_skill,
					skill_cd = BilliardSkillCfg[SummerPubHeroCfg[iter_21_1].skill].cd
				}

				var_21_1.cost = BilliardSkillCfg[SummerPubHeroCfg[iter_21_1].skill].cost
				var_21_1.hero_type = SummerPubHeroCfg[iter_21_1].pinball_hero_type

				table.insert(var_21_0, var_21_1)
			end
		end
	end

	return var_21_0
end

function GetVehiclePlayerData()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(MergeBallVehicleCfg.get_id_list_by_type[BilliardGameConst.VehicleType.VEHICLE]) do
		table.insert(var_22_0, {
			cost = 0,
			active_skill = 0,
			skill_cd = 0,
			hero_type = 4,
			hero_skill_image = "",
			id = iter_22_1,
			name = GetI18NText(MergeBallVehicleCfg[iter_22_1].name),
			baseHP = MergeBallVehicleCfg[iter_22_1].param[2],
			baseAttack = MergeBallVehicleCfg[iter_22_1].param[1],
			baseSpeed = MergeBallVehicleCfg[iter_22_1].param[3],
			baseCollide = MergeBallVehicleCfg[iter_22_1].param[4],
			hero_head_image = MergeBallVehicleCfg[iter_22_1].icon,
			hero_ball_image = MergeBallVehicleCfg[iter_22_1].icon_small,
			passive_skill = MergeBallVehicleCfg[iter_22_1].passive_skill
		})
	end

	return var_22_0
end

function GetEntityData()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(BilliardIllustrationsCfg.all) do
		if BilliardIllustrationsCfg[iter_23_1].type == 1 or BilliardIllustrationsCfg[iter_23_1].type == 2 then
			local var_23_3 = {
				baseAttack = 0,
				hpBarType = 0,
				baseHP = 0,
				id = iter_23_1,
				activityId = BilliardIllustrationsCfg[iter_23_1].activity_id,
				type = BilliardIllustrationsCfg[iter_23_1].type,
				name = GetI18NText(BilliardIllustrationsCfg[iter_23_1].name),
				desc = GetI18NText(BilliardIllustrationsCfg[iter_23_1].desc),
				skillDesc = GetI18NText(BilliardIllustrationsCfg[iter_23_1].skill_desc),
				littleIcon = BilliardIllustrationsCfg[iter_23_1].little_icon,
				icon = BilliardIllustrationsCfg[iter_23_1].icon,
				skillId = BilliardSkillCfg[BilliardIllustrationsCfg[iter_23_1].skill].passive_skill
			}

			if BilliardIllustrationsCfg[iter_23_1].attribute_factor and BilliardIllustrationsCfg[iter_23_1].attribute_factor ~= "" then
				var_23_3.baseHP = BilliardIllustrationsCfg[iter_23_1].attribute_factor[2]
				var_23_3.baseAttack = BilliardIllustrationsCfg[iter_23_1].attribute_factor[1]
			end

			table.insert(var_23_0, var_23_3)
		end
	end

	return var_23_0
end

function GetVehicleEntityData()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(MergeBallMonsterCfg.all) do
		table.insert(var_24_0, {
			skillDesc = "",
			name = "",
			type = 1,
			desc = "",
			littleIcon = "",
			activityId = 0,
			id = iter_24_1,
			icon = MergeBallMonsterCfg[iter_24_1].icon,
			skillId = MergeBallMonsterCfg[iter_24_1].skill_id,
			baseAttack = MergeBallMonsterCfg[iter_24_1].attack,
			baseHP = MergeBallMonsterCfg[iter_24_1].health,
			hpBarType = MergeBallMonsterCfg[iter_24_1].hp_type
		})
	end

	for iter_24_2, iter_24_3 in ipairs(BilliardIllustrationsCfg.all) do
		if BilliardIllustrationsCfg[iter_24_3].type == 1 or BilliardIllustrationsCfg[iter_24_3].type == 2 then
			local var_24_1 = {
				baseAttack = 0,
				hpBarType = 0,
				baseHP = 0,
				id = iter_24_3,
				activityId = BilliardIllustrationsCfg[iter_24_3].activity_id,
				type = BilliardIllustrationsCfg[iter_24_3].type,
				name = GetI18NText(BilliardIllustrationsCfg[iter_24_3].name),
				desc = GetI18NText(BilliardIllustrationsCfg[iter_24_3].desc),
				skillDesc = GetI18NText(BilliardIllustrationsCfg[iter_24_3].skill_desc),
				littleIcon = BilliardIllustrationsCfg[iter_24_3].little_icon,
				icon = BilliardIllustrationsCfg[iter_24_3].icon,
				skillId = BilliardSkillCfg[BilliardIllustrationsCfg[iter_24_3].skill].passive_skill
			}

			if BilliardIllustrationsCfg[iter_24_3].attribute_factor and BilliardIllustrationsCfg[iter_24_3].attribute_factor ~= "" then
				var_24_1.baseHP = BilliardIllustrationsCfg[iter_24_3].attribute_factor[2]
				var_24_1.baseAttack = BilliardIllustrationsCfg[iter_24_3].attribute_factor[1]
			end

			table.insert(var_24_0, var_24_1)
		end
	end

	return var_24_0
end

function GetStageData()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(BilliardStageCfg.all) do
		table.insert(var_25_0, {
			id = iter_25_1,
			type = BilliardStageCfg[iter_25_1].type,
			winType = BilliardStageCfg[iter_25_1].victory_condition_type,
			winCondition = BilliardStageCfg[iter_25_1].victory_condition,
			monsterAttribute = BilliardStageCfg[iter_25_1].attribute_factor,
			monsterUnlockID = BilliardStageCfg[iter_25_1].monster_unlock,
			skillPoint = BilliardStageCfg[iter_25_1].skill_point_each_turn
		})
	end

	return var_25_0
end

function GetVehicleStageData()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(MergeBallStageCfg.all) do
		table.insert(var_26_0, {
			type = 1,
			skillPoint = 0,
			id = iter_26_1,
			winType = MergeBallStageCfg[iter_26_1].victory_condition_type,
			winCondition = MergeBallStageCfg[iter_26_1].victory_condition,
			monsterAttribute = {
				100,
				100
			},
			monsterUnlockID = {}
		})
	end

	return var_26_0
end

function GetBilliardBuffData()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(BilliardBuffCfg.all) do
		table.insert(var_27_0, {
			id = iter_27_1,
			desc = BilliardBuffCfg[iter_27_1].buff_desc,
			icon = BilliardBuffCfg[iter_27_1].buff_icon
		})
	end

	return var_27_0
end

function GetBilliardVehicleBuffData()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(MergeBallBuffCfg.all) do
		table.insert(var_28_0, {
			id = iter_28_1,
			desc = MergeBallBuffCfg[iter_28_1].desc,
			icon = MergeBallBuffCfg[iter_28_1].icon
		})
	end

	return var_28_0
end

function GetInitFood()
	if GameSetting.nya_summer_pinball_initial_energy.value[1] then
		return GameSetting.nya_summer_pinball_initial_energy.value[1]
	end

	return 3
end

function GetBilliardGameCriticalSpeed()
	local var_30_0 = {
		GameSetting.nya_summer_pinball_critical_speed.value[1],
		GameSetting.nya_summer_pinball_critical_speed.value[2],
		GameSetting.nya_summer_pinball_critical_speed.value[3],
		GameSetting.nya_summer_pinball_critical_speed.value[4]
	}

	if var_30_0 then
		return var_30_0
	end

	return {
		0.4,
		8,
		1.2,
		5
	}
end

function GetMonsterHpRatio(arg_31_0)
	if BilliardGameMgr:GetGameType() == BilliardGameConst.GameType.BALL then
		return {
			1
		}
	else
		return GameSetting.mergeball_monster_health_multiply.value
	end
end

function GetPointerRoteteParams()
	return GameSetting.mergeball_combo_angle.value[1], GameSetting.mergeball_combo_angle.value[2], GameSetting.mergeball_combo_angle.value[3]
end

local function var_0_5(arg_33_0)
	local var_33_0 = {}

	for iter_33_0 = 0, arg_33_0.Count - 1 do
		table.insert(var_33_0, arg_33_0[iter_33_0])
	end

	return var_33_0
end

function SendBilliardMessage(arg_34_0)
	if not arg_34_0 then
		return
	end

	local var_34_1 = {}

	for iter_34_0, iter_34_1 in ipairs((var_0_5(arg_34_0.heroInfoList))) do
		table.insert(var_34_1, {
			iter_34_1.id,
			iter_34_1.startHp,
			iter_34_1.endHp
		})
	end

	local var_34_2 = {}

	for iter_34_2, iter_34_3 in ipairs((var_0_5(arg_34_0.monsterInfoList))) do
		table.insert(var_34_2, {
			iter_34_3.id,
			iter_34_3.startHp,
			iter_34_3.endHp
		})
	end

	local var_34_3 = {}

	for iter_34_4, iter_34_5 in ipairs((var_0_5(arg_34_0.skillList))) do
		table.insert(var_34_3, {
			iter_34_5.id,
			iter_34_5.useNum,
			iter_34_5.useRound
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityConst.ACTIVITY_NYA_SUMMER_PUB,
		stage_id = arg_34_0.stageID,
		hard = arg_34_0.hard,
		result = arg_34_0.result,
		use_seconds = arg_34_0.use_seconds,
		hero_list = table.toString(var_34_1),
		boss_hp_list = table.toString(var_34_2),
		other_data = string.format("[%s, %s, %s]", arg_34_0.potHp, arg_34_0.potDamage, arg_34_0.potRegeneration),
		battle_times = arg_34_0.roundNum,
		skill_list = table.toString(var_34_3)
	})
end

function SendBilliardMessage_5_1(arg_35_0)
	if not arg_35_0 then
		return
	end

	local var_35_1 = {}

	for iter_35_0, iter_35_1 in ipairs((var_0_5(arg_35_0.heroInfoList))) do
		table.insert(var_35_1, {
			iter_35_1.id,
			iter_35_1.startHp,
			iter_35_1.endHp
		})
	end

	local var_35_2 = {}

	for iter_35_2, iter_35_3 in ipairs((var_0_5(arg_35_0.monsterInfoList))) do
		table.insert(var_35_2, {
			iter_35_3.id,
			iter_35_3.startHp,
			iter_35_3.endHp
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		stage_id = arg_35_0.stageID,
		start_time = arg_35_0.start_seconds,
		result = arg_35_0.result,
		use_seconds = arg_35_0.use_seconds,
		hero_list = table.toString(var_35_1),
		boss_hp_list = table.toString(var_35_2),
		other_data = otherStr,
		battle_times = arg_35_0.roundNum,
		buff_list = table.toString(BilliardGameMgr:GetAllSelectBuffList()),
		extra_data = table.toString(BilliardGameMgr:GetLevelUpedSkillList())
	})
end

function OnBilliardGameOver(arg_36_0, arg_36_1)
	if BilliardGameMgr:IsInBilliardGame() then
		local var_36_0 = BilliardGameMgr:GetStageId()

		BilliardGameMgr:OverGame()
		manager.notify:Invoke(BilliardGameEvent.SET_BOTTOM_INFO_GO_ACTIVE, false)

		if BilliardGameMgr:GetGameType() == BilliardGameConst.GameType.BALL then
			SendBilliardMessage(arg_36_1)
			SummerPubAction.finishPinBall(BilliardGameMgr:GetLevelId(), var_36_0, BilliardStageCfg[var_36_0].monster_unlock or {}, arg_36_0)
			JumpTools.OpenPageByJump("billiardBattleResultView", {
				victory = arg_36_0
			})
		else
			local var_36_1 = VehicleBallData:GetPassedStageList()

			SendBilliardMessage_5_1(arg_36_1)
			VehicleBallAction.PassVehicleStage({
				stageId = var_36_0,
				kvList = {
					{
						key = BilliardGameConst.KvType.KILL_MONSTER,
						value = BilliardGameMgr:GetKillMonsterCount()
					},
					{
						key = BilliardGameConst.KvType.MERGE_SKILL,
						value = BilliardGameMgr:GetMergeSkillCount()
					}
				},
				buffs = BilliardGameMgr:GetNewBuffUnlockList(),
				isPass = arg_36_0
			})
			JumpTools.OpenPageByJump("billiardBattleVehicleOverView", {
				stageId = var_36_0,
				victory = arg_36_0,
				passedStageList = var_36_1
			})
		end
	end
end

function OnBilliardGameShowHeroInfoUI(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	manager.notify:Invoke(BilliardGameEvent.BILLIARD_HERO_INFO, arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
end

function OnStageConditionFinish(arg_38_0)
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	manager.notify:Invoke(BilliardGameEvent.BILLIARD_CONDITION_FINISH, arg_38_0)
end

function OnVehicleInjured(arg_39_0)
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	manager.notify:Invoke(BilliardGameEvent.BILLIARD_VEHICLE_INJURED, arg_39_0)
end

function OnBilliardGameMonsterDead(arg_40_0)
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	manager.notify:Invoke(BilliardGameEvent.BILLIARD_MONSTER_DEAD, arg_40_0)
end

function OnBilliardGamePlayerRoundBegin()
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	BilliardGameMgr:OnRoundBegin()
	manager.notify:Invoke(BilliardGameEvent.BILLIARD_PLAYER_ROUND_BEGIN)
end

function OnBilliardGameRoundOver()
	if not BilliardGameMgr:IsInBilliardGame() then
		return
	end

	manager.notify:Invoke(BilliardGameEvent.BILLIARD_GAME_ROUND_OVER)
end

function OnFeedbackMergeProcess(arg_43_0)
	manager.notify:Invoke(BilliardGameEvent.MERGE_PROCESS_FEEDBACK, arg_43_0)
end

function OnBilliardGameMapMagnify()
	manager.notify:Invoke(BilliardGameEvent.MAGNIFY_EFFECT)
end

function OnBilliardGameDragStateChange(arg_45_0)
	manager.notify:Invoke(BilliardGameEvent.DRAG_STATE, arg_45_0)
end
