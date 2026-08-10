local var_0_0 = singletonClass("BattleController")
local var_0_1

function var_0_0.GetBattleStageData(arg_1_0)
	return var_0_1
end

function var_0_0.SetBattleStageData(arg_2_0, arg_2_1)
	var_0_1 = arg_2_1
end

function var_0_0.LaunchBattle(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	WaitStartBattle = nil

	local var_3_0 = arg_3_1:GetType()
	local var_3_1 = arg_3_1:GetDest()
	local var_3_2 = arg_3_1:GetMultiple()
	local var_3_3, var_3_4 = manager.assetPend:CheckLauncherBattle(var_3_0, var_3_1)

	if not var_3_3 then
		manager.assetPend:ShowAssetPendMessageBox(var_3_4)

		return
	end

	local var_3_5, var_3_6 = arg_3_1:GetHeroTeam()
	local var_3_7 = arg_3_1:GetAssistHeroOwnerList()
	local var_3_8 = clone(var_3_5)
	local var_3_9 = clone(var_3_6)

	for iter_3_0 = #var_3_8, 1, -1 do
		if var_3_8[iter_3_0] == 0 then
			table.remove(var_3_8, iter_3_0)
			table.remove(var_3_9, iter_3_0)
		end
	end

	for iter_3_1 = 1, 2 do
		for iter_3_2 = iter_3_1 + 1, 3 do
			if var_3_8[iter_3_1] and var_3_8[iter_3_2] and var_3_8[iter_3_1] ~= 0 and var_3_8[iter_3_1] == var_3_8[iter_3_2] then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end
		end
	end

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == var_3_0 or BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == var_3_0 then
		var_3_8 = arg_3_1:GetSystemHeroTeam()

		local var_3_10 = var_3_8
	end

	if BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == var_3_0 or BattleConst.STAGE_TYPE_NEW.SEA_WARFARE == var_3_0 then
		LuaHidTools.ForceSelectKeyboard(HID_TYPES.Keyboard)
	end

	if BattleConst.STAGE_TYPE_NEW.ASH_BATTLE == var_3_0 then
		LuaHidTools.ForceSelectKeyboard(HID_TYPES.Keyboard)
	end

	local var_3_11 = arg_3_1:GetOpts()
	local var_3_12 = arg_3_1:GetComboSkillID() or 0
	local var_3_13 = arg_3_1:GetComboSkillLevel() or 0
	local var_3_14 = arg_3_1:GetSystemHeroTeam()
	local var_3_15 = {}

	for iter_3_3, iter_3_4 in ipairs(var_3_8) do
		var_3_15[iter_3_3] = {}

		if var_3_6[iter_3_3] ~= 0 and var_3_6[iter_3_3] ~= nil then
			var_3_15[iter_3_3].hero_type = 2
			var_3_15[iter_3_3].owner_id = BattleTeamData.NO_OWNER
			var_3_15[iter_3_3].hero_id = var_3_6[iter_3_3]
		elseif var_3_14[iter_3_3] ~= 0 and var_3_14[iter_3_3] ~= nil then
			var_3_15[iter_3_3].hero_type = 2
			var_3_15[iter_3_3].owner_id = BattleTeamData.NO_OWNER
			var_3_15[iter_3_3].hero_id = var_3_14[iter_3_3]
		else
			var_3_15[iter_3_3].hero_id = var_3_8[iter_3_3]
			var_3_15[iter_3_3].owner_id = var_3_7[iter_3_3] or BattleTeamData.NO_OWNER
			var_3_15[iter_3_3].hero_type = not BattleTeamData.IsValidOwner(var_3_15[iter_3_3].owner_id) and 1 or 3
		end
	end

	local var_3_16 = 0

	if arg_3_4 then
		var_3_16 = 1
	end

	local var_3_17 = {
		common_info = {
			hero_list = var_3_15,
			dest = var_3_1,
			activity_id = arg_3_1:GetActivityID() or 0,
			battle_times = var_3_2,
			type = var_3_0,
			index = arg_3_1:GetServerExtant(),
			cooperate_unique_skill_id = var_3_12,
			cooperate_unique_skill_level = var_3_13,
			battle_vs = LuaForUtil.GetBattleVersion(),
			mimir_info = {
				{
					mimir_id = arg_3_1:GetChipManagerID(),
					chip_list = arg_3_1:GetChipList(),
					hero_id = arg_3_1:GetCharChipBaseID(),
					hero_chip_list = arg_3_1:GetCharChipExtraIDList()
				}
			},
			opts = var_3_11 or {}
		},
		is_restarted_battle = var_3_16
	}

	manager.net:SendWithLoadingNew(54030, var_3_17, 54031, function(arg_4_0)
		if arg_3_3 then
			arg_3_3(arg_4_0)
		end

		if isSuccess(arg_4_0.result) then
			var_0_1 = arg_3_1

			manager.net:RegistPushWaiting(54007, function()
				return
			end)
		elseif arg_4_0.result == 2109 and BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == var_3_0 then
			ShowTips(300114)
		else
			if BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME == var_3_0 or BattleConst.STAGE_TYPE_NEW.SEA_WARFARE == var_3_0 then
				LuaHidTools.ForceSelectKeyboard(nil)
			end

			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.LaunchCooperationBattle(arg_6_0)
	manager.net:SendWithLoadingNew(37014, {}, 37015, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			WaitStartBattle = nil
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.LaunchCooperationBattleWithoutRoom(arg_8_0, arg_8_1)
	local var_8_0 = BattleStageFactory.Produce(arg_8_1.battle_type, arg_8_1.dest, {
		dest = arg_8_1.dest,
		activityID = arg_8_1.activity_id
	})

	BattleController.GetInstance():SetBattleStageData(var_8_0)
	var_8_0:UpdateRoleDatas()
	BattleFieldData:SetServerBattleParams(arg_8_1.battle_id, arg_8_1.server_ip, arg_8_1.server_port)
	BattleController.GetInstance():StartBattle(true)
end

function var_0_0.LaunchStoryBattle(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0, var_9_1 = manager.assetPend:CheckLauncherBattle(arg_9_1, arg_9_2)

	if not var_9_0 then
		manager.assetPend:ShowAssetPendMessageBox(var_9_1)

		return
	end

	manager.net:SendWithLoadingNew(54034, {
		stage_id = arg_9_2,
		activity_id = arg_9_3
	}, 54035, function(arg_10_0)
		if arg_9_4 then
			arg_9_4(arg_10_0)
		end

		if isSuccess(arg_10_0.result) then
			manager.story:CheckBattleStory(arg_9_2, manager.story.BEFORE, function()
				gameContext:Go("/blank")

				var_0_1 = BattleStageFactory.Produce(arg_9_1, arg_9_2, arg_9_3)

				var_0_1:SetIsStoryTag(true)

				local var_11_0 = arg_10_0.battle_id
				local var_11_1 = GetOldPlayerExp()

				manager.net:SendWithLoadingNew(54032, {
					battle_id = var_11_0
				}, 54033, function(arg_12_0, arg_12_1)
					manager.story:RemovePlayer()
					BattleFieldData:FinishBattle(arg_12_0)

					BattleCallLuaCallBackWait = false
					BattleCallLuaWaitLoading = false

					GotoTeam(var_11_0, arg_12_0.battle_result, arg_12_0.result, var_11_1)
				end)
			end, false)
		else
			ShowTips(arg_10_0.result)
			manager.story:RemovePlayer()
		end
	end)
end

function var_0_0.UpdateHeroTeam(arg_13_0, arg_13_1)
	if not var_0_1 then
		error("Loss Current BattleStageData In UpdateHeroTeam")

		return
	end

	var_0_1:UpdateRoleDatas(arg_13_1)
end

function var_0_0.StartBattle(arg_14_0, arg_14_1)
	if not var_0_1 then
		error("Loss Current BattleStageData In StartBattle")

		return
	end

	local var_14_0 = var_0_1
	local var_14_1 = BattleFieldData:GetServerBattleID()
	local var_14_2, var_14_3 = BattleFieldData:GetBattleServerIPAndPort()
	local var_14_4 = GetSceneDataForExcehange()

	var_14_4.masterSkill = GetMasterSkillDataForExcehange()
	var_14_4.masterSkill.ID = 1001
	var_14_4.masterSkill.attributeID = {}
	var_14_4.masterSkill.attributeValue = {}

	local var_14_5 = AdminSystemTools.HeroUsingSkinInfo(1001)

	var_14_4.masterSkill.masterSkinID = var_14_5
	var_14_4.masterSkill.masterSkillRenderLevel = SettingData:GetGameSettingValue("battle_play_type") or 1

	if var_14_0:GetCharChipBaseID() and var_14_0:GetCharChipBaseID() > 0 then
		local var_14_6 = ChipCfg[var_14_0:GetCharChipBaseID()].spec_char
		local var_14_7 = HeroTools.HeroUsingSkinInfo(var_14_6).id

		var_14_4.masterSkill.roleSkinID = var_14_7
		var_14_4.masterSkill.isVow = OathTools.IsOath(var_14_6)
	else
		var_14_4.masterSkill.roleSkinID = 0
		var_14_4.masterSkill.isVow = false
	end

	var_14_4.leftTime = var_14_0:GetBattleTime() * 1000

	local var_14_8, var_14_9, var_14_10 = var_14_0:GetBattleStageAffix()

	var_14_4.typeIDListAffix = var_14_8
	var_14_4.levelList = var_14_9
	var_14_4.enemyTypes = var_14_10

	local var_14_11, var_14_12 = var_14_0:GetMap()

	LuaExchangeHelper.SetNewbie(var_14_12)

	var_14_4.mSceneID = var_14_11

	local var_14_13, var_14_14, var_14_15, var_14_16, var_14_17 = var_14_0:GetRevive()

	var_14_4.needResurrect = var_14_13
	var_14_4.coinNumber = var_14_15
	var_14_4.coinConsume = var_14_16
	var_14_4.maxCoinNumber = var_14_17 or 0
	var_14_4.resurrectHP = var_14_0:GetResurrectHP()
	var_14_4.resurrectImmediately = var_14_0:GetResurrectImmediately()
	var_14_4.challengeFactor = var_14_0:GetMultiple()
	var_14_4.mMissionClearTimes = var_14_0:GetClearTime()
	var_14_4.difficulty = var_14_0:GetAILevel()
	var_14_4.adaptiveEnemyLevel = var_14_0:GetEnemyLevel()
	var_14_4.roleDataInLua = var_14_0:GetRoleDatas()

	local var_14_18 = var_14_0:GetAttributeFactor()

	var_14_4.attributeFactor = Int3.New(var_14_18.x * 1000, var_14_18.y * 1000, var_14_18.z * 1000)
	var_14_4.cooperateUniqueSkillID = var_14_0:GetComboSkillID()
	var_14_4.cooperateUniqueSkillLevel = var_14_0:GetComboSkillLevel()

	local var_14_19, var_14_20 = var_14_0:GetMaxRaceData()

	var_14_4.maxRaceID = var_14_19
	var_14_4.maxRacePlayerCount = var_14_20
	var_14_4.targetEnemyID = var_14_0:GetTargetEnemyID()

	LuaExchangeHelper.SetIPAndPort(var_14_2, var_14_3)

	var_14_4.battleID = var_14_1
	var_14_4.Uuid = PlayerData:GetPlayerInfo().userID
	var_14_4.isMultiplayer = arg_14_1
	var_14_4.nickName = PlayerData:GetPlayerInfo().nick
	var_14_4.VHLSkillID = var_14_0:GetActivityReforgeSkillList()
	var_14_4.VHLResult = var_14_0:GetBattleParams()
	var_14_4.customLoading = arg_14_0:GetCustomLoading(var_14_0)

	local var_14_21 = SettingData:GetSettingData()

	LuaExchangeHelper.SetPlayerQuality(var_14_21.pic.user_effect - 1)
	LuaExchangeHelper.SetAIQuality(var_14_21.pic.teammate_effect - 1)
	LuaExchangeHelper.SetCooperateUniqueSkillPlayControlledType(var_14_21.game.cus_full_play_controlled_type)

	if var_14_0:GetType() == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		LuaExchangeHelper.SetFriendQuality(getData("challenge_rogue_team", "hide_effect") or false)
	else
		LuaExchangeHelper.SetFriendQuality(false)
	end

	local var_14_22 = manager.time:GetServerTime()

	local function var_14_23()
		if manager.time:GetServerTime() - var_14_22 > 1500 then
			ConnectionHelper.ShowReturnToLoginTip()
			manager.story:RemovePlayer()

			return
		end

		arg_14_0:TryToStartBattle()
	end

	local var_14_24 = var_14_0:GetType()

	if var_14_24 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		manager.story:CheckChessBattleStory(manager.story.BEFORE, var_14_23)
	elseif var_14_24 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_14_24 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT or var_14_24 == BattleConst.STAGE_TYPE_NEW.SKULD then
		local var_14_25 = var_14_0:GetStageId()

		manager.story:CheckBattleStory(var_14_25, manager.story.BEFORE, var_14_23, false)
	else
		local var_14_26 = var_14_0:GetStageId()

		manager.story:CheckBattleStory(var_14_26, manager.story.BEFORE, var_14_23)
	end

	BattleCallLuaCallBackWait = true

	local var_14_27 = {
		scene_id = tostring(var_14_11),
		mission_clear_times = var_14_0:GetClearTime(),
		affix_id_list = var_14_8,
		affix_level_list = var_14_9,
		affix_target_list = var_14_10
	}
	local var_14_28 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0:GetRoleDatas()) do
		local var_14_29 = {
			uid = tostring(iter_14_1.UID),
			player_level = iter_14_1.playerLevel,
			hero_id = iter_14_1.ID,
			hero_level = iter_14_1.Level,
			attribute_id = arg_14_0:ParseArray(iter_14_1.attributeID)
		}
		local var_14_30 = arg_14_0:ParseArray(iter_14_1.attributeValue)

		var_14_29.attribute_value = {}

		for iter_14_2, iter_14_3 in ipairs(var_14_30) do
			iter_14_3 = tonumber(tostring(iter_14_3))

			table.insert(var_14_29.attribute_value, iter_14_3)
		end

		table.insert(var_14_29.attribute_id, BattleConst.ENTITY_VAR_NAME.ENTITY_ATTR_MAIN_DAMAGE_TYPE)
		table.insert(var_14_29.attribute_value, iter_14_1.mainDamageType)

		var_14_29.equip_skill_id = arg_14_0:ParseArray(iter_14_1.equipSkillID)
		var_14_29.equip_skill_level = arg_14_0:ParseArray(iter_14_1.equipSkillLv)
		var_14_29.astrolabe = arg_14_0:ParseArray(iter_14_1.astrolabe)
		var_14_29.equipment = arg_14_0:ParseArray(iter_14_1.equipment)
		var_14_29.skill_level = arg_14_0:ParseArray(iter_14_1.skillLevel)
		var_14_29.chip_list = arg_14_0:ParseArray(iter_14_1.AIChip)
		var_14_29.weapon_effect_id = iter_14_1.weaponEffectID
		var_14_29.weapon_effect_level = iter_14_1.weaponEffectLevel

		table.insert(var_14_28, var_14_29)
	end

	var_14_27.role_data = var_14_28
	var_14_27.attribute_factor = {
		var_14_18.x * 1000,
		var_14_18.y * 1000,
		var_14_18.z * 1000
	}
	var_14_27.cooperate_unique_skill_id = var_14_0:GetComboSkillID()
	var_14_27.cooperate_unique_skill_level = var_14_0:GetComboSkillLevel()
	var_14_27.need_resurrect = var_14_13
	var_14_27.coin_number = var_14_15
	var_14_27.coin_consume = var_14_16
	var_14_27.max_coin_number = var_14_17 or 0
	var_14_27.resurrect_hp = var_14_0:GetResurrectHP()
	var_14_27.resurrect_immediately = var_14_0:GetResurrectImmediately()
	var_14_27.difficulty = var_14_0:GetAILevel()
	var_14_27.adaptive_enemy_level = var_14_0:GetEnemyLevel()
	var_14_27.max_race_id = var_14_19
	var_14_27.max_race_player_count = var_14_20
	var_14_27.target_enemy_id = var_14_0:GetTargetEnemyID()
	var_14_27.battle_id = var_14_1
	var_14_27.uid = PlayerData:GetPlayerInfo().userID
	var_14_27.is_multi_player = arg_14_1 and true or false
	var_14_27.nick_name = PlayerData:GetPlayerInfo().nick
	var_14_27.vhl_skill_id = var_14_0:GetActivityReforgeSkillList()
	var_14_27.vhl_result = var_14_0:GetBattleParams()
	var_14_27.left_time = var_14_0:GetBattleTime() * 1000
	var_14_27.challenge_factor = var_14_0:GetMultiple()

	manager.net:Push(54300, var_14_27)
end

function var_0_0.GetCustomLoading(arg_16_0, arg_16_1)
	if arg_16_1:GetType() == BattleConst.STAGE_TYPE_NEW.ASH_BATTLE then
		return CustomLoadingConst.ASHGAME_Loading
	end

	return -1
end

function var_0_0.ParseArray(arg_17_0, arg_17_1)
	if arg_17_1 == nil then
		return {}
	end

	local var_17_0 = arg_17_1.Length - 1
	local var_17_1 = {}

	for iter_17_0 = 0, var_17_0 do
		table.insert(var_17_1, arg_17_1[iter_17_0])
	end

	return var_17_1
end

function var_0_0.TryToStartBattle(arg_18_0)
	SetForceShowQuanquan(true)
	LuaExchangeHelper.Launcher(GetSceneDataForExcehange(), function()
		SetForceShowQuanquan(false)
		manager.story:RemovePlayer()

		_G.BATTLE_SERVER_ERROR_TIME = 0

		DestroyLua()
		gameContext:SetSystemLayer("battle")
	end, function()
		gameContext:SetSystemLayer("battle")
	end)
end

function var_0_0.SetHeroData(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0
	local var_21_1

	if arg_21_2 and arg_21_2 ~= 0 then
		var_21_0, var_21_1 = GetVirtualData(arg_21_2)
	else
		var_21_0, var_21_1 = GetPracticalData(arg_21_1)
	end

	local var_21_2 = GetHeroFinalAttr(var_21_0, var_21_0.servantInfo, var_21_1, arg_21_2)
	local var_21_3, var_21_4, var_21_5 = HeroTools.CalTransitionSkillAttribute(var_21_0, var_21_1)
	local var_21_6 = RoleDataForExchange.New()

	var_21_6.UID = arg_21_3
	var_21_6.playerLevel = arg_21_4

	local var_21_7 = var_0_1:GetAssistHeroOwnerList()
	local var_21_8 = var_0_1:GetHeroTeam()
	local var_21_9 = table.indexof(var_21_8, var_21_0.id)

	if arg_21_2 and arg_21_2 ~= 0 then
		var_21_6.ID = HeroStandardSystemCfg[arg_21_2].skin_id
	elseif var_21_7 and var_21_7[var_21_9] then
		var_21_6.ID = arg_21_1.using_skin
	else
		var_21_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_21_0.id).id
	end

	var_21_6.Level = LvTools.CheckHeroExp(1, var_21_0.exp, HeroConst.HERO_LV_MAX)
	var_21_6.isVow = var_21_0:IsOath()

	local var_21_10 = {}
	local var_21_11 = {}

	for iter_21_0, iter_21_1 in pairs(var_21_2) do
		local var_21_12 = PublicAttrCfg[iter_21_0]

		if var_21_12 then
			table.insert(var_21_10, var_21_12.id)
			table.insert(var_21_11, iter_21_1)
		end
	end

	local var_21_13, var_21_14 = BattleTools.FixBattleAttributeListAndWeaponModule(var_21_10, var_21_11, var_21_0.using_skin, var_21_0.weapon_module_level)

	var_21_6.attributeValue, var_21_6.attributeID = var_21_14, var_21_13

	local var_21_15 = {}
	local var_21_16 = {}

	for iter_21_2, iter_21_3 in pairs(var_21_4) do
		table.insert(var_21_15, iter_21_2)
		table.insert(var_21_16, iter_21_3)
	end

	var_21_6.equipSkillID = var_21_15
	var_21_6.equipSkillLv = var_21_16

	local var_21_17 = {}
	local var_21_18 = AstrolabeTools.GetTotalEffect(var_21_0.using_astrolabe)

	for iter_21_4 = 1, 9 do
		var_21_17[iter_21_4] = var_21_18[iter_21_4] or 0
	end

	var_21_6.astrolabe = var_21_17

	local var_21_19 = {}
	local var_21_20 = EquipTools.GetEffectS(var_21_1, var_21_0)

	for iter_21_5, iter_21_6 in pairs(var_21_20) do
		table.insert(var_21_19, iter_21_5)
	end

	var_21_6.equipment = var_21_19

	local var_21_21 = {}
	local var_21_22 = HeroCfg[var_21_0.id]
	local var_21_23 = {}

	for iter_21_7, iter_21_8 in ipairs(var_21_0.skill) do
		var_21_23[iter_21_8.skill_id] = iter_21_8.skill_level
	end

	for iter_21_9, iter_21_10 in pairs(var_21_5) do
		var_21_23[iter_21_9] = (var_21_23[iter_21_9] or 1) + iter_21_10
	end

	for iter_21_11, iter_21_12 in ipairs(var_21_22.skills) do
		var_21_21[iter_21_11] = var_21_23[iter_21_12] or 1
	end

	var_21_6.skillLevel = var_21_21

	if var_21_0.servantInfo and var_21_0.servantInfo.id ~= 0 then
		local var_21_24 = HeroTools.GetHeroWeaponAddLevel(var_21_0)

		var_21_6.weaponEffectID = WeaponServantCfg[var_21_0.servantInfo.id].effect[1]
		var_21_6.weaponEffectLevel = var_21_0.servantInfo.stage + var_21_24
	end

	local var_21_25 = {}
	local var_21_26 = var_0_1:GetChipManagerID() or 0

	if var_21_26 ~= 0 then
		table.insert(var_21_25, var_21_26)
	end

	local var_21_27 = var_0_1:GetChipList()

	if var_21_27 then
		for iter_21_13, iter_21_14 in ipairs(var_21_27) do
			table.insert(var_21_25, iter_21_14)
		end
	end

	local var_21_28 = var_0_1:GetCharChipIDList()

	table.insertto(var_21_25, var_21_28)

	var_21_6.AIChip = var_21_25
	var_21_6.mainDamageType = arg_21_1.mainDamageType

	return var_21_6
end

function var_0_0.SetAdvanceTestHeroData(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0
	local var_22_1

	if arg_22_2 and arg_22_2 ~= 0 then
		var_22_0, var_22_1 = GetVirtualData(arg_22_2)
	else
		var_22_0, var_22_1 = GetPracticalData(arg_22_1)
	end

	local var_22_2 = GetHeroFinalAttr(var_22_0, var_22_0.servantInfo, var_22_1, arg_22_2)
	local var_22_3, var_22_4, var_22_5 = HeroTools.CalTransitionSkillAttribute(var_22_0, var_22_1)
	local var_22_6 = RoleDataForExchange.New()

	var_22_6.UID = arg_22_3
	var_22_6.playerLevel = arg_22_4

	if arg_22_2 and arg_22_2 ~= 0 then
		var_22_6.ID = HeroStandardSystemCfg[arg_22_2].skin_id
	else
		var_22_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_22_0.id).id
	end

	var_22_6.Level = LvTools.CheckHeroExp(1, var_22_0.exp, HeroConst.HERO_LV_MAX)
	var_22_6.isVow = var_22_0:IsOath()

	local var_22_7 = {}
	local var_22_8 = {}

	for iter_22_0, iter_22_1 in pairs(var_22_2) do
		local var_22_9 = PublicAttrCfg[iter_22_0]

		if var_22_9 then
			table.insert(var_22_7, var_22_9.id)
			table.insert(var_22_8, iter_22_1)
		end
	end

	local var_22_10, var_22_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_22_7, var_22_8, var_22_0.using_skin, var_22_0.weapon_module_level)

	var_22_6.attributeValue, var_22_6.attributeID = var_22_11, var_22_10

	local var_22_12 = {}
	local var_22_13 = {}

	for iter_22_2, iter_22_3 in pairs(var_22_4) do
		table.insert(var_22_12, iter_22_2)
		table.insert(var_22_13, iter_22_3)
	end

	var_22_6.equipSkillID = var_22_12
	var_22_6.equipSkillLv = var_22_13

	local var_22_14 = {}
	local var_22_15 = AstrolabeTools.GetTotalEffect(var_22_0.using_astrolabe)

	for iter_22_4 = 1, 9 do
		var_22_14[iter_22_4] = var_22_15[iter_22_4] or 0
	end

	var_22_6.astrolabe = var_22_14

	local var_22_16 = {}
	local var_22_17 = EquipTools.GetEffectS(var_22_1, var_22_0)

	for iter_22_5, iter_22_6 in pairs(var_22_17) do
		table.insert(var_22_16, iter_22_5)
	end

	var_22_6.equipment = var_22_16

	local var_22_18 = {}
	local var_22_19 = HeroCfg[var_22_0.id]
	local var_22_20 = {}

	for iter_22_7, iter_22_8 in ipairs(var_22_0.skill) do
		var_22_20[iter_22_8.skill_id] = iter_22_8.skill_level
	end

	for iter_22_9, iter_22_10 in pairs(var_22_5) do
		var_22_20[iter_22_9] = (var_22_20[iter_22_9] or 1) + iter_22_10
	end

	for iter_22_11, iter_22_12 in ipairs(var_22_19.skills) do
		var_22_18[iter_22_11] = var_22_20[iter_22_12] or 1
	end

	var_22_6.skillLevel = var_22_18

	if var_22_0.servantInfo.id and var_22_0.servantInfo.id ~= 0 then
		local var_22_21 = HeroTools.GetHeroWeaponAddLevel(var_22_0)

		var_22_6.weaponEffectID = WeaponServantCfg[var_22_0.servantInfo.id].effect[1]
		var_22_6.weaponEffectLevel = var_22_0.servantInfo.stage + var_22_21
	end

	local var_22_22 = {}
	local var_22_23 = var_0_1:GetChipManagerID() or 0

	if var_22_23 ~= 0 then
		table.insert(var_22_22, var_22_23)
	end

	if var_0_1:GetChipOfHeroDic()[var_22_6.ID] then
		if var_22_23 ~= 0 then
			for iter_22_13, iter_22_14 in ipairs(var_0_1:GetChipList()) do
				table.insert(var_22_22, iter_22_14)
			end
		end

		for iter_22_15, iter_22_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_22_6.ID]) do
			table.insert(var_22_22, iter_22_16)
		end
	else
		local var_22_24 = var_0_1:GetChipList()

		if var_22_24 then
			for iter_22_17, iter_22_18 in ipairs(var_22_24) do
				table.insert(var_22_22, iter_22_18)
			end
		end
	end

	local var_22_25 = var_0_1:GetCharChipIDList()

	table.insertto(var_22_22, var_22_25)

	var_22_6.AIChip = var_22_22
	var_22_6.mainDamageType = arg_22_1.mainDamageType

	return var_22_6
end

function var_0_0.SetMatrixHeroData(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_1:GetStandardId()
	local var_23_1
	local var_23_2

	if arg_23_1:GetIsOwnerHero() then
		var_23_1, var_23_2 = GetPracticalData(arg_23_1:GetEntrySnapShot())
	else
		var_23_1, var_23_2 = GetVirtualData(var_23_0)
	end

	local var_23_3 = RoleDataForExchange.New()
	local var_23_4 = HeroStandardSystemCfg[var_23_0]

	if arg_23_4 then
		var_23_1.using_skin = ActivityMatrixData:GetHeroSkin(arg_23_4, var_23_4.hero_id)
	else
		var_23_1.using_skin = MatrixData:GetHeroSkin(var_23_4.hero_id)
	end

	var_23_3.UID = arg_23_2
	var_23_3.playerLevel = arg_23_3

	if var_23_0 and var_23_0 ~= 0 then
		var_23_3.ID = HeroStandardSystemCfg[var_23_0].skin_id
	else
		var_23_3.ID = HeroData:GetHeroBattleUsingSkinInfo(var_23_1.id).id
	end

	var_23_3.Level = LvTools.CheckHeroExp(1, var_23_1.exp, HeroConst.HERO_LV_MAX)
	var_23_3.isVow = var_23_1:IsOath()

	local var_23_5 = GetMatrixtHeroPracticalAttr(var_23_1, var_23_2, var_23_0, arg_23_4, arg_23_1)

	var_23_5[3] = arg_23_1:GetHeroMaxHP()
	var_23_5[2002] = arg_23_1:GetHeroHP()

	local var_23_6 = {}
	local var_23_7 = {}

	for iter_23_0, iter_23_1 in pairs(var_23_5) do
		if PublicAttrCfg[iter_23_0] or iter_23_0 == 2002 then
			table.insert(var_23_6, iter_23_0)
			table.insert(var_23_7, iter_23_1)
		end
	end

	var_23_3.attributeID = var_23_6
	var_23_3.attributeValue = var_23_7

	local var_23_8 = {}
	local var_23_9 = arg_23_1:GetAstrolabeEffectList()

	for iter_23_2 = 1, 9 do
		var_23_8[iter_23_2] = var_23_9[iter_23_2] or 0
	end

	var_23_3.astrolabe = var_23_8

	local var_23_10 = {}

	var_23_3.equipment = arg_23_1:GetEquipEffectList()

	local var_23_11 = {}
	local var_23_12 = HeroCfg[var_23_1.id]
	local var_23_13 = {}

	for iter_23_3, iter_23_4 in ipairs(var_23_1.skill) do
		var_23_13[iter_23_4.skill_id] = iter_23_4.skill_level
	end

	for iter_23_5, iter_23_6 in ipairs(var_23_12.skills) do
		var_23_11[iter_23_5] = var_23_13[iter_23_6] or 1
	end

	var_23_3.skillLevel = var_23_11

	local var_23_14 = arg_23_1:GetWeaponServantEffect()

	if var_23_14 ~= 0 then
		var_23_3.weaponEffectID = WeaponServantCfg[var_23_14].effect[1]
		var_23_3.weaponEffectLevel = arg_23_1:GetWeaponServantEffectLevel()
	end

	local var_23_15 = {}
	local var_23_16 = var_0_1:GetChipManagerID()

	if var_23_16 ~= 0 then
		table.insert(var_23_15, var_23_16)

		for iter_23_7, iter_23_8 in ipairs(var_0_1:GetChipList()) do
			table.insert(var_23_15, iter_23_8)
		end
	end

	local var_23_17 = var_0_1:GetCharChipIDList()

	table.insertto(var_23_15, var_23_17)

	var_23_3.AIChip = var_23_15
	var_23_3.mainDamageType = arg_23_1.mainDamageType

	return var_23_3
end

function var_0_0.SetChessHeroData(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0
	local var_24_1

	if arg_24_2 and arg_24_2 ~= 0 then
		var_24_0, var_24_1 = GetVirtualData(arg_24_2)
	else
		var_24_0, var_24_1 = GetPracticalData(arg_24_1)
	end

	local var_24_2 = GetHeroFinalAttr(var_24_0, var_24_0.servantInfo, var_24_1, arg_24_2)
	local var_24_3, var_24_4, var_24_5 = HeroTools.CalTransitionSkillAttribute(var_24_0, var_24_1)
	local var_24_6 = RoleDataForExchange.New()

	var_24_6.UID = arg_24_3
	var_24_6.playerLevel = arg_24_4

	if arg_24_2 and arg_24_2 ~= 0 then
		var_24_6.ID = HeroStandardSystemCfg[arg_24_2].skin_id
	else
		var_24_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_24_0.id).id
	end

	var_24_6.Level = LvTools.CheckHeroExp(1, var_24_0.exp, HeroConst.HERO_LV_MAX)
	var_24_6.isVow = var_24_0:IsOath()

	local var_24_7 = {}
	local var_24_8 = {}

	for iter_24_0, iter_24_1 in pairs(var_24_2) do
		if PublicAttrCfg[iter_24_0] or iter_24_0 == 2002 then
			table.insert(var_24_7, iter_24_0)
			table.insert(var_24_8, iter_24_1)
		end
	end

	local var_24_9, var_24_10 = BattleTools.FixBattleAttributeListAndWeaponModule(var_24_7, var_24_8, var_24_0.using_skin, var_24_0.weapon_module_level)

	var_24_6.attributeValue, var_24_6.attributeID = var_24_10, var_24_9

	local var_24_11 = {}
	local var_24_12 = {}

	for iter_24_2, iter_24_3 in pairs(var_24_4) do
		table.insert(var_24_11, iter_24_2)
		table.insert(var_24_12, iter_24_3)
	end

	var_24_6.equipSkillID = var_24_11
	var_24_6.equipSkillLv = var_24_12

	local var_24_13 = {}
	local var_24_14 = AstrolabeTools.GetTotalEffect(var_24_0.using_astrolabe)

	for iter_24_4 = 1, 9 do
		var_24_13[iter_24_4] = var_24_14[iter_24_4] or 0
	end

	var_24_6.astrolabe = var_24_13

	local var_24_15 = {}
	local var_24_16 = EquipTools.GetEffectS(var_24_1, var_24_0)

	for iter_24_5, iter_24_6 in pairs(var_24_16) do
		table.insert(var_24_15, iter_24_5)
	end

	var_24_6.equipment = var_24_15

	local var_24_17 = {}
	local var_24_18 = HeroCfg[var_24_0.id]
	local var_24_19 = {}

	for iter_24_7, iter_24_8 in ipairs(var_24_0.skill) do
		var_24_19[iter_24_8.skill_id] = iter_24_8.skill_level
	end

	for iter_24_9, iter_24_10 in pairs(var_24_5) do
		var_24_19[iter_24_9] = (var_24_19[iter_24_9] or 1) + iter_24_10
	end

	for iter_24_11, iter_24_12 in ipairs(var_24_18.skills) do
		var_24_17[iter_24_11] = var_24_19[iter_24_12] or 1
	end

	var_24_6.skillLevel = var_24_17

	if var_24_0.servantInfo.id and var_24_0.servantInfo.id ~= 0 then
		local var_24_20 = HeroTools.GetHeroWeaponAddLevel(var_24_0)

		var_24_6.weaponEffectID = WeaponServantCfg[var_24_0.servantInfo.id].effect[1]
		var_24_6.weaponEffectLevel = var_24_0.servantInfo.stage + var_24_20
	end

	local var_24_21 = {}
	local var_24_22 = var_0_1:GetChipManagerID()

	if var_24_22 ~= 0 then
		table.insert(var_24_21, var_24_22)
	end

	if var_0_1:GetChipOfHeroDic()[var_24_6.ID] then
		if var_24_22 ~= 0 then
			for iter_24_13, iter_24_14 in ipairs(var_0_1:GetChipList()) do
				table.insert(var_24_21, iter_24_14)
			end
		end

		for iter_24_15, iter_24_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_24_6.ID]) do
			table.insert(var_24_21, iter_24_16)
		end
	else
		local var_24_23 = var_0_1:GetChipList()

		if var_24_23 then
			for iter_24_17, iter_24_18 in ipairs(var_24_23) do
				table.insert(var_24_21, iter_24_18)
			end
		end
	end

	local var_24_24 = var_0_1:GetCharChipIDList()

	table.insertto(var_24_21, var_24_24)

	var_24_6.AIChip = var_24_21
	var_24_6.mainDamageType = arg_24_1.mainDamageType

	return var_24_6
end

function var_0_0.SetEquipBreakThroughMaterialHeroData(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	local var_25_0
	local var_25_1

	if arg_25_3 and arg_25_3 ~= 0 then
		var_25_0, var_25_1 = GetVirtualData(arg_25_3)
	else
		var_25_0, var_25_1 = GetPracticalData(arg_25_2)
	end

	local var_25_2 = GetHeroFinalAttr(var_25_0, var_25_0.servantInfo, var_25_1, arg_25_3)
	local var_25_3, var_25_4, var_25_5 = HeroTools.CalTransitionSkillAttribute(var_25_0, var_25_1)
	local var_25_6 = RoleDataForExchange.New()

	var_25_6.UID = arg_25_4
	var_25_6.playerLevel = arg_25_5

	if arg_25_3 and arg_25_3 ~= 0 then
		var_25_6.ID = HeroStandardSystemCfg[arg_25_3].skin_id
	else
		var_25_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_25_0.id).id
	end

	var_25_6.Level = LvTools.CheckHeroExp(1, var_25_0.exp, HeroConst.HERO_LV_MAX)
	var_25_6.isVow = var_25_0:IsOath()

	local var_25_7 = {}
	local var_25_8 = {}
	local var_25_9 = EquipBreakThroughMaterialData:GetHeroState()[arg_25_1] and EquipBreakThroughMaterialData:GetHeroState()[arg_25_1].rate or 10000

	if var_25_9 then
		local var_25_10 = var_25_2[3]
		local var_25_11 = math.ceil(var_25_9 / 10000 * var_25_10)

		var_25_2[2002] = var_25_11
	end

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		if PublicAttrCfg[iter_25_0] or iter_25_0 == 2002 then
			table.insert(var_25_7, iter_25_0)
			table.insert(var_25_8, iter_25_1)
		end
	end

	local var_25_12, var_25_13 = BattleTools.FixBattleAttributeListAndWeaponModule(var_25_7, var_25_8, var_25_0.using_skin, var_25_0.weapon_module_level)

	var_25_6.attributeValue, var_25_6.attributeID = var_25_13, var_25_12

	local var_25_14 = {}
	local var_25_15 = {}

	for iter_25_2, iter_25_3 in pairs(var_25_4) do
		table.insert(var_25_14, iter_25_2)
		table.insert(var_25_15, iter_25_3)
	end

	var_25_6.equipSkillID = var_25_14
	var_25_6.equipSkillLv = var_25_15

	local var_25_16 = {}
	local var_25_17 = AstrolabeTools.GetTotalEffect(var_25_0.using_astrolabe)

	for iter_25_4 = 1, 9 do
		var_25_16[iter_25_4] = var_25_17[iter_25_4] or 0
	end

	var_25_6.astrolabe = var_25_16

	local var_25_18 = {}
	local var_25_19 = EquipTools.GetEffectS(var_25_1, var_25_0)

	for iter_25_5, iter_25_6 in pairs(var_25_19) do
		table.insert(var_25_18, iter_25_5)
	end

	var_25_6.equipment = var_25_18

	local var_25_20 = {}
	local var_25_21 = HeroCfg[var_25_0.id]
	local var_25_22 = {}

	for iter_25_7, iter_25_8 in ipairs(var_25_0.skill) do
		var_25_22[iter_25_8.skill_id] = iter_25_8.skill_level
	end

	for iter_25_9, iter_25_10 in pairs(var_25_5) do
		var_25_22[iter_25_9] = (var_25_22[iter_25_9] or 1) + iter_25_10
	end

	for iter_25_11, iter_25_12 in ipairs(var_25_21.skills) do
		var_25_20[iter_25_11] = var_25_22[iter_25_12] or 1
	end

	var_25_6.skillLevel = var_25_20

	if var_25_0.servantInfo.id and var_25_0.servantInfo.id ~= 0 then
		local var_25_23 = HeroTools.GetHeroWeaponAddLevel(var_25_0)

		var_25_6.weaponEffectID = WeaponServantCfg[var_25_0.servantInfo.id].effect[1]
		var_25_6.weaponEffectLevel = var_25_0.servantInfo.stage + var_25_23
	end

	var_25_6.AIChip = var_0_1:GetChipAndAIList(var_25_6.ID)
	var_25_6.mainDamageType = arg_25_2.mainDamageType

	return var_25_6
end

function var_0_0.SetPolyhedronHeroData(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0
	local var_26_1

	if arg_26_3 == nil then
		var_26_0, var_26_1 = GetVirtualData(arg_26_4)
	else
		var_26_0, var_26_1 = arg_26_3:GetVirtualData()
	end

	local var_26_2 = GetPolyhedronHeroPracticalAttr(arg_26_1, var_26_0, var_26_1, arg_26_4)
	local var_26_3, var_26_4, var_26_5 = HeroTools.CalTransitionSkillAttribute(var_26_0, var_26_1)
	local var_26_6 = RoleDataForExchange.New()

	var_26_6.UID = arg_26_5
	var_26_6.playerLevel = arg_26_6
	var_26_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_26_0.id).id
	var_26_6.Level = LvTools.CheckHeroExp(1, var_26_0.exp, HeroConst.HERO_LV_MAX)
	var_26_6.isVow = OathTools.IsOath(var_26_0.id)

	local var_26_7 = {}
	local var_26_8 = {}
	local var_26_9 = var_26_0.id
	local var_26_10 = arg_26_1:GetHeroPolyData(var_26_9)

	var_26_2[3] = var_26_10:GetHeroMaxHP()
	var_26_2[2002] = var_26_10:GetHeroHP()

	for iter_26_0, iter_26_1 in pairs(var_26_2) do
		if PublicAttrCfg[iter_26_0] or iter_26_0 == 2002 then
			table.insert(var_26_7, iter_26_0)
			table.insert(var_26_8, iter_26_1)
		end
	end

	var_26_6.attributeID = var_26_7
	var_26_6.attributeValue = var_26_8

	local var_26_11 = {}
	local var_26_12 = {}

	for iter_26_2, iter_26_3 in pairs(var_26_4) do
		table.insert(var_26_11, iter_26_2)
		table.insert(var_26_12, iter_26_3)
	end

	var_26_6.equipSkillID = var_26_11
	var_26_6.equipSkillLv = var_26_12

	local var_26_13 = {}
	local var_26_14 = AstrolabeTools.GetTotalEffect(var_26_0.using_astrolabe)

	for iter_26_4 = 1, 9 do
		var_26_13[iter_26_4] = var_26_14[iter_26_4] or 0
	end

	var_26_6.astrolabe = var_26_13

	local var_26_15 = {}
	local var_26_16 = EquipTools.GetEffectS(var_26_1, var_26_0)

	for iter_26_5, iter_26_6 in pairs(var_26_16) do
		table.insert(var_26_15, iter_26_5)
	end

	var_26_6.equipment = var_26_15

	local var_26_17 = {}
	local var_26_18 = HeroCfg[var_26_0.id]
	local var_26_19 = {}

	for iter_26_7, iter_26_8 in ipairs(var_26_0.skill) do
		var_26_19[iter_26_8.skill_id] = iter_26_8.skill_level
	end

	for iter_26_9, iter_26_10 in pairs(var_26_5) do
		var_26_19[iter_26_9] = (var_26_19[iter_26_9] or 1) + iter_26_10
	end

	for iter_26_11, iter_26_12 in ipairs(var_26_18.skills) do
		var_26_17[iter_26_11] = var_26_19[iter_26_12] or 1
	end

	var_26_6.skillLevel = var_26_17

	if var_26_0.servantInfo.id and var_26_0.servantInfo.id ~= 0 then
		local var_26_20 = HeroTools.GetHeroWeaponAddLevel(var_26_0)

		var_26_6.weaponEffectID = WeaponServantCfg[var_26_0.servantInfo.id].effect[1]
		var_26_6.weaponEffectLevel = var_26_0.servantInfo.stage + var_26_20
	end

	var_26_6.AIChip = {}
	var_26_6.mainDamageType = arg_26_2.mainDamageType

	return var_26_6
end

function var_0_0.SetChallengeRogueTeamHeroData(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0
	local var_27_1

	if arg_27_2 and arg_27_2 ~= 0 then
		var_27_0, var_27_1 = GetVirtualData(arg_27_2)
		var_27_0.hpPercent = arg_27_1.hpPercent
	else
		var_27_0, var_27_1 = GetPracticalData(arg_27_1)
	end

	local var_27_2 = ChallengeRogueTeamData:GetHeroFinalAttr(var_27_0, var_27_0.servantInfo, var_27_1, arg_27_2)
	local var_27_3, var_27_4, var_27_5 = HeroTools.CalTransitionSkillAttribute(var_27_0, var_27_1)
	local var_27_6 = RoleDataForExchange.New()

	var_27_6.UID = arg_27_3
	var_27_6.playerLevel = arg_27_4

	if arg_27_2 and arg_27_2 ~= 0 then
		var_27_6.ID = HeroStandardSystemCfg[arg_27_2].skin_id
	else
		var_27_6.ID = ChallengeRogueTeamData:GetHeroBattleUsingSkinInfo(var_27_0.id).id
	end

	var_27_6.Level = LvTools.CheckHeroExp(1, var_27_0.exp, HeroConst.HERO_LV_MAX)
	var_27_6.isVow = var_27_0:IsOath()

	local var_27_7 = {}
	local var_27_8 = {}
	local var_27_9, var_27_10 = BattleTools.FixBattleAttributeListAndWeaponModule(var_27_7, var_27_8, var_27_0.using_skin, var_27_0.weapon_module_level)
	local var_27_11 = ChallengeRogueTeamData:GetHeroData(var_27_0.id, nil, true).hpPercent

	if var_27_11 then
		local var_27_12 = var_27_2[3]
		local var_27_13 = math.ceil(var_27_11 / 10000 * var_27_12)

		var_27_2[2002] = var_27_13
	end

	for iter_27_0, iter_27_1 in pairs(var_27_2) do
		if PublicAttrCfg[iter_27_0] or iter_27_0 == 2002 then
			table.insert(var_27_9, iter_27_0)
			table.insert(var_27_10, iter_27_1)
		end
	end

	for iter_27_2, iter_27_3 in ipairs(ChallengeRogueTeamTools.GetBuffList()) do
		local var_27_14 = iter_27_3.effectId
		local var_27_15 = RogueTeamEffectCfg[var_27_14]

		if var_27_15.action == ChallengeRogueTeamConst.EFFECT_ACTION.HERO_ATTRIBUTE then
			local var_27_16 = var_27_15.params

			for iter_27_4, iter_27_5 in ipairs(var_27_16) do
				local var_27_17 = table.keyof(var_27_9, iter_27_5[1])

				if var_27_17 then
					var_27_10[var_27_17] = var_27_10[var_27_17] + iter_27_5[2]
				else
					table.insert(var_27_9, iter_27_5[1])
					table.insert(var_27_10, iter_27_5[2])
				end
			end
		end
	end

	var_27_6.attributeID = var_27_9
	var_27_6.attributeValue = var_27_10

	local var_27_18 = {}
	local var_27_19 = {}

	for iter_27_6, iter_27_7 in pairs(var_27_4) do
		table.insert(var_27_18, iter_27_6)
		table.insert(var_27_19, iter_27_7)
	end

	var_27_6.equipSkillID = var_27_18
	var_27_6.equipSkillLv = var_27_19

	local var_27_20 = {}
	local var_27_21 = AstrolabeTools.GetTotalEffect(var_27_0.using_astrolabe)

	for iter_27_8 = 1, 9 do
		var_27_20[iter_27_8] = var_27_21[iter_27_8] or 0
	end

	var_27_6.astrolabe = var_27_20

	local var_27_22 = {}
	local var_27_23 = EquipTools.GetEffectS(var_27_1, var_27_0)

	for iter_27_9, iter_27_10 in pairs(var_27_23) do
		table.insert(var_27_22, iter_27_9)
	end

	var_27_6.equipment = var_27_22

	local var_27_24 = {}
	local var_27_25 = HeroCfg[var_27_0.id]
	local var_27_26 = {}

	for iter_27_11, iter_27_12 in ipairs(var_27_0.skill) do
		var_27_26[iter_27_12.skill_id] = iter_27_12.skill_level
	end

	for iter_27_13, iter_27_14 in pairs(var_27_5) do
		var_27_26[iter_27_13] = (var_27_26[iter_27_13] or 1) + iter_27_14
	end

	for iter_27_15, iter_27_16 in ipairs(var_27_25.skills) do
		var_27_24[iter_27_15] = var_27_26[iter_27_16] or 1
	end

	var_27_6.skillLevel = var_27_24

	if var_27_0.servantInfo.id and var_27_0.servantInfo.id ~= 0 then
		local var_27_27 = HeroTools.GetHeroWeaponAddLevel(var_27_0)

		var_27_6.weaponEffectID = WeaponServantCfg[var_27_0.servantInfo.id].effect[1]
		var_27_6.weaponEffectLevel = var_27_0.servantInfo.stage + var_27_27
	end

	local var_27_28 = {}
	local var_27_29 = var_0_1:GetChipManagerID() or 0

	if var_27_29 ~= 0 then
		table.insert(var_27_28, var_27_29)
	end

	if var_0_1:GetChipOfHeroDic()[var_27_6.ID] then
		if var_27_29 ~= 0 then
			for iter_27_17, iter_27_18 in ipairs(var_0_1:GetChipList()) do
				table.insert(var_27_28, iter_27_18)
			end
		end

		for iter_27_19, iter_27_20 in ipairs(var_0_1:GetChipOfHeroDic()[var_27_6.ID]) do
			table.insert(var_27_28, iter_27_20)
		end
	else
		local var_27_30 = var_0_1:GetChipList()

		if var_27_30 then
			for iter_27_21, iter_27_22 in ipairs(var_27_30) do
				table.insert(var_27_28, iter_27_22)
			end
		end
	end

	local var_27_31 = var_0_1:GetCharChipIDList()

	table.insertto(var_27_28, var_27_31)

	var_27_6.AIChip = {}
	var_27_6.mainDamageType = arg_27_1.mainDamageType

	return var_27_6
end

function var_0_0.SetNewWarChessHeroData(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0
	local var_28_1

	if arg_28_2 and arg_28_2 ~= 0 then
		var_28_0, var_28_1 = GetVirtualData(arg_28_2)
	else
		var_28_0, var_28_1 = GetPracticalData(arg_28_1)
	end

	local var_28_2 = GetHeroFinalAttr(var_28_0, var_28_0.servantInfo, var_28_1, arg_28_2)
	local var_28_3, var_28_4, var_28_5 = HeroTools.CalTransitionSkillAttribute(var_28_0, var_28_1)
	local var_28_6 = RoleDataForExchange.New()

	var_28_6.UID = arg_28_3
	var_28_6.playerLevel = arg_28_4

	if arg_28_2 and arg_28_2 ~= 0 then
		var_28_6.ID = HeroStandardSystemCfg[arg_28_2].skin_id
	else
		var_28_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_28_0.id).id
	end

	var_28_6.Level = LvTools.CheckHeroExp(1, var_28_0.exp, HeroConst.HERO_LV_MAX)
	var_28_6.isVow = var_28_0:IsOath()

	local var_28_7 = var_28_0.id

	var_28_2[2002] = math.ceil(NewWarChessData:GetHeroHp(var_28_7) / NewChessConst.HERO_HP_RATE * var_28_2[3])

	local var_28_8 = {}
	local var_28_9 = {}

	for iter_28_0, iter_28_1 in pairs(var_28_2) do
		if PublicAttrCfg[iter_28_0] or iter_28_0 == 2002 then
			table.insert(var_28_8, iter_28_0)
			table.insert(var_28_9, iter_28_1)
		end
	end

	local var_28_10, var_28_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_28_8, var_28_9, var_28_0.using_skin, var_28_0.weapon_module_level)

	var_28_6.attributeValue, var_28_6.attributeID = var_28_11, var_28_10

	local var_28_12 = {}
	local var_28_13 = {}

	for iter_28_2, iter_28_3 in pairs(var_28_4) do
		table.insert(var_28_12, iter_28_2)
		table.insert(var_28_13, iter_28_3)
	end

	var_28_6.equipSkillID = var_28_12
	var_28_6.equipSkillLv = var_28_13

	local var_28_14 = {}
	local var_28_15 = AstrolabeTools.GetTotalEffect(var_28_0.using_astrolabe)

	for iter_28_4 = 1, 9 do
		var_28_14[iter_28_4] = var_28_15[iter_28_4] or 0
	end

	var_28_6.astrolabe = var_28_14

	local var_28_16 = {}
	local var_28_17 = EquipTools.GetEffectS(var_28_1, var_28_0)

	for iter_28_5, iter_28_6 in pairs(var_28_17) do
		table.insert(var_28_16, iter_28_5)
	end

	var_28_6.equipment = var_28_16

	local var_28_18 = {}
	local var_28_19 = HeroCfg[var_28_0.id]
	local var_28_20 = {}

	for iter_28_7, iter_28_8 in ipairs(var_28_0.skill) do
		var_28_20[iter_28_8.skill_id] = iter_28_8.skill_level
	end

	for iter_28_9, iter_28_10 in pairs(var_28_5) do
		var_28_20[iter_28_9] = (var_28_20[iter_28_9] or 1) + iter_28_10
	end

	for iter_28_11, iter_28_12 in ipairs(var_28_19.skills) do
		var_28_18[iter_28_11] = var_28_20[iter_28_12] or 1
	end

	var_28_6.skillLevel = var_28_18

	if var_28_0.servantInfo.id and var_28_0.servantInfo.id ~= 0 then
		local var_28_21 = HeroTools.GetHeroWeaponAddLevel(var_28_0)

		var_28_6.weaponEffectID = WeaponServantCfg[var_28_0.servantInfo.id].effect[1]
		var_28_6.weaponEffectLevel = var_28_0.servantInfo.stage + var_28_21
	end

	var_28_6.mainDamageType = arg_28_1.mainDamageType

	return var_28_6
end

function var_0_0.MultiHeartDemonSetHeroData(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0
	local var_29_1

	if arg_29_2 and arg_29_2 ~= 0 then
		var_29_0, var_29_1 = GetVirtualData(arg_29_2)
	else
		var_29_0, var_29_1 = GetPracticalData(arg_29_1)
	end

	local var_29_2 = GetHeroFinalAttr(var_29_0, var_29_0.servantInfo, var_29_1, arg_29_2)
	local var_29_3, var_29_4, var_29_5 = HeroTools.CalTransitionSkillAttribute(var_29_0, var_29_1)
	local var_29_6 = RoleDataForExchange.New()

	var_29_6.UID = arg_29_3
	var_29_6.playerLevel = arg_29_4

	if arg_29_2 and arg_29_2 ~= 0 then
		var_29_6.ID = HeroStandardSystemCfg[arg_29_2].skin_id
	else
		var_29_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_29_0.id).id
	end

	var_29_6.Level = LvTools.CheckHeroExp(1, var_29_0.exp, HeroConst.HERO_LV_MAX)
	var_29_6.isVow = var_29_0:IsOath()

	local var_29_7 = {}
	local var_29_8 = {}
	local var_29_9 = MultHeartDemonData:GetAcvivityId()

	if var_29_0.tempID and var_29_0.tempID > 0 then
		local var_29_10 = MultHeartDemonCfg.get_id_list_by_activity_id[var_29_9][1]
		local var_29_11 = MultHeartDemonCfg[var_29_10].trial_hero
		local var_29_12 = 0

		for iter_29_0, iter_29_1 in ipairs(var_29_11) do
			if var_29_0.tempID == iter_29_1 then
				var_29_12 = iter_29_0

				break
			end
		end

		local var_29_13 = MultHeartDemonCfg[var_29_10].hero_attrib[var_29_12]

		if var_29_13 and var_29_2[var_29_13[1]] then
			var_29_2[var_29_13[1]] = var_29_2[var_29_13[1]] + var_29_13[2]
		end
	end

	var_29_2[2002] = var_29_2[HeroConst.HERO_ATTRIBUTE.STA] * arg_29_5

	for iter_29_2, iter_29_3 in pairs(var_29_2) do
		if PublicAttrCfg[iter_29_2] or iter_29_2 == 2002 then
			table.insert(var_29_7, iter_29_2)
			table.insert(var_29_8, iter_29_3)
		end
	end

	local var_29_14, var_29_15 = BattleTools.FixBattleAttributeListAndWeaponModule(var_29_7, var_29_8, var_29_0.using_skin, var_29_0.weapon_module_level)

	var_29_6.attributeValue, var_29_6.attributeID = var_29_15, var_29_14

	local var_29_16 = {}
	local var_29_17 = {}

	for iter_29_4, iter_29_5 in pairs(var_29_4) do
		table.insert(var_29_16, iter_29_4)
		table.insert(var_29_17, iter_29_5)
	end

	var_29_6.equipSkillID = var_29_16
	var_29_6.equipSkillLv = var_29_17

	local var_29_18 = {}
	local var_29_19 = AstrolabeTools.GetTotalEffect(var_29_0.using_astrolabe)

	for iter_29_6 = 1, 9 do
		var_29_18[iter_29_6] = var_29_19[iter_29_6] or 0
	end

	var_29_6.astrolabe = var_29_18

	local var_29_20 = {}
	local var_29_21 = EquipTools.GetEffectS(var_29_1, var_29_0)

	for iter_29_7, iter_29_8 in pairs(var_29_21) do
		table.insert(var_29_20, iter_29_7)
	end

	var_29_6.equipment = var_29_20

	local var_29_22 = {}
	local var_29_23 = HeroCfg[var_29_0.id]
	local var_29_24 = {}

	for iter_29_9, iter_29_10 in ipairs(var_29_0.skill) do
		var_29_24[iter_29_10.skill_id] = iter_29_10.skill_level
	end

	for iter_29_11, iter_29_12 in pairs(var_29_5) do
		var_29_24[iter_29_11] = (var_29_24[iter_29_11] or 1) + iter_29_12
	end

	for iter_29_13, iter_29_14 in ipairs(var_29_23.skills) do
		var_29_22[iter_29_13] = var_29_24[iter_29_14] or 1
	end

	var_29_6.skillLevel = var_29_22

	if var_29_0.servantInfo and var_29_0.servantInfo.id ~= 0 then
		local var_29_25 = HeroTools.GetHeroWeaponAddLevel(var_29_0)

		var_29_6.weaponEffectID = WeaponServantCfg[var_29_0.servantInfo.id].effect[1]
		var_29_6.weaponEffectLevel = var_29_0.servantInfo.stage + var_29_25
	end

	local var_29_26 = {}
	local var_29_27 = var_0_1:GetChipManagerID() or 0

	if var_29_27 ~= 0 then
		table.insert(var_29_26, var_29_27)
	end

	if var_0_1:GetChipOfHeroDic()[var_29_6.ID] then
		if var_29_27 ~= 0 then
			for iter_29_15, iter_29_16 in ipairs(var_0_1:GetChipList()) do
				table.insert(var_29_26, iter_29_16)
			end
		end

		for iter_29_17, iter_29_18 in ipairs(var_0_1:GetChipOfHeroDic()[var_29_6.ID]) do
			table.insert(var_29_26, iter_29_18)
		end
	else
		local var_29_28 = var_0_1:GetChipList()

		if var_29_28 then
			for iter_29_19, iter_29_20 in ipairs(var_29_28) do
				table.insert(var_29_26, iter_29_20)
			end
		end
	end

	local var_29_29 = var_0_1:GetCharChipIDList()

	table.insertto(var_29_26, var_29_29)

	var_29_6.AIChip = var_29_26
	var_29_6.mainDamageType = arg_29_1.mainDamageType

	return var_29_6
end

function var_0_0.SetOsirisPlayGameHeroData(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0
	local var_30_1

	if arg_30_2 and arg_30_2 ~= 0 then
		var_30_0, var_30_1 = GetVirtualData(arg_30_2)
	else
		var_30_0, var_30_1 = GetPracticalData(arg_30_1)
	end

	local var_30_2 = OsirisPlayGameTempHeroData:GetHeroFinalAttr(var_30_0, var_30_0.servantInfo, var_30_1, arg_30_2)
	local var_30_3, var_30_4, var_30_5 = HeroTools.CalTransitionSkillAttribute(var_30_0, var_30_1)
	local var_30_6 = RoleDataForExchange.New()

	var_30_6.UID = arg_30_3
	var_30_6.playerLevel = arg_30_4

	if arg_30_2 and arg_30_2 ~= 0 then
		var_30_6.ID = HeroStandardSystemCfg[arg_30_2].skin_id
	else
		var_30_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_30_0.id).id
	end

	var_30_6.Level = LvTools.CheckHeroExp(1, var_30_0.exp, HeroConst.HERO_LV_MAX)
	var_30_6.isVow = var_30_0:IsOath()

	local var_30_7 = {}
	local var_30_8 = {}

	for iter_30_0, iter_30_1 in pairs(var_30_2) do
		if PublicAttrCfg[iter_30_0] then
			table.insert(var_30_7, iter_30_0)
			table.insert(var_30_8, iter_30_1)
		end
	end

	local var_30_9, var_30_10 = BattleTools.FixBattleAttributeListAndWeaponModule(var_30_7, var_30_8, var_30_0.using_skin, var_30_0.weapon_module_level)

	var_30_6.attributeValue, var_30_6.attributeID = var_30_10, var_30_9

	local var_30_11 = {}
	local var_30_12 = {}

	for iter_30_2, iter_30_3 in pairs(var_30_4) do
		table.insert(var_30_11, iter_30_2)
		table.insert(var_30_12, iter_30_3)
	end

	var_30_6.equipSkillID = var_30_11
	var_30_6.equipSkillLv = var_30_12

	local var_30_13 = {}
	local var_30_14 = AstrolabeTools.GetTotalEffect(var_30_0.using_astrolabe)

	for iter_30_4 = 1, 9 do
		var_30_13[iter_30_4] = var_30_14[iter_30_4] or 0
	end

	var_30_6.astrolabe = var_30_13

	local var_30_15 = {}
	local var_30_16 = EquipTools.GetEffectS(var_30_1, var_30_0)

	for iter_30_5, iter_30_6 in pairs(var_30_16) do
		table.insert(var_30_15, iter_30_5)
	end

	var_30_6.equipment = var_30_15

	local var_30_17 = {}
	local var_30_18 = HeroCfg[var_30_0.id]
	local var_30_19 = {}

	for iter_30_7, iter_30_8 in ipairs(var_30_0.skill) do
		var_30_19[iter_30_8.skill_id] = iter_30_8.skill_level
	end

	for iter_30_9, iter_30_10 in pairs(var_30_5) do
		var_30_19[iter_30_9] = (var_30_19[iter_30_9] or 1) + iter_30_10
	end

	for iter_30_11, iter_30_12 in ipairs(var_30_18.skills) do
		var_30_17[iter_30_11] = var_30_19[iter_30_12] or 1
	end

	var_30_6.skillLevel = var_30_17

	if var_30_0.servantInfo and var_30_0.servantInfo.id ~= 0 then
		local var_30_20 = HeroTools.GetHeroWeaponAddLevel(var_30_0)

		var_30_6.weaponEffectID = WeaponServantCfg[var_30_0.servantInfo.id].effect[1]
		var_30_6.weaponEffectLevel = var_30_0.servantInfo.stage + var_30_20
	end

	local var_30_21 = {}
	local var_30_22 = var_0_1:GetChipManagerID() or 0

	if var_30_22 ~= 0 then
		table.insert(var_30_21, var_30_22)
	end

	if var_0_1:GetChipOfHeroDic()[var_30_6.ID] then
		if var_30_22 ~= 0 then
			for iter_30_13, iter_30_14 in ipairs(ChipData:GetCurChipManagerList(var_30_22)) do
				table.insert(var_30_21, iter_30_14)
			end
		end

		for iter_30_15, iter_30_16 in ipairs(var_0_1:GetChipOfHeroDic()[var_30_6.ID]) do
			table.insert(var_30_21, iter_30_16)
		end
	else
		local var_30_23 = var_0_1:GetChipList()

		if var_30_23 then
			for iter_30_17, iter_30_18 in ipairs(var_30_23) do
				table.insert(var_30_21, iter_30_18)
			end
		end
	end

	local var_30_24 = var_0_1:GetCharChipIDList()

	table.insertto(var_30_21, var_30_24)

	var_30_6.AIChip = var_30_21
	var_30_6.mainDamageType = arg_30_1.mainDamageType

	return var_30_6
end

function var_0_0.SetOutSourcingData(arg_31_0, arg_31_1)
	local var_31_0
	local var_31_1

	if arg_31_1 and arg_31_1 ~= 0 then
		var_31_0, var_31_1 = GetVirtualData(arg_31_1)
	end

	local var_31_2 = GetHeroFinalAttr(var_31_0, var_31_0.servantInfo, var_31_1, arg_31_1)
	local var_31_3, var_31_4, var_31_5 = HeroTools.CalTransitionSkillAttribute(var_31_0, var_31_1)
	local var_31_6 = RoleDataForExchange.New()

	var_31_6.UID = 1
	var_31_6.playerLevel = 1

	if arg_31_1 and arg_31_1 ~= 0 then
		var_31_6.ID = HeroStandardSystemCfg[arg_31_1].skin_id
	else
		var_31_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_31_0.id).id
	end

	var_31_6.Level = LvTools.CheckHeroExp(1, var_31_0.exp, HeroConst.HERO_LV_MAX)
	var_31_6.isVow = var_31_0:IsOath()

	local var_31_7 = {}
	local var_31_8 = {}

	for iter_31_0, iter_31_1 in pairs(var_31_2) do
		local var_31_9 = PublicAttrCfg[iter_31_0]

		if var_31_9 then
			table.insert(var_31_7, var_31_9.id)
			table.insert(var_31_8, iter_31_1)
		end
	end

	local var_31_10, var_31_11 = BattleTools.FixBattleAttributeListAndWeaponModule(var_31_7, var_31_8, var_31_0.using_skin, var_31_0.weapon_module_level)

	var_31_6.attributeValue, var_31_6.attributeID = var_31_11, var_31_10

	local var_31_12 = {}
	local var_31_13 = {}

	for iter_31_2, iter_31_3 in pairs(var_31_4) do
		table.insert(var_31_12, iter_31_2)
		table.insert(var_31_13, iter_31_3)
	end

	var_31_6.equipSkillID = var_31_12
	var_31_6.equipSkillLv = var_31_13

	local var_31_14 = {}
	local var_31_15 = AstrolabeTools.GetTotalEffect(var_31_0.using_astrolabe)

	for iter_31_4 = 1, 9 do
		var_31_14[iter_31_4] = var_31_15[iter_31_4] or 0
	end

	var_31_6.astrolabe = var_31_14

	local var_31_16 = {}
	local var_31_17 = EquipTools.GetEffectS(var_31_1, var_31_0)

	for iter_31_5, iter_31_6 in pairs(var_31_17) do
		table.insert(var_31_16, iter_31_5)
	end

	var_31_6.equipment = var_31_16

	local var_31_18 = {}
	local var_31_19 = HeroCfg[var_31_0.id]
	local var_31_20 = {}

	for iter_31_7, iter_31_8 in ipairs(var_31_0.skill) do
		var_31_20[iter_31_8.skill_id] = iter_31_8.skill_level
	end

	for iter_31_9, iter_31_10 in pairs(var_31_5) do
		var_31_20[iter_31_9] = (var_31_20[iter_31_9] or 1) + iter_31_10
	end

	for iter_31_11, iter_31_12 in ipairs(var_31_19.skills) do
		var_31_18[iter_31_11] = var_31_20[iter_31_12] or 1
	end

	var_31_6.skillLevel = var_31_18

	if var_31_0.servantInfo and var_31_0.servantInfo.id ~= 0 then
		local var_31_21 = HeroTools.GetHeroWeaponAddLevel(var_31_0)

		var_31_6.weaponEffectID = WeaponServantCfg[var_31_0.servantInfo.id].effect[1]
		var_31_6.weaponEffectLevel = var_31_0.servantInfo.stage + var_31_21
	end

	var_31_6.AIChip = {}
	var_31_6.mainDamageType = HeroTools.GetHeroBattleAtkAttributeId(var_31_0.id)

	return var_31_6
end

function var_0_0.SetHeroDataWithHP(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6)
	local var_32_0
	local var_32_1

	if arg_32_2 and arg_32_2 ~= 0 then
		var_32_0, var_32_1 = GetVirtualData(arg_32_2)
	else
		var_32_0, var_32_1 = GetPracticalData(arg_32_1)
	end

	local var_32_2 = HodurGameTempHeroData:GetHeroFinalAttr(var_32_0, var_32_0.servantInfo, var_32_1, arg_32_2)
	local var_32_3, var_32_4, var_32_5 = HeroTools.CalTransitionSkillAttribute(var_32_0, var_32_1)
	local var_32_6 = RoleDataForExchange.New()

	var_32_6.UID = arg_32_3
	var_32_6.playerLevel = arg_32_4

	if arg_32_2 and arg_32_2 ~= 0 then
		var_32_6.ID = HeroStandardSystemCfg[arg_32_2].skin_id
	else
		var_32_6.ID = HeroData:GetHeroBattleUsingSkinInfo(var_32_0.id).id
	end

	var_32_6.Level = LvTools.CheckHeroExp(1, var_32_0.exp, HeroConst.HERO_LV_MAX)
	var_32_6.isVow = var_32_0:IsOath()

	local var_32_7 = {}
	local var_32_8 = {}
	local var_32_9 = var_32_0.tempID or var_32_0.id
	local var_32_10
	local var_32_11
	local var_32_12, var_32_13 = HodurTools.GetChapterHeroHP(arg_32_5, var_32_9, arg_32_6)
	local var_32_14 = var_32_13
	local var_32_15 = var_32_12 / var_32_14
	local var_32_16 = 1000000
	local var_32_17 = math.ceil(var_32_15 * var_32_16) / var_32_16

	var_32_2[2002] = math.ceil(var_32_17 * var_32_2[3])

	for iter_32_0, iter_32_1 in pairs(var_32_2) do
		if PublicAttrCfg[iter_32_0] or iter_32_0 == 2002 and iter_32_1 >= 0 then
			table.insert(var_32_7, iter_32_0)
			table.insert(var_32_8, iter_32_1)
		end
	end

	local var_32_18, var_32_19 = BattleTools.FixBattleAttributeListAndWeaponModule(var_32_7, var_32_8, var_32_0.using_skin, var_32_0.weapon_module_level)

	var_32_6.attributeValue, var_32_6.attributeID = var_32_19, var_32_18

	local var_32_20 = {}
	local var_32_21 = {}

	for iter_32_2, iter_32_3 in pairs(var_32_4) do
		table.insert(var_32_20, iter_32_2)
		table.insert(var_32_21, iter_32_3)
	end

	var_32_6.equipSkillID = var_32_20
	var_32_6.equipSkillLv = var_32_21

	local var_32_22 = {}
	local var_32_23 = AstrolabeTools.GetTotalEffect(var_32_0.using_astrolabe)

	for iter_32_4 = 1, 9 do
		var_32_22[iter_32_4] = var_32_23[iter_32_4] or 0
	end

	var_32_6.astrolabe = var_32_22

	local var_32_24 = {}
	local var_32_25 = EquipTools.GetEffectS(var_32_1, var_32_0)

	for iter_32_5, iter_32_6 in pairs(var_32_25) do
		table.insert(var_32_24, iter_32_5)
	end

	var_32_6.equipment = var_32_24

	local var_32_26 = {}
	local var_32_27 = HeroCfg[var_32_0.id]
	local var_32_28 = {}

	for iter_32_7, iter_32_8 in ipairs(var_32_0.skill) do
		var_32_28[iter_32_8.skill_id] = iter_32_8.skill_level
	end

	for iter_32_9, iter_32_10 in pairs(var_32_5) do
		var_32_28[iter_32_9] = (var_32_28[iter_32_9] or 1) + iter_32_10
	end

	for iter_32_11, iter_32_12 in ipairs(var_32_27.skills) do
		var_32_26[iter_32_11] = var_32_28[iter_32_12] or 1
	end

	var_32_6.skillLevel = var_32_26

	if var_32_0.servantInfo and var_32_0.servantInfo.id ~= 0 then
		local var_32_29 = HeroTools.GetHeroWeaponAddLevel(var_32_0)

		var_32_6.weaponEffectID = WeaponServantCfg[var_32_0.servantInfo.id].effect[1]
		var_32_6.weaponEffectLevel = var_32_0.servantInfo.stage + var_32_29
	end

	local var_32_30 = {}
	local var_32_31 = var_0_1:GetChipManagerID() or 0

	if var_32_31 ~= 0 then
		table.insert(var_32_30, var_32_31)
	end

	local var_32_32 = var_0_1:GetChipList()

	if var_32_32 then
		for iter_32_13, iter_32_14 in ipairs(var_32_32) do
			table.insert(var_32_30, iter_32_14)
		end
	end

	local var_32_33 = var_0_1:GetCharChipIDList()

	table.insertto(var_32_30, var_32_33)

	var_32_6.AIChip = var_32_30
	var_32_6.mainDamageType = arg_32_1.mainDamageType

	return var_32_6
end

return var_0_0
