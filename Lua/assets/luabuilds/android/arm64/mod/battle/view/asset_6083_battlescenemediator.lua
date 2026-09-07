ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleCardPuzzleEvent
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleVariable
local var_0_6 = ys.Battle.BattleTargetChoise
local BattleSceneMediator = class("BattleSceneMediator", ys.MVC.Mediator)

ys.Battle.BattleSceneMediator = BattleSceneMediator
BattleSceneMediator.__name = "BattleSceneMediator"

local var_0_8 = Vector3(0, 0.8, 0)

function BattleSceneMediator:Ctor()
	BattleSceneMediator.super.Ctor(self)

	self.FlagShipUIPos = Vector3.zero

	return
end

function BattleSceneMediator:Initialize()
	BattleSceneMediator.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	self:InitCharacterFactory()
	self:Init()
	self:AddEvent()

	return
end

function BattleSceneMediator:Init()
	self._characterList = {}
	self._bulletList = {}
	self._particleBulletList = {}
	self._aircraftList = {}
	self._areaList = {}
	self._shelterList = {}
	self._arcEffectList = {}
	self._bulletContainer = GameObject.Find("BulletContainer")
	self._fxPool = var_0_0.Battle.BattleFXPool.GetInstance()
	self._aimBiasTFList = {}

	var_0_0.Battle.BattleCharacterFXContainersPool.GetInstance():Init()
	self:InitPlayerAntiAirArea()
	self:InitPlayerAntiSubArea()
	self:InitFlagShipMark()
	self:InitSkillAim()
	pg.CameraFixMgr.GetInstance():Adapt()

	return
end

function BattleSceneMediator:InitCamera()
	self._cameraUtil = var_0_0.Battle.BattleCameraUtil.GetInstance()

	self._cameraUtil:RegisterEventListener(self, var_0_1.CAMERA_FOCUS_RESET, self.onCameraFocusReset)
	self._cameraUtil:RegisterEventListener(self, var_0_1.BULLET_TIME, self.onBulletTime)

	return
end

function BattleSceneMediator:InitPopNumPool()
	self._popNumMgr = var_0_0.Battle.BattlePopNumManager.GetInstance()

	local var_5_0 = self._state:GetUI()

	if self._dataProxy:GetInitData().battleType == SYSTEM_DODGEM then
		self._popNumMgr:InitialScorePool(var_5_0._tf:Find(var_0_0.Battle.BattlePopNumManager.CONTAINER_CHARACTER_HP .. "/container"))
	else
		self._popNumMgr:InitialBundlePool(var_5_0._tf:Find(var_0_0.Battle.BattlePopNumManager.CONTAINER_CHARACTER_HP .. "/container"))
	end

	return
end

function BattleSceneMediator:InitFlagShipMark()
	local var_6_0 = self._state:GetUI()._tf:Find("flagShipMark").gameObject

	var_6_0:SetActive(true)

	self._goFlagShipMarkTf = var_6_0.transform

	return
end

function BattleSceneMediator:InitSkillAim()
	self._cardAimTargetFilter = {}
	self._cardAimTargetList = {}

	return
end

function BattleSceneMediator:InitCharacterFactory()
	local var_8_0 = self._state:GetUI()

	var_0_0.Battle.BattleHPBarManager.GetInstance():InitialPoolRoot(var_8_0._tf:Find(var_0_0.Battle.BattleHPBarManager.ROOT_NAME))
	var_0_0.Battle.BattleArrowManager.GetInstance():Init(var_8_0._tf:Find(var_0_0.Battle.BattleArrowManager.ROOT_NAME))

	self._characterFactoryList = {
		[var_0_3.UnitType.PLAYER_UNIT] = var_0_0.Battle.BattlePlayerCharacterFactory.GetInstance(),
		[var_0_3.UnitType.ENEMY_UNIT] = var_0_0.Battle.BattleEnemyCharacterFactory.GetInstance(),
		[var_0_3.UnitType.MINION_UNIT] = var_0_0.Battle.BattleMinionCharacterFactory.GetInstance(),
		[var_0_3.UnitType.BOSS_UNIT] = var_0_0.Battle.BattleBossCharacterFactory.GetInstance(),
		[var_0_3.UnitType.AIRCRAFT_UNIT] = var_0_0.Battle.BattleAircraftCharacterFactory.GetInstance(),
		[var_0_3.UnitType.AIRFIGHTER_UNIT] = var_0_0.Battle.BattleAirFighterCharacterFactory.GetInstance(),
		[var_0_3.UnitType.SUB_UNIT] = var_0_0.Battle.BattleSubCharacterFactory.GetInstance(),
		[var_0_3.UnitType.SUPPORT_UNIT] = var_0_0.Battle.BattleSupportCharacterFactory.GetInstance()
	}

	return
end

function BattleSceneMediator:InitPlayerAntiAirArea()
	self._antiAirArea = self._fxPool:GetFX("AntiAirArea")
	self._antiAirAreaTF = self._antiAirArea.transform

	self._antiAirArea:SetActive(false)

	return
end

function BattleSceneMediator:InitPlayerAntiSubArea()
	self._anitSubArea = self._fxPool:GetFX("AntiSubArea")
	self._anitSubAreaTF = self._anitSubArea.transform

	self._anitSubArea:SetActive(false)

	self._antiSubScanAnima = self._anitSubAreaTF:Find("Quad"):GetComponent(typeof(Animator))
	self._anitSubAreaTFList = {}
	self._anitSubAreaTFList[self._anitSubAreaTF] = true

	return
end

function BattleSceneMediator:InitDetailAntiSubArea()
	local var_11_0, var_11_1, var_11_2, var_11_3 = self._leftFleet:GetFleetSonar():GetTotalRangeDetail()

	local function var_11_4(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = self._fxPool:GetFX("AntiSubArea")

		var_12_0.name = arg_12_2
		var_12_0.transform.localScale = Vector3(arg_12_0, 0, arg_12_0)
		var_12_0.transform:Find("static"):GetComponent("SpriteRenderer").color = arg_12_1

		var_12_0:SetActive(true)

		self._anitSubAreaTFList[var_12_0.transform] = true

		return
	end

	var_11_4(var_11_0 + var_11_1 + var_11_2 + var_11_3, Color.New(1, 1, 1, 1), "技能额外直径：" .. var_11_3)
	var_11_4(var_11_0 + var_11_1 + var_11_2, Color.New(0.07, 1, 0, 1), "装备提供直径：" .. var_11_2)
	var_11_4(var_11_0 + var_11_1, Color.New(1, 0.32, 0, 1), "主力提供直径：" .. var_11_1)
	var_11_4(var_11_0, Color.New(1, 0, 0, 1), "基础直径：" .. var_11_0)

	return
end

function BattleSceneMediator:AddEvent()
	self._dataProxy:RegisterEventListener(self, var_0_1.STAGE_DATA_INIT_FINISH, self.onStageInitFinish)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_UNIT, self.onAddUnit)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_UNIT, self.onRemoveUnit)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_BULLET, self.onRemoveBullet)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_AIR_CRAFT, self.onRemoveAircraft)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_AIR_FIGHTER, self.onRemoveAirFighter)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_AREA, self.onAddArea)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_AREA, self.onRemoveArea)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_EFFECT, self.onAddEffect)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_SHELTER, self.onAddShelter)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_SHELTER, self.onRemoveShleter)
	self._dataProxy:RegisterEventListener(self, var_0_1.ANTI_AIR_AREA, self.onAntiAirArea)
	self._dataProxy:RegisterEventListener(self, var_0_1.UPDATE_HOSTILE_SUBMARINE, self.onUpdateHostileSubmarine)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_CAMERA_FX, self.onAddCameraFX)
	self._dataProxy:RegisterEventListener(self, var_0_1.ADD_AIM_BIAS, self.onAddAimBias)
	self._dataProxy:RegisterEventListener(self, var_0_1.REMOVE_AIM_BIAS, self.onRemoveAimBias)

	self._camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function()
		self._dataProxy:OnCameraRatioUpdate()

		return
	end)

	return
end

function BattleSceneMediator:RemoveEvent()
	self._leftFleet:UnregisterEventListener(self, var_0_1.SONAR_SCAN)
	self._leftFleet:UnregisterEventListener(self, var_0_1.SONAR_UPDATE)
	self._leftFleet:UnregisterEventListener(self, var_0_1.ADD_AIM_BIAS)
	self._leftFleet:UnregisterEventListener(self, var_0_1.REMOVE_AIM_BIAS)
	self._leftFleet:UnregisterEventListener(self, var_0_2.FLEET_MOVE_TO)
	self._leftFleet:UnregisterEventListener(self, var_0_2.UPDATE_CARD_TARGET_FILTER)
	self._leftFleet:UnregisterEventListener(self, var_0_1.ON_BOARD_CLICK)
	self._dataProxy:UnregisterEventListener(self, var_0_1.STAGE_DATA_INIT_FINISH)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_UNIT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_BULLET)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_AIR_CRAFT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_AIR_FIGHTER)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_AREA)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_AREA)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_EFFECT)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_SHELTER)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_SHELTER)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ANTI_AIR_AREA)
	self._dataProxy:UnregisterEventListener(self, var_0_1.UPDATE_HOSTILE_SUBMARINE)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_CAMERA_FX)
	self._dataProxy:UnregisterEventListener(self, var_0_1.ADD_AIM_BIAS)
	self._dataProxy:UnregisterEventListener(self, var_0_1.REMOVE_AIM_BIAS)
	self._cameraUtil:UnregisterEventListener(self, var_0_1.CAMERA_FOCUS_RESET)
	self._cameraUtil:UnregisterEventListener(self, var_0_1.BULLET_TIME)
	pg.CameraFixMgr.GetInstance():disconnect(self._camEventId)

	return
end

function BattleSceneMediator:onStageInitFinish(arg_16_1)
	self._leftFleet = self._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
	self._leftFleetMotion = self._leftFleet:GetMotion()

	self:InitCamera()
	self._leftFleet:RegisterEventListener(self, var_0_1.SONAR_SCAN, self.onSonarScan)
	self._leftFleet:RegisterEventListener(self, var_0_1.SONAR_UPDATE, self.onUpdateHostileSubmarine)
	self._leftFleet:RegisterEventListener(self, var_0_1.ADD_AIM_BIAS, self.onAddAimBias)
	self._leftFleet:RegisterEventListener(self, var_0_1.REMOVE_AIM_BIAS, self.onRemoveAimBias)
	self._leftFleet:RegisterEventListener(self, var_0_2.FLEET_MOVE_TO, self.onUpdateMoveMark)
	self._leftFleet:RegisterEventListener(self, var_0_2.ON_BOARD_CLICK, self.onBoardClick)
	self._leftFleet:RegisterEventListener(self, var_0_2.UPDATE_CARD_TARGET_FILTER, self.onUpdateSkillAim)
	self:InitPopNumPool()

	return
end

function BattleSceneMediator:onAddUnit(arg_17_1)
	self._characterFactoryList[arg_17_1.Data.type]:CreateCharacter(arg_17_1.Data)

	return
end

function BattleSceneMediator:onRemoveUnit(arg_18_1)
	if self._characterList[arg_18_1.Data.UID] then
		self._characterList[arg_18_1.Data.UID]:GetFactory():RemoveCharacter(self._characterList[arg_18_1.Data.UID], arg_18_1.Data.deadReason)

		self._characterList[arg_18_1.Data.UID] = nil
	end

	return
end

function BattleSceneMediator:onRemoveAircraft(arg_19_1)
	if self._aircraftList[arg_19_1.Data.UID] then
		self._aircraftList[arg_19_1.Data.UID]:GetFactory():RemoveCharacter(self._aircraftList[arg_19_1.Data.UID])

		self._aircraftList[arg_19_1.Data.UID] = nil
	end

	return
end

function BattleSceneMediator:onRemoveAirFighter(arg_20_1)
	if self._aircraftList[arg_20_1.Data.UID] then
		self._aircraftList[arg_20_1.Data.UID]:GetFactory():RemoveCharacter(self._aircraftList[arg_20_1.Data.UID])

		self._aircraftList[arg_20_1.Data.UID] = nil
	end

	return
end

function BattleSceneMediator:onRemoveBullet(arg_21_1)
	self:RemoveBullet(arg_21_1.Data.UID)

	return
end

function BattleSceneMediator:onAddArea(arg_22_1)
	self:AddArea(arg_22_1.Data.area, arg_22_1.Data.FXID)

	return
end

function BattleSceneMediator:onRemoveArea(arg_23_1)
	self:RemoveArea(arg_23_1.Data.id)

	return
end

function BattleSceneMediator:onAddEffect(arg_24_1)
	self:AddEffect(arg_24_1.Data.FXID, arg_24_1.Data.position, arg_24_1.Data.localScale)

	return
end

function BattleSceneMediator:onAddShelter(arg_25_1)
	local var_25_0, var_25_1 = self._fxPool:GetFX(arg_25_1.Data.shelter:GetFXID())

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_25_0, arg_25_1.Data.shelter:GetPosition():Add(var_25_1), true)

	if arg_25_1.Data.shelter:GetIFF() == var_0_4.FOE_CODE then
		var_25_0.transform.localEulerAngles.y = 180
		var_25_0.transform.localEulerAngles = var_25_0.transform.localEulerAngles
	end

	self._shelterList[arg_25_1.Data.shelter:GetUniqueID()] = var_25_0

	return
end

function BattleSceneMediator:onRemoveShleter(arg_26_1)
	if self._shelterList[arg_26_1.Data.uid] then
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._shelterList[arg_26_1.Data.uid])

		self._shelterList[arg_26_1.Data.uid] = nil
	end

	return
end

function BattleSceneMediator:onAntiAirArea(arg_27_1)
	if arg_27_1.Data.isShow ~= nil then
		self._antiAirArea.gameObject:SetActive(arg_27_1.Data.isShow)

		if arg_27_1.Data.isShow == true then
			local var_27_0 = self._leftFleet:GetFleetAntiAirWeapon():GetRange() * 2

			self._antiAirAreaTF.localScale = Vector3(var_27_0, 0, var_27_0)
		end
	end

	return
end

function BattleSceneMediator:onAntiAirOverload(arg_28_1)
	self._antiAirAreaTF:Find("Quad"):GetComponent(typeof(Animator)).enabled = not arg_28_1.Dispatcher:IsOverLoad()

	return
end

function BattleSceneMediator:onUpdateHostileSubmarine(arg_29_1)
	self:updateSonarView()

	return
end

function BattleSceneMediator:updateSonarView()
	local var_30_0 = self._dataProxy:GetEnemySubmarineCount() > 0

	self._sonarActive = var_30_0

	for iter_30_0, iter_30_1 in pairs(self._characterList) do
		iter_30_1:SonarAcitve(var_30_0)
	end

	local var_30_1 = self._leftFleet:GetFleetSonar():GetCurrentState() ~= var_0_0.Battle.BattleFleetStaticSonar.STATE_DISABLE and var_30_0

	self._anitSubArea.gameObject:SetActive(var_30_1)

	if var_30_1 then
		local var_30_2 = self._leftFleet:GetFleetSonar():GetRange()

		self._anitSubAreaTF.localScale = Vector3(var_30_2, 0, var_30_2)
	end

	return
end

function BattleSceneMediator:onSonarScan(arg_31_1)
	if arg_31_1.Data.indieSonar then
		local var_31_0 = self._fxPool:GetFX("AntiSubArea").transform

		var_31_0.localScale = Vector3(100, 0, 100)

		SetActive(var_31_0:Find("static"), false)

		local var_31_1 = var_31_0:Find("Quad")
		local var_31_2 = var_31_1:GetComponent(typeof(Animator))

		var_31_2.enabled = true

		var_31_2:Play("antiSubZoom", -1, 0)

		self._anitSubAreaTFList[var_31_0] = true

		var_31_1:GetComponent("DftAniEvent"):SetEndEvent(function(arg_32_0)
			self._anitSubAreaTFList[var_31_0] = nil

			return
		end)
	elseif self._antiSubScanAnima and self._sonarActive then
		self._antiSubScanAnima.enabled = true

		self._antiSubScanAnima:Play("antiSubZoom", -1, 0)
	end

	return
end

function BattleSceneMediator:onAddAimBias(arg_33_1)
	self._aimBiasTFList[arg_33_1.Data.aimBias] = {
		tf = self._fxPool:GetFX("AimBiasArea").transform,
		vector = Vector3(5, 0, 5)
	}

	return
end

function BattleSceneMediator:onRemoveAimBias(arg_34_1)
	if self._aimBiasTFList[arg_34_1.Data.aimBias] then
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._aimBiasTFList[arg_34_1.Data.aimBias].tf.gameObject)

		self._aimBiasTFList[arg_34_1.Data.aimBias] = nil
	end

	return
end

function BattleSceneMediator:onUpdateMoveMark(arg_35_1)
	if not self._moveMarkFXTF then
		self._moveMarkFX = self._fxPool:GetFX("kapai_weizhi")
		self._moveMarkFXTF = self._moveMarkFX.transform
	end

	if arg_35_1.Data.pos then
		setActive(self._moveMarkFXTF, true)

		self._moveMarkFXTF.position = arg_35_1.Data.pos
	else
		setActive(self._moveMarkFXTF, false)
	end

	return
end

function BattleSceneMediator:onBoardClick(arg_36_1)
	local var_36_0 = self._leftFleet:GetCardPuzzleComponent():GetTouchScreenPoint()

	if arg_36_1.Data.click == var_0_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_CLICK then
		self._clickMarkFxTF = self._fxPool:GetFX("kapai_weizhi").transform
		self._clickMarkFxTF.position = var_36_0
	elseif arg_36_1.Data.click == var_0_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_DRAG then
		self._clickMarkFxTF.position = var_36_0
	elseif arg_36_1.Data.click == var_0_0.Battle.CardPuzzleBoardClicker.CLICK_STATE_RELEASE and self._clickMarkFxTF then
		var_0_0.Battle.BattleResourceManager.GetInstance():DestroyOb(self._clickMarkFxTF.gameObject)
	end

	return
end

function BattleSceneMediator:onCameraFocusReset(arg_37_1)
	self:ResetFocus()

	return
end

function BattleSceneMediator:onAddCameraFX(arg_38_1)
	self:AddCameraFX(arg_38_1.Data.orderDiff, arg_38_1.Data.FXID, arg_38_1.Data.position, arg_38_1.Data.localScale)

	return
end

function BattleSceneMediator:AddCameraFX(arg_39_1, arg_39_2, arg_39_3, arg_39_4)
	local var_39_0 = self._fxPool:GetFX(arg_39_2)
	local var_39_1 = self._cameraUtil:Add2Camera(var_39_0, arg_39_1)

	arg_39_4 = arg_39_4 or 1
	var_39_0.transform.localScale = Vector3(arg_39_4 / var_39_1.x, arg_39_4 / var_39_1.y, arg_39_4 / var_39_1.z)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_39_0, arg_39_3, true)

	return
end

function BattleSceneMediator:onUpdateSkillAim(arg_40_1)
	self._cardAimTargetFilter = arg_40_1.Data.targetFilterList

	return
end

function BattleSceneMediator:Update()
	for iter_41_0, iter_41_1 in pairs(self._characterList) do
		iter_41_1:Update()
	end

	for iter_41_2, iter_41_3 in pairs(self._aircraftList) do
		iter_41_3:Update()
	end

	for iter_41_4, iter_41_5 in pairs(self._bulletList) do
		iter_41_5:Update()
	end

	for iter_41_6, iter_41_7 in pairs(self._areaList) do
		iter_41_7:Update()
	end

	for iter_41_8, iter_41_9 in ipairs(self._arcEffectList) do
		iter_41_9:Update()
	end

	self:updateCardAim()
	self:UpdateAntiAirArea()
	self:UpdateAimBiasArea()
	self:UpdateFlagShipMark()

	return
end

function BattleSceneMediator:UpdatePause()
	for iter_42_0, iter_42_1 in pairs(self._characterList) do
		iter_42_1:UpdateUIComponentPosition()
		iter_42_1:UpdateHPBarPosition()
	end

	for iter_42_2, iter_42_3 in pairs(self._aircraftList) do
		iter_42_3:UpdateUIComponentPosition()

		if iter_42_3:GetUnitData():GetUniqueID() == var_0_4.FOE_CODE then
			iter_42_3:UpdateHPBarPosition()
		end
	end

	self:UpdateFlagShipMark()

	return
end

function BattleSceneMediator:UpdateEscapeOnly(arg_43_1)
	for iter_43_0, iter_43_1 in pairs(self._characterList) do
		if iter_43_1.__name == var_0_0.Battle.BattleEnemyCharacter.__name or iter_43_1.__name == var_0_0.Battle.BattleBossCharacter.__name then
			iter_43_1:Update(arg_43_1)
		end
	end

	return
end

function BattleSceneMediator:Pause()
	self:PauseCharacterAction(true)

	for iter_44_0, iter_44_1 in pairs(self._areaList) do
		for iter_44_2, iter_44_3 in ipairs((iter_44_1._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_44_3:Pause()
		end
	end

	self._cameraUtil:PauseShake()

	for iter_44_4, iter_44_5 in ipairs(self._arcEffectList) do
		for iter_44_6, iter_44_7 in ipairs((iter_44_5._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_44_7:Pause()
		end
	end

	for iter_44_8, iter_44_9 in pairs(self._particleBulletList) do
		for iter_44_10, iter_44_11 in ipairs((iter_44_8._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_44_11:Pause()
		end
	end

	return
end

function BattleSceneMediator:Resume()
	self:PauseCharacterAction(false)

	for iter_45_0, iter_45_1 in pairs(self._areaList) do
		for iter_45_2, iter_45_3 in ipairs((iter_45_1._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_45_3:Pause()
		end
	end

	self._cameraUtil:ResumeShake()

	for iter_45_4, iter_45_5 in ipairs(self._arcEffectList) do
		for iter_45_6, iter_45_7 in ipairs((iter_45_5._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_45_7:Pause()
		end
	end

	for iter_45_8, iter_45_9 in pairs(self._particleBulletList) do
		for iter_45_10, iter_45_11 in ipairs((iter_45_8._go:GetComponentsInChildren(typeof(ParticleSystem)):ToTable())) do
			iter_45_11:Pause()
		end
	end

	return
end

function BattleSceneMediator:onBulletTime(arg_46_1)
	if arg_46_1.Data.speed then
		local var_46_0 = arg_46_1.Data.exemptUnit:GetUniqueID()

		var_0_5.AppendIFFFactor(var_0_4.FOE_CODE, arg_46_1.Data.key, arg_46_1.Data.speed)
		var_0_5.AppendIFFFactor(var_0_4.FRIENDLY_CODE, arg_46_1.Data.key, arg_46_1.Data.speed)

		for iter_46_0, iter_46_1 in pairs(self._characterList) do
			if iter_46_0 == var_46_0 then
				iter_46_1:SetAnimaSpeed(1 / arg_46_1.Data.speed)

				break
			end
		end
	else
		var_0_5.RemoveIFFFactor(var_0_4.FOE_CODE, arg_46_1.Data.key)
		var_0_5.RemoveIFFFactor(var_0_4.FRIENDLY_CODE, arg_46_1.Data.key)

		for iter_46_2, iter_46_3 in pairs(self._characterList) do
			iter_46_3:SetAnimaSpeed(1)
		end

		for iter_46_4, iter_46_5 in pairs(self._bulletList) do
			iter_46_5:SetAnimaSpeed(1)
		end
	end

	return
end

function BattleSceneMediator:ResetFocus()
	var_0_5.RemoveIFFFactor(var_0_4.FOE_CODE, var_0_4.SPEED_FACTOR_FOCUS_CHARACTER)
	var_0_5.RemoveIFFFactor(var_0_4.FRIENDLY_CODE, var_0_4.SPEED_FACTOR_FOCUS_CHARACTER)

	for iter_47_0, iter_47_1 in pairs(self._characterList) do
		iter_47_1:SetAnimaSpeed(1)
	end

	for iter_47_2, iter_47_3 in pairs(self._bulletList) do
		iter_47_3:SetAnimaSpeed(1)
	end

	self._cameraUtil:ZoomCamara(nil, nil, var_0_4.CAM_RESET_DURATION)

	return
end

function BattleSceneMediator:UpdateFlagShipMark()
	self._goFlagShipMarkTf.position = var_0_5.CameraPosToUICamera((self.FlagShipUIPos:Copy(self._leftFleetMotion:GetPos()))):Add(var_0_8)

	return
end

function BattleSceneMediator:UpdateAntiAirArea()
	self._antiAirAreaTF.position = self._leftFleetMotion:GetPos()

	for iter_49_0, iter_49_1 in pairs(self._anitSubAreaTFList) do
		iter_49_0.position = self._leftFleetMotion:GetPos()
	end

	return
end

function BattleSceneMediator:UpdateAimBiasArea()
	for iter_50_0, iter_50_1 in pairs(self._aimBiasTFList) do
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

function BattleSceneMediator:updateCardAim()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(self._cardAimTargetFilter) do
		local var_51_1 = var_0_6.TargetFleetIndex(nil, {
			fleetPos = iter_51_0
		})[1]

		for iter_51_2, iter_51_3 in ipairs(iter_51_1) do
			local var_51_2

			for iter_51_4, iter_51_5 in ipairs(iter_51_3) do
				var_51_2 = var_0_6[iter_51_5](var_51_1, nil, var_51_2)
			end

			for iter_51_6, iter_51_7 in ipairs(var_51_2) do
				var_51_0[iter_51_7:GetUniqueID()] = true
			end
		end
	end

	for iter_51_8, iter_51_9 in pairs(self._cardAimTargetList) do
		if not var_51_0[iter_51_8] then
			Object.Destroy(go(iter_51_9))

			self._cardAimTargetList[iter_51_8] = nil
		end
	end

	for iter_51_10, iter_51_11 in pairs(var_51_0) do
		local var_51_3 = self._cardAimTargetList[iter_51_10] or self:InstantiateCharacterComponent("SkillAimContainer/SkillAim").transform

		self._cardAimTargetList[iter_51_10] = var_51_3

		if self._characterList[iter_51_10] then
			var_51_3.position = self._characterList[iter_51_10]:GetReferenceVector(self._characterList[iter_51_10].AIM_OFFSET)
		end
	end

	return
end

function BattleSceneMediator:AddBullet(arg_52_1)
	local var_52_0 = arg_52_1:GetBulletData()

	self._bulletList[var_52_0:GetUniqueID()] = arg_52_1

	local var_52_1 = arg_52_1:GetGO()

	if var_52_1 and var_52_1:GetComponent(typeof(ParticleSystem)) then
		self._particleBulletList[arg_52_1] = true
	end

	if var_0_5.focusExemptList[var_52_0:GetSpeedExemptKey()] then
		arg_52_1:SetAnimaSpeed(1 / self._state:GetTimeScaleRate())
	end

	return
end

function BattleSceneMediator:RemoveBullet(arg_53_1)
	if self._bulletList[arg_53_1] then
		self._particleBulletList[self._bulletList[arg_53_1]] = nil

		self._bulletList[arg_53_1]:GetFactory():RemoveBullet(self._bulletList[arg_53_1])
	end

	self._bulletList[arg_53_1] = nil

	return
end

function BattleSceneMediator:GetBulletRoot()
	return self._bulletContainer
end

function BattleSceneMediator:EnablePopContainer(arg_55_1, arg_55_2)
	setActive(self._state:GetUI()._tf:Find(arg_55_1), arg_55_2)

	return
end

function BattleSceneMediator:AddPlayerCharacter(arg_56_1)
	self:AppendCharacter(arg_56_1)

	local var_56_0 = self._dataProxy:GetInitData().battleType
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

function BattleSceneMediator:AddEnemyCharacter(arg_57_1)
	self:AppendCharacter(arg_57_1)

	return
end

function BattleSceneMediator:AppendCharacter(arg_58_1)
	self._characterList[arg_58_1:GetUnitData():GetUniqueID()] = arg_58_1

	return
end

function BattleSceneMediator:InstantiateCharacterComponent(arg_59_1)
	local var_59_0 = self._state:GetUI()._tf:Find(arg_59_1)

	return cloneTplTo(var_59_0, var_59_0.parent).gameObject
end

function BattleSceneMediator:GetCharacterList()
	return self._characterList
end

function BattleSceneMediator:GetPopNumPool()
	return self._popNumMgr
end

function BattleSceneMediator:PauseCharacterAction(arg_62_1)
	for iter_62_0, iter_62_1 in pairs(self._characterList) do
		iter_62_1:PauseActionAnimation(arg_62_1)
	end

	return
end

function BattleSceneMediator:GetCharacter(arg_63_1)
	return self._characterList[arg_63_1]
end

function BattleSceneMediator:GetAircraft(arg_64_1)
	return self._aircraftList[arg_64_1]
end

function BattleSceneMediator:AddAirCraftCharacter(arg_65_1)
	self._aircraftList[arg_65_1:GetUnitData():GetUniqueID()] = arg_65_1

	return
end

function BattleSceneMediator:AddArea(arg_66_1, arg_66_2)
	self._areaList[arg_66_1:GetUniqueID()] = var_0_0.Battle.BattleEffectArea.New(self._fxPool:GetFX(arg_66_2), arg_66_1, not not (pg.effect_offset[arg_66_2] and pg.effect_offset[arg_66_2].top_cover_offset == true))

	return
end

function BattleSceneMediator:RemoveArea(arg_67_1)
	if self._areaList[arg_67_1] then
		self._areaList[arg_67_1]:Dispose()

		self._areaList[arg_67_1] = nil
	end

	return
end

function BattleSceneMediator:AddEffect(arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = self._fxPool:GetFX(arg_68_1)

	arg_68_3 = arg_68_3 or 1
	var_68_0.transform.localScale = Vector3(arg_68_3, 1, arg_68_3)

	pg.EffectMgr.GetInstance():PlayBattleEffect(var_68_0, arg_68_2, true)

	return
end

function BattleSceneMediator:AddArcEffect(arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	local var_69_0 = var_0_0.Battle.BattleArcEffect.New(self._fxPool:GetFX(arg_69_1), arg_69_2, arg_69_3, arg_69_4)

	var_69_0:ConfigCallback(function()
		self:RemoveArcEffect(var_69_0)

		return
	end)
	table.insert(self._arcEffectList, var_69_0)

	return
end

function BattleSceneMediator:RemoveArcEffect(arg_71_1)
	for iter_71_0, iter_71_1 in ipairs(self._arcEffectList) do
		if iter_71_1 == arg_71_1 then
			iter_71_1:Dispose()
			table.remove(self._arcEffectList, iter_71_0)

			break
		end
	end

	return
end

function BattleSceneMediator:Reinitialize()
	self:Clear()
	self:Init()

	return
end

function BattleSceneMediator:AllBulletNeutralize()
	for iter_73_0, iter_73_1 in pairs(self._characterList) do
		if iter_73_1.__name == var_0_0.Battle.BattlePlayerCharacter.__name or iter_73_1.__name == var_0_0.Battle.BattleSubCharacter.__name then
			iter_73_1:DisableWeaponTrack()
		end
	end

	self._antiAirArea:SetActive(false)

	for iter_73_2, iter_73_3 in pairs(self._bulletList) do
		iter_73_3:Neutrailze()
	end

	var_0_0.Battle.BattleBulletFactory.NeutralizeBullet()

	return
end

function BattleSceneMediator:Clear()
	for iter_74_0, iter_74_1 in pairs(self._characterList) do
		iter_74_1:GetFactory():RemoveCharacter(iter_74_1)
	end

	for iter_74_2, iter_74_3 in pairs(self._aircraftList) do
		iter_74_3:GetFactory():RemoveCharacter(iter_74_3)
	end

	self._characterList = nil
	self._characterFactoryList = nil

	for iter_74_4, iter_74_5 in pairs(self._bulletList) do
		self:RemoveBullet(iter_74_4)
	end

	for iter_74_6, iter_74_7 in pairs((var_0_0.Battle.BattleBulletFactory.GetFactoryList())) do
		iter_74_7:Clear()
	end

	self._fxPool:Clear()

	for iter_74_8, iter_74_9 in pairs(self._areaList) do
		self:RemoveArea(iter_74_8)
	end

	self._areaList = nil

	for iter_74_10, iter_74_11 in ipairs(self._arcEffectList) do
		iter_74_11:Dispose()
	end

	self._arcEffectList = nil

	for iter_74_12, iter_74_13 in pairs(self._cardAimTargetList) do
		Object.Destroy(go(iter_74_13))
	end

	self._cardAimTargetList = nil

	var_0_0.Battle.BattleCharacterFXContainersPool.GetInstance():Clear()
	self._popNumMgr:Clear()
	var_0_0.Battle.BattleHPBarManager.GetInstance():Clear()
	var_0_0.Battle.BattleArrowManager.GetInstance():Clear()

	self._anitSubAreaTFList = nil

	return
end

function BattleSceneMediator:Dispose()
	self:Clear()
	self:RemoveEvent()
	BattleSceneMediator.super.Dispose(self)

	return
end

return
