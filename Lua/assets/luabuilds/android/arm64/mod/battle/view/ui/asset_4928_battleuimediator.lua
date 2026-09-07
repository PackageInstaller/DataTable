ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleUnitEvent
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleVariable
local var_0_5 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleCardPuzzleEvent
local BattleUIMediator = class("BattleUIMediator", ys.MVC.Mediator)

ys.Battle.BattleUIMediator = BattleUIMediator
BattleUIMediator.__name = "BattleUIMediator"

function BattleUIMediator:Ctor()
	BattleUIMediator.super.Ctor(self)

	return
end

function BattleUIMediator:SetBattleUI()
	self._ui = self._state:GetUI()

	return
end

function BattleUIMediator:Initialize()
	BattleUIMediator.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)
	self._uiMGR = pg.UIMgr.GetInstance()
	self._fxPool = var_0_0.Battle.BattleFXPool.GetInstance()
	self._updateViewList = {}

	self:SetBattleUI()
	self:AddUIEvent()
	self:InitCamera()
	self:InitGuide()

	return
end

function BattleUIMediator:Reinitialize()
	self._skillView:Dispose()

	return
end

function BattleUIMediator:EnableComponent(arg_5_1)
	self._ui._tf:Find("PauseBtn"):GetComponent(typeof(Button)).enabled = arg_5_1

	self._skillView:EnableWeaponButton(arg_5_1)

	return
end

function BattleUIMediator:EnableJoystick(arg_6_1)
	self._stickController.enabled = arg_6_1

	local var_6_0 = self._joystick:GetComponent(typeof(Animation))

	if var_6_0 then
		var_6_0.enabled = arg_6_1
	end

	local var_6_1 = self._joystick:GetComponent(typeof(Animator))

	if var_6_1 then
		var_6_1.enabled = arg_6_1
	end

	setActive(self._joystick, arg_6_1)

	local var_6_2 = self._joystick:Find("Area/BG/spine")

	if var_6_2 then
		if arg_6_1 then
			var_6_2:GetComponent(typeof(SpineAnimUI)):SetAction("cut_in", 0)
		end
	end

	return
end

function BattleUIMediator:EnableWeaponButton(arg_7_1)
	self._skillView:EnableWeaponButton(arg_7_1)

	return
end

function BattleUIMediator:EnableSkillFloat(arg_8_1)
	self._ui:EnableSkillFloat(arg_8_1)

	return
end

function BattleUIMediator:GetAppearFX()
	return self._appearEffect
end

function BattleUIMediator:DisableComponent()
	self._ui._tf:Find("PauseBtn"):GetComponent(typeof(Button)).enabled = false

	self._skillView:DisableWeapnButton()
	SetActive(self._ui._tf:Find("HPBarContainer"), false)
	SetActive(self._ui._tf:Find("flagShipMark"), false)

	if self._jammingView then
		self._jammingView:Eliminate(false)
	end

	if self._inkView then
		self._inkView:SetActive(false)
	end

	return
end

function BattleUIMediator:ActiveDebugConsole()
	self._debugConsoleView:SetActive(true)

	return
end

function BattleUIMediator:OpeningEffect(arg_12_1, arg_12_2)
	self._uiMGR:SetActive(false)

	if arg_12_2 == SYSTEM_SUBMARINE_RUN then
		self._skillView:SubmarineButton()

		self._joystick.anchorMin = Vector2(var_0_5.JOY_STICK_DEFAULT_PREFERENCE.x, var_0_5.JOY_STICK_DEFAULT_PREFERENCE.y)
		self._joystick.anchorMax = Vector2(var_0_5.JOY_STICK_DEFAULT_PREFERENCE.x, var_0_5.JOY_STICK_DEFAULT_PREFERENCE.y)
	elseif arg_12_2 == SYSTEM_SUB_ROUTINE then
		self._skillView:SubRoutineButton()
	elseif arg_12_2 == SYSTEM_AIRFIGHT then
		self._skillView:AirFightButton()
	elseif arg_12_2 == SYSTEM_DEBUG then
		self._skillView:NormalButton()
	elseif arg_12_2 == SYSTEM_CARDPUZZLE then
		self._skillView:CardPuzzleButton()
	else
		local var_12_0 = pg.SeriesGuideMgr.GetInstance()

		if var_12_0.currIndex and var_12_0:isEnd() then
			self._skillView:NormalButton()
		else
			self._skillView:CustomButton(self._dataProxy:GetDungeonData().skill_hide or {})
		end
	end

	LeanTween.delayedCall(var_0_5.COMBAT_DELAY_ACTIVE, System.Action(function()
		self._uiMGR:SetActive(true)
		self:EnableComponent(true)

		if arg_12_1 then
			arg_12_1()
		end

		return
	end))
	SetActive(self._ui._go, true)
	self._skillView:ButtonInitialAnima()

	return
end

function BattleUIMediator:InitScene()
	self._mapId = self._dataProxy._mapId
	self._seaView = var_0_0.Battle.BattleMap.New(self._mapId)

	return
end

function BattleUIMediator:InitJoystick()
	local var_15_9000

	self._joystick = self._ui._tf:Find("Stick")

	local var_15_0 = PlayerPrefs.GetFloat("joystick_anchorX", var_0_5.JOY_STICK_DEFAULT_PREFERENCE.x)
	local var_15_1 = PlayerPrefs.GetFloat("joystick_anchorY", var_0_5.JOY_STICK_DEFAULT_PREFERENCE.y)
	local var_15_2 = var_15_9000 * PlayerPrefs.GetFloat("joystick_scale", var_0_5.JOY_STICK_DEFAULT_PREFERENCE.scale)

	self._joystick.localScale = Vector3(1, var_15_2, 1)

	originalPrint("scale: ", self._joystick.localScale)

	self._joystick.anchoredPosition = self._joystick.anchoredPosition * var_15_2
	self._joystick.anchorMin = Vector2(var_15_0, var_15_1)
	self._joystick.anchorMax = Vector2(var_15_0, var_15_1)
	self._stickController = self._joystick:GetComponent("StickController")

	self._uiMGR:AttachStickOb(self._joystick)

	local var_15_3 = self._joystick:Find("Area/BG/spine")

	if var_15_3 then
		local var_15_4 = var_15_3:GetComponent(typeof(SpineAnimUI))

		var_15_4:SetActionCallBack(function(arg_16_0)
			if arg_16_0 == "finish" then
				if self._stickController.enabled then
					var_15_4:SetAction("normal", 0)
				else
					SetActive(self._joystick, false)
				end
			end

			return
		end)
	end

	return
end

function BattleUIMediator:InitTimer()
	self._timerView = self._dataProxy:GetInitData().battleType == SYSTEM_DUEL and var_0_0.Battle.BattleTimerView.New(self._ui._tf:Find("DuelTimer")) or var_0_0.Battle.BattleTimerView.New(self._ui._tf:Find("Timer"))

	return
end

function BattleUIMediator:InitEnemyHpBar()
	self._enemyHpBar = var_0_0.Battle.BattleEnmeyHpBarView.New(self._ui._tf:Find("EnemyHPBar"))

	return
end

function BattleUIMediator:InitAirStrikeIcon()
	self._airStrikeView = var_0_0.Battle.BattleAirStrikeIconView.New(self._ui._tf:Find("AirFighterContainer/AirStrikeIcon"))
	self._airSupportTF = self._ui._tf:Find("AirSupportLabel")

	return
end

function BattleUIMediator:InitCommonWarning()
	self._warningView = var_0_0.Battle.BattleCommonWarningView.New(self._ui._tf:Find("WarningView"))
	self._updateViewList[self._warningView] = true

	return
end

function BattleUIMediator:InitScoreBar()
	self._scoreBarView = var_0_0.Battle.BattleScoreBarView.New(self._ui._tf:Find("DodgemCountBar"))

	return
end

function BattleUIMediator:InitAirFightScoreBar()
	self._scoreBarView = var_0_0.Battle.BattleScoreBarView.New(self._ui._tf:Find("AirFightCountBar"))

	return
end

function BattleUIMediator:InitAutoBtn()
	self._autoBtn = self._ui._tf:Find("AutoBtn")

	local var_23_0 = PlayerPrefs.GetFloat("auto_scale", var_0_5.AUTO_DEFAULT_PREFERENCE.scale)
	local var_23_1 = PlayerPrefs.GetFloat("auto_anchorX", var_0_5.AUTO_DEFAULT_PREFERENCE.x)
	local var_23_2 = PlayerPrefs.GetFloat("auto_anchorY", var_0_5.AUTO_DEFAULT_PREFERENCE.y)

	self._autoBtn.localScale = Vector3(var_23_0, var_23_0, 1)
	self._autoBtn.anchorMin = Vector2(var_23_1, var_23_2)
	self._autoBtn.anchorMax = Vector2(var_23_1, var_23_2)

	return
end

function BattleUIMediator:InitDuelRateBar()
	self._duelRateBar = var_0_0.Battle.BattleDuelDamageRateView.New(self._ui._tf:Find("DuelDamageRate"))

	return self._duelRateBar
end

function BattleUIMediator:InitSimulationBuffCounting()
	self._simulationBuffCountView = var_0_0.Battle.BattleSimulationBuffCountView.New(self._ui._tf:Find("SimulationWarning"))

	return self._simulationBuffCountView
end

function BattleUIMediator:InitMainDamagedView()
	self._mainDamagedView = var_0_0.Battle.BattleMainDamagedView.New(self._ui._tf:Find("HPWarning"))

	return
end

function BattleUIMediator:InitInkView(arg_27_1)
	self._inkView = var_0_0.Battle.BattleInkView.New(self._ui._tf:Find("InkContainer"))

	arg_27_1:RegisterEventListener(self, var_0_1.FLEET_HORIZON_UPDATE, self.onFleetHorizonUpdate)

	return
end

function BattleUIMediator:InitDebugConsole()
	self._debugConsoleView = self._debugConsoleView or var_0_0.Battle.BattleDebugConsole.New(self._ui._tf:Find("Debug_Console"), self._state)

	return
end

function BattleUIMediator:InitCameraGestureSlider()
	self._gesture = var_0_0.Battle.BattleCameraSlider.New(self._ui._tf:Find("CameraController"))

	var_0_0.Battle.BattleCameraUtil.GetInstance():SetCameraSilder(self._gesture)
	self._cameraUtil:SwitchCameraPos("FOLLOW_GESTURE")

	return
end

function BattleUIMediator:InitAlchemistAPView()
	if not self._alchemistAP then
		local var_30_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstReisalinAPUI()

		setParent(var_30_0, self._ui.uiCanvas, false)

		self._alchemistAP = var_0_0.Battle.BattleReisalinAPView.New(var_30_0.transform:Find("APPanel"))
	end

	return
end

function BattleUIMediator:InitAlchemistManaView()
	if not self._alchemistMana then
		local var_31_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstYumiaManaUI()

		setParent(var_31_0, self._ui.uiCanvas, false)

		self._alchemistMana = var_0_0.Battle.BattleYumiaManaView.New(var_31_0.transform:Find("ManaPanel"))
	end

	return
end

function BattleUIMediator:InitGuide()
	return
end

function BattleUIMediator:InitCamera()
	self._camera = pg.UIMgr.GetInstance():GetMainCamera():GetComponent(typeof(Camera))
	self._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	self._cameraUtil = var_0_0.Battle.BattleCameraUtil.GetInstance()

	self._cameraUtil:RegisterEventListener(self, var_0_1.CAMERA_FOCUS, self.onCameraFocus)
	self._cameraUtil:RegisterEventListener(self, var_0_1.SHOW_PAINTING, self.onShowPainting)
	self._cameraUtil:RegisterEventListener(self, var_0_1.BULLET_TIME, self.onBulletTime)

	return
end

function BattleUIMediator:Update()
	for iter_34_0, iter_34_1 in pairs(self._updateViewList) do
		iter_34_0:Update()
	end

	return
end

function BattleUIMediator:AddUIEvent()
	self._dataProxy:RegisterEventListener(self, var_0_1.STAGE_DATA_INIT_FINISH, self.onStageInit)
	self._dataProxy:RegisterEventListener(self, var_0_1.COMMON_DATA_INIT_FINISH, self.onCommonInit)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_FLEET, self.onAddFleet)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_1.HIT_ENEMY, self.onEnemyHit)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_AIR_FIGHTER_ICON, self.onAddAirStrike)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_AIR_FIGHTER_ICON, self.onRemoveAirStrike)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_AIR_SUPPORT_LABEL, self.onUpdateAirSupportLabel)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_HOSTILE_SUBMARINE, self.onUpdateHostileSubmarine)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_ENVIRONMENT_WARNING, self.onUpdateEnvironmentWarning)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_COUNT_DOWN, self.onUpdateCountDown)
	self._dataProxy:RegisterEventListener(self, var_0_1.HIDE_INTERACTABLE_BUTTONS, self.OnHideButtons)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_UI_FX, self.OnAddUIFX)
	self._dataProxy:RegisterEventListener(self, var_0_1.EDIT_CUSTOM_WARNING_LABEL, self.onEditCustomWarning)
	self._dataProxy:RegisterEventListener(self, var_0_1.GRIDMAN_SKILL_FLOAT, self.onGridmanSkillFloat)
	self._dataProxy:RegisterEventListener(self, var_0_6.CARD_PUZZLE_INIT, self.OnCardPuzzleInit)

	return
end

function BattleUIMediator:RemoveUIEvent()
	self._dataProxy:UnregisterEventListener(self, var_0_1.COMMON_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_1.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_FLEET)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.HIT_ENEMY)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_COUNT_DOWN)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_AIR_FIGHTER_ICON)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_AIR_FIGHTER_ICON)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_AIR_SUPPORT_LABEL)
	self._cameraUtil:UnregisterEventListener(self, var_0_1.SHOW_PAINTING)
	self._cameraUtil:UnregisterEventListener(self, var_0_1.CAMERA_FOCUS)
	self._cameraUtil:UnregisterEventListener(self, var_0_1.BULLET_TIME)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_SUBMARINE_WARINING)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_SUBMARINE_WARINING)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_DODGEM_SCORE)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_DODGEM_COMBO)
	self._userFleet:UnregisterEventListener(self, var_0_1.SHOW_BUFFER)
	self._userFleet:UnregisterEventListener(self, var_0_2.POINT_HIT_CHARGE)
	self._userFleet:UnregisterEventListener(self, var_0_2.POINT_HIT_CANCEL)
	self._userFleet:UnregisterEventListener(self, var_0_1.MANUAL_SUBMARINE_SHIFT)
	self._userFleet:UnregisterEventListener(self, var_0_1.FLEET_BLIND)
	self._userFleet:UnregisterEventListener(self, var_0_1.FLEET_HORIZON_UPDATE)
	self._userFleet:UnregisterEventListener(self, var_0_1.UPDATE_FLEET_ATTR)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_HOSTILE_SUBMARINE)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_ENVIRONMENT_WARNING)
	self._dataProxy:UnregisterEventListener(self, var_0_1.HIDE_INTERACTABLE_BUTTONS)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_UI_FX)
	self._dataProxy:UnregisterEventListener(self, var_0_1.EDIT_CUSTOM_WARNING_LABEL)
	self._dataProxy:UnregisterEventListener(self, var_0_1.GRIDMAN_SKILL_FLOAT)
	self._dataProxy:UnregisterEventListener(self, var_0_6.CARD_PUZZLE_INIT)
	self._dataProxy:UnregisterEventListener(self, var_0_6.UPDATE_FLEET_SHIP)
	self._dataProxy:UnregisterEventListener(self, var_0_6.COMMON_BUTTON_ENABLE)
	self._dataProxy:UnregisterEventListener(self, var_0_6.LONG_PRESS_BULLET_TIME)
	self._dataProxy:UnregisterEventListener(self, var_0_6.SHOW_CARD_DETAIL)

	return
end

function BattleUIMediator:ShowSkillPainting(arg_37_1, arg_37_2, arg_37_3)
	arg_37_3 = arg_37_3 or 1

	local var_37_0

	if arg_37_2 then
		if arg_37_2.cutin_cover then
			var_37_0 = arg_37_2.cutin_cover
		elseif arg_37_2.cutin_cover_DAL then
			self._ui:CutInPaintingDAL(arg_37_1:GetTemplate(), arg_37_3, arg_37_1:GetIFF(), arg_37_2)

			return
		end
	end

	self._ui:CutInPainting(arg_37_1:GetTemplate(), arg_37_3, arg_37_1:GetIFF(), var_37_0)

	return
end

function BattleUIMediator:ShowSkillFloat(arg_38_1, arg_38_2, arg_38_3)
	self._ui:SkillHrzPop(arg_38_2, arg_38_1, arg_38_3)

	return
end

function BattleUIMediator:ShowSkillFloatCover(arg_39_1, arg_39_2, arg_39_3)
	self._ui:SkillHrzPopCover(arg_39_2, arg_39_1, arg_39_3)

	return
end

function BattleUIMediator:SeaSurfaceShift(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	self._seaView:ShiftSurface(arg_40_1, arg_40_2, arg_40_3 or var_0_0.Battle.BattleConfig.calcInterval, arg_40_4)

	return
end

function BattleUIMediator:ShowAutoBtn()
	SetActive(self._autoBtn.transform, true)
	triggerToggle(self._autoBtn, var_0_0.Battle.BattleState.IsAutoBotActive((self:GetState():GetBattleType())))

	return
end

function BattleUIMediator:ShowTimer()
	self._timerView:SetActive(true)

	return
end

function BattleUIMediator:ShowDuelBar()
	self._duelRateBar:SetActive(true)

	return
end

function BattleUIMediator:ShowSimulationView()
	self._simulationBuffCountView:SetActive(true)

	return
end

function BattleUIMediator:ShowPauseButton(arg_45_1)
	setActive(self._ui._tf:Find("PauseBtn"), arg_45_1)

	return
end

function BattleUIMediator:ShowDodgemScoreBar()
	self:InitScoreBar()
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_DODGEM_SCORE, self.onUpdateDodgemScore)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_DODGEM_COMBO, self.onUpdateDodgemCombo)
	self._scoreBarView:UpdateScore(0)
	self._scoreBarView:SetActive(true)

	return
end

function BattleUIMediator:ShowAirFightScoreBar()
	self:InitAirFightScoreBar()
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_DODGEM_SCORE, self.onUpdateDodgemScore)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_DODGEM_COMBO, self.onUpdateDodgemCombo)
	self._scoreBarView:UpdateScore(0)
	self._scoreBarView:SetActive(true)

	return
end

function BattleUIMediator:ScaleUISpeed(arg_48_1)
	local var_48_0 = self._ui._tf:Find("AutoBtn/on"):GetComponent(typeof(Animation))

	if var_48_0 then
		var_48_0:get_Item("autobtn_toOn").speed = arg_48_1
	end

	local var_48_1 = self._ui._tf:Find("AutoBtn/off"):GetComponent(typeof(Animation))

	if var_48_1 then
		var_48_1:get_Item("autobtn_toOff").speed = arg_48_1
	end

	return
end

function BattleUIMediator:onStageInit(arg_49_1)
	self:InitJoystick()
	self:InitScene()
	self:InitTimer()
	self:InitEnemyHpBar()
	self:InitAirStrikeIcon()
	self:InitCommonWarning()
	self:InitAutoBtn()
	self:InitMainDamagedView()

	return
end

function BattleUIMediator:onEnemyHit(arg_50_1)
	if arg_50_1.Data:GetDiveInvisible() and not arg_50_1.Data:GetDiveDetected() then
		return
	end

	local var_50_0 = self._enemyHpBar:GetCurrentTarget()

	if var_50_0 then
		if var_50_0 ~= arg_50_1.Data then
			self._enemyHpBar:SwitchTarget(arg_50_1.Data, self._dataProxy:GetUnitList())
		end
	else
		self._enemyHpBar:SwitchTarget(arg_50_1.Data, self._dataProxy:GetUnitList())
	end

	return
end

function BattleUIMediator:onEnemyHpUpdate(arg_51_1)
	if arg_51_1.Dispatcher == self._enemyHpBar:GetCurrentTarget() and (not arg_51_1.Dispatcher:GetDiveInvisible() or arg_51_1.Dispatcher:GetDiveDetected()) then
		self._enemyHpBar:UpdateHpBar()
	end

	return
end

function BattleUIMediator:onPlayerMainUnitHpUpdate(arg_52_1)
	if arg_52_1.Data.dHP < 0 then
		self._mainDamagedView:Play()
	end

	return
end

function BattleUIMediator:onSkillFloat(arg_53_1)
	if arg_53_1.Data.coverHrzIcon then
		self:ShowSkillFloatCover(arg_53_1.Dispatcher, arg_53_1.Data.skillName, arg_53_1.Data.coverHrzIcon)
	else
		self:ShowSkillFloat(arg_53_1.Dispatcher, arg_53_1.Data.skillName, arg_53_1.Data.commander)
	end

	return
end

function BattleUIMediator:onCommonInit(arg_54_1)
	self._skillView = var_0_0.Battle.BattleSkillView.New(self, arg_54_1.Data)
	self._updateViewList[self._skillView] = true
	self._userFleet = self._dataProxy:GetFleetByIFF(var_0_5.FRIENDLY_CODE)

	self._userFleet:RegisterEventListener(self, var_0_1.SHOW_BUFFER, self.onShowBuffer)
	self._userFleet:RegisterEventListener(self, var_0_2.POINT_HIT_CHARGE, self.onPointHitSight)
	self._userFleet:RegisterEventListener(self, var_0_2.POINT_HIT_CANCEL, self.onPointHitSight)
	self._userFleet:RegisterEventListener(self, var_0_1.MANUAL_SUBMARINE_SHIFT, self.onManualSubShift)
	self._userFleet:RegisterEventListener(self, var_0_1.FLEET_BLIND, self.onFleetBlind)
	self._userFleet:RegisterEventListener(self, var_0_1.UPDATE_FLEET_ATTR, self.onFleetAttrUpdate)

	self._sightView = var_0_0.Battle.BattleOpticalSightView.New(self._ui._tf:Find("ChargeAreaContainer"))

	self._sightView:SetFleetVO(self._userFleet)

	local var_54_0, var_54_1, var_54_2, var_54_3 = self._dataProxy:GetTotalBounds()

	self._sightView:SetAreaBound(var_54_2, var_54_3)

	local var_54_4
	local var_54_5

	if self._dataProxy:GetInitData().ChapterBuffIDs then
		for iter_54_0, iter_54_1 in ipairs(self._dataProxy:GetInitData().ChapterBuffIDs) do
			if iter_54_1 == 9727 then
				var_54_4 = true

				break
			end
		end
	end

	if #self._dataProxy:GetFleetByIFF(var_0_5.FRIENDLY_CODE):GetSupportUnitList() > 0 then
		var_54_5 = true
	end

	if var_54_5 and not var_54_4 then
		self._airAdavantageTF = self._airSupportTF:Find("player_advantage")
	elseif var_54_4 and not var_54_5 then
		self._airAdavantageTF = self._airSupportTF:Find("enemy_advantage")
	elseif var_54_4 and var_54_5 then
		self._airAdavantageTF = self._airSupportTF:Find("draw")
	end

	return
end

function BattleUIMediator:onAddFleet(arg_55_1)
	if PlayerPrefs.GetInt(BATTLE_EXPOSE_LINE, 1) == 1 then
		self:SetFleetCloakLine(arg_55_1.Data.fleetVO)
	end

	return
end

function BattleUIMediator:SetFleetCloakLine(arg_56_1)
	if #arg_56_1:GetCloakList() > 0 then
		self._seaView:SetExposeLine(arg_56_1:GetIFF(), arg_56_1:GetFleetVisionLine(), (arg_56_1:GetFleetExposeLine()))
	end

	return
end

function BattleUIMediator:onAddUnit(arg_57_1)
	local var_57_0 = arg_57_1.Data.type
	local var_57_1 = arg_57_1.Data.unit

	if arg_57_1.Data.type == var_0_3.UnitType.PLAYER_UNIT or var_57_0 == var_0_3.UnitType.ENEMY_UNIT or var_57_0 == var_0_3.UnitType.BOSS_UNIT then
		self:registerUnitEvent(var_57_1)
	end

	if var_57_1:IsBoss() and self._dataProxy:GetActiveBossCount() == 1 then
		self:AddBossWarningUI()
	elseif var_57_0 == var_0_3.UnitType.ENEMY_UNIT then
		self:registerNPCUnitEvent(var_57_1)
	elseif var_57_0 == var_0_3.UnitType.PLAYER_UNIT and var_57_1:IsMainFleetUnit() and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		self:registerPlayerMainUnitEvent(var_57_1)
	end

	local var_57_2 = var_57_1:GetTemplate().nationality

	if table.contains(var_0_5.ALCHEMIST_AP_UI, var_57_2) and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		self:InitAlchemistAPView()
	end

	if table.contains(var_0_5.YUMIA_MANA_UI, var_57_2) and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		self:InitAlchemistManaView()
	end

	return
end

function BattleUIMediator:onSubmarineDetected(arg_58_1)
	if self._enemyHpBar:GetCurrentTarget() and self._enemyHpBar:GetCurrentTarget() == arg_58_1.Dispatcher and arg_58_1.Dispatcher:GetDiveDetected() == false then
		self._enemyHpBar:RemoveUnit()
	end

	return
end

function BattleUIMediator:onRemoveUnit(arg_59_1)
	local var_59_0 = arg_59_1.Data.unit
	local var_59_1 = arg_59_1.Data.type

	if arg_59_1.Data.type == var_0_3.UnitType.PLAYER_UNIT or var_59_1 == var_0_3.UnitType.ENEMY_UNIT or var_59_1 == var_0_3.UnitType.BOSS_UNIT then
		self:unregisterUnitEvent(var_59_0)
	end

	if var_59_1 == var_0_3.UnitType.ENEMY_UNIT and not var_59_0:IsBoss() then
		self:unregisterNPCUnitEvent(var_59_0)
	elseif var_59_0:GetIFF() == var_0_5.FRIENDLY_CODE and var_59_0:IsMainFleetUnit() then
		self:unregisterPlayerMainUnitEvent(var_59_0)
	end

	if arg_59_1.Data.deadReason == var_0_3.UnitDeathReason.LEAVE and self._enemyHpBar:GetCurrentTarget() and self._enemyHpBar:GetCurrentTarget() == arg_59_1.Data.unit then
		self._enemyHpBar:RemoveUnit(arg_59_1.Data.deadReason)
	end

	return
end

function BattleUIMediator:onUpdateCountDown(arg_60_1)
	self._timerView:SetCountDownText(self._dataProxy:GetCountDown())

	return
end

function BattleUIMediator:onUpdateDodgemScore(arg_61_1)
	self._scoreBarView:UpdateScore(arg_61_1.Data.totalScore)

	return
end

function BattleUIMediator:onUpdateDodgemCombo(arg_62_1)
	self._scoreBarView:UpdateCombo(arg_62_1.Data.combo)

	return
end

function BattleUIMediator:onAddAirStrike(arg_63_1)
	self._airStrikeView:AppendIcon(arg_63_1.Data.index, (self._dataProxy:GetAirFighterInfo(arg_63_1.Data.index)))

	return
end

function BattleUIMediator:onRemoveAirStrike(arg_64_1)
	self._airStrikeView:RemoveIcon(arg_64_1.Data.index, (self._dataProxy:GetAirFighterInfo(arg_64_1.Data.index)))

	return
end

function BattleUIMediator:onUpdateAirSupportLabel(arg_65_1)
	local var_65_0 = 0

	for iter_65_0, iter_65_1 in ipairs((self._dataProxy:GetAirFighterList())) do
		var_65_0 = var_65_0 + iter_65_1.totalNumber
	end

	if var_65_0 == 0 or self._warningView:GetCount() > 0 then
		eachChild(self._airSupportTF, function(arg_66_0)
			setActive(arg_66_0, false)

			return
		end)
	elseif self._airAdavantageTF then
		setActive(self._airAdavantageTF, true)
	end

	return
end

function BattleUIMediator:onUpdateHostileSubmarine(arg_67_1)
	self._warningView:UpdateHostileSubmarineCount((self._dataProxy:GetEnemySubmarineCount()))
	self:onUpdateAirSupportLabel()

	return
end

function BattleUIMediator:onUpdateEnvironmentWarning(arg_68_1)
	if arg_68_1.Data.isActive then
		self._warningView:ActiveWarning(self._warningView.WARNING_TYPE_ARTILLERY)
	else
		self._warningView:DeactiveWarning(self._warningView.WARNING_TYPE_ARTILLERY)
	end

	return
end

function BattleUIMediator:onCameraFocus(arg_69_1)
	if arg_69_1.Data.unit ~= nil then
		local var_69_0 = arg_69_1.Data.skill or false

		self:EnableComponent(false)
		self:EnableSkillFloat(var_69_0)
	else
		LeanTween.delayedCall(self._ui._go, arg_69_1.Data.duration + arg_69_1.Data.extraBulletTime, System.Action(function()
			self:EnableComponent(true)
			self:EnableSkillFloat(true)

			return
		end))
	end

	return
end

function BattleUIMediator:onShowPainting(arg_71_1)
	self:ShowSkillPainting(arg_71_1.Data.caster, arg_71_1.Data.skill, arg_71_1.Data.speed)

	return
end

function BattleUIMediator:onBulletTime(arg_72_1)
	if arg_72_1.Data.rate then
		var_0_4.AppendMapFactor(arg_72_1.Data.key, arg_72_1.Data.rate)
	else
		var_0_4.RemoveMapFactor(arg_72_1.Data.key)
	end

	self._seaView:UpdateSpeedScaler()

	return
end

function BattleUIMediator:onShowBuffer(arg_73_1)
	self._seaView:UpdateBufferAlpha(arg_73_1.Data.dist)

	return
end

function BattleUIMediator:onManualSubShift(arg_74_1)
	self._skillView:ShiftSubmarineManualButton(arg_74_1.Data.state)

	return
end

function BattleUIMediator:onPointHitSight(arg_75_1)
	if arg_75_1.ID == var_0_2.POINT_HIT_CHARGE then
		self._sightView:SetActive(true)

		self._updateViewList[self._sightView] = true
	elseif arg_75_1.ID == var_0_2.POINT_HIT_CANCEL then
		self._sightView:SetActive(false)

		self._updateViewList[self._sightView] = nil
	end

	return
end

function BattleUIMediator:onFleetBlind(arg_76_1)
	if not self._inkView then
		self:InitInkView(arg_76_1.Dispatcher)
	end

	if arg_76_1.Data.isBlind then
		self._inkView:SetActive(true, (arg_76_1.Dispatcher:GetUnitList()))
		self._skillView:HideSkillButton(true)

		self._updateViewList[self._inkView] = true
	else
		self._inkView:SetActive(false)
		self._skillView:HideSkillButton(false)

		self._updateViewList[self._inkView] = nil
	end

	return
end

function BattleUIMediator:onFleetHorizonUpdate(arg_77_1)
	if not self._inkView then
		return
	end

	self._inkView:UpdateHollow((arg_77_1.Dispatcher:GetUnitList()))

	return
end

function BattleUIMediator:onFleetAttrUpdate(arg_78_1)
	if self._alchemistAP and arg_78_1.Data.attr == self._alchemistAP:GetAttrName() then
		self._alchemistAP:UpdateAP(arg_78_1.Data.value)
	end

	if self._alchemistMana and arg_78_1.Data.attr == self._alchemistMana:GetAttrName() then
		self._alchemistMana:UpdateMana(arg_78_1.Data.value)
	end

	return
end

function BattleUIMediator:OnAddUIFX(arg_79_1)
	self:AddUIFX(arg_79_1.Data.orderDiff, arg_79_1.Data.FXID, arg_79_1.Data.position, arg_79_1.Data.localScale)

	return
end

function BattleUIMediator:AddUIFX(arg_80_1, arg_80_2, arg_80_3, arg_80_4)
	local var_80_0 = self._fxPool:GetFX(arg_80_2)

	arg_80_1 = arg_80_1 or 1

	local var_80_2 = self._ui:AddUIFX(var_80_0, arg_80_1)

	arg_80_4 = arg_80_4 or 1
	var_80_0.transform.localScale = Vector3(arg_80_4 / var_80_2.x, arg_80_4 / var_80_2.y, arg_80_4 / var_80_2.z)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_80_0, arg_80_3, true)

	return
end

function BattleUIMediator:AddBossWarningUI()
	self._dataProxy:BlockManualCast(true)

	local var_81_0 = var_0_0.Battle.BattleResourceManager.GetInstance()

	self._appearEffect = var_81_0:InstBossWarningUI()

	local var_81_1 = self._appearEffect:GetComponent(typeof(Animator))

	self._state:SetTakeoverProcess({
		Pause = function()
			var_81_1.speed = 0

			return
		end,
		Resume = function()
			var_81_1.speed = 1

			return
		end
	})

	var_81_1.speed = 1 / self._state:GetTimeScaleRate()

	setParent(self._appearEffect, self._ui.uiCanvas, false)
	self._appearEffect:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_84_0)
		self._userFleet:CoupleEncourage()
		self._dataProxy:BlockManualCast(false)
		self._state:ClearTakeoverProcess()
		var_81_0:DestroyOb(self._appearEffect)

		self._appearEffect = nil

		return
	end)
	SetActive(self._appearEffect, true)

	return
end

function BattleUIMediator:OnHideButtons(arg_85_1)
	self._skillView:HideSkillButton(not arg_85_1.Data.isActive)
	SetActive(self._autoBtn.transform, arg_85_1.Data.isActive)

	return
end

function BattleUIMediator:onEditCustomWarning(arg_86_1)
	self._warningView:EditCustomWarning(arg_86_1.Data.labelData)

	return
end

function BattleUIMediator:onGridmanSkillFloat(arg_87_1)
	if not self._gridmanSkillFloat then
		local var_87_0 = var_0_0.Battle.BattleResourceManager.GetInstance():InstGridmanSkillUI()

		self._gridmanSkillFloat = var_0_0.Battle.BattleGridmanSkillFloatView.New(var_87_0)

		setParent(var_87_0, self._ui.uiCanvas, false)
	end

	local var_87_1 = arg_87_1.Data.IFF

	if arg_87_1.Data.type == 5 then
		self._gridmanSkillFloat:DoFusionFloat(var_87_1)
	else
		self._gridmanSkillFloat:DoSkillFloat(arg_87_1.Data.type, var_87_1)
	end

	return
end

function BattleUIMediator:registerUnitEvent(arg_88_1)
	arg_88_1:RegisterEventListener(self, var_0_2.SKILL_FLOAT, self.onSkillFloat)
	arg_88_1:RegisterEventListener(self, var_0_2.CUT_INT, self.onShowPainting)

	return
end

function BattleUIMediator:registerNPCUnitEvent(arg_89_1)
	arg_89_1:RegisterEventListener(self, var_0_2.UPDATE_HP, self.onEnemyHpUpdate)

	if table.contains(ShipType.SubShipType, arg_89_1:GetTemplate().type) then
		arg_89_1:RegisterEventListener(self, var_0_2.SUBMARINE_DETECTED, self.onSubmarineDetected)
	end

	return
end

function BattleUIMediator:registerPlayerMainUnitEvent(arg_90_1)
	arg_90_1:RegisterEventListener(self, var_0_2.UPDATE_HP, self.onPlayerMainUnitHpUpdate)

	return
end

function BattleUIMediator:unregisterUnitEvent(arg_91_1)
	arg_91_1:UnregisterEventListener(self, var_0_2.SKILL_FLOAT)
	arg_91_1:UnregisterEventListener(self, var_0_2.CUT_INT)

	return
end

function BattleUIMediator:unregisterNPCUnitEvent(arg_92_1)
	arg_92_1:UnregisterEventListener(self, var_0_2.SKILL_FLOAT)
	arg_92_1:UnregisterEventListener(self, var_0_2.CUT_INT)
	arg_92_1:UnregisterEventListener(self, var_0_2.UPDATE_HP)

	if table.contains(ShipType.SubShipType, arg_92_1:GetTemplate().type) then
		arg_92_1:UnregisterEventListener(self, var_0_2.SUBMARINE_DETECTED)
	end

	return
end

function BattleUIMediator:unregisterPlayerMainUnitEvent(arg_93_1)
	arg_93_1:UnregisterEventListener(self, var_0_2.UPDATE_HP)

	return
end

function BattleUIMediator:Dispose()
	LeanTween.cancel(self._ui._go)
	self._uiMGR:ClearStick()

	self._uiMGR = nil

	if self._appearEffect then
		Destroy(self._appearEffect)
	end

	self:RemoveUIEvent()

	self._updateViewList = nil

	self._timerView:Dispose()
	self._enemyHpBar:Dispose()
	self._skillView:Dispose()
	self._seaView:Dispose()
	self._airStrikeView:Dispose()
	self._sightView:Dispose()
	self._mainDamagedView:Dispose()
	self._warningView:Dispose()

	self._seaView = nil
	self._enemyHpBar = nil
	self._skillView = nil
	self._timerView = nil
	self._joystick = nil
	self._airStrikeView = nil
	self._warningView = nil
	self._mainDamagedView = nil

	if self._duelRateBar then
		self._duelRateBar:Dispose()

		self._duelRateBar = nil
	end

	if self._simulationBuffCountView then
		self._simulationBuffCountView:Dispose()

		self._simulationBuffCountView = nil
	end

	if self._jammingView then
		self._jammingView:Dispose()

		self._jammingView = nil
	end

	if self._inkView then
		self._inkView:Dispose()

		self._inkView = nil
	end

	if self._alchemistAP then
		self._alchemistAP:Dispose()

		self._alchemistAP = nil
	end

	if self._alchemistMana then
		self._alchemistMana:Dispose()

		self._alchemistMana = nil
	end

	if self._gridmanSkillFloat then
		self._gridmanSkillFloat:Dispose()
	end

	if go(self._ui._tf:Find("CardPuzzleConsole")).activeSelf then
		self:DisposeCardPuzzleComponent()
	end

	BattleUIMediator.super.Dispose(self)

	return
end

function BattleUIMediator:OnCardPuzzleInit(arg_95_1)
	self._cardPuzzleComponent = self._dataProxy:GetFleetByIFF(var_0_5.FRIENDLY_CODE):GetCardPuzzleComponent()

	self:ShowCardPuzzleComponent()
	self:RegisterCardPuzzleEvent()

	return
end

function BattleUIMediator:RegisterCardPuzzleEvent()
	self._cardPuzzleComponent:RegisterEventListener(self, var_0_6.UPDATE_FLEET_SHIP, self.onUpdateFleetShip)
	self._cardPuzzleComponent:RegisterEventListener(self, var_0_6.COMMON_BUTTON_ENABLE, self.onBlockCommonButton)
	self._cardPuzzleComponent:RegisterEventListener(self, var_0_6.LONG_PRESS_BULLET_TIME, self.onLongPressBulletTime)
	self._cardPuzzleComponent:RegisterEventListener(self, var_0_6.SHOW_CARD_DETAIL, self.onShowCardDetail)

	return
end

function BattleUIMediator:ShowCardPuzzleComponent()
	setActive(self._ui._tf:Find("CardPuzzleConsole"), true)
	self:InitCardPuzzleCommonHPBar()
	self:InitCardPuzzleEnergyBar()
	self:IntCardPuzzleFleetHead()
	self:InitCameraCardBoardClicker()
	self:InitCardPuzzleMovePile()
	self:InitCardPuzzleDeckPile()
	self:InitCardPuzzleIconList()
	self:InitCardPuzzleHandBoard()
	self:InitCardPuzzleCardDetail()
	self:InitCardPuzzleGoalRemind()

	return
end

function BattleUIMediator:InitCardPuzzleCommonHPBar()
	self._cardPuzzleHPBar = var_0_0.Battle.CardPuzzleCommonHPBar.New(self._ui._tf:Find("CardPuzzleConsole/commonHP"))

	self._cardPuzzleHPBar:SetCardPuzzleComponent(self._cardPuzzleComponent)

	self._updateViewList[self._cardPuzzleHPBar] = true

	return
end

function BattleUIMediator:InitCardPuzzleEnergyBar()
	self._cardPuzzleEnergyBar = var_0_0.Battle.CardPuzzleEnergyBar.New(self._ui._tf:Find("CardPuzzleConsole/energy_block"))

	self._cardPuzzleEnergyBar:SetCardPuzzleComponent(self._cardPuzzleComponent)

	self._updateViewList[self._cardPuzzleEnergyBar] = true

	return
end

function BattleUIMediator:InitCameraCardBoardClicker()
	self._cardPuzzleBoardClicker = var_0_0.Battle.CardPuzzleBoardClicker.New(self._ui._tf:Find("CardBoardController"))

	self._cardPuzzleBoardClicker:SetCardPuzzleComponent(self._cardPuzzleComponent)

	return
end

function BattleUIMediator:IntCardPuzzleFleetHead()
	self._cardPuzzleFleetHead = var_0_0.Battle.CardPuzzleFleetHead.New(self._ui._tf:Find("CardPuzzleConsole/fleet"))

	self._cardPuzzleFleetHead:SetCardPuzzleComponent(self._cardPuzzleComponent)

	return
end

function BattleUIMediator:InitCardPuzzleMovePile()
	self._cardPuzzleMovePile = var_0_0.Battle.CardPuzzleMovePile.New(self._ui._tf:Find("CardPuzzleConsole/movedeck"))

	self._cardPuzzleMovePile:SetCardPuzzleComponent(self._cardPuzzleComponent)

	self._updateViewList[self._cardPuzzleMovePile] = true

	return
end

function BattleUIMediator:InitCardPuzzleDeckPile()
	self._cardPuzzleDeckPile = var_0_0.Battle.CardPuzzleDeckPool.New(self._ui._tf:Find("CardPuzzleConsole/deck"))

	self._cardPuzzleDeckPile:SetCardPuzzleComponent(self._cardPuzzleComponent)

	return
end

function BattleUIMediator:InitCardPuzzleIconList()
	self._cardPuzzleStatusIcon = var_0_0.Battle.CardPuzzleFleetIconList.New(self._ui._tf:Find("CardPuzzleConsole/statusIcon"))

	self._cardPuzzleStatusIcon:SetCardPuzzleComponent(self._cardPuzzleComponent)

	self._updateViewList[self._cardPuzzleStatusIcon] = true

	return
end

function BattleUIMediator:InitCardPuzzleHandBoard()
	self._cardPuzzleHandBoard = var_0_0.Battle.CardPuzzleHandBoard.New(self._ui._tf:Find("CardPuzzleConsole/cardboard"), self._ui._tf:Find("CardPuzzleConsole/hand"))

	self._cardPuzzleHandBoard:SetCardPuzzleComponent(self._cardPuzzleComponent)

	self._updateViewList[self._cardPuzzleHandBoard] = true

	return
end

function BattleUIMediator:InitCardPuzzleGoalRemind()
	self._cardPuzzleGoalRemind = var_0_0.Battle.CardPuzzleGoalRemind.New(self._ui._tf:Find("CardPuzzleConsole/goal"))

	self._cardPuzzleGoalRemind:SetCardPuzzleComponent(self._cardPuzzleComponent)

	return
end

function BattleUIMediator:InitCardPuzzleCardDetail()
	self._cardPuzzleCardDetail = var_0_0.Battle.CardPuzzleCardDetail.New(self._ui._tf:Find("CardPuzzleConsole/cardDetail"))

	return
end

function BattleUIMediator:DisposeCardPuzzleComponent()
	self._cardPuzzleHPBar:Dispose()
	self._cardPuzzleEnergyBar:Dispose()
	self._cardPuzzleBoardClicker:Dispose()
	self._cardPuzzleFleetHead:Dispose()
	self._cardPuzzleMovePile:Dispose()
	self._cardPuzzleDeckPile:Dispose()
	self._cardPuzzleStatusIcon:Dispose()
	self._cardPuzzleHandBoard:Dispose()
	self._cardPuzzleGoalRemind:Dispose()
	self._cardPuzzleCardDetail:Dispose()

	return
end

function BattleUIMediator:onUpdateFleetBuff()
	return
end

function BattleUIMediator:onUpdateFleetShip(arg_110_1)
	self._cardPuzzleFleetHead:UpdateShipIcon(arg_110_1.Data.teamType)

	return
end

function BattleUIMediator:onBlockCommonButton(arg_111_1)
	self:EnableComponent(arg_111_1.Data.flag)

	return
end

function BattleUIMediator:onLongPressBulletTime(arg_112_1)
	self._state:ScaleTimer(arg_112_1.Data.timeScale)

	return
end

function BattleUIMediator:onShowCardDetail(arg_113_1)
	if arg_113_1.Data.card then
		self._cardPuzzleCardDetail:Active(true)
		self._cardPuzzleCardDetail:SetReferenceCard(arg_113_1.Data.card)
	else
		self._cardPuzzleCardDetail:Active(false)
	end

	return
end

return
