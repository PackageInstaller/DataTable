ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleAttr
local var_0_6 = ys.Battle.BattleDataFunction
local var_0_7 = class("BattleFleetVO")

ys.Battle.BattleFleetVO = var_0_7
var_0_7.__name = "BattleFleetVO"

function var_0_7.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._IFF = arg_1_1
	arg_1_0._lastDist = 0

	arg_1_0:init()

	return
end

function var_0_7.UpdateMotion(arg_2_0)
	local var_2_0 = 0

	if arg_2_0._motionReferenceUnit then
		arg_2_0._motionVO:UpdatePos(arg_2_0._motionReferenceUnit)
		arg_2_0._motionVO:UpdateVelocityAndDirection(arg_2_0:GetFleetVelocity(), arg_2_0._motionSourceFunc())

		var_2_0 = math.max(arg_2_0._motionVO:GetPos().x - arg_2_0._rightBound, 0)
	end

	if var_2_0 >= 0 and var_2_0 ~= arg_2_0._lastDist then
		arg_2_0._lastDist = var_2_0

		arg_2_0:DispatchEvent(var_0.Event.New(var_0_1.SHOW_BUFFER, {
			dist = var_2_0
		}))
	end

	return
end

function var_0_7.UpdateAutoComponent(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scoutList) do
		iter_3_1:UpdateWeapon(arg_3_1)
		iter_3_1:UpdateAirAssist()
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0._mainList) do
		iter_3_3:UpdateWeapon(arg_3_1)
		iter_3_3:UpdateAirAssist()
	end

	for iter_3_4, iter_3_5 in ipairs(arg_3_0._supportList) do
		iter_3_5:UpdateWeapon(arg_3_1)
	end

	for iter_3_6, iter_3_7 in ipairs(arg_3_0._cloakList) do
		iter_3_7:UpdateCloak(arg_3_1)
	end

	for iter_3_8, iter_3_9 in ipairs(arg_3_0._subList) do
		iter_3_9:UpdateWeapon(arg_3_1)
		iter_3_9:UpdateOxygen(arg_3_1)
		iter_3_9:UpdatePhaseSwitcher()
	end

	for iter_3_10, iter_3_11 in ipairs(arg_3_0._manualSubList) do
		iter_3_11:UpdateOxygen(arg_3_1)
	end

	arg_3_0._fleetAntiAir:Update(arg_3_1)
	arg_3_0._fleetRangeAntiAir:Update(arg_3_1)
	arg_3_0._fleetStaticSonar:Update(arg_3_1)

	for iter_3_12, iter_3_13 in pairs(arg_3_0._indieSonarList) do
		iter_3_12:Update(arg_3_1)
	end

	arg_3_0:UpdateBuff(arg_3_1)

	if arg_3_0._cardPuzzleComponent then
		arg_3_0._cardPuzzleComponent:Update(arg_3_1)
	end

	return
end

function var_0_7.UpdateBuff(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._buffList) do
		iter_4_1:Update(arg_4_0, arg_4_1)
	end

	return
end

function var_0_7.UpdateManualWeaponVO(arg_5_0, arg_5_1)
	arg_5_0._chargeWeaponVO:Update(arg_5_1)
	arg_5_0._torpedoWeaponVO:Update(arg_5_1)
	arg_5_0._airAssistVO:Update(arg_5_1)
	arg_5_0._submarineDiveVO:Update(arg_5_1)
	arg_5_0._submarineFloatVO:Update(arg_5_1)
	arg_5_0._submarineBoostVO:Update(arg_5_1)
	arg_5_0._submarineShiftVO:Update(arg_5_1)

	return
end

function var_0_7.UpdateFleetDamage(arg_6_0, arg_6_1)
	arg_6_0._currentDMGRatio = arg_6_0._currentDMGRatio + var_0_2.CalculateFleetDamage(arg_6_1)

	arg_6_0:DispatchFleetDamageChange()

	return
end

function var_0_7.UpdateFleetOverDamage(arg_7_0, arg_7_1)
	arg_7_0._currentDMGRatio = arg_7_0._currentDMGRatio - var_0_2.CalculateFleetOverDamage(arg_7_0, arg_7_1)

	arg_7_0:DispatchFleetDamageChange()

	return
end

function var_0_7.DispatchFleetDamageChange(arg_8_0)
	arg_8_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_DMG_CHANGE, {}))

	return
end

function var_0_7.DispatchSonarScan(arg_9_0, arg_9_1)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_1.SONAR_SCAN, {
		indieSonar = arg_9_1
	}))

	return
end

function var_0_7.FleetBuffTrigger(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._unitList) do
		iter_10_1:TriggerBuff(arg_10_1, arg_10_2)
	end

	return
end

function var_0_7.FreeMainUnit(arg_11_0, arg_11_1)
	if arg_11_0._mainUnitFree then
		return
	end

	arg_11_0._mainUnitFree = true

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mainList) do
		iter_11_1:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_11_1)))
		iter_11_1:SetMainUnitStatic(false)
	end

	return
end

function var_0_7.RandomMainVictim(arg_12_0, arg_12_1)
	arg_12_1 = arg_12_1 or {}

	local var_12_0 = {}
	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._mainList) do
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

	if #var_12_0 > 0 then
		var_12_1 = var_12_0[math.random(#var_12_0)]
	end

	return var_12_1
end

function var_0_7.NearestUnitByType(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._unitList) do
		local var_13_2

		if table.contains(arg_13_2, iter_13_1:GetTemplate().type) then
			local var_13_1 = Vector3.BattleDistance(iter_13_1:GetPosition(), arg_13_1)

			if var_13_1 < 999 then
				var_13_2 = var_13_1
				var_13_0 = iter_13_1
			end
		end
	end

	return var_13_0
end

function var_0_7.SetMotionSource(arg_14_0, arg_14_1)
	arg_14_0._motionSourceFunc = arg_14_1 == nil and function()
		local var_15_0 = pg.UIMgr.GetInstance()

		return var_15_0.hrz, var_15_0.vtc
	end or arg_14_1

	return
end

function var_0_7.SetSubAidData(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._submarineVO = var_0.Battle.BattleSubmarineAidVO.New()

	if arg_16_2 == var_0_3.SubAidFlag.AID_EMPTY or arg_16_2 == var_0_3.SubAidFlag.OIL_EMPTY then
		arg_16_0._submarineVO:SetUseable(false)
	else
		arg_16_0._submarineVO:SetCount(arg_16_2)
		arg_16_0._submarineVO:SetTotal(arg_16_1)
		arg_16_0._submarineVO:SetUseable(true)
	end

	return
end

function var_0_7.SetAutobotBound(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0._upperBound = arg_17_1
	arg_17_0._lowerBound = arg_17_2
	arg_17_0._leftBound = arg_17_3
	arg_17_0._rightBound = arg_17_4

	return
end

function var_0_7.SetTotalBound(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0._totalUpperBound = arg_18_1
	arg_18_0._totalLowerBound = arg_18_2
	arg_18_0._totalLeftBound = arg_18_3
	arg_18_0._totalRightBound = arg_18_4

	return
end

function var_0_7.SetUnitBound(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._fleetUnitBound = var_0.Battle.BattleFleetBound.New(arg_19_0._IFF)

	arg_19_0._fleetUnitBound:ConfigAreaData(arg_19_1, arg_19_2)
	arg_19_0._fleetUnitBound:SwtichCommon()

	return
end

function var_0_7.SetChapterPlayType(arg_20_0, arg_20_1)
	arg_20_0._chapterType = arg_20_1

	return
end

function var_0_7.GetLeftBoundDistance(arg_21_0)
	if arg_21_0._chapterType and arg_21_0._chapterType == 5 then
		return math.abs(arg_21_0._motionVO:GetPos().x - arg_21_0._leftBound)
	end

	return
end

function var_0_7.UpdateScoutUnitBound(arg_22_0)
	local var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5 = arg_22_0._fleetUnitBound:GetBound()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._scoutList) do
		iter_22_1:SetBound(var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5)
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0._freezeList) do
		if not iter_22_2:IsMainFleetUnit() then
			iter_22_2:SetBound(var_22_0, var_22_1, var_22_2, var_22_3, var_22_4, var_22_5)
		end
	end

	return
end

function var_0_7.CalcSubmarineBaseLine(arg_23_0, arg_23_1)
	if arg_23_0._IFF == var_0_4.FRIENDLY_CODE then
		if arg_23_1 == SYSTEM_DUEL then
			-- block empty
		else
			arg_23_0._subAttackBaseLine = (arg_23_0._totalRightBound + arg_23_0._totalLeftBound) * 0.5
			arg_23_0._subRetreatBaseLine = arg_23_0._leftBound - 10
		end
	elseif arg_23_0._IFF == var_0_4.FOE_CODE and arg_23_1 == SYSTEM_DUEL then
		-- block empty
	end

	return
end

function var_0_7.SetExposeLine(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._visionLineX = arg_24_1
	arg_24_0._exposeLineX = arg_24_2

	return
end

function var_0_7.AppendPlayerUnit(arg_25_0, arg_25_1)
	arg_25_0._unitList[#arg_25_0._unitList + 1] = arg_25_1
	arg_25_0._maxCount = arg_25_0._maxCount + 1

	if arg_25_1:IsMainFleetUnit() then
		arg_25_0:appendMainUnit(arg_25_1)
	else
		arg_25_0:appendScoutUnit(arg_25_1)
	end

	arg_25_1:SetFleetVO(arg_25_0)
	arg_25_1:SetMotion(arg_25_0._motionVO)
	arg_25_1:RegisterEventListener(arg_25_0, var_0_0.UPDATE_HP, arg_25_0.onUnitUpdateHP)
	arg_25_1:RegisterEventListener(arg_25_0, var_0_0.UPDATE_CLOAK_STATE, arg_25_0.onUnitCloakUpdate)

	if arg_25_0._cardPuzzleComponent then
		arg_25_0._cardPuzzleComponent:AppendUnit(arg_25_1)
	end

	return
end

function var_0_7.RemovePlayerUnit(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._freezeList[arg_26_1] = nil

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._unitList) do
		if iter_26_1 ~= arg_26_1 then
			({})[#{} + 1] = iter_26_0
		else
			if not arg_26_2 then
				iter_26_1:UnregisterEventListener(arg_26_0, var_0_0.UPDATE_HP)
				iter_26_1:UnregisterEventListener(arg_26_0, var_0_0.UPDATE_CLOAK_STATE)
				iter_26_1:DeactiveCldBox()
			end

			for iter_26_2, iter_26_3 in ipairs((iter_26_1:GetChargeList())) do
				if iter_26_3:IsAttacking() then
					arg_26_0._chargeWeaponVO:CancelFocus()
					arg_26_0._chargeWeaponVO:ResetFocus()
					arg_26_0:CancelChargeWeapon()
				end

				arg_26_0._chargeWeaponVO:RemoveWeapon(iter_26_3)

				if not arg_26_2 then
					iter_26_3:Clear()
				end
			end

			arg_26_0._fleetAntiAir:RemoveCrewUnit(arg_26_1)
			arg_26_0._fleetRangeAntiAir:RemoveCrewUnit(arg_26_1)
			arg_26_0._fleetStaticSonar:RemoveCrewUnit(arg_26_1)

			for iter_26_4, iter_26_5 in ipairs((iter_26_1:GetTorpedoList())) do
				arg_26_0:RemoveManunalTorpedo(iter_26_5, arg_26_2)
			end

			local var_26_0 = iter_26_1:GetAirAssistList()

			if var_26_0 then
				for iter_26_6, iter_26_7 in ipairs(var_26_0) do
					arg_26_0._airAssistVO:RemoveWeapon(iter_26_7)
				end
			end
		end
	end

	for iter_26_8, iter_26_9 in ipairs(arg_26_0._scoutList) do
		if iter_26_9 == arg_26_1 then
			if #arg_26_0._scoutList == 1 then
				arg_26_0:CancelChargeWeapon()
			end

			table.remove(arg_26_0._scoutList, iter_26_8)

			break
		end
	end

	;(function(arg_27_0)
		for iter_27_0, iter_27_1 in ipairs(arg_27_0) do
			if iter_27_1 == arg_26_1 then
				table.remove(arg_27_0, iter_27_0)

				break
			end
		end

		return
	end)(arg_26_0._mainList)
	var_26_1(arg_26_0._cloakList)
	var_26_1(arg_26_0._subList)
	var_26_1(arg_26_0._manualSubList)

	if not arg_26_0._manualSubUnit then
		arg_26_0:refreshFleetFormation({})
	end

	return
end

function var_0_7.OverrideJoyStickAutoBot(arg_28_0, arg_28_1)
	arg_28_0._autoBotAIID = arg_28_1

	arg_28_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleEvent.OVERRIDE_AUTO_BOT)))

	return
end

function var_0_7.SnapShot(arg_29_0)
	arg_29_0._totalDMGRatio = var_0_2.GetFleetTotalHP(arg_29_0)
	arg_29_0._currentDMGRatio = arg_29_0._totalDMGRatio

	return
end

function var_0_7.GetIFF(arg_30_0)
	return arg_30_0._IFF
end

function var_0_7.GetMaxCount(arg_31_0)
	return arg_31_0._maxCount
end

function var_0_7.GetFlagShip(arg_32_0)
	return arg_32_0._flagShip
end

function var_0_7.GetLeaderShip(arg_33_0)
	return arg_33_0._scoutList[1]
end

function var_0_7.GetUnitList(arg_34_0)
	return arg_34_0._unitList
end

function var_0_7.GetFreezeUnitList(arg_35_0)
	return arg_35_0._freezeList
end

function var_0_7.GetMainList(arg_36_0)
	return arg_36_0._mainList
end

function var_0_7.GetScoutList(arg_37_0)
	return arg_37_0._scoutList
end

function var_0_7.GetFreezeShipByID(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_0._freezeList) do
		if arg_38_1 == iter_38_0:GetAttrByName("id") then
			return iter_38_0
		end
	end

	return
end

function var_0_7.GetShipByID(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0._unitList) do
		if arg_39_1 == iter_39_1:GetAttrByName("id") then
			return iter_39_1
		end
	end

	return
end

function var_0_7.GetCloakList(arg_40_0)
	return arg_40_0._cloakList
end

function var_0_7.GetSubBench(arg_41_0)
	return arg_41_0._manualSubBench
end

function var_0_7.GetUnitBound(arg_42_0)
	return arg_42_0._fleetUnitBound
end

function var_0_7.GetMotion(arg_43_0)
	return arg_43_0._motionVO
end

function var_0_7.GetMotionReferenceUnit(arg_44_0)
	return arg_44_0._motionReferenceUnit
end

function var_0_7.GetAutoBotAIID(arg_45_0)
	return arg_45_0._autoBotAIID
end

function var_0_7.GetChargeWeaponVO(arg_46_0)
	return arg_46_0._chargeWeaponVO
end

function var_0_7.GetTorpedoWeaponVO(arg_47_0)
	return arg_47_0._torpedoWeaponVO
end

function var_0_7.GetAirAssistVO(arg_48_0)
	return arg_48_0._airAssistVO
end

function var_0_7.GetSubAidVO(arg_49_0)
	return arg_49_0._submarineVO
end

function var_0_7.GetSubFreeDiveVO(arg_50_0)
	return arg_50_0._submarineDiveVO
end

function var_0_7.GetSubFreeFloatVO(arg_51_0)
	return arg_51_0._submarineFloatVO
end

function var_0_7.GetSubBoostVO(arg_52_0)
	return arg_52_0._submarineBoostVO
end

function var_0_7.GetSubSpecialVO(arg_53_0)
	return arg_53_0._submarineSpecialVO
end

function var_0_7.GetSubShiftVO(arg_54_0)
	return arg_54_0._submarineShiftVO
end

function var_0_7.GetFleetAntiAirWeapon(arg_55_0)
	return arg_55_0._fleetAntiAir
end

function var_0_7.GetFleetRangeAntiAirWeapon(arg_56_0)
	return arg_56_0._fleetRangeAntiAir
end

function var_0_7.GetFleetVelocity(arg_57_0)
	return var_0_2.GetFleetVelocity(arg_57_0._scoutList)
end

function var_0_7.GetFleetBound(arg_58_0)
	return arg_58_0._upperBound, arg_58_0._lowerBound, arg_58_0._leftBound, arg_58_0._rightBound
end

function var_0_7.GetFleetUnitBound(arg_59_0)
	return arg_59_0._totalUpperBound, arg_59_0._totalLowerBound
end

function var_0_7.GetFleetExposeLine(arg_60_0)
	return arg_60_0._exposeLineX
end

function var_0_7.GetFleetVisionLine(arg_61_0)
	return arg_61_0._visionLineX
end

function var_0_7.GetLeaderPersonality(arg_62_0)
	return arg_62_0._motionReferenceUnit:GetAutoPilotPreference()
end

function var_0_7.GetDamageRatioResult(arg_63_0)
	return string.format("%0.2f", arg_63_0._currentDMGRatio / arg_63_0._totalDMGRatio * 100), arg_63_0._totalDMGRatio
end

function var_0_7.GetDamageRatio(arg_64_0)
	return arg_64_0._currentDMGRatio / arg_64_0._totalDMGRatio
end

function var_0_7.GetSubmarineBaseLine(arg_65_0)
	local var_65_0 = arg_65_0._fixedSubRefLine or arg_65_0._subAttackBaseLine

	return var_65_0, arg_65_0._subRetreatBaseLine
end

function var_0_7.GetFleetSonar(arg_66_0)
	return arg_66_0._fleetStaticSonar
end

function var_0_7.Dispose(arg_67_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_67_0)
	var_0.EventListener.DetachEventListener(arg_67_0)

	arg_67_0._leaderUnit = nil

	arg_67_0._fleetAntiAir:Dispose()
	arg_67_0._fleetRangeAntiAir:Dispose()
	arg_67_0._fleetStaticSonar:Dispose()

	arg_67_0._fleetStaticSonar = nil
	arg_67_0._buffList = nil
	arg_67_0._indieSonarList = nil
	arg_67_0._scoutAimBias = nil

	arg_67_0._fleetAttr:Dispose()

	arg_67_0._fleetAttr = nil
	arg_67_0._freezeList = nil

	return
end

function var_0_7.refreshFleetFormation(arg_68_0, arg_68_1)
	local var_68_0 = var_0_6.GetFormationTmpDataFromID(var_0_4.FORMATION_ID).pos_offset

	arg_68_0._unitList = var_0_6.SortFleetList(arg_68_1, arg_68_0._unitList)

	if not arg_68_0._mainUnitFree then
		for iter_68_0, iter_68_1 in ipairs(arg_68_0._unitList) do
			if not table.contains(arg_68_0._subList, iter_68_1) then
				local var_68_1 = var_68_0[iter_68_0] or var_68_0[#var_68_0]

				iter_68_1:UpdateFormationOffset(Vector3(var_68_1.x, var_68_1.y, var_68_1.z) + var_0_4.BornOffset * (iter_68_0 - 1))
			end
		end
	end

	if #arg_68_0._scoutList > 0 then
		arg_68_0._motionReferenceUnit = arg_68_0._scoutList[1]
		arg_68_0._leaderUnit = arg_68_0._scoutList[1]

		arg_68_0._leaderUnit:LeaderSetting()
		arg_68_0._fleetAntiAir:SwitchHost(arg_68_0._motionReferenceUnit)
		arg_68_0._fleetStaticSonar:SwitchHost(arg_68_0._motionReferenceUnit)

		for iter_68_2, iter_68_3 in pairs(arg_68_0._indieSonarList) do
			iter_68_2:SwitchHost(arg_68_0._motionReferenceUnit)
		end

		arg_68_0._motionVO:UpdatePos(arg_68_0._motionReferenceUnit)
	elseif arg_68_0._fleetAntiAir:GetCurrentState() ~= arg_68_0._fleetAntiAir.STATE_DISABLE then
		for iter_68_4, iter_68_5 in pairs((arg_68_0._fleetAntiAir:GetCrewUnitList())) do
			arg_68_0._motionReferenceUnit = iter_68_4

			arg_68_0._fleetAntiAir:SwitchHost(iter_68_4)

			break
		end
	else
		arg_68_0._motionReferenceUnit = arg_68_0._mainList[1]
		arg_68_0._leaderUnit = nil
	end

	if #arg_68_0:GetUnitList() == 0 then
		return
	end

	arg_68_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleEvent.REFRESH_FLEET_FORMATION)))

	return
end

function var_0_7.init(arg_69_0)
	arg_69_0._chargeWeaponVO = var_0.Battle.BattleChargeWeaponVO.New()
	arg_69_0._torpedoWeaponVO = var_0.Battle.BattleTorpedoWeaponVO.New()
	arg_69_0._airAssistVO = var_0.Battle.BattleAllInStrikeVO.New()
	arg_69_0._submarineDiveVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.DIVE_CD)
	arg_69_0._submarineFloatVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.FLOAT_CD)
	arg_69_0._submarineVOList = {
		arg_69_0._submarineDiveVO,
		arg_69_0._submarineFloatVO
	}
	arg_69_0._submarineBoostVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.BOOST_CD)
	arg_69_0._submarineShiftVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.SHIFT_CD)
	arg_69_0._submarineSpecialVO = var_0.Battle.BattleSubmarineAidVO.New()

	arg_69_0._submarineSpecialVO:SetCount(1)
	arg_69_0._submarineSpecialVO:SetTotal(1)

	arg_69_0._fleetAntiAir = var_0.Battle.BattleFleetAntiAirUnit.New()
	arg_69_0._fleetRangeAntiAir = var_0.Battle.BattleFleetRangeAntiAirUnit.New()
	arg_69_0._motionVO = var_0.Battle.BattleFleetMotionVO.New()
	arg_69_0._fleetStaticSonar = var_0.Battle.BattleFleetStaticSonar.New(arg_69_0)
	arg_69_0._indieSonarList = {}
	arg_69_0._scoutList = {}
	arg_69_0._mainList = {}
	arg_69_0._subList = {}
	arg_69_0._supportList = {}
	arg_69_0._cloakList = {}
	arg_69_0._manualSubList = {}
	arg_69_0._manualSubBench = {}
	arg_69_0._unitList = {}
	arg_69_0._maxCount = 0
	arg_69_0._freezeList = {}
	arg_69_0._blockCast = 0
	arg_69_0._buffList = {}

	arg_69_0:AttachFleetAttr()
	arg_69_0:SetMotionSource()

	return
end

function var_0_7.appendScoutUnit(arg_70_0, arg_70_1)
	arg_70_0._scoutList[#arg_70_0._scoutList + 1] = arg_70_1

	for iter_70_0, iter_70_1 in ipairs((arg_70_1:GetTorpedoList())) do
		arg_70_0._torpedoWeaponVO:AppendWeapon(iter_70_1)
	end

	if #arg_70_1:GetHiveList() > 0 then
		local var_70_0 = var_0_6.CreateAllInStrike(arg_70_1)

		for iter_70_2, iter_70_3 in ipairs(var_70_0) do
			arg_70_0._airAssistVO:AppendWeapon(iter_70_3)
		end

		arg_70_1:SetAirAssistList(var_70_0)
	end

	arg_70_0._fleetAntiAir:AppendCrewUnit(arg_70_1)
	arg_70_0._fleetStaticSonar:AppendCrewUnit(arg_70_1)

	local var_70_1 = 1

	while var_70_1 < #arg_70_0._unitList do
		table.insert({}, var_70_1)

		var_70_1 = var_70_1 + 1
	end

	table.insert({}, #arg_70_0._scoutList, var_70_1)
	arg_70_0:refreshFleetFormation({})

	return
end

function var_0_7.appendMainUnit(arg_71_0, arg_71_1)
	if #arg_71_0._mainList == 0 then
		arg_71_0._flagShip = arg_71_1
	end

	arg_71_0._mainList[#arg_71_0._mainList + 1] = arg_71_1

	arg_71_1:SetMainUnitIndex(#arg_71_0._mainList)

	if ShipType.CloakShipType(arg_71_1:GetTemplate().type) then
		arg_71_0:AttachCloak(arg_71_1)
	end

	for iter_71_0, iter_71_1 in ipairs((arg_71_1:GetChargeList())) do
		arg_71_0._chargeWeaponVO:AppendWeapon(iter_71_1)
	end

	for iter_71_2, iter_71_3 in ipairs((arg_71_1:GetTorpedoList())) do
		arg_71_0._torpedoWeaponVO:AppendWeapon(iter_71_3)
	end

	if #arg_71_1:GetHiveList() > 0 then
		local var_71_0 = var_0_6.CreateAllInStrike(arg_71_1)

		for iter_71_4, iter_71_5 in ipairs(var_71_0) do
			arg_71_0._airAssistVO:AppendWeapon(iter_71_5)
		end

		arg_71_1:SetAirAssistList(var_71_0)
	end

	arg_71_0._fleetAntiAir:AppendCrewUnit(arg_71_1)
	arg_71_0._fleetRangeAntiAir:AppendCrewUnit(arg_71_1)
	arg_71_0._fleetStaticSonar:AppendCrewUnit(arg_71_1)

	for iter_71_6, iter_71_7 in ipairs(arg_71_0._unitList) do
		table.insert({}, iter_71_6)
	end

	arg_71_0:refreshFleetFormation({})

	return
end

function var_0_7.appendSubUnit(arg_72_0, arg_72_1)
	arg_72_0._subList[#arg_72_0._subList + 1] = arg_72_1

	arg_72_1:SetMainUnitIndex(#arg_72_0._subList)

	return
end

function var_0_7.FleetWarcry(arg_73_0)
	local var_73_0
	local var_73_1 = math.random(0, 1)
	local var_73_2 = arg_73_0:GetMainList()[1]

	if var_73_2 == nil or var_73_1 == 0 then
		var_73_0 = arg_73_0:GetScoutList()[1]
	elseif var_73_1 == 1 then
		var_73_0 = var_73_2
	end

	local var_73_3 = "battle"

	var_73_0:DispatchVoice("battle")
	var_73_0:DispatchChat(var_0.Battle.BattleDataFunction.GetWords(var_73_0:GetSkinID(), "battle", (var_73_0:GetIntimacy())), 2.5, var_73_3)

	return
end

function var_0_7.FleetUnitSpwanFinish(arg_74_0)
	local var_74_0 = 0

	for iter_74_0, iter_74_1 in ipairs(arg_74_0._unitList) do
		var_74_0 = var_74_0 + iter_74_1:GetGearScore()
	end

	for iter_74_2, iter_74_3 in ipairs(arg_74_0._unitList) do
		var_0_5.SetCurrent(iter_74_3, "fleetGS", var_74_0)
	end

	return
end

function var_0_7.SubWarcry(arg_75_0)
	local var_75_0 = arg_75_0:GetSubList()[1]

	var_75_0:DispatchVoice("battle")
	var_75_0:DispatchChat(var_0.Battle.BattleDataFunction.GetWords(var_75_0:GetSkinID(), "battle", (var_75_0:GetIntimacy())), 2.5, "battle")

	return
end

function var_0_7.SetWeaponBlock(arg_76_0, arg_76_1)
	arg_76_0._blockCast = arg_76_0._blockCast + arg_76_1

	return
end

function var_0_7.GetWeaponBlock(arg_77_0)
	return arg_77_0._blockCast > 0
end

function var_0_7.CastChargeWeapon(arg_78_0)
	if arg_78_0:GetWeaponBlock() then
		return
	end

	local var_78_0 = arg_78_0._chargeWeaponVO:GetCurrentWeapon()

	if var_78_0 ~= nil and var_78_0:GetCurrentState() == var_78_0.STATE_READY then
		var_78_0:Charge()
		arg_78_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CHARGE, {})))
	end

	return
end

function var_0_7.CancelChargeWeapon(arg_79_0)
	local var_79_0 = arg_79_0._chargeWeaponVO:GetCurrentWeapon()

	if var_79_0 ~= nil and var_79_0:GetCurrentState() == var_79_0.STATE_PRECAST then
		arg_79_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
		var_79_0:CancelCharge()
	end

	return
end

function var_0_7.UnleashChrageWeapon(arg_80_0)
	if arg_80_0:GetWeaponBlock() then
		arg_80_0:CancelChargeWeapon()

		return
	end

	local var_80_0 = arg_80_0._chargeWeaponVO:GetCurrentWeapon()

	if var_80_0 ~= nil and var_80_0:GetCurrentState() == var_80_0.STATE_PRECAST then
		if var_80_0:IsStrikeMode() then
			arg_80_0:fireChargeWeapon(var_80_0, true, Vector3.New(math.min(arg_80_0._motionVO:GetPos().x + var_0_4.ChargeWeaponConfig.SIGHT_C, arg_80_0._totalRightBound), 0, arg_80_0._motionVO:GetPos().z))
		else
			var_80_0:CancelCharge()
		end

		arg_80_0:DispatchEvent((var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, {})))
	end

	return
end

function var_0_7.QuickTagChrageWeapon(arg_81_0, arg_81_1)
	if arg_81_0:GetWeaponBlock() then
		return
	end

	local var_81_0
	local var_81_1 = arg_81_0._chargeWeaponVO:GetCurrentWeapon()

	if var_81_1 ~= nil and var_81_1:GetCurrentState() == var_81_1.STATE_READY then
		var_81_1:QuickTag()

		if #var_81_1:GetLockList() <= 0 then
			var_81_1:CancelQuickTag()
		else
			var_81_0 = arg_81_0:fireChargeWeapon(var_81_1, arg_81_1)
		end
	end

	return var_81_0
end

function var_0_7.fireChargeWeapon(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = arg_82_1:GetHost()

	if arg_82_1:GetType() == var_0_3.EquipmentType.POINT_AIR_STRIKE then
		arg_82_1:Fire(arg_82_3)
	elseif arg_82_2 then
		if arg_82_0._IFF == var_0_4.FRIENDLY_CODE then
			arg_82_0._chargeWeaponVO:PlayCutIn(var_82_0, 1 / var_0_4.FOCUS_MAP_RATE)
		end

		arg_82_0._chargeWeaponVO:PlayFocus(var_82_0, function()
			arg_82_1:DispatchBlink(function()
				arg_82_1:Fire(arg_82_3)

				return
			end)

			return
		end)
	else
		if arg_82_0._IFF == var_0_4.FRIENDLY_CODE then
			arg_82_0._chargeWeaponVO:PlayCutIn(var_82_0, 1)
		end

		;(function()
			arg_82_1:DispatchBlink(function()
				arg_82_1:Fire(arg_82_3)

				return
			end)

			return
		end)()
	end

	return
end

function var_0_7.UnleashAllInStrike(arg_85_0)
	if arg_85_0:GetWeaponBlock() then
		return
	end

	local var_85_0
	local var_85_1 = arg_85_0._airAssistVO:GetCurrentWeapon()

	if var_85_1 and var_85_1:GetCurrentState() == var_85_1.STATE_READY then
		local var_85_2 = var_85_1:GetHost()

		if arg_85_0._IFF == var_0_4.FRIENDLY_CODE and var_85_2:IsMainFleetUnit() then
			arg_85_0._airAssistVO:PlayCutIn(var_85_2, 1)
		end

		var_85_1:CLSBullet()
		var_85_1:DispatchBlink()

		var_85_0 = var_85_1:Fire()
	end

	return var_85_0
end

function var_0_7.CastTorpedo(arg_86_0)
	if arg_86_0:GetWeaponBlock() then
		return
	end

	local var_86_0 = arg_86_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_86_0 ~= nil and var_86_0:GetCurrentState() == var_86_0.STATE_READY and var_86_0:Prepar() then
		arg_86_0:FleetBuffTrigger(var_0_3.BuffEffectType.ON_TORPEDO_BUTTON_PUSH)
	end

	return
end

function var_0_7.CancelTorpedo(arg_87_0)
	local var_87_0 = arg_87_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_87_0 ~= nil and var_87_0:GetCurrentState() == var_87_0.STATE_PRECAST then
		var_87_0:Cancel()
	end

	return
end

function var_0_7.UnleashTorpedo(arg_88_0)
	if arg_88_0:GetWeaponBlock() then
		arg_88_0:CancelTorpedo()

		return
	end

	local var_88_0 = arg_88_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_88_0 ~= nil and var_88_0:GetCurrentState() == var_88_0.STATE_PRECAST then
		var_88_0:Fire()
	end

	return
end

function var_0_7.QuickCastTorpedo(arg_89_0)
	if arg_89_0:GetWeaponBlock() then
		return
	end

	local var_89_0
	local var_89_1 = arg_89_0._torpedoWeaponVO:GetCurrentWeapon()

	if var_89_1 ~= nil and var_89_1:GetCurrentState() == var_89_1.STATE_READY then
		var_89_0 = var_89_1:Fire(true)
	end

	return var_89_0
end

function var_0_7.RemoveManunalTorpedo(arg_90_0, arg_90_1, arg_90_2)
	if arg_90_1:IsAttacking() then
		arg_90_0:CancelTorpedo()
	end

	arg_90_0._torpedoWeaponVO:RemoveWeapon(arg_90_1)

	if not arg_90_2 then
		arg_90_1:Clear()
	end

	return
end

function var_0_7.CoupleEncourage(arg_91_0)
	local var_91_0 = {}

	for iter_91_0, iter_91_1 in ipairs(arg_91_0._unitList) do
		local var_91_1 = var_0_6.GetWords(iter_91_1:GetSkinID(), "couple_encourage", (iter_91_1:GetIntimacy()))

		if #var_91_1 > 0 then
			({})[iter_91_1] = var_91_1
		end
	end

	local var_91_2 = var_0_3.CPChatType

	for iter_91_2, iter_91_3 in pairs({}) do
		for iter_91_4, iter_91_5 in ipairs(iter_91_3) do
			local var_91_3 = iter_91_5[2]
			local var_91_4 = iter_91_5[4] or var_0_3.CPChatType.GROUP_ID
			local var_91_5 = var_0.Battle.BattleTargetChoise.TargetAllHelp(iter_91_2)

			if type(var_91_4) == "table" then
				for iter_91_6, iter_91_7 in ipairs(var_91_4) do
					var_91_5 = var_0.Battle.BattleTargetChoise[var_0_3.CPChatTargetFunc[iter_91_7]](iter_91_2, (function(arg_92_0, arg_92_1)
						if arg_92_0 == var_91_2.GROUP_ID then
							({}).groupIDList = arg_92_1
						elseif arg_92_0 == var_91_2.SHIP_TYPE then
							({}).ship_type_list = arg_92_1
						elseif arg_92_0 == var_91_2.RARE then
							({}).rarity = arg_92_1[1]
						elseif arg_92_0 == var_91_2.NATIONALITY then
							({}).nationality = arg_92_1[1]
						elseif arg_92_0 == var_91_2.ILLUSTRATOR then
							({}).illustrator = arg_92_1[1]
						elseif arg_92_0 == var_91_2.TEAM then
							({}).teamIndex = arg_92_1[1]
						end

						return {}
					end)(iter_91_7, iter_91_5[1][iter_91_6]), var_91_5)
				end
			elseif type(var_91_4) == "number" then
				var_91_5 = var_0.Battle.BattleTargetChoise[var_0_3.CPChatTargetFunc[var_91_4]](iter_91_2, (function(arg_92_0, arg_92_1)
					if arg_92_0 == var_91_2.GROUP_ID then
						({}).groupIDList = arg_92_1
					elseif arg_92_0 == var_91_2.SHIP_TYPE then
						({}).ship_type_list = arg_92_1
					elseif arg_92_0 == var_91_2.RARE then
						({}).rarity = arg_92_1[1]
					elseif arg_92_0 == var_91_2.NATIONALITY then
						({}).nationality = arg_92_1[1]
					elseif arg_92_0 == var_91_2.ILLUSTRATOR then
						({}).illustrator = arg_92_1[1]
					elseif arg_92_0 == var_91_2.TEAM then
						({}).teamIndex = arg_92_1[1]
					end

					return {}
				end)(var_91_4, iter_91_5[1]), var_91_5)
			end

			if var_91_3 <= #var_91_5 then
				var_91_0[#var_91_0 + 1] = {
					cp = iter_91_2,
					content = iter_91_5[3],
					linkIndex = iter_91_4
				}
			end
		end
	end

	if #var_91_0 > 0 then
		local var_91_6 = var_91_0[math.random(#var_91_0)]

		var_91_6.cp:DispatchVoice("link" .. var_91_6.linkIndex)
		var_91_6.cp:DispatchChat(var_91_6.content, 3, "link" .. var_91_6.linkIndex)
	end

	return
end

function var_0_7.onUnitUpdateHP(arg_93_0, arg_93_1)
	for iter_93_0, iter_93_1 in ipairs(arg_93_0._unitList) do
		iter_93_1:TriggerBuff(var_0_3.BuffEffectType.ON_FRIENDLY_HP_RATIO_UPDATE, {
			unit = arg_93_1.Dispatcher,
			dHP = arg_93_1.Data.dHP
		})

		if iter_93_1 ~= arg_93_1.Dispatcher then
			iter_93_1:TriggerBuff(var_0_3.BuffEffectType.ON_TEAMMATE_HP_RATIO_UPDATE, {
				unit = arg_93_1.Dispatcher,
				dHP = arg_93_1.Data.dHP
			})
		end
	end

	return
end

function var_0_7.onUnitCloakUpdate(arg_94_0, arg_94_1)
	local var_94_0 = var_0_5.GetCurrent(arg_94_1.Dispatcher, "isCloak")

	for iter_94_0, iter_94_1 in ipairs(arg_94_0._unitList) do
		iter_94_1:TriggerBuff(var_0_3.BuffEffectType.ON_CLOAK_UPDATE, {
			cloakState = var_94_0
		})

		if iter_94_1 ~= arg_94_1.Dispatcher then
			iter_94_1:TriggerBuff(var_0_3.BuffEffectType.ON_TEAMMATE_CLOAK_UPDATE, {
				cloakState = var_94_0
			})
		end
	end

	return
end

function var_0_7.SetSubUnitData(arg_95_0, arg_95_1)
	arg_95_0._subUntiDataList = arg_95_1

	return
end

function var_0_7.GetSubUnitData(arg_96_0)
	return arg_96_0._subUntiDataList
end

function var_0_7.AddSubMarine(arg_97_0, arg_97_1)
	arg_97_1:InitOxygen()

	local var_97_0 = arg_97_1:GetTemplate()

	var_0.Battle.BattleUnitPhaseSwitcher.New(arg_97_1):SetTemplateData(var_0_6.GeneratePlayerSubmarinPhase(var_97_1, arg_97_0._subRetreatBaseLine, arg_97_1:GetAttrByName("raidDist"), function()
		return arg_97_1:GetRaidDuration()
	end, arg_97_1:GetAttrByName("oxyAtkDuration")))

	arg_97_0._unitList[#arg_97_0._unitList + 1] = arg_97_1
	arg_97_0._subList[#arg_97_0._subList + 1] = arg_97_1

	arg_97_1:SetFleetVO(arg_97_0)
	arg_97_1:RegisterEventListener(arg_97_0, var_0_0.UPDATE_HP, arg_97_0.onUnitUpdateHP)
	arg_97_1:RegisterEventListener(arg_97_0, var_0_0.UPDATE_CLOAK_STATE, arg_97_0.onUnitCloakUpdate)

	return
end

function var_0_7.AddManualSubmarine(arg_99_0, arg_99_1)
	arg_99_0._unitList[#arg_99_0._unitList + 1] = arg_99_1
	arg_99_0._manualSubList[#arg_99_0._manualSubList + 1] = arg_99_1
	arg_99_0._manualSubBench[#arg_99_0._manualSubBench + 1] = arg_99_1
	arg_99_0._maxCount = arg_99_0._maxCount + 1

	arg_99_1:InitOxygen()
	arg_99_1:SetFleetVO(arg_99_0)
	arg_99_1:SetMotion(arg_99_0._motionVO)
	arg_99_1:RegisterEventListener(arg_99_0, var_0_0.UPDATE_HP, arg_99_0.onUnitUpdateHP)
	arg_99_1:RegisterEventListener(arg_99_0, var_0_0.UPDATE_CLOAK_STATE, arg_99_0.onUnitCloakUpdate)

	return
end

function var_0_7.GetSubList(arg_100_0)
	return arg_100_0._subList
end

function var_0_7.ShiftManualSub(arg_101_0)
	local var_101_0

	if arg_101_0._manualSubUnit then
		for iter_101_0, iter_101_1 in ipairs((arg_101_0._manualSubUnit:GetTorpedoList())) do
			if iter_101_1:IsAttacking() then
				arg_101_0:CancelTorpedo()
			end

			arg_101_0._torpedoWeaponVO:RemoveWeapon(iter_101_1)
		end

		if arg_101_0._manualSubUnit:IsAlive() then
			table.insert(arg_101_0._manualSubBench, arg_101_0._manualSubUnit)
		end

		var_101_0 = arg_101_0._motionVO:GetPos():Clone()
	else
		var_101_0 = arg_101_0._manualSubList[1]:GetPosition():Clone()
	end

	arg_101_0._manualSubUnit = table.remove(arg_101_0._manualSubBench, 1)
	arg_101_0._scoutList[1] = arg_101_0._manualSubUnit

	for iter_101_2, iter_101_3 in ipairs(arg_101_0._manualSubBench) do
		for iter_101_4, iter_101_5 in ipairs(arg_101_0._unitList) do
			if iter_101_5 == iter_101_3 then
				table.insert({}, iter_101_4)

				break
			end
		end
	end

	for iter_101_6, iter_101_7 in ipairs(arg_101_0._unitList) do
		if iter_101_7 == arg_101_0._manualSubUnit then
			table.insert({}, 1, iter_101_6)

			break
		end
	end

	arg_101_0:refreshFleetFormation({})
	arg_101_0._manualSubUnit:SetMainUnitStatic(false)
	arg_101_0._manualSubUnit:SetPosition(var_101_0)
	arg_101_0:UpdateMotion()
	arg_101_0._submarineSpecialVO:SetUseable(false)

	for iter_101_8, iter_101_9 in pairs((arg_101_0._manualSubUnit:GetBuffList())) do
		if iter_101_9:IsSubmarineSpecial() then
			arg_101_0._submarineSpecialVO:SetCount(1)
			arg_101_0._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	arg_101_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)
	arg_101_0._torpedoWeaponVO:Reset()

	local var_101_1 = arg_101_0._manualSubUnit:GetTorpedoList()

	for iter_101_10, iter_101_11 in ipairs(var_101_1) do
		if iter_101_11:GetCurrentState() ~= iter_101_11.STATE_OVER_HEAT then
			arg_101_0._torpedoWeaponVO:AppendWeapon(iter_101_11)
		end
	end

	for iter_101_12, iter_101_13 in ipairs(var_101_1) do
		if iter_101_13:GetCurrentState() == iter_101_13.STATE_OVER_HEAT then
			arg_101_0._torpedoWeaponVO:AppendWeapon(iter_101_13)
		end
	end

	if var_0_5.GetCurrent(arg_101_0._manualSubUnit, "oxyMax") <= 0 then
		arg_101_0._submarineDiveVO:SetActive(false)
		arg_101_0._submarineFloatVO:SetActive(false)
	else
		arg_101_0._submarineDiveVO:SetActive(true)
		arg_101_0._submarineFloatVO:SetActive(true)
	end

	for iter_101_14, iter_101_15 in ipairs(arg_101_0._manualSubBench) do
		iter_101_15:SetPosition(var_0_4.SUB_BENCH_POS[iter_101_14])
		iter_101_15:SetMainUnitStatic(true)
		iter_101_15:ChangeOxygenState(var_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	arg_101_0._submarineShiftVO:ResetCurrent()

	if #arg_101_0._manualSubBench == 0 then
		arg_101_0._submarineShiftVO:SetActive(false)
	end

	return
end

function var_0_7.ChangeSubmarineState(arg_102_0, arg_102_1, arg_102_2)
	if not arg_102_0._manualSubUnit then
		return
	end

	arg_102_0._manualSubUnit:ChangeOxygenState(arg_102_1)

	if arg_102_2 then
		for iter_102_0, iter_102_1 in ipairs(arg_102_0._submarineVOList) do
			iter_102_1:ResetCurrent()
		end

		if arg_102_0._submarineShiftVO:IsOverLoad() and arg_102_0._submarineShiftVO:GetMax() - arg_102_0._submarineShiftVO:GetCurrent() > var_0_4.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			arg_102_0._submarineShiftVO:SetMax(var_0_4.SR_CONFIG.DIVE_CD)
			arg_102_0._submarineShiftVO:ResetCurrent()
		end
	end

	arg_102_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_SUBMARINE_SHIFT, {
		state = arg_102_1
	}))

	return
end

function var_0_7.SubmarinBoost(arg_103_0)
	arg_103_0._manualSubUnit:Boost(Vector3.right, var_0_4.SR_CONFIG.BOOST_SPEED, var_0_4.SR_CONFIG.BOOST_DECAY, var_0_4.SR_CONFIG.BOOST_DURATION, var_0_4.SR_CONFIG.BOOST_DECAY_STAMP)
	arg_103_0._submarineBoostVO:ResetCurrent()

	return
end

function var_0_7.UnleashSubmarineSpecial(arg_104_0)
	if arg_104_0:GetWeaponBlock() then
		return
	end

	arg_104_0._submarineSpecialVO:Cast()
	arg_104_0._manualSubUnit:TriggerBuff(var_0_3.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

function var_0_7.FixSubRefLine(arg_105_0, arg_105_1)
	arg_105_0._fixedSubRefLine = arg_105_1

	return
end

function var_0_7.AppendIndieSonar(arg_106_0, arg_106_1, arg_106_2)
	if not arg_106_0._motionReferenceUnit then
		return
	end

	local var_106_0 = var_0.Battle.BattleIndieSonar.New(arg_106_0, arg_106_1, arg_106_2)

	var_106_0:SwitchHost(arg_106_0._motionReferenceUnit)

	arg_106_0._indieSonarList[var_106_0] = true

	var_106_0:Detect()

	return
end

function var_0_7.RemoveIndieSonar(arg_107_0, arg_107_1)
	for iter_107_0, iter_107_1 in pairs(arg_107_0._indieSonarList) do
		if arg_107_1 == iter_107_0 then
			arg_107_0._indieSonarList[iter_107_0] = nil

			break
		end
	end

	return
end

function var_0_7.AttachFleetBuff(arg_108_0, arg_108_1)
	local var_108_0 = arg_108_1:GetID()
	local var_108_1 = arg_108_0:GetFleetBuff(var_108_0)

	if var_108_1 then
		var_108_1:Stack(arg_108_0)
	else
		arg_108_0._buffList[var_108_0] = arg_108_1

		arg_108_1:Attach(arg_108_0)
	end

	return
end

function var_0_7.RemoveFleetBuff(arg_109_0, arg_109_1)
	local var_109_0 = arg_109_0:GetFleetBuff(arg_109_1)

	if var_109_0 then
		var_109_0:Remove()
	end

	return
end

function var_0_7.GetFleetBuff(arg_110_0, arg_110_1)
	return arg_110_0._buffList[arg_110_1]
end

function var_0_7.GetFleetBuffList(arg_111_0)
	return arg_111_0._buffList
end

function var_0_7.AttachFleetAttr(arg_112_0)
	arg_112_0._fleetAttr = var_0.Battle.BattleFleetAttrComponent.New(arg_112_0)

	return
end

function var_0_7.GetFleetAttr(arg_113_0)
	return arg_113_0._fleetAttr
end

function var_0_7.Jamming(arg_114_0, arg_114_1)
	if arg_114_1 then
		arg_114_0._chargeWeaponVO:StartJamming()
		arg_114_0._torpedoWeaponVO:StartJamming()
		arg_114_0._airAssistVO:StartJamming()
	else
		arg_114_0._chargeWeaponVO:JammingEliminate()
		arg_114_0._torpedoWeaponVO:JammingEliminate()
		arg_114_0._airAssistVO:JammingEliminate()
	end

	return
end

function var_0_7.Blinding(arg_115_0, arg_115_1)
	arg_115_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_BLIND, {
		isBlind = arg_115_1
	}))

	return
end

function var_0_7.UpdateHorizon(arg_116_0)
	arg_116_0:DispatchEvent(var_0.Event.New(var_0_1.FLEET_HORIZON_UPDATE, {}))

	return
end

function var_0_7.AutoBotUpdated(arg_117_0, arg_117_1)
	if arg_117_1 then
		local var_117_0 = var_0_3.BuffEffectType.ON_AUTOBOT or var_0_3.BuffEffectType.ON_MANUAL

		arg_117_0:FleetBuffTrigger(var_117_0)

		return
	end
end

function var_0_7.CloakFatalExpose(arg_118_0)
	for iter_118_0, iter_118_1 in ipairs(arg_118_0._cloakList) do
		iter_118_1:GetCloak():ForceToMax()
	end

	return
end

function var_0_7.CloakInVision(arg_119_0, arg_119_1)
	for iter_119_0, iter_119_1 in ipairs(arg_119_0._cloakList) do
		iter_119_1:GetCloak():AppendExposeSpeed(arg_119_1)
	end

	return
end

function var_0_7.CloakOutVision(arg_120_0)
	for iter_120_0, iter_120_1 in ipairs(arg_120_0._cloakList) do
		iter_120_1:GetCloak():AppendExposeSpeed(0)
	end

	return
end

function var_0_7.AttachCloak(arg_121_0, arg_121_1)
	if not arg_121_1:GetCloak() then
		arg_121_1:InitCloak()

		arg_121_0._cloakList[#arg_121_0._cloakList + 1] = arg_121_1
	end

	return
end

function var_0_7.AttachNightCloak(arg_122_0)
	arg_122_0._scoutAimBias = var_0.Battle.BattleUnitAimBiasComponent.New()

	arg_122_0._scoutAimBias:ConfigRangeFormula(var_0_2.CalculateMaxAimBiasRange, var_0_2.CalculateBiasDecay)
	arg_122_0._scoutAimBias:Active(arg_122_0._scoutAimBias.STATE_ACTIVITING)
	arg_122_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AIM_BIAS, {
		aimBias = arg_122_0._scoutAimBias
	}))

	return
end

function var_0_7.GetFleetBias(arg_123_0)
	return arg_123_0._scoutAimBias
end

function var_0_7.FreezeUnit(arg_124_0, arg_124_1)
	arg_124_0:RemovePlayerUnit(arg_124_1, true)

	arg_124_0._freezeList[arg_124_1] = true

	return
end

function var_0_7.ActiveFreezeUnit(arg_125_0, arg_125_1)
	arg_125_0._freezeList[arg_125_1] = nil
	arg_125_0._unitList[#arg_125_0._unitList + 1] = arg_125_1
	arg_125_0._maxCount = arg_125_0._maxCount + 1

	if arg_125_1:IsMainFleetUnit() then
		arg_125_0:appendFreezeMainUnit(arg_125_1)
	else
		arg_125_0:activeFreezeScoutUnit(arg_125_1)
	end

	arg_125_1:SetFleetVO(arg_125_0)
	arg_125_1:SetMotion(arg_125_0._motionVO)
	arg_125_1:RegisterEventListener(arg_125_0, var_0_0.UPDATE_HP, arg_125_0.onUnitUpdateHP)
	arg_125_1:RegisterEventListener(arg_125_0, var_0_0.UPDATE_CLOAK_STATE, arg_125_0.onUnitCloakUpdate)

	return
end

function var_0_7.UndoFusion(arg_126_0)
	for iter_126_0, iter_126_1 in pairs(arg_126_0._freezeList) do
		arg_126_0._unitList[#arg_126_0._unitList + 1] = iter_126_0
		arg_126_0._maxCount = arg_126_0._maxCount + 1

		if iter_126_0:IsMainFleetUnit() then
			arg_126_0:appendFreezeMainUnit(iter_126_0)
		else
			arg_126_0:activeFreezeScoutUnit(iter_126_0)
		end
	end

	for iter_126_2, iter_126_3 in ipairs(arg_126_0._unitList) do
		local var_126_0 = iter_126_3:GetAttrByName("hpProvideRate")

		if var_126_0 ~= 0 then
			table.insert({}, iter_126_3)

			local var_126_1, var_126_2 = iter_126_3:GetHP()

			for iter_126_4, iter_126_5 in pairs(var_126_0) do
				local var_126_4 = arg_126_0:GetFreezeShipByID(iter_126_4)
				local var_126_5

				if not var_126_4 then
					arg_126_0:GetShipByID(iter_126_4)

					var_126_5 = var_126_4
				end

				var_126_4:UpdateHP(math.floor(iter_126_5 * (var_126_2 - var_126_1)) * -1, {})
			end
		end
	end

	for iter_126_6, iter_126_7 in ipairs({}) do
		arg_126_0:RemovePlayerUnit(iter_126_7)
	end

	return
end

function var_0_7.appendFreezeMainUnit(arg_127_0, arg_127_1)
	arg_127_0._mainList[#arg_127_0._mainList + 1] = arg_127_1

	arg_127_1:SetMainUnitIndex(#arg_127_0._mainList)

	if ShipType.CloakShipType(arg_127_1:GetTemplate().type) then
		table.insert(arg_127_0._cloakList, arg_127_1)
	end

	for iter_127_0, iter_127_1 in ipairs((arg_127_1:GetChargeList())) do
		arg_127_0._chargeWeaponVO:AppendFreezeWeapon(iter_127_1)
	end

	for iter_127_2, iter_127_3 in ipairs((arg_127_1:GetTorpedoList())) do
		arg_127_0._torpedoWeaponVO:AppendFreezeWeapon(iter_127_3)
	end

	if arg_127_1:GetAirAssistList() then
		for iter_127_4, iter_127_5 in ipairs((arg_127_1:GetAirAssistList())) do
			arg_127_0._airAssistVO:AppendFreezeWeapon(iter_127_5)
		end
	end

	arg_127_0._fleetAntiAir:AppendCrewUnit(arg_127_1)
	arg_127_0._fleetRangeAntiAir:AppendCrewUnit(arg_127_1)
	arg_127_0._fleetStaticSonar:AppendCrewUnit(arg_127_1)

	for iter_127_6, iter_127_7 in ipairs(arg_127_0._unitList) do
		table.insert({}, iter_127_6)
	end

	arg_127_0:refreshFleetFormation({})

	return
end

function var_0_7.activeFreezeScoutUnit(arg_128_0, arg_128_1)
	arg_128_0._scoutList[#arg_128_0._scoutList + 1] = arg_128_1

	for iter_128_0, iter_128_1 in ipairs((arg_128_1:GetTorpedoList())) do
		arg_128_0._torpedoWeaponVO:AppendFreezeWeapon(iter_128_1)
	end

	if arg_128_1:GetAirAssistList() then
		for iter_128_2, iter_128_3 in ipairs((arg_128_1:GetAirAssistList())) do
			arg_128_0._airAssistVO:AppendFreezeWeapon(iter_128_3)
		end
	end

	arg_128_0._fleetAntiAir:AppendCrewUnit(arg_128_1)
	arg_128_0._fleetStaticSonar:AppendCrewUnit(arg_128_1)

	local var_128_0 = 1

	while var_128_0 < #arg_128_0._unitList do
		table.insert({}, var_128_0)

		var_128_0 = var_128_0 + 1
	end

	table.insert({}, #arg_128_0._scoutList, var_128_0)
	arg_128_0:refreshFleetFormation({})

	return
end

function var_0_7.AttachCardPuzzleComponent(arg_129_0)
	arg_129_0._cardPuzzleComponent = var_0.Battle.BattleFleetCardPuzzleComponent.New(arg_129_0)

	return arg_129_0._cardPuzzleComponent
end

function var_0_7.GetCardPuzzleComponent(arg_130_0)
	return arg_130_0._cardPuzzleComponent
end

function var_0_7.AppendSupportUnit(arg_131_0, arg_131_1)
	arg_131_0._supportList[#arg_131_0._supportList + 1] = arg_131_1

	return
end

function var_0_7.GetSupportUnitList(arg_132_0)
	return arg_132_0._supportList
end

return
