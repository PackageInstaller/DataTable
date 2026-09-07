ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleEvent
local var_0_4 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConfig
local BattleFleetManualSubComponent = class("BattleFleetManualSubComponent")

ys.Battle.BattleFleetManualSubComponent = BattleFleetManualSubComponent
BattleFleetManualSubComponent.__name = "BattleFleetManualSubComponent"

function BattleFleetManualSubComponent:Ctor(arg_1_1)
	self._fleetVO = arg_1_1

	self:init()
	self:attachFunction()

	return
end

function BattleFleetManualSubComponent:attachFunction()
	self._fleetVO.GetSubBench = BattleFleetManualSubComponent.GetSubBench
	self._fleetVO.GetSubFreeDiveVO = BattleFleetManualSubComponent.GetSubFreeDiveVO
	self._fleetVO.GetSubFreeFloatVO = BattleFleetManualSubComponent.GetSubFreeFloatVO
	self._fleetVO.GetSubBoostVO = BattleFleetManualSubComponent.GetSubBoostVO
	self._fleetVO.GetSubSpecialVO = BattleFleetManualSubComponent.GetSubSpecialVO
	self._fleetVO.GetSubShiftVO = BattleFleetManualSubComponent.GetSubShiftVO
	self._fleetVO.AddManualSubmarine = BattleFleetManualSubComponent.AddManualSubmarine

	return
end

function BattleFleetManualSubComponent:UpdateAutoComponent(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self._manualSubList) do
		iter_3_1:UpdateOxygen(arg_3_1)
	end

	return
end

function BattleFleetManualSubComponent:UpdateManualWeaponVO(arg_4_1)
	self._submarineDiveVO:Update(arg_4_1)
	self._submarineFloatVO:Update(arg_4_1)
	self._submarineBoostVO:Update(arg_4_1)
	self._submarineShiftVO:Update(arg_4_1)

	return
end

function BattleFleetManualSubComponent:RemovePlayerUnit(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._subList, i) do
		if iter_5_1 == arg_5_1 then
			table.remove(self._subList, iter_5_0)

			break
		end
	end

	for iter_5_2, iter_5_3 in ipairs(self._manualSubList) do
		if iter_5_3 == arg_5_1 then
			table.remove(self._manualSubList, iter_5_2)

			break
		end
	end

	if not self._manualSubUnit then
		self:refreshFleetFormation(indexList)
	end

	return
end

function BattleFleetManualSubComponent:AddManualSubmarine(arg_6_1)
	self._unitList[#self._unitList + 1] = arg_6_1
	self._manualSubList[#self._manualSubList + 1] = arg_6_1
	self._manualSubBench[#self._manualSubBench + 1] = arg_6_1
	self._maxCount = self._maxCount + 1

	arg_6_1:InitOxygen()
	arg_6_1:SetFleetVO(self)
	arg_6_1:SetMotion(self._motionVO)
	arg_6_1:RegisterEventListener(self, var_0_1.UPDATE_HP, self.onUnitUpdateHP)

	return
end

function BattleFleetManualSubComponent:GetSubBench()
	return self._manualSubBench
end

function BattleFleetManualSubComponent:GetSubFreeDiveVO()
	return self._manualSubComponent._submarineDiveVO
end

function BattleFleetManualSubComponent:GetSubFreeFloatVO()
	return self._manualSubComponent._submarineFloatVO
end

function BattleFleetManualSubComponent:GetSubBoostVO()
	return self._manualSubComponent._submarineBoostVO
end

function BattleFleetManualSubComponent:GetSubSpecialVO()
	return self._manualSubComponent._submarineSpecialVO
end

function BattleFleetManualSubComponent:GetSubShiftVO()
	return self._manualSubComponent._submarineShiftVO
end

function BattleFleetManualSubComponent:init()
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

	self._manualSubList = {}
	self._manualSubBench = {}
	self._unitList = {}
	self._maxCount = 0

	return
end

function BattleFleetManualSubComponent:SetSubUnitData(arg_14_1)
	self._subUntiDataList = arg_14_1

	return
end

function BattleFleetManualSubComponent:GetSubUnitData()
	return self._subUntiDataList
end

function BattleFleetManualSubComponent:GetSubList()
	return self._subList
end

function BattleFleetManualSubComponent:ShiftManualSub()
	local var_17_0

	if self._manualSubUnit then
		for iter_17_0, iter_17_1 in ipairs((self._manualSubUnit:GetTorpedoList())) do
			if iter_17_1:IsAttacking() then
				self:CancelTorpedo()
			end

			self._torpedoWeaponVO:RemoveWeapon(iter_17_1)
		end

		if self._manualSubUnit:IsAlive() then
			table.insert(self._manualSubBench, self._manualSubUnit)
		end

		var_17_0 = self._motionVO:GetPos():Clone()
	else
		var_17_0 = self._manualSubList[1]:GetPosition():Clone()
	end

	self._manualSubUnit = table.remove(self._manualSubBench, 1)
	self._scoutList[1] = self._manualSubUnit

	local var_17_1 = {}

	for iter_17_2, iter_17_3 in ipairs(self._manualSubBench) do
		for iter_17_4, iter_17_5 in ipairs(self._unitList) do
			if iter_17_5 == iter_17_3 then
				table.insert(var_17_1, iter_17_4)

				break
			end
		end
	end

	for iter_17_6, iter_17_7 in ipairs(self._unitList) do
		if iter_17_7 == self._manualSubUnit then
			table.insert(var_17_1, 1, iter_17_6)

			break
		end
	end

	self:refreshFleetFormation(var_17_1)
	self._manualSubUnit:SetMainUnitStatic(false)
	self._manualSubUnit:SetPosition(var_17_0)
	self:UpdateMotion()
	self._submarineSpecialVO:SetUseable(false)

	for iter_17_8, iter_17_9 in pairs((self._manualSubUnit:GetBuffList())) do
		if iter_17_9:IsSubmarineSpecial() then
			self._submarineSpecialVO:SetCount(1)
			self._submarineSpecialVO:SetUseable(true)

			break
		end
	end

	self:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE)
	self._torpedoWeaponVO:Reset()

	local var_17_2 = self._manualSubUnit:GetTorpedoList()

	for iter_17_10, iter_17_11 in ipairs(var_17_2) do
		if iter_17_11:GetCurrentState() ~= iter_17_11.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_17_11)
		end
	end

	for iter_17_12, iter_17_13 in ipairs(var_17_2) do
		if iter_17_13:GetCurrentState() == iter_17_13.STATE_OVER_HEAT then
			self._torpedoWeaponVO:AppendWeapon(iter_17_13)
		end
	end

	for iter_17_14, iter_17_15 in ipairs(self._manualSubBench) do
		iter_17_15:SetPosition(var_0_5.SUB_BENCH_POS[iter_17_14])
		iter_17_15:SetMainUnitStatic(true)
		iter_17_15:ChangeOxygenState(var_0_0.Battle.OxyState.STATE_FREE_BENCH)
	end

	self._submarineShiftVO:ResetCurrent()

	if #self._manualSubBench == 0 then
		self._submarineShiftVO:SetActive(false)
	end

	return
end

function BattleFleetManualSubComponent:ChangeSubmarineState(arg_18_1, arg_18_2)
	if not self._manualSubUnit then
		return
	end

	self._manualSubUnit:ChangeOxygenState(arg_18_1)

	if arg_18_2 then
		for iter_18_0, iter_18_1 in ipairs(self._submarineVOList) do
			iter_18_1:ResetCurrent()
		end

		if self._submarineShiftVO:IsOverLoad() and self._submarineShiftVO:GetMax() - self._submarineShiftVO:GetCurrent() > var_0_5.SR_CONFIG.DIVE_CD then
			-- block empty
		else
			self._submarineShiftVO:SetMax(var_0_5.SR_CONFIG.DIVE_CD)
			self._submarineShiftVO:ResetCurrent()
		end
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_2.MANUAL_SUBMARINE_SHIFT, {
		state = arg_18_1
	}))

	return
end

function BattleFleetManualSubComponent:SubmarinBoost()
	self._manualSubUnit:Boost(Vector3.right, var_0_5.SR_CONFIG.BOOST_SPEED, var_0_5.SR_CONFIG.BOOST_DECAY, var_0_5.SR_CONFIG.BOOST_DURATION, var_0_5.SR_CONFIG.BOOST_DECAY_STAMP)
	self._submarineBoostVO:ResetCurrent()

	return
end

function BattleFleetManualSubComponent:UnleashSubmarineSpecial()
	if self:GetWeaponBlock() then
		return
	end

	self._submarineSpecialVO:Cast()
	self._manualSubUnit:TriggerBuff(var_0_4.BuffEffectType.ON_SUBMARINE_FREE_SPECIAL)

	return
end

return
