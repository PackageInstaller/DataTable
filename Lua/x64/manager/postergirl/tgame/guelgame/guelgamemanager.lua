local var_0_0 = singletonClass("GuelGameManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameData = {}
	arg_1_0.taskRunDic = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.clearCombo = {}

	local var_2_0 = {}

	for iter_2_0 = 1, 2 do
		local var_2_1 = BrahmaGameSettingCfg[iter_2_0]
		local var_2_2 = var_2_1.health * var_2_1.max_angry
		local var_2_3 = {
			artres = 1,
			eliminationNum = 0,
			nowAnger = 0,
			tileList = {},
			angerMax = var_2_2,
			Maxhp = var_2_1 and var_2_1.health or GueGameConst.maxHp,
			nowHp = var_2_1 and var_2_1.health or GueGameConst.maxHp,
			skillDamage = var_2_1 and var_2_1.ultimate or 30,
			singleTileAttackNum = var_2_1 and var_2_1.damage or 1
		}

		table.insert(var_2_0, var_2_3)
	end

	arg_2_0.gameData = {
		isSpecial = false,
		time = 0,
		charge_combo = 3,
		speaialTimes = 0,
		cryTimes = 0,
		startingAni = false,
		gameTime = 60,
		startTime = 0,
		infoList = var_2_0,
		skillUseList = {},
		playerState = GueGameConst.GameState.start,
		aiState = GueGameConst.GameState.start,
		globalState = GueGameConst.GameState.start
	}
	arg_2_0.gameView = arg_2_1

	arg_2_0:InitTileAndData()
	arg_2_0.gameView.ShowTileList(arg_2_1, arg_2_0.gameData.infoList[1].tileList, arg_2_0.gameData.infoList[2].tileList)
end

function var_0_0.InitTileAndData(arg_3_0)
	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		var_3_0[0] = 0
		repeatNum = {}
		repeatNum[0] = 0

		for iter_3_1 = 1, 12 do
			local var_3_1 = math.random(1, #GueGameConst.GameColorRandom)
			local var_3_2 = repeatNum[iter_3_1 - 1] or 0
			local var_3_3 = var_3_0[iter_3_1 - 1] or 0

			if var_3_2 >= 1 and (var_3_1 == var_3_3 or var_3_1 == 0) then
				var_3_1 = (var_3_1 + 1) % #GueGameConst.GameColorRandom

				if var_3_1 == 0 then
					var_3_1 = 3
				end
			end

			local var_3_4 = {
				index = iter_3_1,
				color = GueGameConst.GameColorRandom[var_3_1],
				colorIndex = var_3_1
			}

			table.insert(arg_3_0.gameData.infoList[iter_3_0].tileList, var_3_4)

			var_3_0[iter_3_1] = var_3_1

			if var_3_1 == var_3_0[iter_3_1 - 1] then
				repeatNum[iter_3_1] = 1
			else
				repeatNum[iter_3_1] = 0
			end
		end
	end
end

function var_0_0.AddScheduleTimeTask(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if arg_4_6 then
		arg_4_4()
	end

	if not arg_4_0.taskRunDic[arg_4_1] then
		arg_4_0.taskRunDic[arg_4_1] = {
			startTicket = arg_4_7 and Time.realtimeSinceStartup or arg_4_0.gameData.time,
			finishTicket = (arg_4_7 and Time.realtimeSinceStartup or arg_4_0.gameData.time) + arg_4_2,
			condition = arg_4_3 or function()
				return true
			end,
			taskRun = arg_4_4,
			loop = arg_4_5,
			intervalTime = arg_4_2,
			useRealTime = arg_4_7
		}
	end
end

function var_0_0.UpdateScheduleTimeTask(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.taskRunDic) do
		local var_6_0 = iter_6_1.useRealTime and Time.realtimeSinceStartup or arg_6_0.gameData.time

		if var_6_0 >= iter_6_1.finishTicket and iter_6_1.condition and iter_6_1.condition() then
			iter_6_1.taskRun()

			if iter_6_1.loop then
				iter_6_1.startTicket = var_6_0
				iter_6_1.finishTicket = var_6_0 + iter_6_1.intervalTime
			end
		end
	end
end

function var_0_0.RemoveScheduleTimeTask(arg_7_0, arg_7_1)
	if arg_7_0.taskRunDic[arg_7_1] then
		arg_7_0.taskRunDic[arg_7_1] = nil
	end
end

function var_0_0.UpdateLogic(arg_8_0, arg_8_1)
	if arg_8_0.gameData.globalState == GueGameConst.GameState.pause then
		return
	end

	if arg_8_0.gameData.globalState == GueGameConst.GameState.gameEnd then
		return
	end

	arg_8_0:UpdateScheduleTimeTask()
	arg_8_0:UpdateBattleInfo()

	if arg_8_0.gameData.globalState == GueGameConst.GameState.skillIng then
		return
	end

	if manager.guide:IsPlaying() then
		return
	end

	arg_8_0.gameData.time = arg_8_0.gameData.time + arg_8_1
	arg_8_0.gameData.gameTime = arg_8_0.gameData.gameTime - arg_8_1

	arg_8_0:CheckGameEnd()
	arg_8_0:UpdateTime()
end

function var_0_0.DoAICLear(arg_9_0)
	Debug.Log("DoAICLear" .. arg_9_0.gameData.aiState)

	if arg_9_0.globalState == GueGameConst.GameState.pause or arg_9_0.globalState == GueGameConst.GameState.gameEnd then
		return
	end

	if arg_9_0.gameData.aiState ~= GueGameConst.GameState.playing then
		return
	end

	if startingAni then
		return
	end

	local var_9_0 = math.random(1, 12)

	arg_9_0:DoClickTile(false, var_9_0)
end

function var_0_0.DoClickTile(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:AddScheduleTimeTask("DoClickTile" .. (arg_10_1 and 1 or 2), 0.1, function()
		Debug.Log("DoClickTile" .. arg_10_0.gameView:GetSpineName(arg_10_1) .. tostring(arg_10_0.gameView:GetSpineName(arg_10_1) ~= "ult"))

		return arg_10_0.gameData.globalState == GueGameConst.GameState.playing and arg_10_0.gameView:GetSpineName(arg_10_1) ~= "ult" and not arg_10_0.gameData.isSpecial
	end, function()
		arg_10_0:RemoveScheduleTimeTask("DoClickTile" .. (arg_10_1 and 1 or 2))
		arg_10_0:ClickTile(arg_10_1, arg_10_2)
	end, false, false)
end

function var_0_0.UpdateBattleInfo(arg_13_0)
	for iter_13_0 = 1, 2 do
		local var_13_0 = arg_13_0.gameData.infoList[iter_13_0].nowAnger / arg_13_0.gameData.infoList[iter_13_0].angerMax

		arg_13_0.gameView["skillicon" .. iter_13_0 .. "Img_"].fillAmount = var_13_0
		arg_13_0.gameView[string.format("maskImg%s_", iter_13_0)].fillAmount = 1 - var_13_0

		if iter_13_0 == 1 then
			arg_13_0.canClickSkill = var_13_0 >= 1

			arg_13_0.gameView.selfSkillStateController:SetSelectedState(var_13_0 >= 1 and "complete" or "charge")
		end

		if iter_13_0 == 2 then
			arg_13_0.gameView.enemySkillStateController:SetSelectedState(var_13_0 >= 1 and "complete" or "charge")
		end

		local var_13_1 = arg_13_0.gameData.infoList[iter_13_0].nowHp / arg_13_0.gameData.infoList[iter_13_0].Maxhp

		arg_13_0.gameView["hp" .. iter_13_0].fillAmount = var_13_1
	end
end

function var_0_0.UpdateTime(arg_14_0)
	arg_14_0.gameView.timeText_.text = manager.time:DescCDTime4(arg_14_0.gameData.gameTime)
end

function var_0_0.CheckGameEnd(arg_15_0)
	local var_15_0 = arg_15_0.gameData.infoList[1].nowHp
	local var_15_1 = arg_15_0.gameData.infoList[2].nowHp

	if arg_15_0.gameData.gameTime <= 0 or var_15_1 <= 0 or var_15_0 <= 0 then
		arg_15_0.gameData.gameTime = 0

		arg_15_0:RemoveScheduleTimeTask("GameAI")

		if arg_15_0.gameData.globalState == GueGameConst.GameState.skillIng then
			return
		end

		arg_15_0.gameData.playerState = GueGameConst.GameState.gameEnd
		arg_15_0.gameData.aiState = GueGameConst.GameState.gameEnd
		arg_15_0.gameData.globalState = GueGameConst.GameState.gameEnd

		local var_15_2 = var_15_1 < var_15_0

		arg_15_0.gameView:ShowReult(var_15_2 and 1 or 2)

		arg_15_0.timer2 = TimeTools.StartAfterSeconds(4, function()
			local var_16_0 = var_15_2 and GuelGameManager.GameResult.Win or GuelGameManager.GameResult.Lose

			GuelGameManager.GetInstance():RecordLog(var_16_0)
			GuelGameAcion.ExitGame(var_16_0)
			manager.posterGirl:SetStateCanChange(true)
			JumpTools.Back(2)
		end, {})
	end
end

function var_0_0.StartGame(arg_17_0)
	arg_17_0:StopTimer()

	arg_17_0.timer = FrameTimer.New(function()
		arg_17_0:UpdateLogic(Time.deltaTime)
	end, 1, -1)

	arg_17_0.timer:Start()

	arg_17_0.gameData.globalState = GueGameConst.GameState.playing
	arg_17_0.gameData.playerState = GueGameConst.GameState.playing
	arg_17_0.gameData.aiState = GueGameConst.GameState.playing

	local var_17_0 = GameSetting.guelgame_aitrigger_time.value[1] or 5

	arg_17_0:AddScheduleTimeTask("GameAI", var_17_0, nil, function()
		arg_17_0:DoAICLear()
	end, true, false)
end

function var_0_0.ClickTile(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 and (arg_20_0.gameData.globalState ~= GueGameConst.GameState.playing or arg_20_0.gameData.playerState ~= GueGameConst.GameState.playing) or startingAni then
		return
	end

	if arg_20_1 then
		arg_20_0.gameData.playerState = GueGameConst.GameState.clearing
	else
		arg_20_0.gameData.aiState = GueGameConst.GameState.clearing
	end

	local var_20_0 = arg_20_1 and arg_20_0.gameData.infoList[1].tileList or arg_20_0.gameData.infoList[2].tileList
	local var_20_1 = {}
	local var_20_2 = var_20_0[arg_20_2]

	if not var_20_2 then
		Debug.LogError("点击方块数据错误")

		return
	end

	local var_20_3 = arg_20_1 and 1 or 2

	for iter_20_0 = 1, arg_20_2 - 1 do
		local var_20_4 = var_20_0[arg_20_2 - iter_20_0]

		if var_20_2.color == var_20_4.color then
			table.insert(var_20_1, arg_20_2 - iter_20_0)
		else
			break
		end
	end

	for iter_20_1 = arg_20_2 + 1, #var_20_0 do
		local var_20_5 = var_20_0[iter_20_1]

		if var_20_2.color == var_20_5.color then
			table.insert(var_20_1, iter_20_1)
		else
			break
		end
	end

	table.insert(var_20_1, arg_20_2)
	arg_20_0:RemoveTile(arg_20_1, var_20_0, var_20_1)

	local var_20_6 = 1
	local var_20_7 = arg_20_1 and 2 or 1
	local var_20_8 = arg_20_0:GetComboDamage(var_20_7, var_20_6, #var_20_1)

	arg_20_0:DOClearTile(arg_20_1, var_20_6, var_20_8)
	arg_20_0:AddScheduleTimeTask("DoAnimationMoveClick" .. var_20_3, 0.4, function()
		return true
	end, function()
		arg_20_0:RemoveScheduleTimeTask("DoAnimationMoveClick" .. var_20_3)
		arg_20_0:UpdateTarList(var_20_0)
		arg_20_0:AddTile()
		arg_20_0.gameView:ShowTileListWithAnimation(arg_20_0.gameData.infoList[1].tileList, arg_20_0.gameData.infoList[2].tileList, arg_20_1 and 1 or 2)
	end)
end

function var_0_0.DOClearTile(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1 and "playerState" or "aiState"

	arg_23_0.gameData[var_23_0] = GueGameConst.GameState.clearing
	arg_23_3 = arg_23_3 or 0

	arg_23_0.gameView:ShowAnimation(arg_23_1, 9)
	arg_23_0:AddScheduleTimeTask("CheckTile" .. (arg_23_1 and 1 or 2), 0.5, function()
		return arg_23_0.gameView:GetSpineName(arg_23_1) ~= "ult" and (arg_23_0.gameData[var_23_0] == GueGameConst.GameState.clearing or arg_23_0.gameData[var_23_0] == GueGameConst.GameState.playing)
	end, function()
		local var_25_0, var_25_1 = arg_23_0:CheckLineCanClear(arg_23_1)

		arg_23_0:DoClear(arg_23_1)

		local var_25_2 = arg_23_1 and 2 or 1
		local var_25_3 = arg_23_0:GetComboDamage(var_25_2, arg_23_2, #var_25_1)

		arg_23_3 = arg_23_3 + var_25_3

		Debug.Log("当前累计伤害" .. arg_23_3 .. "当前连击次数" .. arg_23_2 .. "当前消除方块数" .. #var_25_1 .. "当前连击伤害" .. var_25_3)
		arg_23_0:RemoveScheduleTimeTask("CheckTile" .. (arg_23_1 and 1 or 2))

		if var_25_0 then
			arg_23_0:DOClearTile(arg_23_1, arg_23_2 + 1, arg_23_3)
		else
			if arg_23_2 >= arg_23_0.gameData.charge_combo then
				arg_23_0.gameView:ShowAnimation(arg_23_1, 8)
			else
				arg_23_0.gameView:ShowAnimation(arg_23_1, 2)
			end

			arg_23_0:AddScheduleTimeTask("ResetGameState" .. (arg_23_1 and 1 or 2), 0.25, function()
				return true
			end, function()
				arg_23_0:RemoveScheduleTimeTask("ResetGameState" .. (arg_23_1 and 1 or 2))
				Debug.Log("最终状态" .. var_23_0)

				arg_23_0.gameData[var_23_0] = GueGameConst.GameState.playing

				arg_23_0:AddAngerAndDamage(var_25_2, arg_23_3, arg_23_2, true)
			end)
		end
	end, false, false, true)
end

function var_0_0.GetComboDamage(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_1 == 1 and 2 or 1
	local var_28_1 = BrahmaGameSettingCfg[var_28_0] or BrahmaGameSettingCfg[1]
	local var_28_2 = var_28_1["combo_factor" .. arg_28_2 - 1] or arg_28_2 - 1

	return var_28_1.damage * (var_28_2 * arg_28_3)
end

function var_0_0.AddAngerAndDamage(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = arg_29_0.gameData.infoList[3 - arg_29_1]
	local var_29_1 = arg_29_0.gameData.infoList[arg_29_1]
	local var_29_2 = arg_29_2

	var_29_0.nowAnger = Mathf.Clamp(var_29_0.nowAnger + var_29_2, 0, var_29_0.angerMax)
	var_29_1.nowHp = Mathf.Clamp(var_29_1.nowHp - arg_29_2, 0, var_29_1.Maxhp)

	local var_29_3 = arg_29_1 == 2

	arg_29_0.gameView:ShowHitAni(not var_29_3)
	arg_29_0:CheckSpecialState()

	if not var_29_3 then
		arg_29_0:AddScheduleTimeTask("CheckSkill", 0.33, function()
			return true
		end, function()
			arg_29_0:DOSkill(2)
			arg_29_0:RemoveScheduleTimeTask("CheckSkill")
		end, false, false, false)
	end
end

function var_0_0.CheckSpecialState(arg_32_0)
	local var_32_0 = arg_32_0.gameData.infoList[1].nowHp
	local var_32_1 = arg_32_0.gameData.infoList[2].nowHp

	if (GameSetting.guelgame_hp_trigger.value[1] / 100 or 0.1) < var_32_1 / arg_32_0.gameData.infoList[2].Maxhp - var_32_0 / arg_32_0.gameData.infoList[1].Maxhp and arg_32_0.gameData.speaialTimes == 0 then
		arg_32_0.gameData.globalState = GueGameConst.GameState.skillIng
		arg_32_0.gameData.playerState = GueGameConst.GameState.skillIng
		arg_32_0.gameData.aiState = GueGameConst.GameState.skillIng

		arg_32_0.gameView:ShowTaunt()

		arg_32_0.gameData.speaialTimes = arg_32_0.gameData.speaialTimes + 1

		arg_32_0:AddScheduleTimeTask("Dospecial", 2, function()
			return arg_32_0.gameView:GetSpineName(false) ~= "ult"
		end, function()
			arg_32_0.gameData.globalState = GueGameConst.GameState.playing
			arg_32_0.gameData.playerState = GueGameConst.GameState.playing
			arg_32_0.gameData.aiState = GueGameConst.GameState.skillIng
			arg_32_0.gameData.isSpecial = true

			arg_32_0.gameView:ShowAnimation(false, 4)
			arg_32_0:AddScheduleTimeTask("DospecialSpine", 3, function()
				return arg_32_0.gameView:GetSpineName(false) ~= "ult"
			end, function()
				arg_32_0:RemoveScheduleTimeTask("DospecialSpine")

				arg_32_0.gameData.aiState = GueGameConst.GameState.playing
				arg_32_0.gameData.isSpecial = false
			end, false, false, true)
			arg_32_0:RemoveScheduleTimeTask("Dospecial")
		end, false, false, true)
	end

	if (GameSetting.guelgame_sad_trigger.value[1] / 100 or 0.1) > var_32_1 / arg_32_0.gameData.infoList[2].Maxhp and arg_32_0.gameData.cryTimes == 0 then
		arg_32_0.gameData.globalState = GueGameConst.GameState.skillIng
		arg_32_0.gameData.playerState = GueGameConst.GameState.skillIng
		arg_32_0.gameData.aiState = GueGameConst.GameState.skillIng

		arg_32_0.gameView:ShowCry()

		arg_32_0.gameData.cryTimes = arg_32_0.gameData.cryTimes + 1

		arg_32_0:AddScheduleTimeTask("DoCry", 3, function()
			return arg_32_0.gameView:GetSpineName(true) ~= "ult"
		end, function()
			arg_32_0.gameData.globalState = GueGameConst.GameState.playing
			arg_32_0.gameData.playerState = GueGameConst.GameState.playing
			arg_32_0.gameData.aiState = GueGameConst.GameState.playing

			arg_32_0:RemoveScheduleTimeTask("DoCry")
		end, false, false, true)
	end
end

function var_0_0.DOSkill(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.gameData.infoList[arg_39_1]

	if var_39_0.nowAnger >= var_39_0.angerMax then
		local var_39_1 = arg_39_1 == 1 and "playerState" or "aiState"

		arg_39_0.gameData[var_39_1] = GueGameConst.GameState.skillIng
		arg_39_0.gameData.globalState = GueGameConst.GameState.skillIng

		local var_39_2 = arg_39_1 == 1

		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_skill", "")

		if var_39_2 then
			arg_39_0.gameView:ShowSelfUltimate()
		else
			arg_39_0.gameView:ShowEnemyUltimate()
		end

		arg_39_0:AddScheduleTimeTask("DoSkill" .. (var_39_2 and 1 or 2), 2.5, function()
			return var_39_0.nowAnger >= var_39_0.angerMax and (arg_39_0.gameData.globalState == GueGameConst.GameState.playing or arg_39_0.gameData.globalState == GueGameConst.GameState.skillIng)
		end, function()
			arg_39_0:RemoveScheduleTimeTask("DoSkill" .. (var_39_2 and 1 or 2))

			var_39_0.nowAnger = 0
			arg_39_0.gameData.skillUseList[arg_39_1] = (arg_39_0.gameData.skillUseList[arg_39_1] and arg_39_0.gameData.skillUseList[arg_39_1] or 0) + 1
			arg_39_0.gameData.infoList[3 - arg_39_1].nowHp = Mathf.Clamp(arg_39_0.gameData.infoList[3 - arg_39_1].nowHp - var_39_0.skillDamage, 0, var_39_0.Maxhp)

			arg_39_0.gameView:ShowHitAni(not var_39_2)

			arg_39_0.gameData[var_39_1] = GueGameConst.GameState.playing
			arg_39_0.gameData.globalState = GueGameConst.GameState.playing
		end, false, false, true)
	end
end

function var_0_0.DoClear(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1 and arg_42_0.gameData.infoList[1].tileList or arg_42_0.gameData.infoList[2].tileList
	local var_42_1, var_42_2 = arg_42_0:CheckLineCanClear(arg_42_1)
	local var_42_3, var_42_4 = arg_42_0:CheckLineCanClear(arg_42_1)

	arg_42_0:RemoveTile(arg_42_1, var_42_0, var_42_4)
	arg_42_0:AddScheduleTimeTask("DoAnimationMove" .. (arg_42_1 and 1 or 2), 0.4, function()
		return true
	end, function()
		arg_42_0:RemoveScheduleTimeTask("DoAnimationMove" .. (arg_42_1 and 1 or 2))
		arg_42_0:UpdateTarList(var_42_0)
		arg_42_0:AddTile()
		arg_42_0.gameView:ShowTileListWithAnimation(arg_42_0.gameData.infoList[1].tileList, arg_42_0.gameData.infoList[2].tileList, arg_42_1 and 1 or 2)
	end)
end

function var_0_0.RemoveTile(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if arg_45_1 then
		if #arg_45_3 > 0 and #arg_45_3 < 3 then
			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_block_normal", "")
		elseif #arg_45_3 >= 3 then
			manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_block_power", "")
		end
	end

	table.sort(arg_45_3, function(arg_46_0, arg_46_1)
		return arg_46_1 < arg_46_0
	end)

	for iter_45_0, iter_45_1 in ipairs(arg_45_3) do
		local var_45_0 = table.remove(arg_45_2, iter_45_1)

		arg_45_0.gameView:DestroyTile(arg_45_1, iter_45_1)
	end
end

function var_0_0.UpdateTarList(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		arg_47_1[iter_47_0].index = iter_47_0
	end
end

function var_0_0.AddTile(arg_48_0)
	for iter_48_0 = 1, 2 do
		local var_48_0 = {}

		var_48_0[0] = 0
		repeatNum = {}
		repeatNum[0] = 0

		local var_48_1 = #arg_48_0.gameData.infoList[iter_48_0].tileList

		for iter_48_1 = Mathf.Clamp(var_48_1 - 3, 1, 12), 12 do
			local var_48_2 = arg_48_0.gameData.infoList[iter_48_0].tileList[iter_48_1]
			local var_48_3 = var_48_2 and var_48_2.colorIndex or math.random(1, #GueGameConst.GameColorRandom)
			local var_48_4 = var_48_3
			local var_48_5 = repeatNum[iter_48_1 - 1] or 0
			local var_48_6 = var_48_0[iter_48_1 - 1] or 0

			if var_48_5 >= 1 and (var_48_3 == var_48_6 or var_48_3 == 0) then
				var_48_3 = (var_48_3 + 1) % #GueGameConst.GameColorRandom

				if var_48_3 == 0 then
					var_48_3 = 3
				end
			end

			local var_48_7 = {
				index = iter_48_1,
				color = GueGameConst.GameColorRandom[var_48_3],
				colorIndex = var_48_3
			}

			if not var_48_2 then
				table.insert(arg_48_0.gameData.infoList[iter_48_0].tileList, var_48_7)
			end

			var_48_0[iter_48_1] = var_48_3

			if var_48_3 == var_48_6 then
				repeatNum[iter_48_1] = 1
			else
				repeatNum[iter_48_1] = 0
			end
		end
	end
end

function var_0_0.CheckLineCanClear(arg_49_0, arg_49_1)
	local var_49_0 = 3
	local var_49_1 = arg_49_1 and arg_49_0.gameData.infoList[1].tileList or arg_49_0.gameData.infoList[2].tileList

	repeatList = {}
	repeatList[0] = 0

	local var_49_2 = false

	for iter_49_0, iter_49_1 in ipairs(var_49_1) do
		if iter_49_0 == 1 then
			repeatList[iter_49_0] = 0
		else
			local var_49_3 = var_49_1[iter_49_0 - 1]

			if iter_49_1.color == var_49_3.color then
				repeatList[iter_49_0] = repeatList[iter_49_0 - 1] + 1
			else
				repeatList[iter_49_0] = 0
			end
		end
	end

	local var_49_4 = {}
	local var_49_5 = 999

	for iter_49_2, iter_49_3 in ipairs(repeatList) do
		if iter_49_3 >= var_49_0 - 1 then
			table.insert(var_49_4, iter_49_2)

			var_49_5 = math.min(var_49_5, iter_49_2)
		end
	end

	if #var_49_4 > 0 then
		for iter_49_4 = 1, var_49_0 - 1 do
			table.insert(var_49_4, var_49_5 - iter_49_4)
		end
	end

	return #var_49_4 > 0, var_49_4
end

function var_0_0.StopTimer(arg_50_0)
	if arg_50_0.timer then
		arg_50_0.timer:Stop()

		arg_50_0.timer = nil
	end

	if arg_50_0.timer2 then
		arg_50_0.timer2:Stop()

		arg_50_0.timer2 = nil
	end

	arg_50_0.taskRunDic = {}
end

function var_0_0.SetSelect(arg_51_0)
	arg_51_0.chooseIndex = 1
end

function var_0_0.Dispose(arg_52_0)
	arg_52_0:StopTimer()

	arg_52_0.gameData.globalState = GueGameConst.GameState.gameEnd
end

function var_0_0.PauseGame(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0.lastGlobalState = arg_53_0.gameData.globalState

	if arg_53_1 then
		arg_53_0.pauseStartTime = Time.realtimeSinceStartup
		arg_53_0.pausedTasks = {}

		for iter_53_0, iter_53_1 in pairs(arg_53_0.taskRunDic) do
			if iter_53_1.useRealTime then
				arg_53_0.pausedTasks[iter_53_0] = {
					task = iter_53_1,
					remainTime = iter_53_1.finishTicket - Time.realtimeSinceStartup
				}
			end
		end

		arg_53_0.gameData.playerState = GueGameConst.GameState.pause
		arg_53_0.gameData.aiState = GueGameConst.GameState.pause
		arg_53_0.gameData.globalState = GueGameConst.GameState.pause

		manager.audio:Pause("effect", true)
	else
		if arg_53_0.pausedTasks and not arg_53_2 then
			for iter_53_2, iter_53_3 in pairs(arg_53_0.pausedTasks) do
				if iter_53_3.task.useRealTime then
					iter_53_3.task.finishTicket = Time.realtimeSinceStartup + iter_53_3.remainTime
				end

				arg_53_0.taskRunDic[iter_53_2] = iter_53_3.task
			end

			arg_53_0.pausedTasks = nil
		elseif arg_53_2 then
			arg_53_0.taskRunDic = {}
		end

		arg_53_0.gameData.playerState = GueGameConst.GameState.playing
		arg_53_0.gameData.aiState = GueGameConst.GameState.playing
		arg_53_0.gameData.globalState = GueGameConst.GameState.playing

		manager.audio:Pause("effect", false)
	end

	arg_53_0.gameView:PauseTimer(arg_53_1)

	if arg_53_0.timer then
		arg_53_0.timer.running = not arg_53_1
	end

	if arg_53_0.timer2 then
		arg_53_0.timer2.running = not arg_53_1
	end
end

var_0_0.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function var_0_0.RecordLog(arg_54_0, arg_54_1)
	local var_54_0 = PlayerData:GetPosterGirlHeroSkinId()
	local var_54_1 = HomeSceneSettingData:GetCurScene()
	local var_54_2 = arg_54_0.gameData
	local var_54_3 = arg_54_0.gameData.infoList[1].nowHp
	local var_54_4 = arg_54_0.gameData.infoList[2].nowHp
	local var_54_5 = {
		var_54_2.skillUseList[1] or 0,
		var_54_2.skillUseList[2] or 0
	}

	SDKTools.SendMessageToSDK("activity_combat_over", {
		stage_id = 3,
		sys_id = 101,
		skin_id = var_54_0,
		scene_id = var_54_1,
		start_time = var_54_2.startTime,
		boss_hp = var_54_4,
		hero_hp = var_54_3,
		skill_list = SDKTools.JsonEncode(var_54_5),
		other_data = tostring(var_54_2.speaialTimes),
		result = arg_54_1
	})
end

function var_0_0.ResetCombo(arg_55_0, arg_55_1)
	arg_55_0.clearCombo[arg_55_1] = {}
end

return var_0_0
