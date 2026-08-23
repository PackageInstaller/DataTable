local var_0_0 = g.core.const.ConstMgr
local var_0_1 = {
	checkDungeonStageChallenge = function(arg_1_0, arg_1_1)
		if g.core.model.User.dungeonData:isStageUnlocked(arg_1_0) and g.core.model.User.dungeonData:getStageStar(arg_1_0) == 0 then
			return true
		end

		return false
	end,
	checkDungeonStageCanGetStageReward = function(arg_2_0, arg_2_1)
		return g.core.model.User.dungeonData:canReceiveStageChest(arg_2_0, arg_2_1)
	end,
	checkDungeonStageCanGetStarReward = function(arg_3_0, arg_3_1)
		return g.core.model.User.dungeonData:canReceiveStarChest(arg_3_0, arg_3_1)
	end,
	checkTargetPosKnightCanLineup = function(arg_4_0, arg_4_1)
		local var_4_0 = 0
		local KnightConst = require("app.view.module.knight.const.KnightConst")

		if arg_4_0 > 1 and arg_4_0 <= KnightConst.LINEUP_MAX then
			var_4_0 = var_0_0.FUNCTION_TYPE["KNIGHT_LINE_UP_" .. arg_4_0 - 1]
		elseif arg_4_0 >= KnightConst.PARTNER_INDEX and arg_4_0 <= KnightConst.PARTNER_INDEX + KnightConst.PARTNER_TOTAL - 1 then
			var_4_0 = var_0_0.FUNCTION_TYPE["KNIGHT_PARTNER_" .. arg_4_0 - KnightConst.PARTNER_INDEX + 1]
		end

		if var_4_0 > 0 and g.core.common.ModuleUnlock:isModuleUnlock(var_4_0) and not checkbool(g.core.model.User.knightsData:getKnightByFormationIndex(arg_4_0)) and #g.core.model.User.knightsData:getIdleList() > 0 then
			return true
		end

		return false
	end,
	checkTargetEquipOrTreasureCanDress = function(arg_5_0, arg_5_1)
		local var_5_0 = false

		if arg_5_1 > 0 and arg_5_1 <= 4 then
			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.EQUIP_BAG) then
				return false
			end

			if not g.core.model.User.equipmentData:isCanWearEquipByType(arg_5_1) then
				return false
			end

			var_5_0 = not g.core.model.User.equipmentData:isWornEquip((arg_5_0 - 1) * 4 + arg_5_1)
		elseif arg_5_1 >= 5 and arg_5_1 <= 6 then
			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.SWEAR_TREASURE) then
				return false
			end

			local var_5_1 = arg_5_1 - 4

			if not g.core.model.User.treasureData:isHaveSwearTreasure(arg_5_1 - 4) then
				return false
			end

			var_5_0 = not g.core.model.User.treasureData:isHaveTeasurePos((arg_5_0 - 1) * 2 + var_5_1)
		elseif arg_5_1 == 7 then
			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ARTIFACT) then
				return false
			end

			if not g.core.model.User.artifactData:isWornArtifact(arg_5_0) then
				var_5_0 = g.core.model.User.artifactData:isCanWearArtifact()
			end
		end

		return var_5_0
	end,
	checkUniteTokenCanLineup = function(arg_6_0, arg_6_1)
		if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. arg_6_0]) then
			return false
		end

		if not next(g.core.model.User.uniteTokenData:getLineupTokenList()[arg_6_0]) then
			if arg_6_1 and arg_6_1 > 0 then
				if not g.core.model.User.uniteTokenData:getTokenByAdvId(arg_6_1):isLineup() then
					return true
				end
			else
				return true
			end
		end

		return false
	end,
	checkKnightUpgradeItemCanEquip = function(arg_7_0, arg_7_1)
		local var_7_0 = g.core.model.User.knightsData:getKnightByFormationIndex(arg_7_0)

		if not var_7_0 then
			return false
		end

		return (function(arg_8_0, arg_8_1)
			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.KNIGHT_ADVANCE) then
				return false
			end

			local var_8_0 = g.core.model.User.knightsData:getKnightByBaseId(arg_8_0)

			if not var_8_0 then
				return false
			end

			local var_8_1 = var_8_0:getInfo()
			local var_8_2 = g.core.model.User.knightsData:getCanEquipMatPosList(g.core.config.knight_info.get(arg_8_0).promote_code, var_8_1.advance_level, var_8_1.id)

			for iter_8_0 = 1, #var_8_2 do
				if arg_8_1 == var_8_2[iter_8_0] then
					return true
				end
			end

			return false
		end)(var_7_0:getBaseInfo().id, arg_7_1)
	end,
	checkKnightCanUpgrade = function(arg_9_0, arg_9_1)
		local var_9_0 = g.core.model.User.knightsData:getKnightByFormationIndex(arg_9_0)

		if not var_9_0 then
			return false
		end

		if arg_9_1 and arg_9_1 > 0 and var_9_0:getBaseInfo().advance_id ~= arg_9_1 then
			return false
		end

		return (function(arg_10_0)
			local var_10_0 = g.core.model.User.knightsData:getKnightByBaseId(arg_10_0)

			if not var_10_0 then
				return false
			end

			local var_10_1 = var_10_0:getInfo()

			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.KNIGHT_ADVANCE) then
				return false
			end

			local var_10_2 = g.core.config.knight_advance_info.get(g.core.config.knight_info.get(arg_10_0).promote_code, var_10_1.advance_level)

			if var_10_1.level < var_10_2.require_level then
				return false
			end

			if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_COIN) < var_10_2.cost_money then
				return false
			end

			if g.core.model.User.bagData:getCountById(var_10_2.cost_type, var_10_2.cost_value) < var_10_2.cost_size then
				return false
			end

			return true
		end)(var_9_0:getBaseInfo().id)
	end,
	checkHasKnight = function(arg_11_0, arg_11_1)
		local var_11_0 = g.core.model.User.knightsData:getKnight({
			advance_id = arg_11_0
		})

		if var_11_0 and var_11_0:isOwn() then
			return false
		end

		return true
	end,
	checkHasItem = function(arg_12_0, arg_12_1)
		return g.core.model.User.bagData:isOwnItem(arg_12_0, arg_12_1)
	end,
	checkUniteTokenCanAwake = function(arg_13_0, arg_13_1)
		local var_13_0 = g.core.model.User.uniteTokenData:getTokenByAdvId(arg_13_0)

		if not var_13_0 then
			return false
		end

		return var_13_0:canAwaken()
	end,
	checkStormEventFinished = function(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(g.core.model.User.stormData:getSmallCityData(arg_14_0).events or {}) do
			if iter_14_1.ev_id == arg_14_1 then
				return false
			end
		end

		return true
	end,
	checkWushIsFirstOpen = function(arg_15_0, arg_15_1)
		if g.core.model.User.wushData:getTotalStar() == 0 and (function()
			if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.WUSH_TRIAL) then
				return false
			end

			return g.core.model.User.wushData:getLeftFailTimes() > 0
		end)() then
			return true
		end

		return false
	end,
	checkArenaFirstOpen = function(arg_17_0, arg_17_1)
		local var_17_0 = g.core.model.User.arenaData:getRank() or 0

		return var_17_0 == 0 or var_17_0 >= 5000
	end,
	checkUniteTokenPosNotNull = function(arg_18_0, arg_18_1)
		local var_18_0 = g.core.model.User.uniteTokenData:getLineupTokenList()[arg_18_0]

		if next(var_18_0) then
			if arg_18_1 and arg_18_1 > 0 then
				if var_18_0:getAdvanceId() == arg_18_1 then
					return true
				end
			else
				return true
			end
		end

		return false
	end,
	checkCanFirstRecruit = function(arg_19_0, arg_19_1)
		if g.core.model.User.recruitData:getAdvanceTotalNum() > 0 then
			return false
		end

		if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_ADVANCE_RECRUIT_ITEM) < 1 then
			return false
		end

		return true
	end,
	checkKnightCanLvUp = function(arg_20_0, arg_20_1)
		local var_20_0 = g.core.model.User.knightsData:getFormationKnights()

		if var_20_0[arg_20_0] and var_20_0[arg_20_0] ~= 0 then
			local var_20_1 = g.core.model.User.knightsData:getKnightById(var_20_0[arg_20_0])
			local var_20_2 = var_20_1:getInfo()
			local var_20_3 = g.core.config.knight_level_info.get(var_20_1:getBaseInfo().level_exp_id, var_20_2.level)
			local var_20_4 = g.core.model.User.itemsData:getExpItemData()
			local var_20_5 = false

			if var_20_1:getLevel() == var_20_1:getCurMaxLevel() then
				if var_20_3.next_exp > var_20_2.exp then
					local var_20_7 = 9999999

					for iter_20_0, iter_20_1 in ipairs(var_20_4) do
						if iter_20_1.num > 0 then
							local var_20_8 = g.core.config.item_info.get(iter_20_1.id)

							if var_20_7 >= var_20_8.item_value then
								var_20_7 = var_20_8.item_value
							end
						end
					end

					if var_20_7 ~= 9999999 and var_20_3.next_exp - var_20_2.exp <= var_20_7 then
						var_20_5 = true
					end
				else
					var_20_5 = true
				end
			end

			local var_20_9 = true

			for iter_20_2, iter_20_3 in ipairs(var_20_4) do
				if iter_20_3.num > 0 then
					var_20_9 = false

					break
				end
			end

			if var_20_5 then
				return false
			end

			if var_20_9 then
				return false
			end

			return true
		end

		return false
	end,
	checkCanChangeKnightPos = function(arg_21_0, arg_21_1)
		local var_21_0 = g.core.model.User.knightsData:getFormation()

		if not var_21_0[arg_21_0] or var_21_0[arg_21_0] == 0 then
			return false
		end

		if g.core.model.User.knightsData:getKnightById(var_21_0[arg_21_0]):getAdvanceId() == arg_21_1 then
			return true
		end

		return false
	end,
	checkCanChangeUniteTokenPos = function(arg_22_0, arg_22_1)
		local var_22_0 = g.core.model.User.uniteTokenData:getLineupTokenList()

		return next(var_22_0[arg_22_0]) and next(var_22_0[arg_22_1])
	end,
	checkPosIsDesignKnight = function(arg_23_0, arg_23_1)
		local var_23_0 = g.core.model.User.knightsData:getFormationKnights()

		if not var_23_0[arg_23_0] or var_23_0[arg_23_0] == 0 then
			return false
		end

		if g.core.model.User.knightsData:getKnightById(var_23_0[arg_23_0]):getAdvanceId() == arg_23_1 then
			return true
		end

		return false
	end,
	checkCanJoinGuild = function(arg_24_0, arg_24_1)
		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.FUNCTION_TYPE.GUILD) then
			if g.core.model.User.guildData:hasGuild() then
				return false
			else
				return true
			end
		end

		return false
	end,
	checkBioTaskCanRun = function(arg_25_0, arg_25_1)
		local var_25_0 = g.core.model.User.bioData:getMission(arg_25_1)

		if var_25_0 and not var_25_0.finish then
			return true
		end

		return false
	end,
	checkTrainBuild = function(arg_26_0, arg_26_1)
		return not g.core.model.User.hlTrainData:getRoomStruct(20):isUnlocked()
	end,
	checkHasKnightInWork = function(arg_27_0, arg_27_1)
		return not g.core.model.User.hlTrainData:isExistDispatchedKnight()
	end,
	checkAutoFightOpen = function(arg_28_0, arg_28_1)
		return not g.core.battle.BattleProxy:getIsBattleAuto()
	end,
	checkFight2x = function(arg_29_0, arg_29_1)
		return g.core.battle.BattleProxy:getBattleSpeed() < 2
	end,
	checkFight3x = function(arg_30_0, arg_30_1)
		return g.core.battle.BattleProxy:getBattleSpeed() < 3
	end,
	checkArenaHasChallengeTimes = function(arg_31_0, arg_31_1)
		return (g.core.model.User.shopData:getLeftCount(var_0_0.ShopConst.PLAY_TYPE.ARENA) or 0) > 0
	end,
	checkWushHasChallengeTimes = function(arg_32_0, arg_32_1)
		return g.core.model.User.wushData:getLeftFailTimes() > 0
	end,
	checkRebelHasChallengeTimes = function(arg_33_0, arg_33_1)
		return g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_REBEL_ATTACK) > 0
	end,
	checkHasGuide = function(arg_34_0, arg_34_1)
		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.FUNCTION_TYPE.GUILD) then
			if g.core.model.User.guildData:hasGuild() then
				return true
			else
				return false
			end
		end

		return false
	end,
	checkCanFightGuideBoss = function(arg_35_0, arg_35_1)
		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_0.FUNCTION_TYPE.GUILD) then
			if not g.core.model.User.guildData:hasGuild() then
				return false
			end

			if g.core.model.User.guildBossData:isProcess() then
				return true
			end
		end

		return false
	end,
	checkIsInPrimary = function(arg_36_0, arg_36_1)
		return g.core.model.User.recruitData:checkPrimaryIsOpen()
	end,
	checkInMineActivityTime = function(arg_37_0, arg_37_1)
		return g.core.model.User.mineData:isInOpenTime()
	end,
	checkInPeakArenaActivityTime = function(arg_38_0, arg_38_1)
		return g.core.model.User.peakArenaData:isShowEntrance()
	end,
	checkGuideFightInTime = function(arg_39_0, arg_39_1)
		if not g.core.model.User.GuildFightData:isInOpenTime() then
			return false
		end

		if not g.core.model.User.guildData:hasGuild() then
			return false
		end

		return true
	end,
	checkIsGuildWarTime = function(arg_40_0, arg_40_1)
		if arg_40_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_40_0) then
			return false
		end

		if arg_40_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_40_1) then
			return false
		end

		return g.core.model.User.guildWarData:isOpen()
	end,
	checkIsGuildWarDevelopTime = function(arg_41_0, arg_41_1)
		if arg_41_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_41_0) then
			return false
		end

		if arg_41_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_41_1) then
			return false
		end

		if not g.core.model.User.guildWarData:isOpen() then
			return false
		end

		if g.core.model.User.guildWarData:getStageType() ~= g.core.const.ConstMgr.GuildWarConst.StageType.DRILL then
			return false
		end

		return true
	end,
	checkIsGuildWarFightTime = function(arg_42_0, arg_42_1)
		if arg_42_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_42_0) then
			return false
		end

		if arg_42_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_42_1) then
			return false
		end

		if not g.core.model.User.guildWarData:isOpen() then
			return false
		end

		if g.core.model.User.guildWarData:getStageType() ~= g.core.const.ConstMgr.GuildWarConst.StageType.FIGHT then
			return false
		end

		return true
	end,
	checkIsGuildWarFightTimeInDevelop = function(arg_43_0, arg_43_1)
		if arg_43_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_43_0) then
			return false
		end

		if arg_43_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_43_1) then
			return false
		end

		if not g.core.model.User.guildWarData:isOpen() then
			return false
		end

		if g.core.model.User.guildWarData:getStageType() ~= g.core.const.ConstMgr.GuildWarConst.StageType.FIGHT then
			return false
		end

		if g.core.model.User.guildWarData:getFightStageType() ~= g.core.const.ConstMgr.GuildWarConst.FightStageType.DEPLOY then
			return false
		end

		return true
	end,
	checkIsGuildWarFightTimeInBattle = function(arg_44_0, arg_44_1)
		if arg_44_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_44_0) then
			return false
		end

		if arg_44_0 and not g.core.common.ModuleUnlock:isModuleUnlock(arg_44_1) then
			return false
		end

		if not g.core.model.User.guildWarData:isOpen() then
			return false
		end

		if g.core.model.User.guildWarData:getStageType() ~= g.core.const.ConstMgr.GuildWarConst.StageType.FIGHT then
			return false
		end

		if g.core.model.User.guildWarData:getFightStageType() ~= g.core.const.ConstMgr.GuildWarConst.FightStageType.FIGHTING then
			return false
		end

		return true
	end,
	checkFogNightmareInTime = function(arg_45_0, arg_45_1)
		return g.core.model.User.fogNightmareData:isGuideOpen()
	end,
	checkGveInSignUpStage = function(arg_46_0, arg_46_1)
		return g.core.model.User.gveDataMgr:isOpen() and g.core.model.User.gveDataMgr:isInSignUpStage()
	end,
	checkGveInFormalStage = function(arg_47_0, arg_47_1)
		return g.core.model.User.gveDataMgr:isOpen() and g.core.model.User.gveDataMgr:isInFormalStage()
	end,
	checkIsFunctionUnlocked = function(arg_48_0, arg_48_1)
		if arg_48_0 then
			if not g.core.common.ModuleUnlock:isModuleUnlock(arg_48_0) then
				return false
			end

			return true
		end

		return false
	end
}

function var_0_1.checkHardWushUnlocked(arg_49_0, arg_49_1)
	return var_0_1.checkWushIsFirstOpen() and g.core.common.ModuleUnlock:isModuleUnlock(26057)
end

function var_0_1.checkGeneFirstActivate(arg_50_0, arg_50_1)
	return g.core.model.User.geneData:isFirstGeneSeqActivate(arg_50_0, arg_50_1)
end

function var_0_1.checkGeneCanActivate()
	return g.core.model.User.geneData:isFirstGeneActivate()
end

function var_0_1.checkChiefArenaOnSeason()
	return g.core.model.User.crossServerArenaData:getSeasonStatus() == g.core.const.ConstMgr.CrossServerArenaConst.CTRL_ON_SEASON
end

function var_0_1.checkChiefArenaUnlock(arg_53_0, arg_53_1)
	return var_0_1.checkChiefArenaOnSeason() and g.core.common.ModuleUnlock:isModuleUnlock(26070)
end

function var_0_1.checkChiefArenaOnSeason()
	return g.core.model.User.crossServerArenaData:getSeasonStatus() == g.core.const.ConstMgr.CrossServerArenaConst.CTRL_ON_SEASON
end

function var_0_1.checkChiefArenaUnlock(arg_55_0, arg_55_1)
	return var_0_1.checkChiefArenaOnSeason() and g.core.common.ModuleUnlock:isModuleUnlock(26070)
end

function var_0_1.checkTeamPvpCanRoute()
	return g.core.model.User.teamPvpData:isActivityOpen()
end

function var_0_1.checkExplorationCanRoute()
	return g.core.model.User.explorationData:isActivityOpen() and g.core.model.User.explorationData:getCurStage() == 1
end

function var_0_1.checkRedCliffCanRoute()
	local var_58_0 = g.core.const.ConstMgr.RedCliffConst
	local var_58_1 = g.core.model.User.redCliffData:getGameStage()

	return var_58_1 ~= g.core.const.ConstMgr.RedCliffConst.GAME_STAGE.NONE and var_58_1 ~= var_58_0.GAME_STAGE.RESULT
end

function var_0_1.checkBountyCanRoute()
	local var_59_0 = g.core.const.ConstMgr.BountyConst

	if not g.core.model.User.bountyData:isActivityOpen() then
		return false
	end

	local var_59_1 = g.core.model.User.bountyData:getCurStage()

	return var_59_1 ~= var_59_0.ACTIVITY_STATE.NOT_OPEN and var_59_1 ~= var_59_0.ACTIVITY_STATE.RESULT
end

function var_0_1.checkTeamBattleCanRoute()
	local var_60_0 = g.core.const.ConstMgr.TeamBattleConst

	if not g.core.model.User.teamBattleData:isActivityOpen() then
		return false
	end

	local var_60_1 = g.core.model.User.teamBattleData:getCurStage()

	return var_60_1 ~= var_60_0.ACTIVITY_STATE.NOT_OPEN and var_60_1 ~= var_60_0.ACTIVITY_STATE.RESULT
end

function var_0_1.checkAllianceUnlock()
	return g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.ALLIANCE)
end

function var_0_1.checkIsHasAlliance()
	return g.core.model.User.allianceData:isInAlliance()
end

function var_0_1.checkIsSlgOpen()
	return g.core.model.User.newSlgData:isOpen()
end

function var_0_1.checkIsPubgOpen()
	local var_64_0 = g.core.model.User.pubgData:getCurStage()

	if var_64_0 == g.core.const.ConstMgr.PubgConst.GAME_STATE.REGULAR or var_64_0 == g.core.const.ConstMgr.PubgConst.GAME_STATE.FINAL then
		return true
	end

	return false
end

function var_0_1.checkIsSlgS1()
	return g.core.model.User.newSlgData:getSName() == "S1"
end

function var_0_1.checkIsSlgS2()
	return g.core.model.User.newSlgData:getSName() == "S2"
end

function var_0_1.checkSpireIsOpen()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE) then
		return false
	end

	return g.core.model.User.spireData:getCurStage() == g.core.const.ConstMgr.SpireConst.STAGE.GAME
end

function var_0_1.checkElderBossIsOpen()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ELDER_BOSS) then
		return false
	end

	return g.core.model.User.elderBossData:getCurStage() == g.core.const.ConstMgr.ElderBossConst.STAGE.GAME
end

function var_0_1.checkHandBookOpen()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_HAND_BOOK)
end

function var_0_1.checkKnightFragAttr()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_TMP2)
end

function var_0_1.checkOutpostTaskFinish(arg_71_0, arg_71_1)
	local var_71_0 = g.core.model.outpostData:getTaskData():getAction(arg_71_0, g.core.const.ConstMgr.outpostConst.TASK_TYPE.MAIN)

	if not var_71_0 then
		return false
	end

	if var_71_0.finished then
		return false
	else
		return true
	end
end

function var_0_1.checkOutpostTaskAward(arg_72_0, arg_72_1)
	local var_72_0 = g.core.model.outpostData:getTaskData():getAction(arg_72_0, g.core.const.ConstMgr.outpostConst.TASK_TYPE.MAIN)

	if not var_72_0 then
		return false
	end

	if var_72_0.action_value >= g.core.config.outpost_main_quest_info.get(arg_72_0).quest_value then
		if var_72_0.finished then
			return false
		else
			return true
		end
	else
		return false
	end
end

function var_0_1.isHomeLandOpenTwo()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_MAIN) and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.OUTPOST)
end

function var_0_1.isWarriorsUsed()
	return #g.core.model.User.warriorsOfFateData:getActChaptersByType(1) == 0
end

function var_0_1.isOutpostCityLevelUp(arg_75_0, arg_75_1)
	return arg_75_1 > g.core.model.User.outpostData:getBuildData():getBuild({
		type = arg_75_0
	}):getLevel()
end

function var_0_1.isAncientsOpen(arg_76_0, arg_76_1)
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ANCIENTS) and g.core.model.User.ancientsData:isTimeToOpen() and g.core.model.User.ancientsData:getAncientsState() < g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP and g.core.model.User.ancientsData:getTeam(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM) == nil
end

function var_0_1.checkHomeGuideCond()
	if g.core.model.User.guideData:getServerDataById(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.HOME_LAND_HOME_LIVED) then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		return false
	end

	for iter_77_0, iter_77_1 in ipairs((g.core.model.User.knightsData:getSpList((function()
		return function(arg_79_0)
			return arg_79_0:isOwn() and not arg_79_0:isMain() and arg_79_0:getMaxMobility() > 0
		end
	end)()))) do
		if iter_77_1:getMobilityVal() == 0 then
			return true
		end
	end

	return false
end

function var_0_1.checkHomeShowerGuideCond()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		return false
	end

	if g.core.model.User.guideData:getServerDataById(var_0_0.GuideConst.SAVE_SERVER_DATA_IDS.HOME_LAND_HOME_SHOWER) then
		return false
	end

	if g.core.model.User.furnitureData:getCanPlaceFurnitureCount(var_0_0.FurnitureConst.FURNITURE_TYPE.BATH_CROCK) <= 0 then
		return false
	end

	if g.core.model.User.furnitureData:isThereBathCrock(1) then
		return false
	end

	return true
end

return var_0_1
