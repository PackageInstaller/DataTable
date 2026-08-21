ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleEvent
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_8 = class("BattleFleetManualSubComponent")

ys.Battle.BattleFleetManualSubComponent = var_0_8
var_0_8.__name = "BattleFleetManualSubComponent"

function var_0_8.Ctor(arg_1_0, arg_1_1)
	arg_1_0._fleetVO = arg_1_1

	arg_1_0:init()
	arg_1_0:attachFunction()

	return
end

function var_0_8.attachFunction(arg_2_0)
	arg_2_0._fleetVO.GetSubBench = var_0_8.GetSubBench
	arg_2_0._fleetVO.GetSubFreeDiveVO = var_0_8.GetSubFreeDiveVO
	arg_2_0._fleetVO.GetSubFreeFloatVO = var_0_8.GetSubFreeFloatVO
	arg_2_0._fleetVO.GetSubBoostVO = var_0_8.GetSubBoostVO
	arg_2_0._fleetVO.GetSubSpecialVO = var_0_8.GetSubSpecialVO
	arg_2_0._fleetVO.GetSubShiftVO = var_0_8.GetSubShiftVO
	arg_2_0._fleetVO.AddManualSubmarine = var_0_8.AddManualSubmarine

	return
end

function var_0_8.UpdateAutoComponent(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._manualSubList) do
		iter_3_1:UpdateOxygen(arg_3_1)
	end

	return
end

function var_0_8.UpdateManualWeaponVO(arg_4_0, arg_4_1)
	arg_4_0._submarineDiveVO:Update(arg_4_1)
	arg_4_0._submarineFloatVO:Update(arg_4_1)
	arg_4_0._submarineBoostVO:Update(arg_4_1)
	arg_4_0._submarineShiftVO:Update(arg_4_1)

	return
end

function var_0_8.RemovePlayerUnit(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._subList, i) do
		if iter_5_1 == arg_5_1 then
			table.remove(arg_5_0._subList, iter_5_0)

			break
		end
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0._manualSubList) do
		if iter_5_3 == arg_5_1 then
			table.remove(arg_5_0._manualSubList, iter_5_2)

			break
		end
	end

	if not arg_5_0._manualSubUnit then
		arg_5_0:refreshFleetFormation(indexList)
	end

	return
end

function var_0_8.AddManualSubmarine(arg_6_0, arg_6_1)
	arg_6_0._unitList[#arg_6_0._unitList + 1] = arg_6_1
	arg_6_0._manualSubList[#arg_6_0._manualSubList + 1] = arg_6_1
	arg_6_0._manualSubBench[#arg_6_0._manualSubBench + 1] = arg_6_1
	arg_6_0._maxCount = arg_6_0._maxCount + 1

	arg_6_1:InitOxygen()
	arg_6_1:SetFleetVO(arg_6_0)
	arg_6_1:SetMotion(arg_6_0._motionVO)
	arg_6_1:RegisterEventListener(arg_6_0, var_0_0.UPDATE_HP, arg_6_0.onUnitUpdateHP)

	return
end

function var_0_8.GetSubBench(arg_7_0)
	return arg_7_0._manualSubBench
end

function var_0_8.GetSubFreeDiveVO(arg_8_0)
	return arg_8_0._manualSubComponent._submarineDiveVO
end

function var_0_8.GetSubFreeFloatVO(arg_9_0)
	return arg_9_0._manualSubComponent._submarineFloatVO
end

function var_0_8.GetSubBoostVO(arg_10_0)
	return arg_10_0._manualSubComponent._submarineBoostVO
end

function var_0_8.GetSubSpecialVO(arg_11_0)
	return arg_11_0._manualSubComponent._submarineSpecialVO
end

function var_0_8.GetSubShiftVO(arg_12_0)
	return arg_12_0._manualSubComponent._submarineShiftVO
end

function var_0_8.init(arg_13_0)
	arg_13_0._submarineDiveVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.DIVE_CD)
	arg_13_0._submarineFloatVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.FLOAT_CD)
	arg_13_0._submarineVOList = {
		arg_13_0._submarineDiveVO,
		arg_13_0._submarineFloatVO
	}
	arg_13_0._submarineBoostVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.BOOST_CD)
	arg_13_0._submarineShiftVO = var_0.Battle.BattleSubmarineFuncVO.New(var_0_4.SR_CONFIG.SHIFT_CD)
	arg_13_0._submarineSpecialVO = var_0.Battle.BattleSubmarineAidVO.New()

	arg_13_0._submarineSpecialVO:SetCount(1)
	arg_13_0._submarineSpecialVO:SetTotal(1)

	arg_13_0._manualSubList = {}
	arg_13_0._manualSubBench = {}
	arg_13_0._unitList = {}
	arg_13_0._maxCount = 0

	return
end

function var_0_8.SetSubUnitData(arg_14_0, arg_14_1)
	arg_14_0._subUntiDataList = arg_14_1

	return
end

function var_0_8.GetSubUnitData(arg_15_0)
	return arg_15_0._subUntiDataList
end

function var_0_8.GetSubList(arg_16_0)
	return arg_16_0._subList
end

function var_0_8.ShiftManualSub(arg_17_0)
	local var_17_0

	if arg_17_0._manualSubUnit then
		for iter_17_0, iter_17_1 in ipairs((arg_17_0._manualSubUnit:GetTorpedoList())) do
			if iter_17_1:IsAttacking() then
				arg_17_0:CancelTorpedo()
			end

			arg_17_0._torpedoWeaponVO:RemoveWeapon(iter_17_1)
		end

		if arg_17_0._manualSubUnit:IsAlive() then
			table.insert(arg_17_0._manualSubBench, arg_17_0._manualSubUnit)
		end

		var_17_0 = arg_17_0._motionVO:GetPos():Clone()
	else
		var_17_0 = arg_17_0._manualSubList[1]:GetPosition():Clone()
	end

	arg_17_0._manualSubUnit = table.remove(arg_17_0._manualSubBench, 1)
	arg_17_0._scoutList[1] = arg_17_0._manualSubUnit

	for iter_17_2, iter_17_3 in ipairs(arg_17_0._manualSubBench) do
		for iter_17_4, iter_17_5 in ipairs(arg_17_0._unitList) do
			if iter_17_5 == iter_17_3 then
				table.insert({}, iter_17_4)

				break
			end
		end
	end

	for iter_17_6, iter_17_7 in ipairs(arg_17_0._unitList) do
		if iter_17_7 == arg_17_0._manualSubUnit then
			table.insert({}, 1, iter_17_6)

			break
		end
	end

	arg_17_0:refreshFleetFormation({})
	arg_17_0._manualSubUnit:SetMainUnitStatic(false)
	arg_17_0._manualSubUnit:SetPosition(var_17_0)
	arg_17_0:UpdateMotion()
	arg_17_0._submarineSpecialVO:SetUseable(false)

	for iter_17_8, iter_17_9 in pairs((arg_17_0._manualSubUnit:GetBuffList())) do
		if iter_17_9:IsSubmarineSpecial() then
			arg_17_0._submarineSpecialVO:SetCount(1)
			arg_17_0._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	arg_17_0:ChangeSubmarineState(var_0.Battle.OxyState.STATE_FREE_DIVE)
	arg_17_0._torpedoWeaponVO:Reset()

	local var_17_1 = arg_17_0._manualSubUnit:GetTorpedoList()

	for iter_17_10, iter_17_11 in ipairs(var_17_1) do
		if iter_17_11:GetCurrentState() ~= iter_17_11.STATE_OVER_HEAT then
			arg_17_0._torpedoWeaponVO:AppendWeapon(iter_17_11)
		end
	end

	for iter_17_12, iter_17_13 in ipairs(var_17_1) do
		if iter_17_13:GetCurrentState() == iter_17_13.STATE_OVER_HEAT then
			arg_17_0._torpedoWeaponVO:AppendWeapon(iter_17_13)
		end
	end

	for iter_17_14, iter_17_15 in ipairs(arg_17_0._manualSubBench) do
		iter_17_15:SetPosition(var_0_4.SUB_BENCH_POS[iter_17_14])
		iter_17_15:SetMainUnitStatic(true)
		iter_17_15:ChangeOxygenState(var_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	arg_17_0._submarineShiftVO:ResetCurrent()

	if #arg_17_0._manualSubBench == 0 then
		arg_17_0._submarineShiftVO:SetActive(false)
	end

	return
end

function var_0_8.ChangeSubmarineState(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._manualSubUnit then
		return
	end

	arg_18_0._manualSubUnit:ChangeOxygenState(arg_18_1)

	if arg_18_2 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._submarineVOList) do
			iter_18_1:ResetCurrent()
		end

		if arg_18_0._submarineShiftVO:IsOverLoad() and arg_18_0._submarineShiftVO:GetMax() - arg_18_0._submarineShiftVO:GetCurrent() > var_0_4.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			arg_18_0._submarineShiftVO:SetMax(var_0_4.SR_CONFIG.DIVE_CD)
			arg_18_0._submarineShiftVO:ResetCurrent()
		end
	end

	arg_18_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_SUBMARINE_SHIFT, {
		state = arg_18_1
	}))

	return
end

function var_0_8.SubmarinBoost(arg_19_0)
	arg_19_0._manualSubUnit:Boost(Vector3.right, var_0_4.SR_CONFIG.BOOST_SPEED, var_0_4.SR_CONFIG.BOOST_DECAY, var_0_4.SR_CONFIG.BOOST_DURATION, var_0_4.SR_CONFIG.BOOST_DECAY_STAMP)
	arg_19_0._submarineBoostVO:ResetCurrent()

	return
end

function var_0_8.UnleashSubmarineSpecial(arg_20_0)
	if arg_20_0:GetWeaponBlock() then
		return
	end

	arg_20_0._submarineSpecialVO:Cast()
	arg_20_0._manualSubUnit:TriggerBuff(var_0_3.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

return
