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

local function var_0_3(arg_6_0)
	return BackHomeHeroSkinCfg[arg_6_0]
end

local var_0_4 = 0.016666666666666666
local var_0_5 = {
	defense = 1,
	SuperAttack = 3,
	attack = 2,
	none = 0
}
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
	local var_7_0 = "tug.gamepos." .. arg_7_1

	return nullable(Dorm.storage:PickData(var_7_0), "transform")
end

function var_0_0.InitGameData(arg_8_0, arg_8_1, arg_8_2)
	var_0_6.finSpeed = 0

	for iter_8_0 = 1, 3 do
		var_0_6.pos[iter_8_0] = arg_8_1[iter_8_0]
	end

	var_0_6.info1 = TugGameObject.New(arg_8_2.info1)

	local var_8_0 = {
		speed = 0,
		anger = 0,
		constSpeed = arg_8_2.info1.constSpeed,
		angerAddSpeed = arg_8_2.info1.angerAddSpeed,
		angerMax = arg_8_2.info1.angerStart,
		angerMax = arg_8_2.info1.angerMax
	}

	var_0_6.info2 = TugGameObject.New(arg_8_2.info2)

	var_0_6.info2:SetCDTime(arg_8_2.CDtime or 0)

	local var_8_1 = {
		anger = 0,
		speed = 0,
		constSpeed = arg_8_2.info1.constSpeed,
		angerAddSpeed = arg_8_2.info1.angerAddSpeed,
		angerMax = arg_8_2.info1.angerStart,
		angerMax = arg_8_2.info1.angerMax,
		angerDecay = arg_8_2.info1.angerMax,
		superAttackTimes = arg_8_2.info1.superAttackTimes,
		skillASpeed = arg_8_2.info1.skillASpeed,
		skillBSpeed = arg_8_2.info1.skillBSpeed
	}

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

function var_0_0.Init(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.stageID = arg_9_1 or 39335101
	arg_9_0.activityID = arg_9_2

	local var_9_0 = ActivityKaliGameStageCfg[arg_9_0.stageID]
	local var_9_1 = EntityManager.CreatePlayer.New(var_0_1, var_0_2)

	arg_9_0.playerManager = EntityManager.New(var_9_1)

	function arg_9_0.playerManager.OnRemove(arg_10_0, arg_10_1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, arg_10_1)
	end

	arg_9_0.managers = {
		arg_9_0.playerManager
	}

	local var_9_2 = arg_9_0:GetPoint("1")
	local var_9_3 = arg_9_0:GetPoint("2")
	local var_9_4 = arg_9_0:GetPoint("3")

	if arg_9_0.enemyModel == nil then
		arg_9_0.enemyModel = arg_9_0.playerManager:Create(1, {
			complex = true,
			model = "CharDorm/activity/kali/" .. "2904_tpose",
			spawnAt = var_9_3
		}, {
			type = "player",
			cfgID = ActivityHeroChallengeCfg[arg_9_0.activityID] and ActivityHeroChallengeCfg[arg_9_0.activityID].hero_id or 1084
		})
	end

	if arg_9_0.playerModel == nil then
		arg_9_0.playerModel = arg_9_0.playerManager:Create(2, {
			complex = true,
			model = "CharDorm/activity/kali/" .. "9156_tpose",
			spawnAt = var_9_2
		}, {
			type = "player",
			cfgID = ActivityHeroChallengeCfg[arg_9_0.activityID] and ActivityHeroChallengeCfg[arg_9_0.activityID].hero_id or 1084
		})
	end

	arg_9_0.enemyPosX = arg_9_0:GetPoint("4").position.x
	arg_9_0.selfPosX = arg_9_0:GetPoint("5").position.x

	local var_9_5 = {
		var_9_2.position,
		var_9_3.position,
		var_9_4.position
	}

	Dorm.DormEntityManager.PutEntityLookAt(2, var_9_2.position, var_9_4.position)
	Dorm.DormEntityManager.PutEntityLookAt(1, var_9_3.position, var_9_4.position)
	arg_9_0:LoadAsset(var_9_0.level_asset_name)
	arg_9_0:InitGameData(var_9_5, arg_9_0.gameData)
	ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_9_2.gameObject)

	arg_9_0.selfControll = arg_9_0.selfControllerexcollection_:GetController("attackState")

	ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_9_3.gameObject)

	arg_9_0.enemyControll = arg_9_0.enemyControllerexcollection_:GetController("enemyState")

	ComponentBinder.GetInstance():BindCfgUI(arg_9_0, var_9_4.gameObject)

	arg_9_0.maomaoControll = arg_9_0.maomaoControllerexcollection_:GetController("openState")

	arg_9_0:SetMonterState(3)
	arg_9_0:SetSelfState(5)
	arg_9_0.maomaoControll:SetSelectedState("close")
	arg_9_0:StartGameTimeTimer()
end

function var_0_0.StartGameTimeTimer(arg_11_0)
	arg_11_0:StopTimer()

	arg_11_0.detlaTime = 0
	arg_11_0.pauseGameFlag = false
	arg_11_0.showPrepareTime = 2

	arg_11_0:ShowPrepareTime(0)

	arg_11_0.lastTime = 0

	var_0_6.info2:SetState(SpKaliConst.TugEnemyState.CdState)

	arg_11_0.timer = FrameTimer.New(function()
		if arg_11_0.showPrepareTime <= 0 then
			arg_11_0:Update(Time.deltaTime)
		end
	end, 1, -1)
	arg_11_0.prepareTimer = Timer.New(function()
		if not arg_11_0.pauseGameFlag then
			arg_11_0:ShowPrepareTime(1)
		end
	end, 1, -1)

	arg_11_0.prepareTimer:Start()
end

function var_0_0.RestartGame(arg_14_0)
	arg_14_0:GetPoint("3").localPosition = Vector3.New(0, 0, 0)

	Dorm.DormEntityManager.StopAllCmd(2)
	Dorm.DormEntityManager.StopAllCmd(1)
	Dorm.DormEntityManager.SendDoActionCMD(1, "stand", false)
	Dorm.DormEntityManager.SendDoActionCMD(2, "stand_female", false)
	arg_14_0:Init(arg_14_0.stageID, arg_14_0.activityID)
	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, 0, 0)
end

function var_0_0.ShowPrepareTime(arg_15_0, arg_15_1)
	if arg_15_0.showPrepareTime == 1.5 then
		var_0_6.info1:EnterCdTime()
		arg_15_0:Update(0)
	end

	arg_15_0.showPrepareTime = Mathf.Clamp(arg_15_0.showPrepareTime - arg_15_1, 0, 99)

	manager.notify:Invoke(ACTIVITY_KALI_UPDATE__PARETIME, 1, arg_15_0.showPrepareTime)

	if arg_15_0.showPrepareTime <= 0 then
		arg_15_0.prepareTimer:Stop()

		arg_15_0.prepareTimer = nil

		arg_15_0.timer:Start()
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_loop")
		arg_15_0:StarBaAni1()
		arg_15_0:StarBaAni2()
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

function var_0_0.Update(arg_19_0, arg_19_1)
	if not arg_19_0.pauseGameFlag then
		arg_19_0.detlaTime = arg_19_0.detlaTime + arg_19_1

		var_0_6.info1:UpdatePlayGameData1(arg_19_1)
		var_0_6.info2:UpdatePlayGameData2(arg_19_1)

		if arg_19_0.detlaTime - arg_19_0.lastTime >= arg_19_0.angerLastTime then
			manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, 0, 0)
			arg_19_0:RemoveIconAnger()
		end

		if arg_19_0.detlaTime - arg_19_0.lastTime > arg_19_0.showTime then
			arg_19_0.lastTime = arg_19_0.detlaTime

			arg_19_0:AddIconAnger()
		end

		arg_19_0:CaculateSpeed(arg_19_1)
		arg_19_0:OnUpdateScore(arg_19_1)
	end
end

function var_0_0.PauseGame(arg_20_0, arg_20_1)
	arg_20_0.pauseGameFlag = arg_20_1
end

function var_0_0.CaculateSpeed(arg_21_0, arg_21_1)
	local var_21_0 = var_0_6.info2.constSpeed

	for iter_21_0, iter_21_1 in pairs(var_0_6.info2.speedList) do
		var_21_0 = var_21_0 + iter_21_1
	end

	local var_21_1 = var_0_6.info1.constSpeed

	for iter_21_2, iter_21_3 in ipairs(var_0_6.selfSkillData) do
		var_21_1 = var_21_1 + (iter_21_3.nowSpeed or 0) + (iter_21_3.nowQteSpeed or 0)
	end

	local var_21_2 = arg_21_0:GetPoint("3").position.x

	var_0_6.finSpeed = var_21_0 - var_21_1

	for iter_21_4 = 1, 3 do
		local var_21_3 = var_0_6.pos[iter_21_4]
		local var_21_4, var_21_5, var_21_6 = arg_21_0:updatePosition3D(var_21_3.x, var_21_3.y, var_21_3.z, var_0_6.finSpeed, 0, 0, arg_21_1)

		var_0_6.pos[iter_21_4] = Vector3.New(var_21_4, var_21_5, var_21_6)

		if iter_21_4 == 3 then
			arg_21_0:GetPoint("3").position = var_0_6.pos[iter_21_4]
		end
	end

	if var_21_2 >= arg_21_0.enemyPosX or var_21_2 <= arg_21_0.selfPosX then
		local var_21_7 = var_21_2 <= arg_21_0.selfPosX

		var_0_6.finSpeed = 0
		arg_21_0.pauseGameFlag = true

		local var_21_8 = {
			"win",
			"lose"
		}

		Dorm.DormEntityManager.StopAllCmd(2)
		Dorm.DormEntityManager.StopAllCmd(1)
		Dorm.DormEntityManager.SendDoActionCMD(2, var_21_7 and var_21_8[1] or var_21_8[2], false)
		Dorm.DormEntityManager.SendDoActionCMD(1, var_21_7 and var_21_8[2] or var_21_8[1], false)

		arg_21_0.timer2 = TimeTools.StartAfterSeconds(2, function()
			JumpTools.OpenPageByJump("SPKailiTugResuletView", {
				isWin = var_21_7,
				stageID = arg_21_0.stageID
			})
		end, {})

		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_loop_stop")

		local var_21_9 = arg_21_0:GetUseTime()

		if var_21_7 then
			SPKaliChallengeAction.SendTugGameResult(arg_21_0.activityID, arg_21_0.stageID, var_21_9)
		else
			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 2,
				activity_id = arg_21_0.activityID,
				stage_id = arg_21_0.stageID,
				reward_list = {},
				use_seconds = var_21_9
			})
		end
	end
end

function var_0_0.GetUseTime(arg_23_0)
	return string.format("%d", arg_23_0.detlaTime or 0)
end

function var_0_0.SetNotRightSkillData(arg_24_0)
	arg_24_0.isWrong = true

	for iter_24_0, iter_24_1 in pairs(var_0_6.selfSkillluaData or {}) do
		if var_0_6.selfSkillluaData[iter_24_0] then
			var_0_6.selfSkillluaData[iter_24_0].lockTime = arg_24_0.lockTime
		end
	end
end

function var_0_0.OnUpdateScore(arg_25_0, arg_25_1)
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
		var_0_6.selfSkillluaData[iter_25_0].lockTime = Mathf.Clamp(var_0_6.selfSkillluaData[iter_25_0].lockTime - arg_25_1, 0, arg_25_0.lockTime)
		var_25_0[iter_25_0] = {
			value = iter_25_1.cd ~= 0 and 1 - iter_25_1.nowCd / iter_25_1.cd or 1,
			cost = iter_25_1.cost,
			nowAnger = var_0_6.info1.anger or 0,
			lockTime = var_0_6.selfSkillluaData[iter_25_0].lockTime
		}

		if var_0_6.selfSkillluaData[iter_25_0].lockTime == 0 and arg_25_0.isWrong then
			arg_25_0.isWrong = false

			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_dizzy_loop_stop")
			manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_energy_loop_stop")
			arg_25_0:StarBaAni2()
			arg_25_0:SetSelfState(5)
			arg_25_0:SetMonterState(3)
		end
	end

	local var_25_1 = {
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
	}

	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGGAME, var_25_0, var_25_1)
end

function var_0_0.CheckGameEnd(arg_26_0)
	return
end

function var_0_0.SetMonterState(arg_27_0, arg_27_1)
	local var_27_0 = {
		"attack",
		"superAttack",
		"none",
		"lose"
	}

	arg_27_0.enemyControll:SetSelectedState(var_27_0[arg_27_1] or "none")
end

function var_0_0.SetSelfState(arg_28_0, arg_28_1)
	local var_28_0 = {
		"definceSucess",
		"definceLose",
		"attackSucess",
		"attackLose",
		"none",
		"qteLose"
	}

	arg_28_0.selfControll:SetSelectedState(var_28_0[arg_28_1] or "none")
end

function var_0_0.updatePosition3D(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6, arg_29_7)
	return arg_29_1 + arg_29_4 * arg_29_7, arg_29_2 + arg_29_5 * arg_29_7, arg_29_3 + arg_29_6 * arg_29_7
end

function var_0_0.SkillA(arg_30_0)
	local var_30_0 = var_0_6.selfSkillData[1]
	local var_30_1 = var_0_6.selfSkillluaData[1]
	local var_30_2 = var_30_0.nowCd <= 0
	local var_30_3 = var_0_6.info1.anger >= var_30_0.cost
	local var_30_4 = var_30_1 and var_30_1.lockTime <= 0

	if var_30_0.nowCd <= 0 and var_0_6.info1.anger >= var_30_0.cost and var_30_4 then
		var_0_6.selfSkillData[1].nowSpeed = var_30_0.speed
		var_0_6.selfSkillData[1].nowCd = var_30_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_30_0.cost
	end

	return var_30_2, var_30_3, var_30_4
end

function var_0_0.SkillB(arg_31_0)
	local var_31_0 = var_0_6.selfSkillData[2]
	local var_31_1 = var_0_6.selfSkillluaData[2]
	local var_31_2 = var_0_6.info2.state == SpKaliConst.TugEnemyState.defense
	local var_31_3 = var_31_0.nowCd <= 0
	local var_31_4 = var_31_1 and var_31_1.lockTime <= 0
	local var_31_5 = var_0_6.info1.anger >= var_31_0.cost
	local var_31_6 = false
	local var_31_7 = false
	local var_31_8 = var_0_6.info2.effectTime ~= 0

	if var_31_3 and var_31_2 and var_31_5 and var_31_4 and var_31_8 then
		var_0_6.selfSkillData[2].nowSpeed = var_31_0.speed
		var_0_6.selfSkillData[2].nowQteSpeed = var_31_0.rightSpeed
		var_0_6.selfSkillData[2].nowCd = var_31_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_31_0.cost

		var_0_6.info2:ReduceEffectTime()

		var_31_7 = true
	else
		if not var_31_2 and var_31_3 and var_31_4 and var_31_8 and var_31_5 then
			var_0_6.selfSkillData[2].nowSpeed = var_31_0.speed
			var_0_6.selfSkillData[2].nowCd = var_31_0.cd
			var_0_6.info1.anger = var_0_6.info1.anger - var_31_0.cost
			var_31_7 = true
		end

		if not var_31_2 and var_0_6.info2.state ~= SpKaliConst.TugEnemyState.CdState and var_31_4 and var_31_8 and var_31_5 and var_31_3 then
			var_0_6.selfSkillData[2].nowQteSpeed = -var_31_0.mistakeSpeed

			arg_31_0:SetNotRightSkillData()

			var_31_6 = true

			var_0_6.info2:ReduceEffectTime()
		end
	end

	return var_31_3, var_31_5, var_31_2 and var_31_4, var_31_6, var_31_7
end

function var_0_0.SkillC(arg_32_0)
	local var_32_0 = var_0_6.selfSkillData[3]
	local var_32_1 = var_0_6.selfSkillluaData[3]
	local var_32_2 = var_0_6.info2.state == SpKaliConst.TugEnemyState.attack or var_0_6.info2.state == SpKaliConst.TugEnemyState.SuperAttack
	local var_32_3 = var_32_0.nowCd <= 0
	local var_32_4 = var_0_6.info1.anger >= var_32_0.cost
	local var_32_5 = var_32_1 and var_32_1.lockTime <= 0
	local var_32_6 = false
	local var_32_7 = false
	local var_32_8 = var_0_6.info2.effectTime ~= 0

	if var_32_3 and var_32_2 and var_32_4 and var_32_5 and var_32_8 then
		var_0_6.selfSkillData[3].nowSpeed = var_32_0.speed
		var_0_6.selfSkillData[3].nowQteSpeed = var_32_0.rightSpeed
		var_0_6.selfSkillData[3].nowCd = var_32_0.cd
		var_0_6.info1.anger = var_0_6.info1.anger - var_32_0.cost

		var_0_6.info2:ReduceEffectTime()

		var_32_7 = true
	else
		if not var_32_2 and var_32_3 and var_32_5 and var_32_8 and var_32_4 then
			var_0_6.selfSkillData[3].nowSpeed = var_32_0.speed
			var_0_6.selfSkillData[3].nowCd = var_32_0.cd
			var_0_6.info1.anger = var_0_6.info1.anger - var_32_0.cost
			var_32_7 = true
		end

		if not var_32_2 and var_0_6.info2.state ~= SpKaliConst.TugEnemyState.CdState and var_32_5 and var_32_8 and var_32_4 and var_32_3 then
			var_0_6.selfSkillData[3].nowQteSpeed = -var_32_0.mistakeSpeed

			arg_32_0:SetNotRightSkillData()

			var_32_6 = true

			var_0_6.info2:ReduceEffectTime()
		end
	end

	return var_32_3, var_32_4, var_32_2 and var_32_5, var_32_6, var_32_7
end

function var_0_0.AddIconAnger(arg_33_0)
	local var_33_0 = math.random(1, 3)

	manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_chest")
	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_TUGICON, var_33_0, arg_33_0.addAnger)
	arg_33_0.maomaoControll:SetSelectedState("open")
end

function var_0_0.RemoveIconAnger(arg_34_0)
	arg_34_0.maomaoControll:SetSelectedState("close")
end

function var_0_0.AddAnger(arg_35_0)
	var_0_6.info1:AddAnger(arg_35_0.addAnger)
end

function var_0_0.StopTimer(arg_36_0)
	if arg_36_0.timer then
		arg_36_0.timer:Stop()

		arg_36_0.timer = nil
	end

	if arg_36_0.timer2 then
		arg_36_0.timer2:Stop()

		arg_36_0.timer2 = nil
	end

	if arg_36_0.prepareTimer then
		arg_36_0.prepareTimer:Stop()

		arg_36_0.prepareTimer = nil
	end
end

function var_0_0.Exit(arg_37_0, arg_37_1)
	arg_37_0.playerModel = nil
	arg_37_0.enemyModel = nil

	arg_37_0:StopTimer()
end

return var_0_0
