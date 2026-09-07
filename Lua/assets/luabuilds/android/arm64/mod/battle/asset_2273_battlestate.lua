ys = ys or {}

local var_0_0 = ys

ys.Battle = ys.Battle or {}

local var_0_1 = {}

pg.bfConsts = var_0_1
var_0_1.DFT_CRIT_EFFECT = 1.5
var_0_1.DFT_CRIT_RATE = 0.05
var_0_1.SECONDs = 60
var_0_1.PERCENT = 0.01
var_0_1.PERCENT1 = 0.001
var_0_1.PERCENT2 = 0.0001
var_0_1.HUNDRED = 100
var_0_1.SCORE_RATE = {
	0.7,
	0.8,
	0.3
}
var_0_1.CRASH_RATE = {
	0.05,
	0.025
}
var_0_1.SUBMARINE_KAMIKAZE = {
	80,
	3.5,
	1.5,
	1,
	0.5,
	0.5,
	1,
	0.005
}
var_0_1.LEAK_RATE = {
	10,
	2.2,
	0.7,
	0.3,
	1,
	0.005,
	0.5
}
var_0_1.PLANE_LEAK_RATE = {
	1,
	1,
	0.01,
	0.5,
	0.7,
	0.3,
	1,
	0.005,
	150,
	150,
	1,
	1
}
var_0_1.METEO_RATE = {
	0.05,
	20,
	0.6,
	0.4
}
var_0_1.NUM1 = 1
var_0_1.NUM0 = 0
var_0_1.NUM10000 = 10000
var_0_1.ACCURACY = {
	0.1,
	2
}
var_0_1.DRATE = {
	25,
	0.02,
	0.0002,
	2000,
	0.1,
	0.8,
	150
}
var_0_1.SPEED_CONST = 0.02
var_0_1.HP_CONST = 1.5

local var_0_2 = singletonClass("BattleState", ys.MVC.Facade)

ys.Battle.BattleState = var_0_2
var_0_2.__name = "BattleState"
var_0_2.BATTLE_STATE_IDLE = "BATTLE_IDLE"
var_0_2.BATTLE_STATE_OPENING = "BATTLE_OPENING"
var_0_2.BATTLE_STATE_FIGHT = "BATTLE_FIGHT"
var_0_2.BATTLE_STATE_REPORT = "BATTLE_REPORT"

function var_0_2:Ctor()
	var_0_2.super.Ctor(self)
	self:ChangeState(var_0_2.BATTLE_STATE_IDLE)

	return
end

function var_0_2.GetCombatSkinKey()
	return COMBAT_SKIN_KEY or "Standard"
end

function var_0_2.IsAutoBotActive(arg_3_0)
	return PlayerPrefs.GetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(arg_3_0), 0) == 1 and AutoBotCommand.autoBotSatisfied()
end

function var_0_2.IsAutoSubActive(arg_4_0)
	return PlayerPrefs.GetInt("autoSubIsAcitve" .. AutoSubCommand.GetAutoSubMark(arg_4_0), 0) == 1
end

function var_0_2:ChatUseable()
	local var_5_0 = PlayerPrefs.GetInt(HIDE_CHAT_FLAG)
	local var_5_1 = self:GetBattleType()

	return (not var_5_0 or var_5_0 ~= 1) and (var_5_1 == SYSTEM_DUEL or self.IsAutoBotActive(var_5_1)) and var_5_1 ~= SYSTEM_CARDPUZZLE
end

function var_0_2:GetState()
	return self._state
end

function var_0_2:GetBattleType()
	return self._battleType
end

function var_0_2.SetBattleUI(arg_8_0, arg_8_1)
	arg_8_0._baseUI = arg_8_1

	return
end

function var_0_2:EnterBattle(arg_9_1, arg_9_2)
	pg.TimeMgr.GetInstance():ResetCombatTime()
	self:Active()
	self:ResetTimer()

	self._dataProxy = self:AddDataProxy(var_0_0.Battle.BattleDataProxy.GetInstance())
	self._uiMediator = self:AddMediator(var_0_0.Battle.BattleUIMediator.New())
	self._battleType = arg_9_1.battleType
	self._battleCommand = self:AddCommand((var_0_0.Battle.BattleFacadeGate.CommandGates[self._battleType] or var_0_0.Battle.BattleSingleDungeonCommand).New())
	self._sceneMediator = self:AddMediator(var_0_0.Battle.BattleSceneMediator.New())
	self._weaponCommand = self:AddCommand(var_0_0.Battle.BattleControllerWeaponCommand.New())

	self._dataProxy:InitBattle(arg_9_1)

	if BATTLE_DEFAULT_UNIT_DETAIL then
		self:AddMediator(var_0_0.Battle.BattleReferenceBoxMediator.New())
		self:GetMediatorByName(var_0_0.Battle.BattleReferenceBoxMediator.__name):ActiveUnitDetail(true)
	end

	if arg_9_2 then
		-- block empty
	else
		self:ChangeState(var_0_2.BATTLE_STATE_OPENING)
		UpdateBeat:Add(self.Update, self)
	end

	return
end

function var_0_2:GetSceneMediator()
	return self._sceneMediator
end

function var_0_2:GetUIMediator()
	return self._uiMediator
end

function var_0_2:ActiveBot(arg_12_1)
	self._weaponCommand:ActiveBot(arg_12_1, true)
	self:EnableJoystick(not arg_12_1)

	return
end

function var_0_2:EnableJoystick(arg_13_1)
	self._uiMediator:EnableJoystick(arg_13_1)

	return
end

function var_0_2:IsBotActive()
	return self._weaponCommand:GetWeaponBot():IsActive()
end

function var_0_2:Update()
	if not self._isPause then
		for iter_15_0, iter_15_1 in pairs(self._mediatorList) do
			iter_15_1:Update()
		end
	else
		for iter_15_2, iter_15_3 in pairs(self._mediatorList) do
			iter_15_3:UpdatePause()
		end
	end

	return
end

function var_0_2.GenerateVertifyData(arg_16_0)
	return
end

function var_0_2.Vertify()
	return true, -1
end

function var_0_2:ChangeState(arg_18_1)
	self._state = arg_18_1

	if arg_18_1 == var_0_2.BATTLE_STATE_OPENING then
		self._dataProxy:Start()

		local var_18_0 = getProxy(ChapterProxy)

		if self._dataProxy._dungeonInfo.beginStoy then
			if var_18_0 and var_18_0:GetContinuousData(SYSTEM_SCENARIO) then
				pg.NewStoryMgr.GetInstance():ForceAutoPlay(self._dataProxy._dungeonInfo.beginStoy, function()
					self._battleCommand:DoPrologue()

					return
				end)
			else
				pg.NewStoryMgr.GetInstance():Play(self._dataProxy._dungeonInfo.beginStoy, function()
					self._battleCommand:DoPrologue()

					return
				end)
			end
		else
			self._battleCommand:DoPrologue()
		end
	elseif arg_18_1 == var_0_2.BATTLE_STATE_FIGHT then
		self:ActiveAutoComponentTimer()

		if not self._dataProxy:GetFleetLegal(var_0_0.Battle.BattleConfig.FRIENDLY_CODE, self:GetBattleType()) then
			self._battleCommand:CalcStatistic()
			self:BattleEnd()
		end
	elseif arg_18_1 == var_0_2.BATTLE_STATE_REPORT then
		-- block empty
	end

	return
end

function var_0_2:GetUI()
	return self._baseUI
end

function var_0_2.ConfigBattleEndFunc(arg_22_0, arg_22_1)
	arg_22_0._endFunc = arg_22_1

	return
end

function var_0_2:BattleEnd()
	self:disableCommon()

	if self._dataProxy:GetStatistics()._battleScore >= var_0_0.Battle.BattleConst.BattleScore.B then
		self._dataProxy:CelebrateVictory(self._dataProxy:GetFriendlyCode())
		self:reportDelayTimer(function()
			self:DoResult()

			return
		end, var_0_0.Battle.BattleConfig.CelebrateDuration)
	else
		self:DoResult()
	end

	return
end

function var_0_2:BattleTimeUp()
	self:disableCommon()
	self:ActiveEscape()
	self:reportDelayTimer(function()
		self:DeactiveEscape()
		self:DoResult()

		return
	end, var_0_0.Battle.BattleConfig.EscapeDuration)

	return
end

function var_0_2:DoResult()
	self._sceneMediator:PauseCharacterAction(true)
	self._dataProxy:BotPercentage(self._weaponCommand:GetBotActiveDuration())
	self._dataProxy:HPRatioStatistics()
	self._endFunc(self._dataProxy:GetStatistics())

	return
end

function var_0_2:ExitBattle()
	var_0_0.Battle.BattleCameraUtil.GetInstance():Clear()

	for iter_28_0, iter_28_1 in pairs(self._mediatorList) do
		self:RemoveMediator(iter_28_1)
	end

	for iter_28_2, iter_28_3 in pairs(self._commandList) do
		self:RemoveCommand(iter_28_3)
	end

	for iter_28_4, iter_28_5 in pairs(self._proxyList) do
		self:RemoveProxy(iter_28_5)
	end

	var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE = 1

	self:RemoveAllTimer()
	var_0_0.Battle.BattleResourceManager.GetInstance():Clear()

	self._takeoverProcess = nil

	self:ChangeState(var_0_2.BATTLE_STATE_IDLE)

	self._baseUI = nil
	self._endFunc = nil
	self._uiMediator = nil
	self._sceneMediator = nil
	self._battleCommand = nil
	self._weaponCommand = nil

	removeSingletonInstance(var_0_0.Battle.BattleDataProxy)

	self._dataProxy = nil

	var_0_0.Battle.BattleVariable.Clear()
	var_0_0.Battle.BattleBulletFactory.DestroyFactory()
	UpdateBeat:Remove(self.Update, self)
	pg.EffectMgr.GetInstance():ClearBattleEffectMap()

	self._timeScale = nil
	self._timescalerCache = nil

	gcAll(true)

	return
end

function var_0_2:Stop(arg_29_1)
	if self:GetBattleType() == SYSTEM_TEST then
		InDebugBattleLoop = nil

		pg.TipsMgr.GetInstance():ShowTips("interrupt")
	end

	self:disableCommon()
	self._baseUI:exitBattle(arg_29_1)

	return
end

function var_0_2:disableCommon()
	self._weaponCommand:ActiveBot(false)
	self:ScaleTimer()
	var_0_0.Battle.BattleCameraUtil.GetInstance():ResetFocus()
	self:ChangeState(var_0_2.BATTLE_STATE_REPORT)
	self._dataProxy:ClearAirFighterTimer()
	self._dataProxy:KillAllAircraft()
	self._sceneMediator:AllBulletNeutralize()
	var_0_0.Battle.BattleCameraUtil.GetInstance():StopShake()
	var_0_0.Battle.BattleCameraUtil.GetInstance():Deactive()
	self._uiMediator:DisableComponent()
	self:Deactive()

	return
end

function var_0_2:reportDelayTimer(arg_31_1, arg_31_2)
	local var_31_0

	self:RemoveAllTimer()
	pg.TimeMgr.GetInstance():ResumeBattleTimer()

	var_31_0 = pg.TimeMgr.GetInstance():AddBattleTimer("reportDelay", -1, arg_31_2, function()
		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_31_0)

		var_31_0 = nil

		arg_31_1()

		return
	end)

	return
end

function var_0_2:SetTakeoverProcess(arg_33_1)
	assert(self._takeoverProcess == nil, "已经有接管的战斗过程，暂时没有定义这种逻辑")
	assert(arg_33_1.Pause ~= nil and type(arg_33_1.Pause) == "function", "SetTakeoverProcess附加过程，必须要有Pause函数")
	assert(arg_33_1.Pause ~= nil and type(arg_33_1.Resume) == "function", "SetTakeoverProcess附加过程，必须要有Pause函数")

	self._takeoverProcess = arg_33_1

	self:_pause()

	return
end

function var_0_2:ClearTakeoverProcess()
	assert(self._takeoverProcess, "没有接管的战斗过程，暂时没有定义这种逻辑")

	self._takeoverProcess = nil

	self:_resume()

	return
end

function var_0_2:IsPause()
	return self._isPause
end

function var_0_2:Pause()
	if self._takeoverProcess then
		self._takeoverProcess.Pause()
	else
		self:_pause()
	end

	return
end

function var_0_2:_pause()
	self:Deactive()
	self._dataProxy:PausePuzzleComponent()
	self._sceneMediator:Pause()

	if self._timeScale ~= 1 then
		self:CacheTimescaler(self._timeScale)
		self:ScaleTimer(1)
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():PauseCameraTween()

	return
end

function var_0_2:Resume()
	if self._state == var_0_2.BATTLE_STATE_IDLE then
		self:ChangeState(var_0_2.BATTLE_STATE_OPENING)
		UpdateBeat:Add(self.Update, self)
	elseif self._state == var_0_2.BATTLE_STATE_REPORT then
		return
	end

	if self._takeoverProcess then
		self._takeoverProcess.Resume()
	else
		self:_resume()
	end

	return
end

function var_0_2:_resume()
	self._sceneMediator:Resume()
	self:Active()
	self._dataProxy:ResumePuzzleComponent()

	if self._timescalerCache then
		self:ScaleTimer(self._timescalerCache)
		self:CacheTimescaler()
	end

	var_0_0.Battle.BattleCameraUtil.GetInstance():ResumeCameraTween()

	return
end

function var_0_2.ScaleTimer(arg_40_0, arg_40_1)
	arg_40_1 = arg_40_1 or var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

	pg.TimeMgr.GetInstance():ScaleBattleTimer(arg_40_1)

	arg_40_0._timeScale = arg_40_1

	return
end

function var_0_2:GetTimeScaleRate()
	return self._timeScale or 1
end

function var_0_2.CacheTimescaler(arg_42_0, arg_42_1)
	arg_42_0._timescalerCache = arg_42_1

	return
end

function ys.Battle.PlayBattleSFX(arg_43_0)
	if arg_43_0 ~= "" then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/" .. arg_43_0)
	end

	return
end

function var_0_2:OpenConsole()
	self._uiMediator:InitDebugConsole()
	self._uiMediator:ActiveDebugConsole()

	return
end

function var_0_2:ActiveReference()
	self._controllerCommand = self:AddCommand(var_0_0.Battle.BattleControllerCommand.New())

	return
end

return
