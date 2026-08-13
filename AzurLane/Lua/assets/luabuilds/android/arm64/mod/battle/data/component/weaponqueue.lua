ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.WeaponQueue = var_0_10003("WeaponQueue")
var_0.Battle.WeaponQueue.__name = "WeaponQueue"

local var_0_3 = var_0.Battle.WeaponQueue

function var_0_3.Ctor(arg_1_0)
	arg_1_0._totalWeapon = {}
	arg_1_0._queueList = {}
	arg_1_0._GCDTimerList = {}

	return
end

function var_0_3.ConfigParallel(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._torpedoQueue = var_0.Battle.ManualWeaponQueue.New(arg_2_2)
	arg_2_0._chargeQueue = var_0.Battle.ManualWeaponQueue.New(arg_2_1)

	return
end

function var_0_3.ClearAllWeapon(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._totalWeapon) do
		iter_3_1:Clear()
	end

	return
end

function var_0_3.Dispose(arg_4_0)
	local var_4_0 = arg_4_0._torpedoQueue

	var_1.Clear(var_4_0)

	local var_4_1 = arg_4_0._chargeQueue

	var_1.Clear(var_4_1)

	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0._totalWeapon) do
		iter_4_1:Dispose()
	end

	arg_4_0._torpedoQueue = nil
	arg_4_0._chargeQueue = nil

	return
end

function var_0_3.AppendWeapon(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetTemplateData().queue

	var_3[#arg_5_0:GetQueueByIndex(var_5_0) + 1] = arg_5_1
	arg_5_0._totalWeapon[#arg_5_0._totalWeapon + 1] = arg_5_1

	return
end

function var_0_3.RemoveWeapon(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:GetTemplateData().queue
	local var_6_1 = arg_6_0:GetQueueByIndex(var_6_0)
	local var_6_2 = 1
	local var_6_3 = #var_6_1

	while var_6_2 <= var_6_3 do
		if var_6_1[var_6_2] == arg_6_1 then
			table = var_6

			var_6.remove(var_6_1, var_6_2)

			break
		end

		var_6_2 = var_6_2 + 1
	end

	local var_6_4 = 1
	local var_6_5 = #arg_6_0._totalWeapon

	while var_6_4 <= var_6_5 do
		if arg_6_0._totalWeapon[var_6_4] == arg_6_1 then
			table = var_6

			var_6.remove(arg_6_0._totalWeapon, var_6_4)

			break
		end

		var_6_4 = var_6_4 + 1
	end

	return
end

function var_0_3.AppendManualTorpedo(arg_7_0, arg_7_1)
	arg_7_0:AppendWeapon(arg_7_1)

	local var_7_0 = arg_7_0._torpedoQueue

	var_2.AppendWeapon(var_7_0, arg_7_1)

	return
end

function var_0_3.AppendChargeWeapon(arg_8_0, arg_8_1)
	arg_8_0:AppendWeapon(arg_8_1)

	local var_8_0 = arg_8_0._chargeQueue

	var_2.AppendWeapon(var_8_0, arg_8_1)

	return
end

function var_0_3.RemoveManualTorpedo(arg_9_0, arg_9_1)
	arg_9_0:RemoveWeapon(arg_9_1)

	local var_9_0 = arg_9_0._torpedoQueue

	var_2.RemoveWeapon(var_9_0, arg_9_1)

	return
end

function var_0_3.RemoveManualChargeWeapon(arg_10_0, arg_10_1)
	arg_10_0:RemoveWeapon(arg_10_1)

	local var_10_0 = arg_10_0._chargeQueue

	var_2.RemoveWeapon(var_10_0, arg_10_1)

	return
end

function var_0_3.QueueEnterGCD(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:addGCDTimer(arg_11_2, arg_11_1)

	return
end

function var_0_3.GetTotalWeaponUnit(arg_12_0)
	return arg_12_0._totalWeapon
end

function var_0_3.GetQueueByIndex(arg_13_0, arg_13_1)
	if arg_13_0._queueList[arg_13_1] == nil then
		arg_13_0._queueList[arg_13_1] = {}
	end

	return arg_13_0._queueList[arg_13_1]
end

function var_0_3.GetManualTorpedoQueue(arg_14_0)
	return arg_14_0._torpedoQueue
end

function var_0_3.GetChargeWeaponQueue(arg_15_0)
	return arg_15_0._chargeQueue
end

function var_0_3.Update(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0._queueList) do
		if arg_16_0:isNotAttacking(iter_16_0) then
			arg_16_0:updateWeapon(iter_16_0, arg_16_1)
		end
	end

	return
end

function var_0_3.CheckWeaponInitalCD(arg_17_0)
	ipairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0._totalWeapon) do
		local var_17_0 = arg_17_0._torpedoQueue

		if not var_6.Containers(var_17_0, iter_17_1) then
			local var_17_1 = arg_17_0._chargeQueue

			if not var_6.Containers(var_17_1, iter_17_1) then
				iter_17_1:InitialCD()
			end
		end
	end

	local var_17_2 = arg_17_0._torpedoQueue

	var_1.CheckWeaponInitalCD(var_17_2)

	local var_17_3 = arg_17_0._chargeQueue

	var_1.CheckWeaponInitalCD(var_17_3)

	return
end

function var_0_3.FlushWeaponReloadRequire(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0._totalWeapon) do
		local var_18_0 = arg_18_0._torpedoQueue

		if not var_6.Containers(var_18_0, iter_18_1) then
			local var_18_1 = arg_18_0._chargeQueue

			if not var_6.Containers(var_18_1, iter_18_1) then
				iter_18_1:FlushReloadRequire()
			end
		end
	end

	local var_18_2 = arg_18_0._torpedoQueue

	var_1.FlushWeaponReloadRequire(var_18_2)

	local var_18_3 = arg_18_0._chargeQueue

	var_1.FlushWeaponReloadRequire(var_18_3)

	return
end

function var_0_3.isNotAttacking(arg_19_0, arg_19_1)
	if arg_19_0._GCDTimerList[arg_19_1] ~= nil then
		return false
	end

	ipairs = var_2

	for iter_19_0, iter_19_1 in var_2(arg_19_0._queueList[arg_19_1]) do
		if iter_19_1:IsAttacking() then
			return false
		end
	end

	return true
end

function var_0_3.updateWeapon(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._queueList[arg_20_1]

	ipairs = var_1_10004

	for iter_20_0, iter_20_1 in var_1_10004(var_20_0) do
		if iter_20_1:GetType() == var_0_1.EquipmentType.BEAM and iter_20_1:GetCurrentState() == iter_20_1.STATE_ATTACK then
			iter_20_1:Update()

			return
		end
	end

	ipairs = var_4

	for iter_20_2, iter_20_3 in var_4(var_20_0) do
		local var_20_1 = false
		local var_20_2 = false

		if iter_20_3:GetCurrentState() == iter_20_3.STATE_PRECAST or var_11 == iter_20_3.STATE_READY or var_11 == iter_20_3.STATE_OVER_HEAT and iter_20_3:CheckReloadTimeStamp() then
			var_20_1 = true
		end

		iter_20_3:Update(arg_20_2)

		if iter_20_3:GetCurrentState() == iter_20_3.STATE_PRECAST or var_12 == iter_20_3.STATE_READY then
			var_20_2 = true
		end

		if arg_20_1 ~= var_0_1.NON_QUEUE_WEAPON and (var_20_1 and not var_20_2 or iter_20_3:IsAttacking()) then
			break
		end
	end

	return
end

function var_0_3.addGCDTimer(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._GCDTimerList[arg_21_2] ~= nil then
		return
	end

	local function var_21_0()
		local var_22_0 = arg_21_0

		var_0.removeGCDTimer(var_22_0, arg_21_2)

		return
	end

	local var_21_1 = arg_21_0._GCDTimerList

	pg = var_1_10005

	local var_21_2 = var_1_10005.TimeMgr.GetInstance()

	var_21_1[arg_21_2] = var_5.AddBattleTimer(var_21_2, "weaponGCD", -1, arg_21_1, var_21_0, true)

	return
end

function var_0_3.removeGCDTimer(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.TimeMgr.GetInstance()

	var_2.RemoveBattleTimer(var_23_0, arg_23_0._GCDTimerList[arg_23_1])

	arg_23_0._GCDTimerList[arg_23_1] = nil

	return
end

return
