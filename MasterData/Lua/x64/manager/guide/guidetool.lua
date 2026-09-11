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
		if arg_1_0[iter_1_1] then
			return arg_1_0[iter_1_1]
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

	local var_3_1
	local var_3_2

	if var_0_0.NormalizeGuideId(var_3_0.stageId) ~= var_0_0.NormalizeGuideId(arg_3_0) then
		do return false end

		var_3_1 = tonumber(var_3_0.wave) or 0
		var_3_2 = tonumber(arg_3_1) or 0
	end

	return math.floor(var_3_1) == math.floor(var_3_2)
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
			if JumpTools.IsSystemOperationStoped(iter_7_1[2]) then
				return false
			end

			if JumpTools.IsSystemLocked(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "stage" then
			local var_7_0 = BattleStageData:GetStageData()

			if var_7_0[iter_7_1[2]] and var_7_0[iter_7_1[2]].clear_times >= 1 then
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
			local var_7_1 = false

			for iter_7_2, iter_7_3 in ipairs(iter_7_1[2]) do
				if gameContext:GetOpenPageHandler(iter_7_3) then
					var_7_1 = true
				end
			end

			if not var_7_1 then
				return false
			end
		elseif iter_7_1[1] == "activityId" then
			if not ActivityData:GetActivityIsOpen(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "guide" then
			if not GuideData:IsFinish(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "notGuide" then
			if GuideData:IsFinish(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "storyId" then
			if not manager.story:IsStoryPlayed(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "drawNewHero" then
			if DrawData:GetNewHeroFlag() == false then
				return false
			end
		elseif iter_7_1[1] == "anyEquipLevel" then
			local var_7_2 = false

			for iter_7_4, iter_7_5 in pairs(EquipData:GetEquipList()) do
				if iter_7_1[2] <= iter_7_5:GetLevel() then
					var_7_2 = true

					break
				end
			end

			if var_7_2 == false then
				return false
			end
		elseif iter_7_1[1] == "anyComboSkill" then
			local var_7_3 = iter_7_1[2]

			if iter_7_1[2] ~= 0 then
				if var_7_3 == nil then
					var_7_3 = var_0_2((gameContext:GetLastOpenPageHandler()))
				end
			end

			local var_7_4 = ComboSkillTools.GetHeroComboSkill(var_7_3)

			if var_7_4 == nil or #var_7_4 == 0 then
				return false
			end
		elseif iter_7_1[1] == "newbieTaskOpen" then
			if not ActivityNewbieTools.CheckAdvanceTaskOpen() then
				return false
			end
		elseif iter_7_1[1] == "equip" then
			local var_7_5, var_7_6 = gameContext:GetLastOpenPageHandler()

			if gameContext:GetCmdEnqueueCount() ~= 0 or var_7_6 ~= "equipCultureView" then
				return false
			end

			local var_7_7 = gameContext:GetOpenPageHandler("equipCultureView")

			if var_7_7 == nil then
				return false
			end

			local var_7_8 = EquipData:GetEquipData(var_7_7:GetEquipId())

			if not var_7_8 then
				return false
			end

			if iter_7_1[2] == "equipLevel" then
				if iter_7_1[3] > var_7_8:GetLevel() then
					return false
				end
			elseif iter_7_1[2] == "cultureEquipStar" then
				if iter_7_1[3] > var_7_8.star then
					return false
				end
			elseif iter_7_1[2] == "cultureEquipReset" then
				if var_7_8.star < 5 or var_7_8.race ~= 0 and table.keyof(RaceEffectCfg.all, var_7_8.race) == nil then
					return false
				end
			elseif iter_7_1[2] == "page" and var_7_7:GetCulturePage() ~= iter_7_1[3] then
				return false
			end
		elseif iter_7_1[1] == "heroFavorability" then
			if iter_7_1[2][1] == 0 then
				local var_7_9 = false

				for iter_7_6, iter_7_7 in pairs((HeroData:GetHeroList())) do
					if HeroTools.GetHeroIsUnlock(iter_7_6) and iter_7_1[2][2] <= ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[iter_7_6][1]).lv then
						var_7_9 = true

						break
					end
				end

				if not var_7_9 then
					return false
				end
			elseif iter_7_1[2][1] and ArchiveData:GetArchive(iter_7_1[2][1]) then
				local var_7_10 = ArchiveData:GetArchive(iter_7_1[2][1]).lv

				if var_7_10 and var_7_10 < iter_7_1[2][2] then
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
			local var_7_11 = gameContext:GetOpenPageHandler("newHero")

			if var_7_11 == nil or var_7_11.curPageIndex_ ~= 6 or not HeroTools.IsSpHero(var_7_11.curHeroId_) then
				return false
			end
		elseif iter_7_1[1] == "chess" then
			if manager.ChessBoardManager then
				if iter_7_1[2] == "chanceId" and manager.ChessBoardManager:GetCurChanceInfo().chanceID ~= iter_7_1[3] then
					return false
				elseif iter_7_1[2] == "canUseProp" and manager.ChessBoardManager:GetIsCanUseProp() ~= iter_7_1[3] then
					return false
				elseif iter_7_1[2] == "hasProp" and #manager.ChessBoardManager:GetHeroProp() <= 0 then
					return false
				end
			else
				return false
			end
		elseif iter_7_1[1] == "idolCompetition" then
			local var_7_12 = gameContext:GetOpenPageHandler("idolCompetitionMain")

			if var_7_12 == nil then
				return false
			end

			if not var_7_12.myTakePartIn_ and var_7_12.curRacePhase_ > 1 then
				return false
			end
		elseif iter_7_1[1] == "selfSticker" then
			local var_7_13 = gameContext:GetOpenPageHandler("customStickerMain")

			if var_7_13 == nil or var_7_13.params_.foreign then
				return false
			end
		elseif iter_7_1[1] == "qworldFunction" then
			if not QWorldData:IsUnlockFunction(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "bloodCardFunction" then
			if not BloodCardTools.IsUnlockGuide(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "qworldSubQuest" then
			if not QWorldQuestTool.IsSubQuestFinish(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "osirisPlayGame" then
			if not OsirisPlayGameData:IsPassStagesByStageId(iter_7_1[2]) then
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
			elseif iter_7_1[2] == "tetrisStage" then
				if (TetrisGameRunTimeManager:GetBlackBoard() and TetrisGameRunTimeManager:GetBlackBoard().stageID) ~= iter_7_1[3] then
					return false
				end
			end
		elseif iter_7_1[1] == "goldMiner" then
			if iter_7_1[2] ~= GodEaterData:GetGoldActivityId() then
				return false
			end
		elseif iter_7_1[1] == "civilizationGame" then
			if gameContext:GetOpenPageHandler("civilizationGameView") == nil then
				return false
			end

			local var_7_14 = civilization.CivilizationLuaBridge.CheckStage()

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
			local var_7_15 = AutoChessData:GetCurGameType()

			if var_7_15 and var_7_15 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			local var_7_16 = string.split(iter_7_1[2], "_")

			if AutoChessTools.GetCurStageId() ~= tonumber(var_7_16[1]) or AutoChessTools.GetCurRound() ~= tonumber(var_7_16[2]) then
				return false
			end
		elseif iter_7_1[1] == "zzqEvent" then
			local var_7_18 = AutoChessData:GetCurGameType()

			if var_7_18 and var_7_18 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			local var_7_19 = tonumber(iter_7_1[2])
			local var_7_20 = AutoChessData:GetGameStatus()
			local var_7_21 = AutoChessBattleSimulator.GetInstance():GetStatus()
			local var_7_22 = AutoChessBattleSimulator.GetInstance():GetBlackboard()

			if var_7_20 == AutoChessConst.GAME_STATUS.NONE or var_7_20 == AutoChessConst.GAME_STATUS.PREPARE or var_7_20 == AutoChessConst.GAME_STATUS.REPLAY then
				return false
			end

			if var_7_19 == 1 then
				if var_7_21 ~= AutoChessConst.BATTLE_STATUS.PLAYING then
					return false
				end
			elseif var_7_19 == 3 then
				if not var_7_22:GetIsFightOver() then
					return false
				end
			else
				return false
			end
		elseif iter_7_1[1] == "zzqBossStage" then
			local var_7_23 = AutoChessData:GetCurGameType()

			if var_7_23 and var_7_23 ~= AutoChessConst.GAME_TYPE.PVE then
				return false
			end

			if AutoChessData:GetGameStatus(0) == AutoChessConst.GAME_STATUS.REPLAY then
				return false
			end

			local var_7_24 = tonumber(iter_7_1[2])
			local var_7_25 = AutoChessData:GetBattleBossRound()
			local var_7_26 = AutoChessTools.GetCurRound()

			if not var_7_25 or not var_7_26 or var_7_25 + var_7_24 ~= var_7_26 then
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
			if Pinball.PinballGameManager.Instance.currentStageIndex < iter_7_1[2] then
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
			if not HodurTools.GetStagePass(iter_7_1[2], (HodurTools.GetChapterIDByStageID(iter_7_1[2]))) then
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
			if not ChapterV2MapData:IsEventCompleted(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "rogueCardGame" then
			if RogueCardGameBridge.InGame() == false then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance.GameContext.stageID ~= iter_7_1[2] then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance.GameContext.curRound ~= iter_7_1[3] then
				return false
			end

			if gameContext:GetLastOpenPage() ~= "rogueCardGameView" then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance:GetMiniStage() ~= iter_7_1[4] then
				return false
			end

			if RogueCard.RogueCardGameMain.Instance:GetGuideState() ~= iter_7_1[5] then
				return false
			end
		elseif iter_7_1[1] == "rogueCardGamePosting" then
			if not RogueCardGameTools.GetIsFinishPreById(iter_7_1[2]) then
				return false
			end
		elseif iter_7_1[1] == "mergeballStage" then
			if BilliardGameMgr:GetStageId() ~= iter_7_1[2] then
				return false
			end

			if iter_7_1[3] > BilliardGameMgr:GetCurRound() then
				return false
			end
		elseif iter_7_1[1] == "mergeballPass" then
			if not table.indexof(VehicleBallData:GetPassedStageList(), iter_7_1[2]) then
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
	local var_8_0 = ComponentStep.New(nil, 101):AnalyzeComponentCfg((GuideTool.stringToTable(arg_8_0)))

	if var_8_0 then
		LeanTween.scale(var_8_0.gameObject, Vector3.New(1.2, 1.2, 1.2), 0.2)
		LeanTween.scale(var_8_0.gameObject, Vector3.one, 0.2):setDelay(0.2)
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
	local var_13_1

	if not var_13_0 then
		return {}
	end

	for iter_13_0, iter_13_1 in ipairs((string.split(arg_13_1, "/"))) do
		var_13_1 = iter_13_0 == 1 and var_13_0[iter_13_1] or var_13_1[iter_13_1]
	end

	if not var_13_1 then
		return {}
	end

	local var_13_2 = var_13_1:GetItemList()

	if not var_13_2 or not var_13_2[arg_13_2] then
		return {}
	end

	local var_13_3 = var_13_2[arg_13_2]

	var_0_3 = {}
	var_0_4 = var_13_3
	var_0_5 = "LuaList_Item"

	var_0_0.GetGuideComponent(var_13_3, "", 0)

	return var_0_3
end

function var_0_0.GetGuideComponent(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 > 2 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		if type(iter_14_1) == "userdata" and not isNil(iter_14_1) then
			table.insert(var_0_3, {
				var_0_5,
				arg_14_1 .. iter_14_0,
				iter_14_1
			})
		elseif type(iter_14_1) == "table" then
			if iter_14_1.__cname == "LuaList" and iter_14_1.uiList_ ~= nil then
				table.insert(var_0_3, {
					var_0_5,
					arg_14_1 .. iter_14_0,
					iter_14_1.uiList_
				})
			elseif iter_14_1 ~= var_0_4 then
				var_0_0.GetGuideComponent(iter_14_1, (arg_14_1 .. iter_14_0) .. "/", arg_14_2 + 1)
			end
		end
	end
end

function var_0_0.CheckWeakGuide(arg_15_0)
	if GuideWeakCfg.get_id_list_by_name[arg_15_0] == nil then
		return false
	end

	local var_15_0 = {
		priority = -9999
	}

	for iter_15_0, iter_15_1 in pairs(GuideWeakCfg.get_id_list_by_name[arg_15_0]) do
		local var_15_1 = GuideWeakCfg[iter_15_1]

		if not GuideData:IsWeakGuideFinish(iter_15_1) and not (GuideWeakCfg[iter_15_1].skipcondition[1] ~= nil and GuideTool.SatisfyCondition(var_15_1.skipcondition)) and var_15_1.priority > var_15_0.priority and GuideTool.SatisfyCondition(var_15_1.opencondition) then
			var_15_0 = var_15_1
		end
	end

	if var_15_0.priority == -9999 then
		return false
	end

	return true, var_15_0
end

function var_0_0:GetGuideComponentByRoute(arg_16_1)
	local var_16_0 = 1
	local var_16_1

	while var_16_0 <= #arg_16_1 do
		local var_16_2 = var_16_0 == 1 and self[arg_16_1[var_16_0]] or var_16_1[arg_16_1[var_16_0]]

		if var_16_2 then
			var_16_1 = var_16_2
			var_16_0 = var_16_0 + 1
		else
			return nil
		end
	end

	return var_16_1
end

function var_0_0:GetCommonStepGuideComponent(arg_17_1)
	if arg_17_1.guide_component and #arg_17_1.guide_component > 0 and arg_17_1.guide_component[1] == "common" then
		if arg_17_1.guide_component[3] and #arg_17_1.guide_component[3] > 0 then
			if arg_17_1.guide_component[3][1] == "guideComponents" then
				return self.guideComponents[arg_17_1.guide_component[3][2]]
			else
				return self[arg_17_1.guide_component[3][1]]
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
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs((var_0_0.GetPools())) do
		if var_18_0[var_0_6[DrawPoolCfg[iter_18_1].pool_show_type]] == nil then
			var_18_0[var_0_6[DrawPoolCfg[iter_18_1].pool_show_type]] = 1
		end

		var_18_0[var_0_6[DrawPoolCfg[iter_18_1].pool_show_type]] = var_18_0[var_0_6[DrawPoolCfg[iter_18_1].pool_show_type]] + 1
	end

	local var_18_1 = {}

	for iter_18_2 = 1, 8 do
		if var_18_0[iter_18_2] then
			var_18_1[iter_18_2] = 1
		end
	end

	return var_18_1[var_0_6[DrawPoolCfg[arg_18_0].pool_show_type]]
end

function var_0_0.GetPools()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(iter_19_1) then
			if ActivityDrawPoolCfg[iter_19_1] then
				for iter_19_2, iter_19_3 in ipairs(ActivityDrawPoolCfg[iter_19_1].config_list) do
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
