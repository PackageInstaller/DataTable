local var_0_0 = singletonClass("GuelGameManager")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameData = {}
	arg_1_0.taskRunDic = {}
end

function var_0_0:InitData(arg_2_1, arg_2_2)
	self.clearCombo = {}

	local var_2_0 = {}

	for iter_2_0 = 1, 2 do
		local var_2_1 = BrahmaGameSettingCfg[iter_2_0]
		local var_2_2 = {
			artres = 1,
			eliminationNum = 0,
			nowAnger = 0,
			tileList = {},
			angerMax = BrahmaGameSettingCfg[iter_2_0].health * BrahmaGameSettingCfg[iter_2_0].max_angry
		}

		if BrahmaGameSettingCfg[iter_2_0] then
			var_2_2.Maxhp = var_2_1.health or GueGameConst.maxHp
		end

		if var_2_1 then
			var_2_2.nowHp = var_2_1.health or GueGameConst.maxHp
		end

		if var_2_1 then
			var_2_2.skillDamage = var_2_1.ultimate or 30
		end

		if var_2_1 then
			var_2_2.singleTileAttackNum = var_2_1.damage or 1
		end

		table.insert(var_2_0, var_2_2)
	end

	self.gameData = {
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
	self.gameView = arg_2_1

	self:InitTileAndData()
	self.gameView.ShowTileList(arg_2_1, self.gameData.infoList[1].tileList, self.gameData.infoList[2].tileList)
end

function var_0_0:InitTileAndData()
	for iter_3_0 = 1, 2 do
		local var_3_0 = {}

		var_3_0[0] = 0
		repeatNum = {}
		repeatNum[0] = 0

		for iter_3_1 = 1, 12 do
			local var_3_1 = math.random(1, #GueGameConst.GameColorRandom)

			if (repeatNum[iter_3_1 - 1] or 0) >= 1 and (var_3_1 == (var_3_0[iter_3_1 - 1] or 0) or var_3_1 == 0) then
				var_3_1 = (var_3_1 + 1) % #GueGameConst.GameColorRandom

				if var_3_1 == 0 then
					var_3_1 = 3
				end
			end

			table.insert(self.gameData.infoList[iter_3_0].tileList, {
				index = iter_3_1,
				color = GueGameConst.GameColorRandom[var_3_1],
				colorIndex = var_3_1
			})

			var_3_0[iter_3_1] = var_3_1
			repeatNum[iter_3_1] = var_3_1 == var_3_0[iter_3_1 - 1] and 1 or 0
		end
	end
end

function var_0_0:AddScheduleTimeTask(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if arg_4_6 then
		arg_4_4()
	end

	if not self.taskRunDic[arg_4_1] then
		local var_4_0 = {}

		if arg_4_7 then
			var_4_0.startTicket = Time.realtimeSinceStartup or self.gameData.time
		end

		var_4_0.finishTicket = ((arg_4_7 or nil) and (Time.realtimeSinceStartup or self.gameData.time)) + arg_4_2
		var_4_0.condition = arg_4_3 or function()
			return true
		end
		var_4_0.taskRun = arg_4_4
		var_4_0.loop = arg_4_5
		var_4_0.intervalTime = arg_4_2
		var_4_0.useRealTime = arg_4_7
		self.taskRunDic[arg_4_1] = var_4_0
	end
end

function var_0_0:UpdateScheduleTimeTask()
	for iter_6_0, iter_6_1 in pairs(self.taskRunDic) do
		if iter_6_1.useRealTime then
			local var_6_0 = Time.realtimeSinceStartup or self.gameData.time

			if var_6_0 >= iter_6_1.finishTicket and iter_6_1.condition and iter_6_1.condition() then
				iter_6_1.taskRun()

				if iter_6_1.loop then
					iter_6_1.startTicket = var_6_0
					iter_6_1.finishTicket = var_6_0 + iter_6_1.intervalTime
				end
			end
		end
	end
end

function var_0_0:RemoveScheduleTimeTask(arg_7_1)
	if self.taskRunDic[arg_7_1] then
		self.taskRunDic[arg_7_1] = nil
	end
end

function var_0_0:UpdateLogic(arg_8_1)
	if self.gameData.globalState == GueGameConst.GameState.pause then
		return
	end

	if self.gameData.globalState == GueGameConst.GameState.gameEnd then
		return
	end

	self:UpdateScheduleTimeTask()
	self:UpdateBattleInfo()

	if self.gameData.globalState == GueGameConst.GameState.skillIng then
		return
	end

	if manager.guide:IsPlaying() then
		return
	end

	self.gameData.time = self.gameData.time + arg_8_1
	self.gameData.gameTime = self.gameData.gameTime - arg_8_1

	self:CheckGameEnd()
	self:UpdateTime()
end

function var_0_0:DoAICLear()
	Debug.Log("DoAICLear" .. self.gameData.aiState)

	if self.globalState == GueGameConst.GameState.pause or self.globalState == GueGameConst.GameState.gameEnd then
		return
	end

	if self.gameData.aiState ~= GueGameConst.GameState.playing then
		return
	end

	if startingAni then
		return
	end

	self:DoClickTile(false, (math.random(1, 12)))
end

function var_0_0:DoClickTile(arg_10_1, arg_10_2)
	self:AddScheduleTimeTask("DoClickTile" .. (arg_10_1 and 1 or 2), 0.1, function()
		Debug.Log("DoClickTile" .. self.gameView:GetSpineName(arg_10_1) .. tostring(self.gameView:GetSpineName(arg_10_1) ~= "ult"))

		return self.gameData.globalState == GueGameConst.GameState.playing and self.gameView:GetSpineName(arg_10_1) ~= "ult" and not self.gameData.isSpecial
	end, function()
		self:RemoveScheduleTimeTask("DoClickTile" .. (arg_10_1 and 1 or 2))
		self:ClickTile(arg_10_1, arg_10_2)
	end, false, false)
end

function var_0_0:UpdateBattleInfo()
	for iter_13_0 = 1, 2 do
		local var_13_0 = self.gameData.infoList[iter_13_0].nowAnger / self.gameData.infoList[iter_13_0].angerMax

		self.gameView["skillicon" .. iter_13_0 .. "Img_"].fillAmount = self.gameData.infoList[iter_13_0].nowAnger / self.gameData.infoList[iter_13_0].angerMax
		self.gameView[string.format("maskImg%s_", iter_13_0)].fillAmount = 1 - var_13_0

		if iter_13_0 == 1 then
			self.canClickSkill = var_13_0 >= 1

			self.gameView.selfSkillStateController:SetSelectedState(var_13_0 >= 1 and "complete" or "charge")
		end

		if iter_13_0 == 2 then
			self.gameView.enemySkillStateController:SetSelectedState(var_13_0 >= 1 and "complete" or "charge")
		end

		self.gameView["hp" .. iter_13_0].fillAmount = self.gameData.infoList[iter_13_0].nowHp / self.gameData.infoList[iter_13_0].Maxhp
	end
end

function var_0_0:UpdateTime()
	self.gameView.timeText_.text = manager.time:DescCDTime4(self.gameData.gameTime)
end

function var_0_0:CheckGameEnd()
	local var_15_0 = self.gameData.infoList[1].nowHp
	local var_15_1 = self.gameData.infoList[2].nowHp

	if self.gameData.gameTime <= 0 or var_15_1 <= 0 or var_15_0 <= 0 then
		self.gameData.gameTime = 0

		self:RemoveScheduleTimeTask("GameAI")

		if self.gameData.globalState == GueGameConst.GameState.skillIng then
			return
		end

		self.gameData.playerState = GueGameConst.GameState.gameEnd
		self.gameData.aiState = GueGameConst.GameState.gameEnd
		self.gameData.globalState = GueGameConst.GameState.gameEnd

		local var_15_2 = var_15_1 < var_15_0

		self.gameView:ShowReult(var_15_1 < var_15_0 and 1 or 2)

		self.timer2 = TimeTools.StartAfterSeconds(4, function()
			local var_16_0

			if var_15_2 then
				var_16_0 = GuelGameManager.GameResult.Win or GuelGameManager.GameResult.Lose
			end

			GuelGameManager.GetInstance():RecordLog(var_16_0)
			GuelGameAcion.ExitGame(var_16_0)
			manager.posterGirl:SetStateCanChange(true)
			JumpTools.Back(2)
		end, {})
	end
end

function var_0_0:StartGame()
	self:StopTimer()

	self.timer = FrameTimer.New(function()
		self:UpdateLogic(Time.deltaTime)
	end, 1, -1)

	self.timer:Start()

	self.gameData.globalState = GueGameConst.GameState.playing
	self.gameData.playerState = GueGameConst.GameState.playing
	self.gameData.aiState = GueGameConst.GameState.playing

	self:AddScheduleTimeTask("GameAI", GameSetting.guelgame_aitrigger_time.value[1] or 5, nil, function()
		self:DoAICLear()
	end, true, false)
end

function var_0_0:ClickTile(arg_20_1, arg_20_2)
	if arg_20_1 and (self.gameData.globalState ~= GueGameConst.GameState.playing or self.gameData.playerState ~= GueGameConst.GameState.playing) or startingAni then
		return
	end

	if arg_20_1 then
		self.gameData.playerState = GueGameConst.GameState.clearing
	else
		self.gameData.aiState = GueGameConst.GameState.clearing
	end

	local var_20_0

	if arg_20_1 then
		var_20_0 = self.gameData.infoList[1].tileList or self.gameData.infoList[2].tileList
	end

	local var_20_1 = {}
	local var_20_2 = var_20_0[arg_20_2]

	if not var_20_0[arg_20_2] then
		Debug.LogError("点击方块数据错误")

		return
	end

	local var_20_3 = arg_20_1 and 1 or 2

	for iter_20_0 = 1, arg_20_2 - 1 do
		if var_20_2.color == var_20_0[arg_20_2 - iter_20_0].color then
			table.insert(var_20_1, arg_20_2 - iter_20_0)
		else
			break
		end
	end

	for iter_20_1 = arg_20_2 + 1, #var_20_0 do
		if var_20_2.color == var_20_0[iter_20_1].color then
			table.insert(var_20_1, iter_20_1)
		else
			break
		end
	end

	table.insert(var_20_1, arg_20_2)
	self:RemoveTile(arg_20_1, var_20_0, var_20_1)
	self:DOClearTile(arg_20_1, 1, (self:GetComboDamage(arg_20_1 and 2 or 1, 1, #var_20_1)))
	self:AddScheduleTimeTask("DoAnimationMoveClick" .. var_20_3, 0.4, function()
		return true
	end, function()
		self:RemoveScheduleTimeTask("DoAnimationMoveClick" .. var_20_3)
		self:UpdateTarList(var_20_0)
		self:AddTile()
		self.gameView:ShowTileListWithAnimation(self.gameData.infoList[1].tileList, self.gameData.infoList[2].tileList, arg_20_1 and 1 or 2)
	end)
end

function var_0_0:DOClearTile(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_1 and "playerState" or "aiState"

	self.gameData[arg_23_1 and "playerState" or "aiState"] = GueGameConst.GameState.clearing
	arg_23_3 = arg_23_3 or 0

	self.gameView:ShowAnimation(arg_23_1, 9)
	self:AddScheduleTimeTask("CheckTile" .. (arg_23_1 and 1 or 2), 0.5, function()
		return self.gameView:GetSpineName(arg_23_1) ~= "ult" and (self.gameData[var_23_0] == GueGameConst.GameState.clearing or self.gameData[var_23_0] == GueGameConst.GameState.playing)
	end, function()
		local var_25_0, var_25_1 = self:CheckLineCanClear(arg_23_1)

		self:DoClear(arg_23_1)

		local var_25_2 = arg_23_1 and 2 or 1
		local var_25_3 = self:GetComboDamage(arg_23_1 and 2 or 1, arg_23_2, #var_25_1)

		arg_23_3 = arg_23_3 + var_25_3

		Debug.Log("当前累计伤害" .. arg_23_3 .. "当前连击次数" .. arg_23_2 .. "当前消除方块数" .. #var_25_1 .. "当前连击伤害" .. var_25_3)
		self:RemoveScheduleTimeTask("CheckTile" .. (arg_23_1 and 1 or 2))

		if var_25_0 then
			self:DOClearTile(arg_23_1, arg_23_2 + 1, arg_23_3)
		else
			if arg_23_2 >= self.gameData.charge_combo then
				self.gameView:ShowAnimation(arg_23_1, 8)
			else
				self.gameView:ShowAnimation(arg_23_1, 2)
			end

			self:AddScheduleTimeTask("ResetGameState" .. (arg_23_1 and 1 or 2), 0.25, function()
				return true
			end, function()
				self:RemoveScheduleTimeTask("ResetGameState" .. (arg_23_1 and 1 or 2))
				Debug.Log("最终状态" .. var_23_0)

				self.gameData[var_23_0] = GueGameConst.GameState.playing

				self:AddAngerAndDamage(var_25_2, arg_23_3, arg_23_2, true)
			end)
		end
	end, false, false, true)
end

function var_0_0.GetComboDamage(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = BrahmaGameSettingCfg[arg_28_1 == 1 and 2 or 1] or BrahmaGameSettingCfg[1]

	return var_28_0.damage * ((var_28_0["combo_factor" .. arg_28_2 - 1] or arg_28_2 - 1) * arg_28_3)
end

function var_0_0:AddAngerAndDamage(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	self.gameData.infoList[3 - arg_29_1].nowAnger = Mathf.Clamp(self.gameData.infoList[3 - arg_29_1].nowAnger + arg_29_2, 0, self.gameData.infoList[3 - arg_29_1].angerMax)
	self.gameData.infoList[arg_29_1].nowHp = Mathf.Clamp(self.gameData.infoList[arg_29_1].nowHp - arg_29_2, 0, self.gameData.infoList[arg_29_1].Maxhp)

	local var_29_0 = arg_29_1 == 2

	self.gameView:ShowHitAni(not (arg_29_1 == 2))
	self:CheckSpecialState()

	if not var_29_0 then
		self:AddScheduleTimeTask("CheckSkill", 0.33, function()
			return true
		end, function()
			self:DOSkill(2)
			self:RemoveScheduleTimeTask("CheckSkill")
		end, false, false, false)
	end
end

function var_0_0:CheckSpecialState()
	if (GameSetting.guelgame_hp_trigger.value[1] / 100 or 0.1) < self.gameData.infoList[2].nowHp / self.gameData.infoList[2].Maxhp - self.gameData.infoList[1].nowHp / self.gameData.infoList[1].Maxhp and self.gameData.speaialTimes == 0 then
		self.gameData.globalState = GueGameConst.GameState.skillIng
		self.gameData.playerState = GueGameConst.GameState.skillIng
		self.gameData.aiState = GueGameConst.GameState.skillIng

		self.gameView:ShowTaunt()

		self.gameData.speaialTimes = self.gameData.speaialTimes + 1

		self:AddScheduleTimeTask("Dospecial", 2, function()
			return self.gameView:GetSpineName(false) ~= "ult"
		end, function()
			self.gameData.globalState = GueGameConst.GameState.playing
			self.gameData.playerState = GueGameConst.GameState.playing
			self.gameData.aiState = GueGameConst.GameState.skillIng
			self.gameData.isSpecial = true

			self.gameView:ShowAnimation(false, 4)
			self:AddScheduleTimeTask("DospecialSpine", 3, function()
				return self.gameView:GetSpineName(false) ~= "ult"
			end, function()
				self:RemoveScheduleTimeTask("DospecialSpine")

				self.gameData.aiState = GueGameConst.GameState.playing
				self.gameData.isSpecial = false
			end, false, false, true)
			self:RemoveScheduleTimeTask("Dospecial")
		end, false, false, true)
	end

	if (GameSetting.guelgame_sad_trigger.value[1] / 100 or 0.1) > self.gameData.infoList[2].nowHp / self.gameData.infoList[2].Maxhp and self.gameData.cryTimes == 0 then
		self.gameData.globalState = GueGameConst.GameState.skillIng
		self.gameData.playerState = GueGameConst.GameState.skillIng
		self.gameData.aiState = GueGameConst.GameState.skillIng

		self.gameView:ShowCry()

		self.gameData.cryTimes = self.gameData.cryTimes + 1

		self:AddScheduleTimeTask("DoCry", 3, function()
			return self.gameView:GetSpineName(true) ~= "ult"
		end, function()
			self.gameData.globalState = GueGameConst.GameState.playing
			self.gameData.playerState = GueGameConst.GameState.playing
			self.gameData.aiState = GueGameConst.GameState.playing

			self:RemoveScheduleTimeTask("DoCry")
		end, false, false, true)
	end
end

function var_0_0:DOSkill(arg_39_1)
	local var_39_0 = self.gameData.infoList[arg_39_1]

	if self.gameData.infoList[arg_39_1].nowAnger >= self.gameData.infoList[arg_39_1].angerMax then
		local var_39_1 = arg_39_1 == 1 and "playerState" or "aiState"

		self.gameData[arg_39_1 == 1 and "playerState" or "aiState"] = GueGameConst.GameState.skillIng
		self.gameData.globalState = GueGameConst.GameState.skillIng

		local var_39_2 = arg_39_1 == 1

		manager.audio:PlayEffect("ui_scene_102003", "ui_scene_102003_sanxiao_skill", "")

		if var_39_2 then
			self.gameView:ShowSelfUltimate()
		else
			self.gameView:ShowEnemyUltimate()
		end

		self:AddScheduleTimeTask("DoSkill" .. (var_39_2 and 1 or 2), 2.5, function()
			return var_39_0.nowAnger >= var_39_0.angerMax and (self.gameData.globalState == GueGameConst.GameState.playing or self.gameData.globalState == GueGameConst.GameState.skillIng)
		end, function()
			self:RemoveScheduleTimeTask("DoSkill" .. (var_39_2 and 1 or 2))

			var_39_0.nowAnger = 0
			self.gameData.skillUseList[arg_39_1] = ((self.gameData.skillUseList[arg_39_1] or nil) and (self.gameData.skillUseList[arg_39_1] or 0)) + 1
			self.gameData.infoList[3 - arg_39_1].nowHp = Mathf.Clamp(self.gameData.infoList[3 - arg_39_1].nowHp - var_39_0.skillDamage, 0, var_39_0.Maxhp)

			self.gameView:ShowHitAni(not var_39_2)

			self.gameData[var_39_1] = GueGameConst.GameState.playing
			self.gameData.globalState = GueGameConst.GameState.playing
		end, false, false, true)
	end
end

function var_0_0:DoClear(arg_42_1)
	local var_42_0

	if arg_42_1 then
		var_42_0 = self.gameData.infoList[1].tileList or self.gameData.infoList[2].tileList
	end

	local var_42_1, var_42_2 = self:CheckLineCanClear(arg_42_1)
	local var_42_3, var_42_4 = self:CheckLineCanClear(arg_42_1)

	self:RemoveTile(arg_42_1, var_42_0, var_42_4)
	self:AddScheduleTimeTask("DoAnimationMove" .. (arg_42_1 and 1 or 2), 0.4, function()
		return true
	end, function()
		self:RemoveScheduleTimeTask("DoAnimationMove" .. (arg_42_1 and 1 or 2))
		self:UpdateTarList(var_42_0)
		self:AddTile()
		self.gameView:ShowTileListWithAnimation(self.gameData.infoList[1].tileList, self.gameData.infoList[2].tileList, arg_42_1 and 1 or 2)
	end)
end

function var_0_0:RemoveTile(arg_45_1, arg_45_2, arg_45_3)
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

		self.gameView:DestroyTile(arg_45_1, iter_45_1)
	end
end

function var_0_0.UpdateTarList(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		arg_47_1[iter_47_0].index = iter_47_0
	end
end

function var_0_0:AddTile()
	for iter_48_0 = 1, 2 do
		local var_48_0 = {}

		var_48_0[0] = 0
		repeatNum = {}
		repeatNum[0] = 0

		for iter_48_1 = Mathf.Clamp(#self.gameData.infoList[iter_48_0].tileList - 3, 1, 12), 12 do
			local var_48_1 = self.gameData.infoList[iter_48_0].tileList[iter_48_1]
			local var_48_2

			if self.gameData.infoList[iter_48_0].tileList[iter_48_1] then
				var_48_2 = var_48_1.colorIndex or math.random(1, #GueGameConst.GameColorRandom)
			end

			local var_48_4 = var_48_0[iter_48_1 - 1] or 0

			if (repeatNum[iter_48_1 - 1] or 0) >= 1 and (var_48_2 == var_48_4 or var_48_2 == 0) then
				var_48_2 = (var_48_2 + 1) % #GueGameConst.GameColorRandom

				if var_48_2 == 0 then
					var_48_2 = 3
				end
			end

			if not var_48_1 then
				table.insert(self.gameData.infoList[iter_48_0].tileList, {
					index = iter_48_1,
					color = GueGameConst.GameColorRandom[var_48_2],
					colorIndex = var_48_2
				})
			end

			var_48_0[iter_48_1] = var_48_2
			repeatNum[iter_48_1] = var_48_2 == var_48_4 and 1 or 0
		end
	end
end

function var_0_0:CheckLineCanClear(arg_49_1)
	local var_49_0

	if arg_49_1 then
		var_49_0 = self.gameData.infoList[1].tileList or self.gameData.infoList[2].tileList
	end

	repeatList = {}
	repeatList[0] = 0

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		repeatList[iter_49_0] = iter_49_0 == 1 and 0 or iter_49_1.color == var_49_0[iter_49_0 - 1].color and repeatList[iter_49_0 - 1] + 1 or 0
	end

	local var_49_2 = {}
	local var_49_3 = 999

	for iter_49_2, iter_49_3 in ipairs(repeatList) do
		if iter_49_3 >= 3 - 1 then
			table.insert(var_49_2, iter_49_2)

			var_49_3 = math.min(var_49_3, iter_49_2)
		end
	end

	if #var_49_2 > 0 then
		for iter_49_4 = 1, 3 - 1 do
			table.insert(var_49_2, var_49_3 - iter_49_4)
		end
	end

	return #var_49_2 > 0, var_49_2
end

function var_0_0:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.timer2 then
		self.timer2:Stop()

		self.timer2 = nil
	end

	self.taskRunDic = {}
end

function var_0_0.SetSelect(arg_51_0)
	arg_51_0.chooseIndex = 1
end

function var_0_0:Dispose()
	self:StopTimer()

	self.gameData.globalState = GueGameConst.GameState.gameEnd
end

function var_0_0:PauseGame(arg_53_1, arg_53_2)
	self.lastGlobalState = self.gameData.globalState

	if arg_53_1 then
		self.pauseStartTime = Time.realtimeSinceStartup
		self.pausedTasks = {}

		for iter_53_0, iter_53_1 in pairs(self.taskRunDic) do
			if iter_53_1.useRealTime then
				self.pausedTasks[iter_53_0] = {
					task = iter_53_1,
					remainTime = iter_53_1.finishTicket - Time.realtimeSinceStartup
				}
			end
		end

		self.gameData.playerState = GueGameConst.GameState.pause
		self.gameData.aiState = GueGameConst.GameState.pause
		self.gameData.globalState = GueGameConst.GameState.pause

		manager.audio:Pause("effect", true)
	else
		if self.pausedTasks and not arg_53_2 then
			for iter_53_2, iter_53_3 in pairs(self.pausedTasks) do
				if iter_53_3.task.useRealTime then
					iter_53_3.task.finishTicket = Time.realtimeSinceStartup + iter_53_3.remainTime
				end

				self.taskRunDic[iter_53_2] = iter_53_3.task
			end

			self.pausedTasks = nil
		elseif arg_53_2 then
			self.taskRunDic = {}
		end

		self.gameData.playerState = GueGameConst.GameState.playing
		self.gameData.aiState = GueGameConst.GameState.playing
		self.gameData.globalState = GueGameConst.GameState.playing

		manager.audio:Pause("effect", false)
	end

	self.gameView:PauseTimer(arg_53_1)

	if self.timer then
		self.timer.running = not arg_53_1
	end

	if self.timer2 then
		self.timer2.running = not arg_53_1
	end
end

var_0_0.GameResult = {
	Canceled = 3,
	Lose = 2,
	Win = 1
}

function var_0_0:RecordLog(arg_54_1)
	local var_54_0 = {}

	var_54_0[1] = self.gameData.skillUseList[1] or 0
	var_54_0[2] = self.gameData.skillUseList[2] or 0

	SDKTools.SendMessageToSDK("activity_combat_over", {
		stage_id = 3,
		sys_id = 101,
		skin_id = PlayerData:GetPosterGirlHeroSkinId(),
		scene_id = HomeSceneSettingData:GetCurScene(),
		start_time = self.gameData.startTime,
		boss_hp = self.gameData.infoList[2].nowHp,
		hero_hp = self.gameData.infoList[1].nowHp,
		skill_list = SDKTools.JsonEncode(var_54_0),
		other_data = tostring(self.gameData.speaialTimes),
		result = arg_54_1
	})
end

function var_0_0:ResetCombo(arg_55_1)
	self.clearCombo[arg_55_1] = {}
end

return var_0_0
