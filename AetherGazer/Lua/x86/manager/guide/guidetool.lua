local var_0_0 = {}
local var_0_1 = {
	"curHeroId_",
	"curHeroID_",
	"heroId",
	"heroId_",
	"heroID",
	"heroID_"
}

local function var_0_2(arg_1_0)
	if arg_1_0.GetCurHeroID then
		return arg_1_0:GetCurHeroID()
	end

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		local var_1_0 = arg_1_0[iter_1_1]

		if var_1_0 then
			return var_1_0
		end
	end
end

function var_0_0.NormalizeGuideId(arg_2_0)
	local var_2_0 = tonumber(arg_2_0)

	if var_2_0 ~= nil then
		return tostring(var_2_0)
	end

	return tostring(arg_2_0 or "")
end

function var_0_0.IsSummerRaceStageWaveStart(arg_3_0, arg_3_1)
	if SummerRaceData == nil or SummerRaceData.GetRuntimeState == nil then
		return false
	end

	local var_3_0 = SummerRaceData:GetRuntimeState()

	if type(var_3_0) ~= "table" then
		return false
	end

	if tostring(var_3_0.phase or "") ~= "Countdown" then
		return false
	end

	if var_0_0.NormalizeGuideId(var_3_0.stageId) ~= var_0_0.NormalizeGuideId(arg_3_0) then
		return false
	end

	return math.floor(tonumber(var_3_0.wave) or 0) == math.floor(tonumber(arg_3_1) or 0)
end

function var_0_0.IsSummerRaceEnemyDefeatBeforeFx(arg_4_0)
	if SummerRaceData == nil or SummerRaceData.GetGuideTriggerContext == nil then
		return false
	end

	local var_4_0 = SummerRaceData:GetGuideTriggerContext(SummerRaceConst.GUIDE_TRIGGER.CONTEXT_ENEMY_DEFEAT_BEFORE_FX)

	if type(var_4_0) ~= "table" or var_4_0.active ~= true then
		return false
	end

	return var_0_0.NormalizeGuideId(var_4_0.enemyId) == var_0_0.NormalizeGuideId(arg_4_0)
end

function var_0_0.IsSummerRaceEnergyReached(arg_5_0)
	if SummerRaceData == nil or SummerRaceData.GetRuntimeState == nil then
		return false
	end

	local var_5_0 = SummerRaceData:GetRuntimeState()

	if type(var_5_0) ~= "table" then
		return false
	end

	local var_5_1 = tonumber(arg_5_0)

	if var_5_1 == nil then
		return false
	end

	return var_5_1 <= (tonumber(var_5_0.energy) or 0)
end

function var_0_0.IsSummerRaceStageCompleted(arg_6_0)
	if SummerRaceData == nil or SummerRaceData.IsStageCompleted == nil or SummerRaceData.HasStageConfig == nil then
		return false
	end

	if SummerRaceData:HasStageConfig(arg_6_0) ~= true then
		return false
	end

	return SummerRaceData:IsStageCompleted(arg_6_0) == true
end

function var_0_0.SatisfyCondition(arg_7_0)
	if type(arg_7_0) ~= "table" then
		return true
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		if iter_7_1[1] == "system" then
			local var_7_0 = iter_7_1[2]

			if JumpTools.IsSystemOperationStoped(var_7_0) then
				return false
			end

			if JumpTools.IsSystemLocked(var_7_0) then
				return false
			end
		elseif iter_7_1[1] == "stage" then
			local var_7_1 = iter_7_1[2]
			local var_7_2 = BattleStageData:GetStageData()

			if var_7_2[var_7_1] and var_7_2[var_7_1].clear_times >= 1 then
				-- block empty
			else
				return false
			end
		elseif iter_7_1[1] == "task" then
			if not TaskData2:GetTask(iter_7_1[2]) or TaskData2:GetTask(iter_7_1[2]).complete_flag == iter_7_1[3] then
				-- block empty
			else
				return false
			end
		elseif iter_7_1[1] == "playerLevel" then
			if PlayerData:GetPlayerInfo().userLevel < iter_7_1[2] then
				return false
			end
		elseif iter_7_1[1] == "playerLevelLessThan" then
			if PlayerData:GetPlayerInfo().userLevel >= iter_7_1[2] then
				return false
			end
		elseif iter_7_1[1] == "whereTag" then
			if manager.windowBar:GetWhereTag() ~= iter_7_1[2] then
				return false
			end
		elseif iter_7_1[1] == "uiName" then
			if not gameContext:GetOpenPageHandler(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "uiParam" then
			if nullable(gameContext:GetLastOpenPageHandler(), "params_", iter_7_1[2]) ~= iter_7_1[3] then
				return false
			end
		elseif iter_7_1[1] == "uiNameList" then
			local var_7_3 = iter_7_1[2]
			local var_7_4 = false

			for iter_7_2, iter_7_3 in ipairs(var_7_3) do
				if gameContext:GetOpenPageHandler(iter_7_3) then
					var_7_4 = true
				end
			end

			if not var_7_4 then
				return false
			end
		elseif iter_7_1[1] == "activityId" then
			local var_7_5 = iter_7_1[2]

			if not ActivityData:GetActivityIsOpen(var_7_5) then
				return false
			end
		elseif iter_7_1[1] == "guide" then
			local var_7_6 = iter_7_1[2]

			if not GuideData:IsFinish(var_7_6) then
				return false
			end
		elseif iter_7_1[1] == "notGuide" then
			local var_7_7 = iter_7_1[2]

			if GuideData:IsFinish(var_7_7) then
				return false
			end
		elseif iter_7_1[1] == "storyId" then
			local var_7_8 = iter_7_1[2]

			if not manager.story:IsStoryPlayed(var_7_8) then
				return false
			end
		elseif iter_7_1[1] == "drawNewHero" then
			if DrawData:GetNewHeroFlag() == false then
				return false
			end
		elseif iter_7_1[1] == "anyEquipLevel" then
			local var_7_9 = iter_7_1[2]
			local var_7_10 = false

			for iter_7_4, iter_7_5 in pairs(EquipData:GetEquipList()) do
				if var_7_9 <= iter_7_5:GetLevel() then
					var_7_10 = true

					break
				end
			end

			if var_7_10 == false then
				return false
			end
		elseif iter_7_1[1] == "anyComboSkill" then
			local var_7_11 = iter_7_1[2]

			if var_7_11 == 0 or var_7_11 == nil then
				local var_7_12 = gameContext:GetLastOpenPageHandler()

				var_7_11 = var_0_2(var_7_12)
			end

			local var_7_13 = ComboSkillTools.GetHeroComboSkill(var_7_11)

			if var_7_13 == nil or #var_7_13 == 0 then
				return false
			end
		elseif iter_7_1[1] == "newbieTaskOpen" then
			if not ActivityNewbieTools.CheckAdvanceTaskOpen() then
				return false
			end
		elseif iter_7_1[1] == "equip" then
			local var_7_14, var_7_15 = gameContext:GetLastOpenPageHandler()

			if gameContext:GetCmdEnqueueCount() ~= 0 or var_7_15 ~= "equipCultureView" then
				return false
			end

			local var_7_16 = gameContext:GetOpenPageHandler("equipCultureView")

			if var_7_16 == nil then
				return false
			end

			local var_7_17 = EquipData:GetEquipData(var_7_16:GetEquipId())

			if not var_7_17 then
				return false
			end

			if iter_7_1[2] == "equipLevel" then
				if iter_7_1[3] > var_7_17:GetLevel() then
					return false
				end
			elseif iter_7_1[2] == "cultureEquipStar" then
				if iter_7_1[3] > var_7_17.star then
					return false
				end
			elseif iter_7_1[2] == "cultureEquipReset" then
				if var_7_17.star < 5 or var_7_17.race ~= 0 and table.keyof(RaceEffectCfg.all, var_7_17.race) == nil then
					return false
				end
			elseif iter_7_1[2] == "page" then
				local var_7_18 = iter_7_1[3]

				if var_7_16:GetCulturePage() ~= var_7_18 then
					return false
				end
			end
		elseif iter_7_1[1] == "heroFavorability" then
			local var_7_19 = iter_7_1[2][1]

			if var_7_19 == 0 then
				local var_7_20 = iter_7_1[2][2]
				local var_7_21 = HeroData:GetHeroList()
				local var_7_22 = false

				for iter_7_6, iter_7_7 in pairs(var_7_21) do
					if HeroTools.GetHeroIsUnlock(iter_7_6) then
						local var_7_23 = HeroRecordCfg.get_id_list_by_hero_id[iter_7_6][1]

						if var_7_20 <= ArchiveData:GetArchive(var_7_23).lv then
							var_7_22 = true

							break
						end
					end
				end

				if not var_7_22 then
					return false
				end
			elseif var_7_19 and ArchiveData:GetArchive(var_7_19) then
				local var_7_24 = ArchiveData:GetArchive(var_7_19).lv

				if var_7_24 and var_7_24 < iter_7_1[2][2] then
					return false
				end
			else
				print("档案id获取错误")
			end
		elseif iter_7_1[1] == "canJump" then
			if whereami ~= "home" or LuaExchangeHelper.GetSceneIsHanding() or WarChessData:GetIsGoingChess() then
				return false
			end
		elseif iter_7_1[1] == "spHero" then
			local var_7_25 = gameContext:GetOpenPageHandler("newHero")

			if var_7_25 == nil or var_7_25.curPageIndex_ ~= 6 or not HeroTools.IsSpHero(var_7_25.curHeroId_) then
				return false
			end
		elseif iter_7_1[1] == "chess" then
			local var_7_26 = manager.ChessBoardManager

			if var_7_26 then
				local var_7_27 = iter_7_1[2]

				if var_7_27 == "chanceId" and var_7_26:GetCurChanceInfo().chanceID ~= iter_7_1[3] then
					return false
				elseif var_7_27 == "canUseProp" and var_7_26:GetIsCanUseProp() ~= iter_7_1[3] then
					return false
				elseif var_7_27 == "hasProp" and #var_7_26:GetHeroProp() <= 0 then
					return false
				end
			else
				return false
			end
		elseif iter_7_1[1] == "idolCompetition" then
			local var_7_28 = gameContext:GetOpenPageHandler("idolCompetitionMain")

			if var_7_28 == nil then
				return false
			end

			if not var_7_28.myTakePartIn_ and var_7_28.curRacePhase_ > 1 then
				return false
			end
		elseif iter_7_1[1] == "selfSticker" then
			local var_7_29 = gameContext:GetOpenPageHandler("customStickerMain")

			if var_7_29 == nil or var_7_29.params_.foreign then
				return false
			end
		elseif iter_7_1[1] == "qworldFunction" then
			local var_7_30 = iter_7_1[2]

			if not QWorldData:IsUnlockFunction(var_7_30) then
				return false
			end
		elseif iter_7_1[1] == "bloodCardFunction" then
			local var_7_31 = iter_7_1[2]

			if not BloodCardTools.IsUnlockGuide(var_7_31) then
				return false
			end
		elseif iter_7_1[1] == "qworldSubQuest" then
			local var_7_32 = iter_7_1[2]

			if not QWorldQuestTool.IsSubQuestFinish(var_7_32) then
				return false
			end
		elseif iter_7_1[1] == "osirisPlayGame" then
			local var_7_33 = iter_7_1[2]

			if not OsirisPlayGameData:IsPassStagesByStageId(var_7_33) then
				return false
			end
		elseif iter_7_1[1] == "tetris" then
			if iter_7_1[2] == "tetrisLock" then
				if not TetrisGameRunTimeManager:GetLockIsCanUse() then
					return false
				end
			elseif iter_7_1[2] == "tetrisBubble" then
				if not TetrisGameRunTimeManager:GetBublleIsUse() then
					return false
				end
			elseif iter_7_1[2] == "tetrisLockCube" then
				if not TetrisGameRunTimeManager:GetIsLockCube() then
					return false
				end
			elseif iter_7_1[2] == "tetrisSkill" then
				if not TetrisGameRunTimeManager:IsSkillEnough() then
					return false
				end
			elseif iter_7_1[2] == "tetrisStage" and (TetrisGameRunTimeManager:GetBlackBoard() and TetrisGameRunTimeManager:GetBlackBoard().stageID) ~= iter_7_1[3] then
				return false
			end
		elseif iter_7_1[1] == "goldMiner" then
			if iter_7_1[2] ~= GodEaterData:GetGoldActivityId() then
				return false
			end
		elseif iter_7_1[1] == "civilizationGame" then
			if gameContext:GetOpenPageHandler("civilizationGameView") == nil then
				return false
			end

			local var_7_34 = civilization.CivilizationLuaBridge.CheckStage()

			if civilization.CivilizationLuaBridge.CheckStage() < iter_7_1[2] then
				return false
			end
		elseif iter_7_1[1] == "billiardGame" then
			if not BilliardGameMgr:IsInBilliardGame() then
				return false
			end

			if BilliardGameMgr:GetStageId() ~= iter_7_1[2] then
				return false
			end

			if BilliardGameLuaBridge.GetRoundNum() ~= iter_7_1[3] then
				return false
			end
		elseif iter_7_1[1] == "cookid" then
			if SummerPubData:GetClearNumByStageID(iter_7_1[2]) <= 0 then
				return false
			end
		elseif iter_7_1[1] == "zzqStage" then
			local var_7_35 = AutoChessData:GetCurGameType()

			if var_7_35 and var_7_35 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			local var_7_36 = string.split(iter_7_1[2], "_")
			local var_7_37 = tonumber(var_7_36[1])
			local var_7_38 = tonumber(var_7_36[2])
			local var_7_39 = AutoChessTools.GetCurStageId()
			local var_7_40 = AutoChessTools.GetCurRound()

			if var_7_39 ~= var_7_37 or var_7_40 ~= var_7_38 then
				return false
			end
		elseif iter_7_1[1] == "zzqEvent" then
			local var_7_41 = AutoChessData:GetCurGameType()

			if var_7_41 and var_7_41 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			local var_7_42 = tonumber(iter_7_1[2])
			local var_7_43 = AutoChessData:GetGameStatus()
			local var_7_44 = AutoChessBattleSimulator.GetInstance():GetStatus()
			local var_7_45 = AutoChessBattleSimulator.GetInstance():GetBlackboard()

			if var_7_43 == AutoChessConst.GAME_STATUS.NONE or var_7_43 == AutoChessConst.GAME_STATUS.PREPARE or var_7_43 == AutoChessConst.GAME_STATUS.REPLAY then
				return false
			end

			if var_7_42 == 1 then
				if var_7_44 ~= AutoChessConst.BATTLE_STATUS.PLAYING then
					return false
				end
			elseif var_7_42 == 3 then
				if not var_7_45:GetIsFightOver() then
					return false
				end
			else
				return false
			end
		elseif iter_7_1[1] == "zzqBossStage" then
			local var_7_46 = AutoChessData:GetCurGameType()

			if var_7_46 and var_7_46 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			if AutoChessData:GetGameStatus(0) == AutoChessConst.GAME_STATUS.REPLAY then
				return false
			end

			local var_7_47 = tonumber(iter_7_1[2])
			local var_7_48 = AutoChessData:GetBattleBossRound()
			local var_7_49 = AutoChessTools.GetCurRound()

			if not var_7_48 or not var_7_49 or var_7_48 + var_7_47 ~= var_7_49 then
				return false
			end
		elseif iter_7_1[1] == "zzqStagePassed" then
			if AutoChessTools.GetStageState(tonumber(iter_7_1[2])) ~= AutoChessConst.STAGE_STATE.COMPLETED then
				return false
			end
		elseif iter_7_1[1] == "isAnyCharChipUnlock" then
			if manager.redPoint:getTipValue(RedPointConst.CHIP_CHAR_CHIP) <= 0 then
				return false
			end
		elseif iter_7_1[1] == "isHellaPinballPassStage" then
			if not PinballData:GetStageComplete(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "isHellaPinballPassWave" then
			if not (Pinball.PinballGameManager.Instance.currentStageIndex >= iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "isHellaPinballInDebate" then
			if not Pinball.PinballGameManager.Instance.isDebateStage then
				return false
			end
		elseif iter_7_1[1] == "isHellaPinballInChallenge" then
			if PinballData:GetChallengeStageID() ~= PinballAction.PlayingStageID then
				return false
			end
		elseif iter_7_1[1] == "isInHellaPinballStage" then
			if not Pinball.PinballGameManager.Instance.CanPlayGuide then
				return false
			end
		elseif iter_7_1[1] == "isInHellaPinballStageID" then
			if iter_7_1[2] ~= PinballAction.PlayingStageID then
				return false
			end
		elseif iter_7_1[1] == "isInHellaPinballHome" then
			if not PinballAction.CanPlayGuide then
				return false
			end
		elseif iter_7_1[1] == "bossRushStage" then
			local var_7_50 = iter_7_1[2]
			local var_7_51 = HodurTools.GetChapterIDByStageID(var_7_50)

			if not HodurTools.GetStagePass(var_7_50, var_7_51) then
				return false
			end
		elseif iter_7_1[1] == "v2Map" then
			if not gameContext:GetOpenPageHandler("chapterV2MapMain") then
				return false
			end

			if iter_7_1[2] ~= ChapterV2MapData:GetCurrentMapId() then
				return false
			end
		elseif iter_7_1[1] == "v2MapEventFinish" then
			local var_7_52 = iter_7_1[2]

			if not ChapterV2MapData:IsEventCompleted(var_7_52) then
				return false
			end
		elseif iter_7_1[1] == "rogueCardGame" then
			if RogueCardGameBridge.InGame() == false then
				return false
			end

			local var_7_53 = iter_7_1[2]
			local var_7_54 = iter_7_1[3]
			local var_7_55 = iter_7_1[4]
			local var_7_56 = iter_7_1[5]

			if RogueCard.RogueCardGameMain.Instance.GameContext.stageID ~= var_7_53 then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance.GameContext.curRound ~= var_7_54 then
				return false
			end

			if gameContext:GetLastOpenPage() ~= "rogueCardGameView" then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance:GetMiniStage() ~= var_7_55 then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance:GetGuideState() ~= var_7_56 then
				return false
			end
		elseif iter_7_1[1] == "rogueCardGamePosting" then
			local var_7_57 = iter_7_1[2]

			if not RogueCardGameTools.GetIsFinishPreById(var_7_57) then
				return false
			end
		elseif iter_7_1[1] == "mergeballStage" then
			local var_7_58 = iter_7_1[2]
			local var_7_59 = iter_7_1[3]

			if BilliardGameMgr:GetStageId() ~= var_7_58 then
				return false
			end

			if var_7_59 > BilliardGameMgr:GetCurRound() then
				return false
			end
		elseif iter_7_1[1] == "mergeballPass" then
			local var_7_60 = iter_7_1[2]

			if not table.indexof(VehicleBallData:GetPassedStageList(), var_7_60) then
				return false
			end
		elseif iter_7_1[1] == SummerRaceConst.GUIDE_TRIGGER.WAVE_START then
			if not var_0_0.IsSummerRaceStageWaveStart(iter_7_1[2], iter_7_1[3]) then
				return false
			end
		elseif iter_7_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENEMY_DEFEAT_BEFORE_FX then
			if not var_0_0.IsSummerRaceEnemyDefeatBeforeFx(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == SummerRaceConst.GUIDE_TRIGGER.ENERGY_REACHED then
			if not var_0_0.IsSummerRaceEnergyReached(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == SummerRaceConst.GUIDE_TRIGGER.STAGE_COMPLETED then
			if not var_0_0.IsSummerRaceStageCompleted(iter_7_1[2]) then
				return false
			end
		else
			print("未实现的条件类型:", iter_7_1[1])
		end
	end

	return true
end

function var_0_0.FindComponent(arg_8_0)
	local var_8_0 = GuideTool.stringToTable(arg_8_0)
	local var_8_1 = ComponentStep.New(nil, 101):AnalyzeComponentCfg(var_8_0)

	if var_8_1 then
		local var_8_2 = var_8_1.gameObject

		LeanTween.scale(var_8_2, Vector3.New(1.2, 1.2, 1.2), 0.2)
		LeanTween.scale(var_8_2, Vector3.one, 0.2):setDelay(0.2)
		print("<color=#00ff00>找到了</color>")
	else
		print("<color=#ff0000>找不到</color>")
	end
end

function var_0_0.stringToTable(arg_9_0)
	return (loadstring("return " .. arg_9_0)())
end

function var_0_0.Log(arg_10_0)
	print("<color=#00ff00>" .. arg_10_0 .. "</color>")
end

function var_0_0.GetGameContentUrl()
	return gameContext:GetUrl()
end

local var_0_3 = {}
local var_0_4
local var_0_5 = ""

function var_0_0.GetGameContextParams()
	local var_12_0 = gameContext:GetLastOpenPage()
	local var_12_1 = gameContext:GetOpenPageHandler(var_12_0)

	if not var_12_1 then
		return {}
	end

	var_0_3 = {}
	var_0_4 = var_12_1
	var_0_5 = var_12_0

	var_0_0.GetGuideComponent(var_12_1, "", 0)

	var_0_4 = nil

	return var_0_3
end

function var_0_0.GetListComponets(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = gameContext:GetOpenPageHandler(arg_13_0)

	if not var_13_0 then
		return {}
	end

	local var_13_1 = string.split(arg_13_1, "/")
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_0 == 1 then
			var_13_2 = var_13_0[iter_13_1]
		else
			var_13_2 = var_13_2[iter_13_1]
		end
	end

	if not var_13_2 then
		return {}
	end

	local var_13_3 = var_13_2:GetItemList()

	if not var_13_3 or not var_13_3[arg_13_2] then
		return {}
	end

	local var_13_4 = var_13_3[arg_13_2]

	var_0_3 = {}
	var_0_4 = var_13_4
	var_0_5 = "LuaList_Item"

	var_0_0.GetGuideComponent(var_13_4, "", 0)

	return var_0_3
end

function var_0_0.GetGuideComponent(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 > 2 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		local var_14_0 = arg_14_1 .. iter_14_0

		if type(iter_14_1) == "userdata" and not isNil(iter_14_1) then
			table.insert(var_0_3, {
				var_0_5,
				var_14_0,
				iter_14_1
			})
		elseif type(iter_14_1) == "table" then
			if iter_14_1.__cname == "LuaList" and iter_14_1.uiList_ ~= nil then
				table.insert(var_0_3, {
					var_0_5,
					var_14_0,
					iter_14_1.uiList_
				})
			elseif iter_14_1 ~= var_0_4 then
				var_0_0.GetGuideComponent(iter_14_1, var_14_0 .. "/", arg_14_2 + 1)
			end
		end
	end
end

function var_0_0.CheckWeakGuide(arg_15_0)
	local var_15_0 = GuideWeakCfg.get_id_list_by_name[arg_15_0]

	if var_15_0 == nil then
		return false
	end

	local var_15_1 = {
		priority = -9999
	}

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_2 = GuideWeakCfg[iter_15_1]
		local var_15_3 = GuideData:IsWeakGuideFinish(iter_15_1)
		local var_15_4 = var_15_2.skipcondition[1] ~= nil and GuideTool.SatisfyCondition(var_15_2.skipcondition)

		if not var_15_3 and not var_15_4 and var_15_2.priority > var_15_1.priority and GuideTool.SatisfyCondition(var_15_2.opencondition) then
			var_15_1 = var_15_2
		end
	end

	if var_15_1.priority == -9999 then
		return false
	end

	return true, var_15_1
end

function var_0_0.GetGuideComponentByRoute(arg_16_0, arg_16_1)
	local var_16_0 = #arg_16_1
	local var_16_1 = 1
	local var_16_2

	while var_16_1 <= var_16_0 do
		local var_16_3 = arg_16_1[var_16_1]
		local var_16_4

		if var_16_1 == 1 then
			var_16_4 = arg_16_0[var_16_3]
		else
			var_16_4 = var_16_2[var_16_3]
		end

		if var_16_4 then
			var_16_2 = var_16_4
			var_16_1 = var_16_1 + 1
		else
			return nil
		end
	end

	return var_16_2
end

function var_0_0.GetCommonStepGuideComponent(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.guide_component
	local var_17_1

	if var_17_0 and #var_17_0 > 0 and var_17_0[1] == "common" then
		local var_17_2 = var_17_0[3]

		if var_17_2 and #var_17_2 > 0 then
			if var_17_2[1] == "guideComponents" then
				local var_17_3 = var_17_2[2]

				return arg_17_0.guideComponents[var_17_3]
			else
				return arg_17_0[var_17_2[1]]
			end
		end
	end

	return nil
end

local var_0_6 = {
	5,
	6,
	2,
	nil,
	5,
	1,
	3,
	4,
	7
}

function var_0_0.GetPoolIndex(arg_18_0)
	local var_18_0 = var_0_0.GetPools()
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = DrawPoolCfg[iter_18_1]
		local var_18_3 = var_0_6[var_18_2.pool_show_type]

		if var_18_1[var_18_3] == nil then
			var_18_1[var_18_3] = 1
		end

		var_18_1[var_18_3] = var_18_1[var_18_3] + 1
	end

	local var_18_4 = {}
	local var_18_5 = 1

	for iter_18_2 = 1, 8 do
		if var_18_1[iter_18_2] then
			var_18_4[iter_18_2] = var_18_5
			var_18_5 = var_18_5 + 1
		end
	end

	return var_18_4[var_0_6[DrawPoolCfg[arg_18_0].pool_show_type]]
end

function var_0_0.GetPools()
	local var_19_0 = {}
	local var_19_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if ActivityData:GetActivityIsOpen(iter_19_1) then
			local var_19_2 = ActivityDrawPoolCfg[iter_19_1]

			if var_19_2 then
				for iter_19_2, iter_19_3 in ipairs(var_19_2.config_list) do
					if DrawPoolCfg[iter_19_3].pool_show_type == 8 then
						if not DrawData:GetNewbieChooseDrawFlag() then
							table.insert(var_19_0, iter_19_3)
						end
					else
						table.insert(var_19_0, iter_19_3)
					end
				end
			end
		end
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return DrawPoolCfg[arg_20_0].order < DrawPoolCfg[arg_20_1].order
	end)

	return var_19_0
end

return var_0_0
