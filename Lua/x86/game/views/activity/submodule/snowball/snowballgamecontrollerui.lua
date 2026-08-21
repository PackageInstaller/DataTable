local var_0_0 = class("SnowballGameControllerUI", ReduxView)

local function var_0_1(arg_1_0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", arg_1_0, "")
end

function var_0_0.UIName(arg_2_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballGameUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_4_0)
	return
end

local function var_0_2()
	gameContext:Go("/snowballGameLevelUI", nil, true, true)
end

local function var_0_3(arg_6_0)
	if arg_6_0:IsGameStarted() and not arg_6_0.pause then
		arg_6_0.pause = true

		JumpTools.OpenPageByJump("snowballPausePopup", {
			OkCallback = function()
				arg_6_0:EndGame(false)
			end,
			CancelCallback = function()
				arg_6_0.pause = false
			end
		})
	end
end

function var_0_0.RefreshWindowBar(arg_9_0)
	if arg_9_0:IsGameStarted() then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(handler(arg_9_0, var_0_3))
	else
		manager.windowBar:HideBar()
	end
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0:RefreshWindowBar()
end

function var_0_0.OnBehind(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Init(arg_12_0)
	arg_12_0:BindCfgUI()
	DormLuaBridge.InitJoystick(arg_12_0.joystick_)

	arg_12_0.modeController = ControllerUtil.GetController(arg_12_0.transform_, "mode")
	arg_12_0.movingDirIndicator = ControllerUtil.GetController(arg_12_0.transform_, "moveDir")
	arg_12_0.crosshire = ControllerUtil.GetController(arg_12_0.transform_, "crosshire")
	arg_12_0.shoot = ControllerUtil.GetController(arg_12_0.transform_, "shoot")
	arg_12_0.shootTipsController = ControllerUtil.GetController(arg_12_0.transform_, "showShootTips")
	arg_12_0.moveTipsController = ControllerUtil.GetController(arg_12_0.transform_, "showMoveTips")

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Shoot) then
		arg_12_0.shootTipsController:SetSelectedState("hide")
	end

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Move) then
		arg_12_0.moveTipsController:SetSelectedState("hide")
	end

	arg_12_0:InitBtnListeners()
	arg_12_0:InitSubViews()
end

function var_0_0.NewSubView(arg_13_0, arg_13_1, ...)
	local var_13_0 = arg_13_1.New(...)

	table.insert(arg_13_0.subViews, var_13_0)

	return var_13_0
end

function var_0_0.InitSubViews(arg_14_0)
	arg_14_0.subViews = {}
	arg_14_0.buffSubView = arg_14_0:NewSubView(SnowballGameBuffSubView, arg_14_0.buffSubView_)

	function arg_14_0.buffSubView.OnBuffFinished(arg_15_0, arg_15_1)
		SnowballGameBuff.buff[arg_15_1].OnRemove(arg_14_0.playerEID)
		manager.notify:Invoke(SNOWBALL_GAME_BUFF_FINISH, arg_14_0.playerEID, arg_15_1)
		arg_14_0:OnBuffRemoved(arg_15_1)
	end

	function arg_14_0.buffSubView.OnBuffExtended(arg_16_0, arg_16_1)
		local var_16_0 = SnowballGameBuff.buff[arg_16_1].OnExtended

		if var_16_0 then
			var_16_0(arg_14_0.playerEID)
		end
	end

	arg_14_0.gameInfoSubView = arg_14_0:NewSubView(SnowballGameInfoSubView, arg_14_0.gameInfoSubView_)
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.subViews) do
		iter_17_1:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.AddJob(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {
		time = arg_18_0.time + arg_18_1,
		task = arg_18_2
	}

	if arg_18_3 then
		arg_18_0.jobs[arg_18_3] = var_18_0

		return arg_18_3
	else
		table.insert(arg_18_0.jobs, var_18_0)

		return #arg_18_0.jobs
	end
end

function var_0_0.RemoveJob(arg_19_0, arg_19_1)
	if arg_19_0.nextRemove == nil then
		arg_19_0.nextRemove = {}
	end

	if arg_19_0.jobs[arg_19_1] then
		table.insert(arg_19_0.nextRemove, arg_19_1)
	end
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.aim = 0
	arg_20_0.wave = nil
	arg_20_0.pause = false
	arg_20_0.playerEID = arg_20_0.params_.playerEID
	arg_20_0.level = arg_20_0.params_.level

	local var_20_0 = DormUtils.GetEntityData(arg_20_0.playerEID).cfgID
	local var_20_1 = SnowballGameUnitCfg[var_20_0]

	arg_20_0.beamRadius = var_20_1.none_area
	arg_20_0.shootCooldown = var_20_1.skill_cooldown
	arg_20_0.crossireSpeed = var_20_1.ready_speed
	arg_20_0.time = 0
	arg_20_0.jobs = {}

	local var_20_2 = 3

	for iter_20_0 = 1, var_20_2 do
		arg_20_0:AddJob(iter_20_0 - 1, handlerArg1(arg_20_0, arg_20_0.StartCountdown, var_20_2 - iter_20_0 + 1))
	end

	arg_20_0:AddJob(var_20_2, handler(arg_20_0, arg_20_0.StartGame))
	arg_20_0:AddJob(20, handler(arg_20_0, arg_20_0.NotifyGuestTalk))
	arg_20_0.modeController:SetSelectedState("countdown")

	arg_20_0.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(handler(arg_20_0, arg_20_0.Update), -1, true)

	arg_20_0:InitEventListeners()

	for iter_20_1, iter_20_2 in pairs(arg_20_0.subViews) do
		iter_20_2:OnEnter(arg_20_0)
	end

	local var_20_3 = nullable(Dorm.storage:PickData("snowball.pos.gameStart"), "transform")

	Dorm.DormEntityManager.PutEntityAt(arg_20_0.playerEID, var_20_3)
	Dorm.DormEntityManager.StopAllCmd(arg_20_0.playerEID)
	var_0_1("minigame_activity_2_6_snowball_time")
end

local var_0_4 = {}

function var_0_0.StartCountdown(arg_21_0, arg_21_1)
	arg_21_0.startCountdown_.text = GetTipsF(nullable(var_0_4, arg_21_1) or "%d", arg_21_1)
end

function var_0_0.OnExit(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.subViews) do
		iter_22_1:OnExit()
	end

	arg_22_0:RemoveAllEventListener()

	if arg_22_0.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(arg_22_0.updateTicker)

		arg_22_0.updateTicker = nil
	end

	arg_22_0.jobs = nil

	if arg_22_0.waitAfterShoot then
		arg_22_0.waitAfterShoot:Abort()

		arg_22_0.waitAfterShoot = nil

		arg_22_0.shoot:SetSelectedState("throw")
	end

	manager.windowBar:HideBar()
end

function var_0_0.IsGameStarted(arg_23_0)
	return arg_23_0.wave ~= nil
end

function var_0_0.StartGame(arg_24_0)
	arg_24_0.modeController:SetSelectedState("game")
	arg_24_0.gameInfoSubView:OnGameStart()

	arg_24_0.shootEnabled = true
	arg_24_0.noMoreTarget = false

	SnowballGameMgr.GetInstance():SetLevel(arg_24_0.level)
	arg_24_0:StartGenWaveJob()
	arg_24_0:RefreshWindowBar()
end

function var_0_0.EndGame(arg_25_0, arg_25_1)
	local var_25_0 = SnowballGameMgr.GetInstance()

	Dorm.DormEntityManager.PutEntityAt(arg_25_0.playerEID, var_25_0.playerSpawnPos)
	Dorm.DormEntityManager.StopAllCmd(arg_25_0.playerEID)
	SnowballGameMgr.ClearVfxOnEntity(arg_25_0.playerEID)
	SnowballGameMgr.CreateHoldSnowballVfx(arg_25_0.playerEID)

	local var_25_1 = arg_25_0.gameInfoSubView

	if arg_25_0:IsGameStarted() then
		var_25_0:ClearAllTargets()
	end

	arg_25_0:CancelAim()

	var_25_1.started = false

	if arg_25_1 then
		JumpTools.OpenPageByJump("snowballGameResult", {
			finish = arg_25_1,
			level = arg_25_0.level,
			score = var_25_1.score,
			enemyList = var_25_1.hitList,
			extraTime = var_25_1:CalcRestTimeAfterFinish(),
			hitGuestCount = var_25_1.hitGuest,
			OkCallback = var_0_2
		})
		var_0_1("minigame_activity_2_6_snowball_end")
		Dorm.DormEntityManager.SendDoActionCMD(arg_25_0.playerEID, "happy", false)
	else
		var_0_2()
	end

	var_25_0:RemoveGuest()

	arg_25_0.wave = nil
	arg_25_0.shootEnabled = false

	arg_25_0.buffSubView:ClearAllBuff()
end

function var_0_0.IsLastWave(arg_26_0)
	local var_26_0 = arg_26_0.wave or 0

	return SnowballGameCfg[arg_26_0.level].refresh_enemy[var_26_0 + 1] == nil
end

function var_0_0.StartGenWaveJob(arg_27_0)
	if arg_27_0.noMoreTarget or arg_27_0:IsLastWave() then
		arg_27_0:EndGame(true)

		return
	end

	arg_27_0.wave = arg_27_0.wave and arg_27_0.wave + 1 or 0

	manager.notify:Invoke(SNOWBALL_GAME_TARGET_NEW_WAVE, arg_27_0.wave)
end

local var_0_5 = {
	[0] = "none",
	"right",
	[-1] = "left"
}

local function var_0_6(arg_28_0)
	if arg_28_0.x > 0 then
		return 1
	elseif arg_28_0.x < 0 then
		return -1
	end

	return 0
end

function var_0_0.IsChangeDir(arg_29_0, arg_29_1)
	local var_29_0 = var_0_6(arg_29_1)

	if var_29_0 ~= 0 and var_0_6(arg_29_0.lastMovingVec) ~= var_29_0 then
		return true, var_29_0
	end

	return false, var_29_0
end

local var_0_7 = {
	[1] = "snowball_move_R",
	[-1] = "snowball_move_L"
}
local var_0_8 = 0.4

local function var_0_9(arg_30_0)
	return nullable(var_0_7, arg_30_0)
end

function var_0_0.Update(arg_31_0)
	local var_31_0 = arg_31_0.pause and 0 or Time.deltaTime

	arg_31_0.time = arg_31_0.time + var_31_0

	arg_31_0:UpdateGameLogic(var_31_0)
	arg_31_0:UpdateMove()
	arg_31_0:UpdateAim(var_31_0)
	arg_31_0:ExecuteJobs()

	for iter_31_0, iter_31_1 in pairs(arg_31_0.subViews) do
		iter_31_1:Update(var_31_0, arg_31_0.time)
	end
end

function var_0_0.UpdateGameLogic(arg_32_0, arg_32_1)
	local var_32_0 = SnowballGameMgr.GetInstance()

	if not arg_32_0:IsGameStarted() then
		return
	end

	local var_32_1 = arg_32_0.gameInfoSubView.totalTime
	local var_32_2 = var_32_0:GetNormalTargetCount() + var_32_0:GetRewardTargetCount()
	local var_32_3 = false

	if var_32_1 <= 0 then
		var_32_3 = true
	elseif var_32_2 == 0 then
		if arg_32_0.gameInfoSubView.countdown > 5 then
			arg_32_0.gameInfoSubView.countdown = 5
		end

		if arg_32_0.noMoreTarget or arg_32_0:IsLastWave() then
			var_32_3 = true
		end
	end

	if var_32_3 then
		arg_32_0.gameInfoSubView:RecordFinishTime()
		arg_32_0:EndGame(true)
	elseif arg_32_0.gameInfoSubView.countdown <= 0 then
		arg_32_0:StartGenWaveJob()
	end
end

function var_0_0.ExecuteJobs(arg_33_0)
	if arg_33_0.nextRemove then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0.nextRemove) do
			arg_33_0.jobs[iter_33_1] = nil
		end

		arg_33_0.nextRemove = nil
	end

	for iter_33_2 = #arg_33_0.jobs, 1, -1 do
		local var_33_0 = arg_33_0.jobs[iter_33_2]

		if arg_33_0.time >= var_33_0.time then
			var_33_0.task()
			table.remove(arg_33_0.jobs, iter_33_2)
		end
	end
end

function var_0_0.UpdateMove(arg_34_0)
	local var_34_0 = DormLuaBridge.TryGetJoytickInput()
	local var_34_1, var_34_2 = arg_34_0:IsChangeDir(var_34_0)

	if var_34_1 then
		local var_34_3 = arg_34_0.playerEID

		Dorm.DormEntityManager.ChangeEntityAnimeScheme(var_34_3, var_0_9(var_34_2))
		Dorm.DormEntityManager.TryTriggerResetAnimeDuringMove(var_34_3)

		if arg_34_0.moveTipsController:GetSelectedState() == "show" then
			arg_34_0.moveTipsController:SetSelectedState("hide")
			SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Move)
		end
	end

	arg_34_0.movingDirIndicator:SetSelectedState(var_0_5[var_34_2] or "none")

	arg_34_0.lastMovingVec = var_34_0
end

local function var_0_10(arg_35_0)
	local var_35_0 = arg_35_0 % 1

	if var_35_0 < 0 then
		var_35_0 = var_35_0 + 1
	end

	return var_35_0
end

local function var_0_11(arg_36_0)
	local var_36_0 = arg_36_0 % 2

	if var_36_0 < 0 then
		var_36_0 = var_36_0 + 2
	end

	if var_36_0 > 1 then
		var_36_0 = 2 - var_36_0
	end

	return var_36_0
end

function var_0_0.UpdateAim(arg_37_0, arg_37_1)
	if arg_37_0.crosshire:GetSelectedState() ~= "move" then
		return
	end

	arg_37_1 = arg_37_1 or Time.deltaTime

	local var_37_0 = arg_37_0.crossireSpeed or GameSetting.activity_snowball_crosshair_speed.value[1] or 1

	arg_37_0.aim = arg_37_0.aim + var_37_0 * arg_37_1

	local var_37_1 = var_0_11(arg_37_0.aim)
	local var_37_2 = Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(arg_37_0.playerEID, "gua_Hit")
	local var_37_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, var_37_2)
	local var_37_4 = arg_37_0.crosshire_.parent
	local var_37_5 = var_37_4.rect
	local var_37_6 = Vector2.Lerp(Vector2(0, var_37_5.yMin), Vector2(0, var_37_5.yMax), var_37_1)
	local var_37_7 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_37_8 = var_37_4:TransformPoint(var_37_6)
	local var_37_9 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_37_7, var_37_8)

	var_37_9.x = var_37_3.x
	arg_37_0.crosshirePos = var_37_9

	local var_37_10, var_37_11 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_37_0.crosshire_.parent, var_37_9, var_37_7, nil)

	arg_37_0.crosshire_.localPosition = var_37_11
	arg_37_0.chargeKnot_.localRotation = Quaternion.Euler(0, 0, var_37_1 * -120)
end

function var_0_0.InitBtnListeners(arg_38_0)
	local var_38_0 = arg_38_0:GetOrAddComponent(arg_38_0.shootBtn_, typeof(EventTriggerListener))

	var_38_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
		arg_38_0:Shoot()
	end))
	var_38_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_40_0, arg_40_1)
		arg_38_0:BeginAim()
	end))

	arg_38_0.shootLongHoldBtn = var_38_0

	arg_38_0:SetListener(var_38_0)
end

function var_0_0.InitEventListeners(arg_41_0)
	arg_41_0:RegistEventListener(SNOWBALL_GAME_ALL_TARGET_SPAWNED, function()
		arg_41_0.noMoreTarget = true
	end)
	arg_41_0:RegistEventListener(SNOWBALL_GAME_PLAYER_GET_BUFF, handler(arg_41_0, arg_41_0.AddBuff))
end

function var_0_0.AddBuff(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if not arg_43_0:IsGameStarted() then
		return
	end

	arg_43_0.buffSubView:AddBuff(arg_43_1, arg_43_2, arg_43_3)
	SnowballGameBuff.buff[arg_43_1].OnApply(arg_43_0.playerEID, arg_43_3)

	if arg_43_1 == SnowballGameBuff.buffType.Freeze then
		arg_43_0:CancelAim()

		arg_43_0.shootEnabled = false
	end
end

function var_0_0.OnBuffRemoved(arg_44_0, arg_44_1)
	if arg_44_1 == SnowballGameBuff.buffType.Freeze then
		arg_44_0.shootEnabled = true
	end
end

function var_0_0.BeginAim(arg_45_0)
	if not arg_45_0:ReadyToShoot() then
		return
	end

	if arg_45_0.shootTipsController:GetSelectedState() == "show" then
		arg_45_0.shootTipsController:SetSelectedState("hide")
		SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Shoot)
	end

	var_0_1("minigame_activity_2_6_snowball_preattack")

	arg_45_0.beginAim = true
	arg_45_0.aim = 0

	arg_45_0.crosshire:SetSelectedState("move")
	arg_45_0:UpdateAim(0)
	arg_45_0.shoot:SetSelectedState("charge")
end

function var_0_0.CancelAim(arg_46_0)
	arg_46_0.beginAim = false

	arg_46_0.crosshire:SetSelectedState("hide")

	if arg_46_0.shoot:GetSelectedState() == "charge" then
		arg_46_0.shoot:SetSelectedState("throw")
	end
end

local var_0_12 = Dorm.LuaBridge.MiniGameBridge

function var_0_0.GetCharaShootWait(arg_47_0)
	return arg_47_0.shootCooldown or 1
end

function var_0_0.UpdateWaitAfterShoot(arg_48_0, arg_48_1)
	arg_48_0.cooldown_.fillAmount = arg_48_1
end

function var_0_0.CanShoot(arg_49_0)
	return arg_49_0.beginAim and arg_49_0:ReadyToShoot()
end

function var_0_0.ReadyToShoot(arg_50_0)
	return arg_50_0.shootEnabled and not arg_50_0.isInShootCooldown
end

function var_0_0.Shoot(arg_51_0)
	if not arg_51_0:CanShoot() then
		return
	end

	arg_51_0.beginAim = false

	arg_51_0.shoot:SetSelectedState("wait")
	arg_51_0.crosshire:SetSelectedState("hide")
	var_0_1("minigame_activity_2_6_snowball_footstep_stop")

	if arg_51_0.waitAfterShoot then
		arg_51_0.waitAfterShoot:Abort()
	end

	local var_51_0 = arg_51_0:GetCharaShootWait()

	arg_51_0.isInShootCooldown = true
	arg_51_0.waitAfterShoot = DormCharacterActionManager.frameTaskRunner:NewTask():WaitUntil(function(arg_52_0)
		local var_52_0 = arg_51_0.pause and 0 or DormCharacterActionManager:FrameTaskDeltaTime()
		local var_52_1 = SnowballGameMgr.GetInstance().shootSpeedFactor

		arg_52_0.wait = arg_52_0.wait - var_52_0 * var_52_1

		arg_51_0:UpdateWaitAfterShoot(arg_52_0.wait / arg_52_0.total)

		return arg_52_0.wait <= 0
	end, false, {
		wait = var_51_0,
		total = var_51_0
	}):Then(function()
		arg_51_0.shoot:SetSelectedState("throw")

		arg_51_0.isInShootCooldown = false
	end):Start()

	local var_51_1, var_51_2, var_51_3 = var_0_12.BeamcastEntity(arg_51_0.crosshirePos, arg_51_0.beamRadius, nil, nil)

	manager.notify:Invoke(SNOWBALL_GAME_AIM_FINISH, var_51_1, var_51_2, var_51_3)
end

local var_0_13 = {
	"ACTIVITY_SNOWBALL_STAND_TALK01",
	"ACTIVITY_SNOWBALL_STAND_TALK02",
	"ACTIVITY_SNOWBALL_STAND_TALK03",
	"ACTIVITY_SNOWBALL_STAND_TALK04"
}

local function var_0_14(arg_54_0)
	return arg_54_0[math.random(#arg_54_0)]
end

function var_0_0.NotifyGuestTalk(arg_55_0)
	if arg_55_0:IsGameStarted() then
		local var_55_0 = SnowballGameMgr.GetInstance():GetGuestEID()

		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, var_55_0, GetTips(var_0_14(var_0_13)), true)
		arg_55_0:AddJob(20, handler(arg_55_0, arg_55_0.NotifyGuestTalk))
	end
end

function var_0_0.OnGameFocusChange(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_2 then
		var_0_3(arg_56_0)
	end
end

return var_0_0
