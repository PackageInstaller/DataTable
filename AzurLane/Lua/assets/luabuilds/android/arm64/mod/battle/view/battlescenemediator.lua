ys = ys or {}

local var_0_0 = ys.Battle.BattleEvent
local var_0_1 = ys.Battle.BattleCardPuzzleEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleVariable
local var_0_5 = ys.Battle.BattleTargetChoise
local var_0_6 = class("BattleSceneMediator", ys.MVC.Mediator)

ys.Battle.BattleSceneMediator = var_0_6
var_0_6.__name = "BattleSceneMediator"

local var_0_7 = Vector3(0, 0.8, 0)

function var_0_6.Ctor(arg_1_0)
	var_0_6.super.Ctor(arg_1_0)

	arg_1_0.FlagShipUIPos = Vector3.zero

	return
end

function var_0_6.Initialize(arg_2_0)
	var_0_6.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitCharacterFactory()
	arg_2_0:Init()
	arg_2_0:AddEvent()

	return
end

function var_0_6.Init(arg_3_0)
	arg_3_0._characterList = {}
	arg_3_0._bulletList = {}
	arg_3_0._particleBulletList = {}
	arg_3_0._aircraftList = {}
	arg_3_0._areaList = {}
	arg_3_0._shelterList = {}
	arg_3_0._arcEffectList = {}
	arg_3_0._bulletContainer = GameObject.Find("BulletContainer")
	arg_3_0._fxPool = var_0.Battle.BattleFXPool.GetInstance()
	arg_3_0._aimBiasTFList = {}

	var_0.Battle.BattleCharacterFXContainersPool.GetInstance():Init()
	arg_3_0:InitPlayerAntiAirArea()
	arg_3_0:InitPlayerAntiSubArea()
	arg_3_0:InitFlagShipMark()
	arg_3_0:InitSkillAim()
	pg.CameraFixMgr.GetInstance():Adapt()

	return
end

function var_0_6.InitCamera(arg_4_0)
	arg_4_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

	arg_4_0._cameraUtil:RegisterEventListener(arg_4_0, var_0_0.CAMERA_FOCUS_RESET, arg_4_0.onCameraFocusReset)
	arg_4_0._cameraUtil:RegisterEventListener(arg_4_0, var_0_0.BULLET_TIME, arg_4_0.onBulletTime)

	return
end

function var_0_6.InitPopNumPool(arg_5_0)
	arg_5_0._popNumMgr = var_0.Battle.BattlePopNumManager.GetInstance()

	local var_5_0 = arg_5_0._state:GetUI()

	if arg_5_0._dataProxy:GetInitData().battleType == SYSTEM_DODGEM then
		arg_5_0._popNumMgr:InitialScorePool(var_5_0._tf:Find(var_0.Battle.BattlePopNumManager.CONTAINER_CHARACTER_HP .. "/container"))
	else
		arg_5_0._popNumMgr:InitialBundlePool(var_5_0._tf:Find(var_0.Battle.BattlePopNumManager.CONTAINER_CHARACTER_HP .. "/container"))
	end

	return
end

function var_0_6.InitFlagShipMark(arg_6_0)
	local var_6_0 = arg_6_0._state:GetUI()._tf:Find("flagShipMark").gameObject

	var_6_0:SetActive(true)

	arg_6_0._goFlagShipMarkTf = var_6_0.transform

	return
end

function var_0_6.InitSkillAim(arg_7_0)
	arg_7_0._cardAimTargetFilter = {}
	arg_7_0._cardAimTargetList = {}

	return
end

function var_0_6.InitCharacterFactory(arg_8_0)
	local var_8_0 = arg_8_0._state:GetUI()

	var_0.Battle.BattleHPBarManager.GetInstance():InitialPoolRoot(var_8_0._tf:Find(var_0.Battle.BattleHPBarManager.ROOT_NAME))
	var_0.Battle.BattleArrowManager.GetInstance():Init(var_8_0._tf:Find(var_0.Battle.BattleArrowManager.ROOT_NAME))

	arg_8_0._characterFactoryList = {
		[var_0_2.UnitType.PLAYER_UNIT] = var_0.Battle.BattlePlayerCharacterFactory.GetInstance(),
		[var_0_2.UnitType.ENEMY_UNIT] = var_0.Battle.BattleEnemyCharacterFactory.GetInstance(),
		[var_0_2.UnitType.MINION_UNIT] = var_0.Battle.BattleMinionCharacterFactory.GetInstance(),
		[var_0_2.UnitType.BOSS_UNIT] = var_0.Battle.BattleBossCharacterFactory.GetInstance(),
		[var_0_2.UnitType.AIRCRAFT_UNIT] = var_0.Battle.BattleAircraftCharacterFactory.GetInstance(),
		[var_0_2.UnitType.AIRFIGHTER_UNIT] = var_0.Battle.BattleAirFighterCharacterFactory.GetInstance(),
		[var_0_2.UnitType.SUB_UNIT] = var_0.Battle.BattleSubCharacterFactory.GetInstance(),
		[var_0_2.UnitType.SUPPORT_UNIT] = var_0.Battle.BattleSupportCharacterFactory.GetInstance()
	}

	return
end

function var_0_6.InitPlayerAntiAirArea(arg_9_0)
	arg_9_0._antiAirArea = arg_9_0._fxPool:GetFX("AntiAirArea")
	arg_9_0._antiAirAreaTF = arg_9_0._antiAirArea.transform

	arg_9_0._antiAirArea:SetActive(false)

	return
end

function var_0_6.InitPlayerAntiSubArea(arg_10_0)
	arg_10_0._anitSubArea = arg_10_0._fxPool:GetFX("AntiSubArea")
	arg_10_0._anitSubAreaTF = arg_10_0._anitSubArea.transform

	arg_10_0._anitSubArea:SetActive(false)

	arg_10_0._antiSubScanAnima = arg_10_0._anitSubAreaTF:Find("Quad"):GetComponent(typeof(Animator))
	arg_10_0._anitSubAreaTFList = {}
	arg_10_0._anitSubAreaTFList[arg_10_0._anitSubAreaTF] = true

	return
end

function var_0_6.InitDetailAntiSubArea(arg_11_0)
	local var_11_0, var_11_1, var_11_2, var_11_3 = arg_11_0._leftFleet:GetFleetSonar():GetTotalRangeDetail()

	;(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_11_0._fxPool:GetFX("AntiSubArea")

		var_12_0.name = arg_12_2
		var_12_0.transform.localScale = Vector3(arg_12_0, 0, arg_12_0)
		var_12_0.transform:Find("static"):GetComponent("SpriteRenderer").color = arg_12_1

		var_12_0:SetActive(true)

		arg_11_0._anitSubAreaTFList[var_12_0.transform] = true

		return
	end)(var_11_0 + var_11_1 + var_11_2 + var_11_3, Color.New(1, 1, 1, 1), "技能额外直径：" .. var_11_3)
	;(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_11_0._fxPool:GetFX("AntiSubArea")

		var_12_0.name = arg_12_2
		var_12_0.transform.localScale = Vector3(arg_12_0, 0, arg_12_0)
		var_12_0.transform:Find("static"):GetComponent("SpriteRenderer").color = arg_12_1

		var_12_0:SetActive(true)

		arg_11_0._anitSubAreaTFList[var_12_0.transform] = true

		return
	end)(var_11_0 + var_11_1 + var_11_2, Color.New(0.07, 1, 0, 1), "装备提供直径：" .. var_11_2)
	;(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_11_0._fxPool:GetFX("AntiSubArea")

		var_12_0.name = arg_12_2
		var_12_0.transform.localScale = Vector3(arg_12_0, 0, arg_12_0)
		var_12_0.transform:Find("static"):GetComponent("SpriteRenderer").color = arg_12_1

		var_12_0:SetActive(true)

		arg_11_0._anitSubAreaTFList[var_12_0.transform] = true

		return
	end)(var_11_0 + var_11_1, Color.New(1, 0.32, 0, 1), "主力提供直径：" .. var_11_1)
	;(function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_11_0._fxPool:GetFX("AntiSubArea")

		var_12_0.name = arg_12_2
		var_12_0.transform.localScale = Vector3(arg_12_0, 0, arg_12_0)
		var_12_0.transform:Find("static"):GetComponent("SpriteRenderer").color = arg_12_1

		var_12_0:SetActive(true)

		arg_11_0._anitSubAreaTFList[var_12_0.transform] = true

		return
	end)(var_11_0, Color.New(1, 0, 0, 1), "基础直径：" .. var_11_0)

	return
end

function var_0_6.AddEvent(arg_13_0)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.STAGE_DATA_INIT_FINISH, arg_13_0.onStageInitFinish)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_UNIT, arg_13_0.onAddUnit)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_UNIT, arg_13_0.onRemoveUnit)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_BULLET, arg_13_0.onRemoveBullet)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_AIR_CRAFT, arg_13_0.onRemoveAircraft)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_AIR_FIGHTER, arg_13_0.onRemoveAirFighter)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_AREA, arg_13_0.onAddArea)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_AREA, arg_13_0.onRemoveArea)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_EFFECT, arg_13_0.onAddEffect)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_SHELTER, arg_13_0.onAddShelter)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_SHELTER, arg_13_0.onRemoveShleter)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ANTI_AIR_AREA, arg_13_0.onAntiAirArea)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.UPDATE_HOSTILE_SUBMARINE, arg_13_0.onUpdateHostileSubmarine)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_CAMERA_FX, arg_13_0.onAddCameraFX)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.ADD_AIM_BIAS, arg_13_0.onAddAimBias)
	arg_13_0._dataProxy:RegisterEventListener(arg_13_0, var_0_0.REMOVE_AIM_BIAS, arg_13_0.onRemoveAimBias)

	arg_13_0._camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function()
		arg_13_0._dataProxy:OnCameraRatioUpdate()

		return
	end)

	return
end

function var_0_6.RemoveEvent(arg_15_0)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_0.SONAR_SCAN)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_0.SONAR_UPDATE)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_0.ADD_AIM_BIAS)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_AIM_BIAS)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_1.FLEET_MOVE_TO)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_1.UPDATE_CARD_TARGET_FILTER)
	arg_15_0._leftFleet:UnregisterEventListener(arg_15_0, var_0_0.ON_BOARD_CLICK)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.STAGE_DATA_INIT_FINISH)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_UNIT)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_UNIT)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_BULLET)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_AIR_CRAFT)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_AIR_FIGHTER)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_AREA)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_AREA)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_EFFECT)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_SHELTER)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_SHELTER)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ANTI_AIR_AREA)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.UPDATE_HOSTILE_SUBMARINE)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_CAMERA_FX)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.ADD_AIM_BIAS)
	arg_15_0._dataProxy:UnregisterEventListener(arg_15_0, var_0_0.REMOVE_AIM_BIAS)
	arg_15_0._cameraUtil:UnregisterEventListener(arg_15_0, var_0_0.CAMERA_FOCUS_RESET)
	arg_15_0._cameraUtil:UnregisterEventListener(arg_15_0, var_0_0.BULLET_TIME)
	pg.CameraFixMgr.GetInstance():disconnect(arg_15_0._camEventId)

	return
end

function var_0_6.onStageInitFinish(arg_16_0, arg_16_1)
	arg_16_0._leftFleet = arg_16_0._dataProxy:GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)
	arg_16_0._leftFleetMotion = arg_16_0._leftFleet:GetMotion()

	arg_16_0:InitCamera()
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_0.SONAR_SCAN, arg_16_0.onSonarScan)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_0.SONAR_UPDATE, arg_16_0.onUpdateHostileSubmarine)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_0.ADD_AIM_BIAS, arg_16_0.onAddAimBias)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_0.REMOVE_AIM_BIAS, arg_16_0.onRemoveAimBias)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_1.FLEET_MOVE_TO, arg_16_0.onUpdateMoveMark)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_1.ON_BOARD_CLICK, arg_16_0.onBoardClick)
	arg_16_0._leftFleet:RegisterEventListener(arg_16_0, var_0_1.UPDATE_CARD_TARGET_FILTER, arg_16_0.onUpdateSkillAim)
	arg_16_0:InitPopNumPool()

	return
end

function var_0_6.onAddUnit(arg_17_0, arg_17_1)
	arg_17_0._characterFactoryList[arg_17_1.Data.type]:CreateCharacter(arg_17_1.Data)

	return
end

function var_0_6.onRemoveUnit(arg_18_0, arg_18_1)
	if arg_18_0._characterList[arg_18_1.Data.UID] then
		arg_18_0._characterList[arg_18_1.Data.UID]:GetFactory():RemoveCharacter(arg_18_0._characterList[arg_18_1.Data.UID], arg_18_1.Data.deadReason)

		arg_18_0._characterList[arg_18_1.Data.UID] = nil
	end

	return
end

function var_0_6.onRemoveAircraft(arg_19_0, arg_19_1)
	if arg_19_0._aircraftList[arg_19_1.Data.UID] then
		arg_19_0._aircraftList[arg_19_1.Data.UID]:GetFactory():RemoveCharacter(arg_19_0._aircraftList[arg_19_1.Data.UID])

		arg_19_0._aircraftList[arg_19_1.Data.UID] = nil
	end

	return
end

function var_0_6.onRemoveAirFighter(arg_20_0, arg_20_1)
	if arg_20_0._aircraftList[arg_20_1.Data.UID] then
		arg_20_0._aircraftList[arg_20_1.Data.UID]:GetFactory():RemoveCharacter(arg_20_0._aircraftList[arg_20_1.Data.UID])

		arg_20_0._aircraftList[arg_20_1.Data.UID] = nil
	end

	return
end

function var_0_6.onRemoveBullet(arg_21_0, arg_21_1)
	arg_21_0:RemoveBullet(arg_21_1.Data.UID)

	return
end

function var_0_6.onAddArea(arg_22_0, arg_22_1)
	arg_22_0:AddArea(arg_22_1.Data.area, arg_22_1.Data.FXID)

	return
end

function var_0_6.onRemoveArea(arg_23_0, arg_23_1)
	arg_23_0:RemoveArea(arg_23_1.Data.id)

	return
end

function var_0_6.onAddEffect(arg_24_0, arg_24_1)
	arg_24_0:AddEffect(arg_24_1.Data.FXID, arg_24_1.Data.position, arg_24_1.Data.localScale)

	return
end

function var_0_6.onAddShelter(arg_25_0, arg_25_1)
	local var_25_0, var_25_1 = arg_25_0._fxPool:GetFX(arg_25_1.Data.shelter:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_25_0, arg_25_1.Data.shelter:GetPosition():Add(var_25_1), true)

	if arg_25_1.Data.shelter:GetIFF() == var_0_3.FOE_CODE then
		var_25_0.transform.localEulerAngles.y = 180
		var_25_0.transform.localEulerAngles = var_25_0.transform.localEulerAngles
	end

	arg_25_0._shelterList[arg_25_1.Data.shelter:GetUniqueID()] = var_25_0

	return
end

function var_0_6.onRemoveShleter(arg_26_0, arg_26_1)
	if arg_26_0._shelterList[arg_26_1.Data.uid] then
		var_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_26_0._shelterList[arg_26_1.Data.uid])

		arg_26_0._shelterList[arg_26_1.Data.uid] = nil
	end

	return
end

function var_0_6.onAntiAirArea(arg_27_0, arg_27_1)
	if arg_27_1.Data.isShow ~= nil then
		arg_27_0._antiAirArea.gameObject:SetActive(arg_27_1.Data.isShow)

		if arg_27_1.Data.isShow == true then
			local var_27_0 = arg_27_0._leftFleet:GetFleetAntiAirWeapon():GetRange() * 2

			arg_27_0._antiAirAreaTF.localScale = Vector3(var_27_0, 0, var_27_0)
		end
	end

	return
end

function var_0_6.onAntiAirOverload(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._antiAirAreaTF:Find("Quad"):GetComponent(typeof(Animator))

	var_28_0.enabled = not arg_28_1.Dispatcher:IsOverLoad()

	return
end

function var_0_6.onUpdateHostileSubmarine(arg_29_0, arg_29_1)
	arg_29_0:updateSonarView()

	return
end

function var_0_6.updateSonarView(arg_30_0)
	local var_30_0 = arg_30_0._dataProxy:GetEnemySubmarineCount() > 0

	arg_30_0._sonarActive = var_30_0

	for iter_30_0, iter_30_1 in pairs(arg_30_0._characterList) do
		iter_30_1:SonarAcitve(var_30_0)
	end

	local var_30_1 = arg_30_0._leftFleet:GetFleetSonar()
	local var_30_2 = var_30_1:GetCurrentState() ~= var_0.Battle.BattleFleetStaticSonar.STATE_DISABLE and var_30_0

	arg_30_0._anitSubArea.gameObject:SetActive(var_30_2)

	if var_30_2 then
		local var_30_3 = arg_30_0._leftFleet:GetFleetSonar():GetRange()

		arg_30_0._anitSubAreaTF.localScale = Vector3(var_30_3, 0, var_30_3)
	end

	return
end

function var_0_6.onSonarScan(arg_31_0, arg_31_1)
	if arg_31_1.Data.indieSonar then
		local var_31_0 = arg_31_0._fxPool:GetFX("AntiSubArea").transform

		var_31_0.localScale = Vector3(100, 0, 100)

		SetActive(var_31_0:Find("static"), false)

		local var_31_1 = var_31_0:Find("Quad")
		local var_31_2 = var_31_1:GetComponent(typeof(Animator))

		var_31_2.enabled = true

		var_31_2:Play("antiSubZoom", -1, 0)

		arg_31_0._anitSubAreaTFList[var_31_0] = true

		var_31_1:GetComponent("DftAniEvent"):SetEndEvent(function(arg_32_0)
			arg_31_0._anitSubAreaTFList[var_31_0] = nil

			return
		end)
	elseif arg_31_0._antiSubScanAnima and arg_31_0._sonarActive then
		arg_31_0._antiSubScanAnima.enabled = true

		arg_31_0._antiSubScanAnima:Play("antiSubZoom", -1, 0)
	end

	return
end

function var_0_6.onAddAimBias(arg_33_0, arg_33_1)
	arg_33_0._aimBiasTFList[arg_33_1.Data.aimBias] = {
		tf = arg_33_0._fxPool:GetFX("AimBiasArea").transform,
		vector = Vector3(5, 0, 5)
	}

	return
end

function var_0_6.onRemoveAimBias(arg_34_0, arg_34_1)
	if arg_34_0._aimBiasTFList[arg_34_1.Data.aimBias] then
		var_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_34_0._aimBiasTFList[arg_34_1.Data.aimBias].tf.gameObject)

		arg_34_0._aimBiasTFList[arg_34_1.Data.aimBias] = nil
	end

	return
end

function var_0_6.onUpdateMoveMark(arg_35_0, arg_35_1)
	if not arg_35_0._moveMarkFXTF then
		arg_35_0._moveMarkFX = arg_35_0._fxPool:GetFX("kapai_weizhi")
		arg_35_0._moveMarkFXTF = arg_35_0._moveMarkFX.transform
	end

	if arg_35_1.Data.pos then
		setActive(arg_35_0._moveMarkFXTF, true)

		arg_35_0._moveMarkFXTF.position = arg_35_1.Data.pos
	else
		setActive(arg_35_0._moveMarkFXTF, false)
	end

	return
end

function var_0_6.onBoardClick(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._leftFleet:GetCardPuzzleComponent():GetTouchScreenPoint()

	if arg_36_1.Data.click == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_CLICK then
		arg_36_0._clickMarkFxTF = arg_36_0._fxPool:GetFX("kapai_weizhi").transform
		arg_36_0._clickMarkFxTF.position = var_36_0
	elseif arg_36_1.Data.click == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_DRAG then
		arg_36_0._clickMarkFxTF.position = var_36_0
	elseif arg_36_1.Data.click == var_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_RELEASE and arg_36_0._clickMarkFxTF then
		var_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_36_0._clickMarkFxTF.gameObject)
	end

	return
end

function var_0_6.onCameraFocusReset(arg_37_0, arg_37_1)
	arg_37_0:ResetFocus()

	return
end

function var_0_6.onAddCameraFX(arg_38_0, arg_38_1)
	arg_38_0:AddCameraFX(arg_38_1.Data.orderDiff, arg_38_1.Data.FXID, arg_38_1.Data.position, arg_38_1.Data.localScale)

	return
end

function var_0_6.AddCameraFX(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = arg_39_0._fxPool:GetFX(arg_39_2)
	local var_39_1 = arg_39_0._cameraUtil:Add2Camera(var_39_0, arg_39_1)

	arg_39_4 = arg_39_4 or 1
	var_39_0.transform.localScale = Vector3(arg_39_4 / var_39_1.x, arg_39_4 / var_39_1.y, arg_39_4 / var_39_1.z)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_39_0, arg_39_3, true)

	return
end

function var_0_6.onUpdateSkillAim(arg_40_0, arg_40_1)
	arg_40_0._cardAimTargetFilter = arg_40_1.Data.targetFilterList

	return
end

function var_0_6.Update(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0._characterList) do
		iter_41_1:Update()
	end

	for iter_41_2, iter_41_3 in pairs(arg_41_0._aircraftList) do
		iter_41_3:Update()
	end

	for iter_41_4, iter_41_5 in pairs(arg_41_0._bulletList) do
		iter_41_5:Update()
	end

	for iter_41_6, iter_41_7 in pairs(arg_41_0._areaList) do
		iter_41_7:Update()
	end

	for iter_41_8, iter_41_9 in ipairs(arg_41_0._arcEffectList) do
		iter_41_9:Update()
	end

	arg_41_0:updateCardAim()
	arg_41_0:UpdateAntiAirArea()
	arg_41_0:UpdateAimBiasArea()
	arg_41_0:UpdateFlagShipMark()

	return
end

function var_0_6.UpdatePause(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0._characterList) do
		iter_42_1:UpdateUIComponentPosition()
		iter_42_1:UpdateHPBarPosition()
	end

	for iter_42_2, iter_42_3 in pairs(arg_42_0._aircraftList) do
		iter_42_3:UpdateUIComponentPosition()

		local var_42_0 = iter_42_3:GetUnitData()

		if var_42_0:GetUniqueID() == var_0_3.FOE_CODE then
			iter_42_3:UpdateHPBarPosition()
		end
	end

	arg_42_0:UpdateFlagShipMark()

	return
end

function var_0_6.UpdateEscapeOnly(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(arg_43_0._characterList) do
		if iter_43_1.__name == var_0.Battle.BattleEnemyCharacter.__name or iter_43_1.__name == var_0.Battle.BattleBossCharacter.__name then
			iter_43_1:Update(arg_43_1)
		end
	end

	return
end

function var_0_6.Pause(arg_44_0)
	arg_44_0:PauseCharacterAction(true)

	for iter_44_0, iter_44_1 in pairs(arg_44_0._areaList) do
		local var_44_0 = iter_44_1._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_44_2, iter_44_3 in ipairs((var_44_0:ToTable())) do
			iter_44_3:Pause()
		end
	end

	arg_44_0._cameraUtil:PauseShake()

	for iter_44_4, iter_44_5 in ipairs(arg_44_0._arcEffectList) do
		local var_44_1 = iter_44_5._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_44_6, iter_44_7 in ipairs((var_44_1:ToTable())) do
			iter_44_7:Pause()
		end
	end

	for iter_44_8, iter_44_9 in pairs(arg_44_0._particleBulletList) do
		local var_44_2 = iter_44_8._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_44_10, iter_44_11 in ipairs((var_44_2:ToTable())) do
			iter_44_11:Pause()
		end
	end

	return
end

function var_0_6.Resume(arg_45_0)
	arg_45_0:PauseCharacterAction(false)

	for iter_45_0, iter_45_1 in pairs(arg_45_0._areaList) do
		local var_45_0 = iter_45_1._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_45_2, iter_45_3 in ipairs((var_45_0:ToTable())) do
			iter_45_3:Pause()
		end
	end

	arg_45_0._cameraUtil:ResumeShake()

	for iter_45_4, iter_45_5 in ipairs(arg_45_0._arcEffectList) do
		local var_45_1 = iter_45_5._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_45_6, iter_45_7 in ipairs((var_45_1:ToTable())) do
			iter_45_7:Pause()
		end
	end

	for iter_45_8, iter_45_9 in pairs(arg_45_0._particleBulletList) do
		local var_45_2 = iter_45_8._go:GetComponentsInChildren(typeof(ParticleSystem))

		for iter_45_10, iter_45_11 in ipairs((var_45_2:ToTable())) do
			iter_45_11:Pause()
		end
	end

	return
end

function var_0_6.onBulletTime(arg_46_0, arg_46_1)
	if arg_46_1.Data.speed then
		local var_46_0 = arg_46_1.Data.exemptUnit:GetUniqueID()

		var_0_4.AppendIFFFactor(var_0_3.FOE_CODE, arg_46_1.Data.key, arg_46_1.Data.speed)
		var_0_4.AppendIFFFactor(var_0_3.FRIENDLY_CODE, arg_46_1.Data.key, arg_46_1.Data.speed)

		for iter_46_0, iter_46_1 in pairs(arg_46_0._characterList) do
			if iter_46_0 == var_46_0 then
				iter_46_1:SetAnimaSpeed(1 / arg_46_1.Data.speed)

				break
			end
		end
	else
		var_0_4.RemoveIFFFactor(var_0_3.FOE_CODE, arg_46_1.Data.key)
		var_0_4.RemoveIFFFactor(var_0_3.FRIENDLY_CODE, arg_46_1.Data.key)

		for iter_46_2, iter_46_3 in pairs(arg_46_0._characterList) do
			iter_46_3:SetAnimaSpeed(1)
		end

		for iter_46_4, iter_46_5 in pairs(arg_46_0._bulletList) do
			iter_46_5:SetAnimaSpeed(1)
		end
	end

	return
end

function var_0_6.ResetFocus(arg_47_0)
	var_0_4.RemoveIFFFactor(var_0_3.FOE_CODE, var_0_3.SPEED_FACTOR_FOCUS_CHARACTER)
	var_0_4.RemoveIFFFactor(var_0_3.FRIENDLY_CODE, var_0_3.SPEED_FACTOR_FOCUS_CHARACTER)

	for iter_47_0, iter_47_1 in pairs(arg_47_0._characterList) do
		iter_47_1:SetAnimaSpeed(1)
	end

	for iter_47_2, iter_47_3 in pairs(arg_47_0._bulletList) do
		iter_47_3:SetAnimaSpeed(1)
	end

	arg_47_0._cameraUtil:ZoomCamara(nil, nil, var_0_3.CAM_RESET_DURATION)

	return
end

function var_0_6.UpdateFlagShipMark(arg_48_0)
	arg_48_0._goFlagShipMarkTf.position = var_0_4.CameraPosToUICamera((arg_48_0.FlagShipUIPos:Copy(arg_48_0._leftFleetMotion:GetPos()))):Add(var_0_7)

	return
end

function var_0_6.UpdateAntiAirArea(arg_49_0)
	arg_49_0._antiAirAreaTF.position = arg_49_0._leftFleetMotion:GetPos()

	for iter_49_0, iter_49_1 in pairs(arg_49_0._anitSubAreaTFList) do
		iter_49_0.position = arg_49_0._leftFleetMotion:GetPos()
	end

	return
end

function var_0_6.UpdateAimBiasArea(arg_50_0)
	for iter_50_0, iter_50_1 in pairs(arg_50_0._aimBiasTFList) do
		local var_50_0 = iter_50_1.tf
		local var_50_1 = iter_50_0:GetRange() * 2

		iter_50_1.vector:Set(var_50_1, 0, var_50_1)

		var_50_0.position = iter_50_0:GetPosition()
		var_50_0.localScale = iter_50_1.vector

		local var_50_2 = iter_50_0:GetCurrentState()

		if var_50_2 ~= iter_50_1.cacheState then
			setActive(var_50_0:Find("suofang/Quad"), var_50_2 ~= iter_50_0.STATE_SKILL_EXPOSE)
		end

		iter_50_1.cacheState = var_50_2
	end

	return
end

function var_0_6.updateCardAim(arg_51_0)
	for iter_51_0, iter_51_1 in pairs(arg_51_0._cardAimTargetFilter) do
		local var_51_0 = var_0_5.TargetFleetIndex(nil, {
			fleetPos = iter_51_0
		})[1]

		for iter_51_2, iter_51_3 in ipairs(iter_51_1) do
			local var_51_1

			for iter_51_4, iter_51_5 in ipairs(iter_51_3) do
				var_51_1 = var_0_5[iter_51_5](var_51_0, nil, var_51_1)
			end

			for iter_51_6, iter_51_7 in ipairs(var_51_1) do
				({})[iter_51_7:GetUniqueID()] = true
			end
		end
	end

	for iter_51_8, iter_51_9 in pairs(arg_51_0._cardAimTargetList) do
		if not ({})[iter_51_8] then
			Object.Destroy(go(iter_51_9))

			arg_51_0._cardAimTargetList[iter_51_8] = nil
		end
	end

	for iter_51_10, iter_51_11 in pairs({}) do
		local var_51_2 = arg_51_0._cardAimTargetList[iter_51_10] or arg_51_0:InstantiateCharacterComponent("SkillAimContainer/SkillAim").transform

		arg_51_0._cardAimTargetList[iter_51_10] = var_51_2

		if arg_51_0._characterList[iter_51_10] then
			var_51_2.position = arg_51_0._characterList[iter_51_10]:GetReferenceVector(arg_51_0._characterList[iter_51_10].AIM_OFFSET)
		end
	end

	return
end

function var_0_6.AddBullet(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1:GetBulletData()

	arg_52_0._bulletList[var_52_0:GetUniqueID()] = arg_52_1

	local var_52_1 = arg_52_1:GetGO()

	if var_52_1 and var_52_1:GetComponent(typeof(ParticleSystem)) then
		arg_52_0._particleBulletList[arg_52_1] = true
	end

	if var_0_4.focusExemptList[var_52_0:GetSpeedExemptKey()] then
		arg_52_1:SetAnimaSpeed(1 / arg_52_0._state:GetTimeScaleRate())
	end

	return
end

function var_0_6.RemoveBullet(arg_53_0, arg_53_1)
	if arg_53_0._bulletList[arg_53_1] then
		arg_53_0._particleBulletList[arg_53_0._bulletList[arg_53_1]] = nil

		arg_53_0._bulletList[arg_53_1]:GetFactory():RemoveBullet(arg_53_0._bulletList[arg_53_1])
	end

	arg_53_0._bulletList[arg_53_1] = nil

	return
end

function var_0_6.GetBulletRoot(arg_54_0)
	return arg_54_0._bulletContainer
end

function var_0_6.EnablePopContainer(arg_55_0, arg_55_1, arg_55_2)
	setActive(arg_55_0._state:GetUI()._tf:Find(arg_55_1), arg_55_2)

	return
end

function var_0_6.AddPlayerCharacter(arg_56_0, arg_56_1)
	arg_56_0:AppendCharacter(arg_56_1)

	local var_56_0 = arg_56_0._dataProxy:GetInitData().battleType
	local var_56_1 = arg_56_1:GetUnitData():IsMainFleetUnit()

	if var_56_0 == SYSTEM_DUEL then
		-- block empty
	elseif var_56_0 == SYSTEM_SUBMARINE_RUN or var_56_0 == SYSTEM_SUB_ROUTINE then
		arg_56_1:SetBarHidden(false, false)
	else
		arg_56_1:SetBarHidden(not var_56_1, var_56_1)
	end

	return
end

function var_0_6.AddEnemyCharacter(arg_57_0, arg_57_1)
	arg_57_0:AppendCharacter(arg_57_1)

	return
end

function var_0_6.AppendCharacter(arg_58_0, arg_58_1)
	arg_58_0._characterList[arg_58_1:GetUnitData():GetUniqueID()] = arg_58_1

	return
end

function var_0_6.InstantiateCharacterComponent(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._state:GetUI()._tf:Find(arg_59_1)

	return cloneTplTo(var_59_0, var_59_0.parent).gameObject
end

function var_0_6.GetCharacterList(arg_60_0)
	return arg_60_0._characterList
end

function var_0_6.GetPopNumPool(arg_61_0)
	return arg_61_0._popNumMgr
end

function var_0_6.PauseCharacterAction(arg_62_0, arg_62_1)
	for iter_62_0, iter_62_1 in pairs(arg_62_0._characterList) do
		iter_62_1:PauseActionAnimation(arg_62_1)
	end

	return
end

function var_0_6.GetCharacter(arg_63_0, arg_63_1)
	return arg_63_0._characterList[arg_63_1]
end

function var_0_6.GetAircraft(arg_64_0, arg_64_1)
	return arg_64_0._aircraftList[arg_64_1]
end

function var_0_6.AddAirCraftCharacter(arg_65_0, arg_65_1)
	arg_65_0._aircraftList[arg_65_1:GetUnitData():GetUniqueID()] = arg_65_1

	return
end

function var_0_6.AddArea(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = false

	if pg.effect_offset[arg_66_2] and pg.effect_offset[arg_66_2].top_cover_offset == true then
		var_66_0 = true
	end

	arg_66_0._areaList[arg_66_1:GetUniqueID()] = var_0.Battle.BattleEffectArea.New(arg_66_0._fxPool:GetFX(arg_66_2), arg_66_1, var_66_0)

	return
end

function var_0_6.RemoveArea(arg_67_0, arg_67_1)
	if arg_67_0._areaList[arg_67_1] then
		arg_67_0._areaList[arg_67_1]:Dispose()

		arg_67_0._areaList[arg_67_1] = nil
	end

	return
end

function var_0_6.AddEffect(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = arg_68_0._fxPool:GetFX(arg_68_1)

	arg_68_3 = arg_68_3 or 1
	var_68_0.transform.localScale = Vector3(arg_68_3, 1, arg_68_3)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_68_0, arg_68_2, true)

	return
end

function var_0_6.AddArcEffect(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_0 = var_0.Battle.BattleArcEffect.New(arg_69_0._fxPool:GetFX(arg_69_1), arg_69_2, arg_69_3, arg_69_4)

	var_69_0:ConfigCallback(function()
		arg_69_0:RemoveArcEffect(var_69_0)

		return
	end)
	table.insert(arg_69_0._arcEffectList, var_69_0)

	return
end

function var_0_6.RemoveArcEffect(arg_71_0, arg_71_1)
	for iter_71_0, iter_71_1 in ipairs(arg_71_0._arcEffectList) do
		if iter_71_1 == arg_71_1 then
			iter_71_1:Dispose()
			table.remove(arg_71_0._arcEffectList, iter_71_0)

			break
		end
	end

	return
end

function var_0_6.Reinitialize(arg_72_0)
	arg_72_0:Clear()
	arg_72_0:Init()

	return
end

function var_0_6.AllBulletNeutralize(arg_73_0)
	for iter_73_0, iter_73_1 in pairs(arg_73_0._characterList) do
		if iter_73_1.__name == var_0.Battle.BattlePlayerCharacter.__name or iter_73_1.__name == var_0.Battle.BattleSubCharacter.__name then
			iter_73_1:DisableWeaponTrack()
		end
	end

	arg_73_0._antiAirArea:SetActive(false)

	for iter_73_2, iter_73_3 in pairs(arg_73_0._bulletList) do
		iter_73_3:Neutrailze()
	end

	var_0.Battle.BattleBulletFactory.NeutralizeBullet()

	return
end

function var_0_6.Clear(arg_74_0)
	for iter_74_0, iter_74_1 in pairs(arg_74_0._characterList) do
		iter_74_1:GetFactory():RemoveCharacter(iter_74_1)
	end

	for iter_74_2, iter_74_3 in pairs(arg_74_0._aircraftList) do
		iter_74_3:GetFactory():RemoveCharacter(iter_74_3)
	end

	arg_74_0._characterList = nil
	arg_74_0._characterFactoryList = nil

	for iter_74_4, iter_74_5 in pairs(arg_74_0._bulletList) do
		arg_74_0:RemoveBullet(iter_74_4)
	end

	for iter_74_6, iter_74_7 in pairs((var_0.Battle.BattleBulletFactory.GetFactoryList())) do
		iter_74_7:Clear()
	end

	arg_74_0._fxPool:Clear()

	for iter_74_8, iter_74_9 in pairs(arg_74_0._areaList) do
		arg_74_0:RemoveArea(iter_74_8)
	end

	arg_74_0._areaList = nil

	for iter_74_10, iter_74_11 in ipairs(arg_74_0._arcEffectList) do
		iter_74_11:Dispose()
	end

	arg_74_0._arcEffectList = nil

	for iter_74_12, iter_74_13 in pairs(arg_74_0._cardAimTargetList) do
		Object.Destroy(go(iter_74_13))
	end

	arg_74_0._cardAimTargetList = nil

	var_0.Battle.BattleCharacterFXContainersPool.GetInstance():Clear()
	arg_74_0._popNumMgr:Clear()
	var_0.Battle.BattleHPBarManager.GetInstance():Clear()
	var_0.Battle.BattleArrowManager.GetInstance():Clear()

	arg_74_0._anitSubAreaTFList = nil

	return
end

function var_0_6.Dispose(arg_75_0)
	arg_75_0:Clear()
	arg_75_0:RemoveEvent()
	var_0_6.super.Dispose(arg_75_0)

	return
end

return
