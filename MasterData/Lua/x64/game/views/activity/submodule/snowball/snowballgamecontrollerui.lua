local SnowballGameControllerUI = class("SnowballGameControllerUI", ReduxView)

local function var_0_1(arg_1_0)
	manager.audio:PlayEffect("minigame_activity_2_6_snowball", arg_1_0, "")
end

function SnowballGameControllerUI:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballGameUI"
end

function SnowballGameControllerUI:UIParent()
	return manager.ui.uiMain.transform
end

function SnowballGameControllerUI:OnCtor()
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

function SnowballGameControllerUI:RefreshWindowBar()
	if self:IsGameStarted() then
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
		manager.windowBar:RegistBackCallBack(handler(self, var_0_3))
	else
		manager.windowBar:HideBar()
	end
end

function SnowballGameControllerUI:OnTop()
	self:RefreshWindowBar()
end

function SnowballGameControllerUI:OnBehind()
	manager.windowBar:HideBar()
end

function SnowballGameControllerUI:Init()
	self:BindCfgUI()
	DormLuaBridge.InitJoystick(self.joystick_)

	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
	self.movingDirIndicator = ControllerUtil.GetController(self.transform_, "moveDir")
	self.crosshire = ControllerUtil.GetController(self.transform_, "crosshire")
	self.shoot = ControllerUtil.GetController(self.transform_, "shoot")
	self.shootTipsController = ControllerUtil.GetController(self.transform_, "showShootTips")
	self.moveTipsController = ControllerUtil.GetController(self.transform_, "showMoveTips")

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Shoot) then
		self.shootTipsController:SetSelectedState("hide")
	end

	if SnowballGameData:CheckAlreadyShowInGameTip(SnowballGameData.InGameTips.Move) then
		self.moveTipsController:SetSelectedState("hide")
	end

	self:InitBtnListeners()
	self:InitSubViews()
end

function SnowballGameControllerUI:NewSubView(arg_13_1, ...)
	local var_13_0 = arg_13_1.New(...)

	table.insert(self.subViews, var_13_0)

	return var_13_0
end

function SnowballGameControllerUI:InitSubViews()
	self.subViews = {}
	self.buffSubView = self:NewSubView(SnowballGameBuffSubView, self.buffSubView_)

	function self.buffSubView.OnBuffFinished(arg_15_0, arg_15_1)
		SnowballGameBuff.buff[arg_15_1].OnRemove(self.playerEID)
		manager.notify:Invoke(SNOWBALL_GAME_BUFF_FINISH, self.playerEID, arg_15_1)
		self:OnBuffRemoved(arg_15_1)
	end

	function self.buffSubView.OnBuffExtended(arg_16_0, arg_16_1)
		if SnowballGameBuff.buff[arg_16_1].OnExtended then
			SnowballGameBuff.buff[arg_16_1].OnExtended(self.playerEID)
		end
	end

	self.gameInfoSubView = self:NewSubView(SnowballGameInfoSubView, self.gameInfoSubView_)
end

function SnowballGameControllerUI:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.subViews) do
		iter_17_1:Dispose()
	end

	SnowballGameControllerUI.super.Dispose(self)
end

function SnowballGameControllerUI:AddJob(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {
		time = self.time + arg_18_1,
		task = arg_18_2
	}

	if arg_18_3 then
		self.jobs[arg_18_3] = var_18_0

		return arg_18_3
	else
		table.insert(self.jobs, var_18_0)

		return #self.jobs
	end
end

function SnowballGameControllerUI:RemoveJob(arg_19_1)
	if self.nextRemove == nil then
		self.nextRemove = {}
	end

	if self.jobs[arg_19_1] then
		table.insert(self.nextRemove, arg_19_1)
	end
end

function SnowballGameControllerUI:OnEnter()
	self.aim = 0
	self.wave = nil
	self.pause = false
	self.playerEID = self.params_.playerEID
	self.level = self.params_.level

	local var_20_0 = SnowballGameUnitCfg[DormUtils.GetEntityData(self.playerEID).cfgID]

	self.beamRadius = var_20_0.none_area
	self.shootCooldown = var_20_0.skill_cooldown
	self.crossireSpeed = var_20_0.ready_speed
	self.time = 0
	self.jobs = {}

	for iter_20_0 = 1, 3 do
		self:AddJob(iter_20_0 - 1, handlerArg1(self, self.StartCountdown, 3 - iter_20_0 + 1))
	end

	self:AddJob(3, handler(self, self.StartGame))
	self:AddJob(20, handler(self, self.NotifyGuestTalk))
	self.modeController:SetSelectedState("countdown")

	self.updateTicker = FuncTimerManager.inst:CreateFuncFrameTimer(handler(self, self.Update), -1, true)

	self:InitEventListeners()

	for iter_20_1, iter_20_2 in pairs(self.subViews) do
		iter_20_2:OnEnter(self)
	end

	Dorm.DormEntityManager.PutEntityAt(self.playerEID, (nullable(Dorm.storage:PickData("snowball.pos.gameStart"), "transform")))
	Dorm.DormEntityManager.StopAllCmd(self.playerEID)
	var_0_1("minigame_activity_2_6_snowball_time")
end

local var_0_4 = {}

function SnowballGameControllerUI:StartCountdown(arg_21_1)
	self.startCountdown_.text = GetTipsF(nullable(var_0_4, arg_21_1) or "%d", arg_21_1)
end

function SnowballGameControllerUI:OnExit()
	for iter_22_0, iter_22_1 in pairs(self.subViews) do
		iter_22_1:OnExit()
	end

	self:RemoveAllEventListener()

	if self.updateTicker then
		FuncTimerManager.inst:RemoveFuncTimer(self.updateTicker)

		self.updateTicker = nil
	end

	self.jobs = nil

	if self.waitAfterShoot then
		self.waitAfterShoot:Abort()

		self.waitAfterShoot = nil

		self.shoot:SetSelectedState("throw")
	end

	manager.windowBar:HideBar()
end

function SnowballGameControllerUI:IsGameStarted()
	return self.wave ~= nil
end

function SnowballGameControllerUI:StartGame()
	self.modeController:SetSelectedState("game")
	self.gameInfoSubView:OnGameStart()

	self.shootEnabled = true
	self.noMoreTarget = false

	SnowballGameMgr.GetInstance():SetLevel(self.level)
	self:StartGenWaveJob()
	self:RefreshWindowBar()
end

function SnowballGameControllerUI:EndGame(arg_25_1)
	local var_25_0 = SnowballGameMgr.GetInstance()

	Dorm.DormEntityManager.PutEntityAt(self.playerEID, var_25_0.playerSpawnPos)
	Dorm.DormEntityManager.StopAllCmd(self.playerEID)
	SnowballGameMgr.ClearVfxOnEntity(self.playerEID)
	SnowballGameMgr.CreateHoldSnowballVfx(self.playerEID)

	if self:IsGameStarted() then
		var_25_0:ClearAllTargets()
	end

	self:CancelAim()

	self.gameInfoSubView.started = false

	if arg_25_1 then
		JumpTools.OpenPageByJump("snowballGameResult", {
			finish = arg_25_1,
			level = self.level,
			score = self.gameInfoSubView.score,
			enemyList = self.gameInfoSubView.hitList,
			extraTime = self.gameInfoSubView:CalcRestTimeAfterFinish(),
			hitGuestCount = self.gameInfoSubView.hitGuest,
			OkCallback = var_0_2
		})
		var_0_1("minigame_activity_2_6_snowball_end")
		Dorm.DormEntityManager.SendDoActionCMD(self.playerEID, "happy", false)
	else
		var_0_2()
	end

	var_25_0:RemoveGuest()

	self.wave = nil
	self.shootEnabled = false

	self.buffSubView:ClearAllBuff()
end

function SnowballGameControllerUI:IsLastWave()
	return SnowballGameCfg[self.level].refresh_enemy[(self.wave or 0) + 1] == nil
end

function SnowballGameControllerUI:StartGenWaveJob()
	if self.noMoreTarget or self:IsLastWave() then
		self:EndGame(true)

		return
	end

	if self.wave then
		self.wave = self.wave + 1 or 0
	end

	manager.notify:Invoke(SNOWBALL_GAME_TARGET_NEW_WAVE, self.wave)
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

function SnowballGameControllerUI:IsChangeDir(arg_29_1)
	local var_29_0 = var_0_6(arg_29_1)

	if var_29_0 ~= 0 and var_0_6(self.lastMovingVec) ~= var_29_0 then
		return true, var_29_0
	end

	return false, var_29_0
end

local var_0_7 = {
	[1] = "snowball_move_R",
	[-1] = "snowball_move_L"
}

local function var_0_9(arg_30_0)
	return nullable(var_0_7, arg_30_0)
end

function SnowballGameControllerUI:Update()
	local var_31_0 = self.pause and 0 or Time.deltaTime

	self.time = self.time + (self.pause and 0 or Time.deltaTime)

	self:UpdateGameLogic(var_31_0)
	self:UpdateMove()
	self:UpdateAim(var_31_0)
	self:ExecuteJobs()

	for iter_31_0, iter_31_1 in pairs(self.subViews) do
		iter_31_1:Update(var_31_0, self.time)
	end
end

function SnowballGameControllerUI:UpdateGameLogic(arg_32_1)
	local var_32_0 = SnowballGameMgr.GetInstance()
	local var_32_1

	if not self:IsGameStarted() then
		do return end

		var_32_1 = false
	end

	if self.gameInfoSubView.totalTime <= 0 then
		var_32_1 = true
	elseif var_32_0:GetNormalTargetCount() + var_32_0:GetRewardTargetCount() == 0 then
		if self.gameInfoSubView.countdown > 5 then
			self.gameInfoSubView.countdown = 5
		end

		if self.noMoreTarget or self:IsLastWave() then
			var_32_1 = true
		end
	end

	if var_32_1 then
		self.gameInfoSubView:RecordFinishTime()
		self:EndGame(true)
	elseif self.gameInfoSubView.countdown <= 0 then
		self:StartGenWaveJob()
	end
end

function SnowballGameControllerUI:ExecuteJobs()
	if self.nextRemove then
		for iter_33_0, iter_33_1 in ipairs(self.nextRemove) do
			self.jobs[iter_33_1] = nil
		end

		self.nextRemove = nil
	end

	for iter_33_2 = #self.jobs, 1, -1 do
		if self.time >= self.jobs[iter_33_2].time then
			self.jobs[iter_33_2].task()
			table.remove(self.jobs, iter_33_2)
		end
	end
end

function SnowballGameControllerUI:UpdateMove()
	local var_34_0 = DormLuaBridge.TryGetJoytickInput()
	local var_34_1, var_34_2 = self:IsChangeDir(var_34_0)

	if var_34_1 then
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(self.playerEID, var_0_9(var_34_2))
		Dorm.DormEntityManager.TryTriggerResetAnimeDuringMove(self.playerEID)

		if self.moveTipsController:GetSelectedState() == "show" then
			self.moveTipsController:SetSelectedState("hide")
			SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Move)
		end
	end

	self.movingDirIndicator:SetSelectedState(var_0_5[var_34_2] or "none")

	self.lastMovingVec = var_34_0
end

local function var_0_11(arg_36_0)
	local var_36_0 = arg_36_0 % 2

	if arg_36_0 % 2 < 0 then
		var_36_0 = var_36_0 + 2
	end

	if var_36_0 > 1 then
		var_36_0 = 2 - var_36_0
	end

	return var_36_0
end

function SnowballGameControllerUI:UpdateAim(arg_37_1)
	if self.crosshire:GetSelectedState() ~= "move" then
		return
	end

	arg_37_1 = arg_37_1 or Time.deltaTime
	self.aim = self.aim + (self.crossireSpeed or GameSetting.activity_snowball_crosshair_speed.value[1] or 1) * arg_37_1

	local var_37_0 = var_0_11(self.aim)
	local var_37_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_37_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_37_1, (self.crosshire_.parent:TransformPoint((Vector2.Lerp(Vector2(0, self.crosshire_.parent.rect.yMin), Vector2(0, self.crosshire_.parent.rect.yMax), var_37_0)))))

	var_37_2.x = UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, (Dorm.DormEntityManager.QueryEntityAttachPointWorldPos(self.playerEID, "gua_Hit"))).x
	self.crosshirePos = var_37_2

	local var_37_3, var_37_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.crosshire_.parent, var_37_2, var_37_1, nil)

	self.crosshire_.localPosition = var_37_4
	self.chargeKnot_.localRotation = Quaternion.Euler(0, 0, var_37_0 * -120)
end

function SnowballGameControllerUI:InitBtnListeners()
	local var_38_0 = self:GetOrAddComponent(self.shootBtn_, typeof(EventTriggerListener))

	var_38_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_39_0, arg_39_1)
		self:Shoot()
	end))
	var_38_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_40_0, arg_40_1)
		self:BeginAim()
	end))

	self.shootLongHoldBtn = var_38_0

	self:SetListener(var_38_0)
end

function SnowballGameControllerUI:InitEventListeners()
	self:RegistEventListener(SNOWBALL_GAME_ALL_TARGET_SPAWNED, function()
		self.noMoreTarget = true
	end)
	self:RegistEventListener(SNOWBALL_GAME_PLAYER_GET_BUFF, handler(self, self.AddBuff))
end

function SnowballGameControllerUI:AddBuff(arg_43_1, arg_43_2, arg_43_3)
	if not self:IsGameStarted() then
		return
	end

	self.buffSubView:AddBuff(arg_43_1, arg_43_2, arg_43_3)
	SnowballGameBuff.buff[arg_43_1].OnApply(self.playerEID, arg_43_3)

	if arg_43_1 == SnowballGameBuff.buffType.Freeze then
		self:CancelAim()

		self.shootEnabled = false
	end
end

function SnowballGameControllerUI:OnBuffRemoved(arg_44_1)
	if arg_44_1 == SnowballGameBuff.buffType.Freeze then
		self.shootEnabled = true
	end
end

function SnowballGameControllerUI:BeginAim()
	if not self:ReadyToShoot() then
		return
	end

	if self.shootTipsController:GetSelectedState() == "show" then
		self.shootTipsController:SetSelectedState("hide")
		SnowballGameData:InGameTipClose(SnowballGameData.InGameTips.Shoot)
	end

	var_0_1("minigame_activity_2_6_snowball_preattack")

	self.beginAim = true
	self.aim = 0

	self.crosshire:SetSelectedState("move")
	self:UpdateAim(0)
	self.shoot:SetSelectedState("charge")
end

function SnowballGameControllerUI:CancelAim()
	self.beginAim = false

	self.crosshire:SetSelectedState("hide")

	if self.shoot:GetSelectedState() == "charge" then
		self.shoot:SetSelectedState("throw")
	end
end

local var_0_12 = Dorm.LuaBridge.MiniGameBridge

function SnowballGameControllerUI:GetCharaShootWait()
	return self.shootCooldown or 1
end

function SnowballGameControllerUI:UpdateWaitAfterShoot(arg_48_1)
	self.cooldown_.fillAmount = arg_48_1
end

function SnowballGameControllerUI:CanShoot()
	return self.beginAim and self:ReadyToShoot()
end

function SnowballGameControllerUI:ReadyToShoot()
	return self.shootEnabled and not self.isInShootCooldown
end

function SnowballGameControllerUI:Shoot()
	if not self:CanShoot() then
		return
	end

	self.beginAim = false

	self.shoot:SetSelectedState("wait")
	self.crosshire:SetSelectedState("hide")
	var_0_1("minigame_activity_2_6_snowball_footstep_stop")

	if self.waitAfterShoot then
		self.waitAfterShoot:Abort()
	end

	local var_51_0 = self:GetCharaShootWait()

	self.isInShootCooldown = true
	self.waitAfterShoot = DormCharacterActionManager.frameTaskRunner:NewTask():WaitUntil(function(arg_52_0)
		arg_52_0.wait = arg_52_0.wait - (self.pause and 0 or DormCharacterActionManager:FrameTaskDeltaTime()) * SnowballGameMgr.GetInstance().shootSpeedFactor

		self:UpdateWaitAfterShoot(arg_52_0.wait / arg_52_0.total)

		return arg_52_0.wait <= 0
	end, false, {
		wait = var_51_0,
		total = var_51_0
	}):Then(function()
		self.shoot:SetSelectedState("throw")

		self.isInShootCooldown = false
	end):Start()

	local var_51_1, var_51_2, var_51_3 = var_0_12.BeamcastEntity(self.crosshirePos, self.beamRadius, nil, nil)

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

function SnowballGameControllerUI:NotifyGuestTalk()
	if self:IsGameStarted() then
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetGuestEID(), GetTips(var_0_14(var_0_13)), true)
		self:AddJob(20, handler(self, self.NotifyGuestTalk))
	end
end

function SnowballGameControllerUI:OnGameFocusChange(arg_56_1, arg_56_2)
	if arg_56_2 then
		var_0_3(self)
	end
end

return SnowballGameControllerUI
