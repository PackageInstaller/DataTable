local var_0_0 = _G
local var_0_1 = print
local var_0_3 = math
local var_0_4 = table
local var_0_5 = string.match
local var_0_6 = tonumber
local var_0_7 = tostring
local var_0_8 = type
local var_0_9 = pairs
local var_0_11 = cc
local var_0_13 = FIGHTSTATE_SEARCHING
local var_0_14 = FIGHTSTATE_WAIT
local var_0_15 = FIGHTSTATE_REFRESH
local var_0_35 = FIGHTTYPE_GUIDE
local var_0_36 = FIGHTTYPE_NORMAL
local var_0_37 = FIGHTTYPE_ADVENTURE
local var_0_38 = FIGHTTYPE_ADVENTURE_TOWER
local var_0_39 = FIGHTTYPE_ARENA
local var_0_41 = FIGHTTYPE_EXPLORE
local var_0_42 = FIGHTTYPE_SCOREARENA
local var_0_43 = FIGHTTYPE_SUBSTITUTION
local var_0_44 = FIGHTTYPE_AIATTACK
local var_0_45 = FIGHTTYPE_SUBSTITUTION_OLD
local var_0_46 = FIGHTTYPE_ARENATFT
local var_0_47 = FIGHTTYPE_INFINITE
local var_0_48 = FIGHTTYPE_TOWER
local var_0_49 = FIGHTTYPE_FRIENDFIGHT
local var_0_50 = FIGHTTYPE_STAKE_PVP
local var_0_51 = FIGHTTYPE_STAKE_PVE
local var_0_52 = FIGHTTYPE_EXPEDITION
local var_0_53 = FIGHTTYPE_EXPEDITION_TOWER
local var_0_54 = FIGHTTYPE_EXPEDITION_MONOPOLY
local var_0_55 = FIGHTTYPE_MONOPOLY
local var_0_56 = FIGHTTYPE_AUTO_CHESS
local var_0_57 = FIGHTTYPE_ROGUEEXPLORE
local var_0_58 = FIGHTTYPE_GROUPFIGHT
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local arena_manager = require("controller.arena_manager")
local scorearena_manager = require("controller.scorearena_manager")
local FightEventManager = require("fight.FightEventManager")
local parse_server = require("controller.parse_server")
local var_0_65 = _G.AnalyticManager
local explore_manager = require("controller.explore_manager")
local rogue_explore_manager = require("controller.rogue_explore_manager")
local barrage_manager = require("controller.barrage_manager")
local monster_manager = require("controller.monster_manager")
local substitution_manager = require("controller.substitution_manager")
local aiattack_manager = require("controller.aiattack_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local arenatft_manager = require("controller.arenatft_manager")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local friend_system_manager = require("controller.friend_system_manager")
local texture_manager = require("controller.texture_manager")
local expedition_manager = require("controller.expedition_manager")
local activity_manager = require("controller.activity_manager")
local array_manager = require("controller.array_manager")
local var_0_81 = {
	[24] = true,
	[23] = true,
	[FIGHTTYPE_ADVENTURE] = true,
	[FIGHTTYPE_ADVENTURE_TOWER] = true,
	[FIGHTTYPE_EXPLORE] = true,
	[FIGHTTYPE_SUBSTITUTION] = true,
	[FIGHTTYPE_AIATTACK] = true,
	[FIGHTTYPE_SUBSTITUTION_OLD] = true,
	[FIGHTTYPE_INFINITE] = true,
	[FIGHTTYPE_TOWER] = true,
	[FIGHTTYPE_STAKE_PVP] = true,
	[FIGHTTYPE_STAKE_PVE] = true,
	[FIGHTTYPE_EXPEDITION] = true,
	[FIGHTTYPE_EXPEDITION_TOWER] = true,
	[FIGHTTYPE_EXPEDITION_MONOPOLY] = true,
	[FIGHTTYPE_MONOPOLY] = true,
	[FIGHTTYPE_AUTO_CHESS] = true,
	[FIGHTTYPE_ROGUEEXPLORE] = true,
	[FIGHTTYPE_GROUPFIGHT] = true
}
local var_0_82 = {
	[FIGHTTYPE_ARENA] = true,
	[FIGHTTYPE_SCOREARENA] = true,
	[FIGHTTYPE_ARENATFT] = true,
	[FIGHTTYPE_FRIENDFIGHT] = true
}
local var_0_83 = {
	[FIGHTTYPE_STAKE_PVP] = true,
	[FIGHTTYPE_STAKE_PVE] = true
}

return function(arg_1_0)
	return setfenv(function()
		fighttype = nil
		pvpfighting = false
		pvefighting = false
		fightingBigBoss = false
		refightingBigBoss = false
		fightingNormalBoss = false
		fightingActivityBoss = false
		fightRound = 1
		needGuideFight = false

		function isFightingBoss()
			return fightingBigBoss or fightingNormalBoss
		end

		function searchForBoss()
			var_0_1("search For Boss is Deprecated!!!, please use startFightBigBoss")
		end

		function isNormalFight()
			return not pvpfighting and not pvefighting
		end

		function isPVEFight()
			return pvefighting
		end

		function isPVPFight()
			return pvpfighting
		end

		function isFakeFight()
			return var_0_83[fighttype]
		end

		function isPVEFightType(arg_9_0)
			return var_0_81[arg_9_0]
		end

		function isPVPFightType(arg_10_0)
			return var_0_82[arg_10_0]
		end

		function isGuideFight()
			return fighttype == var_0_35
		end

		function needGuideUseXP()
			return needGuideFight and not var_0_0.GuideListener.isGuideFinish(var_0_0.TRIGGER_FIGHT, var_0_0.GUIDE_FIGHT_USEXP_CLASS)
		end

		function isBigBossFight()
			return fightingBigBoss
		end

		function isBigBossRefight()
			return fightingBigBoss and refightingBigBoss
		end

		function isHangupFighting()
			return level_manager:isCurChapterOld() or level_manager:isChapterComplete() or level_manager:isBigBossNow()
		end

		function getFightType()
			return fighttype
		end

		function isPvp()
			return var_0_82[fighttype]
		end

		function canSwitchFight()
			return not pvpfighting and not pvefighting and not fightingBigBoss
		end

		function switchFight(arg_19_0)
			if fighttype == arg_19_0 and fighttype ~= var_0_43 then
				return false
			end

			pvefighting = isPVEFightType(arg_19_0)
			pvpfighting = isPVPFightType(arg_19_0)
			fightingBigBoss = false
			refightingBigBoss = false
			fightingNormalBoss = false
			fighttype = arg_19_0

			setFightState(var_0_15)

			return true
		end

		function refreshFightToType(arg_20_0, arg_20_1)
			if not switchFight(arg_20_0) then
				return false
			end

			refreshAtOnce(arg_20_1)
			fightconsoleRef:createFightLoadIngAni()

			return true
		end

		function refreshFightToTypeForce(arg_21_0, arg_21_1)
			if arg_21_0 == fighttype then
				refreshAtOnce(arg_21_1)

				return true
			else
				return refreshFightToType(arg_21_0, arg_21_1)
			end
		end

		function updateHangupStatus()
			level_manager:cleanHangupCount()

			if level_manager:isCurChapterOld() then
				return
			end

			if level_manager:isChapterComplete() then
				return
			end

			if level_manager:isBigBossNow() then
				return
			end

			if level_manager:isHangupComplete() then
				startFightNormalBoss()
			end
		end

		function addHangupStatus()
			if level_manager:isCurChapterOld() then
				return false
			end

			if level_manager:isChapterComplete() then
				return false
			end

			if level_manager:isBigBossNow() then
				return false
			end

			if level_manager:addHangupCount() then
				startFightNormalBoss()

				return false
			end

			return true
		end

		function startFightNormalBoss()
			fightingNormalBoss = true
			fightingBigBoss = false
			refightingBigBoss = false

			setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE)
			playerResetOnFightboss()
		end

		function startFightBigBoss()
			fightingBigBoss = true
			refightingBigBoss = false
			fightingNormalBoss = false

			level_manager:resetBigBoosFightDieTbl()
			refreshAtOnce()

			needGuideFight = fighttype ~= var_0_35 and var_0_0.GuideListener.isNeedGuideFight()

			var_0_65.startLevel(playermodel.curMode, playermodel.curLevel)
		end

		function startRefightBigBoss()
			fightingBigBoss = true
			refightingBigBoss = true
			fightingNormalBoss = false

			level_manager:resetBigBoosFightDieTbl()
			refreshAtOnce()

			needGuideFight = fighttype ~= var_0_35 and var_0_0.GuideListener.isNeedGuideFight()

			var_0_65.startLevel(playermodel.curMode, playermodel.curLevel)
		end

		function startFightActivityBossRound(arg_27_0)
			fightingActivityBoss = true
			fightRound = arg_27_0
		end

		function endFightActivityBossRound()
			fightingActivityBoss = false
			fightRound = 1
		end

		function fightActivityData()
			return {
				fightingActivityBoss = fightingActivityBoss,
				fightRound = fightRound,
				activityId = activityId
			}
		end

		function onNormalFightSuccess()
			FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_SUCCESS)
			setFightState(var_0_13)
		end

		local function var_2_0()
			doResetFightTimeEnabled(true)
			setFightState(var_0_14)

			needGuideFight = false

			stopStatistics()
			var_0_65.fightAdventureFail({
				mode = playermodel.curMode,
				mode_chapter = playermodel.curMode .. "-" .. var_0_5(playermodel.curLevel, "(%d+)-(%d+)"),
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class,
				servants = getCurFightArrayData(),
				time = getFightTimeStatistics(),
				speedup = var_0_7(getBossSpeedUpForce()),
				autoxp = playermodel.autoXP and "Yes" or "No"
			})
			parse_server:passAdventureFail(playermodel.curMode, var_0_3.floor(getFightTimeStatistics()), 1)
			battlefieldRef:adventureFightFail(function()
				level_manager:returnToNormalFight(function()
					switchFight(var_0_36)
				end)
			end)
		end

		local function var_2_1(arg_78_0)
			doResetFightTimeEnabled(true)
			setFightState(var_0_14)

			local function var_78_0()
				level_manager:returnToNormalFight(function()
					switchFight(var_0_36)
				end, 0)
			end

			expedition_manager:fightResult({
				battleresult = 0
			}, function()
				battlefieldRef:expeditionFightFail(var_78_0)
			end)
		end

		onFightFail = {
			[var_0_36] = function(arg_31_0)
				doResetFightTimeEnabled(true)
				setFightState(var_0_14)
				stopCamera()

				needGuideFight = false

				stopStatistics()

				if isBigBossFight() then
					local var_31_0 = refightingBigBoss

					battlefieldRef:bossFightFail(function(arg_32_0)
						if arg_32_0 then
							level_manager:resetRefightArray()
							setFightState(var_0_13)
							setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
							refreshAtOnce()
							resetFightTimeStatistics()
						else
							fightingBigBoss = false
							refightingBigBoss = false

							fightconsoleRef:switchToMap()
							level_manager.reset_boss_team_proceed()

							if var_31_0 then
								resetCamera()
								resetFightWorldMap()
								initPlayer()
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								setFightState(var_0_13)
								updateHangupStatus()
								fightconsoleRef:updateCurrentChapterInfo()
								FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_FAIL)
							end

							local var_32_0

							do
								resetCamera()
								resetFightWorldMap()
								initPlayer()
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								setFightState(var_0_13)
								updateHangupStatus()
								FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_FAIL)

								var_32_0 = arg_31_0 and 2 or 1
							end
						end

						parse_server:passLevelFail(playermodel.curMode, var_0_6((var_0_5(playermodel.curLevel, "(%d+)-(%d+)"))), var_0_3.floor(getFightTimeStatistics()), var_32_0)
					end)

					local var_31_1 = var_0_5(playermodel.curLevel, "(%d+)-(%d+)")

					var_0_65[arg_31_0 and "fightBigBossSurrender" or "fightBigBossFail"]({
						mode_chapter = playermodel.curMode .. "-" .. playermodel.curLevel,
						rolenum = playermodel:getOwnedServantNum(),
						grade = playermodel.grade,
						class = playermodel.class,
						servants = getCurFightArrayData(),
						time = getFightTimeStatistics()
					})
				else
					if fightingNormalBoss then
						var_0_65.fightNormalBossFail({
							mode_chapter = playermodel.curMode .. "-" .. var_0_5(playermodel.curLevel, "(%d+)-(%d+)"),
							rolenum = playermodel:getOwnedServantNum(),
							grade = playermodel.grade,
							class = playermodel.class,
							servants = getCurFightArrayData(),
							time = getFightTimeStatistics()
						})
					end

					fightingNormalBoss = false

					level_manager:cleanHangupCount()
					battlefieldRef:normalFightFail(function()
						resetCamera()
						resetFightWorldMap()
						initPlayer()
						setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
						setFightState(var_0_13)
						updateHangupStatus()
						parse_server:passLevelFail(playermodel.curMode, var_0_6((var_0_5(playermodel.curLevel, "(%d+)-(%d+)"))), var_0_3.floor(getFightTimeStatistics()), arg_31_0 and 2 or 1)
					end)
				end
			end,
			[var_0_37] = var_2_0,
			[var_0_38] = var_2_0,
			[var_0_39] = function(arg_37_0)
				local var_37_0 = arena_manager:getCurArenaData()
				local var_37_1

				if var_37_0.otherinfo and var_37_0.otherinfo.enemyRank then
					var_37_1 = var_37_0.otherinfo.enemyRank
				end

				local var_37_2 = 0
				local var_37_3 = 0

				if not arg_37_0 then
					local var_37_4 = {
						area_ememy_rank = var_37_1
					}

					for iter_37_0, iter_37_1 in var_0_9(var_37_0.enemyarray) do
						if var_0_8(iter_37_1) == "table" and iter_37_1.servantid then
							var_37_4["area_ememy_rolen" .. iter_37_0 .. "_id"] = iter_37_1.servantid
							var_37_2 = var_37_2 + 1

							if iter_37_1.horcrux and iter_37_1.horcrux.itemid then
								var_37_4["area_ememy_subrole" .. iter_37_0 .. "_id"] = iter_37_1.horcrux.itemid
								var_37_3 = var_37_3 + 1
							end
						end
					end

					var_37_4.area_ememy_rolenum = var_37_2
					var_37_4.area_ememy_subrolenum = var_37_3

					var_0_65.arean_tzfail(var_37_4)
				else
					local var_37_5 = {
						area_ememyrank = var_37_1
					}

					for iter_37_2, iter_37_3 in var_0_9(var_37_0.enemyarray) do
						if var_0_8(iter_37_3) == "table" and iter_37_3.servantid then
							var_37_5["area_ememy_rolen" .. iter_37_2 .. "_id"] = iter_37_3.servantid
							var_37_2 = var_37_2 + 1

							if iter_37_3.horcrux and iter_37_3.horcrux.itemid then
								var_37_5["area_ememy_subrole" .. iter_37_2 .. "_id"] = iter_37_3.horcrux.itemid
								var_37_3 = var_37_3 + 1
							end
						end
					end

					var_37_5.area_ememy_rolenum_rs = var_37_2
					var_37_5.area_subrolenum_rs = var_37_3

					var_0_65.click_arean_renshu(var_37_5)
				end

				setFightState(var_0_14)
				stopStatistics()

				needGuideFight = false

				local function var_37_6()
					switchFight(var_0_36)
				end

				arena_manager:fightFail(function(arg_39_0, arg_39_1, arg_39_2)
					battlefieldRef:arenaFightFail(arg_39_0, arg_39_1, arg_39_2, var_37_6)
				end, arg_37_0)
			end,
			[var_0_42] = function(arg_40_0)
				setFightState(var_0_14)
				stopStatistics()

				needGuideFight = false

				local function var_40_0()
					switchFight(var_0_36)
				end

				scorearena_manager:fightFail(function(arg_42_0, arg_42_1)
					battlefieldRef:scoreArenaFightFail(arg_42_0, arg_42_1, var_40_0)
				end, arg_40_0)
			end,
			[var_0_35] = function()
				setFightState(var_0_14)
				stopCamera()

				needGuideFight = false

				stopStatistics()
				var_0_0.require("devtools.fight_test_bridge"):fightFail()
				removeAllElements()
			end,
			[var_0_41] = function(arg_44_0)
				setFightState(var_0_14)
				stopStatistics()

				needGuideFight = false

				local function var_44_0()
					switchFight(var_0_36)
				end

				local function var_44_1()
					battlefieldRef:exploreFightFail(var_44_0)
				end

				if arg_44_0 then
					explore_manager:fightSurrender(var_44_1)
				else
					explore_manager:fightFail(var_44_1)
				end
			end,
			[var_0_43] = function()
				var_0_1("substitution fight fail.....")
				setFightState(var_0_14)
				stopStatistics()

				local function var_50_0()
					level_manager:switchToNormalMode(function()
						switchFight(var_0_36)
					end, 1)
				end

				substitution_manager:fightFail(playermodel.curMode, function(arg_53_0)
					battlefieldRef:substitutionFightPass(arg_53_0, var_50_0, 0)
				end)
			end,
			[var_0_44] = function()
				doResetFightTimeEnabled(true)
				setFightState(var_0_14)

				local function var_58_0()
					level_manager:switchToNormalMode(function()
						switchFight(var_0_36)
					end, 1)
				end

				aiattack_manager:fightFail(function()
					battlefieldRef:aiAttackFightFail(var_58_0)
				end)
			end,
			[var_0_45] = function()
				var_0_1("substitution fight fail.....")
				setFightState(var_0_14)

				local function var_54_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, 1)
				end

				old_substitution_manager:passSubstitution(function(arg_57_0)
					var_0_1("passcallback======== ")
					battlefieldRef:oldSubstitutionFightPass(arg_57_0, var_54_0)
				end)
			end,
			[var_0_46] = function()
				setFightState(var_0_14)
				stopStatistics()

				local function var_62_0()
					switchFight(var_0_36)
				end

				arenatft_manager:fightFail(function(arg_64_0)
					battlefieldRef:arenatftFightFail(arg_64_0, var_62_0)
				end)
			end,
			[var_0_47] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_65_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end)
				end

				infinite_fight_manager:fightFail(playermodel.curMode, function(arg_68_0, arg_68_1)
					battlefieldRef:infiniteFightFail(arg_68_1, var_65_0)
				end)
			end,
			[var_0_48] = function(arg_69_0)
				doResetFightTimeEnabled(true)
				setFightState(var_0_14)

				local function var_69_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, 1)
				end

				tower_defence_manager:fightFail(arg_69_0, function()
					battlefieldRef:towerFightFail(var_69_0)
				end)
			end,
			[var_0_49] = function()
				setFightState(var_0_14)
				stopStatistics()

				local function var_73_0()
					switchFight(var_0_36)
				end

				friend_system_manager:fightFail(function(arg_75_0)
					battlefieldRef:arenaFrinedFightFail(arg_75_0, var_73_0)
				end)
			end,
			[var_0_50] = function()
				setFightState(var_0_14)
				stopStatistics()
				switchFight(var_0_36)
				battlefieldRef:onFightStakePvpFail()
			end,
			[var_0_51] = function()
				setFightState(var_0_14)
				stopStatistics()
				switchFight(var_0_36)
				battlefieldRef:onFightStakePveFail()
			end,
			[var_0_52] = var_2_1,
			[var_0_53] = var_2_1,
			[var_0_54] = var_2_1,
			[var_0_55] = function(...)
				var_0_1("Mono Fight Fail!!!!!!!!!!!")
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.monopoly.monopoly_manager"):getInstance():fightFail()
				switchFight(var_0_36)
			end,
			[var_0_56] = function(arg_83_0)
				doResetFightTimeEnabled(true)
				setFightState(var_0_14)

				local function var_83_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end)
				end

				activity_manager:autoChessFightFail(arg_83_0, function()
					battlefieldRef:autoChessFightFail(var_83_0)
				end)
			end,
			[var_0_57] = function(arg_47_0)
				setFightState(var_0_14)
				stopStatistics()

				needGuideFight = false

				local function var_47_0()
					switchFight(var_0_36)
				end

				local function var_47_1()
					battlefieldRef:rogueExploreFightFail(var_47_0)
				end

				if arg_47_0 then
					rogue_explore_manager:fightSurrender(var_47_1)
				else
					rogue_explore_manager:fightFail(var_47_1)
				end
			end,
			[var_0_58] = function()
				doResetFightTimeEnabled(true)
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()
				battlefieldRef:groupFightFail(function()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, 1)
					level_manager:jumptoGroupTower(activity_manager:getGroupActivityID())
				end)
			end,
			[23] = function(...)
				var_0_1("FLYCHESS Fight Fail!!!!!!!!!!!")
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.activity_manager"):flychessFightFail()
				switchFight(var_0_36)
			end,
			[24] = function(...)
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.activity_manager"):worldbossFightFail()
				level_manager:switchToNormalMode(function()
					switchFight(var_0_36)
				end)
			end
		}

		local function var_2_2()
			setFightState(var_0_14)

			needGuideFight = false

			if level_manager.isBossTeamFinished() then
				doResetFightTimeEnabled(true)

				local var_102_0 = playermodel.curMode
				local var_102_1 = playermodel.curLevel
				local var_102_2, var_102_3 = playermodel.curLevel:match("(%d+)-(%d+)")
				local var_102_4 = var_0_6(var_102_2) < playermodel.levelmode[playermodel.curMode].status

				stopStatistics()

				local function var_102_5()
					if var_102_4 then
						level_manager:returnToNormalFight(function()
							switchFight(var_0_36)
						end)
					else
						FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_ADVENTURE_PASSLEVEL, function()
							level_manager:returnToNormalFight(function()
								switchFight(var_0_36)
							end)
						end)
					end
				end

				local function var_102_6(arg_107_0)
					if arg_107_0 ~= 1 then
						var_102_5()

						return
					end

					playerResetOnFightBossWin()
					setFightState(var_0_14)
					changeLevel()
					setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE + 1000)

					local function var_107_0()
						setFightState(var_0_13)
					end

					local var_107_1 = checkSpineRes()

					if #var_107_1 > 0 then
						local var_107_2 = var_0_11.EventCustom:new("DOWNLOAD_FIGHT_RESOURCE")

						var_107_2.id = yield(var_107_0)
						var_107_2.list = var_107_1

						var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent(var_107_2)
					else
						removeyield()
						var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent((var_0_11.EventCustom:new("CANCEL_DOWNLOAD_FIGHT_RESOURCE")))
						var_107_0()
					end
				end

				local function var_102_7()
					level_manager:switchToAdventureMode(var_102_0, level_manager:isLevelModeComplete(var_102_0, var_0_6(var_102_2)) and var_0_6(var_102_2) or var_0_6(var_102_2) + 1, var_102_6, (var_0_0.RoleDefault:getInstance():getIntegerForKey("lastadventurearray", 1)))
				end

				local function var_102_8()
					level_manager:switchToAdventureMode(var_102_0, var_0_6(var_102_2), var_102_6, (var_0_0.RoleDefault:getInstance():getIntegerForKey("lastadventurearray", 1)))
				end

				parse_server:passAdventure(playermodel.curMode, function(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
					arg_111_2 = arg_111_2 or 1000

					battlefieldRef:adventureFightSuccess(var_102_0, var_102_1, {
						continuecallback = var_102_7,
						cancelcallback = var_102_5,
						refightcallback = var_102_8,
						data = arg_111_1,
						isrefight = var_102_4,
						remainfighttime = arg_111_2,
						canbuytime = arg_111_3
					})

					local var_111_0 = var_0_5(var_102_1, "(%d+)-(%d+)")

					var_0_65.fightAdventureSuccess({
						mode = var_102_0,
						mode_chapter = var_102_0 .. "-" .. var_111_0,
						rolenum = playermodel:getOwnedServantNum(),
						grade = playermodel.grade,
						class = playermodel.class,
						servants = getCurFightArrayData(),
						time = getFightTimeStatistics(),
						isfirstpass = isfirstpass,
						speedup = var_0_7(getBossSpeedUpForce()),
						autoxp = playermodel.autoXP and "Yes" or "No",
						star = level_manager:getChapterStarsCount(var_102_0, var_111_0)
					})
				end, getFightTimeStatistics())
			else
				fightconsoleRef:createWaveAnim()
				doResetFightTimeEnabled(false)
				setFightState(var_0_13)

				if level_manager:isBossTeam() ~= false and level_manager:isBossTeamLastButOne() and monster_manager.isBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)) then
					setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE + 1300)
				else
					setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE)
				end
			end
		end

		local function var_2_3(arg_158_0)
			setFightState(var_0_14)

			needGuideFight = false

			doResetFightTimeEnabled(true)

			local var_158_0 = playermodel.curMode
			local var_158_1, var_158_2 = playermodel.curLevel:match("(%d+)-(%d+)")

			local function var_158_3()
				removeAllElements()
				level_manager:returnToNormalFight(function()
					resumeBattleField()
					switchFight(var_0_36)
				end, 1)
			end

			expedition_manager:fightResult({
				battleresult = 1
			}, function(arg_161_0, arg_161_1)
				battlefieldRef:expeditionFightPass(var_158_3, arg_161_1, var_0_6(var_158_0), var_0_6(var_158_1))
			end)
		end

		onFightSuccess = {
			[var_0_36] = function()
				FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_SUCCESS)
				setFightState(var_0_14)

				needGuideFight = false

				if isBigBossFight() then
					if level_manager.isBossTeamFinished() then
						doResetFightTimeEnabled(true)

						local var_93_0 = playermodel.curMode
						local var_93_1 = playermodel.curLevel

						local function var_93_2(arg_94_0)
							if arg_94_0 then
								fightconsoleRef:resetDamageAddition()
								setFightState(var_0_13)
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								refreshAtOnce()
							else
								fightingBigBoss = false
								refightingBigBoss = false

								setFightState(var_0_13)
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								level_manager:cleanHangupCount()
								refreshAtOnce()
								fightconsoleRef:switchToMap(var_93_0)
								fightconsoleRef:updateCurrentChapterInfo()
							end
						end

						local function var_93_3(arg_95_0, arg_95_1)
							if arg_95_0 then
								refightingBigBoss = true

								level_manager:resetRefightArray()
								fightconsoleRef:resetDamageAddition()
								setFightState(var_0_13)
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								refreshAtOnce()
							else
								fightingBigBoss = false
								refightingBigBoss = false

								playerResetOnFightBossWin()
								setFightState(var_0_13)
								setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
								level_manager:cleanHangupCount()

								if not level_manager:isLevelModeComplete(playermodel.curMode, (level_manager:getCurChapter(playermodel.curMode))) then
									if arg_95_1 then
										fightconsoleRef:unlockNextChapter(function()
											fightconsoleRef:goToNextChapter()
											arg_95_1()
										end)
									else
										fightconsoleRef:switchToMap()
										fightconsoleRef:unlockNextChapter(function()
											fightconsoleRef:goToNextChapter()
										end)
									end
								elseif arg_95_1 then
									fightconsoleRef:goToNextCity(arg_95_1)
								else
									fightconsoleRef:goToNextCity()
									fightconsoleRef:switchToMap(var_93_0)
								end
							end
						end

						local function var_93_4()
							fightconsoleRef:startFight()
						end

						local function var_93_5(arg_99_0)
							local var_99_0

							if refightingBigBoss then
								var_99_0 = var_93_2

								local var_99_1

								if not var_93_2 then
									var_99_0 = var_93_3
									var_99_1 = {}
								end
							end

							var_99_1.continuecallback = var_93_4
							var_99_1.playcallback = var_99_0

							battlefieldRef:bossFightSuccess(var_93_0, var_93_1, var_99_1, arg_99_0)

							local var_99_2 = var_0_5(var_93_1, "(%d+)-(%d+)")

							var_0_65.fightBigBossSuccess({
								mode_chapter = var_93_0 .. "-" .. var_99_2,
								rolenum = playermodel:getOwnedServantNum(),
								grade = playermodel.grade,
								class = playermodel.class,
								servants = getCurFightArrayData(),
								time = getFightTimeStatistics(),
								isrefight = refightingBigBoss,
								speedup = var_0_7(getBossSpeedUpForce()),
								autoxp = playermodel.autoXP and "Yes" or "No",
								star = level_manager:getChapterStarsCount(var_93_0, var_99_2)
							})
						end

						if isBigBossRefight() then
							parse_server:passLevelAgain(playermodel.curMode, playermodel.curLevel, var_93_5)
						else
							parse_server:passLevel(playermodel.curMode, playermodel.curLevel, var_93_5)
						end
					else
						fightconsoleRef:createWaveAnim()
						doResetFightTimeEnabled(false)
						setFightState(var_0_13)

						if level_manager:isBossTeam() ~= false and level_manager:isBossTeamLastButOne() and monster_manager.isBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)) then
							setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE + 1300)
						else
							setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
						end
					end
				else
					stopStatistics()

					fightingNormalBoss = false

					local var_93_6 = playermodel.curMode
					local var_93_7 = playermodel.curLevel

					local function var_93_8()
						if var_93_6 ~= playermodel.curMode then
							return
						end

						if not isNormalFight() then
							return
						end

						if isBigBossFight() then
							return
						end

						playerResetOnFightBossWin()

						if level_manager:isBigBossNow() then
							setFightState(var_0_13)
							setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
							changeLevel()
							fightconsoleRef:onFindBigBoss()
						else
							setFightState(var_0_13)
							setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)
							changeLevel()
							fightconsoleRef:onPassNormalBoss()
						end
					end

					parse_server:passLevel(playermodel.curMode, playermodel.curLevel, function()
						battlefieldRef:normalFightSuccess(var_93_6, var_93_7, var_93_8)
						var_0_65.fightNormalBossSuccess({
							mode_chapter = var_93_6 .. "-" .. var_0_5(var_93_7, "(%d+)-(%d+)"),
							rolenum = playermodel:getOwnedServantNum(),
							grade = playermodel.grade,
							class = playermodel.class,
							servants = getCurFightArrayData(),
							time = getFightTimeStatistics()
						})
					end)
				end
			end,
			[var_0_37] = var_2_2,
			[var_0_38] = var_2_2,
			[var_0_39] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_117_0()
					switchFight(var_0_36)
				end

				arena_manager:fightSuccess(function(arg_119_0, arg_119_1, arg_119_2)
					battlefieldRef:arenaFightSuccess(arg_119_0, arg_119_1, arg_119_2, var_117_0)
				end)
			end,
			[var_0_42] = function()
				setFightState(var_0_14)
				stopStatistics()

				needGuideFight = false

				local function var_120_0()
					switchFight(var_0_36)
				end

				scorearena_manager:fightSuccess(function(arg_122_0, arg_122_1, arg_122_2, arg_122_3, arg_122_4)
					battlefieldRef:scoreArenaFightSuccess(arg_122_0, arg_122_1, arg_122_2, arg_122_4, var_120_0)
				end)
			end,
			[var_0_35] = function()
				setFightState(var_0_14)
				stopCamera()

				needGuideFight = false

				stopStatistics()
				var_0_0.require("devtools.fight_test_bridge"):fightSuccess()
				removeAllElements()
			end,
			[var_0_41] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_124_0()
					switchFight(var_0_36)
				end

				explore_manager:fightSuccess(function()
					battlefieldRef:exploreFightSuccess(var_124_0)
				end)
			end,
			[var_0_43] = function()
				var_0_1("substitution fight success....")
				setFightState(var_0_14)
				stopStatistics()

				local function var_130_0()
					level_manager:switchToNormalMode(function()
						switchFight(var_0_36)
					end, 1)
				end

				substitution_manager:fightSuccess(playermodel.curMode, function(arg_133_0)
					battlefieldRef:substitutionFightPass(arg_133_0, var_130_0, 1)
				end)
			end,
			[var_0_44] = function()
				var_0_1("aiattack fight success....")
				setFightState(var_0_14)

				needGuideFight = false

				if level_manager.isBossTeamFinished() then
					doResetFightTimeEnabled(true)

					local function var_134_0()
						level_manager:switchToNormalMode(function()
							switchFight(var_0_36)
						end, 1)
					end

					aiattack_manager:fightSuccess(function(arg_137_0, arg_137_1, arg_137_2)
						var_0_1("passcallback======== ")
						battlefieldRef:aiAttackFightPass(var_134_0, arg_137_1, arg_137_2)
					end, true)
				else
					fightconsoleRef:createWaveAnim()
					doResetFightTimeEnabled(false)
					setFightState(var_0_13)

					if level_manager:isBossTeam() ~= false and level_manager:isBossTeamLastButOne() and monster_manager.isBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)) then
						setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE + 1300)
					else
						setSearchDistance(var_0_0.ADVENTURE_SEARCH_DISTANCE)

						for iter_134_0, iter_134_1 in var_0_9(players) do
							var_0_1(iter_134_1:getState())
						end
					end
				end
			end,
			[var_0_45] = function()
				var_0_1("substitution fight success....")
				setFightState(var_0_14)

				local function var_138_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, 1)
				end

				old_substitution_manager:passSubstitution(function(arg_141_0)
					var_0_1("passcallback======== ")
					battlefieldRef:oldSubstitutionFightPass(arg_141_0, var_138_0)
				end, true)
			end,
			[var_0_46] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_142_0()
					switchFight(var_0_36)
				end

				arenatft_manager:fightSuccess(function(arg_144_0)
					battlefieldRef:arenatftFightSuccess(arg_144_0, var_142_0)
				end)
			end,
			[var_0_47] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_145_0()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end)
				end

				infinite_fight_manager:fightSuccess(playermodel.curMode, function(arg_148_0, arg_148_1)
					if arg_148_0 == 1 then
						battlefieldRef:infiniteFightSuccess(arg_148_1, var_145_0)
					elseif arg_148_0 == 2 then
						setFightState(var_0_13)
						setSearchDistance(10)
						changeLevel()
						fightconsoleRef:createInfinteWaveAnim()
						fightconsoleRef:updateInfinteAddScore()

						local var_148_0 = {}

						if playermodel.curLevel then
							for iter_148_0 in playermodel.curLevel:gmatch("([^-]+)") do
								var_0_4.insert(var_148_0, var_0_6(iter_148_0))
							end

							if var_148_0[1] then
								fightconsoleRef:updateChapterBattleFieldStatusInfo(playermodel.curMode, var_148_0[1], true)
							end
						end
					end
				end)
			end,
			[var_0_48] = function()
				setFightState(var_0_14)

				needGuideFight = false

				doResetFightTimeEnabled(true)

				local var_149_0 = playermodel.curMode
				local var_149_1, var_149_2 = playermodel.curLevel:match("(%d+)-(%d+)")

				local function var_149_3()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, 1)
				end

				tower_defence_manager:fightSuccess(function(arg_152_0, arg_152_1)
					battlefieldRef:towerDefenceFightPass(var_149_3, arg_152_1, var_0_6(var_149_0), var_0_6(var_149_1))
				end, true)
			end,
			[var_0_49] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_153_0()
					switchFight(var_0_36)
				end

				friend_system_manager:fightSuccess(function(arg_155_0)
					battlefieldRef:arenaFrinedFightSuccess(arg_155_0, var_153_0)
				end)
			end,
			[var_0_50] = function()
				setFightState(var_0_14)
				stopStatistics()
				switchFight(var_0_36)
				battlefieldRef:onFightStakePvpSuccess(resultdata, callback)
			end,
			[var_0_51] = function()
				setFightState(var_0_14)
				stopStatistics()
				switchFight(var_0_36)
				battlefieldRef:onFightStakePveSuccess(resultdata, callback)
			end,
			[var_0_52] = var_2_3,
			[var_0_53] = var_2_3,
			[var_0_54] = var_2_3,
			[var_0_55] = function(...)
				var_0_1("Mono Fight Success!!!!!!!!!!!")
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.monopoly.monopoly_manager"):getInstance():fightSuccess()
				switchFight(var_0_36)
			end,
			[var_0_56] = function(...)
				setFightState(var_0_14)

				needGuideFight = false

				doResetFightTimeEnabled(true)

				local var_163_0 = playermodel.curMode
				local var_163_1, var_163_2 = playermodel.curLevel:match("(%d+)-(%d+)")

				local function var_163_3()
					level_manager:returnToNormalFight(function()
						switchFight(var_0_36)
					end, {
						chapter = var_163_1,
						mode = var_163_0
					})
				end

				activity_manager:autoChessFightSuccess(function(arg_166_0, arg_166_1)
					battlefieldRef:autoChessFightSuccess(var_163_3, arg_166_1, var_0_6(var_163_0), var_0_6(var_163_1))
				end, true)
			end,
			[var_0_57] = function()
				setFightState(var_0_14)

				needGuideFight = false

				stopStatistics()

				local function var_127_0()
					switchFight(var_0_36)
				end

				rogue_explore_manager:fightSuccess(function()
					battlefieldRef:rogueExploreFightSuccess(var_127_0)
				end)
			end,
			[var_0_58] = function()
				needGuideFight = false

				activity_manager:getGroupIndexNumUp()

				if activity_manager:getGroupIndexNum() > activity_manager:getGroupNum() then
					activity_manager:getGroupIndexNumRestart()
					doResetFightTimeEnabled(true)

					local var_112_0 = playermodel.curMode
					local var_112_1, var_112_2 = playermodel.curLevel:match("(%d+)-(%d+)")
					local var_112_3 = {}

					for iter_112_0, iter_112_1 in var_0_9(activity_manager:getGroupTowerArray()) do
						if iter_112_1.fight_girl then
							var_0_4.insert(var_112_3, iter_112_1.fight_girl)
						end
					end

					local var_112_4 = var_112_3[var_0_3.random(1, #var_112_3)]

					stopStatistics()
					setFightState(var_0_14)

					local function var_112_5()
						level_manager:returnToNormalFight(function()
							switchFight(var_0_36)
						end, 1)
					end

					local function var_112_6()
						local var_115_0 = level_manager:isLevelModeComplete(var_112_0, var_0_6(var_112_1)) and var_0_6(var_112_1) or var_0_6(var_112_1) + 1

						switchFight(var_0_36)

						local var_115_1 = var_0_0.RoleDefault:getInstance():getIntegerForKey("lastadventurearray", 1)

						level_manager:switchToGroupFightMode(var_112_0, var_115_0, var_112_5)
					end

					local var_112_7 = playermodel.curMode
					local var_112_8 = playermodel.curLevel
					local var_112_9, var_112_10 = playermodel.curLevel:match("(%d+)-(%d+)")
					local var_112_11 = var_0_6(var_112_9) < playermodel.levelmode[playermodel.curMode].status

					parse_server:passAdventure(playermodel.curMode, function(arg_116_0, arg_116_1, arg_116_2)
						arg_116_2 = arg_116_2 or 1000

						battlefieldRef:groupFightSuccess(var_112_7, var_112_8, {
							modelid = var_112_4,
							continuecallback = var_112_6,
							data = arg_116_1,
							isrefight = var_112_11,
							remainfighttime = arg_116_2,
							cancelcallback = var_112_5
						})
					end, getFightTimeStatistics())
				else
					switchFight(var_0_36)
					level_manager:updateGroupFight()
				end
			end,
			[23] = function(...)
				var_0_1("flychess Fight Success!!!!!!!!!!!")
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.activity_manager"):flychessFightSuccess()
				switchFight(var_0_36)
			end,
			[24] = function(...)
				var_0_1("worldboss Fight Success!!!!!!!!!!!")
				setFightState(var_0_14)
				stopStatistics()
				var_0_0.require("controller.activity_manager"):worldbossFightSuccess()
				level_manager:switchToNormalMode(function()
					switchFight(var_0_36)
				end)
			end
		}

		local var_2_4 = {
			[var_0_36] = var_0_0.INIT_SEARCH_DISTANCE,
			[var_0_37] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_38] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_39] = 0,
			[var_0_42] = var_0_0.ARENA_SEARCH_DISTANCE,
			[var_0_41] = var_0_0.EXPLORE_SEARCH_DISTANCE,
			[var_0_43] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_44] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_45] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_46] = var_0_0.ARENA_SEARCH_DISTANCE,
			[var_0_47] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_48] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_49] = var_0_0.ARENA_SEARCH_DISTANCE,
			[var_0_50] = var_0_0.ARENA_SEARCH_DISTANCE,
			[var_0_51] = var_0_0.ARENA_SEARCH_DISTANCE,
			[var_0_52] = var_0_0.EXPEDITION_SEARCH_DISTANCE,
			[var_0_53] = var_0_0.EXPEDITION_SEARCH_DISTANCE,
			[var_0_54] = var_0_0.EXPEDITION_SEARCH_DISTANCE,
			[var_0_55] = var_0_0.EXPLORE_SEARCH_DISTANCE,
			[var_0_56] = var_0_0.ADVENTURE_SEARCH_DISTANCE,
			[var_0_57] = var_0_0.EXPLORE_SEARCH_DISTANCE,
			[var_0_58] = var_0_0.INIT_SEARCH_DISTANCE,
			[23] = var_0_0.EXPLORE_SEARCH_DISTANCE,
			[24] = var_0_0.EXPLORE_SEARCH_DISTANCE
		}

		local function var_2_5(arg_170_0)
			return function()
				setSearchDistance(var_2_4[arg_170_0])
				fightconsoleRef:switchToBossFight(getPlayerConf())
			end
		end

		local var_2_6 = {
			[var_0_36] = function()
				setSearchDistance(var_0_0.INIT_SEARCH_DISTANCE)

				if isBigBossFight() then
					fightconsoleRef:switchToBossFight(getPlayerConf())
				else
					fightconsoleRef:switchToMap()
				end
			end,
			[var_0_37] = var_2_5(var_0_37),
			[var_0_38] = var_2_5(var_0_38),
			[var_0_39] = var_2_5(var_0_39),
			[var_0_42] = var_2_5(var_0_42),
			[var_0_41] = function()
				setSearchDistance(var_2_4[var_0_41])
				fightconsoleRef:switchToBossFight(getPlayerConf(), true)
			end,
			[var_0_43] = var_2_5(var_0_43),
			[var_0_44] = function()
				setSearchDistance(var_2_4[var_0_44])
				fightconsoleRef:switchToAiFight()
			end,
			[var_0_45] = var_2_5(var_0_45),
			[var_0_46] = var_2_5(var_0_46),
			[var_0_47] = var_2_5(var_0_47),
			[var_0_48] = function()
				setSearchDistance(var_2_4[var_0_48])
				fightconsoleRef:switchToTowerFight()
			end,
			[var_0_49] = var_2_5(var_0_49),
			[var_0_50] = var_2_5(var_0_50),
			[var_0_51] = var_2_5(var_0_51),
			[var_0_52] = function()
				setSearchDistance(var_2_4[var_0_52])
				fightconsoleRef:switchToExpeditionFight()
			end,
			[var_0_53] = function()
				setSearchDistance(var_2_4[var_0_53])
				fightconsoleRef:switchToExpeditionTowerFight()
			end,
			[var_0_54] = function()
				setSearchDistance(var_2_4[var_0_54])
				fightconsoleRef:switchToExpeditionFight()
			end,
			[var_0_55] = function()
				setSearchDistance(var_2_4[var_0_55])
				fightconsoleRef:switchToBossFight(getPlayerConf(), true)
			end,
			[var_0_56] = function()
				setSearchDistance(var_2_4[var_0_56])
				fightconsoleRef:switchToAutoChessFight()
			end,
			[var_0_57] = function()
				setSearchDistance(var_2_4[var_0_41])
				fightconsoleRef:switchToBossFight(getPlayerConf(), true)
			end,
			[var_0_58] = var_2_5(var_0_58),
			[23] = function()
				setSearchDistance(var_2_4[23])
				fightconsoleRef:switchToBossFight(getPlayerConf(), true)
			end,
			[24] = function()
				setSearchDistance(var_2_4[24])
				fightconsoleRef:switchToBossFight(getPlayerConf(), true)
			end
		}

		function onFightRefresh(arg_184_0)
			setFightState(var_0_14)
			stopCamera()

			needGuideFight = false

			battlefieldRef:fightRefresh(function()
				resetCamera()
				resetFightWorldMap()
				changeLevel()

				if var_2_6[fighttype] then
					var_2_6[fighttype]()
				end

				local function var_185_0()
					initPlayer()
					setFightState(var_0_13)
					FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_REFRESH)
					texture_manager:removeUnusedSpineTextures()

					if arg_184_0 then
						arg_184_0()
					end
				end

				local var_185_1 = checkSpineRes()

				if #var_185_1 > 0 then
					local var_185_2 = var_0_11.EventCustom:new("DOWNLOAD_FIGHT_RESOURCE")

					var_185_2.id = yield(var_185_0)
					var_185_2.list = var_185_1

					var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent(var_185_2)
				else
					removeyield()
					var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent((var_0_11.EventCustom:new("CANCEL_DOWNLOAD_FIGHT_RESOURCE")))
					var_185_0()
				end
			end)
		end

		function changeLevel()
			if fighttype == var_0_36 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_37 or fighttype == var_0_38 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_43 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_45 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_44 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_39 then
				startStatistics()
				battlefieldRef:updateFightMap("arenafight")
			elseif fighttype == var_0_42 then
				startStatistics()
				battlefieldRef:updateFightMap("scorearenafight")
			elseif fighttype == var_0_41 then
				startStatistics()
				battlefieldRef:updateFightMap("explorefight")
			elseif fighttype == var_0_35 then
				startStatistics()
			elseif fighttype == var_0_46 then
				startStatistics()
				battlefieldRef:updateFightMap("arenatftfight")
			elseif fighttype == var_0_47 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_48 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == var_0_49 then
				startStatistics()
				battlefieldRef:updateFightMap("arenafriendfight")
			elseif fighttype == var_0_50 or fighttype == var_0_51 then
				startStatistics()
				battlefieldRef:updateFightMap("stakefight")
			elseif fighttype == var_0_52 then
				startStatistics()
				battlefieldRef:updateFightMap("expeditionfight")
			elseif fighttype == var_0_53 then
				startStatistics()
				battlefieldRef:updateFightMap("expeditionfight")
			elseif fighttype == var_0_54 then
				startStatistics()
				battlefieldRef:updateFightMap("expeditionfight")
			elseif fighttype == var_0_55 then
				startStatistics()
				battlefieldRef:updateFightMap("monopolyfight")
			elseif fighttype == var_0_56 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				battlefieldRef:updateFightMap("autochessfight")
			elseif fighttype == var_0_57 then
				startStatistics()
				battlefieldRef:updateFightMap("rogueExplorefight")
			elseif fighttype == var_0_58 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			elseif fighttype == 23 then
				startStatistics()
				battlefieldRef:updateFightMap("flychessfight")
			elseif fighttype == 24 then
				startStatistics()
				level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)
				updateHangupStatus()
				battlefieldRef:updateFightMap(playermodel.curMode, playermodel.curLevel)
			end
		end

		function closeFight(arg_188_0)
			removeAllElements()
			setFightState(var_0_14)
			stopCamera()

			needGuideFight = false

			FightEventManager:registerCleanSpineTextures()
			level_manager:cleanHangupCount()
			battlefieldRef:fightClose(arg_188_0)
		end

		function openFight(arg_189_0)
			battlefieldRef:fightOpen(function()
				resetCamera()
				resetFightWorldMap()
				changeLevel()

				local function var_190_0()
					initPlayer()
					setSearchDistance(var_2_4[fighttype])

					if fighttype ~= var_0_44 and fightconsoleRef:tryRemoveAIList() then
						if fighttype == var_0_36 then
							if isBigBossFight() then
								fightconsoleRef:switchToBossFight(getPlayerConf())
							else
								fightconsoleRef:switchToMap(nil, nil, true)
							end
						elseif fighttype == var_0_41 then
							fightconsoleRef:switchToBossFight(getPlayerConf(), true)
						elseif fighttype == var_0_57 then
							fightconsoleRef:switchToBossFight(getPlayerConf(), true)
						else
							fightconsoleRef:switchToBossFight(getPlayerConf())
						end
					end

					setFightState(var_0_13)
					FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_REFRESH)
					texture_manager:removeUnusedSpineTextures()

					if arg_189_0 then
						arg_189_0()
					end
				end

				local var_190_1 = checkSpineRes()

				if #var_190_1 > 0 then
					local var_190_2 = var_0_11.EventCustom:new("DOWNLOAD_FIGHT_RESOURCE")

					var_190_2.id = yield(var_190_0)
					var_190_2.list = var_190_1

					var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent(var_190_2)
				else
					removeyield()
					var_0_11.Director:getInstance():getEventDispatcher():dispatchEvent((var_0_11.EventCustom:new("CANCEL_DOWNLOAD_FIGHT_RESOURCE")))
					var_190_0()
				end
			end)
		end

		function changeChapter(arg_192_0)
			if not isNormalFight() then
				return
			end

			if isBigBossFight() then
				return
			end

			barrage_manager:stop()

			fightingNormalBoss = false
			fightingBigBoss = false
			refightingBigBoss = false
			fightconsoleRef._touchlimit = true

			closeFight(function()
				local var_193_0

				if level_manager:isCurNewChapter() then
					function var_193_0()
						FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_JOINCHAPTER, function()
							fightconsoleRef:updateCurrentChapterInfo(nil, arg_192_0)

							fightconsoleRef._touchlimit = false
						end)
					end
				else
					fightconsoleRef:updateCurrentChapterInfo(nil, arg_192_0)

					fightconsoleRef._touchlimit = false
				end

				openFight(var_193_0)
				barrage_manager:reset(level_manager:getCurFightChapter())
				barrage_manager:resume()
			end)
		end

		function closeFightOnChangeChapter()
			if not isNormalFight() then
				return
			end

			if isBigBossFight() then
				return
			end

			barrage_manager:stop()

			fightingNormalBoss = false
			fightingBigBoss = false
			refightingBigBoss = false
			fightconsoleRef._touchlimit = true

			closeFight()
		end

		function openFightOnChangeChapter(arg_197_0)
			if not isNormalFight() then
				return
			end

			if isBigBossFight() then
				return
			end

			local var_197_0

			if level_manager:isCurNewChapter() then
				function var_197_0()
					FightEventManager:triggerFightEventListener(var_0_0.FIGHT_LISTENER_ON_JOINCHAPTER, function()
						fightconsoleRef:updateCurrentChapterInfo()

						fightconsoleRef._touchlimit = false

						if arg_197_0 then
							arg_197_0()
						end
					end)
				end
			else
				fightconsoleRef:updateCurrentChapterInfo()

				fightconsoleRef._touchlimit = false

				if arg_197_0 then
					arg_197_0()
				end
			end

			openFight(var_197_0)
			barrage_manager:reset(level_manager:getCurFightChapter())
			barrage_manager:resume()
		end

		function addGold(...)
			return
		end
	end, arg_1_0)
end
