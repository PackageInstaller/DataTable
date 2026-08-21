ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_6 = ys.Battle.BattleDataFunction
local var_0_7 = ys.Battle.BattleAttr
local var_0_8 = class("BattleFleetVO")

ys.Battle.BattleFleetVO = var_0_8
var_0_8.__name = "BattleFleetVO"

function var_0_8.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._IFF = arg_1_1
	arg_1_0._lastDist = 0

	arg_1_0:init()

	return
end

function var_0_8.UpdateMotion(arg_2_0)
	if arg_2_0._motionReferenceUnit then
		arg_2_0._motionVO:UpdatePos(arg_2_0._motionReferenceUnit)
		arg_2_0._motionVO:UpdateVelocityAndDirection(arg_2_0:GetFleetVelocity(), arg_2_0._motionSourceFunc())
	end

	local var_2_0 = math.max(arg_2_0._motionVO:GetPos().x - arg_2_0._rightBound, 0)

	if var_2_0 >= 0 and var_2_0 ~= arg_2_0._lastDist then
		arg_2_0._lastDist = var_2_0

		arg_2_0:DispatchEvent(var_0.Event.New(var_0_1.SHOW_BUFFER, {
			dist = var_2_0
		}))
	end

	return
end

function var_0_8.UpdateAutoComponent(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scoutList) do
		iter_3_1:UpdateWeapon(arg_3_1)
		iter_3_1:UpdateAirAssist()
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0._mainList) do
		iter_3_3:UpdateWeapon(arg_3_1)
		iter_3_3:UpdateAirAssist()
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_0._cloakList) do
		iter_3_5:UpdateCloak(arg_3_1)
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_0._subList) do
		iter_3_7:UpdateWeapon(arg_3_1)
		iter_3_7:UpdateOxygen(arg_3_1)
		iter_3_7:UpdatePhaseSwitcher()
	end

	for iter_3_8, iter_3_9 in ipairs(arg_3_0._manualSubList) do
		iter_3_9:UpdateOxygen(arg_3_1)
	end

	arg_3_0._fleetAntiAir:Update(arg_3_1)
	arg_3_0._fleetRangeAntiAir:Update(arg_3_1)
	arg_3_0._fleetStaticSonar:Update(arg_3_1)

	for iter_3_10, iter_3_11 in pairs(arg_3_0._indieSonarList) do
		iter_3_10:Update(arg_3_1)
	end

	arg_3_0:UpdateBuff(arg_3_1)

	return
end

function var_0_8.UpdateBuff(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._buffList) do
		iter_4_1:Update(arg_4_0, arg_4_1)
	end

	return
end

function var_0_8.UpdateManualWeaponVO(arg_5_0, arg_5_1)
	arg_5_0._chargeWeaponVO:Update(arg_5_1)
	arg_5_0._torpedoWeaponVO:Update(arg_5_1)
	arg_5_0._airAssistVO:Update(arg_5_1)
	arg_5_0._submarineDiveVO:Update(arg_5_1)
	arg_5_0._submarineFloatVO:Update(arg_5_1)
	arg_5_0._submarineBoostVO:Update(arg_5_1)
	arg_5_0._submarineShiftVO:Update(arg_5_1)

	return
end

function var_0_8.UpdateFleetDamage(arg_6_0, arg_6_1)
	arg_6_0._currentDMGRatio = arg_6_0._currentDMGRatio + var_0_2.CalculateFleetDamage(arg_6_1)

	arg_6_0:DispatchFleetDamageChange()

	return
end

function var_0_8.UpdateFleetOverDamage(arg_7_0, arg_7_1)
	arg_7_0._currentDMGRatio = arg_7_0._currentDMGRatio - var_0_2.CalculateFleetOverDamage(arg_7_0, arg_7_1)

	arg_7_0:DispatchFleetDamageChange()

	return
end

function var_0_8.DispatchFleetDamageChange(arg_8_0)
	arg_8_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_DMG_CHANGE, {}))

	return
end

function var_0_8.DispatchSonarScan(arg_9_0, arg_9_1)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_1.SONAR_SCAN, {
		indieSonar = arg_9_1
	}))

	return
end

function var_0_8.FreeMainUnit(arg_10_0, arg_10_1)
	if arg_10_0._mainUnitFree then
		return
	end

	arg_10_0._mainUnitFree = true

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._mainList) do
		iter_10_1:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_10_1)))
		iter_10_1:SetMainUnitStatic(false)
	end

	return
end

function var_0_8.RandomMainVictim(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or {}

	local var_11_0 = {}
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mainList) do
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

	if #var_11_0 > 0 then
		var_11_1 = var_11_0[math.random(#var_11_0)]
	end

	return var_11_1
end

function var_0_8.NearestUnitByType(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._unitList) do
		local var_12_2

		if table.contains(arg_12_2, iter_12_1:GetTemplate().type) then
			local var_12_1 = Vector3.BattleDistance(iter_12_1:GetPosition(), arg_12_1)

			if var_12_1 < 999 then
				var_12_2 = var_12_1
				var_12_0 = iter_12_1
			end
		end
	end

	return var_12_0
end

function var_0_8.SetMotionSource(arg_13_0, arg_13_1)
	arg_13_0._motionSourceFunc = arg_13_1 == nil and function()
		local var_14_0 = pg.UIMgr.GetInstance()

		return var_14_0.hrz, var_14_0.vtc
	end or arg_13_1

	return
end

function var_0_8.SetSubAidData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._submarineVO = var_0.Battle.BattleSubmarineAidVO.New()

	if arg_15_2 == var_0_3.SubAidFlag.AID_EMPTY or arg_15_2 == var_0_3.SubAidFlag.OIL_EMPTY then
		arg_15_0._submarineVO:SetUseable(false)
	else
		arg_15_0._submarineVO:SetCount(arg_15_2)
		arg_15_0._submarineVO:SetTotal(arg_15_1)
		arg_15_0._submarineVO:SetUseable(true)
	end

	return
end

function var_0_8.SetBound(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_0._upperBound = arg_16_1
	arg_16_0._lowerBound = arg_16_2
	arg_16_0._leftBound = arg_16_3
	arg_16_0._rightBound = arg_16_4

	return
end

function var_0_8.SetTotalBound(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0._totalUpperBound = arg_17_1
	arg_17_0._totalLowerBound = arg_17_2
	arg_17_0._totalLeftBound = arg_17_3
	arg_17_0._totalRightBound = arg_17_4

	return
end

function var_0_8.CalcSubmarineBaseLine(arg_18_0, arg_18_1)
	if arg_18_0._IFF == var_0_4.FRIENDLY_CODE then
		if arg_18_1 == SYSTEM_DUEL then
			-- block empty
		else
			arg_18_0._subAttackBaseLine = (arg_18_0._totalRightBound + arg_18_0._totalLeftBound) * 0.5
			arg_18_0._subRetreatBaseLine = arg_18_0._leftBound - 10
		end
	elseif arg_18_0._IFF == var_0_4.FOE_CODE and arg_18_1 == SYSTEM_DUEL then
		-- block empty
	end

	return
end

function var_0_8.SetExposeLine(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._visionLineX = arg_19_1
	arg_19_0._exposeLineX = arg_19_2

	return
end

function var_0_8.AppendPlayerUnit(arg_20_0, arg_20_1)
	arg_20_0._unitList[#arg_20_0._unitList + 1] = arg_20_1
	arg_20_0._maxCount = arg_20_0._maxCount + 1

	if arg_20_1:IsMainFleetUnit() then
		arg_20_0:appendMainUnit(arg_20_1)
	else
		arg_20_0:appendScoutUnit(arg_20_1)
	end

	arg_20_1:SetFleetVO(arg_20_0)
	arg_20_1:SetMotion(arg_20_0._motionVO)
	arg_20_1:RegisterEventListener(arg_20_0, var_0_0.UPDATE_HP, arg_20_0.onUnitUpdateHP)

	return
end

function var_0_8.RemovePlayerUnit(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._unitList) do
		if iter_21_1 ~= arg_21_1 then
			({})[#{} + 1] = iter_21_0
		else
			iter_21_1:UnregisterEventListener(arg_21_0, var_0_0.UPDATE_HP)
			iter_21_1:DeactiveCldBox()

			for iter_21_2, iter_21_3 in ipairs((iter_21_1:GetChargeList())) do
				if iter_21_3:IsAttacking() then
					arg_21_0._chargeWeaponVO:CancelFocus()
					arg_21_0._chargeWeaponVO:ResetFocus()
					arg_21_0:CancelChargeWeapon()
				end

				arg_21_0._chargeWeaponVO:RemoveWeapon(iter_21_3)
				iter_21_3:Clear()
			end

			arg_21_0._fleetAntiAir:RemoveCrewUnit(arg_21_1)
			arg_21_0._fleetRangeAntiAir:RemoveCrewUnit(arg_21_1)
			arg_21_0._fleetStaticSonar:RemoveCrewUnit(arg_21_1)

			for iter_21_4, iter_21_5 in ipairs((iter_21_1:GetTorpedoList())) do
				arg_21_0:RemoveManunalTorpedo(iter_21_5)
			end

			local var_21_0 = iter_21_1:GetAirAssistList()

			if var_21_0 then
				for iter_21_6, iter_21_7 in ipairs(var_21_0) do
					arg_21_0._airAssistVO:RemoveWeapon(iter_21_7)
				end
			end
		end
	end

	for iter_21_8, iter_21_9 in ipairs(arg_21_0._scoutList) do
		if iter_21_9 == arg_21_1 then
			if #arg_21_0._scoutList == 1 then
				arg_21_0:CancelChargeWeapon()
			end

			table.remove(arg_21_0._scoutList, iter_21_8)

			break
		end
	end

	for iter_21_10, iter_21_11 in ipairs(arg_21_0._mainList) do
		if iter_21_11 == arg_21_1 then
			table.remove(arg_21_0._mainList, iter_21_10)

			break
		end
	end

	for iter_21_12, iter_21_13 in ipairs(arg_21_0._cloakList) do
		if iter_21_13 == arg_21_1 then
			table.remove(arg_21_0._cloakList, iter_21_12)

			break
		end
	end

	for iter_21_14, iter_21_15 in ipairs(arg_21_0._subList, i) do
		if iter_21_15 == arg_21_1 then
			table.remove(arg_21_0._subList, iter_21_14)

			break
		end
	end

	for iter_21_16, iter_21_17 in ipairs(arg_21_0._manualSubList) do
		if iter_21_17 == arg_21_1 then
			table.remove(arg_21_0._manualSubList, iter_21_16)

			break
		end
	end

	if not arg_21_0._manualSubUnit then
		arg_21_0:refreshFleetFormation({})
	end

	return
end

function var_0_8.OverrideJoyStickAutoBot(arg_22_0, arg_22_1)
	arg_22_0._autoBotAIID = arg_22_1

	arg_22_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleEvent.OVERRIDE_AUTO_BOT)))

	return
end

function var_0_8.SnapShot(arg_23_0)
	arg_23_0._totalDMGRatio = var_0_2.GetFleetTotalHP(arg_23_0)
	arg_23_0._currentDMGRatio = arg_23_0._totalDMGRatio

	return
end

function var_0_8.GetIFF(arg_24_0)
	return arg_24_0._IFF
end

function var_0_8.GetMaxCount(arg_25_0)
	return arg_25_0._maxCount
end

function var_0_8.GetFlagShip(arg_26_0)
	return arg_26_0._flagShip
end

function var_0_8.GetLeaderShip(arg_27_0)
	return arg_27_0._scoutList[1]
end

function var_0_8.GetUnitList(arg_28_0)
	return arg_28_0._unitList
end

function var_0_8.GetMainList(arg_29_0)
	return arg_29_0._mainList
end

function var_0_8.GetScoutList(arg_30_0)
	return arg_30_0._scoutList
end

function var_0_8.GetCloakList(arg_31_0)
	return arg_31_0._cloakList
end

function var_0_8.GetSubBench(arg_32_0)
	return arg_32_0._manualSubBench
end

function var_0_8.GetMotion(arg_33_0)
	return arg_33_0._motionVO
end

function var_0_8.GetMotionReferenceUnit(arg_34_0)
	return arg_34_0._motionReferenceUnit
end

function var_0_8.GetAutoBotAIID(arg_35_0)
	return arg_35_0._autoBotAIID
end

function var_0_8.GetChargeWeaponVO(arg_36_0)
	return arg_36_0._chargeWeaponVO
end

function var_0_8.GetTorpedoWeaponVO(arg_37_0)
	return arg_37_0._torpedoWeaponVO
end

function var_0_8.GetAirAssistVO(arg_38_0)
	return arg_38_0._airAssistVO
end

function var_0_8.GetSubAidVO(arg_39_0)
	return arg_39_0._submarineVO
end

function var_0_8.GetSubFreeDiveVO(arg_40_0)
	return arg_40_0._submarineDiveVO
end

function var_0_8.GetSubFreeFloatVO(arg_41_0)
	return arg_41_0._submarineFloatVO
end

function var_0_8.GetSubBoostVO(arg_42_0)
	return arg_42_0._submarineBoostVO
end

function var_0_8.GetSubSpecialVO(arg_43_0)
	return arg_43_0._submarineSpecialVO
end

function var_0_8.GetSubShiftVO(arg_44_0)
	return arg_44_0._submarineShiftVO
end

function var_0_8.GetFleetAntiAirWeapon(arg_45_0)
	return arg_45_0._fleetAntiAir
end

function var_0_8.GetFleetRangeAntiAirWeapon(arg_46_0)
	return arg_46_0._fleetRangeAntiAir
end

function var_0_8.GetFleetVelocity(arg_47_0)
	return var_0_2.GetFleetVelocity(arg_47_0._scoutList)
end

function var_0_8.GetFleetBound(arg_48_0)
	return arg_48_0._upperBound, arg_48_0._lowerBound, arg_48_0._leftBound, arg_48_0._rightBound
end

function var_0_8.GetFleetExposeLine(arg_49_0)
	return arg_49_0._exposeLineX
end

function var_0_8.GetFleetVisionLine(arg_50_0)
	return arg_50_0._visionLineX
end

function var_0_8.GetLeaderPersonality(arg_51_0)
	return arg_51_0._motionReferenceUnit:GetAutoPilotPreference()
end

function var_0_8.GetDamageRatioResult(arg_52_0)
	return string.format("%0.2f", arg_52_0._currentDMGRatio / arg_52_0._totalDMGRatio * 100), arg_52_0._totalDMGRatio
end

function var_0_8.GetDamageRatio(arg_53_0)
	return arg_53_0._currentDMGRatio / arg_53_0._totalDMGRatio
end

function var_0_8.GetSubmarineBaseLine(arg_54_0)
	return arg_54_0._subAttackBaseLine, arg_54_0._subRetreatBaseLine
end

function var_0_8.GetFleetSonar(arg_55_0)
	return arg_55_0._fleetStaticSonar
end

function var_0_8.Dispose(arg_56_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_56_0)
	var_0.EventListener.DetachEventListener(arg_56_0)

	arg_56_0._leaderUnit = nil

	arg_56_0._fleetAntiAir:Dispose()
	arg_56_0._fleetRangeAntiAir:Dispose()
	arg_56_0._fleetStaticSonar:Dispose()

	arg_56_0._fleetStaticSonar = nil
	arg_56_0._buffList = nil
	arg_56_0._indieSonarList = nil
	arg_56_0._scoutAimBias = nil

	return
end

function var_0_8.refreshFleetFormation(arg_57_0, arg_57_1)
	local var_57_0 = var_0_6.GetFormationTmpDataFromID(var_0_4.FORMATION_ID).pos_offset

	arg_57_0._unitList = var_0_6.SortFleetList(arg_57_1, arg_57_0._unitList)

	if not arg_57_0._mainUnitFree then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0._unitList) do
			if not table.contains(arg_57_0._subList, iter_57_1) then
				iter_57_1:UpdateFormationOffset(Vector3(var_57_0[iter_57_0].x, var_57_0[iter_57_0].y, var_57_0[iter_57_0].z) + var_0_4.BornOffset * (iter_57_0 - 1))
			end
		end
	end

	if #arg_57_0._scoutList > 0 then
		arg_57_0._motionReferenceUnit = arg_57_0._scoutList[1]
		arg_57_0._leaderUnit = arg_57_0._scoutList[1]

		arg_57_0._leaderUnit:LeaderSetting()
		arg_57_0._fleetAntiAir:SwitchHost(arg_57_0._motionReferenceUnit)
		arg_57_0._fleetStaticSonar:SwitchHost(arg_57_0._motionReferenceUnit)

		for iter_57_2, iter_57_3 in pairs(arg_57_0._indieSonarList) do
			iter_57_2:SwitchHost(arg_57_0._motionReferenceUnit)
		end

		arg_57_0._motionVO:UpdatePos(arg_57_0._motionReferenceUnit)
	elseif arg_57_0._fleetAntiAir:GetCurrentState() ~= arg_57_0._fleetAntiAir.STATE_DISABLE then
		for iter_57_4, iter_57_5 in pairs((arg_57_0._fleetAntiAir:GetCrewUnitList())) do
			arg_57_0._motionReferenceUnit = iter_57_4

			arg_57_0._fleetAntiAir:SwitchHost(iter_57_4)

			break
		end
	else
		arg_57_0._motionReferenceUnit = arg_57_0._mainList[1]
		arg_57_0._leaderUnit = nil
	end

	if #arg_57_0:GetUnitList() == 0 then
		return
	end

	arg_57_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleEvent.REFRESH_FLEET_FORMATION)))

	return
end

function var_0_8.init(arg_58_0)
	arg_58_0._chargeWeaponVO = var_0.Battle.BattleChargeWeaponVO.New()
	arg_58_0._torpedoWeaponVO = var_0.Battle.BattleTorpedoWeaponVO.New()
	arg_58_0._airAssistVO = var_0.Battle.BattleAllInStrikeVO.New()
	arg_58_0._submarineDiveVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.DIVE_CD)
	arg_58_0._submarineFloatVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.FLOAT_CD)
	arg_58_0._submarineVOList = {
		arg_58_0._submarineDiveVO,
		arg_58_0._submarineFloatVO
	}
	arg_58_0._submarineBoostVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.BOOST_CD)
	arg_58_0._submarineShiftVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.SHIFT_CD)
	arg_58_0._submarineSpecialVO = var_0.Battle.BattleSubmarineAidVO.New()

	arg_58_0._submarineSpecialVO:SetCount(1)
	arg_58_0._submarineSpecialVO:SetTotal(1)

	arg_58_0._fleetAntiAir = var_0.Battle.BattleFleetAntiAirUnit.New()
	arg_58_0._fleetRangeAntiAir = var_0.Battle.BattleFleetRangeAntiAirUnit.New()
	arg_58_0._motionVO = var_0.Battle.BattleFleetMotionVO.New()
	arg_58_0._fleetStaticSonar = var_0.Battle.BattleFleetStaticSonar.New(arg_58_0)
	arg_58_0._indieSonarList = {}
	arg_58_0._scoutList = {}
	arg_58_0._mainList = {}
	arg_58_0._subList = {}
	arg_58_0._cloakList = {}
	arg_58_0._manualSubList = {}
	arg_58_0._manualSubBench = {}
	arg_58_0._unitList = {}
	arg_58_0._maxCount = 0
	arg_58_0._blockCast = 0
	arg_58_0._buffList = {}

	arg_58_0:SetMotionSource()

	return
end

function var_0_8.appendScoutUnit(arg_59_0, arg_59_1)
	arg_59_0._scoutList[#arg_59_0._scoutList + 1] = arg_59_1

	for iter_59_0, iter_59_1 in ipairs((arg_59_1:GetTorpedoList())) do
		arg_59_0._torpedoWeaponVO:AppendWeapon(iter_59_1)
	end

	if #arg_59_1:GetHiveList() > 0 then
		local var_59_0 = var_0_6.CreateAllInStrike(arg_59_1)

		for iter_59_2, iter_59_3 in ipairs(var_59_0) do
			arg_59_0._airAssistVO:AppendWeapon(iter_59_3)
		end

		arg_59_1:SetAirAssistList(var_59_0)
	end

	arg_59_0._fleetAntiAir:AppendCrewUnit(arg_59_1)
	arg_59_0._fleetStaticSonar:AppendCrewUnit(arg_59_1)

	local var_59_1 = 1

	while var_59_1 < #arg_59_0._unitList do
		table.insert({}, var_59_1)

		var_59_1 = var_59_1 + 1
	end

	table.insert({}, #arg_59_0._scoutList, var_59_1)
	arg_59_0:refreshFleetFormation({})

	return
end

function var_0_8.appendMainUnit(arg_60_0, arg_60_1)
	if #arg_60_0._mainList == 0 then
		arg_60_0._flagShip = arg_60_1
	end

	arg_60_0._mainList[#arg_60_0._mainList + 1] = arg_60_1

	arg_60_1:SetMainUnitIndex(#arg_60_0._mainList)

	if ShipType.CloakShipType(arg_60_1:GetTemplate().type) then
		arg_60_0:AttachCloak(arg_60_1)
	end

	for iter_60_0, iter_60_1 in ipairs((arg_60_1:GetChargeList())) do
		arg_60_0._chargeWeaponVO:AppendWeapon(iter_60_1)
	end

	for iter_60_2, iter_60_3 in ipairs((arg_60_1:GetTorpedoList())) do
		arg_60_0._torpedoWeaponVO:AppendWeapon(iter_60_3)
	end

	if #arg_60_1:GetHiveList() > 0 then
		local var_60_0 = var_0_6.CreateAllInStrike(arg_60_1)

		for iter_60_4, iter_60_5 in ipairs(var_60_0) do
			arg_60_0._airAssistVO:AppendWeapon(iter_60_5)
		end

		arg_60_1:SetAirAssistList(var_60_0)
	end

	arg_60_0._fleetAntiAir:AppendCrewUnit(arg_60_1)
	arg_60_0._fleetRangeAntiAir:AppendCrewUnit(arg_60_1)
	arg_60_0._fleetStaticSonar:AppendCrewUnit(arg_60_1)

	for iter_60_6, iter_60_7 in ipairs(arg_60_0._unitList) do
		table.insert({}, iter_60_6)
	end

	arg_60_0:refreshFleetFormation({})

	return
end

function var_0_8.appendSubUnit(arg_61_0, arg_61_1)
	arg_61_0._subList[#arg_61_0._subList + 1] = arg_61_1

	arg_61_1:SetMainUnitIndex(#arg_61_0._subList)

	return
end

function var_0_8.FleetWarcry(arg_62_0)
	local var_62_0
	local var_62_1 = math.random(0, 1)
	local var_62_2 = arg_62_0:GetMainList()[1]

	if var_62_2 == nil or var_62_1 == 0 then
		var_62_0 = arg_62_0:GetScoutList()[1]
	elseif var_62_1 == 1 then
		var_62_0 = var_62_2
	end

	local var_62_3 = "battle"

	var_62_0:DispatchVoice("battle")
	var_62_0:DispatchChat(var_0.Battle.BattleDataFunction.GetWords(var_62_0:GetSkinID(), "battle", (var_62_0:GetIntimacy())), 2.5, var_62_3)

	return
end

function var_0_8.FleetUnitSpwanFinish(arg_63_0)
	local var_63_0 = 0

	for iter_63_0, iter_63_1 in ipairs(arg_63_0._unitList) do
		var_63_0 = var_63_0 + iter_63_1:GetGearScore()
	end

	for iter_63_2, iter_63_3 in ipairs(arg_63_0._unitList) do
		var_0_7.SetCurrent(iter_63_3, "fleetGS", var_63_0)
	end

	return
end

function var_0_8.SubWarcry(arg_64_0)
	local var_64_0 = arg_64_0:GetSubList()[1]

	var_64_0:DispatchVoice("battle")
	var_64_0:DispatchChat(var_0.Battle.BattleDataFunction.GetWords(var_64_0:GetSkinID(), "battle", (var_64_0:GetIntimacy())), 2.5, "battle")

	return
end

function var_0_8.SetWeaponBlock(arg_65_0, arg_65_1)
	arg_65_0._blockCast = arg_65_0._blockCast + arg_65_1

	return
end

function var_0_8.GetWeaponBlock(arg_66_0)
	return arg_66_0._blockCast > 0
end

function var_0_8.CastChargeWeapon(arg_67_0)
	if arg_67_0:GetWeaponBlock() then
		return
	end

	local var_67_0 = arg_67_0._chargeWeaponVO:GetCurrentWeapon()

	if var_67_0 ~= nil and var_67_0:GetCurrentState() == var_67_0.STATE_READY then
		var_67_0:Charge()
		arg_67_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CHARGE, {})))
	end

	return
end

function var_0_8.CancelChargeWeapon(arg_68_0)
	local var_68_0 = arg_68_0._chargeWeaponVO:GetCurrentWeapon()

	if var_68_0 ~= nil and var_68_0:GetCurrentState() == var_68_0.STATE_PRECAST then
		arg_68_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
		var_68_0:CancelCharge()
	end

	return
end

function var_0_8.UnleashChrageWeapon(arg_69_0)
	if arg_69_0:GetWeaponBlock() then
		arg_69_0:CancelChargeWeapon()

		return
	end

	local var_69_0 = arg_69_0._chargeWeaponVO:GetCurrentWeapon()

	if var_69_0 ~= nil and var_69_0:GetCurrentState() == var_69_0.STATE_PRECAST then
		if var_69_0:IsStrikeMode() then
			arg_69_0:fireChargeWeapon(var_69_0, true, Vector3.New(math.min(arg_69_0._motionVO:GetPos().x + var_0_4.ChargeWeaponConfig.SIGHT_C, arg_69_0._totalRightBound), 0, arg_69_0._motionVO:GetPos().z))
		else
			var_69_0:CancelCharge()
		end

		arg_69_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
	end

	return
end

function var_0_8.QuickTagChrageWeapon(arg_70_0, arg_70_1)
	if arg_70_0:GetWeaponBlock() then
		return
	end

	local var_70_0 = arg_70_0._chargeWeaponVO:GetCurrentWeapon()

	if var_70_0 ~= nil and var_70_0:GetCurrentState() == var_70_0.STATE_READY then
		var_70_0:QuickTag()

		if #var_70_0:GetLockList() <= 0 then
			var_70_0:CancelQuickTag()
		else
			arg_70_0:fireChargeWeapon(var_70_0, arg_70_1)
		end
	end

	return
end

function var_0_8.fireChargeWeapon(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	local var_71_0 = arg_71_1:GetHost()

	if arg_71_2 then
		if arg_71_0._IFF == var_0_4.FRIENDLY_CODE then
			arg_71_0._chargeWeaponVO:PlayCutIn(var_71_0, 1 / var_0_4.FOCUS_MAP_RATE)
		end

		arg_71_0._chargeWeaponVO:PlayFocus(var_71_0, function()
			arg_71_1:DispatchBlink(function()
				arg_71_1:Fire(arg_71_3)

				return
			end)

			return
		end)
	else
		if arg_71_0._IFF == var_0_4.FRIENDLY_CODE then
			arg_71_0._chargeWeaponVO:PlayCutIn(var_71_0, 1)
		end

		;(function()
			arg_71_1:DispatchBlink(function()
				arg_71_1:Fire(arg_71_3)

				return
			end)

			return
		end)()
	end

	return
end

function var_0_8.UnleashAllInStrike(arg_74_0)
	if arg_74_0:GetWeaponBlock() then
		return
	end

	local var_74_0 = arg_74_0._airAssistVO:GetCurrentWeapon()

	if var_74_0 and var_74_0:GetCurrentState() == var_74_0.STATE_READY then
		local var_74_1 = var_74_0:GetHost()

		if arg_74_0._IFF == var_0_4.FRIENDLY_CODE and var_74_1:IsMainFleetUnit() then
			arg_74_0._airAssistVO:PlayCutIn(var_74_1, 1)
		end

		var_74_0:CLSBullet()
		var_74_0:DispatchBlink()
		var_74_0:Fire()
	end

	return
end

function var_0_8.CastTorpedo(arg_75_0)
	if arg_75_0:GetWeaponBlock() then
		return
	end

	local var_75_0 = arg_75_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_75_0 ~= nil and var_75_0:GetCurrentState() == var_75_0.STATE_READY then
		var_75_0:Prepar()
	end

	return
end

function var_0_8.CancelTorpedo(arg_76_0)
	local var_76_0 = arg_76_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_76_0 ~= nil and var_76_0:GetCurrentState() == var_76_0.STATE_PRECAST then
		var_76_0:Cancel()
	end

	return
end

function var_0_8.UnleashTorpedo(arg_77_0)
	if arg_77_0:GetWeaponBlock() then
		arg_77_0:CancelTorpedo()

		return
	end

	local var_77_0 = arg_77_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_77_0 ~= nil and var_77_0:GetCurrentState() == var_77_0.STATE_PRECAST then
		var_77_0:Fire()
	end

	return
end

function var_0_8.QuickCastTorpedo(arg_78_0)
	if arg_78_0:GetWeaponBlock() then
		return
	end

	local var_78_0 = arg_78_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_78_0 ~= nil and var_78_0:GetCurrentState() == var_78_0.STATE_READY then
		var_78_0:Fire(true)
	end

	return
end

function var_0_8.RemoveManunalTorpedo(arg_79_0, arg_79_1)
	if arg_79_1:IsAttacking() then
		arg_79_0:CancelTorpedo()
	end

	arg_79_0._torpedoWeaponVO:RemoveWeapon(arg_79_1)
	arg_79_1:Clear()

	return
end

function var_0_8.CoupleEncourage(arg_80_0)
	local var_80_0 = {}

	for iter_80_0, iter_80_1 in ipairs(arg_80_0._unitList) do
		local var_80_1 = var_0_6.GetWords(iter_80_1:GetSkinID(), "couple_encourage", (iter_80_1:GetIntimacy()))

		if #var_80_1 > 0 then
			({})[iter_80_1] = var_80_1
		end
	end

	local var_80_2 = var_0_3.CPChatType

	for iter_80_2, iter_80_3 in pairs({}) do
		for iter_80_4, iter_80_5 in ipairs(iter_80_3) do
			local var_80_3 = iter_80_5[2]
			local var_80_4 = iter_80_5[4] or var_0_3.CPChatType.GROUP_ID
			local var_80_5 = var_0.Battle.BattleTargetChoise.TargetAllHelp(iter_80_2)

			if type(var_80_4) == "table" then
				for iter_80_6, iter_80_7 in ipairs(var_80_4) do
					var_80_5 = var_0.Battle.BattleTargetChoise[var_0_3.CPChatTargetFunc[iter_80_7]](iter_80_2, (function(arg_81_0, arg_81_1)
						if arg_81_0 == var_80_2.GROUP_ID then
							({}).groupIDList = arg_81_1
						elseif arg_81_0 == var_80_2.SHIP_TYPE then
							({}).ship_type_list = arg_81_1
						elseif arg_81_0 == var_80_2.RARE then
							({}).rarity = arg_81_1[1]
						elseif arg_81_0 == var_80_2.NATIONALITY then
							({}).nationality = arg_81_1[1]
						elseif arg_81_0 == var_80_2.ILLUSTRATOR then
							({}).illustrator = arg_81_1[1]
						elseif arg_81_0 == var_80_2.TEAM then
							({}).teamIndex = arg_81_1[1]
						end

						return {}
					end)(iter_80_7, iter_80_5[1][iter_80_6]), var_80_5)
				end
			elseif type(var_80_4) == "number" then
				var_80_5 = var_0.Battle.BattleTargetChoise[var_0_3.CPChatTargetFunc[var_80_4]](iter_80_2, (function(arg_81_0, arg_81_1)
					if arg_81_0 == var_80_2.GROUP_ID then
						({}).groupIDList = arg_81_1
					elseif arg_81_0 == var_80_2.SHIP_TYPE then
						({}).ship_type_list = arg_81_1
					elseif arg_81_0 == var_80_2.RARE then
						({}).rarity = arg_81_1[1]
					elseif arg_81_0 == var_80_2.NATIONALITY then
						({}).nationality = arg_81_1[1]
					elseif arg_81_0 == var_80_2.ILLUSTRATOR then
						({}).illustrator = arg_81_1[1]
					elseif arg_81_0 == var_80_2.TEAM then
						({}).teamIndex = arg_81_1[1]
					end

					return {}
				end)(var_80_4, iter_80_5[1]), var_80_5)
			end

			if var_80_3 <= #var_80_5 then
				var_80_0[#var_80_0 + 1] = {
					cp = iter_80_2,
					content = iter_80_5[3],
					linkIndex = iter_80_4
				}
			end
		end
	end

	if #var_80_0 > 0 then
		local var_80_6 = var_80_0[math.random(#var_80_0)]

		var_80_6.cp:DispatchVoice("link" .. var_80_6.linkIndex)
		var_80_6.cp:DispatchChat(var_80_6.content, 3, "link" .. var_80_6.linkIndex)
	end

	return
end

function var_0_8.onUnitUpdateHP(arg_82_0, arg_82_1)
	for iter_82_0, iter_82_1 in ipairs(arg_82_0._unitList) do
		iter_82_1:TriggerBuff(var_0_3.BuffEffectType.ON_FRIENDLY_HP_RATIO_UPDATE, {
			unit = arg_82_1.Dispatcher,
			dHP = arg_82_1.Data.dHP
		})

		if iter_82_1 ~= arg_82_1.Dispatcher then
			iter_82_1:TriggerBuff(var_0_3.BuffEffectType.ON_TEAMMATE_HP_RATIO_UPDATE, {
				unit = arg_82_1.Dispatcher,
				dHP = arg_82_1.Data.dHP
			})
		end
	end

	return
end

function var_0_8.SetSubUnitData(arg_83_0, arg_83_1)
	arg_83_0._subUntiDataList = arg_83_1

	return
end

function var_0_8.GetSubUnitData(arg_84_0)
	return arg_84_0._subUntiDataList
end

function var_0_8.AddSubMarine(arg_85_0, arg_85_1)
	arg_85_1:InitOxygen()

	local var_85_0 = arg_85_1:GetTemplate()

	var_0.Battle.BattleUnitPhaseSwitcher.New(arg_85_1):SetTemplateData(var_0_6.GeneratePlayerSubmarinPhase(arg_85_0._subAttackBaseLine, arg_85_0._subRetreatBaseLine, arg_85_1:GetAttrByName("raidDist"), function()
		return arg_85_1:GetRaidDuration()
	end, arg_85_1:GetAttrByName("oxyAtkDuration")))

	arg_85_0._unitList[#arg_85_0._unitList + 1] = arg_85_1
	arg_85_0._subList[#arg_85_0._subList + 1] = arg_85_1

	arg_85_1:SetFleetVO(arg_85_0)
	arg_85_1:RegisterEventListener(arg_85_0, var_0_0.UPDATE_HP, arg_85_0.onUnitUpdateHP)

	return
end

function var_0_8.AddManualSubmarine(arg_87_0, arg_87_1)
	arg_87_0._unitList[#arg_87_0._unitList + 1] = arg_87_1
	arg_87_0._manualSubList[#arg_87_0._manualSubList + 1] = arg_87_1
	arg_87_0._manualSubBench[#arg_87_0._manualSubBench + 1] = arg_87_1
	arg_87_0._maxCount = arg_87_0._maxCount + 1

	arg_87_1:InitOxygen()
	arg_87_1:SetFleetVO(arg_87_0)
	arg_87_1:SetMotion(arg_87_0._motionVO)
	arg_87_1:RegisterEventListener(arg_87_0, var_0_0.UPDATE_HP, arg_87_0.onUnitUpdateHP)

	return
end

function var_0_8.GetSubList(arg_88_0)
	return arg_88_0._subList
end

function var_0_8.ShiftManualSub(arg_89_0)
	local var_89_0

	if arg_89_0._manualSubUnit then
		for iter_89_0, iter_89_1 in ipairs((arg_89_0._manualSubUnit:GetTorpedoList())) do
			if iter_89_1:IsAttacking() then
				arg_89_0:CancelTorpedo()
			end

			arg_89_0._torpedoWeaponVO:RemoveWeapon(iter_89_1)
		end

		if arg_89_0._manualSubUnit:IsAlive() then
			table.insert(arg_89_0._manualSubBench, arg_89_0._manualSubUnit)
		end

		var_89_0 = arg_89_0._motionVO:GetPos():Clone()
	else
		var_89_0 = arg_89_0._manualSubList[1]:GetPosition():Clone()
	end

	arg_89_0._manualSubUnit = table.remove(arg_89_0._manualSubBench, 1)
	arg_89_0._scoutList[1] = arg_89_0._manualSubUnit

	for iter_89_2, iter_89_3 in ipairs(arg_89_0._manualSubBench) do
		for iter_89_4, iter_89_5 in ipairs(arg_89_0._unitList) do
			if iter_89_5 == iter_89_3 then
				table.insert({}, iter_89_4)

				break
			end
		end
	end

	for iter_89_6, iter_89_7 in ipairs(arg_89_0._unitList) do
		if iter_89_7 == arg_89_0._manualSubUnit then
			table.insert({}, 1, iter_89_6)

			break
		end
	end

	arg_89_0:refreshFleetFormation({})
	arg_89_0._manualSubUnit:SetMainUnitStatic(false)
	arg_89_0._manualSubUnit:SetPosition(var_89_0)
	arg_89_0:UpdateMotion()
	arg_89_0._submarineSpecialVO:SetUseable(false)

	for iter_89_8, iter_89_9 in pairs((arg_89_0._manualSubUnit:GetBuffList())) do
		if iter_89_9:IsSubmarineSpecial() then
			arg_89_0._submarineSpecialVO:SetCount(1)
			arg_89_0._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	arg_89_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)
	arg_89_0._torpedoWeaponVO:Reset()

	local var_89_1 = arg_89_0._manualSubUnit:GetTorpedoList()

	for iter_89_10, iter_89_11 in ipairs(var_89_1) do
		if iter_89_11:GetCurrentState() ~= iter_89_11.STATE_OVER_HEAT then
			arg_89_0._torpedoWeaponVO:AppendWeapon(iter_89_11)
		end
	end

	for iter_89_12, iter_89_13 in ipairs(var_89_1) do
		if iter_89_13:GetCurrentState() == iter_89_13.STATE_OVER_HEAT then
			arg_89_0._torpedoWeaponVO:AppendWeapon(iter_89_13)
		end
	end

	for iter_89_14, iter_89_15 in ipairs(arg_89_0._manualSubBench) do
		iter_89_15:SetPosition(var_0_4.SUB_BENCH_POS[iter_89_14])
		iter_89_15:SetMainUnitStatic(true)
		iter_89_15:ChangeOxygenState(var_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	arg_89_0._submarineShiftVO:ResetCurrent()

	if #arg_89_0._manualSubBench == 0 then
		arg_89_0._submarineShiftVO:SetActive(false)
	end

	return
end

function var_0_8.ChangeSubmarineState(arg_90_0, arg_90_1, arg_90_2)
	if not arg_90_0._manualSubUnit then
		return
	end

	arg_90_0._manualSubUnit:ChangeOxygenState(arg_90_1)

	if arg_90_2 then
		for iter_90_0, iter_90_1 in ipairs(arg_90_0._submarineVOList) do
			iter_90_1:ResetCurrent()
		end

		if arg_90_0._submarineShiftVO:IsOverLoad() and arg_90_0._submarineShiftVO:GetMax() - arg_90_0._submarineShiftVO:GetCurrent() > var_0_4.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			arg_90_0._submarineShiftVO:SetMax(var_0_4.SR_CONFIG.DIVE_CD)
			arg_90_0._submarineShiftVO:ResetCurrent()
		end
	end

	arg_90_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_SUBMARINE_SHIFT, {
		state = arg_90_1
	}))

	return
end

function var_0_8.SubmarinBoost(arg_91_0)
	arg_91_0._manualSubUnit:Boost(Vector3.right, var_0_4.SR_CONFIG.BOOST_SPEED, var_0_4.SR_CONFIG.BOOST_DECAY, var_0_4.SR_CONFIG.BOOST_DURATION, var_0_4.SR_CONFIG.BOOST_DECAY_STAMP)
	arg_91_0._submarineBoostVO:ResetCurrent()

	return
end

function var_0_8.UnleashSubmarineSpecial(arg_92_0)
	if arg_92_0:GetWeaponBlock() then
		return
	end

	arg_92_0._submarineSpecialVO:Cast()
	arg_92_0._manualSubUnit:TriggerBuff(var_0_3.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

function var_0_8.AppendIndieSonar(arg_93_0, arg_93_1, arg_93_2)
	local var_93_0 = var_0.Battle.BattleIndieSonar.New(arg_93_0, arg_93_1, arg_93_2)

	var_93_0:SwitchHost(arg_93_0._motionReferenceUnit)

	arg_93_0._indieSonarList[var_93_0] = true

	var_93_0:Detect()

	return
end

function var_0_8.RemoveIndieSonar(arg_94_0, arg_94_1)
	for iter_94_0, iter_94_1 in pairs(arg_94_0._indieSonarList) do
		if arg_94_1 == iter_94_0 then
			arg_94_0._indieSonarList[iter_94_0] = nil

			break
		end
	end

	return
end

function var_0_8.AttachFleetBuff(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1:GetID()
	local var_95_1 = arg_95_0:GetFleetBuff(var_95_0)

	if var_95_1 then
		var_95_1:Stack(arg_95_0)
	else
		arg_95_0._buffList[var_95_0] = arg_95_1

		arg_95_1:Attach(arg_95_0)
	end

	return
end

function var_0_8.RemoveFleetBuff(arg_96_0, arg_96_1)
	local var_96_0 = arg_96_0:GetFleetBuff(arg_96_1)

	if var_96_0 then
		var_96_0:Remove()
	end

	return
end

function var_0_8.GetFleetBuff(arg_97_0, arg_97_1)
	return arg_97_0._buffList[arg_97_1]
end

function var_0_8.GetFleetBuffList(arg_98_0)
	return arg_98_0._buffList
end

function var_0_8.Jamming(arg_99_0, arg_99_1)
	if arg_99_1 then
		arg_99_0._chargeWeaponVO:StartJamming()
		arg_99_0._torpedoWeaponVO:StartJamming()
		arg_99_0._airAssistVO:StartJamming()
	else
		arg_99_0._chargeWeaponVO:JammingEliminate()
		arg_99_0._torpedoWeaponVO:JammingEliminate()
		arg_99_0._airAssistVO:JammingEliminate()
	end

	return
end

function var_0_8.Blinding(arg_100_0, arg_100_1)
	arg_100_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_BLIND, {
		isBlind = arg_100_1
	}))

	return
end

function var_0_8.UpdateHorizon(arg_101_0)
	arg_101_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_HORIZON_UPDATE, {}))

	return
end

function var_0_8.AutoBotUpdated(arg_102_0, arg_102_1)
	if arg_102_1 then
		local var_102_0 = var_0_3.BuffEffectType.ON_AUTOBOT or var_0_3.BuffEffectType.ON_MANUAL

		for iter_102_0, iter_102_1 in ipairs(arg_102_0._unitList) do
			iter_102_1:TriggerBuff(var_102_0)
		end

		return
	end
end

function var_0_8.CloakFatalExpose(arg_103_0)
	for iter_103_0, iter_103_1 in ipairs(arg_103_0._cloakList) do
		iter_103_1:GetCloak():ForceToMax()
	end

	return
end

function var_0_8.CloakInVision(arg_104_0, arg_104_1)
	for iter_104_0, iter_104_1 in ipairs(arg_104_0._cloakList) do
		iter_104_1:GetCloak():AppendExposeSpeed(arg_104_1)
	end

	return
end

function var_0_8.CloakOutVision(arg_105_0)
	for iter_105_0, iter_105_1 in ipairs(arg_105_0._cloakList) do
		iter_105_1:GetCloak():AppendExposeSpeed(0)
	end

	return
end

function var_0_8.AttachCloak(arg_106_0, arg_106_1)
	if not arg_106_1:GetCloak() then
		arg_106_1:InitCloak()

		arg_106_0._cloakList[#arg_106_0._cloakList + 1] = arg_106_1
	end

	return
end

function var_0_8.AttachNightCloak(arg_107_0)
	arg_107_0._scoutAimBias = var_0.Battle.BattleUnitAimBiasComponent.New()

	arg_107_0._scoutAimBias:ConfigRangeFormula(var_0_2.CalculateMaxAimBiasRange, var_0_2.CalculateBiasDecay)
	arg_107_0._scoutAimBias:Active(arg_107_0._scoutAimBias.STATE_ACTIVITING)
	arg_107_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AIM_BIAS, {
		aimBias = arg_107_0._scoutAimBias
	}))

	return
end

function var_0_8.GetFleetBias(arg_108_0)
	return arg_108_0._scoutAimBias
end

return
