ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local var_0_3 = ys.Battle.BattleFormulas
local var_0_4 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConfig
local var_0_7 = ys.Battle.BattleDataFunction
local var_0_8 = ys.Battle.BattleAttr
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
	if self._motionReferenceUnit then
		self._motionVO:UpdatePos(self._motionReferenceUnit)
		self._motionVO:UpdateVelocityAndDirection(self:GetFleetVelocity(), self._motionSourceFunc())
	end

	local var_2_0 = math.max(self._motionVO:GetPos().x - self._rightBound, 0)

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

	for iter_3_4, iter_3_5 in ipairs(self._cloakList) do
		iter_3_5:UpdateCloak(arg_3_1)
	end

	for iter_3_6, iter_3_7 in ipairs(self._subList) do
		iter_3_7:UpdateWeapon(arg_3_1)
		iter_3_7:UpdateOxygen(arg_3_1)
		iter_3_7:UpdatePhaseSwitcher()
	end

	for iter_3_8, iter_3_9 in ipairs(self._manualSubList) do
		iter_3_9:UpdateOxygen(arg_3_1)
	end

	self._fleetAntiAir:Update(arg_3_1)
	self._fleetRangeAntiAir:Update(arg_3_1)
	self._fleetStaticSonar:Update(arg_3_1)

	for iter_3_10, iter_3_11 in pairs(self._indieSonarList) do
		iter_3_10:Update(arg_3_1)
	end

	self:UpdateBuff(arg_3_1)

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

function BattleFleetVO:FreeMainUnit(arg_10_1)
	if self._mainUnitFree then
		return
	end

	self._mainUnitFree = true

	for iter_10_0, iter_10_1 in ipairs(self._mainList) do
		iter_10_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_10_1)))
		iter_10_1:SetMainUnitStatic(false)
	end

	return
end

function BattleFleetVO:RandomMainVictim(arg_11_1)
	arg_11_1 = arg_11_1 or {}

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._mainList) do
		local var_11_2 = true

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			if iter_11_1:GetAttrByName(iter_11_3) == 1 then
				var_11_2 = false

				break
			end
		end

		if var_11_2 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return (#var_11_0 > 0 or nil) and var_11_0[math.random(#var_11_0)]
end

function BattleFleetVO:NearestUnitByType(arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(self._unitList) do
		if table.contains(arg_12_2, iter_12_1:GetTemplate().type) then
			if Vector3.BattleDistance(iter_12_1:GetPosition(), arg_12_1) < 999 then
				var_12_0 = iter_12_1
			end
		end
	end

	return var_12_0
end

function BattleFleetVO:SetMotionSource(arg_13_1)
	self._motionSourceFunc = arg_13_1 == nil and function()
		local var_14_0 = pg.UIMgr.GetInstance()

		return var_14_0.hrz, var_14_0.vtc
	end or arg_13_1

	return
end

function BattleFleetVO:SetSubAidData(arg_15_1, arg_15_2)
	self._submarineVO = var_0_0.Battle.BattleSubmarineAidVO.New()

	if arg_15_2 == var_0_4.SubAidFlag.AID_EMPTY or arg_15_2 == var_0_4.SubAidFlag.OIL_EMPTY then
		self._submarineVO:SetUseable(false)
	else
		self._submarineVO:SetCount(arg_15_2)
		self._submarineVO:SetTotal(arg_15_1)
		self._submarineVO:SetUseable(true)
	end

	return
end

function BattleFleetVO:SetBound(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self._upperBound = arg_16_1
	self._lowerBound = arg_16_2
	self._leftBound = arg_16_3
	self._rightBound = arg_16_4

	return
end

function BattleFleetVO:SetTotalBound(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._totalUpperBound = arg_17_1
	self._totalLowerBound = arg_17_2
	self._totalLeftBound = arg_17_3
	self._totalRightBound = arg_17_4

	return
end

function BattleFleetVO:CalcSubmarineBaseLine(arg_18_1)
	if self._IFF == var_0_5.FRIENDLY_CODE then
		if arg_18_1 == SYSTEM_DUEL then
			-- block empty
		else
			self._subAttackBaseLine = (self._totalRightBound + self._totalLeftBound) * 0.5
			self._subRetreatBaseLine = self._leftBound - 10
		end
	elseif self._IFF == var_0_5.FOE_CODE and arg_18_1 == SYSTEM_DUEL then
		-- block empty
	end

	return
end

function BattleFleetVO:SetExposeLine(arg_19_1, arg_19_2)
	self._visionLineX = arg_19_1
	self._exposeLineX = arg_19_2

	return
end

function BattleFleetVO:AppendPlayerUnit(arg_20_1)
	self._unitList[#self._unitList + 1] = arg_20_1
	self._maxCount = self._maxCount + 1

	if arg_20_1:IsMainFleetUnit() then
		self:appendMainUnit(arg_20_1)
	else
		self:appendScoutUnit(arg_20_1)
	end

	arg_20_1:SetFleetVO(self)
	arg_20_1:SetMotion(self._motionVO)
	arg_20_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)

	return
end

function BattleFleetVO:RemovePlayerUnit(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self._unitList) do
		if iter_21_1 ~= arg_21_1 then
			var_21_0[#var_21_0 + 1] = iter_21_0
		else
			iter_21_1:UnregisterEventListener(self, var_0_1.UPDATE_HP)
			iter_21_1:DeactiveCldBox()

			for iter_21_2, iter_21_3 in ipairs((iter_21_1:GetChargeList())) do
				if iter_21_3:IsAttacking() then
					self._chargeWeaponVO:CancelFocus()
					self._chargeWeaponVO:ResetFocus()
					self:CancelChargeWeapon()
				end

				self._chargeWeaponVO:RemoveWeapon(iter_21_3)
				iter_21_3:Clear()
			end

			self._fleetAntiAir:RemoveCrewUnit(arg_21_1)
			self._fleetRangeAntiAir:RemoveCrewUnit(arg_21_1)
			self._fleetStaticSonar:RemoveCrewUnit(arg_21_1)

			for iter_21_4, iter_21_5 in ipairs((iter_21_1:GetTorpedoList())) do
				self:RemoveManunalTorpedo(iter_21_5)
			end

			local var_21_1 = iter_21_1:GetAirAssistList()

			if var_21_1 then
				for iter_21_6, iter_21_7 in ipairs(var_21_1) do
					self._airAssistVO:RemoveWeapon(iter_21_7)
				end
			end
		end
	end

	for iter_21_8, iter_21_9 in ipairs(self._scoutList) do
		if iter_21_9 == arg_21_1 then
			if #self._scoutList == 1 then
				self:CancelChargeWeapon()
			end

			table.remove(self._scoutList, iter_21_8)

			break
		end
	end

	for iter_21_10, iter_21_11 in ipairs(self._mainList) do
		if iter_21_11 == arg_21_1 then
			table.remove(self._mainList, iter_21_10)

			break
		end
	end

	for iter_21_12, iter_21_13 in ipairs(self._cloakList) do
		if iter_21_13 == arg_21_1 then
			table.remove(self._cloakList, iter_21_12)

			break
		end
	end

	for iter_21_14, iter_21_15 in ipairs(self._subList, i) do
		if iter_21_15 == arg_21_1 then
			table.remove(self._subList, iter_21_14)

			break
		end
	end

	for iter_21_16, iter_21_17 in ipairs(self._manualSubList) do
		if iter_21_17 == arg_21_1 then
			table.remove(self._manualSubList, iter_21_16)

			break
		end
	end

	if not self._manualSubUnit then
		self:refreshFleetFormation(var_21_0)
	end

	return
end

function BattleFleetVO:OverrideJoyStickAutoBot(arg_22_1)
	self._autoBotAIID = arg_22_1

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

function BattleFleetVO:GetMainList()
	return self._mainList
end

function BattleFleetVO:GetScoutList()
	return self._scoutList
end

function BattleFleetVO:GetCloakList()
	return self._cloakList
end

function BattleFleetVO:GetSubBench()
	return self._manualSubBench
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
	return self._subAttackBaseLine, self._subRetreatBaseLine
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

	return
end

function BattleFleetVO:refreshFleetFormation(arg_57_1)
	local var_57_0 = var_0_7.GetFormationTmpDataFromID(var_0_5.FORMATION_ID).pos_offset

	self._unitList = var_0_7.SortFleetList(arg_57_1, self._unitList)

	if not self._mainUnitFree then
		for iter_57_0, iter_57_1 in ipairs(self._unitList) do
			if not table.contains(self._subList, iter_57_1) then
				iter_57_1:UpdateFormationOffset(Vector3(var_57_0[iter_57_0].x, var_57_0[iter_57_0].y, var_57_0[iter_57_0].z) + var_0_5.BornOffset * (iter_57_0 - 1))
			end
		end
	end

	if #self._scoutList > 0 then
		self._motionReferenceUnit = self._scoutList[1]
		self._leaderUnit = self._scoutList[1]

		self._leaderUnit:LeaderSetting()
		self._fleetAntiAir:SwitchHost(self._motionReferenceUnit)
		self._fleetStaticSonar:SwitchHost(self._motionReferenceUnit)

		for iter_57_2, iter_57_3 in pairs(self._indieSonarList) do
			iter_57_2:SwitchHost(self._motionReferenceUnit)
		end

		self._motionVO:UpdatePos(self._motionReferenceUnit)
	elseif self._fleetAntiAir:GetCurrentState() ~= self._fleetAntiAir.STATE_DISABLE then
		for iter_57_4, iter_57_5 in pairs((self._fleetAntiAir:GetCrewUnitList())) do
			self._motionReferenceUnit = iter_57_4

			self._fleetAntiAir:SwitchHost(iter_57_4)

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
	self._cloakList = {}
	self._manualSubList = {}
	self._manualSubBench = {}
	self._unitList = {}
	self._maxCount = 0
	self._blockCast = 0
	self._buffList = {}

	self:SetMotionSource()

	return
end

function BattleFleetVO:appendScoutUnit(arg_59_1)
	self._scoutList[#self._scoutList + 1] = arg_59_1

	for iter_59_0, iter_59_1 in ipairs((arg_59_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendWeapon(iter_59_1)
	end

	if #arg_59_1:GetHiveList() > 0 then
		local var_59_0 = var_0_7.CreateAllInStrike(arg_59_1)

		for iter_59_2, iter_59_3 in ipairs(var_59_0) do
			self._airAssistVO:AppendWeapon(iter_59_3)
		end

		arg_59_1:SetAirAssistList(var_59_0)
	end

	self._fleetAntiAir:AppendCrewUnit(arg_59_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_59_1)

	local var_59_1 = 1
	local var_59_2 = {}

	while var_59_1 < #self._unitList do
		table.insert(var_59_2, var_59_1)

		var_59_1 = var_59_1 + 1
	end

	table.insert(var_59_2, #self._scoutList, var_59_1)
	self:refreshFleetFormation(var_59_2)

	return
end

function BattleFleetVO:appendMainUnit(arg_60_1)
	if #self._mainList == 0 then
		self._flagShip = arg_60_1
	end

	self._mainList[#self._mainList + 1] = arg_60_1

	arg_60_1:SetMainUnitIndex(#self._mainList)

	if ShipType.CloakShipType(arg_60_1:GetTemplate().type) then
		self:AttachCloak(arg_60_1)
	end

	for iter_60_0, iter_60_1 in ipairs((arg_60_1:GetChargeList())) do
		self._chargeWeaponVO:AppendWeapon(iter_60_1)
	end

	for iter_60_2, iter_60_3 in ipairs((arg_60_1:GetTorpedoList())) do
		self._torpedoWeaponVO:AppendWeapon(iter_60_3)
	end

	if #arg_60_1:GetHiveList() > 0 then
		local var_60_0 = var_0_7.CreateAllInStrike(arg_60_1)

		for iter_60_4, iter_60_5 in ipairs(var_60_0) do
			self._airAssistVO:AppendWeapon(iter_60_5)
		end

		arg_60_1:SetAirAssistList(var_60_0)
	end

	self._fleetAntiAir:AppendCrewUnit(arg_60_1)
	self._fleetRangeAntiAir:AppendCrewUnit(arg_60_1)
	self._fleetStaticSonar:AppendCrewUnit(arg_60_1)

	local var_60_1 = {}

	for iter_60_6, iter_60_7 in ipairs(self._unitList) do
		table.insert(var_60_1, iter_60_6)
	end

	self:refreshFleetFormation(var_60_1)

	return
end

function BattleFleetVO:appendSubUnit(arg_61_1)
	self._subList[#self._subList + 1] = arg_61_1

	arg_61_1:SetMainUnitIndex(#self._subList)

	return
end

function BattleFleetVO:FleetWarcry()
	local var_62_0
	local var_62_1 = math.random(0, 1)
	local var_62_2 = self:GetMainList()[1]

	if var_62_2 == nil or var_62_1 == 0 then
		var_62_0 = self:GetScoutList()[1]
	elseif var_62_1 == 1 then
		var_62_0 = var_62_2
	end

	local var_62_3 = "battle"

	var_62_0:DispatchVoice("battle")
	var_62_0:DispatchChat(var_0_0.Battle.BattleDataFunction.GetWords(var_62_0:GetSkinID(), "battle", (var_62_0:GetIntimacy())), 2.5, var_62_3)

	return
end

function BattleFleetVO:FleetUnitSpwanFinish()
	local var_63_0 = 0

	for iter_63_0, iter_63_1 in ipairs(self._unitList) do
		var_63_0 = var_63_0 + iter_63_1:GetGearScore()
	end

	for iter_63_2, iter_63_3 in ipairs(self._unitList) do
		var_0_8.SetCurrent(iter_63_3, "fleetGS", var_63_0)
	end

	return
end

function BattleFleetVO:SubWarcry()
	local var_64_0 = self:GetSubList()[1]

	var_64_0:DispatchVoice("battle")
	var_64_0:DispatchChat(var_0_0.Battle.BattleDataFunction.GetWords(var_64_0:GetSkinID(), "battle", (var_64_0:GetIntimacy())), 2.5, "battle")

	return
end

function BattleFleetVO:SetWeaponBlock(arg_65_1)
	self._blockCast = self._blockCast + arg_65_1

	return
end

function BattleFleetVO:GetWeaponBlock()
	return self._blockCast > 0
end

function BattleFleetVO:CastChargeWeapon()
	if self:GetWeaponBlock() then
		return
	end

	local var_67_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_67_0 ~= nil and var_67_0:GetCurrentState() == var_67_0.STATE_READY then
		var_67_0:Charge()
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CHARGE, {})))
	end

	return
end

function BattleFleetVO:CancelChargeWeapon()
	local var_68_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_68_0 ~= nil and var_68_0:GetCurrentState() == var_68_0.STATE_PRECAST then
		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
		var_68_0:CancelCharge()
	end

	return
end

function BattleFleetVO:UnleashChrageWeapon()
	if self:GetWeaponBlock() then
		self:CancelChargeWeapon()

		return
	end

	local var_69_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_69_0 ~= nil and var_69_0:GetCurrentState() == var_69_0.STATE_PRECAST then
		if var_69_0:IsStrikeMode() then
			self:fireChargeWeapon(var_69_0, true, Vector3.New(math.min(self._motionVO:GetPos().x + var_0_5.ChargeWeaponConfig.SIGHT_C, self._totalRightBound), 0, self._motionVO:GetPos().z))
		else
			var_69_0:CancelCharge()
		end

		self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
	end

	return
end

function BattleFleetVO:QuickTagChrageWeapon(arg_70_1)
	if self:GetWeaponBlock() then
		return
	end

	local var_70_0 = self._chargeWeaponVO:GetCurrentWeapon()

	if var_70_0 ~= nil and var_70_0:GetCurrentState() == var_70_0.STATE_READY then
		var_70_0:QuickTag()

		if #var_70_0:GetLockList() <= 0 then
			var_70_0:CancelQuickTag()
		else
			self:fireChargeWeapon(var_70_0, arg_70_1)
		end
	end

	return
end

function BattleFleetVO:fireChargeWeapon(arg_71_1, arg_71_2, arg_71_3)
	local var_71_0 = arg_71_1:GetHost()

	local function var_71_1()
		arg_71_1:DispatchBlink(function()
			arg_71_1:Fire(arg_71_3)

			return
		end)

		return
	end

	if arg_71_2 then
		if self._IFF == var_0_5.FRIENDLY_CODE then
			self._chargeWeaponVO:PlayCutIn(var_71_0, 1 / var_0_5.FOCUS_MAP_RATE)
		end

		self._chargeWeaponVO:PlayFocus(var_71_0, var_71_1)
	else
		if self._IFF == var_0_5.FRIENDLY_CODE then
			self._chargeWeaponVO:PlayCutIn(var_71_0, 1)
		end

		var_71_1()
	end

	return
end

function BattleFleetVO:UnleashAllInStrike()
	if self:GetWeaponBlock() then
		return
	end

	local var_74_0 = self._airAssistVO:GetCurrentWeapon()

	if var_74_0 and var_74_0:GetCurrentState() == var_74_0.STATE_READY then
		local var_74_1 = var_74_0:GetHost()

		if self._IFF == var_0_5.FRIENDLY_CODE and var_74_1:IsMainFleetUnit() then
			self._airAssistVO:PlayCutIn(var_74_1, 1)
		end

		var_74_0:CLSBullet()
		var_74_0:DispatchBlink()
		var_74_0:Fire()
	end

	return
end

function BattleFleetVO:CastTorpedo()
	if self:GetWeaponBlock() then
		return
	end

	local var_75_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_75_0 ~= nil and var_75_0:GetCurrentState() == var_75_0.STATE_READY then
		var_75_0:Prepar()
	end

	return
end

function BattleFleetVO:CancelTorpedo()
	local var_76_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_76_0 ~= nil and var_76_0:GetCurrentState() == var_76_0.STATE_PRECAST then
		var_76_0:Cancel()
	end

	return
end

function BattleFleetVO:UnleashTorpedo()
	if self:GetWeaponBlock() then
		self:CancelTorpedo()

		return
	end

	local var_77_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_77_0 ~= nil and var_77_0:GetCurrentState() == var_77_0.STATE_PRECAST then
		var_77_0:Fire()
	end

	return
end

function BattleFleetVO:QuickCastTorpedo()
	if self:GetWeaponBlock() then
		return
	end

	local var_78_0 = self._torpedoWeaponVO:GetCurrentWeapon()

	if var_78_0 ~= nil and var_78_0:GetCurrentState() == var_78_0.STATE_READY then
		var_78_0:Fire(true)
	end

	return
end

function BattleFleetVO:RemoveManunalTorpedo(arg_79_1)
	if arg_79_1:IsAttacking() then
		self:CancelTorpedo()
	end

	self._torpedoWeaponVO:RemoveWeapon(arg_79_1)
	arg_79_1:Clear()

	return
end

function BattleFleetVO:CoupleEncourage()
	local var_80_0 = {}
	local var_80_1 = {}

	for iter_80_0, iter_80_1 in ipairs(self._unitList) do
		local var_80_2 = var_0_7.GetWords(iter_80_1:GetSkinID(), "couple_encourage", (iter_80_1:GetIntimacy()))

		if #var_80_2 > 0 then
			var_80_0[iter_80_1] = var_80_2
		end
	end

	local var_80_3 = var_0_4.CPChatType

	local function var_80_4(arg_81_0, arg_81_1)
		local var_81_0 = {}

		if arg_81_0 == var_80_3.GROUP_ID then
			var_81_0.groupIDList = arg_81_1
		elseif arg_81_0 == var_80_3.SHIP_TYPE then
			var_81_0.ship_type_list = arg_81_1
		elseif arg_81_0 == var_80_3.RARE then
			var_81_0.rarity = arg_81_1[1]
		elseif arg_81_0 == var_80_3.NATIONALITY then
			var_81_0.nationality = arg_81_1[1]
		elseif arg_81_0 == var_80_3.ILLUSTRATOR then
			var_81_0.illustrator = arg_81_1[1]
		elseif arg_81_0 == var_80_3.TEAM then
			var_81_0.teamIndex = arg_81_1[1]
		end

		return var_81_0
	end

	for iter_80_2, iter_80_3 in pairs(var_80_0) do
		for iter_80_4, iter_80_5 in ipairs(iter_80_3) do
			local var_80_5 = iter_80_5[2]
			local var_80_6 = iter_80_5[4] or var_0_4.CPChatType.GROUP_ID
			local var_80_7 = var_0_0.Battle.BattleTargetChoise.TargetAllHelp(iter_80_2)

			if type(var_80_6) == "table" then
				for iter_80_6, iter_80_7 in ipairs(var_80_6) do
					var_80_7 = var_0_0.Battle.BattleTargetChoise[var_0_4.CPChatTargetFunc[iter_80_7]](iter_80_2, var_80_4(iter_80_7, iter_80_5[1][iter_80_6]), var_80_7)
				end
			elseif type(var_80_6) == "number" then
				var_80_7 = var_0_0.Battle.BattleTargetChoise[var_0_4.CPChatTargetFunc[var_80_6]](iter_80_2, var_80_4(var_80_6, iter_80_5[1]), var_80_7)
			end

			if var_80_5 <= #var_80_7 then
				var_80_1[#var_80_1 + 1] = {
					cp = iter_80_2,
					content = iter_80_5[3],
					linkIndex = iter_80_4
				}
			end
		end
	end

	if #var_80_1 > 0 then
		local var_80_8 = var_80_1[math.random(#var_80_1)]

		var_80_8.cp:DispatchVoice("link" .. var_80_8.linkIndex)
		var_80_8.cp:DispatchChat(var_80_8.content, 3, "link" .. var_80_8.linkIndex)
	end

	return
end

function BattleFleetVO:onUnitUpdateHP(arg_82_1)
	for iter_82_0, iter_82_1 in ipairs(self._unitList) do
		iter_82_1:TriggerBuff(var_0_4.BuffEffectType.ON_FRIENDLY_HP_RATIO_UPDATE, {
			unit = arg_82_1.Dispatcher,
			dHP = arg_82_1.Data.dHP
		})

		if iter_82_1 ~= arg_82_1.Dispatcher then
			iter_82_1:TriggerBuff(var_0_4.BuffEffectType.ON_TEAMMATE_HP_RATIO_UPDATE, {
				unit = arg_82_1.Dispatcher,
				dHP = arg_82_1.Data.dHP
			})
		end
	end

	return
end

function BattleFleetVO:SetSubUnitData(arg_83_1)
	self._subUntiDataList = arg_83_1

	return
end

function BattleFleetVO:GetSubUnitData()
	return self._subUntiDataList
end

function BattleFleetVO:AddSubMarine(arg_85_1)
	arg_85_1:InitOxygen()

	local var_85_0 = arg_85_1:GetTemplate()

	var_0_0.Battle.BattleUnitPhaseSwitcher.New(arg_85_1):SetTemplateData(var_0_7.GeneratePlayerSubmarinPhase(self._subAttackBaseLine, self._subRetreatBaseLine, arg_85_1:GetAttrByName("raidDist"), function()
		return arg_85_1:GetRaidDuration()
	end, arg_85_1:GetAttrByName("oxyAtkDuration")))

	self._unitList[#self._unitList + 1] = arg_85_1
	self._subList[#self._subList + 1] = arg_85_1

	arg_85_1:SetFleetVO(self)
	arg_85_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)

	return
end

function BattleFleetVO:AddManualSubmarine(arg_87_1)
	self._unitList[#self._unitList + 1] = arg_87_1
	self._manualSubList[#self._manualSubList + 1] = arg_87_1
	self._manualSubBench[#self._manualSubBench + 1] = arg_87_1
	self._maxCount = self._maxCount + 1

	arg_87_1:InitOxygen()
	arg_87_1:SetFleetVO(self)
	arg_87_1:SetMotion(self._motionVO)
	arg_87_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)

	return
end

function BattleFleetVO:GetSubList()
	return self._subList
end

function BattleFleetVO:ShiftManualSub()
	local var_89_0

	if self._manualSubUnit then
		for iter_89_0, iter_89_1 in ipairs((self._manualSubUnit:GetTorpedoList())) do
			if iter_89_1:IsAttacking() then
				self:CancelTorpedo()
			end

			self._torpedoWeaponVO:RemoveWeapon(iter_89_1)
		end

		if self._manualSubUnit:IsAlive() then
			table.insert(self._manualSubBench, self._manualSubUnit)
		end

		var_89_0 = self._motionVO:GetPos():Clone()
	else
		var_89_0 = self._manualSubList[1]:GetPosition():Clone()
	end

	self._manualSubUnit = table.remove(self._manualSubBench, 1)
	self._scoutList[1] = self._manualSubUnit

	local var_89_1 = {}

	for iter_89_2, iter_89_3 in ipairs(self._manualSubBench) do
		for iter_89_4, iter_89_5 in ipairs(self._unitList) do
			if iter_89_5 == iter_89_3 then
				table.insert(var_89_1, iter_89_4)

				break
			end
		end
	end

	for iter_89_6, iter_89_7 in ipairs(self._unitList) do
		if iter_89_7 == self._manualSubUnit then
			table.insert(var_89_1, 1, iter_89_6)

			break
		end
	end

	self:refreshFleetFormation(var_89_1)
	self._manualSubUnit:SetMainUnitStatic(false)
	self._manualSubUnit:SetPosition(var_89_0)
	self:UpdateMotion()
	self._submarineSpecialVO:SetUseable(false)

	for iter_89_8, iter_89_9 in pairs((self._manualSubUnit:GetBuffList())) do
		if iter_89_9:IsSubmarineSpecial() then
			self._submarineSpecialVO:SetCount(1)
			self._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	self:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE)
	self._torpedoWeaponVO:Reset()

	local var_89_2 = self._manualSubUnit:GetTorpedoList()

	for iter_89_10, iter_89_11 in ipairs(var_89_2) do
		if iter_89_11:GetCurrentState() ~= iter_89_11.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_89_11)
		end
	end

	for iter_89_12, iter_89_13 in ipairs(var_89_2) do
		if iter_89_13:GetCurrentState() == iter_89_13.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_89_13)
		end
	end

	for iter_89_14, iter_89_15 in ipairs(self._manualSubBench) do
		iter_89_15:SetPosition(var_0_5.SUB_BENCH_POS[iter_89_14])
		iter_89_15:SetMainUnitStatic(true)
		iter_89_15:ChangeOxygenState(var_0_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	self._submarineShiftVO:ResetCurrent()

	if #self._manualSubBench == 0 then
		self._submarineShiftVO:SetActive(false)
	end

	return
end

function BattleFleetVO:ChangeSubmarineState(arg_90_1, arg_90_2)
	if not self._manualSubUnit then
		return
	end

	self._manualSubUnit:ChangeOxygenState(arg_90_1)

	if arg_90_2 then
		for iter_90_0, iter_90_1 in ipairs(self._submarineVOList) do
			iter_90_1:ResetCurrent()
		end

		if self._submarineShiftVO:IsOverLoad() and self._submarineShiftVO:GetMax() - self._submarineShiftVO:GetCurrent() > var_0_5.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			self._submarineShiftVO:SetMax(var_0_5.SR_CONFIG.DIVE_CD)
			self._submarineShiftVO:ResetCurrent()
		end
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_SUBMARINE_SHIFT, {
		state = arg_90_1
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

function BattleFleetVO:AppendIndieSonar(arg_93_1, arg_93_2)
	local var_93_0 = var_0_0.Battle.BattleIndieSonar.New(self, arg_93_1, arg_93_2)

	var_93_0:SwitchHost(self._motionReferenceUnit)

	self._indieSonarList[var_93_0] = true

	var_93_0:Detect()

	return
end

function BattleFleetVO:RemoveIndieSonar(arg_94_1)
	for iter_94_0, iter_94_1 in pairs(self._indieSonarList) do
		if arg_94_1 == iter_94_0 then
			self._indieSonarList[iter_94_0] = nil

			break
		end
	end

	return
end

function BattleFleetVO:AttachFleetBuff(arg_95_1)
	local var_95_0 = arg_95_1:GetID()
	local var_95_1 = self:GetFleetBuff(var_95_0)

	if var_95_1 then
		var_95_1:Stack(self)
	else
		self._buffList[var_95_0] = arg_95_1

		arg_95_1:Attach(self)
	end

	return
end

function BattleFleetVO:RemoveFleetBuff(arg_96_1)
	local var_96_0 = self:GetFleetBuff(arg_96_1)

	if var_96_0 then
		var_96_0:Remove()
	end

	return
end

function BattleFleetVO:GetFleetBuff(arg_97_1)
	return self._buffList[arg_97_1]
end

function BattleFleetVO:GetFleetBuffList()
	return self._buffList
end

function BattleFleetVO:Jamming(arg_99_1)
	if arg_99_1 then
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

function BattleFleetVO:Blinding(arg_100_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_2.FLEET_BLIND, {
		isBlind = arg_100_1
	}))

	return
end

function BattleFleetVO:UpdateHorizon()
	self:DispatchEvent(var_0_0.Event.New(var_0_2.FLEET_HORIZON_UPDATE, {}))

	return
end

function BattleFleetVO:AutoBotUpdated(arg_102_1)
	for iter_102_0, iter_102_1 in ipairs(self._unitList) do
		iter_102_1:TriggerBuff((arg_102_1 or nil) and (var_0_4.BuffEffectType.ON_AUTOBOT or var_0_4.BuffEffectType.ON_MANUAL))
	end

	return
end

function BattleFleetVO:CloakFatalExpose()
	for iter_103_0, iter_103_1 in ipairs(self._cloakList) do
		iter_103_1:GetCloak():ForceToMax()
	end

	return
end

function BattleFleetVO:CloakInVision(arg_104_1)
	for iter_104_0, iter_104_1 in ipairs(self._cloakList) do
		iter_104_1:GetCloak():AppendExposeSpeed(arg_104_1)
	end

	return
end

function BattleFleetVO:CloakOutVision()
	for iter_105_0, iter_105_1 in ipairs(self._cloakList) do
		iter_105_1:GetCloak():AppendExposeSpeed(0)
	end

	return
end

function BattleFleetVO:AttachCloak(arg_106_1)
	if not arg_106_1:GetCloak() then
		arg_106_1:InitCloak()

		self._cloakList[#self._cloakList + 1] = arg_106_1
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

return
