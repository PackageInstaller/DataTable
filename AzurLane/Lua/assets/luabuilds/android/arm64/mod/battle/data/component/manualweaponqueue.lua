ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.ManualWeaponQueue = var_0_10004("ManualWeaponQueue")
var_0.Battle.ManualWeaponQueue.__name = "ManualWeaponQueue"

local var_0_4 = var_0.Battle.ManualWeaponQueue

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0:init()

	arg_1_0._maxCount = arg_1_1 or 1

	return
end

function var_0_4.init(arg_2_0)
	var_0.EventListener.AttachEventListener(arg_2_0)

	arg_2_0._weaponList = {}
	arg_2_0._overheatQueue = {}
	arg_2_0._cooldownList = {}

	return
end

function var_0_4.AppendWeapon(arg_3_0, arg_3_1)
	arg_3_0._weaponList[arg_3_1] = true

	arg_3_0:addWeaponEvent(arg_3_1)

	if arg_3_1:GetCurrentState() == arg_3_1.STATE_OVER_HEAT then
		arg_3_0._overheatQueue[#arg_3_0._overheatQueue + 1] = arg_3_1
	end

	return
end

function var_0_4.RemoveWeapon(arg_4_0, arg_4_1)
	arg_4_0._weaponList[arg_4_1] = nil

	arg_4_0:removeWeaponEvent(arg_4_1)

	ipairs = var_2

	for iter_4_0, iter_4_1 in var_2(arg_4_0._overheatQueue) do
		if iter_4_1 == arg_4_1 then
			table = var_1_10007

			var_1_10007.remove(arg_4_0._overheatQueue, iter_4_0)

			break
		end
	end

	ipairs = var_2

	for iter_4_2, iter_4_3 in var_2(arg_4_0._cooldownList) do
		if iter_4_3 == arg_4_1 then
			table = var_1_10007

			var_1_10007.remove(arg_4_0._cooldownList, iter_4_2)
		end
	end

	return
end

function var_0_4.Containers(arg_5_0, arg_5_1)
	return arg_5_0._weaponList[arg_5_1]
end

function var_0_4.GetCoolDownList(arg_6_0)
	return arg_6_0._cooldownList
end

function var_0_4.GetQueueHead(arg_7_0)
	local var_7_0

	if not arg_7_0._overheatQueue[#arg_7_0._overheatQueue] then
		var_7_0 = arg_7_0._cooldownList[1]
	end

	return var_7_0
end

function var_0_4.CheckWeaponInitalCD(arg_8_0)
	pairs = var_1_10001

	for iter_8_0, iter_8_1 in var_1_10001(arg_8_0._weaponList) do
		if not iter_8_0:GetModifyInitialCD() then
			arg_8_0._overheatQueue[#arg_8_0._overheatQueue + 1] = iter_8_0
		end
	end

	local var_8_0 = #arg_8_0._cooldownList

	while var_8_0 < arg_8_0._maxCount and #arg_8_0._overheatQueue > 0 do
		table = var_2

		local var_8_1 = var_2.remove(arg_8_0._overheatQueue, 1)

		var_2.InitialCD(var_8_1)

		arg_8_0._cooldownList[#arg_8_0._cooldownList + 1] = var_2
		var_8_0 = #arg_8_0._cooldownList
	end

	ipairs = var_2

	for iter_8_2, iter_8_3 in var_2(arg_8_0._overheatQueue) do
		iter_8_3:OverHeat()
	end

	return
end

function var_0_4.FlushWeaponReloadRequire(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0._weaponList) do
		iter_9_0:FlushReloadRequire()
	end

	return
end

function var_0_4.Clear(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0._weaponList) do
		arg_10_0:removeWeaponEvent(iter_10_0)
	end

	arg_10_0._weaponList = nil
	arg_10_0._overheatQueue = nil

	var_0.EventListener.DetachEventListener(arg_10_0)

	return
end

function var_0_4.addWeaponEvent(arg_11_0, arg_11_1)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_FIRE, arg_11_0.onManualWeaponFire)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_READY, arg_11_0.onManualWeaponReady)
	arg_11_1:RegisterEventListener(arg_11_0, var_0_2.MANUAL_WEAPON_INSTANT_READY, arg_11_0.onManualInstantReady)

	return
end

function var_0_4.removeWeaponEvent(arg_12_0, arg_12_1)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_READY)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_FIRE)
	arg_12_1:UnregisterEventListener(arg_12_0, var_0_2.MANUAL_WEAPON_INSTANT_READY)

	return
end

function var_0_4.onManualWeaponFire(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.Dispatcher

	var_2.OverHeat(var_13_0)

	arg_13_0._overheatQueue[#arg_13_0._overheatQueue + 1] = var_2

	arg_13_0:fillCooldownList()

	return
end

function var_0_4.onManualWeaponReady(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.Dispatcher

	arg_14_0:removeFromCDList(var_14_0)
	arg_14_0:fillCooldownList()

	return
end

function var_0_4.onManualInstantReady(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.Dispatcher
	local var_15_1

	ipairs = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10004(arg_15_0._overheatQueue) do
		if var_15_0 == iter_15_1 then
			table = var_1_10009

			var_1_10009.remove(arg_15_0._overheatQueue, iter_15_0)

			var_15_1 = true

			break
		end
	end

	if not var_15_1 then
		arg_15_0:removeFromCDList(var_15_0)
	end

	arg_15_0:fillCooldownList()

	return
end

function var_0_4.removeFromCDList(arg_16_0, arg_16_1)
	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0._cooldownList) do
		if arg_16_1 == iter_16_1 then
			table = var_1_10007

			var_1_10007.remove(arg_16_0._cooldownList, iter_16_0)

			break
		end
	end

	return
end

function var_0_4.fillCooldownList(arg_17_0)
	local var_17_0 = #arg_17_0._cooldownList

	while var_17_0 < arg_17_0._maxCount and #arg_17_0._overheatQueue > 0 do
		table = var_2

		local var_17_1 = var_2.remove(arg_17_0._overheatQueue, 1)

		var_2.EnterCoolDown(var_17_1)

		arg_17_0._cooldownList[#arg_17_0._cooldownList + 1] = var_2
		var_17_0 = #arg_17_0._cooldownList
	end

	return
end

return
