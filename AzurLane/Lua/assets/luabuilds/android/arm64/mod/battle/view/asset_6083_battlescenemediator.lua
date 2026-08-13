ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleVariable
local var_0_6 = var_0.Battle.BattleTargetChoise

class = var_0_10007

local var_0_7 = var_0_10007("BattleSceneMediator", var_0.MVC.Mediator)

var_0.Battle.BattleSceneMediator = var_0_7
var_0_7.__name = "BattleSceneMediator"
Vector3 = var_8

local var_0_8 = var_8(0, 0.8, 0)

function var_0_7.Ctor(arg_1_0)
	var_0_7.super.Ctor(arg_1_0)

	Vector3 = var_1
	arg_1_0.FlagShipUIPos = var_1.zero

	return
end

function var_0_7.Initialize(arg_2_0)
	var_0_7.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitCharacterFactory()
	arg_2_0:Init()
	arg_2_0:AddEvent()

	return
end

function var_0_7.Init(arg_3_0)
	arg_3_0._characterList = {}
	arg_3_0._bulletList = {}
	arg_3_0._particleBulletList = {}
	arg_3_0._aircraftList = {}
	arg_3_0._areaList = {}
	arg_3_0._shelterList = {}
	arg_3_0._arcEffectList = {}
	GameObject = var_1
	arg_3_0._bulletContainer = var_1.Find("BulletContainer")
	arg_3_0._fxPool = var_0.Battle.BattleFXPool.GetInstance()
	arg_3_0._aimBiasTFList = {}

	local var_3_0 = var_0.Battle.BattleCharacterFXContainersPool.GetInstance()

	var_1.Init(var_3_0)
	arg_3_0:InitPlayerAntiAirArea()
	arg_3_0:InitPlayerAntiSubArea()
	arg_3_0:InitFlagShipMark()
	arg_3_0:InitSkillAim()

	pg = var_1

	local var_3_1 = var_1.CameraFixMgr.GetInstance()

	var_1.Adapt(var_3_1)

	return
end

function var_0_7.InitCamera(arg_4_0)
	arg_4_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

	local var_4_0 = arg_4_0._cameraUtil

	var_1.RegisterEventListener(var_4_0, arg_4_0, var_0_1.CAMERA_FOCUS_RESET, arg_4_0.onCameraFocusReset)

	local var_4_1 = arg_4_0._cameraUtil

	var_1.RegisterEventListener(var_4_1, arg_4_0, var_0_1.BULLET_TIME, arg_4_0.onBulletTime)

	return
end

function var_0_7.InitPopNumPool(arg_5_0)
	arg_5_0._popNumMgr = var_0.Battle.BattlePopNumManager.GetInstance()

	local var_5_0 = arg_5_0._state
	local var_5_1 = var_2.GetUI(var_5_0)
	local var_5_2 = arg_5_0._dataProxy
	local var_5_3 = var_3.GetInitData(var_5_2).battleType

	SYSTEM_DODGEM = var_5_0

	if var_5_3 == var_5_0 then
		local var_5_4 = arg_5_0._popNumMgr
		local var_5_5 = var_3.InitialScorePool
		local var_5_6 = var_5_1._tf

		var_5_5(var_5_4, var_6.Find(var_5_6, var_1.CONTAINER_CHARACTER_HP .. "/container"))
	else
		local var_5_7 = arg_5_0._popNumMgr
		local var_5_8 = var_3.InitialBundlePool
		local var_5_9 = var_5_1._tf

		var_5_8(var_5_7, var_6.Find(var_5_9, var_1.CONTAINER_CHARACTER_HP .. "/container"))
	end

	return
end

function var_0_7.InitFlagShipMark(arg_6_0)
	local var_6_0 = arg_6_0._state
	local var_6_1 = var_1.GetUI(var_6_0)._tf
	local var_6_2 = var_1.Find(var_6_1, "flagShipMark").gameObject

	var_1.SetActive(var_6_2, true)

	arg_6_0._goFlagShipMarkTf = var_1.transform

	return
end

function var_0_7.InitSkillAim(arg_7_0)
	arg_7_0._cardAimTargetFilter = {}
	arg_7_0._cardAimTargetList = {}

	return
end

function var_0_7.InitCharacterFactory(arg_8_0)
	local var_8_0 = arg_8_0._state
	local var_8_1 = var_1.GetUI(var_8_0)
	local var_8_2 = var_0.Battle.BattleHPBarManager.GetInstance()
	local var_8_3 = var_2.InitialPoolRoot
	local var_8_4 = var_8_1._tf

	var_8_3(var_8_2, var_5.Find(var_8_4, var_0.Battle.BattleHPBarManager.ROOT_NAME))

	local var_8_5 = var_0.Battle.BattleArrowManager.GetInstance()
	local var_8_6 = var_2.Init
	local var_8_7 = var_8_1._tf

	var_8_6(var_8_5, var_5.Find(var_8_7, var_0.Battle.BattleArrowManager.ROOT_NAME))

	arg_8_0._characterFactoryList = {
		[var_0_3.UnitType.PLAYER_UNIT] = var_0.Battle.BattlePlayerCharacterFactory.GetInstance(),
		[var_0_3.UnitType.ENEMY_UNIT] = var_0.Battle.BattleEnemyCharacterFactory.GetInstance(),
		[var_0_3.UnitType.MINION_UNIT] = var_0.Battle.BattleMinionCharacterFactory.GetInstance(),
		[var_0_3.UnitType.BOSS_UNIT] = var_0.Battle.BattleBossCharacterFactory.GetInstance(),
		[var_0_3.UnitType.AIRCRAFT_UNIT] = var_0.Battle.BattleAircraftCharacterFactory.GetInstance(),
		[var_0_3.UnitType.AIRFIGHTER_UNIT] = var_0.Battle.BattleAirFighterCharacterFactory.GetInstance(),
		[var_0_3.UnitType.SUB_UNIT] = var_0.Battle.BattleSubCharacterFactory.GetInstance(),
		[var_0_3.UnitType.SUPPORT_UNIT] = var_0.Battle.BattleSupportCharacterFactory.GetInstance()
	}

	return
end

function var_0_7.InitPlayerAntiAirArea(arg_9_0)
	local var_9_0 = arg_9_0._fxPool

	arg_9_0._antiAirArea = var_1.GetFX(var_9_0, "AntiAirArea")
	arg_9_0._antiAirAreaTF = arg_9_0._antiAirArea.transform

	local var_9_1 = arg_9_0._antiAirArea

	var_1.SetActive(var_9_1, false)

	return
end

function var_0_7.InitPlayerAntiSubArea(arg_10_0)
	local var_10_0 = arg_10_0._fxPool

	arg_10_0._anitSubArea = var_1.GetFX(var_10_0, "AntiSubArea")
	arg_10_0._anitSubAreaTF = arg_10_0._anitSubArea.transform

	local var_10_1 = arg_10_0._anitSubArea

	var_1.SetActive(var_10_1, false)

	local var_10_2 = arg_10_0._anitSubAreaTF
	local var_10_3 = var_1.Find(var_10_2, "Quad")
	local var_10_4 = var_1.GetComponent

	typeof = var_4
	Animator = var_1_10006
	arg_10_0._antiSubScanAnima = var_10_4(var_10_3, var_4(var_1_10006))
	arg_10_0._anitSubAreaTFList = {}
	arg_10_0._anitSubAreaTFList[arg_10_0._anitSubAreaTF] = true

	return
end

function var_0_7.InitDetailAntiSubArea(arg_11_0)
	local var_11_0 = arg_11_0._leftFleet
	local var_11_1 = var_1.GetFleetSonar(var_11_0)
	local var_11_2, var_11_3, var_11_4, var_11_5 = var_1.GetTotalRangeDetail(var_11_1)

	local function var_11_6(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_11_0._fxPool
		local var_12_1 = var_3.GetFX(var_12_0, "AntiSubArea")

		var_12_1.name = arg_12_2

		local var_12_2 = var_12_1.transform

		Vector3 = var_12_0
		var_12_2.localScale = var_12_0(arg_12_0, 0, arg_12_0)

		local var_12_3 = var_12_2:Find("static")

		var_5.GetComponent(var_12_3, "SpriteRenderer").color = arg_12_1

		var_12_1:SetActive(true)

		arg_11_0._anitSubAreaTFList[var_12_2] = true

		return
	end

	local var_11_7 = var_11_2 + var_11_3 + var_11_4 + var_11_5

	Color = var_1_10009

	var_11_6(var_11_7, var_1_10009.New(1, 1, 1, 1), "技能额外直径：" .. var_11_5)

	local var_11_8 = var_5
	local var_11_9 = var_11_2 + var_11_3 + var_11_4

	Color = var_9

	var_11_8(var_11_9, var_9.New(0.07, 1, 0, 1), "装备提供直径：" .. var_11_4)

	local var_11_10 = var_5
	local var_11_11 = var_11_2 + var_11_3

	Color = var_9

	var_11_10(var_11_11, var_9.New(1, 0.32, 0, 1), "主力提供直径：" .. var_11_3)

	local var_11_12 = var_5
	local var_11_13 = var_11_2

	Color = var_9

	var_11_12(var_11_13, var_9.New(1, 0, 0, 1), "基础直径：" .. var_11_2)

	return
end

function var_0_7.AddEvent(arg_13_0)
	local var_13_0 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_0, arg_13_0, var_0_1.STAGE_DATA_INIT_FINISH, arg_13_0.onStageInitFinish)

	local var_13_1 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_1, arg_13_0, var_0_1.ADD_UNIT, arg_13_0.onAddUnit)

	local var_13_2 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_2, arg_13_0, var_0_1.REMOVE_UNIT, arg_13_0.onRemoveUnit)

	local var_13_3 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_3, arg_13_0, var_0_1.REMOVE_BULLET, arg_13_0.onRemoveBullet)

	local var_13_4 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_4, arg_13_0, var_0_1.REMOVE_AIR_CRAFT, arg_13_0.onRemoveAircraft)

	local var_13_5 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_5, arg_13_0, var_0_1.REMOVE_AIR_FIGHTER, arg_13_0.onRemoveAirFighter)

	local var_13_6 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_6, arg_13_0, var_0_1.ADD_AREA, arg_13_0.onAddArea)

	local var_13_7 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_7, arg_13_0, var_0_1.REMOVE_AREA, arg_13_0.onRemoveArea)

	local var_13_8 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_8, arg_13_0, var_0_1.ADD_EFFECT, arg_13_0.onAddEffect)

	local var_13_9 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_9, arg_13_0, var_0_1.ADD_SHELTER, arg_13_0.onAddShelter)

	local var_13_10 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_10, arg_13_0, var_0_1.REMOVE_SHELTER, arg_13_0.onRemoveShleter)

	local var_13_11 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_11, arg_13_0, var_0_1.ANTI_AIR_AREA, arg_13_0.onAntiAirArea)

	local var_13_12 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_12, arg_13_0, var_0_1.UPDATE_HOSTILE_SUBMARINE, arg_13_0.onUpdateHostileSubmarine)

	local var_13_13 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_13, arg_13_0, var_0_1.ADD_CAMERA_FX, arg_13_0.onAddCameraFX)

	local var_13_14 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_14, arg_13_0, var_0_1.ADD_AIM_BIAS, arg_13_0.onAddAimBias)

	local var_13_15 = arg_13_0._dataProxy

	var_1.RegisterEventListener(var_13_15, arg_13_0, var_0_1.REMOVE_AIM_BIAS, arg_13_0.onRemoveAimBias)

	pg = var_1

	local var_13_16 = var_1.CameraFixMgr.GetInstance()
	local var_13_17 = var_1.bind

	pg = var_4
	arg_13_0._camEventId = var_13_17(var_13_16, var_4.CameraFixMgr.ASPECT_RATIO_UPDATE, function()
		local var_14_0 = arg_13_0._dataProxy

		var_0.OnCameraRatioUpdate(var_14_0)

		return
	end)

	return
end

function var_0_7.RemoveEvent(arg_15_0)
	local var_15_0 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_0, arg_15_0, var_0_1.SONAR_SCAN)

	local var_15_1 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_1, arg_15_0, var_0_1.SONAR_UPDATE)

	local var_15_2 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_2, arg_15_0, var_0_1.ADD_AIM_BIAS)

	local var_15_3 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_3, arg_15_0, var_0_1.REMOVE_AIM_BIAS)

	local var_15_4 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_4, arg_15_0, var_0_2.FLEET_MOVE_TO)

	local var_15_5 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_5, arg_15_0, var_0_2.UPDATE_CARD_TARGET_FILTER)

	local var_15_6 = arg_15_0._leftFleet

	var_1.UnregisterEventListener(var_15_6, arg_15_0, var_0_1.ON_BOARD_CLICK)

	local var_15_7 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_7, arg_15_0, var_0_1.STAGE_DATA_INIT_FINISH)

	local var_15_8 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_8, arg_15_0, var_0_1.ADD_UNIT)

	local var_15_9 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_9, arg_15_0, var_0_1.REMOVE_UNIT)

	local var_15_10 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_10, arg_15_0, var_0_1.REMOVE_BULLET)

	local var_15_11 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_11, arg_15_0, var_0_1.REMOVE_AIR_CRAFT)

	local var_15_12 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_12, arg_15_0, var_0_1.REMOVE_AIR_FIGHTER)

	local var_15_13 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_13, arg_15_0, var_0_1.ADD_AREA)

	local var_15_14 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_14, arg_15_0, var_0_1.REMOVE_AREA)

	local var_15_15 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_15, arg_15_0, var_0_1.ADD_EFFECT)

	local var_15_16 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_16, arg_15_0, var_0_1.ADD_SHELTER)

	local var_15_17 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_17, arg_15_0, var_0_1.REMOVE_SHELTER)

	local var_15_18 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_18, arg_15_0, var_0_1.ANTI_AIR_AREA)

	local var_15_19 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_19, arg_15_0, var_0_1.UPDATE_HOSTILE_SUBMARINE)

	local var_15_20 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_20, arg_15_0, var_0_1.ADD_CAMERA_FX)

	local var_15_21 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_21, arg_15_0, var_0_1.ADD_AIM_BIAS)

	local var_15_22 = arg_15_0._dataProxy

	var_1.UnregisterEventListener(var_15_22, arg_15_0, var_0_1.REMOVE_AIM_BIAS)

	local var_15_23 = arg_15_0._cameraUtil

	var_1.UnregisterEventListener(var_15_23, arg_15_0, var_0_1.CAMERA_FOCUS_RESET)

	local var_15_24 = arg_15_0._cameraUtil

	var_1.UnregisterEventListener(var_15_24, arg_15_0, var_0_1.BULLET_TIME)

	pg = var_1

	local var_15_25 = var_1.CameraFixMgr.GetInstance()

	var_1.disconnect(var_15_25, arg_15_0._camEventId)

	return
end

function var_0_7.onStageInitFinish(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._dataProxy

	arg_16_0._leftFleet = var_2.GetFleetByIFF(var_16_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_16_1 = arg_16_0._leftFleet

	arg_16_0._leftFleetMotion = var_2.GetMotion(var_16_1)

	arg_16_0:InitCamera()

	local var_16_2 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_2, arg_16_0, var_0_1.SONAR_SCAN, arg_16_0.onSonarScan)

	local var_16_3 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_3, arg_16_0, var_0_1.SONAR_UPDATE, arg_16_0.onUpdateHostileSubmarine)

	local var_16_4 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_4, arg_16_0, var_0_1.ADD_AIM_BIAS, arg_16_0.onAddAimBias)

	local var_16_5 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_5, arg_16_0, var_0_1.REMOVE_AIM_BIAS, arg_16_0.onRemoveAimBias)

	local var_16_6 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_6, arg_16_0, var_0_2.FLEET_MOVE_TO, arg_16_0.onUpdateMoveMark)

	local var_16_7 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_7, arg_16_0, var_0_2.ON_BOARD_CLICK, arg_16_0.onBoardClick)

	local var_16_8 = arg_16_0._leftFleet

	var_2.RegisterEventListener(var_16_8, arg_16_0, var_0_2.UPDATE_CARD_TARGET_FILTER, arg_16_0.onUpdateSkillAim)
	arg_16_0:InitPopNumPool()

	return
end

function var_0_7.onAddUnit(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.Data.type
	local var_17_1 = arg_17_0._characterFactoryList[var_17_0]
	local var_17_2 = arg_17_1.Data

	var_17_1:CreateCharacter(var_17_2)

	return
end

function var_0_7.onRemoveUnit(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.Data.UID
	local var_18_1 = arg_18_1.Data.deadReason

	if arg_18_0._characterList[var_18_0] then
		local var_18_2 = var_4:GetFactory()

		var_5.RemoveCharacter(var_18_2, var_4, var_18_1)

		arg_18_0._characterList[var_18_0] = nil
	end

	return
end

function var_0_7.onRemoveAircraft(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.Data.UID

	if arg_19_0._aircraftList[var_19_0] then
		local var_19_1 = var_3:GetFactory()

		var_4.RemoveCharacter(var_19_1, var_3)

		arg_19_0._aircraftList[var_19_0] = nil
	end

	return
end

function var_0_7.onRemoveAirFighter(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.Data.UID

	if arg_20_0._aircraftList[var_20_0] then
		local var_20_1 = var_3:GetFactory()

		var_4.RemoveCharacter(var_20_1, var_3)

		arg_20_0._aircraftList[var_20_0] = nil
	end

	return
end

function var_0_7.onRemoveBullet(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.Data.UID

	arg_21_0:RemoveBullet(var_21_0)

	return
end

function var_0_7.onAddArea(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.Data.FXID
	local var_22_1 = arg_22_1.Data.area

	arg_22_0:AddArea(var_22_1, var_22_0)

	return
end

function var_0_7.onRemoveArea(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.Data.id

	arg_23_0:RemoveArea(var_23_0)

	return
end

function var_0_7.onAddEffect(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.Data.FXID
	local var_24_1 = arg_24_1.Data.position
	local var_24_2 = arg_24_1.Data.localScale

	arg_24_0:AddEffect(var_24_0, var_24_1, var_24_2)

	return
end

function var_0_7.onAddShelter(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.Data.shelter
	local var_25_1 = arg_25_0._fxPool
	local var_25_2, var_25_3 = var_3.GetFX(var_25_1, var_25_0:GetFXID())
	local var_25_4 = var_25_0:GetPosition()

	pg = var_6

	local var_25_5 = var_6.EffectMgr.GetInstance()

	var_6.PlayBattleEffect(var_25_5, var_25_2, var_25_4:Add(var_25_3), true)

	if var_25_0:GetIFF() == var_0_4.FOE_CODE then
		local var_25_6 = var_25_2.transform.localEulerAngles

		var_25_6.y = 180
		var_6.localEulerAngles = var_25_6
	end

	arg_25_0._shelterList[var_25_0:GetUniqueID()] = var_25_2

	return
end

function var_0_7.onRemoveShleter(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.Data.uid

	if arg_26_0._shelterList[var_26_0] then
		local var_26_1 = var_0.Battle.BattleResourceManager.GetInstance()

		var_4.DestroyOb(var_26_1, var_3)

		arg_26_0._shelterList[var_26_0] = nil
	end

	return
end

function var_0_7.onAntiAirArea(arg_27_0, arg_27_1)
	if arg_27_1.Data.isShow ~= nil then
		local var_27_0 = arg_27_0._antiAirArea.gameObject

		var_3.SetActive(var_27_0, arg_27_1.Data.isShow)

		if var_2 == true then
			local var_27_1 = arg_27_0._leftFleet
			local var_27_2 = var_3.GetFleetAntiAirWeapon(var_27_1)
			local var_27_3 = var_3.GetRange(var_27_2) * 2
			local var_27_4 = arg_27_0._antiAirAreaTF

			Vector3 = var_27_2
			var_27_4.localScale = var_27_2(var_27_3, 0, var_27_3)
		end
	end

	return
end

function var_0_7.onAntiAirOverload(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.Dispatcher
	local var_28_1 = arg_28_0._antiAirAreaTF
	local var_28_2 = var_3.Find(var_28_1, "Quad")
	local var_28_3 = var_3.GetComponent

	typeof = var_6
	Animator = var_1_10008

	local var_28_4 = var_28_3(var_28_2, var_6(var_1_10008))

	if var_28_0:IsOverLoad() then
		var_28_4.enabled = false
	else
		var_28_4.enabled = true
	end

	return
end

function var_0_7.onUpdateHostileSubmarine(arg_29_0, arg_29_1)
	arg_29_0:updateSonarView()

	return
end

function var_0_7.updateSonarView(arg_30_0)
	local var_30_0 = arg_30_0._dataProxy
	local var_30_1 = var_1.GetEnemySubmarineCount(var_30_0)

	arg_30_0._sonarActive = 0 < var_30_1
	pairs = var_2

	for iter_30_0, iter_30_1 in var_2(arg_30_0._characterList) do
		iter_30_1:SonarAcitve(var_1)
	end

	local var_30_2 = arg_30_0._leftFleet
	local var_30_3 = var_2.GetFleetSonar(var_30_2)
	local var_30_4 = var_2.GetCurrentState(var_30_3) ~= var_0.Battle.BattleFleetStaticSonar.STATE_DISABLE and var_1
	local var_30_5 = arg_30_0._anitSubArea.gameObject

	var_4.SetActive(var_30_5, var_30_4)

	if var_30_4 then
		local var_30_6 = arg_30_0._leftFleet
		local var_30_7 = var_4.GetFleetSonar(var_30_6)
		local var_30_8 = var_4.GetRange(var_30_7)
		local var_30_9 = arg_30_0._anitSubAreaTF

		Vector3 = var_30_7
		var_30_9.localScale = var_30_7(var_30_8, 0, var_30_8)
	end

	return
end

function var_0_7.onSonarScan(arg_31_0, arg_31_1)
	if arg_31_1.Data.indieSonar then
		local var_31_0 = arg_31_0._fxPool
		local var_31_1 = var_3.GetFX(var_31_0, "AntiSubArea").transform

		Vector3 = var_31_0
		var_31_1.localScale = var_31_0(100, 0, 100)
		SetActive = var_5

		local var_31_2 = var_31_1

		var_5(var_31_1.Find(var_31_2, "static"), false)

		local var_31_3 = var_31_1:Find("Quad")
		local var_31_4 = var_5.GetComponent

		typeof = var_31_2
		Animator = var_1_10011

		local var_31_5 = var_31_4(var_31_3, var_31_2(var_1_10011))

		var_31_5.enabled = true

		var_31_5:Play("antiSubZoom", -1, 0)

		arg_31_0._anitSubAreaTFList[var_31_1] = true

		local var_31_6 = var_5:GetComponent("DftAniEvent")

		var_7.SetEndEvent(var_31_6, function(arg_32_0)
			arg_31_0._anitSubAreaTFList[var_31_1] = nil

			return
		end)
	elseif arg_31_0._antiSubScanAnima and arg_31_0._sonarActive then
		arg_31_0._antiSubScanAnima.enabled = true

		local var_31_7 = arg_31_0._antiSubScanAnima

		var_3.Play(var_31_7, "antiSubZoom", -1, 0)
	end

	return
end

function var_0_7.onAddAimBias(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.Data.aimBias
	local var_33_1 = arg_33_0._fxPool
	local var_33_2 = var_3.GetFX(var_33_1, "AimBiasArea").transform
	local var_33_3 = arg_33_0._aimBiasTFList
	local var_33_4 = {
		tf = var_33_2
	}

	Vector3 = var_1_10007
	var_33_4.vector = var_1_10007(5, 0, 5)
	var_33_3[var_33_0] = var_33_4

	return
end

function var_0_7.onRemoveAimBias(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.Data.aimBias

	if arg_34_0._aimBiasTFList[var_34_0] then
		local var_34_1 = var_3.tf.gameObject
		local var_34_2 = var_0.Battle.BattleResourceManager.GetInstance()

		var_5.DestroyOb(var_34_2, var_34_1)

		arg_34_0._aimBiasTFList[var_34_0] = nil
	end

	return
end

function var_0_7.onUpdateMoveMark(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.Data.pos

	if not arg_35_0._moveMarkFXTF then
		local var_35_1 = arg_35_0._fxPool

		arg_35_0._moveMarkFX = var_35_2.GetFX(var_35_1, "kapai_weizhi")
		arg_35_0._moveMarkFXTF = arg_35_0._moveMarkFX.transform
	end

	local var_35_2

	if var_35_0 then
		setActive = var_35_2

		var_35_2(arg_35_0._moveMarkFXTF, true)

		var_35_2 = arg_35_0._moveMarkFXTF
		var_35_2.position = var_35_0
	else
		setActive = var_35_2

		var_35_2(arg_35_0._moveMarkFXTF, false)
	end

	return
end

function var_0_7.onBoardClick(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.Data.click
	local var_36_1 = arg_36_0._leftFleet
	local var_36_2 = var_4.GetCardPuzzleComponent(var_36_1)
	local var_36_3 = var_4.GetTouchScreenPoint(var_36_2)

	if var_36_0 == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_CLICK then
		local var_36_4 = arg_36_0._fxPool

		arg_36_0._clickMarkFxTF = var_5.GetFX(var_36_4, "kapai_weizhi").transform
		arg_36_0._clickMarkFxTF.position = var_36_3
	elseif var_36_0 == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_DRAG then
		arg_36_0._clickMarkFxTF.position = var_36_3
	elseif var_36_0 == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_RELEASE and arg_36_0._clickMarkFxTF then
		local var_36_5 = var_0.Battle.BattleResourceManager.GetInstance()

		var_5.DestroyOb(var_36_5, arg_36_0._clickMarkFxTF.gameObject)
	end

	return
end

function var_0_7.onCameraFocusReset(arg_37_0, arg_37_1)
	arg_37_0:ResetFocus()

	return
end

function var_0_7.onAddCameraFX(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.Data.FXID
	local var_38_1 = arg_38_1.Data.position
	local var_38_2 = arg_38_1.Data.localScale
	local var_38_3 = arg_38_1.Data.orderDiff

	arg_38_0:AddCameraFX(var_38_3, var_38_0, var_38_1, var_38_2)

	return
end

function var_0_7.AddCameraFX(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = arg_39_0._fxPool
	local var_39_1 = var_5.GetFX(var_39_0, arg_39_2)
	local var_39_2 = arg_39_0._cameraUtil
	local var_39_3 = var_6.Add2Camera(var_39_2, var_39_1, arg_39_1)

	arg_39_4 = arg_39_4 or 1

	local var_39_4 = var_39_1.transform

	Vector3 = var_39_2
	var_39_4.localScale = var_39_2(arg_39_4 / var_39_3.x, arg_39_4 / var_39_3.y, arg_39_4 / var_39_3.z)
	pg = var_39_4

	local var_39_5 = var_39_4.EffectMgr.GetInstance()

	var_7.PlayBattleEffect(var_39_5, var_39_1, arg_39_3, true)

	return
end

function var_0_7.onUpdateSkillAim(arg_40_0, arg_40_1)
	arg_40_0._cardAimTargetFilter = arg_40_1.Data.targetFilterList

	return
end

function var_0_7.Update(arg_41_0)
	pairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0._characterList) do
		iter_41_1:Update()
	end

	pairs = var_1

	for iter_41_2, iter_41_3 in var_1(arg_41_0._aircraftList) do
		iter_41_3:Update()
	end

	pairs = var_1

	for iter_41_4, iter_41_5 in var_1(arg_41_0._bulletList) do
		iter_41_5:Update()
	end

	pairs = var_1

	for iter_41_6, iter_41_7 in var_1(arg_41_0._areaList) do
		iter_41_7:Update()
	end

	ipairs = var_1

	for iter_41_8, iter_41_9 in var_1(arg_41_0._arcEffectList) do
		iter_41_9:Update()
	end

	arg_41_0:updateCardAim()
	arg_41_0:UpdateAntiAirArea()
	arg_41_0:UpdateAimBiasArea()
	arg_41_0:UpdateFlagShipMark()

	return
end

function var_0_7.UpdatePause(arg_42_0)
	pairs = var_1_10001

	for iter_42_0, iter_42_1 in var_1_10001(arg_42_0._characterList) do
		iter_42_1:UpdateUIComponentPosition()
		iter_42_1:UpdateHPBarPosition()
	end

	pairs = var_1

	for iter_42_2, iter_42_3 in var_1(arg_42_0._aircraftList) do
		iter_42_3:UpdateUIComponentPosition()

		local var_42_0 = iter_42_3:GetUnitData()

		if var_6.GetUniqueID(var_42_0) == var_0_4.FOE_CODE then
			iter_42_3:UpdateHPBarPosition()
		end
	end

	arg_42_0:UpdateFlagShipMark()

	return
end

function var_0_7.UpdateEscapeOnly(arg_43_0, arg_43_1)
	pairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_0._characterList) do
		if iter_43_1.__name == var_0.Battle.BattleEnemyCharacter.__name or iter_43_1.__name == var_0.Battle.BattleBossCharacter.__name then
			iter_43_1:Update(arg_43_1)
		end
	end

	return
end

function var_0_7.Pause(arg_44_0)
	arg_44_0:PauseCharacterAction(true)

	pairs = var_1

	for iter_44_0, iter_44_1 in var_1(arg_44_0._areaList) do
		local var_44_0 = iter_44_1._go
		local var_44_1 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_44_11

		local var_44_2 = var_44_1(var_44_0, var_1_10009(iter_44_11))
		local var_44_3 = var_6.ToTable(var_44_2)

		ipairs = var_1_10007

		for iter_44_2, iter_44_11 in var_1_10007(var_44_3) do
			iter_44_11:Pause()
		end
	end

	local var_44_4 = arg_44_0._cameraUtil

	var_1.PauseShake(var_44_4)

	ipairs = var_1

	for iter_44_4, iter_44_5 in var_1(arg_44_0._arcEffectList) do
		local var_44_5 = iter_44_5._go
		local var_44_6 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_44_11

		local var_44_7 = var_44_6(var_44_5, var_1_10009(iter_44_11))
		local var_44_8 = var_6.ToTable(var_44_7)

		ipairs = var_1_10007

		for iter_44_6, iter_44_11 in var_1_10007(var_44_8) do
			iter_44_11:Pause()
		end
	end

	pairs = var_1

	for iter_44_8, iter_44_9 in var_1(arg_44_0._particleBulletList) do
		local var_44_9 = iter_44_8._go
		local var_44_10 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_44_11

		local var_44_11 = var_44_10(var_44_9, var_1_10009(iter_44_11))
		local var_44_12 = var_6.ToTable(var_44_11)

		ipairs = var_1_10007

		for iter_44_10, iter_44_11 in var_1_10007(var_44_12) do
			iter_44_11:Pause()
		end
	end

	return
end

function var_0_7.Resume(arg_45_0)
	arg_45_0:PauseCharacterAction(false)

	pairs = var_1

	for iter_45_0, iter_45_1 in var_1(arg_45_0._areaList) do
		local var_45_0 = iter_45_1._go
		local var_45_1 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_45_11

		local var_45_2 = var_45_1(var_45_0, var_1_10009(iter_45_11))
		local var_45_3 = var_6.ToTable(var_45_2)

		ipairs = var_1_10007

		for iter_45_2, iter_45_11 in var_1_10007(var_45_3) do
			iter_45_11:Pause()
		end
	end

	local var_45_4 = arg_45_0._cameraUtil

	var_1.ResumeShake(var_45_4)

	ipairs = var_1

	for iter_45_4, iter_45_5 in var_1(arg_45_0._arcEffectList) do
		local var_45_5 = iter_45_5._go
		local var_45_6 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_45_11

		local var_45_7 = var_45_6(var_45_5, var_1_10009(iter_45_11))
		local var_45_8 = var_6.ToTable(var_45_7)

		ipairs = var_1_10007

		for iter_45_6, iter_45_11 in var_1_10007(var_45_8) do
			iter_45_11:Pause()
		end
	end

	pairs = var_1

	for iter_45_8, iter_45_9 in var_1(arg_45_0._particleBulletList) do
		local var_45_9 = iter_45_8._go
		local var_45_10 = var_6.GetComponentsInChildren

		typeof = var_1_10009
		ParticleSystem = iter_45_11

		local var_45_11 = var_45_10(var_45_9, var_1_10009(iter_45_11))
		local var_45_12 = var_6.ToTable(var_45_11)

		ipairs = var_1_10007

		for iter_45_10, iter_45_11 in var_1_10007(var_45_12) do
			iter_45_11:Pause()
		end
	end

	return
end

function var_0_7.onBulletTime(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_1.Data.key

	if var_2.speed then
		local var_46_1 = var_2.exemptUnit
		local var_46_2 = var_5.GetUniqueID(var_46_1)

		var_0_5.AppendIFFFactor(var_0_4.FOE_CODE, var_46_0, var_4)
		var_0_5.AppendIFFFactor(var_0_4.FRIENDLY_CODE, var_46_0, var_4)

		pairs = var_6

		for iter_46_0, iter_46_1 in var_6(arg_46_0._characterList) do
			if iter_46_0 == var_46_2 then
				iter_46_1:SetAnimaSpeed(1 / var_4)

				break
			end
		end
	else
		var_0_5.RemoveIFFFactor(var_0_4.FOE_CODE, var_46_0)
		var_0_5.RemoveIFFFactor(var_0_4.FRIENDLY_CODE, var_46_0)

		pairs = var_5

		for iter_46_2, iter_46_3 in var_5(arg_46_0._characterList) do
			iter_46_3:SetAnimaSpeed(1)
		end

		pairs = var_5

		for iter_46_4, iter_46_5 in var_5(arg_46_0._bulletList) do
			iter_46_5:SetAnimaSpeed(1)
		end
	end

	return
end

function var_0_7.ResetFocus(arg_47_0)
	var_0_5.RemoveIFFFactor(var_0_4.FOE_CODE, var_0_4.SPEED_FACTOR_FOCUS_CHARACTER)
	var_0_5.RemoveIFFFactor(var_0_4.FRIENDLY_CODE, var_0_4.SPEED_FACTOR_FOCUS_CHARACTER)

	pairs = var_1

	for iter_47_0, iter_47_1 in var_1(arg_47_0._characterList) do
		iter_47_1:SetAnimaSpeed(1)
	end

	pairs = var_1

	for iter_47_2, iter_47_3 in var_1(arg_47_0._bulletList) do
		iter_47_3:SetAnimaSpeed(1)
	end

	local var_47_0 = arg_47_0._cameraUtil

	var_1.ZoomCamara(var_47_0, nil, nil, var_0_4.CAM_RESET_DURATION)

	return
end

function var_0_7.UpdateFlagShipMark(arg_48_0)
	local var_48_0 = arg_48_0.FlagShipUIPos
	local var_48_1 = var_1.Copy
	local var_48_2 = arg_48_0._leftFleetMotion
	local var_48_3 = var_48_1(var_48_0, var_4.GetPos(var_48_2))
	local var_48_4 = arg_48_0._goFlagShipMarkTf
	local var_48_5 = var_0_5.CameraPosToUICamera(var_48_3)

	var_48_4.position = var_3.Add(var_48_5, var_0_8)

	return
end

function var_0_7.UpdateAntiAirArea(arg_49_0)
	local var_49_0 = arg_49_0._antiAirAreaTF
	local var_49_1 = arg_49_0._leftFleetMotion

	var_49_0.position = var_2.GetPos(var_49_1)
	pairs = var_49_0

	for iter_49_0, iter_49_1 in var_49_0(arg_49_0._anitSubAreaTFList) do
		local var_49_2 = arg_49_0._leftFleetMotion

		iter_49_0.position = var_6.GetPos(var_49_2)
	end

	return
end

function var_0_7.UpdateAimBiasArea(arg_50_0)
	pairs = var_1_10001

	for iter_50_0, iter_50_1 in var_1_10001(arg_50_0._aimBiasTFList) do
		local var_50_0 = iter_50_1.tf
		local var_50_1 = iter_50_1.vector
		local var_50_2 = iter_50_1.cacheState
		local var_50_3 = iter_50_0
		local var_50_4 = iter_50_0.GetRange(var_50_3) * 2

		var_50_1:Set(var_50_4, 0, var_50_4)

		var_50_0.position = iter_50_0:GetPosition()
		var_50_0.localScale = var_50_1

		if iter_50_0:GetCurrentState() ~= var_50_2 then
			setActive = var_50_3

			var_50_3(var_50_0:Find("suofang/Quad"), var_10 ~= iter_50_0.STATE_SKILL_EXPOSE)
		end

		iter_50_1.cacheState = var_10
	end

	return
end

function var_0_7.updateCardAim(arg_51_0)
	local var_51_0 = {}

	pairs = var_1_10002

	for iter_51_0, iter_51_1 in var_1_10002(arg_51_0._cardAimTargetFilter) do
		local var_51_1 = var_0_6.TargetFleetIndex(nil, {
			fleetPos = iter_51_0
		})[1]

		ipairs = var_1_10008

		for iter_51_2, iter_51_3 in var_1_10008(iter_51_1) do
			local var_51_2

			ipairs = var_1_10014

			for iter_51_4, iter_51_5 in var_1_10014(iter_51_3) do
				var_51_2 = var_0_6[iter_51_5](var_51_1, nil, var_51_2)
			end

			ipairs = var_1_10014

			for iter_51_6, iter_51_7 in var_1_10014(var_51_2) do
				var_51_0[iter_51_7:GetUniqueID()] = true
			end
		end
	end

	pairs = var_2

	for iter_51_8, iter_51_9 in var_2(arg_51_0._cardAimTargetList) do
		if not var_51_0[iter_51_8] then
			Object = var_7

			local var_51_3 = var_7.Destroy

			go = var_1_10009

			var_51_3(var_1_10009(iter_51_9))

			arg_51_0._cardAimTargetList[iter_51_8] = nil
		end
	end

	pairs = var_2

	for iter_51_10, iter_51_11 in var_2(var_51_0) do
		local var_51_4

		if not arg_51_0._cardAimTargetList[iter_51_10] then
			var_51_4 = arg_51_0:InstantiateCharacterComponent("SkillAimContainer/SkillAim").transform
		end

		arg_51_0._cardAimTargetList[iter_51_10] = var_51_4

		if arg_51_0._characterList[iter_51_10] then
			var_51_4.position = var_8:GetReferenceVector(var_8.AIM_OFFSET)
		end
	end

	return
end

function var_0_7.AddBullet(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1:GetBulletData()

	arg_52_0._bulletList[var_52_0:GetUniqueID()] = arg_52_1

	if arg_52_1:GetGO() then
		local var_52_1 = var_3
		local var_52_2 = var_3.GetComponent

		typeof = var_1_10007
		ParticleSystem = var_1_10009

		if var_52_2(var_52_1, var_1_10007(var_1_10009)) then
			arg_52_0._particleBulletList[arg_52_1] = true
		end
	end

	if var_0_5.focusExemptList[var_52_0:GetSpeedExemptKey()] then
		local var_52_3 = arg_52_0._state
		local var_52_4 = var_4.GetTimeScaleRate(var_52_3)

		arg_52_1:SetAnimaSpeed(1 / var_52_4)
	end

	return
end

function var_0_7.RemoveBullet(arg_53_0, arg_53_1)
	if arg_53_0._bulletList[arg_53_1] then
		arg_53_0._particleBulletList[var_2] = nil

		local var_53_0 = var_2:GetFactory()

		var_3.RemoveBullet(var_53_0, var_2)
	end

	arg_53_0._bulletList[arg_53_1] = nil

	return
end

function var_0_7.GetBulletRoot(arg_54_0)
	return arg_54_0._bulletContainer
end

function var_0_7.EnablePopContainer(arg_55_0, arg_55_1, arg_55_2)
	setActive = var_1_10003

	local var_55_0 = arg_55_0._state
	local var_55_1 = var_5.GetUI(var_55_0)._tf

	var_1_10003(var_5.Find(var_55_1, arg_55_1), arg_55_2)

	return
end

function var_0_7.AddPlayerCharacter(arg_56_0, arg_56_1)
	arg_56_0:AppendCharacter(arg_56_1)

	local var_56_0 = arg_56_0._dataProxy
	local var_56_1 = var_2.GetInitData(var_56_0).battleType
	local var_56_2 = arg_56_1:GetUnitData()
	local var_56_3 = var_3.IsMainFleetUnit(var_56_2)

	SYSTEM_DUEL = var_56_0

	if var_56_1 == var_56_0 then
		goto label_56_0
	end

	SYSTEM_SUBMARINE_RUN = var_56_0

	if var_56_1 ~= var_56_0 then
		SYSTEM_SUB_ROUTINE = var_56_0

		if var_56_1 == var_56_0 then
			arg_56_1:SetBarHidden(false, false)
		else
			arg_56_1:SetBarHidden(not var_56_3, var_56_3)
		end

		::label_56_0::

		return
	end
end

function var_0_7.AddEnemyCharacter(arg_57_0, arg_57_1)
	arg_57_0:AppendCharacter(arg_57_1)

	return
end

function var_0_7.AppendCharacter(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_1:GetUnitData()

	arg_58_0._characterList[var_58_0:GetUniqueID()] = arg_58_1

	return
end

function var_0_7.InstantiateCharacterComponent(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._state
	local var_59_1 = var_2.GetUI(var_59_0)._tf
	local var_59_2 = var_3.Find(var_59_1, arg_59_1)

	cloneTplTo = var_59_0

	return var_59_0(var_59_2, var_59_2.parent).gameObject
end

function var_0_7.GetCharacterList(arg_60_0)
	return arg_60_0._characterList
end

function var_0_7.GetPopNumPool(arg_61_0)
	return arg_61_0._popNumMgr
end

function var_0_7.PauseCharacterAction(arg_62_0, arg_62_1)
	pairs = var_1_10002

	for iter_62_0, iter_62_1 in var_1_10002(arg_62_0._characterList) do
		iter_62_1:PauseActionAnimation(arg_62_1)
	end

	return
end

function var_0_7.GetCharacter(arg_63_0, arg_63_1)
	return arg_63_0._characterList[arg_63_1]
end

function var_0_7.GetAircraft(arg_64_0, arg_64_1)
	return arg_64_0._aircraftList[arg_64_1]
end

function var_0_7.AddAirCraftCharacter(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_1:GetUnitData()

	arg_65_0._aircraftList[var_65_0:GetUniqueID()] = arg_65_1

	return
end

function var_0_7.AddArea(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = arg_66_0._fxPool
	local var_66_1 = var_3.GetFX(var_66_0, arg_66_2)

	pg = var_1_10004

	local var_66_2 = var_1_10004.effect_offset[arg_66_2]
	local var_66_3 = false

	if var_66_2 and var_66_2.top_cover_offset == true then
		var_66_3 = true
	end

	local var_66_4 = var_0.Battle.BattleEffectArea.New(var_66_1, arg_66_1, var_66_3)

	arg_66_0._areaList[arg_66_1:GetUniqueID()] = var_66_4

	return
end

function var_0_7.RemoveArea(arg_67_0, arg_67_1)
	if arg_67_0._areaList[arg_67_1] then
		local var_67_0 = arg_67_0._areaList[arg_67_1]

		var_2.Dispose(var_67_0)

		arg_67_0._areaList[arg_67_1] = nil
	end

	return
end

function var_0_7.AddEffect(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = arg_68_0._fxPool
	local var_68_1 = var_4.GetFX(var_68_0, arg_68_1)

	arg_68_3 = arg_68_3 or 1

	local var_68_2 = var_68_1.transform

	Vector3 = var_68_0
	var_68_2.localScale = var_68_0(arg_68_3, 1, arg_68_3)
	pg = var_68_2

	local var_68_3 = var_68_2.EffectMgr.GetInstance()

	var_5.PlayBattleEffect(var_68_3, var_68_1, arg_68_2, true)

	return
end

function var_0_7.AddArcEffect(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_0 = arg_69_0._fxPool
	local var_69_1 = var_5.GetFX(var_69_0, arg_69_1)
	local var_69_2 = var_0.Battle.BattleArcEffect.New(var_69_1, arg_69_2, arg_69_3, arg_69_4)

	local function var_69_3()
		local var_70_0 = arg_69_0

		var_0.RemoveArcEffect(var_70_0, var_69_2)

		return
	end

	var_69_2:ConfigCallback(var_69_3)

	table = var_8

	var_8.insert(arg_69_0._arcEffectList, var_69_2)

	return
end

function var_0_7.RemoveArcEffect(arg_71_0, arg_71_1)
	ipairs = var_1_10002

	for iter_71_0, iter_71_1 in var_1_10002(arg_71_0._arcEffectList) do
		if iter_71_1 == arg_71_1 then
			iter_71_1:Dispose()

			table = var_7

			var_7.remove(arg_71_0._arcEffectList, iter_71_0)

			break
		end
	end

	return
end

function var_0_7.Reinitialize(arg_72_0)
	arg_72_0:Clear()
	arg_72_0:Init()

	return
end

function var_0_7.AllBulletNeutralize(arg_73_0)
	pairs = var_1_10001

	for iter_73_0, iter_73_1 in var_1_10001(arg_73_0._characterList) do
		if iter_73_1.__name == var_0.Battle.BattlePlayerCharacter.__name or iter_73_1.__name == var_0.Battle.BattleSubCharacter.__name then
			iter_73_1:DisableWeaponTrack()
		end
	end

	local var_73_0 = arg_73_0._antiAirArea

	var_1.SetActive(var_73_0, false)

	local var_73_1 = 0

	pairs = var_2

	for iter_73_2, iter_73_3 in var_2(arg_73_0._bulletList) do
		var_73_1 = var_73_1 + 1

		iter_73_3:Neutrailze()
	end

	var_0.Battle.BattleBulletFactory.NeutralizeBullet()

	return
end

function var_0_7.Clear(arg_74_0)
	pairs = var_1_10001

	for iter_74_0, iter_74_1 in var_1_10001(arg_74_0._characterList) do
		local var_74_0 = iter_74_1:GetFactory()

		var_6.RemoveCharacter(var_74_0, iter_74_1)
	end

	pairs = var_1

	for iter_74_2, iter_74_3 in var_1(arg_74_0._aircraftList) do
		local var_74_1 = iter_74_3:GetFactory()

		var_6.RemoveCharacter(var_74_1, iter_74_3)
	end

	arg_74_0._characterList = nil
	arg_74_0._characterFactoryList = nil
	pairs = var_1

	for iter_74_4, iter_74_5 in var_1(arg_74_0._bulletList) do
		arg_74_0:RemoveBullet(iter_74_4)
	end

	local var_74_2 = var_0.Battle.BattleBulletFactory.GetFactoryList()

	pairs = var_2

	for iter_74_6, iter_74_7 in var_2(var_74_2) do
		var_1_10009 = iter_74_7

		iter_74_7.Clear(var_1_10009)
	end

	local var_74_3 = arg_74_0._fxPool

	var_2.Clear(var_74_3)

	pairs = var_2

	for iter_74_8, iter_74_9 in var_2(arg_74_0._areaList) do
		var_1_10009 = arg_74_0

		arg_74_0.RemoveArea(var_1_10009, iter_74_8)
	end

	arg_74_0._areaList = nil
	ipairs = var_2

	for iter_74_10, iter_74_11 in var_2(arg_74_0._arcEffectList) do
		var_1_10009 = iter_74_11

		iter_74_11.Dispose(var_1_10009)
	end

	arg_74_0._arcEffectList = nil
	pairs = var_2

	for iter_74_12, iter_74_13 in var_2(arg_74_0._cardAimTargetList) do
		Object = var_1_10007
		var_1_10007 = var_1_10007.Destroy
		go = var_1_10009

		var_1_10007(var_1_10009(iter_74_13))
	end

	arg_74_0._cardAimTargetList = nil

	local var_74_4 = var_0.Battle.BattleCharacterFXContainersPool.GetInstance()

	var_2.Clear(var_74_4)

	local var_74_5 = arg_74_0._popNumMgr

	var_2.Clear(var_74_5)

	local var_74_6 = var_0.Battle.BattleHPBarManager.GetInstance()

	var_2.Clear(var_74_6)

	local var_74_7 = var_0.Battle.BattleArrowManager.GetInstance()

	var_2.Clear(var_74_7)

	arg_74_0._anitSubAreaTFList = nil

	return
end

function var_0_7.Dispose(arg_75_0)
	arg_75_0:Clear()
	arg_75_0:RemoveEvent()
	var_0_7.super.Dispose(arg_75_0)

	return
end

return
