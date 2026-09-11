local var_0_0 = singletonClass("TugGame")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.ModelPathGetter(arg_2_0, arg_2_1)
	return arg_2_1.model
end

function var_0_0.SpawnPosGetter(arg_3_0, arg_3_1)
	return arg_3_1.spawnAt
end

local function var_0_1(arg_4_0)
	return arg_4_0.model
end

local function var_0_2(arg_5_0)
	return arg_5_0.spawnAt
end

local var_0_6 = {
	finSpeed = 0,
	CdTime = 0,
	pos = {},
	selfSkillData = {},
	info1 = {},
	info2 = {},
	selfSkillluaData = {}
}

function var_0_0.GetPoint(arg_7_0, arg_7_1)
	return nullable(Dorm.storage:PickData("tug.gamepos." .. arg_7_1), "transform")
end

function var_0_0.InitGameData(arg_8_0, arg_8_1, arg_8_2)
	var_0_6.finSpeed = 0

	for iter_8_0 = 1, 3 do
		var_0_6.pos[iter_8_0] = arg_8_1[iter_8_0]
	end

	var_0_6.info1 = TugGameObject.New(arg_8_2.info1)
	var_0_6.info2 = TugGameObject.New(arg_8_2.info2)

	var_0_6.info2:SetCDTime(arg_8_2.CDtime or 0)

	for iter_8_1 = 0, arg_8_2.skillInfo.Count - 1 do
		var_0_6.selfSkillData[iter_8_1 + 1] = arg_8_2.skillInfo[iter_8_1]
		var_0_6.selfSkillluaData[iter_8_1 + 1] = {
			lockTime = 0
		}
	end

	arg_8_0.offsetSpeed = arg_8_2.offset or 0
	arg_8_0.showTime = arg_8_2.showTime or 10
	arg_8_0.addAnger = arg_8_2.addAnger or 0
	arg_8_0.lockTime = 1.5
	arg_8_0.angerLastTime = arg_8_2.angerLastTime or 0
end

function var_0_0:Init(arg_9_1, arg_9_2)
	self.stageID = arg_9_1 or 39335101
	self.activityID = arg_9_2
	self.playerManager = EntityManager.New((EntityManager.CreatePlayer.New(var_0_1, var_0_2)))

	function self.playerManager.OnRemove(arg_10_0, arg_10_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_10_1)
	end

	self.managers = {
		self.playerManager
	}

	local var_9_0 = self:GetPoint("1")
	local var_9_1 = self:GetPoint("2")
	local var_9_2 = self:GetPoint("3")

	if self.enemyModel == nil then
		local var_9_4 = {
			type = "player"
		}

		if ActivityHeroChallengeCfg[self.activityID] then
			var_9_4.cfgID = ActivityHeroChallengeCfg[self.activityID].hero_id or 1084
		end

		self.enemyModel = self.playerManager:Create(1, {
			complex = true,
			model = "CharDorm/activity/kali/" .. "2904_tpose",
			spawnAt = var_9_1
		}, var_9_4)
	end

	if self.playerModel == nil then
		local var_9_6 = {
			type = "player"
		}

		if ActivityHeroChallengeCfg[self.activityID] then
			var_9_6.cfgID = ActivityHeroChallengeCfg[self.activityID].hero_id or 1084
		end

		self.playerModel = self.playerManager:Create(2, {
			complex = true,
			model = "CharDorm/activity/kali/" .. "9156_tpose",
			spawnAt = var_9_0
		}, var_9_6)
	end

	self.enemyPosX = self:GetPoint("4").position.x
	self.selfPosX = self:GetPoint("5").position.x

	Dorm.DormEntityManager.PutEntityLookAt(2, var_9_0.position, var_9_2.position)
	Dorm.DormEntityManager.PutEntityLookAt(1, var_9_1.position, var_9_2.position)
	self:LoadAsset(ActivityKaliGameStageCfg[self.stageID].level_asset_name)
	self:InitGameData({
		var_9_0.position,
		var_9_1.position,
		var_9_2.position
	}, self.gameData)
	ComponentBinder.GetInstance():BindCfgUI(self, var_9_0.gameObject)

	self.selfControll = self.selfControllerexcollection_:GetController("attackState")

	ComponentBinder.GetInstance():BindCfgUI(self, var_9_1.gameObject)

	self.enemyControll = self.enemyControllerexcollection_:GetController("enemyState")

	ComponentBinder.GetInstance():BindCfgUI(self, var_9_2.gameObject)

	self.maomaoControll = self.maomaoControllerexcollection_:GetController("openState")

	self:SetMonterState(3)
	self:SetSelfState(5)
	self.maomaoControll:SetSelectedState("close")
	self:StartGameTimeTimer()
end

function var_0_0:StartGameTimeTimer()
	self:StopTimer()

	self.detlaTime = 0
	self.pauseGameFlag = false
	self.showPrepareTime = 2

	self:ShowPrepareTime(0)

	self.lastTime = 0

	var_0_6.info2:SetState(SpKaliConst.TugEnemyState.CdState)

	self.timer = FrameTimer.New(function()
		if self.showPrepareTime <= 0 then
			self:Update(Time.deltaTime)
		end
	end, 1, -1)
	self.prepareTimer = Timer.New(function()
		if not self.pauseGameFlag then
			self:ShowPrepareTime(1)
		end
	end, 1, -1)

	self.prepareTimer:Start()
end

function var_0_0:RestartGame()
	self:GetPoint("3").localPosition = Vector3.New(0, 0, 0)

	Dorm.DormEntityManager.StopAllCmd(2)
	Dorm.DormEntityManager.StopAllCmd(1)
	Dorm.DormEntityManager.SendDoActionCMD(1, "stand", false)
	Dorm.DormEntityManager.SendDoActionCMD(2, "stand_female", false)
	self:Init(self.stageID, self.activityID)
	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, 0, 0)
end

function var_0_0:ShowPrepareTime(arg_15_1)
	if self.showPrepareTime == 1.5 then
		var_0_6.info1:EnterCdTime()
		self:Update(0)
	end

	self.showPrepareTime = Mathf.Clamp(self.showPrepareTime - arg_15_1, 0, 99)

	manager.notify:Invoke(ACTIVITY_KALI_UPDATE__PARETIME, 1, self.showPrepareTime)

	if self.showPrepareTime <= 0 then
		self.prepareTimer:Stop()

		self.prepareTimer = nil

		self.timer:Start()
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_loop")
		self:StarBaAni1()
		self:StarBaAni2()
	end
end

function var_0_0.StarBaAni1(arg_16_0)
	Dorm.DormEntityManager.StopAllCmd(1)
	Dorm.DormEntityManager.SendDoActionCMD(1, "Baleft", false)
end

function var_0_0.StarBaAni2(arg_17_0)
	Dorm.DormEntityManager.StopAllCmd(2)
	Dorm.DormEntityManager.SendDoActionCMD(2, "Baright", false)
end

function var_0_0.LoadAsset(arg_18_0, arg_18_1)
	arg_18_0.gameData = TugGameToLuaBridge.LoadConfig(arg_18_1)
end

function var_0_0:Update(arg_19_1)
	if not self.pauseGameFlag then
		self.detlaTime = self.detlaTime + arg_19_1

		var_0_6.info1:UpdatePlayGameData1(arg_19_1)
		var_0_6.info2:UpdatePlayGameData2(arg_19_1)

		if self.detlaTime - self.lastTime >= self.angerLastTime then
			manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, 0, 0)
			self:RemoveIconAnger()
		end

		if self.detlaTime - self.lastTime > self.showTime then
			self.lastTime = self.detlaTime

			self:AddIconAnger()
		end

		self:CaculateSpeed(arg_19_1)
		self:OnUpdateScore(arg_19_1)
	end
end

function var_0_0.PauseGame(arg_20_0, arg_20_1)
	arg_20_0.pauseGameFlag = arg_20_1
end

function var_0_0:CaculateSpeed(arg_21_1)
	local var_21_0 = var_0_6.info2.constSpeed

	for iter_21_0, iter_21_1 in pairs(var_0_6.info2.speedList) do
		var_21_0 = var_21_0 + iter_21_1
	end

	local var_21_1 = var_0_6.info1.constSpeed

	for iter_21_2, iter_21_3 in ipairs(var_0_6.selfSkillData) do
		var_21_1 = var_21_1 + (iter_21_3.nowSpeed or 0) + (iter_21_3.nowQteSpeed or 0)
	end

	local var_21_3 = self:GetPoint("3").position.x

	var_0_6.finSpeed = var_21_0 - var_21_1

	for iter_21_4 = 1, 3 do
		local var_21_4, var_21_5, var_21_6 = self:updatePosition3D(var_0_6.pos[iter_21_4].x, var_0_6.pos[iter_21_4].y, var_0_6.pos[iter_21_4].z, var_0_6.finSpeed, 0, 0, arg_21_1)

		var_0_6.pos[iter_21_4] = Vector3.New(var_21_4, var_21_5, var_21_6)

		if iter_21_4 == 3 then
			self:GetPoint("3").position = var_0_6.pos[iter_21_4]
		end
	end

	if var_21_3 >= self.enemyPosX or var_21_3 <= self.selfPosX then
		local var_21_7 = var_21_3 <= self.selfPosX

		var_0_6.finSpeed = 0
		self.pauseGameFlag = true

		local var_21_8 = {
			"win",
			"lose"
		}

		Dorm.DormEntityManager.StopAllCmd(2)
		Dorm.DormEntityManager.StopAllCmd(1)
		Dorm.DormEntityManager.SendDoActionCMD(2, (var_21_7 or nil) and (var_21_8[1] or var_21_8[2]), false)
		Dorm.DormEntityManager.SendDoActionCMD(1, (var_21_7 or nil) and (var_21_8[2] or var_21_8[1]), false)

		self.timer2 = TimeTools.StartAfterSeconds(2, function()
			JumpTools.OpenPageByJump("SPKailiTugResuletView", {
				isWin = var_21_7,
				stageID = self.stageID
			})
		end, {})

		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_loop_stop")

		local var_21_9 = self:GetUseTime()

		if var_21_7 then
			SPKaliChallengeAction.SendTugGameResult(self.activityID, self.stageID, var_21_9)
		else
			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 2,
				activity_id = self.activityID,
				stage_id = self.stageID,
				reward_list = {},
				use_seconds = var_21_9
			})
		end
	end
end

function var_0_0:GetUseTime()
	return string.format("%d", self.detlaTime or 0)
end

function var_0_0:SetNotRightSkillData()
	self.isWrong = true

	for iter_24_0, iter_24_1 in pairs(var_0_6.selfSkillluaData or {}) do
		if var_0_6.selfSkillluaData[iter_24_0] then
			var_0_6.selfSkillluaData[iter_24_0].lockTime = self.lockTime
		end
	end
end

function var_0_0:OnUpdateScore(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(var_0_6.selfSkillData) do
		if iter_25_1.nowSpeed > 0 then
			iter_25_1.nowSpeed = Mathf.Clamp(iter_25_1.nowSpeed - iter_25_1.AddSpeedA * arg_25_1, 0, 99)
		end

		if iter_25_1.nowQteSpeed > 0 then
			iter_25_1.nowQteSpeed = Mathf.Clamp(iter_25_1.nowQteSpeed - iter_25_1.rightAddSpeedA * arg_25_1, 0, 99)
		end

		if iter_25_1.nowQteSpeed < 0 then
			iter_25_1.nowQteSpeed = Mathf.Clamp(iter_25_1.nowQteSpeed + iter_25_1.mistakeAddSpeedA * arg_25_1, -99, 0)
		end

		iter_25_1.nowCd = Mathf.Clamp(iter_25_1.nowCd - arg_25_1, 0, iter_25_1.nowCd)
		var_0_6.selfSkillluaData[iter_25_0].lockTime = Mathf.Clamp(var_0_6.selfSkillluaData[iter_25_0].lockTime - arg_25_1, 0, self.lockTime)

		local var_25_1 = {}

		if iter_25_1.cd ~= 0 then
			var_25_1.value = 1 - iter_25_1.nowCd / iter_25_1.cd or 1
		end

		var_25_1.cost = iter_25_1.cost
		var_25_1.nowAnger = var_0_6.info1.anger or 0
		var_25_1.lockTime = var_0_6.selfSkillluaData[iter_25_0].lockTime
		var_25_0[iter_25_0] = var_25_1

		if var_0_6.selfSkillluaData[iter_25_0].lockTime == 0 and self.isWrong then
			self.isWrong = false

			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
			self:StarBaAni2()
			self:SetSelfState(5)
			self:SetMonterState(3)
		end
	end

	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGGAME, var_25_0, {
		{
			pos = var_0_6.pos[2],
			value = var_0_6.info2:GetCDFillAmount(),
			anger = var_0_6.info2.anger,
			state = var_0_6.info2.state,
			canEffect = var_0_6.info2.effectTime ~= 0
		},
		{
			pos = var_0_6.pos[1],
			anger = var_0_6.info1.anger,
			value = var_0_6.info1:GetAngerFillAmount()
		},
		{
			pos = var_0_6.pos[3]
		}
	})
end

function var_0_0.CheckGameEnd(arg_26_0)
	return
end

function var_0_0:SetMonterState(arg_27_1)
	self.enemyControll:SetSelectedState(({
		"attack",
		"superAttack",
		"none",
		"lose"
	})[arg_27_1] or "none")
end

function var_0_0:SetSelfState(arg_28_1)
	self.selfControll:SetSelectedState(({
		"definceSucess",
		"definceLose",
		"attackSucess",
		"attackLose",
		"none",
		"qteLose"
	})[arg_28_1] or "none")
end

function var_0_0.updatePosition3D(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	return arg_29_1 + arg_29_4 * arg_29_7, arg_29_2 + arg_29_5 * arg_29_7, arg_29_3 + arg_29_6 * arg_29_7
end

function var_0_0.SkillA(arg_30_0)
	local var_30_0 = var_0_6.selfSkillData[1]
	local var_30_1 = var_0_6.selfSkillluaData[1] and var_0_6.selfSkillluaData[1].lockTime <= 0

	if var_0_6.selfSkillData[1].nowCd <= 0 and var_0_6.info1.anger >= var_30_0.cost and var_30_1 then
		var_0_6.selfSkillData[1].nowSpeed = var_30_0.speed
		var_0_6.selfSkillData[1].nowCd = var_30_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_30_0.cost
	end

	return var_0_6.selfSkillData[1].nowCd <= 0, var_0_6.info1.anger >= var_0_6.selfSkillData[1].cost, var_30_1
end

function var_0_0:SkillB()
	local var_31_0 = var_0_6.selfSkillData[2]
	local var_31_1 = var_0_6.info2.state == SpKaliConst.TugEnemyState.defense
	local var_31_2 = var_0_6.selfSkillData[2].nowCd <= 0
	local var_31_3 = var_0_6.selfSkillluaData[2] and var_0_6.selfSkillluaData[2].lockTime <= 0
	local var_31_4 = var_0_6.info1.anger >= var_0_6.selfSkillData[2].cost
	local var_31_5 = false
	local var_31_6 = false
	local var_31_7 = var_0_6.info2.effectTime ~= 0

	if var_0_6.selfSkillData[2].nowCd <= 0 and var_31_1 and var_31_4 and var_31_3 and var_31_7 then
		var_0_6.selfSkillData[2].nowSpeed = var_31_0.speed
		var_0_6.selfSkillData[2].nowQteSpeed = var_31_0.rightSpeed
		var_0_6.selfSkillData[2].nowCd = var_31_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_31_0.cost

		var_0_6.info2:ReduceEffectTime()

		var_31_6 = true
	else
		if not var_31_1 and var_31_2 and var_31_3 and var_31_7 and var_31_4 then
			var_0_6.selfSkillData[2].nowSpeed = var_31_0.speed
			var_0_6.selfSkillData[2].nowCd = var_31_0.cd
			var_0_6.info1.anger = var_0_6.info1.anger - var_31_0.cost
			var_31_6 = true
		end

		if not var_31_1 and var_0_6.info2.state ~= SpKaliConst.TugEnemyState.CdState and var_31_3 and var_31_7 and var_31_4 and var_31_2 then
			var_0_6.selfSkillData[2].nowQteSpeed = -var_31_0.mistakeSpeed

			self:SetNotRightSkillData()

			var_31_5 = true

			var_0_6.info2:ReduceEffectTime()
		end
	end

	return var_31_2, var_31_4, var_31_1 and var_31_3, var_31_5, var_31_6
end

function var_0_0:SkillC()
	local var_32_0 = var_0_6.selfSkillData[3]
	local var_32_1 = var_0_6.info2.state == SpKaliConst.TugEnemyState.attack or var_0_6.info2.state == SpKaliConst.TugEnemyState.SuperAttack
	local var_32_2 = var_0_6.selfSkillData[3].nowCd <= 0
	local var_32_3 = var_0_6.info1.anger >= var_0_6.selfSkillData[3].cost
	local var_32_4 = var_0_6.selfSkillluaData[3] and var_0_6.selfSkillluaData[3].lockTime <= 0
	local var_32_5 = false
	local var_32_6 = false
	local var_32_7 = var_0_6.info2.effectTime ~= 0

	if var_0_6.selfSkillData[3].nowCd <= 0 and var_32_1 and var_32_3 and var_32_4 and var_32_7 then
		var_0_6.selfSkillData[3].nowSpeed = var_32_0.speed
		var_0_6.selfSkillData[3].nowQteSpeed = var_32_0.rightSpeed
		var_0_6.selfSkillData[3].nowCd = var_32_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_32_0.cost

		var_0_6.info2:ReduceEffectTime()

		var_32_6 = true
	else
		if not var_32_1 and var_32_2 and var_32_4 and var_32_7 and var_32_3 then
			var_0_6.selfSkillData[3].nowSpeed = var_32_0.speed
			var_0_6.selfSkillData[3].nowCd = var_32_0.cd
			var_0_6.info1.anger = var_0_6.info1.anger - var_32_0.cost
			var_32_6 = true
		end

		if not var_32_1 and var_0_6.info2.state ~= SpKaliConst.TugEnemyState.CdState and var_32_4 and var_32_7 and var_32_3 and var_32_2 then
			var_0_6.selfSkillData[3].nowQteSpeed = -var_32_0.mistakeSpeed

			self:SetNotRightSkillData()

			var_32_5 = true

			var_0_6.info2:ReduceEffectTime()
		end
	end

	return var_32_2, var_32_3, var_32_1 and var_32_4, var_32_5, var_32_6
end

function var_0_0:AddIconAnger()
	manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_chest")
	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, math.random(1, 3), self.addAnger)
	self.maomaoControll:SetSelectedState("open")
end

function var_0_0:RemoveIconAnger()
	self.maomaoControll:SetSelectedState("close")
end

function var_0_0:AddAnger()
	var_0_6.info1:AddAnger(self.addAnger)
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

	if self.prepareTimer then
		self.prepareTimer:Stop()

		self.prepareTimer = nil
	end
end

function var_0_0:Exit(arg_37_1)
	self.playerModel = nil
	self.enemyModel = nil

	self:StopTimer()
end

return var_0_0
