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

function ys.Battle.WeaponQueue.ClearAllWeapon(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._totalWeapon) do
		iter_3_1:Clear()
	end

	return
end

function ys.Battle.WeaponQueue.Dispose(arg_4_0)
	arg_4_0._torpedoQueue:Clear()
	arg_4_0._chargeQueue:Clear()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._totalWeapon) do
		iter_4_1:Dispose()
	end

	arg_4_0._torpedoQueue = nil
	arg_4_0._chargeQueue = nil

	return
end

function ys.Battle.WeaponQueue.AppendWeapon(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetQueueByIndex(arg_5_1:GetTemplateData().queue)

	var_5_0[#var_5_0 + 1] = arg_5_1
	arg_5_0._totalWeapon[#arg_5_0._totalWeapon + 1] = arg_5_1

	return
end

function ys.Battle.WeaponQueue.RemoveWeapon(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetQueueByIndex(arg_6_1:GetTemplateData().queue)
	local var_6_1 = 1

	while var_6_1 <= #var_6_0 do
		if var_6_0[var_6_1] == arg_6_1 then
			table.remove(var_6_0, var_6_1)

			break
		end

		var_6_1 = var_6_1 + 1
	end

	local var_6_2 = 1

	while var_6_2 <= #arg_6_0._totalWeapon do
		if arg_6_0._totalWeapon[var_6_2] == arg_6_1 then
			table.remove(arg_6_0._totalWeapon, var_6_2)

			break
		end

		var_6_2 = var_6_2 + 1
	end

	return
end

function ys.Battle.WeaponQueue.AppendManualTorpedo(arg_7_0, arg_7_1)
	arg_7_0:AppendWeapon(arg_7_1)
	arg_7_0._torpedoQueue:AppendWeapon(arg_7_1)

	return
end

function ys.Battle.WeaponQueue.AppendChargeWeapon(arg_8_0, arg_8_1)
	arg_8_0:AppendWeapon(arg_8_1)
	arg_8_0._chargeQueue:AppendWeapon(arg_8_1)

	return
end

function ys.Battle.WeaponQueue.RemoveManualTorpedo(arg_9_0, arg_9_1)
	arg_9_0:RemoveWeapon(arg_9_1)
	arg_9_0._torpedoQueue:RemoveWeapon(arg_9_1)

	return
end

function ys.Battle.WeaponQueue.RemoveManualChargeWeapon(arg_10_0, arg_10_1)
	arg_10_0:RemoveWeapon(arg_10_1)
	arg_10_0._chargeQueue:RemoveWeapon(arg_10_1)

	return
end

function ys.Battle.WeaponQueue.QueueEnterGCD(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:addGCDTimer(arg_11_2, arg_11_1)

	return
end

function ys.Battle.WeaponQueue.GetTotalWeaponUnit(arg_12_0)
	return arg_12_0._totalWeapon
end

function ys.Battle.WeaponQueue.GetQueueByIndex(arg_13_0, arg_13_1)
	if arg_13_0._queueList[arg_13_1] == nil then
		arg_13_0._queueList[arg_13_1] = {}
	end

	return arg_13_0._queueList[arg_13_1]
end

function ys.Battle.WeaponQueue.GetManualTorpedoQueue(arg_14_0)
	return arg_14_0._torpedoQueue
end

function ys.Battle.WeaponQueue.GetChargeWeaponQueue(arg_15_0)
	return arg_15_0._chargeQueue
end

function ys.Battle.WeaponQueue.Update(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._queueList) do
		if arg_16_0:isNotAttacking(iter_16_0) then
			arg_16_0:updateWeapon(iter_16_0, arg_16_1)
		end
	end

	return
end

function ys.Battle.WeaponQueue.CheckWeaponInitalCD(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._totalWeapon) do
		if not arg_17_0._torpedoQueue:Containers(iter_17_1) and not arg_17_0._chargeQueue:Containers(iter_17_1) then
			iter_17_1:InitialCD()
		end
	end

	arg_17_0._torpedoQueue:CheckWeaponInitalCD()
	arg_17_0._chargeQueue:CheckWeaponInitalCD()

	return
end

function ys.Battle.WeaponQueue.FlushWeaponReloadRequire(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._totalWeapon) do
		if not arg_18_0._torpedoQueue:Containers(iter_18_1) and not arg_18_0._chargeQueue:Containers(iter_18_1) then
			iter_18_1:FlushReloadRequire()
		end
	end

	arg_18_0._torpedoQueue:FlushWeaponReloadRequire()
	arg_18_0._chargeQueue:FlushWeaponReloadRequire()

	return
end

function ys.Battle.WeaponQueue.isNotAttacking(arg_19_0, arg_19_1)
	if arg_19_0._GCDTimerList[arg_19_1] ~= nil then
		return false
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._queueList[arg_19_1]) do
		if iter_19_1:IsAttacking() then
			return false
		end
	end

	return true
end

function ys.Battle.WeaponQueue.updateWeapon(arg_20_0, arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._queueList[arg_20_1]) do
		if iter_20_1:GetType() == var_0_1.EquipmentType.BEAM and iter_20_1:GetCurrentState() == iter_20_1.STATE_ATTACK then
			iter_20_1:Update()

			return
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._queueList[arg_20_1]) do
		local var_20_0 = false
		local var_20_1 = false
		local var_20_2 = iter_20_3:GetCurrentState()

		if var_20_2 == iter_20_3.STATE_PRECAST or var_20_2 == iter_20_3.STATE_READY or var_20_2 == iter_20_3.STATE_OVER_HEAT and iter_20_3:CheckReloadTimeStamp() then
			var_20_0 = true
		end

		iter_20_3:Update(arg_20_2)

		local var_20_3 = iter_20_3:GetCurrentState()

		if var_20_3 == iter_20_3.STATE_PRECAST or var_20_3 == iter_20_3.STATE_READY then
			var_20_1 = true
		end

		if arg_20_1 ~= var_0_1.NON_QUEUE_WEAPON and (var_20_0 and not var_20_1 or iter_20_3:IsAttacking()) then
			break
		end
	end

	return
end

function ys.Battle.WeaponQueue.addGCDTimer(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._GCDTimerList[arg_21_2] ~= nil then
		return
	end

	arg_21_0._GCDTimerList[arg_21_2] = pg.TimeMgr.GetInstance():AddBattleTimer("weaponGCD", -1, arg_21_1, function()
		arg_21_0:removeGCDTimer(arg_21_2)

		return
	end, true)

	return
end

function ys.Battle.WeaponQueue.removeGCDTimer(arg_23_0, arg_23_1)
	pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_23_0._GCDTimerList[arg_23_1])

	arg_23_0._GCDTimerList[arg_23_1] = nil

	return
end

return
