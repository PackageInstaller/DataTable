ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleConst
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle.BattleAttr
local var_0_7 = var_0.Battle.BattleDataFunction
local var_0_8 = var_0.Battle.BattleAttr

class = var_0_10009

local var_0_9 = var_0_10009("BattleFleetVO")

var_0.Battle.BattleFleetVO = var_0_9
var_0_9.__name = "BattleFleetVO"

function var_0_9.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._IFF = arg_1_1
	arg_1_0._lastDist = 0

	arg_1_0:init()

	return
end

function var_0_9.UpdateMotion(arg_2_0)
	if arg_2_0._motionReferenceUnit then
		local var_2_0 = arg_2_0._motionVO

		var_1.UpdatePos(var_2_0, arg_2_0._motionReferenceUnit)

		local var_2_1 = arg_2_0._motionVO

		var_1.UpdateVelocityAndDirection(var_2_1, arg_2_0:GetFleetVelocity(), arg_2_0._motionSourceFunc())
	end

	math = var_1

	local var_2_2 = var_1.max
	local var_2_3 = arg_2_0._motionVO

	if var_2_2(var_2.GetPos(var_2_3).x - arg_2_0._rightBound, 0) >= 0 and var_1 ~= arg_2_0._lastDist then
		arg_2_0._lastDist = var_1

		arg_2_0:DispatchEvent(var_0.Event.New(var_0_2.SHOW_BUFFER, {
			dist = var_1
		}))
	end

	return
end

function var_0_9.UpdateAutoComponent(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0._scoutList) do
		iter_3_1:UpdateWeapon(arg_3_1)
		iter_3_1:UpdateAirAssist()
	end

	ipairs = var_2

	for iter_3_2, iter_3_3 in var_2(arg_3_0._mainList) do
		iter_3_3:UpdateWeapon(arg_3_1)
		iter_3_3:UpdateAirAssist()
	end

	ipairs = var_2

	for iter_3_4, iter_3_5 in var_2(arg_3_0._cloakList) do
		iter_3_5:UpdateCloak(arg_3_1)
	end

	ipairs = var_2

	for iter_3_6, iter_3_7 in var_2(arg_3_0._subList) do
		iter_3_7:UpdateWeapon(arg_3_1)
		iter_3_7:UpdateOxygen(arg_3_1)
		iter_3_7:UpdatePhaseSwitcher()
	end

	ipairs = var_2

	for iter_3_8, iter_3_9 in var_2(arg_3_0._manualSubList) do
		iter_3_9:UpdateOxygen(arg_3_1)
	end

	local var_3_0 = arg_3_0._fleetAntiAir

	var_2.Update(var_3_0, arg_3_1)

	local var_3_1 = arg_3_0._fleetRangeAntiAir

	var_2.Update(var_3_1, arg_3_1)

	local var_3_2 = arg_3_0._fleetStaticSonar

	var_2.Update(var_3_2, arg_3_1)

	pairs = var_2

	for iter_3_10, iter_3_11 in var_2(arg_3_0._indieSonarList) do
		iter_3_10:Update(arg_3_1)
	end

	arg_3_0:UpdateBuff(arg_3_1)

	return
end

function var_0_9.UpdateBuff(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._buffList

	pairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(var_4_0) do
		iter_4_1:Update(arg_4_0, arg_4_1)
	end

	return
end

function var_0_9.UpdateManualWeaponVO(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._chargeWeaponVO

	var_2.Update(var_5_0, arg_5_1)

	local var_5_1 = arg_5_0._torpedoWeaponVO

	var_2.Update(var_5_1, arg_5_1)

	local var_5_2 = arg_5_0._airAssistVO

	var_2.Update(var_5_2, arg_5_1)

	local var_5_3 = arg_5_0._submarineDiveVO

	var_2.Update(var_5_3, arg_5_1)

	local var_5_4 = arg_5_0._submarineFloatVO

	var_2.Update(var_5_4, arg_5_1)

	local var_5_5 = arg_5_0._submarineBoostVO

	var_2.Update(var_5_5, arg_5_1)

	local var_5_6 = arg_5_0._submarineShiftVO

	var_2.Update(var_5_6, arg_5_1)

	return
end

function var_0_9.UpdateFleetDamage(arg_6_0, arg_6_1)
	local var_6_0 = var_0_3.CalculateFleetDamage(arg_6_1)

	arg_6_0._currentDMGRatio = arg_6_0._currentDMGRatio + var_6_0

	arg_6_0:DispatchFleetDamageChange()

	return
end

function var_0_9.UpdateFleetOverDamage(arg_7_0, arg_7_1)
	local var_7_0 = var_0_3.CalculateFleetOverDamage(arg_7_0, arg_7_1)

	arg_7_0._currentDMGRatio = arg_7_0._currentDMGRatio - var_7_0

	arg_7_0:DispatchFleetDamageChange()

	return
end

function var_0_9.DispatchFleetDamageChange(arg_8_0)
	arg_8_0:DispatchEvent(var_0.Event.New(var_0_2.FLEET_DMG_CHANGE, {}))

	return
end

function var_0_9.DispatchSonarScan(arg_9_0, arg_9_1)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_2.SONAR_SCAN, {
		indieSonar = arg_9_1
	}))

	return
end

function var_0_9.FreeMainUnit(arg_10_0, arg_10_1)
	if arg_10_0._mainUnitFree then
		return
	end

	arg_10_0._mainUnitFree = true
	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_0._mainList) do
		local var_10_0 = var_0.Battle.BattleBuffUnit.New(arg_10_1)

		iter_10_1:AddBuff(var_10_0)
		iter_10_1:SetMainUnitStatic(false)
	end

	return
end

function var_0_9.RandomMainVictim(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or {}

	local var_11_0 = {}
	local var_11_1

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_0._mainList) do
		local var_11_2 = true

		ipairs = var_1_10010

		for iter_11_2, iter_11_3 in var_1_10010(arg_11_1) do
			if iter_11_1:GetAttrByName(iter_11_3) == 1 then
				var_11_2 = false

				break
			end
		end

		if var_11_2 then
			table = var_1_10010

			var_1_10010.insert(var_11_0, iter_11_1)
		end
	end

	if #var_11_0 > 0 then
		math = var_4
		var_11_1 = var_11_0[var_4.random(#var_11_0)]
	end

	return var_11_1
end

function var_0_9.NearestUnitByType(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 999
	local var_12_1

	ipairs = var_1_10005

	for iter_12_0, iter_12_1 in var_1_10005(arg_12_0._unitList) do
		local var_12_2 = iter_12_1
		local var_12_3 = iter_12_1.GetTemplate(var_12_2).type

		table = var_12_2

		if var_12_2.contains(arg_12_2, var_12_3) then
			local var_12_4 = iter_12_1
			local var_12_5 = iter_12_1.GetPosition(var_12_4)

			Vector3 = var_12_4

			if var_12_4.BattleDistance(var_12_5, arg_12_1) < var_12_0 then
				var_12_0 = var_12
				var_12_1 = iter_12_1
			end
		end
	end

	return var_12_1
end

function var_0_9.SetMotionSource(arg_13_0, arg_13_1)
	if arg_13_1 == nil then
		function arg_13_0._motionSourceFunc()
			pg = var_2_10000

			return var_2_10000.UIMgr.GetInstance().hrz, var_0.vtc
		end
	else
		arg_13_0._motionSourceFunc = arg_13_1
	end

	return
end

function var_0_9.SetSubAidData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._submarineVO = var_0.Battle.BattleSubmarineAidVO.New()

	if arg_15_2 == var_0_4.SubAidFlag.AID_EMPTY or arg_15_2 == var_0_4.SubAidFlag.OIL_EMPTY then
		local var_15_0 = arg_15_0._submarineVO

		var_3.SetUseable(var_15_0, false)
	else
		local var_15_1 = arg_15_0._submarineVO

		var_3.SetCount(var_15_1, arg_15_2)

		local var_15_2 = arg_15_0._submarineVO

		var_3.SetTotal(var_15_2, arg_15_1)

		local var_15_3 = arg_15_0._submarineVO

		var_3.SetUseable(var_15_3, true)
	end

	return
end

function var_0_9.SetBound(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_0._upperBound = arg_16_1
	arg_16_0._lowerBound = arg_16_2
	arg_16_0._leftBound = arg_16_3
	arg_16_0._rightBound = arg_16_4

	return
end

function var_0_9.SetTotalBound(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	arg_17_0._totalUpperBound = arg_17_1
	arg_17_0._totalLowerBound = arg_17_2
	arg_17_0._totalLeftBound = arg_17_3
	arg_17_0._totalRightBound = arg_17_4

	return
end

function var_0_9.CalcSubmarineBaseLine(arg_18_0, arg_18_1)
	local var_18_0 = (arg_18_0._totalRightBound + arg_18_0._totalLeftBound) * 0.5

	if arg_18_0._IFF == var_0_5.FRIENDLY_CODE then
		SYSTEM_DUEL = var_3

		if arg_18_1 == var_3 then
			-- block empty
		else
			arg_18_0._subAttackBaseLine = var_18_0
			arg_18_0._subRetreatBaseLine = arg_18_0._leftBound - 10
		end
	elseif arg_18_0._IFF == var_0_5.FOE_CODE then
		SYSTEM_DUEL = var_3

		if arg_18_1 == var_3 then
			-- block empty
		end
	end

	return
end

function var_0_9.SetExposeLine(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._visionLineX = arg_19_1
	arg_19_0._exposeLineX = arg_19_2

	return
end

function var_0_9.AppendPlayerUnit(arg_20_0, arg_20_1)
	arg_20_0._unitList[#arg_20_0._unitList + 1] = arg_20_1
	arg_20_0._maxCount = arg_20_0._maxCount + 1

	if arg_20_1:IsMainFleetUnit() then
		arg_20_0:appendMainUnit(arg_20_1)
	else
		arg_20_0:appendScoutUnit(arg_20_1)
	end

	arg_20_1:SetFleetVO(arg_20_0)
	arg_20_1:SetMotion(arg_20_0._motionVO)
	arg_20_1:RegisterEventListener(arg_20_0, var_0_1.UPDATE_HP, arg_20_0.onUnitUpdateHP)

	return
end

function var_0_9.RemovePlayerUnit(arg_21_0, arg_21_1)
	local var_21_0 = {}

	ipairs = var_1_10003

	for iter_21_0, iter_21_1 in var_1_10003(arg_21_0._unitList) do
		if iter_21_1 ~= arg_21_1 then
			var_21_0[#var_21_0 + 1] = iter_21_0
		else
			iter_21_1:UnregisterEventListener(arg_21_0, var_0_1.UPDATE_HP)
			iter_21_1:DeactiveCldBox()

			local var_21_1 = iter_21_1

			var_1_10008 = iter_21_1.GetChargeList(var_21_1)
			ipairs = var_21_1

			for iter_21_2, iter_21_3 in var_21_1(var_1_10008) do
				if iter_21_3:IsAttacking() then
					local var_21_2 = arg_21_0._chargeWeaponVO

					var_14.CancelFocus(var_21_2)

					local var_21_3 = arg_21_0._chargeWeaponVO

					var_14.ResetFocus(var_21_3)
					arg_21_0:CancelChargeWeapon()
				end

				local var_21_4 = arg_21_0._chargeWeaponVO

				var_14.RemoveWeapon(var_21_4, iter_21_3)
				iter_21_3:Clear()
			end

			local var_21_5 = arg_21_0._fleetAntiAir

			var_9.RemoveCrewUnit(var_21_5, arg_21_1)

			local var_21_6 = arg_21_0._fleetRangeAntiAir

			var_9.RemoveCrewUnit(var_21_6, arg_21_1)

			local var_21_7 = arg_21_0._fleetStaticSonar

			var_9.RemoveCrewUnit(var_21_7, arg_21_1)

			local var_21_8 = iter_21_1
			local var_21_9 = iter_21_1.GetTorpedoList(var_21_8)

			ipairs = var_21_8

			for iter_21_4, iter_21_5 in var_21_8(var_21_9) do
				arg_21_0:RemoveManunalTorpedo(iter_21_5)
			end

			local var_21_10 = iter_21_1

			if iter_21_1.GetAirAssistList(var_21_10) then
				ipairs = var_21_10

				for iter_21_6, iter_21_7 in var_21_10(var_10) do
					local var_21_11 = arg_21_0._airAssistVO

					var_16.RemoveWeapon(var_21_11, iter_21_7)
				end
			end
		end
	end

	ipairs = var_3

	for iter_21_8, iter_21_9 in var_3(arg_21_0._scoutList) do
		if iter_21_9 == arg_21_1 then
			if #arg_21_0._scoutList == 1 then
				arg_21_0:CancelChargeWeapon()
			end

			table = var_1_10008

			var_1_10008.remove(arg_21_0._scoutList, iter_21_8)

			break
		end
	end

	ipairs = var_3

	for iter_21_10, iter_21_11 in var_3(arg_21_0._mainList) do
		if iter_21_11 == arg_21_1 then
			table = var_1_10008

			var_1_10008.remove(arg_21_0._mainList, iter_21_10)

			break
		end
	end

	ipairs = var_3

	for iter_21_12, iter_21_13 in var_3(arg_21_0._cloakList) do
		if iter_21_13 == arg_21_1 then
			table = var_1_10008

			var_1_10008.remove(arg_21_0._cloakList, iter_21_12)

			break
		end
	end

	ipairs = var_3

	local var_21_12 = arg_21_0._subList

	i = var_5

	for iter_21_14, iter_21_15 in var_3(var_21_12, var_5) do
		if iter_21_15 == arg_21_1 then
			table = var_1_10008

			var_1_10008.remove(arg_21_0._subList, iter_21_14)

			break
		end
	end

	ipairs = var_3

	for iter_21_16, iter_21_17 in var_3(arg_21_0._manualSubList) do
		if iter_21_17 == arg_21_1 then
			table = var_1_10008

			var_1_10008.remove(arg_21_0._manualSubList, iter_21_16)

			break
		end
	end

	if not arg_21_0._manualSubUnit then
		arg_21_0:refreshFleetFormation(var_21_0)
	end

	return
end

function var_0_9.OverrideJoyStickAutoBot(arg_22_0, arg_22_1)
	arg_22_0._autoBotAIID = arg_22_1

	local var_22_0 = var_0.Event.New(var_0.Battle.BattleEvent.OVERRIDE_AUTO_BOT)

	arg_22_0:DispatchEvent(var_22_0)

	return
end

function var_0_9.SnapShot(arg_23_0)
	arg_23_0._totalDMGRatio = var_0_3.GetFleetTotalHP(arg_23_0)
	arg_23_0._currentDMGRatio = arg_23_0._totalDMGRatio

	return
end

function var_0_9.GetIFF(arg_24_0)
	return arg_24_0._IFF
end

function var_0_9.GetMaxCount(arg_25_0)
	return arg_25_0._maxCount
end

function var_0_9.GetFlagShip(arg_26_0)
	return arg_26_0._flagShip
end

function var_0_9.GetLeaderShip(arg_27_0)
	return arg_27_0._scoutList[1]
end

function var_0_9.GetUnitList(arg_28_0)
	return arg_28_0._unitList
end

function var_0_9.GetMainList(arg_29_0)
	return arg_29_0._mainList
end

function var_0_9.GetScoutList(arg_30_0)
	return arg_30_0._scoutList
end

function var_0_9.GetCloakList(arg_31_0)
	return arg_31_0._cloakList
end

function var_0_9.GetSubBench(arg_32_0)
	return arg_32_0._manualSubBench
end

function var_0_9.GetMotion(arg_33_0)
	return arg_33_0._motionVO
end

function var_0_9.GetMotionReferenceUnit(arg_34_0)
	return arg_34_0._motionReferenceUnit
end

function var_0_9.GetAutoBotAIID(arg_35_0)
	return arg_35_0._autoBotAIID
end

function var_0_9.GetChargeWeaponVO(arg_36_0)
	return arg_36_0._chargeWeaponVO
end

function var_0_9.GetTorpedoWeaponVO(arg_37_0)
	return arg_37_0._torpedoWeaponVO
end

function var_0_9.GetAirAssistVO(arg_38_0)
	return arg_38_0._airAssistVO
end

function var_0_9.GetSubAidVO(arg_39_0)
	return arg_39_0._submarineVO
end

function var_0_9.GetSubFreeDiveVO(arg_40_0)
	return arg_40_0._submarineDiveVO
end

function var_0_9.GetSubFreeFloatVO(arg_41_0)
	return arg_41_0._submarineFloatVO
end

function var_0_9.GetSubBoostVO(arg_42_0)
	return arg_42_0._submarineBoostVO
end

function var_0_9.GetSubSpecialVO(arg_43_0)
	return arg_43_0._submarineSpecialVO
end

function var_0_9.GetSubShiftVO(arg_44_0)
	return arg_44_0._submarineShiftVO
end

function var_0_9.GetFleetAntiAirWeapon(arg_45_0)
	return arg_45_0._fleetAntiAir
end

function var_0_9.GetFleetRangeAntiAirWeapon(arg_46_0)
	return arg_46_0._fleetRangeAntiAir
end

function var_0_9.GetFleetVelocity(arg_47_0)
	return var_0_3.GetFleetVelocity(arg_47_0._scoutList)
end

function var_0_9.GetFleetBound(arg_48_0)
	return arg_48_0._upperBound, arg_48_0._lowerBound, arg_48_0._leftBound, arg_48_0._rightBound
end

function var_0_9.GetFleetExposeLine(arg_49_0)
	return arg_49_0._exposeLineX
end

function var_0_9.GetFleetVisionLine(arg_50_0)
	return arg_50_0._visionLineX
end

function var_0_9.GetLeaderPersonality(arg_51_0)
	local var_51_0 = arg_51_0._motionReferenceUnit

	return var_1.GetAutoPilotPreference(var_51_0)
end

function var_0_9.GetDamageRatioResult(arg_52_0)
	string = var_1_10001

	return var_1_10001.format("%0.2f", arg_52_0._currentDMGRatio / arg_52_0._totalDMGRatio * 100), arg_52_0._totalDMGRatio
end

function var_0_9.GetDamageRatio(arg_53_0)
	return arg_53_0._currentDMGRatio / arg_53_0._totalDMGRatio
end

function var_0_9.GetSubmarineBaseLine(arg_54_0)
	return arg_54_0._subAttackBaseLine, arg_54_0._subRetreatBaseLine
end

function var_0_9.GetFleetSonar(arg_55_0)
	return arg_55_0._fleetStaticSonar
end

function var_0_9.Dispose(arg_56_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_56_0)
	var_0.EventListener.DetachEventListener(arg_56_0)

	arg_56_0._leaderUnit = nil

	local var_56_0 = arg_56_0._fleetAntiAir

	var_1.Dispose(var_56_0)

	local var_56_1 = arg_56_0._fleetRangeAntiAir

	var_1.Dispose(var_56_1)

	local var_56_2 = arg_56_0._fleetStaticSonar

	var_1.Dispose(var_56_2)

	arg_56_0._fleetStaticSonar = nil
	arg_56_0._buffList = nil
	arg_56_0._indieSonarList = nil
	arg_56_0._scoutAimBias = nil

	return
end

function var_0_9.refreshFleetFormation(arg_57_0, arg_57_1)
	local var_57_0 = var_0_7.GetFormationTmpDataFromID(var_0_5.FORMATION_ID).pos_offset

	arg_57_0._unitList = var_0_7.SortFleetList(arg_57_1, arg_57_0._unitList)

	local var_57_1 = var_0_5.BornOffset

	if not arg_57_0._mainUnitFree then
		ipairs = var_4

		for iter_57_0, iter_57_1 in var_4(arg_57_0._unitList) do
			table = var_1_10009

			if not var_1_10009.contains(arg_57_0._subList, iter_57_1) then
				var_1_10009 = var_57_0[iter_57_0]

				local var_57_2 = iter_57_1
				local var_57_3 = iter_57_1.UpdateFormationOffset

				Vector3 = var_1_10012

				var_57_3(var_57_2, var_1_10012(var_1_10009.x, var_1_10009.y, var_1_10009.z) + var_57_1 * (iter_57_0 - 1))
			end
		end
	end

	if #arg_57_0._scoutList > 0 then
		arg_57_0._motionReferenceUnit = arg_57_0._scoutList[1]
		arg_57_0._leaderUnit = arg_57_0._scoutList[1]

		local var_57_4 = arg_57_0._leaderUnit

		var_4.LeaderSetting(var_57_4)

		local var_57_5 = arg_57_0._fleetAntiAir

		var_4.SwitchHost(var_57_5, arg_57_0._motionReferenceUnit)

		local var_57_6 = arg_57_0._fleetStaticSonar

		var_4.SwitchHost(var_57_6, arg_57_0._motionReferenceUnit)

		pairs = var_4

		for iter_57_2, iter_57_3 in var_4(arg_57_0._indieSonarList) do
			iter_57_2:SwitchHost(arg_57_0._motionReferenceUnit)
		end

		local var_57_7 = arg_57_0._motionVO

		var_4.UpdatePos(var_57_7, arg_57_0._motionReferenceUnit)
	else
		local var_57_8 = arg_57_0._fleetAntiAir

		if var_4.GetCurrentState(var_57_8) ~= arg_57_0._fleetAntiAir.STATE_DISABLE then
			local var_57_9 = arg_57_0._fleetAntiAir
			local var_57_10 = var_4.GetCrewUnitList(var_57_9)

			pairs = var_57_9

			for iter_57_4, iter_57_5 in var_57_9(var_57_10) do
				arg_57_0._motionReferenceUnit = iter_57_4

				local var_57_11 = arg_57_0._fleetAntiAir

				var_10.SwitchHost(var_57_11, iter_57_4)

				break
			end
		else
			arg_57_0._motionReferenceUnit = arg_57_0._mainList[1]
			arg_57_0._leaderUnit = nil
		end
	end

	if #arg_57_0:GetUnitList() == 0 then
		return
	end

	local var_57_12 = var_0.Event.New(var_0.Battle.BattleEvent.REFRESH_FLEET_FORMATION)

	arg_57_0:DispatchEvent(var_57_12)

	return
end

function var_0_9.init(arg_58_0)
	arg_58_0._chargeWeaponVO = var_0.Battle.BattleChargeWeaponVO.New()
	arg_58_0._torpedoWeaponVO = var_0.Battle.BattleTorpedoWeaponVO.New()
	arg_58_0._airAssistVO = var_0.Battle.BattleAllInStrikeVO.New()
	arg_58_0._submarineDiveVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.DIVE_CD)
	arg_58_0._submarineFloatVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.FLOAT_CD)
	arg_58_0._submarineVOList = {
		arg_58_0._submarineDiveVO,
		arg_58_0._submarineFloatVO
	}
	arg_58_0._submarineBoostVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.BOOST_CD)
	arg_58_0._submarineShiftVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.SHIFT_CD)
	arg_58_0._submarineSpecialVO = var_0.Battle.BattleSubmarineAidVO.New()

	local var_58_0 = arg_58_0._submarineSpecialVO

	var_1.SetCount(var_58_0, 1)

	local var_58_1 = arg_58_0._submarineSpecialVO

	var_1.SetTotal(var_58_1, 1)

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

function var_0_9.appendScoutUnit(arg_59_0, arg_59_1)
	arg_59_0._scoutList[#arg_59_0._scoutList + 1] = arg_59_1

	local var_59_0 = arg_59_1
	local var_59_1 = arg_59_1.GetTorpedoList(var_59_0)

	ipairs = var_59_0

	for iter_59_0, iter_59_1 in var_59_0(var_59_1) do
		local var_59_2 = arg_59_0._torpedoWeaponVO

		var_8.AppendWeapon(var_59_2, iter_59_1)
	end

	if #arg_59_1:GetHiveList() > 0 then
		local var_59_3 = var_0_7.CreateAllInStrike(arg_59_1)

		ipairs = var_5

		for iter_59_2, iter_59_3 in var_5(var_59_3) do
			local var_59_4 = arg_59_0._airAssistVO

			var_10.AppendWeapon(var_59_4, iter_59_3)
		end

		arg_59_1:SetAirAssistList(var_59_3)
	end

	local var_59_5 = arg_59_0._fleetAntiAir

	var_4.AppendCrewUnit(var_59_5, arg_59_1)

	local var_59_6 = arg_59_0._fleetStaticSonar

	var_4.AppendCrewUnit(var_59_6, arg_59_1)

	local var_59_7 = 1
	local var_59_8 = #arg_59_0._unitList
	local var_59_9 = {}

	while var_59_7 < var_59_8 do
		table = iter_59_1

		iter_59_1.insert(var_59_9, var_59_7)

		var_59_7 = var_59_7 + 1
	end

	table = iter_59_1

	iter_59_1.insert(var_59_9, #arg_59_0._scoutList, var_59_7)
	arg_59_0:refreshFleetFormation(var_59_9)

	return
end

function var_0_9.appendMainUnit(arg_60_0, arg_60_1)
	if #arg_60_0._mainList == 0 then
		arg_60_0._flagShip = arg_60_1
	end

	arg_60_0._mainList[#arg_60_0._mainList + 1] = arg_60_1

	arg_60_1:SetMainUnitIndex(#arg_60_0._mainList)

	ShipType = var_2

	if var_2.CloakShipType(arg_60_1:GetTemplate().type) then
		arg_60_0:AttachCloak(arg_60_1)
	end

	local var_60_0 = arg_60_1
	local var_60_1 = arg_60_1.GetChargeList(var_60_0)

	ipairs = var_60_0

	for iter_60_0, iter_60_1 in var_60_0(var_60_1) do
		local var_60_2 = arg_60_0._chargeWeaponVO

		var_8.AppendWeapon(var_60_2, iter_60_1)
	end

	local var_60_3 = arg_60_1
	local var_60_4 = arg_60_1.GetTorpedoList(var_60_3)

	ipairs = var_60_3

	for iter_60_2, iter_60_3 in var_60_3(var_60_4) do
		local var_60_5 = arg_60_0._torpedoWeaponVO

		var_9.AppendWeapon(var_60_5, iter_60_3)
	end

	if #arg_60_1:GetHiveList() > 0 then
		local var_60_6 = var_0_7.CreateAllInStrike(arg_60_1)

		ipairs = var_6

		for iter_60_4, iter_60_5 in var_6(var_60_6) do
			local var_60_7 = arg_60_0._airAssistVO

			var_1_10011.AppendWeapon(var_60_7, iter_60_5)
		end

		arg_60_1:SetAirAssistList(var_60_6)
	end

	local var_60_8 = arg_60_0._fleetAntiAir

	var_5.AppendCrewUnit(var_60_8, arg_60_1)

	local var_60_9 = arg_60_0._fleetRangeAntiAir

	var_5.AppendCrewUnit(var_60_9, arg_60_1)

	local var_60_10 = arg_60_0._fleetStaticSonar

	var_5.AppendCrewUnit(var_60_10, arg_60_1)

	local var_60_11 = {}

	ipairs = var_60_10

	for iter_60_6, iter_60_7 in var_60_10(arg_60_0._unitList) do
		table = var_1_10011

		var_1_10011.insert(var_60_11, iter_60_6)
	end

	arg_60_0:refreshFleetFormation(var_60_11)

	return
end

function var_0_9.appendSubUnit(arg_61_0, arg_61_1)
	arg_61_0._subList[#arg_61_0._subList + 1] = arg_61_1

	arg_61_1:SetMainUnitIndex(#arg_61_0._subList)

	return
end

function var_0_9.FleetWarcry(arg_62_0)
	local var_62_0

	math = var_1_10002

	local var_62_1 = var_1_10002.random(0, 1)
	local var_62_2 = arg_62_0:GetScoutList()[1]

	if arg_62_0:GetMainList()[1] == nil or var_62_1 == 0 then
		var_62_0 = var_62_2
	elseif var_62_1 == 1 then
		var_62_0 = var_4
	end

	local var_62_3 = "battle"
	local var_62_4 = var_62_0:GetIntimacy()
	local var_62_5 = var_0.Battle.BattleDataFunction.GetWords(var_62_0:GetSkinID(), var_62_3, var_62_4)

	var_62_0:DispatchVoice(var_62_3)
	var_62_0:DispatchChat(var_62_5, 2.5, var_62_3)

	return
end

function var_0_9.FleetUnitSpwanFinish(arg_63_0)
	local var_63_0 = 0

	ipairs = var_1_10002

	for iter_63_0, iter_63_1 in var_1_10002(arg_63_0._unitList) do
		var_63_0 = var_63_0 + iter_63_1:GetGearScore()
	end

	ipairs = var_2

	for iter_63_2, iter_63_3 in var_2(arg_63_0._unitList) do
		var_0_8.SetCurrent(iter_63_3, "fleetGS", var_63_0)
	end

	return
end

function var_0_9.SubWarcry(arg_64_0)
	local var_64_0 = arg_64_0:GetSubList()[1]
	local var_64_1 = "battle"
	local var_64_2 = var_64_0:GetIntimacy()
	local var_64_3 = var_0.Battle.BattleDataFunction.GetWords(var_64_0:GetSkinID(), var_64_1, var_64_2)

	var_64_0:DispatchVoice(var_64_1)
	var_64_0:DispatchChat(var_64_3, 2.5, var_64_1)

	return
end

function var_0_9.SetWeaponBlock(arg_65_0, arg_65_1)
	arg_65_0._blockCast = arg_65_0._blockCast + arg_65_1

	return
end

function var_0_9.GetWeaponBlock(arg_66_0)
	return arg_66_0._blockCast > 0
end

function var_0_9.CastChargeWeapon(arg_67_0)
	if arg_67_0:GetWeaponBlock() then
		return
	end

	local var_67_0 = arg_67_0._chargeWeaponVO

	if var_1.GetCurrentWeapon(var_67_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_READY then
		var_1:Charge()

		local var_67_1 = {}
		local var_67_2 = var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CHARGE, var_67_1)

		arg_67_0:DispatchEvent(var_67_2)
	end

	return
end

function var_0_9.CancelChargeWeapon(arg_68_0)
	local var_68_0 = arg_68_0._chargeWeaponVO

	if var_1.GetCurrentWeapon(var_68_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_PRECAST then
		local var_68_1 = {}
		local var_68_2 = var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, var_68_1)

		arg_68_0:DispatchEvent(var_68_2)
		var_1:CancelCharge()
	end

	return
end

function var_0_9.UnleashChrageWeapon(arg_69_0)
	if arg_69_0:GetWeaponBlock() then
		arg_69_0:CancelChargeWeapon()

		return
	end

	local var_69_0 = arg_69_0._chargeWeaponVO

	if var_1.GetCurrentWeapon(var_69_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_PRECAST then
		if var_1:IsStrikeMode() then
			local var_69_1 = arg_69_0._motionVO
			local var_69_2 = var_2.GetPos(var_69_1).x + var_0_5.ChargeWeaponConfig.SIGHT_C

			math = var_3

			local var_69_3 = var_3.min(var_69_2, arg_69_0._totalRightBound)
			local var_69_4 = arg_69_0
			local var_69_5 = arg_69_0.fireChargeWeapon
			local var_69_6 = var_1
			local var_69_7 = true

			Vector3 = var_1_10007

			local var_69_8 = var_1_10007.New
			local var_69_9 = var_69_3
			local var_69_10 = 0
			local var_69_11 = arg_69_0._motionVO

			var_69_5(var_69_4, var_69_6, var_69_7, var_69_8(var_69_9, var_69_10, var_10.GetPos(var_69_11).z))
		else
			var_1:CancelCharge()
		end

		local var_69_12 = {}
		local var_69_13 = var_0.Event.New(var_0.Battle.BattleUnitEvent.POINT_HIT_CANCEL, var_69_12)

		arg_69_0:DispatchEvent(var_69_13)
	end

	return
end

function var_0_9.QuickTagChrageWeapon(arg_70_0, arg_70_1)
	if arg_70_0:GetWeaponBlock() then
		return
	end

	local var_70_0 = arg_70_0._chargeWeaponVO

	if var_2.GetCurrentWeapon(var_70_0) ~= nil and var_2:GetCurrentState() == var_2.STATE_READY then
		var_2:QuickTag()

		if #var_2:GetLockList() <= 0 then
			var_2:CancelQuickTag()
		else
			arg_70_0:fireChargeWeapon(var_2, arg_70_1)
		end
	end

	return
end

function var_0_9.fireChargeWeapon(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	local var_71_0 = arg_71_1:GetHost()

	local function var_71_1()
		local function var_72_0()
			local var_73_0 = arg_71_1

			var_0.Fire(var_73_0, arg_71_3)

			return
		end

		local var_72_1 = arg_71_1

		var_1.DispatchBlink(var_72_1, var_72_0)

		return
	end

	if arg_71_2 then
		if arg_71_0._IFF == var_0_5.FRIENDLY_CODE then
			local var_71_2 = arg_71_0._chargeWeaponVO

			var_6.PlayCutIn(var_71_2, var_71_0, 1 / var_0_5.FOCUS_MAP_RATE)
		end

		local var_71_3 = arg_71_0._chargeWeaponVO

		var_6.PlayFocus(var_71_3, var_71_0, var_71_1)
	else
		if arg_71_0._IFF == var_0_5.FRIENDLY_CODE then
			local var_71_4 = arg_71_0._chargeWeaponVO

			var_6.PlayCutIn(var_71_4, var_71_0, 1)
		end

		var_71_1()
	end

	return
end

function var_0_9.UnleashAllInStrike(arg_74_0)
	if arg_74_0:GetWeaponBlock() then
		return
	end

	local var_74_0 = arg_74_0._airAssistVO

	if var_1.GetCurrentWeapon(var_74_0) and var_1:GetCurrentState() == var_1.STATE_READY then
		local var_74_1 = var_1:GetHost()

		if arg_74_0._IFF == var_0_5.FRIENDLY_CODE and var_74_1:IsMainFleetUnit() then
			local var_74_2 = arg_74_0._airAssistVO

			var_3.PlayCutIn(var_74_2, var_74_1, 1)
		end

		var_1:CLSBullet()
		var_1:DispatchBlink()
		var_1:Fire()
	end

	return
end

function var_0_9.CastTorpedo(arg_75_0)
	if arg_75_0:GetWeaponBlock() then
		return
	end

	local var_75_0 = arg_75_0._torpedoWeaponVO

	if var_1.GetCurrentWeapon(var_75_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_READY then
		var_1:Prepar()
	end

	return
end

function var_0_9.CancelTorpedo(arg_76_0)
	local var_76_0 = arg_76_0._torpedoWeaponVO

	if var_1.GetCurrentWeapon(var_76_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_PRECAST then
		var_1:Cancel()
	end

	return
end

function var_0_9.UnleashTorpedo(arg_77_0)
	if arg_77_0:GetWeaponBlock() then
		arg_77_0:CancelTorpedo()

		return
	end

	local var_77_0 = arg_77_0._torpedoWeaponVO

	if var_1.GetCurrentWeapon(var_77_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_PRECAST then
		var_1:Fire()
	end

	return
end

function var_0_9.QuickCastTorpedo(arg_78_0)
	if arg_78_0:GetWeaponBlock() then
		return
	end

	local var_78_0 = arg_78_0._torpedoWeaponVO

	if var_1.GetCurrentWeapon(var_78_0) ~= nil and var_1:GetCurrentState() == var_1.STATE_READY then
		var_1:Fire(true)
	end

	return
end

function var_0_9.RemoveManunalTorpedo(arg_79_0, arg_79_1)
	if arg_79_1:IsAttacking() then
		arg_79_0:CancelTorpedo()
	end

	local var_79_0 = arg_79_0._torpedoWeaponVO

	var_2.RemoveWeapon(var_79_0, arg_79_1)
	arg_79_1:Clear()

	return
end

function var_0_9.CoupleEncourage(arg_80_0)
	local var_80_0 = {}
	local var_80_1 = {}

	ipairs = var_1_10003

	for iter_80_0, iter_80_1 in var_1_10003(arg_80_0._unitList) do
		local var_80_2 = iter_80_1:GetIntimacy()
		local var_80_3 = var_0_7.GetWords

		var_1_10011 = iter_80_1

		local var_80_4 = #var_80_3(iter_80_1.GetSkinID(var_1_10011), "couple_encourage", var_80_2)

		if 0 < var_80_4 then
			var_80_0[iter_80_1] = var_9
		end
	end

	local var_80_5 = var_0_4.CPChatType
	local var_80_6 = var_0_4.CPChatTargetFunc

	local function var_80_7(arg_81_0, arg_81_1)
		local var_81_0 = {}

		if arg_81_0 == var_80_5.GROUP_ID then
			var_81_0.groupIDList = arg_81_1
		elseif arg_81_0 == var_80_5.SHIP_TYPE then
			var_81_0.ship_type_list = arg_81_1
		elseif arg_81_0 == var_80_5.RARE then
			var_81_0.rarity = arg_81_1[1]
		elseif arg_81_0 == var_80_5.NATIONALITY then
			var_81_0.nationality = arg_81_1[1]
		elseif arg_81_0 == var_80_5.ILLUSTRATOR then
			var_81_0.illustrator = arg_81_1[1]
		elseif arg_81_0 == var_80_5.TEAM then
			var_81_0.teamIndex = arg_81_1[1]
		end

		return var_81_0
	end

	pairs = iter_80_0

	for iter_80_2, iter_80_3 in iter_80_0(var_80_0) do
		ipairs = var_1_10011

		for iter_80_4, iter_80_5 in var_1_10011(iter_80_3) do
			local var_80_8 = iter_80_5[1]
			local var_80_9 = iter_80_5[2]
			local var_80_10

			if not iter_80_5[4] then
				var_80_10 = var_80_5.GROUP_ID
			end

			local var_80_11 = var_0.Battle.BattleTargetChoise.TargetAllHelp(iter_80_2)

			type = var_20

			if var_20(var_80_10) == "table" then
				ipairs = var_20

				for iter_80_6, iter_80_7 in var_20(var_80_10) do
					local var_80_12 = var_80_7(iter_80_7, var_80_8[iter_80_6])

					var_80_11 = var_0.Battle.BattleTargetChoise[var_80_6[iter_80_7]](iter_80_2, var_80_12, var_80_11)
				end
			else
				type = var_20

				if var_20(var_80_10) == "number" then
					local var_80_13 = var_80_7(var_80_10, var_80_8)

					var_80_11 = var_0.Battle.BattleTargetChoise[var_80_6[var_80_10]](iter_80_2, var_80_13, var_80_11)
				end
			end

			if var_80_9 <= #var_80_11 then
				local var_80_14 = {
					cp = iter_80_2,
					content = iter_80_5[3],
					linkIndex = iter_80_4
				}

				var_80_1[#var_80_1 + 1] = var_80_14
			end
		end
	end

	if #var_80_1 > 0 then
		math = var_6

		local var_80_15 = var_80_1[var_6.random(#var_80_1)]
		local var_80_16 = "link" .. var_80_15.linkIndex
		local var_80_17 = var_80_15.cp

		var_9.DispatchVoice(var_80_17, var_80_16)

		local var_80_18 = var_80_15.cp

		var_9.DispatchChat(var_80_18, var_80_15.content, 3, var_80_16)
	end

	return
end

function var_0_9.onUnitUpdateHP(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_1.Dispatcher
	local var_82_1 = arg_82_1.Data.dHP

	ipairs = var_1_10004

	for iter_82_0, iter_82_1 in var_1_10004(arg_82_0._unitList) do
		iter_82_1:TriggerBuff(var_0_4.BuffEffectType.ON_FRIENDLY_HP_RATIO_UPDATE, {
			unit = var_82_0,
			dHP = var_82_1
		})

		if iter_82_1 ~= var_82_0 then
			iter_82_1:TriggerBuff(var_0_4.BuffEffectType.ON_TEAMMATE_HP_RATIO_UPDATE, {
				unit = var_82_0,
				dHP = var_82_1
			})
		end
	end

	return
end

function var_0_9.SetSubUnitData(arg_83_0, arg_83_1)
	arg_83_0._subUntiDataList = arg_83_1

	return
end

function var_0_9.GetSubUnitData(arg_84_0)
	return arg_84_0._subUntiDataList
end

function var_0_9.AddSubMarine(arg_85_0, arg_85_1)
	arg_85_1:InitOxygen()

	local var_85_0 = arg_85_1:GetTemplate()
	local var_85_1 = var_0.Battle.BattleUnitPhaseSwitcher.New(arg_85_1)

	local function var_85_2()
		local var_86_0 = arg_85_1

		return var_0.GetRaidDuration(var_86_0)
	end

	var_85_1:SetTemplateData(var_0_7.GeneratePlayerSubmarinPhase(arg_85_0._subAttackBaseLine, arg_85_0._subRetreatBaseLine, arg_85_1:GetAttrByName("raidDist"), var_85_2, arg_85_1:GetAttrByName("oxyAtkDuration")))

	arg_85_0._unitList[#arg_85_0._unitList + 1] = arg_85_1
	arg_85_0._subList[#arg_85_0._subList + 1] = arg_85_1

	arg_85_1:SetFleetVO(arg_85_0)
	arg_85_1:RegisterEventListener(arg_85_0, var_0_1.UPDATE_HP, arg_85_0.onUnitUpdateHP)

	return
end

function var_0_9.AddManualSubmarine(arg_87_0, arg_87_1)
	arg_87_0._unitList[#arg_87_0._unitList + 1] = arg_87_1
	arg_87_0._manualSubList[#arg_87_0._manualSubList + 1] = arg_87_1
	arg_87_0._manualSubBench[#arg_87_0._manualSubBench + 1] = arg_87_1
	arg_87_0._maxCount = arg_87_0._maxCount + 1

	arg_87_1:InitOxygen()
	arg_87_1:SetFleetVO(arg_87_0)
	arg_87_1:SetMotion(arg_87_0._motionVO)
	arg_87_1:RegisterEventListener(arg_87_0, var_0_1.UPDATE_HP, arg_87_0.onUnitUpdateHP)

	return
end

function var_0_9.GetSubList(arg_88_0)
	return arg_88_0._subList
end

function var_0_9.ShiftManualSub(arg_89_0)
	local var_89_0
	local var_89_2

	if arg_89_0._manualSubUnit then
		local var_89_1 = arg_89_0._manualSubUnit

		var_89_2 = var_89_2.GetTorpedoList(var_89_1)
		ipairs = var_89_1

		for iter_89_0, iter_89_1 in var_89_1(var_89_2) do
			if iter_89_1:IsAttacking() then
				arg_89_0:CancelTorpedo()
			end

			local var_89_3 = arg_89_0._torpedoWeaponVO

			var_1_10008.RemoveWeapon(var_89_3, iter_89_1)
		end

		local var_89_4 = arg_89_0._manualSubUnit

		if var_3.IsAlive(var_89_4) then
			table = var_3

			var_3.insert(arg_89_0._manualSubBench, arg_89_0._manualSubUnit)
		end

		local var_89_5 = arg_89_0._motionVO
		local var_89_6 = var_3.GetPos(var_89_5)

		var_89_0 = var_3.Clone(var_89_6)
	else
		local var_89_7 = arg_89_0._manualSubList[1]
		local var_89_8 = var_89_2.GetPosition(var_89_7)

		var_89_0 = var_89_2.Clone(var_89_8)
	end

	table = var_89_2
	arg_89_0._manualSubUnit = var_89_2.remove(arg_89_0._manualSubBench, 1)
	arg_89_0._scoutList[1] = arg_89_0._manualSubUnit

	local var_89_9 = {}

	ipairs = var_3

	for iter_89_2, iter_89_3 in var_3(arg_89_0._manualSubBench) do
		ipairs = var_1_10008

		for iter_89_4, iter_89_5 in var_1_10008(arg_89_0._unitList) do
			if iter_89_5 == iter_89_3 then
				table = var_1_10013

				var_1_10013.insert(var_89_9, iter_89_4)

				break
			end
		end
	end

	ipairs = var_3

	for iter_89_6, iter_89_7 in var_3(arg_89_0._unitList) do
		if iter_89_7 == arg_89_0._manualSubUnit then
			table = var_8

			var_8.insert(var_89_9, 1, iter_89_6)

			break
		end
	end

	arg_89_0:refreshFleetFormation(var_89_9)

	local var_89_10 = arg_89_0._manualSubUnit

	var_3.SetMainUnitStatic(var_89_10, false)

	local var_89_11 = arg_89_0._manualSubUnit

	var_3.SetPosition(var_89_11, var_89_0)
	arg_89_0:UpdateMotion()

	local var_89_12 = arg_89_0._submarineSpecialVO

	var_3.SetUseable(var_89_12, false)

	local var_89_13 = arg_89_0._manualSubUnit
	local var_89_14 = var_3.GetBuffList(var_89_13)

	pairs = var_89_13

	for iter_89_8, iter_89_9 in var_89_13(var_89_14) do
		if iter_89_9:IsSubmarineSpecial() then
			local var_89_15 = arg_89_0._submarineSpecialVO

			var_9.SetCount(var_89_15, 1)

			local var_89_16 = arg_89_0._submarineSpecialVO

			var_9.SetUseable(var_89_16, true)

			break
		end
	end

	arg_89_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)

	local var_89_17 = arg_89_0._torpedoWeaponVO

	var_4.Reset(var_89_17)

	local var_89_18 = arg_89_0._manualSubUnit
	local var_89_19 = var_4.GetTorpedoList(var_89_18)

	ipairs = var_89_18

	for iter_89_10, iter_89_11 in var_89_18(var_89_19) do
		if iter_89_11:GetCurrentState() ~= iter_89_11.STATE_OVER_HEAT then
			local var_89_20 = arg_89_0._torpedoWeaponVO

			var_10.AppendWeapon(var_89_20, iter_89_11)
		end
	end

	ipairs = var_5

	for iter_89_12, iter_89_13 in var_5(var_89_19) do
		if iter_89_13:GetCurrentState() == iter_89_13.STATE_OVER_HEAT then
			local var_89_21 = arg_89_0._torpedoWeaponVO

			var_10.AppendWeapon(var_89_21, iter_89_13)
		end
	end

	ipairs = var_5

	for iter_89_14, iter_89_15 in var_5(arg_89_0._manualSubBench) do
		iter_89_15:SetPosition(var_0_5.SUB_BENCH_POS[iter_89_14])
		iter_89_15:SetMainUnitStatic(true)
		iter_89_15:ChangeOxygenState(var_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	local var_89_22 = arg_89_0._submarineShiftVO

	var_5.ResetCurrent(var_89_22)

	if #arg_89_0._manualSubBench == 0 then
		local var_89_23 = arg_89_0._submarineShiftVO

		var_5.SetActive(var_89_23, false)
	end

	return
end

function var_0_9.ChangeSubmarineState(arg_90_0, arg_90_1, arg_90_2)
	if not arg_90_0._manualSubUnit then
		return
	end

	local var_90_0 = arg_90_0._manualSubUnit

	var_3.ChangeOxygenState(var_90_0, arg_90_1)

	if arg_90_2 then
		ipairs = var_3

		for iter_90_0, iter_90_1 in var_3(arg_90_0._submarineVOList) do
			iter_90_1:ResetCurrent()
		end

		local var_90_1 = arg_90_0._submarineShiftVO
		local var_90_2 = var_3.GetMax(var_90_1)
		local var_90_3 = arg_90_0._submarineShiftVO
		local var_90_4 = var_90_2 - var_4.GetCurrent(var_90_3)
		local var_90_5 = arg_90_0._submarineShiftVO

		if var_4.IsOverLoad(var_90_5) and var_90_4 > var_0_5.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			local var_90_6 = arg_90_0._submarineShiftVO

			var_4.SetMax(var_90_6, var_0_5.SR_CONFIG.DIVE_CD)

			local var_90_7 = arg_90_0._submarineShiftVO

			var_4.ResetCurrent(var_90_7)
		end
	end

	arg_90_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_SUBMARINE_SHIFT, {
		state = arg_90_1
	}))

	return
end

function var_0_9.SubmarinBoost(arg_91_0)
	local var_91_0 = arg_91_0._manualSubUnit
	local var_91_1 = var_1.Boost

	Vector3 = var_1_10003

	var_91_1(var_91_0, var_1_10003.right, var_0_5.SR_CONFIG.BOOST_SPEED, var_0_5.SR_CONFIG.BOOST_DECAY, var_0_5.SR_CONFIG.BOOST_DURATION, var_0_5.SR_CONFIG.BOOST_DECAY_STAMP)

	local var_91_2 = arg_91_0._submarineBoostVO

	var_1.ResetCurrent(var_91_2)

	return
end

function var_0_9.UnleashSubmarineSpecial(arg_92_0)
	if arg_92_0:GetWeaponBlock() then
		return
	end

	local var_92_0 = arg_92_0._submarineSpecialVO

	var_1.Cast(var_92_0)

	local var_92_1 = arg_92_0._manualSubUnit

	var_1.TriggerBuff(var_92_1, var_0_4.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

function var_0_9.AppendIndieSonar(arg_93_0, arg_93_1, arg_93_2)
	local var_93_0 = var_0.Battle.BattleIndieSonar.New(arg_93_0, arg_93_1, arg_93_2)

	var_3.SwitchHost(var_93_0, arg_93_0._motionReferenceUnit)

	arg_93_0._indieSonarList[var_3] = true

	var_3:Detect()

	return
end

function var_0_9.RemoveIndieSonar(arg_94_0, arg_94_1)
	pairs = var_1_10002

	for iter_94_0, iter_94_1 in var_1_10002(arg_94_0._indieSonarList) do
		if arg_94_1 == iter_94_0 then
			arg_94_0._indieSonarList[iter_94_0] = nil

			break
		end
	end

	return
end

function var_0_9.AttachFleetBuff(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1:GetID()

	if arg_95_0:GetFleetBuff(var_95_0) then
		var_3:Stack(arg_95_0)
	else
		arg_95_0._buffList[var_95_0] = arg_95_1

		arg_95_1:Attach(arg_95_0)
	end

	return
end

function var_0_9.RemoveFleetBuff(arg_96_0, arg_96_1)
	if arg_96_0:GetFleetBuff(arg_96_1) then
		var_2:Remove()
	end

	return
end

function var_0_9.GetFleetBuff(arg_97_0, arg_97_1)
	return arg_97_0._buffList[arg_97_1]
end

function var_0_9.GetFleetBuffList(arg_98_0)
	return arg_98_0._buffList
end

function var_0_9.Jamming(arg_99_0, arg_99_1)
	if arg_99_1 then
		local var_99_0 = arg_99_0._chargeWeaponVO

		var_2.StartJamming(var_99_0)

		local var_99_1 = arg_99_0._torpedoWeaponVO

		var_2.StartJamming(var_99_1)

		local var_99_2 = arg_99_0._airAssistVO

		var_2.StartJamming(var_99_2)
	else
		local var_99_3 = arg_99_0._chargeWeaponVO

		var_2.JammingEliminate(var_99_3)

		local var_99_4 = arg_99_0._torpedoWeaponVO

		var_2.JammingEliminate(var_99_4)

		local var_99_5 = arg_99_0._airAssistVO

		var_2.JammingEliminate(var_99_5)
	end

	return
end

function var_0_9.Blinding(arg_100_0, arg_100_1)
	arg_100_0:DispatchEvent(var_0.Event.New(var_0_2.FLEET_BLIND, {
		isBlind = arg_100_1
	}))

	return
end

function var_0_9.UpdateHorizon(arg_101_0)
	arg_101_0:DispatchEvent(var_0.Event.New(var_0_2.FLEET_HORIZON_UPDATE, {}))

	return
end

function var_0_9.AutoBotUpdated(arg_102_0, arg_102_1)
	local var_102_0

	if not arg_102_1 or not var_0_4.BuffEffectType.ON_AUTOBOT then
		var_102_0 = var_0_4.BuffEffectType.ON_MANUAL
	end

	ipairs = var_1_10003

	for iter_102_0, iter_102_1 in var_1_10003(arg_102_0._unitList) do
		iter_102_1:TriggerBuff(var_102_0)
	end

	return
end

function var_0_9.CloakFatalExpose(arg_103_0)
	ipairs = var_1_10001

	for iter_103_0, iter_103_1 in var_1_10001(arg_103_0._cloakList) do
		local var_103_0 = iter_103_1:GetCloak()

		var_6.ForceToMax(var_103_0)
	end

	return
end

function var_0_9.CloakInVision(arg_104_0, arg_104_1)
	ipairs = var_1_10002

	for iter_104_0, iter_104_1 in var_1_10002(arg_104_0._cloakList) do
		local var_104_0 = iter_104_1:GetCloak()

		var_7.AppendExposeSpeed(var_104_0, arg_104_1)
	end

	return
end

function var_0_9.CloakOutVision(arg_105_0)
	ipairs = var_1_10001

	for iter_105_0, iter_105_1 in var_1_10001(arg_105_0._cloakList) do
		local var_105_0 = iter_105_1:GetCloak()

		var_6.AppendExposeSpeed(var_105_0, 0)
	end

	return
end

function var_0_9.AttachCloak(arg_106_0, arg_106_1)
	if not arg_106_1:GetCloak() then
		arg_106_1:InitCloak()

		arg_106_0._cloakList[#arg_106_0._cloakList + 1] = arg_106_1
	end

	return
end

function var_0_9.AttachNightCloak(arg_107_0)
	arg_107_0._scoutAimBias = var_0.Battle.BattleUnitAimBiasComponent.New()

	local var_107_0 = arg_107_0._scoutAimBias

	var_1.ConfigRangeFormula(var_107_0, var_0_3.CalculateMaxAimBiasRange, var_0_3.CalculateBiasDecay)

	local var_107_1 = arg_107_0._scoutAimBias

	var_1.Active(var_107_1, arg_107_0._scoutAimBias.STATE_ACTIVITING)
	arg_107_0:DispatchEvent(var_0.Event.New(var_0_2.ADD_AIM_BIAS, {
		aimBias = arg_107_0._scoutAimBias
	}))

	return
end

function var_0_9.GetFleetBias(arg_108_0)
	return arg_108_0._scoutAimBias
end

return
