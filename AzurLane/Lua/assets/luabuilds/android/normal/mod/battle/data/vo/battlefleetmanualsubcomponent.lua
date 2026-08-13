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

local var_0_9 = var_0_10009("BattleFleetManualSubComponent")

var_0.Battle.BattleFleetManualSubComponent = var_0_9
var_0_9.__name = "BattleFleetManualSubComponent"

function var_0_9.Ctor(arg_1_0, arg_1_1)
	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init()
	arg_1_0:attachFunction()

	return
end

function var_0_9.attachFunction(arg_2_0)
	arg_2_0._fleetVO.GetSubBench = var_0_9.GetSubBench
	arg_2_0._fleetVO.GetSubFreeDiveVO = var_0_9.GetSubFreeDiveVO
	arg_2_0._fleetVO.GetSubFreeFloatVO = var_0_9.GetSubFreeFloatVO
	arg_2_0._fleetVO.GetSubBoostVO = var_0_9.GetSubBoostVO
	arg_2_0._fleetVO.GetSubSpecialVO = var_0_9.GetSubSpecialVO
	arg_2_0._fleetVO.GetSubShiftVO = var_0_9.GetSubShiftVO
	arg_2_0._fleetVO.AddManualSubmarine = var_0_9.AddManualSubmarine

	return
end

function var_0_9.UpdateAutoComponent(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0._manualSubList) do
		iter_3_1:UpdateOxygen(arg_3_1)
	end

	return
end

function var_0_9.UpdateManualWeaponVO(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._submarineDiveVO

	var_2.Update(var_4_0, arg_4_1)

	local var_4_1 = arg_4_0._submarineFloatVO

	var_2.Update(var_4_1, arg_4_1)

	local var_4_2 = arg_4_0._submarineBoostVO

	var_2.Update(var_4_2, arg_4_1)

	local var_4_3 = arg_4_0._submarineShiftVO

	var_2.Update(var_4_3, arg_4_1)

	return
end

function var_0_9.RemovePlayerUnit(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	local var_5_0 = arg_5_0._subList

	i = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10002(var_5_0, var_1_10004) do
		if iter_5_1 == arg_5_1 then
			table = var_1_10007

			var_1_10007.remove(arg_5_0._subList, iter_5_0)

			break
		end
	end

	ipairs = var_2

	for iter_5_2, iter_5_3 in var_2(arg_5_0._manualSubList) do
		if iter_5_3 == arg_5_1 then
			table = var_1_10007

			var_1_10007.remove(arg_5_0._manualSubList, iter_5_2)

			break
		end
	end

	if not arg_5_0._manualSubUnit then
		local var_5_1 = arg_5_0
		local var_5_2 = arg_5_0.refreshFleetFormation

		indexList = var_4

		var_5_2(var_5_1, var_4)
	end

	return
end

function var_0_9.AddManualSubmarine(arg_6_0, arg_6_1)
	arg_6_0._unitList[#arg_6_0._unitList + 1] = arg_6_1
	arg_6_0._manualSubList[#arg_6_0._manualSubList + 1] = arg_6_1
	arg_6_0._manualSubBench[#arg_6_0._manualSubBench + 1] = arg_6_1
	arg_6_0._maxCount = arg_6_0._maxCount + 1

	arg_6_1:InitOxygen()
	arg_6_1:SetFleetVO(arg_6_0)
	arg_6_1:SetMotion(arg_6_0._motionVO)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_1.UPDATE_HP, arg_6_0.onUnitUpdateHP)

	return
end

function var_0_9.GetSubBench(arg_7_0)
	return arg_7_0._manualSubBench
end

function var_0_9.GetSubFreeDiveVO(arg_8_0)
	return arg_8_0._manualSubComponent._submarineDiveVO
end

function var_0_9.GetSubFreeFloatVO(arg_9_0)
	return arg_9_0._manualSubComponent._submarineFloatVO
end

function var_0_9.GetSubBoostVO(arg_10_0)
	return arg_10_0._manualSubComponent._submarineBoostVO
end

function var_0_9.GetSubSpecialVO(arg_11_0)
	return arg_11_0._manualSubComponent._submarineSpecialVO
end

function var_0_9.GetSubShiftVO(arg_12_0)
	return arg_12_0._manualSubComponent._submarineShiftVO
end

function var_0_9.init(arg_13_0)
	arg_13_0._submarineDiveVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.DIVE_CD)
	arg_13_0._submarineFloatVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.FLOAT_CD)
	arg_13_0._submarineVOList = {
		arg_13_0._submarineDiveVO,
		arg_13_0._submarineFloatVO
	}
	arg_13_0._submarineBoostVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.BOOST_CD)
	arg_13_0._submarineShiftVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_5.SR_CONFIG.SHIFT_CD)
	arg_13_0._submarineSpecialVO = var_0.Battle.BattleSubmarineAidVO.New()

	local var_13_0 = arg_13_0._submarineSpecialVO

	var_1.SetCount(var_13_0, 1)

	local var_13_1 = arg_13_0._submarineSpecialVO

	var_1.SetTotal(var_13_1, 1)

	arg_13_0._manualSubList = {}
	arg_13_0._manualSubBench = {}
	arg_13_0._unitList = {}
	arg_13_0._maxCount = 0

	return
end

function var_0_9.SetSubUnitData(arg_14_0, arg_14_1)
	arg_14_0._subUntiDataList = arg_14_1

	return
end

function var_0_9.GetSubUnitData(arg_15_0)
	return arg_15_0._subUntiDataList
end

function var_0_9.GetSubList(arg_16_0)
	return arg_16_0._subList
end

function var_0_9.ShiftManualSub(arg_17_0)
	local var_17_0
	local var_17_2

	if arg_17_0._manualSubUnit then
		local var_17_1 = arg_17_0._manualSubUnit

		var_17_2 = var_17_2.GetTorpedoList(var_17_1)
		ipairs = var_17_1

		for iter_17_0, iter_17_1 in var_17_1(var_17_2) do
			if iter_17_1:IsAttacking() then
				arg_17_0:CancelTorpedo()
			end

			local var_17_3 = arg_17_0._torpedoWeaponVO

			var_1_10008.RemoveWeapon(var_17_3, iter_17_1)
		end

		local var_17_4 = arg_17_0._manualSubUnit

		if var_3.IsAlive(var_17_4) then
			table = var_3

			var_3.insert(arg_17_0._manualSubBench, arg_17_0._manualSubUnit)
		end

		local var_17_5 = arg_17_0._motionVO
		local var_17_6 = var_3.GetPos(var_17_5)

		var_17_0 = var_3.Clone(var_17_6)
	else
		local var_17_7 = arg_17_0._manualSubList[1]
		local var_17_8 = var_17_2.GetPosition(var_17_7)

		var_17_0 = var_17_2.Clone(var_17_8)
	end

	table = var_17_2
	arg_17_0._manualSubUnit = var_17_2.remove(arg_17_0._manualSubBench, 1)
	arg_17_0._scoutList[1] = arg_17_0._manualSubUnit

	local var_17_9 = {}

	ipairs = var_3

	for iter_17_2, iter_17_3 in var_3(arg_17_0._manualSubBench) do
		ipairs = var_1_10008

		for iter_17_4, iter_17_5 in var_1_10008(arg_17_0._unitList) do
			if iter_17_5 == iter_17_3 then
				table = var_1_10013

				var_1_10013.insert(var_17_9, iter_17_4)

				break
			end
		end
	end

	ipairs = var_3

	for iter_17_6, iter_17_7 in var_3(arg_17_0._unitList) do
		if iter_17_7 == arg_17_0._manualSubUnit then
			table = var_8

			var_8.insert(var_17_9, 1, iter_17_6)

			break
		end
	end

	arg_17_0:refreshFleetFormation(var_17_9)

	local var_17_10 = arg_17_0._manualSubUnit

	var_3.SetMainUnitStatic(var_17_10, false)

	local var_17_11 = arg_17_0._manualSubUnit

	var_3.SetPosition(var_17_11, var_17_0)
	arg_17_0:UpdateMotion()

	local var_17_12 = arg_17_0._submarineSpecialVO

	var_3.SetUseable(var_17_12, false)

	local var_17_13 = arg_17_0._manualSubUnit
	local var_17_14 = var_3.GetBuffList(var_17_13)

	pairs = var_17_13

	for iter_17_8, iter_17_9 in var_17_13(var_17_14) do
		if iter_17_9:IsSubmarineSpecial() then
			local var_17_15 = arg_17_0._submarineSpecialVO

			var_9.SetCount(var_17_15, 1)

			local var_17_16 = arg_17_0._submarineSpecialVO

			var_9.SetUseable(var_17_16, true)

			break
		end
	end

	arg_17_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)

	local var_17_17 = arg_17_0._torpedoWeaponVO

	var_4.Reset(var_17_17)

	local var_17_18 = arg_17_0._manualSubUnit
	local var_17_19 = var_4.GetTorpedoList(var_17_18)

	ipairs = var_17_18

	for iter_17_10, iter_17_11 in var_17_18(var_17_19) do
		if iter_17_11:GetCurrentState() ~= iter_17_11.STATE_OVER_HEAT then
			local var_17_20 = arg_17_0._torpedoWeaponVO

			var_10.AppendWeapon(var_17_20, iter_17_11)
		end
	end

	ipairs = var_5

	for iter_17_12, iter_17_13 in var_5(var_17_19) do
		if iter_17_13:GetCurrentState() == iter_17_13.STATE_OVER_HEAT then
			local var_17_21 = arg_17_0._torpedoWeaponVO

			var_10.AppendWeapon(var_17_21, iter_17_13)
		end
	end

	ipairs = var_5

	for iter_17_14, iter_17_15 in var_5(arg_17_0._manualSubBench) do
		iter_17_15:SetPosition(var_0_5.SUB_BENCH_POS[iter_17_14])
		iter_17_15:SetMainUnitStatic(true)
		iter_17_15:ChangeOxygenState(var_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	local var_17_22 = arg_17_0._submarineShiftVO

	var_5.ResetCurrent(var_17_22)

	if #arg_17_0._manualSubBench == 0 then
		local var_17_23 = arg_17_0._submarineShiftVO

		var_5.SetActive(var_17_23, false)
	end

	return
end

function var_0_9.ChangeSubmarineState(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._manualSubUnit then
		return
	end

	local var_18_0 = arg_18_0._manualSubUnit

	var_3.ChangeOxygenState(var_18_0, arg_18_1)

	if arg_18_2 then
		ipairs = var_3

		for iter_18_0, iter_18_1 in var_3(arg_18_0._submarineVOList) do
			iter_18_1:ResetCurrent()
		end

		local var_18_1 = arg_18_0._submarineShiftVO
		local var_18_2 = var_3.GetMax(var_18_1)
		local var_18_3 = arg_18_0._submarineShiftVO
		local var_18_4 = var_18_2 - var_4.GetCurrent(var_18_3)
		local var_18_5 = arg_18_0._submarineShiftVO

		if var_4.IsOverLoad(var_18_5) and var_18_4 > var_0_5.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			local var_18_6 = arg_18_0._submarineShiftVO

			var_4.SetMax(var_18_6, var_0_5.SR_CONFIG.DIVE_CD)

			local var_18_7 = arg_18_0._submarineShiftVO

			var_4.ResetCurrent(var_18_7)
		end
	end

	arg_18_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_SUBMARINE_SHIFT, {
		state = arg_18_1
	}))

	return
end

function var_0_9.SubmarinBoost(arg_19_0)
	local var_19_0 = arg_19_0._manualSubUnit
	local var_19_1 = var_1.Boost

	Vector3 = var_1_10003

	var_19_1(var_19_0, var_1_10003.right, var_0_5.SR_CONFIG.BOOST_SPEED, var_0_5.SR_CONFIG.BOOST_DECAY, var_0_5.SR_CONFIG.BOOST_DURATION, var_0_5.SR_CONFIG.BOOST_DECAY_STAMP)

	local var_19_2 = arg_19_0._submarineBoostVO

	var_1.ResetCurrent(var_19_2)

	return
end

function var_0_9.UnleashSubmarineSpecial(arg_20_0)
	if arg_20_0:GetWeaponBlock() then
		return
	end

	local var_20_0 = arg_20_0._submarineSpecialVO

	var_1.Cast(var_20_0)

	local var_20_1 = arg_20_0._manualSubUnit

	var_1.TriggerBuff(var_20_1, var_0_4.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

return
