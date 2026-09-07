ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local var_0_3 = ys.Battle.BattleFormulas
local var_0_4 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleAttr
local var_0_7 = ys.Battle.BattleDataFunction
local BattleFleetVO = class("BattleFleetVO")

ys.Battle.BattleFleetVO = BattleFleetVO
BattleFleetVO.__name = "BattleFleetVO"

function BattleFleetVO:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.EventListener.AttachEventListener(self)

	self._IFF = arg_1_1
	self._lastDist = 0

	self:init()

	return
end

function BattleFleetVO:UpdateMotion()
	local var_2_0 = 0

	if self._motionReferenceUnit then
		self._motionVO:UpdatePos(self._motionReferenceUnit)
		self._motionVO:UpdateVelocityAndDirection(self:GetFleetVelocity(), self._motionSourceFunc())

		var_2_0 = math.max(self._motionVO:GetPos().x - self._rightBound, 0)
	end

	if var_2_0 >= 0 and var_2_0 ~= self._lastDist then
		self._lastDist = var_2_0

		self:DispatchEvent(var_0_0.Event.New(var_0_2.SHOW_BUFFER, {
			dist = var_2_0
		}))
	end

	return
end

function BattleFleetVO:UpdateAutoComponent(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._scoutList) do
		iter_3_1:UpdateWeapon(arg_3_1)
		iter_3_1:UpdateAirAssist()
	end

	for iter_3_2, iter_3_3 in ipairs(self._mainList) do
		iter_3_3:UpdateWeapon(arg_3_1)
		iter_3_3:UpdateAirAssist()
	end

	for iter_3_4, iter_3_5 in ipairs(self._supportList) do
		iter_3_5:UpdateWeapon(arg_3_1)
	end

	for iter_3_6, iter_3_7 in ipairs(self._cloakList) do
		iter_3_7:UpdateCloak(arg_3_1)
	end

	for iter_3_8, iter_3_9 in ipairs(self._subList) do
		iter_3_9:UpdateWeapon(arg_3_1)
		iter_3_9:UpdateOxygen(arg_3_1)
		iter_3_9:UpdatePhaseSwitcher()
	end

	for iter_3_10, iter_3_11 in ipairs(self._manualSubList) do
		iter_3_11:UpdateOxygen(arg_3_1)
	end

	self._fleetAntiAir:Update(arg_3_1)
	self._fleetRangeAntiAir:Update(arg_3_1)
	self._fleetStaticSonar:Update(arg_3_1)

	for iter_3_12, iter_3_13 in pairs(self._indieSonarList) do
		iter_3_12:Update(arg_3_1)
	end

	self:UpdateBuff(arg_3_1)

	if self._cardPuzzleComponent then
		self._cardPuzzleComponent:Update(arg_3_1)
	end

	return
end

function BattleFleetVO:UpdateBuff(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self._buffList) do
		iter_4_1:Update(self, arg_4_1)
	end

	return
end

function BattleFleetVO:UpdateManualWeaponVO(arg_5_1)
	self._chargeWeaponVO:Update(arg_5_1)
	self._torpedoWeaponVO:Update(arg_5_1)
	self._airAssistVO:Update(arg_5_1)
	self._submarineDiveVO:Update(arg_5_1)
	self._submarineFloatVO:Update(arg_5_1)
	self._submarineBoostVO:Update(arg_5_1)
	self._submarineShiftVO:Update(arg_5_1)

	return
end

function BattleFleetVO:UpdateFleetDamage(arg_6_1)
	self._currentDMGRatio = self._currentDMGRatio + var_0_3.CalculateFleetDamage(arg_6_1)

	self:DispatchFleetDamageChange()

	return
end

function BattleFleetVO:UpdateFleetOverDamage(arg_7_1)
	self._currentDMGRatio = self._currentDMGRatio - var_0_3.CalculateFleetOverDamage(self, arg_7_1)

	self:DispatchFleetDamageChange()

	return
end

function BattleFleetVO:DispatchFleetDamageChange()
	self:DispatchEvent(var_0_0.Event.New(var_0_2.FLEET_DMG_CHANGE, {}))

	return
end

function BattleFleetVO:DispatchSonarScan(arg_9_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.SONAR_SCAN, {
		indieSonar = arg_9_1
	}))

	return
end

function BattleFleetVO:FleetBuffTrigger(arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(self._unitList) do
		iter_10_1:TriggerBuff(arg_10_1, arg_10_2)
	end

	return
end

function BattleFleetVO:FreeMainUnit(arg_11_1)
	if self._mainUnitFree then
		return
	end

	self._mainUnitFree = true

	for iter_11_0, iter_11_1 in ipairs(self._mainList) do
		iter_11_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_11_1)))
		iter_11_1:SetMainUnitStatic(false)
	end

	return
end

function BattleFleetVO:RandomMainVictim(arg_12_1)
	arg_12_1 = arg_12_1 or {}

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._mainList) do
		local var_12_2 = true

		for iter_12_2, iter_12_3 in ipairs(arg_12_1) do
			if iter_12_1:GetAttrByName(iter_12_3) >= 1 then
				var_12_2 = false

				break
			end
		end

		if var_12_2 then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return (#var_12_0 > 0 or nil) and var_12_0[math.random(#var_12_0)]
end

function BattleFleetVO:NearestUnitByType(arg_13_1, arg_13_2)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(self._unitList) do
		if table.contains(arg_13_2, iter_13_1:GetTemplate().type) then
			if Vector3.BattleDistance(iter_13_1:GetPosition(), arg_13_1) < 999 then
				var_13_0 = iter_13_1
			end
		end
	end

	return var_13_0
end

function BattleFleetVO:SetMotionSource(arg_14_1)
	self._motionSourceFunc = arg_14_1 == nil and function()
		local var_15_0 = pg.UIMgr.GetInstance()

		return var_15_0.hrz, var_15_0.vtc
	end or arg_14_1

	return
end

function BattleFleetVO:SetSubAidData(arg_16_1, arg_16_2)
	self._submarineVO = var_0_0.Battle.BattleSubmarineAidVO.New()

	if arg_16_2 == var_0_4.SubAidFlag.AID_EMPTY or arg_16_2 == var_0_4.SubAidFlag.OIL_EMPTY then
		self._submarineVO:SetUseable(false)
	else
		self._submarineVO:SetCount(arg_16_2)
		self._submarineVO:SetTotal(arg_16_1)
		self._submarineVO:SetUseable(true)
	end

	return
end

function BattleFleetVO:SetAutobotBound(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._upperBound = arg_17_1
	self._lowerBound = arg_17_2
	self._leftBound = arg_17_3
	self._rightBound = arg_17_4

	return
end

function BattleFleetVO:SetTotalBound(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self._totalUpperBound = arg_18_1
	self._totalLowerBound = arg_18_2
	self._totalLeftBound = arg_18_3
	self._totalRightBound = arg_18_4

	return
end

function BattleFleetVO:SetUnitBound(arg_19_1, arg_19_2)
	self._fleetUnitBound = var_0_0.Battle.BattleFleetBound.New(self._IFF)

	self._fleetUnitBound:ConfigAreaData(arg_19_1, arg_19_2)
	self._fleetUnitBound:SwtichCommon()

	return
end

function BattleFleetVO:SetChapterPlayType(arg_20_1)
	self._chapterType = arg_20_1

	return
end

function BattleFleetVO:GetLeftBoundDistance()
	if self._chapterType and self._chapterType == 5 then
		return math.abs(self._motionVO:GetPos().x - self._leftBound)
	end

	return
end

function BattleFleetVO:UpdateScoutUnitBound()
	local var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5 = self._fleetUnitBound:GetBound()

	for iter_22_0, iter_22_1 in ipairs(self._scoutList) do
		iter_22_1:SetBound(var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5)
	end

	for iter_22_2, iter_22_3 in pairs(self._freezeList) do
		if not iter_22_2:IsMainFleetUnit() then
			iter_22_2:SetBound(var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5)
		end
	end

	return
end

function BattleFleetVO:CalcSubmarineBaseLine(arg_23_1)
	if self._IFF == var_0_5.FRIENDLY_CODE then
		if arg_23_1 == SYSTEM_DUEL then
			-- block empty
		else
			self._subAttackBaseLine = (self._totalRightBound + self._totalLeftBound) * 0.5
			self._subRetreatBaseLine = self._leftBound - 10
		end
	elseif self._IFF == var_0_5.FOE_CODE and arg_23_1 == SYSTEM_DUEL then
		-- block empty
	end

	return
end

function BattleFleetVO:SetExposeLine(arg_24_1, arg_24_2)
	self._visionLineX = arg_24_1
	self._exposeLineX = arg_24_2

	return
end

function BattleFleetVO:AppendPlayerUnit(arg_25_1)
	self._unitList[#self._unitList + 1] = arg_25_1
	self._maxCount = self._maxCount + 1

	if arg_25_1:IsMainFleetUnit() then
		self:appendMainUnit(arg_25_1)
	else
		self:appendScoutUnit(arg_25_1)
	end

	arg_25_1:SetFleetVO(self)
	arg_25_1:SetMotion(self._motionVO)
	arg_25_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)
	arg_25_1:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_STATE, self.onUnitCloakUpdate)

	if self._cardPuzzleComponent then
		self._cardPuzzleComponent:AppendUnit(arg_25_1)
	end

	return
end

function BattleFleetVO:RemovePlayerUnit(arg_26_1, arg_26_2)
	self._freezeList[arg_26_1] = nil

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self._unitList) do
		if iter_26_1 ~= arg_26_1 then
			var_26_0[#var_26_0 + 1] = iter_26_0
		else
			if not arg_26_2 then
				iter_26_1:UnregisterEventListener(self, var_0_1.UPDATE_HP)
				iter_26_1:UnregisterEventListener(self, var_0_1.UPDATE_CLOAK_STATE)
				iter_26_1:DeactiveCldBox()
			end

			for iter_26_2, iter_26_3 in ipairs((iter_26_1:GetChargeList())) do
				if iter_26_3:IsAttacking() then
					self._chargeWeaponVO:CancelFocus()
					self._chargeWeaponVO:ResetFocus()
					self:CancelChargeWeapon()
				end

				self._chargeWeaponVO:RemoveWeapon(iter_26_3)

				if not arg_26_2 then
					iter_26_3:Clear()
				end
			end

			self._fleetAntiAir:RemoveCrewUnit(arg_26_1)
			self._fleetRangeAntiAir:RemoveCrewUnit(arg_26_1)
			self._fleetStaticSonar:RemoveCrewUnit(arg_26_1)

			for iter_26_4, iter_26_5 in ipairs((iter_26_1:GetTorpedoList())) do
				self:RemoveManunalTorpedo(iter_26_5, arg_26_2)
			end

			local var_26_1 = iter_26_1:GetAirAssistList()

			if var_26_1 then
				for iter_26_6, iter_26_7 in ipairs(var_26_1) do
					self._airAssistVO:RemoveWeapon(iter_26_7)
				end
			end
		end
	end

	for iter_26_8, iter_26_9 in ipairs(self._scoutList) do
		if iter_26_9 == arg_26_1 then
			if #self._scoutList == 1 then
				self:CancelChargeWeapon()
			end

			table.remove(self._scoutList, iter_26_8)

			break
		end
	end

	local function var_26_2(arg_27_0)
		for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
			if iter_27_1 == arg_26_1 then
				table.remove(arg_27_0, iter_27_0)

				break
			end
		end

		return
	end

	var_26_2(self._mainList)
	var_26_2(self._cloakList)
	var_26_2(self._subList)
	var_26_2(self._manualSubList)

	if not self._manualSubUnit then
		self:refreshFleetFormation(var_26_0)
	end

	return
end

function BattleFleetVO:OverrideJoyStickAutoBot(arg_28_1)
	self._autoBotAIID = arg_28_1

	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.OVERRIDE_AUTO_BOT)))

	return
end

function BattleFleetVO:SnapShot()
	self._totalDMGRatio = var_0_3.GetFleetTotalHP(self)
	self._currentDMGRatio = self._totalDMGRatio

	return
end

function BattleFleetVO:GetIFF()
	return self._IFF
end

function BattleFleetVO:GetMaxCount()
	return self._maxCount
end

function BattleFleetVO:GetFlagShip()
	return self._flagShip
end

function BattleFleetVO:GetLeaderShip()
	return self._scoutList[1]
end

function BattleFleetVO:GetUnitList()
	return self._unitList
end

function BattleFleetVO:GetFreezeUnitList()
	return self._freezeList
end

function BattleFleetVO:GetMainList()
	return self._mainList
end

function BattleFleetVO:GetScoutList()
	return self._scoutList
end

function BattleFleetVO:GetFreezeShipByID(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._freezeList) do
		if arg_38_1 == iter_38_0:GetAttrByName("id") then
			return iter_38_0
		end
	end

	return
end

function BattleFleetVO:GetShipByID(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(self._unitList) do
		if arg_39_1 == iter_39_1:GetAttrByName("id") then
			return iter_39_1
		end
	end

	return
end

function BattleFleetVO:GetCloakList()
	return self._cloakList
end

function BattleFleetVO:GetSubBench()
	return self._manualSubBench
end

function BattleFleetVO:GetUnitBound()
	return self._fleetUnitBound
end

function BattleFleetVO:GetMotion()
	return self._motionVO
end

function BattleFleetVO:GetMotionReferenceUnit()
	return self._motionReferenceUnit
end

function BattleFleetVO:GetAutoBotAIID()
	return self._autoBotAIID
end

function BattleFleetVO:GetChargeWeaponVO()
	return self._chargeWeaponVO
end

function BattleFleetVO:GetTorpedoWeaponVO()
	return self._torpedoWeaponVO
end

function BattleFleetVO:GetAirAssistVO()
	return self._airAssistVO
end

function BattleFleetVO:GetSubAidVO()
	return self._submarineVO
end

function BattleFleetVO:GetSubFreeDiveVO()
	return self._submarineDiveVO
end

function BattleFleetVO:GetSubFreeFloatVO()
	return self._submarineFloatVO
end

function BattleFleetVO:GetSubBoostVO()
	return self._submarineBoostVO
end

function BattleFleetVO:GetSubSpecialVO()
	return self._submarineSpecialVO
end

function BattleFleetVO:GetSubShiftVO()
	return self._submarineShiftVO
end

function BattleFleetVO:GetFleetAntiAirWeapon()
	return self._fleetAntiAir
end

function BattleFleetVO:GetFleetRangeAntiAirWeapon()
	return self._fleetRangeAntiAir
end

function BattleFleetVO:GetFleetVelocity()
	return var_0_3.GetFleetVelocity(self._scoutList)
end

function BattleFleetVO:GetFleetBound()
	return self._upperBound, self._lowerBound, self._leftBound, self._rightBound
end

function BattleFleetVO:GetFleetUnitBound()
	return self._totalUpperBound, self._totalLowerBound
end

function BattleFleetVO:GetFleetExposeLine()
	return self._exposeLineX
end

function BattleFleetVO:GetFleetVisionLine()
	return self._visionLineX
end

function BattleFleetVO:GetLeaderPersonality()
	return self._motionReferenceUnit:GetAutoPilotPreference()
end

function BattleFleetVO:GetDamageRatioResult()
	return string.format("%0.2f", self._currentDMGRatio / self._totalDMGRatio * 100), self._totalDMGRatio
end

function BattleFleetVO:GetDamageRatio()
	return self._currentDMGRatio / self._totalDMGRatio
end

function BattleFleetVO:GetSubmarineBaseLine()
	return self._fixedSubRefLine or self._subAttackBaseLine, self._subRetreatBaseLine
end

function BattleFleetVO:GetFleetSonar()
	return self._fleetStaticSonar
end

function BattleFleetVO:Dispose()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)
	var_0_0.EventListener.DetachEventListener(self)

	self._leaderUnit = nil

	self._fleetAntiAir:Dispose()
	self._fleetRangeAntiAir:Dispose()
	self._fleetStaticSonar:Dispose()

	self._fleetStaticSonar = nil
	self._buffList = nil
	self._indieSonarList = nil
	self._scoutAimBias = nil

	self._fleetAttr:Dispose()

	self._fleetAttr = nil
	self._freezeList = nil

	return
end

function BattleFleetVO:refreshFleetFormation(arg_68_1)
	local var_68_0 = var_0_7.GetFormationTmpDataFromID(var_0_5.FORMATION_ID).pos_offset

	self._unitList = var_0_7.SortFleetList(arg_68_1, self._unitList)

	if not self._mainUnitFree then
		for iter_68_0, iter_68_1 in ipairs(self._unitList) do
			if not table.contains(self._subList, iter_68_1) then
				local var_68_1 = var_68_0[iter_68_0] or var_68_0[#var_68_0]

				iter_68_1:UpdateFormationOffset(Vector3(var_68_1.x, var_68_1.y, var_68_1.z) + var_0_5.BornOffset * (iter_68_0 - 1))
			end
		end
	end

	if #self._scoutList > 0 then
		self._motionReferenceUnit = self._scoutList[1]
		self._leaderUnit = self._scoutList[1]

		self._leaderUnit:LeaderSetting()
		self._fleetAntiAir:SwitchHost(self._motionReferenceUnit)
		self._fleetStaticSonar:SwitchHost(self._motionReferenceUnit)

		for iter_68_2, iter_68_3 in pairs(self._indieSonarList) do
			iter_68_2:SwitchHost(self._motionReferenceUnit)
		end

		self._motionVO:UpdatePos(self._motionReferenceUnit)
	elseif self._fleetAntiAir:GetCurrentState() ~= self._fleetAntiAir.STATE_DISABLE then
		for iter_68_4, iter_68_5 in pairs((self._fleetAntiAir:GetCrewUnitList())) do
			self._motionReferenceUnit = iter_68_4

			self._fleetAntiAir:SwitchHost(iter_68_4)

			break
		end
	else
		self._motionReferenceUnit = self._mainList[1]
		self._leaderUnit = nil
	end

	if #self:GetUnitList() == 0 then
		return
	end

	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.REFRESH_FLEET_FORMATION)))

	return
end

function BattleFleetVO:init()
	self._chargeWeaponVO = var_0_0.Battle.BattleChargeWeaponVO.New()
	self._torpedoWeaponVO = var_0_0.Battle.BattleTorpedoWeaponVO.New()
	self._airAssistVO = var_0_0.Battle.BattleAllInStrikeVO.New()
	self._submarineDiveVO = var_0_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.DIVE_CD)
	self._submarineFloatVO = var_0_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.FLOAT_CD)
	self._submarineVOList = {
		self._submarineDiveVO,
		self._submarineFloatVO
	}
	self._submarineBoostVO = var_0_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.BOOST_CD)
	self._submarineShiftVO = var_0_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.SHIFT_CD)
	self._submarineSpecialVO = var_0_0.Battle.BattleSubmarineAidVO.New()

	self._submarineSpecialVO:SetCount(1)
	self._submarineSpecialVO:SetTotal(1)

	self._fleetAntiAir = var_0_0.Battle.BattleFleetAntiAirUnit.New()
	self._fleetRangeAntiAir = var_0_0.Battle.BattleFleetRangeAntiAirUnit.New()
	self._motionVO = var_0_0.Battle.BattleFleetMotionVO.New()
	self._fleetStaticSonar = var_0_0.Battle.BattleFleetStaticSonar.New(self)
	self._indieSonarList = {}
	self._scoutList = {}
	self._mainList = {}
	self._subList = {}
	self._supportList = {}
	self._cloakList = {}
	self._manualSubList = {}
	self._manualSubBench = {}
	self._unitList = {}
	self._maxCount = 0
	self._freezeList = {}
	self._blockCast = 0
	self._buffList = {}

	self:AttachFleetAttr()
	self:SetMotionSource()

	return
end

function BattleFleetVO:appendScoutUnit(arg_70_1)
	self._scoutList[#self._scoutList + 1] = arg_70_1

	for iter_70_0, iter_70_1 in ipairs((arg_70_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendWeapon(iter_70_1)
	end

	if #arg_70_1:GetHiveList() > 0 then
		local var_70_0 = var_0_7.CreateAllInStrike(arg_70_1)

		for iter_70_2, iter_70_3 in ipairs(var_70_0) do
			self._airAssistVO:AppendWeapon(iter_70_3)
		end

		arg_70_1:SetAirAssistList(var_70_0)
	end

	self._fleetAntiAir:AppendCrewUnit(arg_70_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_70_1)

	local var_70_1 = 1
	local var_70_2 = {}

	while var_70_1 < #self._unitList do
		table.insert(var_70_2, var_70_1)

		var_70_1 = var_70_1 + 1
	end

	table.insert(var_70_2, #self._scoutList, var_70_1)
	self:refreshFleetFormation(var_70_2)

	return
end

function BattleFleetVO:appendMainUnit(arg_71_1)
	if #self._mainList == 0 then
		self._flagShip = arg_71_1
	end

	self._mainList[#self._mainList + 1] = arg_71_1

	arg_71_1:SetMainUnitIndex(#self._mainList)

	if ShipType.CloakShipType(arg_71_1:GetTemplate().type) then
		self:AttachCloak(arg_71_1)
	end

	for iter_71_0, iter_71_1 in ipairs((arg_71_1:GetChargeList())) do
		self._chargeWeaponVO:AppendWeapon(iter_71_1)
	end

	for iter_71_2, iter_71_3 in ipairs((arg_71_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendWeapon(iter_71_3)
	end

	if #arg_71_1:GetHiveList() > 0 then
		local var_71_0 = var_0_7.CreateAllInStrike(arg_71_1)

		for iter_71_4, iter_71_5 in ipairs(var_71_0) do
			self._airAssistVO:AppendWeapon(iter_71_5)
		end

		arg_71_1:SetAirAssistList(var_71_0)
	end

	self._fleetAntiAir:AppendCrewUnit(arg_71_1)
	self._fleetRangeAntiAir:AppendCrewUnit(arg_71_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_71_1)

	local var_71_1 = {}

	for iter_71_6, iter_71_7 in ipairs(self._unitList) do
		table.insert(var_71_1, iter_71_6)
	end

	self:refreshFleetFormation(var_71_1)

	return
end

function BattleFleetVO:appendSubUnit(arg_72_1)
	self._subList[#self._subList + 1] = arg_72_1

	arg_72_1:SetMainUnitIndex(#self._subList)

	return
end

function BattleFleetVO:FleetWarcry()
	local var_73_0
	local var_73_1 = math.random(0, 1)
	local var_73_2 = self:GetMainList()[1]

	if var_73_2 == nil or var_73_1 == 0 then
		var_73_0 = self:GetScoutList()[1]
	elseif var_73_1 == 1 then
		var_73_0 = var_73_2
	end

	local var_73_3 = "battle"

	var_73_0:DispatchVoice("battle")
	var_73_0:DispatchChat(var_0_0.Battle.BattleDataFunction.GetWords(var_73_0:GetSkinID(), "battle", (var_73_0:GetIntimacy())), 2.5, var_73_3)

	return
end

function BattleFleetVO:FleetUnitSpwanFinish()
	local var_74_0 = 0

	for iter_74_0, iter_74_1 in ipairs(self._unitList) do
		var_74_0 = var_74_0 + iter_74_1:GetGearScore()
	end

	for iter_74_2, iter_74_3 in ipairs(self._unitList) do
		var_0_6.SetCurrent(iter_74_3, "fleetGS", var_74_0)
	end

	return
end

function BattleFleetVO:SubWarcry()
	local var_75_0 = self:GetSubList()[1]

	var_75_0:DispatchVoice("battle")
	var_75_0:DispatchChat(var_0_0.Battle.BattleDataFunction.GetWords(var_75_0:GetSkinID(), "battle", (var_75_0:GetIntimacy())), 2.5, "battle")

	return
end

function BattleFleetVO:SetWeaponBlock(arg_76_1)
	self._blockCast = self._blockCast + arg_76_1

	return
end

function BattleFleetVO:GetWeaponBlock()
	return self._blockCast > 0
end

function BattleFleetVO:CastChargeWeapon()
	if self:GetWeaponBlock() then
		return
	end

	local var_78_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_78_0 ~= nil and var_78_0:GetCurrentState() == var_78_0.STATE_READY then
		var_78_0:Charge()
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CHARGE, {})))
	end

	return
end

function BattleFleetVO:CancelChargeWeapon()
	local var_79_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_79_0 ~= nil and var_79_0:GetCurrentState() == var_79_0.STATE_PRECAST then
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
		var_79_0:CancelCharge()
	end

	return
end

function BattleFleetVO:UnleashChrageWeapon()
	if self:GetWeaponBlock() then
		self:CancelChargeWeapon()

		return
	end

	local var_80_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_80_0 ~= nil and var_80_0:GetCurrentState() == var_80_0.STATE_PRECAST then
		if var_80_0:IsStrikeMode() then
			self:fireChargeWeapon(var_80_0, true, Vector3.New(math.min(self._motionVO:GetPos().x + var_0_5.ChargeWeaponConfig.SIGHT_C, self._totalRightBound), 0, self._motionVO:GetPos().z))
		else
			var_80_0:CancelCharge()
		end

		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
	end

	return
end

function BattleFleetVO:QuickTagChrageWeapon(arg_81_1)
	if self:GetWeaponBlock() then
		return
	end

	local var_81_0
	local var_81_1 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_81_1 ~= nil and var_81_1:GetCurrentState() == var_81_1.STATE_READY then
		var_81_1:QuickTag()

		if #var_81_1:GetLockList() <= 0 then
			var_81_1:CancelQuickTag()
		else
			var_81_0 = self:fireChargeWeapon(var_81_1, arg_81_1)
		end
	end

	return var_81_0
end

function BattleFleetVO:fireChargeWeapon(arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = arg_82_1:GetHost()

	local function var_82_1()
		arg_82_1:DispatchBlink(function()
			arg_82_1:Fire(arg_82_3)

			return
		end)

		return
	end

	if arg_82_1:GetType() == var_0_4.EquipmentType.POINT_AIR_STRIKE then
		arg_82_1:Fire(arg_82_3)
	elseif arg_82_2 then
		if self._IFF == var_0_5.FRIENDLY_CODE then
			self._chargeWeaponVO:PlayCutIn(var_82_0, 1 / var_0_5.FOCUS_MAP_RATE)
		end

		self._chargeWeaponVO:PlayFocus(var_82_0, var_82_1)
	else
		if self._IFF == var_0_5.FRIENDLY_CODE then
			self._chargeWeaponVO:PlayCutIn(var_82_0, 1)
		end

		var_82_1()
	end

	return
end

function BattleFleetVO:UnleashAllInStrike()
	if self:GetWeaponBlock() then
		return
	end

	local var_85_0
	local var_85_1 = self._airAssistVO:GetCurrentWeapon()

	if var_85_1 and var_85_1:GetCurrentState() == var_85_1.STATE_READY then
		local var_85_2 = var_85_1:GetHost()

		if self._IFF == var_0_5.FRIENDLY_CODE and var_85_2:IsMainFleetUnit() then
			self._airAssistVO:PlayCutIn(var_85_2, 1)
		end

		var_85_1:CLSBullet()
		var_85_1:DispatchBlink()

		var_85_0 = var_85_1:Fire()
	end

	return var_85_0
end

function BattleFleetVO:CastTorpedo()
	if self:GetWeaponBlock() then
		return
	end

	local var_86_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_86_0 ~= nil and var_86_0:GetCurrentState() == var_86_0.STATE_READY and var_86_0:Prepar() then
		self:FleetBuffTrigger(var_0_4.BuffEffectType.ON_TORPEDO_BUTTON_PUSH)
	end

	return
end

function BattleFleetVO:CancelTorpedo()
	local var_87_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_87_0 ~= nil and var_87_0:GetCurrentState() == var_87_0.STATE_PRECAST then
		var_87_0:Cancel()
	end

	return
end

function BattleFleetVO:UnleashTorpedo()
	if self:GetWeaponBlock() then
		self:CancelTorpedo()

		return
	end

	local var_88_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_88_0 ~= nil and var_88_0:GetCurrentState() == var_88_0.STATE_PRECAST then
		var_88_0:Fire()
	end

	return
end

function BattleFleetVO:QuickCastTorpedo()
	if self:GetWeaponBlock() then
		return
	end

	local var_89_1 = self._torpedoWeaponVO:GetCurrentWeapon()

	return (var_89_1 ~= nil and var_89_1:GetCurrentState() == var_89_1.STATE_READY or nil) and var_89_1:Fire(true)
end

function BattleFleetVO:RemoveManunalTorpedo(arg_90_1, arg_90_2)
	if arg_90_1:IsAttacking() then
		self:CancelTorpedo()
	end

	self._torpedoWeaponVO:RemoveWeapon(arg_90_1)

	if not arg_90_2 then
		arg_90_1:Clear()
	end

	return
end

function BattleFleetVO:CoupleEncourage()
	local var_91_0 = {}
	local var_91_1 = {}

	for iter_91_0, iter_91_1 in ipairs(self._unitList) do
		local var_91_2 = var_0_7.GetWords(iter_91_1:GetSkinID(), "couple_encourage", (iter_91_1:GetIntimacy()))

		if #var_91_2 > 0 then
			var_91_0[iter_91_1] = var_91_2
		end
	end

	local var_91_3 = var_0_4.CPChatType

	local function var_91_4(arg_92_0, arg_92_1)
		local var_92_0 = {}

		if arg_92_0 == var_91_3.GROUP_ID then
			var_92_0.groupIDList = arg_92_1
		elseif arg_92_0 == var_91_3.SHIP_TYPE then
			var_92_0.ship_type_list = arg_92_1
		elseif arg_92_0 == var_91_3.RARE then
			var_92_0.rarity = arg_92_1[1]
		elseif arg_92_0 == var_91_3.NATIONALITY then
			var_92_0.nationality = arg_92_1[1]
		elseif arg_92_0 == var_91_3.ILLUSTRATOR then
			var_92_0.illustrator = arg_92_1[1]
		elseif arg_92_0 == var_91_3.TEAM then
			var_92_0.teamIndex = arg_92_1[1]
		end

		return var_92_0
	end

	for iter_91_2, iter_91_3 in pairs(var_91_0) do
		for iter_91_4, iter_91_5 in ipairs(iter_91_3) do
			local var_91_5 = iter_91_5[2]
			local var_91_6 = iter_91_5[4] or var_0_4.CPChatType.GROUP_ID
			local var_91_7 = var_0_0.Battle.BattleTargetChoise.TargetAllHelp(iter_91_2)

			if type(var_91_6) == "table" then
				for iter_91_6, iter_91_7 in ipairs(var_91_6) do
					var_91_7 = var_0_0.Battle.BattleTargetChoise[var_0_4.CPChatTargetFunc[iter_91_7]](iter_91_2, var_91_4(iter_91_7, iter_91_5[1][iter_91_6]), var_91_7)
				end
			elseif type(var_91_6) == "number" then
				var_91_7 = var_0_0.Battle.BattleTargetChoise[var_0_4.CPChatTargetFunc[var_91_6]](iter_91_2, var_91_4(var_91_6, iter_91_5[1]), var_91_7)
			end

			if var_91_5 <= #var_91_7 then
				var_91_1[#var_91_1 + 1] = {
					cp = iter_91_2,
					content = iter_91_5[3],
					linkIndex = iter_91_4
				}
			end
		end
	end

	if #var_91_1 > 0 then
		local var_91_8 = var_91_1[math.random(#var_91_1)]

		var_91_8.cp:DispatchVoice("link" .. var_91_8.linkIndex)
		var_91_8.cp:DispatchChat(var_91_8.content, 3, "link" .. var_91_8.linkIndex)
	end

	return
end

function BattleFleetVO:onUnitUpdateHP(arg_93_1)
	for iter_93_0, iter_93_1 in ipairs(self._unitList) do
		iter_93_1:TriggerBuff(var_0_4.BuffEffectType.ON_FRIENDLY_HP_RATIO_UPDATE, {
			unit = arg_93_1.Dispatcher,
			dHP = arg_93_1.Data.dHP
		})

		if iter_93_1 ~= arg_93_1.Dispatcher then
			iter_93_1:TriggerBuff(var_0_4.BuffEffectType.ON_TEAMMATE_HP_RATIO_UPDATE, {
				unit = arg_93_1.Dispatcher,
				dHP = arg_93_1.Data.dHP
			})
		end
	end

	return
end

function BattleFleetVO:onUnitCloakUpdate(arg_94_1)
	local var_94_0 = var_0_6.GetCurrent(arg_94_1.Dispatcher, "isCloak")

	for iter_94_0, iter_94_1 in ipairs(self._unitList) do
		iter_94_1:TriggerBuff(var_0_4.BuffEffectType.ON_CLOAK_UPDATE, {
			cloakState = var_94_0
		})

		if iter_94_1 ~= arg_94_1.Dispatcher then
			iter_94_1:TriggerBuff(var_0_4.BuffEffectType.ON_TEAMMATE_CLOAK_UPDATE, {
				cloakState = var_94_0
			})
		end
	end

	return
end

function BattleFleetVO:SetSubUnitData(arg_95_1)
	self._subUntiDataList = arg_95_1

	return
end

function BattleFleetVO:GetSubUnitData()
	return self._subUntiDataList
end

function BattleFleetVO:AddSubMarine(arg_97_1)
	arg_97_1:InitOxygen()

	local var_97_0 = arg_97_1:GetTemplate()

	var_0_0.Battle.BattleUnitPhaseSwitcher.New(arg_97_1):SetTemplateData(var_0_7.GeneratePlayerSubmarinPhase(self._fixedSubRefLine or self._subAttackBaseLine, self._subRetreatBaseLine, arg_97_1:GetAttrByName("raidDist"), function()
		return arg_97_1:GetRaidDuration()
	end, arg_97_1:GetAttrByName("oxyAtkDuration")))

	self._unitList[#self._unitList + 1] = arg_97_1
	self._subList[#self._subList + 1] = arg_97_1

	arg_97_1:SetFleetVO(self)
	arg_97_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)
	arg_97_1:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_STATE, self.onUnitCloakUpdate)

	return
end

function BattleFleetVO:AddManualSubmarine(arg_99_1)
	self._unitList[#self._unitList + 1] = arg_99_1
	self._manualSubList[#self._manualSubList + 1] = arg_99_1
	self._manualSubBench[#self._manualSubBench + 1] = arg_99_1
	self._maxCount = self._maxCount + 1

	arg_99_1:InitOxygen()
	arg_99_1:SetFleetVO(self)
	arg_99_1:SetMotion(self._motionVO)
	arg_99_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)
	arg_99_1:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_STATE, self.onUnitCloakUpdate)

	return
end

function BattleFleetVO:GetSubList()
	return self._subList
end

function BattleFleetVO:ShiftManualSub()
	local var_101_0

	if self._manualSubUnit then
		for iter_101_0, iter_101_1 in ipairs((self._manualSubUnit:GetTorpedoList())) do
			if iter_101_1:IsAttacking() then
				self:CancelTorpedo()
			end

			self._torpedoWeaponVO:RemoveWeapon(iter_101_1)
		end

		if self._manualSubUnit:IsAlive() then
			table.insert(self._manualSubBench, self._manualSubUnit)
		end

		var_101_0 = self._motionVO:GetPos():Clone()
	else
		var_101_0 = self._manualSubList[1]:GetPosition():Clone()
	end

	self._manualSubUnit = table.remove(self._manualSubBench, 1)
	self._scoutList[1] = self._manualSubUnit

	local var_101_1 = {}

	for iter_101_2, iter_101_3 in ipairs(self._manualSubBench) do
		for iter_101_4, iter_101_5 in ipairs(self._unitList) do
			if iter_101_5 == iter_101_3 then
				table.insert(var_101_1, iter_101_4)

				break
			end
		end
	end

	for iter_101_6, iter_101_7 in ipairs(self._unitList) do
		if iter_101_7 == self._manualSubUnit then
			table.insert(var_101_1, 1, iter_101_6)

			break
		end
	end

	self:refreshFleetFormation(var_101_1)
	self._manualSubUnit:SetMainUnitStatic(false)
	self._manualSubUnit:SetPosition(var_101_0)
	self:UpdateMotion()
	self._submarineSpecialVO:SetUseable(false)

	for iter_101_8, iter_101_9 in pairs((self._manualSubUnit:GetBuffList())) do
		if iter_101_9:IsSubmarineSpecial() then
			self._submarineSpecialVO:SetCount(1)
			self._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	self:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE)
	self._torpedoWeaponVO:Reset()

	local var_101_2 = self._manualSubUnit:GetTorpedoList()

	for iter_101_10, iter_101_11 in ipairs(var_101_2) do
		if iter_101_11:GetCurrentState() ~= iter_101_11.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_101_11)
		end
	end

	for iter_101_12, iter_101_13 in ipairs(var_101_2) do
		if iter_101_13:GetCurrentState() == iter_101_13.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_101_13)
		end
	end

	if var_0_6.GetCurrent(self._manualSubUnit, "oxyMax") <= 0 then
		self._submarineDiveVO:SetActive(false)
		self._submarineFloatVO:SetActive(false)
	else
		self._submarineDiveVO:SetActive(true)
		self._submarineFloatVO:SetActive(true)
	end

	for iter_101_14, iter_101_15 in ipairs(self._manualSubBench) do
		iter_101_15:SetPosition(var_0_5.SUB_BENCH_POS[iter_101_14])
		iter_101_15:SetMainUnitStatic(true)
		iter_101_15:ChangeOxygenState(var_0_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	self._submarineShiftVO:ResetCurrent()

	if #self._manualSubBench == 0 then
		self._submarineShiftVO:SetActive(false)
	end

	return
end

function BattleFleetVO:ChangeSubmarineState(arg_102_1, arg_102_2)
	if not self._manualSubUnit then
		return
	end

	self._manualSubUnit:ChangeOxygenState(arg_102_1)

	if arg_102_2 then
		for iter_102_0, iter_102_1 in ipairs(self._submarineVOList) do
			iter_102_1:ResetCurrent()
		end

		if self._submarineShiftVO:IsOverLoad() and self._submarineShiftVO:GetMax() - self._submarineShiftVO:GetCurrent() > var_0_5.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			self._submarineShiftVO:SetMax(var_0_5.SR_CONFIG.DIVE_CD)
			self._submarineShiftVO:ResetCurrent()
		end
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_SUBMARINE_SHIFT, {
		state = arg_102_1
	}))

	return
end

function BattleFleetVO:SubmarinBoost()
	self._manualSubUnit:Boost(Vector3.right, var_0_5.SR_CONFIG.BOOST_SPEED, var_0_5.SR_CONFIG.BOOST_DECAY, var_0_5.SR_CONFIG.BOOST_DURATION, var_0_5.SR_CONFIG.BOOST_DECAY_STAMP)
	self._submarineBoostVO:ResetCurrent()

	return
end

function BattleFleetVO:UnleashSubmarineSpecial()
	if self:GetWeaponBlock() then
		return
	end

	self._submarineSpecialVO:Cast()
	self._manualSubUnit:TriggerBuff(var_0_4.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

function BattleFleetVO:FixSubRefLine(arg_105_1)
	self._fixedSubRefLine = arg_105_1

	return
end

function BattleFleetVO:AppendIndieSonar(arg_106_1, arg_106_2)
	if not self._motionReferenceUnit then
		return
	end

	local var_106_0 = var_0_0.Battle.BattleIndieSonar.New(self, arg_106_1, arg_106_2)

	var_106_0:SwitchHost(self._motionReferenceUnit)

	self._indieSonarList[var_106_0] = true

	var_106_0:Detect()

	return
end

function BattleFleetVO:RemoveIndieSonar(arg_107_1)
	for iter_107_0, iter_107_1 in pairs(self._indieSonarList) do
		if arg_107_1 == iter_107_0 then
			self._indieSonarList[iter_107_0] = nil

			break
		end
	end

	return
end

function BattleFleetVO:AttachFleetBuff(arg_108_1)
	local var_108_0 = arg_108_1:GetID()
	local var_108_1 = self:GetFleetBuff(var_108_0)

	if var_108_1 then
		var_108_1:Stack(self)
	else
		self._buffList[var_108_0] = arg_108_1

		arg_108_1:Attach(self)
	end

	return
end

function BattleFleetVO:RemoveFleetBuff(arg_109_1)
	local var_109_0 = self:GetFleetBuff(arg_109_1)

	if var_109_0 then
		var_109_0:Remove()
	end

	return
end

function BattleFleetVO:GetFleetBuff(arg_110_1)
	return self._buffList[arg_110_1]
end

function BattleFleetVO:GetFleetBuffList()
	return self._buffList
end

function BattleFleetVO:AttachFleetAttr()
	self._fleetAttr = var_0_0.Battle.BattleFleetAttrComponent.New(self)

	return
end

function BattleFleetVO:GetFleetAttr()
	return self._fleetAttr
end

function BattleFleetVO:Jamming(arg_114_1)
	if arg_114_1 then
		self._chargeWeaponVO:StartJamming()
		self._torpedoWeaponVO:StartJamming()
		self._airAssistVO:StartJamming()
	else
		self._chargeWeaponVO:JammingEliminate()
		self._torpedoWeaponVO:JammingEliminate()
		self._airAssistVO:JammingEliminate()
	end

	return
end

function BattleFleetVO:Blinding(arg_115_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.FLEET_BLIND, {
		isBlind = arg_115_1
	}))

	return
end

function BattleFleetVO:UpdateHorizon()
	self:DispatchEvent(var_0_0.Event.New(var_0_2.FLEET_HORIZON_UPDATE, {}))

	return
end

function BattleFleetVO:AutoBotUpdated(arg_117_1)
	self:FleetBuffTrigger((arg_117_1 or nil) and (var_0_4.BuffEffectType.ON_AUTOBOT or var_0_4.BuffEffectType.ON_MANUAL))

	return
end

function BattleFleetVO:CloakFatalExpose()
	for iter_118_0, iter_118_1 in ipairs(self._cloakList) do
		iter_118_1:GetCloak():ForceToMax()
	end

	return
end

function BattleFleetVO:CloakInVision(arg_119_1)
	for iter_119_0, iter_119_1 in ipairs(self._cloakList) do
		iter_119_1:GetCloak():AppendExposeSpeed(arg_119_1)
	end

	return
end

function BattleFleetVO:CloakOutVision()
	for iter_120_0, iter_120_1 in ipairs(self._cloakList) do
		iter_120_1:GetCloak():AppendExposeSpeed(0)
	end

	return
end

function BattleFleetVO:AttachCloak(arg_121_1)
	if not arg_121_1:GetCloak() then
		arg_121_1:InitCloak()

		self._cloakList[#self._cloakList + 1] = arg_121_1
	end

	return
end

function BattleFleetVO:AttachNightCloak()
	self._scoutAimBias = var_0_0.Battle.BattleUnitAimBiasComponent.New()

	self._scoutAimBias:ConfigRangeFormula(var_0_3.CalculateMaxAimBiasRange, var_0_3.CalculateBiasDecay)
	self._scoutAimBias:Active(self._scoutAimBias.STATE_ACTIVITING)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.ADD_AIM_BIAS, {
		aimBias = self._scoutAimBias
	}))

	return
end

function BattleFleetVO:GetFleetBias()
	return self._scoutAimBias
end

function BattleFleetVO:FreezeUnit(arg_124_1)
	self:RemovePlayerUnit(arg_124_1, true)

	self._freezeList[arg_124_1] = true

	return
end

function BattleFleetVO:ActiveFreezeUnit(arg_125_1)
	self._freezeList[arg_125_1] = nil
	self._unitList[#self._unitList + 1] = arg_125_1
	self._maxCount = self._maxCount + 1

	if arg_125_1:IsMainFleetUnit() then
		self:appendFreezeMainUnit(arg_125_1)
	else
		self:activeFreezeScoutUnit(arg_125_1)
	end

	arg_125_1:SetFleetVO(self)
	arg_125_1:SetMotion(self._motionVO)
	arg_125_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)
	arg_125_1:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_STATE, self.onUnitCloakUpdate)

	return
end

function BattleFleetVO:UndoFusion()
	for iter_126_0, iter_126_1 in pairs(self._freezeList) do
		self._unitList[#self._unitList + 1] = iter_126_0
		self._maxCount = self._maxCount + 1

		if iter_126_0:IsMainFleetUnit() then
			self:appendFreezeMainUnit(iter_126_0)
		else
			self:activeFreezeScoutUnit(iter_126_0)
		end
	end

	local var_126_0 = {}

	for iter_126_2, iter_126_3 in ipairs(self._unitList) do
		local var_126_1 = iter_126_3:GetAttrByName("hpProvideRate")

		if var_126_1 ~= 0 then
			table.insert(var_126_0, iter_126_3)

			local var_126_2, var_126_3 = iter_126_3:GetHP()

			for iter_126_4, iter_126_5 in pairs(var_126_1) do
				local var_126_5 = self:GetFreezeShipByID(iter_126_4)

				if not var_126_5 then
					self:GetShipByID(iter_126_4)
				end

				var_126_5:UpdateHP(math.floor(iter_126_5 * (var_126_3 - var_126_2)) * -1, {})
			end
		end
	end

	for iter_126_6, iter_126_7 in ipairs(var_126_0) do
		self:RemovePlayerUnit(iter_126_7)
	end

	return
end

function BattleFleetVO:appendFreezeMainUnit(arg_127_1)
	self._mainList[#self._mainList + 1] = arg_127_1

	arg_127_1:SetMainUnitIndex(#self._mainList)

	if ShipType.CloakShipType(arg_127_1:GetTemplate().type) then
		table.insert(self._cloakList, arg_127_1)
	end

	for iter_127_0, iter_127_1 in ipairs((arg_127_1:GetChargeList())) do
		self._chargeWeaponVO:AppendFreezeWeapon(iter_127_1)
	end

	for iter_127_2, iter_127_3 in ipairs((arg_127_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendFreezeWeapon(iter_127_3)
	end

	if arg_127_1:GetAirAssistList() then
		for iter_127_4, iter_127_5 in ipairs((arg_127_1:GetAirAssistList())) do
			self._airAssistVO:AppendFreezeWeapon(iter_127_5)
		end
	end

	self._fleetAntiAir:AppendCrewUnit(arg_127_1)
	self._fleetRangeAntiAir:AppendCrewUnit(arg_127_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_127_1)

	local var_127_0 = {}

	for iter_127_6, iter_127_7 in ipairs(self._unitList) do
		table.insert(var_127_0, iter_127_6)
	end

	self:refreshFleetFormation(var_127_0)

	return
end

function BattleFleetVO:activeFreezeScoutUnit(arg_128_1)
	self._scoutList[#self._scoutList + 1] = arg_128_1

	for iter_128_0, iter_128_1 in ipairs((arg_128_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendFreezeWeapon(iter_128_1)
	end

	if arg_128_1:GetAirAssistList() then
		for iter_128_2, iter_128_3 in ipairs((arg_128_1:GetAirAssistList())) do
			self._airAssistVO:AppendFreezeWeapon(iter_128_3)
		end
	end

	self._fleetAntiAir:AppendCrewUnit(arg_128_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_128_1)

	local var_128_0 = 1
	local var_128_1 = {}

	while var_128_0 < #self._unitList do
		table.insert(var_128_1, var_128_0)

		var_128_0 = var_128_0 + 1
	end

	table.insert(var_128_1, #self._scoutList, var_128_0)
	self:refreshFleetFormation(var_128_1)

	return
end

function BattleFleetVO:AttachCardPuzzleComponent()
	self._cardPuzzleComponent = var_0_0.Battle.BattleFleetCardPuzzleComponent.New(self)

	return self._cardPuzzleComponent
end

function BattleFleetVO:GetCardPuzzleComponent()
	return self._cardPuzzleComponent
end

function BattleFleetVO:AppendSupportUnit(arg_131_1)
	self._supportList[#self._supportList + 1] = arg_131_1

	return
end

function BattleFleetVO:GetSupportUnitList()
	return self._supportList
end

return
