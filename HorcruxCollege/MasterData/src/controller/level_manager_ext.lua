local var_0_0 = {}
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local battlefield_status_data = require("data.battlefield_status_data")
local city_data = require("data.city_data")
local level_bgm = require("data.level_bgm")
local network = require("network.network")
local playermodel = require("model.playermodel")

var_0_0.curenemycount = {}

function var_0_0:getCurEnemyCount(arg_1_1)
	if levelmode_data[arg_1_1].saveenemycount then
		return math.floor(math.sqrt(self.curenemycount[arg_1_1] or 0))
	else
		return self.curenemycount[arg_1_1] or 0
	end
end

function var_0_0:addCurEnemyCount(arg_2_1)
	if levelmode_data[arg_2_1].saveenemycount then
		self:sync_curenemycount(arg_2_1)

		local var_2_0 = math.floor(math.sqrt(self.curenemycount[arg_2_1] or 0)) + 1

		self.curenemycount[arg_2_1] = math.pow(var_2_0, 2)

		return var_2_0
	else
		self.curenemycount[arg_2_1] = ((not self.curenemycount[arg_2_1] or nil) and 0) + 1

		return self.curenemycount[arg_2_1]
	end
end

function var_0_0:cleanCurEnemyCount(arg_3_1)
	self.curenemycount[arg_3_1] = 0
end

function var_0_0:sync_curenemycount(arg_4_1)
	network:rpc("sync_curenemycount", {
		mode = arg_4_1,
		count = self.curenemycount[arg_4_1]
	}, nil)
end

local var_0_8 = {
	[INFINITE_MODE] = require("controller.modeconfig.commonmodeconfig"),
	[CONQUER_MODE] = require("controller.modeconfig.conquermodeconfig"),
	[SPILING_MODE] = require("controller.modeconfig.spilingmodeconfig"),
	[MIRROR_MODE] = require("controller.modeconfig.mirrormodeconfig"),
	[MACHINE_MODE] = require("controller.modeconfig.commonmodeconfig"),
	[ENERGY_MODE] = require("controller.modeconfig.commonmodeconfig"),
	[102] = require("controller.modeconfig.commonmodeconfig"),
	[103] = require("controller.modeconfig.commonmodeconfig"),
	[201] = require("controller.modeconfig.commonmodeconfig"),
	[202] = require("controller.modeconfig.commonmodeconfig"),
	[203] = require("controller.modeconfig.commonmodeconfig"),
	[204] = require("controller.modeconfig.commonmodeconfig"),
	[205] = require("controller.modeconfig.commonmodeconfig"),
	[301] = require("controller.modeconfig.commonmodeconfig"),
	[302] = require("controller.modeconfig.commonmodeconfig"),
	[303] = require("controller.modeconfig.commonmodeconfig"),
	[501] = require("controller.modeconfig.commonmodeconfig"),
	[1001] = require("controller.modeconfig.commonmodeconfig"),
	[1009] = require("controller.modeconfig.commonmodeconfig"),
	[1041] = require("controller.modeconfig.commonmodeconfig"),
	[1042] = require("controller.modeconfig.commonmodeconfig"),
	[1043] = require("controller.modeconfig.commonmodeconfig"),
	[110] = require("controller.modeconfig.commonmodeconfig"),
	[120] = require("controller.modeconfig.commonmodeconfig"),
	[130] = require("controller.modeconfig.commonmodeconfig"),
	[511] = require("controller.modeconfig.commonmodeconfig"),
	[521] = require("controller.modeconfig.commonmodeconfig"),
	[531] = require("controller.modeconfig.commonmodeconfig"),
	[541] = require("controller.modeconfig.commonmodeconfig"),
	[551] = require("controller.modeconfig.commonmodeconfig"),
	[11501] = require("controller.modeconfig.commonmodeconfig"),
	[11502] = require("controller.modeconfig.commonmodeconfig"),
	[11503] = require("controller.modeconfig.commonmodeconfig"),
	[11504] = require("controller.modeconfig.commonmodeconfig"),
	[11505] = require("controller.modeconfig.commonmodeconfig"),
	[11506] = require("controller.modeconfig.commonmodeconfig"),
	[11507] = require("controller.modeconfig.commonmodeconfig"),
	[11508] = require("controller.modeconfig.commonmodeconfig"),
	[11509] = require("controller.modeconfig.commonmodeconfig"),
	[1151] = require("controller.modeconfig.commonmodeconfig"),
	[1152] = require("controller.modeconfig.commonmodeconfig"),
	[1153] = require("controller.modeconfig.commonmodeconfig"),
	[1281] = require("controller.modeconfig.commonmodeconfig"),
	[1282] = require("controller.modeconfig.commonmodeconfig"),
	[1283] = require("controller.modeconfig.commonmodeconfig"),
	[1284] = require("controller.modeconfig.commonmodeconfig"),
	[12801] = require("controller.modeconfig.commonmodeconfig"),
	[12802] = require("controller.modeconfig.commonmodeconfig"),
	[12803] = require("controller.modeconfig.commonmodeconfig"),
	[12804] = require("controller.modeconfig.commonmodeconfig"),
	[12805] = require("controller.modeconfig.commonmodeconfig"),
	[12806] = require("controller.modeconfig.commonmodeconfig"),
	[12807] = require("controller.modeconfig.commonmodeconfig"),
	[12808] = require("controller.modeconfig.commonmodeconfig"),
	[12809] = require("controller.modeconfig.commonmodeconfig"),
	[12810] = require("controller.modeconfig.commonmodeconfig"),
	[12811] = require("controller.modeconfig.commonmodeconfig"),
	[12812] = require("controller.modeconfig.commonmodeconfig"),
	[13201] = require("controller.modeconfig.commonmodeconfig"),
	[13202] = require("controller.modeconfig.commonmodeconfig"),
	[13203] = require("controller.modeconfig.commonmodeconfig"),
	[13204] = require("controller.modeconfig.commonmodeconfig"),
	[13205] = require("controller.modeconfig.commonmodeconfig"),
	[13206] = require("controller.modeconfig.commonmodeconfig"),
	[13207] = require("controller.modeconfig.commonmodeconfig"),
	[13208] = require("controller.modeconfig.commonmodeconfig"),
	[13209] = require("controller.modeconfig.commonmodeconfig"),
	[13210] = require("controller.modeconfig.commonmodeconfig"),
	[13211] = require("controller.modeconfig.commonmodeconfig"),
	[13212] = require("controller.modeconfig.commonmodeconfig"),
	[1321] = require("controller.modeconfig.commonmodeconfig"),
	[1322] = require("controller.modeconfig.commonmodeconfig"),
	[1323] = require("controller.modeconfig.commonmodeconfig"),
	[13701] = require("controller.modeconfig.commonmodeconfig"),
	[13702] = require("controller.modeconfig.commonmodeconfig"),
	[13703] = require("controller.modeconfig.commonmodeconfig"),
	[13704] = require("controller.modeconfig.commonmodeconfig"),
	[13705] = require("controller.modeconfig.commonmodeconfig"),
	[13706] = require("controller.modeconfig.commonmodeconfig"),
	[13707] = require("controller.modeconfig.commonmodeconfig"),
	[13708] = require("controller.modeconfig.commonmodeconfig"),
	[13709] = require("controller.modeconfig.commonmodeconfig"),
	[13710] = require("controller.modeconfig.commonmodeconfig"),
	[13711] = require("controller.modeconfig.commonmodeconfig"),
	[13712] = require("controller.modeconfig.commonmodeconfig"),
	[13713] = require("controller.modeconfig.commonmodeconfig"),
	[1371] = require("controller.modeconfig.commonmodeconfig"),
	[1372] = require("controller.modeconfig.commonmodeconfig"),
	[1373] = require("controller.modeconfig.commonmodeconfig"),
	[20011] = require("controller.modeconfig.commonmodeconfig"),
	[20012] = require("controller.modeconfig.commonmodeconfig"),
	[20013] = require("controller.modeconfig.commonmodeconfig"),
	[20021] = require("controller.modeconfig.commonmodeconfig"),
	[20031] = require("controller.modeconfig.commonmodeconfig"),
	[20032] = require("controller.modeconfig.commonmodeconfig"),
	[20033] = require("controller.modeconfig.commonmodeconfig"),
	[14801] = require("controller.modeconfig.commonmodeconfig"),
	[14802] = require("controller.modeconfig.commonmodeconfig"),
	[14803] = require("controller.modeconfig.commonmodeconfig"),
	[14804] = require("controller.modeconfig.commonmodeconfig"),
	[14805] = require("controller.modeconfig.commonmodeconfig"),
	[14806] = require("controller.modeconfig.commonmodeconfig"),
	[15101] = require("controller.modeconfig.commonmodeconfig"),
	[15102] = require("controller.modeconfig.commonmodeconfig"),
	[15103] = require("controller.modeconfig.commonmodeconfig"),
	[20011] = require("controller.modeconfig.commonmodeconfig"),
	[20012] = require("controller.modeconfig.commonmodeconfig"),
	[20013] = require("controller.modeconfig.commonmodeconfig"),
	[20041] = require("controller.modeconfig.commonmodeconfig"),
	[21011] = require("controller.modeconfig.commonmodeconfig"),
	[21012] = require("controller.modeconfig.commonmodeconfig"),
	[21013] = require("controller.modeconfig.commonmodeconfig"),
	[21031] = require("controller.modeconfig.commonmodeconfig"),
	[21032] = require("controller.modeconfig.commonmodeconfig"),
	[21033] = require("controller.modeconfig.commonmodeconfig"),
	[21041] = require("controller.modeconfig.commonmodeconfig"),
	[21042] = require("controller.modeconfig.commonmodeconfig"),
	[21043] = require("controller.modeconfig.commonmodeconfig"),
	[21511] = require("controller.modeconfig.commonmodeconfig"),
	[21051] = require("controller.modeconfig.commonmodeconfig"),
	[21052] = require("controller.modeconfig.commonmodeconfig"),
	[21053] = require("controller.modeconfig.commonmodeconfig"),
	[21054] = require("controller.modeconfig.commonmodeconfig"),
	[20101] = require("controller.modeconfig.commonmodeconfig"),
	[20102] = require("controller.modeconfig.commonmodeconfig"),
	[20103] = require("controller.modeconfig.commonmodeconfig"),
	[20104] = require("controller.modeconfig.commonmodeconfig")
}

function var_0_0.initAdventureStatus(arg_5_0)
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].initAdventureStatus then
		var_0_8[playermodel.curMode].initAdventureStatus(arg_5_0)
	end
end

function var_0_0.getCreatePlayerFunc(arg_6_0)
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].getCreatePlayerFunc then
		return var_0_8[playermodel.curMode].getCreatePlayerFunc(arg_6_0)
	else
		return nil
	end
end

function var_0_0.generateEnemy(arg_7_0)
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].generateEnemy then
		return var_0_8[playermodel.curMode].generateEnemy(arg_7_0)
	else
		return nil
	end
end

function var_0_0.getCreateEnemyFunc(arg_8_0)
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].getCreateEnemyFunc then
		return var_0_8[playermodel.curMode].getCreateEnemyFunc(arg_8_0)
	else
		return nil
	end
end

function var_0_0:getAdventureProceed()
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].getModeProceed then
		return var_0_8[playermodel.curMode].getModeProceed(self, playermodel.curMode)
	else
		return self:getModeProceed(playermodel.curMode) .. "/" .. self:getModeTotalChapter(playermodel.curMode)
	end
end

function var_0_0.onPlayerDie(arg_10_0, arg_10_1)
	if var_0_8[playermodel.curMode] and var_0_8[playermodel.curMode].onPlayerDie then
		var_0_8[playermodel.curMode].onPlayerDie(arg_10_0, arg_10_1)
	end
end

function var_0_0.getActivityCityList(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if arg_11_1 > 400 then
		local var_11_1 = ACTIVITY_ID_TO_MODETYPE_FUNC.level(arg_11_1)

		for iter_11_0 = 1, 10 do
			local var_11_2 = tonumber(var_11_1 .. iter_11_0)

			if city_data[var_11_2] then
				table.insert(var_11_0, var_11_2)
			else
				break
			end
		end
	else
		for iter_11_1, iter_11_2 in pairs(city_data) do
			if iter_11_2.is_activity_city and string.find(iter_11_2.id, arg_11_1) then
				table.insert(var_11_0, iter_11_2.id)
			end
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)

	return var_11_0
end

function var_0_0.getActivityModeList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(city_data) do
		if iter_13_1.is_activity_city == arg_13_1 then
			while iter_13_1["difficulty" .. 1] do
				table.insert(var_13_0, iter_13_1["difficulty" .. 1])
			end
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end)

	return var_13_0
end

function var_0_0.isActivityLevel(arg_15_0, arg_15_1)
	if not levelmode_data[arg_15_1] then
		return
	end

	if not levelmode_data[arg_15_1].city then
		return
	end

	if city_data[levelmode_data[arg_15_1].city].is_activity_city then
		return true, city_data[levelmode_data[arg_15_1].city].is_activity_city
	else
		return false
	end
end

function var_0_0.isActivityCity(arg_16_0, arg_16_1)
	return city_data[arg_16_1].is_activity_city
end

function var_0_0:getMaxActivityCity(arg_17_1)
	local var_17_0 = self:getActivityCityList(arg_17_1)

	return next(var_17_0) ~= nil and var_17_0[1]
end

local var_0_9 = {}

function var_0_0.updateAdventureDetailInfo(arg_18_0, arg_18_1, arg_18_2)
	var_0_9[arg_18_1] = arg_18_2
end

function var_0_0.getAdventureDetailInfo(arg_19_0, arg_19_1)
	return var_0_9[arg_19_1]
end

function var_0_0.getAdventureBaseDetailInfo(arg_20_0, arg_20_1)
	return {
		initcitytype = var_0_9["initcitytype" .. arg_20_1],
		initcity = var_0_9["initcity" .. arg_20_1],
		initdifficulty = var_0_9["initdifficulty" .. arg_20_1]
	}
end

function var_0_0.getModeList(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(levelmode_data) do
		if iter_21_1.modetype == arg_21_1 then
			table.insert(var_21_0, iter_21_1.mode)
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		return arg_22_0 < arg_22_1
	end)

	return var_21_0
end

function var_0_0:getMaxCity(arg_23_1)
	local var_23_0 = self:getModeList(arg_23_1)

	return next(var_23_0) ~= nil and var_23_0[1]
end

function var_0_0.getMaxAutoChessCity(arg_24_0, arg_24_1)
	for iter_24_0 = 1, 10 do
		local var_24_0 = tonumber(arg_24_1 .. iter_24_0)

		if not levelmode_data[var_24_0] then
			return tonumber(arg_24_1 .. iter_24_0 - 1)
		elseif levelmode_data[var_24_0].totalchapter >= playermodel.levelmode[var_24_0].pass then
			return tonumber(arg_24_1 .. iter_24_0)
		end
	end
end

function var_0_0.jumpToAutoChess(arg_25_0, arg_25_1, arg_25_2)
	return
end

local var_0_10 = {
	[function(arg_26_0)
		if arg_26_0 == 5 or arg_26_0 == 7 or arg_26_0 == 104 then
			return true
		end

		return false
	end] = function(arg_27_0, arg_27_1)
		LayerManager:switchShowLayer("AdventureNewTowerLayer", {
			layer = arg_27_0,
			chaptermode = RoleDefault:getInstance():getIntegerForKey("SpecialAdventureEnterMode", 502),
			scessflag = arg_27_1
		})
	end,
	[function(arg_28_0)
		local expedition_entrance_data = require("data.expedition_entrance_data")

		return expedition_entrance_data[arg_28_0] and expedition_entrance_data[arg_28_0].season_type
	end] = function(arg_29_0, arg_29_1)
		local var_29_0 = require("controller.expedition_manager"):getExpeditionParam()
		local var_29_1 = {}

		var_29_1.jump_to_system = var_29_0.jumpid or 118
		var_29_1.config = {
			inittype = var_29_0.inittype,
			jumpToFlipCallback = var_29_0.jumpToFlipCallback,
			isNeedCheckEvent = arg_29_1 == 1,
			jumpid = var_29_0.jumpid
		}

		goto_complete_system(var_29_1)
	end,
	[function(arg_30_0)
		return arg_30_0 == 1021 or arg_30_0 == require("controller.limit_tower_defence_level_manager"):getInstance():getCurMode()
	end] = function(arg_31_0, arg_31_1)
		local var_31_0 = "TowerDefenceLevelLayer"
		local var_31_1 = RoleDefault:getInstance()

		var_31_0 = arg_31_0 == require("controller.limit_tower_defence_level_manager").getInstance(var_31_1):getCurMode() and "Limit" .. var_31_0 or var_31_0

		LayerManager:switchShowLayer(var_31_0, {
			activityid = arg_31_0,
			initcity = var_31_1:getIntegerForKey("SpecialAdventureEnterMode", 502)
		})
	end,
	[function(arg_32_0)
		return require("controller.substitution_manager"):isSubstitutionModeType(arg_32_0)
	end] = function(arg_33_0, arg_33_1)
		LayerManager:switchShowLayer(require("controller.formation.formation_old_substitute_manager"):getInstance():getReturnLayer(), {
			index = 3,
			activityId = require("controller.substitution_manager"):getCurSubstitutionActivityId()
		})
	end,
	[function(arg_34_0)
		return require("controller.weekly_tower_manager").getInstance():isWeeklyTowerModetpye(arg_34_0)
	end] = function(arg_35_0, arg_35_1)
		require("controller.weekly_tower_manager").getInstance():setFightFlag(false)
		LayerManager:switchShowLayer("WeeklyTowerLayer")
	end,
	[function(arg_36_0)
		local var_36_0 = math.floor(arg_36_0 / 10)
		local activity_conf_data = require("data.activity_conf_data")

		if not activity_conf_data[var_36_0] then
			return false
		end

		if not activity_conf_data[var_36_0].modeType then
			return false
		end

		if activity_conf_data[var_36_0].modeType ~= arg_36_0 then
			return
		end

		return true
	end] = function(arg_37_0, arg_37_1)
		LayerManager:switchReturnLayer("ActivityDailyLevelLayer", {
			activityid = math.floor(arg_37_0 / 10)
		})
	end,
	[function(arg_38_0)
		if ({
			[1150] = true,
			[1152] = true
		})[arg_38_0] then
			return true
		end

		local var_38_0 = math.floor(arg_38_0 / 10)
		local activity_conf_data = require("data.activity_conf_data")

		if not activity_conf_data[var_38_0] then
			return false
		end

		if tonumber(activity_conf_data[var_38_0].version) ~= 2 then
			return false
		end

		if tonumber(var_38_0 * 10 + 2) ~= tonumber(arg_38_0) then
			return false
		end

		return true
	end] = function(arg_39_0, arg_39_1)
		LayerManager:switchReturnLayer(arg_39_0 == 1150 and "ActivityLevelLayer" or "ActivityLevelBaseLayer", {
			activityid = arg_39_0 == 1152 and 104 or math.floor(arg_39_0 / 10)
		})
	end,
	[function(arg_40_0)
		local var_40_0 = math.floor(arg_40_0 / 10)
		local activity_conf_data = require("data.activity_conf_data")

		if not activity_conf_data[var_40_0] then
			return false
		end

		if tonumber(activity_conf_data[var_40_0].version) ~= 2 then
			return false
		end

		if tonumber(var_40_0 * 10 + 4) ~= tonumber(arg_40_0) then
			return false
		end

		return true
	end] = function(arg_41_0, arg_41_1)
		if not arg_41_1 then
			LayerManager:switchReturnLayer("AutoChessBaseLayer", {
				activityId = math.floor(arg_41_0 / 10)
			})

			return
		elseif not chapter_data[arg_41_1.mode .. "-" .. arg_41_1.chapter + 1] then
			arg_41_1.mode = arg_41_1.mode + 1
			arg_41_1.chapter = 0

			local var_41_0

			if not chapter_data[arg_41_1.mode .. "-" .. arg_41_1.chapter + 1] then
				LayerManager:switchReturnLayer("AutoChessBaseLayer", {
					activityId = math.floor(arg_41_0 / 10)
				})

				do return end

				var_41_0 = {}
			end
		end

		function var_41_0.sureCallback(arg_42_0)
			require("controller.activity_manager"):switchToAutoChessDefence(arg_41_1.mode, arg_41_1.chapter + 1, arg_42_0, function(arg_43_0)
				if arg_43_0.result == 1 then
					RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", modetype)
					FightManager.refreshFightToType(FIGHTTYPE_AUTO_CHESS)
					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
				end
			end)
		end

		var_41_0.mode = arg_41_1.mode
		var_41_0.chapter = arg_41_1.chapter + 1
		var_41_0.activityId = math.floor(arg_41_0 / 10)

		LayerManager:switchReturnLayer("AutoChessSelectLayer", var_41_0)
	end,
	[function(arg_44_0)
		if arg_44_0 == 2010 then
			return true
		end

		if arg_44_0 == 1151 then
			return true
		end

		local var_44_0 = math.floor(arg_44_0 / 10)
		local activity_conf_data = require("data.activity_conf_data")

		if not activity_conf_data[var_44_0] then
			return false
		end

		if tonumber(activity_conf_data[var_44_0].version) ~= 2 then
			return false
		end

		if tonumber(var_44_0 * 10 + 1) ~= tonumber(arg_44_0) then
			return false
		end

		return true
	end] = function(arg_45_0, arg_45_1)
		local activity_manager = require("controller.activity_manager")

		if arg_45_0 == 1151 then
			LayerManager:switchShowLayer("AdventurerVisualLayer", {
				modetype = arg_45_0
			})
		elseif math.floor(arg_45_0 / 10) >= 500 then
			if math.floor(arg_45_0 / 10) == 576 then
				LayerManager:switchShowLayer("ActivityNewBossFightBaseLayer", {
					activityId = math.floor(arg_45_0 / 10)
				})
			else
				LayerManager:switchShowLayer("ActivityBossFightBaseLayer", {
					activityId = math.floor(arg_45_0 / 10)
				})
			end
		else
			LayerManager:switchShowLayer("AdventurerRandomLayer", {
				modetype = arg_45_0
			})
		end
	end,
	[function(arg_46_0)
		if arg_46_0 == 5993 then
			return true
		end
	end] = function(arg_47_0, arg_47_1)
		LayerManager:switchShowLayer("AdventurerInfiniteLayer")
	end,
	[function(arg_48_0)
		local var_48_0 = math.floor(arg_48_0 / 10)

		if not require("data.activity_conf_data")[var_48_0] then
			return false
		end

		if tonumber(var_48_0 * 10 + 6) ~= tonumber(arg_48_0) then
			return false
		end

		return true
	end] = function(arg_49_0, arg_49_1)
		LayerManager:switchShowLayer("ActivityJumptowerBaseLayer", {
			activityId = math.floor(arg_49_0 / 10)
		})
	end,
	[function(arg_50_0)
		return require("controller/urban_defense_manager"):getInstance():isUrbanDefenseModetype(arg_50_0)
	end] = function(arg_51_0, arg_51_1)
		LayerManager:switchShowLayer("UrbanDefenseLayer", {
			activityId = require("controller/urban_defense_manager"):getInstance():getActivityId()
		})
	end,
	[function(arg_52_0)
		local var_52_0 = math.floor(arg_52_0 / 10)

		if not require("data.activity_conf_data")[var_52_0] then
			return false
		end

		if tonumber(var_52_0 * 10 + 7) ~= tonumber(arg_52_0) then
			return false
		end

		return true
	end] = function(arg_53_0, arg_53_1)
		LayerManager:switchShowLayer("ActivityGroupFightLayer", {
			activityId = math.floor(arg_53_0 / 10)
		})
	end,
	[function(arg_54_0)
		if arg_54_0 == 110 then
			return true
		end
	end] = function(arg_55_0, arg_55_1)
		local var_55_0 = RoleDefault:getInstance():getIntegerForKey("EnterWorldBossActivityId", 0)

		if var_55_0 == 0 then
			LayerManager:switchShowLayer("MainLayer")

			return
		end

		LayerManager:switchShowLayer("ActivityWorldBossBaseLayer", {
			activityId = var_55_0
		})
	end
}

function var_0_0.updateGroupFight(arg_56_0)
	FightManager.refreshFightToType(FIGHTTYPE_GROUPFIGHT)
	LayerManager:switchShowLayer("FightLayer", {
		is_hide_topcost = true,
		is_hide_listbutton = true
	})
end

function var_0_0.jumptoGroupTower(arg_57_0)
	FightManager.refreshFightToType(FIGHTTYPE_NORMAL)
	LayerManager:switchShowLayer("ActivityGroupFightLayer", {
		activityId = require("controller.activity_manager"):getGroupActivityID()
	})
end

function var_0_0:returnToNormalFight(arg_58_1, arg_58_2)
	local level_manager = require("controller.level_manager")
	local var_58_3 = FightManager.getCurFightArrayData()

	self:switchToNormalMode(function()
		require("controller.array_manager"):resetHangupArray()

		local var_59_0 = RoleDefault:getInstance():getIntegerForKey("AdventureEnterIndex", 2)

		for iter_59_0, iter_59_1 in pairs(var_0_10) do
			if iter_59_0(var_59_0) then
				iter_59_1(var_59_0, arg_58_2)

				if arg_58_1 then
					arg_58_1()
				end

				return
			end
		end

		LayerManager:switchShowLayer("AdventureNewItemLayer", {
			layer = var_59_0,
			trialtype = RoleDefault:getInstance():getIntegerForKey("AdventureEnterTrialtype", 1),
			result = arg_58_2
		})

		if arg_58_1 then
			arg_58_1()
		end
	end)
end

return var_0_0
