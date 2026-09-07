ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.WeaponQueue = class("WeaponQueue")
ys.Battle.WeaponQueue.__name = "WeaponQueue"

function ys.Battle.WeaponQueue.Ctor(arg_1_0)
	arg_1_0._totalWeapon = {}
	arg_1_0._queueList = {}
	arg_1_0._GCDTimerList = {}

	return
end

function ys.Battle.WeaponQueue.ConfigParallel(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._torpedoQueue = var_0_0.Battle.ManualWeaponQueue.New(arg_2_2)
	arg_2_0._chargeQueue = var_0_0.Battle.ManualWeaponQueue.New(arg_2_1)

	return
end

function ys.Battle.WeaponQueue:ClearAllWeapon()
	for iter_3_0, iter_3_1 in ipairs(self._totalWeapon) do
		iter_3_1:Clear()
	end

	return
end

function ys.Battle.WeaponQueue:Dispose()
	self._torpedoQueue:Clear()
	self._chargeQueue:Clear()

	for iter_4_0, iter_4_1 in ipairs(self._totalWeapon) do
		iter_4_1:Dispose()
	end

	self._torpedoQueue = nil
	self._chargeQueue = nil

	return
end

function ys.Battle.WeaponQueue:AppendWeapon(arg_5_1)
	local var_5_0 = self:GetQueueByIndex(arg_5_1:GetTemplateData().queue)

	var_5_0[#var_5_0 + 1] = arg_5_1
	self._totalWeapon[#self._totalWeapon + 1] = arg_5_1

	return
end

function ys.Battle.WeaponQueue:RemoveWeapon(arg_6_1)
	local var_6_0 = self:GetQueueByIndex(arg_6_1:GetTemplateData().queue)
	local var_6_1 = 1

	while var_6_1 <= #var_6_0 do
		if var_6_0[var_6_1] == arg_6_1 then
			table.remove(var_6_0, var_6_1)

			break
		end

		var_6_1 = var_6_1 + 1
	end

	local var_6_2 = 1

	while var_6_2 <= #self._totalWeapon do
		if self._totalWeapon[var_6_2] == arg_6_1 then
			table.remove(self._totalWeapon, var_6_2)

			break
		end

		var_6_2 = var_6_2 + 1
	end

	return
end

function ys.Battle.WeaponQueue:AppendManualTorpedo(arg_7_1)
	self:AppendWeapon(arg_7_1)
	self._torpedoQueue:AppendWeapon(arg_7_1)

	return
end

function ys.Battle.WeaponQueue:AppendChargeWeapon(arg_8_1)
	self:AppendWeapon(arg_8_1)
	self._chargeQueue:AppendWeapon(arg_8_1)

	return
end

function ys.Battle.WeaponQueue:RemoveManualTorpedo(arg_9_1)
	self:RemoveWeapon(arg_9_1)
	self._torpedoQueue:RemoveWeapon(arg_9_1)

	return
end

function ys.Battle.WeaponQueue:RemoveManualChargeWeapon(arg_10_1)
	self:RemoveWeapon(arg_10_1)
	self._chargeQueue:RemoveWeapon(arg_10_1)

	return
end

function ys.Battle.WeaponQueue:QueueEnterGCD(arg_11_1, arg_11_2)
	self:addGCDTimer(arg_11_2, arg_11_1)

	return
end

function ys.Battle.WeaponQueue:GetTotalWeaponUnit()
	return self._totalWeapon
end

function ys.Battle.WeaponQueue:GetQueueByIndex(arg_13_1)
	if self._queueList[arg_13_1] == nil then
		self._queueList[arg_13_1] = {}
	end

	return self._queueList[arg_13_1]
end

function ys.Battle.WeaponQueue:GetManualTorpedoQueue()
	return self._torpedoQueue
end

function ys.Battle.WeaponQueue:GetChargeWeaponQueue()
	return self._chargeQueue
end

function ys.Battle.WeaponQueue:Update(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self._queueList) do
		if self:isNotAttacking(iter_16_0) then
			self:updateWeapon(iter_16_0, arg_16_1)
		end
	end

	return
end

function ys.Battle.WeaponQueue:CheckWeaponInitalCD()
	for iter_17_0, iter_17_1 in ipairs(self._totalWeapon) do
		if not self._torpedoQueue:Containers(iter_17_1) and not self._chargeQueue:Containers(iter_17_1) then
			iter_17_1:InitialCD()
		end
	end

	self._torpedoQueue:CheckWeaponInitalCD()
	self._chargeQueue:CheckWeaponInitalCD()

	return
end

function ys.Battle.WeaponQueue:FlushWeaponReloadRequire()
	for iter_18_0, iter_18_1 in ipairs(self._totalWeapon) do
		if not self._torpedoQueue:Containers(iter_18_1) and not self._chargeQueue:Containers(iter_18_1) then
			iter_18_1:FlushReloadRequire()
		end
	end

	self._torpedoQueue:FlushWeaponReloadRequire()
	self._chargeQueue:FlushWeaponReloadRequire()

	return
end

function ys.Battle.WeaponQueue:isNotAttacking(arg_19_1)
	if self._GCDTimerList[arg_19_1] ~= nil then
		return false
	end

	for iter_19_0, iter_19_1 in ipairs(self._queueList[arg_19_1]) do
		if iter_19_1:IsAttacking() then
			return false
		end
	end

	return true
end

function ys.Battle.WeaponQueue:updateWeapon(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(self._queueList[arg_20_1]) do
		if iter_20_1:GetType() == var_0_1.EquipmentType.BEAM and iter_20_1:GetCurrentState() == iter_20_1.STATE_ATTACK then
			iter_20_1:Update()

			return
		end
	end

	for iter_20_2, iter_20_3 in ipairs(self._queueList[arg_20_1]) do
		local var_20_0 = false
		local var_20_2 = iter_20_3:GetCurrentState()

		if var_20_2 == iter_20_3.STATE_PRECAST or var_20_2 == iter_20_3.STATE_READY or var_20_2 == iter_20_3.STATE_OVER_HEAT and iter_20_3:CheckReloadTimeStamp() then
			var_20_0 = true
		end

		iter_20_3:Update(arg_20_2)

		local var_20_3 = iter_20_3:GetCurrentState()

		if arg_20_1 ~= var_0_1.NON_QUEUE_WEAPON and (var_20_0 and not ((var_20_3 == iter_20_3.STATE_PRECAST or var_20_3 == iter_20_3.STATE_READY or nil) and true) or iter_20_3:IsAttacking()) then
			break
		end
	end

	return
end

function ys.Battle.WeaponQueue:addGCDTimer(arg_21_1, arg_21_2)
	if self._GCDTimerList[arg_21_2] ~= nil then
		return
	end

	self._GCDTimerList[arg_21_2] = pg.TimeMgr.GetInstance():AddBattleTimer("weaponGCD", -1, arg_21_1, function()
		self:removeGCDTimer(arg_21_2)

		return
	end, true)

	return
end

function ys.Battle.WeaponQueue:removeGCDTimer(arg_23_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._GCDTimerList[arg_23_1])

	self._GCDTimerList[arg_23_1] = nil

	return
end

return
