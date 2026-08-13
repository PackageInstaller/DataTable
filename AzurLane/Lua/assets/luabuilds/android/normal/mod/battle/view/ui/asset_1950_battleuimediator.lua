ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleVariable
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleCardPuzzleEvent

class = var_0_10007

local var_0_7 = var_0_10007("BattleUIMediator", var_0.MVC.Mediator)

var_0.Battle.BattleUIMediator = var_0_7
var_0_7.__name = "BattleUIMediator"

function var_0_7.Ctor(arg_1_0)
	var_0_7.super.Ctor(arg_1_0)

	return
end

function var_0_7.SetBattleUI(arg_2_0)
	local var_2_0 = arg_2_0._state

	arg_2_0._ui = var_1.GetUI(var_2_0)

	return
end

function var_0_7.Initialize(arg_3_0)
	var_0_7.super.Initialize(arg_3_0)

	local var_3_0 = arg_3_0._state

	arg_3_0._dataProxy = var_1.GetProxyByName(var_3_0, var_0.Battle.BattleDataProxy.__name)
	pg = var_1
	arg_3_0._uiMGR = var_1.UIMgr.GetInstance()
	arg_3_0._fxPool = var_0.Battle.BattleFXPool.GetInstance()
	arg_3_0._updateViewList = {}

	arg_3_0:SetBattleUI()
	arg_3_0:AddUIEvent()
	arg_3_0:InitCamera()
	arg_3_0:InitGuide()

	return
end

function var_0_7.Reinitialize(arg_4_0)
	local var_4_0 = arg_4_0._skillView

	var_1.Dispose(var_4_0)

	return
end

function var_0_7.EnableComponent(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._ui._tf
	local var_5_1 = var_2.Find(var_5_0, "PauseBtn")
	local var_5_2 = var_2.GetComponent

	typeof = var_4
	Button = var_1_10005
	var_5_2(var_5_1, var_4(var_1_10005)).enabled = arg_5_1

	local var_5_3 = arg_5_0._skillView

	var_2.EnableWeaponButton(var_5_3, arg_5_1)

	return
end

function var_0_7.EnableJoystick(arg_6_0, arg_6_1)
	arg_6_0._stickController.enabled = arg_6_1

	local var_6_0 = arg_6_0._joystick
	local var_6_1 = var_2.GetComponent

	typeof = var_1_10004
	Animation = var_1_10005

	if var_6_1(var_6_0, var_1_10004(var_1_10005)) then
		var_2.enabled = arg_6_1
	end

	local var_6_2 = arg_6_0._joystick
	local var_6_3 = var_3.GetComponent

	typeof = var_1_10005
	Animator = var_1_10006

	if var_6_3(var_6_2, var_1_10005(var_1_10006)) then
		var_3.enabled = arg_6_1
	end

	setActive = var_6_2

	var_6_2(arg_6_0._joystick, arg_6_1)

	local var_6_4 = arg_6_0._joystick

	if var_4.Find(var_6_4, "Area/BG/spine") then
		local var_6_5 = var_4
		local var_6_6 = var_4.GetComponent

		typeof = var_1_10007
		SpineAnimUI = var_1_10008

		local var_6_7 = var_6_6(var_6_5, var_1_10007(var_1_10008))

		if arg_6_1 then
			var_6_7:SetAction("cut_in", 0)
		end
	end

	return
end

function var_0_7.EnableWeaponButton(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._skillView

	var_2.EnableWeaponButton(var_7_0, arg_7_1)

	return
end

function var_0_7.EnableSkillFloat(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._ui

	var_2.EnableSkillFloat(var_8_0, arg_8_1)

	return
end

function var_0_7.GetAppearFX(arg_9_0)
	return arg_9_0._appearEffect
end

function var_0_7.DisableComponent(arg_10_0)
	local var_10_0 = arg_10_0._ui._tf
	local var_10_1 = var_1.Find(var_10_0, "PauseBtn")
	local var_10_2 = var_1.GetComponent

	typeof = var_3
	Button = var_1_10004
	var_10_2(var_10_1, var_3(var_1_10004)).enabled = false

	local var_10_3 = arg_10_0._skillView

	var_1.DisableWeapnButton(var_10_3)

	SetActive = var_1

	local var_10_4 = arg_10_0._ui._tf

	var_1(var_2.Find(var_10_4, "HPBarContainer"), false)

	SetActive = var_1

	local var_10_5 = arg_10_0._ui._tf

	var_1(var_2.Find(var_10_5, "flagShipMark"), false)

	if arg_10_0._jammingView then
		local var_10_6 = arg_10_0._jammingView

		var_1.Eliminate(var_10_6, false)
	end

	if arg_10_0._inkView then
		local var_10_7 = arg_10_0._inkView

		var_1.SetActive(var_10_7, false)
	end

	return
end

function var_0_7.ActiveDebugConsole(arg_11_0)
	local var_11_0 = arg_11_0._debugConsoleView

	var_1.SetActive(var_11_0, true)

	return
end

function var_0_7.OpeningEffect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._uiMGR

	var_3.SetActive(var_12_0, false)

	SYSTEM_SUBMARINE_RUN = var_12_2

	local var_12_2, var_12_9

	if arg_12_2 == var_12_2 then
		local var_12_1 = arg_12_0._skillView

		var_12_2.SubmarineButton(var_12_1)

		var_12_2 = var_0_5.JOY_STICK_DEFAULT_PREFERENCE

		local var_12_3 = arg_12_0._joystick

		Vector2 = var_12_9
		var_12_3.anchorMin = var_12_9(var_12_2.x, var_12_2.y)

		local var_12_4 = arg_12_0._joystick

		Vector2 = var_12_9
		var_12_4.anchorMax = var_12_9(var_12_2.x, var_12_2.y)
	else
		SYSTEM_SUB_ROUTINE = var_12_2

		if arg_12_2 == var_12_2 then
			local var_12_5 = arg_12_0._skillView

			var_12_2.SubRoutineButton(var_12_5)
		else
			SYSTEM_AIRFIGHT = var_12_2

			if arg_12_2 == var_12_2 then
				local var_12_6 = arg_12_0._skillView

				var_12_2.AirFightButton(var_12_6)
			else
				SYSTEM_DEBUG = var_12_2

				if arg_12_2 == var_12_2 then
					local var_12_7 = arg_12_0._skillView

					var_12_2.NormalButton(var_12_7)
				else
					SYSTEM_CARDPUZZLE = var_12_2

					if arg_12_2 == var_12_2 then
						local var_12_8 = arg_12_0._skillView

						var_12_2.CardPuzzleButton(var_12_8)
					else
						pg = var_12_2

						if var_12_2.SeriesGuideMgr.GetInstance().currIndex then
							var_12_9 = var_12_2

							if var_12_2.isEnd(var_12_9) then
								var_12_9 = arg_12_0._skillView

								var_4.NormalButton(var_12_9)

								goto label_12_0
							end
						end

						var_12_9 = arg_12_0._dataProxy

						local var_12_10

						if not var_4.GetDungeonData(var_12_9).skill_hide then
							var_12_10 = {}
						end

						local var_12_11 = arg_12_0._skillView

						var_12_9.CustomButton(var_12_11, var_12_10)
					end
				end
			end
		end
	end

	::label_12_0::

	LeanTween = var_12_2

	local var_12_12 = var_12_2.delayedCall
	local var_12_13 = var_0_5.COMBAT_DELAY_ACTIVE

	System = var_12_9

	var_12_12(var_12_13, var_12_9.Action(function()
		local var_13_0 = arg_12_0._uiMGR

		var_0.SetActive(var_13_0, true)

		local var_13_1 = arg_12_0

		var_0.EnableComponent(var_13_1, true)

		if arg_12_1 then
			arg_12_1()
		end

		return
	end))

	SetActive = var_12_12

	var_12_12(arg_12_0._ui._go, true)

	local var_12_14 = arg_12_0._skillView

	var_3.ButtonInitialAnima(var_12_14)

	return
end

function var_0_7.InitScene(arg_14_0)
	arg_14_0._mapId = arg_14_0._dataProxy._mapId
	arg_14_0._seaView = var_0.Battle.BattleMap.New(arg_14_0._mapId)

	return
end

function var_0_7.InitJoystick(arg_15_0)
	local var_15_0 = arg_15_0._ui._tf

	arg_15_0._joystick = var_1.Find(var_15_0, "Stick")

	local var_15_1 = var_0_5.JOY_STICK_DEFAULT_PREFERENCE
	local var_15_2 = arg_15_0._joystick
	local var_15_3 = 1

	PlayerPrefs = var_1_10004

	local var_15_4 = var_1_10004.GetFloat("joystick_scale", var_15_1.scale)

	PlayerPrefs = var_5

	local var_15_5 = var_5.GetFloat("joystick_anchorX", var_15_1.x)

	PlayerPrefs = var_6

	local var_15_6 = var_6.GetFloat("joystick_anchorY", var_15_1.y)
	local var_15_7 = var_15_3 * var_15_4
	local var_15_8 = arg_15_0._joystick

	Vector3 = var_8
	var_15_8.localScale = var_8(var_15_7, var_15_7, 1)
	originalPrint = var_15_8

	var_15_8("scale: ", arg_15_0._joystick.localScale)

	var_15_2.anchoredPosition = var_15_2.anchoredPosition * var_15_7

	local var_15_9 = arg_15_0._joystick

	Vector2 = var_8
	var_15_9.anchorMin = var_8(var_15_5, var_15_6)

	local var_15_10 = arg_15_0._joystick

	Vector2 = var_8
	var_15_10.anchorMax = var_8(var_15_5, var_15_6)

	local var_15_11 = arg_15_0._joystick

	arg_15_0._stickController = var_7.GetComponent(var_15_11, "StickController")

	local var_15_12 = arg_15_0._uiMGR

	var_7.AttachStickOb(var_15_12, arg_15_0._joystick)

	local var_15_13 = arg_15_0._joystick

	if var_7.Find(var_15_13, "Area/BG/spine") then
		local var_15_14 = var_7
		local var_15_15 = var_7.GetComponent

		typeof = var_10
		SpineAnimUI = var_11

		local var_15_16 = var_15_15(var_15_14, var_10(var_11))

		var_8.SetActionCallBack(var_15_16, function(arg_16_0)
			if arg_16_0 == "finish" then
				if arg_15_0._stickController.enabled then
					local var_16_0 = var_0

					var_1.SetAction(var_16_0, "normal", 0)
				else
					SetActive = var_1

					var_1(arg_15_0._joystick, false)
				end
			end

			return
		end)
	end

	return
end

function var_0_7.InitTimer(arg_17_0)
	local var_17_0 = arg_17_0._dataProxy
	local var_17_1 = var_1.GetInitData(var_17_0).battleType

	SYSTEM_DUEL = var_17_0

	if var_17_1 == var_17_0 then
		local var_17_2 = var_0.Battle.BattleTimerView.New
		local var_17_3 = arg_17_0._ui._tf

		arg_17_0._timerView = var_17_2(var_3.Find(var_17_3, "DuelTimer"))
	else
		local var_17_4 = var_0.Battle.BattleTimerView.New
		local var_17_5 = arg_17_0._ui._tf

		arg_17_0._timerView = var_17_4(var_3.Find(var_17_5, "Timer"))
	end

	return
end

function var_0_7.InitEnemyHpBar(arg_18_0)
	local var_18_0 = var_0.Battle.BattleEnmeyHpBarView.New
	local var_18_1 = arg_18_0._ui._tf

	arg_18_0._enemyHpBar = var_18_0(var_2.Find(var_18_1, "EnemyHPBar"))

	return
end

function var_0_7.InitAirStrikeIcon(arg_19_0)
	local var_19_0 = var_0.Battle.BattleAirStrikeIconView.New
	local var_19_1 = arg_19_0._ui._tf

	arg_19_0._airStrikeView = var_19_0(var_2.Find(var_19_1, "AirFighterContainer/AirStrikeIcon"))

	local var_19_2 = arg_19_0._ui._tf

	arg_19_0._airSupportTF = var_1.Find(var_19_2, "AirSupportLabel")

	return
end

function var_0_7.InitCommonWarning(arg_20_0)
	local var_20_0 = var_0.Battle.BattleCommonWarningView.New
	local var_20_1 = arg_20_0._ui._tf

	arg_20_0._warningView = var_20_0(var_2.Find(var_20_1, "WarningView"))
	arg_20_0._updateViewList[arg_20_0._warningView] = true

	return
end

function var_0_7.InitScoreBar(arg_21_0)
	local var_21_0 = var_0.Battle.BattleScoreBarView.New
	local var_21_1 = arg_21_0._ui._tf

	arg_21_0._scoreBarView = var_21_0(var_2.Find(var_21_1, "DodgemCountBar"))

	return
end

function var_0_7.InitAirFightScoreBar(arg_22_0)
	local var_22_0 = var_0.Battle.BattleScoreBarView.New
	local var_22_1 = arg_22_0._ui._tf

	arg_22_0._scoreBarView = var_22_0(var_2.Find(var_22_1, "AirFightCountBar"))

	return
end

function var_0_7.InitAutoBtn(arg_23_0)
	local var_23_0 = arg_23_0._ui._tf

	arg_23_0._autoBtn = var_1.Find(var_23_0, "AutoBtn")

	local var_23_1 = var_0_5.AUTO_DEFAULT_PREFERENCE

	PlayerPrefs = var_23_0

	local var_23_2 = var_23_0.GetFloat("auto_scale", var_23_1.scale)

	PlayerPrefs = var_3

	local var_23_3 = var_3.GetFloat("auto_anchorX", var_23_1.x)

	PlayerPrefs = var_4

	local var_23_4 = var_4.GetFloat("auto_anchorY", var_23_1.y)
	local var_23_5 = arg_23_0._autoBtn

	Vector3 = var_6
	var_23_5.localScale = var_6(var_23_2, var_23_2, 1)

	local var_23_6 = arg_23_0._autoBtn

	Vector2 = var_6
	var_23_6.anchorMin = var_6(var_23_3, var_23_4)

	local var_23_7 = arg_23_0._autoBtn

	Vector2 = var_6
	var_23_7.anchorMax = var_6(var_23_3, var_23_4)

	return
end

function var_0_7.InitDuelRateBar(arg_24_0)
	local var_24_0 = var_0.Battle.BattleDuelDamageRateView.New
	local var_24_1 = arg_24_0._ui._tf

	arg_24_0._duelRateBar = var_24_0(var_2.Find(var_24_1, "DuelDamageRate"))

	return arg_24_0._duelRateBar
end

function var_0_7.InitSimulationBuffCounting(arg_25_0)
	local var_25_0 = var_0.Battle.BattleSimulationBuffCountView.New
	local var_25_1 = arg_25_0._ui._tf

	arg_25_0._simulationBuffCountView = var_25_0(var_2.Find(var_25_1, "SimulationWarning"))

	return arg_25_0._simulationBuffCountView
end

function var_0_7.InitMainDamagedView(arg_26_0)
	local var_26_0 = var_0.Battle.BattleMainDamagedView.New
	local var_26_1 = arg_26_0._ui._tf

	arg_26_0._mainDamagedView = var_26_0(var_2.Find(var_26_1, "HPWarning"))

	return
end

function var_0_7.InitInkView(arg_27_0, arg_27_1)
	local var_27_0 = var_0.Battle.BattleInkView.New
	local var_27_1 = arg_27_0._ui._tf

	arg_27_0._inkView = var_27_0(var_3.Find(var_27_1, "InkContainer"))

	arg_27_1:RegisterEventListener(arg_27_0, var_0_1.FLEET_HORIZON_UPDATE, arg_27_0.onFleetHorizonUpdate)

	return
end

function var_0_7.InitDebugConsole(arg_28_0)
	local var_28_2

	if not arg_28_0._debugConsoleView then
		local var_28_0 = var_0.Battle.BattleDebugConsole.New
		local var_28_1 = arg_28_0._ui._tf

		var_28_2 = var_28_0(var_2.Find(var_28_1, "Debug_Console"), arg_28_0._state)
	end

	arg_28_0._debugConsoleView = var_28_2

	return
end

function var_0_7.InitCameraGestureSlider(arg_29_0)
	local var_29_0 = var_0.Battle.BattleCameraSlider.New
	local var_29_1 = arg_29_0._ui._tf

	arg_29_0._gesture = var_29_0(var_2.Find(var_29_1, "CameraController"))

	local var_29_2 = var_0.Battle.BattleCameraUtil.GetInstance()

	var_1.SetCameraSilder(var_29_2, arg_29_0._gesture)

	local var_29_3 = arg_29_0._cameraUtil

	var_1.SwitchCameraPos(var_29_3, "FOLLOW_GESTURE")

	return
end

function var_0_7.InitAlchemistAPView(arg_30_0)
	if not arg_30_0._alchemistAP then
		local var_30_0 = var_0.Battle.BattleResourceManager.GetInstance()
		local var_30_1 = var_1.InstReisalinAPUI(var_30_0)

		setParent = var_30_0

		var_30_0(var_30_1, arg_30_0._ui.uiCanvas, false)

		local var_30_2 = var_0.Battle.BattleReisalinAPView.New
		local var_30_3 = var_30_1.transform

		arg_30_0._alchemistAP = var_30_2(var_3.Find(var_30_3, "APPanel"))
	end

	return
end

function var_0_7.InitAlchemistManaView(arg_31_0)
	if not arg_31_0._alchemistMana then
		local var_31_0 = var_0.Battle.BattleResourceManager.GetInstance()
		local var_31_1 = var_1.InstYumiaManaUI(var_31_0)

		setParent = var_31_0

		var_31_0(var_31_1, arg_31_0._ui.uiCanvas, false)

		local var_31_2 = var_0.Battle.BattleYumiaManaView.New
		local var_31_3 = var_31_1.transform

		arg_31_0._alchemistMana = var_31_2(var_3.Find(var_31_3, "ManaPanel"))
	end

	return
end

function var_0_7.InitGuide(arg_32_0)
	return
end

function var_0_7.InitCamera(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.UIMgr.GetInstance()
	local var_33_1 = var_1.GetMainCamera(var_33_0)
	local var_33_2 = var_1.GetComponent

	typeof = var_1_10003
	Camera = var_1_10004
	arg_33_0._camera = var_33_2(var_33_1, var_1_10003(var_1_10004))
	GameObject = var_1

	local var_33_3 = var_1.Find("UICamera")
	local var_33_4 = var_1.GetComponent

	typeof = var_3
	Camera = var_1_10004
	arg_33_0._uiCamera = var_33_4(var_33_3, var_3(var_1_10004))
	arg_33_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

	local var_33_5 = arg_33_0._cameraUtil

	var_1.RegisterEventListener(var_33_5, arg_33_0, var_0_1.CAMERA_FOCUS, arg_33_0.onCameraFocus)

	local var_33_6 = arg_33_0._cameraUtil

	var_1.RegisterEventListener(var_33_6, arg_33_0, var_0_1.SHOW_PAINTING, arg_33_0.onShowPainting)

	local var_33_7 = arg_33_0._cameraUtil

	var_1.RegisterEventListener(var_33_7, arg_33_0, var_0_1.BULLET_TIME, arg_33_0.onBulletTime)

	return
end

function var_0_7.Update(arg_34_0)
	pairs = var_1_10001

	for iter_34_0, iter_34_1 in var_1_10001(arg_34_0._updateViewList) do
		iter_34_0:Update()
	end

	return
end

function var_0_7.AddUIEvent(arg_35_0)
	local var_35_0 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_0, arg_35_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_35_0.onStageInit)

	local var_35_1 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_1, arg_35_0, var_0_1.COMMON_DATA_INIT_FINISH, arg_35_0.onCommonInit)

	local var_35_2 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_2, arg_35_0, var_0_1.ADD_FLEET, arg_35_0.onAddFleet)

	local var_35_3 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_3, arg_35_0, var_0_1.ADD_UNIT, arg_35_0.onAddUnit)

	local var_35_4 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_4, arg_35_0, var_0_1.REMOVE_UNIT, arg_35_0.onRemoveUnit)

	local var_35_5 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_5, arg_35_0, var_0_1.HIT_ENEMY, arg_35_0.onEnemyHit)

	local var_35_6 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_6, arg_35_0, var_0_1.ADD_AIR_FIGHTER_ICON, arg_35_0.onAddAirStrike)

	local var_35_7 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_7, arg_35_0, var_0_1.REMOVE_AIR_FIGHTER_ICON, arg_35_0.onRemoveAirStrike)

	local var_35_8 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_8, arg_35_0, var_0_1.UPDATE_AIR_SUPPORT_LABEL, arg_35_0.onUpdateAirSupportLabel)

	local var_35_9 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_9, arg_35_0, var_0_1.UPDATE_HOSTILE_SUBMARINE, arg_35_0.onUpdateHostileSubmarine)

	local var_35_10 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_10, arg_35_0, var_0_1.UPDATE_ENVIRONMENT_WARNING, arg_35_0.onUpdateEnvironmentWarning)

	local var_35_11 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_11, arg_35_0, var_0_1.UPDATE_COUNT_DOWN, arg_35_0.onUpdateCountDown)

	local var_35_12 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_12, arg_35_0, var_0_1.HIDE_INTERACTABLE_BUTTONS, arg_35_0.OnHideButtons)

	local var_35_13 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_13, arg_35_0, var_0_1.ADD_UI_FX, arg_35_0.OnAddUIFX)

	local var_35_14 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_14, arg_35_0, var_0_1.EDIT_CUSTOM_WARNING_LABEL, arg_35_0.onEditCustomWarning)

	local var_35_15 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_15, arg_35_0, var_0_1.GRIDMAN_SKILL_FLOAT, arg_35_0.onGridmanSkillFloat)

	local var_35_16 = arg_35_0._dataProxy

	var_1.RegisterEventListener(var_35_16, arg_35_0, var_0_6.CARD_PUZZLE_INIT, arg_35_0.OnCardPuzzleInit)

	return
end

function var_0_7.RemoveUIEvent(arg_36_0)
	local var_36_0 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_0, arg_36_0, var_0_1.COMMON_DATA_INIT_FINISH)

	local var_36_1 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_1, arg_36_0, var_0_1.STAGE_DATA_INIT_FINISH)

	local var_36_2 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_2, arg_36_0, var_0_1.ADD_FLEET)

	local var_36_3 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_3, arg_36_0, var_0_1.ADD_UNIT)

	local var_36_4 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_4, arg_36_0, var_0_1.REMOVE_UNIT)

	local var_36_5 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_5, arg_36_0, var_0_1.HIT_ENEMY)

	local var_36_6 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_6, arg_36_0, var_0_1.UPDATE_COUNT_DOWN)

	local var_36_7 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_7, arg_36_0, var_0_1.ADD_AIR_FIGHTER_ICON)

	local var_36_8 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_8, arg_36_0, var_0_1.REMOVE_AIR_FIGHTER_ICON)

	local var_36_9 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_9, arg_36_0, var_0_1.UPDATE_AIR_SUPPORT_LABEL)

	local var_36_10 = arg_36_0._cameraUtil

	var_1.UnregisterEventListener(var_36_10, arg_36_0, var_0_1.SHOW_PAINTING)

	local var_36_11 = arg_36_0._cameraUtil

	var_1.UnregisterEventListener(var_36_11, arg_36_0, var_0_1.CAMERA_FOCUS)

	local var_36_12 = arg_36_0._cameraUtil

	var_1.UnregisterEventListener(var_36_12, arg_36_0, var_0_1.BULLET_TIME)

	local var_36_13 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_13, arg_36_0, var_0_1.ADD_SUBMARINE_WARINING)

	local var_36_14 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_14, arg_36_0, var_0_1.REMOVE_SUBMARINE_WARINING)

	local var_36_15 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_15, arg_36_0, var_0_1.UPDATE_DODGEM_SCORE)

	local var_36_16 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_16, arg_36_0, var_0_1.UPDATE_DODGEM_COMBO)

	local var_36_17 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_17, arg_36_0, var_0_1.SHOW_BUFFER)

	local var_36_18 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_18, arg_36_0, var_0_2.POINT_HIT_CHARGE)

	local var_36_19 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_19, arg_36_0, var_0_2.POINT_HIT_CANCEL)

	local var_36_20 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_20, arg_36_0, var_0_1.MANUAL_SUBMARINE_SHIFT)

	local var_36_21 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_21, arg_36_0, var_0_1.FLEET_BLIND)

	local var_36_22 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_22, arg_36_0, var_0_1.FLEET_HORIZON_UPDATE)

	local var_36_23 = arg_36_0._userFleet

	var_1.UnregisterEventListener(var_36_23, arg_36_0, var_0_1.UPDATE_FLEET_ATTR)

	local var_36_24 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_24, arg_36_0, var_0_1.UPDATE_HOSTILE_SUBMARINE)

	local var_36_25 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_25, arg_36_0, var_0_1.UPDATE_ENVIRONMENT_WARNING)

	local var_36_26 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_26, arg_36_0, var_0_1.HIDE_INTERACTABLE_BUTTONS)

	local var_36_27 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_27, arg_36_0, var_0_1.ADD_UI_FX)

	local var_36_28 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_28, arg_36_0, var_0_1.EDIT_CUSTOM_WARNING_LABEL)

	local var_36_29 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_29, arg_36_0, var_0_1.GRIDMAN_SKILL_FLOAT)

	local var_36_30 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_30, arg_36_0, var_0_6.CARD_PUZZLE_INIT)

	local var_36_31 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_31, arg_36_0, var_0_6.UPDATE_FLEET_SHIP)

	local var_36_32 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_32, arg_36_0, var_0_6.COMMON_BUTTON_ENABLE)

	local var_36_33 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_33, arg_36_0, var_0_6.LONG_PRESS_BULLET_TIME)

	local var_36_34 = arg_36_0._dataProxy

	var_1.UnregisterEventListener(var_36_34, arg_36_0, var_0_6.SHOW_CARD_DETAIL)

	return
end

function var_0_7.ShowSkillPainting(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	arg_37_3 = arg_37_3 or 1

	local var_37_0

	if arg_37_2 then
		if arg_37_2.cutin_cover then
			var_37_0 = arg_37_2.cutin_cover
		elseif arg_37_2.cutin_cover_DAL then
			local var_37_1 = arg_37_0._ui

			var_5.CutInPaintingDAL(var_37_1, arg_37_1:GetTemplate(), arg_37_3, arg_37_1:GetIFF(), arg_37_2)

			return
		end
	end

	local var_37_2 = arg_37_0._ui

	var_5.CutInPainting(var_37_2, arg_37_1:GetTemplate(), arg_37_3, arg_37_1:GetIFF(), var_37_0)

	return
end

function var_0_7.ShowSkillFloat(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_0._ui

	var_4.SkillHrzPop(var_38_0, arg_38_2, arg_38_1, arg_38_3)

	return
end

function var_0_7.ShowSkillFloatCover(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = arg_39_0._ui

	var_4.SkillHrzPopCover(var_39_0, arg_39_2, arg_39_1, arg_39_3)

	return
end

function var_0_7.SeaSurfaceShift(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = arg_40_3 or var_0.Battle.BattleConfig.calcInterval
	local var_40_1 = arg_40_0._seaView

	var_6.ShiftSurface(var_40_1, arg_40_1, arg_40_2, var_40_0, arg_40_4)

	return
end

function var_0_7.ShowAutoBtn(arg_41_0)
	SetActive = var_1_10001

	var_1_10001(arg_41_0._autoBtn.transform, true)

	local var_41_0 = arg_41_0:GetState()
	local var_41_1 = var_1.GetBattleType(var_41_0)

	triggerToggle = var_41_0

	var_41_0(arg_41_0._autoBtn, var_0.Battle.BattleState.IsAutoBotActive(var_41_1))

	return
end

function var_0_7.ShowTimer(arg_42_0)
	local var_42_0 = arg_42_0._timerView

	var_1.SetActive(var_42_0, true)

	return
end

function var_0_7.ShowDuelBar(arg_43_0)
	local var_43_0 = arg_43_0._duelRateBar

	var_1.SetActive(var_43_0, true)

	return
end

function var_0_7.ShowSimulationView(arg_44_0)
	local var_44_0 = arg_44_0._simulationBuffCountView

	var_1.SetActive(var_44_0, true)

	return
end

function var_0_7.ShowPauseButton(arg_45_0, arg_45_1)
	setActive = var_1_10002

	local var_45_0 = arg_45_0._ui._tf

	var_1_10002(var_3.Find(var_45_0, "PauseBtn"), arg_45_1)

	return
end

function var_0_7.ShowDodgemScoreBar(arg_46_0)
	arg_46_0:InitScoreBar()

	local var_46_0 = arg_46_0._dataProxy

	var_1.RegisterEventListener(var_46_0, arg_46_0, var_0_1.UPDATE_DODGEM_SCORE, arg_46_0.onUpdateDodgemScore)

	local var_46_1 = arg_46_0._dataProxy

	var_1.RegisterEventListener(var_46_1, arg_46_0, var_0_1.UPDATE_DODGEM_COMBO, arg_46_0.onUpdateDodgemCombo)

	local var_46_2 = arg_46_0._scoreBarView

	var_1.UpdateScore(var_46_2, 0)

	local var_46_3 = arg_46_0._scoreBarView

	var_1.SetActive(var_46_3, true)

	return
end

function var_0_7.ShowAirFightScoreBar(arg_47_0)
	arg_47_0:InitAirFightScoreBar()

	local var_47_0 = arg_47_0._dataProxy

	var_1.RegisterEventListener(var_47_0, arg_47_0, var_0_1.UPDATE_DODGEM_SCORE, arg_47_0.onUpdateDodgemScore)

	local var_47_1 = arg_47_0._dataProxy

	var_1.RegisterEventListener(var_47_1, arg_47_0, var_0_1.UPDATE_DODGEM_COMBO, arg_47_0.onUpdateDodgemCombo)

	local var_47_2 = arg_47_0._scoreBarView

	var_1.UpdateScore(var_47_2, 0)

	local var_47_3 = arg_47_0._scoreBarView

	var_1.SetActive(var_47_3, true)

	return
end

function var_0_7.ScaleUISpeed(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0._ui._tf
	local var_48_1 = var_2.Find(var_48_0, "AutoBtn/on")
	local var_48_2 = var_2.GetComponent

	typeof = var_4
	Animation = var_1_10005

	if var_48_2(var_48_1, var_4(var_1_10005)) then
		var_2:get_Item("autobtn_toOn").speed = arg_48_1
	end

	local var_48_3 = arg_48_0._ui._tf
	local var_48_4 = var_3.Find(var_48_3, "AutoBtn/off")
	local var_48_5 = var_3.GetComponent

	typeof = var_5
	Animation = var_1_10006

	if var_48_5(var_48_4, var_5(var_1_10006)) then
		var_3:get_Item("autobtn_toOff").speed = arg_48_1
	end

	return
end

function var_0_7.onStageInit(arg_49_0, arg_49_1)
	arg_49_0:InitJoystick()
	arg_49_0:InitScene()
	arg_49_0:InitTimer()
	arg_49_0:InitEnemyHpBar()
	arg_49_0:InitAirStrikeIcon()
	arg_49_0:InitCommonWarning()
	arg_49_0:InitAutoBtn()
	arg_49_0:InitMainDamagedView()

	return
end

function var_0_7.onEnemyHit(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1.Data

	if var_2.GetDiveInvisible(var_50_0) and not var_2:GetDiveDetected() then
		return
	end

	local var_50_1 = arg_50_0._enemyHpBar

	if var_3.GetCurrentTarget(var_50_1) then
		if var_3 ~= var_2 then
			local var_50_2 = arg_50_0._enemyHpBar
			local var_50_3 = var_4.SwitchTarget
			local var_50_4 = var_2
			local var_50_5 = arg_50_0._dataProxy

			var_50_3(var_50_2, var_50_4, var_7.GetUnitList(var_50_5))
		end
	else
		local var_50_6 = arg_50_0._enemyHpBar
		local var_50_7 = var_4.SwitchTarget
		local var_50_8 = var_2
		local var_50_9 = arg_50_0._dataProxy

		var_50_7(var_50_6, var_50_8, var_7.GetUnitList(var_50_9))
	end

	return
end

function var_0_7.onEnemyHpUpdate(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1.Dispatcher
	local var_51_1 = arg_51_0._enemyHpBar

	if var_51_0 == var_3.GetCurrentTarget(var_51_1) and (not var_51_0:GetDiveInvisible() or var_51_0:GetDiveDetected()) then
		local var_51_2 = arg_51_0._enemyHpBar

		var_3.UpdateHpBar(var_51_2)
	end

	return
end

function var_0_7.onPlayerMainUnitHpUpdate(arg_52_0, arg_52_1)
	if arg_52_1.Data.dHP < 0 then
		local var_52_0 = arg_52_0._mainDamagedView

		var_3.Play(var_52_0)
	end

	return
end

function var_0_7.onSkillFloat(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1.Data.coverHrzIcon
	local var_53_1 = var_2.commander
	local var_53_2 = var_2.skillName
	local var_53_3 = arg_53_1.Dispatcher

	if var_53_0 then
		arg_53_0:ShowSkillFloatCover(var_53_3, var_53_2, var_53_0)
	else
		arg_53_0:ShowSkillFloat(var_53_3, var_53_2, var_53_1)
	end

	return
end

function var_0_7.onCommonInit(arg_54_0, arg_54_1)
	arg_54_0._skillView = var_0.Battle.BattleSkillView.New(arg_54_0, arg_54_1.Data)
	arg_54_0._updateViewList[arg_54_0._skillView] = true

	local var_54_0 = arg_54_0._dataProxy

	arg_54_0._userFleet = var_2.GetFleetByIFF(var_54_0, var_0_5.FRIENDLY_CODE)

	local var_54_1 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_1, arg_54_0, var_0_1.SHOW_BUFFER, arg_54_0.onShowBuffer)

	local var_54_2 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_2, arg_54_0, var_0_2.POINT_HIT_CHARGE, arg_54_0.onPointHitSight)

	local var_54_3 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_3, arg_54_0, var_0_2.POINT_HIT_CANCEL, arg_54_0.onPointHitSight)

	local var_54_4 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_4, arg_54_0, var_0_1.MANUAL_SUBMARINE_SHIFT, arg_54_0.onManualSubShift)

	local var_54_5 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_5, arg_54_0, var_0_1.FLEET_BLIND, arg_54_0.onFleetBlind)

	local var_54_6 = arg_54_0._userFleet

	var_2.RegisterEventListener(var_54_6, arg_54_0, var_0_1.UPDATE_FLEET_ATTR, arg_54_0.onFleetAttrUpdate)

	local var_54_7 = var_0.Battle.BattleOpticalSightView.New
	local var_54_8 = arg_54_0._ui._tf

	arg_54_0._sightView = var_54_7(var_3.Find(var_54_8, "ChargeAreaContainer"))

	local var_54_9 = arg_54_0._sightView

	var_2.SetFleetVO(var_54_9, arg_54_0._userFleet)

	local var_54_10 = arg_54_0._dataProxy
	local var_54_11, var_54_12, var_54_13, var_54_14 = var_2.GetTotalBounds(var_54_10)
	local var_54_15 = arg_54_0._sightView

	var_6.SetAreaBound(var_54_15, var_54_13, var_54_14)

	local var_54_16
	local var_54_17
	local var_54_18 = arg_54_0._dataProxy

	if var_8.GetInitData(var_54_18).ChapterBuffIDs then
		ipairs = var_8

		local var_54_19 = arg_54_0._dataProxy

		for iter_54_0, iter_54_1 in var_8(var_9.GetInitData(var_54_19).ChapterBuffIDs) do
			if iter_54_1 == 9727 then
				var_54_16 = true

				break
			end
		end
	end

	local var_54_20 = arg_54_0._dataProxy
	local var_54_21 = var_8.GetFleetByIFF(var_54_20, var_0_5.FRIENDLY_CODE)

	if #var_8.GetSupportUnitList(var_54_21) > 0 then
		var_54_17 = true
	end

	if var_54_17 and not var_54_16 then
		local var_54_22 = arg_54_0._airSupportTF

		arg_54_0._airAdavantageTF = var_8.Find(var_54_22, "player_advantage")
	elseif var_54_16 and not var_54_17 then
		local var_54_23 = arg_54_0._airSupportTF

		arg_54_0._airAdavantageTF = var_8.Find(var_54_23, "enemy_advantage")
	elseif var_54_16 and var_54_17 then
		local var_54_24 = arg_54_0._airSupportTF

		arg_54_0._airAdavantageTF = var_8.Find(var_54_24, "draw")
	end

	return
end

function var_0_7.onAddFleet(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1.Data.fleetVO

	PlayerPrefs = var_1_10003

	local var_55_1 = var_1_10003.GetInt

	BATTLE_EXPOSE_LINE = var_1_10004

	if var_55_1(var_1_10004, 1) == 1 then
		arg_55_0:SetFleetCloakLine(var_55_0)
	end

	return
end

function var_0_7.SetFleetCloakLine(arg_56_0, arg_56_1)
	if #arg_56_1:GetCloakList() > 0 then
		local var_56_0 = arg_56_1:GetIFF()
		local var_56_1 = arg_56_1:GetFleetVisionLine()
		local var_56_2 = arg_56_1:GetFleetExposeLine()
		local var_56_3 = arg_56_0._seaView

		var_5.SetExposeLine(var_56_3, var_56_0, var_56_1, var_56_2)
	end

	return
end

function var_0_7.onAddUnit(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_1.Data.type
	local var_57_1 = arg_57_1.Data.unit

	if var_57_0 == var_0_3.UnitType.PLAYER_UNIT or var_57_0 == var_0_3.UnitType.ENEMY_UNIT or var_57_0 == var_0_3.UnitType.BOSS_UNIT then
		arg_57_0:registerUnitEvent(var_57_1)
	end

	if var_57_1:IsBoss() then
		local var_57_2 = arg_57_0._dataProxy

		if var_4.GetActiveBossCount(var_57_2) == 1 then
			arg_57_0:AddBossWarningUI()

			goto label_57_0
		end
	end

	if var_57_0 == var_0_3.UnitType.ENEMY_UNIT then
		arg_57_0:registerNPCUnitEvent(var_57_1)
	elseif var_57_0 == var_0_3.UnitType.PLAYER_UNIT and var_57_1:IsMainFleetUnit() and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		arg_57_0:registerPlayerMainUnitEvent(var_57_1)
	end

	::label_57_0::

	local var_57_3 = var_57_1
	local var_57_4 = var_57_1.GetTemplate(var_57_3).nationality

	table = var_57_3

	if var_57_3.contains(var_0_5.ALCHEMIST_AP_UI, var_57_4) and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		arg_57_0:InitAlchemistAPView()
	end

	table = var_5

	if var_5.contains(var_0_5.YUMIA_MANA_UI, var_57_4) and var_57_1:GetIFF() == var_0_5.FRIENDLY_CODE then
		arg_57_0:InitAlchemistManaView()
	end

	return
end

function var_0_7.onSubmarineDetected(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1.Dispatcher
	local var_58_1 = arg_58_0._enemyHpBar

	if var_3.GetCurrentTarget(var_58_1) then
		local var_58_2 = arg_58_0._enemyHpBar

		if var_3.GetCurrentTarget(var_58_2) == var_58_0 and var_58_0:GetDiveDetected() == false then
			local var_58_3 = arg_58_0._enemyHpBar

			var_3.RemoveUnit(var_58_3)
		end
	end

	return
end

function var_0_7.onRemoveUnit(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1.Data.unit

	if arg_59_1.Data.type == var_0_3.UnitType.PLAYER_UNIT or var_3 == var_0_3.UnitType.ENEMY_UNIT or var_3 == var_0_3.UnitType.BOSS_UNIT then
		arg_59_0:unregisterUnitEvent(var_59_0)
	end

	if var_3 == var_0_3.UnitType.ENEMY_UNIT and not var_59_0:IsBoss() then
		arg_59_0:unregisterNPCUnitEvent(var_59_0)
	elseif var_59_0:GetIFF() == var_0_5.FRIENDLY_CODE and var_59_0:IsMainFleetUnit() then
		arg_59_0:unregisterPlayerMainUnitEvent(var_59_0)
	end

	if arg_59_1.Data.deadReason == var_0_3.UnitDeathReason.LEAVE then
		local var_59_1 = arg_59_0._enemyHpBar

		if var_4.GetCurrentTarget(var_59_1) then
			local var_59_2 = arg_59_0._enemyHpBar

			if var_4.GetCurrentTarget(var_59_2) == arg_59_1.Data.unit then
				local var_59_3 = arg_59_0._enemyHpBar

				var_4.RemoveUnit(var_59_3, arg_59_1.Data.deadReason)
			end
		end
	end

	return
end

function var_0_7.onUpdateCountDown(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._timerView
	local var_60_1 = var_2.SetCountDownText
	local var_60_2 = arg_60_0._dataProxy

	var_60_1(var_60_0, var_4.GetCountDown(var_60_2))

	return
end

function var_0_7.onUpdateDodgemScore(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_1.Data.totalScore
	local var_61_1 = arg_61_0._scoreBarView

	var_4.UpdateScore(var_61_1, var_61_0)

	return
end

function var_0_7.onUpdateDodgemCombo(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1.Data.combo
	local var_62_1 = arg_62_0._scoreBarView

	var_4.UpdateCombo(var_62_1, var_62_0)

	return
end

function var_0_7.onAddAirStrike(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1.Data.index
	local var_63_1 = arg_63_0._dataProxy
	local var_63_2 = var_3.GetAirFighterInfo(var_63_1, var_63_0)
	local var_63_3 = arg_63_0._airStrikeView

	var_4.AppendIcon(var_63_3, var_63_0, var_63_2)

	return
end

function var_0_7.onRemoveAirStrike(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_1.Data.index
	local var_64_1 = arg_64_0._dataProxy
	local var_64_2 = var_3.GetAirFighterInfo(var_64_1, var_64_0)
	local var_64_3 = arg_64_0._airStrikeView

	var_4.RemoveIcon(var_64_3, var_64_0, var_64_2)

	return
end

function var_0_7.onUpdateAirSupportLabel(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0._dataProxy
	local var_65_1 = var_2.GetAirFighterList(var_65_0)
	local var_65_2 = 0

	ipairs = var_1_10004

	for iter_65_0, iter_65_1 in var_1_10004(var_65_1) do
		var_65_2 = var_65_2 + iter_65_1.totalNumber
	end

	if var_65_2 ~= 0 then
		local var_65_3 = arg_65_0._warningView

		if var_4.GetCount(var_65_3) > 0 then
			eachChild = var_4

			var_4(arg_65_0._airSupportTF, function(arg_66_0)
				setActive = var_2_10001

				var_2_10001(arg_66_0, false)

				return
			end)
		elseif arg_65_0._airAdavantageTF then
			setActive = var_4

			var_4(arg_65_0._airAdavantageTF, true)
		end

		return
	end
end

function var_0_7.onUpdateHostileSubmarine(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0._dataProxy
	local var_67_1 = var_2.GetEnemySubmarineCount(var_67_0)
	local var_67_2 = arg_67_0._warningView

	var_3.UpdateHostileSubmarineCount(var_67_2, var_67_1)
	arg_67_0:onUpdateAirSupportLabel()

	return
end

function var_0_7.onUpdateEnvironmentWarning(arg_68_0, arg_68_1)
	if arg_68_1.Data.isActive then
		local var_68_0 = arg_68_0._warningView

		var_3.ActiveWarning(var_68_0, arg_68_0._warningView.WARNING_TYPE_ARTILLERY)
	else
		local var_68_1 = arg_68_0._warningView

		var_3.DeactiveWarning(var_68_1, arg_68_0._warningView.WARNING_TYPE_ARTILLERY)
	end

	return
end

function var_0_7.onCameraFocus(arg_69_0, arg_69_1)
	if arg_69_1.Data.unit ~= nil then
		local var_69_0

		if not var_2.skill then
			var_69_0 = false
		end

		arg_69_0:EnableComponent(false)
		arg_69_0:EnableSkillFloat(var_69_0)
	else
		local var_69_1 = var_2.duration + var_2.extraBulletTime

		LeanTween = var_4

		local var_69_2 = var_4.delayedCall
		local var_69_3 = arg_69_0._ui._go
		local var_69_4 = var_69_1

		System = var_1_10007

		var_69_2(var_69_3, var_69_4, var_1_10007.Action(function()
			local var_70_0 = arg_69_0

			var_0.EnableComponent(var_70_0, true)

			local var_70_1 = arg_69_0

			var_0.EnableSkillFloat(var_70_1, true)

			return
		end))
	end

	return
end

function var_0_7.onShowPainting(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_1.Data

	arg_71_0:ShowSkillPainting(var_71_0.caster, var_71_0.skill, var_71_0.speed)

	return
end

function var_0_7.onBulletTime(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_1.Data.key

	if var_2.rate then
		var_0_4.AppendMapFactor(var_72_0, var_4)
	else
		var_0_4.RemoveMapFactor(var_72_0)
	end

	local var_72_1 = arg_72_0._seaView

	var_5.UpdateSpeedScaler(var_72_1)

	return
end

function var_0_7.onShowBuffer(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_1.Data.dist
	local var_73_1 = arg_73_0._seaView

	var_3.UpdateBufferAlpha(var_73_1, var_73_0)

	return
end

function var_0_7.onManualSubShift(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_1.Data.state
	local var_74_1 = arg_74_0._skillView

	var_3.ShiftSubmarineManualButton(var_74_1, var_74_0)

	return
end

function var_0_7.onPointHitSight(arg_75_0, arg_75_1)
	if arg_75_1.ID == var_0_2.POINT_HIT_CHARGE then
		local var_75_0 = arg_75_0._sightView

		var_3.SetActive(var_75_0, true)

		arg_75_0._updateViewList[arg_75_0._sightView] = true
	elseif var_2 == var_0_2.POINT_HIT_CANCEL then
		local var_75_1 = arg_75_0._sightView

		var_3.SetActive(var_75_1, false)

		arg_75_0._updateViewList[arg_75_0._sightView] = nil
	end

	return
end

function var_0_7.onFleetBlind(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_1.Data.isBlind
	local var_76_1 = arg_76_1.Dispatcher

	if not arg_76_0._inkView then
		arg_76_0:InitInkView(var_76_1)
	end

	if var_76_0 then
		local var_76_2 = var_76_1:GetUnitList()
		local var_76_3 = arg_76_0._inkView

		var_5.SetActive(var_76_3, true, var_76_2)

		local var_76_4 = arg_76_0._skillView

		var_5.HideSkillButton(var_76_4, true)

		arg_76_0._updateViewList[arg_76_0._inkView] = true
	else
		local var_76_5 = arg_76_0._inkView

		var_4.SetActive(var_76_5, false)

		local var_76_6 = arg_76_0._skillView

		var_4.HideSkillButton(var_76_6, false)

		arg_76_0._updateViewList[arg_76_0._inkView] = nil
	end

	return
end

function var_0_7.onFleetHorizonUpdate(arg_77_0, arg_77_1)
	if not arg_77_0._inkView then
		return
	end

	local var_77_0 = arg_77_1.Dispatcher
	local var_77_1 = var_2.GetUnitList(var_77_0)
	local var_77_2 = arg_77_0._inkView

	var_4.UpdateHollow(var_77_2, var_77_1)

	return
end

function var_0_7.onFleetAttrUpdate(arg_78_0, arg_78_1)
	if arg_78_0._alchemistAP then
		local var_78_0 = arg_78_1.Data.attr
		local var_78_1 = arg_78_0._alchemistAP

		if var_78_0 == var_3.GetAttrName(var_78_1) then
			local var_78_2 = arg_78_0._alchemistAP

			var_2.UpdateAP(var_78_2, arg_78_1.Data.value)
		end
	end

	if arg_78_0._alchemistMana then
		local var_78_3 = arg_78_1.Data.attr
		local var_78_4 = arg_78_0._alchemistMana

		if var_78_3 == var_3.GetAttrName(var_78_4) then
			local var_78_5 = arg_78_0._alchemistMana

			var_2.UpdateMana(var_78_5, arg_78_1.Data.value)
		end
	end

	return
end

function var_0_7.OnAddUIFX(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_1.Data.FXID
	local var_79_1 = arg_79_1.Data.position
	local var_79_2 = arg_79_1.Data.localScale
	local var_79_3 = arg_79_1.Data.orderDiff

	arg_79_0:AddUIFX(var_79_3, var_79_0, var_79_1, var_79_2)

	return
end

function var_0_7.AddUIFX(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4)
	local var_80_0 = arg_80_0._fxPool
	local var_80_1 = var_5.GetFX(var_80_0, arg_80_2)

	arg_80_1 = arg_80_1 or 1

	local var_80_2

	var_80_2 = arg_80_1 > 0

	local var_80_3 = arg_80_0._ui
	local var_80_4 = var_7.AddUIFX(var_80_3, var_80_1, arg_80_1)

	arg_80_4 = arg_80_4 or 1

	local var_80_5 = var_80_1.transform

	Vector3 = var_9
	var_80_5.localScale = var_9(arg_80_4 / var_80_4.x, arg_80_4 / var_80_4.y, arg_80_4 / var_80_4.z)
	pg = var_80_5

	local var_80_6 = var_80_5.EffectMgr.GetInstance()

	var_8.PlayBattleEffect(var_80_6, var_80_1, arg_80_3, true)

	return
end

function var_0_7.AddBossWarningUI(arg_81_0)
	local var_81_0 = arg_81_0._dataProxy

	var_1.BlockManualCast(var_81_0, true)

	local var_81_1 = var_0.Battle.BattleResourceManager.GetInstance()

	arg_81_0._appearEffect = var_1.InstBossWarningUI(var_81_1)

	local var_81_2 = arg_81_0._appearEffect
	local var_81_3 = var_2.GetComponent

	typeof = var_1_10004
	Animator = var_1_10005

	local var_81_4 = var_81_3(var_81_2, var_1_10004(var_1_10005))
	local var_81_5 = {
		Pause = function()
			var_81_4.speed = 0

			return
		end,
		Resume = function()
			var_81_4.speed = 1

			return
		end
	}
	local var_81_6 = arg_81_0._state

	var_4.SetTakeoverProcess(var_81_6, var_81_5)

	local var_81_7 = arg_81_0._state

	var_81_4.speed = 1 / var_4.GetTimeScaleRate(var_81_7)
	setParent = var_4

	var_4(arg_81_0._appearEffect, arg_81_0._ui.uiCanvas, false)

	local var_81_8 = arg_81_0._appearEffect
	local var_81_9 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_7

	local var_81_10 = var_81_9(var_81_8, var_6(var_7))

	var_4.SetEndEvent(var_81_10, function(arg_84_0)
		local var_84_0 = arg_81_0._userFleet

		var_1.CoupleEncourage(var_84_0)

		local var_84_1 = arg_81_0._dataProxy

		var_1.BlockManualCast(var_84_1, false)

		local var_84_2 = arg_81_0._state

		var_1.ClearTakeoverProcess(var_84_2)

		local var_84_3 = var_0

		var_1.DestroyOb(var_84_3, arg_81_0._appearEffect)

		arg_81_0._appearEffect = nil

		return
	end)

	SetActive = var_5

	var_5(arg_81_0._appearEffect, true)

	return
end

function var_0_7.OnHideButtons(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_1.Data.isActive
	local var_85_1 = arg_85_0._skillView

	var_3.HideSkillButton(var_85_1, not var_85_0)

	SetActive = var_3

	var_3(arg_85_0._autoBtn.transform, var_85_0)

	return
end

function var_0_7.onEditCustomWarning(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1.Data.labelData
	local var_86_1 = arg_86_0._warningView

	var_3.EditCustomWarning(var_86_1, var_86_0)

	return
end

function var_0_7.onGridmanSkillFloat(arg_87_0, arg_87_1)
	if not arg_87_0._gridmanSkillFloat then
		local var_87_0 = var_0.Battle.BattleResourceManager.GetInstance()
		local var_87_1 = var_2.InstGridmanSkillUI(var_87_0)

		arg_87_0._gridmanSkillFloat = var_0.Battle.BattleGridmanSkillFloatView.New(var_87_1)
		setParent = var_4

		var_4(var_87_1, arg_87_0._ui.uiCanvas, false)
	end

	local var_87_2 = arg_87_1.Data.type
	local var_87_3 = var_2.IFF

	if var_87_2 == 5 then
		local var_87_4 = arg_87_0._gridmanSkillFloat

		var_5.DoFusionFloat(var_87_4, var_87_3)
	else
		local var_87_5 = arg_87_0._gridmanSkillFloat

		var_5.DoSkillFloat(var_87_5, var_87_2, var_87_3)
	end

	return
end

function var_0_7.registerUnitEvent(arg_88_0, arg_88_1)
	arg_88_1:RegisterEventListener(arg_88_0, var_0_2.SKILL_FLOAT, arg_88_0.onSkillFloat)
	arg_88_1:RegisterEventListener(arg_88_0, var_0_2.CUT_INT, arg_88_0.onShowPainting)

	return
end

function var_0_7.registerNPCUnitEvent(arg_89_0, arg_89_1)
	arg_89_1:RegisterEventListener(arg_89_0, var_0_2.UPDATE_HP, arg_89_0.onEnemyHpUpdate)

	local var_89_0 = arg_89_1
	local var_89_1 = arg_89_1.GetTemplate(var_89_0).type

	table = var_89_0

	local var_89_2 = var_89_0.contains

	ShipType = var_4

	if var_89_2(var_4.SubShipType, var_89_1) then
		arg_89_1:RegisterEventListener(arg_89_0, var_0_2.SUBMARINE_DETECTED, arg_89_0.onSubmarineDetected)
	end

	return
end

function var_0_7.registerPlayerMainUnitEvent(arg_90_0, arg_90_1)
	arg_90_1:RegisterEventListener(arg_90_0, var_0_2.UPDATE_HP, arg_90_0.onPlayerMainUnitHpUpdate)

	return
end

function var_0_7.unregisterUnitEvent(arg_91_0, arg_91_1)
	arg_91_1:UnregisterEventListener(arg_91_0, var_0_2.SKILL_FLOAT)
	arg_91_1:UnregisterEventListener(arg_91_0, var_0_2.CUT_INT)

	return
end

function var_0_7.unregisterNPCUnitEvent(arg_92_0, arg_92_1)
	arg_92_1:UnregisterEventListener(arg_92_0, var_0_2.SKILL_FLOAT)
	arg_92_1:UnregisterEventListener(arg_92_0, var_0_2.CUT_INT)
	arg_92_1:UnregisterEventListener(arg_92_0, var_0_2.UPDATE_HP)

	local var_92_0 = arg_92_1
	local var_92_1 = arg_92_1.GetTemplate(var_92_0).type

	table = var_92_0

	local var_92_2 = var_92_0.contains

	ShipType = var_4

	if var_92_2(var_4.SubShipType, var_92_1) then
		arg_92_1:UnregisterEventListener(arg_92_0, var_0_2.SUBMARINE_DETECTED)
	end

	return
end

function var_0_7.unregisterPlayerMainUnitEvent(arg_93_0, arg_93_1)
	arg_93_1:UnregisterEventListener(arg_93_0, var_0_2.UPDATE_HP)

	return
end

function var_0_7.Dispose(arg_94_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_94_0._ui._go)

	local var_94_0 = arg_94_0._uiMGR

	var_1.ClearStick(var_94_0)

	arg_94_0._uiMGR = nil

	if arg_94_0._appearEffect then
		Destroy = var_1

		var_1(arg_94_0._appearEffect)
	end

	arg_94_0:RemoveUIEvent()

	arg_94_0._updateViewList = nil

	local var_94_1 = arg_94_0._timerView

	var_1.Dispose(var_94_1)

	local var_94_2 = arg_94_0._enemyHpBar

	var_1.Dispose(var_94_2)

	local var_94_3 = arg_94_0._skillView

	var_1.Dispose(var_94_3)

	local var_94_4 = arg_94_0._seaView

	var_1.Dispose(var_94_4)

	local var_94_5 = arg_94_0._airStrikeView

	var_1.Dispose(var_94_5)

	local var_94_6 = arg_94_0._sightView

	var_1.Dispose(var_94_6)

	local var_94_7 = arg_94_0._mainDamagedView

	var_1.Dispose(var_94_7)

	local var_94_8 = arg_94_0._warningView

	var_1.Dispose(var_94_8)

	arg_94_0._seaView = nil
	arg_94_0._enemyHpBar = nil
	arg_94_0._skillView = nil
	arg_94_0._timerView = nil
	arg_94_0._joystick = nil
	arg_94_0._airStrikeView = nil
	arg_94_0._warningView = nil
	arg_94_0._mainDamagedView = nil

	if arg_94_0._duelRateBar then
		local var_94_9 = arg_94_0._duelRateBar

		var_1.Dispose(var_94_9)

		arg_94_0._duelRateBar = nil
	end

	if arg_94_0._simulationBuffCountView then
		local var_94_10 = arg_94_0._simulationBuffCountView

		var_1.Dispose(var_94_10)

		arg_94_0._simulationBuffCountView = nil
	end

	if arg_94_0._jammingView then
		local var_94_11 = arg_94_0._jammingView

		var_1.Dispose(var_94_11)

		arg_94_0._jammingView = nil
	end

	if arg_94_0._inkView then
		local var_94_12 = arg_94_0._inkView

		var_1.Dispose(var_94_12)

		arg_94_0._inkView = nil
	end

	if arg_94_0._alchemistAP then
		local var_94_13 = arg_94_0._alchemistAP

		var_1.Dispose(var_94_13)

		arg_94_0._alchemistAP = nil
	end

	if arg_94_0._alchemistMana then
		local var_94_14 = arg_94_0._alchemistMana

		var_1.Dispose(var_94_14)

		arg_94_0._alchemistMana = nil
	end

	if arg_94_0._gridmanSkillFloat then
		local var_94_15 = arg_94_0._gridmanSkillFloat

		var_1.Dispose(var_94_15)
	end

	go = var_1

	local var_94_16 = arg_94_0._ui._tf

	if var_1(var_2.Find(var_94_16, "CardPuzzleConsole")).activeSelf then
		arg_94_0:DisposeCardPuzzleComponent()
	end

	var_0_7.super.Dispose(arg_94_0)

	return
end

function var_0_7.OnCardPuzzleInit(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_0._dataProxy
	local var_95_1 = var_2.GetFleetByIFF(var_95_0, var_0_5.FRIENDLY_CODE)

	arg_95_0._cardPuzzleComponent = var_2.GetCardPuzzleComponent(var_95_1)

	arg_95_0:ShowCardPuzzleComponent()
	arg_95_0:RegisterCardPuzzleEvent()

	return
end

function var_0_7.RegisterCardPuzzleEvent(arg_96_0)
	local var_96_0 = arg_96_0._cardPuzzleComponent

	var_1.RegisterEventListener(var_96_0, arg_96_0, var_0_6.UPDATE_FLEET_SHIP, arg_96_0.onUpdateFleetShip)

	local var_96_1 = arg_96_0._cardPuzzleComponent

	var_1.RegisterEventListener(var_96_1, arg_96_0, var_0_6.COMMON_BUTTON_ENABLE, arg_96_0.onBlockCommonButton)

	local var_96_2 = arg_96_0._cardPuzzleComponent

	var_1.RegisterEventListener(var_96_2, arg_96_0, var_0_6.LONG_PRESS_BULLET_TIME, arg_96_0.onLongPressBulletTime)

	local var_96_3 = arg_96_0._cardPuzzleComponent

	var_1.RegisterEventListener(var_96_3, arg_96_0, var_0_6.SHOW_CARD_DETAIL, arg_96_0.onShowCardDetail)

	return
end

function var_0_7.ShowCardPuzzleComponent(arg_97_0)
	setActive = var_1_10001

	local var_97_0 = arg_97_0._ui._tf

	var_1_10001(var_2.Find(var_97_0, "CardPuzzleConsole"), true)
	arg_97_0:InitCardPuzzleCommonHPBar()
	arg_97_0:InitCardPuzzleEnergyBar()
	arg_97_0:IntCardPuzzleFleetHead()
	arg_97_0:InitCameraCardBoardClicker()
	arg_97_0:InitCardPuzzleMovePile()
	arg_97_0:InitCardPuzzleDeckPile()
	arg_97_0:InitCardPuzzleIconList()
	arg_97_0:InitCardPuzzleHandBoard()
	arg_97_0:InitCardPuzzleCardDetail()
	arg_97_0:InitCardPuzzleGoalRemind()

	return
end

function var_0_7.InitCardPuzzleCommonHPBar(arg_98_0)
	local var_98_0 = var_0.Battle.CardPuzzleCommonHPBar.New
	local var_98_1 = arg_98_0._ui._tf

	arg_98_0._cardPuzzleHPBar = var_98_0(var_2.Find(var_98_1, "CardPuzzleConsole/commonHP"))

	local var_98_2 = arg_98_0._cardPuzzleHPBar

	var_1.SetCardPuzzleComponent(var_98_2, arg_98_0._cardPuzzleComponent)

	arg_98_0._updateViewList[arg_98_0._cardPuzzleHPBar] = true

	return
end

function var_0_7.InitCardPuzzleEnergyBar(arg_99_0)
	local var_99_0 = var_0.Battle.CardPuzzleEnergyBar.New
	local var_99_1 = arg_99_0._ui._tf

	arg_99_0._cardPuzzleEnergyBar = var_99_0(var_2.Find(var_99_1, "CardPuzzleConsole/energy_block"))

	local var_99_2 = arg_99_0._cardPuzzleEnergyBar

	var_1.SetCardPuzzleComponent(var_99_2, arg_99_0._cardPuzzleComponent)

	arg_99_0._updateViewList[arg_99_0._cardPuzzleEnergyBar] = true

	return
end

function var_0_7.InitCameraCardBoardClicker(arg_100_0)
	local var_100_0 = var_0.Battle.CardPuzzleBoardClicker.New
	local var_100_1 = arg_100_0._ui._tf

	arg_100_0._cardPuzzleBoardClicker = var_100_0(var_2.Find(var_100_1, "CardBoardController"))

	local var_100_2 = arg_100_0._cardPuzzleBoardClicker

	var_1.SetCardPuzzleComponent(var_100_2, arg_100_0._cardPuzzleComponent)

	return
end

function var_0_7.IntCardPuzzleFleetHead(arg_101_0)
	local var_101_0 = var_0.Battle.CardPuzzleFleetHead.New
	local var_101_1 = arg_101_0._ui._tf

	arg_101_0._cardPuzzleFleetHead = var_101_0(var_2.Find(var_101_1, "CardPuzzleConsole/fleet"))

	local var_101_2 = arg_101_0._cardPuzzleFleetHead

	var_1.SetCardPuzzleComponent(var_101_2, arg_101_0._cardPuzzleComponent)

	return
end

function var_0_7.InitCardPuzzleMovePile(arg_102_0)
	local var_102_0 = var_0.Battle.CardPuzzleMovePile.New
	local var_102_1 = arg_102_0._ui._tf

	arg_102_0._cardPuzzleMovePile = var_102_0(var_2.Find(var_102_1, "CardPuzzleConsole/movedeck"))

	local var_102_2 = arg_102_0._cardPuzzleMovePile

	var_1.SetCardPuzzleComponent(var_102_2, arg_102_0._cardPuzzleComponent)

	arg_102_0._updateViewList[arg_102_0._cardPuzzleMovePile] = true

	return
end

function var_0_7.InitCardPuzzleDeckPile(arg_103_0)
	local var_103_0 = var_0.Battle.CardPuzzleDeckPool.New
	local var_103_1 = arg_103_0._ui._tf

	arg_103_0._cardPuzzleDeckPile = var_103_0(var_2.Find(var_103_1, "CardPuzzleConsole/deck"))

	local var_103_2 = arg_103_0._cardPuzzleDeckPile

	var_1.SetCardPuzzleComponent(var_103_2, arg_103_0._cardPuzzleComponent)

	return
end

function var_0_7.InitCardPuzzleIconList(arg_104_0)
	local var_104_0 = var_0.Battle.CardPuzzleFleetIconList.New
	local var_104_1 = arg_104_0._ui._tf

	arg_104_0._cardPuzzleStatusIcon = var_104_0(var_2.Find(var_104_1, "CardPuzzleConsole/statusIcon"))

	local var_104_2 = arg_104_0._cardPuzzleStatusIcon

	var_1.SetCardPuzzleComponent(var_104_2, arg_104_0._cardPuzzleComponent)

	arg_104_0._updateViewList[arg_104_0._cardPuzzleStatusIcon] = true

	return
end

function var_0_7.InitCardPuzzleHandBoard(arg_105_0)
	local var_105_0 = var_0.Battle.CardPuzzleHandBoard.New
	local var_105_1 = arg_105_0._ui._tf
	local var_105_2 = var_2.Find(var_105_1, "CardPuzzleConsole/cardboard")
	local var_105_3 = arg_105_0._ui._tf

	arg_105_0._cardPuzzleHandBoard = var_105_0(var_105_2, var_3.Find(var_105_3, "CardPuzzleConsole/hand"))

	local var_105_4 = arg_105_0._cardPuzzleHandBoard

	var_1.SetCardPuzzleComponent(var_105_4, arg_105_0._cardPuzzleComponent)

	arg_105_0._updateViewList[arg_105_0._cardPuzzleHandBoard] = true

	return
end

function var_0_7.InitCardPuzzleGoalRemind(arg_106_0)
	local var_106_0 = var_0.Battle.CardPuzzleGoalRemind.New
	local var_106_1 = arg_106_0._ui._tf

	arg_106_0._cardPuzzleGoalRemind = var_106_0(var_2.Find(var_106_1, "CardPuzzleConsole/goal"))

	local var_106_2 = arg_106_0._cardPuzzleGoalRemind

	var_1.SetCardPuzzleComponent(var_106_2, arg_106_0._cardPuzzleComponent)

	return
end

function var_0_7.InitCardPuzzleCardDetail(arg_107_0)
	local var_107_0 = var_0.Battle.CardPuzzleCardDetail.New
	local var_107_1 = arg_107_0._ui._tf

	arg_107_0._cardPuzzleCardDetail = var_107_0(var_2.Find(var_107_1, "CardPuzzleConsole/cardDetail"))

	return
end

function var_0_7.DisposeCardPuzzleComponent(arg_108_0)
	local var_108_0 = arg_108_0._cardPuzzleHPBar

	var_1.Dispose(var_108_0)

	local var_108_1 = arg_108_0._cardPuzzleEnergyBar

	var_1.Dispose(var_108_1)

	local var_108_2 = arg_108_0._cardPuzzleBoardClicker

	var_1.Dispose(var_108_2)

	local var_108_3 = arg_108_0._cardPuzzleFleetHead

	var_1.Dispose(var_108_3)

	local var_108_4 = arg_108_0._cardPuzzleMovePile

	var_1.Dispose(var_108_4)

	local var_108_5 = arg_108_0._cardPuzzleDeckPile

	var_1.Dispose(var_108_5)

	local var_108_6 = arg_108_0._cardPuzzleStatusIcon

	var_1.Dispose(var_108_6)

	local var_108_7 = arg_108_0._cardPuzzleHandBoard

	var_1.Dispose(var_108_7)

	local var_108_8 = arg_108_0._cardPuzzleGoalRemind

	var_1.Dispose(var_108_8)

	local var_108_9 = arg_108_0._cardPuzzleCardDetail

	var_1.Dispose(var_108_9)

	return
end

function var_0_7.onUpdateFleetBuff(arg_109_0)
	return
end

function var_0_7.onUpdateFleetShip(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_0._cardPuzzleFleetHead

	var_2.UpdateShipIcon(var_110_0, arg_110_1.Data.teamType)

	return
end

function var_0_7.onBlockCommonButton(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_1.Data.flag

	arg_111_0:EnableComponent(var_111_0)

	return
end

function var_0_7.onLongPressBulletTime(arg_112_0, arg_112_1)
	local var_112_0 = arg_112_1.Data.timeScale
	local var_112_1 = arg_112_0._state

	var_3.ScaleTimer(var_112_1, var_112_0)

	return
end

function var_0_7.onShowCardDetail(arg_113_0, arg_113_1)
	if arg_113_1.Data.card then
		local var_113_0 = arg_113_0._cardPuzzleCardDetail

		var_3.Active(var_113_0, true)

		local var_113_1 = arg_113_0._cardPuzzleCardDetail

		var_3.SetReferenceCard(var_113_1, var_2)
	else
		local var_113_2 = arg_113_0._cardPuzzleCardDetail

		var_3.Active(var_113_2, false)
	end

	return
end

return
