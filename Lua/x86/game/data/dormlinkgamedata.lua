local var_0_0 = singletonClass("DormLinkGameData")
local var_0_1 = require("cjson")
local var_0_2 = import("game.data.DormLinkGameTemplate")
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12

function var_0_0.Init(arg_1_0)
	var_0_3 = nil
	var_0_8 = nil
	var_0_12 = nil
end

function var_0_0.CheckToEnterDormLinkScene(arg_2_0, arg_2_1)
	var_0_8 = arg_2_1

	if not ActivityLinkGameCfg[var_0_8] then
		var_0_8 = nil

		return
	end

	arg_2_0:InitGameInfo()
	DormMinigame.Launch("HZ07_lianliankan")
end

function var_0_0.GetCurLevelID(arg_3_0)
	if var_0_8 then
		return var_0_8
	end
end

function var_0_0.InitLevelInfo(arg_4_0, arg_4_1)
	var_0_3 = arg_4_1.activity_id
	var_0_10 = {}
	var_0_11 = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityLinkGameCfg.all) do
		local var_4_0 = {
			clear = false,
			activityID = iter_4_1,
			difficultyLevel = ActivityLinkGameCfg[iter_4_1].difficult
		}

		var_0_10[iter_4_1] = var_4_0
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.link_game) do
		if var_0_10[iter_4_3.id] then
			var_0_10[iter_4_3.id].maxPoint = iter_4_3.point
		end
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.receive_reward) do
		arg_4_0:SetRewardInfo(iter_4_5, true)
	end

	arg_4_0:CheckUnCompleteLevel()
	arg_4_0:CheckUnReciveLevelReward()
	var_0_0.InitRedPoint(var_0_3)
end

local function var_0_13(arg_5_0, arg_5_1)
	return string.format("%s_%d", arg_5_0, arg_5_1)
end

function var_0_0.RedPointKey(arg_6_0, arg_6_1)
	return var_0_13(arg_6_1, var_0_3)
end

var_0_0.LIANLIANKAN_IN_GAME = "LINKGAME_INGAME"
var_0_0.LIANLIANKAN_LEVEL_REWARD = "LINKGAME_LEVEL_REWARD"
var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL = "LINKGAME_UNCOMPLETE_LEVEL"
var_0_0.LIANLIANKAN_TASK_REWARD = "LINKGAME_TASK_REWARD"

function var_0_0.InitRedPoint(arg_7_0)
	var_0_12 = nil

	local var_7_0 = ActivityTools.GetAllTaskSubActivityID(arg_7_0)
	local var_7_1 = var_0_13(var_0_0.LIANLIANKAN_IN_GAME, arg_7_0)
	local var_7_2 = var_0_13(var_0_0.LIANLIANKAN_TASK_REWARD, arg_7_0)
	local var_7_3 = var_0_13(var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL, arg_7_0)
	local var_7_4 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		table.insert(var_7_4, var_0_13(RedPointConst.ACTIVITY_TASK, iter_7_1))
	end

	manager.redPoint:addGroup(var_7_2, var_7_4)

	local var_7_5 = {}

	for iter_7_2, iter_7_3 in ipairs(DormLinkGameTools:GetLevelActivityList(arg_7_0)) do
		table.insert(var_7_5, var_0_13(var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL, iter_7_3))
	end

	manager.redPoint:addGroup(var_7_3, var_7_5)
	manager.redPoint:addGroup(var_7_1, {
		var_0_13(var_0_0.LIANLIANKAN_LEVEL_REWARD, arg_7_0),
		var_7_3
	})
	manager.redPoint:addGroup(var_0_13(RedPointConst.LIANLIANKAN, arg_7_0), {
		var_7_2,
		var_7_1
	})
end

function var_0_0.GetAwardInfo(arg_8_0, arg_8_1)
	if var_0_11 then
		return var_0_11[arg_8_1]
	end
end

function var_0_0.SetRewardInfo(arg_9_0, arg_9_1, arg_9_2)
	if not var_0_11 then
		var_0_11 = {}
	end

	var_0_11[arg_9_1] = arg_9_2
end

function var_0_0.GetMainActivityID(arg_10_0)
	return var_0_3
end

function var_0_0.GetLevelActivityIDList(arg_11_0)
	return DormLinkGameTools:GetLevelActivityList(var_0_3)
end

function var_0_0.GetLevelControlledByActivity(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1
	local var_12_2

	for iter_12_0, iter_12_1 in ipairs(ActivityLinkGameCfg.get_id_list_by_activity_id[arg_12_1]) do
		local var_12_3 = ActivityLinkGameCfg[iter_12_1]

		if var_12_0 == nil and var_12_3.difficult == 1 then
			var_12_0 = iter_12_1
		elseif var_12_1 == nil and var_12_3.difficult == 2 then
			var_12_1 = iter_12_1
		elseif var_12_2 == nil and var_12_3.diffcult ~= 1 and var_12_3.diffcult ~= 2 then
			var_12_2 = iter_12_1
		end

		if var_12_0 and var_12_1 or var_12_2 then
			break
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function var_0_0.GetLevelInfoList(arg_13_0)
	if var_0_10 then
		return var_0_10
	end
end

function var_0_0.CheckLevelIsClear(arg_14_0, arg_14_1)
	local var_14_0 = {
		arg_14_1 * 2 - 1,
		arg_14_1 * 2
	}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if var_0_10[iter_14_1] and var_0_10[iter_14_1].maxPoint then
			return true
		end
	end

	return false
end

function var_0_0.CheckLevelRewardState(arg_15_0, arg_15_1)
	if var_0_11 and var_0_11[arg_15_1] then
		return DormLinkGameConst.RewardItemState.received
	end

	local var_15_0 = ActivityLinkGameRewardCfg[arg_15_1].condition
	local var_15_1 = ConditionCfg[var_15_0]

	if var_15_1.type == DormLinkGameConst.AwardCondition.Point then
		local var_15_2 = var_15_1.params[1]
		local var_15_3 = var_15_1.params[2]
		local var_15_4 = ActivityLinkGameRewardCfg[arg_15_1].activity_id
		local var_15_5
		local var_15_6 = 0

		if var_15_2 == 0 then
			local var_15_7 = 0

			for iter_15_0, iter_15_1 in ipairs(ActivityLinkGameCfg.all) do
				if ActivityLinkGameCfg[iter_15_1].activity_id == var_15_4 and var_0_10[iter_15_1] then
					var_15_7 = math.max(var_15_7, var_0_10[iter_15_1].maxPoint or 0)
				end
			end

			var_15_6 = var_15_7
		else
			local var_15_8 = DormLinkGameTools:GetLevelIDByDiffAndActivityID(var_15_4, var_15_2)

			if var_0_10[var_15_8] then
				var_15_6 = var_0_10[var_15_8].maxPoint or 0
			else
				var_15_6 = 0
			end
		end

		if var_15_3 <= var_15_6 then
			return DormLinkGameConst.RewardItemState.complete
		else
			return DormLinkGameConst.RewardItemState.unComplete
		end
	end
end

function var_0_0.GetAllLevelTopPoint(arg_16_0)
	local var_16_0 = 0

	if var_0_10 then
		for iter_16_0, iter_16_1 in pairs(var_0_10) do
			if iter_16_1.maxPoint then
				var_16_0 = math.max(var_16_0, iter_16_1.maxPoint)
			end
		end
	end

	return var_16_0
end

function var_0_0.CheckActivityComplete(arg_17_0, arg_17_1)
	local var_17_0 = ActivityLinkGameCfg.get_id_list_by_activity_id[arg_17_1]

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if var_0_10[iter_17_1].maxPoint then
			return true
		end
	end

	return false
end

function var_0_0.GetLevelInfoByIndexAndDiff(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 == 2 then
		return arg_18_1 * 2
	else
		return arg_18_1 * 2 - 1
	end
end

function var_0_0.GetIndexAndDiffByLevelInfo(arg_19_0, arg_19_1)
	local var_19_0
	local var_19_1 = ActivityLinkGameCfg[arg_19_1].difficult

	if arg_19_1 % 2 == 0 then
		var_19_0 = arg_19_1 / 2
	else
		var_19_0 = (arg_19_1 + 1) / 2
	end

	return var_19_0, var_19_1
end

function var_0_0.GetLevelScore(arg_20_0, arg_20_1)
	if var_0_10[arg_20_1] then
		return var_0_10[arg_20_1].maxPoint
	end
end

function var_0_0.GetCurCnaUseTokenNum(arg_21_0)
	local var_21_0 = DormLinkGameTools:GetCurrencyID(var_0_3)
	local var_21_1 = ItemTools.getItemNum(var_21_0)

	if var_0_5 then
		return var_21_1 - var_0_5.costTokenNum
	else
		return var_21_1
	end
end

local var_0_14

function var_0_0.InitGameInfo(arg_22_0)
	arg_22_0:InitSceneData()
	arg_22_0:InitCacheData()

	var_0_14 = false
end

function var_0_0.InitSceneData(arg_23_0)
	if var_0_8 then
		var_0_4 = {}
		var_0_4 = {
			levelID = var_0_8,
			difficultyLevel = ActivityLinkGameCfg[var_0_8].difficult,
			canUseItem = ActivityLinkGameCfg[var_0_8].property_limit,
			limitTime = ActivityLinkGameCfg[var_0_8].time_limit
		}
	end
end

function var_0_0.GetSceneData(arg_24_0)
	return var_0_4
end

function var_0_0.InitCacheData(arg_25_0)
	if var_0_8 then
		var_0_5 = {
			basePoint = 0,
			drainPoint = 0,
			drainMaterialNum = 0,
			batterNum = 0,
			costTokenNum = 0,
			eliminateNum = 0,
			highestBatterNum = 0,
			gameTime = 0,
			customerAddition = 0,
			batterAddition = 0,
			batterMaterial = {},
			generateInterval = ActivityLinkGameCfg[var_0_8].time_interval / 100,
			extendPoint = ActivityLinkGameCfg[var_0_8].extra_score,
			useItemList = {}
		}
		var_0_6 = false
		var_0_9 = 0
	end
end

function var_0_0.DisposeGameCacheInfo(arg_26_0)
	var_0_5 = nil
end

function var_0_0.GetGameCacheInfo(arg_27_0)
	if var_0_5 then
		return var_0_5
	end
end

function var_0_0.GetGameCurLevel(arg_28_0)
	if var_0_5 then
		return var_0_5.levelID
	end
end

function var_0_0.GetGameBuffIgnoreConnectCheck(arg_29_0)
	return nullable(var_0_5, "buffIgnoreConnect")
end

function var_0_0.InitCustomerInfo(arg_30_0)
	if var_0_8 then
		var_0_7 = {}

		local var_30_0 = DormUtils.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer)

		for iter_30_0, iter_30_1 in Dorm.storage:ForeachData(var_30_0, pairs) do
			local var_30_1 = DormUtils.GetEntityData(iter_30_1).cfgID
			local var_30_2 = {
				customerID = var_30_1,
				customerEID = iter_30_1,
				posIndex = iter_30_0
			}

			var_0_7[var_30_1] = var_0_2.New(var_30_2)
		end
	end
end

function var_0_0.GetCustomerList(arg_31_0)
	return var_0_7
end

function var_0_0.GetCustomerInfo(arg_32_0, arg_32_1)
	if var_0_7[arg_32_1] then
		return var_0_7[arg_32_1]
	else
		print("未找到食客信息")
	end
end

local var_0_15

local function var_0_16(arg_33_0)
	local var_33_0 = var_0_15[arg_33_0]

	if var_33_0 then
		var_33_0:Stop()

		local var_33_1
	end
end

local function var_0_17(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	var_0_16(arg_34_0)

	local var_34_0 = Timer.New(arg_34_2, arg_34_1, arg_34_3 or 1)

	var_34_0:Start()

	var_0_15[arg_34_0] = var_34_0
end

function var_0_0.RunGameTimer(arg_35_0)
	if not var_0_15 then
		var_0_15 = {}
	end

	if not var_0_15.gameTimer then
		local var_35_0 = var_0_4.limitTime

		var_0_15.gameTimer = Timer.New(function()
			var_0_5.gameTime = var_0_5.gameTime + 1
			var_35_0 = var_35_0 - 1

			if var_35_0 <= 0 then
				arg_35_0:StopGame(DormLinkGameConst.StopGameType.success)
			else
				manager.notify:Invoke(DORM_LINK_REFRESH_GAME_TIME, var_35_0)
			end

			local var_36_0 = {
				num = var_35_0
			}

			DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.LastTime, var_36_0)
		end, 1, -1)

		var_0_15.gameTimer:Start()
	end

	var_0_17("customerTimer", 1, function()
		for iter_37_0, iter_37_1 in pairs(var_0_7) do
			local var_37_0 = ActivityLinkGameCustomerCfg[iter_37_1.ID].satiety_descend_rate

			iter_37_1:ReviseSatiety(-var_37_0)
		end
	end, -1)

	local var_35_1 = GameSetting.linkgame_count_down.value[1]

	var_0_17("startGenerateTimer", DormLinkGameConst.GenerateTick, function()
		if var_0_9 <= 0 then
			var_35_1 = var_35_1 - DormLinkGameConst.GenerateTick

			if var_35_1 <= 0 then
				var_0_16("startGenerateTimer")
				arg_35_0:RefreshMaterialGenerateTimer()
			else
				manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, var_35_1 + var_0_5.generateInterval)
			end
		end
	end, -1)
end

function var_0_0.RefreshMaterialGenerateTimer(arg_39_0)
	local var_39_0 = var_0_5.generateInterval

	var_0_17("generateTimer", DormLinkGameConst.GenerateTick, function()
		if var_0_9 <= 0 then
			var_39_0 = var_39_0 - DormLinkGameConst.GenerateTick

			if var_39_0 <= 0 then
				arg_39_0:GenerateMaterialList()

				var_39_0 = var_0_5.generateInterval
			end

			manager.notify:Invoke(DORM_LINK_REFRESH_MATERIAL_TIME, var_39_0)
		end
	end, -1)
end

function var_0_0.PauseMaterialGenerate(arg_41_0, arg_41_1)
	var_0_9 = math.max(0, var_0_9) + arg_41_1

	var_0_17("pauseTimer", 1, function()
		var_0_9 = var_0_9 - 1
	end, var_0_9)
end

function var_0_0.BuffIgnoreConnectCheck(arg_43_0, arg_43_1)
	var_0_5.buffIgnoreConnect = {
		start = Time.time,
		duration = arg_43_1
	}

	manager.notify:Invoke(DORM_LINK_REFRESH_BUFF_IGNORE_CONNECTION, var_0_5.buffIgnoreConnect)
	var_0_17("buffIgnoreConnect", arg_43_1, function()
		var_0_5.buffIgnoreConnect = nil
	end)
end

function var_0_0.ReSetBatterTimer(arg_45_0)
	if var_0_15.batterTimer and var_0_6 then
		var_0_15.batterTimer:Reset()
	else
		local var_45_0 = GameSetting.linkgame_hit_time.value[1]

		var_0_15.batterTimer = Timer.New(function()
			var_0_6 = false

			arg_45_0:ClearBatterNum()
		end, var_45_0, 1)
	end

	var_0_15.batterTimer:Start()
end

function var_0_0.StopTimer(arg_47_0)
	if var_0_15 then
		for iter_47_0, iter_47_1 in pairs(var_0_15) do
			iter_47_1:Stop()
		end
	end
end

function var_0_0.DisposeTimer(arg_48_0)
	if var_0_15 then
		for iter_48_0, iter_48_1 in pairs(var_0_15) do
			iter_48_1:Stop()

			var_0_15[iter_48_0] = nil
		end
	end
end

local var_0_18

function var_0_0.PlayerStartGame(arg_49_0)
	var_0_18 = true

	arg_49_0:RunGameTimer()
	manager.notify:Invoke(DORM_LINK_START_PLAY)

	if var_0_4 then
		local var_49_0 = ActivityLinkGameCfg[var_0_4.levelID].activity_id

		if var_0_4.difficultyLevel and var_49_0 then
			local var_49_1 = 1

			if not var_0_14 then
				var_49_1 = 2
			end

			SDKTools.SendMessageToSDK("activity_linkgame_end", {
				difficulty_id = var_0_4.difficultyLevel,
				activity_id = var_49_0,
				end_type = var_49_1
			})
		end
	end
end

function var_0_0.StopGame(arg_50_0, arg_50_1)
	manager.audio:Stop("effect")

	if var_0_18 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")

		var_0_18 = nil
	else
		manager.audio:PlayEffect("minigame_activity_2_1", "minigame_activity_2_1_connect_end02", "")
	end

	arg_50_0:StopTimer()

	if arg_50_1 == DormLinkGameConst.StopGameType.success then
		DormLinkGameAction:ClearanceLevel(var_0_4.levelID, var_0_5)
	elseif arg_50_1 == DormLinkGameConst.StopGameType.fail then
		arg_50_0:FailedClear()
	end
end

local function var_0_19(arg_51_0)
	local var_51_0 = 0

	for iter_51_0, iter_51_1 in ipairs(arg_51_0) do
		var_51_0 = var_51_0 + ActivityLinkGameGoodsCfg[iter_51_1.id].coin_num * iter_51_1.num
	end

	return var_51_0
end

local function var_0_20(arg_52_0)
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_0) do
		table.insert(var_52_0, {
			id = iter_52_1.id,
			num = iter_52_1.num
		})
	end

	return var_0_1.encode(var_52_0)
end

function var_0_0.SuccessClear(arg_53_0, arg_53_1)
	local var_53_0, var_53_1 = arg_53_0:GetLastPoint()

	var_0_10[var_0_8].maxPoint = var_0_10[var_0_8].maxPoint or 0
	var_0_10[var_0_8].maxPoint = math.max(var_0_10[var_0_8].maxPoint, var_53_0)
	var_0_5.highestBatterNum = math.max(var_0_5.highestBatterNum, var_0_5.batterNum)

	local var_53_2 = {
		totalPoint = var_53_0,
		extendPoint = var_53_1,
		time = var_0_5.gameTime
	}
	local var_53_3 = ActivityLinkGameCfg[var_0_4.levelID].activity_id

	if var_0_4.difficultyLevel and var_53_3 then
		SDKTools.SendMessageToSDK("activity_linkgame_finish", {
			hit_num = var_0_5.highestBatterNum,
			cell_num = var_0_5.eliminateNum,
			activity_id = var_53_3,
			difficulty_id = var_0_4.difficultyLevel,
			score = arg_53_1.point,
			use_time = var_0_5.gameTime,
			use_coin_num = var_0_19(arg_53_1.item_list),
			skill_num = var_0_20(arg_53_1.item_list)
		})
	end

	arg_53_0:DisposeRunGameInfo()
	arg_53_0:SaveDefaultLevelAndDiff(var_0_8)
	arg_53_0:CheckUnReciveLevelReward()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.success, var_53_2)
end

function var_0_0.FailedClear(arg_54_0)
	arg_54_0:DisposeRunGameInfo()
	manager.notify:Invoke(DORM_LINK_END_GAME, DormLinkGameConst.StopGameType.fail)
end

function var_0_0.DisposeRunGameInfo(arg_55_0)
	arg_55_0:DisposeGameCacheInfo()
	arg_55_0:DisposeTimer()

	var_0_7 = nil
end

function var_0_0.ResetRunGameInfo(arg_56_0)
	var_0_14 = true

	arg_56_0:InitCacheData()
	arg_56_0:InitCustomerInfo()
end

function var_0_0.DisposeGameInfo(arg_57_0)
	var_0_4 = nil
	var_0_6 = nil
end

function var_0_0.EliminateMaterial(arg_58_0, arg_58_1)
	arg_58_0:ReSetBatterTimer()

	var_0_6 = true

	if not var_0_5.batterMaterial[arg_58_1] then
		var_0_5.batterMaterial[arg_58_1] = 0
	end

	var_0_5.eliminateNum = var_0_5.eliminateNum + 1
	var_0_5.batterMaterial[arg_58_1] = var_0_5.batterMaterial[arg_58_1] + 1

	local var_58_0 = {}

	arg_58_0:UpdataCustomerNeed(var_58_0)

	if var_0_7 then
		for iter_58_0, iter_58_1 in pairs(var_0_7) do
			local var_58_1 = var_58_0[iter_58_0]

			manager.notify:Invoke(DORM_LINK_REFRESH_CUSTOMER_BUBBLE, iter_58_0, var_58_1)
		end
	end

	arg_58_0:AddBatterNum()
	arg_58_0:RefreshBasePoint(arg_58_1)
end

function var_0_0.RefreshBasePoint(arg_59_0, arg_59_1)
	local var_59_0 = 0

	for iter_59_0, iter_59_1 in pairs(var_0_7) do
		var_59_0 = var_59_0 + iter_59_1.satietyAddition
	end

	var_0_5.customerAddition = var_59_0

	if ActivityLinkGameCellCfg[arg_59_1] then
		var_0_5.basePoint = var_0_5.basePoint + ActivityLinkGameCellCfg[arg_59_1].complete_score * (100 + var_0_5.batterAddition + var_59_0) / 100
	end
end

function var_0_0.AddBatterNum(arg_60_0)
	var_0_5.batterNum = var_0_5.batterNum + 1

	arg_60_0:RefreshExtendAddition()
	arg_60_0:RefreshGenerateInterval()

	local var_60_0 = {
		oldNum = var_0_5.batterNum - 1,
		newNum = var_0_5.batterNum
	}

	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.SuccssBatterNum, var_60_0)
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function var_0_0.ClearBatterNum(arg_61_0)
	var_0_5.highestBatterNum = math.max(var_0_5.highestBatterNum, var_0_5.batterNum)

	local var_61_0 = {
		num = var_0_5.batterNum
	}

	DormLinkGameTools:PlaySpecialVoice(DormLinkGameConst.SpecialVoiceType.FaileBatterNum, var_61_0)

	var_0_5.batterNum = 0

	arg_61_0:RefreshGenerateInterval()
	arg_61_0:RefreshExtendAddition()
	manager.notify:Invoke(DORM_LINK_REFRESH_BATTER_NUM)
end

function var_0_0.GetBatterNum(arg_62_0)
	return var_0_5.batterNum
end

function var_0_0.GetExtendAddition(arg_63_0)
	return var_0_5.batterAddition + var_0_5.customerAddition
end

function var_0_0.RefreshExtendAddition(arg_64_0)
	local var_64_0 = ActivityLinkGameCfg[var_0_8].hit_score_up
	local var_64_1 = arg_64_0:GetExtendAddition()
	local var_64_2 = var_0_5.batterNum

	var_0_5.batterAddition = 0

	if var_64_0 then
		for iter_64_0, iter_64_1 in ipairs(var_64_0) do
			if var_64_2 >= iter_64_1[1] then
				var_0_5.batterAddition = 0 + iter_64_1[2]

				if var_0_5.batterAddition <= 0 then
					print("连击加成错误")
				end
			end
		end
	end

	if var_64_1 ~= arg_64_0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function var_0_0.RefreshCustomerExtendAddition(arg_65_0)
	local var_65_0 = arg_65_0:GetExtendAddition()

	var_0_5.customerAddition = 0

	for iter_65_0, iter_65_1 in pairs(var_0_7) do
		var_0_5.customerAddition = var_0_5.customerAddition + iter_65_1.satietyAddition
	end

	if var_65_0 ~= arg_65_0:GetExtendAddition() then
		manager.notify:Invoke(DORM_LINK_REFRESH_EXTEND_ADDITION)
	end
end

function var_0_0.RefreshGenerateInterval(arg_66_0)
	if not var_0_5 then
		print("操作数据不存在")
	end

	local var_66_0 = var_0_5.batterNum
	local var_66_1 = ActivityLinkGameCfg[var_0_8].hit_interval_cut

	var_0_5.generateInterval = ActivityLinkGameCfg[var_0_8].time_interval / 100

	if var_66_1 then
		for iter_66_0, iter_66_1 in ipairs(var_66_1) do
			if var_66_0 >= iter_66_1[1] then
				var_0_5.generateInterval = (ActivityLinkGameCfg[var_0_8].time_interval - iter_66_1[2]) / 100

				if var_0_5.generateInterval <= 0 then
					print("生成间隔时间错误")
				end
			end
		end
	end
end

function var_0_0.GetDisposeMaterialNum(arg_67_0, arg_67_1)
	return var_0_5.batterMaterial[arg_67_1] or 0
end

function var_0_0.UpdataCustomerNeed(arg_68_0, arg_68_1)
	if var_0_7 then
		for iter_68_0, iter_68_1 in pairs(var_0_7) do
			local var_68_0 = iter_68_1.curPreference
			local var_68_1 = true

			for iter_68_2, iter_68_3 in ipairs(ActivityLinkGameComposeCfg[var_68_0].compose_list) do
				local var_68_2 = iter_68_3[1]

				if iter_68_3[2] > arg_68_0:GetDisposeMaterialNum(var_68_2) then
					var_68_1 = false

					break
				end
			end

			if var_68_1 then
				for iter_68_4, iter_68_5 in ipairs(ActivityLinkGameComposeCfg[var_68_0].compose_list) do
					local var_68_3 = iter_68_5[1]
					local var_68_4 = iter_68_5[2]

					var_0_5.batterMaterial[var_68_3] = var_0_5.batterMaterial[var_68_3] - var_68_4
				end

				iter_68_1:FoodComplate()
			end

			if arg_68_1 then
				arg_68_1[iter_68_0] = var_68_1
			end
		end
	end
end

function var_0_0.GetCurMaterialState(arg_69_0)
	if var_0_5 then
		return var_0_5.materialstate
	end
end

function var_0_0.GenerateMaterialList(arg_70_0)
	manager.notify:Invoke(LIANLIANKAN_PREVIEW_APPEAR)
end

function var_0_0.DrainMaterial(arg_71_0, arg_71_1)
	local var_71_0 = 0

	for iter_71_0, iter_71_1 in ipairs(arg_71_1) do
		var_0_5.drainMaterialNum = var_0_5.drainMaterialNum + 1
		var_71_0 = var_71_0 + ActivityLinkGameCellCfg[iter_71_1].waste_score
	end

	var_0_5.drainPoint = var_0_5.drainPoint + var_71_0

	if var_71_0 > 0 then
		manager.notify:Invoke(DORM_LINK_REFRESH_DRAIN_MATERIAL, var_71_0)
	end
end

function var_0_0.GetLastPoint(arg_72_0)
	local var_72_0 = var_0_5.basePoint
	local var_72_1 = math.max(var_0_5.extendPoint - var_0_5.drainPoint, 0)
	local var_72_2 = var_0_5.gameTime
	local var_72_3 = var_72_1 + math.max(var_0_4.limitTime - var_72_2, 0) * GameSetting.linkgame_time_score.value[1]

	return var_72_0 + var_72_3, var_72_3
end

function var_0_0.GetSaveLevelID(arg_73_0)
	local var_73_0 = USER_ID

	return getData(string.format("%s_%d", "DormLinkLevel", var_73_0), "levelID") or ActivityLinkGameCfg[ActivityLinkGameCfg.all[1]].id
end

function var_0_0.SaveDefaultLevelAndDiff(arg_74_0, arg_74_1)
	local var_74_0 = USER_ID

	saveData(string.format("%s_%d", "DormLinkLevel", var_74_0), "levelID", arg_74_1)
end

local function var_0_21()
	if var_0_12 == nil then
		var_0_12 = getData("DormLinkLevel", "unlockLevel") or {}
	end

	return var_0_12
end

local function var_0_22(arg_76_0, arg_76_1)
	arg_76_0[tostring(arg_76_1)] = 1
end

local function var_0_23(arg_77_0, arg_77_1)
	return arg_77_0[tostring(arg_77_1)] == 1
end

local function var_0_24(arg_78_0)
	saveData("DormLinkLevel", "unlockLevel", arg_78_0 or {})
end

function var_0_0.UpdateLevelActivityCompleteRedPoint(arg_79_0, arg_79_1)
	if var_0_10 == nil then
		return
	end

	local var_79_0 = var_0_13(var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL, arg_79_1)
	local var_79_1 = var_0_21()

	for iter_79_0, iter_79_1 in ipairs(ActivityLinkGameCfg.get_id_list_by_activity_id[arg_79_1]) do
		if DormLinkGameTools:ChecklevelUnLock(iter_79_1) then
			local var_79_2 = not var_0_10[iter_79_1] or not var_0_10[iter_79_1].maxPoint
			local var_79_3 = not var_0_23(var_79_1, arg_79_1)

			if var_79_2 and var_79_3 then
				manager.redPoint:setTip(var_79_0, 1)

				return
			end
		end
	end

	manager.redPoint:setTip(var_79_0, 0)
end

function var_0_0.CheckUnCompleteLevel(arg_80_0)
	if var_0_10 then
		for iter_80_0, iter_80_1 in ipairs(arg_80_0:GetLevelActivityIDList()) do
			arg_80_0:UpdateLevelActivityCompleteRedPoint(iter_80_1)
		end
	end
end

function var_0_0.HideSingleLevelRedPoint(arg_81_0, arg_81_1)
	local var_81_0 = var_0_21()
	local var_81_1 = var_0_13(var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL, arg_81_1)

	if manager.redPoint:getTipBoolean(var_81_1) then
		manager.redPoint:setTip(var_81_1, 0)
		var_0_22(var_81_0, arg_81_1)
		var_0_24(var_81_0)
	end
end

function var_0_0.HideLevelRedPoint(arg_82_0)
	local var_82_0 = var_0_21()
	local var_82_1 = false

	for iter_82_0, iter_82_1 in ipairs(arg_82_0:GetLevelActivityIDList()) do
		local var_82_2 = var_0_13(var_0_0.LIANLIANKAN_UNCOMPLETE_LEVEL, iter_82_1)

		if manager.redPoint:getTipBoolean(var_82_2) then
			manager.redPoint:setTip(var_82_2, 0)
			var_0_22(var_82_0, iter_82_1)

			var_82_1 = true
		end
	end

	if var_82_1 then
		var_0_24(var_82_0)
	end
end

function var_0_0.CheckUnReciveLevelReward(arg_83_0)
	local var_83_0 = arg_83_0:RedPointKey(var_0_0.LIANLIANKAN_LEVEL_REWARD)
	local var_83_1 = ActivityLinkGameRewardCfg.all

	for iter_83_0, iter_83_1 in ipairs(var_83_1) do
		if (not var_0_11 or var_0_11 and not var_0_11[iter_83_1]) and DormLinkGameData:CheckLevelRewardState(iter_83_1) == DormLinkGameConst.RewardItemState.complete then
			manager.redPoint:setTip(var_83_0, 1)

			return
		end
	end

	manager.redPoint:setTip(var_83_0, 0)
end

return var_0_0
